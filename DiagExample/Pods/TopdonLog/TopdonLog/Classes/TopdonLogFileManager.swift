//
//  TopdonLogFileManager.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/28.
//

import Foundation
import SwiftyBeaver

final public class TopdonLogFileManager {
    
    static var kLogFileExtension: String = ".log"
    static var kLogSuffix: String = "App.log"
    static func rename(log: String, at index: Int64) -> String {
        if index <= 0 {
            return log
        } else {
            let suffix = "App_\(index)\(kLogFileExtension)" // eg: App_1.log
            return log.replacingOccurrences(of: kLogSuffix, with: suffix, options: .backwards)
        }
    }
    
    var onCreateLogFile: ((String)->Void)?
    /// oldName, newName
    var onRenameLogFile: ((String, String) ->Void)?
    
    var appName: String = ""
    
    var logsDirectory: String = ""
    /// Log / VM ..
    var subPath: String = ""
    
    /// 启动时间或者进车时间
    /// eg.2023.11.28 13_45_20
    var launchTime: String = ""
    
    var url: URL
    
    private(set) var launchDateFormatter: DateFormatter
    
    required init(logsDirectory: String,
                  subPath: String,
                  appName: String,
                  launchTime: String,
                  launchDateFormatter: DateFormatter, onCreateLogFile: ((String)->Void)?) {
        
        self.logsDirectory = logsDirectory
        self.subPath = subPath
        self.appName = appName
        self.launchTime = launchTime
        self.launchDateFormatter = launchDateFormatter
        self.onCreateLogFile = onCreateLogFile
        // CarPal_EOBD_20240807_114225_App.log  CarPal_EOBD_20240807_114225_App_1.log
        let newLogFileName = "\(appName)_\(subPath)_\(launchTime)_\(TopdonLogFileManager.kLogSuffix)"
        self.url = URL(fileURLWithPath: logsDirectory.ns.appendingPathComponent(newLogFileName))
    }
    
}
