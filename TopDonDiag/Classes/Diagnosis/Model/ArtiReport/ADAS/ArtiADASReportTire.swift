//
//  ArtiADASReportTire.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/13.
//

import UIKit

// MARK: - ArtiADASReportTireUnit

@objc(TDD_ArtiADASTireUnitType)
public enum ArtiADASTireUnitType: Int {
    case tirePressure
    case wheelEyebrow
    
    var asPDFType: ArtiADASTirePDFType {
        switch self {
        case .tirePressure:
            return .tirePressure
        case .wheelEyebrow:
            return .wheelEyebrow
        }
    }
    
}

@objc(TDD_ArtiADASTirePosition)
public enum ArtiADASTirePosition: Int {
    case leftFront  // lf
    case rightFront // rf
    case leftRear   // lr
    case rightRear  // rr
}

@objc(TDD_ArtiADASReportTireUnit)
@objcMembers
public class ArtiADASReportTireUnit: NSObject {
    
    public var type: ArtiADASTireUnitType
    
    // 小数点支持位数：0或者1
    public var floatBit: Int
    
    public var unit: String
    
    public var lfValue: String
    public var rfValue: String
    public var lrValue: String
    public var rrValue: String
    
    public var lowerBound: String
    public var upperBound: String
    
    // MARK: - UI
    public var isFold: Bool = false
    
    // MARK: - Geter
    public func displayValue(position: ArtiADASTirePosition) -> String {
        
        let value: String
        switch position {
        case .leftFront:
            value = lfValue
        case .rightFront:
            value = rfValue
        case .leftRear:
            value = lrValue
        case .rightRear:
            value = rrValue
        }
        
        if value.isEmpty { return value }
        
        if floatBit == 0 {
            if let floatValue = value.i18nFloat {
                return value.intValue()
            } else {
                return ""
            }
        } else {
            return value
        }
    }
    
    public init(type: ArtiADASTireUnitType,
                floatBit: Int,
                unit: String,
                lfValue: String,
                rfValue: String,
                lrValue: String,
                rrValue: String,
                lowerBound: String,
                upperBound: String,
                isFold: Bool) {
        self.type = type
        self.floatBit = floatBit
        self.unit = unit
        self.lfValue = lfValue
        self.rfValue = rfValue
        self.lrValue = lrValue
        self.rrValue = rrValue
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.isFold = isFold
    }
    
    public func update(other unit: ArtiADASReportTireUnit) {
        type = unit.type
        floatBit = unit.floatBit
        self.unit = unit.unit
        lfValue = unit.lfValue
        rfValue = unit.rfValue
        lrValue = unit.lrValue
        rrValue = unit.rrValue
        lowerBound = unit.lowerBound
        upperBound = unit.upperBound
        isFold = unit.isFold
    }
    
    public func convert(to unit: String) -> ArtiADASReportTireUnit {
        // 子类实现
        fatalError("子类重写")
    }
    
    // MARK: - Editor to Preview
    public var asADASTirePDFData: ArtiADASTirePDFData? {
        
        guard !unit.isEmpty else { return nil }
        
        if rfValue.isEmpty && lrValue.isEmpty && rfValue.isEmpty && rrValue.isEmpty {
            return nil
        }
        
        let pdfType = type.asPDFType
        
        // TODO: - 国际化
        
        // 左前轮
        let lfPosData: ArtiADASTirePDFPositionData = .init(rows: [.init(type: pdfType, dataType: .position, value: "左前轮", unit: ""),
                                                                  .init(type: pdfType, dataType: .current, value: displayValue(position: .leftFront), unit: unit)])
        // 左后轮
        let lrPosData: ArtiADASTirePDFPositionData = .init(rows: [.init(type: pdfType, dataType: .position, value: "左后轮", unit: ""),
                                                                  .init(type: pdfType, dataType: .current, value: displayValue(position: .leftRear), unit: unit)])
        // 右前轮
        let rfPosData: ArtiADASTirePDFPositionData = .init(rows: [.init(type: pdfType, dataType: .position, value: "右前轮", unit: ""),
                                                                  .init(type: pdfType, dataType: .current, value: displayValue(position: .rightFront), unit: unit)])
        // 右后轮
        let rrPosData: ArtiADASTirePDFPositionData = .init(rows: [.init(type: pdfType, dataType: .position, value: "右后轮", unit: ""),
                                                                  .init(type: pdfType, dataType: .current, value: displayValue(position: .rightRear), unit: unit)])
        
        return .init(type: pdfType,
                     leftFront: lfPosData,
                     leftRear: lrPosData,
                     rightFront: rfPosData,
                     rightRear: rrPosData)
    }
    
}

