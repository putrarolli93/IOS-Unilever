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
        addDoneButtonOnKeyboard()
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        inputInform.resignFirstResponder()
//        return true
//    }
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        delegate.textField(textField.text!)
//    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0,y: 0,width: 320,height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(EditProfileVC.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.inputInform.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.inputInform.resignFirstResponder()
        
    }
}
