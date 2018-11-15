//
//  BrandsCollectionViewCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var brand_image: UIImageView!
    var product: ProductModel!
    var brand: ProductBrandModel!
    var image = ["sunsilk.jpg","ponds.jpg","dove.jpg","switzal.jpg","rexona.jpg","vaseline.jpg","sunsilk.jpg","ponds.jpg","dove.jpg","switzal.jpg","rexona.jpg","vaseline.jpg","sunsilk.jpg","ponds.jpg","dove.jpg","switzal.jpg","rexona.jpg","vaseline.jpg","sunsilk.jpg","ponds.jpg","dove.jpg","switzal.jpg","rexona.jpg","vaseline.jpg"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadView(_ index: Int){
//        brand_image.image = UIImage(named: "\(product.data[index].product_photo_link)")
        let string_image = "\(BaseUrl.baseUrl)commerce/production/uploads/\(brand.data[index].brand_image)"
        let updatedUrl = string_image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        brand_image.sd_setImage(with: URL(string: updatedUrl!), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
}
