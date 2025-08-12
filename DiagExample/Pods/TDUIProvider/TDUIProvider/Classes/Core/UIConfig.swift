//
//  UIConfig.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/6.
//

import Foundation
import TDBasis
import TDTheme

@objc(TDUIConfig)
@objcMembers
open class UIConfig: NSObject {
    /// 获取资源所在的 bundle
    @objc public private(set) static var resourceBundle: Bundle?
    
    /// 配置的 json 文件
    @objc public private(set) static var themeName: String?
    
    /// 中间件资源文件 bundle eg: LMS 的默认资源 bundle
    private(set) static var middlewareConfigs: [MiddlewareConfig] = []
    
    /// 配置 json 和 bundle 如果通过这个方法配置了 JSON 和 bundle，将会优先生效。（会覆盖 provider 中的值）
    /// 通过快捷配置 json 和 bundle 实现 LMS 的项目配置
    /// 相应的 json 文件参考 对应的 bundle 里面的 Theme.json
    /// eg: 配置国内版 将 National.bundle 复制到主工程，将对应图片替换（注意清不要修改图片名），修改 Theme.json 中的颜色的色值
    @objc open class func setupConfig(with json: String = "Theme.json", in bundle: Bundle) {
        resourceBundle = bundle
        themeName = json
    }
    
    /// 配置 中间件 SDK
    ///  json 和 bundle 如果通过这个方法配置了 JSON 和 bundle，将会优先生效。（会覆盖 provider 中的值）
    /// 通过快捷配置 json 和 bundle 实现 LMS 的项目配置
    /// 相应的 json 文件参考 对应的 bundle 里面的 Theme.json
    /// eg: 配置国内版 将 National.bundle 复制到主工程，将对应图片替换（注意清不要修改图片名），修改 Theme.json 中的颜色的色值
    @objc public static func configMiddleware(key: String, themeName: String = "Theme.json", bundle: Bundle?) {
        middlewareConfigs.removeAll(where: { $0.key == key })
        middlewareConfigs.append(MiddlewareConfig(bundle: bundle, themeName: themeName, key: key))
    }
}

extension UIConfig {
    class MiddlewareConfig {
        var bundle: Bundle?
        var themeName: String?
        var key: String
        
        private var _themedDict: NSDictionary?
        var themeDict: NSDictionary? {
            if let _themedDict {
                return _themedDict
            }
            guard let resourceBundle = bundle, let jsonName = UIConfig.jsonName(with: themeName) else { return nil }
            guard let path = resourceBundle.path(forResource: jsonName, ofType: "json") else { return nil }
            guard
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                let themeDict = json as? NSDictionary else {
                TDLogError("加载配置警告: App 未配置主题 json '\(jsonName)' at: \(path)")
                return nil
            }
            _themedDict = themeDict
            return themeDict
        }
        
        required init(bundle: Bundle?, themeName: String?, key: String) {
            self.bundle = bundle
            self.themeName = themeName
            self.key = key
        }
    }
}

extension UIConfig {
    // 获取 json 的文件名
    private static func jsonName(with themeName: String?) -> String? {
        guard let themeName = themeName else { return nil }
        if themeName.lowercased().hasSuffix(".json") {
            return String(themeName.dropLast(".json".count))
        }
        return themeName
    }
    
    // 获取配置的 json，转换成字典
    private static var _jsonDict: NSDictionary?
    private static var jsonDict: NSDictionary? {
        if let _jsonDict {
            return _jsonDict
        }
        guard let resourceBundle = resourceBundle, let jsonName = jsonName(with: themeName) else { return nil }
        guard let path = resourceBundle.path(forResource: jsonName, ofType: "json") else { return nil }
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
            TDLogError("加载配置警告: App 未配置主题 json '\(jsonName)' at: \(path)")
            return nil
        }
        _jsonDict = jsonDict
        return jsonDict
    }
    
    /// 获取内置的配置，转换成字典
    private static var _internalJson: NSDictionary?
    private static var internalJson: NSDictionary? {
        if let _internalJson {
            return _internalJson
        }
        guard let bundle = Bundle.providerBundle, let path = bundle.path(forResource: "Theme", ofType: "json") else { return nil }
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
            TDLogError("加载配置警告: 无法读取 LMS 内置的配置文件 Theme.json at: \(path)")
            return nil
        }
        _internalJson = jsonDict
        return jsonDict
    }
    
    /// 通过 keyPath 读取配置的具体值， 先读外界配置的 json，外界配置的 json 读不到，则去读内置的 json，如果还读不到则返回 nil
    private static func readValue(for keyPath: String, middlewareKey: String? = nil) -> Any? {
        if let jsonDict, let value = jsonDict.value(forKeyPath: keyPath) {
            return value
        }
        
        if let middlewareKey, let jsonDict = middlewareConfigs.first(where: { $0.key == middlewareKey })?.themeDict, let value = jsonDict.value(forKeyPath: keyPath) {
            return value
        }
        
        if let internalJson, let value = internalJson.value(forKeyPath: keyPath) {
            return value
        }
        
        TDLogError("加载配置错误，未知的 keyPath: \(keyPath)")
        return nil
    }
}

