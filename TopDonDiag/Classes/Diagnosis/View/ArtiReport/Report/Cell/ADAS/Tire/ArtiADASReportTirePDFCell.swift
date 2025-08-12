//
//  ArtiADASReportTirePDFCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/20.
//

import UIKit

@objc(TDD_ArtiADASReportTirePDFCell)
@objcMembers
public class ArtiADASReportTirePDFCell: ArtiADASReportBaseCell, UITableViewDelegate, UITableViewDataSource {
    
    public static func a4CellHeight(_ models: [ArtiADASTirePDFPageRowData]) -> CGFloat {
        return 7 + CGFloat(models.count) * 32.0 + 15.0
    }
    
    public func update(_ models: [ArtiADASTirePDFPageRowData]) {
        self.models = models
        
        tableView.reloadData()
    }
    
    private var models: [ArtiADASTirePDFPageRowData] = []
    
    public override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24.0)
            make.top.equalTo(7.0)
            make.bottom.equalTo(-15.0)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.register(ArtiADASReportTirePDFRowCell.self, forCellReuseIdentifier: "kCell")
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32.0
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kCell", for: indexPath) as? ArtiADASReportTirePDFRowCell else {
            return UITableViewCell()
        }
        
        let model = models[indexPath.row]
        cell.update(model, isLastCell: indexPath.row == (models.count - 1))
        
        return cell
    }
    
}


class ArtiADASReportTirePDFRowCell: ArtiADASReportBorderCell {
    
    func update(_ model: ArtiADASTirePDFPageRowData, isLastCell: Bool) {
        switch model.rowLeft.dataType {
        case .position:
            bgView.isHidden = false
        case .current:
            bgView.isHidden = true
        case .previous:
            bgView.isHidden = true
        case .posterior:
            bgView.isHidden = true
        }
        
        leftLeftLabel.attributedText  = model.rowLeft.previewLeftValue
        leftRightLabel.attributedText = model.rowLeft.previewRightValue
        
        rightLeftLabel.attributedText  = model.rowRight.previewLeftValue
        rightRightLabel.attributedText = model.rowRight.previewRightValue
        
        bottomBorderLine.snp.updateConstraints { make in
            make.bottom.equalTo(isLastCell ? 0 : PDFInfo.lineWidthHeight)
        }
    }
    
    override func setupUI() {
        
        contentView.addSubview(bgView)
        contentView.addSubview(leftLeftLabel)
        contentView.addSubview(leftRightLabel)
        contentView.addSubview(verticalLineView)
        contentView.addSubview(rightLeftLabel)
        contentView.addSubview(rightRightLabel)
        
        super.setupUI()
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftLeftLabel.snp.makeConstraints { make in
            make.left.equalTo(10.0)
            make.top.bottom.equalToSuperview()
        }
        
        leftRightLabel.snp.makeConstraints { make in
            make.right.equalTo(verticalLineView.snp.left).offset(-10.0)
            make.top.bottom.equalToSuperview()
        }
        
        verticalLineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(PDFInfo.lineWidthHeight)
            make.centerX.equalToSuperview()
        }
        
        rightLeftLabel.snp.makeConstraints { make in
            make.left.equalTo(verticalLineView.snp.right).offset(10.0)
            make.top.bottom.equalToSuperview()
        }
        
        rightRightLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-10.0)
        }
        
    }
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_color(withHex: 0xF4F4F4)
        return view
    }()
    
    private(set) lazy var leftLeftLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var leftRightLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .right
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private lazy var verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = PDFInfo.lineColor
        return view
    }()
    
    private(set) lazy var rightLeftLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var rightRightLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.textAlignment = .right
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
}
