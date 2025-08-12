//
//  TDD_VciUnConnectTipView.swift
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/12/28.
//

import UIKit
import SnapKit
import TDBasis

@objc public class TDD_VciUnConnectTipView:UIView {
    
    @objc public var clickTap:Block.VoidBlock?
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        addSubview(bgView)
        addSubview(tipsImageView)
        addSubview(tipsLabel)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tipsImageView.snp.makeConstraints { make in
            make.left.equalTo(Software.isTopScanHD ? 40 : 20)
            make.top.equalToSuperview().offset(Software.isTopScanHD ? 20.0 : 13.0)
            make.size.equalTo(Software.isTopScanHD ? 24.0 : 18.0)
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(Software.isTopScanHD ? -20 :-12.5)
            make.left.equalTo(tipsImageView.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(Software.isTopScanHD ? -40 : -20)
            make.top.equalToSuperview().offset(Software.isTopScanHD ? 20 : 12.5)
        }
        
    }
    
    
    lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_colorDiagTheme()
        view.alpha = 0.1
        view.td.addTap { [weak self] tap in guard let self = self else{ return }
            self.clickTap?()
        }
        return view
    }()
    
    lazy var tipsImageView : UIImageView = {
        let bundle = Bundle(for: TDD_ArtiMenuModel.self)
        let imageView = UIImageView()
        imageView.image = BridgeTool.tdd_imageNamed("diag_icon_error_tips_red")
        return imageView
    }()
    
    lazy var tipsLabel : UILabel = {
        let label = TDD_CustomLabel()
        label.font = .systemFont(ofSize: Software.isTopScanHD ? 18 : 14, weight: .medium)
        label.textColor = UIColor.tdd_colorDiagTheme()
        label.numberOfLines = 2
        label.text = TDDLocalized.tips_vci_unconnect
        return label
    }()
}
