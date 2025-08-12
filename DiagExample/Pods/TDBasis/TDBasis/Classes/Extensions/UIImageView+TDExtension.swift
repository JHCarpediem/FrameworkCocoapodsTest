//
//  UIImageView+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

extension UIImageView: TDCompatible {}
public extension TDBasisWrap where Base: UIImageView {
    /// SwifterSwift: Make image view blurry
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = base.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        base.addSubview(blurEffectView)
        base.clipsToBounds = true
    }

    /// SwifterSwift: Blurred version of an image view
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    /// - Returns: blurred version of self.
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = base
        imgView.td.blur(withStyle: style)
        return imgView
    }
}

extension UIImageView {
    @objc public func td_blur(withStyle style: UIBlurEffect.Style = .light) {
        self.td.blur(withStyle: style)
    }
    
    @objc public func td_blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        return self.td.blurred(withStyle: style)
    }
}
