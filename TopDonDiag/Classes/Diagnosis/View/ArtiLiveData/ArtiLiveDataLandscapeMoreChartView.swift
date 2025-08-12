//
//  ArtiLiveDataLandscapeMoreChartView.swift
//  TopdonDiagnosis
//
//  Created by liuxinwen on 2025/7/29.
//

import UIKit
import SnapKit
import TDUIProvider
import YYText

// MARK: - LandscapeItemView
// width 244 height: (UIScreen.main.bounds.width - 44.0 - 55.0 - kBottom - 1.0) / 4.0
final class LandscapeLiveDataItemView: UIView {
    
    var cubeColor: UIColor
    var itemName: String
    var unit: String
    
    var value: String
    
    lazy var cubeView: UIView = {
        let cubeView = UIView()
        cubeView.backgroundColor = cubeColor
        return cubeView
    }()
    
    /// to-do 更多
    lazy var itemNameLabel: YYLabel = {
        let itemNameLabel = YYLabel()
        itemNameLabel.text = itemName
        itemNameLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .medium)
        itemNameLabel.textColor = UIColor.tdd_title()
        itemNameLabel.numberOfLines = 2
        itemNameLabel.textAlignment = .left
        itemNameLabel.isUserInteractionEnabled = true
        setupTruncationToken(itemNameLabel)
        return itemNameLabel
    }()
    
    lazy var valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 9.0)
        valueLabel.textColor = UIColor.tdd_liveDataUnitNormal()
        valueLabel.numberOfLines = 2
        valueLabel.textAlignment = .left
        return valueLabel
    }()
    
    lazy var unitLabel: UILabel = {
        let unitLabel = UILabel()
        unitLabel.text = unit
        unitLabel.font = UIFont.systemFont(ofSize: 9.0)
        unitLabel.textColor = UIColor.tdd_liveDataUnitNormal()
        unitLabel.numberOfLines = 2
        unitLabel.textAlignment = .right
        return unitLabel
    }()
    
    //    private lazy var lineView: UIView = {
    //        let lineView = UIView()
    //        lineView.backgroundColor = UIColor.tdd_line()
    //        return lineView
    //    }()
    
    func refresh() {
        cubeView.backgroundColor = cubeColor
        let name = itemName
        
        let leftMargin: CGFloat = TDD_DiagBridge.isIPhoneX() ? 3.0 : 10.0
        
        let textMaxWidth: CGFloat = 170
        let yyLabelHeight = name.calculateYYLabelHeight(font: .systemFont(ofSize: 11, weight: .medium) , width: textMaxWidth, numberOfLines: 2)
        itemNameLabel.frame = CGRect(x: leftMargin + 10 + 2.5, y: 6.0, width: textMaxWidth, height: yyLabelHeight)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.baseWritingDirection = .leftToRight
        
        itemNameLabel.attributedText = NSAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 11, weight: .medium), .foregroundColor: UIColor.tdd_title(), .paragraphStyle: paragraphStyle])
        
        valueLabel.text = value
        unitLabel.text = unit
    }
    
    func setupTruncationToken(_ label: YYLabel) {
        let moreText = TDDLocalized.upgrade_more
        let truncationToken = NSMutableAttributedString(string: " " + moreText)
        let range = (truncationToken.string as NSString).range(of: moreText)
        
        truncationToken.yy_font = .systemFont(ofSize: 11, weight: .medium)
        truncationToken.yy_setColor(UIColor.tdd_colorDiagTheme(), range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.baseWritingDirection = .leftToRight
        truncationToken.yy_paragraphStyle = paragraphStyle
        
        let highlight = YYTextHighlight()
        highlight.setFont(.systemFont(ofSize: 11, weight: .medium))
        truncationToken.yy_setTextHighlight(highlight, range: NSRange(location: 0, length: truncationToken.length))
        
        highlight.tapAction = { [weak self] (containerView, text, range, rect) in
            guard let self else { return }
            
            let confirmAction = LMSAlertAction.init(title: TDDLocalized.app_confirm, titleColor: UIColor.tdd_colorDiagTheme()) { action in
                
            }
            //LMSAlertController.showAlert(nil, message: self.itemName, actions: [confirmAction])
        }
        
        let seeMore = YYLabel()
        seeMore.attributedText = truncationToken
        seeMore.sizeToFit()
        
        label.truncationToken = NSAttributedString.yy_attachmentString(withContent: seeMore, contentMode: .center, attachmentSize: seeMore.frame.size, alignTo: truncationToken.yy_font ?? .systemFont(ofSize: 11, weight: .medium), alignment: .center)
    }
    
    required init(cubeColor: UIColor, itemName: String, unit: String) {
        self.cubeColor = cubeColor
        self.itemName = itemName
        self.unit = unit
        self.value = ""
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(cubeView)
        addSubview(itemNameLabel)
        addSubview(valueLabel)
        addSubview(unitLabel)
        //        addSubview(lineView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let leftMargin: CGFloat = TDD_DiagBridge.isIPhoneX() ? 3.0 : 10.0
        
        cubeView.snp.makeConstraints { make in
            make.left.equalTo(leftMargin)
            make.top.equalTo(7)
            make.size.equalTo(CGSize(width: 10.0, height: 10.0))
            
        }
        
        //        itemNameLabel.snp.makeConstraints { make in
        //            make.left.equalTo(cubeView.snp.right).offset(2.5)
        //            make.top.equalTo(cubeView.snp.top)
        //            make.right.equalTo(-10)
        //            make.height.lessThanOrEqualTo(31.0)
        //        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.equalTo(leftMargin)
            make.width.equalTo(120.0)
            make.bottom.equalTo(-6.0)
        }
        
        unitLabel.snp.makeConstraints { make in
            make.left.equalTo(valueLabel.snp.right).offset(4)
            make.bottom.equalTo(-6)
            make.width.equalTo(60.0)
        }
        
        //        lineView.snp.makeConstraints { make in
        //            make.left.equalTo(leftMargin)
        //            make.height.equalTo(1.0)
        //            make.bottom.right.equalToSuperview()
        //        }
    }
    
}


