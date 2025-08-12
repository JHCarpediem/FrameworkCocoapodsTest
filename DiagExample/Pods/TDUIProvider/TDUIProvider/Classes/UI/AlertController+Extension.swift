//
//  AlertController+Extension.swift
//  TDBasis
//
//  Created by Fench on 2024/11/7.
//

import Foundation

@objc public extension LMSAlertController {
    @objc public convenience init(
        title: String?,
        message: String?,
        image: UIImage? = nil,
        btnArrangeType: LMSAlertButtonArrangeStyle,
        shouldNomoreAlert: Bool = false,
        priority: Float = 1000,
        actions: [LMSAlertAction]
    ) {
        self.init()
        self.alertTitle = title
        self.message = message
        self.image = image
        self.isShowNomoreAlert = shouldNomoreAlert
        self.priority = .init(priority)
        self.actions = actions
        self.btnArrangeStyle = actions.count > 2 ? .vertical : btnArrangeType
    }
    
    @objc public convenience init(
        title: String?,
        message: String?,
        image: UIImage? = nil,
        shouldNomoreAlert: Bool = false,
        priority: Float = 1000,
        actions: [LMSAlertAction]
    ) {
        self.init()
        self.alertTitle = title
        self.message = message
        self.image = image
        self.isShowNomoreAlert = shouldNomoreAlert
        self.priority = .init(priority)
        self.actions = actions
        self.btnArrangeStyle = actions.count > 2 ? .vertical : .horizontal
    }
    
    @objc public convenience init(
        title: String?,
        message: String?,
        image: UIImage? = nil,
        shouldNomoreAlert: Bool = false,
        priority: Float = 1000,
        untriggerBehavior: TDPopupViewUntriggeredBehavior,
        switchBehavior: TDPopupViewSwitchBehavior,
        actions: [LMSAlertAction]
    ) {
        self.init()
        self.alertTitle = title
        self.message = message
        self.image = image
        self.isShowNomoreAlert = shouldNomoreAlert
        self.priority = .init(priority)
        self.actions = actions
        self.btnArrangeStyle = actions.count > 2 ? .vertical : .horizontal
        self._untriggerBehavior = untriggerBehavior
        self._switchBehavior = switchBehavior
    }
    
    @objc public convenience init(
        title: String?,
        message: String?,
        shouldNomoreAlert: Bool = false,
        priority: Float = 1000,
        untriggerBehavior: TDPopupViewUntriggeredBehavior,
        switchBehavior: TDPopupViewSwitchBehavior,
        actions: [LMSAlertAction]
    ) {
        self.init()
        self.alertTitle = title
        self.message = message
        self.isShowNomoreAlert = shouldNomoreAlert
        self.priority = .init(priority)
        self.actions = actions
        self.btnArrangeStyle = actions.count > 2 ? .vertical : .horizontal
        self._untriggerBehavior = untriggerBehavior
        self._switchBehavior = switchBehavior
    }
}

