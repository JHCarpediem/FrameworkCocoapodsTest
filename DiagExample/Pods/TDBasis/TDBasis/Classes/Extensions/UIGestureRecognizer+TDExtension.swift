//
//  UIGestureRecognizer+TDExtension.swift
//  TDBasis
//
//  Created by fench on 2023/7/24.
//

import UIKit


fileprivate var TapGestureKey: Void?
public typealias ActionBlock = (Any) -> Void

@objc fileprivate class TDUIGestureRecognizerBlockTarget: NSObject {
    
    fileprivate var actionBlock: ActionBlock?
    fileprivate convenience init(block: ActionBlock?) {
        self.init()
        
        self.actionBlock = block
    }
    
    @objc func invoke(_ sender: Any) {
        actionBlock?(sender)
    }
}

@objc public extension UIGestureRecognizer {
    
    
    @objc public convenience init(actionBlock block: ActionBlock?) {
        self.init()
        self.add(actionBlock: block)
        
    }
    
    @objc public func add(actionBlock block: ActionBlock?) {
        let target = TDUIGestureRecognizerBlockTarget(block: block)
        self.addTarget(target, action: #selector(TDUIGestureRecognizerBlockTarget.invoke(_:)))
        _allUIGestureRecognizerBlockTargets.append(target)
    }
    
    @objc public func removeAllActions(){
        _allUIGestureRecognizerBlockTargets.map { [weak self] in
            guard let self = self else { return }
            self.removeTarget($0, action: #selector(TDUIGestureRecognizerBlockTarget.invoke(_:)))
        }
        _allUIGestureRecognizerBlockTargets.removeAll()
    }
    
    private var _allUIGestureRecognizerBlockTargets: [TDUIGestureRecognizerBlockTarget] {
        get {
            guard let res = objc_getAssociatedObject(self, &TapGestureKey) as? [TDUIGestureRecognizerBlockTarget] else {
                let resulet: [TDUIGestureRecognizerBlockTarget] = []
                objc_setAssociatedObject(self, &TapGestureKey, resulet, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return resulet
            }
            
            return res
        }
        set {
            objc_setAssociatedObject(self, &TapGestureKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
