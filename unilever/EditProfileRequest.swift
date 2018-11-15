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
    func editProfileSuccess(data: EditProfileModel)
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
                    "outlet_contact": outlet_contact,
                    "outlet_address": outlet_address,
                    "outlet_city": outlet_city,
                    "outlet_phone": outlet_phone,
                    "outlet_email": outlet_email,
                    "outlet_photo": "myOutlet.jpg",
                    "outlet_nik": outlet_nik,
                    "outlet_npwp": outlet_npwp,
                    "outlet_npwp_address": outlet_npwp_address
                ]
            ]
        ]
        
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Profile/update_profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<EditProfileModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.editProfileSuccess(data: responses)
                }else{
                    self.delegate.editProfileError(data: "error")
                }
        }
    }
}
