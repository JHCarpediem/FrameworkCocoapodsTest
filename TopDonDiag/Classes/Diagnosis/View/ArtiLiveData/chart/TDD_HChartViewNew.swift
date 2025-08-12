//
//  TDD_HChartViewNew.swift
//  TopdonDiagnosis
//
//  Created by 何可人 on 2022/3/4.
//

import UIKit
import SnapKit
import JHCampoCharts
import TDUIProvider
import YYModel

@objc
open class TDD_HChartViewNew: UIView {
    
    // MARK: - Properties
    @objc public var valueArr: [Any]? {
        didSet {
            //logBluetoothAD200("TDD_HChartView set valueArr: \(valueArr ?? [])()")
            updateChartData()
        }
    }
    
    @objc public var showType: ShowType = .liveData {
        didSet {
            updateShowType()
        }
    }
    
    @objc public var chartType: ChartType = .oneOutY {
        didSet {
            updateChartType()
        }
    }
    
    @objc public lazy var colorArr: [UIColor]? = TDD_DiagBridge.chart4Colors() {
        didSet {
            updateChartColors()
        }
    }
    
    @objc public var startTime: TimeInterval = 0
    
    private var scaleX: CGFloat = 1.0
    
    private let kMinScaleX: CGFloat = 0.5
    private let kMaxScaleX: CGFloat = 3.0
    private let kMinScaleY: CGFloat = 1.0
    private let kMaxScaleY: CGFloat = 3.0
    
    // 控制是否在数据刷新时自动吸附到X轴
    private var shouldAutoAdjustToXAxis: Bool = true
    
    private(set) lazy var delegator: TDD_HChartViewDelegator = {
        let delegator = TDD_HChartViewDelegator()
        delegator.masterChartView = self
        return delegator
    }()
    
    // MARK: - UI Components
    private(set) lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = delegator
        chartView.dragEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.scaleYEnabled = false
        chartView.scaleXEnabled = false
        chartView.gridBackgroundColor = .clear
        chartView.borderColor = .clear
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        chartView.noDataText = TDDLocalized.home_no_data_tips
        chartView.noDataTextColor = UIColor.tdd_subTitle()
        chartView.legend.enabled = false
        chartView.dragEnabled = true
        chartView.dragDecelerationEnabled = true
        chartView.dragDecelerationFrictionCoef = 0.9
        
        // Configure axes
        configureAxes(chartView)
        
        // Create initial data sets
        let sets = createInitialDataSets()
        let data = LineChartData(dataSets: sets)
        chartView.data = data
        
