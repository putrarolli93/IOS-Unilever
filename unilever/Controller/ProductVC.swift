//
//  ProductVC.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import SideMenuController
import FTIndicator

class ProductVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ProductDelegate {

    @IBOutlet weak var topHeading: NSLayoutConstraint!
    @IBOutlet weak var Mycollection: UICollectionView!
    let screenSize = UIScreen.main.bounds
    var _request: ProductRequest = ProductRequest()
    var product: ProductModel!
    var productFilter: [ProductModelArray]!
    var brand_id: String = ""
    let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        _request.delegate = self
        self.reqProduct(brand_id)
//        self.topHeading.constant = 70
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        let screenWidth = screenSize.width
        
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: screenWidth / 2 - 20, height: 237)
        
        Mycollection.delegate = self
        Mycollection.dataSource = self
        Mycollection.isScrollEnabled = true
        Mycollection.collectionViewLayout = layout
        //        Mycollection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        Mycollection.register(nib, forCellWithReuseIdentifier: "product")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        LoginVC.getData()
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.text = "\(LoginVC.product_count)"
        navigationController?.navigationBar.addSubview(label)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.willRemoveSubview(label)
    }
    
    func reqProduct(_ brand_id: String) {
        FTIndicator.showProgress(withMessage: "Loading")
        _request.reqParams(brand_id: brand_id)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        vc.product_detail_string = self.productFilter[indexPath.row].product_id
        let navCon = UINavigationController()
        navCon.viewControllers = [vc]
        self.present(navCon, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if product == nil {
            return 0
        }
        return productFilter.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCollectionViewCell
        cell.loadView(indexPath.row, self.product, self.productFilter)
        cell.index = indexPath.row
        return cell
    }
    
    func popViewController() {
        HomeVC.selectedIndex = 0
        dismiss(animated: true, completion: {
        })
    }
    
    func chart() {
        HomeVC.selectedIndex = 1
        dismiss(animated: true, completion: {
        })
    }
    
    //MARK: Product Delegate
    func ProductSuccess(data: ProductModel, brand: [ProductModelArray]?) {
        FTIndicator.dismissProgress()
        self.product = data
        self.productFilter = brand
        self.Mycollection.reloadData()
    }
    
    func ProductError(data: String) {
        
    }
}


extension ProductVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
//        title = "Register"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        //-------------------
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(chart))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
