//
//  Date+Extensions.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 26.01.2025.
//

import Foundation

extension Date {
    init(milisecondsSince1970: Int) {
        self = Date(timeIntervalSince1970: Double(milisecondsSince1970) / 1000)
    }
    
    func toString(withFormat format: DateFormates) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
        return dateFormatter.string(from: self)
    }
}