// MARK: - Bound

extension ArtiADASReportTireUnit {
    
    func defaultBound(unit: String) -> (lowerBound: String, upperBound: String, divisor: Float?) {
        switch unit {
        case String.mm:
            return ("500", "1000", nil)
        case String.cm:
            return ("50", "100", nil)
        case String.inch:
            return ("197", "394", 10)
        case String.pa:
            return ("100000", "400000", nil)
        case String.bar:
            return ("10", "40", 10)
        default:
            return ("100000", "400000", nil)
        }
    }
    
    /// float 转换小数点为整数 String / divisor
    ///  int divisor == nil
    func bound(minValue: String, maxValue: String, divisor: Float?, value: String) -> String {
        
        if value.isEmpty { return value }
        
        if let divisor = divisor {
            
            let formatter = NumberFormatter.unitFloatFormatter()
            let lowerBoundFloat = (formatter.number(from: minValue)?.floatValue ?? 0) / divisor
            let upperBoundFloat = (formatter.number(from: maxValue)?.floatValue ?? 0) / divisor
            
//            let i18nLowerBound = lowerBoundFloat.floatUnitValue()
//            let i18nUpperBound = upperBoundFloat.floatUnitValue()
            
            let valueFloat = formatter.number(from: value)?.floatValue ?? 0
         
            return max(lowerBoundFloat, min(upperBoundFloat, valueFloat)).floatUnitValue()
        } else {
            let lowerBoundInt = minValue.i18nIntValue
            let upperBoundInt = maxValue.i18nIntValue
            
            let valueInt = value.i18nIntValue
            
            return "\(max(lowerBoundInt, min(upperBoundInt, valueInt)))"
        }
    }
    
}

// MARK: - TDD_ArtiADASReportWheelEyebrowUnit

@objc(TDD_ArtiADASReportWheelEyebrowUnit)
@objcMembers
public class ArtiADASReportWheelEyebrowUnit: ArtiADASReportTireUnit {
    
    public class var mm: ArtiADASReportWheelEyebrowUnit {
        let eLowerBound = "500"
        let eUpperBound = "1000"
        
        let formatter = NumberFormatter.unitFloatFormatter()
        let lowerBoundFloat = (formatter.number(from: eLowerBound)?.floatValue ?? 500)
        let upperBoundFloat = (formatter.number(from: eUpperBound)?.floatValue ?? 1000)
        
        var i18nLowerBound = lowerBoundFloat.intUnitValue()
        if i18nLowerBound.isEmpty { i18nLowerBound = eLowerBound }
        
        var i18nUpperBound = upperBoundFloat.intUnitValue()
        if i18nUpperBound.isEmpty { i18nUpperBound = eUpperBound }
        
