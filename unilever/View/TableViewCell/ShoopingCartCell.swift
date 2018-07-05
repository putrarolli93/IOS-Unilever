//
//  ShoopingCartCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit
import CoreData

internal protocol deleteProductDelegate {
    func deleteSuccess()
    func plusProduct()
    func minProduct()
}

class ShoopingCartCell: UITableViewCell {
    
    @IBOutlet weak var btn_move: UIButton!
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_price: UILabel!
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var btn_wishlist: UIButton!
    @IBOutlet weak var product_qty: UITextField!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var qty_label: UILabel!
    
    var index: Int = 0
    var id: String = ""
    var delegate: deleteProductDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deleteChart(_ sender: Any) {
        deleteFeed(id: self.id)
        self.delegate.deleteSuccess()
    }
    
    @IBAction func plusAct(_ sender: Any) {
        self.qty_label.text = "\(Int(self.qty_label.text!)! + 1)"
        editFeed(id: id, qty: self.qty_label.text!)
        delegate.plusProduct()
    }

    @IBAction func minAct(_ sender: Any) {
        if self.qty_label.text != "3" {
            self.qty_label.text = "\(Int(self.qty_label.text!)! - 1)"
            editFeed(id: id, qty: self.qty_label.text!)
            delegate.minProduct()
        }
    }
    
    @IBAction func moveWishList(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
                try managedContext.save()
            }
        }
        catch _ {
            print("Could not delete")
        }
    }
    
    func editFeed(id: String, qty: String) {
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
                objectUpdate.setValue(qty, forKey: "product_qty")
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
    
}
