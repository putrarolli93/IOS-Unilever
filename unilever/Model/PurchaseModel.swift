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
    var data: PurchaseModelData?
    
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

class PurchaseModelData:Mappable {

    var order_id: String = ""
    var order_date: String = ""
    var order_pay_type: String = ""
    var order_notes: String = ""
    var order_subtotal: String = ""
    var order_disc: String = ""
    var order_total: String = ""
    var outlet_term_of_payment: String = ""
    var outlet_credit_limit: String = ""

    required convenience init?(map: Map){
        self.init()
    }

    func mapping(map: Map) {
        order_id    <- map["order_id"]
        order_date    <- map["order_date"]
        order_pay_type   <- map["order_pay_type"]
        order_notes    <- map["order_notes"]
        order_subtotal    <- map["order_subtotal"]
        order_disc    <- map["order_disc"]
        order_total   <- map["order_total"]
        outlet_term_of_payment    <- map["outlet_term_of_payment"]
        outlet_credit_limit    <- map["outlet_credit_limit"]

    }

}

