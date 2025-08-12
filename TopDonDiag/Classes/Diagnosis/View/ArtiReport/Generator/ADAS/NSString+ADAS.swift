//
//  NSString+ADAS.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/25.
//

import Foundation

@objc public extension NSString {
    
    /// Before maintenance to Before the calibration
    func replaceBeforeMaintenanceToCalibration() -> NSString {
        var str: String = self as String
        return str.beforeMaintenanceToCalibration() as NSString
    }
    
    /// After maintenance to After the calibration
    func replaceAfterMaintenanceToCalibration() -> NSString {
        var str: String = self as String
        return str.afterMaintenanceToCalibration() as NSString
    }
    
}

extension String {
    
    @discardableResult
    mutating func beforeMaintenanceToCalibration() -> String {
        self = replacingOccurrences(of: "维修前", with: "校准前")
        return self
    }
    
    @discardableResult
    mutating func afterMaintenanceToCalibration() -> String {
        self = replacingOccurrences(of: "维修后", with: "校准后")
        return self
    }
}
