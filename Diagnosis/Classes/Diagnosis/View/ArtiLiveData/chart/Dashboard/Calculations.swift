//
//  Calculations.swift
//  
//
//  Created by Saeid on 2022-08-07.
//

import UIKit

public class Calculations : NSObject {
    
    /// 开始值
    @objc public var minValue: CGFloat = 0.0
    /// 结束值
    @objc public var maxValue: CGFloat = 100.0
    /// 长刻度第一格的大小
    @objc public var longSectionGapValue: CGFloat = 10.0
    /// 短刻度第一格的大小
    @objc public var shortSectionGapValue: CGFloat  = 1.0
    /// 开始角度
    @objc public var startDegree: CGFloat = 120.0
    /// 结束角度
    @objc public var endDegree: CGFloat = 60.0

    /// 长刻度个数
    var longSeparationPoints: Int {
        Int((maxValue - minValue) / longSectionGapValue)
    }
    
    /// 短刻度个数
    var shortSeparationPoints: Int {
        Int((maxValue - minValue) / shortSectionGapValue)
    }

    ///  开始角度
    var calculatedStartDegree: CGFloat {
        360 - startDegree 
    }

    /// 结束角度
    var calculatedEndDegree: CGFloat {
        360 - endDegree
    }

    /// 计算角度
    func calculateSectionDegree(for point: CGFloat, in separationPoints: Int) -> CGFloat {
        guard point != 0 else {
            return calculatedStartDegree
        }
        return point == CGFloat(separationPoints)
        ? calculatedEndDegree
        : calculatedStartDegree - ((360.0 - (calculatedEndDegree - calculatedStartDegree)) / CGFloat(separationPoints)) * point
    }
    
    
}
