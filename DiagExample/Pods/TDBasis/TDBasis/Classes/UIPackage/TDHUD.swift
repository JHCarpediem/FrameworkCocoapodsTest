//
//  TDHUD.swift
//  TDBasis
//
//  Created by fench on 2023/7/21.
//

import UIKit

@objc public protocol TDHUDLoadingDelegate: NSObjectProtocol {
    @objc optional func showCustom(with message: String?, delay: TimeInterval, inView: UIView?) -> UIView
    @objc optional func loadingWillShow()
    @objc optional func loadingWillHide()
}

@objc public class TDHUDConfig: NSObject {
    @objc public static let shared: TDHUDConfig = TDHUDConfig()
    
    @objc public weak var loadingDelegate: TDHUDLoadingDelegate?
    
    @objc public var warnningImage: UIImage?
    @objc public var successImage: UIImage?
    @objc public var errorImage: UIImage?
    @objc public var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    @objc public var titleColor: UIColor = UIColor.white
    @objc public var messageFont: UIFont = UIFont.systemFont(ofSize: 15)
    @objc public var messageColor: UIColor = UIColor.white
    @objc public var loadingImage: UIImage?
    
    @objc public var loadingTopBallColor: UIColor = UIColor.td.color(with: 0xF22222)!
    @objc public var loadingBottomBallColor: UIColor = UIColor.td.color(with: 0xFF8100)!
    @objc public var loadingBackgroundColor: UIColor = UIColor.td.color(with: 0xf2f2f2)!
    @objc public var loadingMessageColor: UIColor = UIColor.td.color(with: 0x333333)!
    @objc public var loadingMessageFont: UIFont = UIFont.systemFont(ofSize: 14)
    @objc public var loadingMessageAlignment: NSTextAlignment = .center
    @objc public var loadingMessageNumberOfLines = 0
    
    /// 设置吐司的位置 默认为屏幕 2 / 3 （LMS 4.50 统一标准）
    public var toastPosition: ToastPosition = .custom(percent: 2 / 3)
    
    
    @objc(setToastPositionPercent:)
    /// OC 专用 设置 吐司所在屏幕的位置
    /// - Parameter percent: 位置百分比 具体值为 center:  percent * ScreenHeight
    public static func setToastPosition(_ percent: CGFloat) {
        shared.toastPosition = .custom(percent: percent)
    }
    
    @objc(setToastPosition:)
    /// 设置 toast 位置  0：Top  1： center  2: bottom
    /// - Parameter position: Int value  0：Top  1： center  2: bottom
    public static func setToastPosition(_ position: Int) {
        var tostPosition = ToastPosition.center
        switch position {
        case 0:
            tostPosition = .top
        case 1:
            tostPosition = .center
        case 2:
            tostPosition = .bottom
        default:
            tostPosition = .center
        }
        shared.toastPosition = tostPosition
    }
}

@objc
open class TDHUD: NSObject {

    @objc
    /// 弹出loading
    public static func showLoading(with message: String? = nil, delay: TimeInterval = 60, inView: UIView? = nil){
        hideLoading()
        TDLoadingView.show(with: message, delay: delay, inView: inView)
    }
    
    @objc
    /// 隐藏loading
    public static func hideLoading(){
        TDLoadingView.hide()
    }
  
    @objc(showMessage:)
    /// 弹出 toast 位置为 TDHUDConfig.shared.toastPosition 外部设置  默认为屏幕 2 / 3 处
    /// - Parameter message: 提示消息
    public static func show(_ message: String?) {
        show(message: message, position: TDHUDConfig.shared.toastPosition)
    }
    
    
    @objc(showInCenter:)
    /// 在中间弹出 toast
    /// - Parameter message: 提示内容
    public static func showIn(_ message: String?) {
        show(message: message, position: .center)
    }
    
    @objc
    /// 在底部弹出Toast
    /// - Parameter message: 提示消息
    public static func toast(_ message: String?) {
        show(message: message, position: .bottom)
    }
    
