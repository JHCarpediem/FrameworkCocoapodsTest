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

public extension BinaryInteger {

    func clampedToInt8() -> Int8 {
        return Self.clamp(self, to: Int8.min, Int8.max)
    }

    func clampedToUInt8() -> UInt8 {
        return Self.clamp(self, to: UInt8.min, UInt8.max)
    }

    func clampedToInt16() -> Int16 {
        return Self.clamp(self, to: Int16.min, Int16.max)
    }

    func clampedToUInt16() -> UInt16 {
        return Self.clamp(self, to: UInt16.min, UInt16.max)
    }

    func clampedToInt32() -> Int32 {
        return Self.clamp(self, to: Int32.min, Int32.max)
    }

    func clampedToUInt32() -> UInt32 {
        return Self.clamp(self, to: UInt32.min, UInt32.max)
    }

    func clampedToInt64() -> Int64 {
        return Self.clamp(self, to: Int64.min, Int64.max)
    }

    func clampedToUInt64() -> UInt64 {
        return Self.clamp(self, to: UInt64.min, UInt64.max)
    }

    // 通用静态辅助方法
    private static func clamp<T: FixedWidthInteger>(_ value: Self, to minValue: T, _ maxValue: T) -> T {
        // 使用有符号或无符号类型安全比较
        if T.isSigned {
            let v = Int64(clamping: Int64(truncatingIfNeeded: value))
            let minV = Int64(truncatingIfNeeded: minValue)
            let maxV = Int64(truncatingIfNeeded: maxValue)
            if v < minV { return minValue }
            if v > maxV { return maxValue }
        } else {
            let v = UInt64(truncatingIfNeeded: value)
            let minV = UInt64(truncatingIfNeeded: minValue)
            let maxV = UInt64(truncatingIfNeeded: maxValue)
            if v < minV { return minValue }
            if v > maxV { return maxValue }
        }
        return T(truncatingIfNeeded: value)
    }
}

public extension BinaryInteger {
    
    func toInt8() -> Int8? {
        return Int8(exactly: self)
    }

    func toUInt8() -> UInt8? {
        return UInt8(exactly: self)
    }

    func toInt16() -> Int16? {
        return Int16(exactly: self)
    }

    func toUInt16() -> UInt16? {
        return UInt16(exactly: self)
    }

    func toInt32() -> Int32? {
        return Int32(exactly: self)
    }

    func toUInt32() -> UInt32? {
        return UInt32(exactly: self)
    }

    func toInt64() -> Int64? {
        return Int64(exactly: self)
    }

    func toUInt64() -> UInt64? {
        return UInt64(exactly: self)
    }
}
