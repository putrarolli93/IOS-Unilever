//
//  OrderHeaderCell.swift
//  unilever
//
//  Created by putra rolli on 10/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class OrderHeaderCell: UITableViewCell {

    @IBOutlet weak var order_id: UILabel!
    @IBOutlet weak var order_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
