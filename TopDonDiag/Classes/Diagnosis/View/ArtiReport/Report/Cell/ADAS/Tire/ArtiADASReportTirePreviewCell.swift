//
//  ArtiADASReportTirePreviewCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import UIKit

@objc(TDD_ArtiADASReportTirePreviewCell)
@objcMembers
public class ArtiADASReportTirePreviewCell: ArtiADASReportBaseCell {
    
    public static func height(_ data: ArtiADASTirePDFData) -> CGFloat {
        let top: CGFloat = 7.0
        let leftFrontHeight = CGFloat(data.leftFront.rows.count) * 40
        let leftGap: CGFloat = 12
        let leftRearHeight = leftFrontHeight
        let imageHeight: CGFloat = 180
        let rightFrontHeight = leftFrontHeight
        let rightGap: CGFloat = 12
        let rightRearHeight = leftFrontHeight
        let bottom: CGFloat = 15.0
        
        return top + leftRearHeight + leftGap + leftRearHeight + imageHeight + rightFrontHeight + rightRearHeight + bottom
    }
    
    public func update(_ data: ArtiADASTirePDFData) {
        leftFrontTable.postion = data.leftFront
        leftRearTable.postion = data.leftRear
        rightFrontTable.postion = data.rightFront
        rightRearTable.postion = data.rightRear
        
        leftFrontTable.snp.updateConstraints { make in
            make.height.equalTo(CGFloat(data.leftFront.rows.count * 40))
        }
    }
    
    public override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(leftFrontTable)
        contentView.addSubview(leftRearTable)
        
        contentView.addSubview(carImageView)
        
        contentView.addSubview(rightFrontTable)
        contentView.addSubview(rightRearTable)
        
        leftFrontTable.snp.makeConstraints { make in
            make.top.equalTo(7.0)
            make.left.right.equalToSuperview().inset(15.0)
            make.height.equalTo(80)
        }
        
        leftRearTable.snp.makeConstraints { make in
            make.top.equalTo(leftFrontTable.snp.bottom).offset(12.0)
            make.left.right.equalTo(leftFrontTable)
            make.height.equalTo(leftFrontTable)
        }
        
        carImageView.snp.makeConstraints { make in
            make.top.equalTo(leftRearTable.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(180)
        }
        
        rightFrontTable.snp.makeConstraints { make in
            make.top.equalTo(carImageView.snp.bottom)
            make.left.right.equalTo(leftFrontTable)
            make.height.equalTo(leftFrontTable)
        }
        
        rightRearTable.snp.makeConstraints { make in
            make.top.equalTo(rightFrontTable.snp.bottom).offset(12.0)
            make.left.right.equalTo(leftFrontTable)
            make.height.equalTo(leftFrontTable)
        }
        
    }
    
    // MARK: - Lazy Load
    
    private lazy var leftFrontTable: TirePositionView = .init(frame: .zero)
    private lazy var leftRearTable: TirePositionView = .init(frame: .zero)
    
    private lazy var carImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = BridgeTool.tdd_imageNamed("report_pic_car")
        return imgView
    }()
    
    private lazy var rightFrontTable: TirePositionView = .init(frame: .zero)
    private lazy var rightRearTable: TirePositionView = .init(frame: .zero)
    
    
}

// MARK: - TirePositionView

extension ArtiADASReportTirePreviewCell {
    
    class TirePositionView: UIView, UITableViewDelegate, UITableViewDataSource {
        
        var rows: [ArtiADASTirePDFRowData] = []
        
        var postion: ArtiADASTirePDFPositionData? {
            didSet {
                self.rows = postion?.rows ?? []
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
            addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
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
            
            tableView.register(ArtiADASReportTirePreviewRowCell.self, forCellReuseIdentifier: "kArtiADASReportTirePreviewRowCell")
            
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            return tableView
        }()
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 40.0
        }
        
        // MARK: - UITableViewDataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return rows.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "kArtiADASReportTirePreviewRowCell", for: indexPath) as? ArtiADASReportTirePreviewRowCell else {
                return UITableViewCell()
            }
            let model = rows[indexPath.row]
            cell.update(model, isLastCell: indexPath.row == (rows.count - 1))
            return cell
        }
        
    }
    
}
