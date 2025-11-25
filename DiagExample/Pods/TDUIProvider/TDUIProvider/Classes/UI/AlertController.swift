//
//  TDAlertController.swift
//  TDBasis
//
//  Created by Fench on 2024/8/26.
//

import UIKit
import TDBasis
import TDTheme

public typealias AlertPriority = TDPopupPriority

@objc public enum LMSAlertButtonStyle: Int {
    case `default`  // 系统样色
    case custom     // 自定义样式
}

extension LMSAlertController {
    
    @discardableResult
    public static func show(
        _ title: String?,
        message: String?,
        image: UIImage? = nil,
        inView: UIView? = nil,
        shouldNoMoreAlert: Bool = false,
        btnArrangeType: LMSAlertButtonArrangeStyle = .horizontal,
        priority: AlertPriority = .required,
        untriggerBehavoir: TDPopupViewUntriggeredBehavior = .await,
        switchBehavoir: TDPopupViewSwitchBehavior = .latent,
        canRegisterFirstPopupViewResponder: Bool = true,
        actions: [LMSAlertAction]
    ) -> Self {
        showAlert(
            title,
            message: message,
            image: image,
            inView: inView,
            shouldNoMoreAlert: shouldNoMoreAlert,
            alertButtonArrangeStyle: btnArrangeType,
            priority: priority,
            untriggeredBehavior: untriggerBehavoir,
            switchBehavior: switchBehavoir,
            actions: actions
        )
    }
    
    
    /// 显示自定义的 AlertController
    /// - Parameters:
    ///   - customView: 自定义的视图
    ///   - btnArrangeType: 按钮排列方式
    ///   - priority: 优先级
    ///   - untriggeredBehavior: 未触发行为
    ///   - switchBehavior: 开关行为
    ///   - actions: 按钮数组
    /// - Returns: 返回一个 AlertController 实例
    @discardableResult
    public static func show(
        customView: UIView,
        btnArrangeType: LMSAlertButtonArrangeStyle = .horizontal,
        priority: AlertPriority = .required,
        untriggeredBehavior: TDPopupViewUntriggeredBehavior = .await,
        switchBehavior: TDPopupViewSwitchBehavior = .latent,
        canRegisterFirstPopupViewResponder: Bool = true,
        actions: [LMSAlertAction]
    ) -> Self {
        showAlert(customView: customView,
                  alertButtonArrangeStyle: btnArrangeType,
                  priority: priority,
                  untriggeredBehavior: untriggeredBehavior,
                  switchBehavior: switchBehavior,
                  actions: actions)
    }
    
    
    @objc
    public convenience init(customView: UIView,
                            priority: Float = 1000,
                            untriggeredBehavior: TDPopupViewUntriggeredBehavior = .await,
                            switchBehavior: TDPopupViewSwitchBehavior = .latent,
                            canRegisterFirstPopupViewResponder: Bool = true,
                            actions: [LMSAlertAction]) {
        self.init()
        self.customView = customView
        self.priority = .init(priority)
        self._untriggerBehavior = untriggeredBehavior
        self._switchBehavior = switchBehavior
        self.actions = actions
    }
}

// MARK: - update Attribute message
extension  LMSAlertController {
    
    /// 更新富文本消息
    /// - Parameters:
    ///   - attributeMsg: NSAttributedString 消息内容
    ///   - tapHandle: 点击消息回调
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
    
    
    /// 更新富文本消息
    /// - Parameter msg: NSAttributedString 消息内容
    @objc public func updateAttributeMessage(_ msg: NSAttributedString) {
        _updateAttributeMsg(msg)
    }
}

extension LMSAlertController {
    func updateRepetitionTriger() {
        let elements = TDPopupScheduler.shared.elementList
        for element in elements {
            guard let alert = element.data as? LMSAlertController else {
                continue
            }
            let alertTitle = alert.titleLabel.text ?? ""
            let alertMessage = alert.messageLabel.text ?? ""
            let title = titleLabel.text ?? ""
            let message = messageLabel.text ?? ""
            
            if title == alertTitle && message == alertMessage {
                TDLogDebug("当前调度列表中已存在相同弹框 - \"\(title)\" - \"\(message)\" 不再重复添加")
                self._untriggerBehavior = .discard
                return
            }
        }
    }
}

