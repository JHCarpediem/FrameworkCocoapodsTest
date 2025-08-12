//  LMSUI
//
//  Created by fench on 2023/7/19.
//

import UIKit

@objc
public enum TDScrollLabelDirection: Int {
    case none, left, right, comeAndBack
}
public class TDScrollLabel: UILabel {
    
    // MARK: - 配置属性
    /// 滚动方向 (默认 .none)
    @objc public var scrollDirection: TDScrollLabelDirection = .none {
        didSet {
            resetAnimation()
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    /// 滚动速度系数 (默认1.0)
    @objc public var speed: CGFloat = 1.0 {
        didSet {
            speedPoint = 0.2 * speed
        }
    }
    
    /// 文本间距 (默认10)
    @objc public var margin: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - 私有属性
    private var displayLink: CADisplayLink?
    private var speedPoint: CGFloat = 0.2
    private var currentX: CGFloat = 0
    private var isMovingLeft: Bool = false
    private var contentWidth: CGFloat = 0
    private var shouldScroll: Bool = false
    
    // MARK: - 生命周期
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    deinit {
        stopAnimation()
    }
    
    private func commonInit() {
        self.clipsToBounds = true
        self.lineBreakMode = .byTruncatingTail // 默认使用省略号模式
    }
    
    // MARK: - 布局系统
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateContentSize()
        checkScrollNeeded()
        setupInitialPosition()
    }
    
    public override var text: String? {
        didSet {
            resetAnimation()
            setNeedsLayout()
        }
    }
    
    public override var font: UIFont! {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - 核心逻辑
    private func updateContentSize() {
        guard let text = text else {
            contentWidth = 0
            return
        }
        
        let size = text.size(withAttributes: [.font: font!])
        contentWidth = size.width
        shouldScroll = (contentWidth > bounds.width) && (scrollDirection != .none)
    }
    
    private func checkScrollNeeded() {
        if shouldScroll {
            startAnimation()
        } else {
            stopAnimation()
            setNeedsDisplay() // 确保非滚动状态刷新布局
        }
    }
    
    private func setupInitialPosition() {
        guard !shouldScroll else { return }
        
        // 普通UILabel的布局逻辑
        switch textAlignment {
        case .left:
            currentX = 0
        case .right:
            currentX = bounds.width - contentWidth
        case .center:
            currentX = (bounds.width - contentWidth) / 2
        default:
            currentX = 0
        }
    }
    
    // MARK: - 动画控制
    private func startAnimation() {
        guard scrollDirection != .none else { return }
        guard displayLink == nil else { return }
        
        // 根据方向设置初始位置
        switch scrollDirection {
        case .left, .comeAndBack:
            currentX = bounds.width
        case .right:
            currentX = -contentWidth
        default: break
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateFrame))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    private func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    private func resetAnimation() {
        stopAnimation()
        currentX = 0
        setNeedsDisplay()
    }
    
    @objc private func updateFrame() {
        guard shouldScroll else { return }
        
        switch scrollDirection {
        case .left:
            handleLeftScroll()
        case .right:
            handleRightScroll()
        case .comeAndBack:
            handleComeBackScroll()
        default:
            break
        }
        
        setNeedsDisplay()
    }
    
    // MARK: - 滚动处理
    private func handleLeftScroll() {
        currentX -= speedPoint
        if currentX + contentWidth < 0 {
            currentX = bounds.width
        }
    }
    
    private func handleRightScroll() {
        currentX += speedPoint
        if currentX > bounds.width {
            currentX = -contentWidth
        }
    }
    
    private func handleComeBackScroll() {
        if isMovingLeft {
            currentX -= speedPoint
            if currentX < margin {
                isMovingLeft = false
            }
        } else {
            currentX += speedPoint
            if currentX + contentWidth > bounds.width - margin {
                isMovingLeft = true
            }
        }
    }
    
    // MARK: - 绘制文本
    public override func drawText(in rect: CGRect) {
        guard let text = text else { return }
        
        // 根据模式选择绘制策略
        if scrollDirection == .none {
            drawNormalText(in: rect)
        } else {
            drawScrollingText(in: rect)
        }
    }
    
    private func drawNormalText(in rect: CGRect) {
        // 完全使用UILabel原生绘制方式
        super.drawText(in: rect)
    }
    
    private func drawScrollingText(in rect: CGRect) {
        guard let text = text else { return }
        
        let drawRect = CGRect(
            x: currentX,
            y: 0,
            width: contentWidth,
            height: rect.height
        )
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: textColor!,
            .paragraphStyle: createScrollParagraphStyle()
        ]
        
        text.draw(in: drawRect, withAttributes: attributes)
        
        // 创建无缝滚动效果
        let secondaryRect = drawRect.offsetBy(
            dx: scrollDirection == .left ? -contentWidth - margin : contentWidth + margin,
            dy: 0
        )
        text.draw(in: secondaryRect, withAttributes: attributes)
    }
    
    private func createScrollParagraphStyle() -> NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .left // 滚动时强制左对齐
        return style
    }
}
