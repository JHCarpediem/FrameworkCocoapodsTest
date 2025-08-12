//
//  TDDHLanguage.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/11/20.
//

import Foundation

/*
 typedef enum {
 TDD_HLanguageType_en = 0,//英语
 TDD_HLanguageType_ja,    //日语
 TDD_HLanguageType_ru,    //俄语
 TDD_HLanguageType_de,    //德语
 TDD_HLanguageType_pt,    //葡萄牙语
 TDD_HLanguageType_es,    //西班牙语
 TDD_HLanguageType_fr,    //法语
 TDD_HLanguageType_zh,    //简体中文
 TDD_HLanguageType_zh_HK, //繁体中文
 TDD_HLanguageType_it,    //意大利语
 TDD_HLanguageType_pl,     //波兰语
 TDD_HLanguageType_ko,      // 韩语
 TDD_HLanguageType_cz,    //捷克语
 TDD_HLanguageType_uk,    //乌克兰语
 TDD_HLanguageType_nl,    //荷兰语
 TDD_HLanguageType_tr,    //土耳其语
 TDD_HLanguageType_da,    //丹麦
 TDD_HLanguageType_nb,    //挪威语
 TDD_HLanguageType_sv,    //瑞典语
 TDD_HLanguageType_ar,    //阿拉伯语
 TDD_HLanguageType_sk,    //斯洛伐克语
 TDD_HLanguageType_fi,    //芬兰语
 TDD_HLanguageType_sr,    //塞尔维亚语
 TDD_HLanguageType_hr,    //克罗地亚语
 TDD_HLanguageType_bg,    //保加利亚
 TDD_HLanguageType_se,   // 瑞典语
 } TDD_HLanguageType;
 
 */
@objc
public enum TDDHLanguageType: Int {
    /// 简体中文
    case chinese            = 1
    /// 中文繁体
    case chineseTraditional = 2
    /// 德语
    case german             = 3
    /// 法语
    case french             = 4
    /// 日语
    case japanese           = 5
    /// 捷克
    case czech              = 6
    /// 英语
    case english            = 7
    /// 丹麦语
    case danish             = 8
    /// 希腊语
    case greek              = 9
    /// 西班牙语
    case spanish            = 10
    /// 芬兰语
    case finnish            = 11
    /// 匈牙利语
    case hungarian          = 13
    /// 意大利语
    case italian            = 14
    /// 韩语
    case korean             = 15
    /// 荷兰语
    case dutch              = 16
    /// 挪威语
    case norwegian          = 17
    /// 波兰语
    case polish             = 18
    /// 葡萄牙语
    case portuguese         = 19
    /// 俄语
    case russian            = 20
    /// 斯洛文尼亚语
    case slovenian          = 21
    /// 瑞典语
    case swedish            = 22
    /// 土耳其语
    case turkish            = 23
    /// 阿拉伯语
    case arabic             = 24
    /// 越南语
    case vietnamese         = 25
    /// 泰语
    case thai               = 26
    /// 保加利亚语
    case bulgarian          = 28
    /// 爱沙尼亚语
    case estonian           = 30
    /// 波斯语
    case persian            = 32
    /// 爱尔兰语
    case irish              = 34
    /// 印地语
    case hindi              = 35
    /// 克罗地亚语
    case croatian           = 36
    /// 印度尼西亚语
    case indonesian         = 37
    /// 立陶宛语
    case lithuanian         = 40
    /// 拉脱维亚语
    case lettish            = 41
    /// 马来西亚语
    case malaysia           = 43
    /// 马耳他语
    case malti              = 44
    /// 罗马尼亚语
    case romanian           = 46
    /// 斯洛伐克语
    case slovak             = 48
    /// 塞尔维亚语
    case serbian            = 50
    /// 乌克兰语
    case ukrainian          = 55
    /// 老挝语
    case lao                = 60
    /// 蒙古语
    case mongolian          = 61
    /// 普什图语
    case pushtu             = 62
    /// 僧伽罗语
    case sinhala            = 63
    /// 菲律宾语
    case filipino           = 64
    
    var localizedGroup: String {
        switch self {
        case .chinese:
            return "zh-Hans"
        case .chineseTraditional:
            return "zh-HK"
        case .german:
            return "de-DE"
        case .french:
            return "fr-FR"
        case .japanese:
            return "ja-JP"
        case .czech:
            return "cs-CZ"
        case .english:
            return "en"
        case .danish:
            return "da"
        case .greek:
            return "el"
        case .spanish:
            return "es-ES"
        case .finnish:
            return "fi-FI"
        case .hungarian:
            return "hu"
        case .italian:
            return "it-IT"
        case .korean:
            return "ko-KR"
        case .dutch:
            return "nl-NL"
        case .norwegian:
            return "nb"
        case .polish:
            return "pl-PL"
        case .portuguese:
            return "pt-PT"
        case .russian:
            return "ru-RU"
        case .slovenian:
            return "sl"
        case .swedish:
            return "sv"
        case .turkish:
            return "tr-TR"
        case .arabic:
            return "ar"
        case .vietnamese:
            return "vi"
        case .thai:
            return "th"
        case .bulgarian:
            return "bg-BG"
        case .estonian:
            return "et"
        case .persian:
            return "fa"
        case .irish:
            return "ga"
        case .hindi:
            return "hi"
        case .croatian:
            return "hr-HR"
        case .indonesian:
            return "id"
        case .lithuanian:
            return "lt"
        case .lettish:
            return "lv"
        case .malaysia:
            return "ms"
        case .malti:
            return "mt"
        case .romanian:
            return "ro"
        case .slovak:
            return "sk-SK"
        case .serbian:
            return "sr"
        case .ukrainian:
            return "uk-UA"
        case .lao:
            return "lo"
        case .mongolian:
            return "mn"
        case .pushtu:
            return "ps"
        case .sinhala:
            return "si"
        case .filipino:
            return "fil"
        }
    }
    
