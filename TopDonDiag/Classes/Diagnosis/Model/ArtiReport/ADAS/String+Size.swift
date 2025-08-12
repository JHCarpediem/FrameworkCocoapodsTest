//
//  String+Size.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/15.
//

import Foundation
import UIKit

// MARK: - Size

internal extension String {
    
    func heightOfString(usingFont font: UIFont, withWidth width: CGFloat) -> CGFloat {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let size = CGSizeMake(width, CGFloat.greatestFiniteMagnitude)
        let estimatedFrame = NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return estimatedFrame.height
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func size(maxWidth: CGFloat, maxHeight: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGSize {
        if isBlank { return .zero }
        
        let rect = CGRect(x: 0, y: 0, width: maxWidth, height: maxHeight)
        
        let label = TDD_CustomLabel(frame: rect)
        label.font = font
        label.text = self
        label.numberOfLines = 0
        
        return label.sizeThatFits(rect.size)
    }
    
    func width(maxWidth: CGFloat, maxHeight: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGFloat {
        return size(maxWidth: maxWidth, maxHeight: maxHeight, font: font).width
    }
    
    func height(maxWidth: CGFloat, maxHeight: CGFloat = CGFloat(MAXFLOAT), font: UIFont) -> CGFloat {
        return size(maxWidth: maxWidth, maxHeight: maxHeight, font: font).height
    }
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == ""
    }
    
}

extension NSAttributedString {
    
    func width(containerHeight: CGFloat) -> CGFloat {
        // 定义一个 CGSize，宽度为无限制，高度为容器的高度
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: containerHeight)
        
        // 计算文本的矩形框
        let boundingRect = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        // 返回计算出的宽度，并向上取整
        return ceil(boundingRect.width)
    }
    
    func height(containerWidth: CGFloat) -> CGFloat {
        // 定义一个 CGSize，宽度为容器的宽度，高度为无限制
        let maxSize = CGSize(width: containerWidth, height: CGFloat.greatestFiniteMagnitude)
        
        // 计算文本的矩形框
        let boundingRect = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        // 返回计算出的高度，并向上取整
        return ceil(boundingRect.height)
    }
}
