//
//  AppLaunchUploader.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/5/24.
//

import Foundation

final class LaunchLogFileUploader: NSObject {
    
    static let shared = LaunchLogFileUploader()
    
    var isUploading: Bool = false
    
    private var groups: [LogFiles] = []
    
    private var failureCount: Int = 0
    
    /// 用作上传之前的
    private var zips: [String] = []
    
    private override init() {
        super.init()
    }
    
    func upload(_ groups: [LogFiles]) {
        guard isUploading == false else { return }
        self.groups = groups
        loopUploading()
    }
    
    private func loopUploading() {
        let logFiles = groups.filter { ($0.isUpload == false && (!$0.zipPath.isEmpty)) }
        guard !logFiles.isEmpty else {
            isUploading = false
            failureCount = 0
            return
        }
        isUploading = true
        
        guard let first = logFiles.first else {
            isUploading = false
            failureCount = 0
            return
        }
        
        doSingleUpload(first) { isSuccess in
            if isSuccess {
                first.isUpload = true
                self.failureCount = 0
                self.loopUploading()
            } else {
                self.failureCount += 1
                guard self.failureCount <= 3 else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) { self.loopUploading() }
            }
        }
    }
    
    private func doSingleUpload(_ logFiles: LogFiles, completion:@escaping (Bool) -> Void) {
        if let uploadModel = logFiles.uploadModel {
            LogUploadManager.shared.uploadSingle(uploadModel) {
                completion($0)
            }
        } else {
            completion(true)
        }
    }
    
    private func doSingleUploadZip(_ zip: String, completion:@escaping (Bool) -> Void) {
        let model = LogUploadModel(zipPath: zip,
                                   feedBackZipPath: "",
                                   uploadType: .appLog,
                                   carType: "iOSLog".uppercased(),
                                   carBrand: "iOSLog".uppercased(),
                                   createTime: String.getFileCreateTime(for: zip) ?? Date().dateString(format: TopdonDateFormat.kUploadTime),
                                   dbPath: LogColletionManager.shared.dbPath)
        LogUploadManager.shared.uploadSingle(model) {
            completion($0)
        }
    }
    
}

extension LaunchLogFileUploader {
    
    func loopUploadingZips(_ zips: [String], completion: @escaping (Bool) -> Void) {
         guard isUploading == false else { return }
         self.zips = zips
         loopUploadingZip(completion: completion)
     }
     
     private func loopUploadingZip(completion: @escaping (Bool) -> Void) {
         zips = zips.filter { FileManager.default.fileExists(atPath: $0) }
         guard !zips.isEmpty else {
             isUploading = false
             failureCount = 0
             completion(true)
             return
         }
         isUploading = true
         
         guard let first = zips.first else {
             isUploading = false
             failureCount = 0
             completion(true)
             return
         }
         
         doSingleUploadZip(first) { isSuccess in
             if isSuccess {
                 self.failureCount = 0
                 self.loopUploadingZip(completion: completion)
             } else {
                 self.failureCount += 1
                 guard self.failureCount <= 3 else {
                     completion(false)
                     return
                 }
                 DispatchQueue.main.asyncAfter(deadline: .now() + 10) { self.loopUploadingZip(completion: completion) }
             }
         }
     }
    
}

final class AppLaunchLogFileHandler: NSObject {
    
    /// 条件： logs是按时间排好序的
    static func handle(_ logs: [String]) -> GroupLogFile {
        // topscan /var/mobile/Containers/Data/Application/AAFA0FC6-5734-4720-8939-516CB0BBFD60/Documents/log/log/2024-05-22 10_06_30.log
        // topdonLog "/var/mobile/Containers/Data/Application/AD3439F7-A25C-44F4-9856-5323B011F822/Documents/Log/Log/TopdonLog_Example-2024.05.25 08_13_47-1716624827.2339911.log"
        // PulseQ AC-2024.05.25 08_18_32-1716625112.554874.log
        let group = GroupLogFile(group: [])
        for log in logs {
            guard let date = log.logDate else {
                continue
            }
            let file = LogFile(path: log, day: date)
            
            let logFiles = group.last ?? createLogFilesFor(group: group)
            
            if !logFiles.isFull {
                if logFiles.isEmpty {
                    logFiles.logs.append(file)
                } else {
                    // 1. date is same
                    if date == logFiles.date {
                        logFiles.logs.append(file)
                    } else { // 2. date is not same
                        let logFiles = createLogFilesFor(group: group)
                        logFiles.logs.append(file)
                    }
                }
            } else { // isFull
                let logFiles = createLogFilesFor(group: group)
                logFiles.logs.append(file)
            }
        }
        
        return group
    }
    
