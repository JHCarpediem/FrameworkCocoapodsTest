//
//  ArtiADASTirePDF.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import Foundation
import UIKit

@objc(TDD_ArtiADASTirePDFType)
public enum ArtiADASTirePDFType: Int {
    case tirePressure
    case wheelEyebrow
}

@objc(TDD_ArtiADASTirePDFRowDataType)
public enum ArtiADASTirePDFRowDataType: Int {
    /// header 左前轮
    case position
    /// 当前
    case current
    /// 维修前
    case previous
    /// 维修后
    case posterior
}

@objc(TDD_ArtiADASTirePDFRowData)
@objcMembers
public class ArtiADASTirePDFRowData: NSObject {
    public var type: ArtiADASTirePDFType
    public var dataType: ArtiADASTirePDFRowDataType
    public var value: String
    public var unit: String
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.type = .tirePressure
        self.dataType = .current
        self.value = ""
        self.unit = ""
        
        super.init()
    }
    
    public init(type: ArtiADASTirePDFType, dataType: ArtiADASTirePDFRowDataType, value: String, unit: String) {
        self.type = type
        self.dataType = dataType
        self.value = value
        self.unit = unit
        
        super.init()
    }
    
    public var previewLeftValue: NSAttributedString {
        switch dataType {
        case .position:
            return NSAttributedString(string: value, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                                  .foregroundColor: UIColor.tdd_color666666()])
        case .current:
            let toValue = value.isEmpty ? "-" : value
            let toValueAtt = NSAttributedString(string: toValue, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                                                                              .foregroundColor: UIColor.tdd_color333333()])
            let unitAtt = NSAttributedString(string: " \(unit)", attributes: [.font: UIFont.systemFont(ofSize: 11, weight: .regular),
                                                                        .foregroundColor: UIColor.tdd_color333333()])
            let mutAtt = NSMutableAttributedString()
            mutAtt.append(toValueAtt)
            mutAtt.append(unitAtt)
            return mutAtt
        case .previous:
            // TODO: - 国际化
            return NSAttributedString(string: "校准前", attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                  .foregroundColor: UIColor.tdd_color333333()])
        case .posterior:
            // TODO: - 国际化
            return NSAttributedString(string: "校准后", attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                  .foregroundColor: UIColor.tdd_color333333()])
        }
    }
    
    public var previewRightValue: NSAttributedString? {
        switch dataType {
        case .position:
            return nil
        case .current:
            return nil
        case .previous, .posterior:
            let toValue = value.isEmpty ? "-" : value
            let toValueAtt = NSAttributedString(string: toValue, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                                                                              .foregroundColor: UIColor.tdd_color333333()])
            let unitAtt = NSAttributedString(string: " \(unit)", attributes: [.font: UIFont.systemFont(ofSize: 11, weight: .regular),
                                                                        .foregroundColor: UIColor.tdd_color333333()])
            let mutAtt = NSMutableAttributedString()
            mutAtt.append(toValueAtt)
            mutAtt.append(unitAtt)
            return mutAtt
        }
    }
    
    /// 转换历史数据的单位为当前的单位
    func convert(to unit: String) {
        switch type {
        case .tirePressure:
            convertPressure(unit)
        case .wheelEyebrow:
            convertEyebrow(unit)
        }
    }
    
    private func convertEyebrow(_ toUnit: String) {
        let eyebrowUnit: ArtiADASReportWheelEyebrowUnit
        if unit == String.mm {
            let defaultmmUnit = ArtiADASReportWheelEyebrowUnit.mm
            eyebrowUnit = .init(type: .wheelEyebrow,
                                 floatBit: defaultmmUnit.floatBit,
                                 unit: unit,
                                 lfValue: value,
                                 rfValue: "",
                                 lrValue: "",
                                 rrValue: "",
                                 lowerBound: defaultmmUnit.lowerBound,
                                 upperBound: defaultmmUnit.upperBound,
                                 isFold: false)
            
    
        } else if unit == String.cm {
            let defaultcmUnit = ArtiADASReportWheelEyebrowUnit.cm
            eyebrowUnit = .init(type: .wheelEyebrow,
                                 floatBit: defaultcmUnit.floatBit,
                                 unit: unit,
                                 lfValue: value,
                                 rfValue: "",
                                 lrValue: "",
                                 rrValue: "",
                                 lowerBound: defaultcmUnit.lowerBound,
                                 upperBound: defaultcmUnit.upperBound,
                                 isFold: false)
        } else { // inch
            let defaultInchUnit = ArtiADASReportWheelEyebrowUnit.inch
            eyebrowUnit = .init(type: .wheelEyebrow,
                                 floatBit: defaultInchUnit.floatBit,
                                 unit: unit,
                                 lfValue: value,
                                 rfValue: "",
                                 lrValue: "",
                                 rrValue: "",
                                 lowerBound: defaultInchUnit.lowerBound,
                                 upperBound: defaultInchUnit.upperBound,
                                 isFold: false)
        }
        
        let newUnit = eyebrowUnit.convert(to: toUnit)
        
        self.unit = newUnit.unit
        self.value = newUnit.lfValue
    }
    
    private func convertPressure(_ toUnit: String) {
        let tirePressure: ArtiADASReportTirePressureUnit
        if unit == String.bar {
            let defaultBar = ArtiADASReportTirePressureUnit.bar
            tirePressure = .init(type: .tirePressure,
                                 floatBit: defaultBar.floatBit,
                                 unit: unit,
                                 lfValue: value,
                                 rfValue: "",
                                 lrValue: "",
                                 rrValue: "",
                                 lowerBound: defaultBar.lowerBound,
                                 upperBound: defaultBar.upperBound,
                                 isFold: false)
        } else { // pa
            let defaultPa = ArtiADASReportTirePressureUnit.pa
            tirePressure = .init(type: .tirePressure,
                                 floatBit: defaultPa.floatBit,
                                 unit: unit,
                                 lfValue: value,
                                 rfValue: "",
                                 lrValue: "",
                                 rrValue: "",
                                 lowerBound: defaultPa.lowerBound,
                                 upperBound: defaultPa.upperBound,
                                 isFold: false)
        }
        
        let newUnit = tirePressure.convert(to: toUnit)
        
        self.unit = newUnit.unit
        self.value = newUnit.lfValue
    }
    
}


