//
//  UIView+ex.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/10.
//

import Foundation
import TDTheme
import TDBasis
import SnapKit

extension UIView {
    public enum LMSLinePosition: Int {
        case top, left, bottom, right
    }
}

extension TDBasisWrap where Base: UIView {
    @discardableResult
    public func addLine(to position: UIView.LMSLinePosition = .bottom, lineWidth: CGFloat = 1 / UIScreen.main.scale, color: UIColor? = nil, edgeInset: UIEdgeInsets = .zero, tag: Int = 99999) -> UIView {
        let line = UIView()
        line.isOpaque = false
        line.tag = tag
        if let lineColor = color {
            line.backgroundColor = lineColor
        } else {
            line.theme.backgroundColor = .theme.line
        }
        base.insertSubview(line, at: 0)
        
        line.snp.makeConstraints {
            switch position {
            case .bottom, .top:
                $0.height.equalTo(lineWidth)
                $0.left.equalToSuperview().offset(edgeInset.left)
                $0.right.equalToSuperview().offset(-edgeInset.right)
                 _ = position == .top ? $0.top.equalToSuperview() : $0.bottom.equalToSuperview()
            case .left, .right:
                $0.width.equalTo(lineWidth)
                $0.top.equalToSuperview().offset(edgeInset.top)
                $0.bottom.equalToSuperview().offset(-edgeInset.bottom)
                _ = position == .left ? $0.left.equalToSuperview() : $0.right.equalToSuperview()
            }
        }
        return line
    }
}

@objc public extension UIFont {
    /// 适配平板字体 相对手机缩放比为 1.5
    @objc public var adaptHD: UIFont {
        adaptHD(scale: 1.5)
    }
    
    /// 适配平板 传入平板相对手机的字体大小缩放比
    @objc public func adaptHD(scale: CGFloat) -> UIFont {
        if UIProvider.isHD {
            let adapt = UI.HD.verticalScale * scale
            return self.withSize(pointSize * adapt)
        }
        return self
    }
    
    /// 适配平板 传入平板的字体大小
    @objc public func adaptHD(size: CGFloat) -> UIFont {
        if UIProvider.isHD {
            return self.withSize(size)
        }
        return self
    }
}

extension BinaryInteger {
    public var adaptHD: CGFloat { adaptHD(for: 1.5) }
    
    public func adaptHD<Point: BinaryFloatingPoint>(for scale: Point) -> Point {
        if UIProvider.isHD {
            return scale * Point(self)
        }
        return Point(self)
    }
    
    public func adaptHD<Point: BinaryFloatingPoint>(for scale: Point) -> Self {
        if UIProvider.isHD {
            return Self(scale * Point(self))
        }
        return self
    }
    
    public func adaptHD<Point: BinaryInteger>(for scale: Point) -> Point {
        if UIProvider.isHD {
            return scale * Point(self)
        }
        return Point(self)
    }
    
    public func adaptHD<Element: BinaryInteger>(to value: Element) -> Element {
        if UIProvider.isHD {
            return value
        }
        
        return Element(self)
    }
    
    public func adapthHD<Element: BinaryFloatingPoint>(to value: Element) -> Element {
        if UIProvider.isHD {
            return value
        }
        return Element(self)
    }
}

extension BinaryFloatingPoint {
    public var adaptHD: Self { adaptHD(for: 1.5) }
    
    public func adaptHD(for scale: Self = 1.5) -> Self {
        if UIProvider.isHD {
            return scale * self
        }
        return self
    }
    
    public func adaptHD(to value: Self) -> Self {
        if UIProvider.isHD {
            return value
        }
        return self
    }
}
