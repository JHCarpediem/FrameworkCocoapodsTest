//
//  SpeedViewTest.swift
//  Demo002
//
//  Created by tangjilin on 2022/9/26.
//

import UIKit

public class SpeedViewTest: UIView {
    
    // MARK: - 中间模块
    
    /// 计算
    var calculations: CalculationsTest = {
        let calculations = CalculationsTest(minValue: 0, maxValue: 10, longSectionGapValue: 1, shortSectionGapValue: 0.1, startDegree: 120 - 90, endDegree: 420 - 90)
        return calculations
    }()
    
    /// 圆弧与父视图的间距
    @objc public var ringInset: CGFloat = 30
    
    /// 弧线的宽度
    var lineWidth: CGFloat = 2
    
    /// 长刻度长度
    var longIndicLength: CGFloat = 20
    
    /// 短刻度长度
    var shortIndicLength: CGFloat = 10
    
    /// 文字与圆环间隔
    let labelGap: CGFloat = 26

    /// 长刻度颜色
    var longIndicatorsColor: UIColor = UIColor(hex: "#91C6FE")
    
    /// 短刻度颜色
    var shortIndicatorsColor: UIColor = UIColor(hex: "#91C6FE")
    
    /// 字体
    var indicatorsFont: UIFont = UIFont.systemFont(ofSize: 13)
    
    /// 文字
    private var labelShapes: [CATextLayer] = []
    
    /// 长格进度条
    private var longIndicatorsShapes: [CAShapeLayer] = []
    
    /// 短格进度条
    private var shortIndicatorsShapes: [CAShapeLayer] = []
        
    /// 特殊颜色
    private var specialShapes: [[CAShapeLayer]] = [[], []]
    
    /// 外层大渐变圈
    private lazy var progressGradientRing: CAGradientLayer = {
        let shapeLayer = CAGradientLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 进度圆环
    private lazy var progressRing: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 内圈圆环
    private lazy var innerRing: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 主圆环
    private lazy var mainRing: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 背景圆环
    private lazy var backgroundRing: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 指针承载层
    private lazy var indicator: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 指针
    private lazy var pointer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()

    @objc public lazy var centerBgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = TDD_Tools.tdd_imageNamed("chart_center_bg")
        return imageView
    }()
    
