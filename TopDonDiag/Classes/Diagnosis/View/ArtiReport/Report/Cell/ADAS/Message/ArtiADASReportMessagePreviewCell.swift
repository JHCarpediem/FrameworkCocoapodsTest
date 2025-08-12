//
//  ArtiADASReportMessagePreviewCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import UIKit

@objc(TDD_ArtiADASReportMessagePreviewCell)
@objcMembers
public class ArtiADASReportMessagePreviewCell: ArtiADASReportBaseCell {
    
    public static func cellHeight(_ msg: String) -> CGFloat {
        var text = msg
        if text.isEmpty {
            text = TDDLocalized.app_no_data
        }
        let gap = TDD_DiagnosisTools.isIpad() ? 40.0 : 15.0
        
        return text.height(maxWidth: UIScreen.main.bounds.width - gap * 2, font: .systemFont(ofSize: TDD_DiagnosisTools.isIpad() ? 18 : 14)) + 15.0 + 10.0
    }
    
    public static func a4CellHeight(_ msg: String) -> CGFloat {
        var text = msg
        if text.isEmpty {
            text = TDDLocalized.app_no_data
        }
        return text.height(maxWidth: PDFInfo.size.width - 48.0, font: .systemFont(ofSize: 12, weight: .regular)) + 15.0
    }
    
    public func update(_ msg: String) {
        var text = msg
        if text.isEmpty {
            text = TDDLocalized.app_no_data
        }
        messageLabel.text = text
        
        messageLabel.snp.updateConstraints { make in
            make.left.right.equalToSuperview().inset(TDD_DiagnosisTools.isIpad() ? 40.0 : 15.0)
        }
    }
    
    public func updateA4(_ msg: String) {

        contentView.backgroundColor = .white

        messageLabel.font = .systemFont(ofSize: 12, weight: .regular)

        var text = msg
        if text.isEmpty {
            text = TDDLocalized.app_no_data
        }
        messageLabel.text = text
        messageLabel.textColor = UIColor.tdd_color333333()
        messageLabel.snp.updateConstraints { make in
            make.left.right.equalToSuperview().inset(24.0)
        }
    }
    
    public override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(TDD_DiagnosisTools.isIpad() ? 40.0 : 15.0)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(-15.0)
        }
    }
    
    // MARK: - Lazy Load
    private(set) lazy var messageLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: TDD_DiagnosisTools.isIpad() ? 18 : 14, weight: .regular)
        textLabel.textColor = UIColor.tdd_reportDisclaimText()

        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
}
