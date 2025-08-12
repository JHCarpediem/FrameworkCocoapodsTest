//
//  TDUserModel.swift
//  TDNetwork
//
//  Created by fench on 2023/7/12.
//

import UIKit

@objc
public class TDUserModel: TDDBModel {
    /// id 新版的UserID == topdonId
    @objc dynamic public var userId: Int = 0
    /// topdonId
    @objc dynamic public var topdonId: String = ""
    /// 令牌
    @objc dynamic public var token: String = ""
    /// 刷新令牌
    @objc dynamic public var refreshToken: String = ""
    /// 用户名
    @objc dynamic public var userName: String = ""
    
    /// 头像地址 新版已失效 请使用avatar
    @available(*, deprecated, renamed: "avatar")
    @objc dynamic public var url: String {
        get { avatar }
        set { avatar = newValue}
    }
    /// 邮箱
    @objc dynamic public var email: String = ""
    /// 是否是第三方登录
    @objc dynamic public var isOtherLogin: Bool = false
    /// 性别 1、男 0、女
    @objc dynamic public var gender: Int = 1
    /// 生日
    @objc dynamic public var birthday: String = ""
    /// 头像
    @objc dynamic public var avatar: String = ""
    /// 手机号
    @objc dynamic public var phone: String = ""
    /// 是否有绑定设备
    @objc dynamic public var hasBindDevice: Bool = false
    
    /// 是否有绑定Apple ID
    @objc dynamic public var bindApple: Bool = false
    
    /// 是否有绑定微信
    @objc dynamic public var bindWechat: Bool = false
    
    /// 微信头像
    @objc dynamic public var wechatAvatar: String = ""
    
    /// 微信昵称
    @objc dynamic public var wechatNickname: String = ""
    
    /// 是否有绑定手机号
    @objc dynamic public var bindPhone: Bool = false
    
    /// facebook头像
    @objc dynamic public var facebookAvatar: String = ""
    
    /// 是否有绑定facebook
    @objc dynamic public var bindFacebook: Bool = false
    
    /// 谷歌头像
    @objc dynamic public var googleAvatar: String = ""
    
    /// 是否有绑定google
    @objc dynamic public var bindGoogle: Bool = false
    
    /// 过期时间
    @objc dynamic public var expiration: Double = 0
    
    /// 过期时间 多少s 后过期
    @objc dynamic public var expiresIn: Double = 0
    
    /// refreshToken 多少 s 后 过期
    @objc dynamic public var refreshExpiresIn: Double = 0
    
    /// refreshToken 过期时间戳 - 相对服务器时间
    @objc dynamic public var refreshExpiration: Double = 0
    
    /// 已登录的 App 软件编码
    @objc dynamic public private(set) var loginApps: String = ""
    
    @objc dynamic public var pointCardBalance: Int = 0
    
    @objc dynamic public var pointCardBalanceDisplay: String {
        pointCardBalance.decimalFormatString
    }
    
    @objc dynamic public var pointBalance: Int = 0
    
    @objc dynamic public var pointBalanceDisplay: String {
        pointBalance.decimalFormatString
    }
    
    public var exsitApps: [String] {
        get {
            loginApps.components(separatedBy: ", ").filter { !$0.isEmpty }
        }
        set {
            loginApps = newValue.filter { !$0.isEmpty }.joined(separator: ", ")
        }
    }
    
    /// refreshToken 已过期
    @objc public var isRefreshTokenExpired: Bool {
        return refreshExpiration < AppInfo.serviceTimestamp
    }
    
    /// 构建方法
    public convenience init(topdonId: String,
                            token: String,
                            refreshToken: String,
                            userName: String,
                            avatar: String,
                            email: String,
                            phone: String,
                            isOtherLogin: Bool = false,
                            gender: Int = 1,
                            birthday: String = "") {
        self.init()
        self.topdonId = topdonId
        self.token = token
        self.refreshToken = refreshToken
        self.userName = userName
        self.email = email
        self.isOtherLogin = isOtherLogin
        self.gender = gender
        self.birthday = birthday
        self.phone = phone
    }
    
    /// 当前用户
    @objc public static var current: TDUserModel {
        if let curUser = _currentUser {
            return curUser
        }
        
        let emptyUser = TDUserModel()
        let topdonId = UserDefaults.topdonId
        let userID = UserDefaults.userId
        if userID == 0 && topdonId.isEmpty {
            return emptyUser // 没有保存UserID
        }
        var criteria: String
        if userID != 0 {
            criteria = " WHERE userId = \(userID) "
        } else {
            criteria = " WHERE topdonId = '\(topdonId)' "
        }
        if !BasisInfo.userDBSoftCode.isEmpty {
            criteria += "AND LOWER(loginApps) LIKE '%\(BasisInfo.userDBSoftCode.lowercased())%'"
        }
        if let current = TDUserModel.findFirst(byCriteria: criteria) {
            _currentUser = current
            return current
        }
        
        return TDUserModel()
    }
    
