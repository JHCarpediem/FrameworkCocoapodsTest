//
//  AppInfo.swift
//  TopdonLog
//
//  Created by xinwenliu on 2023/11/21.
//

import Foundation

@objc(TDAppInfo)
@objcMembers
public class AppInfo: NSObject {
    
    public let appName: String
    public let version: String
    
    /// 默认`iOS`
    public let platform: String = "iOS"
    
    public let launchTime: String
    public let launchTimeFormat: String = TopdonDateFormat.kLaunchTime
    public let launchDateFormatter: DateFormatter
    
    public let launchTimestamp: TimeInterval
    
    public override init() {
        if let infoDict = Bundle.main.infoDictionary {
            self.appName = ((infoDict["CFBundleDisplayName"] as? String) ?? (infoDict["CFBundleName"] as? String)) ?? ""
            self.version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        } else {
            self.appName = ""
            self.version = ""
        }
        
        let dateFormatter = DateFormatter()
        #if DEBUG
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        #else
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        #endif
        dateFormatter.dateFormat = launchTimeFormat
        
        self.launchDateFormatter = dateFormatter
        let launchDate = Date.current()
        self.launchTime = launchDate.string(withFormatter: dateFormatter)
        self.launchTimestamp = launchDate.timeIntervalSince1970
        super.init()
    }
    
}
