//
//  RegisterRequest.swift
//  unilever
//
//  Created by putra rolli on 08/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol RegisterDelegate {
    func RegisterSuccess(data: RegisterModel)
    func RegisterError(data: String)
}

class RegisterRequest {
    
    var username: String = ""
    var password: String = ""
    var outlet_name: String = ""
    var outlet_contact: String = ""
    var outlet_address: String = ""
    var outlet_phone: String = ""
    var outlet_email: String = ""
    
    var delegate: RegisterDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type" : 2,
            "data": [
                "user_info" : [
                    "username": self.username,
                    "password": self.password,
                    "user_group": "Outlet",
                    "updated_by": "Mobile Apps IOS"
                ],
                "outlet_info" : [
                    "outlet_name": self.outlet_name,
                    "outlet_contact": self.outlet_contact,
                    "outlet_address": self.outlet_address,
                    "outlet_city": "Tangerang selatan",
                    "outlet_phone": "081219976562",
                    "outlet_email": "zahra@gmail.com",
                    "outlet_photo": "myOutlet.jpg",
                    "outlet_term_of_payment": 4,
                    "outlet_credit_limit": 1500000
                ]
            ]
        ]
        
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/authenticate/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<RegisterModel>().map(JSONObject: result as AnyObject) {
                    DispatchQueue.main.async {
                        self.delegate.RegisterSuccess(data: responses)
                    }
                }else{
                    self.delegate.RegisterError(data: "error")
                }
        }
    }
}
