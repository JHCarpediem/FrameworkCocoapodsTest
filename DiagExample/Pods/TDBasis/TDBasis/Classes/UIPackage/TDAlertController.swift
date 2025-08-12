//
//  TDAlertController.swift
//  TDBasis
//
//  Created by Fench on 2024/8/26.
//

import UIKit

@objc public enum TDAlertButtonStyle: Int {
    case `default`  // 系统样色
    case custom     // 自定义样式
}

extension TDAlertController {
    @discardableResult
    @objc public static func show(title: String?, content: String?, actions: [AlertAction]) -> TDAlertController {
        show(title, message: content, config: TDAlertConfig.topscan, actions: actions)
    }
}

// MARK: - update Attribute message 
extension  TDAlertController {
    @objc public func setAttributeMessage(_ attributeMsg: NSAttributedString?, tapHandle: Block.VoidBlock? = nil) {
        guard let attributeMsg = attributeMsg else { return }
        messageLabel.text = nil
        messageLabel.attributedText = attributeMsg
        _updateAttributeMsg(attributeMsg)
        if let tapHandle = tapHandle {
            messageLabel.td.addTap { [weak self] tap in
                tapHandle()
            }
        }
    }
    
    @objc public func updateAttributeMessage(_ msg: NSAttributedString) {
        _updateAttributeMsg(msg)
    }
}

@objc
@objcMembers
open class TDAlertController: UIViewController {
    public var config: TDAlertConfig = .global
    
    public var priorityValue: Float = 1000
    public var priority: TDAlertController.AlertPriority {
        get { .init(priorityValue) }
        set { priorityValue = newValue.value }
    }
    public var btnArrangeStyle: TDAlertButtonArrangeStyle = .horizontal
    /// 点击message 回调  message 带link
    public var messageTapHandle: (()->Void)?
    
    /// alert 弹框的按钮数组
    private var actions: [AlertAction] = [AlertAction]()
    
    public var contentView: UIView = UIView()
    public var titleLabel: UILabel = UILabel()
    public var messageLabel: UILabel = UILabel()
    public var actionBtns: [UIButton] = [UIButton]()
    public var btnView: UIView = UIView()
    public var imageView: UIImageView = UIImageView()
    public var closeBtn: UIButton = UIButton(type: .custom)
    public var nomoreAlertBtn: UIButton = UIButton(type: .custom)
    
    private var link: String?
    private var alertTitle: String?
    private var message: String?
    private var image: UIImage?
    private var scrollView: UIScrollView = UIScrollView()
    private var hasTitle: Bool { !(alertTitle?.isEmpty ?? true) }
    private var hasMessage: Bool { !(message?.isEmpty ?? true) }
    private var btnViewHeight: CGFloat {
        var btnHeight: CGFloat = config.alertButtonStyle == .custom ? 70 : 50
        let style = actions.first?.btnStyle ?? .default
        if config.alertButtonArrangeStyle == .vertical {
            if style == .custom {
                btnHeight = CGFloat(actions.count) * (45 + 16) - 16 + 24
            } else {
                btnHeight = CGFloat(actions.count) * 50
            }
        }
        return btnHeight + noMoreHeight
    }
    
    static private var alertStack: [TDAlertController] = []
    
