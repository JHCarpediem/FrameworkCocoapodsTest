//
//  TDD_ArtiADASReportBaseCell.swift
//  Alamofire
//
//  Created by xinwenliu on 2024/5/15.
//

import UIKit

@objc(TDD_ArtiADASReportBaseCell)
@objcMembers
open class ArtiADASReportBaseCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    open func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.tdd_reportBackground()
        backgroundColor = .clear
        
    }
    
    func updateA4Background(color: UIColor = .white) {
        contentView.backgroundColor = color
    }
    
}
