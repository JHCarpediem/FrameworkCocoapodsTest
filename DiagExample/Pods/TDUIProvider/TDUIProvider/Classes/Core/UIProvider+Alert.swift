//
//  UIProvider+Alert.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/8.
//

import Foundation
import TDBasis
import TDTheme

typealias AlertProvider = UIProvider.Alert

extension UIProvider {
    public struct Alert {}
}

extension UIProvider.Alert {
    
    /// 按钮样式 默认为带线条
    public static var buttonStyle: LMSAlertButtonStyle {
        let rawValue = UIConfig.intValue(keyPath: "alert.buttonStyle", defaultValue: 0)
        return .init(rawValue: rawValue) ?? .default
    }
    
    /// 弹框的圆角 默认：5
    public static var contentCornerRadius: CGFloat {
        return UIConfig.doubleValue(keyPath: "alert.conterntCornerRadius", defaultValue: 5)
    }
    
    /// 弹框的背景色 默认白色
    public static var backgroundColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.backgroundColor") ?? .white
    }
    
    /// 弹框的标题文本色 默认： title
    public static var titleTextColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.titleTextColor") ?? .theme.title
    }
    
    /// 弹框的内容文本色 默认： subTitle
    public static var messageTextColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.messageTextColor") ?? .theme.subTitle
    }
    
    /// 弹框的取消按钮的文本色: 不配置默认 subTitle
    public static var cancelBtnTextColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.cancelBtnTextColor") ?? .theme.subTitle
    }
    
    /// 弹框取消按钮的背景色： 不配做 默认 clear
    public static var cancelBtnBackgroundColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.cancelBtnBackgroundColor") ?? .clear
    }
    
    /// 弹框内文本的链接色 不配置 默认 主题色
    public static var linkTextColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.linkTextColor") ?? .theme.theme
    }
    
    /// 弹框是否隐藏 分割线 默认 false 
    public static var isHideLine: Bool {
        return UIConfig.intValue(keyPath: "alert.lineHidden", defaultValue: 0) == 1
    }
    
    /// 设置弹框全局内容对齐方式 如果没有配置 则默认左对齐
    public static var messageTextAlignment: NSTextAlignment {
        if let alignmentText = UIConfig.string(for: "alert.messageTextAlignment") {
            if let alignmentInt = alignmentText.td.int {
                return NSTextAlignment(rawValue: alignmentInt) ?? .left
            }
            
            switch alignmentText.lowercased() {
            case "left": return .left
            case "center": return .center
            case "right": return .right
            case "justified": return .justified
            case "natural": return .natural
            default: return .left
            }
        }
        
        if let alignmentInt = UIConfig.intValue(keyPath: "alert.messageTextAlignment") {
            return NSTextAlignment(rawValue: alignmentInt) ?? .left
        }
        
        return .left
    }
    
    public static var nomoreAlertTextColor: ThemeColorPicker? {
        return UIConfig.color(with: "alert.nomoreAlertTextColor") ?? .theme.subTitle
    }
}
