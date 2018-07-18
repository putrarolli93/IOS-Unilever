//
//  String.swift
//  unilever
//
//  Created by putra rolli on 16/07/18.
//  Copyright © 2018 putra. All rights reserved.
//

import Foundation

extension String {
    
    func stringTodateWithTime() -> String {
//        let dateString = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: self)
        return (date?.dateToString())!
    }
    
    func stringTodate() -> String {
//        let dateString = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: self)
        return (date?.dateToString())!
    }
}
