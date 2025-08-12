//
//  File+Attributes.swift
//  CocoaLumberjack
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

extension String {
    
    /// 目录大小
    var dirFileSize: UInt64 {
        AppFile.getFolderSize(atPath: self)
    }
    
    var ns: NSString {
        self as NSString
    }
    
    
    func removePrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    func removeSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
    
}

// MARK: - Dir
final public class AppFile {
    
    /// /Documents/
    public static let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
    
    /// /Library/Caches/
    public static let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last ?? ""
    
    /// 子目录 intermediateDirectories == true， 不存在就创建
    public static func childrenDir(parentDir: String, componet: String, intermediateDirectories: Bool = false) -> String {
        
        let path = parentDir.ns.appendingPathComponent(componet)
        
        guard intermediateDirectories else { return path }
        
        var isDirectory: ObjCBool = false
        let _ = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if !isDirectory.boolValue {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
        
        return path
    }
    
}

// MARK: - File Fetch

extension AppFile {
    
    /// 获取目录大小
    static func getFolderSize(atPath path: String) -> UInt64 {
        
        guard !path.isEmpty else { return 0 }
        
        let fileManager = FileManager.default
        var folderSize: UInt64 = 0
        
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: path)
            
            for contentPath in contents {
                let fullPath = path.ns.appendingPathComponent(contentPath)
                var isDirectory: ObjCBool = false
                
                if fileManager.fileExists(atPath: fullPath, isDirectory: &isDirectory) {
                    if isDirectory.boolValue {
                        let subfolderSize = getFolderSize(atPath: fullPath)
                        folderSize += subfolderSize
                    } else {
                        let attributes: [FileAttributeKey: Any] = try fileManager.attributesOfItem(atPath: fullPath)
                        if let fileSize = attributes[.size] as? UInt64 {
                            folderSize += fileSize
                        }
                    }
                }
            }
            
            return folderSize
        } catch {
            innerLogger(error)
            return 0
        }
        
    }
    
    static func fileSize(atPath path: String) -> UInt64? {
        let fileManager = FileManager.default
        do {
            let attributes = try fileManager.attributesOfItem(atPath: path)
            if let fileSize = attributes[.size] as? UInt64 {
                return fileSize
            }
        } catch {
#if DEBUG
            innerLogger("Error retrieving file size: \(error)")
#endif
        }
        return nil
    }
    
    static func isDirectoryEmpty(atPath path: String) -> Bool {
        let fileManager = FileManager.default
        do {
            // 获取目录中的所有内容
            let contents = try fileManager.contentsOfDirectory(atPath: path)
            // 检查内容是否为空
            return contents.isEmpty
        } catch {
#if DEBUG
            innerLogger("Error checking directory contents: \(error)")
#endif
            return false
        }
    }
    
    /// 当前目录的所有文件
    static func files(atPath path: String) -> [String] {
        guard !path.isEmpty else { return [] }
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: path) else { return [] }
        return files
    }
    
    /// 目录下全部文件、包括子目录下的文件
    static func flatFiles(atPath path: String) -> [String] {
        guard !path.isEmpty else { return [] }
        
        let files = files(atPath: path)
        var allFiles: [String] = []
        for file in files {
            let fullPath = path.ns.appendingPathComponent(file)
            var isDirectory: ObjCBool = false
            if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                    allFiles.append(contentsOf: flatFiles(atPath: fullPath))
                } else {
                    allFiles.append(fullPath)
                }
            }
        }
        return allFiles
    }
    
    /// 文件按创建时间排序
    static func sortFiles(_ files: [String], asc: Bool = false) -> [String] {
        files.sorted { f1, f2 in
            guard let f1Info = try? FileManager.default.attributesOfItem(atPath: f1),
                  let f1Date = f1Info[.creationDate] as? Date,
                  let f2Info = try? FileManager.default.attributesOfItem(atPath: f2),
                  let f2Date = f2Info[.creationDate] as? Date else {
                return true
            }
            return asc ? (f1Date.timeIntervalSince1970 < f2Date.timeIntervalSince1970) : (f1Date.timeIntervalSince1970 > f2Date.timeIntervalSince1970)
        }
    }
    
}

// MARK: - File Operation

extension AppFile {
    
    enum Error: Swift.Error {
        case pathEmtpy
        case undderlying(Swift.Error)
        case custom(String)
        
