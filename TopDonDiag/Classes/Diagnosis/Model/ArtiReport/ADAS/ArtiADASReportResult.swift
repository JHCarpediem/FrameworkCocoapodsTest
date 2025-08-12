//
//  ArtiADASReportResult.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/15.
//

import UIKit

@objc(TDD_ArtiADASReportResult)
@objcMembers
open class ArtiADASReportResult: NSObject {
    
    public var sysName: String
    public var startTime: String
    public var stopTime: String
    public var totalTime: Int // s
    /// ADAS系统校准类型
    ///  0   静态校准   1   动态校准
    public var type: Int
    /// 系统校准结果状态
    ///  0   ADAS校准OK  1   ADAS校准失败
    public var status: Int
    
    /// 参数
    public var parameters: [ArtiADASParameters]?
    
    public func add(parameter: ArtiADASParameters) {
        parameters?.append(parameter)
    }
    
    /// YYMode Use, Don't Call with Code
    public override init() {
        self.sysName    = ""
        self.startTime  = ""
        self.stopTime   = ""
        self.totalTime  = 0
        self.type       = 0
        self.status     =  0
        self.parameters = nil
        super.init()
    }
    
    public class func modelContainerPropertyGenericClass() -> [String: Any] {
        return ["parameters": ArtiADASParameters.classForCoder()]
    }
    
    public init(sysName: String, startTime: String, stopTime: String, totalTime: Int, type: Int, status: Int) {
        self.sysName = sysName
        self.startTime = startTime
        self.stopTime = stopTime
        self.totalTime = totalTime
        self.type = type
        self.status = status
        
        super.init()
    }
    
    public var displayTotalTime: String {
        let minute = totalTime / 60
        let sec    = totalTime % 60
        
        return "\(minute)min\(sec)s"
    }
    
    public var displayResult: String {
        // TODO: - 国际化
        isFailure ? "校准失败!" : "校准成功!"
    }
    
    public var displayImageName: String {
        isFailure ? "adas_pic_failed" : "adas_pic_success"
    }
    
    public var totalTitle: String {
        // TODO: - 国际化
        "总校准时长"
    }
    
    public var timeTitle: String {
        // TODO: - 国际化
        "校准时间"
    }
    
    public var a4TimeValue: String {
        return "\(startTime)~\(stopTime)"
    }
    
    public var timeValue: String {
        return "\(startTime)\n~\(stopTime)"
    }
    
    public var isFailure: Bool {
        return status == 1
    }
    
    public var parameterTitle: String {
        // TODO: - 国际化
        "校准参数"
    }
    
    public var parameterHeight: CGFloat {
        guard let parameters = self.parameters,
              !parameters.isEmpty else {
            return 0.0
        }
        return CGFloat(parameters.count) * 50.0
    }
    
    public var serverJson: [String: AnyHashable] {
        [
            "ADAS_strSysName": sysName,
            "ADAS_strStartTime": startTime,
            "ADAS_strStopTime": stopTime,
            "ADAS_uTotalTimeS": totalTime,
            "ADAS_uType": type,
            "ADAS_uStatus": status
        ]
    }
}
