//
//  UILabel+Theme.swift
//  TDTheme
//
//  Created by fench on 2023/7/19.
//

import UIKit

@objc public extension UILabel {
    @objc public convenience init(text: String?, themeColor: ThemeColorPicker?, font: UIFont?) {
        self.init()
        
        self.text = text
        self.theme.textColor = themeColor
        self.font = font 
    }
}
