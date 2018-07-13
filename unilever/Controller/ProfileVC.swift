//
//  ProfileVC.swift
//  unilever
//
//  Created by putra rolli on 10/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import FTIndicator

class ProfileVC: UIViewController,UITableViewDelegate, UITableViewDataSource,ProfileChangeImageDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GetProfileDelegate,profileEditBtnDelegate {

    private var myTableView: UITableView!
    var bounds = UIScreen.main.bounds
    let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    let imagePicker = UIImagePickerController()
    var imageData: UIImage? = nil
    var _request: GetProfileRequest = GetProfileRequest()
    var getImage: Bool = false
    var profile: GetProfileModel!
    static var image_photo: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        _request.delegate = self
        _request.username = "\(UserDefaults.standard.array(forKey: "session")![2])"
        _request.outlet_id = "\(UserDefaults.standard.array(forKey: "session")![0])"
        _request.req()
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "ProfileImageCell", bundle: nil), forCellReuseIdentifier: "ProfileImageCell")
        myTableView.register(UINib(nibName: "ProfileEditBtnCell", bundle: nil), forCellReuseIdentifier: "ProfileEditBtnCell")
        myTableView.register(UINib(nibName: "ProfileInfoCell", bundle: nil), forCellReuseIdentifier: "ProfileInfoCell")
        myTableView.register(UINib(nibName: "ProfileBottomCell", bundle: nil), forCellReuseIdentifier: "ProfileBottomCell")
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.text = "\(LoginVC.product_count)"
        navigationController?.navigationBar.addSubview(label)
        addNotifIcon()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 9
        }else if section == 3 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                let vc = ChangePasswordVC()
                let navCon = UINavigationController()
                navCon.viewControllers = [vc]
                self.present(navCon, animated: true, completion: nil)
            }else if indexPath.row == 1 {
                let prefs = UserDefaults.standard
                prefs.removeObject(forKey:"session")
                self.present(LoginVC(), animated: true, completion: nil)
            }
        }
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.profile_username.text = "\(UserDefaults.standard.array(forKey: "session")![1])"
            if self.profile != nil && self.profile.data.outlet_photo != "" {
                let image = "http://202.154.3.188/commerce/unilever-middleware/uploads/\(UserDefaults.standard.array(forKey: "session")![0])/\(self.profile.data.outlet_photo)"
                ProfileVC.image_photo = image
                cell.profile_image.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
            }
            cell.delegate = self
            if getImage {
                cell.profile_image.image = imageData
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileEditBtnCell", for: indexPath) as! ProfileEditBtnCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.delegate = self
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            changeDataInfoType(indexPath.row,cell)
            if profile != nil {
                changeDataInfo(indexPath.row,cell)
            }
            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileBottomCell", for: indexPath) as! ProfileBottomCell
//            cell.selectionStyle = UITableViewCellSelectionStyle.none
            if indexPath.row == 0 {
                cell.labelBottom.text = "Ubah Password"
                cell.imageBottom.image = UIImage(named: "door-key.png")
            }else if indexPath.row == 1{
                cell.labelBottom.text = "Keluar"
                cell.imageBottom.image = UIImage(named: "ic_sign_out.png")
            }
            return cell
        }

        return UITableViewCell()
    }
    
    func changeDataInfoType(_ data : Int, _ cell: ProfileInfoCell) {
        if data == 0 {
            cell.info_type.text = "Outlet ID"
        }else if data == 1 {
            cell.info_type.text = "Username"
        }else if data == 2 {
            cell.info_type.text = "Alamat Outlet"
        }else if data == 3 {
            cell.info_type.text = "Kota"
        }else if data == 4 {
            cell.info_type.text = "No. Telepon Outlet"
        }else if data == 5 {
            cell.info_type.text = "Email"
        }else if data == 6 {
            cell.info_type.text = "NPWP"
        }else if data == 7 {
            cell.info_type.text = "Alamat NPWP"
        }else if data == 8 {
            cell.info_type.text = "NIK"
        }
    }
    
    func changeDataInfo(_ data : Int, _ cell: ProfileInfoCell) {
        if data == 0 {
            cell.info_value.text = "\(UserDefaults.standard.array(forKey: "session")![0])"
        }else if data == 1 {
            cell.info_value.text = "\(UserDefaults.standard.array(forKey: "session")![2])"
        }else if data == 2 && profile.data.outlet_address != "" {
            cell.info_value.text = profile.data.outlet_address
            
        }else if data == 3 && profile.data.outlet_city != "" {
            cell.info_value.text = profile.data.outlet_city
            
        }else if data == 4 && profile.data.outlet_contact != "" {
            cell.info_value.text = profile.data.outlet_contact
            
        }else if data == 5 && profile.data.outlet_email != "" {
            cell.info_value.text = profile.data.outlet_email
            
        }else if data == 6 && profile.data.outlet_npwp != "" {
            cell.info_value.text = profile.data.outlet_npwp
            
        }else if data == 7 && profile.data.outlet_npwp_address != "" {
            cell.info_value.text = profile.data.outlet_npwp_address
            
        }else if data == 8 && profile.data.outlet_nik != "" {
            cell.info_value.text = profile.data.outlet_nik
        }
    }
    
    func addNotifIcon() {
        let imageName = "notifications-bell-button"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width - 100, y: 10 , width: 28 , height: 25)
        navigationController?.navigationBar.addSubview(imageView)
    }

    func popViewController() {
        HomeVC.selectedIndex = 3
        dismiss(animated: true, completion: {
        })
    }
    
    func searchIconTapped() {
        let regis = ShoppingCartVC()
        let navCon = UINavigationController()
        DefaultController.indexOftabbar = 1
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageData = pickedImage
            
            let productImage:UIImage = pickedImage
            let imageData = UIImageJPEGRepresentation(productImage, 0.2)!
            let titleToSend = "OT-0000041"
            let headers = [
                "Content-Type": "application/form-data"
            ]
            FTIndicator.showProgress(withMessage: "Loading..", userInteractionEnable: false)
            Alamofire.upload(multipartFormData:{ multipartFormData in
                multipartFormData.append(imageData, withName: "profile_photo", fileName: "sample.jpg", mimeType: "image/jpeg")
                multipartFormData.append(titleToSend.data(using: .utf8)!, withName: "outlet_id")},
                             usingThreshold:UInt64.init(),
                             to: "http://202.154.3.188/commerce/unilever-middleware/core-services/Profile/photo_upload",
                             method:.post,
                             headers:headers,
                             encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseJSON { response in
                                        debugPrint(response)
                                        FTIndicator.dismissProgress()
                                        self.getImage = true
                                        self.myTableView.reloadData()
                                    }
                                case .failure(let encodingError):
                                    print(encodingError)
                                    FTIndicator.dismissProgress()
                                }
            })
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    //MARK: CHANGE IMAGE CELL
    func changeImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: GET PROFILE
    func getProfileSuccess(data: GetProfileModel) {
        profile = data
        myTableView.reloadData()
    }
    
    func getProfileError(data: String) {
        
    }
    
    //MARK: PROFILE EDIT BUTTON
    func profileEditBtn() {
        let forgot = EditProfileVC()
        forgot.profileModel = self.profile
        let navCon = UINavigationController()
        navCon.viewControllers = [forgot]
        self.present(navCon, animated: true, completion: nil)
    }
    
    
    
}

extension ProfileVC {
    func setupNavigation() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
