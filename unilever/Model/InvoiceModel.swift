//
//  InvoiceModel.swift
//  unilever
//
//  Created by putra rolli on 20/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class InvoiceModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: [InvoiceDataModel]!
    
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

class InvoiceDataModel:Mappable {
    
    var order_id: String = ""
    var order_date: String = ""
    var outlet_id: String = ""
    var order_discount: String = ""
    var order_payment_type: String = ""
    var order_note: String = ""
    var updated_by: String = ""
    var updated_date: String = ""
    var invoice_id:String = ""
    var invoice_date: String = ""
    var order_status: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        order_id    <- map["order_id"]
        order_date    <- map["order_date"]
        outlet_id   <- map["outlet_id"]
        order_discount    <- map["order_discount"]
        order_payment_type    <- map["order_payment_type"]
        order_note    <- map["order_note"]
        updated_by    <- map["updated_by"]
        updated_date   <- map["updated_date"]
        invoice_id <- map["invoice_id"]
        invoice_date <- map["invoice_date"]
        order_status <- map["order_status"]
    }
    
}
