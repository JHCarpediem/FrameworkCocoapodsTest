//
//  Color+Ex.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/7.
//

import Foundation
import TDBasis
import TDTheme

public extension TDBasisWrap where Base: UIColor {
    /// 文本正文标题主色 白色主题：#333333 黑色主题：#FFFFFF
    static var title: UIColor { .theme.title?.color ?? UIColor.td.color(hex6: 0x333333) }
    
    /// 文本副标题色 白色主题：#999999 黑色主题 #FFFFFF80 (白色透明的 0.5)
    static var subTitle: UIColor { .theme.subTitle?.color ?? UIColor.td.color(hex6: 0x999999) }
    
    /// 文本辅助色 白色主题： #666666 黑色主题 cccc (白色不透明度0.8)
    static var assitTitle: UIColor { .theme.assitTitle?.color ?? UIColor.td.color(hex6: 0x666666) }
    
    /// 页面主背景色 无渐变
    static var mainBackground: UIColor { .theme.mainBackground?.color ?? UIColor.td.color(hex6: 0xFFFFFF) }
    
    /// `tableView` 背景色
    static var tableViewBackground: UIColor { .theme.tableViewBackground?.color ?? UIColor.td.color(hex6: 0xF8F8F8) }
    
    /// 分割线颜色
    static var line: UIColor { .theme.line?.color ?? UIColor.td.color(hex6: 0xDDDDDD) }
    
    /// 主题色
    static var theme: UIColor { .theme.theme?.color ?? UIColor.td.color(hex6: 0xF22222) }
    
    /// 按钮/视图 不可用背景灰色
    static var disableBackground: UIColor { .theme.disableBackground?.color ?? UIColor.td.color(hex6: 0x424D59) }
    
    /// 按钮 不可以文本颜色
    static var disableText: UIColor { .theme.disableText?.color ?? UIColor.td.color(hex6: 0xFFFFFF4D) }
    
    /// 错误的红色 #F22222
    static var error: UIColor { .theme.error?.color ?? UIColor.td.color(hex6: 0xF22222) }
    
    /// `tableView cell` 的背景色
    static var cellBackground: UIColor { .theme.cellBackground?.color ?? UIColor.td.color(hex6: 0xFFFFFF) }
    
    /// `tableView cell` 选中状态 背景色
    static var cellSelectBackground: UIColor { .theme.cellSelectBackground?.color ?? UIColor.td.color(hex6: 0x1C2C3C) }
    
    /// 确定按钮文本颜色
    static var confirmBtnText: UIColor { .theme.confirmBtnText?.color ?? UIColor.td.color(hex6: 0xFFFFFF) }
    
    /// 确定按钮背景颜色
    static var confirmBtnBackground: UIColor { .theme.confirmBtnBackground?.color ?? UIColor.td.color(hex6: 0xF22222) }
    
    /// 确定按钮 不可用状态背景色
    static var confirmBtnDisableBackground: UIColor { .theme.confirmBtnDisableBackground?.color ?? UIColor.td.color(hex6: 0x424D59) }
    
    /// 确定按钮 不可用文本颜色
    static var confirmBtnDisableText: UIColor { .theme.confirmBtnDisableText?.color ?? UIColor.td.color(hex6: 0xFFFFFF4D) }
    
    /// 输入框占位文本颜色
    static var textFieldPlaceholder: UIColor { .theme.textFieldPlaceholder?.color ?? UIColor.td.color(hex6: 0x999999) }
    
    /// 导航栏背景色
    static var navigationBackground: UIColor { .theme.navigationBackground?.color ?? .clear }
    
    /// 导航栏 右边按钮颜色
    static var navigationRightItemsText: UIColor { .theme.navigationRightItemsText?.color ?? UIColor.td.title }
}

public extension TDThemeBasis where Base: UIColor {
    /// 文本正文标题主色 白色主题：#333333 黑色主题：#FFFFFF
    static var title: ThemeColorPicker? { UIConfig.color(with: "global.titleColor") }
    
    /// 文本副标题色 白色主题：#999999 黑色主题 #FFFFFF80 (白色透明的 0.5)
    static var subTitle: ThemeColorPicker? { UIConfig.color(with: "global.subTitleColor") }
    
    /// 文本辅助色 白色主题： #666666 黑色主题 cccc (白色不透明度0.8)
    static var assitTitle: ThemeColorPicker? { UIConfig.color(with: "global.assitTitleColor") }
    
    /// 页面主背景色 无渐变 #FFFFFF
    static var mainBackground: ThemeColorPicker? { UIConfig.color(with: "global.mainBackgroundColor") }
    
    /// `tableView` 背景色 #F8F8F8
    static var tableViewBackground: ThemeColorPicker? { UIConfig.color(with: "global.tableViewBackgroundColor") }
    
    /// 分割线颜色 #DDDDDD
    static var line: ThemeColorPicker? { UIConfig.color(with: "global.lineColor") }
    
    /// 主题色 #F22222
    static var theme: ThemeColorPicker? { UIConfig.color(with: "global.themeColor") }
    
    /// 按钮/视图 不可用背景灰色 #424D59
    static var disableBackground: ThemeColorPicker? { UIConfig.color(with: "global.disableBackgroundColor") }
    
    /// 按钮 不可以文本颜色 #FFFFFF4D
    static var disableText: ThemeColorPicker? { UIConfig.color(with: "global.disableTextColor") }
    
