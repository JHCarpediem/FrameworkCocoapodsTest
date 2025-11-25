//
//  DiagBridge.swift
//  TopdonDiagnosis
//
//  Created by liuxinwen on 2025/7/25.
//

import Foundation
import UIKit

@objc public class DiagBridge: NSObject {
    
    /// 在横屏前初始化，防止值问题
    @objc public static let shared = DiagBridge()
    
    public static var HD_HeightValue: CGFloat = TDD_DiagBridge.hd_HeightValue()
    
    public static var H_HeightValue: CGFloat = TDD_DiagBridge.h_HeightValue()
    
    public static var iphoneWidthValue: CGFloat = TDD_DiagBridge.iphoneWidthValue()
    
    /// 是否是刘海屏
    @objc public let iPhoneX: Bool
    
    @objc public static var iPhoneX: Bool { shared.iPhoneX }
    
    @objc public static var liveLandscapeLeftCombineWidth: CGFloat { iPhoneX ? 244.0 : 202.5 }
    
    private override init() {
        iPhoneX = TDD_DiagBridge.isIPhoneX()
        super.init()
    }
    
}

