//
//  TDLanguage.swift
//  TDBasis
//
//  Created by fench on 2023/7/12.
//

import UIKit

/// swift 版本 语言Type

@objc public enum TDLanguageType: Int, CaseIterable {
    
        // 简体中文,
        case zh = 1
        // 繁体中文
        case zh_HK = 2
        // 德语
        case de = 3
        // 法语
        case fr = 4
        // 日语
        case ja = 5
        // 捷克语
        case cz = 6
        // 英语
        case en = 7
        // 丹麦语
        case da = 8
        // 希腊语
        case el = 9
        // 西班牙语
        case es = 10
        // 芬兰语
        case fi = 11
        // 匈牙利语
        case hu = 13
        // 意大利语
        case it = 14
        // 韩语
        case ko = 15
        // 荷兰语
        case nl = 16
        // 挪威语
        case nb = 17
        // 波兰语
        case pl = 18
        // 葡萄牙语
        case pt = 19
        // 俄语
        case ru = 20
        // 斯洛文尼亚语
        case sl = 21
        // 瑞典语
        case sv = 22
        // 土耳其语
        case tr = 23
        // 阿拉伯语
        case ar = 24
        // 越南语
        case vi = 25
        // 泰语
        case th = 26
        // 保加利亚语
        case bg = 28
        // 爱沙尼亚语
        case et = 30
        // 波斯语
        case fa = 32
        // 爱尔兰语
        case ga = 34
        // 印地语
        case hi = 35
        // 克罗地亚语
        case hr = 36
        // 印度尼西亚语
        case id = 37
        // 立陶宛语
        case lt = 40
        // 拉脱维亚语
        case lv = 41
        // 马来西亚语
        case ms = 43
        // 马耳他语
        case mt = 44
        // 罗马尼亚语
        case ro = 46
        // 斯洛伐克语
        case sk = 48
        // 塞尔维亚语
        case sr = 50
        // 乌克兰语
        case uk = 55
        // 老挝语
        case lo = 60
        // 蒙古语
        case mn = 61
        // 普什图语
        case ps = 62
        // 僧伽罗语
        case si = 63
        // 菲律宾语
        case fil = 64

    var localizedGroup: String {
        switch self {
        case .zh:
            return "zh-Hans"
        case .zh_HK:
            return "zh-HK"
        case .de:
            return "de-DE"
        case .fr:
            return "fr-FR"
        case .ja:
            return "ja-JP"
        case .cz:
            return "cs-CZ"
        case .en:
            return "en"
        case .da:
            return "da"
        case .el:
            return "el"
        case .es:
            return "es-ES"
        case .fi:
            return "fi-FI"
        case .hu:
            return "hu"
        case .it:
            return "it-IT"
        case .ko:
            return "ko-KR"
        case .nl:
            return "nl-NL"
        case .nb:
            return "nb"
        case .pl:
            return "pl-PL"
        case .pt:
            return "pt-PT"
        case .ru:
            return "ru-RU"
        case .sl:
            return "sl"
        case .sv:
            return "sv"
        case .tr:
            return "tr-TR"
        case .ar:
            return "ar"
        case .vi:
            return "vi"
        case .th:
            return "th"
        case .bg:
            return "bg-BG"
        case .et:
            return "et"
        case .fa:
            return "fa"
        case .ga:
            return "ga"
        case .hi:
            return "hi"
        case .hr:
            return "hr-HR"
        case .id:
            return "id"
        case .lt:
            return "lt"
        case .lv:
            return "lv"
        case .ms:
            return "ms"
        case .mt:
            return "mt"
        case .ro:
            return "ro"
        case .sk:
            return "sk-SK"
        case .sr:
            return "sr"
        case .uk:
            return "uk-UA"
        case .lo:
            return "lo"
        case .mn:
            return "mn"
        case .ps:
            return "ps"
        case .si:
            return "si"
        case .fil:
            return "fil"
        }
    }
    