    private static func createLogFilesFor(group: GroupLogFile) -> LogFiles {
        let logFiles = LogFiles(logs: [])
        group.group.append(logFiles)
        return logFiles
    }
    
    
}

internal extension String {
    
    var fileName: String? {
        return self.components(separatedBy: "/").last
    }
    
    var logDate: String? {
        //  PulseQ AC-2024.05.25 08_18_32-1716625112.554874.log
        guard let name = fileName else { return nil }
        let components = name.components(separatedBy: "-")
        guard components.count >= 3 else { return nil }
        guard let dateComponents = components[safe:1] else { return nil }
        guard let date = dateComponents.components(separatedBy: " ").first else { return nil }
        return date.replacingOccurrences(of: "-", with: "_").replacingOccurrences(of: ".", with: "_")
    }
    
    static func getFileCreateTime(for filePath: String, format: String = TopdonDateFormat.kUploadTime) -> String? {
        let fileManager = FileManager.default
        
        do {
            let attributes = try fileManager.attributesOfItem(atPath: filePath)
            if let creationDate = attributes[.creationDate] as? Date {
                let dateFormatter = DateFormatter()
                // dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.locale = .current
                dateFormatter.timeZone = .current
                dateFormatter.dateFormat = format
                return dateFormatter.string(from: creationDate)
            }
        } catch {
            innerLogger("Failed to get file attributes: \(error)")
        }
        
        return nil
    }
    
    func date(with format: String = TopdonDateFormat.kZipName) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
    
}

fileprivate extension Date {
    
    func dateString(format: String = TopdonDateFormat.kUploadTime) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

final class GroupLogFile: NSObject {
    
    var group: [LogFiles]
    
    var last: LogFiles? {
        group.last
    }
    
    init(group: [LogFiles]) {
        self.group = group
        super.init()
    }
    
    override var description: String {
        var logsDes = group.reduce(into: "") { partialResult, logFiles in
            partialResult += ", \(logFiles.description)"
        }
        logsDes = "[group:\(logsDes)]"
        
        let hexAddress = hexObjectAddressString(self)
        return "{self:<AD200.LogFiles: \(hexAddress)>}"
    }
}

final class LogFiles: NSObject {
    
    var logs: [LogFile]
    
    var zipPath: String = "" {
        didSet {
            logs.forEach { $0.zipPath = zipPath }
        }
    }
    
    var uploadModel: LogUploadModel?
    
    /// 最多5个1组
    var isFull: Bool {
        logs.count >= 5
    }
    
    var isEmpty: Bool {
        logs.isEmpty
    }
    
    /// 注意判空
    var date: String {
        return logs[0].day
    }
    
    var isUpload: Bool = false {
        didSet {
            logs.forEach { $0.isUpload = isUpload }
        }
    }
    
    init(logs: [LogFile]) {
        self.logs = logs
        
        super.init()
    }
    
    override var description: String {
        
        var logsDes = logs.reduce(into: "") { partialResult, logFile in
            partialResult += ", \(logFile.description)"
        }
        logsDes = "[logs:\(logsDes)]"
        
        let hexAddress = hexObjectAddressString(self)
        return "{self:<AD200.LogFiles: \(hexAddress)>, isFull: \(isFull), isEmpty: \(isEmpty), isUpload: \(isUpload)}"
        
    }
    
}


final class LogFile: NSObject {
    
    var path: String
    var day: String
    
    var zipPath: String = ""
    var isUpload: Bool = false
    
    init(path: String, day: String) {
        self.path = path
        self.day = day
        super.init()
    }
    
    var fileName: String {
        path.fileName ?? ""
    }
    
    override var description: String {
        let hexAddress = hexObjectAddressString(self)
        return "{self:<AD200.LogFile: \(hexAddress)>, path:\(path), day:\(day), zipPath:\(zipPath), isUpload:\(isUpload)}"
    }
}

fileprivate func hexObjectAddressString(_ obj: AnyObject) -> String {
    String(format: "0x%2X", getObjectAddress(obj))
}

fileprivate func getObjectAddress(_ obj: AnyObject) -> Int {
    let address = unsafeBitCast(obj, to: Int.self)
    return address
}
