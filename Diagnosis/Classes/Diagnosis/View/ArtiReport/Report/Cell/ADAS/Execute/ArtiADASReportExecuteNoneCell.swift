//
//  ArtiADASReportExecuteNoneCell.swift
//  Alamofire
//
//  Created by xinwenliu on 2024/5/15.
//

import UIKit

@objc(TDD_ArtiADASReportExecuteNoneCell)
@objcMembers
open class ArtiADASReportExecuteNoneCell: ArtiADASReportBaseCell { // height: 153
    
    public func update() {
        
    }
    
    public func updateA4() {
        
    }
    
    open override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20.0)
        }
    }
    
    private(set) lazy var resultLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        // TODO: - 国际化
        textLabel.text = "无ADAS校准记录"
        textLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
}
