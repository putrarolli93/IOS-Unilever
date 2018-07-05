//
//  ProductBrandModel.swift
//  unilever
//
//  Created by putra rolli on 27/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductBrandModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: [ProductModelBrand]!
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_type    <- map["response_type"]
        response_code    <- map["response_code"]
        response_message   <- map["response_message"]
        data    <- map["data"]
    }
    
}

class ProductModelBrand:Mappable {
    
    var brand_id: String = ""
    var brand_name: String = ""
    var brand_image: String = ""
    var brand_status: String = ""
    var updated_by: String = ""
    var updated_date: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        brand_id    <- map["brand_id"]
        brand_name    <- map["brand_name"]
        brand_image   <- map["brand_image"]
        brand_status    <- map["brand_status"]
        updated_by    <- map["updated_by"]
        updated_date    <- map["updated_date"]
    }
    
}