        return ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                              floatBit: 0,
                                              unit: String.mm,
                                              lfValue: "",
                                              rfValue: "",
                                              lrValue: "",
                                              rrValue: "",
                                              lowerBound: i18nLowerBound,
                                              upperBound: i18nUpperBound,
                                              isFold: false)
    }
    
    public class var cm: ArtiADASReportWheelEyebrowUnit {
        let eLowerBound = "50"
        let eUpperBound = "100"
        
        let formatter = NumberFormatter.unitFloatFormatter()
        let lowerBoundFloat = (formatter.number(from: eLowerBound)?.floatValue ?? 50)
        let upperBoundFloat = (formatter.number(from: eUpperBound)?.floatValue ?? 100)
        
        var i18nLowerBound = lowerBoundFloat.intUnitValue()
        if i18nLowerBound.isEmpty { i18nLowerBound = eLowerBound }
        
        var i18nUpperBound = upperBoundFloat.intUnitValue()
        if i18nUpperBound.isEmpty { i18nUpperBound = eUpperBound }
        return ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                              floatBit: 0,
                                              unit: String.cm,
                                              lfValue: "",
                                              rfValue: "",
                                              lrValue: "",
                                              rrValue: "",
                                              lowerBound: i18nLowerBound,
                                              upperBound: i18nUpperBound,
                                              isFold: false)
    }
    
    public class var inch: ArtiADASReportWheelEyebrowUnit {
        let formatter = NumberFormatter.unitFloatFormatter()
        let lowerBoundFloat = (formatter.number(from: "197")?.floatValue ?? 197) / 10
        let upperBoundFloat = (formatter.number(from: "394")?.floatValue ?? 394) / 10
        
        var i18nLowerBound = lowerBoundFloat.floatUnitValue()
        if i18nLowerBound.isEmpty { i18nLowerBound = "19.7" }
        
        var i18nUpperBound = upperBoundFloat.floatUnitValue()
        if i18nUpperBound.isEmpty { i18nUpperBound = "39.4" }
        
        return ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                              floatBit: 1,
                                              unit: String.inch,
                                              lfValue: "",
                                              rfValue: "",
                                              lrValue: "",
                                              rrValue: "",
                                              lowerBound: i18nLowerBound,
                                              upperBound: i18nUpperBound,
                                              isFold: false)
    }
    
    override public func convert(to unit: String) -> ArtiADASReportTireUnit {
        let validUnits: [String] = [.mm, .cm, .inch]
        
        guard validUnits.contains(unit) else {
            fatalError("unit is not supported")
        }
        
        func copy() -> ArtiADASReportWheelEyebrowUnit {
            return ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                                  floatBit: floatBit,
                                                  unit: self.unit,
                                                  lfValue: lfValue,
                                                  rfValue: rfValue,
                                                  lrValue: lrValue,
                                                  rrValue: rrValue,
                                                  lowerBound: lowerBound,
                                                  upperBound: upperBound,
                                                  isFold: isFold)
        }
        
        func cmTomm(value: String) -> String {
            if value.isEmpty {
                return value
            } else {
                let tValue = (value.i18nFloatValue * 10).floatUnitValue().intValue()
                let mmBound = defaultBound(unit: String.mm)
                return bound(minValue: mmBound.lowerBound, maxValue: mmBound.upperBound, divisor: mmBound.divisor, value: tValue)
            }
        }
        
        func inchTomm(value: String) -> String {
            if value.isEmpty {
                return value
            } else {
                let tValue = (value.i18nFloatValue * 25.4).floatUnitValue().intValue()
                let mmBound = defaultBound(unit: String.mm)
                return bound(minValue: mmBound.lowerBound, maxValue: mmBound.upperBound, divisor: mmBound.divisor, value: tValue)
            }
        }
        
        func mmTocm(value: String) -> String {
            if value.isEmpty { 
                return value
            } else { 
                let tValue = (value.i18nFloatValue / 10).floatUnitValue().intValue()
                let cmBound = defaultBound(unit: String.cm)
                return bound(minValue: cmBound.lowerBound, maxValue: cmBound.upperBound, divisor: cmBound.divisor, value: tValue)
            }
        }
        
        func mmToinch(value: String) -> String {
            if value.isEmpty {
                return value
            } else {
                let tValue = (value.i18nFloatValue / 25.4).floatUnitValue()
                let inchBound = defaultBound(unit: String.inch)
                return bound(minValue: inchBound.lowerBound, maxValue: inchBound.upperBound, divisor: inchBound.divisor, value: tValue)
            }
        }
        
        
        
        if unit == self.unit {
            return copy()
        }
        
        // 1 inch = 25.4 mm
        // 先转换为 mm
        let mmModel: ArtiADASReportWheelEyebrowUnit
        if self.unit.isMm {
            mmModel = copy()
        } else if self.unit.isCm { // cm to mm
            let defaultMM = Self.mm
            
            let lfStrValue = displayValue(position: .leftFront)
            let newLfValue = cmTomm(value: lfStrValue)
            
            let rfStrValue = displayValue(position: .rightFront)
            let newRfValue = cmTomm(value: rfStrValue)
            
            let lrStrValue = displayValue(position: .leftRear)
            let newLrValue = cmTomm(value: lrStrValue)
            
            let rrStrValue = displayValue(position: .rightRear)
            let newRrValue = cmTomm(value: rrStrValue)
            
            mmModel = ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                                     floatBit: defaultMM.floatBit,
                                                     unit: defaultMM.unit,
                                                     lfValue: newLfValue,
                                                     rfValue: newRfValue,
                                                     lrValue: newLrValue,
                                                     rrValue: newRrValue,
                                                     lowerBound: defaultMM.lowerBound,
                                                     upperBound: defaultMM.upperBound,
                                                     isFold: isFold)
        } else { // inch to mm
            let defaultMM = Self.mm
            
            let lfStrValue = displayValue(position: .leftFront)
            let newLfValue = inchTomm(value: lfStrValue)
            
            let rfStrValue = displayValue(position: .rightFront)
            let newRfValue = inchTomm(value: rfStrValue)
            
            let lrStrValue = displayValue(position: .leftRear)
            let newLrValue = inchTomm(value: lrStrValue)
            
            let rrStrValue = displayValue(position: .rightRear)
            let newRrValue = inchTomm(value: rrStrValue)
            
            mmModel = ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                                     floatBit: defaultMM.floatBit,
                                                     unit: defaultMM.unit,
                                                     lfValue: newLfValue,
                                                     rfValue: newRfValue,
                                                     lrValue: newLrValue,
                                                     rrValue: newRrValue,
                                                     lowerBound: defaultMM.lowerBound,
                                                     upperBound: defaultMM.upperBound,
                                                     isFold: isFold)
        }
        
        if unit.isCm { // mm to cm
            let defaultCM = Self.cm
            
            let lfStrValue = mmModel.displayValue(position: .leftFront)
            let newLfValue = mmTocm(value: lfStrValue)
            
            let rfStrValue = mmModel.displayValue(position: .rightFront)
            let newRfValue = mmTocm(value: rfStrValue)
            
            let lrStrValue = mmModel.displayValue(position: .leftRear)
            let newLrValue = mmTocm(value: lrStrValue)
            
            let rrStrValue = mmModel.displayValue(position: .rightRear)
            let newRrValue = mmTocm(value: rrStrValue)
            
            return ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                                  floatBit: defaultCM.floatBit,
                                                  unit: unit,
                                                  lfValue: newLfValue,
                                                  rfValue: newRfValue,
                                                  lrValue: newLrValue,
                                                  rrValue: newRrValue,
                                                  lowerBound: defaultCM.lowerBound,
                                                  upperBound: defaultCM.upperBound,
                                                  isFold: isFold)
        } else if unit.isInch { // mm to inch
            let defaultInch = Self.inch
            
            let lfStrValue = mmModel.displayValue(position: .leftFront)
            let newLfValue = mmToinch(value: lfStrValue)
            
            let rfStrValue = mmModel.displayValue(position: .rightFront)
            let newRfValue = mmToinch(value: rfStrValue)
            
            let lrStrValue = mmModel.displayValue(position: .leftRear)
            let newLrValue = mmToinch(value: lrStrValue)
            
            let rrStrValue = mmModel.displayValue(position: .rightRear)
            let newRrValue = mmToinch(value: rrStrValue)
            
            return ArtiADASReportWheelEyebrowUnit(type: .wheelEyebrow,
                                                  floatBit: defaultInch.floatBit,
                                                  unit: unit,
                                                  lfValue: newLfValue,
                                                  rfValue: newRfValue,
                                                  lrValue: newLrValue,
                                                  rrValue: newRrValue,
                                                  lowerBound: defaultInch.lowerBound,
                                                  upperBound: defaultInch.upperBound,
                                                  isFold: isFold)
        } else {
            return mmModel
        }
    }
    
    /// 支持mm / inch
    //public func update(lf: NSNumber, lr: NSNumber, rf: NSNumber, rr: NSNumber) {
        public func update(lf: Float, lr: Float, rf: Float, rr: Float) {
//        let lf = lf.floatValue
//        let lr = lr.floatValue
//        let rf = rf.floatValue
//        let rr = rr.floatValue
        
        if (self.floatBit <= 0) {
            lfValue = lf.intUnitValue()
            lrValue = lr.intUnitValue()
            rfValue = rf.intUnitValue()
            rrValue = rr.intUnitValue()
        } else {
            lfValue = lf.floatUnitValue()
            lrValue = lr.floatUnitValue()
            rfValue = rf.floatUnitValue()
            rrValue = rr.floatUnitValue()
        }
    }
}

