//
//  TopdonLog.swift
//  LogTest
//
//  Created by xinwenliu on 2023/11/16.
//


import UIKit
import SwiftyBeaver


//@objc(TDTopdonLog)
@objc
public class TopdonLog: NSObject {
    
    static var configBuilder: (()-> [LogConfigurationBuildable])?
    
    static var onCreateLogFile: ((String)->Void)?
    
    /// oldName, newName
    static var onRenameLogFile: ((String, String) ->Void)?
    
    /// 日志格式，颜色-颜色重置-上下文-时间-函数-行号-消息体
    public static var logFormat: String = "$C$c$X [$Dyyyy-MM-dd HH:mm:ss.SSS$d] $F($l): $M"
    
    /// 重定向时，写日志开关
    @objc public static var writeLogEnable: Bool = true
    
    static var globalQueue: DispatchQueue = .init(label: "com.topdonlog.global")
    
    // MARK: - Monitor
    
    static var diskSpaceMonitor: DiskSpaceMonitor?
    static var hasAvailableSpace: Bool = true
    
    private(set) static var fileLogger: TopdonFileLogger?
    
    static var interceptor: OutputInterceptor?
    private static var isIntercepting: Bool = false
    /// 诊断
    public static var appInfo: AppInfo = .init()
    @objc public static var param: RedirectionParameters = .init(appName: appInfo.appName,
                                                                 subPath: "Log",
                                                                 launchTime: appInfo.launchTime,
                                                                 launchDateFormatter: appInfo.launchDateFormatter, logDirectDir: AppFile.documentPath.ns.appendingPathComponent("Log").ns.appendingPathComponent("Log"))
    
    private static var logsDirectory: String = ""
    /// maximumFileSize  5 * 1024 * 1024  // 5M = 5242880
    private static var maximumFileSize: UInt64 = 5 * 1024 * 1024
    
    /// 40 appLog and 40 carLog
    private static var maximumNumberOfLogFiles: UInt = 40
    
    /// 默认全部捕获
    private static var interceptorOptions: OutputInterceptorOptions = .all
    
    /// Crash 捕获
    private static var crashInstall: TDCrashInstallationFile?
    
    static var isCrashFilesGenerated: Bool = false
    
    // MARK: - Config
    
    /// 单一配置方法, 无需按下面顺序配置两个方法
    public static func config(logsDirectory: String = "",
                              maximumFileSize: UInt64 =  5 * 1024 * 1024,
                              maximumNumberOfLogFiles: UInt = 40,
                              interceptorOptions: OutputInterceptorOptions = .all,
                              @LogConfigurationBuilder _ configBuilder: @escaping ()-> [LogConfigurationBuildable]) {
        self.configBuilder = configBuilder
        self.configuration(logsDirectory: logsDirectory, maximumFileSize: maximumFileSize, maximumNumberOfLogFiles: maximumNumberOfLogFiles, interceptorOptions: interceptorOptions)
    }
    
    /// 首先，配置 configBuilder
    /// maximumFileSize  5 * 1024 * 1024  // 5M = 5242880
    /// maximumNumberOfLogFiles = 40
    public static func config(@LogConfigurationBuilder _ configBuilder: @escaping ()-> [LogConfigurationBuildable]) {
        self.configBuilder = configBuilder
        self.configuration(logsDirectory: "", maximumFileSize: 5 * 1024 * 1024, maximumNumberOfLogFiles: 40)
    }
    
    /// 然后，配置 自己
    /// logsDirectory default is Documents/Log/
    /// maximumFileSize  5 * 1024 * 1024  // 5M = 5242880
    /// maximumNumberOfLogFiles = 40
    public static func configuration(logsDirectory: String = "",
                                     maximumFileSize: UInt64 =  5 * 1024 * 1024,
                                     maximumNumberOfLogFiles: UInt = 40,
                                     interceptorOptions: OutputInterceptorOptions = .all) {
        
        self.maximumFileSize = maximumFileSize
        self.maximumNumberOfLogFiles = maximumNumberOfLogFiles
        self.interceptorOptions = interceptorOptions
        
        // 可用空间 500 M 限制
        self.diskSpaceMonitor = DiskSpaceMonitor(timeInterval: 5, threshold: 500 * 1000 * 1000, overflowBlock: { isOverflow in
            self.handleDiskSpace(isOverFlow: isOverflow)
        })
        
        /// call configBuiler
        if let configs = configBuilder?() {
            for config in configs {
                let _ = config.config(self)
            }
        }
        
        /// 0. 创建启动记录
        RecordManager.shared.migration()
        RecordManager.shared.initialLaunchRecord()
        
        if isDebuggerAttached() {
            /// 1. 控制台打印
            let console = ConsoleDestination()
            console.format = logFormat
            console.levelColor.verbose = "🟢"
            console.levelColor.debug   = "🟣"
            console.levelColor.info    = "🔵"
            console.levelColor.warning = "🟡"
            console.levelColor.error   = "🔴"
            console.minLevel = .verbose
            SwiftyBeaver.self.addDestination(console)
        }
        /// 2. 文件打印
        let directory: String
        if !logsDirectory.isEmpty {
            directory = logsDirectory
        } else {
            let tempDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let folderURL = tempDirectoryURL.appendingPathComponent("Log") // /Documents/Log/
            directory = folderURL.path
        }
        
        self.logsDirectory = directory
        
        /// appLog Dir /Documents/Log/Log
        createFileLogger(with: directory.ns.appendingPathComponent("Log"), param: param)
        
        /// Interceptor
        if !interceptorOptions.contains(.none)
            && interceptorOptions.contains(.all)
            && !isDebuggerAttached() {
            
            interceptor = OutputInterceptor()
            startCapturing()
            
        }
        
        /// Crash Install
        tdCrashInstall()
    }
    
