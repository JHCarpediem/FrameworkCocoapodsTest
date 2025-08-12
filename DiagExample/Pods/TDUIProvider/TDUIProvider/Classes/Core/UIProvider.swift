//
//  UIProvider.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/7.
//

import Foundation
import TDBasis
import TDTheme

public struct UIProvider {
    /// 状态栏样式
    public static var statusBarStyle: UIStatusBarStyle {
        if let style = UIConfig.intValue(keyPath: "global.statusBarStyle") {
            return UIStatusBarStyle(rawValue: style) ?? .default
        }
        return .default
    }
    
    /// 是否是中性 App
    public static var isNeutral: Bool {
        UIConfig.intValue(keyPath: "global.isNeutral") == 1
    }
    
    /// 中性 App Topdon 替换文本
    public static var neutralReplaceValue: String {
        return UIConfig.string(for: "global.neutralTopdonReplaceValue", defaultValue: "")
    }
    
    /// 是否是平板
    public static var isHD: Bool {
        UIConfig.intValue(keyPath: "global.isHD") == 1
    }
    
    /// 退出登录是否pop 到 root
    public static var isLogoutPopToRoot: Bool {
        return UIConfig.intValue(keyPath: "global.isLogoutPopToRoot", defaultValue: 1) == 1
    }
    
    /// 返回默认导航栏 返回按钮
    public static var navigationBackIcon: ThemeImagePicker? {
        let oldName = "LMS_login_backImage"
        if let image = UIConfig.image(named: oldName, bundle: UIConfig.resourceBundle) {
            return image
        }
        
        for bundle in UIConfig.middlewareConfigs.map(\.bundle) {
            if let image = UIConfig.image(named: oldName, bundle: bundle) {
                return image
            }
        }
        
        let backImageName = "td_navigation_back_icon"
        return UIConfig.image(named: backImageName)?.image(byTintColor: .td.title)
    }
}


extension UIProvider {
    public struct Image {}
}

public extension UIProvider.Image {
    static var navigationBack: ThemeImagePicker? { UIProvider.navigationBackIcon }
    
    static var checkboxSquareNormal: ThemeImagePicker? {
        let oldName = "feedback_normal"
        if let image = UIConfig.image(named: oldName) {
            return image
        }
        return UIConfig.image(named: "td_checkbox_square_normal")
    }
    
    static var checkboxSquareSelected: ThemeImagePicker? {
        let oldName = "feedback_selected"
        if let image = UIConfig.image(named: oldName) {
            return image
        }
        return UIConfig.image(named: "td_checkbox_square_selected")
    }
    
    static var checkboxRoundNormal: ThemeImagePicker? {
        let oldName = "LMS_login_round"
        if let image = UIConfig.image(named: oldName) {
            return image
        }
        return UIConfig.image(named: "td_checkbox_round_normal")
    }
    
    static var checkboxRoundSelected: ThemeImagePicker? {
        let oldName = "LMS_login_round_select"
        if let image = UIConfig.image(named: oldName) {
            return image
        }
        return UIConfig.image(named: "td_checkbox_round_selected")
    }
}


public extension UIProvider {
    /// 通过尺寸创建 确定按钮背景色 （如果配置了渐变色 就是渐变 否则返回主题色）
    static func confirmBackground(size: CGSize) -> ThemeColorPicker? {
        guard let confirmBtnColors = Gradient.confirmBtnColors, !confirmBtnColors.isEmpty else {
            return .theme.theme
        }
        
        return gridentColor(colors: confirmBtnColors, size: size, style: Gradient.confirmBtnStyle)
    }
    
    /// 通过尺寸创建 确定按钮背景图片 （如果配置了渐变色 就是渐变 否则返回主题色创建图片）
    static func confirmBackgroundImage(size: CGSize) -> ThemeImagePicker? {
        guard let confirmBtnColors = Gradient.confirmBtnColors, !confirmBtnColors.isEmpty else {
            return ThemeColorPicker.theme.theme?.image(for: size)
        }
        
        return ThemeImagePicker(keyPath: "") { _ in
            return UIImage.td.gradient(colors: confirmBtnColors, size: size, style: Gradient.confirmBtnStyle)
        }
    }
    
    /// 通过此次创建控制器背景色（如果配置了渐变色 就是渐变 否则返回控制器纯色背景）
    static func mainBackground(size: CGSize = UI.SCREEN_BOUNDS.size) -> ThemeColorPicker? {
        guard let mainBackgroundColors = Gradient.mainBackgroundColors, !mainBackgroundColors.isEmpty else {
            return .theme.mainBackground
        }
        
        return gridentColor(colors: mainBackgroundColors, size: size, style: Gradient.mainBackgroundStyle)
    }
    
    /// 创建渐变颜色的 颜色选择器
    static func gridentColor(colors: [UIColor], size: CGSize, style: GradientStyle) -> ThemeColorPicker? {
        ThemeColorPicker(keyPath: "") { _ in
            return UIColor.td.gradient(colors: colors, size: size, style: style)
        }
    }
}
