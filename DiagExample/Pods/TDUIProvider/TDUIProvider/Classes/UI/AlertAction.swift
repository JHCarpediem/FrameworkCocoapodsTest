//
//  AlertAction.swift
//  TDUIProvider
//
//  Created by Fench on 2025/5/27.
//

import Foundation
import TDBasis
import TDTheme


//MARK: - 按钮排列方式枚举
@objc public enum LMSAlertButtonArrangeStyle: Int {
    case vertical
    case horizontal
}

//MARK - AlertActionStyle
public enum LMSAlertActionStyle {
    /// 确认按钮
    case confirm
    /// 取消按钮
    case cancel
    /// 我知道了  按钮
    case iknow
    
    case custom(title: String, color: UIColor?, backgroundColor: UIColor?)
    
    
    var textColor : UIColor? {
        switch self {
        case .confirm, .iknow:
            if AlertProvider.buttonStyle == .custom {
                return UIColor.td.confirmBtnText
            }
            return UIColor.td.theme
        case .cancel:
            if AlertProvider.buttonStyle == .custom {
                return UIColor.td.title
            }
            return UIColor.td.subTitle
        case .custom(_, let color, _):
            return color
        }
    }
    
    var backgroundColor: UIColor? {
        let config = LMSAlertConfig.global
        switch self {
        case .confirm, .iknow:
            if AlertProvider.buttonStyle == .custom {
                return UIColor.td.theme
            }
            return nil
        case .cancel:
            if AlertProvider.buttonStyle == .custom {
                return AlertProvider.cancelBtnBackgroundColor?.color
            }
            return nil
        case .custom(_, _, let backgroundColor):
            return backgroundColor
        }
    }
    
    var title: String {
        let config = LMSAlertConfig.global
        switch self {
        case .confirm:
            return config.confirmTitle()
        case .cancel:
            return config.cancelTitle()
        case .iknow:
            return config.iknowTitle()
        case .custom(let title, _, _):
            return title
        }
    }
}

// MARK: - LMSAlertAction
@objc
@objcMembers
open class LMSAlertAction: NSObject {
    public var titleColor: UIColor?
    /// 标题
    public var title: String!
    /// 图片
    public var image: UIImage?
    /// 点击回调
    public var action: ((_ action: LMSAlertAction) -> Void)?
    /// 按钮的样式
    public var style: LMSAlertActionStyle = .confirm
    
    public var backgroundColor: UIColor?
    
    public var isTapHideAlert: Bool = true
    
    public var btnStyle: LMSAlertButtonStyle = AlertProvider.buttonStyle
    
    // 是否不再提示
    public var isNomoreAlert: Bool = false
    
    /// 快速构建AlertAction  alert 的按钮
    ///
    /// - Parameters:
    ///   - title: 按钮的标题
    ///   - style: LMSAlertActionStyle 支持default 和 cancel 两种样式
    ///   - image: 按钮的图片
    ///   - action: 点击按钮的回调
    public convenience init(
        style: LMSAlertActionStyle,
        title: String? = nil,
        image: UIImage? = nil,
        _ action: ((_ action: LMSAlertAction) -> Void)?
    ) {
        self.init()
        self.title = title
        self.image = image
        self.action = action
        self.style = style
    }
    
    @objc public convenience init(
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor? = nil,
        image: UIImage? = nil,
        _ action: ((_ action: LMSAlertAction) -> Void)?
    ) {
        self.init()
        
        self.title = title
        self.image = image
        self.action = action
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
    }
    
    @objc public convenience init(
        title: String,
        titleColor: UIColor,
        image: UIImage? = nil,
        backgroundColor: UIColor? = nil,
        btnStyle: LMSAlertButtonStyle,
        _ action: ((_ action: LMSAlertAction) -> Void)?
    ) {
        self.init()
        self.title = title
        self.image = image
        self.action = action
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.btnStyle = btnStyle
    }
    
    @objc public convenience init(
        title: String,
        titleColor: ThemeColorPicker? = nil,
        backgroundColor: ThemeColorPicker? = nil,
        _ action: ((_ action: LMSAlertAction) -> Void)?
    ) {
        self.init()
        self.title = title
        self.titleColor = titleColor?.color
        self.action = action
        self.backgroundColor = backgroundColor?.color
    }
    
}

@objc extension LMSAlertAction {
    
    /// 快速构建常用的 AlertAction 按钮 - 确定按钮
    @objc public static var confirmAction: LMSAlertAction { LMSAlertAction(style: .confirm, nil) }
    
    /// 快速构建常用的 AlertAction 按钮 - 取消按钮
    @objc public static var cancelAction: LMSAlertAction { LMSAlertAction(style: .cancel, nil) }
    
    /// 快速构建常用的 AlertAction 按钮 - 我知道了 按钮 (确定)
    @objc public static var iknowAction: LMSAlertAction { LMSAlertAction(style: .iknow, nil) }
    
}