    private var noMoreHeight: CGFloat { config.isShowNomoreAlert ? 40 : 0 }
    /// 显示alertView 使用方法类似UIAlertController
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 说明
    ///   - actions: actions [LMSAlertAction]
    @discardableResult
    static internal func show(_ title: String?, message: String?, image: UIImage? = nil, config: TDAlertConfig, priority: AlertPriority = .required, actions: [AlertAction]) -> Self {
        UIApplication.shared.keyWindow?.endEditing(true)
        let alert = Self.init()
        alert.hidesBottomBarWhenPushed = true
        alert.modalPresentationStyle = .overCurrentContext
        alert.alertTitle = title
        alert.actions = actions
        alert.message = message
        alert.config = config
        alert.image = image
        alert.priority = priority
        alert.btnArrangeStyle = actions.count > 2 ? .vertical : config.alertButtonArrangeStyle
        if let index = alertStack.firstIndex(where: { alert.priority >= $0.priority }) {
            alertStack.insert(alert, at: index)
        } else {
            alertStack.append(alert)
        }
        
        if let alertVC =  UI.topViewController as? TDAlertController {
            if priority < alertVC.priority { return alert }
            
            UI.topViewController?.dismiss(animated: false, completion: {
                if UI.topViewController?.tabBarController != nil {
                    UI.topViewController?.tabBarController?.present(alert, animated: false, completion: nil)
                } else {
                    UI.topViewController?.present(alert, animated: false, completion: nil)
                }
            })
        } else {
            if UI.topViewController?.tabBarController != nil {
                UI.topViewController?.tabBarController?.present(alert, animated: false, completion: nil)
            } else {
                UI.topViewController?.present(alert, animated: false, completion: nil)
            }
        }
        
        return alert
        
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        _init()
        
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return config.statusBarStyle
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    /// 初始化UI
    open func _init(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        contentView = UIView()
        contentView.td.cornerRadius = config.contentCornerRadius
        contentView.backgroundColor = config.backgroundColor
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        
        titleLabel.font = config.titleFont
        titleLabel.textColor = config.titleColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = alertTitle
        
        messageLabel.isUserInteractionEnabled = true
        messageLabel.text = message
        messageLabel.font = config.messageFont
        messageLabel.textColor = config.messageColor
        messageLabel.textAlignment = config.messageAligment
        messageLabel.numberOfLines = 0
        
        nomoreAlertBtn.setTitle(config.nomoreAlertText, for: .normal)
        nomoreAlertBtn.setImage(config.nomoreCheckBoxNormalImage, for: .normal)
        nomoreAlertBtn.setImage(config.nomoreCheckBoxSelectImage, for: .selected)
        nomoreAlertBtn.contentHorizontalAlignment = .left
        nomoreAlertBtn.setTitleColor(config.nomoreAlertTextColor, for: .normal)
        nomoreAlertBtn.td.setTitleFont(.systemFont(ofSize: 12), forState: .normal)
        nomoreAlertBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        nomoreAlertBtn.isHidden = !config.isShowNomoreAlert
        nomoreAlertBtn.addTarget(self, action: #selector(onNoMoreClick(_:)), for: .touchUpInside)
        contentView.addSubview(nomoreAlertBtn)
        
        imageView.image = image
        
        closeBtn.setImage(config.closeImage, for: .normal)
        
        btnView = UIView()
        btnView.backgroundColor = .clear
        contentView.addSubview(btnView)
        
        closeBtn.td.addblock(for: .touchUpInside) { [weak self] sender in
            guard let self = self else { return }
            self.hide()
        }
        contentView.addSubview(closeBtn)
        closeBtn.isHidden = true
        _setupConstains()
    }
    
    open func _setupConstains(){
        titleLabel.isHidden = !hasTitle
        messageLabel.isHidden = !hasMessage
        var scrollHeight: CGFloat = 0
        var imageHeight: CGFloat = image?.size.height ?? 0
        let maxScrollHeight: CGFloat = 350
        
        let contentWidth: CGFloat = UI.SCREEN_WIDTH - 140
        
        messageLabel.td.width = contentWidth
        titleLabel.td.width = contentWidth
        messageLabel.sizeToFit()
        titleLabel.sizeToFit()
        
        let messageHeight = messageLabel.td.height ?? 0
        var titleHeight = titleLabel.td.height ?? 0

        titleHeight = titleHeight == 0 ? 0 : titleHeight + 5
        
        let tHeight = titleHeight
        let mHeight = messageHeight
        let margin = (tHeight > 0 && mHeight > 0) ? 20.0 : 0
        let contentHeight = tHeight + mHeight + margin
        scrollHeight = min(maxScrollHeight, contentHeight)
        
        
        let contentX = (self.view.bounds.width - contentWidth) / 2
        let contentY = (self.view.bounds.height - (scrollHeight + CGFloat(btnViewHeight))) / 2
        
        imageView.frame = CGRect(x: (contentWidth - 50) / 2, y: 17, width: 50, height: 50)
        
        closeBtn.frame = CGRect(x: contentView.bounds.width - 16 - closeBtn.bounds.width, y: 16, width: closeBtn.bounds.width, height: closeBtn.bounds.height)
        let scrollY = imageHeight == 0 ? Const.edgeInsets.top : imageView.frame.maxY + 15
        scrollView.frame = CGRect(x: Const.edgeInsets.left, y: scrollY, width: contentWidth, height: scrollHeight)
        scrollView.contentSize = CGSize(width: 0, height: contentHeight)
        
        
        let sContentView = UIView()
        sContentView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.contentSize.height)
        scrollView.addSubview(sContentView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.alignment = .fill
        sContentView.addSubview(stackView)
        stackView.frame = sContentView.bounds
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: stackView.bounds.width, height: tHeight)
        messageLabel.frame = CGRect(x: 0, y: tHeight == 0 ? 0 : tHeight + 20, width: stackView.bounds.width, height: mHeight)
        
        contentView.frame = CGRect(center: CGPoint(x: UI.SCREEN_WIDTH / 2, y: UI.SCREEN_HEIGHT / 2), size: CGSize(width: UI.SCREEN_WIDTH - 100, height: scrollView.frame.maxY + Const.edgeInsets.bottom + btnViewHeight))
        
        _setupBtnsConstatins()  // 需要进一步修改这个方法，将按钮的约束转为 frame 布局
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    private func _updateAttributeMsg(_ attribute: NSAttributedString){
        let maxScrollHeight: CGFloat = 300
        var scrollContentHeight: CGFloat = 0

        titleLabel.td.width = UI.SCREEN_WIDTH - 140
        messageLabel.td.width = UI.SCREEN_WIDTH - 140
        titleLabel.sizeToFit()
        messageLabel.sizeToFit()
        
        var titleHeight = titleLabel.td.height ?? 0
        let messageHeight = messageLabel.td.height ?? 0
        titleHeight = titleHeight == 0 ? 0 : titleHeight + 5

        let margin = (titleHeight > 0 && messageHeight > 0) ? 20.0 : 0
        let contentHeight = titleHeight + messageHeight + Const.edgeInsets.top * 2 + margin
        scrollContentHeight = min(contentHeight, maxScrollHeight)
        
        contentView.td.height = scrollContentHeight + btnViewHeight
        scrollView.td.height = scrollContentHeight
        
        scrollView.contentSize = CGSize(width: 0, height: contentHeight)
        
        _setupConstains()
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    open func _setupBtnsConstatins(){
        btnView.subviews.forEach {
            $0.removeFromSuperview()
        }
        actionBtns.removeAll()
        
        btnView.frame = CGRect(
            x: 0,
            y: contentView.frame.height - (btnViewHeight - noMoreHeight),
            width: contentView.frame.width,
            height: btnViewHeight - noMoreHeight
        )
        
        nomoreAlertBtn.sizeToFit()
        nomoreAlertBtn.frame = CGRect(
            x: Const.edgeInsets.left,
            y: btnView.frame.origin.y - 12 - nomoreAlertBtn.frame.height,
            width: contentView.frame.width - 2 * Const.edgeInsets.left,
            height: nomoreAlertBtn.frame.height
        )
        
        // 添加并设置 lineView 的 frame
        let lineView = UIView()
        lineView.backgroundColor = config.lineColor
        btnView.addSubview(lineView)
        lineView.frame = CGRect(
            x: 0,
            y: 0,
            width: btnView.frame.width,
            height: 0.5
        )
        
        // 添加并设置 sepLineView 的 frame
        let sepLineView = UIView()
        sepLineView.backgroundColor = config.lineColor
        btnView.addSubview(sepLineView)
        sepLineView.frame = CGRect(
            x: (btnView.frame.width - 0.5) / 2,
            y: 14,
            width: 0.5,
            height: btnView.frame.height - 28
        )
        
        for (index, action) in actions.enumerated() {
            let btn = UIButton(type: .custom)
            btn.tag = index
            btn.setTitle(action.title, for: .normal)
            btn.setTitleColor(action.titleColor, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 15)
            btn.backgroundColor = action.backgroundColor
            btn.addTarget(self, action: #selector(onBtnsClick(_:)), for: .touchUpInside)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.lineBreakMode = .byWordWrapping
            btn.contentEdgeInsets = UIEdgeInsets(horizontals: 20, verticals: 10)
            if config.alertButtonStyle == .custom {
                btn.td.cornerRadius = 5
            }
            btnView.addSubview(btn)
            actionBtns.append(btn)
        }
        
        let btnHeight: CGFloat = config.alertButtonStyle == .custom ? 45 : 50
        lineView.isHidden = config.alertButtonStyle == .custom
        sepLineView.isHidden = config.alertButtonStyle == .custom
        
        if actionBtns.count == 1 {
            sepLineView.isHidden = true
            let inset: CGFloat = config.alertButtonStyle == .custom ? 20 : 0
            actionBtns.first?.frame = CGRect(
                x: inset,
                y: 0,
                width: btnView.frame.width - 2 * inset,
                height: btnHeight
            )
        } else {
            if btnArrangeStyle == .horizontal {
                let btns = actionBtns
                let spacing: CGFloat = config.alertButtonStyle == .custom ? 20 : 5
                let inset: CGFloat = config.alertButtonStyle == .custom ? 20 : 5
                let totalWidth = btnView.frame.width - 2 * inset
                let buttonWidth = (totalWidth - CGFloat(btns.count - 1) * spacing) / CGFloat(btns.count)
                for (index, btn) in btns.enumerated() {
                    btn.frame = CGRect(
                        x: inset + CGFloat(index) * (buttonWidth + spacing),
                        y: 0,
                        width: buttonWidth,
                        height: btnHeight
                    )
                }
            } else {
                let btns = actionBtns
                lineView.isHidden = true
                sepLineView.isHidden = true
                if config.alertButtonStyle == .default {
                    
                    btns.forEach {
                        let line = UIView()
                        line.backgroundColor = config.lineColor
                        $0.addSubview(line)
                        line.frame = CGRect(x: 0, y: 0, width: $0.td.width, height: 0.5)
                    }
                    for (index, btn) in btns.enumerated() {
                        let btnY = CGFloat(index) * btnHeight
                        btn.frame = CGRect(x: 10, y: btnY, width: btnView.td.width - 20, height: btnHeight)
                    }
                } else {
                    let style = self.actions.first?.btnStyle ?? config.alertButtonStyle
                    let totalHeight = btnHeight * CGFloat(btns.count)
                    let leadSpacing: CGFloat = 5
                    let tailSpacing: CGFloat = style == .custom ? 20 : 0
                    let buttonSpacing: CGFloat = style == .custom ? 16 : 0
                    
                    for (index, btn) in btns.enumerated() {
                        let btnY = leadSpacing + CGFloat(index) * (btnHeight + buttonSpacing)
                        btn.frame = CGRect(
                            x: style == .custom ? 20 : 0,
                            y: btnY,
                            width: btnView.frame.width - (style == .custom ? 40 : 0),
                            height: btnHeight
                        )
                    }
                    
                    if style == .default {
                        btns.forEach { btn in
                            let line = UIView()
                            line.backgroundColor = config.lineColor
                            btn.addSubview(line)
                            line.frame = CGRect(x: 0, y: 0, width: btn.td.width, height: 0.5)
                        }
                    }
                }
            }
        }
        btnView.bringSubviewToFront(sepLineView)
        btnView.bringSubviewToFront(lineView)
        
        if config.alertButtonStyle == .custom {
            for (index, btn) in actionBtns.enumerated() {
                guard let action = actions[index~], action._backgroundColor == nil else {
                    continue
                }
                switch action.style {
                case .confirm, .iknow:
                    if let gradient = config.alertConfirmBtnGradient {
                        btn.td.setBackgroundColor(UIColor.td.gradient(colors: gradient, size: btn.td.size, style: config.alertConfirmBtnGradientStyle), forState: .normal)
                    } else {
                        btn.td.setBackgroundColor(config.alertConfirmBtnBackground, forState: .normal)
                    }
                default:
                    break
                }
            }
        }
    }
    
    /// 点击了 action 按钮
    @objc final func onBtnsClick(_ sender: UIButton){
        let index = sender.tag
        self.actions.forEach { (action) in
            action.isNomoreAlert = config.isShowNomoreAlert ? nomoreAlertBtn.isSelected : false
        }
        if index > actions.count {
            return
        }
        let action = self.actions[index]
        if action.isTapHideAlert {
            hide {
                action.action?(action)
            }
        } else {
            action.action?(action)
        }
       
    }
    
    /// 隐藏Alert
    public func hide(_ complete: (()->Void)? = nil){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0
        }) { (res) in
            self.dismiss(animated: false, completion: {
                complete?()
                if Self.alertStack.contains(where: { $0 == self }) {
                    Self.alertStack.removeAll(where: { $0 == self })
                }
                if let next = Self.alertStack.first {
                    if next.presentingViewController != nil {
                        Self.alertStack.removeFirst()
                        return
                    }
                    if UI.topViewController?.tabBarController != nil {
                        UI.topViewController?.tabBarController?.present(next, animated: false, completion: nil)
                    } else {
                        UI.topViewController?.present(next, animated: false, completion: nil)
                    }
                }
            })
        }
    }
    
    @objc func onNoMoreClick(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
}


extension TDAlertController {
    struct Const {
        static let edgeInsets = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
        static let contentInset: CGFloat = 46
    }
    
    public struct AlertPriority : ExpressibleByFloatLiteral, Equatable, Strideable {
        public typealias FloatLiteralType = Float
        
        public let value: Float
        
        public init(floatLiteral value: Float) {
            self.value = value
        }
        
        public init(_ value: Float) {
            self.value = value
        }
        
        public static var greatestFiniteMagnitude: AlertPriority {
            return .init(.greatestFiniteMagnitude)
        }
        
        public static var required: AlertPriority {
            return 1000.0
        }
        
        public static var high: AlertPriority {
            return 750.0
        }
        
        public static var medium: AlertPriority {
            return 500.0
        }
        
        public static var low: AlertPriority {
            return 250.0
        }
        
        public static func ==(lhs: AlertPriority, rhs: AlertPriority) -> Bool {
            return lhs.value == rhs.value
        }

        // MARK: Strideable

        public func advanced(by n: FloatLiteralType) -> AlertPriority {
            return AlertPriority(floatLiteral: value + n)
        }

        public func distance(to other: AlertPriority) -> FloatLiteralType {
            return other.value - value
        }
    }
}

@objc public enum TDAlertButtonArrangeStyle: Int {
    case vertical
    case horizontal
}

public enum AlertActionStyle {
    /// 确认按钮
    case confirm
    /// 取消按钮
    case cancel
    /// 我知道了  按钮
    case iknow
    
    case custom(title: String, color: UIColor?, backgroundColor: UIColor?)
    
}


@objc public class AlertAction: NSObject {
    fileprivate var titleColor: UIColor? { _titleColor }
    /// 标题
    public var title: String!
    /// 图片
    public var image: UIImage?
    /// 点击回调
    public var action: ((_ action: AlertAction) -> Void)?
    /// 按钮的样式
    fileprivate var style: AlertActionStyle = .confirm
    
    fileprivate var backgroundColor: UIColor? { _backgroundColor }
    
    public var isTapHideAlert: Bool = true
    
    fileprivate var _backgroundColor: UIColor?
    private var _titleColor: UIColor?
    
    public var btnStyle: TDAlertButtonStyle = .default
    
    // 是否不再提示
    @objc public var isNomoreAlert: Bool = false
    
    /// 快速构建AlertAction  alert 的按钮
    ///
    /// - Parameters:
    ///   - title: 按钮的标题
    ///   - style: LMSAlertActionStyle 支持default 和 cancel 两种样式
    ///   - image: 按钮的图片
    ///   - action: 点击按钮的回调
    public convenience init(
        style: AlertActionStyle,
        title: String? = nil,
        image: UIImage? = nil,
        _ action: ((_ action: AlertAction) -> Void)?
    ) {
        self.init()
        self.title = title
        self.image = image
        self.action = action
        self.style = style
    }
    
    @objc public convenience init(
        title: String,
        titleColor: UIColor? = nil,
        image: UIImage? = nil,
        backgroundColor: UIColor? = nil,
        _ action: ((_ action: AlertAction) -> Void)?
    ) {
        self.init()
        
        self.title = title
        self.image = image
        self.action = action
        self._backgroundColor = backgroundColor
        self._titleColor = titleColor
    }
    
    @objc public convenience init(
        btnStyle: TDAlertButtonStyle,
        title: String,
        titleColor: UIColor? = nil,
        image: UIImage? = nil,
        backgroundColor: UIColor? = nil,
        _ action: ((_ action: AlertAction) -> Void)?
    ) {
        self.init()
        self.title = title
        self.image = image
        self.action = action
        self._backgroundColor = backgroundColor
        self._titleColor = titleColor
        self.btnStyle = btnStyle
    }
}

@objc extension AlertAction {
    
    
    @objc public static var confirmAction: AlertAction { AlertAction(style: .confirm, nil) }
    
    @objc public static var cancelAction: AlertAction { AlertAction(style: .cancel, nil) }
    
    @objc public static var iknowAction: AlertAction { AlertAction(style: .iknow, nil) }
    
    
}
