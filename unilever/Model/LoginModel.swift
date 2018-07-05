//
//  LoginModel.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//
import Foundation
import ObjectMapper

class LoginModel:Mappable {

    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    var data: LoginData!
    
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

class LoginData: Mappable {
    
    var user_id: String = ""
    var username: String = ""
    var outlet_id: String = ""
    var outlet_name: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        user_id    <- map["user_id"]
        username    <- map["username"]
        outlet_id   <- map["outlet_id"]
        outlet_name    <- map["outlet_name"]
    }
}

class RegisterModel: Mappable {
    
    var response_type: Int = 0
    var response_code: String = ""
    var response_message: String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        response_type    <- map["response_type"]
        response_code    <- map["response_code"]
        response_code   <- map["response_code"]
    }
}
