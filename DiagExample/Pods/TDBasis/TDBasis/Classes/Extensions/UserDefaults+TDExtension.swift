//
//  UserDefaults+diag.swift
//  TDBasis
//
//  Created by Fench on 2025/8/13.
//


/// 属性包装器
/// 快速构建 存储到偏好设置的值, 存储到 App 沙盒
/// 使用 方式：
/// ```
/// @TDUserDefaults(key: "com.diag.LMS.islogin", defaultValue: false)
/// var isLogin: Bool
///
/// ```
/// 这样在外部调用的时候 就可以直接使用 `isLogin` 来进行偏好设置的存储和访问了
///
@propertyWrapper
public struct TDUserDefaults<T: Codable> {
    
    public let key: String
    public let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            if case Optional<Any>.none = newValue as Any {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
            UserDefaults.standard.synchronize()
        }
    }
    
}

/// 属性包装器
/// 快速构建 存储到偏好设置的值, 如果 App 设置了 Group 开启了 keyChain sharing 将会保存到钥匙串 同一个组织可以一起访问该值，如果没有设置则会使用沙盒偏好设置
/// 使用 方式：
/// ```
/// @TDKeyChainUserDefaults(key: "com.diag.LMS.islogin", defaultValue: false)
/// var isLogin: Bool
///
/// ```
/// 这样在外部调用的时候 就可以直接使用 `isLogin` 来进行偏好设置的存储和访问了
///
@propertyWrapper
public struct TDKeyChainUserDefaults<T: Codable> {
    
    public let key: String
    public let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            UserDefaults.diag.value(forKey: key) as? T ?? defaultValue
        }
        set {
            if case Optional<Any>.none = newValue as Any {
                UserDefaults.diag.set(newValue, forKey: key)
            } else {
                UserDefaults.diag.removeObject(forKey: key)
            }
            UserDefaults.diag.synchronize()
        }
    }
    
}