    /// 单位
    @objc public lazy var mphuin: UILabel = {
        let mphlabel = TDD_CustomLabel()
        mphlabel.text = (Software.isTopVCI || TDD_DiagnosisTools.diagnosticUnit() == "metric") ? "km/h" : "MPH"
        mphlabel.textColor = .white
        mphlabel.font = .systemFont(ofSize: 10).adaptHD(size: 18)
        mphlabel.textAlignment = .center
        return mphlabel
    }()
    /// 速度值
    @objc public lazy var rotae: UILabel = {
        let speed = TDD_CustomLabel()
        speed.textColor = .white
        speed.font = .systemFont(ofSize: 30).adaptHD(size: 48)
        speed.textAlignment = .center
        speed.text = "00"
        return speed
    }()
    ///转速视图
    private lazy var bgrpmView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 3
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(hex: "#91C6FE").cgColor
        return bgView
    }()
    /// 转速值设置
    @objc public lazy var speedLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.textColor = UIColor(hex: "#FFFFFF")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 8).adaptHD(size: 14)
        label.text = "00"
        return label
    }()
    //RP×1000
    lazy var rplabel: UILabel = {
        let label = TDD_CustomLabel()
        label.textColor = UIColor(hex: "#4FE86F")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 8).adaptHD(size: 14)
        label.text = "X 1000 RPM"
        return label
    }()
    
    // hp 单位背景视图
    lazy var hpbgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 3
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(hex: "#91C6FE").cgColor
        return bgView
    }()
    
    // lb 单位背景视图
    lazy var lbbgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 3
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(hex: "#91C6FE").cgColor
        return bgView
    }()
    
    lazy var hplabel: UILabel = {
        let label = TDD_CustomLabel()
        label.textColor = UIColor(hex: "#FFFFFF")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16).adaptHD(size: 20)
        label.text = Software.isTopVCI ? "kW" : "HP"
        return label
    }()
    
    lazy var lblabel: UILabel = {
        let label = TDD_CustomLabel()
        label.textColor = UIColor(hex: "#FFFFFF")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16).adaptHD(size: 20)
        label.text = Software.isTopVCI ? "Nm" : "Ib•ft "
        return label
    }()
    
    // MARK: - 左模块
    
    /// 计算
    var leftCalculations: CalculationsTest = {
        let calculations = CalculationsTest(minValue: 0, maxValue: 500, longSectionGapValue: 100, shortSectionGapValue: 20, startDegree: 140 - 90, endDegree: 220 - 90)
        return calculations
    }()
    
    /// 左进度条
    private var leftIndicatorsShapes: [CAShapeLayer] = []
    
    /// 左短进度条
    private var leftShortIndicatorsShapes: [CAShapeLayer] = []
    
    /// 左进度条
    private var leftProgressIndicatorsShapes: [CAShapeLayer] = []
    
    /// 文字
    private var leftLabelShapes: [CATextLayer] = []
    
    /// 左边与中间的距离
    var leftGap: CGFloat = 30
    
    /// 左边刻度宽度
    var leftIndicatorWidth: CGFloat = 10
    
    /// 长刻度颜色
    var leftLongIndicatorsColor: UIColor = UIColor(hex: "#81AB83")
    
    /// 长刻度颜色
    var leftShortIndicatorsColor: UIColor = UIColor(hex: "#345335")
    
    /// 左进度颜色
    var leftProgressIndicatorsColor: UIColor = UIColor(hex: "#4AF353")

    /// 字体
    var leftIndicatorsFont: UIFont = UIFont.systemFont(ofSize: 13)
    
    /// 遮罩层
    private lazy var leftProgressGradientRing: CAGradientLayer = {
        let shapeLayer = CAGradientLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 进度圆环
    private lazy var leftProgressRing: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    // MARK: - 右模块
    
    /// 计算
    var rightCalculations: CalculationsTest = {
        let calculations = CalculationsTest(minValue: 0, maxValue: 500, longSectionGapValue: 100, shortSectionGapValue: 20, startDegree: 320 - 90, endDegree: 400 - 90)
        return calculations
    }()
    
    /// 右进度条
    private var rightIndicatorsShapes: [CAShapeLayer] = []
    
    /// 右短进度条
    private var rightShortIndicatorsShapes: [CAShapeLayer] = []
    
    /// 右进度条
    private var rightProgressIndicatorsShapes: [CAShapeLayer] = []

    /// 文字
    private var rightLabelShapes: [CATextLayer] = []
    
    /// 右边与中间的距离
    var rightGap: CGFloat = 30
    
    /// 右边刻度宽度
    var rightIndicatorWidth: CGFloat = 10
    
    /// 长刻度颜色
    var rightLongIndicatorsColor: UIColor = UIColor(hex: "#7993AD")
    
    /// 长刻度颜色
    var rightShortIndicatorsColor: UIColor = UIColor(hex: "#27476B")
    
    /// 右进度颜色
    var rightProgressIndicatorsColor: UIColor = UIColor(hex: "#91C6FE")
    
    /// 字体
    var rightIndicatorsFont: UIFont = UIFont.systemFont(ofSize: 13)
    
    /// 遮罩层
    private lazy var rightProgressGradientRing: CAGradientLayer = {
        let shapeLayer = CAGradientLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    /// 进度圆环
    private lazy var rightProgressRing: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        return shapeLayer
    }()
    
    // MARK: - 生命周期
    
    /// 构造函数
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    /// 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// 构造函数
    public convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    /// 位置更新完毕
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
        drawControls()
    }
    
    // MARK: - 方法
    
    /// 初使化控件
    private func setupView() {
        
        // MARK: - 主模块

        // 自身
        backgroundColor = UIColor.clear
        
        // 设置圆环
        mainRing.fillColor = UIColor.clear.cgColor
        mainRing.strokeColor = UIColor(hex: "#57A3FF").cgColor
        mainRing.lineWidth = lineWidth
        mainRing.lineCap = .butt
        layer.addSublayer(mainRing)
        
        // 背景圆环
        backgroundRing.fillColor = UIColor.clear.cgColor
        backgroundRing.strokeColor = UIColor(hex: "#57A3FF").withAlphaComponent(0.15).cgColor
        backgroundRing.lineCap = .butt
        layer.addSublayer(backgroundRing)
        
        // 渐变
        layer.addSublayer(progressGradientRing)
        progressRing.fillColor = UIColor.clear.cgColor
        progressRing.strokeColor = UIColor.black.cgColor
        progressRing.lineCap = .butt
        layer.addSublayer(progressRing)
        
        // 内圈圆环
        innerRing.fillColor = UIColor.clear.cgColor
        innerRing.strokeColor = UIColor(hex: "#91C6FE").cgColor
        innerRing.lineWidth = lineWidth
        innerRing.lineCap = .butt
        layer.addSublayer(innerRing)
        
        // 指针承载层
        indicator.backgroundColor = UIColor.clear.cgColor
        indicator.anchorPoint = CGPoint(x: 0.5, y: 0)
        layer.addSublayer(indicator)
        
        // 指针
        pointer.backgroundColor = UIColor.yellow.cgColor
        indicator.addSublayer(pointer)
        
        // 进度
        rotateGauge(newValue: calculations.minValue, duration: 0)
        
        // MARK: - 左模块

        // 渐变
        layer.addSublayer(leftProgressGradientRing)
        leftProgressRing.fillColor = UIColor.clear.cgColor
        leftProgressRing.strokeColor = UIColor.black.cgColor
        leftProgressRing.lineCap = .square
        layer.addSublayer(leftProgressRing)
        
        // 进度
        rotateLeftGauge(newValue: leftCalculations.minValue, duration: 0)
        
        // MARK: - 右模块
        layer.addSublayer(rightProgressGradientRing)
        rightProgressRing.fillColor = UIColor.clear.cgColor
        rightProgressRing.strokeColor = UIColor.black.cgColor
        rightProgressRing.lineCap = .square
        layer.addSublayer(rightProgressRing)
        
        // 进度
        rotateRightGauge(newValue: rightCalculations.minValue, duration: 0)
        
        // MARK: - 表中间值
        addSubview(centerBgImageView)
        
        self.addSubview(self.rotae)
        // 单位
        addSubview(self.mphuin)
        // 转速父视图
        addSubview(self.bgrpmView)
        //转速值
        self.bgrpmView .addSubview(self.speedLabel)
        //RP×1000
        addSubview(self.rplabel)
        
        addSubview(self.hpbgView)
        self.hpbgView.addSubview(self.hplabel)
        
        addSubview(self.lbbgView)
        self.lbbgView.addSubview(self.lblabel)
    }
    
    /// 更新UI
    func updateUI() {
        
        // MARK: - 主模块

        let startDegree: CGFloat = 360.0 - calculations.calculatedEndDegree
        let endDegree: CGFloat = 360.0 - calculations.calculatedStartDegree

        // 圆环
        let radius = min(bounds.width, bounds.height) / 2
        let ringRadius = radius - (lineWidth / 2) - ringInset - longIndicLength
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: ringRadius, startAngle: startDegree.radian, endAngle: endDegree.radian, clockwise: false)
        mainRing.path = ringPath.cgPath
        
        /// 内圈圆环
        let innerRingGap: CGFloat = 30
        let innerRingRadius = ringRadius - innerRingGap
        let innerRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: innerRingRadius, startAngle: CGFloat(0).radian, endAngle: CGFloat(360).radian, clockwise: false)
        innerRing.path = innerRingPath.cgPath
        
        // 渐变
        let gradintBottomGap: CGFloat = 8
        let gradintTopGap: CGFloat = 4
        let progressRingLineWidth = ringRadius - innerRingRadius - gradintBottomGap - gradintTopGap
        let progressRingRadius = innerRingRadius + progressRingLineWidth / 2 + gradintBottomGap
        let progressRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: progressRingRadius, startAngle: endDegree.radian, endAngle: startDegree.radian, clockwise: true)
        progressRing.path = progressRingPath.cgPath
        progressRing.lineWidth = progressRingLineWidth
        
        // 渐变
        progressGradientRing.frame = bounds
        progressGradientRing.colors = [
            UIColor(hex: "#48F44F").cgColor,
            UIColor(hex: "#1C82FD").cgColor
        ]
        progressGradientRing.type = .axial
        progressGradientRing.startPoint = CGPoint(x: 1, y: 0)
        let endY = 0.5 + frame.size.width / frame.size.height / 2
        progressGradientRing.endPoint = CGPoint(x: 1, y: endY)
        // 注释此行显示渐变图
        progressGradientRing.mask = progressRing
        
        // 背景圆环
        backgroundRing.lineWidth = progressRingLineWidth
        let backgroundRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: progressRingRadius, startAngle: startDegree.radian, endAngle: endDegree.radian, clockwise: false)
        backgroundRing.path = backgroundRingPath.cgPath
        
        // 指针承载层
        let indicatorWidth: CGFloat = 10
        indicator.frame = CGRect(x: bounds.width / 2 - indicatorWidth / 2, y: bounds.height / 2, width: indicatorWidth, height: ringRadius)
        
        // 指针
        let pointerHeight = progressRingLineWidth + gradintBottomGap
        pointer.cornerRadius = 4
        pointer.backgroundColor = UIColor(hex: "49F451").cgColor
        pointer.frame = CGRect(x: 0, y: -indicator.frame.size.height + gradintTopGap, width: indicatorWidth, height: pointerHeight)
        
        // MARK: - 左模块
        
        // 渐变
        leftProgressGradientRing.frame = bounds
        leftProgressGradientRing.colors = [
        
        ]
        leftProgressGradientRing.type = .axial
        leftProgressGradientRing.startPoint = CGPoint(x: 1, y: 0)
        let leftEndY = 0.5 + frame.size.width / frame.size.height / 2
        leftProgressGradientRing.endPoint = CGPoint(x: 1, y: leftEndY)
        // 注释此行显示渐变图
        leftProgressGradientRing.mask = leftProgressRing
        
        // 左渐变
        let leftProgressRingRadius = ringRadius + longIndicLength / 2 + leftGap + lineWidth / 2
        let leftStartDegree: CGFloat = 360.0 - leftCalculations.calculatedEndDegree
        // 线头有一定的宽度，要增加一点的位置
        let leftLineCapGap: CGFloat = 6
        let leftEndDegree: CGFloat = 360.0 - leftCalculations.calculatedStartDegree - leftLineCapGap
        let leftProgressRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: leftProgressRingRadius, startAngle: leftEndDegree.radian, endAngle: leftStartDegree.radian, clockwise: true)
        leftProgressRing.path = leftProgressRingPath.cgPath
        leftProgressRing.lineWidth = 20
        
        // MARK: - 右模块
        
        // 渐变
        rightProgressGradientRing.frame = bounds
        rightProgressGradientRing.colors = [

        ]
        rightProgressGradientRing.type = .axial
        rightProgressGradientRing.startPoint = CGPoint(x: 1, y: 0)
        let rightEndY = 0.5 + frame.size.width / frame.size.height / 2
        rightProgressGradientRing.endPoint = CGPoint(x: 1, y: rightEndY)
        // 注释此行显示渐变图
        rightProgressGradientRing.mask = rightProgressRing
        
        // 右渐变
        let rightProgressRingRadius = ringRadius + longIndicLength / 2 + rightGap + lineWidth / 2
        // 线头有一定的宽度，要增加一点的位置
        let rightLineCapGap: CGFloat = 6
        let rightStartDegree: CGFloat = rightCalculations.calculatedStartDegree + rightLineCapGap
        let rightEndDegree: CGFloat = rightCalculations.calculatedEndDegree
        let rightProgressRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: rightProgressRingRadius, startAngle: rightStartDegree.radian, endAngle: rightEndDegree.radian, clockwise: false)
        rightProgressRing.path = rightProgressRingPath.cgPath
        rightProgressRing.lineWidth = 20
        
        //innerRingRadius 内圆高度
        
        if TDD_DiagnosisTools.isIpad() {
            self.centerBgImageView.frame = CGRect(x: self.frame.size.width / 2 - 80, y: self.height / 2 - 80, width: 160, height: 160)
            //表中间值 green
            self.rotae.frame = CGRect(x: 0, y: self.height / 2 - 35, width: self.width, height: 40)
            //mph单位 red
            self.mphuin.frame = CGRect(x: 0, y: self.rotae.top - 40, width: self.width, height: 15)
            //长方形视图
            self.bgrpmView.frame = CGRect(x: self.x - 30, y: self.height / 2 + 15, width: 60, height: 20)
            //何 - 修改
            self.bgrpmView.center = CGPoint(x: bounds.width / 2, y: self.bgrpmView.center.y)
            
            //转速值 blue
            self.speedLabel.frame = CGRect(x: 0, y: 0, width: self.bgrpmView.width, height: self.bgrpmView.height)
            //RPX1000
            self.rplabel.frame = CGRect(x: self.width / 2 - 50, y: self.bgrpmView.bottom + 10, width: 100, height: 25)
            
        } else {
            self.centerBgImageView.frame = CGRect(x: self.width / 2 - 60, y: self.height / 2 - 60, width: 120, height: 120)
            //表中间值
            self.rotae.frame = CGRect(x: 0, y: self.height / 2 - 20, width: self.width, height: 30)
            //mph单位
            self.mphuin.frame = CGRect(x: 0, y: self.height / 2 - 40, width: self.width, height: 15)
            //长方形视图
            self.bgrpmView.frame = CGRect(x: self.frame.origin.x + 15, y: self.frame.size.height / 2 + 15, width: 32, height: 10)
            //何 - 修改
            self.bgrpmView.center = CGPoint(x: bounds.width / 2, y: self.bgrpmView.center.y)
            
            //转速值
            self.speedLabel.frame = CGRect(x: 0, y: 0, width: self.bgrpmView.frame.width, height: self.bgrpmView.frame.height)
            //RPX1000
            self.rplabel.frame = CGRect(x: self.frame.size.width / 2 - 25, y: self.frame.size.height / 2 + 25, width: 50, height: 20)
        }
        if TDD_DiagnosisTools.isIpad() {
            self.hpbgView.frame = CGRect(x: -5, y: self.frame.size.height - 5, width: 50, height: 24);
        } else {
            self.hpbgView.frame = CGRect(x: -5, y: self.frame.size.height - 5, width: 40, height: 20);
        }
        self.hplabel.frame = CGRect(x: 0, y: 0, width: self.hpbgView.width, height: self.hpbgView.height);
        
        if TDD_DiagnosisTools.isIpad() {
            self.lbbgView.frame = CGRect(x: self.frame.size.width - 45, y: self.frame.size.height - 5, width: 50, height: 24)
        } else {
            self.lbbgView.frame = CGRect(x: self.frame.size.width - 35, y: self.frame.size.height - 5, width: 40, height: 20)
        }
        self.lblabel.frame = CGRect(x: 0, y: 0, width: self.lbbgView.width, height: self.lbbgView.height);

    }
    
    /// 画控件
    public func drawControls() {
        
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 中间模块
        addLongIndicators(centerPoint: center)
        addShortIndicators(centerPoint: center)
        drawSpecailAngleColor(startValue: 8, endValue: 9, color: UIColor(hex: "#FF9F59"), specialShapes: &specialShapes[0])
        drawSpecailAngleColor(startValue: 9, endValue: 10, color: UIColor(hex: "#F41515"), specialShapes: &specialShapes[1])
        drawLabels(centerPoint: center)
        
        // 左模块
        addLeftShortIndicators(centerPoint: center)
        drawLeftLabels(centerPoint: center)
        addLeftProgressIndicators(centerPoint: center)
        addLeftLongIndicators(centerPoint: center)

        // 右模块
        addRightShortIndicators(centerPoint: center)
        drawRightLabels(centerPoint: center)
        addRightProgressIndicators(centerPoint: center)
        addRightLongIndicators(centerPoint: center)
    }
    
    /// 计算文字大小
    private func textSize(for string: String?, font: UIFont) -> CGSize {
        let attribute = [NSAttributedString.Key.font: font]
        return string?.size(withAttributes: attribute) ?? .zero
    }
}