//MARK: - LMSAlertController
@objc
@objcMembers
open class LMSAlertController: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addNotification()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    static public var alertStack: [LMSAlertController] = []
    
    public var config: LMSAlertConfig { .global }
    
    public var priorityValue: Float = 1000
    public var priority: AlertPriority {
        get { .init(priorityValue) }
        set { priorityValue = newValue.value }
    }
    public var btnArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal
    /// 点击message 回调  message 带link
    public var messageTapHandle: (()->Void)?
    
    /// alert 弹框的按钮数组
    public var actions: [LMSAlertAction] = [LMSAlertAction]()
    
    /// 是否显示不再提示
    public var isShowNomoreAlert: Bool = false {
        didSet {
            nomoreAlertBtn.isHidden = !isShowNomoreAlert
        }
    }
    
    public var isShowCloseBtn: Bool = false {
        didSet {
            closeBtn.isHidden = !isShowCloseBtn
        }
    }
    
    /// 标题字体
    public var titleFont: UIFont? {
        didSet {
            self.titleLabel.font = titleFont
            _setupConstains()
        }
    }
    /// message 字体
    public var messageFont: UIFont? {
        didSet {
            self.messageLabel.font = messageFont
            _setupConstains()
        }
    }
    
    /// 获取根窗口上可见的最后一个 AlertController
    public static var visiableAlert: LMSAlertController? {
        UI.keyWindow?.subviews.last(where: { $0 is LMSAlertController }) as? LMSAlertController
    }
    
    public var contentView: UIView = UIView()
    public var titleLabel: TDScrollLabel = TDScrollLabel()
    public var messageLabel: UILabel = UILabel()
    public var actionBtns: [UIButton] = [UIButton]()
    public var btnView: UIView = UIView()
    public var imageView: UIImageView = UIImageView()
    public var closeBtn: UIButton = UIButton(type: .custom)
    public var nomoreAlertBtn: UIButton = UIButton(type: .custom)
    
    public var messageTextAligment: NSTextAlignment? {
        didSet {
            guard let messageTextAligment = messageTextAligment else { return }
            messageLabel.textAlignment = messageTextAligment
        }
    }
    public var link: String?
    public var alertTitle: String?
    public var message: String?
    public var image: UIImage?
    private var scrollView: UIScrollView = UIScrollView()
    private var hasTitle: Bool { !(alertTitle?.isEmpty ?? true) }
    private var hasMessage: Bool { !(message?.isEmpty ?? true) }
    
    var _untriggerBehavior: TDPopupViewUntriggeredBehavior = .await
    var _switchBehavior: TDPopupViewSwitchBehavior = .latent
    public var _canRegisterFirstPopupViewResponder: Bool = true
    private var btnHeight: CGFloat {
        
        let hdBtnHeight: CGFloat = 70.hdVerticalScale
        var iphoneBtnHeight: CGFloat = 50
        var btnHeight = UIProvider.isHD ? hdBtnHeight : iphoneBtnHeight
        return btnHeight
    }
    private var btnViewHeight: CGFloat {
        var btnHeight = self.btnHeight + (buttonStyle == .custom ? 20 : 0)
        let style = actions.first?.btnStyle ?? .default
        
        if btnArrangeStyle == .vertical {
            if style == .custom {
                btnHeight = CGFloat(actions.count) * (45 + 16) - 16 + 24
            } else {
                btnHeight = CGFloat(actions.count) * btnHeight
            }
        }
        return btnHeight + noMoreHeight
    }
    
    public var customView: UIView? {
        didSet {
            updateCustomView()
        }
    }
    var showInView: UIView?
    private var buttonStyle: LMSAlertButtonStyle { AlertProvider.buttonStyle }
    private var noMoreHeight: CGFloat { isShowNomoreAlert ? 40 : 0 }
    
    /// 点击了 action 按钮
    @objc final func onBtnsClick(_ sender: UIButton){
        let index = sender.tag
        self.actions.forEach { (action) in
            action.isNomoreAlert = isShowNomoreAlert ? nomoreAlertBtn.isSelected : false
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
    
    /// 显示Alert, 通过 init 方法创建的 Alert 可以通过这个方法 显示视图
    public final func showAlert() {
        let elements = TDPopupScheduler.shared.elementList
        for element in elements {
            guard let alert = element.data as? LMSAlertController else {
                continue
            }
            let alertTitle = alert.titleLabel.text ?? ""
            let alertMessage = alert.messageLabel.text ?? ""
            let title = titleLabel.text ?? ""
            let message = messageLabel.text ?? ""
            
            if title == alertTitle && message == alertMessage {
                TDLogDebug("当前调度列表中已存在相同弹框 - \"\(title)\" - \"\(message)\" 不再重复添加")
                return
            }
        }
        
        TDPopupScheduler.shared.add(self, priority: priority)
    }
    
    /// 隐藏 Alert, 通过 hide 方法隐藏 Alert
    public final func hide(_ complete: (()->Void)? = nil){
        self.dismissWithAnimation(complete)
    }
    
    @objc func onNoMoreClick(_ sender: UIButton){
        sender.isSelected.toggle()
    }
}

//MARK: - 显示 AlertController 内部方法
extension LMSAlertController {
    /// 显示alertView 使用方法类似UIAlertController
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 说明
    ///   - actions: actions [LMSAlertAction]
    @discardableResult
    public static func showAlert(
        _ title: String?,
        message: String?,
        image: UIImage? = nil,
        inView: UIView? = nil,
        shouldNoMoreAlert: Bool = false,
        alertButtonArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal,
        priority: AlertPriority = .required,
        untriggeredBehavior: TDPopupViewUntriggeredBehavior = .await,
        switchBehavior: TDPopupViewSwitchBehavior = .latent,
        canRegisterFirstPopupViewResponder: Bool = true,
        actions: [LMSAlertAction]
    ) -> Self {
        let alert = Self.init()
        DispatchQueue.syncInMain {
            UIApplication.shared.keyWindow?.endEditing(true)
            alert.alertTitle = title
            alert.actions = actions
            alert.message = message
            alert.image = image
            alert.priority = priority
            alert.showInView = inView
            alert.isShowNomoreAlert = shouldNoMoreAlert
            alert.btnArrangeStyle = actions.count > 2 ? .vertical : alertButtonArrangeStyle
            alert._switchBehavior = switchBehavior
            alert._untriggerBehavior = untriggeredBehavior
            alert._canRegisterFirstPopupViewResponder = canRegisterFirstPopupViewResponder
            alert._init()
            
            alert.showAlert()
        }
        return alert
    }
    
    
    /// 显示自定义 AlertController
    /// - Parameters:
    ///   - customView: 自定义视图
    ///   - inView: 显示的父视图, 默认为 keyWindow
    ///   - alertButtonArrangeStyle: 按钮排列方式
    ///   - priority: 优先级
    ///   - untriggeredBehavior: 未触发行为
    ///   - switchBehavior: 开关行为
    ///   - actions: 按钮数组
    /// - Returns: 返回一个 AlertController 实例
    @discardableResult
    public static func showAlert(
        customView: UIView,
        inView: UIView? = nil,
        alertButtonArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal,
        priority: AlertPriority = .required,
        untriggeredBehavior: TDPopupViewUntriggeredBehavior = .await,
        switchBehavior: TDPopupViewSwitchBehavior = .latent,
        canRegisterFirstPopupViewResponder: Bool = true,
        actions: [LMSAlertAction]
    ) -> Self {
        let alert = Self.init()
        DispatchQueue.syncInMain {
            UIApplication.shared.keyWindow?.endEditing(true)
            alert.showInView = inView
            alert.actions = actions
            alert.priority = priority
            alert._switchBehavior = switchBehavior
            alert._untriggerBehavior = untriggeredBehavior
            alert.customView = customView
            alert._canRegisterFirstPopupViewResponder = canRegisterFirstPopupViewResponder
            
            alert.showAlert()
        }
        
        return alert
    }
}

//MARK: - layout 布局
extension LMSAlertController {
    
    public func refreshUI() {
        let topVc = UI.topViewController
        self.frame = topVc?.view.bounds ?? UI.SCREEN_BOUNDS
        _setupConstains()
    }
    
    /// 初始化UI
    open func _init(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        contentView = UIView()
        contentView.td.cornerRadius = AlertProvider.contentCornerRadius
        contentView.theme.backgroundColor = AlertProvider.backgroundColor
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        addSubview(contentView)
        contentView.addSubview(scrollView)
        
        titleLabel.font = config.titleFont
        titleLabel.theme.textColor = AlertProvider.titleTextColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 5
        titleLabel.text = alertTitle
        
        messageLabel.isUserInteractionEnabled = true
        messageLabel.text = message
        messageLabel.font = config.messageFont
        messageLabel.theme.textColor = AlertProvider.messageTextColor
        messageLabel.textAlignment = AlertProvider.messageTextAlignment
        messageLabel.numberOfLines = 0
        
        nomoreAlertBtn.setTitle(config.nomoreAlertText(), for: .normal)
        nomoreAlertBtn.setImage(config.nomoreCheckBoxNormalImage, for: .normal)
        nomoreAlertBtn.setImage(config.nomoreCheckBoxSelectImage, for: .selected)
        nomoreAlertBtn.contentHorizontalAlignment = .left
        nomoreAlertBtn.theme.setTitleColor(AlertProvider.nomoreAlertTextColor, for: .normal)
        nomoreAlertBtn.td.setTitleFont(.systemFont(ofSize: 12).adaptHD, forState: .normal)
        nomoreAlertBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        nomoreAlertBtn.isHidden = !isShowNomoreAlert
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
        
        refreshUI()
    }
    
    // 设置约束
    open func _setupConstains() {
        titleLabel.isHidden = !hasTitle
        messageLabel.isHidden = !hasMessage
        var scrollHeight: CGFloat = 0
        var imageHeight: CGFloat = image?.size.height ?? 0
        let maxScrollHeight: CGFloat = 350
        
        let contentWidth: CGFloat = Const.contentWidth
        let messageMaxWidth = (message ?? "").td.size(font: config.messageFont, maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude)).width
        let messageWidth =  min(Const.contentWidth, messageMaxWidth)
        
        // 标题布局
        titleLabel.td.width = contentWidth
        titleLabel.sizeToFit()
        var titleHeight = titleLabel.td.height ?? 0
        titleHeight = titleHeight == 0 ? 0 : titleHeight + 5
        
        // 消息布局
        messageLabel.td.width = messageWidth
        messageLabel.sizeToFit()
        let messageHeight = messageLabel.td.height ?? 0
        
        // 滚动区域高度（只包含消息）
        let margin = (titleHeight > 0 && messageHeight > 0) ? 20.0 : 0
        let contentHeight = messageHeight // + margin
        scrollHeight = min(maxScrollHeight, contentHeight)
        
        // 布局元素
        let contentX = (self.bounds.width - contentWidth) / 2
        let contentY = (self.bounds.height - (scrollHeight + CGFloat(btnViewHeight) + titleHeight)) / 2
        
        // 图片布局
        imageView.frame = CGRect(x: (contentWidth - 50) / 2, y: 17, width: 50, height: 50)
        
        // 关闭按钮
        closeBtn.frame = CGRect(x: contentView.bounds.width - 16 - closeBtn.bounds.width,
                               y: 16,
                               width: closeBtn.bounds.width,
                               height: closeBtn.bounds.height)
        
        // 标题位置（在内容视图顶部）
        titleLabel.frame = CGRect(x: Const.edgeInsets.left,
                                 y: imageHeight == 0 ? Const.edgeInsets.top : imageView.frame.maxY + 15,
                                 width: contentWidth,
                                 height: titleHeight)
        
        // 滚动视图位置（在标题下方）
        let scrollY = titleLabel.frame.maxY + (titleHeight > 0 ? 10 : 0)
        scrollView.frame = CGRect(x: Const.edgeInsets.left,
                                 y: scrollY,
                                 width: contentWidth,
                                 height: scrollHeight)
        
        // 消息内容布局（仅在滚动视图内）
        messageLabel.frame = CGRect(
            x: max(0, (Const.contentWidth - messageWidth) / 2),
            y: 0,
            width: messageWidth,
            height: messageHeight
        )
        
        scrollView.contentSize = CGSize(width: messageWidth,
                                       height: messageHeight)
        
        // 调整容器视图总高度
        let topVc = UI.topViewController
        let cWidth = (topVc?.view.bounds.width ?? UI.SCREEN_WIDTH) / 2
        let cHeight = (topVc?.view.bounds.height ?? UI.SCREEN_HEIGHT) / 2
        contentView.frame = CGRect(center: CGPoint(x: cWidth, y: cHeight),
                                   size: CGSize(width: UI.SCREEN_WIDTH - Const.contentInset * 2,
                                                height: scrollView.frame.maxY + Const.edgeInsets.bottom + btnViewHeight))
        
        // 视图层级调整
        contentView.addSubview(titleLabel)    // 标题添加到内容视图
        scrollView.addSubview(messageLabel)   // 消息添加到滚动视图
        
        _setupBtnsConstatins()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // 更新自定义视图
    private func updateCustomView() {
        guard let customView else {
            return
        }
        let topVc = UI.topViewController
        self.frame = topVc?.view.bounds ?? UI.SCREEN_BOUNDS
        
        contentView = UIView()
        contentView.td.cornerRadius = AlertProvider.contentCornerRadius
        contentView.theme.backgroundColor = AlertProvider.backgroundColor
        
        addSubview(contentView)
        
        contentView.addSubview(customView)
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // 更新富文本内容约束
    private func _updateAttributeMsg(_ attribute: NSAttributedString) {
        // 修改部分保持与上述逻辑一致，主要调整高度计算
        let maxScrollHeight: CGFloat = 350
        var scrollContentHeight: CGFloat = 0
        
        let messageMaxWidth = attribute.string.td.size(font: config.messageFont,
                                                       maxSize: CGSize(width: .greatestFiniteMagnitude,
                                                                       height: 100.0)).width
        let messageWidth = min(Const.contentWidth, messageMaxWidth)
        
        // 更新标题高度
        titleLabel.sizeToFit()
        var titleHeight = titleLabel.td.height ?? 0
        titleHeight = titleHeight == 0 ? 0 : titleHeight + 5
        
        // 更新消息高度
        messageLabel.sizeToFit()
        let messageHeight = messageLabel.td.height ?? 0
        
        // 计算滚动区域高度（仅消息）
        let margin = (titleHeight > 0 && messageHeight > 0) ? 20.0 : 0
        let contentHeight = messageHeight + margin
        scrollContentHeight = min(contentHeight, maxScrollHeight)
        
        // 更新容器高度（包含标题和滚动区域）
        contentView.td.height = scrollContentHeight + btnViewHeight + titleHeight
        scrollView.td.height = scrollContentHeight
        
        scrollView.contentSize = CGSize(width: messageWidth,
                                       height: messageHeight)
        
        _setupConstains()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        updateRepetitionTriger()
    }
    
    // 设置按钮的布局
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
        lineView.theme.backgroundColor = .theme.line
        btnView.addSubview(lineView)
        lineView.frame = CGRect(
            x: 0,
            y: 0,
            width: btnView.frame.width,
            height: 0.5
        )
        
        // 添加并设置 sepLineView 的 frame
        let sepLineView = UIView()
        sepLineView.theme.backgroundColor = .theme.line
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
            btn.setTitle(action.title ?? action.style.title, for: .normal)
            btn.setTitleColor(action.titleColor ?? action.style.textColor, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium).adaptHD
            btn.backgroundColor = action.backgroundColor ?? action.style.backgroundColor
            btn.addTarget(self, action: #selector(onBtnsClick(_:)), for: .touchUpInside)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.lineBreakMode = .byWordWrapping
            btn.contentEdgeInsets = UIEdgeInsets(horizontals: 20, verticals: 10)
            if buttonStyle == .custom {
                btn.td.cornerRadius = 5
            }
            btnView.addSubview(btn)
            actionBtns.append(btn)
            
            if index > 0 {
                if case .confirm = action.style {
                    btn.accessibilityIdentifier = "alertConfirm"
                }
                
                if case .custom = action.style {
                    btn.accessibilityIdentifier = "alertConfirm"
                }
            } else {
                if case .confirm = action.style {
                    btn.accessibilityIdentifier = "alertSingleConfirm"
                } else {
                    btn.accessibilityIdentifier = "alertCancel"
                }
            }
        }
        
        lineView.isHidden = buttonStyle == .custom
        sepLineView.isHidden = buttonStyle == .custom
        
        if actionBtns.count == 1 {
            sepLineView.isHidden = true
            let inset: CGFloat = buttonStyle == .custom ? 20 : 0
            actionBtns.first?.frame = CGRect(
                x: inset,
                y: 0,
                width: btnView.frame.width - 2 * inset,
                height: btnHeight
            )
        } else {
            if btnArrangeStyle == .horizontal {
                let btns = actionBtns
                let spacing: CGFloat = buttonStyle == .custom ? 20 : 5
                let inset: CGFloat = buttonStyle == .custom ? 20 : 5
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
                if buttonStyle == .default {
                    
                    for (index, btn) in btns.enumerated() {
                        let btnY = CGFloat(index) * btnHeight
                        btn.frame = CGRect(x: 10, y: btnY, width: btnView.td.width - 20, height: btnHeight)
                    }
                    
                    btns.forEach {
                        let line = UIView()
                        line.theme.backgroundColor = .theme.line
                        $0.addSubview(line)
                        line.frame = CGRect(x: 0, y: 0, width: $0.td.width, height: 0.5)
                    }
                } else {
                    let style = self.actions.first?.btnStyle ?? buttonStyle
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
                            line.theme.backgroundColor = .theme.line
                            btn.addSubview(line)
                            line.frame = CGRect(x: 0, y: 0, width: btn.td.width, height: 0.5)
                        }
                    }
                }
            }
        }
        btnView.bringSubviewToFront(sepLineView)
        btnView.bringSubviewToFront(lineView)
        
        // 设置按钮的背景 （渐变）
        if buttonStyle == .custom, let colors = UIProvider.Gradient.confirmBtnColors, !colors.isEmpty {
            for (index, btn) in actionBtns.enumerated() {
                guard let action = actions[index~], action.backgroundColor == nil else {
                    continue
                }
                switch action.style {
                case .confirm, .iknow:
                    let background = UIProvider.confirmBackground(size: btn.td.size) ?? .theme.theme
                    btn.td.setBackgroundColor(background?.color, forState: .normal)
                default:
                    break
                }
            }
        }
    }
}

