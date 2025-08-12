//
//  ArtiADASReportBorderCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/15.
//

import UIKit

struct PDFInfo {
    
    /// A4 Page Size in Point
    static let size: CGSize = .init(width: 595.2, height: 841.8)
    
    /// 底线宽、高
    static let lineWidthHeight: CGFloat = 1.0
    
    /// 一行灰底 #F4F4F4
    static let rowGrayColor: UIColor = UIColor.tdd_color(withHex: 0xF4F4F4)
    
    /// 底线灰 #DDDDDD
    static let lineColor: UIColor = UIColor.tdd_color(withHex: 0xDDDDDD)
    
    
}


@objc(TDD_ArtiArtiADASReportBorderCell)
@objcMembers
open class ArtiADASReportBorderCell: ArtiADASReportBaseCell {
    
    open override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(topBorderLine)
        contentView.addSubview(leftBorderLine)
        contentView.addSubview(bottomBorderLine)
        contentView.addSubview(rightBorderLine)
        
        topBorderLine.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(PDFInfo.lineWidthHeight)
        }
        
        leftBorderLine.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.width.equalTo(PDFInfo.lineWidthHeight)
        }
        
        rightBorderLine.snp.makeConstraints { make in
            make.right.bottom.top.equalToSuperview()
            make.width.equalTo(PDFInfo.lineWidthHeight)
        }
        
        bottomBorderLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(0)
            make.height.equalTo(PDFInfo.lineWidthHeight)
        }
        
    }
    
    // MARK: - BorderLines
    
    private(set) lazy var topBorderLine: UIView = {
        createBorderLine()
    }()
    
    private(set) lazy var leftBorderLine: UIView = {
        createBorderLine()
    }()
    
    private(set) lazy var bottomBorderLine: UIView = {
        createBorderLine()
    }()
    
    private(set) lazy var rightBorderLine: UIView = {
        createBorderLine()
    }()
    
    private func createBorderLine() -> UIView {
        let line = UIView()
        line.backgroundColor = PDFInfo.lineColor
        return line
    }
    
}
