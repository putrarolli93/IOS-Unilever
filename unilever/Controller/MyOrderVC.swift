//
//  MyOrderVC.swift
//  unilever
//
//  Created by putra rolli on 20/06/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class MyOrderVC: UIViewController,UITableViewDelegate, UITableViewDataSource,MyOrderDelegate {
    
    let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    private var myTableView: UITableView!
    var bounds = UIScreen.main.bounds
    var myorder: MyOrderModel!
    var _request: MyOrderRequest = MyOrderRequest()
    let label2 = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 85, y: 0, width: 20, height: 20))

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigation()

        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "MyOrderCell", bundle: nil), forCellReuseIdentifier: "myordercell")
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        _request.delegate = self
        _request.req()
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.text = "\(LoginVC.product_count)"
        navigationController?.navigationBar.addSubview(label)
        
        label2.textColor = UIColor.red
        label2.textAlignment = .center
        label2.text = "0"
        navigationController?.navigationBar.addSubview(label2)
        
        addNotifIcon()
    }
    
    func addNotifIcon() {
        let imageName = "notifications-bell-button"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width - 100, y: 10 , width: 28 , height: 25)
        navigationController?.navigationBar.addSubview(imageView)
    }
    
    
    func searchIconTapped() {
        let regis = ShoppingCartVC()
        let navCon = UINavigationController()
        DefaultController.indexOftabbar = 1
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myorder != nil {
            if myorder.data != nil {
                return myorder.data.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myordercell", for: indexPath) as! MyOrderCell
            if self.myorder.data[indexPath.row].total.isEmpty {
                cell.order_total.text = ""
            }else{
                cell.order_total.text = "Rp. \(Int(Double(self.myorder.data[indexPath.row].total)!).formatnumber())"
            }
            cell.order_date.text = self.myorder.data[indexPath.row].order_date.stringTodateWithTime()
            cell.invoice_id.text = self.myorder.data[indexPath.row].order_id
            cell.order_status.text = myorder.data[indexPath.row].order_status
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = OrderReportVC()
        order.order_id = self.myorder.data[indexPath.row].order_id
        order.rows = indexPath.row
        order.order_list = self.myorder
        let navCon = UINavigationController()
        DefaultController.indexOftabbar = 1
        navCon.viewControllers = [order]
        self.present(navCon, animated: true, completion: nil)
    }

    
    func popViewController() {
        HomeVC.selectedIndex = 1
        dismiss(animated: true, completion: {
        })
    }
    
    //MARK: MYORDER REQUEST DELEGATE
    func MyOrderRequestSuccess(data: MyOrderModel) {
        self.myorder = data
        myTableView.reloadData()
    }
    
    func MyOrderRequestError(data: String) {
        
    }
    

}

extension MyOrderVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        //        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
