//
//  TDCrashReportSinkFile.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/9/20.
//

import Foundation
import KSCrash

/// Apple Crash File Suffix
public let kAppleCrashFileSuffix = ".crash"

public class TDCrashReportSinkFile: KSCrashReportFilterAppleFmt {
    
    public private(set) var fileDir: String
    
    public init(reportStyle: KSAppleReportStyle, dir: String) {
        fileDir = dir
        super.init(reportStyle: reportStyle)
    }
    
    typealias OutputFile = (crash: String, json: String)
    func outputFilePath() -> OutputFile {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd_HHmmss"
        
        let processInfo = ProcessInfo.processInfo
        let tmpFileName = "\(processInfo.processName)-\(formatter.string(from: .init()))-\(processInfo.processIdentifier)"
        let filename = fileDir + "/" + tmpFileName
        
        return (filename + kAppleCrashFileSuffix, filename + ".json")
    }
    
    override public func filterReports(_ reports: [Any]!, onCompletion: KSCrashReportFilterCompletion!) {
        
        super.filterReports(reports) { [weak self] filterReports, isComplete, err in
            guard let self else { return }
            
            // Write JSON File
            /*
             for report in reports {
             do {
             let filePath = self.outputFilePath()
             if var fileURL = URL(string: filePath.json) {
             fileURL.deleteLastPathComponent()
             let dirPath = fileURL.path
             if !FileManager.default.fileExists(atPath: dirPath) {
             try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true)
             }
             }
             logger.warn("xinwen report: \(report)")
             let reportObj = try KSJSONCodec.encode(report, options: KSJSONEncodeOptionSorted)
             try String(data: reportObj, encoding: .utf8)?.write(toFile: filePath.json, atomically: false, encoding: .utf8)
             
             } catch {
             logger.error("TDCrashReportSinkFile error \(error)")
             }
             }
             */
            
            // Write AppleFmt File
            if let filterReports {
                for report in filterReports {
                    let filePath = self.outputFilePath()
                    do {
                        if let str = report as? String {
                            try str.write(toFile: filePath.crash, atomically: false, encoding: .utf8)
                        } else {
                            innerLogger("crash report: is not a string")
                        }
                    } catch {
                        innerLogger("TDCrashReportSinkFile write to file error \(error)")
                    }
                }
            }
            
            kscrash_callCompletion(onCompletion, reports, true, nil)
        }
    }
    
}
