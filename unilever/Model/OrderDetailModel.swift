//
//  OrderDetailModel.swift
//  unilever
//
//  Created by putra rolli on 24/06/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderDetailModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var order_id: String = ""
    var data: [OrderDetailDataModel]!
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_type    <- map["response_type"]
        response_code    <- map["response_code"]
        response_message   <- map["response_message"]
        order_id <- map["order_id"]
        data    <- map["data"]
    }
    
}

class OrderDetailDataModel:Mappable {
    
    var order_detail_id: String = ""
    var order_id: String = ""
    var product_id: String = ""
    var product_qty: String = ""
    var product_pricelist: String = ""
    var product_discount: String = ""
    var product_selling_price: String = ""
    var product_status: String = ""
    var product_sku:String = ""
    var product_name: String = ""

    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        order_detail_id    <- map["order_detail_id"]
        order_id    <- map["order_id"]
        product_id   <- map["product_id"]
        product_qty    <- map["product_qty"]
        product_pricelist    <- map["product_pricelist"]
        product_discount    <- map["product_discount"]
        product_selling_price    <- map["product_selling_price"]
        product_status   <- map["product_status"]
        product_sku <- map["product_sku"]
        product_name <- map["product_name"]
    }
    
}
