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
    @IBOutlet weak var limit_payment: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var payment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
