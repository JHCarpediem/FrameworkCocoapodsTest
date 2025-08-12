//
//  ArtiADASReportExpandView.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/13.
//

import UIKit
import SnapKit

class ArtiADASReportExpandView: UIView { // height: 48.5
    
    private var unit: ArtiADASReportTireUnit?
    
    var onExpandChanged: ((Bool)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func update(unit: ArtiADASReportTireUnit) {
        self.unit = unit
        
        switch unit.type {
        case .tirePressure:
            // TODO: - 国际化
            titleLabel.text = "轮胎压力"
            helpButton.isHidden = true
        case .wheelEyebrow:
            // TODO: - 国际化
            titleLabel.text = "轮眉高度"
            helpButton.isHidden = false
        }
        
        rangeLabel.text = " (\(unit.lowerBound)~\(unit.upperBound)) "
        
        if unit.isFold {
            expandButton.setImage(BridgeTool.tdd_imageNamed("report_icon_drop"), for: .normal)
        } else {
            expandButton.setImage(BridgeTool.tdd_imageNamed("report_icon_pickup"), for: .normal)
        }
    }
    
    private(set) lazy var titleLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 14, weight: .medium)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private lazy var rangeLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .regular)
        textLabel.textColor = UIColor.tdd_color666666()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var helpButton: UIButton = {
        let button = UIButton()
        button.setImage(BridgeTool.tdd_imageNamed("adas_help"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(showHelpTips), for: .touchUpInside)
        return button
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(BridgeTool.tdd_imageNamed("report_icon_pickup"), for: .normal)
        button.addTarget(self, action: #selector(expandButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_ColorEEEEEE()
        return view
    }()
    
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(rangeLabel)
        addSubview(helpButton)
        addSubview(expandButton)
        addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.left.equalTo(20.0)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
            make.right.equalToSuperview()
        }
        
        expandButton.snp.makeConstraints { make in
            make.width.equalTo(55.0)
            make.height.equalTo(48.0)
            make.right.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalToSuperview()
            make.bottom.equalTo(-0.5)
        }
        
        rangeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.centerY.equalTo(titleLabel)
        }
        
        helpButton.snp.makeConstraints { make in
            make.left.equalTo(rangeLabel.snp.right).offset(8.0)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(20.0)
        }
        
    }
    
    // MARK: - Actions
    
    @objc func showHelpTips() {
        let tipsArrowView = ArtiADASReportArrowTipsView()
        tipsArrowView.show(at: helpButton, image: BridgeTool.tdd_imageNamed("vin_pic_notice")!, direction: .top)
    }
    
    @objc func expandButtonClicked(_ btn: UIButton) {
        guard let unit = self.unit else { return }
        unit.isFold.toggle()
        onExpandChanged?(unit.isFold)
    }
}
