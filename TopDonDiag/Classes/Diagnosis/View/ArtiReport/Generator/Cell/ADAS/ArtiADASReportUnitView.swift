//
//  ArtiADASReportUnitView.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/13.
//

import UIKit

class ArtiADASReportUnitView: UIView {
    
    private(set) var units: [String] = []
    var selectedIndex: Int = 0
    
    var onSelectedIndex: ((Int) -> Void)?
    
    init(units: [String], selectedIndex: Int = 0) {
        self.units = units
        self.selectedIndex = selectedIndex
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    func update(units: [String], selectedIndex: Int) {
        self.units = units
        self.selectedIndex = selectedIndex
        
        segmentView.update(units: units, selectedIndex: selectedIndex)
        segmentView.snp.updateConstraints { make in
            make.size.equalTo(segmentView.intrinsicContentSize)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(segmentView)
        addSubview(measureButton)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        segmentView.snp.makeConstraints { make in
            make.top.equalTo(15.0)
            make.right.equalTo(-20.0)
            make.size.equalTo(segmentView.intrinsicContentSize)
        }
        
        measureButton.snp.makeConstraints { make in
            make.size.equalTo(24.0)
            make.centerY.equalTo(segmentView)
            make.right.equalTo(segmentView.snp.left).offset(-16.0)
        }
        
        setupMeasure()
        
        segmentView.onSelectedIndex =  { [weak self] idx in guard let self else { return }
            
            self.onSelectedIndex?(idx)
        }
    }
    
    private func setupMeasure(isOnClicked: Bool = false) {
        guard let measureAppURL = URL(string: "measure://") else { return }
        
        let canOpen = UIApplication.shared.canOpenURL(measureAppURL)
        measureButton.isHidden = !canOpen
        
        // onClicked
        guard isOnClicked else { return }
        guard canOpen else { return }
        UIApplication.shared.open(measureAppURL, options: [:], completionHandler: nil)
    }
    
    // MARK: - Lazy Load
    private(set) lazy var titleLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.text = TDDLocalized.diagnosis_unit
        textLabel.font = .systemFont(ofSize: 12, weight: .regular)
        // TODO: - 颜色使用配色
        textLabel.textColor = UIColor.tdd_color666666()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var measureButton: UIButton = {
        let button = UIButton()
        button.setImage(BridgeTool.tdd_imageNamed("report_icon_cl"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(measureButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var segmentView: UnitSegmentView = {
        return UnitSegmentView(units: self.units, selectedIndex: self.selectedIndex)
    }()
    
    @objc func measureButtonClicked() {
        setupMeasure(isOnClicked: true)
    }
    
}

// MARK: - UnitSegmentView

class UnitSegmentView: UIView {
    
    final class Button: UIButton {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        func setupUI() {
            
            layer.cornerRadius = 1.5
            titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
            
            // normal
            setTitleColor(UIColor.tdd_color666666(), for: .normal)
            
            // selected
            setTitleColor(UIColor.tdd_color(withHex: 0xF22222), for: .selected)
            
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            if isSelected {
                backgroundColor = UIColor.tdd_color(withHex: 0xF22222, alpha: 0.1)
            } else {
                backgroundColor = UIColor.tdd_ColorEEEEEE()
            }
        }
        
    }
    
    private(set) var units: [String] = []
    private var buttons: [Button] = []
    
    var selectedIndex: Int = 0
    
    var onSelectedIndex: ((Int) -> Void)?
    
    init(units: [String], selectedIndex: Int = 0) {
        self.units = units
        self.selectedIndex = selectedIndex
        
        super.init(frame: .zero)
        
        setupButtons()
        
        setupUI()
    }
    
    func update(units: [String], selectedIndex: Int) {
        self.units = units
        self.selectedIndex = selectedIndex
        
        self.buttons.removeAll()
        setupButtons()
        
        subviews.forEach { $0.removeFromSuperview() }
        stackView = createStackView()
        
        setupUI()
    }
    
    private func setupButtons() {
        for (idx, unit) in units.enumerated() {
            let btn = Button(frame: .zero)
            btn.setTitle(unit, for: .normal)
            btn.setTitle(unit, for: .selected)
            btn.isSelected = idx == selectedIndex
            btn.tag = idx
            btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
            self.buttons.append(btn)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: CGFloat(46 * units.count) + 8.5 * CGFloat(units.count - 1), height: 24.0)
    }
    
    func setupUI() {
        addSubview(stackView)
        
        var frame = self.frame
        let size = CGSize(width: CGFloat(46 * units.count) + 8.5 * CGFloat(units.count - 1), height: 24.0)
        frame.size = size
        self.frame = frame
        
        stackView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.size.equalTo(size)
        }
        
    }
    
    @objc func btnClicked(_ btn: Button) {
        guard btn.tag != selectedIndex else { return }
        btn.isSelected = true
        selectedIndex = btn.tag
        
        for (idx, button) in buttons.enumerated() {
            if idx != selectedIndex {
                btn.isSelected = false
            }
        }
        
        onSelectedIndex?(btn.tag)
    }
    
    // MARK: - Lazy load
    private lazy var stackView: UIStackView = {
        createStackView()
    }()
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8.5
        return stackView
    }
}
