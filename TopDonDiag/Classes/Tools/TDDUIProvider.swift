//
//  TDDUIProvider.swift
//  TopdonDiagnosis
//
//  Created by Fench on 2025/8/20.
//

import Foundation
import TDUIProvider
import TDTheme
import TDBasis

@objc
@objcMembers
public class TDD_UIProvider: NSObject {
    
    /// 从配置 bundle 中获取 图片 （优先从 App 配置的 bundle 中读取，然后读取诊断内的 bundle，最后从 UIProvider 库中读取）
    /// - Parameter named: 图片名 注意保持 App bundle 中的图片名与 诊断内 bundle 中的图片名一致
    /// - Returns: 图片
    @objc public class func image(with named: String) -> UIImage? {
        UIConfig.image(named: named, middlewareKey: middleKey)?.image
    }
    
    public class func themeImage(with named: String) -> ThemeImagePicker? {
        UIConfig.image(named: named, middlewareKey: middleKey)
    }
}