    var serverAbbreviation: String {
        switch self {
        case .zh:
            return "CN" // 简体中文
        case .zh_HK:
            return "HK" // 繁体中文
        case .de:
            return "DE" // 德语
        case .fr:
            return "FR" // 法语
        case .ja:
            return "JP" // 日语
        case .cz:
            return "CS" // 捷克语
        case .en:
            return "EN" // 英语
        case .da:
            return "DA" // 丹麦语
        case .el:
            return "EL" // 希腊语
        case .es:
            return "ES" // 西班牙语
        case .fi:
            return "FI" // 芬兰语
        case .hu:
            return "HU" // 匈牙利语
        case .it:
            return "IT" // 意大利语
        case .ko:
            return "KO" // 韩语
        case .nl:
            return "NL" // 荷兰语
        case .nb:
            return "NO" // 挪威语
        case .pl:
            return "PL" // 波兰语
        case .pt:
            return "PT" // 葡萄牙语
        case .ru:
            return "RU" // 俄语
        case .sl:
            return "SL" // 斯洛文尼亚语
        case .sv:
            return "SE" // 瑞典语
        case .tr:
            return "TR" // 土耳其语
        case .ar:
            return "AR" // 阿拉伯语
        case .vi:
            return "VI" // 越南语
        case .th:
            return "TH" // 泰语
        case .bg:
            return "BG" // 保加利亚语
        case .et:
            return "ET" // 爱沙尼亚语
        case .fa:
            return "FA" // 波斯语
        case .ga:
            return "GA" // 爱尔兰语
        case .hi:
            return "HI" // 印地语
        case .hr:
            return "HR" // 克罗地亚语
        case .id:
            return "ID" // 印度尼西亚语
        case .lt:
            return "LT" // 立陶宛语
        case .lv:
            return "LV" // 拉脱维亚语
        case .ms:
            return "MS" // 马来西亚语
        case .mt:
            return "MT" // 马耳他语
        case .ro:
            return "RO" // 罗马尼亚语
        case .sk:
            return "SK" // 斯洛伐克语
        case .sr:
            return "SR" // 塞尔维亚语
        case .uk:
            return "UK" // 乌克兰语
        case .lo:
            return "LO" // 老挝语
        case .mn:
            return "MN" // 蒙古语
        case .ps:
            return "PS" // 普什图语
        case .si:
            return "SI" // 僧伽罗语
        case .fil:
            return "TL" // 菲律宾语
        }
    }
    
    var headKey:String {
        switch self {
        case .zh:
            return "中文"
        case .zh_HK:
            return "繁体中文"
        case .de:
            return "德语"
        case .fr:
            return  "法语"
        case .ja:
             return "日语"
        case .cz:
             return "捷克语"
        case .en:
             return "校正英文"
        case .da:
             return "丹麦语"
        case .el:
             return "希腊语"
        case .es:
             return "西班牙语"
        case .fi:
             return "芬兰语"
        case .hu:
             return "匈牙利语"
        case .it:
             return "意大利语"
        case .ko:
             return "韩语"
        case .nl:
             return "荷兰语"
        case .nb:
             return "挪威语"
        case .pl:
             return "波兰语"
        case .pt:
             return "葡萄牙语"
        case .ru:
             return "俄语"
        case .sl:
             return "斯洛文尼亚语"
        case .sv:
             return "瑞典语"
        case .tr:
             return "土耳其语"
        case .ar:
             return "阿拉伯语"
        case .vi:
             return "越南语"
        case .th:
             return "泰语"
        case .bg:
             return "保加利亚语"
        case .et:
             return "爱沙尼亚语"
        case .fa:
             return "波斯语"
        case .ga:
             return "爱尔兰语"
        case .hi:
             return "印度语"
        case .hr:
             return "克罗地亚语"
        case .id:
             return "印尼语"
        case .lt:
             return "立陶宛语"
        case .lv:
             return "拉脱维亚语"
        case .ms:
             return "马来语"
        case .mt:
             return "马耳他语"
        case .ro:
             return "罗马尼亚语"
        case .sk:
             return "斯洛伐克语"
        case .sr:
             return "塞尔维亚语"
        case .uk:
             return "乌克兰语"
        case .lo:
             return "老挝语"
        case .mn:
             return "蒙古语"
        case .ps:
             return "普什图语"
        case .si:
             return "僧伽罗语"
        case .fil:
             return "菲律宾语"
        }
    }
    
