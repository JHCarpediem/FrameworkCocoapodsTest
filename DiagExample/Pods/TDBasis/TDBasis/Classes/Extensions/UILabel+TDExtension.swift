//
//  UILabel+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

public extension TDBasisWrap where Base: UILabel {
    /// Required height for a label
    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: base.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = base.font
        label.text = base.text
        label.attributedText = base.attributedText
        label.sizeToFit()
        return label.frame.height
    }

}

@objc public extension UILabel {
    /// Required height for a label
    @objc var td_requiredHeight: CGFloat {
        self.td.requiredHeight
    }
    
    @objc convenience init(text: String?, textColor: UIColor?, font: UIFont?) {
        self.init()
        
        self.text = text
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let font = font {
            self.font = font
        }
    }
}
