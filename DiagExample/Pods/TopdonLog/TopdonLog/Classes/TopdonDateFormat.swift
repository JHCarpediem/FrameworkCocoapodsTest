//
//  TopdonDateFormat.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/6/12.
//

import Foundation

struct TopdonDateFormat {
    
    /// 打印日志体内时间格式 (yyyy/MM/dd HH:mm:ss:SSS)
    // static let kLogMessage = "yyyy/MM/dd HH:mm:ss:SSS"
    /// 记录启动时间格式 (yyyy.MM.dd HH_mm_ss) , 用于appLog name ( func newLogFileName )
    static let kLaunchTime = "yyyyMMdd_HHmmss"
    /// zip名字中的时间格式 (yyyyMMddHHmmss)
    static let kZipName    = "yyyyMMddHHmmss"
    /// 上传用到的时间格式 (yyyy-MM-dd HH:mm:ss)
    static let kUploadTime = "yyyy-MM-dd HH:mm:ss"
    /// 日志文件名
    // static let kLogFieNameDate = "yyyyMMdd"

}
