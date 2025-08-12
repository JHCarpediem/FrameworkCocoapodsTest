//
//  Date+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

@objc public extension NSDate {
    var shangHaiTimeString: String {
        let formatter = DateFormatter.shared
        formatter.timeZone = TimeZone(secondsFromGMT: 8 * 60 * 60)
        formatter.locale = Locale(identifier: "en_US") 
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let shangHai = formatter.string(from: self as Date)
        return shangHai
    }
}

public extension TDBasisWrap where Base == Date {
    /// Day name format.
    ///
    /// - threeLetters: 3 letter day abbreviation of day name.
    /// - oneLetter: 1 letter day abbreviation of day name.
    /// - full: Full day name.
    enum DayNameStyle {

        /// 3 letter day abbreviation of day name.
        case threeLetters

        /// 1 letter day abbreviation of day name.
        case oneLetter

        /// Full day name.
        case full

    }

    /// Month name format.
    ///
    /// - threeLetters: 3 letter month abbreviation of month name.
    /// - oneLetter: 1 letter month abbreviation of month name.
    /// - full: Full month name.
    enum MonthNameStyle {

        /// 3 letter month abbreviation of month name.
        case threeLetters

        /// 1 letter month abbreviation of month name.
        case oneLetter

        /// Full month name.
        case full

    }
    
    var shangHaiTime: String {
        return (base as NSDate).shangHaiTimeString
    }
    
