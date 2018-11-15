//
//  DiskonRequest.swift
//  unilever
//
//  Created by putra rolli on 16/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol DiskonDelegate {
    func diskonGetSuccess(data: DiskonModel)
    func diskonGetError(data: String)
}

class DiskonRequest {
    
    var total: String = ""
    var delegate: DiskonDelegate!
    
    func req() {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Order/discount_check/orderSubTotal/\(total)").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<DiskonModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.diskonGetSuccess(data: responses)
                }
            }else{
                self.delegate.diskonGetError(data: "error")
            }
        }
    }
}
