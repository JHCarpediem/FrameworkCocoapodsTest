//
//  Color+OC.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/7.
//

import Foundation
import TDBasis
import TDTheme

public extension UIColor {
    /// 文本正文标题主色 白色主题：#333333 黑色主题：#FFFFFF
    @objc public static var theme_title: ThemeColorPicker? { theme.title }
    
    /// 文本副标题色 白色主题：#999999 黑色主题 #FFFFFF80 (白色透明的 0.5)
    @objc public static var theme_subTitle: ThemeColorPicker? { theme.subTitle }
    
    /// 文本辅助色 白色主题： #666666 黑色主题 cccc (白色不透明度0.8)
    @objc public static var theme_assitTitle: ThemeColorPicker? { theme.assitTitle }
    
    /// 页面主背景色 无渐变 #FFFFFF
    @objc public static var theme_mainBackground: ThemeColorPicker? { theme.mainBackground }
    
    /// `tableView` 背景色 #F8F8F8
    @objc public static var theme_tableViewBackground: ThemeColorPicker? { theme.tableViewBackground }
    
    /// 分割线颜色 #DDDDDD
    @objc public static var theme_line: ThemeColorPicker? { theme.line }
    
    /// 主题色 #F22222
    @objc public static var theme_theme: ThemeColorPicker? { theme.line }
    
    /// 按钮/视图 不可用背景灰色 #424D59
    @objc public static var theme_disableBackground: ThemeColorPicker? { theme.disableBackground }
    
    /// 按钮 不可以文本颜色 #FFFFFF4D
    @objc public static var theme_disableText: ThemeColorPicker? { theme.disableText }
    
    /// 错误的红色 #F22222
    @objc public static var theme_error: ThemeColorPicker? { theme.error }
    
    /// `tableView cell` 的背景色 #FFFFFF
    @objc public static var theme_cellBackground: ThemeColorPicker? { theme.cellBackground }
    
    /// `tableView cell` 选中状态 背景色 #1C2C3C
    @objc public static var theme_cellSelectBackground: ThemeColorPicker? { theme.cellSelectBackground }
    
    /// 确定按钮文本颜色 #FFFFFF
    @objc public static var theme_confirmBtnText: ThemeColorPicker? { theme.confirmBtnText }
    
    /// 确定按钮背景颜色 #F22222
    @objc public static var theme_confirmBtnBackground: ThemeColorPicker? { theme.confirmBtnBackground }
    
    /// 确定按钮 不可用状态背景色 #424D59
    @objc public static var theme_confirmBtnDisableBackground: ThemeColorPicker? { theme.confirmBtnDisableBackground }
    
    /// 确定按钮 不可用文本颜色 #FFFFFF4D
    @objc public static var theme_confirmBtnDisableText: ThemeColorPicker? { theme.confirmBtnDisableText }
    
    /// 输入框占位文本颜色 #999999
    @objc public static var theme_textFieldPlaceholder: ThemeColorPicker? { theme.textFieldPlaceholder }
    
}

public extension UIColor {
    /// 文本正文标题主色 白色主题：#333333 黑色主题：#FFFFFF
    @objc public static var td_title: UIColor { td.title }
    
    /// 文本副标题色 白色主题：#999999 黑色主题 #FFFFFF80 (白色透明的 0.5)
    @objc public static var td_subTitle: UIColor { td.subTitle }
    
    /// 文本辅助色 白色主题： #666666 黑色主题 cccc (白色不透明度0.8)
    @objc public static var td_assitTitle: UIColor { td.assitTitle }
    
    /// 页面主背景色 无渐变 #FFFFFF
    @objc public static var td_mainBackground: UIColor { td.mainBackground }
    
    /// `tableView` 背景色 #F8F8F8
    @objc public static var td_tableViewBackground: UIColor { td.tableViewBackground }
    
    /// 分割线颜色 #DDDDDD
    @objc public static var td_line: UIColor { td.line }
    
    /// 主题色 #F22222
    @objc public static var td_theme: UIColor { td.line }
    
    /// 按钮/视图 不可用背景灰色 #424D59
    @objc public static var td_disableBackground: UIColor { td.disableBackground }
    
    /// 按钮 不可以文本颜色 #FFFFFF4D
    @objc public static var td_disableText: UIColor { td.disableText }
    
    /// 错误的红色 #F22222
    @objc public static var td_error: UIColor { td.error }
    
