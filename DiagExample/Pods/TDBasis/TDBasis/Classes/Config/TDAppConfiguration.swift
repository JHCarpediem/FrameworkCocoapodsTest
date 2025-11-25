//
//  TDAppConfiguration.swift
//  TDBasis
//
//  Created by Fench on 2025/8/13.
//

import Foundation


/**
    全局 App 配置类，包含中台信息、苹果信息和第三方信息。
    使用方式：
    
    ```swift
    // 第一种，直接通过 AppType 获取对应的配置
    TDAppConfiguration.topguru.topdonPlatform.appKey;
    
    //第二种 先 设置当前 App 类型 然后通过 TDAppConfiguration.current
    TDAppConfiguration.appType = TopdonAppTypeTopGuru;
    TDAppConfiguration.current.topdonPlatform.appKey;
    ```
 
    注意：请在使用前确保已设置 `TDAppConfiguration.appType`，否则会导致 fatalError。
 
    建议：App 配置 分 3 个模块 TopdonPlatform : 中台信息、AppleStore： 商店信息、ThirdVendor：第三方 SDK 配置
    可以在 App 中使用全局属性或者 OC 的宏定义来缩短访问路径，例如：
    
    ```swift
    let TopGuruPlatform = TDAppConfiguration.topguru.topdonPlatform
    let TopGuruAppleStore = TDAppConfiguration.topguru.appleStore
    let TopGuruThirdVendor = TDAppConfiguration.topguru.thirdVendor
 
    // 后续使用
    let appKey = TopGuruPlatform.appKey
    let bundleId = TopGuruAppleStore.bundleId
    let jPushKey = TopGuruThirdVendor.JPushKey
    ```
 */

@objc
@objcMembers
public class TDAppConfiguration: NSObject, Codable {
    
    //MARK: 中台信息
    @objc
    @objcMembers
    public class TopdonPlatform: NSObject, Codable {
        /// 中台软编码
        public var softCode: String
        /// 中台应用 Key
        public var appKey: String
        /// 中台应用 Secret
        public var appSecret: String
        
        public required init(softCode: String, appKey: String, appSecret: String) {
            self.softCode = softCode
            self.appKey = appKey
            self.appSecret = appSecret
        }
    }
    
    
    //MARK: 苹果信息
    
    @objc
    @objcMembers
    public class AppleStore: NSObject, Codable {
        /// 上传账号
        public private(set) var uploadAccount: String
        /// 应用包标识符
        public private(set) var bundleId: String
        /// 应用组标识符
        public private(set) var groupId: String
        /// App Store ID
        public private(set) var appStoreId: String
        /// 团队 ID
        public private(set) var teamId: String
        /// MFi 协议
        public private(set) var mfiProtocol: String?
        /// PPID (可选)
        public private(set) var PPID: String?
        /// 获取 App Store URL
        var appStoreUrl: String {
            return "https://apps.apple.com/app/id\(appStoreId)"
        }
        
        required init(uploadAccount: String, bundleId: String, groupId: String, appStoreId: String, teamId: String, mfiProtocol: String? = nil, PPID: String? = nil) {
            self.uploadAccount = uploadAccount
            self.bundleId = bundleId
            self.groupId = groupId
            self.appStoreId = appStoreId
            self.teamId = teamId
            self.mfiProtocol = mfiProtocol
            self.PPID = PPID
        }
    }
    
    
    //MARK: 第三方信息
    @objc
    @objcMembers
    public class ThirdVendor: NSObject, Codable {
        /// 极光推送 Key
        public private(set) var JPushKey: String
        /// 极光推送 Secret
        public private(set) var JPushSecret: String
        /// Zoho Key
        public private(set) var zohoKey: String
        /// Zoho Secret
        public private(set) var zohoSecret: String
        /// 友盟 Key
        public private(set) var UMengKey: String
        /// 微信企业号 ID
        public private(set) var wechatCompanyId: String
        /// 微信服务号地址
        public private(set) var wechatServiceUrl: String
        
        required init(JPushKey: String, JPushSecret: String, zohoKey: String, zohoSecret: String, UMengKey: String, wechatCompanyId: String, wechatServiceUrl: String) {
            self.JPushKey = JPushKey
            self.JPushSecret = JPushSecret
            self.zohoKey = zohoKey
            self.zohoSecret = zohoSecret
            self.UMengKey = UMengKey
            self.wechatCompanyId = wechatCompanyId
            self.wechatServiceUrl = wechatServiceUrl
        }
    }
    