    /// 更新 DeviceSN
    public static func update(device sn: String) {
        LogColletionManager.shared.deviceSN = sn
    }
    
}

// MARK: - Redirection

extension TopdonLog {
    
    @objc public static func buildParam(subPath: String = "Log", launchTime: String) -> RedirectionParameters {
        let fullPath = logsDirectory.ns.appendingPathComponent(subPath) //  Documents/Log/Log or Documents/Log/VW
        return RedirectionParameters(appName: appInfo.appName,
                                     subPath: subPath,
                                     launchTime: launchTime,
                                     launchDateFormatter: appInfo.launchDateFormatter,
                                     logDirectDir: fullPath)
    }
    
    /// Documents/Log/Log or Documents/Log/VW
    /// subPath: Log or like VW
    /// result logFile path is Documents/Log/Log/xxx.log or Documents/Log/VW/xxx.log
    @objc public static func redirectionTo(param: RedirectionParameters) {
        let fullPath = logsDirectory.ns.appendingPathComponent(param.subPath)
        self.redirection(to: fullPath, param: param)
    }
    
    @objc public static func redirection(to path: String, param: RedirectionParameters) {
        
        guard writeLogEnable else {
            return
        }
        
        if fileLogger?.logFileManager?.logsDirectory == path {
            return
        }
        
        stopCapturing()
        
        if let fileLogger = fileLogger {
            SwiftyBeaver.self.removeDestination(fileLogger)
            self.fileLogger = nil
        }
        
        createFileLogger(with: path, param: param)
        
        startCapturing()
    }
    
    static func eliminateSideEffectsOnDiagStopCar() { // 停止诊断移动日志后，可能会有输出导致重新生成移走的日志
        fileLogger?.logFileURL = nil
        fileLogger?.logFileManager = nil
    }
    
    private static func createFileLogger(with path: String, param: RedirectionParameters) {
        
        guard hasAvailableSpace else { return }
        
        let manager = fileManager(with: path, param: param)
        let fileLogger = createFileLogger(manager: manager)
        
        SwiftyBeaver.self.addDestination(fileLogger)
        
        Self.fileLogger = fileLogger
    }
    
    private static func createFileLogger(manager: TopdonLogFileManager) -> TopdonFileLogger {
        let fileLogger = TopdonFileLogger(logFileManager: manager,
                                          maximumFileSize: maximumFileSize,
                                          maximumNumberOfLogFiles: maximumNumberOfLogFiles)
        fileLogger.format = logFormat
        fileLogger.minLevel = .verbose
        fileLogger.asynchronously = false
        return fileLogger
    }
    
    private static func fileManager(with path: String, param: RedirectionParameters) -> TopdonLogFileManager {
        
        let manager = TopdonLogFileManager(logsDirectory: path,
                                           subPath: param.subPath,
                                           appName: param.appName,
                                           launchTime: param.launchTime,
                                           launchDateFormatter: param.launchDateFormatter) { newLogFilename in
#if DEBUG
            innerLogger("onCreateLogFile (\(newLogFilename)")
#endif
            self.onCreateLogFile?(newLogFilename)
        }
        manager.onRenameLogFile = { oldName, newName in
#if DEBUG
            innerLogger("onRenameLogFile (\(oldName) to \(newName)")
#endif
            self.onRenameLogFile?(oldName, newName)
        }
        
        return manager
    }
    
    
}

// MARK: - Output

extension TopdonLog {
    
    
    public static func error( message: @autoclosure () -> Any, _
                              file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[E] ") {
        let msg = message()
        callOnGlobal {
            SwiftyBeaver.self.error(msg, file, function, line: line, context: context)
            
        }
    }
    
    public static func warn(_ message: @autoclosure () -> Any, _
                            file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[W] ") {
        let msg = message()
        callOnGlobal {
            
            SwiftyBeaver.self.warning(msg, file, function, line: line, context: context)
        }
    }
    
