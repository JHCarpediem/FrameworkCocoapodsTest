//
//  ArtiADASReportParametersCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/15.
//

import UIKit

@objc(TDD_ArtiADASReportParametersCell)
@objcMembers
open class ArtiADASReportParametersCell: ArtiADASReportBorderCell {
    
    func update(dataSource: ArtiADASParametersItemable, isLastCell: Bool = false, isA4: Bool = false) {
        
        let inset: UIEdgeInsets = .init(top: 0,
                                        left: CGFloat(dataSource.aapPDFParameter.aapHorizonalInset),
                                        bottom: 0,
                                        right: CGFloat(dataSource.aapPDFParameter.aapHorizonalInset))
        
        keyLabel.textInsets = inset
        valueLabel.textInsets = inset
        referenceLabel.textInsets = inset
        
        keyLabel.attributedText = dataSource.aapPDFParameter.aapPDFKey
        valueLabel.attributedText = dataSource.aapPDFParameter.aapPDFValue
        referenceLabel.attributedText = dataSource.aapPDFParameter.aapPDFReference
        
        if dataSource.aapPDFRowType == .header {
            keyLabel.backgroundColor = UIColor.tdd_color(withHex: 0xF4F4F4)
            valueLabel.backgroundColor = UIColor.tdd_color(withHex: 0xF4F4F4)
            referenceLabel.backgroundColor = UIColor.tdd_color(withHex: 0xF4F4F4)
        } else {
            keyLabel.backgroundColor = UIColor.white
            valueLabel.backgroundColor = UIColor.white
            referenceLabel.backgroundColor = UIColor.white
        }
        
        let pageWidth: CGFloat = isA4 ? PDFInfo.size.width : UIScreen.main.bounds.width
        let hInset: CGFloat = isA4 ? 24.0 : 15.0
        
        let keyWidth: CGFloat = dataSource.aapPDFParameter.aapKeyWidth(totalWidth: pageWidth - 2 * hInset)
        let valueWidth: CGFloat = dataSource.aapPDFParameter.aapValueWidth
        let refWidth: CGFloat = dataSource.aapPDFParameter.aapReferenceWidth
        
        keyLabel.snp.updateConstraints { make in
            make.width.equalTo(keyWidth)
        }
        
        valueLabel.snp.updateConstraints { make in
            make.width.equalTo(valueWidth)
        }
        
        referenceLabel.snp.updateConstraints { make in
            if isA4 {
                make.width.equalTo(refWidth - (1.5 * PDFInfo.lineWidthHeight))
            } else {
                make.width.equalTo(refWidth)
            }
        }
        
        bottomBorderLine.snp.updateConstraints { make in
            make.bottom.equalTo(isLastCell ? 0 : PDFInfo.lineWidthHeight)
        }
        
        layoutIfNeeded()
    }
    
    open override func setupUI() {
        
        contentView.addSubview(keyLabel)

        contentView.addSubview(valueLabel)

        contentView.addSubview(referenceLabel)
        
        contentView.addSubview(verticalLine1)
        contentView.addSubview(verticalLine2)
        
        super.setupUI()

        keyLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(PDFInfo.lineWidthHeight)
            make.bottom.equalTo(bottomBorderLine.snp.top)
            make.width.equalTo(212.0)
        }
        
        verticalLine1.snp.makeConstraints { make in
            make.top.bottom.equalTo(keyLabel)
            make.width.equalTo(PDFInfo.lineWidthHeight)
            make.right.equalTo(keyLabel)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.equalTo(keyLabel.snp.right)
            make.bottom.top.equalTo(keyLabel)
            make.width.equalTo(52)
        }
        
        verticalLine2.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(verticalLine1)
            make.right.equalTo(valueLabel)
        }
        
        referenceLabel.snp.makeConstraints { make in
            make.left.equalTo(valueLabel.snp.right)
            make.bottom.top.equalTo(valueLabel)
            make.width.equalTo(80.0)
        }
        
    }
    
    // MARK: - Getter
    
    private lazy var keyLabel: InsetsLabel = {
        let textLabel = InsetsLabel()
        textLabel.textAlignment = .left
        textLabel.backgroundColor = PDFInfo.rowGrayColor
        textLabel.textLabel.numberOfLines = 0
        textLabel.textLabel.adjustsFontSizeToFitWidth = true
        return textLabel
    }()
    
    private lazy var verticalLine1: UIView = {
        let line = UIView()
        line.backgroundColor = PDFInfo.lineColor
        return line
    }()
    
    private lazy var valueLabel: InsetsLabel = {
        let textLabel = InsetsLabel()
        textLabel.textAlignment = .center
        textLabel.textLabel.numberOfLines = 0
        textLabel.textLabel.adjustsFontSizeToFitWidth = true
        return textLabel
    }()
    
    private lazy var verticalLine2: UIView = {
        let line = UIView()
        line.backgroundColor = PDFInfo.lineColor
        return line
    }()
    
    private lazy var verticalLine3: UIView = {
        let line = UIView()
        line.backgroundColor = PDFInfo.lineColor
        return line
    }()
    
    private lazy var referenceLabel: InsetsLabel = {
        let textLabel = InsetsLabel()
        textLabel.textAlignment = .center
        textLabel.textLabel.numberOfLines = 0
        textLabel.textLabel.adjustsFontSizeToFitWidth = true
        return textLabel
    }()
}

// MARK: - InsetsLabel
/*
class InsetsLabel: UILabel {
    
    var textInsets: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let insets = textInsets
        var rect = super.textRect(forBounds: bounds.inset(by:insets), limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left+insets.right)
        rect.size.height += (insets.top+insets.bottom)
        
        return rect
    }
    
}
*/

class InsetsLabel: UIView {
    
    var textInsets: UIEdgeInsets = .zero {
        didSet {
            textLabel.snp.remakeConstraints { make in
                make.left.equalTo(textInsets.left)
                make.right.equalTo(-textInsets.right)
                make.top.bottom.equalToSuperview()
            }
        }
    }
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    var attributedText: NSAttributedString? {
        didSet {
            textLabel.attributedText = attributedText
        }
    }
    
    var textAlignment: NSTextAlignment = .left {
        didSet {
            textLabel.textAlignment = textAlignment
        }
    }
    
    var numberOfLines: Int = 1 {
        didSet {
            textLabel.numberOfLines = numberOfLines
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: textInsets.left + textLabel.intrinsicContentSize.width + textInsets.right, height: textInsets.top + textLabel.intrinsicContentSize.height + textInsets.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.left.equalTo(textInsets.left)
            make.right.equalTo(-textInsets.right)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private(set) lazy var textLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
}