@objc(TDD_ArtiADASTirePDFPageRowData)
@objcMembers
public class ArtiADASTirePDFPageRowData: NSObject {
    
    public var type: ArtiADASTirePDFType
    
    public var rowLeft: ArtiADASTirePDFRowData
    public var rowRight: ArtiADASTirePDFRowData
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.type      = .tirePressure
        self.rowLeft   = .init()
        self.rowRight  = .init()
        
        super.init()
    }
    
    public init(type: ArtiADASTirePDFType, rowLeft: ArtiADASTirePDFRowData, rowRight: ArtiADASTirePDFRowData) {
        self.type = type
        self.rowLeft = rowLeft
        self.rowRight = rowRight
        
        super.init()
    }
}

// 左前轮、左后轮、右前轮、右后轮
@objc(TDD_ArtiADASTirePDFPositionData)
@objcMembers
public class ArtiADASTirePDFPositionData: NSObject {
    
    public class func mj_objectClassInArray() -> [String: Any] {
        return ["rows": "ArtiADASTirePDFRowData"]
    }
    
    public class func modelContainerPropertyGenericClass() -> [String: Any] {
        return ["rows": ArtiADASTirePDFRowData.classForCoder()]
    }
    
    public var rows:[ArtiADASTirePDFRowData]
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.rows = []
        super.init()
    }
    
    public init(rows: [ArtiADASTirePDFRowData]) {
        self.rows = rows
        
        super.init()
    }
    
}

/// Tire Data
@objc(TDD_ArtiADASTirePDFData)
@objcMembers
public class ArtiADASTirePDFData: NSObject {
    
    public var type: ArtiADASTirePDFType
    
