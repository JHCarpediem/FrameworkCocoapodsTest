//
//  UIColor+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

/**
 MissingHashMarkAsPrefix:   "Invalid RGB string, missing '#' as prefix"
 UnableToScanHexValue:      "Scan hex error"
 MismatchedHexStringLength: "Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8"
 */
public enum UIColorInputError : Error {
    case missingHashMarkAsPrefix,
    unableToScanHexValue,
    mismatchedHexStringLength
}

extension TDBasisWrap where Base: UIColor {
    
    
    /// 创建一个渐变色
    /// - Parameters:
    ///   - colors: 渐变色的颜色数组
    ///   - size: 渐变的大小
    ///   - style: 渐变类型
    /// - Returns: 渐变的颜色
    public static func gradient(colors: [UIColor], size: CGSize, style: GradientStyle = .leftToRight) -> UIColor {
        return gradient(colors: colors, size: size, style: style, baseColor: nil)
    }
    
    public static func gradient(colors: [UIColor], size: CGSize, style: GradientStyle = .leftToRight, baseColor: UIColor?) -> UIColor {
        guard let image = UIImage.td.gradient(colors: colors, size: size, style: style, baseColor: baseColor) else {
            return colors.first ?? .clear
        }
        
        return UIColor(patternImage: image)
    }
    
    public static func gradient(colors: [UIColor], size: CGSize, startPoint: CGPoint, endPoint: CGPoint, locations: UnsafePointer<CGFloat>?) -> UIColor {
        guard let image = UIImage.td.gradient(colors: colors, size: size, startPoint: startPoint, endPoint: endPoint, locations: locations) else {
            return colors.first ?? .clear
        }
        
        return UIColor(patternImage: image)
    }
    
    /// 通过 16进制数值方式创建颜色
    /// eg: `UIColor.td.color(with: 0xFFFFFF)`
    public static func color(with hex: Int) -> UIColor? {
        let hexStr = "#" + hex.td.hexString
        return UIColor.td_color(hexString: hexStr)
    }
    
    /// 通过16进制字符串方式创建颜色
    /// eg: `UIColor.td.color(with: "#FFFFFF")`
    /// eg: `UIColor.td.color(with: "0xFFFFFF")`
    public static func color(with hexString: String) -> UIColor? {
        UIColor.td_color(hexString: hexString)
    }
    
    public static func color(hex8: UInt32) -> UIColor {
        UIColor.td_color(hex8: hex8)
    }
    
    public static func color(hex6: UInt32, alpha: CGFloat = 1) -> UIColor {
        UIColor.td_color(hex6: hex6, alpha: alpha)
    }
    
    public static func color(hex4: UInt16) -> UIColor {
        UIColor.td_color(hex4: hex4)
    }
    
    public static func color(hex3: UInt16, alpha: CGFloat = 1) -> UIColor {
        UIColor.td_color(hex3: hex3, alpha: alpha)
    }
    
    
    
    /// 获取颜色的Int值
    public var intValue: Int {
        base.td_IntValue
    }
    
    /// 获取颜色的16进制字符串
    /// 格式： `#FFFFFF`
    public var hexString: String {
        base.td_HexString
    }
}

@objc public extension UIColor {
    
    @objc(td_gradientWithColors:size:style:)
    public static func td_gradient(colors: [UIColor], size: CGSize, style: GradientStyle = .leftToRight) -> UIColor {
        td.gradient(colors: colors, size: size, style: style)
    }
    
    @objc public var td_IntValue: Int {
        let comps: [CGFloat] = {
            let comps = cgColor.components!
            return comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
        }()

        var colorAsUInt32: UInt32 = 0
        colorAsUInt32 += UInt32(comps[0] * 255.0) << 16
        colorAsUInt32 += UInt32(comps[1] * 255.0) << 8
        colorAsUInt32 += UInt32(comps[2] * 255.0)

        return Int(colorAsUInt32)
    }
    
    @objc public var td_HexString: String {
        let components: [Int] = {
            let comps = cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    public static func td_color(hexString: String, defaultColor: UIColor = .clear) -> UIColor {
        guard let color = try? td_clolor(rgba_throws: hexString) else {
            return defaultColor
        }
        return color
    }
    
    public static func td_clolor(rgba_throws rgba: String) throws -> UIColor {
        guard rgba.hasPrefix("#") || rgba.hasPrefix("0x") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        
        var hexString: String
        if rgba.hasPrefix("#") {
            hexString = String(rgba[rgba.index(rgba.startIndex, offsetBy: 1)...])
        } else{
            hexString = String(rgba[rgba.index(rgba.startIndex, offsetBy: 2)...])
        }
        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        let color: UIColor
        switch (hexString.count) {
        case 3:
            color = td_color(hex3: UInt16(hexValue))
        case 4:
            color = td_color(hex4: UInt16(hexValue))
        case 6:
            color = td_color(hex6: hexValue)
        case 8:
            color = td_color(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
        return color
    }
    
    public static func td_color(hex3: UInt16, alpha: CGFloat = 1) -> UIColor {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor

        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func td_color(hex4: UInt16) -> UIColor {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor

        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func td_color(hex6: UInt32, alpha: CGFloat = 1) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor

        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func td_color(hex8: UInt32) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor

        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

