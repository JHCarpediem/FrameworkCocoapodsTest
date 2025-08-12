//
//  ArtiADASReportTireCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/13.
//

import UIKit

@objc(TDD_ArtiADASReportTireCell)
@objcMembers
open class ArtiADASReportTireCell: UITableViewCell {
    
    private var unit: ArtiADASReportTireUnit?
    
    public var onExpandChanged: ((Bool)->Void)? {
        didSet {
            expandView.onExpandChanged = onExpandChanged
        }
    }
    
    public var onSelectedIndex: ((Int) -> Void)?
    
    private lazy var tirePressureUnits: [String] = [.pa, .bar]
    private lazy var wheelEyebrowUnits: [String] = [.mm, .cm, .inch]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func update(unit: ArtiADASReportTireUnit) {
        self.unit = unit
        
        expandView.update(unit: unit)
        
        if let tirePressureUnit = unit as? ArtiADASReportTirePressureUnit {
            update(units: tirePressureUnits, selectedIndex: index(unit: unit.unit, type: .tirePressure))
        } else if let wheelEyebrowUnit = unit as? ArtiADASReportWheelEyebrowUnit {
            update(units: wheelEyebrowUnits, selectedIndex: index(unit: unit.unit, type: .wheelEyebrow))
        }
        
        tireView.update(unit: unit)
        
        if unit.isFold {
            unitView.isHidden = true
            tireView.isHidden = true
        } else {
            unitView.isHidden = false
            tireView.isHidden = false
        }
    }
    
    public func update(units: [String], selectedIndex: Int) {
        unitView.update(units: units, selectedIndex: selectedIndex)
    }
    
    private func index(unit: String, type: ArtiADASTireUnitType) -> Int {
        
        let units: [String]
        switch type {
        case .tirePressure:
            units = tirePressureUnits
        case .wheelEyebrow:
            units = wheelEyebrowUnits
        }
        
        guard units.contains(unit) else {
            return 0
        }
        return units.firstIndex(of: unit) ?? 0
    }
    
    func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(expandView)
        contentView.addSubview(unitView)
        contentView.addSubview(tireView)
        contentView.addSubview(gapView)
        
        expandView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(48.5)
        }
        
        unitView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(45.0)
            make.top.equalTo(expandView.snp.bottom)
        }
        
        tireView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(unitView.snp.bottom)
            make.height.equalTo(378)
        }
        
        gapView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(10.0)
            make.bottom.equalTo(0)
        }
        
        setupCallbacks()
    }
    
    private func setupCallbacks() {
        unitView.onSelectedIndex = { [weak self] index in guard let self else { return }
            guard let unit = self.unit else { return }
            if self.tireView.isFirstResponder {
                self.tireView.resignFirstResponder()
            }
            
            let targetUnit: String
            switch unit.type {
            case .tirePressure:
                targetUnit = self.tirePressureUnits[index]
            case .wheelEyebrow:
                targetUnit = self.wheelEyebrowUnits[index]
            }
            
            let newUnit = unit.convert(to: targetUnit)
            unit.update(other: newUnit)
            
            self.onSelectedIndex?(index)
        }
    }
    
    // MARK: - Lazy
    private lazy var expandView: ArtiADASReportExpandView = .init(frame: .zero)
    
    private lazy var unitView: ArtiADASReportUnitView = .init(units: ["pa", "bar"], selectedIndex: 0)
    
    private lazy var tireView: ArtiADASReportTireInputView = .init(frame: .zero)
    
    private lazy var gapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_collectionViewBG()
        return view
    }()
}


// MARK: - visibleFrame

extension UITableView {
   
    @objc public var visibleFrame: CGRect {
        
        guard let firstCell = visibleCells.first else {
            return .zero
        }
        
        var visibleFrame = firstCell.frame
        
        
        for cell in visibleCells.dropFirst() {
            visibleFrame = visibleFrame.union(cell.frame)
        }
        
        // return convert(visibleFrame, to: superview)
        return visibleFrame
    }
}
