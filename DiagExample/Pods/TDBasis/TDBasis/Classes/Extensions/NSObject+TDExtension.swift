//
//  NSObject+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

extension TDBasisWrap where Base: NSObject {
    public func swizzleMethod(_ originSelector: Selector, swizzledSelector: Selector) {
        base.td_swizzleMethod(originSelector, swizzledSelector: swizzledSelector)
    }
    
    
}

@objc public extension NSObject {
    
    @objc public var classNameNoSpace: String {
        var className = NSStringFromClass(self.classForCoder)
        return className.components(separatedBy: ".").last ?? className
    }
    
    /// 方法交换
    /// - Parameters:
    ///   - originalSelector: 类的原始方法
    ///   - swizzled: 需要交换的方法
    @objc func td_swizzleMethod(_ originalSelector: Selector, swizzledSelector swizzled: Selector) {
        guard
            let originalMethod = class_getInstanceMethod(Self.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(Self.self, swizzled) else {
            return
        }
        
        let didAddMethod = class_addMethod(
            Self.self,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddMethod {
            class_replaceMethod(
                Self.self,
                swizzled,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
