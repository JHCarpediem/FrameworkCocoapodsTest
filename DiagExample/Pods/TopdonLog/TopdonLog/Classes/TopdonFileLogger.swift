//
//  TopdonFileLogger.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/28.
//

import Foundation
import SwiftyBeaver

// copy FileDestination
final public class TopdonFileLogger: BaseDestination {
    
    public override var format: String {
        didSet {
            hookoutFormat = format
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: " ", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var hookoutFormat: String = ""
    
    public var logFileManager: TopdonLogFileManager?
    let fileManager = FileManager.default
    
    convenience init(logFileManager: TopdonLogFileManager, maximumFileSize: UInt64, maximumNumberOfLogFiles: UInt) {
        self.init(logFileURL: logFileManager.url)
        self.logFileMaxSize = Int(maximumFileSize)
        self.logFileAmount = Int(maximumNumberOfLogFiles)
        
        self.logFileManager = logFileManager
    }
    
    
    public var logFileURL: URL?
    public var syncAfterEachWrite: Bool = false
    
    // LOGFILE ROTATION
    // ho many bytes should a logfile have until it is rotated?
    // default is 5 MB. Just is used if logFileAmount > 1
    public var logFileMaxSize = (5 * 1024 * 1024)
    // Number of log files used in rotation, default is 1 which deactivates file rotation
    public var logFileAmount = 1
    
    override public var defaultHashValue: Int {return 2}
    
    public init(logFileURL: URL? = nil) {
        if let logFileURL = logFileURL {
            self.logFileURL = logFileURL
            super.init()
            return
        }
        
        // platform-dependent logfile directory default
        var baseURL: URL?
#if os(OSX)
        if let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            baseURL = url
            // try to use ~/Library/Caches/APP NAME instead of ~/Library/Caches
            if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String {
                do {
                    if let appURL = baseURL?.appendingPathComponent(appName, isDirectory: true) {
                        try fileManager.createDirectory(at: appURL,
                                                        withIntermediateDirectories: true, attributes: nil)
                        baseURL = appURL
                    }
                } catch {
                    innerLogger("Warning! Could not create folder /Library/Caches/\(appName)")
                }
            }
        }
#else
#if os(Linux)
        baseURL = URL(fileURLWithPath: "/var/cache")
#else
        // iOS, watchOS, etc. are using the caches directory
        if let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            baseURL = url
        }
#endif
#endif
        
        if let baseURL = baseURL {
            self.logFileURL = baseURL.appendingPathComponent("swiftybeaver.log", isDirectory: false)
        }
        super.init()
    }
    
    // append to file. uses full base class functionality
    override public func send(_ level: SwiftyBeaver.Level, msg: String, thread: String,
                              file: String, function: String, line: Int, context: Any? = nil) -> String? {
        
        let formattedString: String?
        if let ctx = context as? String, ctx == OutputInterceptor.identifier {
            formattedString = formatMessage(hookoutFormat, level: level, msg: msg, thread: thread, file: file, function: function, line: line, context: ctx)
        } else {
           formattedString = super.send(level, msg: msg, thread: thread, file: file, function: function, line: line, context: context)
        }
        
        if let str = formattedString {
            _ = validateSaveFile(str: str)
        }
        return formattedString
    }
    
    // check if filesize is bigger than wanted and if yes then rotate them
    func validateSaveFile(str: String) -> Bool {
        if self.logFileAmount > 1 {
            guard let url = logFileURL else { return false }
            let filePath = url.path
            if FileManager.default.fileExists(atPath: filePath) == true {
                do {
                    // Get file size
                    let attr = try FileManager.default.attributesOfItem(atPath: filePath)
                    let fileSize = attr[FileAttributeKey.size] as! UInt64
                    // Do file rotation
                    if fileSize > logFileMaxSize {
                        //rotateFile(filePath)
                        rotateFileWithRound(filePath)
                    }
                } catch {
                    innerLogger("validateSaveFile error: \(error)")
                }
            }
        }
        return saveToFile(str: str)
    }
    
