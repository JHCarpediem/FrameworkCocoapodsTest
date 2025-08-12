//
//  TDD_HChartViewDelegator.swift
//  TopdonDiagnosis
//
//  Created by liuxinwen on 2025/7/30.
//

import UIKit
import JHCampoCharts

// MARK: - ChartViewDelegate
class TDD_HChartViewDelegator: NSObject, ChartViewDelegate {
    
    // 参考Android的主从模式：只有主图表的delegate会处理缩放回调
    weak var masterChartView: TDD_HChartViewNew?
    weak var landscapeView: TDD_HMoreChartLandscapeView?
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        // 处理图表选中事件
    }
    
    // 参考Android的onScale逻辑
    public func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        // 只有主图表才处理缩放事件
        guard let masterChart = masterChartView,
              let lineChart = chartView as? LineChartView,
              masterChart.lineChartView == lineChart else {
            return
        }
        
        // 注意：X轴缩放现在通过手势拦截处理，这里只处理Y轴缩放
        if scaleY != 1.0 {
            //landscapeView?.syncYAxisScaling(scaleY: Double(scaleY), fromChart: masterChart)
        }
        
        // 缩放后验证轴的值
        let xMin = chartView.xAxis.axisMinimum
        let xMax = chartView.xAxis.axisMaximum
        
        // 如果缩放后产生了无效值，重置缩放
        if !xMin.isFinite || !xMax.isFinite || xMin.isNaN || xMax.isNaN {
            print("TDD_HChartViewNew: Invalid axis values after zoom - xMin:\(xMin), xMax:\(xMax)")
            chartView.viewPortHandler?.resetZoom()
        }
    }
    
    public func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        // 平移后验证轴的值
        let xMin = chartView.xAxis.axisMinimum
        let xMax = chartView.xAxis.axisMaximum
        
        // 如果平移后产生了无效值，重置视图
        if !xMin.isFinite || !xMax.isFinite || xMin.isNaN || xMax.isNaN {
            print("TDD_HChartViewNew: Invalid axis values after translate - xMin:\(xMin), xMax:\(xMax)")
            chartView.viewPortHandler?.resetZoom()
        }
    }
    
}
