//
//  ProductCollectionViewCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    @IBOutlet weak var product_price: UILabel!
    @IBOutlet weak var btn_buy: UIView!
    @IBOutlet weak var btn_buy_text: UILabel!
    
//    var index: Int = 0
    var isRemove: Bool = true
    var data: ProductModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadView(_ index: Int,_ data: ProductModel,_ data_filter: [ProductModelArray]!) {
        self.data = data
        if data_filter[index].product_stock == "Unavailable" {
            self.btn_buy.backgroundColor = UIColor.lightGray
            self.btn_buy_text.text = "Tidak Tersedia"
        }else{
            
        }
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        let formattedNumber = formater.string(from: Int(data_filter[index].selling_price)! as NSNumber)
        let string_image = "\(data_filter[index].product_photo_link)\(data_filter[index].product_photo)"
        let updatedUrl = string_image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        product_image.sd_setImage(with: URL(string: updatedUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        product_title.text = data_filter[index].product_name
        product_price.text = "Rp. \(String(describing: formattedNumber!))"
    }

//    @IBAction func addToCart(_ sender: Any) {
////        self.isRemove = true
//        if isRemove {
//            self.btn_chart.backgroundColor = UIColor.red
//            self.btn_chart.setTitle("Remove", for: .normal)
//            save(self.index)
//            self.isRemove = false
//        }else{
//            self.btn_chart.backgroundColor = UIColor.blue
//            self.btn_chart.setTitle("Add to Chart", for: .normal)
//            deleteFeed(id: data.data[index].product_id)
//            self.isRemove = true
//        }
//        getData()
//    }
    
    func save(_ index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(data.data[index].product_id, forKey: "product_id")
        newUser.setValue("1", forKey: "product_qty")
        newUser.setValue(data.data[index].product_pricelist, forKey: "product_pricelist")
        newUser.setValue(data.data[index].product_discount, forKey: "product_discount")
        newUser.setValue(data.data[index].selling_price, forKey: "product_selling_price")
        newUser.setValue(data.data[index].product_photo_link + data.data[index].product_photo, forKey: "product_photo_link")
        newUser.setValue(data.data[index].product_name, forKey: "product_name")
        newUser.setValue(data.data[index].selling_price, forKey: "price_total")

        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
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
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func deleteFeed(id:String)
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Product")
        fetchRequest.predicate = NSPredicate(format: "product_id = %@", "\(id)")
        do
        {
            let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            for entity in fetchedResults! {
                managedContext.delete(entity)
            }
        }
        catch _ {
            print("Could not delete")
        }
    }
}
