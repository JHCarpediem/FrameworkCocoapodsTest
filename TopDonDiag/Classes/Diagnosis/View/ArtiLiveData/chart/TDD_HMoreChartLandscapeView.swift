//
//  TDD_HMoreChartLandscapeView.swift
//  TopdonDiagnosis
//
//  Created by hkr on 2022/9/14.
//

import UIKit
import SnapKit

@objcMembers
public class TDD_HMoreChartLandscapeView: UIView {
    
    // MARK: - Properties
    public var valueArr: [[Any]]? {
        didSet {
            if (valueArr?.count != oldValue?.count) && oldValue != nil {
                recreateAll()
            }
            
            updateChartViews()
        }
    }
    
    // showDataChartView1 为主图表，其余3个为从图表
    // X轴缩放：通过Pinch手势拦截处理
    // Y轴缩放：转发给主图表的Charts内置缩放
    
    // 平移相关属性
    private var lastPanPoint: CGPoint = .zero
    private var isDragging: Bool = false
    private var currentTranslationX: CGFloat = 0.0
    private var currentTranslationY: CGFloat = 0.0
    
    // 手势识别器
    private lazy var pinchGestureRecognizer: UIPinchGestureRecognizer = createPinchGesture()
    
    // 添加 pan 手势识别器属性
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = createPanGesture()
    
    // 手势状态跟踪
    private var isHandlingXAxisScaling: Bool = false
    private var accumulatedScaleX: Double = 1.0 // 累积的X轴缩放值
    
    // MARK: - UI Components
    
    private lazy var showDataChartView1: TDD_HChartViewNew = createShowDataChartView1()
    
    private lazy var showDataChartView2: TDD_HChartViewNew = createShowDataChartView2()
    
    private lazy var outYChartView: TDD_HChartViewNew = createOutYChartView()
    
    private lazy var inYChartView: TDD_HChartViewNew = createInYChartView()
    
    private lazy var colorArr: [UIColor] = { return TDD_DiagBridge.chart4Colors() }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(showDataChartView2)
        addSubview(outYChartView)
        addSubview(inYChartView)
        addSubview(showDataChartView1)
        
        setupMasterSlaveMode()
        
        setupGestures()
        
        showDataChartView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        showDataChartView2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        outYChartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        inYChartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupMasterSlaveMode() {
        showDataChartView1.setAsSlaveChart()
        showDataChartView2.setAsSlaveChart()
        outYChartView.setAsSlaveChart()
        inYChartView.setAsSlaveChart()
        
        // showDataChartView1 作为主图表
        showDataChartView1.setAsMasterChart()
        
        // 设置delegate的landscape view引用
        showDataChartView1.delegator.landscapeView = self
        
        // 禁用其他图表的用户交互，只允许主图表响应
        showDataChartView1.isUserInteractionEnabled = false // 主图表启用交互
        showDataChartView2.isUserInteractionEnabled = false
        outYChartView.isUserInteractionEnabled = false
        inYChartView.isUserInteractionEnabled = false
    }
    
    private func setupGestures() {
        pinchGestureRecognizer.delegate = self
        addGestureRecognizer(pinchGestureRecognizer)
        
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        isUserInteractionEnabled = true
    }
    
    // MARK: - create UI
    private func createShowDataChartView1() -> TDD_HChartViewNew {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.colorArr = [colorArr[0], colorArr[1]]
        chartView.chartType = .noYLine
        return chartView
    }
    
    private func createShowDataChartView2() -> TDD_HChartViewNew {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.colorArr = [colorArr[2], colorArr[3]]
        chartView.chartType = .noYNoLine
        return chartView
    }
    
    private func createOutYChartView() -> TDD_HChartViewNew {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.chartType = .oneOutY
        return chartView
    }
    
    private func createInYChartView() -> TDD_HChartViewNew {
        let chartView = TDD_HChartViewNew(showType: .more)
        chartView.chartType = .oneInY
        return chartView
    }
    
    private func createPinchGesture() -> UIPinchGestureRecognizer {
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        return pinchGestureRecognizer
    }
    
    private func createPanGesture() -> UIPanGestureRecognizer {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        panGestureRecognizer.maximumNumberOfTouches = 1
        return panGestureRecognizer
    }
    
