//
//  OrderConfirmVC.swift
//  unilever
//
//  Created by putra rolli on 01/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CoreData

class OrderConfirmVC: UIViewController,UITableViewDelegate,UITableViewDataSource,ProsesPaymentDelegate,InputInformTextDelegate {
    
    var pickerView = UIPickerView()
    var pickOption = ["one", "two", "three", "seven", "fifteen"]
    private var myTableView: UITableView!
    var bounds = UIScreen.main.bounds
    var data_count: Int = 0
    var chart: [[String]] = []
    var total_price: Int = 0
    var order_id: String = ""
    var _request: OrderDetailRequest = OrderDetailRequest()
    var order_detail: OrderDetailModel!
    var textInform: String = ""
    var pickerPayment: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        fetchData()
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 500))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "HeaderOrderConfirmCell", bundle: nil), forCellReuseIdentifier: "HeaderOrderConfirmCell")
        myTableView.register(UINib(nibName: "OrderProductCell", bundle: nil), forCellReuseIdentifier: "OrderProductCell")
        myTableView.register(UINib(nibName: "OrderTotalCell", bundle: nil), forCellReuseIdentifier: "OrderTotalCell")
        myTableView.register(UINib(nibName: "OrderInputInformCell", bundle: nil), forCellReuseIdentifier: "OrderInputInformCell")
        myTableView.register(UINib(nibName: "OrderPaymentMethodCell", bundle: nil), forCellReuseIdentifier: "OrderPaymentMethodCell")
//        myTableView.separatorStyle = .none
        myTableView.isScrollEnabled = true
        self.view.addSubview(myTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.frame.size.height = 1000
        myTableView.frame.size.height = 500
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.frame.size.height = 1000
        myTableView.frame.size.height = 500
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.chart.count == 0 {
            return 0
        }
        return 5
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderOrderConfirmCell", for: indexPath) as! HeaderOrderConfirmCell
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderProductCell", for: indexPath) as! OrderProductCell
            if self.chart.count != 0 {
                cell.product_qty.text = "\(self.chart[indexPath.row][1])"
                cell.product_name.text = "\(self.chart[indexPath.row][0])"
                cell.product_price.text = "\(self.chart[indexPath.row][2])"
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTotalCell", for: indexPath) as! OrderTotalCell
            cell.price_total.text = "\(total_price)"
            cell.price_ppn.text = "\(total_price * 10 / 100)"
            cell.total_price_3.text = "\(total_price + Int(cell.price_ppn.text!)!)"
            return cell
        }else if indexPath.section == 3 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInputInformCell", for: indexPath) as! OrderInputInformCell
            cell.delegate = self
            return cell
        }else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPaymentMethodCell", for: indexPath) as! OrderPaymentMethodCell
            cell.delegate = self
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
    
    //Mark: Payment method
    func prosesDidclick(_ string: String) {
        let regis = OrderWebviewVC()
        pickerPayment = string
        regis.pickerPayment = pickerPayment
        regis.textInform = textInform
        regis.total = Double(total_price)
        let navCon = UINavigationController()
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }
    
    //MARK: TextField
    func textField(_ String: String) {
        textInform = String
    }
}

extension OrderConfirmVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        //        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
