//
//  TDUserManager.swift
//  TDBasis
//
//  Created by Diag on 2023/7/13.
//

import UIKit


@objc public class TDUserManager: NSObject {
    
    /// 退出登录
    @objc public static func logout() {
        if !TDUserManager.isLogin {
            return
        }
        /// 先清空数据库
//        TDUserModel.current.deleteObject()
        
        /// 清空保存的userID
//        UserDefaults.savediagId = ""
//        UserDefaults.saveUserId = 0
        UserDefaults.userId = 0
        UserDefaults.diagId = ""
        UserDefaults.savedAppleUid = nil
        TDUserModel.logout()
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)

    }
    
    @objc public static var isLogin: Bool {
        if !UserDefaults.hasBackupUser && !UserDefaults.savediagId.isEmpty && UserDefaults.diagId.isEmpty {
            UserDefaults.hasBackupUser = true
            UserDefaults.diagId = UserDefaults.savediagId
        }
        let result = (!UserDefaults.diagId.isEmpty || (!isAppIsolation && !UserDefaults.savediagId.isEmpty)) && TDUserModel.current.isValid
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
    @available(*, deprecated, message: "方法已过期，请使用 `UserDefaults.diagId`")
    public static var savediagId: String {
        get {
            UserDefaults.diag.string(forKey: TDGlobalKey.kDiagId) ?? ""
        }
        set {
            UserDefaults.diag.set(newValue, forKey: TDGlobalKey.kDiagId)
            UserDefaults.diag.synchronize()
        }
    }
    
    @available(*, deprecated, message: "方法已过期，请使用 `UserDefaults.userId`")
    public static var saveUserId: Int {
        get {
            UserDefaults.diag.integer(forKey: TDGlobalKey.kUserId)
        }
        set {
            UserDefaults.diag.set(newValue, forKey: TDGlobalKey.kUserId)
            UserDefaults.diag.synchronize()
        }
    }
    

    @objc public static var userId: Int  = 0
    
    

    @objc public static var diagId: String  = ""
   
    /// 保存的邮箱
    public static var savedEmail: String? {
        get {
            UserDefaults.diag.string(forKey: TDGlobalKey.kRememberEmail)
        }
        set {
            if let email = newValue {
                UserDefaults.diag.setValue(email, forKey: TDGlobalKey.kRememberEmail)
                UserDefaults.diag.synchronize()
            }
        }
    }
    
    /// `token`更新时间
    public static var updateTokenTime: TimeInterval {
        get {
            UserDefaults.diag.double(forKey: TDGlobalKey.kUpdateTokenTime)
        }
        set {
            UserDefaults.diag.set(newValue, forKey: TDGlobalKey.kUpdateTokenTime)
            UserDefaults.diag.synchronize()
        }
    }
    
    public static var savedAvatarData: Data? {
        get {
            if TDUserModel.current.diagId.isEmpty { return nil }
            return UserDefaults.diag.data(forKey: TDGlobalKey.kSavedAvatarData + "_\(TDUserModel.current.diagId)")
        }
        set {
            if TDUserModel.current.diagId.isEmpty { return }
            UserDefaults.diag.set(newValue, forKey: TDGlobalKey.kSavedAvatarData + "_\(TDUserModel.current.diagId)")
            UserDefaults.diag.synchronize()
        }
    }
    
    public static var savedAvatarUrl: String? {
        get {
            if TDUserModel.current.diagId.isEmpty { return nil }
            return UserDefaults.diag.string(forKey: TDGlobalKey.kSavedAvatarUrl + "_\(TDUserModel.current.diagId)")
        }
        set {
            if TDUserModel.current.diagId.isEmpty { return }
            UserDefaults.diag.set(newValue, forKey: TDGlobalKey.kSavedAvatarUrl + "_\(TDUserModel.current.diagId)")
            UserDefaults.diag.synchronize()
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
   
    /// 获取diag 的`userDefaults`
    @objc public static var diag: UserDefaults {
        UserDefaults(suiteName: TDGlobalKey.kGroupId) ?? UserDefaults.standard
    }
}
