//
//  MenuListCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class MenuListCell: UITableViewCell {
    
    @IBOutlet weak var view_line: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    var image_arr = ["menu","ic_home","ic_order","ic_invoice","ic_profile","ic_sign_out"]
    var title_arr = ["test","Home","Pesanan","Tagihan","Profil","Keluar"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadView(_ index: Int){
        //        icon.image = UIImage(named: image_arr[index])
        //        icon.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        //        icon.tintColor = UIColor.blue
        
        let origImage = UIImage(named: image_arr[index])
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        icon.image = tintedImage
        icon.tintColor = UIColor(red:0.01, green:0.61, blue:0.90, alpha:1.0)
        
        name.text = title_arr[index]
    }
    
}

