//
//  LMSTextView.swift
//  LMSUI
//
//  Created by zhouxiong on 2024/5/9.
//

import UIKit

@objcMembers
open class TDD_CustomTextView: UITextView {
    public let placeholderLabel = TDD_CustomLabel()

    open var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    
    open override var textContainerInset: UIEdgeInsets {
        didSet {
            placeholderLabel.snp.remakeConstraints { make in
                make.left.equalTo(textContainerInset.left + 5)
                make.right.equalToSuperview().inset(textContainerInset.right + 5)
                make.top.equalTo(textContainerInset.top)
                make.bottom.lessThanOrEqualTo(-10)
            }
        }
    }
    
    open var attributedPlaceholder: NSAttributedString? {
        didSet {
            placeholderLabel.attributedText = attributedPlaceholder
        }
    }

    public override var text: String! {
        didSet {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.semanticContentAttribute = .forceLeftToRight; // 强制 LTR
        self.textAlignment = .left; // 文本左对齐
        
        initial()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initial() {
        // 设置占位符文本属性
        placeholderLabel.font = font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerX.equalToSuperview()
            make.top.equalTo(8)
            make.bottom.lessThanOrEqualTo(-10)
        }

        // 注册监听文本变化的通知
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }

    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    
}

