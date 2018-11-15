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
    var outlet_nik: String = ""
    var outlet_npwp: String = ""
    var outlet_npwp_address: String = ""
    
    var delegate: RegisterDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type" : 4,
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
                    "outlet_city": self.outlet_address,
                    "outlet_phone": self.outlet_phone,
                    "outlet_email": self.outlet_email,
                    "outlet_photo": "myOutlet.jpg",
                    "outlet_nik": self.outlet_nik,
                    "outlet_npwp": self.outlet_npwp,
                    "outlet_npwp_address": self.outlet_npwp_address,
                    "outlet_term_of_payment": 7,
                    "outlet_credit_limit": 1500000
                ]
            ]
        ]
        
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/authenticate/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
