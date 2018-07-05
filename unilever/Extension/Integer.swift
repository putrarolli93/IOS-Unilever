//
//  Integer.swift
//  unilever
//
//  Created by putra rolli on 04/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation

extension Int {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}
