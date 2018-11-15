//
//  OrderConfirmVC.swift
//  unilever
//
//  Created by putra rolli on 01/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CoreData
import FTIndicator

class OrderConfirmVC: UIViewController,UITableViewDelegate,UITableViewDataSource,ProsesPaymentDelegate,InputInformTextDelegate,ContinueOrderDelegate,DiskonDelegate {
    
    @IBOutlet weak var btn_proses: UIButton!
    
    func OrderSuccess(data: PurchaseModel) {
        let regis = OrderReportFinishVC()
        regis.chart = self.chart
        regis.purchase = data
        let navCon = UINavigationController()
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }
    
    func OrderError(data: String) {
        
    }
    
    
    var pickerView = UIPickerView()
    var payment_option = ["Bayar ditempat", "Giro", "Transfer Bank", "Kartu Kredit", "Pembayaran Tunai"]
    var payment_option_img = ["delivery-truck-with-circular-clock", "icon_giro", "bank-building", "credit-cards", "hand"]
    private var myTableView: UITableView!
    var bounds = UIScreen.main.bounds
    var data_count: Int = 0
    var chart: [[String]] = []
    var total_price: Int = 0
    var order_id: String = ""
//    var _request: OrderDetailRequest = OrderDetailRequest()
    var _request: ContinueOrderRequest = ContinueOrderRequest()
    var order_detail: OrderDetailModel!
    var diskon: DiskonModel!
    var textInform: String = ""
    var pickerPayment: String = ""
    var index_payment_selec: Int? = nil
    var _request_diskon: DiskonRequest = DiskonRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _request.delegate = self
        setupNavigation()
        fetchData()
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - 120 - navigationController!.navigationBar.frame.size.height))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "HeaderOrderConfirmCell", bundle: nil), forCellReuseIdentifier: "HeaderOrderConfirmCell")
        myTableView.register(UINib(nibName: "OrderProductCell", bundle: nil), forCellReuseIdentifier: "OrderProductCell")
        myTableView.register(UINib(nibName: "OrderTotalCell", bundle: nil), forCellReuseIdentifier: "OrderTotalCell")
        myTableView.register(UINib(nibName: "OrderInputInformCell", bundle: nil), forCellReuseIdentifier: "OrderInputInformCell")
         myTableView.register(UINib(nibName: "HeaderTypeCell", bundle: nil), forCellReuseIdentifier: "specialOffer")
//        myTableView.register(UINib(nibName: "OrderPaymentMethodCell", bundle: nil), forCellReuseIdentifier: "OrderPaymentMethodCell")
        myTableView.register(UINib(nibName: "PaymentMethodCell", bundle: nil), forCellReuseIdentifier: "PaymentMethodCell")

