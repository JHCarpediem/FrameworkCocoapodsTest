//
//  SpeedView.swift
//  GaugeSampleProject
//
//  Created by Lecason on 2022/9/14.
//  Copyright © 2022 Saeid Basirnia. All rights reserved.
//

import UIKit

public class SpeedView: UIView {
    
    // MARK: - 属性
    
    /// 圆弧与父视图的间距
    var ringInset: CGFloat = 20
    
    /// 弧线的宽度
    var lineWidth: CGFloat = 2
    
    /// 进度条弧线的宽度
    var progressLineWidth: CGFloat = 30
    
    /// 长刻度颜色
    var longIndicatorsColor: UIColor = UIColor(hex: "#91C6FE")
    
    /// 短刻度颜色
    var shortIndicatorsColor: UIColor = UIColor(hex: "#91C6FE")
    
    /// 字体
    var indicatorsFont: UIFont = UIFont.systemFont(ofSize: 16)
    
    /// 文字
    private var labelShapes: [CATextLayer] = []
    
    /// 长格进度条
    private var longIndicatorsShapes: [CAShapeLayer] = []
    
    /// 短格进度条
    private var shortIndicatorsShapes: [CAShapeLayer] = []
    
    /// 特殊颜色
    private var specialShapes: [[CAShapeLayer]] = [[], []]
    
    /// 显示的值
    var showValue: CGFloat = 0

    // MARK: - 控件
    
    /// 中间数值
    lazy var progressLabel: EFCountingLabel = {
        let label = EFCountingLabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = ""
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    /// 顶部文字
   @objc public lazy var topLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = Software.isKindOfTopVCI ? "km/h" : "MPH"
        label.isHidden = true
        return label
    }()
    
    /// 底部文字
    @objc public lazy var bottomLabel: UILabel = {
        let label = TDD_CustomLabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = ""
        return label
    }()
    
