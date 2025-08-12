//
//  UIButton+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

extension TDBasisWrap where Base: UIButton {
    
    /// 单独给某个状态设置边框颜色
    /// - Parameters:
    ///   - borderColor: 边框颜色
    ///   - state: state
    ///   - animated: 是否需要动画 默认 `YES`
    public func setBorderColor(_ borderColor: UIColor?, forState state: UIControl.State, animated: Bool = true) {
        guard let borderColor = borderColor else { return }
        base.td_setborderColor(borderColor, for: state, animated: animated)
    }
    
    /// 单独给某个状态设置边框宽度
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - state: state
    ///   - animated: 是否需要动画 默认 `YES`
    public func setBorderWidth(_ borderWidth: CGFloat, forState state: UIControl.State, animated: Bool = true) {
        base.td_setborderWidth(borderWidth, for: state, animated: animated)
    }
    
    /// 单独给某个状态设置背景颜色
    /// - Parameters:
    ///   - backgroundColor: 背景颜色
    ///   - state: state
    ///   - animated: 是否需要动画 默认 `YES`
    public func setBackgroundColor(_ backgroundColor: UIColor?, forState state: UIControl.State, animated: Bool = true) {
        guard let backgroundColor = backgroundColor else { return }
        base.td_setBackgroundColor(backgroundColor, for: state, animated: animated)
    }
    
    /// 单独给某个状态设置标题字体
    /// - Parameters:
    ///   - font: 字体
    ///   - state: state
    public func setTitleFont(_ font: UIFont, forState state:UIControl.State) {
        base.td_setTitleLabelFont(font, for: state)
    }
    
    /// 获取`state`状态下的边框颜色
    /// - Parameter state: state
    /// - Returns: 边框颜色
    public func borderColor(for state: UIControl.State) -> UIColor? {
        base.td_borderColor(for: state)
    }
    
    /// 获取`state`的边框宽度
    /// - Parameter state: state
    /// - Returns: 边框宽度
    public func borderWidth(for state: UIControl.State) -> CGFloat {
        base.td_borderWidth(for: state)
    }
    
    /// 获取`state`的背景颜色
    /// - Parameter state: state
    /// - Returns: 背景色
    public func backgroundColor(for state: UIControl.State) -> UIColor? {
        base.td_backgroundColor(for: state)
    }
    
    /// 获取`state`的文字字体
    /// - Parameter state: state
    /// - Returns: 字体
    public func titleFont(for state: UIControl.State) -> UIFont {
        base.td_titleLabelFont(for: state)
    }
}
