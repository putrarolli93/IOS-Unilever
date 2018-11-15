//
//  InvoiceRequest.swift
//  unilever
//
//  Created by putra rolli on 20/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol InvoiceDelegate {
    func InvoiceRequestSuccess(data: InvoiceModel)
    func InvoiceRequestError(data: String)
}

class InvoiceRequest {
    
    var delegate: InvoiceDelegate!
    
    func req() {
        Alamofire.request("\(BaseUrl.baseUrl)commerce/unilever-middleware/core-services/Invoice/list/outletId/\(UserDefaults.standard.array(forKey: "session")![0])").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<InvoiceModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.InvoiceRequestSuccess(data: responses)
                }
            }else{
                self.delegate.InvoiceRequestError(data: "error")
            }
        }
    }
}
