//
//  RegisterVC.swift
//  unilever
//
//  Created by putra rolli on 08/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator

class RegisterVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,RegisterDelegate {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var upLoadImageBtn: UIButton!
    let imagePicker = UIImagePickerController()
    var _request: RegisterRequest = RegisterRequest()
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        imageCircle()
        imagePicker.delegate = self
    }
    
    func imageCircle() {
        myImageView.layer.borderWidth = 1
        myImageView.layer.masksToBounds = false
        myImageView.layer.borderColor = UIColor.black.cgColor
        myImageView.layer.cornerRadius = myImageView.frame.height/2
        myImageView.clipsToBounds = true
    }
    
    @IBAction func RegisterAct(_ sender: Any) {
        FTIndicator.showProgress(withMessage: "Loading")
        _request.delegate = self
        self._request.outlet_name = self.name.text!
        self._request.outlet_contact = self.contact.text!
        self._request.outlet_address = self.address.text!
        self._request.outlet_phone = self.phone.text!
        self._request.outlet_email = self.email.text!
        self._request.username = self.username.text!
        self._request.password = self.password.text!
        _request.req()
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
        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}

extension UINavigationController{
    func defaultStyle(){
        self.navigationBar.isTranslucent = false
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = UIColor.blue
        self.navigationBar.tintColor = UIColor.white
    }
}