    private func rotateFileWithRound(_ filePath: String) {
        
        // 获取目录下的同名前缀日志排序
        let fullPrefix = filePath.removeSuffix(TopdonLogFileManager.kLogFileExtension)
        let dir = filePath.ns.deletingLastPathComponent
        let oldFiles = AppFile.files(atPath: dir).map { dir.ns.appendingPathComponent($0) }.lazy.filter { ($0 != filePath) && $0.hasPrefix(fullPrefix) }.sorted { file1, file2 in
            
            let suffFile1 = file1.removePrefix(fullPrefix.appending("_")).removeSuffix(TopdonLogFileManager.kLogFileExtension)
            let suffFile2 = file2.removePrefix(fullPrefix.appending("_")).removeSuffix(TopdonLogFileManager.kLogFileExtension)
            
            let numFile1 = Int64(suffFile1) ?? 0
            let numFile2 = Int64(suffFile2) ?? 0
            
            return numFile1 < numFile2
        }
        
#if DEBUG
        innerLogger("oldFiles .... b")
        for oldFile in oldFiles {
            innerLogger("oldFile \(oldFile)")
        }
        innerLogger("oldFiles .... e")
#endif
        
        let count = oldFiles.count
        let maxCount = (logFileAmount-1) // 4
        
        do {
            
            if count < maxCount {
                let index = Int64(count + 1)
                let newFile = try move(filePath, to: index)
                //logFileManager?.onCreateLogFile?(newFile)
                logFileManager?.onRenameLogFile?(filePath, newFile)
            } else { // >= maxCount
                guard let minIndex = oldFiles[0].removeSuffix(TopdonLogFileManager.kLogFileExtension).components(separatedBy: "_").last,
                      let min = Int64(minIndex),
                      let maxIndex = oldFiles[count-1].removeSuffix(TopdonLogFileManager.kLogFileExtension).components(separatedBy: "_").last,
                      let max = Int64(maxIndex) else {
                    innerLogger("rotateFileWithRound error: minIndex and maxIndex Failed.")
                    return
                }
                // 当前 --> index 最大
                let oldestFile = TopdonLogFileManager.rename(log: filePath, at: min)
                
                let cMaxIndex = Int64(max+1)
                let newFile = try move(filePath, to: cMaxIndex)
                //logFileManager?.onCreateLogFile?(newFile)
                logFileManager?.onRenameLogFile?(oldestFile, newFile)

                // 旧文件
                if FileManager.default.fileExists(atPath: oldestFile) {
                    try FileManager.default.removeItem(atPath: oldestFile)
                }
                
            }
            
            // 创建新文件
            //logFileManager?.onCreateLogFile?(filePath)
        } catch {
            innerLogger("rotateFileWithRound error: \(error)")
        }
        
    }
    
    private func move(_ filePath: String, to index: Int64) throws -> String {
        let newFile = TopdonLogFileManager.rename(log: filePath, at: index)
        try FileManager.default.moveItem(atPath: filePath, toPath: newFile)
        return newFile
    }
    
    /*
    private func rotateFile(_ filePath: String) {
        let lastIndex = (logFileAmount-1)
        let firstIndex = 1
        do {
            for index in stride(from: lastIndex, through: firstIndex, by: -1) { //4 3 2 1
                //let oldFile = String.init(format: "%@.%d", filePath, index)
                let oldFile = TopdonLogFileManager.rename(log: filePath, at: index)

                if FileManager.default.fileExists(atPath: oldFile) {
                    if index == lastIndex {
                        // Delete the last file
                        try FileManager.default.removeItem(atPath: oldFile)
                    } else {
                        // Move the current file to next index
                        //let newFile = String.init(format: "%@.%d", filePath, index+1)
                        let newFile = TopdonLogFileManager.rename(log: filePath, at: index+1)
                        try FileManager.default.moveItem(atPath: oldFile, toPath: newFile)
                        
                        self.logFileManager?.onRenameLogFile?(oldFile, newFile)
                    }
                }
            }
            
            // Finally, move the current file
            //let newFile = String.init(format: "%@.%d", filePath, firstIndex)
            let newFile =  TopdonLogFileManager.rename(log: filePath, at: firstIndex)
            try FileManager.default.moveItem(atPath: filePath, toPath: newFile)
            self.logFileManager?.onRenameLogFile?(filePath, newFile)
            
            self.logFileManager?.onCreateLogFile?(filePath)
            
        } catch {
            innerLogger("rotateFile error: \(error)")
        }
    }
     */
    
    /// appends a string as line to a file.
    /// returns boolean about success
    func saveToFile(str: String) -> Bool {
        guard let url = logFileURL else { return false }
        
        let line = str + "\n"
        guard let data = line.data(using: String.Encoding.utf8) else { return false }
        
        return write(data: data, to: url)
    }
    
    private func write(data: Data, to url: URL) -> Bool {
        
#if os(Linux)
        return true
#else
        var success = false
        let coordinator = NSFileCoordinator(filePresenter: nil)
        var error: NSError?
        coordinator.coordinate(writingItemAt: url, error: &error) { [weak self] url in
            guard let self else { return }
            do {
                if fileManager.fileExists(atPath: url.path) == false {
                    
                    let directoryURL = url.deletingLastPathComponent()
                    if fileManager.fileExists(atPath: directoryURL.path) == false {
                        try fileManager.createDirectory(
                            at: directoryURL,
                            withIntermediateDirectories: true
                        )
                    }
                    fileManager.createFile(atPath: url.path, contents: nil)
                    logFileManager?.onCreateLogFile?(url.path)
                    
#if os(iOS) || os(watchOS)
                    if #available(iOS 10.0, watchOS 3.0, *) {
                        var attributes = try fileManager.attributesOfItem(atPath: url.path)
                        attributes[FileAttributeKey.protectionKey] = FileProtectionType.none
                        try fileManager.setAttributes(attributes, ofItemAtPath: url.path)
                    }
#endif
                }
                
                let fileHandle = try FileHandle(forWritingTo: url)
                fileHandle.seekToEndOfFile()
                // fileHandle.write(data)
                if #available(iOS 13.4, *) {
                    try fileHandle.write(contentsOf: data)
                } else {
                    if let exception = tryBlock({ fileHandle.write(data) }) {
                        if exception.reason?.contains("No space left") == true {
#if DEBUG
                            innerLogger("TopdonFileLogger No Space left on Device write to file: \(url).")
#endif
                        } else {
                            
                        }
                    }
                }
                    
                if syncAfterEachWrite {
                    fileHandle.synchronizeFile()
                }
                fileHandle.closeFile()
                success = true
            } catch {
                #if DEBUG
                innerLogger("TopdonFileLogger File Destination could not write to file \(url).")
                #endif
            }
        }
        
        if let error = error {
            #if DEBUG
            innerLogger("Failed writing file with error: \(String(describing: error))")
            #endif
            return false
        }
        
        return success
