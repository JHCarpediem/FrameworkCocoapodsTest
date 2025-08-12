//
//  String+Sandbox.swift
//  Pods-TopdonLog_Example
//
//  Created by xinwenliu on 2024/6/25.
//

import Foundation

extension String {
    
    /// eg. /Documents/log/log/xxx.log ==> /log/log/xxx.log
    /// for save to db
    var removeDocumentsPath: String {
        let components = (self as NSString).components(separatedBy: "Documents")
        guard components.count == 2 else {
            return self
        }
        return components[1]
    }
    
    /// eg.  /Documents/log/log/xxx.log <== /log/log/xxx.log
    /// for query
    var addDocumentsPath: String {
        guard !self.contains("Documents") else {
            return self
        }
        
        return AppFile.documentPath + self
    }
    
    /// 启动沙河路径变化
    var fixLogPath: String {
        let removeOld = self.removeDocumentsPath
        return removeOld.addDocumentsPath
    }
    
}

// MARK: - IOSLOG -- iOSLog
extension String {
    
//    var fixupiOSLog: String {
//        if uppercased() == "iOSLog".uppercased() {
//            return "iOSLog"
//        }
//        return self
//    }
    
}