// MARK: - 中间模块

extension SpeedViewTest {
    
    /// 更新指针
    @objc public func rotateGauge(newValue: CGFloat, duration: CGFloat = 0.5) {
        var value = newValue
        if value > calculations.maxValue {
            value = calculations.maxValue
        }
        
        if value < calculations.minValue {
            value = calculations.minValue
        }
                
        let fractalValue = (value - calculations.minValue) / (calculations.maxValue - calculations.minValue)
        let totalAngle = calculations.endDegree - calculations.startDegree
        let newAngle = (calculations.startDegree + (totalAngle * fractalValue) - 180).radian

        let currentStrokeEnd = progressRing.presentation()?.value(forKeyPath: "strokeEnd") ?? 0.0
        let stroke = CABasicAnimation(keyPath: "strokeEnd")
        stroke.fromValue = currentStrokeEnd
        stroke.toValue = fractalValue
        stroke.duration = duration
        stroke.fillMode = CAMediaTimingFillMode.forwards
        stroke.isRemovedOnCompletion = false
        progressRing.add(stroke, forKey: "strokeEnd")
        
        let currentRotation: CGFloat = (indicator.presentation()?.value(forKeyPath: "transform.rotation") as? CGFloat) ?? 0.0
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = currentRotation
        print("currentRotation: \(currentRotation) newAngle: \(newAngle)")
        rotate.toValue = newAngle
        rotate.duration = duration
        rotate.fillMode = CAMediaTimingFillMode.forwards
        rotate.isRemovedOnCompletion = false
        indicator.add(rotate, forKey: "transform.rotation")
    }
    
