//
//  TDD_UpdateEquityAccountView.swift
//  AD200
//
//  Created by liuyong on 2024/11/5.
//

import UIKit
import SnapKit
import TDBasis
import TDUIProvider

@objc public class TDD_UpdateEquityAccountView: UIView {

    var equityAccount = ""
    
    var updateAccount: Block.ParameterBlock<String>?
    
    var superView: UIView?
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        
        td.addSubviews(bgView, popView)
        popView.td.addSubviews(titleLabel, accountLabel, accountTextView, clearBtn, errorTipLabel, lineView, cancelBtn, confirmBtn, lineView2)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(45.adaptHD(to: 272.hdHorizontalScale))
            make.height.lessThanOrEqualTo(UI.SCREEN_HEIGHT/2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22)
            make.left.equalToSuperview().offset(20)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        accountTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(accountLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        clearBtn.snp.makeConstraints { make in
            make.right.equalTo(accountTextView).offset(-20)
            make.width.height.equalTo(22)
            make.top.equalTo(accountTextView).offset(10)
        }
        
        errorTipLabel.snp.makeConstraints { make in
            make.top.equalTo(accountTextView.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
//        tipsLabel.snp.makeConstraints { make in
//            make.top.equalTo(accountTextView.snp.bottom).offset(6)
//            make.left.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(accountTextView.snp.bottom).offset(52)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(50)
            make.width.equalTo(confirmBtn)
            make.bottom.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(50)
            make.left.equalTo(cancelBtn.snp.right)
        }
        
        lineView2.snp.makeConstraints { make in
            make.centerY.equalTo(cancelBtn)
            make.centerX.equalToSuperview()
            make.width.equalTo(0.5)
            make.height.equalTo(20)
        }
    }
    
    @objc public func showInView(superView: UIView, account: String, updateAccount: @escaping Block.ParameterBlock<String>) {
        
        superView.addSubview(self)
        accountTextView.text = account
        self.superView = superView
        self.updateAccount = updateAccount
        self.equityAccount = account

    }
    
    @objc public func updateUI(isErrorTipLabelHidden: Bool) {
        TDHUD.hideLoading()
//        if isErrorTipLabelHidden {
//            tipsLabel.snp.remakeConstraints { make in
//                make.top.equalTo(accountTextView.snp.bottom).offset(6)
//                make.left.equalToSuperview().offset(20)
//                make.centerX.equalToSuperview()
//            }
//        } else {
//            tipsLabel.snp.remakeConstraints { make in
//                make.top.equalTo(errorTipLabel.snp.bottom).offset(15)
//                make.left.equalToSuperview().offset(20)
//                make.centerX.equalToSuperview()
//            }
//        }
    }
    
    func dismiss() {
        removeFromSuperview()
    }
    
    @objc func clearBtnClick() {
        accountTextView.text = ""
        clearBtn.isHidden = true
        errorTipLabel.text = ""
    }
    
    @objc func cancelBtnClick() {
        dismiss()
    }
    
    @objc func confirmBtnClick() {
        if accountTextView.text == TDDLocalized.please_enter_email || accountTextView.text.isEmpty {
            return
        }
        self.endEditing(true)
        TDHUD.showLoading(inView: self)
        //切换账号
        self.updateAccount?(self.accountTextView.text)
        
        
    }
    
    lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_color(withHex: 0x000000, alpha: 0.7);
        view.td.addTap { [weak self] tap in
            guard let self = self else { return }
            self.endEditing(true)
        }
        return view
    } ()
    
    lazy var popView : UIView = {
        let view = UIView()
        view.backgroundColor = .cardBg()
        view.layer.cornerRadius = 2.5
        return view
    } ()
    
    lazy var titleLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = TDDLocalized.update_account
        label.textColor = UIColor.tdd_title()
        return label
    }()
    
    lazy var accountLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = TDDLocalized.exchange_query_account + ":"
        label.textColor = UIColor.tdd_title()
        return label
    }()
    
    lazy var accountTextView: TDD_CustomTextView = {
        let textView = TDD_CustomTextView()
        textView.backgroundColor = UIColor.tdd_textFieldBg()
        textView.layer.cornerRadius = 4
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 44)
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.textColor = UIColor.tdd_title()
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        let placeholder =  TDDLocalized.please_enter_account
        let attrPlaceholder = NSMutableAttributedString(string: placeholder)
        attrPlaceholder.addAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: UIColor.tdd_subTitle()], range: NSRange(location: 0, length: placeholder.count))
        textView.attributedPlaceholder = attrPlaceholder
        textView.delegate = self
        return textView
    }()
    
    lazy var clearBtn: UIButton = {
        let btn = UIButton(type: .custom)
        if TDD_DiagnosisTools.softWareIsKindOfTopScan() == true {
            btn.setImage(BridgeTool.tdd_imageNamed("account_edit_close_btn"), for: .normal)
        }else {
            btn.setImage(BridgeTool.tdd_imageNamed("textfiled_clear"), for: .normal)
        }
        
        
        btn.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
        btn.tdd_hitEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        return btn
    }()
    
    @objc public lazy var errorTipLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.tdd_errorRed()
        return label
    }()

    lazy var tipsLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        //label.text = TDDLocalized.update_equity_account_tips
        label.textColor = UIColor.tdd_subTitle()
        return label
    }()
    
    lazy var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_line()
        return view
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.setTitle(TDDLocalized.app_cancel, for: .normal)
        btn.setTitleColor(UIColor.tdd_subTitle(), for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return btn
    }()
    
    @objc public lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.setTitle(TDDLocalized.app_confirm, for: .normal)
        btn.setTitleColor(UIColor.tdd_colorDiagTheme(), for: .normal)
        btn.setTitleColor(UIColor.tdd_colorDiagTheme().withAlphaComponent(0.5), for: .disabled)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_line()
        return view
    }()
}

extension TDD_UpdateEquityAccountView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {

        clearBtn.isHidden = textView.text.isEmpty
        if textView.text.count >= 100 {
            textView.text = textView.text?.td.subString(to: 100)
        }
        if textView.text?.td.isValidateEmail ?? false && textView.text != self.equityAccount || (textView.text.count == 0) {
            confirmBtn.isEnabled = textView.text.count > 0
            errorTipLabel.isHidden = true
            self.updateUI(isErrorTipLabelHidden: true)
        } else {
            confirmBtn.isEnabled = false
            errorTipLabel.isHidden = textView.text == self.equityAccount
            errorTipLabel.text = TDDLocalized.login_email_error_tip
            self.updateUI(isErrorTipLabelHidden: textView.text == self.equityAccount)
        }
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        UIView.animate(withDuration: 0.25) {
            self.popView.transform = CGAffineTransform(translationX: 0, y: -120)
        }
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {

        UIView.animate(withDuration: 0.25) {
            self.popView.transform = .identity
        }
    }
}
