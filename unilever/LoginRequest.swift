//
//  BaseRequest.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol LoginDelegate {
    func loginSuccess(data: LoginModel)
    func loginError(data: String)
}

class LoginRequest {
    
    var username: String = ""
    var password: String = ""
    var delegate: LoginDelegate!

    func req() {
        let parameters: [String: Any] = [
            "request_type" : 1,
            "data": [
                "authenticate" : [
                    "username": self.username,
                    "password": self.password
                ],
                "device" : [
                    "type": "android OS",
                    "imei": "99999999999",
                    "phone_no": "+6281219976562",
                    "location": "-6.285799,106.664323"
                ]
            ]
        ]
        
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/authenticate/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<LoginModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.loginSuccess(data: responses)
                }else{
                    self.delegate.loginError(data: "error")
                }
        }
    }
}
