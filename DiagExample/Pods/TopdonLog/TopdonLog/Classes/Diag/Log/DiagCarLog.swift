//
//  DiagCarLog.swift
//  CocoaLumberjack
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

/// 诊断库车型日志
/// Documents/TD/AD200/DataLog, 其中TD/AD200是变量
final class DiagCarLog: BaseLog {
    
    /// 自动收集的时候用到
    override func collectionLogs(limitCount: Int = Int.max) -> [String] {
        
        collectionLogDir = logDir
        
        return super.autoCollectionLogs(limitCount: limitCount)
        
    }
    
}
