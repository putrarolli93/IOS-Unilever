//
//  InvoiceDetailVC.swift
//  unilever
//
//  Created by putra rolli on 15/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator


class InvoiceDetailVC: UIViewController,InvoiceDetailDelegate,DiskonDelegate {

    @IBOutlet weak var keterangan: UILabel!
    @IBOutlet weak var pembayaran_type: UILabel!
    @IBOutlet weak var total_pembayaran: UILabel!
    @IBOutlet weak var diskon: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var tgl_pesanan: UILabel!
    @IBOutlet weak var no_pesanan: UILabel!
    @IBOutlet weak var batas_tagihan: UILabel!
    @IBOutlet weak var tgl_tagihan: UILabel!
    @IBOutlet weak var invoice_id: UILabel!
    var invoice: InvoiceModel!
    var data: InvoiceDetailModel!
    var total: Float = 0.0

    var _index: Int = 0
    var _request: InvoiceDetailRequest = InvoiceDetailRequest()
    var _request_diskon: DiskonRequest = DiskonRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        _request.delegate = self
        _request.invoice_id = self.invoice.data[_index].invoice_id
        _request.outlet_id = self.invoice.data[_index].outlet_id
        FTIndicator.showProgress(withMessage: "Loading..")
        _request.req()
    }
    
    func popViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: DETAIL INVOICE
    func InvoiceDetailRequestSuccess(data: InvoiceDetailModel) {
        total = Float(data.data[0].total)!
        
        //req diskon
        _request_diskon.delegate = self
        _request_diskon.total = "\(Int(total))"
        _request_diskon.req()

        self.data = data
        self.invoice_id.text = data.data[0].invoice_id
        self.tgl_tagihan.text = data.data[0].invoice_date.stringTodate()
        self.batas_tagihan.text = data.data[0].invoice_due_date.stringTodate()
        self.no_pesanan.text = data.data[0].order_id
        self.tgl_pesanan.text = data.data[0].order_date.stringTodateWithTime()
        self.status.text = data.data[0].order_status
//        self.diskon.text = data.data[0].order_discount
//        self.total_pembayaran.text = "RP. \(Int(total).formatnumber())"
        self.pembayaran_type.text = data.data[0].order_payment_type
        self.keterangan.text = data.data[0].order_note
    }
    
    func InvoiceDetailRequestError(data: String) {
        FTIndicator.dismissProgress()
        let alert = UIAlertController(title: "Alert", message: "Request Error", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: DISKON
    func diskonGetSuccess(data: DiskonModel) {
        var total_pmbyrn: Int = 0
        if data.data != nil {
            self.diskon.text = "Rp. \(Int(data.data[0].discount_calc).formatnumber())"
            total_pmbyrn =  Int(total) - Int(data.data[0].discount_calc)
        }else{
            total_pmbyrn = Int(total)
        }
        self.total = Float(total_pmbyrn)
        self.total_pembayaran.text = "RP. \(total_pmbyrn.formatnumber())"
        FTIndicator.dismissProgress()
    }
    
    func diskonGetError(data: String) {
        
    }
    

    
    @IBAction func bayarDidClick(_ sender: Any) {
        if pembayaran_type.text == "Transfer Bank" || pembayaran_type.text == "Kartu Kredit" {
            let regis = OrderWebviewVC()
            regis.pickerPayment = self.data.data[0].order_payment_type
            regis.total = Double(self.total)
            let navCon = UINavigationController()
            navCon.viewControllers = [regis]
            self.present(navCon, animated: true, completion: nil)
        }else {
            let vc = PaymentCodVC()
            vc.thanks_lbl = "Terima kasih toko \(data.data[0].outlet_name), anda telah melakukan pembayaran via \(data.data[0].order_payment_type) dengan status pembayaran \(data.data[0].order_status), pesanan anda akan segera diproses."
            let navCon = UINavigationController()
            navCon.viewControllers = [vc]
            self.present(navCon, animated: true, completion: nil)
        }
    }
    
}


extension InvoiceDetailVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        title = "Tagihan"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
