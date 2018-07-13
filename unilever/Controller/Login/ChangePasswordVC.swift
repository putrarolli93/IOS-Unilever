//
//  ChangePasswordVC.swift
//  unilever
//
//  Created by putra rolli on 11/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator

class ChangePasswordVC: UIViewController,ChangePasswordDelegate {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var new_password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    var _request: ChangePasswordRequest = ChangePasswordRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        _request.delegate = self
        password.isSecureTextEntry = true
        new_password.isSecureTextEntry = true
        confirm_password.isSecureTextEntry = true
    }
    
    @IBAction func savePassword(_ sender: Any) {
        if validasi() {
            FTIndicator.showProgress(withMessage: "Loading")
            _request.password_old = password.text!
            _request.password_new = new_password.text!
            _request.req()
        }
    }
    func validasi() -> Bool {
        if self.password.text! == "" {
            alert("password tidak boleh kosong")
            return false
        }
        if self.new_password.text! == "" {
            alert("password tidak boleh kosong")
            return false
        }
        if self.new_password.text! != self.confirm_password.text! {
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
    func alertDismiss(_ text: String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    func popViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: CHANGE PASSWORD DELEGATE
    func changePasswordSuccess(data: ForgotPasswordModel) {
        FTIndicator.dismissProgress()
        if data.response_code == "00" {
            alertDismiss(data.response_message)
        }else{
            alert(data.response_message)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func changePasswordError(data: String) {
        FTIndicator.dismissProgress()
        alert(data)
    }
    
}

extension ChangePasswordVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
