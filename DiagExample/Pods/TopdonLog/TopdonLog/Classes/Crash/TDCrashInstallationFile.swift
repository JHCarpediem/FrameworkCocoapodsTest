//
//  File.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/9/20.
//

import Foundation
import KSCrash

public struct TDCrashInstallationFileOpts {
    
    public static func defaultDir() throws -> String {
        guard let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last else {
            return ""
        }
        let dir = (documentDir as NSString).appendingPathComponent("TDCrashReports")
    
        if !FileManager.default.fileExists(atPath: dir) {
            try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
        }
        
        return dir
    }
    
    public private(set) var outputDir: String
    
    public private(set) var reportStyle: KSAppleReportStyle
    
    /// 默认：KSAppleReportStyleUnsymbolicated
    public init(outDirPath: String, reportStyle: KSAppleReportStyle = KSAppleReportStyleUnsymbolicated) {
        self.outputDir = outDirPath
        self.reportStyle = reportStyle
    }
    
}

public class TDCrashInstallationFile: KSCrashInstallationConsole {
    
    public private(set) var options: TDCrashInstallationFileOpts
    
    public init(opts: TDCrashInstallationFileOpts) {
        options = opts
        super.init(requiredProperties: nil)
    }
    
    override public func install() {
        
        let sinkFile = TDCrashReportSinkFile(reportStyle: options.reportStyle, dir: options.outputDir)
        addPreFilter(sinkFile)
        
        super.install()
    }
    
}
