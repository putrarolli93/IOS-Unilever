//
//  ProductRequest.swift
//  unilever
//
//  Created by putra rolli on 08/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol ProductDelegate {
    func ProductSuccess(data: ProductModel, brand: [ProductModelArray]?)
    func ProductError(data: String)
}

class ProductRequest {
    
    var delegate: ProductDelegate!
    var array: [ProductModelArray] = []
    
    func req() {
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/product/inquiry").responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<ProductModel>().map(JSONObject: result as AnyObject) {
                    DispatchQueue.main.async {
                        self.delegate.ProductSuccess(data: responses, brand: nil)
                    }
                }else{
                    self.delegate.ProductError(data: "error")
                }
        }
    }
    
    func reqParams(brand_id: String) {
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/product/inquiry").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<ProductModel>().map(JSONObject: result as AnyObject) {
                for i in 0...responses.data.count - 1 {
                    if responses.data[i].brand_id == brand_id {
                        self.array.append(responses.data[i])
                    }
                }
                DispatchQueue.main.async {
                    self.delegate.ProductSuccess(data: responses, brand: self.array)
                }
            }else{
                self.delegate.ProductError(data: "error")
            }
        }
    }
}