// MARK: - Cell

final class LiveDataItemCell: UITableViewCell {
    
    private lazy var itemView: LandscapeLiveDataItemView = {
        let view = LandscapeLiveDataItemView(cubeColor: .clear, itemName: "", unit: "")
        return view
    }()
    
    func update(cubeColor: UIColor, itemName: String, value: String, unit: String) {
        itemView.cubeColor = cubeColor
        itemView.itemName = itemName
        itemView.value = value
        itemView.unit = unit
        
        itemView.refresh()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        
        separatorInset = .zero
        layoutMargins = .zero
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(itemView)
        
        itemView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

// MARK: - TDD_ArtiLiveDataMoreChartViewNew

@objcMembers
@objc(TDD_ArtiLiveDataLandscapeMoreChartView)
public class ArtiLiveDataLandscapeMoreChartView: TDD_ArtiContentBaseView {
    
    // MARK: - Properties
    public var model: TDD_ArtiLiveDataMoreChartModel? {
        didSet {
            refreshUI()
        }
    }
    
    private let navigationHeight: CGFloat = 44.0
    private let composeBottomHeight: CGFloat = 55.0
    private let lineHeight: CGFloat = 1.0
    private let maxCount: Int = 4
    private lazy var kSafeBottomHeightValue: CGFloat = { TDD_DiagBridge.kSafeBottomHeightValue() }()
    
    private let tableViewWidth: CGFloat = 244.0
    private lazy var tableViewHeight: CGFloat = (UIScreen.main.bounds.width - navigationHeight - composeBottomHeight - kSafeBottomHeightValue  - lineHeight)
    
    private let space: CGFloat = 10.0 // 图标和 tableVeiw 中间间距
    
    private lazy var rowHeight: CGFloat = { (UIScreen.main.bounds.width - navigationHeight - composeBottomHeight - kSafeBottomHeightValue - lineHeight) / CGFloat(maxCount) }()
    
    // MARK: - UI Components
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.tdd_line()
        return lineView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.tdd_line()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.bounces = false
        tableView.delaysContentTouches = false
        
        tableView.rowHeight = rowHeight
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        tableView.register(LiveDataItemCell.self, forCellReuseIdentifier: "LiveDataItemCell")
        return tableView
    }()
    
    private lazy var gapView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.tdd_liveDataSepLine()
        return lineView
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.tdd_liveDataLegend() // #999999
        label.font = UIFont.systemFont(ofSize: 10.0)
        // TODO: xinwen 国际化
        label.text = "支持X轴Y轴的手势缩放"
        return label
    }()
    
