//
//  OrderReportVC.swift
//  unilever
//
//  Created by putra rolli on 10/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CoreData

class OrderReportVC: UIViewController,UITableViewDelegate, UITableViewDataSource, OrderDetailDelegate {

    private var myTableView: UITableView!
    var bounds = UIScreen.main.bounds
    var data_count: Int = 0
    var chart: [[String]] = []
    var total_price: Int = 0
    var order_id: String = ""
    var order_list: MyOrderModel!
    var _request: OrderDetailRequest = OrderDetailRequest()
    var order_detail: OrderDetailModel!
    var rows: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        _request.delegate = self
        _request.req(self.order_id)
//        fetchData()
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "OrderHeaderCell", bundle: nil), forCellReuseIdentifier: "OrderHeaderCell")
        myTableView.register(UINib(nibName: "OrderProductCell", bundle: nil), forCellReuseIdentifier: "OrderProductCell")
        myTableView.register(UINib(nibName: "OrderTotalCell", bundle: nil), forCellReuseIdentifier: "OrderTotalCell")
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.order_detail == nil {
            return 0
        }
        return 3
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
            return self.order_detail.data.count
        }else if section == 2 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHeaderCell", for: indexPath) as! OrderHeaderCell
            cell.order_id.text = self.order_list.data[rows].order_id
            cell.order_date.text = self.order_list.data[rows].order_date.stringTodateWithTime()
            cell.limit_payment.text = self.order_list.data[rows].outlet_term_of_payment + " hari"
            cell.info.text = self.order_list.data[rows].order_note
            cell.payment.text = self.order_list.data[rows].order_payment_type

            
            
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderProductCell", for: indexPath) as! OrderProductCell
            if self.order_detail.data.count != 0 {
                cell.product_qty.text = "\(self.order_detail.data[indexPath.row].product_qty) x "
                cell.product_name.text = "\(self.order_detail.data[indexPath.row].product_name)"
                cell.product_price.text = "Rp. \(Int(self.order_detail.data[indexPath.row].product_selling_price)!.formatnumber())"
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTotalCell", for: indexPath) as! OrderTotalCell
            let price_total = self.order_list.data[rows].subtotal
            let price_ppn = (Int(Double(price_total)!) * 10) / 100
            let total_price_after = Int(Double(price_total)!) + price_ppn
            cell.price_total.text = "Rp. \(Int(Double(price_total)!).formatnumber())"
            cell.price_ppn.text = "Rp. \(price_ppn.formatnumber())"
            cell.total_price_3.text = "Rp. \(total_price_after.formatnumber())"
            return cell
        }
        return UITableViewCell()
    }
    
    func popViewController() {
        ShoppingCartVC.selectionIndex = 0
        deleteAllRecords()
        dismiss(animated: true, completion: {
        })
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
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
                self.total_price += Int(_datecreated.product_selling_price!)! * Int(_datecreated.product_qty!)!
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
    
    //MARK: Order Detail
    func OrderDetailSuccess(data: OrderDetailModel) {
        self.order_detail = data
        self.myTableView.reloadData()
    }
    
    func OrderDetailError(data: String) {
        
    }

}

extension OrderReportVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        title = "Rincian Pembelian"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
