//
//  BaseLog.swift
//  CocoaLumberjack
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation
import SSZipArchive

class BaseLog {
    
    /// 日志写入原始路径
    private(set) var logDir: String
    
    var collectionLogDir: String
    
    /// CarLog 为进车时间、其余为APP启动时间
    var launchTime: String
    
    var car: Car?
    
    var vciInfo: VCIInfo?
    
    lazy var appInfo: AppInfo = .init()
    
    init(logDir: String, launchTime: String) {
        self.logDir = logDir
        self.collectionLogDir = logDir
        self.launchTime = launchTime
    }
    
    /// 收集需要上传的日志
    func collectionLogs(limitCount: Int = 5) -> [String] {
        var logFiles = AppFile.flatFiles(atPath: collectionLogDir)
        logFiles = AppFile.sortFiles(logFiles)
        
        var cLogFiles: [String] = []
        
        for logFile in logFiles where logFile.contains(launchTime) {
            guard cLogFiles.count < limitCount else {
                break
            }
            cLogFiles.append(logFile)
        }
        
        if cLogFiles.isEmpty {
            for logFile in logFiles {
                guard cLogFiles.count < limitCount else {
                    break
                }
                cLogFiles.append(logFile)
            }
        }
        
        return cLogFiles
    }
    
    /// 自动收集上报, 不判断 launchTime字段（launchTime or enterCarTime）
    func autoCollectionLogs(limitCount: Int = 5) -> [String] {
        var logFiles = AppFile.flatFiles(atPath: collectionLogDir)
        logFiles = AppFile.sortFiles(logFiles)
        
        var cLogFiles: [String] = []
        for logFile in logFiles  {
            guard cLogFiles.count < limitCount else {
                break
            }
            // 获取最多5个(进车时间)日志
            
            cLogFiles.append(logFile)
        }
        
        return cLogFiles
    }
    
}
