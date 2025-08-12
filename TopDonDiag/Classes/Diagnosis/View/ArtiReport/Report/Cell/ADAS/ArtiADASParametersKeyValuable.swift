//
//  File.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/15.
//

import Foundation

// MARK: - Protocol

@objc(TDD_ArtiADASParametersRowType)
public enum ArtiADASParametersRowType: Int {
    case header
    case row
}

@objc(TDD_ArtiADASParameterable)
public protocol ArtiADASParameterable {
    /// 名称
    var aapPDFKey: NSAttributedString { get }
    /// 数值
    var aapPDFValue: NSAttributedString { get }
    /// 参考
    var aapPDFReference: NSAttributedString { get }
    
    var aapHorizonalInset: CGFloat { get}
    func aapKeyWidth(totalWidth: CGFloat) -> CGFloat
    var aapValueWidth: CGFloat { get}
    var aapReferenceWidth: CGFloat { get}
}

@objc(TDD_ArtiADASParametersItemable)
public protocol ArtiADASParametersItemable {
    
    var aapPDFRowType: ArtiADASParametersRowType { get }
    
    var aapPDFParameter: ArtiADASParameterable { get }
    
}

// MARK: - Model

@objc(TDD_ArtiADASParameters)
@objcMembers
open class ArtiADASParameters: NSObject, ArtiADASParameterable, ArtiADASParametersItemable {
 
    public var key: String
    public var value: String
    public var reference: String
    
    public var unit: String = ""
    public var min: String  = ""
    public var max: String  = ""
    
    public var isHeader: Bool
    public var horizonalInset: CGFloat // 12.0
    
    // 整个数组计算出最大的 value 和 ReferenceWidth 剩余的 KeyWidth
    public var keyWidth: CGFloat = 0
    public var valueWidth: CGFloat = 0
    public var referenceWidth: CGFloat = 0
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.key = ""
        self.value = ""
        self.reference = ""
        
        self.unit = ""
        self.min  = ""
        self.max  = ""
        
        self.isHeader = false
        self.horizonalInset = 0
        self.keyWidth = 0
        self.valueWidth = 0
        self.referenceWidth = 0
        
        super.init()
    }
    
    public convenience init(key: String, value: String, reference: String, unit: String, min: String, max: String, isHeader: Bool, horizonalInset: CGFloat) {
        self.init(key: key, value: value, reference: reference, isHeader: isHeader, horizonalInset: horizonalInset)
        
        self.unit = unit
        self.min  = min
        self.max  = max
    }
    
    public init(key: String, value: String, reference: String, isHeader: Bool, horizonalInset: CGFloat) {
        self.key = key
        self.value = value
        self.reference = reference
        self.isHeader = isHeader
        self.horizonalInset = horizonalInset
        
        super.init()
        
        let inset = 2 * horizonalInset
        self.valueWidth = aapPDFValue.width(containerHeight: 200) + inset
        self.referenceWidth = aapPDFReference.width(containerHeight: 200) + inset
        self.keyWidth = 0

    }
    
    // MARK: - ArtiADASParameterable
    
    public var aapPDFKey: NSAttributedString {
        NSAttributedString(string: key, attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
            .foregroundColor: UIColor.tdd_color666666()
        ])
    }
    
    public var aapPDFValue: NSAttributedString {
        NSAttributedString(string: value, attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
            .foregroundColor: UIColor.tdd_color666666()
        ])
    }
    
    public var aapPDFReference: NSAttributedString {
        NSAttributedString(string: reference, attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
            .foregroundColor: UIColor.tdd_color666666()
        ])
    }
    
    public func aapKeyWidth(totalWidth: CGFloat) -> CGFloat {
        totalWidth - aapValueWidth - aapReferenceWidth
    }
    
    public var aapHorizonalInset: CGFloat {
        horizonalInset
    }
    
    public var aapReferenceWidth: CGFloat {
        let inset = 2 * horizonalInset
        if (referenceWidth <= 0) {
            referenceWidth = aapPDFReference.width(containerHeight: 200) + inset
        }
        return referenceWidth
    }
    
    public var aapValueWidth: CGFloat {
        let inset = 2 * horizonalInset
        if (valueWidth <= 0) {
            valueWidth = aapPDFValue.width(containerHeight: 200) + inset
        }
        return valueWidth
    }
    
    // MARK: - ArtiADASParametersItemable
    
    public var aapPDFRowType: ArtiADASParametersRowType {
        return isHeader ? .header : .row
    }
    
    public var aapPDFParameter: any ArtiADASParameterable {
        return self
    }
    
}
