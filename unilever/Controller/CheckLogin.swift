//
//  CheckLogin.swift
//  unilever
//
//  Created by putra rolli on 07/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol IsLoginDelegate {
    func isLogin(data: String)
    func isNotlogin(data: String)
}

class CheckLogin {
    
    var delegate: IsLoginDelegate!
    
    func req() {
        DispatchQueue.main.asyncAfter(deadline:.now() + 2) {
            
            if UserDefaults.standard.array(forKey: "session") != nil {
                self.delegate.isLogin(data: "udah Login")
            }else{
                self.delegate.isNotlogin(data: "belon Login")
            }
        }

    }

}
