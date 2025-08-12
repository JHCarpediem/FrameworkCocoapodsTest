//
//  UIViewController+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

extension TDBasisWrap where Base: UIViewController {
    
    /// 将当前控制器从 导航栏控制器的控制器栈中移除
    public func removeFromNavigationStack(){
        DispatchQueue.main.td.after(0.5) {
            guard let vcs = base.navigationController?.viewControllers else { return }
            base.navigationController?.viewControllers = vcs.filter { $0 != base }
        }
    }
}

@objc public extension UIViewController {
    
}

// 方法交换 交换 prefersStatusBarHidden
extension UIViewController: SwiftAwakeProtocol {
    
    public static func awake() {
        swizzleMethod
    }
    
    private static let swizzleMethod: Void = {
        let originalSelector = #selector(getter: prefersStatusBarHidden)
        let swizzleSelector = #selector(getter: swizz_prefersStatusBarHidden)
        
        swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzleSelector)
    }()
    
    
    @objc dynamic var swizz_prefersStatusBarHidden: Bool {
        if UI.STATUSBAR_HEIGHT == 0 {
            return false
        }
        return swizz_prefersStatusBarHidden
    }
}