//        myTableView.separatorStyle = .none
        myTableView.isScrollEnabled = true
        self.view.addSubview(myTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if index_payment_selec == nil {
            btn_proses.isEnabled = false
            btn_proses.backgroundColor = UIColor.lightGray
        }
        _request_diskon.delegate = self
        _request_diskon.total = "\(self.total_price)"
        _request_diskon.req()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.chart.count == 0 {
            return 0
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return self.chart.count
        }else if section == 2 {
            return 1
        }else if section == 3 {
            return 1
        }else if section == 4 {
            return 1
        }
        else if section == 5 {
            if total_price < 500000 {
                return 1
            }
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.tintColor = UIColor.blue
                cell.accessoryType = .checkmark
                self.index_payment_selec = indexPath.row
                if index_payment_selec != nil {
                    btn_proses.backgroundColor = UIColor.blue
                    btn_proses.isEnabled = true
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if indexPath.section == 5 {
                cell.tintColor = UIColor.gray
                cell.accessoryType = .checkmark
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderOrderConfirmCell", for: indexPath) as! HeaderOrderConfirmCell
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderProductCell", for: indexPath) as! OrderProductCell
            if self.chart.count != 0 {
                cell.product_qty.text = "\(self.chart[indexPath.row][1]) x "
                cell.product_name.text = "\(self.chart[indexPath.row][0])"
                cell.product_price.text = "\(Int(self.chart[indexPath.row][2])!.formatnumber())"
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTotalCell", for: indexPath) as! OrderTotalCell
            let price_total = total_price
            let price_ppn = (total_price * 10) / 100
            var total_price_after = price_total + price_ppn
            var total_after_diskon = 0
            cell.price_total.text = "Rp. \(price_total.formatnumber())"
            cell.price_ppn.text = "Rp. \(price_ppn.formatnumber())"
            if diskon != nil && diskon.data != nil {
                if Int(diskon.data[0].discount_calc) != 0 {
                    cell.diskon.isHidden = false
                    cell.diskon_lbl.isHidden = false
                    cell.diskon_lbl.text = diskon.data[0].discount_name
                    cell.diskon.text = "- Rp. \(Int(diskon.data[0].discount_calc).formatnumber())"
                    
                    total_price_after = total_price_after - Int(diskon.data[0].discount_calc)
                }
            }
            cell.total_price_3.text = "Rp. \(total_price_after.formatnumber())"
            return cell
        }else if indexPath.section == 3 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInputInformCell", for: indexPath) as! OrderInputInformCell
            cell.delegate = self
            return cell
        }else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "specialOffer", for: indexPath) as! HeaderTypeCell
            return cell
        }else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
            if total_price < 500000 {
                payment_option.removeAll()
                payment_option_img.removeAll()
                payment_option.append("Bayar Ditempat")
                payment_option_img.append("delivery-truck-with-circular-clock")
            }
            cell.payment_label.text = payment_option[indexPath.row]
            cell.payment_img.image = UIImage(named: payment_option_img[indexPath.row])
            cell.tintColor = UIColor.gray
            cell.accessoryType = .checkmark
            return cell
        }
        return UITableViewCell()
    }
    
    func donePicker() {
       inputView?.resignFirstResponder()
    }

    func popViewController() {
        dismiss(animated: true, completion: {
        })
    }
    
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        do {
            let results = try context.fetch(fetchRequest)
            let  dateCreated = results as! [Product]
            var i = 0
            diagonalRow(N: dateCreated.count)
            for _datecreated in dateCreated {
                print(_datecreated.product_name!)
                self.data_count = dateCreated.count
//                self.total_price += Int(_datecreated.product_selling_price!)! * Int(_datecreated.product_qty!)!
                print("total harga: \(self.total_price)")
                print(i)
                chart[i].append(_datecreated.product_name!)
                chart[i].append(_datecreated.product_qty!)
                chart[i].append(_datecreated.product_selling_price!)
                
                i = i + 1
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    func diagonalRow (N:Int) {
        for row in 0..<N {
            // Append an empty row.
            chart.append([String]())
        }
    }
    
    @IBAction func btnProsesClick(_ sender: Any) {
        _request.chart = self.chart
        _request.payment_type = payment_option[index_payment_selec!]
        _request.payment_total = "\(total_price)"
        _request.req()
    }
    //Mark: Payment method
    func prosesDidclick(_ string: String) {
        _request.chart = self.chart
        _request.payment_type = string
        _request.payment_total = "\(total_price)"
        _request.req()
//        let regis = OrderWebviewVC()
//        pickerPayment = string
//        regis.pickerPayment = pickerPayment
//        regis.textInform = textInform
//        regis.total = Double(total_price)
//        let navCon = UINavigationController()
//        navCon.viewControllers = [regis]
//        self.present(navCon, animated: true, completion: nil)
    }
    
    //MARK: TextField
    func textField(_ String: String) {
        textInform = String
    }
    
    
    //MARK: DISKON DELEGATE
    func diskonGetSuccess(data: DiskonModel) {
        self.diskon = data
        myTableView.reloadData()
    }
    
    func diskonGetError(data: String) {
        FTIndicator.showToastMessage("Koneksi bermasalah")
    }
}

extension OrderConfirmVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        title = "Konfirmasi Pesanan"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
