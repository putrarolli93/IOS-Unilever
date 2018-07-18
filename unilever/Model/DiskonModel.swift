//
//  DiskonModel.swift
//  unilever
//
//  Created by putra rolli on 16/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class DiskonModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: [DiskonDataDataModel]!
    
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

class DiskonDataDataModel:Mappable {
    
    var discount_name: String = ""
    var discount_calc: Double = 0.0
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        discount_name    <- map["discount_name"]
        discount_calc    <- map["discount_calc"]
    }
    
}