    /// 服务器语言code
    public var serverCode: String { serverInfo.cdoe }
    
    /// 服务器语言ID
    public var serverId: Int { serverInfo.id }
    
    /// 保存到userDefault里面的值
    public var stringValue: String {
        let index = TDLanguageType.allLanguages.firstIndex(of: self) ?? 0
        return TDLanguageType.allLanguageDefaults[index]
    }
    
    /// Localized.strings  lproj 目录名
    public var lproj: String {  stringValue }
    
    //MARK:   ---- internal 属性
    internal typealias SererInfo = (cdoe: String, `id`: Int, headkey: String)
    
    internal static var allLanguages: [TDLanguageType] {
        TDLanguageType.allCases
    }
    
    internal static var allLanguageDefaults: [String] {
        return allLanguages.map { $0.localizedGroup }
    }
    
    internal static var serverInfos: [SererInfo] {
        return allLanguages.map { $0.serverInfo }
    }
    
    internal var serverInfo: SererInfo {
        return (self.serverAbbreviation, self.rawValue, self.headKey)
    }
    
    // 根据userDefault里的值 创建枚举值
    public static func creat(with languageStr: String?) -> TDLanguageType {
        guard let languageStr = languageStr,
              let index = allLanguageDefaults.firstIndex(of: languageStr) else {
            return .zh
        }
        return allLanguages[index]
    }
    
    public static func creat(serviceCode: String) -> TDLanguageType? {
        guard let rawValue = serverInfos.filter { $0.0 == serviceCode }.first?.id else {
            return nil
        }
        
        return TDLanguageType(rawValue: rawValue)
    }
    
}

extension TDLanguage {
    
    /// 将系统语音 转换成 TDLanguage 传入默认值
    @objc public static func convertSystemLanguage(default language: TDLanguageType) -> TDLanguageType {
        return systemLanguage ?? language
    }
}


@objc public class TDLanguage: NSObject {
    
    /// 所有的语言类型
    public static var all: [TDLanguageType] {
        return TDLanguageType.allLanguages
    }
    
    /// 当前语言类型
    public static var current: TDLanguageType {
        get {
            UserDefaults.currentLanguage
        }
        set {
            UserDefaults.currentLanguage = newValue
        }
    }
    
    // 将当前系统语言转换成TDLanguage
    public static var systemLanguage: TDLanguageType? {
        let systemLan = AppInfo.languageCode
        guard let sysFirstCom = systemLan.components(separatedBy: "-").first else {
            return nil
        }
        
        return TDLanguageType.allLanguages.first { lanType in
            guard let lanStr = lanType.lproj.components(separatedBy: "-").first else {
                return false
            }
            return lanStr.lowercased() == systemLan.lowercased()
        }
    }
    
    /// 用户是否设置过语言
    @objc public static var hasUserSetLanguage: Bool {
        let lan = UserDefaults.standard.string(forKey: TDGlobalKey.kCurrentLanguage)
        return lan != nil
    }
    
    /// 所有语言的值 见： `TDLanguageType.allLanguageDefaults`
    @objc public class var allLanguages: [String] {
        return TDLanguageType.allLanguageDefaults
    }
    
    /// 当前语言值 `TDLanguageType.allLanguageDefaults` 中的值
    @objc public class var currentLanguage: String {
        get {
            TDLanguage.current.stringValue
        }
        set {
            let type = TDLanguageType.creat(with: newValue)
            TDLanguage.current = type
        }
    }
    
    /// 当前语言的服务器code
    @objc public class var currentLanguageCode: String {
        return TDLanguage.current.serverCode
    }
    
    /// 当前语言的服务器ID
    @objc public class var currentLanguageId: Int {
        return TDLanguage.current.serverId
    }
}

extension UserDefaults {
    
    /// 获取userDefaults 用户保存的语言
    internal static var currentLanguage: TDLanguageType {
        get {
            let value = UserDefaults.standard.string(forKey: TDGlobalKey.kCurrentLanguage)
            return TDLanguageType.creat(with: value)
        }
        set {
            UserDefaults.standard.setValue(newValue.stringValue, forKey: TDGlobalKey.kCurrentLanguage)
            UserDefaults.standard.synchronize()
        }
    }
}