#endif
    }
    
    /// deletes log file.
    /// returns true if file was removed or does not exist, false otherwise
    public func deleteLogFile() -> Bool {
        guard let url = logFileURL, fileManager.fileExists(atPath: url.path) == true else { return true }
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch {
            innerLogger("SwiftyBeaver File Destination could not remove file \(url).")
            return false
        }
    }
    
}

// MARK: - Format For [StdIO]
extension TopdonFileLogger {
    
    /// returns the log message based on the format pattern
    func formatMessage(_ format: String, level: SwiftyBeaver.Level, msg: String, thread: String,
        file: String, function: String, line: Int, context: Any? = nil) -> String {

        var text = ""
        // Prepend a $I for 'ignore' or else the first character is interpreted as a format character
        // even if the format string did not start with a $.
        let phrases: [String] = ("$I" + format).components(separatedBy: "$")

        for phrase in phrases where !phrase.isEmpty {
            let (padding, offset) = parsePadding(phrase)
            let formatCharIndex = phrase.index(phrase.startIndex, offsetBy: offset)
            let formatChar = phrase[formatCharIndex]
            let rangeAfterFormatChar = phrase.index(formatCharIndex, offsetBy: 1)..<phrase.endIndex
            let remainingPhrase = phrase[rangeAfterFormatChar]

            switch formatChar {
            case "I":  // ignore
                text += remainingPhrase
            case "L":
                text += remainingPhrase
            case "M":
                text += paddedString(msg, padding) + remainingPhrase
            case "T":
                text += remainingPhrase
            case "N":
                // name of file without suffix
                text += remainingPhrase
            case "n":
                // name of file with suffix
                text += remainingPhrase
            case "F":
                text += remainingPhrase
            case "l":
                text += remainingPhrase
            case "D":
                // start of datetime format
                #if swift(>=3.2)
                text += ""
                #else
                text += ""
                #endif
            case "d":
                text += remainingPhrase
            case "U":
                text += remainingPhrase
            case "Z":
                // start of datetime format in UTC timezone
                #if swift(>=3.2)
                text += ""
                #else
                text += ""
                #endif
            case "z":
                text += remainingPhrase
            case "C":
                // color code ("" on default)
                text += remainingPhrase
            case "c":
                text += remainingPhrase
            case "X":
                // add the context
                if let cx = context {
                    text += paddedString(String(describing: cx).trimmingCharacters(in: .whitespacesAndNewlines), padding) + remainingPhrase
                } else {
                    text += paddedString("", padding) + remainingPhrase
                }
            default:
                text += phrase
            }
        }
        // right trim only
        return text.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
    
    private func paddedString(_ text: String, _ toLength: Int, truncating: Bool = false) -> String {
        if toLength > 0 {
            // Pad to the left of the string
            if text.count > toLength {
                // Hm... better to use suffix or prefix?
                return truncating ? String(text.suffix(toLength)) : text
            } else {
                return "".padding(toLength: toLength - text.count, withPad: " ", startingAt: 0) + text
            }
        } else if toLength < 0 {
            // Pad to the right of the string
            let maxLength = truncating ? -toLength : max(-toLength, text.count)
            return text.padding(toLength: maxLength, withPad: " ", startingAt: 0)
        } else {
            return text
        }
    }

    ////////////////////////////////
    // MARK: Format
    ////////////////////////////////

    /// returns (padding length value, offset in string after padding info)
    private func parsePadding(_ text: String) -> (Int, Int) {
        // look for digits followed by a alpha character
        var s: String!
        var sign: Int = 1
        if text.firstChar == "-" {
            sign = -1
            s = String(text.suffix(from: text.index(text.startIndex, offsetBy: 1)))
        } else {
            s = text
        }
        let numStr = String(s.prefix { $0 >= "0" && $0 <= "9" })
        if let num = Int(numStr) {
            return (sign * num, (sign == -1 ? 1 : 0) + numStr.count)
        } else {
            return (0, 0)
        }
    }
    
}

extension String {
    /// cross-Swift compatible characters count
    var length: Int {
        return self.count
    }

    /// cross-Swift-compatible first character
    var firstChar: Character? {
        return self.first
    }

    /// cross-Swift-compatible last character
    var lastChar: Character? {
        return self.last
    }

    /// cross-Swift-compatible index
    func find(_ char: Character) -> Index? {
        #if swift(>=5)
            return self.firstIndex(of: char)
        #else
            return self.index(of: char)
        #endif
    }
}
