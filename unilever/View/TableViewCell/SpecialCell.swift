//
//  SpecialCell.swift
//  unilever
//
//  Created by Programmer5 on 5/7/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class SpecialCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var specialCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let sheight = screenSize.height
        specialCell.frame.size.width = screenWidth
        self.frame.size.width = screenWidth
        self.frame.size.height = sheight
        // Do any additional setup after loading the view, typically from a nib
        //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0.0
        //        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3 - 30)
        specialCell.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        collectionCell = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        specialCell.delegate = self
        specialCell.dataSource = self
        //        specialCell.isScrollEnabled = false
        specialCell.collectionViewLayout = layout
        specialCell.frame.size.width = self.frame.size.width
        let nib = UINib(nibName: "SpecialCollectionViewCell", bundle: nil)
        specialCell.register(nib, forCellWithReuseIdentifier: "special")
        //        collectionCell.register(BrandsCollectionViewCell.self, forCellWithReuseIdentifier: "brands")
        //        collectionCell.backgroundColor = UIColor.yellow
        
        self.addSubview(specialCell)
    }
    
    func loadView(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "special", for: indexPath) as! SpecialCollectionViewCell
        cell.loadView(indexPath.row)
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 0.9
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 0.9
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    
}
