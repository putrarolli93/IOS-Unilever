//
//  ChangePasswordRequest.swift
//  unilever
//
//  Created by putra rolli on 10/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol ChangePasswordDelegate {
    func changePasswordSuccess(data: ForgotPasswordModel)
    func changePasswordError(data: String)
}

class ChangePasswordRequest {
    
    var username: String = ""
    var outlet_id: String = ""
    var password_old: String = ""
    var password_new: String = ""
    var delegate: ChangePasswordDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type": 18,
            "data": [
                "user_info": [
                    "username": "\(UserDefaults.standard.array(forKey: "session")![2])",
                    "outlet_id": "\(UserDefaults.standard.array(forKey: "session")![0])",
                    "password_old": password_old,
                    "password_new": password_new
                ]
            ]
        ]
        
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Profile/update_password", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<ForgotPasswordModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.changePasswordSuccess(data: responses)
                }else{
                    self.delegate.changePasswordError(data: "error")
                }
        }
    }
}
