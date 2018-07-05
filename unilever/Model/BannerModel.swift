//
//  BannerModel.swift
//  unilever
//
//  Created by putra rolli on 04/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation
import ObjectMapper

class BannerModel:Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: BannerPromoDataModel!
    
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

class BannerPromoDataModel:Mappable {
    
    var promo: [BannerDataModel]!
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        promo    <- map["promo"]
    }
    
}

class BannerDataModel:Mappable {
    
    var promo_id: String = ""
    var promo_name: String = ""
    var promo_start_date: String = ""
    var promo_end_date: String = ""
    var promo_image: String = ""
    var promo_page: String = ""
    var promo_status: String = ""
    var updated_by: String = ""
    var updated_date: String = ""

    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        promo_id    <- map["promo_id"]
        promo_name    <- map["promo_name"]
        promo_start_date    <- map["promo_start_date"]
        promo_end_date    <- map["promo_end_date"]
        promo_image    <- map["promo_image"]
        promo_page    <- map["promo_page"]
        promo_status    <- map["promo_status"]
        updated_by    <- map["updated_by"]
        updated_date    <- map["updated_date"]
    }
    
}
