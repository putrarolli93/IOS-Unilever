//
//  ForgotPasswordVC.swift
//  unilever
//
//  Created by putra rolli on 08/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator

class ForgotPasswordVC: UIViewController,ForgotPasswordDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var numberTlpn: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    var _request: ForgotPasswordRequest = ForgotPasswordRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }

    @IBAction func sendDidClick(_ sender: Any) {
        FTIndicator.showProgress(withMessage: "Loading")
        _request.delegate = self
        self._request.email = self.email.text!
        self._request.phone = self.numberTlpn.text!
        _request.req()
    }
    
    func popViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: FORGOT PASSWORD DELEGATE
    func forgotPasswordSuccess(data: ForgotPasswordModel) {
        FTIndicator.dismissProgress()
        let alert = UIAlertController(title: "Alert", message: data.response_message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func forgotPasswordError(data: String) {
        FTIndicator.dismissProgress()
        let alert = UIAlertController(title: "Alert", message: "Error Request", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ForgotPasswordVC {
    
    func setupNavigation() {
        navigationController?.defaultStyle()
//        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