@objc public extension LMSAlertController {
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - actions: 弹框按钮
    ///   - isCover: 是否覆盖原有的弹框 如果传 true 会将原有的弹框隐藏 在弹出当前弹框 如果为 false 会将当前弹框入栈，当原有的弹框隐藏之后，才会弹出当前弹框
    /// - Returns: 弹框控件
    @nonobjc
    static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool,
        priority: AlertPriority,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title, message: content, image: image, shouldNoMoreAlert: shouldNoMoreAlert, priority: priority, actions: actions)
    }
    
    @discardableResult
    @objc static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        priority: Float,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title: title, content: content, image: image, shouldNoMoreAlert: false, priority: .init(priority), actions: actions)
    }
    
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - actions: 弹框按钮
    ///   - isCover: 是否覆盖原有的弹框 如果传 true 会将原有的弹框隐藏 在弹出当前弹框 如果为 false 会将当前弹框入栈，当原有的弹框隐藏之后，才会弹出当前弹框
    /// - Returns: 弹框控件
    @objc static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool = false,
        priorityValue: Float,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title, message: content, image: image, shouldNoMoreAlert: shouldNoMoreAlert, priority: .init(priorityValue), actions: actions)
    }
    
    @available(*, deprecated, renamed: "show(title:content:image:shouldNoMoreAlert:priority:actions:)")
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - actions: 弹框按钮
    ///   - isCover: 是否覆盖原有的弹框 如果传 true 会将原有的弹框隐藏 在弹出当前弹框 如果为 false 会将当前弹框入栈，当原有的弹框隐藏之后，才会弹出当前弹框
    /// - Returns: 弹框控件
    @objc static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool = false,
        isCover: Bool,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title, message: content, image: image, shouldNoMoreAlert: shouldNoMoreAlert, priority: isCover ? .init(.greatestFiniteMagnitude) : .low, actions: actions)
    }
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @objc static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool = false,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title, message: content, image: image, shouldNoMoreAlert: shouldNoMoreAlert, actions: actions)
    }
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - btnArrangeStyle: 按钮排列状态 默认水平排列
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @objc static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool = false,
        btnArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal,
        priorityValue: Float,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title,
             message: content,
             image: image,
             shouldNoMoreAlert: shouldNoMoreAlert,
             btnArrangeType: btnArrangeStyle,
             priority: .init(priorityValue),
             actions: actions)
    }
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - btnArrangeStyle: 按钮排列状态 默认水平排列
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @objc static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool = false,
        btnArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title,
             message: content,
             image: image,
             shouldNoMoreAlert: shouldNoMoreAlert,
             btnArrangeType: btnArrangeStyle,
             priority: .required,
             actions: actions)
    }
    
    @discardableResult
    @objc
    static func show(
        title: String?,
        content: String?,
        shouldNoMoreAlert: Bool = false,
        priority: Float,
        untriggerBehavior: TDPopupViewUntriggeredBehavior,
        switchBehavior: TDPopupViewSwitchBehavior,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title,
             message: content,
             shouldNoMoreAlert: shouldNoMoreAlert,
             priority: .init(priority),
             untriggerBehavoir: untriggerBehavior,
             switchBehavoir: switchBehavior,
             actions: actions)
    }
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - btnArrangeStyle: 按钮排列状态 默认水平排列
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @nonobjc
    static func show(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        shouldNoMoreAlert: Bool = false,
        btnArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal,
        priority: AlertPriority,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title,
             message: content,
             image: image,
             shouldNoMoreAlert: shouldNoMoreAlert,
             btnArrangeType: btnArrangeStyle,
             priority: priority,
             actions: actions)
    }
    
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - shouldNoMoreAlert: 是否显示`不再提示`按钮
    ///   - btnArrangeStyle: 按钮排列状态 默认水平排列
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @nonobjc
    static func show(
        title: String?,
        content: String?,
        inView: UIView?,
        shouldNoMoreAlert: Bool = false,
        btnArrangeStyle: LMSAlertButtonArrangeStyle = .horizontal,
        priority: AlertPriority,
        untriggerBehavior: TDPopupViewUntriggeredBehavior = .await,
        switchBehavior: TDPopupViewSwitchBehavior = .latent,
        actions: [LMSAlertAction]
    ) -> Self {
        show(title,
             message: content,
             inView: inView,
             shouldNoMoreAlert: shouldNoMoreAlert,
             btnArrangeType: btnArrangeStyle,
             priority: priority,
             untriggerBehavoir: untriggerBehavior,
             switchBehavoir: switchBehavior,
             actions: actions)
    }
}