    public var leftFront: ArtiADASTirePDFPositionData
    public var leftRear: ArtiADASTirePDFPositionData
    public var rightFront: ArtiADASTirePDFPositionData
    public var rightRear: ArtiADASTirePDFPositionData
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.type       = .tirePressure
        self.leftFront  = .init()
        self.leftRear   = .init()
        self.rightFront = .init()
        self.rightRear  = .init()
        
        super.init()
    }
    
    public init(type: ArtiADASTirePDFType, leftFront: ArtiADASTirePDFPositionData, leftRear: ArtiADASTirePDFPositionData, rightFront: ArtiADASTirePDFPositionData, rightRear: ArtiADASTirePDFPositionData) {
        self.type = type
        self.leftFront = leftFront
        self.leftRear = leftRear
        self.rightFront = rightFront
        self.rightRear = rightRear
        
        super.init()
    }
    
    public var asPDFPageRowDatas: [ArtiADASTirePDFPageRowData] {
        
        // left
        var list: [ArtiADASTirePDFPageRowData] = []
        for (idx, lf) in leftFront.rows.enumerated() {
            let lr = leftRear.rows[idx]
            let row: ArtiADASTirePDFPageRowData = .init(type: type, rowLeft: lf, rowRight: lr)
            list.append(row)
        }
        
        // right
        for (idx, rf) in rightFront.rows.enumerated() {
            let rr = rightRear.rows[idx]
            let row: ArtiADASTirePDFPageRowData = .init(type: type, rowLeft: rf, rowRight: rr)
            list.append(row)
        }
        
        return list
    }
    
    public func insert(historyTireData: ArtiADASTirePDFData) {
        // TODO: - 单位换算
        
        // LF
        guard let historyLFRow = historyTireData.leftFront.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first else {
            return
        }
        historyLFRow.convert(to: leftFront.rows.last?.unit ?? "")
        
        historyLFRow.dataType = .previous
        leftFront.rows.insert(historyLFRow, at: 1)
        leftFront.rows.last?.dataType = .posterior
        
        // LR
        guard let historyLRRow = historyTireData.leftRear.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first else {
            return
        }
        historyLRRow.convert(to: leftRear.rows.last?.unit ?? "")
        
        historyLRRow.dataType = .previous
        leftRear.rows.insert(historyLRRow, at: 1)
        leftRear.rows.last?.dataType = .posterior
        
        // RF
        guard let historyRFRow = historyTireData.rightFront.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first else {
            return
        }
        historyRFRow.convert(to: rightFront.rows.last?.unit ?? "")
        
        historyRFRow.dataType = .previous
        rightFront.rows.insert(historyRFRow, at: 1)
        rightFront.rows.last?.dataType = .posterior
        
        // RR
        guard let historyRRRow = historyTireData.rightRear.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first else {
            return
        }
        historyRRRow.convert(to: rightRear.rows.last?.unit ?? "")
        
        historyRRRow.dataType = .previous
        rightRear.rows.insert(historyRRRow, at: 1)
        rightRear.rows.last?.dataType = .posterior
    }
    
    public var serverJson: [String: AnyHashable] {
        guard let leftFront = self.leftFront.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first,
        let leftRear = self.leftRear.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first,
        let rightFront = self.rightFront.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first,
        let rightRear = self.rightRear.rows.filter { $0.dataType == .current || $0.dataType == .posterior }.first
        else { return [:] }
        
        switch type {
        case .tirePressure:
            return [
                "ADAS_tyre_pressure_LF": leftFront.value,
                "ADAS_tyre_pressure_LR": leftRear.value,
                "ADAS_tyre_pressure_RF": rightFront.value,
                "ADAS_tyre_pressure_RR": rightRear.value,
                "ADAS_tyre_pressure_unit": leftFront.unit,
            ]
        case .wheelEyebrow:
            return [
                "ADAS_wheel_brow_height_LF": leftFront.value,
                "ADAS_wheel_brow_height_LR": leftRear.value,
                "ADAS_wheel_brow_height_RF": rightFront.value,
                "ADAS_wheel_brow_height_RR": rightRear.value,
                "ADAS_wheel_brow_height_unit": leftFront.unit,
            ]
        }
        
    }
    
}

