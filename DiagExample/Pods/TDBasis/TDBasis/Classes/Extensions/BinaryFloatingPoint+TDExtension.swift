//
//  BinaryFloatingPoint+TDExtension.swift
//  TDBasis
//
//  Created by fench on 2023/7/29.
//

import UIKit

public extension BinaryInteger {
    var spaceFormatString: String { Double(self).spaceFormatString }
}

public extension BinaryFloatingPoint {
    
    /// Returns a rounded value with the specified number of decimal places and rounding rule. If `decimalPlaces` is negative, `0` will be used.
    ///
    ///     let num = 3.1415927
    ///     num.rounded(decimalPlaces: 3, rule: .up) -> 3.142
    ///     num.rounded(decimalPlaces: 3, rule: .down) -> 3.141
    ///     num.rounded(decimalPlaces: 2, rule: .awayFromZero) -> 3.15
    ///     num.rounded(decimalPlaces: 4, rule: .towardZero) -> 3.1415
    ///     num.rounded(decimalPlaces: -1, rule: .toNearestOrEven) -> 3
    ///
    /// - Parameters:
    ///   - decimalPlaces: The expected number of decimal places.
    ///   - rule: The rounding rule to use.
    /// - Returns: The rounded value.
    func rounded(decimalPlaces: Int = 0, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        let factor = Self(pow(10.0, Double(max(0, decimalPlaces))))
        return (self * factor).rounded(rule) / factor
    }
    
    
    /// 数字转字符串 保留小数位
    /// - Parameters:
    ///   - decimalPlace: 保留几位小数
    ///   - rule: Rounding 规则  默认四舍五入
    /// - Returns: 保留位数的字符串
    func string(decimalPlace: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> String {
        String(format: "%.0\(decimalPlace)f", Double(rounded(decimalPlaces: decimalPlace, rule: rule)))
    }
    
    
    /// 向上取整 数字转换字符串
    /// - Parameter count: 保留小数位数
    /// - Returns: 数字字符串
    func ceilString(retain count: Int) -> String {
        string(decimalPlace: count, rule: .awayFromZero)
    }
    
    /// 向下取整 数字转换字符串
    /// - Parameter count: 保留小数位数
    /// - Returns: 数字字符串
    func floorString(retain count: Int) -> String {
        string(decimalPlace: count, rule: .towardZero)
    }
    
    /// 四舍五入 数字转换字符串
    /// - Parameter count: 保留小数位数
    /// - Returns: 数字字符串
    func roundString(retain count: Int) -> String {
        string(decimalPlace: count)
    }
    
    /// 四舍五入 数字转换字符串
    /// - Parameter count: 保留小数位数
    /// - Returns: 数字字符串
    func string(retain count: Int) -> String {
        roundString(retain: count)
    }
    
    /// 度数 --> 弧度制
    /// `let degree = 180.0`
    /// `degree.degreesToRadians == 3.1415926...`
    var degreesToRadians: CGFloat {
        return .pi * CGFloat(self) / 180.0
    }

    /// 弧度 --> 度数
    /// `let radians = CGFloat.pi`
    /// `radians.radiansToDegrees == 180°`
    var radiansToDegrees: CGFloat {
        return CGFloat(self) * 180.0 / CGFloat.pi
    }
    
    /// 空间格式化  1000，000  -->  1MB
    var spaceFormatString: String {
        let value = CGFloat(self)
        
        if value >= pow(10, 9) {
            return String(format: "%.2fGB", value / pow(10, 9))
        } else if value >= pow(10, 6) {
            return String(format: "%.2fMB", value / pow(10, 6))
        } else if value >= pow(10, 3) {
            return String(format: "%.2fKB", value / pow(10, 3))
        } else {
            return String(format: "%dB", Int(value))
        }
    }
    
    var decimalFormatString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: CGFloat(self))) ?? "\(self)"
    }
}

public extension BinaryInteger {
    var decimalFormatString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: Int(self))) ?? "\(self)"
    }
}

extension CGFloat: TDCompatibleValue {}
public extension TDBasisWrap where Base == CGFloat {
    /// Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(base)
    }

    #if canImport(Foundation)
    /// 向上取整
    var ceil: CGFloat {
        return Foundation.ceil(base)
    }
    #endif

    /// 度数 --> 弧度制
    /// `let degree = 180.0`
    /// `degree.degreesToRadians == 3.1415926...`
    var degreesToRadians: CGFloat {
        return .pi * base / 180.0
    }

    /// 弧度 --> 度数
    /// `let radians = CGFloat.pi`
    /// `radians.radiansToDegrees == 180°`
    var radiansToDegrees: CGFloat {
        return base * 180 / CGFloat.pi
    }
    #if canImport(Foundation)
    /// 向下取整
    var floor: CGFloat {
        return Foundation.floor(base)
    }
    #endif

    /// 是否为正数
    var isPositive: Bool {
        return base > 0
    }

    /// 是否为负数
    var isNegative: Bool {
        return base < 0
    }

    /// Int.
    var int: Int {
        return Int(base)
    }

    /// Float.
    var float: Float {
        return Float(base)
    }

    /// Double.
    var double: Double {
        return Double(base)
    }
}

extension Double: TDCompatibleValue {}
public extension TDBasisWrap where Base == Double {
    /// SwifterSwift: Int.
    var int: Int {
        return Int(base)
    }

    /// SwifterSwift: Float.
    var float: Float {
        return Float(base)
    }

    #if canImport(CoreGraphics)
    /// SwifterSwift: CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(base)
    }
    #endif
}

extension Int: TDCompatibleValue {}
public extension TDBasisWrap where Base == Int {
    /// SwifterSwift: CountableRange 0..<Int.
    var countableRange: CountableRange<Int> {
        return 0..<base
    }

    /// SwifterSwift: Radian value of degree input.
    var degreesToRadians: Double {
        return Double.pi * Double(base) / 180.0
    }

    /// SwifterSwift: Degree value of radian input
    var radiansToDegrees: Double {
        return Double(base) * 180 / Double.pi
    }

    /// SwifterSwift: UInt.
    var uInt: UInt {
        return UInt(base)
    }

    /// SwifterSwift: Double.
    var double: Double {
        return Double(base)
    }

    /// SwifterSwift: Float.
    var float: Float {
        return Float(base)
    }

    #if canImport(CoreGraphics)
    /// SwifterSwift: CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(base)
    }
    #endif
    
    var hexString: String {
        String(format: "%02x", base)
    }
}

extension BinaryFloatingPoint {
    /// 平板水平方向缩放比
    public var hdHorizontalScale: Self { self * Self(UI.HD.horizontalScale) }
    /// 平板竖直方向缩放比
    public var hdVerticalScale: Self { self * Self(UI.HD.verticalScale) }
}

extension BinaryInteger {
    /// 平板水平方向缩放比
    public var hdHorizontalScale: Self { self * Self(UI.HD.horizontalScale) }
    /// 平板竖直方向缩放比
    public var hdVerticalScale: Self { self * Self(UI.HD.verticalScale) }
}
