//
//  TDDUIViewEx.swift
//  TDDiag
//
//  Created by fench on 2023/7/1.
//

import UIKit

@objc public extension UIView {
    @objc func draw(in context: CGContext) {
        draw(in: context, oriView: self)
    }
    
    private func draw(in context: CGContext, oriView: UIView) {
        
        // 控件在原UI中不显示 则不绘制
        if self.frame == .zero || self.isHidden || self.alpha == 0 || self.frame.width == 0 || self.frame.height == 0 { return }
        
        var rect = self.frame
        
        // 坐标系转换
        if self != oriView, superview! != oriView {
            rect = superview!.convert(rect, to: oriView)
        }
        
        // 绘制背景
        if let backgroundColor = backgroundColor, backgroundColor != .clear {
            
            // 绘制圆角
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: layer.cornerRadius, height: layer.cornerRadius))
            context.addPath(path.cgPath)
            context.setFillColor(backgroundColor.cgColor)
            context.closePath()
            context.fillPath()
        }
        
        // 绘制虚线
        if let dashLine = self as? TDD_DashLineView {
            self.backgroundColor = .clear
            self.snapshotImage?.draw(in: rect)
            
        }
        // 绘制Label
        if let label = self as? UILabel {
            
            let attribute: [NSAttributedString.Key : Any] = [.foregroundColor: label.textColor!, .font: label.font!]
            let oriFrame = rect
            label.sizeToFit()
            let fitFrame = label.frame
            
            var drawRect = rect
            drawRect.size = fitFrame.size
            switch label.textAlignment {
            case.center:
                drawRect.origin.x = oriFrame.minX + (oriFrame.width - fitFrame.width) / 2
                break
            case .right:
                drawRect.origin.x = oriFrame.maxX - fitFrame.width
                break
            default:
                break
            }
            drawRect.origin.y = oriFrame.minY + (oriFrame.height - fitFrame.height) / 2
            if let attribteText = label.attributedText {
                if (abs(round(label.font.lineHeight) - round(label.frame.height)) < round(label.font.lineHeight)) {
                    attribteText.draw(in: drawRect)
                } else {
                    (attribteText.string as NSString).draw(in: drawRect, withAttributes: attribute)
                }
            } else {
                (label.text as? NSString)?.draw(in: label.frame, withAttributes: attribute)
            }
        }
        
        // 绘制图片
        if let imageView = self as? UIImageView {
            imageView.image?.draw(in: rect)
        }
        
        self.subviews.forEach { subView in
            // 递归绘制 所有的子控件
            subView.draw(in: context, oriView: oriView)
        }
        
    }
    
    
    var snapshotImage: UIImage? {
        if bounds.size.width <= 0 || bounds.size.height <= 0 { return nil }
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}


