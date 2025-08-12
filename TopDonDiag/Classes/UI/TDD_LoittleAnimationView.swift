//
//  TDLoittleAnimationView.swift
//  AD200
//
//  Created by yong liu on 2023/12/1.
//

import UIKit
import Lottie

@objc public class TDD_LoittleAnimationView: UIView {

    var animationView: LottieAnimationView?
    
    @objc public func playAnimation(name: String) {
        
        animationView?.removeFromSuperview()
        animationView = LottieAnimationView.init(name: name)
//        animationView?.contentMode = .scaleAspectFill
//        animationView?.loopMode = .loop
        addSubview(animationView!)
        
        animationView?.mas_makeConstraints({ make in
            make?.edges.equalTo()(self)
        })
        animationView?.play(toProgress: 1, loopMode: .loop)
    }
    
    
    /// 播放带图片的动画
    /// - Parameters:
    ///   - name: bundle名称
    ///   - animationName: 动画名称
    ///   - images: 图片文件夹名称
    @objc public func playBundleAnimation(name: String, animationName: String, images: String = "images") {

        animationView?.removeFromSuperview()
        let bundle = Bundle(for: TDD_ArtiMenuModel.self)
        animationView = LottieAnimationView(name: animationName, bundle: bundle, imageProvider: BundleImageProvider(bundle: bundle, searchPath: images))
//            animationView?.contentMode = .scaleAspectFill
        addSubview(animationView!)
        animationView?.mas_makeConstraints({ make in
            make?.edges.equalTo()(self)
        })
        animationView?.play(toProgress: 1, loopMode: .loop)

    }
    
    @objc public func stopAnimation() {
        animationView?.stop()
        
    }
    
    @objc public func playAnimation() {
        if animationView?.superview != nil {
            animationView?.play()
        }
        
        
    }

}
