//
//  TDAlertController+Config.swift
//  TDBasis
//
//  Created by Fench on 2024/8/27.
//

import UIKit
import TDBasis
import TDTheme

@objc
@objcMembers
public final class LMSAlertConfig: NSObject {
    
    internal static var global: LMSAlertConfig = .init()
    
    public var nomoreAlertText: Block.ReturnBlock<String> = { "不再提示" }
    public var confirmTitle: Block.ReturnBlock<String> = { "确定" }
    public var cancelTitle: Block.ReturnBlock<String> = { "取消" }
    public var iknowTitle: Block.ReturnBlock<String> = { "确定" }
    public var nomoreCheckBoxNormalImage: UIImage?
    public var nomoreCheckBoxSelectImage: UIImage?
    public var closeImage: UIImage?
    
    public static func setup(_ config: LMSAlertConfig) {
        global = config
    }
}

extension LMSAlertConfig {
    public var messageFont: UIFont {
        .systemFont(ofSize: 14).adaptHD
    }
    
    public var titleFont: UIFont {
        .systemFont(ofSize: 16, weight: .medium).adaptHD
    }
}
