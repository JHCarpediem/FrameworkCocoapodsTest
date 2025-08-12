//
//  UIProvider+Gradient.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/8.
//

import Foundation
import TDBasis

extension UIProvider {
    public struct Gradient {}
}

public extension UIProvider.Gradient {
    /// 控制器背景渐变色 颜色数组
    static var mainBackgroundColors: [UIColor]? {
        UIConfig.gradient(keyPath: "gradient.mainBackgroundGradient")
    }
    
    /// 控制器背景渐变色 渐变方式
    static var mainBackgroundStyle: GradientStyle {
        UIConfig.gradientStyle(with: "gradient.mainBackgroundGradientStyle") ?? .topLeftToBottomRight
    }
    
    /// 确定按钮渐变背景色 颜色数组
    static var confirmBtnColors: [UIColor]? {
        UIConfig.gradient(keyPath: "gradient.confirmBtnGradientColors")
    }
    
    /// 确定按钮渐变背景色 渐变方式
    static var confirmBtnStyle: GradientStyle {
        UIConfig.gradientStyle(with: "gradient.confirmBtnGradientStyle") ?? .leftToRight
    }
    
    /// 选择器选中行 渐变背景色 颜色数组
    static var pickerViewRowSelectColors: [UIColor]? {
        UIConfig.gradient(keyPath: "gradient.pickerViewRowSelectGradient")
    }
    
    /// 选择器选中行 渐变背景色 渐变方式
    static var pickerViewRowSelectStyle: GradientStyle {
        UIConfig.gradientStyle(with: "gradient.pickerViewRowSelectGradientStyle") ?? .leftToRight
    }
    
    /// 反馈页面 渐变背景 颜色数组
    static var feedbackBackgroundColors: [UIColor]? {
        UIConfig.gradient(keyPath: "gradient.feedbackBackgroundGradient")
    }
    
    /// 反馈页面 渐变背景 渐变方式
    static var feedbackBackgroundStyle: GradientStyle {
        UIConfig.gradientStyle(with: "gradient.feedbackBackgroundGradientStyle") ?? .topToBottom
    }
    
}
