//
//  ForgotPasswordRequest.swift
//  unilever
//
//  Created by putra rolli on 09/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol ForgotPasswordDelegate {
    func forgotPasswordSuccess(data: ForgotPasswordModel)
    func forgotPasswordError(data: String)
}

class ForgotPasswordRequest {
    
    var email: String = ""
    var phone: String = ""
    var delegate: ForgotPasswordDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type": 13,
            "data": [
                "outlet_email": self.email,
                "outlet_phone": self.phone
            ]
        ]
        
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/Authenticate/forget_account", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<ForgotPasswordModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.forgotPasswordSuccess(data: responses)
                }else{
                    self.delegate.forgotPasswordError(data: "error")
                }
        }
    }
}
