//
//  ProductDetailRequest.swift
//  unilever
//
//  Created by putra rolli on 20/05/18.
//  Copyright © 2018 putra. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol ProductDetailDelegate {
    func ProductDetailRequestSuccess(data: ProductDetailModel)
    func ProductDetailRequestError(data: String)
}

class ProductDetailRequest {
    
    var delegate: ProductDetailDelegate!
    static var product_detail: String = ""
    
    func req(_ product_detail_string: String) {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/product/inquiry/productId/\(ProductDetailRequest.product_detail)").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<ProductDetailModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.ProductDetailRequestSuccess(data: responses)
                }
            }else{
                self.delegate.ProductDetailRequestError(data: "error")
            }
        }
    }
}

