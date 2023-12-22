//
//  Date+Ext.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import Foundation

extension Date {
    func timeInMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
    
    func format(_ format: DateFormatter.Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

extension Int64 {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self ))
    }
}
