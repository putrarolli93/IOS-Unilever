//
//  EditProfileRequest.swift
//  unilever
//
//  Created by putra rolli on 12/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol EditProfileDelegate {
    func editProfileSuccess(data: PurchaseModel)
    func editProfileError(data: String)
}

class EditProfileRequest {
    
    var outlet_contact: String = ""
    var outlet_address: String = ""
    var outlet_city: String = ""
    var outlet_phone: String = ""
    var outlet_email: String = ""
    var outlet_nik: String = ""
    var outlet_npwp: String = ""
    var outlet_npwp_address: String = ""
    var delegate: EditProfileDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type": 17,
            "data": [
                "user_info": [
                    "username": "\(UserDefaults.standard.array(forKey: "session")![2])",
                    "outlet_id": "\(UserDefaults.standard.array(forKey: "session")![0])"
                ],
                "outlet_info": [
                    "outlet_contact": "No Contact",
                    "outlet_address": "Jalan tol",
                    "outlet_city": "Bekasi",
                    "outlet_phone": "081219976562",
                    "outlet_email": "nodeadlock@gmail.com",
                    "outlet_photo": "myOutlet.jpg",
                    "outlet_nik": "989999999",
                    "outlet_npwp": "123456789",
                    "outlet_npwp_address": "jalan tol jakarta"
                ]
            ]
        ]
        
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/Profile/update_profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<PurchaseModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.editProfileSuccess(data: responses)
                }else{
                    self.delegate.editProfileError(data: "error")
                }
        }
    }
}