    @objc
    /// 弹出带图片的成功✅提示 图片在`TDHUDConfig.shared.errorImage`中配置
    /// - Parameter message: 提示消息
    public static func showSuccess(_ message: String?) {
        show(message: message, image: TDHUDConfig.shared.successImage)
    }
    
    @objc
    /// 弹出带图片的错误❎提示  图片在 `TDHUDConfig.shared.successImage`中配置
    /// - Parameter message: 提示消息
    public static func showError(_ message: String?) {
        show(message: message, image: TDHUDConfig.shared.errorImage)
    }
    
    @objc
    /// 弹出带图片的警告⚠️提示  图片在 `TDHUDConfig.shared.warnningImage`中配置
    /// - Parameter message: 提示消息
    public static func showWarnning(_ message: String?) {
        show(message: message, image: TDHUDConfig.shared.warnningImage)
    }
    /// 弹出toast
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 文本
    ///   - image: 图片
    ///   - inView: inview
    ///   - duration: 持续时间
    ///   - position: position
    ///   - style: 自定义style
    public static func show(with title: String? = nil,
                             message: String?,
                             image: UIImage? = nil,
                             inView: UIView? = nil,
                             duration: TimeInterval = 1.5,
                             position: ToastPosition = .center,
                             style: ToastStyle? = nil) {
        
        DispatchQueue.main.async {
            guard let view = inView ?? UI.keyWindow else {
                return
            }
            view.td.hideToast()
            let style = style ?? ToastManager.shared.style
            ToastManager.shared.isQueueEnabled = false
            view.td.makeToast(message, duration: duration, position: position, title: title, image: image, style: style)
        }
    }
    
    /// 隐藏Toast
    /// - Parameter fromeView: Toast 所在的View 不传默认为 keyWindow
    public static func hide(fromeView: UIView? = nil) {
        DispatchQueue.main.async {
            guard let view = fromeView ?? UI.keyWindow else {
                return
            }
            view.td.hideToast()
        }
    }
}


public class TDLoadingView: UIView {
    struct Const {
        static let ballWidth: CGFloat = 11
        static let ballSpeed: CGFloat = 0.7
        static let ballZoomScale: CGFloat = 0.25
        static let pauseSecond: CGFloat = 0.12
    }
    
    enum BallMoveDirection: Int {
        case positive = 1, negative = -1
    }
    
    var customLoadinView: UIView?
    let ballContainer = UIView()
    let greenBall = UIView()
    let redBall = UIView()
    var ballMoveDirection: BallMoveDirection = .positive
    var displayLink: CADisplayLink?
    let messageLabel = UILabel(text: nil, textColor: TDHUDConfig.shared.loadingMessageColor, font: TDHUDConfig.shared.loadingMessageFont)
    var delay: TimeInterval = 60
    
    static let shared: TDLoadingView = TDLoadingView()
    
    static func show(with message: String? = nil, delay: TimeInterval = 60, inView: UIView? = nil){
        DispatchQueue.main.async {
            guard let view = inView ?? UI.topViewController?.view ?? UI.keyWindow else { return }
            view.addSubview(TDLoadingView.shared)
            
            var isCustom = false
            if let customView = TDHUDConfig.shared.loadingDelegate?.showCustom?(with: message, delay: delay, inView: inView) {
                customView.tag = 999999
                TDLoadingView.shared.subviews.forEach {
                    $0.removeFromSuperview()
                }
                TDLoadingView.shared.addSubview(customView)
                isCustom = true
                
                let centxLayout = NSLayoutConstraint(item: customView, attribute: .centerX, relatedBy: .equal, toItem: TDLoadingView.shared, attribute: .centerX, multiplier: 1, constant: 0)
                let centyLayout = NSLayoutConstraint(item: customView, attribute: .centerY, relatedBy: .equal, toItem: TDLoadingView.shared, attribute: .centerY, multiplier: 1, constant: 0)
                let heightLayout = NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: TDLoadingView.shared, attribute: .height, multiplier: 1, constant: 0)
                let widthLayout = NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: TDLoadingView.shared, attribute: .width, multiplier: 1, constant: 0)
                
                customView.translatesAutoresizingMaskIntoConstraints = false
                let constains = [centxLayout, centyLayout, heightLayout, widthLayout]
                TDLoadingView.shared.addConstraints(constains)
                TDLoadingView.shared.customLoadinView = customView
            }
            
