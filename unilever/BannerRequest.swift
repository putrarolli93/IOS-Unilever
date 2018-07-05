//
//  BannerRequest.swift
//  unilever
//
//  Created by putra rolli on 04/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol BannerDelegate {
    func bannerSuccess(data: BannerModel)
    func bannerError(data: String)
}

class BannerRequest {
    
    var username: String = ""
    var password: String = ""
    var delegate: BannerDelegate!
    
    func req() {
        let parameters: [String: Any] = [
            "request_type": 20,
            "data": [
                "user_info": [
                    "username": "nodeadlock",
                    "outlet_id": "OT-0000041"
                ]
            ]
        ]
        
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/Promo/promo_banner1", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<BannerModel>().map(JSONObject: result as AnyObject) {
                    self.delegate.bannerSuccess(data: responses)
                }else{
                    self.delegate.bannerError(data: "error")
                }
        }
    }
}