        var dbError: String{
            switch self {
            case .pathEmtpy:
                return "path is Empty"
            case .undderlying(let err):
                return err.localizedDescription
            case .custom(let desc):
                return desc
            }
        }
    }
    
    static func fileExists(atPath path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }
    
    /// 删除
    @discardableResult
    static func removeFile(atPath path: String) -> AppFile.Error? {
        guard !path.isEmpty else { return .pathEmtpy }
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            innerLogger(error)
            return .undderlying(error)
        }
        
        return nil
    }
    
    /// 移动
    @discardableResult
    static func moveFile(atPath path: String, toPath dstPath: String) -> AppFile.Error? {
        guard !path.isEmpty, !dstPath.isEmpty else { return .pathEmtpy }
        do {
            try FileManager.default.moveItem(atPath: path, toPath: dstPath)
        } catch {
            innerLogger(error)
            return .undderlying(error)
        }
        return nil
    }
    
    /// 移动，限制大小 size: 默认 200M = 200 * 1024 * 1024 = 209715200
    @discardableResult
    static func sortFilesByDateDscAndMove(atPath path: String, toPath dstPath: String, isDeleteOutLimit: Bool = false, limitSize: UInt64 = 209715200) -> AppFile.Error? {
        let fileManager = FileManager.default
        
        do {
            // 获取目录中的所有文件
            let files = try fileManager.contentsOfDirectory(atPath: path)
            
            // 构建文件 URL
            let fileURLs = files.map { URL(fileURLWithPath: path).appendingPathComponent($0) }
            
            // 获取文件属性并按创建时间排序
            let sortedFileURLs = try fileURLs.sorted {
                let attributes1 = try fileManager.attributesOfItem(atPath: $0.path)
                let attributes2 = try fileManager.attributesOfItem(atPath: $1.path)
                
                if let date1 = attributes1[.creationDate] as? Date, let date2 = attributes2[.creationDate] as? Date {
                    return date1.timeIntervalSince1970 > date2.timeIntervalSince1970
                }
                return false
            }
            
            var movedFileURLS: [URL] = []
            
            var totalSize: UInt64 = 0
            for fileURL in sortedFileURLs {
                let attributes = try fileManager.attributesOfItem(atPath: fileURL.path)
                
                if let fileSize = attributes[.size] as? UInt64 {
                    // 检查总大小是否超过限制大小
                    if totalSize + fileSize > limitSize {
                        break
                    }
                    
                    totalSize += fileSize
                    
                    // 移动文件
                    let destinationURL = URL(fileURLWithPath: dstPath).appendingPathComponent(fileURL.lastPathComponent)
                    try fileManager.moveItem(at: fileURL, to: destinationURL)
#if DEBUG
                    innerLogger("Moved \(fileURL.lastPathComponent) to \(destinationURL.path)")
#endif
                    movedFileURLS.append(fileURL)
                }
            }
            
#if DEBUG
            innerLogger("Total moved size: \(totalSize) bytes")
#endif
            // 删除其余的文件
            if isDeleteOutLimit && !sortedFileURLs.isEmpty {
                for fileURL in sortedFileURLs where !movedFileURLS.contains(fileURL) {
                    try? fileManager.removeItem(at: fileURL)
                }
            }
            
        } catch {
#if DEBUG
            innerLogger("Error: \(error)")
#endif
            return .undderlying(error)
        }
        return nil
    }
    
    /// 拷贝
    @discardableResult
    static func copyFile(atPath path: String, toPath dstPath: String) -> AppFile.Error? {
        guard !path.isEmpty, !dstPath.isEmpty else { return .pathEmtpy }
        do {
            try FileManager.default.copyItem(atPath: path, toPath: dstPath)
        } catch {
            innerLogger(error)
            return .undderlying(error)
        }
        return nil
    }
    
    /// 目录
    @discardableResult
    static func isDirectoryExist(atPath path: String, isCreate: Bool) -> Bool {
        let fileManager = FileManager.default
        let isExist = fileManager.fileExists(atPath: path)
        if !isExist && isCreate {
           try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
        return isExist
    }
    
    
}

// MARK: - 磁盘空间

extension AppFile {
    
    static func freeDiskSpace() -> Int64 {
        let fileManager = FileManager.default
        if let attributes = try? fileManager.attributesOfFileSystem(forPath: NSHomeDirectory()),
           let freeSpace = attributes[.systemFreeSize] as? Int64 {
            return freeSpace
        } else {
            return 0
        }
    }
    
}
