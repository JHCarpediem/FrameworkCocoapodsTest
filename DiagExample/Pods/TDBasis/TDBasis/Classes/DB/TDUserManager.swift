//
//  TDUserManager.swift
//  TDBasis
//
//  Created by fench on 2023/7/13.
//

import UIKit
import TopdonLog

public let TDUserDefaults = UserDefaults.standard
@objc public class TDUserManager: NSObject {
    
    /// 退出登录
    @objc public static func logout() {
        if !TDUserManager.isLogin {
            return
        }
        /// 先清空数据库
//        TDUserModel.current.deleteObject()
        
        /// 清空保存的userID
//        UserDefaults.saveTopdonId = ""
//        UserDefaults.saveUserId = 0
        UserDefaults.userId = 0
        UserDefaults.topdonId = ""
        UserDefaults.savedAppleUid = nil
        TDUserModel.logout()
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
        TDLogDebug("退出登录")
    }
    
    @objc public static var isLogin: Bool {
        if !UserDefaults.hasBackupUser && !UserDefaults.saveTopdonId.isEmpty && UserDefaults.topdonId.isEmpty {
            UserDefaults.hasBackupUser = true
            UserDefaults.topdonId = UserDefaults.saveTopdonId
        }
        let result = (!UserDefaults.topdonId.isEmpty || (!isAppIsolation && !UserDefaults.saveTopdonId.isEmpty)) && TDUserModel.current.isValid
        return result
    }
    
    /// APP 账号隔离 （LMS 4.70 以上版本 支持账号隔离）
    @objc public static var isAppIsolation = false
    
    /// 用户上次登录的邮箱
    @objc public static var savedEmail: String? {
        get { UserDefaults.savedEmail }
        set { UserDefaults.savedEmail = newValue }
    }
    
    /// 用户上次登录的密码
    @objc public static var savedPassword: String? {
        get {
            TDHKeychainTool.td_readKeychainValue(TDGlobalKey.kRememberPwd)
        }
        set {
            guard let pwd = newValue else {
                TDHKeychainTool.td_deleteKeychainValue(TDGlobalKey.kRememberPwd)
                return
            }
            TDHKeychainTool.td_saveKeychainValue(pwd, key: TDGlobalKey.kRememberPwd)
        }
    }

    // 兼容性测试账号 密码
    public static var compatibilityMobil: String? {
        get { UserDefaults.compatibilityMobile }
        set {
            UserDefaults.compatibilityMobile = newValue ?? ""
            UserDefaults.standard.synchronize()
            
        }
    }
    
    public static var compatibilityEmail: String? {
        get { UserDefaults.compatibilityEmail }
        set {
            UserDefaults.compatibilityEmail = newValue ?? ""
            UserDefaults.standard.synchronize()
        }
    }
    public static var compatibilityPassword: String? {
        get { UserDefaults.compatibilityPassword }
        set {
            UserDefaults.compatibilityPassword = newValue ?? ""
            UserDefaults.standard.synchronize()
        }
    }
    
    public static func addCompatibility(account: String, pwd: String) {
        var coms = compatibilitys
        if coms.contains(where: { $0["account"] == account && $0["password"] == pwd }) { return }
        
        let info = ["account": account, "password": pwd]
        coms.append(info)
        compatibilitys = coms
    }
    
    public static var compatibilitys: [[String: String]] {
        get { UserDefaults.standard.object(forKey: "com.tdbasis.compatibilitys") as? [[String: String]] ?? [] }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "com.tdbasis.compatibilitys")
        }
    }
    
}

extension UserDefaults {
   
    /// 保存`userID`
    @available(*, deprecated, message: "方法已过期，请使用 `UserDefaults.topdonId`")
    public static var saveTopdonId: String {
        get {
            UserDefaults.topdon.string(forKey: TDGlobalKey.kTopdonId) ?? ""
        }
        set {
            UserDefaults.topdon.set(newValue, forKey: TDGlobalKey.kTopdonId)
            UserDefaults.topdon.synchronize()
        }
    }
    
