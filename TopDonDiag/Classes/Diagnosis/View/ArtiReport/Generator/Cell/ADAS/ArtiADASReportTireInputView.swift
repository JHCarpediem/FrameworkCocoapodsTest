//
//  ArtiADASReportTireInputView.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/13.
//

import UIKit

/*
* LF  左前轮
* RF  右前轮
* LR  左后轮
* RR  右后轮
*/
class ArtiADASReportTireInputView: UIView {
   
    var unit: ArtiADASReportTireUnit?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func update(unit: ArtiADASReportTireUnit) {
        self.unit = unit
        
        LFInputTextField.unitLabel.text = unit.unit
        RFInputTextField.unitLabel.text = unit.unit
        LRInputTextField.unitLabel.text = unit.unit
        RRInputTextField.unitLabel.text = unit.unit
        
        [LFInputTextField, RFInputTextField, LRInputTextField, RRInputTextField].forEach { tf in
            tf.unit = unit
            tf.unitLabel.snp.updateConstraints { make in
                make.width.equalTo(tf.unitLabel.intrinsicContentSize.width)
            }
        }
        
        if !unit.lfValue.isEmpty {
            LFInputTextField.textField.text = unit.lfValue
        } else {
            LFInputTextField.textField.text = nil
        }
        if !unit.rfValue.isEmpty {
            RFInputTextField.textField.text = unit.rfValue
        } else {
            RFInputTextField.textField.text = nil
        }
        if !unit.lrValue.isEmpty {
            LRInputTextField.textField.text = unit.lrValue
        } else {
            LRInputTextField.textField.text = nil
        }
        if !unit.rrValue.isEmpty {
            RRInputTextField.textField.text = unit.rrValue
        } else {
            RRInputTextField.textField.text = nil
        }
        
        if unit.floatBit > 0 {
            [LFInputTextField, RFInputTextField, LRInputTextField, RRInputTextField].forEach {
                $0.textField.keyboardType = .decimalPad
            }
        } else {
            [LFInputTextField, RFInputTextField, LRInputTextField, RRInputTextField].forEach {
                $0.textField.keyboardType = .numberPad
            }
        }
    }
    
    func setupUI() {
        addSubview(LRInputTextField)
        addSubview(LFInputTextField)
        
        addSubview(carImageView)
        
        addSubview(RRInputTextField)
        addSubview(RFInputTextField)
        
        LRInputTextField.snp.makeConstraints { make in
            make.top.equalTo(22.0)
            make.size.equalTo(CGSize(width: 120, height: 44.0))
            make.left.equalTo(32.0)
        }
        
        LFInputTextField.snp.makeConstraints { make in
            make.top.equalTo(LRInputTextField)
            make.size.equalTo(LRInputTextField)
            make.right.equalTo(-32.0)
        }
        
        carImageView.snp.makeConstraints { make in
            //make.left.right.equalToSuperview().inset(15.0)
            make.top.equalTo(LRInputTextField.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(180)
        }
        
        RRInputTextField.snp.makeConstraints { make in
            make.top.equalTo(carImageView.snp.bottom).offset(8.0)
            make.left.size.equalTo(LRInputTextField)
        }
        
        RFInputTextField.snp.makeConstraints { make in
            make.top.equalTo(carImageView.snp.bottom).offset(8.0)
            make.right.size.equalTo(LFInputTextField)
        }
        
        setupCallbacks()
    }
    
    private func setupCallbacks() {
        LFInputTextField.onTextDidChanged = { [weak self] lfValue in guard let self else { return }
            self.unit?.lfValue = lfValue
        }
        RFInputTextField.onTextDidChanged = { [weak self] rfValue in guard let self else { return }
            self.unit?.rfValue = rfValue
        }
        LRInputTextField.onTextDidChanged = { [weak self] lrValue in guard let self else { return }
            self.unit?.lrValue = lrValue
        }
        RRInputTextField.onTextDidChanged = { [weak self] rrValue in guard let self else { return }
            self.unit?.rrValue = rrValue
        }
    }
    
    // MARK: - Lazy Load
    /// 左前轮
    private lazy var LFInputTextField: TireInputTextField = .init(frame: .zero)
    /// 右前轮
    private lazy var RFInputTextField: TireInputTextField = .init(frame: .zero)
    /// 左后轮
    private lazy var LRInputTextField: TireInputTextField = .init(frame: .zero)
    /// 右后轮
    private lazy var RRInputTextField: TireInputTextField = .init(frame: .zero)
    
    private lazy var carImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = BridgeTool.tdd_imageNamed("report_pic_car")
        return imgView
    }()
}

// MARK: - TireInputTextField

class TireInputTextField: UIView, UITextFieldDelegate {
    
    var onTextDidChanged: ((String) -> Void)?
    
    var unit: ArtiADASReportTireUnit?
    
