//
//  TDD_ArtiLiveDataMoreChartViewNew.swift
//  TopdonDiagnosis
//
//  Created by AppTD on 2022/9/7.
//

import UIKit
import SnapKit
import TDUIProvider


// MARK: - TDD_ArtiLiveDataMoreChartViewNew

@objcMembers
public class TDD_ArtiLiveDataMoreChartViewNew: TDD_ArtiContentBaseView {
    
    // MARK: - Properties
    public var model: TDD_ArtiLiveDataMoreChartModel? {
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
        tableView.estimatedRowHeight = 68 * scale
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentify")
        return tableView
    }()
    
    private lazy var colorArr: [UIColor] = {
        TDD_DiagBridge.chart4Colors()
    }()
    
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
extension TDD_ArtiLiveDataMoreChartViewNew: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.selectItmes.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentify", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        // Get or create UI components
        var moreChartView = cell.contentView.viewWithTag(1000) as? TDD_HMoreChartViewNew
        var contenView = cell.contentView.viewWithTag(1001)
        var colorView = cell.contentView.viewWithTag(1002)
        var titleLabel = cell.contentView.viewWithTag(1003) as? TDD_CustomLabel
        var valueLabel = cell.contentView.viewWithTag(1004) as? TDD_CustomLabel
        var unityLabel = cell.contentView.viewWithTag(1005) as? TDD_CustomLabel
        var grayView = cell.contentView.viewWithTag(1006)
        
        if moreChartView == nil {
            // Create moreChartView
            moreChartView = TDD_HMoreChartViewNew()
            moreChartView?.isUserInteractionEnabled = false
            moreChartView?.tag = 1000
            cell.contentView.addSubview(moreChartView!)
            
            // Create grayView
            grayView = UIView()
            grayView?.tag = 1006
            grayView?.backgroundColor = UIColor.tdd_liveDataSegmentationBackground()
            cell.contentView.addSubview(grayView!)
            
            // Create contenView
            contenView = UIView()
            contenView?.tag = 1001
            cell.contentView.addSubview(contenView!)
            
            // Create colorView
            colorView = UIView()
            colorView?.tag = 1002
            colorView?.layer.cornerRadius = 5 * scale
            contenView?.addSubview(colorView!)
            
            // Create titleLabel
            titleLabel = TDD_CustomLabel()
            titleLabel?.tag = 1003
            titleLabel?.font = UIFont.systemFont(ofSize: 15).tdd_adaptHD()
            titleLabel?.textColor = UIColor.tdd_title()
            titleLabel?.numberOfLines = 0
            titleLabel?.text = ""
            contenView?.addSubview(titleLabel!)
            
            // Create valueLabel
            valueLabel = TDD_CustomLabel()
            valueLabel?.tag = 1004
            valueLabel?.font = UIFont.systemFont(ofSize: 13).tdd_adaptHD()
            valueLabel?.textColor = UIColor.tdd_color666666()
            valueLabel?.numberOfLines = 0
            valueLabel?.text = ""
            contenView?.addSubview(valueLabel!)
            
            // Create unityLabel
            unityLabel = TDD_CustomLabel()
            unityLabel?.tag = 1005
            unityLabel?.font = UIFont.systemFont(ofSize: 13).tdd_adaptHD()
            unityLabel?.textColor = UIColor.tdd_color666666()
            unityLabel?.numberOfLines = 0
            unityLabel?.text = ""
            contenView?.addSubview(unityLabel!)
            
            // Create lineView
            let lineView = UIView()
            lineView.backgroundColor = UIColor.tdd_line()
            contenView?.addSubview(lineView)
            
            // Setup constraints
            moreChartView?.snp.makeConstraints { make in
                make.top.right.left.equalTo(cell.contentView).inset(UIEdgeInsets(top: 15 * scale, left: 15 * scale, bottom: 0, right: 15 * scale))
                make.height.equalTo(200 * scale)
            }
            
            grayView?.snp.makeConstraints { make in
                make.top.equalTo(moreChartView!.snp.bottom).offset(23 * scale)
                make.left.right.equalTo(cell.contentView)
                make.height.equalTo(20 * scale)
            }
            
            contenView?.snp.makeConstraints { make in
                make.top.equalTo(grayView!.snp.bottom)
                make.left.right.equalTo(cell.contentView)
                make.bottom.equalTo(cell.contentView)
            }
            
            colorView?.snp.makeConstraints { make in
                make.left.top.equalTo(contenView!).inset(UIEdgeInsets(top: 15 * scale, left: 20 * scale, bottom: 0, right: 0))
                make.size.equalTo(CGSize(width: 10 * scale, height: 10 * scale))
            }
            
            titleLabel?.snp.makeConstraints { make in
                make.left.top.equalTo(contenView!).inset(UIEdgeInsets(top: 10 * scale, left: 45 * scale, bottom: 0, right: 0))
            }
            
            valueLabel?.snp.makeConstraints { make in
                make.left.equalTo(contenView!).inset(UIEdgeInsets(top: 10 * scale, left: 45 * scale, bottom: 0, right: 0))
                make.top.equalTo(titleLabel!.snp.bottom).offset(5 * scale)
            }
            
            unityLabel?.snp.makeConstraints { make in
                make.left.equalTo(contenView!).inset(UIEdgeInsets(top: 10 * scale, left: 145 * scale, bottom: 0, right: 0))
                make.top.equalTo(titleLabel!.snp.bottom).offset(5 * scale)
            }
            
            lineView.snp.makeConstraints { make in
                make.left.right.equalTo(contenView!).inset(UIEdgeInsets(top: 10 * scale, left: 20 * scale, bottom: 0, right: 0))
                make.top.equalTo(unityLabel!.snp.bottom).offset(10 * scale)
                make.height.equalTo(1)
                make.bottom.equalTo(cell.contentView)
            }
        }
        
        let index = indexPath.row
        
        if index == 0 {
            moreChartView?.isHidden = false
            grayView?.isHidden = false
            
            contenView?.snp.remakeConstraints { make in
                make.top.equalTo(grayView!.snp.bottom)
                make.left.right.equalTo(cell.contentView)
                make.bottom.equalTo(cell.contentView)
            }
            
            var valueArr: [Any] = []
            if let selectItems = model?.selectItmes {
                for itemModel in selectItems {
                    if let liveDataItem = itemModel as? TDD_ArtiLiveDataItemModel {
                        valueArr.append(liveDataItem.valueArr ?? [])
                    }
                }
            }
            
            moreChartView?.valueArr = valueArr as? [[Any]]
        } else {
            moreChartView?.isHidden = true
            grayView?.isHidden = true
            
            contenView?.snp.remakeConstraints { make in
                make.top.equalTo(cell.contentView)
                make.left.right.equalTo(cell.contentView)
                make.bottom.equalTo(cell.contentView)
            }
        }
        
        colorView?.backgroundColor = colorArr[index % 4]
        
        if index > (model?.selectItmes.count ?? 0) - 1 {
            return cell
        }
        
        if let selectItems = model?.selectItmes,
           index < selectItems.count,
           let itemModel = selectItems[index] as? TDD_ArtiLiveDataItemModel {
            
            titleLabel?.text = itemModel.strName
            valueLabel?.text = "\(TDDLocalized.report_data_stream_number):\(itemModel.strChangeValue ?? "")"
            unityLabel?.text = "\(TDDLocalized.diagnosis_unit):\(itemModel.strChangeUnit ?? "")"
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TDD_ArtiLiveDataMoreChartViewNew: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection if needed
    }
}