// MARK: - TDD_ArtiADASReportTirePressureUnit

@objc(TDD_ArtiADASReportTirePressureUnit)
@objcMembers
public class ArtiADASReportTirePressureUnit: ArtiADASReportTireUnit {
    
    public class var pa: ArtiADASReportTirePressureUnit {
        let eLowerBound = "100000"
        let eUpperBound = "400000"
        let formatter = NumberFormatter.unitFloatFormatter()
        let lowerBoundFloat = (formatter.number(from: eLowerBound)?.floatValue ?? 100000)
        let upperBoundFloat = (formatter.number(from: eUpperBound)?.floatValue ?? 400000)
        
        var i18nLowerBound = lowerBoundFloat.intUnitValue()
        if i18nLowerBound.isEmpty { i18nLowerBound = eLowerBound }
        
        var i18nUpperBound = upperBoundFloat.intUnitValue()
        if i18nUpperBound.isEmpty { i18nUpperBound = eUpperBound}
        
        return ArtiADASReportTirePressureUnit(type: .tirePressure,
                                              floatBit: 0,
                                              unit: String.pa,
                                              lfValue: "",
                                              rfValue: "",
                                              lrValue: "",
                                              rrValue: "",
                                              lowerBound: i18nLowerBound,
                                              upperBound: i18nUpperBound,
                                              isFold: false)
    }
    
