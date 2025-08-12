//
//  Comparable+TDExtension.swift
//  TDBasis
//
//  Created by fench on 2023/7/29.
//

import UIKit


public extension TDBasisWrap where Base: Comparable {
    /// Returns true if value is in the provided range.
    ///
    ///    1.td.isBetween(5...7) // false
    ///    7.td.isBetween(6...12) // true
    ///    date.isBetween(date1...date2)
    ///    "c".isBetween(a...d) // true
    ///    0.32.isBetween(0.31...0.33) // true
    ///
    /// - parameter min: Minimum comparable value.
    /// - parameter max: Maximum comparable value.
    ///
    /// - returns: `true` if value is between `min` and `max`, `false` otherwise.
    func isBetween(_ range: ClosedRange<Base>) -> Bool {
        return range ~= base
    }

    ///  Returns value limited within the provided range.
    ///
    ///     1.td.clamped(to: 3...8) // 3
    ///     4.td..clamped(to: 3...7) // 4
    ///     "c".td.clamped(to: "e"..."g") // "e"
    ///     0.32.td.clamped(to: 0.1...0.29) // 0.29
    ///
    /// - parameter min: Lower bound to limit the value to.
    /// - parameter max: Upper bound to limit the value to.
    ///
    /// - returns: A value limited to the range between `min` and `max`.
    func clamped(to range: ClosedRange<Base>) -> Base {
        return max(range.lowerBound, min(base, range.upperBound))
    }
}
