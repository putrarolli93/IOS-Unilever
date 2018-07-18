//
//  HomeVC.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import FTIndicator

class HomeVC: UIViewController,UITableViewDelegate, UITableViewDataSource,ProductBrandDelegate,BrandSelectDelegate,BannerDelegate {
    
    func brandSelected(_ brand_id: String, _ brand_name: String) {
        let regis = ProductVC()
        regis.brand_name = brand_name
        regis.brand_id = brand_id
        let navCon = UINavigationController()
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }

    func ProductBrandRequestSuccess(data: [ProductModelBrand]?, brand: ProductBrandModel?) {
        self.brand = brand
        let row = (brand?.data.count)! / 3
        let rowProduct = (brand?.data.count)! % 3
        if rowProduct != 0 {
            HomeVC.RowCountProduct = row + 1
        }else{
            HomeVC.RowCountProduct = row
        }
        self.myTableView.reloadData()
        FTIndicator.dismissProgress()
    }
    func ProductBrandRequestError(data: String) {
        
    }

    func ProductSuccess(data: ProductModel, brand: [ProductModelArray]?) {
//        self.product = data
//        let row = data.data.count / 3
//        let rowProduct = data.data.count % 3
//        if rowProduct == 1 {
//            HomeVC.RowCountProduct = row + 1
//        }else{
//            HomeVC.RowCountProduct = row
//        }
//        self.myTableView.reloadData()
//        FTIndicator.dismissProgress()
    }
    
    func ProductError(data: String) {
//        FTIndicator.dismissProgress()
    }
    
    static var RowCountProduct: Int = 0
    static var ProductHeight: Int = 0
    private var myTableView: UITableView!
    var GetIndex: Bool = false
    static var selectedIndex: Int = 0
    var _request: ProductBrandRequest = ProductBrandRequest()
    var _requestBanner: BannerRequest = BannerRequest()
    var product: ProductModel!
    var banner: BannerModel!
    var brand: ProductBrandModel!
    let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    let label2 = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 85, y: 0, width: 20, height: 20))
    var bounds = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(searchIconTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        _request.delegate = self
        _request.req()
        _requestBanner.delegate = self
        _requestBanner.req()
//        FTIndicator.showProgress(withMessage: "Loading..", userInteractionEnable: false)
        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: bounds.height + 49))
//        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        let nib5 = UINib(nibName: "BannerCell", bundle: nil)
        myTableView.register(nib5, forCellReuseIdentifier: "banner")
        let nib4 = UINib(nibName: "BrandCell", bundle: nil)
        myTableView.register(nib4, forCellReuseIdentifier: "brandCell")
//        let nib3 = UINib(nibName: "HeaderTypeCell", bundle: nil)
//        myTableView.register(nib3, forCellReuseIdentifier: "specialOffer")
//        let nib2 = UINib(nibName: "SpecialCell", bundle: nil)
//        myTableView.register(nib2, forCellReuseIdentifier: "specialCell")
        myTableView.dataSource = self
        myTableView.backgroundColor = UIColor.lightText
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        self.view.addSubview(myTableView)
    }
    
    func searchIconTapped() {
//        tabBarController?.selectedIndex = 1
        let regis = ShoppingCartVC()
        let navCon = UINavigationController()
        DefaultController.indexOftabbar = 1
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.selectedIndex = HomeVC.selectedIndex
        LoginVC.getData()
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.text = "\(LoginVC.product_count)"
        navigationController?.navigationBar.addSubview(label)
        
        addNotifIcon()
    }
    
    func addNotifIcon() {
        let imageName = "notifications-bell-button"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width - 100, y: 10 , width: 28 , height: 25)
        navigationController?.navigationBar.addSubview(imageView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.willRemoveSubview(label)
    }
    
    func getIndex() {
        DispatchQueue.main.async {
            if self.GetIndex {
                self.tabBarController?.selectedIndex = 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        }else if indexPath.section == 1 {
            return CGFloat(HomeVC.ProductHeight) + 50
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "banner", for: indexPath) as! BannerCell
            cell.selectionStyle = .none
            if self.banner != nil {
                cell.loadView(banner)
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath) as! BrandCell
//            cell.collectionCell.frame.size.width = self.view.frame.width
//            cell.collectionCell.frame.size.height = self.view.frame.height
            cell.selectionStyle = .none
            cell.delegate = self
            if self.brand != nil {
                cell.brand = self.brand
                cell.loadView()
//                myTableView.reloadData()
            }
            return cell
        }
        return UITableViewCell()
        
    }
    
    //MARK: BANNER REQUEST
    func bannerSuccess(data: BannerModel) {
        self.banner = data
        self.myTableView.reloadData()
        FTIndicator.dismissProgress()
    }
    
    func bannerError(data: String) {
        FTIndicator.dismissProgress()
    }
    

    
    func setUpTabBar() {
//        let tab1 = ProductVC()
//        tab1.tabBarItem = UITabBarItem(title: "Most View", image: UIImage(named: "ic_profile_new"), tag: 0)
//        let tab2 = ShoppingCartVC()
//        tab2.tabBarItem = UITabBarItem(title: "Update News", image: UIImage(named: "ic_profile_new"), tag: 1)
//        let viewControllerList = [tab1, tab2]
//        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
    
}