    private(set) lazy var textField: UITextField = {
        let view = UITextField()
        view.keyboardType = .numberPad
        // TODO: - 国际化
        view.attributedPlaceholder = NSAttributedString(string: "请输入", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.tdd_colorCCCCCC()])
        view.delegate = self
        return view
    }()
    
    private(set) lazy var unitLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .right
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func setupUI() {
        layer.cornerRadius = 2.5
        layer.borderColor = UIColor.tdd_colorCCCCCC().cgColor
        layer.borderWidth = 1.0
        
        addSubview(unitLabel)
        addSubview(textField)
        
        unitLabel.snp.makeConstraints { make in
            make.right.equalTo(-12.0)
            make.centerY.equalToSuperview()
            make.width.equalTo(unitLabel.intrinsicContentSize.width)
        }
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(12.0)
            make.centerY.equalToSuperview()
            make.right.equalTo(unitLabel.snp.left).offset(1.0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        callBack(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tfText: String
        defer { textField.text = tfText }
        
        if let text = textField.text, let floatValue = text.i18nFloat {
            if let unit = self.unit {
                let boundText: String
                if unit.floatBit > 0 { // float
                    let boundValue = max(unit.lowerBound.i18nFloatValue, min(unit.upperBound.i18nFloatValue, floatValue))
                    boundText = boundValue.floatUnitValue()
                } else { // int
                     let boundValue = max(unit.lowerBound.i18nIntValue, min(unit.upperBound.i18nIntValue, Int(floatValue)))
                    //let boundValue = max(unit.lowerBound.i18nFloatValue, min(unit.upperBound.i18nFloatValue, floatValue))
                    // boundText = boundValue.intUnitValue()
                    boundText = "\(boundValue)"
                }
                tfText = boundText
                onTextDidChanged?(boundText)
            } else {
                tfText = text
                onTextDidChanged?(text)
            }
        } else {
            tfText = ""
            onTextDidChanged?("")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let unit = self.unit else {
            return true
        }
        
        if string.isEmpty { return true }
        
        if unit.floatBit > 0 {
            return onePoint(textField, shouldChangeCharactersIn: range, replacementString: string, unit: unit)
        } else {
            return integer(textField, shouldChangeCharactersIn: range, replacementString: string, unit: unit)
        }
        
        return true
    }
    
    private func onePoint(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, unit: ArtiADASReportTireUnit) -> Bool {
        // 第一个字符输入. 自动填充0.
        if range.location == 0 && string == String.i18nCurrentDecimalSeparator() && (textField.text?.isEmpty ?? true) {
            textField.text = "0\(String.i18nCurrentDecimalSeparator())"
            return false
        }
        
        // 获取当前文本框的文本
        guard let currentText = textField.text else { return true }
        
        if currentText.count >= unit.upperBound.count {
            return false
        }
        
        if currentText.count == (unit.upperBound.count - 1) && string == String.i18nCurrentDecimalSeparator() {
            return false
        }
        
        // 判断是否超过最大字符数
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if newText.count > unit.upperBound.count {
            return false
        }
        
        if currentText.contains(String.i18nCurrentDecimalSeparator()) && string == String.i18nCurrentDecimalSeparator() {
            return false
        }
        
        if currentText.contains(String.i18nCurrentDecimalSeparator()) {
            let components: [String]
            if #available(iOS 16.0, *) {
                components = currentText.split(separator: String.i18nCurrentDecimalSeparator()).compactMap{ String($0) }
            } else {
                components = currentText.split(separator: String.i18nCurrentDecimalSeparator().first ?? ".").compactMap{ String($0) }
            }
            if components.count > 1 && ((components.last?.count ?? 0) >= 1) {
                if string.isEmpty && range.length > 0 {
                    return true
                }
                return false
            }
            return true
        }
        
        if newText == String.i18nCurrentDecimalSeparator() {
            return false
        }
        
        // 判断第一个字符为0时，只能输入小数点
        if newText.hasPrefix("0") && newText.count > 1 && String(newText[1]) != String.i18nCurrentDecimalSeparator() {
            return false
        }
        
        return true
    }
    
    private func integer(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, unit: ArtiADASReportTireUnit) -> Bool {
        
        // 获取当前文本框的文本
        guard let currentText = textField.text else { return true }
        
        if currentText.count >= unit.upperBound.count {
            return false
        }
        
        // 判断是否超过最大字符数
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if newText.count >= unit.upperBound.count {
            return false
        }
        
        return true
    }
    
    
    @objc func textDidChanged(_ noti: Notification) {
        guard let tf = noti.object as? UITextField, tf === textField else { return }
        callBack(tf)
    }
    
    private func callBack(_ textField: UITextField) {
        if let text = textField.text, let _ = text.i18nFloat {
            onTextDidChanged?(text)
        } else {
            onTextDidChanged?("")
        }
    }
}