    var serverAbbreviation: String {
        switch self {
        case .chinese:
            return "CN" // 简体中文
        case .chineseTraditional:
            return "HK" // 繁体中文
        case .german:
            return "DE" // 德语
        case .french:
            return "FR" // 法语
        case .japanese:
            return "JP" // 日语
        case .czech:
            return "CS" // 捷克语
        case .english:
            return "EN" // 英语
        case .danish:
            return "DA" // 丹麦语
        case .greek:
            return "EL" // 希腊语
        case .spanish:
            return "ES" // 西班牙语
        case .finnish:
            return "FI" // 芬兰语
        case .hungarian:
            return "HU" // 匈牙利语
        case .italian:
            return "IT" // 意大利语
        case .korean:
            return "KO" // 韩语
        case .dutch:
            return "NL" // 荷兰语
        case .norwegian:
            return "NO" // 挪威语
        case .polish:
            return "PL" // 波兰语
        case .portuguese:
            return "PT" // 葡萄牙语
        case .russian:
            return "RU" // 俄语
        case .slovenian:
            return "SL" // 斯洛文尼亚语
        case .swedish:
            return "SV" // 瑞典语
        case .turkish:
            return "TR" // 土耳其语
        case .arabic:
            return "AR" // 阿拉伯语
        case .vietnamese:
            return "VI" // 越南语
        case .thai:
            return "TH" // 泰语
        case .bulgarian:
            return "BG" // 保加利亚语
        case .estonian:
            return "ET" // 爱沙尼亚语
        case .persian:
            return "FA" // 波斯语
        case .irish:
            return "GA" // 爱尔兰语
        case .hindi:
            return "HI" // 印地语
        case .croatian:
            return "HR" // 克罗地亚语
        case .indonesian:
            return "ID" // 印度尼西亚语
        case .lithuanian:
            return "LT" // 立陶宛语
        case .lettish:
            return "LV" // 拉脱维亚语
        case .malaysia:
            return "MS" // 马来西亚语
        case .malti:
            return "MT" // 马耳他语
        case .romanian:
            return "RO" // 罗马尼亚语
        case .slovak:
            return "SK" // 斯洛伐克语
        case .serbian:
            return "SR" // 塞尔维亚语
        case .ukrainian:
            return "UK" // 乌克兰语
        case .lao:
            return "LO" // 老挝语
        case .mongolian:
            return "MN" // 蒙古语
        case .pushtu:
            return "PS" // 普什图语
        case .sinhala:
            return "SI" // 僧伽罗语
        case .filipino:
            return "TL" // 菲律宾语
        }
    }
}

// MARK: - TDDHLanguage

@objc
@objcMembers
public class TDDHLanguage: NSObject {
    
    public var type: TDDHLanguageType = .english
    
    public init(type: TDDHLanguageType) {
        self.type = type
    }
    
    public var serverCode: Int {
        type.rawValue
    }
    
    public var localizedGroup: String {
        type.localizedGroup
    }
    
    public var serverAbbreviation: String {
        type.serverAbbreviation
    }
    
    public static func allSupportLanguageTypes() -> [TDDHLanguageType] {
        [
            .english,
            .french,
            .spanish,
            .german,
            .italian,
            .russian,
            .portuguese,
            .polish,
            .japanese,
            .korean,
            .chinese,
            .chineseTraditional,
            .czech,
            .ukrainian,
            .dutch,
            .turkish,
            .danish,
            .norwegian,
            .swedish,
            .arabic,
            .slovak,
            .finnish,
            .serbian,
            .croatian,
            .bulgarian,
            .irish,
            .estonian,
            .persian,
            .filipino,
            .lettish,
            .lao,
            .lithuanian,
            .romanian,
            .malti,
            .malaysia,
            .mongolian,
            .pushtu,
            .sinhala,
            .slovenian,
            .thai,
            .greek,
            .hungarian,
            .hindi,
            .indonesian,
            .vietnamese
        ]
    }
    
    public static func allSupportLanguages() -> [TDDHLanguage] {
        allSupportLanguageTypes().map { TDDHLanguage(type: $0) }
    }
    
    public static func allSupportLanguageLocalizedGroups() -> [String] {
        allSupportLanguageTypes().map { $0.localizedGroup }
    }
    
    @objc public static let allLanguageTypeDict: [String: String] = {
        var dict = [String: String]()
        allSupportLanguageTypes().forEach { langType in
            let key = "text_\(langType.serverAbbreviation.lowercased()).dat"
            dict[key] = String(langType.localizedGroup)
        }
        return dict
    }()
    
    @objc public static func allLanguageTypeValue() -> [String : String] {
        return allLanguageTypeDict
    }
    
    /// 根据 localized group 获取语言，默认 英语 保底
    public static func language(localizedGroup: String) -> TDDHLanguage {
        let language = allSupportLanguages().first { $0.localizedGroup == localizedGroup } ?? TDDHLanguage(type: .english)
        return language
    }
    
    public static func language(type: TDDHLanguageType) -> TDDHLanguage {
        allSupportLanguages().first { $0.type == type } ?? TDDHLanguage(type: .english)
    }
    
}
