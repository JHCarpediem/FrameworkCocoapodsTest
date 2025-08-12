//
//  TDLogger.swift
//  TDBasis
//
//  Created by fench on 2023/7/12.
//

import UIKit
import TopdonLog
import os

@objc public class TDLogManager: NSObject {
    
    private static var _isLogEnable: Bool = true
    /// 是否开启日志
    @objc public class var logEnable: Bool {
        get {
            return _isLogEnable
        }
        set {
            _isLogEnable = newValue
        }
    }
    
    #if DEBUG
    @objc public static var isConsoleLog: Bool = true
    #endif
}

/// 打印Custom 日志
/// - Parameter message: 日志信息
public func TDLogCustom(_ message: Any...,
                        customLevel: String,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line,
                        ignoreExtra: Bool = false) {
    TDLog(message, logLevel: .custom(value: customLevel), file: file, function: function, line: line)
}

/// 打印Warnning 日志
/// - Parameter message: 日志信息
public func TDLogWarnning(_ message: Any...,
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) {
    TDLog(message, logLevel: .warning, file: file, function: function, line: line)
}

/// 打印Error 日志
/// - Parameter message: 日志信息
public func TDLogError(_ message: Any...,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
    TDLog(message, logLevel: .error, file: file, function: function, line: line)
}

/// 打印DEBUG 日志
/// - Parameter message: 日志信息
public func TDLogDebug(_ message: Any...,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
    TDLog(message, logLevel: .debug, file: file, function: function, line: line)
}

/// 打印日志
/// - Parameters:
///   - messages: 需要打印的信息
///   - logLevel: 日志级别
///   - file: 文件名
///   - function: 方法名
///   - line: 文件行数
///   - async: 是否异步答应
public func TDLog(_ messages: Any...,
                  logLevel: TDLogger.TDLogLevel = .default,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line,
                  asynchronous async: Bool = false,
                  ignoreExtra: Bool = true) {
    
    TDLogger.log(with: messages,
                 logLevel: logLevel,
                 file: file,
                 function: function,
                 line: line,
                 asynchronous: async,
                 ignoreExtra: ignoreExtra)
}


private var _logQueue = DispatchQueue(label: "com.topdon.logger")

@objc public class TDLogger: NSObject {
    
    @available(iOS 14.0, *)
    private static var loggerCaches: [String: os.Logger] = [:]
    
    @UserDefault(key: "kEnableLogDebugView", defaultValue: false)
    public static var isLogDebugViewEnabled: Bool {
        didSet {
            #if DEBUG
            if isLogDebugViewEnabled {
                LogDebugView.shared.showLogView(isExpand: false)
            } else {
                LogDebugView.shared.hideLogView()
            }
            #endif
        }
    }
    
    
    public enum TDLogLevel {
        case `default`, debug, warning, error
        case custom(value: String)
        
        var tagValue: String {
            switch self {
            case .debug:
                return "🛠"
            case .warning:
                return "⚠️"
            case .error:
                return "❌"
            case .custom(let value):
                return "\(value)"
            case .default:
                return "⚪️"
            }
        }
        
        var osLogType: OSLogType {
            switch self {
            case .default:
                return .default
            case .debug:
                return .debug
            case .warning:
                return .info
            case .error:
                return .error
            case .custom(let value):
                return .info
            }
        }
    }
    
    internal static func log(with items: Any...,
                             logLevel: TDLogLevel = .default,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line,
                             asynchronous async: Bool = false,
                             ignoreExtra: Bool = true) {
        
        if !TDLogManager.logEnable {
            return
        }
        
        var itemsDes = items.reduce("") { partialResult, result in
            var temp = "\(result)"
            if result is Array<Any> {
                temp = (result as! Array<Any>).reduce("") { arg1 , arg2 in
                    return arg1 + " \(arg2)"
                }
            }
            return partialResult + temp
        }
        if !ignoreExtra {
            itemsDes = Date().td.string(withFormat: "[yyyy-MM-dd HH:mm:ss.sss]") + itemsDes
        }
        
        if isLogDebugViewEnabled {
            LogDebugView.shared.logQueue.sync {
                let logValue = logLevel.tagValue + itemsDes
                LogDebugView.shared.logs.append((logLevel, logValue))
            }
        }
        
        #if DEBUG
        if isatty(STDOUT_FILENO) != 0, TDLogManager.isConsoleLog, #available(iOS 14.0, *) {
            let fileName = file.td.nsString.lastPathComponent
            let logger: os.Logger
            if let cacheLogger = loggerCaches[logLevel.tagValue] {
                logger = cacheLogger
            } else {
                logger = Logger(subsystem: AppInfo.bundleName, category: logLevel.tagValue)
                loggerCaches[logLevel.tagValue] = logger
            }
            if case .warning = logLevel {
                logger.warning("\(fileName):\(line) \(function) - \(itemsDes)")
            } else {
                logger.log(level: logLevel.osLogType, "\(fileName):\(line) \(function) - \(itemsDes)")
            }
        } else {
            switch logLevel {
            case .default:
                TopdonLog.info(itemsDes, file: file, function: function, line: line)
            case .debug:
                TopdonLog.debug(itemsDes, file: file, function: function, line: line)
            case .warning:
                TopdonLog.warn(itemsDes, file: file, function: function, line: line)
            case .error:
                TopdonLog.error(itemsDes, file: file, function: function, line: line)
            case .custom(let value):
                TopdonLog.custom(itemsDes, level: value, file: file, function: function, line: line)
            }
        }
        #else
        switch logLevel {
        case .default:
            TopdonLog.info(itemsDes, file: file, function: function, line: line)
        case .debug:
            TopdonLog.debug(itemsDes, file: file, function: function, line: line)
        case .warning:
            TopdonLog.warn(itemsDes, file: file, function: function, line: line)
        case .error:
            TopdonLog.error(itemsDes, file: file, function: function, line: line)
        case .custom(let value):
            TopdonLog.custom(itemsDes, level: value, file: file, function: function, line: line)
        }
        #endif
        
    }
    
    @objc public class func log(_ message: String,
                                file: String = #file,
                                function: String = #function,
                                line: Int = #line,
                                asynchronous async: Bool = false) {
        log(with: message, logLevel: .default, file: file, function: function, line: line, asynchronous: async)
    }
    
    @objc public class func logDebug(_ message: String,
                                     file: String = #file,
                                     function: String = #function,
                                     line: Int = #line,
                                     asynchronous async: Bool = false) {
        log(with: message, logLevel: .debug, file: file, function: function, line: line, asynchronous: async)
    }
    
    @objc public class func logError(_ message: String,
                                     file: String = #file,
                                     function: String = #function,
                                     line: Int = #line,
                                     asynchronous async: Bool = false) {
        log(with: message, logLevel: .error, file: file, function: function, line: line, asynchronous: async)
    }
    
    @objc public class func logWarnning(_ message: String,
                                        file: String = #file,
                                        function: String = #function,
                                        line: Int = #line,
                                        asynchronous async: Bool = false) {
        log(with: message, logLevel: .warning, file: file, function: function, line: line, asynchronous: async)
    }
    
    @objc public class func logCustom(_ message: String,
                                      customLevel: String,
                                      file: String = #file,
                                      function: String = #function,
                                      line: Int = #line,
                                      asynchronous async: Bool = false) {
        log(with: message, logLevel: .custom(value: customLevel), file: file, function: function, line: line, asynchronous: async)
    }
}