            TDLoadingView.shared.delay = delay
            view.bringSubviewToFront(TDLoadingView.shared)
            
            TDLoadingView.shared.removeConstraints(TDLoadingView.shared.selfConstains)
            let centxLayout = NSLayoutConstraint(item: TDLoadingView.shared, attribute: .centerX, relatedBy: .equal, toItem: TDLoadingView.shared.superview, attribute: .centerX, multiplier: 1, constant: 0)
            let centyLayout = NSLayoutConstraint(item: TDLoadingView.shared, attribute: .centerY, relatedBy: .equal, toItem: TDLoadingView.shared.superview, attribute: .centerY, multiplier: 1, constant: 0)
            let heightLayout = NSLayoutConstraint(item: TDLoadingView.shared, attribute: .height, relatedBy: .equal, toItem: TDLoadingView.shared.superview, attribute: .height, multiplier: 1, constant: 0)
            let widthLayout = NSLayoutConstraint(item: TDLoadingView.shared, attribute: .width, relatedBy: .equal, toItem: TDLoadingView.shared.superview, attribute: .width, multiplier: 1, constant: 0)
            
            TDLoadingView.shared.translatesAutoresizingMaskIntoConstraints = false
            TDLoadingView.shared.selfConstains = [centxLayout, centyLayout, heightLayout, widthLayout]
            TDLoadingView.shared.superview?.addConstraints(TDLoadingView.shared.selfConstains)
            
            
            TDLoadingView.shared.message = message
            TDLoadingView.shared.startAnimation()
            
        }
        
    }
    
    static func hide(){
        DispatchQueue.main.async {
            TDHUDConfig.shared.loadingDelegate?.loadingWillHide?()
            TDLoadingView.shared.stopAnimation()
            TDLoadingView.shared.removeFromSuperview()
        }
    }
    
    func startAnimation(){
        displayLink?.isPaused = false
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(TDLoadingView.dismiss), with: nil, afterDelay: delay)
        TDHUDConfig.shared.loadingDelegate?.loadingWillShow?()
    }
    
    @objc private func dismiss(){
        TDLoadingView.hide()
    }
    
    func stopAnimation(){
        displayLink?.isPaused = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: UI.SCREEN_BOUNDS.size))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    var ballContanerConstains: [NSLayoutConstraint] = []
    var messageLabelConstains: [NSLayoutConstraint] = []
    var containerConstatins: [NSLayoutConstraint] = []
    var selfConstains: [NSLayoutConstraint] = []
    
    var containerView: UIView!
    var message: String? = nil {
        didSet {
            if let customLoadinView = self.customLoadinView {
                return
            }
            
            self.messageLabel.isHidden = message.td.isEmpty
            self.messageLabel.text = message
            messageLabel.numberOfLines = TDHUDConfig.shared.loadingMessageNumberOfLines
            messageLabel.textAlignment = TDHUDConfig.shared.loadingMessageAlignment
            
            
            // 设置ballContainer约束
            containerView.removeConstraints(ballContanerConstains)
            ballContainer.translatesAutoresizingMaskIntoConstraints = false
            let ballContainerLayoutCenterX = NSLayoutConstraint(item: ballContainer, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0)
            let ballContainerLayoutTop = NSLayoutConstraint(item: ballContainer, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 20)
            let ballContainerLayoutWidth = NSLayoutConstraint(item: ballContainer, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Const.ballWidth * 3)
            let ballContainerLayoutHeight = NSLayoutConstraint(item: ballContainer, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Const.ballWidth * 3)
            ballContanerConstains = [ballContainerLayoutCenterX, ballContainerLayoutTop, ballContainerLayoutWidth, ballContainerLayoutHeight]
            containerView.addConstraints(ballContanerConstains)
            
            if !self.messageLabel.isHidden {
                // 设置messageLabel约束
                containerView.removeConstraints(messageLabelConstains)
                messageLabel.translatesAutoresizingMaskIntoConstraints = false
                let messageLabelLayoutCenterX = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0)
                let messageLabelLayoutTop = NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: ballContainer, attribute: .bottom, multiplier: 1.0, constant: 20)
                let messageLabelLayoutWidth = NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160)
                let messageLabelLayoutBottom = NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -30)
                messageLabelConstains = [messageLabelLayoutCenterX, messageLabelLayoutTop, messageLabelLayoutWidth, messageLabelLayoutBottom]
                containerView.addConstraints(messageLabelConstains)
            }
            
            // 设置containerView的中心点约束
            containerView.translatesAutoresizingMaskIntoConstraints = false
            self.removeConstraints(containerConstatins)
            let containerWidth: CGFloat = !messageLabel.isHidden ? 180 : 70
            let containerHeight: CGFloat = !messageLabel.isHidden ? 115 : 70
            let containerViewLayoutCenterX = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
            let containerViewLayoutCenterY = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
            let containerViewLayoutWidth = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: containerWidth)
            containerConstatins = [containerViewLayoutCenterX, containerViewLayoutCenterY, containerViewLayoutWidth]
            
            if self.messageLabel.isHidden {
                let containerViewLayoutHeight = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: containerHeight)
                containerConstatins.append(containerViewLayoutHeight)
            }
            
            self.addConstraints(containerConstatins)
            
            
        }
    }
    
    func setupUI(){
        containerView = {
            let view = UIView(frame: CGRect(center: self.center, size: CGSize(width: 70, height: 70)))
            view.backgroundColor = TDHUDConfig.shared.loadingBackgroundColor
            view.layer.cornerRadius = 15
            addSubview(view)
            return view
        }()
        
        ballContainer.frame = CGRect(center: CGPoint(x: containerView.td.width / 2, y: containerView.td.height / 2),
                                     size: CGSize(width: Const.ballWidth * 3, height: Const.ballWidth * 3))
        containerView.addSubview(ballContainer)
        
        containerView.addSubview(messageLabel)
        
        messageLabel.textAlignment = .center
        do {
            greenBall.frame = CGRect(center: CGPoint(x: Const.ballWidth / 2, y: ballContainer.td.height / 2),
                                     size: CGSize(width: Const.ballWidth, height: Const.ballWidth))
            greenBall.layer.cornerRadius = Const.ballWidth / 2
            greenBall.layer.masksToBounds = true
            greenBall.backgroundColor = TDHUDConfig.shared.loadingBottomBallColor
            ballContainer.addSubview(greenBall)
        }
        
        do {
            redBall.frame = CGRect(center: CGPoint(x: ballContainer.td.width - Const.ballWidth / 2, y: ballContainer.td.height / 2),
                                   size: CGSize(width: Const.ballWidth, height: Const.ballWidth))
            redBall.layer.cornerRadius = Const.ballWidth / 2
            redBall.layer.masksToBounds = true
            redBall.backgroundColor = TDHUDConfig.shared.loadingTopBallColor
            ballContainer.addSubview(redBall)
        }
        
        displayLink = {
            let link = CADisplayLink(target: self, selector: #selector(updateBallAnimations))
            link.add(to: .main, forMode: .common)
            return link
        }()
    }
    
    @objc func updateBallAnimations(){
        switch ballMoveDirection {
        case .positive:
            greenBall.td.centerX += Const.ballSpeed
            redBall.td.centerX -= Const.ballSpeed
            if greenBall.td.right >= ballContainer.td.width || redBall.td.left <= 0 {
                ballMoveDirection = .negative
                bringSubviewToFront(greenBall)
            }
        case .negative:
            greenBall.td.centerX -= Const.ballSpeed
            redBall.td.centerX += Const.ballSpeed
            if greenBall.td.left <= 0 || redBall.td.right >= ballContainer.td.width {
                ballMoveDirection = .positive
                bringSubviewToFront(redBall)
            }
        }
    }
    
    func pauseAnimation(){
        stopAnimation()
        DispatchQueue.main.td.after(Const.pauseSecond) { [weak self] in
            guard let self = self else {
                return
            }
            self.startAnimation()
        }
    }
    
    
}

