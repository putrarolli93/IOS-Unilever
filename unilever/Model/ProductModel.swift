//
//  ProductModel.swift
//  unilever
//
//  Created by putra rolli on 08/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: [ProductModelArray]!
    
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

class ProductModelArray:Mappable {
    
    var category_level_1: String = ""
    var category_level_2: String = ""
    var category_level_3: String = ""
    var product_id: String = ""
    var brand_id: String = ""
    var product_brand: String = ""
    var product_sku: String = ""
    var product_name: String = ""
    var product_pricelist: String = ""
    var selling_price: String = ""
    var product_discount: String = ""
    var product_photo_link: String = ""
    var product_photo: String = ""
    var product_status: String = ""
    var product_stock: String = ""
    var supplier_id: String = ""
    var buying_price: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        category_level_1    <- map["category_level_1"]
        category_level_2    <- map["category_level_2"]
        category_level_3   <- map["category_level_3"]
        product_id    <- map["product_id"]
        brand_id    <- map["brand_id"]
        product_brand    <- map["product_brand"]
        product_sku    <- map["product_sku"]
        product_name   <- map["product_name"]
        product_pricelist    <- map["product_pricelist"]
        selling_price    <- map["selling_price"]
        product_discount    <- map["product_discount"]
        product_photo_link   <- map["product_photo_link"]
        product_photo    <- map["product_photo"]
        product_status    <- map["product_status"]
        product_stock    <- map["product_stock"]
        supplier_id   <- map["supplier_id"]
        buying_price    <- map["buying_price"]
    }
    
}
