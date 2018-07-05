//
//  HeaderCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet weak var store_name: UILabel!
    @IBOutlet weak var info_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        user_image.layer.borderWidth = 1
        user_image.layer.masksToBounds = false
        user_image.layer.borderColor = UIColor.black.cgColor
        user_image.layer.cornerRadius = user_image.frame.height/2
        user_image.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
