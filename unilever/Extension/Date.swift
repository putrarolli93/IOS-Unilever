//
//  Date.swift
//  unilever
//
//  Created by putra rolli on 16/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let newDate = dateFormatter.string(from: self)
        print(newDate)
        return newDate
    }
}
