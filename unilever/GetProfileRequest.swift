//
//  GetProfileRequest.swift
//  unilever
//
//  Created by putra rolli on 10/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol GetProfileDelegate {
    func getProfileSuccess(data: GetProfileModel)
    func getProfileError(data: String)
}

class GetProfileRequest {
    
    var username: String = ""
    var outlet_id: String = ""
    var delegate: GetProfileDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type": 19,
            "data": [
                "user_info": [
                    "username": username,
                    "outlet_id": outlet_id
                ]
            ]
        ]
        
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Profile/get_profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<GetProfileModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.getProfileSuccess(data: responses)
                }else{
                    self.delegate.getProfileError(data: "error")
                }
        }
    }
}