// MARK: 显示一个按钮 我知道了
@objc public extension LMSAlertController {
    
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    /// - Returns: 弹框控件
    @objc static func showIknow(
        title: String?,
        content: String?,
        image: UIImage? = nil
    ) -> Self {
        showIknow(title: title, content: content, image: image, ikonwAction: nil)
    }
    
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - ikonwAction: 我知道了点击回调
    /// - Returns: 弹框控件
    @objc static func showIknow(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        ikonwAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title, message: content, image: image, actions: [LMSAlertAction(style: .iknow, ikonwAction)])
    }
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - priorityValue: 弹框优先级
    ///   - ikonwAction: 我知道了点击回调
    /// - Returns: 弹框控件
    @objc
    static func showIknow(
        title: String?,
        content: String?,
        priorityValue: Float,
        ikonwAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title, message: content, priority: .init(priorityValue), actions: [LMSAlertAction(style: .iknow, ikonwAction)])
    }
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - priorityValue: 弹框优先级
    ///   - ikonwAction: 我知道了点击回调
    /// - Returns: 弹框控件
    @objc
    static func showIknow(
        title: String?,
        content: String?,
        priorityValue: Float,
        untriggerBehavior: TDPopupViewUntriggeredBehavior,
        switchBehavior: TDPopupViewSwitchBehavior,
        ikonwAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title,
             message: content,
             priority: .init(priorityValue),
             untriggerBehavoir: untriggerBehavior,
             switchBehavoir: switchBehavior,
             actions: [LMSAlertAction(style: .iknow, ikonwAction)])
    }
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - priorityValue: 弹框优先级
    ///   - ikonwAction: 我知道了点击回调
    /// - Returns: 弹框控件
    @objc
    static func showIknow(
        title: String?,
        content: String?,
        priorityValue: Float,
        untriggerBehavior: TDPopupViewUntriggeredBehavior,
        switchBehavior: TDPopupViewSwitchBehavior
    ) -> Self {
        showIknow(title: title, content: content, priority: .init(priorityValue), untriggerBehavior: untriggerBehavior, switchBehavior: switchBehavior, ikonwAction: nil)
    }
    
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - priority: 弹框优先级
    ///   - ikonwAction: 我知道了点击回调
    /// - Returns: 弹框控件
    @nonobjc static func showIknow(
        title: String?,
        content: String?,
        priority: AlertPriority,
        untriggerBehavior: TDPopupViewUntriggeredBehavior = .await,
        switchBehavior: TDPopupViewSwitchBehavior = .latent,
        ikonwAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title,
             message: content,
             priority: priority,
             untriggerBehavoir: untriggerBehavior,
             switchBehavoir: switchBehavior,
             actions: [LMSAlertAction(style: .iknow, ikonwAction)])
    }
}

// MARK: 显示默认弹框 -- 带  确定/取消  按钮
@objc public extension LMSAlertController {
    
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - confirmAction: 确认回调
    ///   - cacncelAction: 取消回调
    /// - Returns: 弹框控件
    @objc
    static func showDefault(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        confirmAction: ((LMSAlertAction)->Void)?,
        cacncelAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title,
             message: content,
             image: image,
             actions: [LMSAlertAction(style: .cancel, cacncelAction), LMSAlertAction(style: .confirm, confirmAction)])
    }
    
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - confirmAction: 确认回调
    /// - Returns: 弹框 控件
    @objc
    static func showDefault(
        title: String?,
        content: String?,
        image: UIImage? = nil,
        confirmAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        showDefault(title: title, content: content, image: image, confirmAction: confirmAction, cacncelAction: nil)
    }
    
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - confirmAction: 确认回调
    /// - Returns: 弹框 控件
    @nonobjc
    static func showDefault(
        title: String?,
        content: String?,
        priority: AlertPriority,
        untriggerBehavior: TDPopupViewUntriggeredBehavior = .await,
        switchBehavior: TDPopupViewSwitchBehavior = .latent,
        confirmAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title, message: content, priority: priority, actions: [.cancelAction, .init(style: .confirm, confirmAction)])
    }
    
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - priorityValue: 弹框优先级  详见 - `AlertPriority`
    ///   - confirmAction: 确认回调
    /// - Returns: 弹框 控件
    @objc
    static func showDefault(
        title: String?,
        content: String?,
        priorityValue: Float,
        confirmAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        showDefault(title: title, content: content, priority: .init(priorityValue), confirmAction: confirmAction)
    }
    
    @available(swift, deprecated: 3, message: "swift 中不建议使用此方法，建议使用枚举 priorityValue -> priority")
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - priorityValue: 弹框优先级  详见 - `AlertPriority`
    ///   - confirmAction: 确认回调
    /// - Returns: 弹框 控件
    @objc
    static func showDefault(
        title: String?,
        content: String?,
        priorityValue: Float,
        untriggerBehavior: TDPopupViewUntriggeredBehavior,
        switchBehavior: TDPopupViewSwitchBehavior,
        confirmAction: ((LMSAlertAction)->Void)?
    ) -> Self {
        show(title,
             message: content,
             priority: .init(priorityValue),
             untriggerBehavoir: untriggerBehavior,
             switchBehavoir: switchBehavior,
             actions: [.cancelAction, .init(style: .confirm, confirmAction)])
    }
}


extension LMSAlertController {
    @objc public func setAttributeMessage(_ attributeMsg: NSAttributedString?) {
        guard let attributeMsg = attributeMsg else { return }
        messageLabel.text = nil
        messageLabel.attributedText = attributeMsg
        updateAttributeMessage(attributeMsg)
        messageLabel.td.addTap { [weak self] tap in
            self?.messageTapHandle?()
        }
    }
}
