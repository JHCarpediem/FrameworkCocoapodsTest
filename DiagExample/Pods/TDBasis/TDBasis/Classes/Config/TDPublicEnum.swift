//
//  TDPublicEnum.swift
//  TDBasis
//
//  Created by Fench on 2025/8/14.
//

import Foundation

//MARK: 产品型号对应id关系
@objc
public enum TDProductType: Int {
    case TopScan = 1255
    case TopScanPro = 1514
    case TopScanMoto = 1577
    case TopVCI = 1609
    case SmallCarPro = 1724
    case SmallCarProMoto = 1767
    case AD500 = 271
    case AD500s = 68
    case AD600 = 270
    case AD600s = 67
    case AD700 = 269
    case TNinjaPro = 876
    case UltraDiag = 1258
    case AD900Lite = 1397
    case TC007 = 1783
    case BTMobileLite = 839
    case BT100W = 1070
    case BTMobilePro = 150
    case TB6000Pro = 1083
    case BT20 = 833
    case CarPal = 1764
    case CarPalGuru = 1852
    case ArtiDiag800BT2 = 1847
    case ArtiDiagMoto = 1948
    case ArtiDiag600Pro = 1993
    case TC001 = 950
    case TC002 = 951
    case TS004 = 1733
    case TC002CDuo = 2062
    case ArtiDiag600Elite = 2013
    case UltraDiagMoto = 2038
    case DeepScan = 2071
    case TOPDONONE = 2118
    case TDarts = 1206
    case BTMobilePros = 149
    case DS200 = 2153
    case DS100 = 2152
    case ArtiDiag500BMS = 2119
    case DS900 = 2158
    case RLinkLite = 1456
    case RLinkPro = 1487
    case RlinkX7 = 1791
    case RlinkJ2534 = 1790

    public var productId: Int { rawValue }
    public var testProcutId: Int {
        switch self {
        case .TC007:
            return 1801
        case .CarPal:
            return 1773
        case .CarPalGuru:
            return 1806
        case .ArtiDiag800BT2:
            return 1805
        case .ArtiDiagMoto:
            return 1809
        case .ArtiDiag600Pro:
            return 1820
        case .TS004:
            return 1695
        case .TC002CDuo:
            return 1838
        case .ArtiDiag600Elite:
            return 1821
        case .UltraDiagMoto:
            return 1836
        case .DeepScan:
            return 1837
        case .TOPDONONE:
            return 1846
        case .DS200:
            return 1851
        case .DS100:
            return 1852
        case .ArtiDiag500BMS:
            return 1853
        case .RlinkX7:
            return 1776
        case .RlinkJ2534:
            return 1807
        default:
            return rawValue
        }
    }
}

//MARK: 软件类型
@objc
public enum TDSoftType: Int {
    case DIAG = 0
    case FirmwareSW = 1
    case ToolsSW = 2
    case DisplaySW = 3
    case OSSW = 4
    case PublicSW = 5
    case BurnSW = 6
    case BootSW = 7
    case FactorySW = 8
    case CarHDSW = 10
    case ADAS = 11
    case CarEVSW = 12
    case IMMO = 13
    case Motor = 14
    case TDarts = 15
    case CarCustomizeSW = 16
    
    public var softTypeId: Int { rawValue }
    
    public var softTypeName: String {
        switch self {
        case .DIAG: return "CarSW"
        case .FirmwareSW: return "FirmwareSW"
        case .ToolsSW: return "ToolsSW"
        case .DisplaySW: return "DisplaySW"
        case .OSSW: return "OSSW"
        case .PublicSW: return "PublicSW"
        case .BurnSW: return "BurnSW"
        case .BootSW: return "BootSW"
        case .FactorySW: return "FactorySW"
        case .CarHDSW: return "CarHDSW"
        case .ADAS: return "CarADASSW"
        case .CarEVSW: return "CarEVSW"
        case .IMMO: return "CarIMMOSW"
        case .Motor: return "CarMOTOSW"
        case .TDarts: return "CarRFIDSW"
        case .CarCustomizeSW: return "CarCustomizeSW"
        }
    }
}