    @available(*, deprecated, message: "方法已过期，请使用 `UserDefaults.userId`")
    public static var saveUserId: Int {
        get {
            UserDefaults.topdon.integer(forKey: TDGlobalKey.kUserId)
        }
        set {
            UserDefaults.topdon.set(newValue, forKey: TDGlobalKey.kUserId)
            UserDefaults.topdon.synchronize()
        }
    }
    
    @UserDefault(key: "com.TDBasis.userId", defaultValue: 0)
    @objc public static var userId: Int
    
    
    @UserDefault(key: "com.TDBasis.topdonId", defaultValue: "")
    @objc public static var topdonId: String
   
    /// 保存的邮箱
    public static var savedEmail: String? {
        get {
            UserDefaults.topdon.string(forKey: TDGlobalKey.kRememberEmail)
        }
        set {
            if let email = newValue {
                UserDefaults.topdon.setValue(email, forKey: TDGlobalKey.kRememberEmail)
                UserDefaults.topdon.synchronize()
            }
        }
    }
    
    /// `token`更新时间
    public static var updateTokenTime: TimeInterval {
        get {
            UserDefaults.topdon.double(forKey: TDGlobalKey.kUpdateTokenTime)
        }
        set {
            UserDefaults.topdon.set(newValue, forKey: TDGlobalKey.kUpdateTokenTime)
            UserDefaults.topdon.synchronize()
        }
    }
    
    public static var savedAvatarData: Data? {
        get {
            if TDUserModel.current.topdonId.isEmpty { return nil }
            return UserDefaults.topdon.data(forKey: TDGlobalKey.kSavedAvatarData + "_\(TDUserModel.current.topdonId)")
        }
        set {
            if TDUserModel.current.topdonId.isEmpty { return }
            UserDefaults.topdon.set(newValue, forKey: TDGlobalKey.kSavedAvatarData + "_\(TDUserModel.current.topdonId)")
            UserDefaults.topdon.synchronize()
        }
    }
    
    public static var savedAvatarUrl: String? {
        get {
            if TDUserModel.current.topdonId.isEmpty { return nil }
            return UserDefaults.topdon.string(forKey: TDGlobalKey.kSavedAvatarUrl + "_\(TDUserModel.current.topdonId)")
        }
        set {
            if TDUserModel.current.topdonId.isEmpty { return }
            UserDefaults.topdon.set(newValue, forKey: TDGlobalKey.kSavedAvatarUrl + "_\(TDUserModel.current.topdonId)")
            UserDefaults.topdon.synchronize()
        }
    }
    
    public static var savedAppleUid: String? {
        get {
            UserDefaults.standard.string(forKey: TDGlobalKey.kSavedAppleUid)
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: TDGlobalKey.kSavedAppleUid)
                return
            }
            UserDefaults.standard.set(newValue, forKey: TDGlobalKey.kSavedAppleUid)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var compatibilityEmail: String {
        get {
            #if DEBUG
            return UserDefaults.standard.string(forKey: "compatibilityEmail") ?? ""
            #endif
            return ""
        }
        set {
            UserDefaults.standard["compatibilityEmail"] = newValue
            UserDefaults.standard.synchronize()
        }
    }
    
    static var compatibilityMobile: String {
        get {
            #if DEBUG
            return UserDefaults.standard.string(forKey: "compatibilityMobile") ?? ""
            #endif
            return ""
        }
        set {
            UserDefaults.standard["compatibilityMobile"] = newValue
            UserDefaults.standard.synchronize()
        }
    }
    
    static var compatibilityPassword: String {
        get {
            #if DEBUG
            return UserDefaults.standard.string(forKey: "compatibilityPassword") ?? ""
            #endif
            return ""
        }
        set {
            UserDefaults.standard["compatibilityPassword"] = newValue
            UserDefaults.standard.synchronize()
        }
    }
   
    /// 获取Topdon 的`userDefaults`
    @objc public static var topdon: UserDefaults {
        UserDefaults(suiteName: TDGlobalKey.kGroupId) ?? UserDefaults.standard
    }
}
