//
//  OrderWebviewVC.swift
//  unilever
//
//  Created by putra rolli on 30/06/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CryptoSwift

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

class OrderWebviewVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var pickerPayment: String = ""
    var textInform: String = ""
    var total: Double = 0
    var paymentMethod: Int = 0
    var DOKU_MALL_ID: String = "5865"
    var CHAINMERCHANT: String = "NA"
    var CURRENCY: Int = 360
    var PURCHASECURRENCY: Int = 360
    var timeFormat: Int = 0
    var SHAREDKEY: String = "0RGmzf441tJU"
    var WORDS: String = ""
    var TRANSIDMERCHANT: String = ""
    var wordFromEncryp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateToTimeStamp()
        setupNavigation()
        if pickerPayment == "Bayar Ditempat" {
            paymentMethod = 1
        }else if pickerPayment == "Giro" {
            paymentMethod = 2
        }else if pickerPayment == "Bank Transfer" {
            paymentMethod = 36
        }else if pickerPayment == "Kartu Kredit" {
            paymentMethod = 15
        }else{
            paymentMethod = 3
        }
        TRANSIDMERCHANT = "\(20180704062948)"
        let totalPurchase = "13000.00"
        
        self.WORDS = "\(totalPurchase)\(DOKU_MALL_ID)\(SHAREDKEY)\(TRANSIDMERCHANT)"
        let newWords = WORDS.sha1()
        wordFromEncryp = newWords.replacingOccurrences(of: " ", with: "").lowercased()
        timeFormat = Int(Date().ticks)
        var request = URLRequest(url: URL(string: "https://staging.doku.com/Suite/Receive")!)
        request.httpMethod = "POST"
        let postString = "BASKET=Item 1,10000.00,1,10000.00&MALLID=\(DOKU_MALL_ID)&CHAINMERCHANT=\(CHAINMERCHANT)&CURRENCY=\(CURRENCY)&PURCHASECURRENCY=\(PURCHASECURRENCY)&AMOUNT=\(totalPurchase)&PURCHASEAMOUNT=\(totalPurchase)&TRANSIDMERCHANT=\(TRANSIDMERCHANT)&SHAREDKEY=\(SHAREDKEY)&PAYMENTCHANNEL=\(paymentMethod)&WORDS=\(wordFromEncryp)&REQUESTDATETIME=\(TRANSIDMERCHANT)&SESSIONID=\(TRANSIDMERCHANT)&EMAIL=test@doku.com&NAME=test&MOBILEPHONE=0215150555"
        request.httpBody = postString.data(using: .utf8)
        webView.loadRequest(request)
    }
    
    func dateToTimeStamp() -> Int {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let todaysDate = dateFormatter.string(from: date)
        return Int(todaysDate)!
    }
    
    func popViewController() {
        dismiss(animated: true, completion: {
        })
    }
}

extension OrderWebviewVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        //        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}