    /// 背景图片
    lazy var backgroundImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "ringBackground"))
        return imageView
    }()
    
    /// 外层大渐变圈
    private lazy var progressGradientRing: CAGradientLayer = {
        let shapeLayer = CAGradientLayer()
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
    
    /// 进度圆环
    private lazy var progressRing: CAShapeLayer = {
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
    
    // MARK: - 其它
    
    /// 计算
    @objc public var calculations: Calculations = {
//        let calculations = Calculations(minValue: 10, maxValue: 100, longSectionGapValue: 10, shortSectionGapValue: 1, startDegree: 120, endDegree: 60)
        let calculations = Calculations()
        return calculations
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
        // 自身
        backgroundColor = UIColor.black
        
        // 设置圆环
        mainRing.fillColor = UIColor.clear.cgColor
        mainRing.strokeColor = UIColor(hex: "#57A3FF").cgColor
        mainRing.lineWidth = lineWidth
        mainRing.lineCap = .butt
        layer.addSublayer(mainRing)
        
        /// 背景圆环
        backgroundRing.fillColor = UIColor.clear.cgColor
        backgroundRing.strokeColor = UIColor(hex: "#BAD6F8").withAlphaComponent(0.11).cgColor
        backgroundRing.lineCap = .butt
        layer.addSublayer(backgroundRing)
        
        // 渐变
        layer.addSublayer(progressGradientRing)
        progressRing.fillColor = UIColor.clear.cgColor
        progressRing.strokeColor = UIColor.black.cgColor
        progressRing.lineWidth = progressLineWidth
        progressRing.lineCap = .butt
        layer.addSublayer(progressRing)
        
        /// 内圈圆环
        innerRing.fillColor = UIColor.clear.cgColor
        innerRing.strokeColor = UIColor(hex: "#91C6FE").cgColor
        innerRing.lineWidth = lineWidth
        innerRing.lineCap = .butt
        layer.addSublayer(innerRing)
        
        // 指针
        pointer.fillColor = UIColor.clear.cgColor
        pointer.strokeColor = UIColor(hex: "#49F451").cgColor
        pointer.lineWidth = lineWidth
        pointer.lineCap = .round
        layer.addSublayer(pointer)
        pointer.lineWidth = 0
        let anchorPoint = CGPoint(x: 0.5, y: 1.0)
        let newPoint = CGPoint(x: pointer.bounds.size.width * anchorPoint.x, y: pointer.bounds.size.height * anchorPoint.y)
        let oldPoint = CGPoint(x: pointer.bounds.size.width * pointer.anchorPoint.x, y: pointer.bounds.size.height * pointer.anchorPoint.y)
        var position = pointer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        pointer.position = position
        pointer.anchorPoint = anchorPoint
        pointer.fillColor = UIColor(hex: "#49F451").cgColor
        rotateGauge(newValue: calculations.minValue, duration: 0)
        
        // 背景图片
        addSubview(backgroundImageView)
        
        // 进度字体
        addSubview(progressLabel)
        progressLabel.setUpdateBlock { (value, label) in
//            label.text = String(format: "%d", Int(value))
            label.text = String(format: "%.02f", value)
        }
        
        /// 顶部文字
        addSubview(topLabel)
        
        /// 底部文字
        addSubview(bottomLabel)
        
    }
    
    /// 更新UI
    @objc public func updateUI() {
        // 圆环
        let radius = min(bounds.width, bounds.height) / 2
        let ringRadius = radius - (lineWidth / 2) - ringInset
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: ringRadius, startAngle: calculations.startDegree.degreesToRadians, endAngle: calculations.endDegree.degreesToRadians, clockwise: true)
        mainRing.path = ringPath.cgPath
        
        // 渐变
        let gradientGap: CGFloat = 3
        let progressRingRadius = radius - (progressLineWidth / 2) - ringInset - lineWidth - gradientGap
        let progressRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: progressRingRadius, startAngle: calculations.startDegree.degreesToRadians, endAngle: calculations.endDegree.degreesToRadians, clockwise: true)
        progressRing.path = progressRingPath.cgPath
        
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
        
        /// 内圈圆环
        let innerRingGap: CGFloat = 10
        let innerRingRadius  = radius - (lineWidth / 2) - ringInset - progressLineWidth - gradientGap - innerRingGap
        let innerRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: innerRingRadius, startAngle: 0.degreesToRadians, endAngle: 360.degreesToRadians, clockwise: true)
        innerRing.path = innerRingPath.cgPath
        
        // 三角型指针
        let viewWidth = frame.width
        let halfViewWidth = viewWidth / 2
        let viewHeight = frame.height
        let gaugeGap = ringInset + lineWidth
        let gaugeYPos: CGFloat = gaugeGap
        let gaugeHeight: CGFloat = (viewHeight / 2) - gaugeGap
        let gaugeWidth: CGFloat = 10
        let gaugeFrame = CGRect(x: halfViewWidth - (gaugeWidth / 2), y: gaugeYPos, width: gaugeWidth, height: gaugeHeight).integral
        pointer.bounds.size = gaugeFrame.size
        pointer.position.x = gaugeFrame.origin.x + (gaugeFrame.width / 2)
        pointer.position.y = gaugeFrame.origin.y + gaugeFrame.height
        let gaugePath = UIBezierPath()
        gaugePath.move(to: CGPoint(x: gaugeWidth / 2, y: 0))
        gaugePath.addLine(to: CGPoint(x: gaugeWidth, y: gaugeHeight))
        gaugePath.addLine(to: CGPoint(x: 0, y: gaugeHeight))
        gaugePath.close()
        // pointer.path = indicatorPath.cgPath
        
        // 矩型指针
        let indicatorPath = UIBezierPath()
        let innerRingHeight = ringRadius - innerRingRadius - lineWidth
        indicatorPath.move(to: CGPoint(x: 0, y: gradientGap))
        indicatorPath.addLine(to: CGPoint(x: gaugeWidth, y: gradientGap))
        indicatorPath.addLine(to: CGPoint(x: gaugeWidth, y: innerRingHeight))
        indicatorPath.addLine(to: CGPoint(x: 0, y: innerRingHeight))
        indicatorPath.close()
        // 圆角矩型指针
        let roundCapGap = lineWidth
        let roundPath = UIBezierPath(roundedRect: CGRect(x: 0, y: gradientGap, width: gaugeWidth, height: innerRingHeight - roundCapGap), cornerRadius: 10)
        pointer.path = roundPath.cgPath
        
        // 背景圆环
        backgroundRing.lineWidth = innerRingHeight
        let backgroundRingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: progressRingRadius, startAngle: 0.degreesToRadians, endAngle: 360.degreesToRadians, clockwise: true)
        backgroundRing.path = backgroundRingPath.cgPath
        
        // 进度字体
        progressLabel.frame.size = CGSize(width: innerRingRadius * 2, height: innerRingRadius)
        progressLabel.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 背景图片
        backgroundImageView.frame.size = CGSize(width: innerRingRadius * 2, height: innerRingRadius * 2)
        backgroundImageView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        /// 顶部文字
        topLabel.frame.size = CGSize(width: innerRingRadius * 2, height: innerRingRadius * 2)
        topLabel.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2 - progressLabel.bounds.height / 2)

        /// 底部文字
        bottomLabel.frame.size = CGSize(width: innerRingRadius * 2 - 30, height: innerRingRadius * 2)
        bottomLabel.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2 + progressLabel.bounds.height / 2)
    }
    
    
    /// 更新指针
    @objc public func rotateGauge(newValue: CGFloat, duration: CGFloat = 0.5) {
//        if showValue == newValue {
//            return
//        }
//
//        showValue = newValue
        
        var value = newValue
        if value > calculations.maxValue {
            value = calculations.maxValue
        }
        
        if value < calculations.minValue {
            value = calculations.minValue
        }
        
        progressLabel.countFromCurrentValueTo(newValue, withDuration: duration)
        
        let fractalValue = (value - calculations.minValue) / (calculations.maxValue - calculations.minValue)
        let newAngle = (270.degreesToRadians - calculations.startDegree.degreesToRadians) * (2 * fractalValue - 1)
        
        if duration == 0 {
            pointer.transform = CATransform3DMakeRotation(newAngle, 0, 0, 1)
            let currentStrokeEnd = pointer.presentation()?.value(forKeyPath: "strokeEnd") ?? 0.0
            let stroke = CABasicAnimation(keyPath: "strokeEnd")
            stroke.fromValue = currentStrokeEnd
            stroke.toValue = fractalValue
            stroke.duration = 0
            stroke.fillMode = CAMediaTimingFillMode.forwards
            stroke.isRemovedOnCompletion = false
            pointer.add(stroke, forKey: "strokeEnd")
            
            let progressStrokeEnd = progressRing.presentation()?.value(forKeyPath: "strokeEnd") ?? 0.0
            let progressStroke = CABasicAnimation(keyPath: "strokeEnd")
            progressStroke.fromValue = progressStrokeEnd
            progressStroke.toValue = fractalValue
            progressStroke.duration = 0
            progressStroke.fillMode = CAMediaTimingFillMode.forwards
            progressStroke.isRemovedOnCompletion = false
            progressRing.add(progressStroke, forKey: "strokeEnd")
        } else {
            let currentRotation = pointer.presentation()?.value(forKeyPath: "transform.rotation") ?? 0.0
            let rotate = CABasicAnimation(keyPath: "transform.rotation")
            rotate.fromValue = currentRotation
            rotate.toValue = newAngle
            rotate.duration = duration
            rotate.fillMode = CAMediaTimingFillMode.forwards
            rotate.isRemovedOnCompletion = false
            pointer.add(rotate, forKey: "transform.rotation")
            
            let currentStrokeEnd = progressRing.presentation()?.value(forKeyPath: "strokeEnd") ?? 0.0
            let stroke = CABasicAnimation(keyPath: "strokeEnd")
            stroke.fromValue = currentStrokeEnd
            stroke.toValue = fractalValue
            stroke.duration = duration
            stroke.fillMode = CAMediaTimingFillMode.forwards
            stroke.isRemovedOnCompletion = false
            progressRing.add(stroke, forKey: "strokeEnd")
        }
    }
    
    /// 画控件
    @objc public func drawControls() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        drawSpecailAngleColor(startValue: Int(self.calculations.maxValue - self.calculations.longSectionGapValue * 2), endValue: Int(self.calculations.maxValue - self.calculations.longSectionGapValue * 1), color: UIColor(hex: "#FF9F59"), specialShapes: &specialShapes[0])
        drawSpecailAngleColor(startValue: Int(self.calculations.maxValue - self.calculations.longSectionGapValue), endValue: Int(self.calculations.maxValue), color: UIColor(hex: "#F41515"), specialShapes: &specialShapes[1])
        addShortIndicators(centerPoint: center)
        addLongIndicators(centerPoint: center)
        drawLabels(centerPoint: center)
    }
    
    /// 重新画文字
    @objc public func reDrawLabels() {
        for i in 0...calculations.longSeparationPoints {
            var indicatorValue: CGFloat = 0
            indicatorValue = calculations.longSectionGapValue * CGFloat(i) + calculations.minValue
            
            var indicatorStringValue : String = ""
            if indicatorValue.truncatingRemainder(dividingBy: 1) == 0{
                indicatorStringValue = String(Int(indicatorValue))
            } else {
                indicatorStringValue = Double(indicatorValue).defaultFormatValue(maximumFractionDigits: 2, roundingMode: .halfUp) ?? ""
            }
            
            if i > labelShapes.count - 1
            {
                break
            }
            
            var fontSize : CGFloat = 16
            
            indicatorsFont = UIFont.systemFont(ofSize: fontSize)
            
            var size: CGSize = textSize(for: indicatorStringValue, font: indicatorsFont)
            
            while size.width > 30 {
                fontSize -= 1
                
                indicatorsFont = UIFont.systemFont(ofSize: fontSize)
                
                size = textSize(for: indicatorStringValue, font: indicatorsFont)
                
                if fontSize == 5 {
                    break
                }
            }
            
            let textLayer = labelShapes[i]
            textLayer.removeFromSuperlayer()
            textLayer.string = indicatorStringValue
            textLayer.font = indicatorsFont
            textLayer.fontSize = indicatorsFont.pointSize
            layer.addSublayer(textLayer)
        }
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
            let indicLength = CGFloat(20)
            
            let startValue = frame.width / 2 - ringInset - lineWidth - 5
            let endValue = startValue + indicLength
            let baseAngle = calculations
                .calculateSectionDegree(for: CGFloat(i), in: calculations.longSeparationPoints)
                .degreesToRadians
            
            let startPoint = CGPoint(x: cos(-baseAngle) * startValue + centerPoint.x,
                                     y: sin(-baseAngle) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(-baseAngle) * endValue+centerPoint.x,
                                   y: sin(-baseAngle) * endValue + centerPoint.y)
            
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
            let indicLength = CGFloat(10)
            
            // 从圆心开始计算
            let startValue = frame.width / 2 - ringInset - lineWidth + lineWidth
            let endValue = startValue + indicLength
            let baseAngle = calculations
                .calculateSectionDegree(for: CGFloat(i), in: calculations.shortSeparationPoints)
                .degreesToRadians
            
            let startPoint = CGPoint(x: cos(-baseAngle) * startValue + centerPoint.x,
                                     y: sin(-baseAngle) * startValue + centerPoint.y)
            let endPoint = CGPoint(x: cos(-baseAngle) * endValue+centerPoint.x,
                                   y: sin(-baseAngle) * endValue + centerPoint.y)
            
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
        
        let totalAngle = ((270 - calculations.startDegree) + (90 + calculations.endDegree))
        let startValuePercent = (CGFloat(startValue) - calculations.minValue) / (calculations.maxValue - calculations.minValue)
        let startAngleValue = (startValuePercent * totalAngle)
        
        let endValuePercent = (CGFloat(endValue) - calculations.minValue) / (calculations.maxValue - calculations.minValue)
        let endAngleValue = (endValuePercent * totalAngle)
        
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: radius - (lineWidth / 2) - ringInset, startAngle: startAngleValue.degreesToRadians + calculations.startDegree.degreesToRadians, endAngle: endAngleValue.degreesToRadians + calculations.startDegree.degreesToRadians, clockwise: true)
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
            let labelGap = 30.0
            let endValue = frame.width / 2 - ringInset - lineWidth - labelGap
            
            let baseRad = calculations
                .calculateSectionDegree(for: CGFloat(i), in: calculations.longSeparationPoints)
                .degreesToRadians
            let endPoint = CGPoint(x: cos(-baseRad) * endValue + centerPoint.x,
                                   y: sin(-baseRad) * endValue + centerPoint.y)
            
            
            var indicatorValue: CGFloat = 0
            indicatorValue = calculations.longSectionGapValue * CGFloat(i) + calculations.minValue
            
            var indicatorStringValue : String = ""
            if indicatorValue.truncatingRemainder(dividingBy: 1) == 0{
                indicatorStringValue = String(Int(indicatorValue))
            } else {
                indicatorStringValue = Double(indicatorValue).defaultFormatValue(maximumFractionDigits: 2, roundingMode: .halfUp) ?? ""
            }
            
            var fontSize : CGFloat = 16
            
            indicatorsFont = UIFont.systemFont(ofSize: fontSize)
            
            var size: CGSize = textSize(for: indicatorStringValue, font: indicatorsFont)
            
            while size.width > 30 {
                fontSize -= 1
                
                indicatorsFont = UIFont.systemFont(ofSize: fontSize)
                
                size = textSize(for: indicatorStringValue, font: indicatorsFont)
                
                if fontSize == 5 {
                    break
                }
            }
            
            let xOffset = abs(cos(baseRad)) * size.width * 0.5
            let yOffset = abs(sin(baseRad)) * size.height * 0.5
            let textPadding = CGFloat(5.0)
            let textOffset = sqrt(xOffset * xOffset + yOffset * yOffset) + textPadding
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
//            textLayer.isWrapped = true
            
            layer.addSublayer(textLayer)
            labelShapes.append(textLayer)
        }
    }
    
    /// 计算文字大小
    private func textSize(for string: String?, font: UIFont) -> CGSize {
        let attribute = [NSAttributedString.Key.font: font]
        return string?.size(withAttributes: attribute) ?? .zero
    }
    
}

extension BinaryInteger {
    
    /// 角度转弧度
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    
    /// 角度转弧度
    var degreesToRadians: Self { self * .pi / 180 }
    /// 弧度转角度
    var radiansToDegrees: Self { self * 180 / .pi }
}

extension Double {
    
    /// 小数位数最多为两位
    func defaultFormatValue(maximumFractionDigits: Int = 2, roundingMode: NumberFormatter.RoundingMode  = .halfUp) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.roundingMode = roundingMode
        return numberFormatter.string(from: NSNumber(value: self))
    }
    
}
