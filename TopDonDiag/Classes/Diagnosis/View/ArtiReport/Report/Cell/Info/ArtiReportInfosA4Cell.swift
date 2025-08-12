//
//  ArtiReportInfosA4Cell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/6/5.
//

import UIKit

// MARK: - Model

@objc(TDD_ArtiReportInfo)
@objcMembers
public class ArtiReportInfo: NSObject {
    var title: String
    var value: String
    
    var combineText: String
    lazy var attributedText: NSAttributedString = {
        var mAtt = NSMutableAttributedString()
        let titleAtt = NSAttributedString(string: "\(title) ", attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular), .foregroundColor: UIColor.tdd_pdfDtcNormal()])
        let valueAtt = NSAttributedString(string: "\(value) ", attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular), .foregroundColor: UIColor.tdd_reportInfoValueText()])
        mAtt.append(titleAtt)
        mAtt.append(valueAtt)
        return mAtt
    }()
    
    var infoHeight: CGFloat = 20
    
    public init(title: String, value: String) {
        self.title = title
        self.value = value
        
        self.combineText = "\(title) \(value)"
        
        self.infoHeight = max(20, self.combineText.height(maxWidth: (PDFInfo.size.width - 48.0) / 2.0, font: UIFont.systemFont(ofSize: 10, weight: .regular)))
        
        super.init()
    }
    
    var isEmpty: Bool {
        return title.isEmpty && value.isEmpty
    }
    
    static var empty: ArtiReportInfo {
        .init(title: "", value: "")
    }
    
    static func map(_ infos: [ArtiReportInfo]) -> [DArtiReportInfos] {
        guard !infos.isEmpty else {
            return []
        }
        
        let infosCount = infos.count
        let d = infosCount / 2
        let m = infosCount % 2
        var dInfos: [DArtiReportInfos] = []
        
        for i in 0..<(d+m) {
            let info = DArtiReportInfos.empty
            dInfos.append(info)
        }
        
        for (idx, info) in infos.enumerated() {
            let dInfo = getDInfo(infos: idx, dInfos: dInfos)
            if (idx % 2) == 0 {
                dInfo?.left = info
            } else {
                dInfo?.right = info
            }
            if let dInfo = dInfo, dInfo.right.isEmpty {
                dInfo.hasRight = false
            }
        }
        
        return dInfos
    }
    
    private static func getDInfo(infos idx: Int, dInfos: [DArtiReportInfos]) -> DArtiReportInfos? {
        let dIdx = idx / 2
        guard dInfos.indices.contains(dIdx) else {
            return nil
        }
        return dInfos[dIdx]
    }
    
}

class DArtiReportInfos {
    var left: ArtiReportInfo
    var right: ArtiReportInfo
    var hasRight: Bool = true
    
    init(left: ArtiReportInfo, right: ArtiReportInfo, hasRight: Bool = true) {
        self.left = left
        self.right = right
        self.hasRight = hasRight
    }
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    
    static var empty: DArtiReportInfos {
        .init(left: .empty, right: .empty, hasRight: true)
    }
    
    var cellHeight: CGFloat {
        return max(left.infoHeight, right.infoHeight)
    }
    
}

// MARK: - TDD_ArtiReportInfosA4Cell
@objc(TDD_ArtiReportInfosA4Cell)
@objcMembers
public class ArtiReportInfosA4Cell: ArtiADASReportBaseCell, UITableViewDelegate, UITableViewDataSource {
    
    public static func cellHeight(infos: [ArtiReportInfo]) -> CGFloat {
        // 10.0 + CGFloat(ArtiReportInfo.map(infos).count) * 20.0 + 10.0
        let rows = ArtiReportInfo.map(infos)
        let height = rows.reduce(0) { partialResult, newValue in
            return partialResult + newValue.cellHeight
        }
        return 10.0 + height + 10.0
    }
    
    private var dInfos: [DArtiReportInfos] = []
    
    public func update(infos: [ArtiReportInfo]) {
        dInfos = ArtiReportInfo.map(infos)
        
        self.tableView.reloadData()
    }
    
    public override func setupUI() {
        super.setupUI()
        
        contentView.backgroundColor = UIColor.tdd_reportPDFBackground()
        backgroundColor = .clear
        
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.right.left.equalTo(0)
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10.0)
        }
        
    }
    
    // MARK: - Lazy Loading
    private(set) lazy var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.tdd_imageDiagReportInfo()
        if (TDD_DiagnosisTools.customizedType() == TDD_Customized_Germany) {
            imgView.image = nil;
        }
        if (Software.isDeepScan) {
            imgView.image = nil;
        }
        imgView.backgroundColor = UIColor.tdd_btnBackground()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.register(DCell.self, forCellReuseIdentifier: DCell.ID)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return 20.0
        //return UITableView.automaticDimension
        
        return dInfos[indexPath.row].cellHeight
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // rowHeight = 50.0
        return dInfos.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DCell.ID, for: indexPath) as? DCell else {
            return UITableViewCell()
        }
        
        let item = dInfos[indexPath.row]
        cell.update(item)
        return cell
    }

}

extension ArtiReportInfosA4Cell {
    
    final class SingleItemView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        func update(_ model: ArtiReportInfo) {
           // titleLabel.text = model.title
           // valueLabel.text = model.value
            titleLabel.attributedText = model.attributedText
        }
        
        private func setupUI() {
            addSubview(titleLabel)
//            addSubview(valueLabel)
            
            titleLabel.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.right.equalToSuperview()
            }
//            valueLabel.snp.makeConstraints { make in
//                make.top.bottom.equalToSuperview()
//                make.left.equalTo(titleLabel.snp.right)
//                make.right.equalToSuperview()
//            }
        }
        
        // MARK: - Lazy
        
        private(set) lazy var titleLabel: UILabel = {
            let textLabel = TDD_CustomLabel()
            textLabel.font = .systemFont(ofSize: 10, weight: .regular)
            //textLabel.textColor = UIColor.tdd_pdfDtcNormal()
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 0
            //textLabel.adjustsFontSizeToFitWidth = true
            return textLabel
        }()
        
    }
    
    final class DCell: ArtiADASReportBaseCell {
        
        static var ID: String {
            String(describing: self)
        }
        
        public override func setupUI() {
            super.setupUI()
            
            contentView.backgroundColor = .clear
            backgroundColor = .clear
            
            contentView.addSubview(leftItem)
            contentView.addSubview(rightItem)
            
            leftItem.snp.makeConstraints { make in
                make.left.equalTo(24.0)
                make.top.equalToSuperview()
                make.width.equalTo((PDFInfo.size.width - 48.0) / 2.0)
                make.height.equalTo(20)
            }
            
            rightItem.snp.makeConstraints { make in
                make.left.equalTo(leftItem.snp.right)
                make.top.width.equalTo(leftItem)
                make.height.equalTo(20)
            }
            
        }
        
        func update(_ model: DArtiReportInfos) {
            leftItem.update(model.left)
            rightItem.update(model.right)
            
            leftItem.snp.updateConstraints { make in
                make.height.equalTo(model.left.infoHeight)
            }
            
            rightItem.snp.updateConstraints { make in
                make.height.equalTo(model.right.infoHeight)
            }
            
        }
        
        // MARK: - Lazy
        private lazy var leftItem: SingleItemView = {
            .init(frame: .zero)
        }()
        
        private lazy var rightItem: SingleItemView = {
            .init(frame: .zero)
        }()
        
    }
}
