//
//  ArtiADASReportFuel.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/14.
//

import Foundation

@objc(TDD_ArtiADASReportFuelType)
public enum ArtiADASReportFuelType: Int {
    /// 当前
    case current
    /// 维修前
    case previous
    /// 维修后
    case posterior
}


@objc(TDD_ArtiADASReportFuel)
@objcMembers
public class ArtiADASReportFuel: NSObject {
    
    public var type: ArtiADASReportFuelType = .current
    
    /// 0-100, 仅支持整数
    public var percent: String
    public var imagePath: String = ""
    public var isFold: Bool
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.type       = .current
        self.percent    = ""
        self.imagePath  = ""
        self.isFold     = false
        
        super.init()
    }
    
    public init(percent: String, imagePath: String, isFold: Bool) {
        self.percent = percent
        self.imagePath = imagePath
        self.isFold = isFold
        self.type = .current
        
        super.init()
    }
    
    public var sectionTitle: String {
        // TODO: - 国际化
        switch type {
        case .current:
            return "燃油表"
        case .previous:
            return "燃油表 (校准前)"
        case .posterior:
            return "燃油表 (校准后)"
        }
    }
    
    public var displayPercent: String {
        percent.isEmpty ? "-" : percent
    }
    
    public var serverJson: [String: AnyHashable] {
        let percentStr: String
        if percent.isEmpty {
            percentStr = ""
        } else {
            let fValue = Float(percent) ?? 0
            let iValue = Int(fValue / 10.0)
            percentStr = "\(iValue)"
        }
        return [
            "ADAS_fuel_level": percentStr,
            "ADAS_fuel_picture": imagePath,
        ]
    }
}

// MARK: - 测试数据

@objc public extension ArtiADASReportFuel {
    
    public static var current: ArtiADASReportFuel {
        .init(percent: "65", imagePath: "", isFold: false)
    }
    
    public static var previous: ArtiADASReportFuel {
        let model = ArtiADASReportFuel.init(percent: "65", imagePath: "", isFold: false)
        model.type = .previous
        return model
    }
    
    public static var posterior: ArtiADASReportFuel {
        let model = ArtiADASReportFuel.init(percent: "75", imagePath: "", isFold: false)
        model.type = .posterior
        return model
    }
    
}
