//
//  BUndle+Ex.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/6.
//

import Foundation

fileprivate class providerBundleEmptyClass: NSObject { }

extension Bundle {
    
    static var current: Bundle {
        return Bundle(for: providerBundleEmptyClass.classForCoder())
    }

    /// 内置 bundle 对象
    static var providerBundle: Bundle? {
        return bundle(className: providerBundleEmptyClass.classForCoder(), bundleName: "TDUIProvider.bundle")
    }
  
}

extension Bundle {
    
    /// 通过类名 + bundle 名 获取类所在的模块中的 bundle 对象
    public static func bundle(className: AnyClass, bundleName: String) -> Bundle? {
        guard let bundlePath = Bundle(for: className).path(forResource: bundleName, ofType: nil) else { return nil }
        return Bundle(path: bundlePath)
    }
}
