//
//  CreditLimitRequest.swift
//  unilever
//
//  Created by putra rolli on 09/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol CreditLimitDelegate {
    func creditLimitSuccess(data: CreditLimitModel)
    func creditLimitError(data: String)
}

class CreditLimitRequest {
    
    var email: String = ""
    var phone: String = ""
    var delegate: CreditLimitDelegate!
    
    func req() {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Order/credit_limit_check/outletId/\(UserDefaults.standard.array(forKey: "session")![0])").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<CreditLimitModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.creditLimitSuccess(data: responses)
                }
            }else{
                self.delegate.creditLimitError(data: "error")
            }
        }
    }
}
