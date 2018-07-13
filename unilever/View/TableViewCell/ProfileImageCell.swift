//
//  ProfileImageCell.swift
//  unilever
//
//  Created by putra rolli on 10/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

internal protocol ProfileChangeImageDelegate {
    func changeImage()
}

class ProfileImageCell: UITableViewCell {

    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var profile_username: UILabel!
    @IBOutlet weak var change_image_btn: UIButton!
    var delegate: ProfileChangeImageDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageCircle()
    }
    func imageCircle() {
        profile_image.layer.borderWidth = 1
        profile_image.layer.masksToBounds = false
        profile_image.layer.borderColor = UIColor.black.cgColor
        profile_image.layer.cornerRadius = profile_image.frame.height/2
        profile_image.clipsToBounds = true
    }
    
    @IBAction func imageBtnDidClick(_ sender: Any) {
        delegate.changeImage()
    }
}
