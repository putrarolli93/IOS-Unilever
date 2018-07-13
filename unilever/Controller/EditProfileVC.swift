//
//  EditProfileVC.swift
//  unilever
//
//  Created by putra rolli on 12/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator

class EditProfileVC: UIViewController,EditProfileDelegate {

    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var npwp: UITextField!
    @IBOutlet weak var npwp_address: UITextView!
    @IBOutlet weak var nik: UITextField!
    @IBOutlet weak var save_btn: UIButton!
    var profileModel: GetProfileModel!
    var _request: EditProfileRequest = EditProfileRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
    
    func setupView() {
        address.text = profileModel.data.outlet_address
        contact.text = profileModel.data.outlet_contact
        city.text = profileModel.data.outlet_city
        phone.text = profileModel.data.outlet_phone
        npwp.text = profileModel.data.outlet_npwp
        npwp_address.text = profileModel.data.outlet_npwp_address
        nik.text = profileModel.data.outlet_nik
    }
    
    func popViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnClick(_ sender: Any) {
        _request.delegate = self
        validasi()
        self._request.outlet_city = self.city.text!
        self._request.outlet_contact = self.contact.text!
        self._request.outlet_address = self.address.text!
        self._request.outlet_phone = self.phone.text!
        self._request.outlet_nik = self.nik.text!
        self._request.outlet_npwp_address = self.npwp_address.text!
        self._request.outlet_npwp = self.npwp.text!
        if validasi() {
            FTIndicator.showProgress(withMessage: "Loading")
            _request.req()
        }
    }
    
    func validasi() -> Bool {
        if self.city.text! == "" {
            alert("kota tidak boleh kosong")
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
        
        return true
    }
    
    func alert(_ text: String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil )
    }
    
    //MARK: UPDATE PROFILE
    func editProfileSuccess(data: PurchaseModel) {
        if data.response_code == "01" {
            let alert = UIAlertController(title: "Alert", message: "Register Failed", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil )
        }else{
            let alert = UIAlertController(title: "Alert", message: data.response_message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil )
        }
        
        self.dismiss(animated: true, completion: {
            FTIndicator.dismissProgress()
        })
    }
    
    func editProfileError(data: String) {
            FTIndicator.dismissProgress()
    }
    
}

extension EditProfileVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        title = "Ubah Profile"
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