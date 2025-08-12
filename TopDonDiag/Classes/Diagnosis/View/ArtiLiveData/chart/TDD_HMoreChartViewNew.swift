//
//  TDD_HMoreChartViewNew.swift
//  TopdonDiagnosis
//
//  Created by hkr on 2022/9/14.
//

import UIKit
import SnapKit

@objcMembers
public class TDD_HMoreChartViewNew: UIView {
    
    // MARK: - Properties
   public var valueArr: [[Any]]? {
        didSet {
            updateChartViews()
        }
    }
    
    // MARK: - UI Components
    private lazy var showDataChartView1: TDD_HChartViewNew = {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.colorArr = [colorArr[0], colorArr[1]]
        chartView.chartType = .noYLine
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return chartView
    }()
    
    private lazy var showDataChartView2: TDD_HChartViewNew = {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.colorArr = [colorArr[2], colorArr[3]]
        chartView.chartType = .noYNoLine
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return chartView
    }()
    
    private lazy var outYChartView: TDD_HChartViewNew = {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.chartType = .oneOutY
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return chartView
    }()
    
    private lazy var inYChartView: TDD_HChartViewNew = {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.chartType = .oneInY
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return chartView
    }()
    
    private lazy var colorArr: [UIColor] = { TDD_DiagBridge.chart4Colors() }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Chart Update Logic
    private func updateChartViews() {
        guard let valueArr = valueArr else { return }
        
        let count = valueArr.count
        
        if count < 3 {
            // Handle 1-2 data streams
            showDataChartView2.isHidden = true
            inYChartView.isHidden = true
            
            showDataChartView1.valueArr = valueArr
            outYChartView.valueArr = valueArr
            
            if count <= 1 {
                outYChartView.chartType = .oneOutY
                
                showDataChartView1.setExtraOffsets(
                    left: outYChartView.getLeftAxisRequiredSize().width,
                    top: 0,
                    right: 0,
                    bottom: 0
                )
            } else {
                outYChartView.chartType = .twoOutY
                
                showDataChartView1.setExtraOffsets(
                    left: outYChartView.getLeftAxisRequiredSize().width,
                    top: 0,
                    right: outYChartView.getRightAxisRequiredSize().width,
                    bottom: 0
                )
            }
            
            outYChartView.setExtraOffsets(
                left: 0,
                top: 0,
                right: 0,
                bottom: showDataChartView1.getxAxisLabelHeight() + 4
            )
            
        } else {
            // Handle 3+ data streams
            var newValueArr = valueArr
            
            // First two data streams
            let firstTwo = Array(valueArr.prefix(2))
            showDataChartView1.valueArr = firstTwo
            outYChartView.valueArr = firstTwo
            
            // Remove first two and use remaining
            newValueArr.removeFirst(2)
            showDataChartView2.valueArr = newValueArr
            inYChartView.valueArr = newValueArr
            
            showDataChartView2.isHidden = false
            inYChartView.isHidden = false
            
            outYChartView.chartType = .twoOutY
            
            if count <= 3 {
                inYChartView.chartType = .oneInY
                
                let leftOffset = outYChartView.getLeftAxisRequiredSize().width + inYChartView.getLeftAxisRequiredSize().width
                let rightOffset = outYChartView.getRightAxisRequiredSize().width
                
                showDataChartView1.setExtraOffsets(
                    left: leftOffset,
                    top: 0,
                    right: rightOffset,
                    bottom: 0
                )
                
                showDataChartView2.setExtraOffsets(
                    left: leftOffset,
                    top: 0,
                    right: rightOffset,
                    bottom: 0
                )
                
            } else {
                inYChartView.chartType = .twoInY
                
                let leftOffset = outYChartView.getLeftAxisRequiredSize().width + inYChartView.getLeftAxisRequiredSize().width
                let rightOffset = outYChartView.getRightAxisRequiredSize().width + inYChartView.getRightAxisRequiredSize().width
                
                showDataChartView1.setExtraOffsets(
                    left: leftOffset,
                    top: 0,
                    right: rightOffset,
                    bottom: 0
                )
                
                showDataChartView2.setExtraOffsets(
                    left: leftOffset,
                    top: 0,
                    right: rightOffset,
                    bottom: 0
                )
            }
            
            outYChartView.setExtraOffsets(
                left: 0,
                top: 0,
                right: 0,
                bottom: showDataChartView1.getxAxisLabelHeight() + 4
            )
            
            inYChartView.setExtraOffsets(
                left: outYChartView.getLeftAxisRequiredSize().width,
                top: 0,
                right: outYChartView.getRightAxisRequiredSize().width,
                bottom: showDataChartView1.getxAxisLabelHeight() + 4
            )
        }
    }
} 