    /// 画长刻度
    private func addLongIndicators(centerPoint: CGPoint) {
        longIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...calculations.longSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(2 / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset
            let endValue = startValue - longIndicLength
            let baseAngle = calculations
                .calculateSectionDegree(for: CGFloat(i), in: calculations.longSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = longIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            layer.addSublayer(indicatorLayer)
            longIndicatorsShapes.append(indicatorLayer)
        }
    }
    
    /// 画短刻度
    private func addShortIndicators(centerPoint: CGPoint) {
        shortIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...calculations.shortSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(2 / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset - shortIndicLength
            let endValue = startValue - shortIndicLength

            let baseAngle = calculations
                .calculateSectionDegree(for: CGFloat(i), in: calculations.shortSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = shortIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            layer.addSublayer(indicatorLayer)
            shortIndicatorsShapes.append(indicatorLayer)
        }
    }
  
    /// 画特殊段颜色
    private func drawSpecailAngleColor(startValue: Int, endValue: Int, color: UIColor, specialShapes: inout [CAShapeLayer]) {
        specialShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.drawsAsynchronously = true
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .butt
                
        let radius = min(bounds.width, bounds.height) / 2
        
        let totalAngle = calculations.endDegree - calculations.startDegree
        let startValuePercent = (CGFloat(startValue) - calculations.minValue) / (calculations.maxValue - calculations.minValue)
        let startAngleValue = (startValuePercent * totalAngle) + calculations.startDegree
        
        let endValuePercent = (CGFloat(endValue) - calculations.minValue) / (calculations.maxValue - calculations.minValue)
        let endAngleValue = (endValuePercent * totalAngle) + calculations.startDegree
        
        // 将 clockwise true 转为 clockwise false 数值
        let startTransform: CGFloat = startAngleValue
        let endTransform: CGFloat = endAngleValue
        let startDegreeValue: CGFloat = 360.0 - (270.0 - endTransform + 360)
        let endDegreeValue: CGFloat = 360.0 - (270.0 - startTransform)
        
        let ringRadius = radius - (lineWidth / 2) - ringInset - longIndicLength
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: ringRadius, startAngle: CGFloat(startDegreeValue).radian, endAngle: CGFloat(endDegreeValue).radian, clockwise: false)
        shapeLayer.path = ringPath.cgPath
        
        layer.addSublayer(shapeLayer)
        specialShapes.append(shapeLayer)
    }
    
    /// 画文字
    private func drawLabels(centerPoint: CGPoint) {
        labelShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...calculations.longSeparationPoints {
            
            // 从圆心开始计算
            let radius = min(bounds.width, bounds.height) / 2
            let ringRadius = radius - (lineWidth / 2) - ringInset - longIndicLength - labelGap
            let endValue = ringRadius
            
            let baseRad = calculations
                .calculateSectionDegree(for: CGFloat(i), in: calculations.longSeparationPoints)
                .radian
            let endPoint = CGPoint(x: cos(CGFloat(-baseRad)) * endValue + centerPoint.x,
                                   y: sin(CGFloat(-baseRad)) * endValue + centerPoint.y)
            
            
            var indicatorValue: CGFloat = 0
            indicatorValue = calculations.longSectionGapValue * CGFloat(i) + calculations.minValue
            
            var indicatorStringValue : String = ""
            if indicatorValue.truncatingRemainder(dividingBy: 1) == 0 {
                indicatorStringValue = String(Int(indicatorValue))
            } else {
                indicatorStringValue = String(Double(indicatorValue))
            }
            let size: CGSize = textSize(for: indicatorStringValue, font: indicatorsFont)
            
            let xOffset = abs(cos(baseRad)) * size.width * 0.5
            let yOffset = abs(sin(baseRad)) * size.height * 0.5
            let textPadding = CGFloat(5.0)
            let textOffset = sqrt(CGFloat(xOffset * xOffset + yOffset * yOffset)) + textPadding
            let textCenter = CGPoint(x: cos(-baseRad) * textOffset + endPoint.x,
                                     y: sin(-baseRad) * textOffset + endPoint.y)
            let textRect = CGRect(x: textCenter.x - size.width * 0.5,
                                  y: textCenter.y - size.height * 0.5,
                                  width: size.width,
                                  height: size.height)
            
            let textLayer = CATextLayer()
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.frame = textRect
            textLayer.string = indicatorStringValue
            textLayer.font = indicatorsFont
            textLayer.fontSize = indicatorsFont.pointSize
            textLayer.foregroundColor = UIColor.white.cgColor
            
            layer.addSublayer(textLayer)
            labelShapes.append(textLayer)
        }
    }
}

// MARK: - 左模块

extension SpeedViewTest {
    