        return chartView
    }()
    
    private var selectEntry: ChartDataEntry?
    
    // MARK: - Initialization
    @objc
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChart()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChart()
    }
    
    @objc
    required public init(showType: ShowType) {
        self.showType = showType
        super.init(frame: .zero)
        setupChart()
        self.updateShowType()
    }
    
    // MARK: - Setup
    private func setupChart() {
        addSubview(lineChartView)
        
        lineChartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func configureAxes(_ chartView: LineChartView) {
        // Right Axis
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false
        rightAxis.axisLineColor = UIColor.tdd_color666666()
        rightAxis.labelTextColor = UIColor.tdd_subTitle()
        rightAxis.labelFont = UIFont.systemFont(ofSize: 10).tdd_adaptHD()
        rightAxis.valueFormatter = TDD_DateValueFormatterNew()
        rightAxis.gridColor = .clear
        rightAxis.labelCount = 5
        rightAxis.granularity = 1
        rightAxis.decimals = 2
        rightAxis.granularityEnabled = true
        rightAxis.forceLabelsEnabled = true
        
        // Left Axis
        let leftAxis = chartView.leftAxis
        leftAxis.axisLineColor = UIColor.tdd_color666666()
        leftAxis.labelTextColor = UIColor.tdd_subTitle()
        leftAxis.drawGridLinesBehindDataEnabled = false
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10).tdd_adaptHD()
        leftAxis.valueFormatter = TDD_DateValueFormatterNew()
        leftAxis.gridColor = UIColor.tdd_color(withHex: 0xE9E9E9)
        leftAxis.gridLineDashLengths = [1, 1]
        leftAxis.labelCount = 5
        leftAxis.granularity = 1
        leftAxis.decimals = 2
        leftAxis.granularityEnabled = true
        leftAxis.forceLabelsEnabled = true
        
        // X Axis
        let xAxis = chartView.xAxis
        xAxis.axisLineColor = UIColor.tdd_color666666()
        xAxis.gridColor = UIColor.tdd_color(withHex: 0xE9E9E9)
        xAxis.gridLineDashLengths = [1, 1]
        xAxis.drawGridLinesBehindDataEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 7
        xAxis.granularity = TDD_DiagBridge.isKindOfTopVCIValue() ? 10 : 5
        xAxis.granularityEnabled = true
        xAxis.labelTextColor = UIColor.tdd_subTitle()
        xAxis.labelFont = UIFont.systemFont(ofSize: 10).tdd_adaptHD()
        xAxis.valueFormatter = TDD_DateValueFormatterNew()
    }
    
    private func createInitialDataSets() -> [LineChartDataSet] {
        let set1 = createDataSet(yValues: [], color: UIColor.tdd_blue())
        let set2 = createDataSet(yValues: [], color: UIColor.tdd_blue())
        set2.axisDependency = .right
        return [set1, set2]
    }
    
    private func createDataSet(yValues: [ChartDataEntry], color: UIColor) -> LineChartDataSet {
        let set = LineChartDataSet(entries: yValues, label: "")
        set.mode = .horizontalBezier
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.drawValuesEnabled = false
        set.highlightEnabled = true
        set.highlightColor = color
        set.highlightLineDashLengths = [2, 2]
        set.highlightLineWidth = 1
        set.drawCirclesEnabled = true
        set.cubicIntensity = 0.2
        set.circleRadius = 1.0
        set.drawCircleHoleEnabled = false
        set.circleHoleRadius = 4.0
        set.circleHoleColor = .white
        set.circleColors = [color]
        set.setColor(color)
        
        if showType != .more {
            set.drawFilledEnabled = true
            let gradientColors = [color.cgColor, color.withAlphaComponent(0).cgColor]
            if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors as CFArray, locations: nil) {
                set.fillAlpha = 1
                set.fill = Fill(linearGradient: gradient, angle: -90)
            }
        } else {
            set.highlightEnabled = false // more 模式下不显示虚线
        }
        
        return set
    }
    
    // MARK: - Update Methods
    private func updateShowType() {
        
        if showType == .freqWave {
            lineChartView.xAxis.drawLabelsEnabled = false
            lineChartView.leftAxis.drawLabelsEnabled = false
        }
        
        /// 填充样式
        guard let data = lineChartView.data else { return }
        let color = UIColor.tdd_blue()
        for dataSet in data.dataSets {
            if let set = dataSet as? LineChartDataSet {
                if showType.isShowFill {
                    set.drawFilledEnabled = true
                    let gradientColors = [color.cgColor, color.withAlphaComponent(0).cgColor]
                    if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors as CFArray, locations: nil) {
                        set.fillAlpha = 1
                        set.fill = Fill(linearGradient: gradient, angle: -90)
                    }
                } else {
                    set.drawFilledEnabled = false
                }
            }
        }
        
    }
    
    private func updateChartData() {
        guard let valueArr = valueArr else { return }
        
        // Update formatter start time
        if let xFormatter = lineChartView.xAxis.valueFormatter as? TDD_DateValueFormatterNew {
            xFormatter.startTime = startTime
        }
        
        // Clear existing data
        if let set1 = lineChartView.data?.dataSets[0] as? LineChartDataSet {
            set1.clear()
        }
        if let set2 = lineChartView.data?.dataSets[1] as? LineChartDataSet {
            set2.clear()
        }
        
        // Process data
        for j in 0..<min(valueArr.count, 2) {
            guard let arr = valueArr[j] as? [Any] else { continue }
            
            var dataArr: [ChartDataEntry] = []
            var startTime: TimeInterval = 0
            var endTime: TimeInterval = 0
            
            for (i, item) in arr.enumerated() {
                var model: TDD_HChartModel
                
                if let dict = item as? [String: Any] {
                    model = TDD_HChartModel.yy_model(with: dict) ?? TDD_HChartModel()
                } else if let chartModel = item as? TDD_HChartModel {
                    model = chartModel
                } else {
                    continue
                }
                
                let entry = ChartDataEntry(x: model.time, y: Double(model.value))
                dataArr.append(entry)
                
                if i == 0 {
                    startTime = model.time
                }
                
                if i == arr.count - 1 {
                    let valueStrArr = model.valueStrArr
                    if valueStrArr.count != 0 {
                        if j == 0 {
                            lineChartView.leftAxis.labelCount = valueStrArr.count + 2
                            if let leftFormatter = lineChartView.leftAxis.valueFormatter as? TDD_DateValueFormatterNew {
                                leftFormatter.valueStrArr = valueStrArr as? [String] ?? []
                            }
                        } else {
                            lineChartView.rightAxis.labelCount = valueStrArr.count + 2
                            if let rightFormatter = lineChartView.rightAxis.valueFormatter as? TDD_DateValueFormatterNew {
                                rightFormatter.valueStrArr = valueStrArr as? [String] ?? []
                            }
                        }
                    } else {
                        lineChartView.leftAxis.labelCount = 5
                        lineChartView.rightAxis.labelCount = 5
                        
                        if showType == .freqWave {
                            lineChartView.leftAxis.labelCount = 10
                            lineChartView.rightAxis.labelCount = 6
                            lineChartView.xAxis.granularity = 1
                        }
                        
                        lineChartView.leftAxis.granularityEnabled = true
                        lineChartView.leftAxis.forceLabelsEnabled = true
                        lineChartView.rightAxis.granularityEnabled = true
                        lineChartView.rightAxis.forceLabelsEnabled = true
                        
                        if let leftFormatter = lineChartView.leftAxis.valueFormatter as? TDD_DateValueFormatterNew {
                            leftFormatter.valueStrArr = []
                        }
                        if let rightFormatter = lineChartView.rightAxis.valueFormatter as? TDD_DateValueFormatterNew {
                            rightFormatter.valueStrArr = []
                        }
                    }
                    
                    endTime = model.time
                    
                    let xMin: Double
                    let xMax: Double
                    if showType == .freqWave {
                        if endTime - startTime > 6 {
                            xMin = endTime - 6
                            xMax = endTime
                        } else {
                            xMin = startTime
                            xMax = startTime + 6
                        }
                        
                        setXMin(xMin, xMax: xMax)
                    } else {
                        if endTime - startTime > 30 {
                            xMin = endTime - 29
                            xMax = endTime + 1
                        } else {
                            xMin = startTime
                            xMax = startTime + 30
                        }
                        
                        // 放大缩小
                        //let scalXMax = max(xMin, scaleX * xMax)
                        let scalXMax: Double
                        if scaleX < 1.0 {
                            scalXMax = max(xMin, xMax / scaleX)
                        } else {
                            scalXMax = xMax
                        }
                        
                        setXMin(xMin, xMax: scalXMax)
                    }
                    
                }
            }
            
            if dataArr.isEmpty { continue }
            
            let (minY, maxY, minX, maxX) = dataArr.tdd_getMinMaxvalue()
            
            // 安全检查：确保Y轴值是有效的
            let safeMinY = minY.isFinite ? minY : 0.0
            let safeMaxY = maxY.isFinite ? maxY : 1.0
            
            if j == 0 {
                safeSetAxisMinMax(axis: lineChartView.leftAxis, min: safeMinY, max: safeMaxY)
                if (valueArr.count <= 1) {
                    safeSetAxisMinMax(axis: lineChartView.rightAxis, min: 0, max: 0)
                }
                
                if let lineData = lineChartView.lineData {
                    setYInterval(yAxis: lineChartView.leftAxis, lineData: lineData, index: 0, isNumber: true)
                }
                
                lineChartView.setNeedsDisplay()
            } else {
                safeSetAxisMinMax(axis: lineChartView.rightAxis, min: safeMinY, max: safeMaxY)
                
                if let lineData = lineChartView.lineData {
                    setYInterval(yAxis: lineChartView.rightAxis, lineData: lineData, index: 1, isNumber: true)
                }
                
                lineChartView.setNeedsDisplay()
            }
            
            if ((lineChartView.data?.dataSets.count ?? 0) > j) {
                guard let set = lineChartView.data?.dataSets[j] as? LineChartDataSet else {
                    return
                }
                set.replaceEntries(dataArr)
            }
            
        }
        
        setLineChartXAxisGranularity()
        //
        //        lineChartView.setVisibleXRangeMinimum(Double(mScaleX))
        //        lineChartView.setVisibleXRangeMaximum(Double(mScaleX))
        
        
        updateChart()
        
        // 只有在需要自动吸附时才执行吸附操作
        if shouldAutoAdjustToXAxis, let data = lineChartView.data {
            lineChartView.moveViewToX(data.xMax)
        }
    }
    
    private func fixupLimitX(value: CGFloat) -> CGFloat {
        
        var result = max(kMinScaleX, min(kMaxScaleX, value))
        
        return result
    }
    
    private func fixupLimitY(value: CGFloat) -> CGFloat {
        
        let newValue = max(kMinScaleY, min(kMaxScaleY, value))
        
        return newValue
    }
    
    func applyXAxisScaling(scaleX: Double, scaleY: Double, location: CGPoint) {
        logBluetoothAD200("scaleY: \(scaleY), scaleX: \(scaleX)")
        guard hasData() else { return }
        
        let limitedScaleX = max(kMinScaleX, min(scaleX, kMaxScaleX))
        
        // 应用X轴缩放变换，直接操作视图端口处理器
        guard let viewPortHandler = lineChartView.viewPortHandler else { return }
        
        viewPortHandler.setMinMaxScaleX(minScaleX: kMinScaleX, maxScaleX: kMaxScaleX)
        viewPortHandler.setMinMaxScaleY(minScaleY: kMinScaleY, maxScaleY: kMaxScaleY)
        
        // 与当前变换矩阵合并，Y轴保持原样，只对X轴进行缩放
        let currentMatrix = viewPortHandler.touchMatrix
        
        let newMatrixA = currentMatrix.a * CGFloat(limitedScaleX) // X轴缩放
        let newA = fixupLimitX(value: newMatrixA)
        self.scaleX = newA
        
        let newMatrix = CGAffineTransform(
            a: newA,
            b: currentMatrix.b,
            c: currentMatrix.c,
            d: 1.0, // Y轴保持不变
            tx: currentMatrix.tx,
            ty: currentMatrix.ty
        )
        
        // 应用新矩阵并重绘
        viewPortHandler.refresh(newMatrix: newMatrix, chart: lineChartView, invalidate: true)
        
        //        setLineChartXAxisGranularity()
        //        lineChartView.setVisibleXRangeMinimum(Double(mScaleX))
        //        lineChartView.setVisibleXRangeMaximum(Double(mScaleX))
    }
    
    func applyYAxisScaling(scaleY: Double, scaleX: Double, location: CGPoint) {
        logBluetoothAD200("scaleY: \(scaleY), scaleX: \(scaleX)")
        guard hasData() else { return }
        
        let limitedScaleY = max(kMinScaleY, min(scaleY, kMaxScaleY))
        let limitedScaleX = max(kMinScaleX, min(scaleX, kMaxScaleX))
        
        // 应用Y轴缩放变换，直接操作视图端口处理器
        guard let viewPortHandler = lineChartView.viewPortHandler else { return }
        
        viewPortHandler.setMinMaxScaleX(minScaleX: kMinScaleX, maxScaleX: kMaxScaleX)
        viewPortHandler.setMinMaxScaleY(minScaleY: kMinScaleY, maxScaleY: kMaxScaleY)
        
        // 创建以中心点为基准的缩放变换
        var matrix = CGAffineTransform(translationX: location.x, y: location.y)
        matrix = matrix.scaledBy(x: CGFloat(limitedScaleX), y: CGFloat(limitedScaleY))
        matrix = matrix.translatedBy(x: -location.x, y: -location.y)
        
        // 与当前变换矩阵合并
        let newMatrix = viewPortHandler.touchMatrix.concatenating(matrix)
        
        let newA = fixupLimitX(value: newMatrix.a)
        let newD = fixupLimitY(value: newMatrix.d)
        
        let resultScale = max(1.0, min(newA, newD))
        
        self.scaleX = resultScale
        
        let limitMatrix = CGAffineTransform(resultScale,
                                            newMatrix.b,
                                            newMatrix.c,
                                            resultScale,
                                            newMatrix.tx,
                                            newMatrix.ty)
        
        // 应用新矩阵并重绘
        viewPortHandler.refresh(newMatrix: limitMatrix, chart: lineChartView, invalidate: true)
        
        setLineChartXAxisGranularity()
        //        lineChartView.setVisibleXRangeMinimum(Double(mScaleX))
        //        lineChartView.setVisibleXRangeMaximum(Double(mScaleX))
        
        // 计算并应用补偿平移，确保图形在X轴之上
        adjustChartToXAxis(lineChartView)
        
        // 缩放后重新启用自动吸附
        shouldAutoAdjustToXAxis = true
    }
    
    func update(translationX: CGFloat, translationY: CGFloat) {
        guard hasData() else { return }
        
        // 应用平移变换到图表，直接操作视图端口处理器
        guard let viewPortHandler = lineChartView.viewPortHandler else { return }
        
        // 创建平移变换矩阵
        let matrix = CGAffineTransform(translationX: translationX, y: translationY)
        
        // 与当前变换矩阵合并
        let newMatrix = viewPortHandler.touchMatrix.concatenating(matrix)
        
        // 取消 X 轴 之上
        cancelAdjustToXAxis()
        
        // 应用新矩阵并重绘
        viewPortHandler.refresh(newMatrix: newMatrix, chart: lineChartView, invalidate: true)
    }
    
    
    private func adjustChartToXAxis(_ chartView: ChartViewBase) {
        guard let lineChart = chartView as? LineChartView else { return }
        
        // 获取当前的 Y 轴范围
        let yAxis = lineChart.leftAxis
        let minY = yAxis.axisMinimum
        let maxY = yAxis.axisMaximum
        
        // 获取当前中心 X 值
        let midX = (lineChart.lowestVisibleX + lineChart.highestVisibleX) / 2
        
        // 以当前 X 轴中心，Y 轴最小值进行居中（对齐 x 轴底部）
        lineChart.centerViewTo(xValue: midX, yValue: minY, axis: .left)
    }
    
    private func cancelAdjustToXAxis() {
        // 取消 Charts 的 viewport job，防止自动吸附
        lineChartView.clearAllViewportJobs()
        
        // 禁用自动吸附，让用户可以自由平移
        shouldAutoAdjustToXAxis = false
    }
    
    private func updateChartType() {
        let leftAxis = lineChartView.leftAxis
        let rightAxis = lineChartView.rightAxis
        let xAxis = lineChartView.xAxis
        
        xAxis.enabled = false
        leftAxis.gridColor = .clear
        leftAxis.maxWidth = 0
        
        let set1 = lineChartView.data?.dataSets[0] as? LineChartDataSet
        let set2 = lineChartView.data?.dataSets[1] as? LineChartDataSet
        
        let color1 = colorArr?.first ?? UIColor.tdd_colorDiagTheme()
        let color2 = colorArr?.count ?? 0 > 1 ? colorArr![1] : UIColor.tdd_colorDiagTheme()
        
        switch chartType {
        case .oneOutY:
            leftAxis.enabled = true
            rightAxis.enabled = false
            leftAxis.labelTextColor = colorArr?.first ?? .black
            rightAxis.labelTextColor = colorArr?.count ?? 0 > 1 ? colorArr![1] : .black
            leftAxis.labelPosition = .outsideChart
            rightAxis.labelPosition = .outsideChart
            set1?.setColor(.clear)
            set1?.circleColors = [.clear]
            set2?.setColor(.clear)
            set2?.circleColors = [.clear]
            
        case .twoOutY:
            leftAxis.enabled = true
            rightAxis.enabled = true
            leftAxis.labelTextColor = colorArr?.first ?? .black
            rightAxis.labelTextColor = colorArr?.count ?? 0 > 1 ? colorArr![1] : .black
            leftAxis.labelPosition = .outsideChart
            rightAxis.labelPosition = .outsideChart
            set1?.setColor(.clear)
            set1?.circleColors = [.clear]
            set2?.setColor(.clear)
            set2?.circleColors = [.clear]
            
        case .oneInY:
            leftAxis.enabled = true
            rightAxis.enabled = false
            leftAxis.labelTextColor = colorArr?.count ?? 0 > 2 ? colorArr![2] : .black
            rightAxis.labelTextColor = colorArr?.count ?? 0 > 3 ? colorArr![3] : .black
            leftAxis.axisLineColor = .clear
            rightAxis.axisLineColor = .clear
            leftAxis.labelPosition = .insideChart
            rightAxis.labelPosition = .insideChart
            set1?.setColor(.clear)
            set1?.circleColors = [.clear]
            set2?.setColor(.clear)
            set2?.circleColors = [.clear]
            
        case .twoInY:
            leftAxis.enabled = true
            rightAxis.enabled = true
            leftAxis.labelTextColor = colorArr?.count ?? 0 > 2 ? colorArr![2] : .black
            rightAxis.labelTextColor = colorArr?.count ?? 0 > 3 ? colorArr![3] : .black
            leftAxis.axisLineColor = .clear
            rightAxis.axisLineColor = .clear
            leftAxis.labelPosition = .insideChart
            rightAxis.labelPosition = .insideChart
            set1?.setColor(.clear)
            set1?.circleColors = [.clear]
            set2?.setColor(.clear)
            set2?.circleColors = [.clear]
            
        case .noYLine:
            leftAxis.enabled = true
            rightAxis.enabled = false
            xAxis.enabled = true
            leftAxis.maxWidth = 0.0001
            leftAxis.axisLineColor = .clear
            leftAxis.labelTextColor = .clear
            leftAxis.gridColor = UIColor.tdd_color(withHex: 0xE9E9E9)
            set1?.setColor(color1)
            set1?.circleColors = [color1]
            set2?.setColor(color2)
            set2?.circleColors = [color2]
            
        case .noYNoLine:
            leftAxis.enabled = false
            rightAxis.enabled = false
            xAxis.enabled = true
            xAxis.axisLineColor = .clear
            xAxis.gridColor = .clear
            xAxis.labelTextColor = .clear
            set1?.setColor(color1)
            set1?.circleColors = [color1]
            set2?.setColor(color2)
            set2?.circleColors = [color2]
            
        default:
            break
        }
        
        updateChart()
    }
    
    private func updateChartColors() {
        // Colors are updated when chart type changes
        updateChartType()
    }
    
    private func updateChart() {
        if showType == .freqWave {
            lineChartView.leftAxis.axisMinimum = 0
            lineChartView.leftAxis.axisMaximum = 9
        }
        
        lineChartView.lineData?.notifyDataChanged()
        lineChartView.notifyDataSetChanged()
        safeSetAxisMinMax(axis: lineChartView.leftAxis, min: lineChartView.leftAxis.axisMinimum, max: lineChartView.leftAxis.axisMaximum)
        safeSetAxisMinMax(axis: lineChartView.rightAxis, min: lineChartView.rightAxis.axisMinimum, max: lineChartView.rightAxis.axisMaximum)
    }
    
    // MARK: - Public Methods
    func setXMin(_ xMin: TimeInterval, xMax: TimeInterval) {
        lineChartView.xAxis.axisMinimum = xMin
        lineChartView.xAxis.axisMaximum = xMax
        updateChart()
    }
    
    func getLeftAxisRequiredSize() -> CGSize {
        return lineChartView.leftAxis.requiredSize()
    }
    
    func getRightAxisRequiredSize() -> CGSize {
        return lineChartView.rightAxis.requiredSize()
    }
    
    func getxAxisLabelHeight() -> CGFloat {
        return lineChartView.xAxis.labelHeight
    }
    
    func setExtraOffsets(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        lineChartView.setExtraOffsets(left: left, top: top, right: right, bottom: bottom)
    }
    
    func hasData() -> Bool {
        guard let valueArr = self.valueArr, !valueArr.isEmpty else { return false }
        return true
    }
    
    func setAsMasterChart() {
        lineChartView.scaleYEnabled = true
        lineChartView.scaleXEnabled = false // X轴缩放通过手势拦截处理
        lineChartView.pinchZoomEnabled = true
        
        //        if let viewPortHandler = lineChartView.viewPortHandler {
        //            viewPortHandler.setMinMaxScaleY(minScaleY: kMaxScaleY, maxScaleY: kMaxScaleY)
        //        }
    }
    
    func setAsSlaveChart() {
        lineChartView.scaleYEnabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.pinchZoomEnabled = false
    }
    
    // 安全设置Y轴min/max，防止NaN
    private func safeSetAxisMinMax(axis: YAxis, min: Double, max: Double) {
        let safeMin = min.isFinite ? min : 0.0
        let safeMax = max.isFinite ? max : (safeMin + 1.0)
        axis.axisMinimum = safeMin
        axis.axisMaximum = safeMax > safeMin ? safeMax : (safeMin + 1.0)
    }
    
    private func setLineChartXAxisGranularity() {
        let xAxis = lineChartView.xAxis
        
        // 根据可见范围动态调整标签间距，避免重叠
        let visibleRange = xAxis.axisRange
        
        // 计算合适的标签数量，避免重叠
        let maxLabels = 8 // 最大标签数量
        let minLabels = 4 // 最小标签数量
        
        // 根据可见范围计算合适的标签间距
        var granularity: Double
        var labelCount: Int
        
        if visibleRange >= 200 {
            granularity = 30.0
            labelCount = 6
        } else if visibleRange >= 150 {
            granularity = 20.0
            labelCount = 7
        } else if visibleRange >= 100 {
            granularity = 15.0
            labelCount = 8
        } else if visibleRange >= 60 {
            granularity = 10.0
            labelCount = 8
        } else if visibleRange >= 30 {
            granularity = 5.0
            labelCount = 8
        } else if visibleRange >= 15 {
            granularity = 3.0
            labelCount = 4
        } else if visibleRange >= 10 {
            granularity = 2.0
            labelCount = 4
        } else {
            granularity = 1.0
            labelCount = 8
        }
        
        // 确保标签间距不会太小导致重叠
        let minGranularity = visibleRange / Double(maxLabels)
        granularity = max(granularity, minGranularity)
        
        xAxis.granularity = granularity
        xAxis.setLabelCount(labelCount, force: false)
        
        // 确保标签不会重叠
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.labelRotationAngle = 0 // 保持水平显示
        
        // 设置标签位置避免边缘裁剪
        xAxis.labelPosition = .bottom
        xAxis.yOffset = 5.0 // 给标签一些垂直间距
    }
    
    // 参考Android的setYInterval方法
    private func setYInterval(yAxis: YAxis, lineData: LineChartData, index: Int, isNumber: Bool) {
        // 安全检查：确保lineData的Y值是有效的
        guard lineData.yMax.isFinite && lineData.yMin.isFinite else {
            print("⚠️ setYInterval: Invalid Y values - yMin: \(lineData.yMin), yMax: \(lineData.yMax)")
            yAxis.axisMinimum = 0.0
            yAxis.axisMaximum = 1.0
            return
        }
        
        yAxis.setLabelCount(5, force: false)
        
        if lineData.yMax == lineData.yMin {
            if index == 2 || index == 3 {
                yAxis.yOffset = -3.0 // 设置Y轴标签偏移量
            }
        }
        
        yAxis.granularity = 10.0
        yAxis.granularity = 10.0
        
        if lineData.yMax == lineData.yMin {
            if lineData.yMax < 0 {
                let newMin = lineData.yMax * 1.2
                let newMax = lineData.yMax * 0.8
                yAxis.axisMinimum = newMin.isFinite ? newMin : -1.0
                yAxis.axisMaximum = newMax.isFinite ? newMax : 0.0
            } else {
                if isNumber {
                    if lineData.yMin < 10 {
                        yAxis.granularity = 1.0
                        let newMin = lineData.yMin * 0.8
                        let newMax = lineData.yMax * 1.2
                        yAxis.axisMinimum = newMin.isFinite ? newMin : 0.0
                        yAxis.axisMaximum = newMax.isFinite ? newMax : 1.0
                    }
                    
                    if lineData.yMin >= 10 && lineData.yMin < 20 {
                        yAxis.granularity = 5.0
                        yAxis.axisMinimum = 0
                        let newMax = lineData.yMax * 2.0
                        yAxis.axisMaximum = newMax.isFinite ? newMax : 20.0
                    } else {
                        let newMin = lineData.yMin * 0.8
                        let newMax = lineData.yMax * 1.2
                        yAxis.axisMinimum = newMin.isFinite ? newMin : 0.0
                        yAxis.axisMaximum = newMax.isFinite ? newMax : 1.0
                    }
                } else {
                    yAxis.axisMinimum = 0
                    let newMax = lineData.yMax * 2.0
                    yAxis.axisMaximum = newMax.isFinite ? newMax : 2.0
                }
            }
        } else {
            yAxis.resetCustomAxisMin()
            yAxis.resetCustomAxisMax()
        }
    }
    
    deinit {
        print("chart -- dealloc")
    }
}

