//
//  ArtiADASReportRepairHeaderCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/25.
//

import UIKit

@objc(TDD_ArtiADASReportRepairHeaderCell)
@objcMembers
public class ArtiADASReportRepairHeaderCell: ArtiADASReportBaseCell {
    
    public override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(0)
        }
        
        contentView.addSubview(currentStackView)
        currentStackView.addSubview(currentLabel)
        currentStackView.addSubview(currentTimeLabel)
        
        let height: CGFloat = 50
        let vInset: CGFloat = 3.0
        let totaleTextHeight = (height - 2 * vInset)
        let titleHeight = totaleTextHeight * 0.75
        let timeHeight =  totaleTextHeight * 0.25
        
        currentLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(vInset)
            make.height.equalTo(titleHeight)
        }
        currentTimeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(vInset)
            make.height.equalTo(timeHeight)
        }
        
        contentView.addSubview(historyStackView)
        historyStackView.addSubview(historyLabel)
        historyStackView.addSubview(historyTimeLabel)
        
        historyLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(vInset)
            make.height.equalTo(titleHeight)
        }
        
        historyTimeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(vInset)
            make.height.equalTo(timeHeight)
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
    }
    
    private func remakeLayout() {
        let height: CGFloat = 50
        let vInset: CGFloat = 5.0
        let totaleTextHeight = (height - 2 * vInset)
        let titleHeight = totaleTextHeight * 0.75
        let timeHeight =  totaleTextHeight * 0.25
        
        currentLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(vInset)
            make.height.equalTo(titleHeight)
        }
        currentTimeLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(vInset)
            make.height.equalTo(timeHeight)
        }
        
        historyLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(vInset)
            make.height.equalTo(titleHeight)
        }
        
        historyTimeLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(vInset)
            make.height.equalTo(timeHeight)
        }
    }
    
    private func remakeA4Layout() {
        let height: CGFloat = 40
        let vInset: CGFloat = 5.0
        let totaleTextHeight = (height - 2 * vInset)
        let titleHeight = totaleTextHeight * 0.75
        let timeHeight =  totaleTextHeight * 0.25
        
        currentLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(vInset)
            make.height.equalTo(titleHeight)
        }
        currentTimeLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(vInset)
            make.height.equalTo(timeHeight)
        }
        
        historyLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(vInset)
            make.height.equalTo(titleHeight)
        }
        
        historyTimeLabel.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(vInset)
            make.height.equalTo(timeHeight)
        }
    }
    
    /// 更新数据
    public func updateText(history: String, historyTime: String, current: String, currentTime: String) {
        
        var history = history
        history = history.beforeMaintenanceToCalibration()
        history = history.afterMaintenanceToCalibration()
        
        var current = current
        current = current.beforeMaintenanceToCalibration()
        current = current.afterMaintenanceToCalibration()
        
        historyLabel.text = history
        historyTimeLabel.text = historyTime
        
        currentLabel.text = current
        currentTimeLabel.text = currentTime
    }
    
    /// 更新预览布局
    public func update(historyPercent: Float, currentPercent: Float) {
        
        let pageWidth: CGFloat = UIScreen.main.bounds.width
        
        currentStackView.snp.remakeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(pageWidth * CGFloat(currentPercent))
        }
        
        historyStackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(currentStackView.snp.left)
            make.width.equalTo(pageWidth * CGFloat(historyPercent))
        }
        
        remakeLayout()
        
        contentView.backgroundColor = UIColor.tdd_reportBackground()
        
    }
    
    /// 更新 A4 布局
    public func updateA4(historyPercent: Float, currentPercent: Float) {
        var currentPercent = currentPercent
        if historyPercent == 0.0 {
            currentPercent = 0.3;
        }
        
        let pageWidth: CGFloat = PDFInfo.size.width
        
        currentStackView.snp.remakeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(pageWidth * CGFloat(currentPercent))
        }
        
        historyStackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(currentStackView.snp.left)
            make.width.equalTo(pageWidth * CGFloat(historyPercent))
        }
        
        remakeA4Layout()
        
        contentView.backgroundColor = .white
    }
    
    // MARK: - Getter
    
    private lazy var currentStackView: UIView = {
        let stackView = UIView()
        stackView.backgroundColor = UIColor.tdd_colorDiagTheme()
        return stackView
    }()
    
    private lazy var historyStackView: UIView = {
        let stackView = UIView()
        stackView.backgroundColor = UIColor.tdd_colorDiagTheme()
        return stackView
    }()
    
    private(set) lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_reportHeadCellBackground()
        return view
    }()
    
    // tdd_width = 0.36
    private(set) lazy var currentLabel: UILabel = {
        let textLabel = createTitleLabel()
        var before = TDDLocalized.report_system_type_before
        textLabel.text = before.beforeMaintenanceToCalibration()
        return textLabel
    }()
    
    private(set) lazy var currentTimeLabel: UILabel = {
        let textLabel = createTimeLabel()
        return textLabel
    }()
    
    private(set) lazy var historyLabel: UILabel = {
        let textLabel = createTitleLabel()
        var after = TDDLocalized.report_system_type_after
        textLabel.text = after.afterMaintenanceToCalibration()
        return textLabel
    }()
    
    private(set) lazy var historyTimeLabel: UILabel = {
        let textLabel = createTimeLabel()
        return textLabel
    }()
    
    private(set) lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_colorDiagTheme()
        return view
    }()
    
    private func createTitleLabel() -> UILabel {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .white
        textLabel.backgroundColor = UIColor.tdd_colorDiagTheme()
        textLabel.textAlignment = .center
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 0
        return textLabel
    }
    
    private func createTimeLabel() -> UILabel {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 10, weight: .regular)
        textLabel.textColor = .white
        textLabel.backgroundColor = UIColor.tdd_colorDiagTheme()
        textLabel.textAlignment = .center
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 0
        return textLabel
    }
    
}