    /// 更新指针
    @objc public func rotateLeftGauge(newValue: CGFloat, duration: CGFloat = 0.5) {
        var value = newValue
        if value > leftCalculations.maxValue {
            value = leftCalculations.maxValue
        }
        
        if value < leftCalculations.minValue {
            value = leftCalculations.minValue
        }
                
        let fractalValue = (value - leftCalculations.minValue) / (leftCalculations.maxValue - leftCalculations.minValue)
        
        let currentStrokeEnd = leftProgressRing.presentation()?.value(forKeyPath: "strokeEnd") ?? 0.0
        let stroke = CABasicAnimation(keyPath: "strokeEnd")
        stroke.fromValue = currentStrokeEnd
        stroke.toValue = fractalValue
        stroke.duration = duration
        stroke.fillMode = CAMediaTimingFillMode.forwards
        stroke.isRemovedOnCompletion = false
        leftProgressRing.add(stroke, forKey: "strokeEnd")
    }
    
    /// 画左刻度
    private func addLeftLongIndicators(centerPoint: CGPoint) {
        leftIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...leftCalculations.longSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(leftIndicatorWidth / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset + leftGap
            let endValue = startValue - longIndicLength
            let baseAngle = leftCalculations
                .calculateSectionDegree(for: CGFloat(i), in: leftCalculations.longSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = leftLongIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            layer.addSublayer(indicatorLayer)
            leftIndicatorsShapes.append(indicatorLayer)
        }
    }
    
    /// 画左短刻度
    private func addLeftShortIndicators(centerPoint: CGPoint) {
        leftShortIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...leftCalculations.shortSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(leftIndicatorWidth / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset + leftGap
            let endValue = startValue - longIndicLength
            let baseAngle = leftCalculations
                .calculateSectionDegree(for: CGFloat(i), in: leftCalculations.shortSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = leftShortIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            layer.addSublayer(indicatorLayer)
            leftShortIndicatorsShapes.append(indicatorLayer)
        }
    }
    
    /// 画左进度刻度
    private func addLeftProgressIndicators(centerPoint: CGPoint) {
        leftProgressIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...leftCalculations.shortSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(leftIndicatorWidth / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset + leftGap
            let endValue = startValue - longIndicLength
            let baseAngle = leftCalculations
                .calculateSectionDegree(for: CGFloat(i), in: leftCalculations.shortSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = leftProgressIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            leftProgressGradientRing.addSublayer(indicatorLayer)
            leftProgressIndicatorsShapes.append(indicatorLayer)
        }
        
        // 顶层
        leftProgressGradientRing.removeFromSuperlayer()
        layer.addSublayer(leftProgressGradientRing)
    }
    
    /// 画文字
    private func drawLeftLabels(centerPoint: CGPoint) {
        leftLabelShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...leftCalculations.longSeparationPoints {
            
            // 从圆心开始计算
            let radius = min(bounds.width, bounds.height) / 2
            let ringRadius = radius - ringInset + leftGap
            let endValue = ringRadius
            
            let baseRad = leftCalculations
                .calculateSectionDegree(for: CGFloat(i), in: leftCalculations.longSeparationPoints)
                .radian
            let endPoint = CGPoint(x: cos(CGFloat(-baseRad)) * endValue + centerPoint.x,
                                   y: sin(CGFloat(-baseRad)) * endValue + centerPoint.y)
            
            
            var indicatorValue: CGFloat = 0
            indicatorValue = leftCalculations.longSectionGapValue * CGFloat(i) + leftCalculations.minValue
            
            var indicatorStringValue : String = ""
            if indicatorValue.truncatingRemainder(dividingBy: 1) == 0 {
                indicatorStringValue = String(Int(indicatorValue))
            } else {
                indicatorStringValue = String(Double(indicatorValue))
            }
            let size: CGSize = textSize(for: indicatorStringValue, font: leftIndicatorsFont)
            
            let xOffset = abs(cos(baseRad)) * size.width * 0.5
            let yOffset = abs(sin(baseRad)) * size.height * 0.5
            let textPadding = CGFloat(5.0)
            let textOffset = sqrt(CGFloat(xOffset * xOffset + yOffset * yOffset)) + textPadding
            let textCenter = CGPoint(x: cos(-baseRad) * textOffset + endPoint.x,
                                     y: sin(-baseRad) * textOffset + endPoint.y)
            let textRect = CGRect(x: textCenter.x - size.width * 0.5,
                                  y: textCenter.y - size.height * 0.5,
                                  width: size.width,
                                  height: size.height)
            
            let textLayer = CATextLayer()
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.frame = textRect
            textLayer.string = indicatorStringValue
            textLayer.font = leftIndicatorsFont
            textLayer.fontSize = leftIndicatorsFont.pointSize
            textLayer.foregroundColor = UIColor.white.cgColor
            
            layer.addSublayer(textLayer)
            leftLabelShapes.append(textLayer)
            
            if i == 0 {
                hpbgView.center = CGPoint(x: textCenter.x, y: textCenter.y + 20)
            }
        }
    }
}

// MARK: - 右模块

extension SpeedViewTest {
    
    /// 更新指针
    @objc public func rotateRightGauge(newValue: CGFloat, duration: CGFloat = 0.5) {
        var value = newValue
        if value > rightCalculations.maxValue {
            value = rightCalculations.maxValue
        }
        
        if value < rightCalculations.minValue {
            value = rightCalculations.minValue
        }
                
        let fractalValue = (value - rightCalculations.minValue) / (rightCalculations.maxValue - rightCalculations.minValue)
        
        let currentStrokeEnd = rightProgressRing.presentation()?.value(forKeyPath: "strokeEnd") ?? 0.0
        let stroke = CABasicAnimation(keyPath: "strokeEnd")
        stroke.fromValue = currentStrokeEnd
        stroke.toValue = fractalValue
        stroke.duration = duration
        stroke.fillMode = CAMediaTimingFillMode.forwards
        stroke.isRemovedOnCompletion = false
        rightProgressRing.add(stroke, forKey: "strokeEnd")
    }
    
    /// 画右刻度
    private func addRightLongIndicators(centerPoint: CGPoint) {
        rightIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...rightCalculations.longSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(rightIndicatorWidth / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset + rightGap
            let endValue = startValue - longIndicLength
            let baseAngle = rightCalculations
                .calculateSectionDegree(for: CGFloat(i), in: rightCalculations.longSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y);
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = rightLongIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            layer.addSublayer(indicatorLayer)
            rightIndicatorsShapes.append(indicatorLayer)
        }
    }
    
    /// 画右短刻度
    private func addRightShortIndicators(centerPoint: CGPoint) {
        rightShortIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...rightCalculations.shortSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(rightIndicatorWidth / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset + rightGap
            let endValue = startValue - longIndicLength
            let baseAngle = rightCalculations
                .calculateSectionDegree(for: CGFloat(i), in: rightCalculations.shortSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = rightShortIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            layer.addSublayer(indicatorLayer)
            rightShortIndicatorsShapes.append(indicatorLayer)
        }
    }
    
    /// 画右进度刻度
    private func addRightProgressIndicators(centerPoint: CGPoint) {
        rightProgressIndicatorsShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...rightCalculations.shortSeparationPoints {
            let indicatorLayer = CAShapeLayer()
            indicatorLayer.frame = bounds
            
            let indicWidth = CGFloat(rightIndicatorWidth / UIScreen.main.scale)
            
            // 从圆心开始计算
            let boundWidth = min(bounds.width, bounds.height)
            let startValue = boundWidth / 2 - ringInset + rightGap
            let endValue = startValue - longIndicLength
            let baseAngle = rightCalculations
                .calculateSectionDegree(for: CGFloat(i), in: rightCalculations.shortSeparationPoints)
                .radian
            
            let startPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * startValue + centerPoint.x,
                                     y: sin(CGFloat(-baseAngle)) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(CGFloat(-baseAngle)) * endValue+centerPoint.x,
                                   y: sin(CGFloat(-baseAngle)) * endValue + centerPoint.y)
            
            let indicatorPath = UIBezierPath()
            indicatorPath.move(to: startPoint)
            indicatorPath.addLine(to: endPoint)
            
            indicatorLayer.path = indicatorPath.cgPath
            indicatorLayer.fillColor = UIColor.clear.cgColor
            indicatorLayer.strokeColor = rightProgressIndicatorsColor.cgColor
            indicatorLayer.lineWidth = indicWidth
            
            rightProgressGradientRing.addSublayer(indicatorLayer)
            rightProgressIndicatorsShapes.append(indicatorLayer)
        }
        
        // 顶层
        rightProgressGradientRing.removeFromSuperlayer()
        layer.addSublayer(rightProgressGradientRing)
    }
    
    /// 画文字
    private func drawRightLabels(centerPoint: CGPoint) {
        rightLabelShapes.forEach { layer in
            layer.removeFromSuperlayer()
        }
        
        for i in 0...rightCalculations.longSeparationPoints {
            
            // 从圆心开始计算
            let radius = min(bounds.width, bounds.height) / 2
            let ringRadius = radius - ringInset + rightGap
            let endValue = ringRadius
            
            let baseRad = rightCalculations
                .calculateSectionDegree(for: CGFloat(i), in: rightCalculations.longSeparationPoints)
                .radian
            let endPoint = CGPoint(x: cos(CGFloat(-baseRad)) * endValue + centerPoint.x,
                                   y: sin(CGFloat(-baseRad)) * endValue + centerPoint.y)
            
            
            var indicatorValue: CGFloat = 0
            indicatorValue = rightCalculations.maxValue - rightCalculations.longSectionGapValue * CGFloat(i) + rightCalculations.minValue
            
            var indicatorStringValue : String = ""
            if indicatorValue.truncatingRemainder(dividingBy: 1) == 0 {
                indicatorStringValue = String(Int(indicatorValue))
            } else {
                indicatorStringValue = String(Double(indicatorValue))
            }
            let size: CGSize = textSize(for: indicatorStringValue, font: rightIndicatorsFont)
            
            let xOffset = abs(cos(baseRad)) * size.width * 0.5
            let yOffset = abs(sin(baseRad)) * size.height * 0.5
            let textPadding = CGFloat(5.0)
            let textOffset = sqrt(CGFloat(xOffset * xOffset + yOffset * yOffset)) + textPadding
            let textCenter = CGPoint(x: cos(-baseRad) * textOffset + endPoint.x,
                                     y: sin(-baseRad) * textOffset + endPoint.y)
            let textRect = CGRect(x: textCenter.x - size.width * 0.5,
                                  y: textCenter.y - size.height * 0.5,
                                  width: size.width,
                                  height: size.height)
            
            let textLayer = CATextLayer()
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.frame = textRect
            textLayer.string = indicatorStringValue
            textLayer.font = rightIndicatorsFont
            textLayer.fontSize = rightIndicatorsFont.pointSize
            textLayer.foregroundColor = UIColor.white.cgColor
            
            layer.addSublayer(textLayer)
            rightLabelShapes.append(textLayer)
            
            if i == rightCalculations.longSeparationPoints {
                lbbgView.center = CGPoint(x: textCenter.x, y: textCenter.y + 20)
            }
        }
    }
}

extension CGFloat {
    public var radian: CGFloat {
        CGFloat(self * CGFloat(.pi / 180.0))
    }
}