//MARK: 诊断类型拓展
extension TDSoftType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .DIAG:
            return "diagnostic"
        case .IMMO:
            return "IMMO"
        case .Motor:
            return "Motor"
        case .TDarts:
            return "T-Darts"
        case .ADAS:
            return "ADAS"
        default:
            return softTypeName
        }
    }
    
    public var vehiclePathName: String? {
        switch self {
        case .DIAG:
            return "Diagnosis"
        case .IMMO:
            return "Immo"
        case .Motor:
            return "MOTOR"
        case .TDarts:
            return "RFID"
        case .ADAS:
            return ""
        default:
            return nil
        }
    }
    
    public var strType: String? {
        switch self {
        case .DIAG:
            return "DIAG"
        case .IMMO:
            return "IMMO"
        case .Motor:
            return "Motor"
        case .TDarts:
            return "T-Darts"
        case .ADAS:
            return ""
        default:
            return nil
        }
    }
    
    public var fileName: String {
        switch self {
        case .DIAG:
            return "DIAG.json"
        case .IMMO:
            return "IMMO.json"
        case .Motor:
            return "MOTO.json"
        case .TDarts:
            return "IMMO.json"
        case .ADAS:
            return ""
        default:
            return ""
        }
    }
    
    public init?(diagType: String) {
        switch diagType {
        case "DIAG":
            self = .DIAG
        case "IMMO":
            self = .IMMO
        case "Motor":
            self = .Motor
        case "T-Darts":
            self = .TDarts
        case "ADAS":
            self = .ADAS
        default:
            return nil
        }
    }
    
}

//MARK: 软件类型计算值
//软件类型掩码值    软件类型名称
@objc
public enum TDSoftTypeMask: Int {
    case CarSW = 2
    case CarHDSW = 8
    case CarADASSW = 32
    case CarEVSW = 16
    case CarIMMOSW = 1
    case CarMOTOSW = 4
    case CarCustomizeSW = 64
    
    public var softTypeMaskId: Int { rawValue }
    
    public var softTypeName: String {
        switch self {
        case .CarSW: return "CarSW"
        case .CarHDSW: return "CarHDSW"
        case .CarADASSW: return "CarADASSW"
        case .CarEVSW: return "CarEVSW"
        case .CarIMMOSW: return "CarIMMOSW"
        case .CarMOTOSW: return "CarMOTOSW"
        case .CarCustomizeSW: return "CarCustomizeSW"
        }
    }
}

//MARK: 货币类型
@objc
public enum TDCurrencyType: Int {
    /// 澳元
    case AUD = 1
    /// 巴西
    case BRL
    /// 加币
    case CAD
    /// 捷克币
    case CZK
    /// 丹麦币
    case DKK
    /// 欧元
    case EUR
    /// 港币
    case HKD
    /// 匈牙利
    case HUF
    /// 以色列
    case ILS
    /// 日元
    case JPY
    /// 马来西亚币
    case MYR
    /// 墨西哥
    case MXN
    /// 台币
    case TWD
    /// 新西兰币
    case NZD
    /// 挪威
    case NOK
    /// 菲律宾
    case PHP
    /// 波兰
    case PLN
    /// 英镑
    case GBP
    /// 俄罗斯
    case RUB
    /// 新加坡
    case SGD
    /// 瑞典
    case SEK
    /// 瑞士法郎
    case CHF
    /// 泰铢
    case THB
    /// 美金
    case USD
    /// 人民币
    case CNY
    
    public var currencyId: Int { rawValue }
    
    public var currencyName: String {
        switch self {
        case .AUD: return "澳元"
        case .BRL: return "巴西"
        case .CAD: return "加币"
        case .CZK: return "捷克币"
        case .DKK: return "丹麦币"
        case .EUR: return "欧元"
        case .HKD: return "港币"
        case .HUF: return "匈牙利"
        case .ILS: return "以色列"
        case .JPY: return "日元"
        case .MYR: return "马来西亚币"
        case .MXN: return "墨西哥"
        case .TWD: return "台币"
        case .NZD: return "新西兰币"
        case .NOK: return "挪威"
        case .PHP: return "菲律宾"
        case .PLN: return "波兰"
        case .GBP: return "英镑"
        case .RUB: return "俄罗斯"
        case .SGD: return "新加坡"
        case .SEK: return "瑞典"
        case .CHF: return "瑞士法郎"
        case .THB: return "泰铢"
        case .USD: return "美金"
        case .CNY: return "人民币"
        }
    }
}
