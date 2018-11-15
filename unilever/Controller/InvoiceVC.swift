//
//  InvoiceVC.swift
//  unilever
//
//  Created by putra rolli on 20/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CoreData

class InvoiceVC: UIViewController,UITableViewDelegate, UITableViewDataSource,InvoiceDelegate {
    
    private var myTableView: UITableView!
    var bounds = UIScreen.main.bounds
    var invoice: InvoiceModel!
    var _request: InvoiceRequest = InvoiceRequest()
    let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    let label2 = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 85, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UINib(nibName: "InvoiceCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InvoiceDetailVC()
        vc._index = indexPath.row
        vc.invoice = self.invoice
        let navCon = UINavigationController()
        navCon.viewControllers = [vc]
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
        if (invoice != nil && invoice.data != nil) {
            return invoice.data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceCell
            cell.order_id.text = self.invoice.data[indexPath.row].order_id
            cell.order_date.text = self.invoice.data[indexPath.row].invoice_date.stringTodate()
            cell.invoice_id.text = self.invoice.data[indexPath.row].invoice_id
            cell.order_status.text = self.invoice.data[indexPath.row].order_status
            return cell
        }
        return UITableViewCell()
    }
    
    func popViewController() {
        HomeVC.selectedIndex = 0
        dismiss(animated: true, completion: {
        })
    }
    
    func searchIconTapped() {
        let regis = ShoppingCartVC()
        let navCon = UINavigationController()
        DefaultController.indexOftabbar = 1
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
        
    }
    
    //MARK: INVOICE
    func InvoiceRequestSuccess(data: InvoiceModel) {
        self.invoice = data
        myTableView.reloadData()
    }
    
    func InvoiceRequestError(data: String) {
        
    }
}

extension InvoiceVC {
    func setupNavigation() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
