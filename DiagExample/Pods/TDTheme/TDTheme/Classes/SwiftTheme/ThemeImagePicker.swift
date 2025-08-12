//
//  ThemeImagePicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2017/1/28.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import UIKit
import TDBasis

@objc public final class ThemeImagePicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.image(for: keyPath) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIImage?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(names: String...) {
        self.init(v: { ThemeManager.imageElement(for: names) })
    }
    
    public convenience init(images: UIImage...) {
        self.init(v: { ThemeManager.element(for: images) })
    }
    
    public required convenience init(arrayLiteral elements: String...) {
        self.init(v: { ThemeManager.imageElement(for: elements) })
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

@objc public extension ThemeImagePicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeImagePicker {
        return ThemeImagePicker(keyPath: keyPath)
    }
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIImage?) -> ThemeImagePicker {
        return ThemeImagePicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithNames(_ names: [String]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { ThemeManager.imageElement(for: names) })
    }
    
    class func pickerWithImages(_ images: [UIImage]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { ThemeManager.element(for: images) })
    }
    
    var image: UIImage? {
        return value() as? UIImage
    }
    
    func rotated(by radians: CGFloat) -> ThemeImagePicker {
        guard let image = image else {
            return ThemeImagePicker(v: { UIImage() })
        }
        return ThemeImagePicker(v: { image.td.rotated(by: radians)})
    }
    
    func image(byTintColor color: UIColor?) -> ThemeImagePicker {
        guard let image = image else {
            return ThemeImagePicker(v: { UIImage() })
        }
        guard let color = color else {
            return ThemeImagePicker(v: { image })
        }
        return ThemeImagePicker(v: { image.td.image(byTintColor: color) })
    }
    
    @objc(imageByThemeTintColor:)
    func image(byTintColor color: ThemeColorPicker?) -> ThemeImagePicker {
        guard let image = image else {
            return ThemeImagePicker(v: { UIImage() })
        }
        guard let color = color?.color else {
            return ThemeImagePicker(v: { image })
        }
        return ThemeImagePicker(v: { image.td.image(byTintColor: color) })
    }
    
    func cropped(to rect: CGRect) -> ThemeImagePicker {
        guard let image = image else {
            return ThemeImagePicker(v: { nil })
        }
        return ThemeImagePicker(v: { image.td.cropped(to: rect) })
    }
    
    func image(byResize toSize: CGSize) -> ThemeImagePicker {
        guard let image = image else {
            return ThemeImagePicker(v: { nil })
        }
        
        return ThemeImagePicker(v: { image.td.image(byResize: toSize) })
    }
    
    func resizeableImage(withCapInsets: UIEdgeInsets, resizingMode: UIImage.ResizingMode = .stretch) -> ThemeImagePicker {
        guard let image = image else {
            return ThemeImagePicker(v: { nil })
        }
        
        return ThemeImagePicker(v: { image.resizableImage(withCapInsets: withCapInsets, resizingMode: resizingMode) })
    }
    
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> ThemeImagePicker? {
        guard let image = image?.td.scaled(toHeight: toHeight, opaque: opaque) else { return nil }
        return ThemeImagePicker(v: { image })
    }

    func scaled(toWidth: CGFloat, opaque: Bool = false) -> ThemeImagePicker? {
        guard let image = image?.td.scaled(toWidth: toWidth, opaque: opaque) else { return nil }
        return ThemeImagePicker(v: { image })
    }
    
    func withRoundedCorners(radius: CGFloat = 0) -> ThemeImagePicker? {
        guard let image = image?.td.withRoundedCorners(radius: radius) else { return nil }
        return ThemeImagePicker(v: { image })
    }
    
    func scaled(to newSize: CGSize) -> ThemeImagePicker? {
        guard let image = image?.td.scaled(to: newSize) else { return nil }
        return ThemeImagePicker(v: { image })
    }
}

public extension ThemeImagePicker {
    convenience init(themeColor: ThemeColorPicker, size: CGSize = CGSize(width: 1, height: 1)) {
        self.init {
            guard let color = themeColor.color else {
                return UIImage.td.color(.clear, size: size)
            }
            
            return UIImage.td.color(color, size: size)
        }
    }
    
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        self.init {
            return UIImage.td.color(color, size: size)
        }
    }
}

extension ThemeImagePicker: ExpressibleByArrayLiteral {}
extension ThemeImagePicker: ExpressibleByStringLiteral {}
