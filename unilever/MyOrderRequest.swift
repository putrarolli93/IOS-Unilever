//
//  MyOrderRequest.swift
//  unilever
//
//  Created by putra rolli on 21/06/18.
//  Copyright © 2018 putra. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol MyOrderDelegate {
    func MyOrderRequestSuccess(data: MyOrderModel)
    func MyOrderRequestError(data: String)
}

class MyOrderRequest {
    
    var delegate: MyOrderDelegate!
    
    func req() {
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/Order/list/outletId/\(UserDefaults.standard.array(forKey: "session")![0])").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<MyOrderModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.MyOrderRequestSuccess(data: responses)
                }
            }else{
                self.delegate.MyOrderRequestError(data: "error")
            }
        }
    }
}
