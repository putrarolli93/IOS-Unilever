//
//  SpecialCollectionViewCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class SpecialCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var special_image: UIImageView!
    
    var image = ["diskon.jpg","beli2.jpg","by1.jpg","diskon.jpg"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadView(_ index: Int){
        special_image.image = UIImage(named: "\(image[index])")
    }
}
