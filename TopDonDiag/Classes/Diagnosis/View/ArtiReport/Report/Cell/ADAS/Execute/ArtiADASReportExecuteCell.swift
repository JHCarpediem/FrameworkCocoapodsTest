//
//  ArtiADASReportExecuteCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/15.
//

import UIKit

@objc(TDD_ArtiADASReportExecuteCell)
@objcMembers
open class ArtiADASReportExecuteCell: ArtiADASReportBaseCell {
    
    public class func cellHeight(with result: ArtiADASReportResult) -> CGFloat {
        let titleTop = 15.0
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let horizonalInset: CGFloat = 15.0
        
        let titleHeight = titleHeight(horizonalInset, title: result.sysName, pageWidth: screenWidth)
        let resultViewTop  = 16.0
        let resulthViewHeight = 72.5
        let totalTop = 16.0
        let totalHeight = 16.5
        let timeTop = 16.0
        let timeHieght = 16.5 * 2
        
        // 没有参数 13.5
        let bottomGap: CGFloat
        let parameterViewHeight: CGFloat
        if let parameters = result.parameters, !parameters.isEmpty {
            
            parameterViewHeight  =  17 + 12 + result.parameterHeight
            bottomGap = 15.0
        } else {
            parameterViewHeight  = 0
            bottomGap = 0
        }
        
        return titleTop + titleHeight + resultViewTop + resulthViewHeight + totalTop + totalHeight + timeTop + timeHieght + parameterViewHeight + bottomGap
    }
    
    public class func a4CellHeight(with result: ArtiADASReportResult) -> CGFloat {
        let titleTop = 15.0
        let screenWidth: CGFloat = PDFInfo.size.width
        let horizonalInset: CGFloat = 24.0
        
        let titleHeight = titleHeight(horizonalInset, title: result.sysName, pageWidth: screenWidth)
        let resultViewTop  = 16.0
        let resulthViewHeight = 72.5
        let totalTop = 16.0
        let totalHeight = 16.5
        let timeTop = 16.0
        let timeHieght = 16.5
        
        // 没有参数 13.5
        let bottomGap: CGFloat
        let parameterViewHeight: CGFloat
        if let parameters = result.parameters, !parameters.isEmpty {
            
            parameterViewHeight  =  17 + 12 + result.parameterHeight
            bottomGap = 20.0
        } else {
            parameterViewHeight  = 0
            bottomGap = 0
        }
        
        return titleTop + titleHeight + resultViewTop + resulthViewHeight + totalTop + totalHeight + timeTop + timeHieght + parameterViewHeight + bottomGap
    }
    
    public func update(with result: ArtiADASReportResult) {
        
        updateData(result)
        resultView.updatePreview()
        parameterView.update(with: result)
        
        titleLabel.snp.updateConstraints { make in
            make.height.equalTo(Self.titleHeight(15.0, title: result.sysName, pageWidth: UIScreen.main.bounds.width))
        }
        
        if result.parameterHeight > 0 {
            calibrationValueLabel.snp.remakeConstraints { make in
                make.top.equalTo(calibrationTitleLabel)
                make.right.equalTo(totalValueLabel)
            }
            parameterView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
               // make.top.equalTo(calibrationValueLabel.snp.bottom)
                make.height.equalTo(17+12+result.parameterHeight)
                make.bottom.equalTo(-20.0)
            }
        } else {
            calibrationValueLabel.snp.remakeConstraints { make in
                make.top.equalTo(calibrationTitleLabel)
                make.right.equalTo(totalValueLabel)
                make.bottom.equalTo(0)
            }
            parameterView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(calibrationValueLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
    }
    
    public func updateA4(with result: ArtiADASReportResult) {
        updateData(result)
        resultView.updateA4()
        calibrationValueLabel.text = result.a4TimeValue
        parameterView.updateA4(with: result)
        
        titleLabel.snp.updateConstraints { make in
            make.left.right.equalToSuperview().inset(24.0)
            make.height.equalTo(Self.titleHeight(24.0, title: result.sysName, pageWidth: PDFInfo.size.width))
        }
        
        if result.parameterHeight > 0 {
            calibrationValueLabel.snp.remakeConstraints { make in
                make.top.equalTo(calibrationTitleLabel)
                make.right.equalTo(totalValueLabel)
            }
            parameterView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
               // make.top.equalTo(calibrationValueLabel.snp.bottom)
                make.height.equalTo(17+12+result.parameterHeight)
                make.bottom.equalTo(-15.0)
            }
        } else {
            calibrationValueLabel.snp.remakeConstraints { make in
                make.top.equalTo(calibrationTitleLabel)
                make.right.equalTo(totalValueLabel)
                make.bottom.equalTo(0)
            }
            parameterView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(calibrationValueLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
    }
    
    private func updateData(_ result: ArtiADASReportResult) {
        titleLabel.text = result.sysName
        
        resultView.iconView.image = BridgeTool.tdd_imageNamed(result.displayImageName)
        resultView.resultLabel.text = result.displayResult
        
        totalTitleLabel.text = result.totalTitle
        totalValueLabel.text = result.displayTotalTime
        
        calibrationTitleLabel.text = result.timeTitle
        calibrationValueLabel.text = result.timeValue
    }
    
    private class func titleHeight(_ horizonalInset: CGFloat, title: String, pageWidth: CGFloat) -> CGFloat {
        title.height(maxWidth: pageWidth - 2 * horizonalInset, font: .systemFont(ofSize: 18.0, weight: .semibold))
    }
    
    open override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(resultView)
        
        contentView.addSubview(totalTitleLabel)
        contentView.addSubview(totalValueLabel)
        contentView.addSubview(calibrationTitleLabel)
        contentView.addSubview(calibrationValueLabel)
        
        contentView.addSubview(parameterView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15.0)
            make.top.equalTo(15.0)
            make.height.equalTo(21.5)
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(72.5)
        }
        
        totalTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(resultView.snp.bottom).offset(16.0)
            make.height.equalTo(16.5)
        }
        