// MARK: - 测试数据
@objc public extension ArtiADASTirePDFData {
    
    @objc class var repairTirePressure: ArtiADASTirePDFData {
        
        let leftFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左前轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .previous, value: "2.6", unit: "bar"), .init(type: .tirePressure, dataType: .posterior, value: "2.5", unit: "bar")])
        let leftRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左后轮", unit: ""),
                                                          .init(type: .tirePressure, dataType: .previous, value: "2.8", unit: "bar"), .init(type: .tirePressure, dataType: .posterior, value: "2.5", unit: "bar")])
        let rightFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右前轮", unit: ""),
                                                            .init(type: .tirePressure, dataType: .previous, value: "2.7", unit: "bar"), .init(type: .tirePressure, dataType: .posterior, value: "2.5", unit: "bar")])
        let rightRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右后轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .previous, value: "2.9", unit: "bar"), .init(type: .tirePressure, dataType: .posterior, value: "2.5", unit: "bar")])
        
        return .init(type: .tirePressure,
                     leftFront: leftFront,
                     leftRear: leftRear,
                     rightFront: rightFront,
                     rightRear: rightRear)
    }
    
    @objc class var tirePressure: ArtiADASTirePDFData {
        
        let leftFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左前轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .current, value: "2.6", unit: "bar")])
        let leftRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左后轮", unit: ""),
                                                          .init(type: .tirePressure, dataType: .current, value: "2.8", unit: "bar")])
        let rightFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右前轮", unit: ""),
                                                            .init(type: .tirePressure, dataType: .current, value: "2.7", unit: "bar")])
        let rightRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右后轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .current, value: "2.9", unit: "bar")])
        
        return .init(type: .tirePressure,
                     leftFront: leftFront,
                     leftRear: leftRear,
                     rightFront: rightFront,
                     rightRear: rightRear)
    }
    
    @objc class var repairWheelEyebrow: ArtiADASTirePDFData {
        
        let leftFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左前轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .previous, value: "13", unit: "cm"), .init(type: .tirePressure, dataType: .posterior, value: "10", unit: "cm")])
        let leftRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左后轮", unit: ""),
                                                          .init(type: .tirePressure, dataType: .previous, value: "12", unit: "cm"), .init(type: .tirePressure, dataType: .posterior, value: "2.5", unit: "bar")])
        let rightFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右前轮", unit: ""),
                                                            .init(type: .tirePressure, dataType: .previous, value: "", unit: "cm"), .init(type: .tirePressure, dataType: .posterior, value: "11", unit: "cm")])
        let rightRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右后轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .previous, value: "12", unit: "cm"), .init(type: .tirePressure, dataType: .posterior, value: "10", unit: "cm")])
        
        return .init(type: .tirePressure,
                     leftFront: leftFront,
                     leftRear: leftRear,
                     rightFront: rightFront,
                     rightRear: rightRear)
    }
    
    @objc class var wheelEyebrow: ArtiADASTirePDFData {
        
        let leftFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左前轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .current, value: "11", unit: "cm")])
        let leftRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "左后轮", unit: ""),
                                                          .init(type: .tirePressure, dataType: .current, value: "11", unit: "cm")])
        let rightFront = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右前轮", unit: ""),
                                                            .init(type: .tirePressure, dataType: .current, value: "12", unit: "cm")])
        let rightRear = ArtiADASTirePDFPositionData(rows: [.init(type: .tirePressure, dataType: .position, value: "右后轮", unit: ""),
                                                           .init(type: .tirePressure, dataType: .current, value: "12", unit: "cm")])
        
        return .init(type: .tirePressure,
                     leftFront: leftFront,
                     leftRear: leftRear,
                     rightFront: rightFront,
                     rightRear: rightRear)
    }
    
}
