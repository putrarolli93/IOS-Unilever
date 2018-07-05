//
//  OrderInputInformCell.swift
//  unilever
//
//  Created by putra rolli on 02/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

internal protocol InputInformTextDelegate {
    func textField(_ String: String)
}

class OrderInputInformCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var inputInform: UITextField!
    var delegate: InputInformTextDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inputInform.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputInform.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        delegate.textField(textField.text!)
    }
}
