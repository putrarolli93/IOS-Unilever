//
//  MyOrderCell.swift
//  unilever
//
//  Created by putra rolli on 21/06/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {
    
    @IBOutlet weak var order_total: UILabel!
    @IBOutlet weak var order_date: UILabel!
    @IBOutlet weak var invoice_id: UILabel!
    @IBOutlet weak var order_status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
