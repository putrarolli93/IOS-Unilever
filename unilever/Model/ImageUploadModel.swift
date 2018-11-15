//
//  ImageUploadModel.swift
//  unilever
//
//  Created by putra rolli on 29/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageUploadModel:Mappable {
    
    var response_message: Int = 0
    var response_code: String = ""
    var outlet_photo: String = ""
    var response_type: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_message    <- map["response_message"]
        response_code    <- map["response_code"]
        outlet_photo   <- map["outlet_photo"]
        response_type    <- map["response_type"]
    }
    
}