    private func prepareForRecreate() {
        lastPanPoint = .zero
        isDragging = false
        currentTranslationX = 0.0
        currentTranslationY = 0.0
        
        isHandlingXAxisScaling = false
        accumulatedScaleX = 1.0
        
        subviews.forEach { $0.removeFromSuperview() }
        
        pinchGestureRecognizer.removeTarget(self, action: #selector(handlePinch(_:)))
        removeGestureRecognizer(pinchGestureRecognizer)
        panGestureRecognizer.removeTarget(self, action: #selector(handlePan(_:)))
        removeGestureRecognizer(panGestureRecognizer)
        
        isUserInteractionEnabled = false
        
        layoutIfNeeded()
    }
    
    private func recreateAll() {
        prepareForRecreate()
        
        showDataChartView1 = createShowDataChartView1()
        showDataChartView2 = createShowDataChartView2()
        outYChartView = createOutYChartView()
        inYChartView = createInYChartView()
        
        pinchGestureRecognizer = createPinchGesture()
        panGestureRecognizer = createPanGesture()
        
        setupViews()
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
    
    func syncYAxisScaling(scaleY: Double, location: CGPoint) {
        
        let slaveCharts = [showDataChartView2, outYChartView, inYChartView]
        
        for chart in slaveCharts {
            let salveLocation = self.convert(location, to: showDataChartView1)
            chart.applyYAxisScaling(scaleY: scaleY, scaleX: scaleY, location: salveLocation)
        }
    }
    
    func syncXAxisScaling(scaleX: Double, location: CGPoint) {
        
        let slaveCharts = [showDataChartView2, outYChartView, inYChartView]
        
        for chart in slaveCharts {
            let salveLocation = self.convert(location, to: showDataChartView1)
            chart.applyXAxisScaling(scaleX: scaleX, scaleY: 1.0, location: salveLocation)
        }
    }
}

extension TDD_HMoreChartLandscapeView: UIGestureRecognizerDelegate {
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.numberOfTouches >= 2 else { return }
        
        switch gesture.state {
        case .began:
            // 判断是否为水平缩放
            let p1 = gesture.location(ofTouch: 0, in: self)
            let p2 = gesture.location(ofTouch: 1, in: self)
            
            let dx = abs(p1.x - p2.x)
            let dy = abs(p1.y - p2.y)
            
            isHandlingXAxisScaling = dx > dy * 1.5 // 水平距离明显大于垂直距离
            
            if isHandlingXAxisScaling {
                // 拦截X轴缩放，禁用主图表的手势识别
                showDataChartView1.lineChartView.isUserInteractionEnabled = false
                // 重置累积缩放值
                accumulatedScaleX = 1.0
            } else {
                // 转发给主图表处理Y轴缩放
                showDataChartView1.lineChartView.isUserInteractionEnabled = false
            }
            
        case .changed:
            if isHandlingXAxisScaling {
                // 累积缩放值
                let incrementalScale = Double(gesture.scale)
                accumulatedScaleX *= incrementalScale
                
                // 应用累积的X轴缩放到所有图表
                let location = gesture.location(in: self)
                let masterPoint = self.convert(location, to: showDataChartView1)
                let scale = gesture.scale
                
                showDataChartView1.applyXAxisScaling(scaleX: accumulatedScaleX, scaleY: 1.0, location: masterPoint)
                syncXAxisScaling(scaleX: accumulatedScaleX, location: location)
                
                gesture.scale = 1.0 // 重置scale避免累积
            }
            // 如果不是X轴缩放，手势会自动转发给主图表
            else {
                
                let location = gesture.location(in: self)
                let masterPoint = self.convert(location, to: showDataChartView1)
                let scale = gesture.scale
                showDataChartView1.applyYAxisScaling(scaleY: scale, scaleX: scale, location: masterPoint)
                syncYAxisScaling(scaleY: scale, location: location)
            }
            
        case .ended, .cancelled:
            // 重置状态
            isHandlingXAxisScaling = false
            showDataChartView1.lineChartView.isUserInteractionEnabled = false
            
        default:
            break
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            // 检查是否可以平移
            guard canPan() else {
                return
            }
            
            // 开始平移
            isDragging = true
            lastPanPoint = gesture.translation(in: view)
        case .changed:
            if isDragging {
                let originalTranslation = gesture.translation(in: view)
                let translation = CGPoint(
                    x: originalTranslation.x - lastPanPoint.x,
                    y: originalTranslation.y - lastPanPoint.y
                )
                
                // 执行平移变换
                let _ = performPanChange(translation: translation)
                
                lastPanPoint = originalTranslation
            }
            
        case .ended, .cancelled:
            if isDragging {
                if gesture.state == .ended && isDragDecelerationEnabled() {
                    
                }
                isDragging = false
            }
            
        default:
            break
        }
    }
    
    // 允许手势同时识别
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 允许捏合和平移手势同时工作
        if (gestureRecognizer is UIPinchGestureRecognizer && otherGestureRecognizer is UIPanGestureRecognizer) ||
            (gestureRecognizer is UIPanGestureRecognizer && otherGestureRecognizer is UIPinchGestureRecognizer) {
            return true
        }
        
        return false
    }
    
    // 确保手势能够开始识别
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // 简化平移检查，只要有数据就允许平移
    private func canPan() -> Bool {
        return valueArr != nil && !valueArr!.isEmpty
    }
    
    private func performPanChange(translation: CGPoint) -> Bool {
        // 应用平移变换
        let dX = translation.x
        let dY = translation.y
        
        currentTranslationX += dX
        currentTranslationY += dY
        
        // 限制平移范围
        let maxTranslationX: CGFloat = 1000.0
        let maxTranslationY: CGFloat = 500.0
        
        currentTranslationX = max(-maxTranslationX, min(currentTranslationX, maxTranslationX))
        currentTranslationY = max(-maxTranslationY, min(currentTranslationY, maxTranslationY))
        
        updateTranslation(dX: dX, dY: dY)
        
        return true
    }
    
    private func isDragDecelerationEnabled() -> Bool {
        return true
    }
    
    private func updateTranslation(dX: CGFloat, dY: CGFloat) {
        // 应用平移变换到所有图表
        showDataChartView1.update(translationX: dX, translationY: dY)
        showDataChartView2.update(translationX: dX, translationY: dY)
        outYChartView.update(translationX: dX, translationY: dY)
        inYChartView.update(translationX: dX, translationY: dY)
    }
}