// MARK: - 枚举

extension TDD_HChartViewNew {
    
    @objc(TDD_HChatViewChartType)
    public enum ChartType: Int {
        /// 1条外y轴，没x轴
        case oneOutY = 0
        /// 2条外y轴，没x轴
        case twoOutY
        /// 1条内y轴，没x轴
        case oneInY
        /// 2条内y轴，没x轴
        case twoInY
        /// 没有y轴，有线，有x轴
        case noYLine
        /// 没有y轴，没有线，有x轴
        case noYNoLine
    }
    
    @objc(TDD_HChatViewShowType)
    public enum ShowType: Int {
        /// 数据流页面
        case liveData = 0
        /// FreqWave页面
        case freqWave
        /// 组合图形页面
        case more
        
        /// 显示填充样式
        var isShowFill: Bool {
            if case .more = self {
                return false
            }
            return true
        }
        
    }
    
}

fileprivate extension Array where Element == ChartDataEntry {
    
    func tdd_getMinMaxvalue() -> (minY: Double, maxY: Double, minX: Double, maxX: Double) {
        // 如果数组为空，返回默认值避免NaN
        guard !self.isEmpty else {
            return (minY: 0.0, maxY: 1.0, minX: 0.0, maxX: 1.0)
        }
        
        var minY = Double.infinity
        var maxY = -Double.infinity
        
        var minX = Double.infinity
        var maxX = -Double.infinity
        
        for entry in self {
            if entry.y.isFinite && entry.y < minY {
                minY = entry.y
            }
            if entry.y.isFinite && entry.y > maxY {
                maxY = entry.y
            }
            
            if entry.x.isFinite && entry.x < minX {
                minX = entry.x
            }
            if entry.x.isFinite && entry.x > maxX {
                maxX = entry.x
            }
        }
        
        // 如果所有值都是无限值或NaN，返回默认值
        if !minY.isFinite { minY = 0.0 }
        if !maxY.isFinite { maxY = 1.0 }
        if !minX.isFinite { minX = 0.0 }
        if !maxX.isFinite { maxX = 1.0 }
        
        // 确保min <= max
        if minY > maxY { maxY = minY + 1.0 }
        if minX > maxX { maxX = minX + 1.0 }
        
        return (minY, maxY, minX, maxX)
    }
    
}

func logBluetoothAD200(_ message: String, file: String = #file, line: Int = #line) {
    let formateTime = DateFormatter()
    formateTime.dateFormat = "yyyy.MM.dd HH:mm:ss.SSS"
    let timestamp = formateTime.string(from: Date())
    
    let filename = (file as NSString).lastPathComponent
    let log = "\n⚪️【ChatView】\(timestamp) [\(line)] \(filename): \(message)"
    print(log)
}