    public class var bar: ArtiADASReportTirePressureUnit {
        let usformatter = NumberFormatter.unitFloatFormatter()
        let lowerBoundFloat = (usformatter.number(from: "10")?.floatValue ?? 10) / 10
        let upperBoundFloat = (usformatter.number(from: "40")?.floatValue ?? 40) / 10
        
        var i18nLowerBound = lowerBoundFloat.floatUnitValue()
        if i18nLowerBound.isEmpty { i18nLowerBound = "1.0" }
        
        var i18nUpperBound = upperBoundFloat.floatUnitValue()
        if i18nUpperBound.isEmpty { i18nUpperBound = "4.0" }

        return ArtiADASReportTirePressureUnit(type: .tirePressure,
                                              floatBit: 1,
                                              unit: String.bar,
                                              lfValue: "",
                                              rfValue: "",
                                              lrValue: "",
                                              rrValue: "",
                                              lowerBound: i18nLowerBound,
                                              upperBound: i18nUpperBound,
                                              isFold: false)
    }
    
    override public func convert(to unit: String) -> ArtiADASReportTireUnit {
        let validUnits: [String] = [.bar, .pa]
        
        guard validUnits.contains(unit) else {
            fatalError("unit is not supported")
        }
        
        if unit == self.unit { return ArtiADASReportTirePressureUnit(type: .tirePressure,
                                                                     floatBit: floatBit,
                                                                     unit: unit,
                                                                     lfValue: lfValue,
                                                                     rfValue: rfValue,
                                                                     lrValue: lrValue,
                                                                     rrValue: rrValue,
                                                                     lowerBound: lowerBound,
                                                                     upperBound: upperBound,
                                                                     isFold: isFold)
        }
        
        func barToPa(value: String) -> String {
            if value.isEmpty {
                return value
            } else {
                let tValue = (100000 * value.i18nFloatValue).intUnitValue()
                let paBound = defaultBound(unit: String.pa)
                return bound(minValue: paBound.lowerBound, maxValue: paBound.upperBound, divisor: paBound.divisor, value: tValue)
            }
        }
        
        func paToBar(value: String) -> String {
            if value.isEmpty {
                return value
            } else {
                let tValue = (value.i18nFloatValue / 100000).floatUnitValue()
                let barBound = defaultBound(unit: String.bar)
                return bound(minValue: barBound.lowerBound, maxValue: barBound.upperBound, divisor: barBound.divisor, value: tValue)
            }
        }
        
        if unit.isPa { // bar to pa
            let defaultPa = Self.pa
            
            let newLfValue = barToPa(value: lfValue)
            let newRfValue = barToPa(value: rfValue)
            let newLrValue = barToPa(value: lrValue)
            let newRrValue = barToPa(value: rrValue)
            return ArtiADASReportTirePressureUnit(type: .tirePressure,
                                                  floatBit: defaultPa.floatBit,
                                                  unit: unit,
                                                  lfValue: newLfValue,
                                                  rfValue: newRfValue,
                                                  lrValue: newLrValue,
                                                  rrValue: newRrValue,
                                                  lowerBound: defaultPa.lowerBound,
                                                  upperBound: defaultPa.upperBound,
                                                  isFold: isFold)
        } else { // pa to bar
            let defaultBar = Self.bar
            
            let newLfValue = paToBar(value: lfValue)
            let newRfValue = paToBar(value: rfValue)
            let newLrValue = paToBar(value: lrValue)
            let newRrValue = paToBar(value: rrValue)
            return ArtiADASReportTirePressureUnit(type: .tirePressure,
                                                  floatBit: defaultBar.floatBit,
                                                  unit: unit,
                                                  lfValue: newLfValue,
                                                  rfValue: newRfValue,
                                                  lrValue: newLrValue,
                                                  rrValue: newRrValue,
                                                  lowerBound: defaultBar.lowerBound,
                                                  upperBound: defaultBar.upperBound,
                                                  isFold: isFold)
        }
    }
}

