//
//  PurchaseModel.swift
//  unilever
//
//  Created by putra rolli on 10/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class PurchaseModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
//    var data: PurchaseModelData?
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_type    <- map["response_type"]
        response_code    <- map["response_code"]
        response_message   <- map["response_message"]
//        data    <- map["data"]
    }
    
}

//class PurchaseModelData:Mappable {
//
//    var order_id: String = ""
//    var order_date: String = ""
//    var order_pay_type: String = ""
//    var order_notes: String = ""
//
//    required convenience init?(map: Map){
//        self.init()
//    }
//
//    func mapping(map: Map) {
//        order_id    <- map["order_id"]
//        order_date    <- map["order_date"]
//        order_pay_type   <- map["order_pay_type"]
//        order_notes    <- map["order_notes"]
//    }
//
//}

