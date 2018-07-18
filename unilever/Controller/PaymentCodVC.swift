//
//  PaymentCodVC.swift
//  unilever
//
//  Created by putra rolli on 15/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

class PaymentCodVC: UIViewController {

    @IBOutlet weak var thanks_label: UILabel!
    var thanks_lbl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.thanks_label.text = thanks_lbl
    }
    
    @IBAction func selesaiDidClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func popViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PaymentCodVC {
    func setupNavigation() {
        navigationController?.defaultStyle()
        title = "Pembayaran Selesai"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic_backBtn"), style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