    /// 错误的红色 #F22222
    static var error: ThemeColorPicker? { UIConfig.color(with: "global.errorColor") }
    
    /// `tableView cell` 的背景色 #FFFFFF
    static var cellBackground: ThemeColorPicker? { UIConfig.color(with: "global.cellBackgroundColor") }
    
    /// `tableView cell` 选中状态 背景色 #1C2C3C
    static var cellSelectBackground: ThemeColorPicker? { UIConfig.color(with: "global.cellSelectBackgroundColor") }
    
    /// 确定按钮文本颜色 #FFFFFF
    static var confirmBtnText: ThemeColorPicker? { UIConfig.color(with: "global.confirmBtnTextColor") }
    
    /// 确定按钮背景颜色 #F22222
    static var confirmBtnBackground: ThemeColorPicker? { UIConfig.color(with: "global.confirmBtnBackgroundColor") }
    
    /// 确定按钮 不可用状态背景色 #424D59
    static var confirmBtnDisableBackground: ThemeColorPicker? { UIConfig.color(with: "global.confirmBtnDisableBackground") }
    
    /// 确定按钮 不可用文本颜色 #FFFFFF4D
    static var confirmBtnDisableText: ThemeColorPicker? { UIConfig.color(with: "global.confirmBtnDisableTextColor") }
    
    /// 输入框占位文本颜色 #999999
    static var textFieldPlaceholder: ThemeColorPicker? { UIConfig.color(with: "global.textFieldPlaceholder") }
    
    /// 导航栏背景色
    static var navigationBackground: ThemeColorPicker? { UIConfig.color(with: "navigationBar.backgroundColor") }
    
    /// 导航栏 右边按钮颜色
    static var navigationRightItemsText: ThemeColorPicker? { UIConfig.color(with: "navigationBar.rightItemTextColor") }
}

extension ThemeColorPicker: TDThemeCompatible {}
public extension TDThemeBasis where Base: ThemeColorPicker {
    /// 文本正文标题主色 白色主题：#333333 黑色主题：#FFFFFF
    static var title: ThemeColorPicker? { UIColor.theme.title }
    
    /// 文本副标题色 白色主题：#999999 黑色主题 #FFFFFF80 (白色透明的 0.5)
    static var subTitle: ThemeColorPicker? { UIColor.theme.subTitle }
    
    /// 文本辅助色 白色主题： #666666 黑色主题 cccc (白色不透明度0.8)
    static var assitTitle: ThemeColorPicker? { UIColor.theme.assitTitle }
    
    /// 页面主背景色 无渐变 #FFFFFF
    static var mainBackground: ThemeColorPicker? { UIColor.theme.mainBackground }
    
    /// `tableView` 背景色 #F8F8F8
    static var tableViewBackground: ThemeColorPicker? { UIColor.theme.tableViewBackground }
    
    /// 分割线颜色 #DDDDDD
    static var line: ThemeColorPicker? { UIColor.theme.line }
    
    /// 主题色 #F22222
    static var theme: ThemeColorPicker? { UIColor.theme.theme }
    
    /// 按钮/视图 不可用背景灰色 #424D59
    static var disableBackground: ThemeColorPicker? { UIColor.theme.disableBackground }
    
    /// 按钮 不可以文本颜色 #FFFFFF4D
    static var disableText: ThemeColorPicker? { UIColor.theme.disableText }
    
    /// 错误的红色 #F22222
    static var error: ThemeColorPicker? { UIColor.theme.error }
    
    /// `tableView cell` 的背景色 #FFFFFF
    static var cellBackground: ThemeColorPicker? { UIColor.theme.cellBackground }
    
    /// `tableView cell` 选中状态 背景色 #1C2C3C
    static var cellSelectBackground: ThemeColorPicker? { UIColor.theme.cellSelectBackground }
    
    /// 确定按钮文本颜色 #FFFFFF
    static var confirmBtnText: ThemeColorPicker? { UIColor.theme.confirmBtnText }
    
    /// 确定按钮背景颜色 #F22222
    static var confirmBtnBackground: ThemeColorPicker? { UIColor.theme.confirmBtnBackground }
    
    /// 确定按钮 不可用状态背景色 #424D59
    static var confirmBtnDisableBackground: ThemeColorPicker? { UIColor.theme.confirmBtnDisableBackground }
    
    /// 确定按钮 不可用文本颜色 #FFFFFF4D
    static var confirmBtnDisableText: ThemeColorPicker? { UIColor.theme.confirmBtnDisableText }
    
    /// 输入框占位文本颜色 #999999
    static var textFieldPlaceholder: ThemeColorPicker? { UIColor.theme.textFieldPlaceholder }
    
    /// 导航栏背景色
    static var navigationBackground: ThemeColorPicker? { UIColor.theme.navigationBackground }
    
    /// 导航栏 右边按钮颜色
    static var navigationRightItemsText: ThemeColorPicker? { UIColor.theme.navigationRightItemsText }
}


public extension ThemeColorPicker {
    /// 通过颜色选择器 创建一个图片
    func image(for size: CGSize = CGSize(width: 1, height: 1)) -> ThemeImagePicker? {
        guard let color = value() as? UIColor else { return nil }
        var size = size
        if size.width == 0 || size.height == 0 {
            size = CGSize(width: 1, height: 1)
        }
        return ThemeImagePicker(images: UIImage.td.color(color, size: size))
    }
}