    // Topdon 中台信息
    public private(set) var topdonPlatform: TopdonPlatform
    // Apple Store 信息
    public private(set) var appleStore: AppleStore
    // 第三方信息
    public private(set) var thirdVendor: ThirdVendor
    
    required init(topdonPlatform: TopdonPlatform, appleStore: AppleStore, thirdVendor: ThirdVendor) {
        self.topdonPlatform = topdonPlatform
        self.appleStore = appleStore
        self.thirdVendor = thirdVendor
    }
        
}

//MARK: 设置 App 类型并获取当前 App 配置
public extension TDAppConfiguration {
    /// 设置当前 App 的类型 请在启动应用时调用一次
    @objc static var appType: TopdonAppType {
        get {
            guard let _appType else {
                #if DEBUG
                fatalError("请先设置 AppType 再访问")
                #endif
                TDLogError("请先设置 AppType 再访问")
                return .TopGuru
            }
            return _appType
        }
        set { _appType = newValue }
    }
    
    private static var _appType: TopdonAppType?
    
    /// 获取当前 App 的配置，如果未设置 App 类型，DEBUG 环境下会抛出异常崩溃，release 环境下则返回 TopGuru 的配置
    @objc static let current: TDAppConfiguration = {
        // 获取当前 App 的配置
        guard let _appType else {
            #if DEBUG
            fatalError("当前 App 的配置未找到, 请先调用 TDAppConfiguration 设置当前 App 类型")
            #endif
            TDLogError("当前 App 的配置未找到, 请先调用 TDAppConfiguration 设置当前 App 类型")
            return TopdonAppType.TopGuru.appConfiguration
        }
        return _appType.appConfiguration
    }()
    
}

//MARK: - Topdon App 单例
public extension TDAppConfiguration {
    /// TopScan App 的配置
    @objc static let topscan: TDAppConfiguration = TopdonAppType.TopScan.appConfiguration
    
    /// TopGuru App 的配置
    @objc static let topguru: TDAppConfiguration = TopdonAppType.TopGuru.appConfiguration
    
    /// TopScan HD App 的配置
    @objc static let topscanHD: TDAppConfiguration = TopdonAppType.TopScan_HD.appConfiguration
    
    /// TopScan VAG App 的配置
    @objc static let topscanVAG: TDAppConfiguration = TopdonAppType.TopScan_VAG.appConfiguration
    
    /// TopScan BMW App 的配置
    @objc static let topscanBMW: TDAppConfiguration = TopdonAppType.TopScan_BMW.appConfiguration
    
    /// TopScan FORD App 的配置
    @objc static let topscanFORD: TDAppConfiguration = TopdonAppType.TopScan_FORD.appConfiguration
    
    /// DeepScan App 的配置
    @objc static let deepscan: TDAppConfiguration = TopdonAppType.DeepScan.appConfiguration
    
    /// GOOLOO OBD App 的配置
    @objc static let goolooOBD: TDAppConfiguration = TopdonAppType.GOOLOO_OBD.appConfiguration
    
    /// TopVCI Pro App 的配置
    @objc static let topvcipro: TDAppConfiguration = TopdonAppType.TopVCI_Pro.appConfiguration
    
    /// TopVCI App 的配置
    @objc static let topvci: TDAppConfiguration = TopdonAppType.TopVCI.appConfiguration
    
    /// CarPal App 的配置
    @objc static let carpal: TDAppConfiguration = TopdonAppType.CarPal.appConfiguration
    
    /// TopInfrared App 的配置
    @objc static let topinfrared: TDAppConfiguration = TopdonAppType.TopInfrared.appConfiguration
    
    /// ThermCam App 的配置
    @objc static let thermcam: TDAppConfiguration = TopdonAppType.ThermCam.appConfiguration
    
    /// BatteryLab App 的配置
    @objc static let batterylab: TDAppConfiguration = TopdonAppType.BatteryLab.appConfiguration
    
    /// PulseQ AC App 的配置
    @objc static let pulseqAC: TDAppConfiguration = TopdonAppType.PulseQ_AC.appConfiguration
    
    /// Home AC App 的配置
    @objc static let homeAC: TDAppConfiguration = TopdonAppType.Home_AC.appConfiguration
}
