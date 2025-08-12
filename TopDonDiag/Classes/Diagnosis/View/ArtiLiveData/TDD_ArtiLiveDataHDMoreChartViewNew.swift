//
//  TDD_ArtiLiveDataHDMoreChartViewNew.swift
//  TopdonDiagnosis
//
//  Created by lk_ios2023002 on 2024/2/22.
//

import UIKit
import SnapKit

// MARK: - TDD_ArtiLiveDataHDMoreSelectItemView
@objcMembers
class TDD_ArtiLiveDataHDMoreSelectItemView: UIView {
    
    // MARK: - Properties
    var color: UIColor? {
        didSet {
            colorView.backgroundColor = color
        }
    }
    
    var itemModel: TDD_ArtiLiveDataItemModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI Components
    private lazy var colorView: UIView = {
        let view = UIView()
        view.tdd_addRoundCorner(3, rectCorner: [.topLeft, .bottomLeft])
        return view
    }()
    
    private lazy var titleLab: TDD_CustomLabel = {
        let label = TDD_CustomLabel()
        label.font = UIFont.systemFont(ofSize: 15).tdd_adaptHD()
        label.textColor = UIColor.tdd_title()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private lazy var valueLab: TDD_CustomLabel = {
        let label = TDD_CustomLabel()
        label.tag = 1004
        label.font = UIFont.systemFont(ofSize: 13).tdd_adaptHD()
        label.textColor = UIColor.tdd_color666666()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private lazy var unitLab: TDD_CustomLabel = {
        let label = TDD_CustomLabel()
        label.tag = 1005
        label.font = UIFont.systemFont(ofSize: 13).tdd_adaptHD()
        label.textColor = UIColor.tdd_color666666()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        layer.cornerRadius = 3
        layer.masksToBounds = true
        
        addSubview(colorView)
        addSubview(titleLab)
        addSubview(valueLab)
        addSubview(unitLab)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.tdd_line()
        addSubview(lineView)
        
        setupConstraints(lineView: lineView)
    }
    
    private func setupConstraints(lineView: UIView) {
        colorView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(8 * TDD_DiagBridge.hd_HeightValue())
        }
        
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15 * TDD_DiagBridge.hd_HeightValue())
            make.left.equalTo(colorView).offset(12 * TDD_DiagBridge.hd_HeightValue())
            make.right.equalToSuperview().offset(-20 * TDD_DiagBridge.hd_HeightValue())
        }
        
        valueLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15 * TDD_DiagBridge.hd_HeightValue())
            make.left.equalTo(colorView).offset(12 * TDD_DiagBridge.hd_HeightValue())
            make.right.equalToSuperview().offset(-20 * TDD_DiagBridge.hd_HeightValue())
        }
        
        unitLab.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIEdgeInsets(top: 10 * TDD_DiagBridge.h_HeightValue(), left: 145 * TDD_DiagBridge.h_HeightValue(), bottom: 0, right: 0))
            make.top.equalTo(titleLab.snp.bottom).offset(5 * TDD_DiagBridge.h_HeightValue())
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 10 * TDD_DiagBridge.h_HeightValue(), left: 20 * TDD_DiagBridge.h_HeightValue(), bottom: 0, right: 0))
            make.top.equalTo(unitLab.snp.bottom).offset(10 * TDD_DiagBridge.h_HeightValue())
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UI Updates
    private func updateUI() {
        guard let itemModel = itemModel else { return }
        
        titleLab.text = itemModel.strName
        valueLab.text = "\(TDDLocalized.report_data_stream_number):\(itemModel.strChangeValue ?? "")"
        unitLab.text = "\(TDDLocalized.diagnosis_unit):\(itemModel.strChangeUnit ?? "")"
    }
}

// MARK: - TDD_ArtiLiveDataHDMoreChartView
@objcMembers
class TDD_ArtiLiveDataHDMoreChartViewNew: TDD_ArtiContentBaseView {
    
    // MARK: - Properties
    var model: TDD_ArtiLiveDataMoreChartModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.delaysContentTouches = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 68 * TDD_DiagBridge.h_HeightValue()
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentify")
        return tableView
    }()
    
    private lazy var colorArr: [UIColor] = {
        TDD_DiagBridge.chart4Colors()
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
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
        
        addSubview(tableView)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.tdd_line()
        addSubview(lineView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
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
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TDD_ArtiLiveDataHDMoreChartViewNew: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else { return 0 }
        let selectItems = model.selectItmes
        return selectItems.count / 2 + selectItems.count % 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentify", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        // Remove existing subviews
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        guard let model = model else { return cell }
        let selectItems = model.selectItmes
        
        let leftIndex = indexPath.row % 2 + indexPath.row
        if leftIndex < selectItems.count {
            let leftView = TDD_ArtiLiveDataHDMoreSelectItemView()
            leftView.color = colorArr[min(leftIndex % 2 + indexPath.row, colorArr.count - 2)]
            leftView.itemModel = selectItems[leftIndex] as? TDD_ArtiLiveDataItemModel
            cell.contentView.addSubview(leftView)
            
            leftView.snp.makeConstraints { make in
                make.left.equalTo(cell.contentView).offset(20 * TDD_DiagBridge.hd_HeightValue())
                make.top.equalTo(cell.contentView)
                make.bottom.equalTo(cell.contentView).offset(-10 * TDD_DiagBridge.hd_HeightValue())
                make.width.equalTo((TDD_DiagBridge.iphoneWidthValue() - 20 * TDD_DiagBridge.hd_HeightValue()) / 2)
            }
        }
        
        let rightIndex = leftIndex + 1
        if rightIndex < selectItems.count {
            let rightView = TDD_ArtiLiveDataHDMoreSelectItemView()
            rightView.color = colorArr[min(rightIndex, colorArr.count - 1)]
            rightView.itemModel = selectItems[rightIndex] as? TDD_ArtiLiveDataItemModel
            cell.contentView.addSubview(rightView)
            
            rightView.snp.makeConstraints { make in
                make.right.equalTo(cell.contentView).offset(-20 * TDD_DiagBridge.hd_HeightValue())
                make.top.equalTo(cell.contentView)
                make.bottom.equalTo(cell.contentView).offset(-10 * TDD_DiagBridge.hd_HeightValue())
                make.width.equalTo((TDD_DiagBridge.iphoneWidthValue() - 20 * TDD_DiagBridge.hd_HeightValue()) / 2)
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TDD_ArtiLiveDataHDMoreChartViewNew: UITableViewDelegate {
    // UITableViewDelegate methods can be added here if needed
}
