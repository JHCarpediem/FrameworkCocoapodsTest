//
//  Date+Extension.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/22.
//

import Foundation

extension Date {
    
    static func current() -> Date {
        return Date()
    }
    
    var millionSeconds: TimeInterval {
        return Self.current().timeIntervalSince1970 * 1000.0
    }
    
    /// 默认是 zipName 时间格式-yyyyMMddHHmmss
    func string(withFormat format: String = TopdonDateFormat.kZipName,
                local: Locale = Locale(identifier: "en_US_POSIX"),
                timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = local
        return dateFormatter.string(from: self)
    }
    
    func string(withFormatter formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    mutating func add(_ component: Calendar.Component, value: Int) {
        let calendar = Calendar.current
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
    
}

// MARK: - millisecond

extension TimeInterval {
    
    func isMillisecondTimestamp() -> Bool {
        let timestampString = String(format: "%.0f", self)
        return timestampString.count > 10
    }
    
    var millisecondDate: Date? {
        guard isMillisecondTimestamp() else { return nil }
        
        let timestamp: TimeInterval = self / 1000.0
        return Date(timeIntervalSince1970: timestamp)
    }
    
}

// MARK: - Other Extension

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
