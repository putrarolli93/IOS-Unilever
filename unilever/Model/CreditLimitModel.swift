//
//  CreditLimitModel.swift
//  unilever
//
//  Created by putra rolli on 09/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class CreditLimitModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var outlet_id: String = ""
    var outlet_name: String = ""
    var total_credit_limit: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_type    <- map["response_type"]
        response_code    <- map["response_code"]
        response_message   <- map["response_message"]
        outlet_id    <- map["outlet_id"]
        outlet_name    <- map["outlet_name"]
        total_credit_limit    <- map["total_credit_limit"]
    }
    
}
