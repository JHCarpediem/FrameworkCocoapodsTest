//
//  TDDUIConfig.swift
//  TopdonDiagnosis
//
//  Created by Fench on 2025/8/20.
//

import Foundation
import TDTheme
import TDBasis
import TDUIProvider

let middleKey = "TopdonDiagnosis"
//MARK: - LMSUIConfig
@objc public class TDDUIConfig:NSObject {
    
    private static var appImagePath: String?
    
    /// 配置 json 和 bundle 如果通过这个方法配置了 JSON 和 bundle，将会优先生效。（会覆盖 provider 中的值）
    /// 通过快捷配置 json 和 bundle 实现 LMS 的项目配置
    /// 相应的 json 文件参考 对应的 bundle 里面的 Theme.json
    /// eg: 配置国内版 将 National.bundle 复制到主工程，将对应图片替换（注意清不要修改图片名），修改 Theme.json 中的颜色的色值
    @objc public static func setupConfig(with json: String = "Theme.json", in bundle: Bundle, imagePath: String? = nil) {
        
        UIConfig.appConfig(key: middleKey, themeName: json, bundle: bundle, imagePath: imagePath)
        if let resorceBundle = Bundle.resorceBundle {
            UIConfig.configMiddleware(key: middleKey, bundle: resorceBundle, middleImagePath: "image")
        }
    }
    
}

