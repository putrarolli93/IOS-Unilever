//
//  BrandCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

internal protocol BrandSelectDelegate {
    func brandSelected(_ brand_id: String)
}

class BrandCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collLeft: NSLayoutConstraint!
    @IBOutlet weak var collWidth: NSLayoutConstraint!
    @IBOutlet weak var collHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionCell: UICollectionView!
    let screenSize = UIScreen.main.bounds
    var product: ProductModel!
    var brand: ProductBrandModel!
    var delegate: BrandSelectDelegate!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        let screenWidth = screenSize.width
        //        let sheight = screenSize.height
        self.collWidth.constant = screenWidth
        self.collHeight.constant = (screenWidth / 3 - 25) * 4 + 50
        self.collLeft.constant = 20
        
        // Do any additional setup after loading the view, typically from a nib
        //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0.0
        //        layout.sectionInset = UIEdgeInsets(top: 0 , left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: screenWidth / 3 - 20, height: screenWidth / 3 - 25)
        //        collectionCell = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionCell.delegate = self
        collectionCell.dataSource = self
        collectionCell.isScrollEnabled = false
        collectionCell.collectionViewLayout = layout
        collectionCell.frame.size.width = self.frame.size.width
        collectionCell.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let nib = UINib(nibName: "BrandsCollectionViewCell", bundle: nil)
        collectionCell.register(nib, forCellWithReuseIdentifier: "brands")
        //        collectionCell.register(BrandsCollectionViewCell.self, forCellWithReuseIdentifier: "brands")
        //        collectionCell.backgroundColor = UIColor.yellow
        
        self.addSubview(collectionCell)
    }
    
    func loadView(){
        self.collHeight.constant = (screenSize.width / 3 - 25) * CGFloat(HomeVC.RowCountProduct) + 50
        HomeVC.ProductHeight = Int(self.collHeight.constant)
        collectionCell.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.brandSelected(self.brand.data[indexPath.row].brand_id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.brand != nil {
            return self.brand.data.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brands", for: indexPath) as! BrandsCollectionViewCell
        if self.brand != nil {
            cell.brand = self.brand
            cell.loadView(indexPath.row)
        }
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 0.9
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 0.9
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    
    
    
}