        totalValueLabel.snp.makeConstraints { make in
            make.right.equalTo(titleLabel)
            make.top.height.equalTo(totalTitleLabel)
        }
        
        calibrationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(totalTitleLabel.snp.bottom).offset(12)
            make.left.height.equalTo(totalTitleLabel)
        }
        
        calibrationValueLabel.snp.makeConstraints { make in
            make.top.equalTo(calibrationTitleLabel)
            make.right.equalTo(totalValueLabel)
        }
        
        parameterView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(calibrationValueLabel.snp.bottom)
            make.bottom.equalTo(-30.0)
        }
        
        // 如果 parameterView 隐藏 calibrationValueLabel 距离底部 13.0
        
    }
    
    // MARK: - Lazy Load
    
    private(set) lazy var titleLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return textLabel
    }()
    
    private lazy var resultView: ResultView = {
        let view = ResultView()
        return view
    }()
    
    private(set) lazy var totalTitleLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .medium)
        textLabel.textColor = UIColor.tdd_color666666()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var totalValueLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .medium)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .right
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var calibrationTitleLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .medium)
        textLabel.textColor = UIColor.tdd_color666666()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var calibrationValueLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .medium)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .right
        textLabel.numberOfLines = 0
        textLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return textLabel
    }()
    
    private(set) lazy var parameterView: ParametersView = .init(frame: .zero)
    
}

extension ArtiADASReportExecuteCell {
    
    class ResultView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        func setupUI() {
            addSubview(containerView)
            containerView.addSubview(iconView)
            containerView.addSubview(resultLabel)
            
            containerView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(0)
                make.height.equalTo(72.5)
            }
            
            iconView.snp.makeConstraints { make in
                make.size.equalTo(46.0)
                make.left.equalTo(20.0)
                make.centerY.equalToSuperview()
            }
            
            resultLabel.snp.makeConstraints { make in
                make.left.equalTo(iconView.snp.right).offset(16.0)
                make.centerY.equalToSuperview()
            }
            
        }
        
        func updatePreview() {
            containerView.snp.updateConstraints { make in
                make.left.right.equalToSuperview().inset(15)
            }
        }
        
        func updateA4() {
            containerView.snp.updateConstraints { make in
                make.left.right.equalToSuperview().inset(24)
            }
        }
        
        private lazy var containerView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 1.5
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor.tdd_color(withHex: 0x215CB0, alpha: 0.05)
            return view
        }()
        
        private(set) lazy var iconView: UIImageView = {
            let imgView = UIImageView()
            return imgView
        }()
        
        private(set) lazy var resultLabel: UILabel = {
            let textLabel = TDD_CustomLabel()
            textLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            textLabel.textColor = UIColor.tdd_color333333()
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 1
            return textLabel
        }()
    }
}

// MARK: - 校准参数

extension ArtiADASReportExecuteCell {
    
    class ParametersView: UIView, UITableViewDelegate, UITableViewDataSource {
        
        func update(with result: ArtiADASReportResult) {
            isA4 = false
            
            updateData(result)
        }
        
        func updateA4(with result: ArtiADASReportResult) {
            isA4 = true
            
            updateData(result)
            
            titleLabel.snp.updateConstraints { make in
                make.left.equalTo(24.0)
            }
            
            tableView.snp.updateConstraints { make in
                make.left.right.equalToSuperview().inset(24.0)
            }
        }
        
        private func updateData(_ result: ArtiADASReportResult) {
            titleLabel.text = result.parameterTitle
            
            let items = result.parameters ?? []
            tableView.snp.updateConstraints { make in
                make.height.equalTo(result.parameterHeight)
            }
            self.items = items
            isHidden = items.isEmpty
        }
        
        private var isA4: Bool = false
        
        var items: [ArtiADASParametersItemable] = [] {
            didSet {
                tableView.reloadData()
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        func setupUI() {
            addSubview(titleLabel)
            addSubview(tableView)
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(15.0)
                make.top.equalToSuperview()
                make.height.equalTo(17.0)
            }
            
            tableView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(15.0)
                make.top.equalTo(titleLabel.snp.bottom).offset(12)
                make.height.equalTo(CGFloat(items.count) * 50.0)
                make.bottom.equalToSuperview()
            }
        }
        
        private(set) lazy var titleLabel: UILabel = {
            let textLabel = TDD_CustomLabel()
            textLabel.font = .systemFont(ofSize: 12, weight: .medium)
            textLabel.textColor = UIColor.tdd_color666666()
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 1
            return textLabel
        }()
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
            tableView.contentInsetAdjustmentBehavior = .never
            
            tableView.register(ArtiADASReportParametersCell.self, forCellReuseIdentifier: "kArtiADASReportParametersCell")
            
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            return tableView
        }()
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50.0
        }
        
        // MARK: - UITableViewDataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // rowHeight = 50.0
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "kArtiADASReportParametersCell", for: indexPath) as? ArtiADASReportParametersCell else {
                return UITableViewCell()
            }
            
            let item = items[indexPath.row]
            cell.update(dataSource: item, isLastCell: indexPath.row == (items.count - 1), isA4: isA4)
            
            return cell
        }
        
    }
}
