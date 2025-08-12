//
//  UIColor+Theme.swift
//  TDTheme
//
//  Created by fench on 2023/7/19.
//

import UIKit

@objc public protocol TDThemColorProvidor: NSObjectProtocol {
    /// 标题颜色
    @objc static var theme_title: ThemeColorPicker? { get }
    
    /// 副标题颜色
    @objc static var theme_subTitle: ThemeColorPicker? { get }
    
    /// 主题色
    @objc static var theme_theme: ThemeColorPicker? { get }
    
    /// 主背景色  一般为 白色
    @objc static var theme_mainBG: ThemeColorPicker? { get }
    
    /// tableView 背景色
    @objc static var theme_tableViewBG: ThemeColorPicker? { get }
    
    /// button view 等的不能点击  不能选择状态的颜色
    @objc static var theme_viewDisableBG: ThemeColorPicker? { get }
    
    /// 弹框背景颜色
    @objc static var theme_alertBG: ThemeColorPicker? { get }
    
    /// 分割线颜色
    @objc static var theme_sepLine: ThemeColorPicker? { get }
    
    /// 浅灰色 eg: #999999
    @objc static var theme_lightGray: ThemeColorPicker? { get }
    
    /// 深灰色 eg: #666666
    @objc static var theme_darkGray: ThemeColorPicker? { get }
    
    /// 按钮的颜色  一般为蓝色
    @objc static var theme_buttonTint: ThemeColorPicker? { get }
}

///// 默认都返回空 需要再实际项目中 自定义配置
public extension TDThemColorProvidor {
    static var theme_title: ThemeColorPicker? { nil }
    static var theme_subTitle: ThemeColorPicker? { nil }
    static var theme_theme: ThemeColorPicker? { nil }
    static var theme_mainBG: ThemeColorPicker? { nil }
    static var theme_tableViewBG: ThemeColorPicker? { nil }
    static var theme_viewDisableBG: ThemeColorPicker? { nil }
    static var theme_alertBG: ThemeColorPicker? { nil }
    static var theme_sepLine: ThemeColorPicker? { nil }
    static var theme_lightGray: ThemeColorPicker? { nil }
    static var theme_darkGray: ThemeColorPicker? { nil }
    static var theme_buttonTint: ThemeColorPicker? { nil }
}


public extension TDThemeBasis where Base: TDThemColorProvidor {
    static var title: ThemeColorPicker? { Base.theme_title }
    static var subTitle: ThemeColorPicker? { Base.theme_subTitle }
    static var theme: ThemeColorPicker? { Base.theme_theme }
    static var mainBG: ThemeColorPicker? { Base.theme_mainBG }
    static  var tableViewBG: ThemeColorPicker? { Base.theme_tableViewBG }
    static var viewDisableBG: ThemeColorPicker? { Base.theme_viewDisableBG }
    static var alertBG: ThemeColorPicker? { Base.theme_alertBG }
    static var sepLine: ThemeColorPicker? { Base.theme_sepLine }
    static var lightGray: ThemeColorPicker? { Base.theme_lightGray }
    static var darkGray: ThemeColorPicker? { Base.theme_darkGray }
    static  var buttonTint: ThemeColorPicker? { Base.theme_buttonTint }
}

@objc public extension UIColor {
    @objc public var themeColorPicker: ThemeColorPicker {
        ThemeColorPicker(v: { self } )
    }
}

public extension UIImage {
    @objc public var themeImagePicker: ThemeImagePicker {
        ThemeImagePicker(v: { self })
    }
}
