//
//  UIScrollView+TDExtension.swift
//  TDBasis
//
//  Created by Fench on 2024/6/28.
//

import UIKit


fileprivate var AllwaysShowverticalScrollIndicatorKey: Void?
fileprivate var VerticalIndicatorViewKey: Void?
@objc public extension UIScrollView {
    
    /// 竖直滚动条一直显示
    @objc public var allwaysShowVerticalScrollIndicator: Bool {
        get {
            guard let res = objc_getAssociatedObject(self, &AllwaysShowverticalScrollIndicatorKey) as? Bool else {
                objc_setAssociatedObject(self, &AllwaysShowverticalScrollIndicatorKey, false, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return false
            }
            return res
        }
        set {
            objc_setAssociatedObject(self, &AllwaysShowverticalScrollIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue {
                showsVerticalScrollIndicator = false
            }
            showVerticalIndicator(newValue)
        }
    }
    
    @objc public var verticalIndicatorView: UIView? {
        get{
            return objc_getAssociatedObject(self, &VerticalIndicatorViewKey) as? UIView
        }
        set{
            objc_setAssociatedObject(self, &VerticalIndicatorViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func showVerticalIndicator(_ show: Bool) {
        func setupIndicator() {
            if verticalIndicatorView == nil {
                verticalIndicatorView = UIView()
                verticalIndicatorView?.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
                verticalIndicatorView?.layer.cornerRadius = 1.5
                self.addSubview(verticalIndicatorView!)
                self.bringSubviewToFront(verticalIndicatorView!)
            } else {
                verticalIndicatorView?.isHidden = false
            }
            updateVerticalIndicatorFrame()
        }
        if show {
            setupIndicator()
        } else {
            verticalIndicatorView?.removeFromSuperview()
            verticalIndicatorView = nil
        }
    }
    
    private func updateVerticalIndicatorFrame() {
        guard let verticalIndicatorView = verticalIndicatorView, allwaysShowVerticalScrollIndicator else { return }
        self.bringSubviewToFront(verticalIndicatorView)
        
        let contentHeight = contentSize.height
        let visibleHeight = bounds.height
        let cOffsetY = contentOffset.y
        var iHeight = visibleHeight / contentHeight * visibleHeight     // 初始的滚动条的高度
        let yOffset = contentOffset.y / contentHeight * visibleHeight   // 初始的滚动条的 Y 轴偏移量
        
        // 当初始滚动条高度比 bounds.height 小 （需要滑动，contentSize > bounds.height）显示滚动条
        if iHeight < visibleHeight {
            let minHeight = min(15, visibleHeight)
            iHeight = iHeight.td.clamped(to: minHeight...visibleHeight)
            var cHeight = iHeight
            var cY = contentOffset.y + yOffset
            
            // 当偏移量小于 0 （滑倒最上面 继续往上滑）滚动条等比缩短
            if contentOffset.y < 0 {
                cHeight -= (abs(cY - cOffsetY))
                cY = contentOffset.y
            } else if yOffset + cHeight > visibleHeight { // 当滑动到最下面 滚动条等比 缩短
                let delta = contentSize.height - (cOffsetY + visibleHeight)
                cHeight -= abs(delta * iHeight / visibleHeight)
            }
            verticalIndicatorView.frame = CGRect(x: bounds.width - 7, y: cY, width: 3, height: cHeight)
            self.verticalIndicatorView?.isHidden = false
        } else {
            verticalIndicatorView.isHidden = true
        }
    }
}

extension UIScrollView: SwiftAwakeProtocol {
    public static func awake() {
        swizzleMethod
    }
    
    private static let swizzleMethod: Void = {
        let originalContentSize = #selector(setter: contentSize)
        let swizzleContentSize = #selector(setter: swizz_contentSize)
        
        let originalContentOffset = #selector(setter: contentOffset)
        let swizzleContentOffset = #selector(setter: swizz_contentOffset)
        
        let originFrame = #selector(setter: frame)
        let swizzFrame = #selector(setter: swizz_frame)
        
        #if DEBUG
        print("scrollView - 方法交换")
        #endif
        swizzlingForClass(UIScrollView.self, originalSelector: originalContentSize, swizzledSelector: swizzleContentSize)
        swizzlingForClass(UIScrollView.self, originalSelector: originalContentOffset, swizzledSelector: swizzleContentOffset)
        swizzlingForClass(UIScrollView.self, originalSelector: originFrame, swizzledSelector: swizzFrame)
    }()
    
    
    @objc dynamic var swizz_contentSize: CGSize {
        get { contentSize }
        set {
            swizz_contentSize = newValue
            updateVerticalIndicatorFrame()
        }
    }
    
    @objc dynamic var swizz_contentOffset: CGPoint {
        get { contentOffset }
        set {
            swizz_contentOffset = newValue
            updateVerticalIndicatorFrame()
        }
    }
    
    @objc dynamic var swizz_frame: CGRect {
        get { frame }
        set {
            swizz_frame = newValue
            updateVerticalIndicatorFrame()
        }
    }
}