    /// User’s current calendar.
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier) // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
    }
    /// Era.
    ///
    ///        Date().td.era -> 1
    ///
    var era: Int {
        return calendar.component(.era, from: base)
    }

    #if !os(Linux)
    /// Quarter.
    ///
    ///        Date().td.quarter -> 3 // date in third quarter of the year.
    ///
    var quarter: Int {
        let month = Double(calendar.component(.month, from: base))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(Darwin.ceil(month/numberOfMonthsInQuarter))
    }
    #endif

    /// Week of year.
    ///
    ///        Date().td.weekOfYear -> 2 // second week in the year.
    ///
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: base)
    }

    /// Week of month.
    ///
    ///        Date().td.weekOfMonth -> 3 // date is in third week of the month.
    ///
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: base)
    }

    /// Year.
    ///
    ///        Date().td.year -> 2017
    ///
    ///        var someDate = Date()
    ///        someDate.td.year = 2000 // sets someDate's year to 2000
    ///
    var year: Int {
        get {
            return calendar.component(.year, from: base)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: base)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: base) {
                base = date
            }
        }
    }

    /// Month.
    ///
    ///     Date().td.month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.td.month = 10 // sets someDate's month to 10.
    ///
    var month: Int {
        get {
            return calendar.component(.month, from: base)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: base)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = calendar.component(.month, from: base)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: base) {
                base = date
            }
        }
    }

    /// Day.
    ///
    ///     Date().td.day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.td.day = 1 // sets someDate's day of month to 1.
    ///
    var day: Int {
        get {
            return calendar.component(.day, from: base)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: base)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: base)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: base) {
                base = date
            }
        }
    }

    /// Weekday.
    ///
    ///     Date().td.weekday -> 5 // fifth day in the current week.
    ///
    var weekday: Int {
        return calendar.component(.weekday, from: base)
    }

    /// Hour.
    ///
    ///     Date().td.hour -> 17 // 5 pm
    ///
    ///     var someDate = Date()
    ///     someDate.td.hour = 13 // sets someDate's hour to 1 pm.
    ///
    var hour: Int {
        get {
            return calendar.component(.hour, from: base)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: base)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: base)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: base) {
                base = date
            }
        }
    }

    /// Minutes.
    ///
    ///     Date().td.minute -> 39
    ///
    ///     var someDate = Date()
    ///     someDate.td.minute = 10 // sets someDate's minutes to 10.
    ///
    var minute: Int {
        get {
            return calendar.component(.minute, from: base)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: base)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: base)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: base) {
                base = date
            }
        }
    }

    /// Seconds.
    ///
    ///     Date().second -> 55
    ///
    ///     var someDate = Date()
    ///     someDate.td.second = 15 // sets someDate's seconds to 15.
    ///
    var second: Int {
        get {
            return calendar.component(.second, from: base)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: base)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: base)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: base) {
                base = date
            }
        }
    }

    /// Nanoseconds.
    ///
    ///     Date().nanosecond -> 981379985
    ///
    ///     var someDate = Date()
    ///     someDate.td.nanosecond = 981379985 // sets someDate's seconds to 981379985.
    ///
    var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: base)
        }
        set {
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: base)!
            #endif
            guard allowedRange.contains(newValue) else { return }

            let currentNanoseconds = calendar.component(.nanosecond, from: base)
            let nanosecondsToAdd = newValue - currentNanoseconds

            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: base) {
                base = date
            }
        }
    }
    
    /// Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).td.isInFuture -> true
    ///
    var isInFuture: Bool {
        return base > Date()
    }

    /// Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).td.isInPast -> true
    ///
    var isInPast: Bool {
        return base < Date()
    }

    /// Check if date is within today.
    ///
    ///     Date().td.isInToday -> true
    ///
    var isInToday: Bool {
        return calendar.isDateInToday(base)
    }

    /// Check if date is within yesterday.
    ///
    ///     Date().td.isInYesterday -> false
    ///
    var isInYesterday: Bool {
        return calendar.isDateInYesterday(base)
    }

    /// Check if date is within tomorrow.
    ///
    ///     Date().td.isInTomorrow -> false
    ///
    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(base)
    }

    /// Check if date is within a weekend period.
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(base)
    }

    /// Check if date is within a weekday period.
    var isWorkday: Bool {
        return !calendar.isDateInWeekend(base)
    }

    /// Check if date is within the current week.
    var isInCurrentWeek: Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// Check if date is within the current month.
    var isInCurrentMonth: Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: .month)
    }

    /// Check if date is within the current year.
    var isInCurrentYear: Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: .year)
    }

    /// ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    ///
    ///     Date().td.iso8601String -> "2017-01-12T14:51:29.574Z"
    ///
    var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter.shared
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        return dateFormatter.string(from: base).appending("Z")
    }
    
    var utcString: String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: base)
    }
    
    
    /// Nearest five minutes to date.
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.td.minute = 32 // "5:32 PM"
    ///     date.td.nearestFiveMinutes // "5:30 PM"
    ///
    ///     date.td.minute = 44 // "5:44 PM"
    ///     date.td.nearestFiveMinutes // "5:45 PM"
    ///
    var nearestFiveMinutes: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: base)
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    /// Nearest ten minutes to date.
    ///
    ///     var date = Date() // "5:57 PM"
    ///     date.td.minute = 34 // "5:34 PM"
    ///     date.td.nearestTenMinutes // "5:30 PM"
    ///
    ///     date.td.minute = 48 // "5:48 PM"
    ///     date.td.nearestTenMinutes // "5:50 PM"
    ///
    var nearestTenMinutes: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: base)
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    /// Nearest quarter hour to date.
    ///
    ///     var date = Date() // "5:57 PM"
    ///     date.td.minute = 34 // "5:34 PM"
    ///     date.td.nearestQuarterHour // "5:30 PM"
    ///
    ///     date.td.minute = 40 // "5:40 PM"
    ///     date.td.nearestQuarterHour // "5:45 PM"
    ///
    var nearestQuarterHour: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: base)
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    /// Nearest half hour to date.
    ///
    ///     var date = Date() // "6:07 PM"
    ///     date.td.minute = 41 // "6:41 PM"
    ///     date.td.nearestHalfHour // "6:30 PM"
    ///
    ///     date.td.minute = 51 // "6:51 PM"
    ///     date.td.nearestHalfHour // "7:00 PM"
    ///
    var nearestHalfHour: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: base)
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }

    /// Nearest hour to date.
    ///
    ///     var date = Date() // "6:17 PM"
    ///     date.td.nearestHour // "6:00 PM"
    ///
    ///     date.td.minute = 36 // "6:36 PM"
    ///     date.td.nearestHour // "7:00 PM"
    ///
    var nearestHour: Date {
        let min = calendar.component(.minute, from: base)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = calendar.date(from: calendar.dateComponents(components, from: base))!

        if min < 30 {
            return date
        }
        return calendar.date(byAdding: .hour, value: 1, to: date)!
    }

    /// Yesterday date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let yesterday = date.td.yesterday // "Oct 2, 2018, 10:57:11"
    ///
    var yesterday: Date {
        return calendar.date(byAdding: .day, value: -1, to: base) ?? Date()
    }

    /// Tomorrow's date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let tomorrow = date.td.tomorrow // "Oct 4, 2018, 10:57:11"
    ///
    var tomorrow: Date {
        return calendar.date(byAdding: .day, value: 1, to: base) ?? Date()
    }

    /// UNIX timestamp from date.
    ///
    ///        Date().unixTimestamp -> 1484233862.826291
    ///
    var unixTimestamp: Double {
        return base.timeIntervalSince1970
    }
    
    /// Date by adding multiples of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.td.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.td.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.td.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.td.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: base)!
    }

    /// Add calendar component to date.
    ///
    ///     var date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     date.td.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     date.td.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     date.td.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     date.td.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenet to add.
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: base) {
            base = date
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    /// Date by changing value of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.td.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
    ///     let date3 = date.td.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
    ///     let date4 = date.td.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
    ///     let date5 = date.td.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date after changing given component to given value.
    func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: base)!
            #endif
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = calendar.component(.nanosecond, from: base)
            let nanosecondsToAdd = value - currentNanoseconds
            return calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: base)

        case .second:
            let allowedRange = calendar.range(of: .second, in: .minute, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentSeconds = calendar.component(.second, from: base)
            let secondsToAdd = value - currentSeconds
            return calendar.date(byAdding: .second, value: secondsToAdd, to: base)

        case .minute:
            let allowedRange = calendar.range(of: .minute, in: .hour, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentMinutes = calendar.component(.minute, from: base)
            let minutesToAdd = value - currentMinutes
            return calendar.date(byAdding: .minute, value: minutesToAdd, to: base)

        case .hour:
            let allowedRange = calendar.range(of: .hour, in: .day, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentHour = calendar.component(.hour, from: base)
            let hoursToAdd = value - currentHour
            return calendar.date(byAdding: .hour, value: hoursToAdd, to: base)

        case .day:
            let allowedRange = calendar.range(of: .day, in: .month, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentDay = calendar.component(.day, from: base)
            let daysToAdd = value - currentDay
            return calendar.date(byAdding: .day, value: daysToAdd, to: base)

        case .month:
            let allowedRange = calendar.range(of: .month, in: .year, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentMonth = calendar.component(.month, from: base)
            let monthsToAdd = value - currentMonth
            return calendar.date(byAdding: .month, value: monthsToAdd, to: base)

        case .year:
            guard value > 0 else { return nil }
            let currentYear = calendar.component(.year, from: base)
            let yearsToAdd = value - currentYear
            return calendar.date(byAdding: .year, value: yearsToAdd, to: base)

        default:
            return calendar.date(bySetting: component, value: value, of: base)
        }
    }
    #if !os(Linux)

    /// Data at the beginning of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:14 PM"
    ///     let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
    ///     let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
    ///     let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: base)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: base))
    }
    #endif

    /// Date at the end of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:27 PM"
    ///     let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
    ///     let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
    ///     let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
    ///
    /// - Parameter component: calendar component to get date at the end of.
    /// - Returns: date at the end of calendar component (if applicable).
    func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.td.add(.second, value: -1)
            return date

        case .minute:
            var date = adding(.minute, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.td.adding(.second, value: -1)
            return date

        case .hour:
            var date = adding(.hour, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.td.adding(.second, value: -1)
            return date

        case .day:
            var date = adding(.day, value: 1)
            date = calendar.startOfDay(for: date)
            date.td.add(.second, value: -1)
            return date

        case .weekOfYear, .weekOfMonth:
            var date = base
            let beginningOfWeek = calendar.date(from:
                calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.td.adding(.day, value: 7).td.adding(.second, value: -1)
            return date

        case .month:
            var date = adding(.month, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month], from: date))!
            date = after.td.adding(.second, value: -1)
            return date

        case .year:
            var date = adding(.year, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year], from: date))!
            date = after.td.adding(.second, value: -1)
            return date

        default:
            return nil
        }
    }

    /// Check if date is in current given calendar component.
    ///
    ///     Date().isInCurrent(.day) -> true
    ///     Date().isInCurrent(.year) -> true
    ///
    /// - Parameter component: calendar component to check.
    /// - Returns: true if date is in current given calendar component.
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        return calendar.isDate(base, equalTo: Date(), toGranularity: component)
    }
    
    /// Day name from date.
    ///
    ///     Date().dayName(ofStyle: .oneLetter) -> "T"
    ///     Date().dayName(ofStyle: .threeLetters) -> "Thu"
    ///     Date().dayName(ofStyle: .full) -> "Thursday"
    ///
    /// - Parameter Style: style of day name (default is DayNameStyle.full).
    /// - Returns: day name string (example: W, Wed, Wednesday).
    func dayName(ofStyle style: DayNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter.shared
        var format: String {
            switch style {
            case .oneLetter:
                return "EEEEE"
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: base)
    }

    /// Month name from date.
    ///
    ///     Date().monthName(ofStyle: .oneLetter) -> "J"
    ///     Date().monthName(ofStyle: .threeLetters) -> "Jan"
    ///     Date().monthName(ofStyle: .full) -> "January"
    ///
    /// - Parameter Style: style of month name (default is MonthNameStyle.full).
    /// - Returns: month name string (example: D, Dec, December).
    func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter.shared
        var format: String {
            switch style {
            case .oneLetter:
                return "MMMMM"
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: base)
    }
    
    /// Date string from date.
    ///
    ///     Date().td.string(withFormat: "dd/MM/yyyy") -> "1/12/17"
    ///     Date().td.string(withFormat: "HH:mm") -> "23:50"
    ///     Date().td.string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
    ///
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    func string(withFormat format: String = "dd/MM/yyyy HH:mm",
                local: Locale = Locale(identifier: "en_US"),
                timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = local
        return dateFormatter.string(from: base)
    }

    /// get number of seconds between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of seconds between self and given date.
    func secondsSince(_ date: Date) -> Double {
        return base.timeIntervalSince(date)
    }

    /// get number of minutes between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of minutes between self and given date.
    func minutesSince(_ date: Date) -> Double {
        return base.timeIntervalSince(date)/60
    }

    /// get number of hours between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of hours between self and given date.
    func hoursSince(_ date: Date) -> Double {
        return base.timeIntervalSince(date)/3600
    }

    /// get number of days between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of days between self and given date.
    func daysSince(_ date: Date) -> Double {
        return base.timeIntervalSince(date)/(3600*24)
    }

    /// check if a date is between two other dates
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false)
    /// - Returns: true if the date is between the two given dates.
    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(base).rawValue * base.compare(endDate).rawValue >= 0
        }
        return startDate.compare(base).rawValue * base.compare(endDate).rawValue > 0
    }

    /// check if a date is a number of date components of another date
    ///
    /// - Parameters:
    ///   - value: number of times component is used in creating range
    ///   - component: Calendar.Component to use.
    ///   - date: Date to compare self to.
    /// - Returns: true if the date is within a number of components of another date
    func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = calendar.dateComponents([component], from: base, to: date)
        let componentValue = components.value(for: component)!
        return Swift.abs(componentValue) <= value
    }
    
    /// 获取当前时间所在月份的 天数 （当前月有多少天）
    func numberOfDaysInMonth() -> Int {
        calendar.td.numberOfDaysInMonth(for: base)
    }
    
    /// UTC 时间 将本地时间转换成 UTC 时间 - 时区偏移量
    public var utcDate: Date {
        var localTimestamp = base.timeIntervalSince1970
        let secondsFromGMT = TimeZone.current.secondsFromGMT()
        localTimestamp = TimeInterval(Int(localTimestamp) - secondsFromGMT)
        return Date(timeIntervalSince1970: localTimestamp)
    }
    
    /// 本地时间 将 UTC 时间转换成本地时间 + 时区偏移量
    public var localDate: Date {
        var localTimestamp = base.timeIntervalSince1970
        let secondsFromGMT = TimeZone.current.secondsFromGMT()
        localTimestamp = TimeInterval(Int(localTimestamp) + secondsFromGMT)
        return Date(timeIntervalSince1970: localTimestamp)
    }
    
    /// 北京时间
    public var beijingDate: Date {
        let zone = TimeZone(secondsFromGMT: 8 * 60 * 60)!
        let interval = zone.secondsFromGMT(for: base)
        let bgDate = base.addingTimeInterval(TimeInterval(interval))
        return bgDate
    }
    
    /// 根据timeZone计算世界时间
    /// - Parameter timeZone: timeZone
    public func date(of timeZone: TimeZone) -> Date {
        let interVal = timeZone.secondsFromGMT(for: base)
        let date = base.addingTimeInterval(TimeInterval(interVal))
        return date
    }
    
    /// 获取时区 字符串
    public static var timeZone: String {
        let formatter = DateFormatter.shared
        if let identifier = Locale.preferredLanguages.first {
            formatter.locale = Locale.init(identifier: identifier)
        }
        let timeZone = TimeZone.current
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        let dateStr = formatter.string(from: Date())
        return dateStr.components(separatedBy: " ").last ?? "-0400"
    }
    
    /// 将 yyyyMMddHHmmss 格式字符串 转换成 yyyyMMdd 时间格式字符串
    public static func formatDateString(_ dateString: String) -> String {
        let inputFormat = "yyyyMMddHHmmss"
        let outputFormat = "yyyyMMdd"
        
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputFormat
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        }
        return ""
    }
}

extension TDBasisWrap where Base == HTTPURLResponse {
    /// 服务器时间
    public var serviceDate: Date {
        guard let serviceDateStr = base.allHeaderFields["Date"] as? String else {
            return Date()
        }
        let formatter = DateFormatter.shared
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"
        let serviceDate = formatter.date(from: serviceDateStr)
        return serviceDate ?? Date()
    }
}

extension Calendar: TDCompatibleValue {}
extension TDBasisWrap where Base == Calendar {
    /// 获取当前月有多有天
    func numberOfDaysInMonth(for date: Date) -> Int {
        return base.range(of: .day, in: .month, for: date)!.count
    }
}

extension DateFormatter {
    /// 获取 DateFormatter 单例对象
    /// 先从当前线程字典缓存中取， 取不到 创建一个 并加入当前线程缓存字典中。
    @objc public static var shared: DateFormatter {
        let threadHash = "DateFormatter_" + "\(Thread.current.hash)"
        if let existingFormatter = Thread.current.threadDictionary[threadHash] as? DateFormatter {
            return existingFormatter
        }else{
            let dateFormatter = DateFormatter()
            Thread.current.threadDictionary[threadHash] = dateFormatter
            return dateFormatter
        }
    }
}
