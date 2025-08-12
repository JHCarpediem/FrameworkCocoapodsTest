//
//  DispatchQueue+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

extension DispatchQueue: TDCompatible {}
extension TDBasisWrap where Base: DispatchQueue {

    /// 延迟调用
    /// - Parameters:
    ///   - seconds: 延迟时间  单位秒 s
    ///   - completion: 延迟任务
    public func after(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        base.asyncAfter(deadline: popTime) {
            completion()
        }
    }
}

extension DispatchQueue {
    private static var _onceTracker = [String]()
    
    /// 单例 只执行一次
    /// - Parameters:
    ///   - token: token
    ///   - block: 任务
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
