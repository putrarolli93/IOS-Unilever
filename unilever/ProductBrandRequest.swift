//
//  ProductBrandRequest.swift
//  unilever
//
//  Created by putra rolli on 20/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol ProductBrandDelegate {
    func ProductBrandRequestSuccess(data: [ProductModelBrand]?, brand: ProductBrandModel?)
    func ProductBrandRequestError(data: String)
}

class ProductBrandRequest {
    
    var delegate: ProductBrandDelegate!
    var array: [ProductModelBrand] = []

    func req() {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Product_Brand/inquiry").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<ProductBrandModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.ProductBrandRequestSuccess(data: nil, brand: responses)
                }
            }else{
                self.delegate.ProductBrandRequestError(data: "error")
            }
        }
    }
    
    func req(brand_id: String) {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Product_Brand/inquiry").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<ProductBrandModel>().map(JSONObject: result as AnyObject) {
                for i in 0...responses.data.count - 1 {
                    if responses.data[i].brand_id == brand_id {
                        self.array.append(responses.data[i])
                    }
                }
                DispatchQueue.main.async {
                    self.delegate.ProductBrandRequestSuccess(data: self.array, brand: nil)
                }
            }else{
                self.delegate.ProductBrandRequestError(data: "error")
            }
        }
    }
}
