//
//  Calculations.swift
//  
//
//  Created by Saeid on 2022-08-07.
//

import UIKit

public struct VicCalculations {
        
    /// 开始值
    let minValue: CGFloat
    /// 结束值
    let maxValue: CGFloat
    /// 长刻度第一格的大小
    let longSectionGapValue: CGFloat
    /// 短刻度第一格的大小
    let shortSectionGapValue: CGFloat
    /// 开始角度
    let startDegree: CGFloat
    /// 结束角度
    let endDegree: CGFloat

    /// 长刻度个数
    var longSeparationPoints: Int {
        Int((maxValue - minValue) / longSectionGapValue)
    }
    
    /// 短刻度个数
    var shortSeparationPoints: Int {
        Int((maxValue - minValue) / shortSectionGapValue)
    }
    
    /// 开始角度
    var calculatedStartDegree: CGFloat {
        270.0 - startDegree
    }

    /// 结束角度
    var calculatedEndDegree: CGFloat {
        return 270.0 - endDegree + 360
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
