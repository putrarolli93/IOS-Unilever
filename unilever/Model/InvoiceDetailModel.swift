//
//  InvoiceDetailModel.swift
//  unilever
//
//  Created by putra rolli on 15/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class InvoiceDetailModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: [InvoiceDetailDataModel]!
    
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

class InvoiceDetailDataModel:Mappable {
    
    var invoice_id: String = ""
    var invoice_date: String = ""
    var invoice_due_date: String = ""
    var order_id: String = ""
    var order_date: String = ""
    var outlet_id: String = ""
    var outlet_name: String = ""
    var outlet_contact: String = ""
    var outlet_address: String = ""
    var outlet_city: String = ""
    var outlet_phone: String = ""
    var outlet_email: String = ""
    var outlet_term_of_payment: String = ""
    var outlet_credit_limit: String = ""
    var order_discount: String = ""
    var order_payment_type: String = ""
    var order_note: String = ""
    var order_status: String = ""
    var total: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        invoice_id    <- map["invoice_id"]
        invoice_date    <- map["invoice_date"]
        invoice_due_date    <- map["invoice_due_date"]
        order_id    <- map["order_id"]
        order_date    <- map["order_date"]
        outlet_id    <- map["outlet_id"]
        outlet_name    <- map["outlet_name"]
        outlet_contact    <- map["outlet_contact"]
        outlet_address    <- map["outlet_address"]
        outlet_city    <- map["outlet_city"]
        outlet_phone    <- map["outlet_phone"]
        outlet_email    <- map["outlet_email"]
        outlet_term_of_payment    <- map["outlet_term_of_payment"]
        outlet_credit_limit    <- map["outlet_credit_limit"]
        order_discount    <- map["order_discount"]
        order_payment_type    <- map["order_payment_type"]
        order_note    <- map["order_note"]
        order_status    <- map["order_status"]
        total    <- map["total"]

    }
    
}
