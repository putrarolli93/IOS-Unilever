//
//  BannerCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class BannerCell: UITableViewCell {

    var bannerUrl: String = "\(BaseUrl.baseUrl)commerce/production/uploads/"
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func loadView(_ data: BannerModel) {
        let updateUrl = bannerUrl + data.data.promo[0].promo_image
        bannerImage.sd_setImage(with: URL(string: updateUrl), placeholderImage: UIImage(named: "placeholder.png"))
    }

}
