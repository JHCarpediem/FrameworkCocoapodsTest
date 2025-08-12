//
//  TDAlertController+Config.swift
//  TDBasis
//
//  Created by Fench on 2024/8/27.
//

import UIKit

@objc
@objcMembers
public final class TDAlertConfig: NSObject {
    
    public static let global: TDAlertConfig = .init()
    
    public var backgroundColor: UIColor = .white
    public var titleColor: UIColor = UIColor.black
    public var messageColor: UIColor = UIColor.black
    public var titleFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    public var messageFont: UIFont = .systemFont(ofSize: 15)
    public var messageAligment: NSTextAlignment = .center
    public var isShowNomoreAlert: Bool = false
    public var nomoreAlertText: String?
    public var nomoreCheckBoxNormalImage: UIImage?
    public var nomoreCheckBoxSelectImage: UIImage?
    public var statusBarStyle: UIStatusBarStyle = .default
    public var alertButtonStyle: TDAlertButtonStyle = .default
    public var alertButtonArrangeStyle: TDAlertButtonArrangeStyle = .horizontal
    public var contentCornerRadius: CGFloat = 5
    public var nomoreAlertTextColor: UIColor = .lightGray
    public var closeImage: UIImage?
    public var lineColor: UIColor = .lightGray
    public var alertConfirmBtnBackground: UIColor? = UIColor.blue
    public var alertConfirmBtnGradient: [UIColor]?
    public var alertConfirmBtnGradientStyle: GradientStyle = .leftToRight
    public var alertCancelBtnTextColor: UIColor?
    public var alertCancelBtnBackgroundColor: UIColor?
}


extension TDAlertConfig {
    @objc public static var topscan: TDAlertConfig {
        let config = TDAlertConfig()
        config.backgroundColor = UIColor.td.color(hex6: 0x424d59)
        config.titleColor = UIColor.white
        config.messageColor = UIColor.white
        config.titleFont = .systemFont(ofSize: 16, weight: .medium)
        config.messageFont = .systemFont(ofSize: 14)
        config.messageAligment = .center
        config.isShowNomoreAlert = true
        config.nomoreAlertText = "不再提示"
        config.statusBarStyle = .lightContent
        config.alertButtonStyle = .custom
        config.alertButtonArrangeStyle = .horizontal
        config.contentCornerRadius = 5
        config.nomoreAlertTextColor = UIColor.white.withAlphaComponent(0.8)
        config.lineColor = UIColor.white.withAlphaComponent(0.3)
        config.alertConfirmBtnBackground = UIColor.td.color(hex6: 0x1093FF)
        config.alertConfirmBtnGradientStyle = .leftToRight
        config.alertCancelBtnTextColor = UIColor.white
        config.alertCancelBtnBackgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        return config
    }
    
    @objc public static var carpal: TDAlertConfig {
        let config = TDAlertConfig()
        config.titleColor = UIColor.black
        config.messageColor = UIColor.black
        config.titleFont = .systemFont(ofSize: 15, weight: .medium)
        config.messageFont = .systemFont(ofSize: 15)
        config.messageAligment = .center
        config.isShowNomoreAlert = false
        config.nomoreAlertText = ""
        config.nomoreCheckBoxNormalImage
        config.nomoreCheckBoxSelectImage
        config.statusBarStyle = .default
        config.alertButtonStyle = .default
        config.alertButtonArrangeStyle = .horizontal
        config.contentCornerRadius = 5
        config.nomoreAlertTextColor = .lightGray
        config.closeImage
        config.lineColor = .lightGray
        config.alertConfirmBtnBackground = UIColor.blue
        config.alertConfirmBtnGradient
        config.alertConfirmBtnGradientStyle = .leftToRight
        config.alertCancelBtnTextColor
        
        return config
    }
    
    @objc public static var topvci: TDAlertConfig {
        let config = TDAlertConfig()
        config.titleColor = UIColor.black
        config.messageColor = UIColor.black
        config.titleFont = .systemFont(ofSize: 15, weight: .medium)
        config.messageFont = .systemFont(ofSize: 15)
        config.messageAligment = .center
        config.isShowNomoreAlert = false
        config.nomoreAlertText = ""
        config.nomoreCheckBoxNormalImage
        config.nomoreCheckBoxSelectImage
        config.statusBarStyle = .default
        config.alertButtonStyle = .default
        config.alertButtonArrangeStyle = .horizontal
        config.contentCornerRadius = 5
        config.nomoreAlertTextColor = .lightGray
        config.closeImage
        config.lineColor = .lightGray
        config.alertConfirmBtnBackground = UIColor.blue
        config.alertConfirmBtnGradient
        config.alertConfirmBtnGradientStyle = .leftToRight
        config.alertCancelBtnTextColor
        
        return config
    }
    
    @objc public static var topInfreed: TDAlertConfig {
        let config = TDAlertConfig()
        config.titleColor = UIColor.black
        config.messageColor = UIColor.black
        config.titleFont = .systemFont(ofSize: 15, weight: .medium)
        config.messageFont = .systemFont(ofSize: 15)
        config.messageAligment = .center
        config.isShowNomoreAlert = false
        config.nomoreAlertText = ""
        config.nomoreCheckBoxNormalImage
        config.nomoreCheckBoxSelectImage
        config.statusBarStyle = .default
        config.alertButtonStyle = .default
        config.alertButtonArrangeStyle = .horizontal
        config.contentCornerRadius = 5
        config.nomoreAlertTextColor = .lightGray
        config.closeImage
        config.lineColor = .lightGray
        config.alertConfirmBtnBackground = UIColor.blue
        config.alertConfirmBtnGradient
        config.alertConfirmBtnGradientStyle = .leftToRight
        config.alertCancelBtnTextColor
        
        return config
    }
    
    @objc public static var batteryLab: TDAlertConfig {
        let config = TDAlertConfig()
        config.titleColor = UIColor.black
        config.messageColor = UIColor.black
        config.titleFont = .systemFont(ofSize: 15, weight: .medium)
        config.messageFont = .systemFont(ofSize: 15)
        config.messageAligment = .center
        config.isShowNomoreAlert = false
        config.nomoreAlertText = ""
        config.nomoreCheckBoxNormalImage
        config.nomoreCheckBoxSelectImage
        config.statusBarStyle = .default
        config.alertButtonStyle = .default
        config.alertButtonArrangeStyle = .horizontal
        config.contentCornerRadius = 5
        config.nomoreAlertTextColor = .lightGray
        config.closeImage
        config.lineColor = .lightGray
        config.alertConfirmBtnBackground = UIColor.blue
        config.alertConfirmBtnGradient
        config.alertConfirmBtnGradientStyle = .leftToRight
        config.alertCancelBtnTextColor
        
        return config
    }
}
