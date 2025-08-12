//
//  UIView+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit


//MARK: UIView 扩展 所有的 TD 分类 在Swift中使用都采用 ·td· 做命名空间 OC 中使用 使用 td_xxx
/**
 eg:
 let view = UIView()
 view.td.size = CGSize.zero
 view.td.origin = CGPoint.zero
 
 UIView *view = [ UIView new];
 view.td_height = 200;
 */

@objc public extension UIView {
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func td_addRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.td.addRoundCorners(corners, radius: radius)
    }

    /// Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func td_addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        self.td.addShadow(ofColor: color, radius: radius, offset: offset, opacity: opacity)
    }
    
    /// Rotate view by angle on relative axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view by.  使用度数： 180 、360
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func td_rotate(byAngle angle: CGFloat, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        self.td.rotate(byAngle: angle, ofType: .degrees, animated: animated, duration: duration, completion: completion)
    }

    /// Rotate view to angle on fixed axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view to.  使用度数： 180 、360
    ///   - animated: set true to animate rotation (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    @objc func td_rotate(toAngle angle: CGFloat, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        self.td.rotate(toAngle: angle, ofType: .degrees, animated: animated, duration: duration, completion: completion)
    }

    /// Scale view by offset.
    ///
    /// - Parameters:
    ///   - offset: scale offset
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    
    @objc func td_scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        self.td.scale(by: offset, animated: animated, duration: duration, completion: completion)
    }

    /// Shake view.
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    @objc func td_shake(duration: TimeInterval = 1, completion:(() -> Void)? = nil) {
        self.td.shake(direction: .horizontal, duration: duration, animationType: .easeInOut, completion: completion)
    }
    
    /// Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var td_snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        var size = bounds.size
        if let scrollView = self as? UIScrollView {
            size = scrollView.contentSize
        }
        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: size)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 给View 添加点击手势 通过`block`的方式回调
    @objc func td_addTap(_ tapRecognize: ((_ tap: Any)->Void)?) {
        let tapGes = UITapGestureRecognizer { (sender) in
            tapRecognize?(sender)
        }
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGes)
    }
    
    
    @objc var td_origin:CGPoint {
        get { frame.origin }
        set {
            var rect = frame
            rect.origin = newValue
            self.frame = rect
        }
    }
    
    
    @objc var td_size:CGSize {
        get { frame.size }
        set {
            var rect = frame
            rect.size = newValue
            self.frame = rect
        }
    }
    
    @objc var td_left:CGFloat {
        get { frame.origin.x }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    @objc var td_top:CGFloat {
        get { frame.origin.y }
        set {
            var rect = frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    @objc var td_right:CGFloat {
        get { frame.origin.x + frame.size.width }
        set {
            var rect = frame
            rect.origin.x = newValue - frame.size.width
            frame = rect
        }
    }
    
    @objc var td_bottom:CGFloat {
        get { frame.origin.y + frame.size.height }
        set {
            var rect = frame
            rect.origin.y = newValue - frame.size.height
            frame = rect
        }
    }
    
    @objc var td_centerX: CGFloat {
        get { frame.center.x }
        set {
            self.center = CGPoint(x: newValue, y: td_centerY)
        }
    }
    
    @objc var td_centerY: CGFloat {
        get { frame.center.y }
        set {
            self.center = CGPoint(x: td_centerX, y: newValue)
        }
    }
    
    @objc var td_width: CGFloat {
        get { frame.size.width }
        set {
            var rect = frame
            rect.size.width = newValue
            frame = rect
        }
    }
    
    @objc var td_height: CGFloat {
        get { frame.size.height }
        set {
            var rect = frame
            rect.size.height = newValue
            frame = rect
        }
    }
    
    @objc var td_backgroundImage: UIImage? {
        get { td.backgroundImage }
        set { td.backgroundImage = newValue }
    }
}

fileprivate var backgroundImageKey: Void?
public extension TDBasisWrap where Base: UIView {
    
    var cornerRadius: CGFloat {
        get {
            base.layer.cornerRadius
        }
        set {
            base.layer.cornerRadius = newValue
            base.layer.masksToBounds = true
        }
    }
    
    var backgroundImage: UIImage? {
        get{
            return objc_getAssociatedObject(base, &backgroundImageKey) as? UIImage
        }
        set{
            if backgroundImage == nil && backgroundImage == newValue {
                return
            }
            let bgLayer = CALayer()
            bgLayer.contents = newValue?.cgImage
            bgLayer.frame = base.bounds
            base.layer.insertSublayer(bgLayer, at: 0)
            
            objc_setAssociatedObject(base, &backgroundImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Shake directions of a view.
    ///
    /// - horizontal: Shake left and right.
    /// - vertical: Shake up and down.
    enum ShakeDirection {
        /// Shake left and right.
        case horizontal

        /// Shake up and down.
        case vertical
    }

    /// Angle units.
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    enum AngleUnit {
        /// degrees.
        case degrees

        /// radians.
        case radians
    }

    /// Shake animations types.
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation.
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    enum ShakeAnimationType {
        /// linear animation.
        case linear

        /// easeIn animation.
        case easeIn

        /// easeOut animation.
        case easeOut

        /// easeInOut animation.
        case easeInOut
    }
    
    /// Remove all subviews in view.
    func removeSubviews() {
        base.subviews.forEach({ $0.removeFromSuperview() })
    }

    /// Remove all gesture recognizers from view.
    func removeGestureRecognizers() {
        base.gestureRecognizers?.forEach(base.removeGestureRecognizer)
    }
    
    /// Recursively find the first responder.
    func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: base)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    
    @discardableResult
    /// 添加虚线分割线
    /// - Parameters:
    ///   - rect: 虚线分割线的rect
    ///   - lineColor: 分割线颜色 默认为  `lightGray`
    ///   - lineWidth: 分割线线宽 默认为 0.5
    ///   - spacing: 分割线 space 默认为 3
    ///   - isVertical: 是否为竖线
    func addDashLine(in rect: CGRect, lineColor: UIColor? = nil, lineWidth: CGFloat = 0.5, spacing: CGFloat = 3, isVertical: Bool = false) -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = rect
        shapeLayer.position = rect.center
        shapeLayer.strokeColor = (lineColor == nil) ? UIColor.lightGray.cgColor : lineColor!.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [NSNumber(value: 4), NSNumber(value: Double(spacing))]
        let path = CGMutablePath()
        
        path.move(to: rect.origin)
        if isVertical {
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        } else {
            path.addLine(to: CGPoint(x: rect.width, y: rect.maxY))
        }
        
        shapeLayer.path = path
        base.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
//    func corner(clipRect rect: CGRect, corner: UIRectCorner = .allCorners, cornerRadius: CGFloat = 0, borderColor: UIColor = .clear, borderWidth: CGFloat = 0, lineDashPattern: [NSNumber] = []) {
//
//            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
//
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = path.cgPath
//            layer.mask = maskLayer
//
//            let borderLayer = CAShapeLayer()
//            borderLayer.path = path.cgPath
//            borderLayer.lineWidth = borderWidth * 2
//            borderLayer.fillColor = UIColor.clear.cgColor
//            borderLayer.strokeColor = borderColor.cgColor
//            borderLayer.lineDashPattern = lineDashPattern
//            layer.addSublayer(borderLayer)
//    }


    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    ///   - isAddBorder: should add border to corners
    ///   - borderColor: if Add border this will be used
    ///   - borderWidth: if add border will use this to set to lineWidth
    func addRoundCorners(_ corners: UIRectCorner,
                         radius: CGFloat,
                         isAddBorder: Bool = false,
                         borderColor: UIColor? = nil,
                         borderWidth: CGFloat = 0.5,
                         lineDashPattern: [Double]? = nil,
                         userMask: Bool = false) {
        
        let maskPath = UIBezierPath(
            roundedRect: base.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        if userMask {
            if #available(iOS 11.0, *) {
                base.layer.cornerRadius = radius
                base.layer.maskedCorners = corners.cornerMask
                base.layer.masksToBounds = true
            } else {
                base.layer.mask = shape
            }
        } else {
            base.layer.mask = shape
        }
        if isAddBorder, let borderColor = borderColor {
            base.layer.sublayers?.forEach({ layer in
                if layer.name == "com.corner.borderLayer" {
                    layer.removeFromSuperlayer()
                }
            })
            let borderLayer = CAShapeLayer()
            borderLayer.name = "com.corner.borderLayer"
            borderLayer.path = shape.path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.lineWidth = borderWidth
            if let lineDashPattern = lineDashPattern {
                borderLayer.lineDashPattern = lineDashPattern.map { NSNumber(value: $0) }
                borderLayer.lineDashPhase = 2
            }
            borderLayer.frame = base.bounds
            base.layer.addSublayer(borderLayer)
        }
    }
    
    func removeRoundCorneres(){
        if #available(iOS 11.0, *) {
            base.layer.cornerRadius = 0
        }
        base.layer.mask = nil
        base.layer.sublayers?.forEach({ layer in
            if layer.name == "com.corner.borderLayer" {
                layer.removeFromSuperlayer()
            }
        })
    }
    
    /// Add shadow to view.
    /// 此方式添加的阴影如果 收 `clipsToBounds` 和 `layer.masksToBounds`两个属性影响
    /// 当 `clipsToBounds = true`  或者 `layer.masksToBounds = true` 时 阴影将不生效
    ///  如果需要同时添加阴影和圆角 可使用 `td.addShadowView(...)`方法
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowRadius = radius
        base.layer.shadowOpacity = opacity
        base.layer.masksToBounds = false
        
    }
    
    /// 添加阴影视图  将视图添加到当前视图的父控件上 这种方式添加的阴影不收圆角的影响
    /// 隐藏当前视图的时候 需要手动调用 `removeShadowView(tag)`方法将阴影从父控件中移除
    /// 此方法添加的阴影需要再当前视图已经确认了`frame` 最好放到`layoutSubviews`中调用
    func addShadowView(color: UIColor, offset: CGSize, opacity: CGFloat, radius: CGFloat, tag: Int) {
        //Remove previous shadow views
        base.superview?.viewWithTag(tag)?.removeFromSuperview()

        //Create new shadow view with frame
        let shadowView = UIView(frame: base.frame)
        shadowView.tag = tag
        shadowView.layer.shadowColor = color.cgColor
        shadowView.layer.shadowOffset = offset
        shadowView.layer.masksToBounds = false

        shadowView.layer.shadowOpacity = Float(opacity)
        shadowView.layer.shadowRadius = radius
        shadowView.layer.shadowPath = UIBezierPath(rect: base.bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true

        base.superview?.insertSubview(shadowView, belowSubview: base)
    }
    
    func removeShadowView(_ tag: Int){
        base.superview?.viewWithTag(tag)?.removeFromSuperview()
    }
    
    /// Rotate view by angle on relative axis.
    ///   `type` use default as `AngleUnit.radians`, you should make `angle` to `.pi` or  `.pi / 2` or `.pi * 2`...
    ///   while you want to use degrees value for angle, set the parameter `type` to `AngleUnit.degrees`. then you can use like `180` or `90` for angle
    /// - Parameters:
    ///   - angle: angle to rotate view by. radians value eg:` .pi 、.pi / 2、.pi * 2`
    ///   - type: type of the rotation angle. default is radians
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(byAngle angle: CGFloat, ofType type: AngleUnit = .radians, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            base.transform = base.transform.rotated(by: angleWithType)
        }, completion: completion)
    }

    /// Rotate view to angle on fixed axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view to. radians value eg: .pi 、.pi / 2、.pi * 2
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(toAngle angle: CGFloat, ofType type: AngleUnit = .radians, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            base.transform = base.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }

    /// Scale view by offset.
    ///
    /// - Parameters:
    ///   - offset: scale offset
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                base.transform = base.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            base.transform = base.transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }

    /// Shake view.
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        base.layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    /// View 截图 返回一张图片
    var snapshot: UIImage? {
        base.td_snapshot
    }
    
    
    /// 给View添加手势 通过block回调
    /// - Parameter tapRecognize: block 手势回调
    func addTap(_ tapRecognize: ((_ tap: Any)->Void)?) {
        let tapGes = UITapGestureRecognizer { (sender) in
            tapRecognize?(sender)
        }
        base.isUserInteractionEnabled = true
        base.addGestureRecognizer(tapGes)
    }
    
    /// 批量添加子控件
    /// eg: `view.addSubviews(view1, view2, view3)`
    func addSubviews(_ views: UIView...) {
        views.forEach { base.addSubview($0) }
    }
    
    /// 批量添加子控件 传入数字
    /// eg: `view.addSubviews([view1, view2, view3])`
    func addSubviews(_ views: [UIView]) {
        views.forEach { base.addSubview($0) }
    }
    
    /// view's origin
    var origin:CGPoint {
        get { base.td_origin }
        set { base.td_origin = newValue }
     }
    
    /// view's size
    var size:CGSize {
        get { base.td_size }
        set { base.td_size = newValue }
    }
    
    /// view's left / minX / origin.x
    var left:CGFloat {
        get { base.td_left }
        set { base.td_left = newValue }
    }
    
    /// view's top/minY/y
    var top:CGFloat {
        get { base.td_top }
        set { base.td_top = newValue }
    }
    
    /// view's right/maxX/x+width
    var right:CGFloat {
        get { base.td_right }
        set { base.td_right = newValue }
    }
    
    /// view's bottom/maxY/y+height
    var bottom:CGFloat {
        get { base.td_bottom }
        set { base.td_bottom = newValue }
    }
    
    /// view's centerX/midX/x + halfWidth
    var centerX: CGFloat {
        get { base.td_centerX }
        set { base.td_centerX = newValue }
    }
    
    /// view's centerY/midY/y+halfHeight
    var centerY: CGFloat {
        get { base.td_centerY }
        set { base.td_centerY = newValue }
    }
    
    /// view's width size.width
    var width: CGFloat {
        get { base.td_width }
        set { base.td_width = newValue }
    }
    
    /// view's height  size.height
    var height: CGFloat {
        get { base.td_height }
        set { base.td_height = newValue }
    }
}

extension UIRectCorner {
    var cornerMask: CACornerMask {
        var cornersMask = CACornerMask()
        if self.contains(.topLeft) {
            cornersMask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            cornersMask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            cornersMask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            cornersMask.insert(.layerMaxXMaxYCorner)
        }
        return cornersMask
    }
}
