//
//  ProfileBottomCell.swift
//  unilever
//
//  Created by putra rolli on 11/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

internal protocol ProfileBottomDelegate {
    func profileBottomDidClick(_ text: String)
}

class ProfileBottomCell: UITableViewCell {

    @IBOutlet weak var imageBottom: UIImageView!
    @IBOutlet weak var labelBottom: UILabel!
    
    var delegate: ProfileBottomDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func btnBottomDidClick(_ sender: Any) {
       
    }
}
