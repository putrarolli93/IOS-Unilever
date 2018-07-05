//
//  ProductDetailVC.swift
//  unilever
//
//  Created by putra rolli on 20/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class ProductDetailVC: UIViewController,ProductDetailDelegate {

    var _request: ProductDetailRequest = ProductDetailRequest()
    var product: ProductDetailModel!
    var product_detail_string: String = ""
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_price: UILabel!
    @IBOutlet weak var product_category: UILabel!
    @IBOutlet weak var product_brand: UILabel!
    let label = UILabel(frame: CGRect(x: LoginVC.screenSize.width - 25, y: 0, width: 20, height: 20))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        _request.delegate = self
        ProductDetailRequest.product_detail = self.product_detail_string
        _request.req(product_detail_string)

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
    
    func popViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func chart() {
        HomeVC.selectedIndex = 1
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func orderAct(_ sender: Any) {
        save()
//        HomeVC.selectedIndex = 1
//        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        let regis = ShoppingCartVC()
        let navCon = UINavigationController()
        DefaultController.indexOftabbar = 1
        navCon.viewControllers = [regis]
        self.present(navCon, animated: true, completion: nil)
    }
    
    
    func ProductDetailRequestSuccess(data: ProductDetailModel) {
        self.product = data
        product_name.text = data.data.product_name
        product_price.text = "Rp. \(Int(data.data.selling_price)!.formatnumber())"
        product_category.text = data.data.category_level_1
        product_brand.text = data.data.brand_name
        let string_image = "\(data.data.product_photo_link)\(data.data.product_photo)"
        let updatedUrl = string_image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        product_image.sd_setImage(with: URL(string: updatedUrl!), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func ProductDetailRequestError(data: String) {
        
    }
    
    func save() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(product.data.product_id, forKey: "product_id")
        newUser.setValue("3", forKey: "product_qty")
        newUser.setValue(product.data.product_pricelist, forKey: "product_pricelist")
        newUser.setValue(product.data.product_discount, forKey: "product_discount")
        newUser.setValue(product.data.selling_price, forKey: "product_selling_price")
        newUser.setValue(product.data.product_photo_link + product.data.product_photo, forKey: "product_photo_link")
        newUser.setValue(product.data.product_name, forKey: "product_name")
        newUser.setValue(product.data.selling_price, forKey: "price_total")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

}

extension ProductDetailVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(chart))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
