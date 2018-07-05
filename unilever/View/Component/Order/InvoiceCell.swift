//
//  InvoiceCell.swift
//  unilever
//
//  Created by putra rolli on 10/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class InvoiceCell: UITableViewCell {

    @IBOutlet weak var order_id: UILabel!
    @IBOutlet weak var order_date: UILabel!
    @IBOutlet weak var invoice_id: UILabel!
    @IBOutlet weak var order_status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
