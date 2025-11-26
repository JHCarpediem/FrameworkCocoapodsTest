//
//  TDAppConfiguration.swift
//  TDBasis
//
//  Created by Diag on 2025/8/13.
//

import Foundation


/**
    全局 App 配置类，包含中台信息、苹果信息和第三方信息。
    使用方式：
    
    ```swift
    // 第一种，直接通过 AppType 获取对应的配置
    TDAppConfiguration.diagguru.diagdonPlatform.appKey;
    
    //第二种 先 设置当前 App 类型 然后通过 TDAppConfiguration.current
    TDAppConfiguration.appType = DiagdonAppTypeDiag;
    TDAppConfiguration.current.diagdonPlatform.appKey;
    ```
 
    注意：请在使用前确保已设置 `TDAppConfiguration.appType`，否则会导致 fatalError。
 
    建议：App 配置 分 3 个模块 DiagPlatform : 中台信息、AppleStore： 商店信息、ThirdVendor：第三方 SDK 配置
    可以在 App 中使用全局属性或者 OC 的宏定义来缩短访问路径，例如：
    
    ```swift
    let DiagPlatform = TDAppConfiguration.diagguru.diagdonPlatform
    let DiagAppleStore = TDAppConfiguration.diagguru.appleStore
    let DiagThirdVendor = TDAppConfiguration.diagguru.thirdVendor
 
    // 后续使用
    let appKey = DiagPlatform.appKey
    let bundleId = DiagAppleStore.bundleId
    let jPushKey = DiagThirdVendor.JPushKey
    ```
 */

@objc
@objcMembers
public class TDAppConfiguration: NSObject, Codable {
    
    //MARK: 中台信息
    @objc
    @objcMembers
    public class DiagPlatform: NSObject, Codable {
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
    

    public private(set) var diagdonPlatform: DiagPlatform
    // Apple Store 信息
    public private(set) var appleStore: AppleStore
    // 第三方信息
    public private(set) var thirdVendor: ThirdVendor
    
    required init(diagdonPlatform: DiagPlatform, appleStore: AppleStore, thirdVendor: ThirdVendor) {
        self.diagdonPlatform = diagdonPlatform
        self.appleStore = appleStore
        self.thirdVendor = thirdVendor
    }
        
}

//MARK: 设置 App 类型并获取当前 App 配置
public extension TDAppConfiguration {
    /// 设置当前 App 的类型 请在启动应用时调用一次
    @objc static var appType: DiagdonAppType {
        get {
            guard let _appType else {
                #if DEBUG
                fatalError("请先设置 AppType 再访问")
                #endif

                return .DiagGuru
            }
            return _appType
        }
        set { _appType = newValue }
    }
    
    private static var _appType: DiagdonAppType?
    
    /// 获取当前 App 的配置，如果未设置 App 类型，DEBUG 环境下会抛出异常崩溃，release 环境下则返回 Diag 的配置
    @objc static let current: TDAppConfiguration = {
        // 获取当前 App 的配置
        guard let _appType else {
            #if DEBUG
            fatalError("当前 App 的配置未找到, 请先调用 TDAppConfiguration 设置当前 App 类型")
            #endif

            return DiagdonAppType.DiagGuru.appConfiguration
        }
        return _appType.appConfiguration
    }()
    
}


public extension TDAppConfiguration {
    /// Diag App 的配置
    @objc static let diagscan: TDAppConfiguration = DiagdonAppType.DiagScan.appConfiguration
    
    /// Diag App 的配置
    @objc static let diagguru: TDAppConfiguration = DiagdonAppType.DiagGuru.appConfiguration
    
    /// Diag HD App 的配置
    @objc static let diagscanHD: TDAppConfiguration = DiagdonAppType.DiagScan_HD.appConfiguration
    
    /// Diag VAG App 的配置
    @objc static let diagscanVAG: TDAppConfiguration = DiagdonAppType.DiagScan_VAG.appConfiguration
    
    /// Diag BMW App 的配置
    @objc static let diagscanBMW: TDAppConfiguration = DiagdonAppType.DiagScan_BMW.appConfiguration
    
    /// Diag FORD App 的配置
    @objc static let diagscanFORD: TDAppConfiguration = DiagdonAppType.DiagScan_FORD.appConfiguration
    
    /// DeepDiag App 的配置
    @objc static let DeepDiag: TDAppConfiguration = DiagdonAppType.DeepDiag.appConfiguration
    
    /// GOOLOO OBD App 的配置
    @objc static let goolooOBD: TDAppConfiguration = DiagdonAppType.GOOLOO_OBD.appConfiguration
    
    /// TopVCI Pro App 的配置
    @objc static let diagvcipro: TDAppConfiguration = DiagdonAppType.DiagVCI_Pro.appConfiguration
    
    /// TopVCI App 的配置
    @objc static let diagvci: TDAppConfiguration = DiagdonAppType.DiagVCI.appConfiguration
    
    /// CarDiag App 的配置
    @objc static let carpal: TDAppConfiguration = DiagdonAppType.CarDiag.appConfiguration
    
    /// TopInfrared App 的配置
    @objc static let diaginfrared: TDAppConfiguration = DiagdonAppType.DiagInfrared.appConfiguration
    
    /// ThermCam App 的配置
    @objc static let thermcam: TDAppConfiguration = DiagdonAppType.ThermCam.appConfiguration
    
    /// BatteryLab App 的配置
    @objc static let batterylab: TDAppConfiguration = DiagdonAppType.BatteryLab.appConfiguration
    
    /// PulseQ AC App 的配置
    @objc static let pulseqAC: TDAppConfiguration = DiagdonAppType.PulseQ_AC.appConfiguration
    
    /// Home AC App 的配置
    @objc static let homeAC: TDAppConfiguration = DiagdonAppType.Home_AC.appConfiguration
}
