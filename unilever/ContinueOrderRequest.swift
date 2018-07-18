//
//  ContinueOrderRequest.swift
//  unilever
//
//  Created by putra rolli on 10/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import CoreData

internal protocol ContinueOrderDelegate {
    func OrderSuccess(data: PurchaseModel)
    func OrderError(data: String)
}

class ContinueOrderRequest {
    
    var username: String = ""
    var password: String = ""
    var outlet_name: String = ""
    var outlet_contact: String = ""
    var outlet_address: String = ""
    var outlet_phone: String = ""
    var outlet_email: String = ""
    var chart: [[String]] = []
    var payment_type: String = ""
    var payment_note: String = ""
    var payment_total: String = ""
    var params: [[String:Any]] = []
    
    var delegate: ContinueOrderDelegate!
    
    func req() {
        fetchData()
        let headers: HTTPHeaders = [
            "Authorization": "Info XXX",
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        let parameters: [String: Any] = [
            "request_type": 7,
            "data": [
                "order_info": [
                    "username": "\(UserDefaults.standard.array(forKey: "session")![2])",
                    "outlet_id": "\(UserDefaults.standard.array(forKey: "session")![0])",
                    "order_disc": "0",
                    "order_notes": "\(payment_note)",
                    "order_pay_type": "\(payment_type)",
                    "order_subtotal": "\(payment_total)",
                    "order_total": "\(payment_total)"
                ],
                "order_detail":
                        params
            ]
        ]
        
        Alamofire.request("http://202.154.3.188/commerce/unilever-middleware/core-services/order/save", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let result = response.result.value
                if let responses = Mapper<PurchaseModel>().map(JSONObject: result as AnyObject) {
                    DispatchQueue.main.async {
                        self.delegate.OrderSuccess(data: responses)
                        self.params.removeAll()
                    }
                }else{
                    self.delegate.OrderError(data: "error")
                    self.params.removeAll()
                }
        }
    }
    
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        do {
            let results = try context.fetch(fetchRequest)
            let  dateCreated = results as! [Product]
            var i = 0
            for _datecreated in dateCreated {
                params.append(
                    [
                        "product_id": _datecreated.product_id!,
                        "product_qty": _datecreated.product_qty!,
                        "product_pricelist": _datecreated.product_pricelist!,
                        "product_discount": "0",
                        "product_selling_price": _datecreated.product_selling_price!
                    ]
                )
                i = i + 1
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
}
