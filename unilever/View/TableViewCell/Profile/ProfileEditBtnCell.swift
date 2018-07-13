//
//  ProfileEditBtnCell.swift
//  unilever
//
//  Created by putra rolli on 10/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

internal protocol profileEditBtnDelegate {
    func profileEditBtn()
}

class ProfileEditBtnCell: UITableViewCell {

    var delegate: profileEditBtnDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func profileEditBtnDidClick(_ sender: Any) {
        self.delegate.profileEditBtn()
    }
}
