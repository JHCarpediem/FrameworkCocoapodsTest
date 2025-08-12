//
//  TDD_DateValueFormatterNew.swift
//  TopdonDiagnosis
//
//  Created by 何可人 on 2021/10/21.
//

import Foundation
import JHCampoCharts

@objcMembers
class TDD_DateValueFormatterNew: NSObject, IAxisValueFormatter {
    
    // MARK: - Properties
    var startTime: TimeInterval = 0
    var valueStrArr: [String] = []
    
    // MARK: - AxisValueFormatter
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var valueStr = ""
        
        if axis is ChartXAxis {
            // X-axis formatting - time format mm:ss
            valueStr = String(format: "%02d:%02d", Int(value) / 60, Int(value) % 60)
            
        } else if axis is ChartYAxis {
            // Y-axis formatting
            if !valueStrArr.isEmpty {
                let valueInt = Int(value) - 1
                
                if valueInt < valueStrArr.count {
                    valueStr = valueStrArr[valueInt]
                } else {
                    valueStr = ""
                }
                
            } else {
                // Default decimal formatting
                valueStr = String(format: "%.02f", round(value * 100) / 100.0)
            }
        }
        
        return valueStr
    }
} 
