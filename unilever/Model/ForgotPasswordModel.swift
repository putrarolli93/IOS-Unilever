//
//  ForgotPasswordModel.swift
//  unilever
//
//  Created by putra rolli on 09/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class ForgotPasswordModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_type    <- map["response_type"]
        response_code    <- map["response_code"]
        response_message   <- map["response_message"]
    }
    
}
