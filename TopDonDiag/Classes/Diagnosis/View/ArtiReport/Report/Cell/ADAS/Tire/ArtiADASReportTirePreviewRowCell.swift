//
//  ArtiADASReportTirePreviewRowCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import UIKit

@objc(TDD_ArtiADASReportTirePreviewRowCell)
@objcMembers
public class ArtiADASReportTirePreviewRowCell: ArtiADASReportBorderCell { // rowHeight: 40
    
    public func update(_ model: ArtiADASTirePDFRowData, isLastCell: Bool) {
        switch model.dataType {
        case .position:
            bgView.isHidden = false
        case .current:
            bgView.isHidden = true
        case .previous:
            bgView.isHidden = true
        case .posterior:
            bgView.isHidden = true
        }
        leftLabel.attributedText  = model.previewLeftValue
        rightLabel.attributedText = model.previewRightValue
        
        bottomBorderLine.snp.updateConstraints { make in
            make.bottom.equalTo(isLastCell ? 0 : PDFInfo.lineWidthHeight)
        }
    }
    
    public override func setupUI() {
        contentView.addSubview(bgView)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        super.setupUI()
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftLabel.snp.makeConstraints { make in
            make.left.equalTo(8.0)
            make.top.bottom.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.right.equalTo(-8.0)
            make.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Lazy Load
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_color(withHex: 0xF4F4F4)
        return view
    }()
    
    private(set) lazy var leftLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var rightLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .right
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
}
