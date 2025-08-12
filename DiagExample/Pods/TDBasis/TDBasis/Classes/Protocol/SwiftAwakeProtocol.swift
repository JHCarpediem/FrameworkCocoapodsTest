//
//  SwiftAwakeProtocol.swift
//  TDBasis
//
//  Created by fench on 2023/11/7.
//

import Foundation

public protocol SwiftAwakeProtocol: class {
    /// 此方法是在应用程序与用户进行第一次交互的时候在子线程调用， 不要在 `awake()` 方法中调用 UI 相关代码 （如果需要操作 UI 相关，请将 UI 相关操作移到主线程）
    static func awake()
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
}

public extension SwiftAwakeProtocol {
    
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}

public class NothingToSeeHere {
    static func harmlessFunction() {
        
        for awakeProtocol in needAwakeTypes {
            (awakeProtocol as? SwiftAwakeProtocol.Type)?.awake()
        }
        #if DEBUG
        print("执行方法交换---harmlessFunction")
        #endif 
//        DispatchQueue(label: "com.TDBais.swizz").async {
//            let typeCount = Int(objc_getClassList(nil, 0))
//            let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
//            let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
//            objc_getClassList(autoreleasingTypes, Int32(typeCount))
//            for index in 0 ..< typeCount {
//                if needAwakeTypes.contains(where: { "\($0)" == "\(types[index])" }) {
//                    continue
//                }
//                (types[index] as? SwiftAwakeProtocol.Type)?.awake()
//            }
//            types.deallocate()
//        }
    }
    
    public static var needAwakeTypes: [AnyClass] = [UIScrollView.self, UIViewController.self]
}
extension UIApplication {
    public static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}