internal extension String {
    
    static var pa: String {
        "pa"
    }
    
    static var bar: String {
        "bar"
    }
    
    var isPa: Bool {
        self == Self.pa
    }
    
    var isBar: Bool {
        self == Self.bar
    }
    
    // MARK: - String to Number
    
    /// 100000 par  --- 6
    var i18nFloat: Float? {
        let number = NumberFormatter.unitFloatFormatter(maximumFractionDigits: 6).number(from: self)
        return number?.floatValue
    }
    
    var i18nFloatValue: Float {
        i18nFloat ?? 0.0
    }
    
    var i18nInt: Int? {
        let number = NumberFormatter.unitIntFormatter().number(from: self)
        return number?.intValue
    }
    
    var i18nIntValue: Int {
        i18nInt ?? 0
    }
    
    func intValue() -> String {
        if isEmpty { return self }
        
        guard let floatValue = i18nFloat else {
            return ""
        }
        return floatValue.intUnitValue()
    }
    
    
}

internal extension String {
    
    static var mm: String {
        "mm"
    }
    
    static var cm: String {
        "cm"
    }
    
    static var inch: String {
        "inch"
    }
    
    var isMm: Bool {
        self == Self.mm
    }
    
    var isCm: Bool {
        self == Self.cm
    }
    
    var isInch: Bool {
        self == Self.inch
    }
    
    
}

fileprivate extension NumberFormatter {
    
    static func unitFloatFormatter(maximumFractionDigits: Int = 1, isUS: Bool = false) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.roundingMode = .halfUp
        numberFormatter.numberStyle  = .decimal
        if isUS {
            numberFormatter.locale = Locale(identifier: "en_US")
        }
        return numberFormatter
    }
    
    static func unitIntFormatter(isUS: Bool = false) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.roundingMode = .halfUp
        numberFormatter.numberStyle  = .decimal
        if isUS {
            numberFormatter.locale = Locale(identifier: "en_US")
        }
        return numberFormatter
    }
    
}

internal extension Float {
    
    func floatUnitValue() -> String {
        let numberFormatter = NumberFormatter.unitFloatFormatter()
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func intUnitValue() -> String {
        let numberFormatter = NumberFormatter.unitIntFormatter()
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}

extension String {
    
    static func i18nCurrentDecimalSeparator() -> String {
        let fmt = NumberFormatter()
        return fmt.currencyDecimalSeparator ?? "."
    }
    
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
    
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}


// TirePressure: pa -- bar
/*
 bar: 1.0-4.0 支持输入小数点后一位
 pa:  100000-400000 仅可输入整数
 换算单位：1bar = 100000pa
 */

// WheelEyebrow: mm cm inch
/*
 公制：500-1000 mm 仅可输入整数
 英制：19.7-39.4 inch 输入小数点后一位
 换算单位：1inch = 25.4mm
 */
