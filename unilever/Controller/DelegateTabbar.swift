//
//  DelegateTabbar.swift
//  unilever
//
//  Created by putra rolli on 08/05/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class DelegateTabbar: UIViewController {
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismisView()
    }
    
    func dismisView() {
        HomeVC.selectedIndex = self.index
        dismiss(animated: true, completion: nil)
    }
}