// MARK: - TDPopupView 代理
extension LMSAlertController: TDPopupView {
    /// 显示 AlertController 内部方法, 外界不要调用
    public func showWithAnimation(_ animation: Block.VoidBlock?) {
        let showInView = self.showInView ?? UI.keyWindow
        showInView?.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        } completion: { _ in
            animation?()
        }
    }
    
    /// 隐藏 AlertController 内部方法, 外界不要调用
    public func dismissWithAnimation(_ animation: Block.VoidBlock?) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { _ in
            animation?()
            self.removeFromSuperview()
        }
    }
    
    /// 当前弹框的触发显示行为 详细作用请参考 `TDPopupViewUntriggeredBehavior`
    public var untriggerBehavior: TDPopupViewUntriggeredBehavior { _untriggerBehavior }
    
    /// 当前弹框已显示，后续触发其他弹框，当前弹框的显示行为. 详细作用请参考 `TDPopupViewSwitchBehavior`
    public var switchBehavior: TDPopupViewSwitchBehavior { _switchBehavior }
    
    public var canRegisterFirstPopupViewResponder: Bool {
        return _canRegisterFirstPopupViewResponder
    }
}

//MARK: - Const
extension LMSAlertController {
    struct Const {
        static let edgeInsets = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
        static let contentInset: CGFloat = UIProvider.isHD ? 272.hdHorizontalScale : 46
        static var contentWidth: CGFloat {
            UI.SCREEN_WIDTH - contentInset * 2 - edgeInsets.left - edgeInsets.right
        }
    }
}

// MARK: - Rotation

extension LMSAlertController {
    
    func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOrientationChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func handleOrientationChange() {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait:
            print("竖屏")
        case .landscapeLeft, .landscapeRight:
            print("横屏")
        default:
            break
        }
        
        refreshAfterRotation()
    }
    
    func refreshAfterRotation() {
        self.refreshUI()
    }
    
}
