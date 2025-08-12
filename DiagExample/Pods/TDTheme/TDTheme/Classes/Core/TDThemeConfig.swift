//
//  TDThemeConfig.swift
//  TDTheme
//
//  Created by fench on 2023/7/17.
//

import UIKit
import TDBasis

public enum TDThemeType {
    case `default`
    case custom(key: String, sourceDir: String)
}

@objc public class TDThemeConfig: NSObject {
    
    static var skinType: String = "default"
    
    
    @objc public func setTheme(skinType: String, jsonName: String, path: String) {
        let jsonUrl = URL(fileURLWithPath: path)
        ThemeManager.setTheme(jsonName: jsonName, path: .sandbox(jsonUrl))
        
        TDThemeConfig.skinType = skinType
    }
}
