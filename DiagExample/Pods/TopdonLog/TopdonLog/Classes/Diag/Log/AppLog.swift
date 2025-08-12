//
//  AppLog.swift
//  CocoaLumberjack
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

/// Documents/log/log
final class AppLog: BaseLog {

    override init(logDir: String, launchTime: String) {
        super.init(logDir: logDir, launchTime: logDir)
        
        self.collectionLogDir = "\(logDir)/Log"
    }
    
    /// 最多50条, 按时间倒序，不包含当前正在写的那条
    func collectionAppLaunchLogs(limitCount: Int = 50, asc: Bool = false) -> [String] {
        var logFiles = AppFile.flatFiles(atPath: collectionLogDir)
        logFiles = AppFile.sortFiles(logFiles, asc: asc)
        
        // 当前在打印的那条不需要操作
        if !logFiles.isEmpty {
            logFiles.removeFirst()
        }
        
        var cLogFiles: [String] = []
        
        for logFile in logFiles {
            guard cLogFiles.count < limitCount else {
                break
            }
            cLogFiles.append(logFile)
        }
        
        return cLogFiles
    }
    
}
