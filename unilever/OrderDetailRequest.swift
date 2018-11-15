//
//  OrderDetailRequest.swift
//  unilever
//
//  Created by putra rolli on 24/06/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol OrderDetailDelegate {
    func OrderDetailSuccess(data: OrderDetailModel)
    func OrderDetailError(data: String)
}

class OrderDetailRequest {
    
    var delegate: OrderDetailDelegate!
    
    func req(_ id: String) {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Order/detail/orderId/\(id)").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<OrderDetailModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.OrderDetailSuccess(data: responses)
                }
            }else{
                self.delegate.OrderDetailError(data: "error")
            }
        }
    }
}
