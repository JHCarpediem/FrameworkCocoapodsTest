//
//  TDScrollButton.swift
//  LMSUI
//
//  Created by fench on 2023/7/19.
//

import Foundation
import TDBasis

@objc
public enum TDScrollDirection: Int {
    case left, right, comeAndBack
}

@objc
public class TDScrollButton: UIButton {
    /// 内边距
    @objc public var margin: CGFloat = 10
    /// 滚动方向 默认 left
    @objc public var scrollDirection: TDScrollDirection = .left {
        didSet {
            removeLink()
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    /// 速度 0.2 * speed
    @objc public var speed: CGFloat = 1 {
        didSet {
            speedPoint = 0.2 * speed
        }
    }
    
    var isDotBadge: Bool = false
    
    @objc public var dotSize: CGFloat = 8
    
    @objc open func showDotBadge(){
        if let dotView = self.dotView {
            dotView.isHidden = false
        }
        let dotView = UIView()
        dotView.backgroundColor = UIColor.red
        dotView.layer.cornerRadius = dotSize / 2
        dotView.tag = 1789
        self.addSubview(dotView)
        self.dotView = dotView
        isDotBadge = true
        setNeedsLayout()
    }
    
    @objc public var badge: String? {
        didSet {
            guard let value = badge else {
                clearBadge()
                return
            }
            if badge == "0" {
                clearBadge()
                return
            }
            self.subviews.forEach {
                if $0.tag == 99999 && $0 is UILabel {
                    $0.removeFromSuperview()
                }
            }
            let label = UILabel(text: value, textColor: badgeTitleColor, font: badgeFont)
            label.tag = 99999
            label.textAlignment = .center
            addSubview(label)
            self.badgeLabel = label
            isDotBadge = false
            updateBadge()
        }
    }
    /// 设置badge的字体颜色
    @objc open var badgeTitleColor: UIColor = .white {
        didSet {
            updateBadge()
        }
    }
    
    var defaultBadgeColor: UIColor {
        .td.error
    }
    
    /// 设置badge的背景颜色
    @objc open lazy var badgeColor: UIColor = defaultBadgeColor {
        didSet {
            updateBadge()
        }
    }
    /// 设置badge的字体
    @objc open var badgeFont: UIFont = .systemFont(ofSize: 9){
        didSet {
            updateBadge()
        }
    }
    /// 设置badge的位置 相对于图标右上角的偏移量
    @objc open var badgeOffset: CGPoint = CGPoint.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    open var isNeedScroll: Bool = true
    
    @objc open var badgeBorderColor: UIColor = UIColor.red
    
    open private(set) var badgeLabel: UILabel?
    open private(set) var dotView: UIView?
    /// 更新badge
    open func updateBadge(){
        self.badgeLabel?.isHidden = self.badge == nil
        badgeLabel?.text = badge
        badgeLabel?.textColor = badgeTitleColor
        badgeLabel?.font = badgeFont
        badgeLabel?.backgroundColor = badgeColor
        badgeLabel?.layer.borderWidth = 1
        badgeLabel?.layer.borderColor = badgeBorderColor.cgColor
    }
    
    /// 清空badge  将 属性 badge = nil 可以达到同样的目的
    open func clearBadge(){
        badgeLabel?.text = nil
        badgeLabel?.isHidden = true
        badgeLabel?.removeFromSuperview()
        badgeLabel = nil
        
        dotView?.isHidden = true
        dotView?.removeFromSuperview()
        dotView = nil
        
        let view = viewWithTag(1789)
        view?.removeFromSuperview()
    }
    
    private var isLeft: Bool = false
    private var displayLink: CADisplayLink?
    private var speedPoint: CGFloat = 0.2
    private var currentX: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if isNeedScroll {
            guard let titleLabel = self.titleLabel else { return }
            titleLabel.sizeToFit()
            if (self.titleLabel?.td.width ?? 0) > td.width - titleEdgeInsets.left {
                layer.masksToBounds = true
                self.titleLabel?.td.left = currentX
                
                if displayLink == nil {
                    displayLink = CADisplayLink(target: self, selector: #selector(displayLink(_:)))
                    displayLink?.add(to: .current, forMode: .default)
                }
            }
            
        }
        
        updateBadgeFrame()
    }
    
    func updateBadgeFrame(){
        var badgeCenter: CGPoint = CGPoint(x: td.width, y: 0)
        if let label = self.titleLabel {
            badgeCenter = CGPoint(x: label.td.right, y: label.td.top)
        }
        if let imageView = self.imageView {
            badgeCenter = CGPoint(x: imageView.td.right, y: imageView.td.top)
        }
        
        self.dotView?.td.size = CGSize(width: dotSize, height: dotSize)
        self.dotView?.center = CGPoint(x: badgeCenter.x + badgeOffset.x, y: badgeCenter.y + badgeOffset.y)
        
        if isDotBadge {
            return
        }
        
        guard let badgeValue = badge, let _ = badgeLabel else {
            return
        }
        
        let bHeight = ceil(Double(badgeValue.size(with: badgeFont).height)) + 4
        let btnWidth = badgeValue.size(with: badgeFont).width + 4
        let bWidth = max(btnWidth, CGFloat(bHeight))
        badgeLabel?.td.size = CGSize(width: bWidth, height: bWidth)
        badgeLabel?.center = CGPoint(x: badgeCenter.x + badgeOffset.x, y: badgeCenter.y + badgeOffset.y)
        let radius = badgeLabel!.td.size.height * 0.5
        
        badgeLabel?.layer.cornerRadius = radius
        badgeLabel?.layer.masksToBounds = true
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        removeLink()
        super.setTitle(title, for: state)
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    deinit {
        removeLink()
    }
}

extension TDScrollButton {
    @objc func displayLink(_ link: CADisplayLink) {
        guard let _ = titleLabel else { return }
        
        let isLongerThanBoundsWidth = td.width - titleLabel!.td.width - margin > titleLabel!.td.left
        switch scrollDirection {
        case .comeAndBack:
            if isLongerThanBoundsWidth {
                isLeft = false
            }
            if titleLabel!.td.left >= margin {
                isLeft = true
            }
            currentX = isLeft ? currentX - speedPoint : currentX + speedPoint
        case .left:
            currentX = isLongerThanBoundsWidth ? margin : currentX - speedPoint
        case .right:
            currentX = margin == titleLabel!.td.left ? td.width - titleLabel!.td.width - margin : currentX - speedPoint
        }
        
        titleLabel?.td.left = currentX
        
    }
    
    public func removeLink(){
        displayLink?.invalidate()
        displayLink = nil
    }
}
