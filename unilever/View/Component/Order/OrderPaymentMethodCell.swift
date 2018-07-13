//
//  OrderPaymentMethodCell.swift
//  unilever
//
//  Created by putra rolli on 02/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import UIKit

internal protocol ProsesPaymentDelegate {
    func prosesDidclick(_ string: String)
}

class OrderPaymentMethodCell: UITableViewCell,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var btnProses: UIButton!
    @IBOutlet weak var inputPaymentInform: UITextField!
    var title = ["Bayar Ditempat", "Giro", "Bank Transfer", "Kartu Kredit", "Pembayaran Tunai"]
    let titlePickerView = UIPickerView()
    var delegate: ProsesPaymentDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnProses.isEnabled = false
        btnProses.backgroundColor = UIColor.lightGray
        // Initialization code
        titlePickerView.delegate = self
        titlePickerView.tag = 1
        inputPaymentInform.inputView = titlePickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(donePicker))
        
        toolBar.setItems([flexible,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        inputPaymentInform.inputView = titlePickerView
        inputPaymentInform.inputAccessoryView = toolBar
        customTextField()
    }
    
    func loadData(){
        
    }
    
    func customTextField(){
        
    }
    
    func donePicker() {
        if inputPaymentInform.text == nil {
            btnProses.isEnabled = false
            btnProses.backgroundColor = UIColor.lightGray
        }else{
            btnProses.isEnabled = true
            btnProses.backgroundColor = UIColor.blue
        }
        inputPaymentInform.resignFirstResponder()
        if title.count == 1 {
            inputPaymentInform.text = "Bayar Ditempat"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            
            return title.count
            
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            
            return title[row]
            
        }
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            
            inputPaymentInform.text = title[row]
            
        }
    }
    
    @IBAction func btnProsesDidClick(_ sender: Any) {
        delegate.prosesDidclick(inputPaymentInform.text!)
    }
    
    
}