    private lazy var chartLandscapeView: TDD_HMoreChartLandscapeView = {
        let view = TDD_HMoreChartLandscapeView()
        return view
    }()
    
    private lazy var colorArr: [UIColor] = { TDD_DiagBridge.chart4Colors() }()
    
    private lazy var scale: CGFloat = {
        return TDD_DiagBridge.isPad() ? TDD_DiagBridge.hd_HeightValue() : TDD_DiagBridge.h_HeightValue()
    }()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = UIColor.tdd_viewControllerBackground()
        
        addSubview(lineView)
        addSubview(tableView)
        addSubview(gapView)
        addSubview(tipLabel)
        addSubview(chartLandscapeView)
        
        lineView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(tableViewWidth)
            make.height.equalTo(tableViewHeight)
        }
        
        gapView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalTo(tableView.snp.right)
            make.width.equalTo(space)
            make.bottom.equalToSuperview()
        }
        
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.right.equalTo(-20)
            make.height.equalTo(14.0)
            make.left.equalTo(gapView.snp.right)
        }
        
        chartLandscapeView.snp.makeConstraints { make in
            make.left.equalTo(tableView.snp.right).offset(space)
            make.top.equalTo(tipLabel.snp.bottom).offset(12.0)
            make.bottom.equalToSuperview()
            make.right.equalTo(-20.0)
        }
        
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleArtiLiveDataModelShow(_:)),
            name: NSNotification.Name("TDD_ArtiLiveDataModelShow"),
            object: nil
        )
    }
    
    // MARK: - Notification Handlers
    
    @objc private func handleArtiLiveDataModelShow(_ notification: Notification) {
        refreshUI()
    }
    
    private func refreshUI() {
        tableView.reloadData()
        refreshChartView()
    }
    
    private func refreshChartView() {
        var valueArr: [Any] = []
        if let selectItems = model?.selectItmes {
            for itemModel in selectItems {
                if let liveDataItem = itemModel as? TDD_ArtiLiveDataItemModel {
                    valueArr.append(liveDataItem.valueArr ?? [])
                }
            }
        }
        
        chartLandscapeView.valueArr = valueArr as? [[Any]]
    }
}

// MARK: - UITableViewDataSource
extension ArtiLiveDataLandscapeMoreChartView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.selectItmes.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveDataItemCell", for: indexPath)
        if let cell = cell as? LiveDataItemCell {
            
            let index = indexPath.row
            let cubeColor = colorArr[index % 4]
            
            if let selectItems = model?.selectItmes,
               index < selectItems.count,
               let itemModel = selectItems[index] as? TDD_ArtiLiveDataItemModel {
                
                //                titleLabel?.text = itemModel.strName
                //                valueLabel?.text = "\(TDDLocalized.report_data_stream_number):\(itemModel.strChangeValue ?? "")"
                //                unityLabel?.text = "\(TDDLocalized.diagnosis_unit):\(itemModel.strChangeUnit ?? "")"
                
                let value: String = "\(itemModel.strChangeValue ?? "")"
                let unit: String = "\(itemModel.strChangeUnit ?? "")"
                cell.update(cubeColor: cubeColor, itemName: itemModel.strName, value: value, unit: unit)
            }
            
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ArtiLiveDataLandscapeMoreChartView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection if needed
    }
}

extension String {
    
    func calculateYYLabelHeight(font: UIFont, width: CGFloat, numberOfLines: UInt) -> CGFloat {
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.yy_font = font
        
        let container = YYTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        container.maximumNumberOfRows = numberOfLines
        
        let layout = YYTextLayout(container: container, text: attributedText)
        
        return layout?.textBoundingSize.height ?? 0
    }
    
}
