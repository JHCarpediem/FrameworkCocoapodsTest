//
//  ThemeColorPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2017/1/28.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import UIKit

@objc public final class ThemeColorPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.color(for: keyPath) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIColor?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(colors: String...) {
        self.init(v: { ThemeManager.colorElement(for: colors) })
    }
    
    public convenience init(colors: UIColor...) {
        self.init(v: { ThemeManager.element(for: colors) })
    }
    
    public required convenience init(arrayLiteral elements: String...) {
        self.init(v: { ThemeManager.colorElement(for: elements) })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(keyPath: value)
    }
    
}

@objc public extension ThemeColorPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath)
    }
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIColor?) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithColors(_ colors: [String]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { ThemeManager.colorElement(for: colors) })
    }
    
    class func pickerWithUIColors(_ colors: [UIColor]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { ThemeManager.element(for: colors) })
    }
    
    var cgColor: ThemeCGColorPicker {
        return ThemeCGColorPicker(colorPick: self)
    }
    
    func withAlphaComponent(_ alpha: CGFloat) -> ThemeColorPicker {
        return ThemeColorPicker {
            guard let color = self.color else {
                return nil
            }
            return color.withAlphaComponent(alpha)
        }
    }
}

@objc public extension ThemeColorPicker {
    @objc public var color: UIColor? {
        self.value() as? UIColor
    }
}

extension ThemeColorPicker: ExpressibleByArrayLiteral {}
extension ThemeColorPicker: ExpressibleByStringLiteral {}

@objc public extension ThemeColorPicker {
    @objc public static var clear: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.clear })
    }
    
    @objc public static var white: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.white })
    }
    
    @objc public static var black: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.black })
    }
    
    @objc public static var blue: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.blue })
    }
    
    @objc public static var systemPink: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.systemPink })
    }
    
    @objc public static var red: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.red })
    }
    
    @objc public static var yellow: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.yellow })
    }
    
    @objc public static var green: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.green })
    }
    
    @objc public static var gray: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.gray })
    }
    
    @objc public static var lightGray: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.lightGray })
    }
    
    @objc public static var darkGray: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.darkGray })
    }
    
    @objc public static var orange: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.orange })
    }
    
    @objc public static var purple: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.purple })
    }
    
    @objc public static var cyan: ThemeColorPicker {
        ThemeColorPicker(v: { UIColor.cyan })
    }
}
