//
//  ArtiADASReportArrowTipsView.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/21.
//

import UIKit
import SnapKit

class ArtiADASReportArrowTipsView: UIView {
    
    private(set) var containerView = UIView()
    private(set) var contentView = UIView()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        enableTapDismiss()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(containerView)
        containerView.frame = frame
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        addSubview(contentView)
        
        containerView.backgroundColor = .clear
        
        contentView.width = UIScreen.main.bounds.width - contentGap * 2
        contentView.height = 200
        contentView.centerX = width / 2
        contentView.centerY = height / 2
        contentView.backgroundColor = .white
        contentView.decorateShadow(color: UIColor.black, alpha: 0.08 , x: 0, y: 5, blur: 25)
        
        contentView.addSubview(imageView)
        
        contentView.layer.insertSublayer(pointer, at: 0)
    }
    
    func enableTapDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
        containerView.addGestureRecognizer(tap)
        containerView.isUserInteractionEnabled = true
    }
    
    enum ArrowDirection {
        /// 箭头向下
        case bottom
        /// 箭头向上
        case top
    }
    
    /// 矩形框与弹出控件的距离
    let contentOffset: CGFloat = 0
    /// 箭头框与弹出控件的距离
    let arrowOffset: CGFloat = -5
    /// 箭头高度
    var arrowHeight: CGFloat {
        return contentOffset - arrowOffset
    }
    /// 图片边距
    var imageGap: CGFloat = 15
    /// 矩形框边距
    var contentGap: CGFloat = 20
    /// 箭头宽度
    let arrowWidth: CGFloat = 10
    /// 箭头顶部到 postionControl 顶部/ or 顶部距离
    var arrowPeekOffset: CGFloat = -3
    
    /// |-20 -- 20-| 16 v - 16 v |
    func show(at postionControl: UIView, image: UIImage, direction: ArrowDirection = .bottom) {
        
        let ratio = image.size.width / image.size.height
        
        let imageContentWidth = UIScreen.main.bounds.width - 2 * (imageGap + contentGap)
        
        let imageContentHeight = imageContentWidth / ratio
        
        contentView.height = imageContentHeight + imageGap * 2
        
        if direction == .bottom {
            
            let point = postionControl.convert(CGPoint(x: postionControl.centerX, y: postionControl.top), to: self)
            
            contentView.top = point.y - contentOffset*2 - contentView.height + arrowPeekOffset
            
            pointer.frame = contentView.bounds
            
            let pointerPoint = contentView.convert(CGPoint(x: postionControl.centerX - contentGap * 2, y: postionControl.top), to: self)
            
            let gaugePath = UIBezierPath()
            // 三角顶点
            gaugePath.move(to: CGPoint(x: pointerPoint.x, y: contentView.height + (contentOffset - arrowOffset)))
            // 三角右点
            gaugePath.addLine(to: CGPoint(x: pointerPoint.x + arrowWidth / 2, y: contentView.height))
            // 三角左点
            gaugePath.addLine(to: CGPoint(x: pointerPoint.x + -(arrowWidth / 2), y: contentView.height))
            
            gaugePath.close()
            pointer.path = gaugePath.cgPath
        } else {
            let point = postionControl.convert(CGPoint(x: postionControl.centerX, y: postionControl.bottom), to: self)
            
            contentView.top = point.y + contentOffset + arrowPeekOffset
            
            pointer.frame = contentView.bounds
            
            let pointerPoint = contentView.convert(CGPoint(x: postionControl.centerX - contentGap * 2, y: postionControl.bottom), to: self)
            
            let gaugePath = UIBezierPath()
            // 三角顶点
            gaugePath.move(to: CGPoint(x: pointerPoint.x, y: -(contentOffset - arrowOffset)))
            // 三角右点
            gaugePath.addLine(to: CGPoint(x: pointerPoint.x + arrowWidth / 2, y: 0))
            // 三角左点
            gaugePath.addLine(to: CGPoint(x: pointerPoint.x + -(arrowWidth / 2), y: 0))
            gaugePath.close()
            pointer.path = gaugePath.cgPath
        }
        
        imageView.image = image
        imageView.width = contentView.width - imageGap * 2
        imageView.height = contentView.height - imageGap * 2
        imageView.left = imageGap
        imageView.top = imageGap
        show()
    }
    
    /// 帮助图片
    private(set) lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    /// 箭头
    private lazy var pointer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        shapeLayer.fillColor = UIColor.white.cgColor
        return shapeLayer
    }()
    
}

extension ArtiADASReportArrowTipsView  {
    
    @objc func show() {
        self.alpha = 0.0
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.alpha = 1.0
        }) { _ in }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}

// MARK: - Shadow

extension UIView {
    
    /// 添加阴影
    func decorateShadow(color: UIColor = .black,
                        alpha: Float = 0.5,
                        x: CGFloat,
                        y: CGFloat,
                        blur: CGFloat,
                        spread: CGFloat = 0) {
        layer.decorateShadow(color: color, alpha: alpha, x: x, y: y, blur: blur, spread: spread)
    }
}

extension CALayer {
    
    /// 添加阴影
    func decorateShadow(color: UIColor = .black,
                        alpha: Float = 0.5,
                        x: CGFloat,
                        y: CGFloat,
                        blur: CGFloat,
                        spread: CGFloat = 0) {
        
        shadowColor   = color.cgColor
        shadowOpacity = alpha
        shadowOffset  = CGSize(width: x, height: y)
        shadowRadius  = blur / UIScreen.main.scale
        masksToBounds = false
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx     = -spread
            let rect   = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}

extension UIView {
    
    /// x 的位置
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// y 的位置
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// height: 视图的高度
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    /// width: 视图的宽度
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size: 视图的zize
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX: 视图的X中间位置
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY: 视图Y的中间位置
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    /// top 上端横坐标(y)
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// left 左端横坐标(x)
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// bottom 底端纵坐标 (y + height)
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set(newValue) {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    /// right 底端纵坐标 (x + width)
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(newValue) {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
}
