//
//  ShoppingCartVC.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import FTIndicator

class ShoppingCartVC: UIViewController, UITableViewDelegate, UITableViewDataSource,deleteProductDelegate,ContinueOrderDelegate,CreditLimitDelegate {

    @IBOutlet weak var shopping_total: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var order_btn: UIView!
    var credit_limit: Bool = false
    var data_count: Int = 0
    var _request_credit_limit: CreditLimitRequest = CreditLimitRequest()
    var chart: [[String]] = []
    var array: [[Int]] = []
    var shoopingCell: ShoopingCartCell = ShoopingCartCell()
    var total_price: Int = 0
    var _request: ContinueOrderRequest = ContinueOrderRequest()
    static var selectionIndex: Int = 1
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let label_chart = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    
    func plusProduct() {
        chart.removeAll()
        data_count = 0
        self.total_price = 0
        fetchData()
        if data_count == 0 {
            self.shopping_total.text = "0"
        }
        myTableView.reloadData()
    }
    
    func minProduct() {
        chart.removeAll()
        data_count = 0
        self.total_price = 0
        fetchData()
        if data_count == 0 {
            self.shopping_total.text = "0"
        }
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        data_count = 0
        self.total_price = 0
        myTableView.bounces = false
        myTableView.allowsSelection = false
//        fetchData()
        //UIApplication.shared.statusBarStyle = .lightContent
        
        //        let displayWidth: CGFloat = self.view.frame.width
        //        let displayHeight: CGFloat = self.view.frame.height
        
        //        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        //myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        myTableView.register(UINib(nibName: "ShoopingCartCell", bundle: nil), forCellReuseIdentifier: "shoopingCart")
//        myTableView.dataSource = self
//        myTableView.delegate = self
//        self.view.addSubview(myTableView)
        
        fetchData()
        self._request.delegate = self
        myTableView.register(UINib(nibName: "ShoopingCartCell", bundle: nil), forCellReuseIdentifier: "shoopingCart")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.chart.removeAll()
        navigationController?.navigationBar.willRemoveSubview(label_chart)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.selectedIndex = ShoppingCartVC.selectionIndex
        data_count = 0
        self.total_price = 0
        fetchData()
        LoginVC.getData()
        label_chart.isHidden = true
        label_chart.textColor = UIColor.red
        label_chart.textAlignment = .center
        label_chart.text = "\(LoginVC.product_count)"
        navigationController?.navigationBar.addSubview(label_chart)
        myTableView.reloadData()
        if data_count == 0 {
            addLabel()
            order_btn.isHidden = true
        }else{
            order_btn.isHidden = false
            label.removeFromSuperview()
        }
    }
    
    @IBAction func continueOrder(_ sender: Any) {
        _request_credit_limit.delegate = self
        FTIndicator.showProgress(withMessage: "Loading..", userInteractionEnable: false)
         DispatchQueue.main.async {
            self._request_credit_limit.req()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoopingCart", for: indexPath) as! ShoopingCartCell
        cell.delegate = self
        cell.index = indexPath.row
        if chart.count != 0 {
            cell.id = chart[indexPath.row][3]
            cell.product_name.text = chart[indexPath.row][0]
            cell.qty_label.text = chart[indexPath.row][2]
            let string_image = "\(chart[indexPath.row][1])"
            let updatedUrl = string_image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            cell.product_image.sd_setImage(with: URL(string: updatedUrl!), placeholderImage: UIImage(named: "placeholder.png"))
            cell.product_price.text = chart[indexPath.row][4]
        }
        return cell
    }
    
    func addLabel() {
        label.center = self.view.center
        label.textAlignment = .center
        label.text = "Let's Order Now"
        self.view.addSubview(label)
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "product_id") as! String)
                self.data_count = result.count
            }
            
        } catch {
            print("Failed")
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
                if data_count == 0 {
                    shopping_total.text = "0"
                }
                self.total_price += Int(_datecreated.product_selling_price!)! * Int(_datecreated.product_qty!)!
                print("total harga: \(self.total_price)")
                self.shopping_total.text = "\(self.total_price)"
                print(i)
                chart[i].append(_datecreated.product_name!)
                chart[i].append(_datecreated.product_photo_link!)
                chart[i].append(_datecreated.product_qty!)
                chart[i].append(_datecreated.product_id!)
                chart[i].append(_datecreated.product_selling_price!)
//                chart[i].append(_datecreated.price_total!)
//                chart[i].append(_datecreated.product_photo_link!)
//                diagonal(N: dateCreated.count,i: i, name: _datecreated.product_name!, id: _datecreated.product_id!, photo: _datecreated.product_photo_link!, price: _datecreated.product_selling_price!)
                i = i + 1
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func diagonal (N:Int,i:Int,name:String,id: String,photo: String,price: String) {
        
        for row in 0..<N {
            // Append an empty row.
            chart.append([String]())
            
            for _ in 0..<1 {
                // Populate the row.
                chart[row].append("satu")
            }
        }
    }
    
    func diagonalRow (N:Int) {
        for _ in 0..<N {
            // Append an empty row.
            chart.append([String]())
        }
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
    
    func labelProductCountRefresh() {
        navigationController?.navigationBar.willRemoveSubview(label_chart)
        LoginVC.getData()
        label_chart.textColor = UIColor.red
        label_chart.textAlignment = .center
        label_chart.text = "\(LoginVC.product_count)"
        navigationController?.navigationBar.addSubview(label_chart)
    }
    
    //MARK DELETE PRODUCT
    func deleteSuccess() {
        labelProductCountRefresh()
        chart.removeAll()
        data_count = 0
        self.total_price = 0
        fetchData()
        if data_count == 0 {
            self.shopping_total.text = "0"
            self.order_btn.isHidden = true
            addLabel()
        }else{
            label.removeFromSuperview()
        }
        
        myTableView.reloadData()
    }
    
    //MARK Request Delegate
    func OrderSuccess(data: PurchaseModel) {
        FTIndicator.dismissProgress()
        let regis = OrderReportVC()
        let navCon = UINavigationController()
        navCon.viewControllers = [regis]
//        self.show(regis, sender: nil)
        self.present(navCon, animated: true, completion: nil)
    }
    
    func OrderError(data: String) {
        FTIndicator.dismissProgress()
    }
    
    func editFeed(id: String, invoice: String) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Product")
        let predicate = NSPredicate(format: "product_id = '\(id)'")
        fetchRequest.predicate = predicate
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1
            {
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(invoice, forKey: "invoice_id")
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func popViewController() {
        HomeVC.selectedIndex = 0
        dismiss(animated: true, completion: {
        })
    }
    
    //MARK CREDIT LIMIT
    func creditLimitSuccess(data: CreditLimitModel) {
        if Int(Double(data.total_credit_limit)!) < Int(shopping_total.text!)! {
            credit_limit = false
        }else{
            credit_limit = true
        }
        FTIndicator.dismissProgress()
        if chart.count != 0 {
            if credit_limit {
                let web = OrderConfirmVC()
                web.total_price = Int(shopping_total.text!)!
                let navCon = UINavigationController()
                navCon.viewControllers = [web]
                self.present(navCon, animated: true, completion: nil)
            }
        }
    }
    
    func creditLimitError(data: String) {
        credit_limit = false
        FTIndicator.dismissProgress()
    }
    
    
}

extension ShoppingCartVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        //        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