//MARK: - 从配置的 json 文件中读取 具体的配置信息
extension UIConfig {
    /// 从配置中读取颜色
    public static func color(with keyPath: String, middlewareKey: String? = nil) -> ThemeColorPicker? {
        guard let rgba = readValue(for: keyPath, middlewareKey: middlewareKey) as? String, let color = try? UIColor(rgba_throws: rgba) else {
            TDLogError("配置错误 - 无法读取颜色配置: \(keyPath)")
            return nil
        }
        return ThemeColorPicker(v: { color })
        
    }
    
    /// 从配置中读取 渐变色 style
    public static func gradientStyle(with keyPath: String, middlewareKey: String? = nil) -> GradientStyle? {
        if let value = readValue(for: keyPath, middlewareKey: middlewareKey) as? String {
            if let intValue = value.td.int {
                return GradientStyle(rawValue: intValue)
            }
            switch value.lowercased() {
            case "toptobottom":
                return .topToBottom
            case "toplefttobottomright":
                return .topLeftToBottomRight
            case "toprighttobottomleft":
                return .topRightToBottomLeft
            case "lefttoright":
                return .leftToRight
            default:
                return nil
            }
        }
        
        if let value = readValue(for: keyPath, middlewareKey: middlewareKey) as? Int {
            return GradientStyle(rawValue: value)
        }
        return nil
    }
    
    
    /// 从配置中读取渐变色 色值数组
    public static func gradient(keyPath: String, middlewareKey: String? = nil) -> [UIColor]? {
        guard let colorValue = readValue(for: keyPath, middlewareKey: middlewareKey) as? String, !colorValue.isEmpty else { return nil }
        let colors = colorValue.td.nsString.components(separatedBy: ",").map { UIColor.td.color(with: $0) ?? .clear }
        return colors
    }
    
    /// 从配置中读取配置的 int 值 可自定义默认值，读不到取默认值
    public static func intValue(keyPath: String, defaultValue: Int, middlewareKey: String? = nil) -> Int {
        guard let intValue = readValue(for: keyPath, middlewareKey: middlewareKey) as? Int else { return defaultValue }
        return intValue
    }
    
    /// 从配置中读取配置的 int 值
    public static func intValue(keyPath: String, middlewareKey: String? = nil) -> Int? {
        if var strValue = readValue(for: keyPath, middlewareKey: middlewareKey) as? String {
            if let intValue = Int(strValue) {
                return intValue
            } else if strValue.lowercased().contains("0x"){
                strValue = String(strValue.dropFirst(2))
                if let intValue = Int(strValue, radix: 16) {
                    return intValue
                }
            } else if strValue.contains("#") {
                strValue = String(strValue.dropFirst(1))
                if let intValue = Int(strValue, radix: 16) {
                    return intValue
                }
            } else if strValue.lowercased().contains("0b") {
                strValue = String(strValue.dropFirst(2))
                if let intValue = Int(strValue, radix: 2) {
                    return intValue
                }
            }
            
        }
        guard let intValue = readValue(for: keyPath, middlewareKey: middlewareKey) as? Int else { return nil }
        return intValue
    }
    
    /// 从配置中读取配置的 double 值 可自定义默认值 读不到取默认值
    public static func doubleValue(keyPath: String, defaultValue: Double, middlewareKey: String? = nil) -> Double {
        guard let doubleValue = readValue(for: keyPath, middlewareKey: middlewareKey) as? Double else { return defaultValue }
        return doubleValue
    }
    
    /// 从配置中读取配置的 double 值 返回可选类型
    public static func doubleValue(keyPath: String, middlewareKey: String? = nil) -> Double? {
        guard let doubleValue = readValue(for: keyPath, middlewareKey: middlewareKey) as? Double else { return nil }
        return doubleValue
    }
    
    /// 从配置中读取配置的 string 值， 返回可选类型
    public static func string(for keyPath: String, middlewareKey: String? = nil) -> String? {
        guard let string = readValue(for: keyPath, middlewareKey: middlewareKey) as? String else { return nil }
        return string
    }
    
    /// 从配置中读取配置的 string 值， 可自定义默认值 读不到取默认值
    public static func string(for keyPath: String, defaultValue: String, middlewareKey: String? = nil) -> String {
        guard let string = readValue(for: keyPath, middlewareKey: middlewareKey) as? String else { return defaultValue }
        return string
    }
    
    /// 根据图片名 从配置的 bundle 中读取图片
    public static func image(named: String, middlewareKey: String? = nil) -> ThemeImagePicker? {
        if let image = image(named: named, bundle: UIConfig.resourceBundle) {
            return image
        }
        
        if let bundle = middlewareConfigs.first(where: { $0.key == middlewareKey } )?.bundle {
            if let image = image(named: named, bundle: bundle) {
                return image
            }
        } else {
            for bundle in middlewareConfigs.map(\.bundle) {
                if let image = image(named: named, bundle: bundle) {
                    return image 
                }
            }
        }
        
        var named = named
        if !named.contains("/") {
            named = "TDUIProvider.bundle/Image/\(named)"
        }
        return image(named: named, bundle: .current)
    }
    
    /// 根据图片名 从 bundle 中读取图片
    public static func image(named: String, bundle: Bundle?) -> ThemeImagePicker? {
        guard let image = UIImage(named: named, in: bundle, compatibleWith: nil) else {
            return nil
        }
        return ThemeImagePicker(images: image)
    }
}