    private static var unIsolationModel: TDUserModel? {
        let topdonId = UserDefaults.saveTopdonId
        let userID = UserDefaults.saveUserId
        if userID == 0 && topdonId.isEmpty {
            return nil // 没有保存UserID
        }
        var criteria: String
        if userID != 0 {
            criteria = " WHERE userId = \(userID) "
        } else {
            criteria = " WHERE topdonId = '\(topdonId)' "
        }
        
        if let current = TDUserModel.findFirst(byCriteria: criteria) {
            _currentUser = current
            if !current.exsitApps.contains(where: { $0.lowercased() == BasisInfo.userDBSoftCode.lowercased() }) {
                current.exsitApps.append(BasisInfo.userDBSoftCode)
            }
            current.saveOrUpdate()
            return current
        }
        
        return nil
    }
    
    /// 当前用户是否有效
    public var isValid: Bool {
        return userId != 0 && !topdonId.isEmpty
    }
    
    private static var _currentUser: TDUserModel?
    
    /// 这个方法不要在 项目中调用 项目中要退出登录 请调用 `TDUserManager.logout()`
    public static func logout(){
        _currentUser?.exsitApps.removeAll(where: { $0.lowercased() == BasisInfo.userDBSoftCode.lowercased() })
        _currentUser?.saveOrUpdate()
        _currentUser = nil
    }
    
    @objc public static func clearMemoryCache() {
        _currentUser = nil
    }
    
    /// 更新用户信息
    /// - Parameter userModel: 用户模型
    public static func updateUser(_ userModel: TDUserModel) {
        _currentUser = userModel
        if TDUserManager.isLogin, !userModel.topdonId.isEmpty {
//            UserDefaults.saveTopdonId = userModel.topdonId
//            UserDefaults.saveUserId = userModel.userId
            UserDefaults.userId = userModel.userId
            UserDefaults.topdonId = userModel.topdonId
        }
    }
    
    public override class func customPk() -> String? {
        return "topdonId"
    }
    
    public override class func storeGroupID() -> String! {
        return TDGlobalKey.kGroupId
    }
    
    public func updateExpriTime(){
        let serTime = AppInfo.serviceTimestamp
        self.expiration = serTime + expiresIn
    }
    
    public func updateRefreshTokenExpritTime() {
        self.refreshExpiration = AppInfo.serviceTimestamp + refreshExpiresIn
    }
    
    public override class func transients() -> [Any]! {
        return ["exsitApps", "isRefreshTokenExpired", "pointCardBalanceDisplay", "pointBalanceDisplay"]
    }
    
    public override class func tableName() -> String? {
        return nil
    }
}

@objc public extension TDUserModel {
    @objc public func setSelect() {
        if !isValid { return }
        UserDefaults.topdonId = topdonId
        UserDefaults.userId = userId
        if !exsitApps.contains(where: { $0.lowercased() == BasisInfo.userDBSoftCode.lowercased() }) {
            exsitApps.append(BasisInfo.userDBSoftCode)
        }
        Self._currentUser = nil
    }
    
    @objc public func displayAccount(isEmailFirst: Bool = false) -> String {
        if isEmailFirst {
            return !email.isEmpty ? email : phone.td.securetPhoneNum
        } else {
            return !phone.isEmpty ? phone.td.securetPhoneNum : email
        }
    }
    
    @objc public func account(isEmailFirst: Bool = false) -> String {
        if isEmailFirst {
            return !email.isEmpty ? email : phone
        } else {
            return !phone.isEmpty ? phone : email
        }
    }
    
    /// 获取DB 中所有已登录的账号
    @objc public static func loginedUsers() -> [TDUserModel] {
        let criteria = " WHERE loginApps != '' AND loginApps IS NOT NULL"
        guard let users = TDUserModel.find(byCriteria: criteria) as? [TDUserModel] else {
            return []
        }
        return users
    }
    
    /// 获取 DB 中所有refreshToken 已过期的账号 （已登录的账号）
    @objc public static func expiredUsers() -> [TDUserModel] {
        let criteria = " WHERE loginApps != '' AND loginApps IS NOT NULL AND expiration < \(AppInfo.serviceTimestamp)"
        guard let users = TDUserModel.find(byCriteria: criteria) as? [TDUserModel] else {
            return []
        }
        return users
    }
    
    /// 获取 DB 中所有 refreshToken 未过期的账号 （已登录的账号）
    @objc public static func inExpiredUsers() -> [TDUserModel] {
        let criteria = " WHERE loginApps != '' AND loginApps IS NOT NULL AND expiration >= \(AppInfo.serviceTimestamp)"
        guard let users = TDUserModel.find(byCriteria: criteria) as? [TDUserModel] else {
            return []
        }
        return users
    }
}

extension UserDefaults {
    static public var hasBackupUser: Bool {
        get {
            let value = UserDefaults.topdon.bool(forKey: "kHasBackupUser_\(BasisInfo.userDBSoftCode)")
            if !value , UserDefaults.topdonId.isEmpty, !UserDefaults.saveTopdonId.isEmpty {
                UserDefaults.topdonId = UserDefaults.saveTopdonId
            }
            return value
        }
        set {
            UserDefaults.topdon["kHasBackupUser_\(BasisInfo.userDBSoftCode)"] = newValue
            UserDefaults.topdon.synchronize()
        }
    }
}
