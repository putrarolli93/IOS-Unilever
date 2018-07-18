//
//  InvoiceDetailRequest.swift
//  unilever
//
//  Created by putra rolli on 15/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

internal protocol InvoiceDetailDelegate {
    func InvoiceDetailRequestSuccess(data: InvoiceDetailModel)
    func InvoiceDetailRequestError(data: String)
}

class InvoiceDetailRequest {
    
    var delegate: InvoiceDetailDelegate!
    var invoice_id: String = ""
    var outlet_id: String = ""
    
    func req() {
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/Invoice/detail/outletId/\(UserDefaults.standard.array(forKey: "session")![0])/invoiceId/\(invoice_id)").responseJSON { response in
            let result = response.result.value
            if let responses = Mapper<InvoiceDetailModel>().map(JSONObject: result as AnyObject) {
                DispatchQueue.main.async {
                    self.delegate.InvoiceDetailRequestSuccess(data: responses)
                }
            }else{
                self.delegate.InvoiceDetailRequestError(data: "error")
            }
        }
    }
}
