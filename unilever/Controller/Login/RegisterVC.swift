//
//  RegisterVC.swift
//  unilever
//
//  Created by putra rolli on 08/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator
import Alamofire

class RegisterVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,RegisterDelegate,UITextFieldDelegate {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var upLoadImageBtn: UIButton!
    @IBOutlet weak var npwp: UITextField!
    @IBOutlet weak var npwp_address: UITextField!
    @IBOutlet weak var nik: UITextField!
    
    
    let imagePicker = UIImagePickerController()
    var _request: RegisterRequest = RegisterRequest()
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        imageCircle()
        imagePicker.delegate = self
        textDelegate()
    }
    
    func textDelegate() {
        name.delegate = self
        contact.delegate = self
        address.delegate = self
        phone.delegate = self
        email.delegate = self
        city.delegate = self
        username.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        nik.delegate = self
        npwp_address.delegate = self
        npwp.delegate = self
    }
    
    func imageCircle() {
        myImageView.layer.borderWidth = 1
        myImageView.layer.masksToBounds = false
        myImageView.layer.borderColor = UIColor.black.cgColor
        myImageView.layer.cornerRadius = myImageView.frame.height/2
        myImageView.clipsToBounds = true
    }
    
    @IBAction func RegisterAct(_ sender: Any) {
        _request.delegate = self
        validasi()
        self._request.outlet_name = self.name.text!
        self._request.outlet_contact = self.contact.text!
        self._request.outlet_address = self.address.text!
        self._request.outlet_phone = self.phone.text!
        self._request.outlet_email = self.email.text!
        self._request.username = self.username.text!
        self._request.password = self.password.text!
        self._request.outlet_nik = self.nik.text!
        self._request.outlet_npwp_address = self.npwp_address.text!
        self._request.outlet_npwp = self.npwp.text!
        if validasi() {
            FTIndicator.showProgress(withMessage: "Loading")
            _request.req()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validasi() -> Bool {
        if self.name.text! == "" {
            alert("nama tidak boleh kosong")
            return false
        }
        if self.contact.text! == "" {
            alert("kontak tidak boleh kosong")
            return false
        }
        if self.address.text! == "" {
            alert("alamat tidak boleh kosong")
            return false
        }
        if self.phone.text! == "" {
            alert("telepon tidak boleh kosong")
            return false
        }
        if self.email.text! == "" {
            alert("email tidak boleh kosong")
            return false
        }
        if self.username.text! == "" {
            alert("username tidak boleh kosong")
            return false
        }
        if self.password.text! == "" {
            alert("password tidak boleh kosong")
            return false
        }
        if self.confirmPassword.text! == "" {
            alert("password tidak boleh kosong")
            return false
        }
        if self.nik.text! == "" {
            alert("nik tidak boleh kosong")
            return false
        }
        if self.npwp.text! == "" {
            alert("npwp tidak boleh kosong")
            return false
        }
        if self.npwp_address.text! == "" {
            alert("alamat NPWP tidak boleh kosong")
            return false
        }
        if self.password.text! != self.confirmPassword.text! {
            alert("password harus cocok")
            return false
        }
        
        return true
    }
    
    func alert(_ text: String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil )
    }
    
    @IBAction func upLoadImageBtnPressed(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        
        /*
         The sourceType property wants a value of the enum named        UIImagePickerControllerSourceType, which gives 3 options:
         
         UIImagePickerControllerSourceType.PhotoLibrary
         UIImagePickerControllerSourceType.Camera
         UIImagePickerControllerSourceType.SavedPhotosAlbum
         
         */
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // MARK: - ImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.contentMode = .scaleAspectFit
            myImageView.image = pickedImage
        }
        if let selectedImages = myImageView.image {
            
        }
        let productImage:UIImage = myImageView.image!
        let imageData = UIImageJPEGRepresentation(productImage, 0.2)!
        let titleToSend = "OT-0000041"
        let headers = [
            "Content-Type": "application/form-data"
        ]
        Alamofire.upload(multipartFormData:{ multipartFormData in
//            multipartFormData.append(imageData, withName: "image")
            multipartFormData.append(imageData, withName: "profile_photo", fileName: "sample.jpg", mimeType: "image/jpeg")
            multipartFormData.append(titleToSend.data(using: .utf8)!, withName: "outlet_id")},
                         usingThreshold:UInt64.init(),
                         to: "\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Profile/photo_upload",
                         method:.post,
                         headers:headers,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
        /*
         
         Swift Dictionary named “info”.
         We have to unpack it from there with a key asking for what media information we want.
         We just want the image, so that is what we ask for.  For reference, the available options are:
         
         UIImagePickerControllerMediaType
         UIImagePickerControllerOriginalImage
         UIImagePickerControllerEditedImage
         UIImagePickerControllerCropRect
         UIImagePickerControllerMediaURL
         UIImagePickerControllerReferenceURL
         UIImagePickerControllerMediaMetadata
         
         */
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    func popViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    
    //Mark: RegisterDelegate
    func RegisterSuccess(data: RegisterModel) {
        if data.response_code == "01" {
            let alert = UIAlertController(title: "Alert", message: "Register Failed", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil )
        }

        self.dismiss(animated: true, completion: {
            FTIndicator.dismissProgress()
        })
    }
    
    func RegisterError(data: String) {
        FTIndicator.dismissProgress()
    }

}

extension RegisterVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        title = "Daftar"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}