    public static func info(_ message: @autoclosure () -> Any, _
                            file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[I] ") {
        let msg = message()
        callOnGlobal {
            
            SwiftyBeaver.self.info(msg, file, function, line: line, context: context)
        }
    }
    
    public static func debug(_ message: @autoclosure () -> Any, _
                             file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[D] ") {
        let msg = message()
        callOnGlobal {
            
            SwiftyBeaver.self.debug(msg, file, function, line: line, context: context)
        }
    }
    
    public static func verbose(_ message: @autoclosure () -> Any, _
                               file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[V] ") {
        let msg = message()
        callOnGlobal {
            
            SwiftyBeaver.self.verbose(msg, file, function, line: line, context: context)
        }
    }
}


// MARK: - Prefix Output

extension TopdonLog {
    
    public static func error(prefix: String = "",
                             _ message: @autoclosure () -> Any,
                             file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[E] ") {
        
        let msg = prefix.isEmpty ? message() : "[\(prefix)] \(message())"
        callOnGlobal {
            SwiftyBeaver.self.error(msg, file, function, line: line, context: context)
        }
    }
    
    public static func warn(prefix: String = "",
                            _ message: @autoclosure () -> Any,
                            file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[W] ") {
        
        let msg = prefix.isEmpty ? message() : "[\(prefix)] \(message())"
        callOnGlobal {
            SwiftyBeaver.self.warning(msg, file, function, line: line, context: context)
        }
    }
    
    public static func info(prefix: String = "",
                            _ message: @autoclosure () -> Any,
                            file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[I] ") {
        
        let msg = prefix.isEmpty ? message() : "[\(prefix)] \(message())"
        callOnGlobal {
            SwiftyBeaver.self.info(msg, file, function, line: line, context: context)
        }
    }
    
    public static func debug(prefix: String = "",
                             _ message: @autoclosure () -> Any,
                             file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[D] ") {
        let msg = prefix.isEmpty ? message() : "[\(prefix)] \(message())"
        callOnGlobal {
            SwiftyBeaver.self.debug(msg, file, function, line: line, context: context)
        }
    }
    
    public static func verbose(prefix: String = "",
                               _ message: @autoclosure () -> Any,
                               file: String = #file, function: String = #function, line: Int = #line, _ context: Any? = "[V] ") {
        let msg = prefix.isEmpty ? message() : "[\(prefix)] \(message())"
        callOnGlobal {
            SwiftyBeaver.self.verbose(msg, file, function, line: line, context: context)
        }
    }
    
    public static func custom(_ message: @autoclosure () -> Any, level: String,
                              file: String = #file, function: String = #function, line: Int = #line) {
        let msg = message()
        callOnGlobal {
            SwiftyBeaver.self.verbose(msg, file, function, line: line, context: level)
        }
    }
    
    static func callOnGlobal(completion: @escaping ()->Void) {
        globalQueue.async {
            completion()
        }
    }
}

// MARK: - Disk Space Warning

extension TopdonLog {
    
    static func handleDiskSpace(isOverFlow: Bool) {
        self.hasAvailableSpace = !isOverFlow
        guard isOverFlow else { return }
        
        // 记录磁盘日志不足
        warn("[TopdonLog] 磁盘空间不足 500M 停止写日志")
        
        if let fileLogger {
            SwiftyBeaver.self.removeDestination(fileLogger)
        }
    }
}

extension TopdonLog {
    
    static func isDebuggerAttached() -> Bool {
        var info = kinfo_proc()
        var mib = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        
        var size = MemoryLayout<kinfo_proc>.stride
        let result = sysctl(&mib, u_int(mib.count), &info, &size, nil, 0)
        if result != 0 {
            warn("[TopdonLog] isDebuggerAttached run fail(sysctl failed).")
            return false
        }
 
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
    /// 开始捕获标准输出
    public static func startCapturing() {
        if isIntercepting { return }
        isIntercepting = true
        interceptor?.startCapturing()
    }
    
    /// 开始捕获标准输出
    public static func stopCapturing() {
        isIntercepting = false
        interceptor?.stopCapturing()
    }
    
}

// MARK: - Crash File

extension TopdonLog {

    static func tdCrashInstall() {
        
        guard let dir = try? TDCrashInstallationFileOpts.defaultDir() else {
            innerLogger("TDCrashReports create failed.")
            return
        }
     
        let crash = TDCrashInstallationFile(opts: .init(outDirPath: dir))
        crash.install()
        self.crashInstall = crash
        
        crash.sendAllReports { reports, isComplete, error in
            if let err = error {
                innerLogger("[Crash] send all reports: \(reports ?? []), isComplete: \(isComplete), error: \(err)")
            } else {
                innerLogger("[Crash] send all reports: \(reports ?? []), isComplete: \(isComplete)")
            }
            
            self.isCrashFilesGenerated = isComplete
        }
    }
}

extension TopdonLog {
    
    public static var version: String { "1.60.001" }
    
}
