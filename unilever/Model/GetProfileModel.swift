//
//  GetProfileModel.swift
//  unilever
//
//  Created by putra rolli on 10/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class GetProfileModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: GetProfileDataModel!
    
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

class GetProfileDataModel:Mappable {
    
    var outlet_email: String = ""
    var outlet_contact: String = ""
    var outlet_address: String = ""
    var outlet_city: String = ""
    var outlet_phone: String = ""
    var outlet_photo: String = ""
    var outlet_nik: String = ""
    var outlet_npwp: String = ""
    var outlet_npwp_address:String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        outlet_email    <- map["outlet_email"]
        outlet_contact    <- map["outlet_contact"]
        outlet_address   <- map["outlet_address"]
        outlet_city    <- map["outlet_city"]
        outlet_phone    <- map["outlet_phone"]
        outlet_photo    <- map["outlet_photo"]
        outlet_nik    <- map["outlet_nik"]
        outlet_npwp   <- map["outlet_npwp"]
        outlet_npwp_address <- map["outlet_npwp_address"]
    }
    
}