    /// `tableView cell` 的背景色 #FFFFFF
    @objc public static var td_cellBackground: UIColor { td.cellBackground }
    
    /// `tableView cell` 选中状态 背景色 #1C2C3C
    @objc public static var td_cellSelectBackground: UIColor { td.cellSelectBackground }
    
    /// 确定按钮文本颜色 #FFFFFF
    @objc public static var td_confirmBtnText: UIColor { td.confirmBtnText }
    
    /// 确定按钮背景颜色 #F22222
    @objc public static var td_confirmBtnBackground: UIColor { td.confirmBtnBackground }
    
    /// 确定按钮 不可用状态背景色 #424D59
    @objc public static var td_confirmBtnDisableBackground: UIColor { td.confirmBtnDisableBackground }
    
    /// 确定按钮 不可用文本颜色 #FFFFFF4D
    @objc public static var td_confirmBtnDisableText: UIColor { td.confirmBtnDisableText }
    
    /// 输入框占位文本颜色 #999999
    @objc public static var td_textFieldPlaceholder: UIColor { td.textFieldPlaceholder }
    
    /// 导航栏背景色
    @objc public static var td_navigationBackground: UIColor { .td.navigationBackground }
    
    /// 导航栏 右边按钮颜色
    @objc public static var td_navigationRightItemsText: UIColor { .td.navigationRightItemsText }
    
}

public extension ThemeColorPicker {
    /// 文本正文标题主色 白色主题：#333333 黑色主题：#FFFFFF
    @objc public static var theme_title: ThemeColorPicker? { theme.title }
    
    /// 文本副标题色 白色主题：#999999 黑色主题 #FFFFFF80 (白色透明的 0.5)
    @objc public static var theme_subTitle: ThemeColorPicker? { theme.subTitle }
    
    /// 文本辅助色 白色主题： #666666 黑色主题 cccc (白色不透明度0.8)
    @objc public static var theme_assitTitle: ThemeColorPicker? { theme.assitTitle }
    
    /// 页面主背景色 无渐变 #FFFFFF
    @objc public static var theme_mainBackground: ThemeColorPicker? { theme.mainBackground }
    
    /// `tableView` 背景色 #F8F8F8
    @objc public static var theme_tableViewBackground: ThemeColorPicker? { theme.tableViewBackground }
    
    /// 分割线颜色 #DDDDDD
    @objc public static var theme_line: ThemeColorPicker? { theme.line }
    
    /// 主题色 #F22222
    @objc public static var theme_theme: ThemeColorPicker? { theme.line }
    
    /// 按钮/视图 不可用背景灰色 #424D59
    @objc public static var theme_disableBackground: ThemeColorPicker? { theme.disableBackground }
    
    /// 按钮 不可以文本颜色 #FFFFFF4D
    @objc public static var theme_disableText: ThemeColorPicker? { theme.disableText }
    
    /// 错误的红色 #F22222
    @objc public static var theme_error: ThemeColorPicker? { theme.error }
    
    /// `tableView cell` 的背景色 #FFFFFF
    @objc public static var theme_cellBackground: ThemeColorPicker? { theme.cellBackground }
    
    /// `tableView cell` 选中状态 背景色 #1C2C3C
    @objc public static var theme_cellSelectBackground: ThemeColorPicker? { theme.cellSelectBackground }
    
    /// 确定按钮文本颜色 #FFFFFF
    @objc public static var theme_confirmBtnText: ThemeColorPicker? { theme.confirmBtnText }
    
    /// 确定按钮背景颜色 #F22222
    @objc public static var theme_confirmBtnBackground: ThemeColorPicker? { theme.confirmBtnBackground }
    
    /// 确定按钮 不可用状态背景色 #424D59
    @objc public static var theme_confirmBtnDisableBackground: ThemeColorPicker? { theme.confirmBtnDisableBackground }
    
    /// 确定按钮 不可用文本颜色 #FFFFFF4D
    @objc public static var theme_confirmBtnDisableText: ThemeColorPicker? { theme.confirmBtnDisableText }
    
    /// 输入框占位文本颜色 #999999
    @objc public static var theme_textFieldPlaceholder: ThemeColorPicker? { theme.textFieldPlaceholder }
    
    /// 导航栏背景色
    @objc public static var theme_navigationBackground: ThemeColorPicker? { .theme.navigationBackground }
    
    /// 导航栏 右边按钮颜色
    @objc public static var theme_navigationRightItemsText: ThemeColorPicker? { .theme.navigationRightItemsText }
}

