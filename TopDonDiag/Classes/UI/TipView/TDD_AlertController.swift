//
//  TDD_AlertController.swift
//  TDDiag
//
//  Created by fench on 2023/6/15.
//

import UIKit
import Masonry
import TDBasis
import TDUIProvider

let ScreenWidth = UIScreen.main.bounds.width//
let ScreenHeight = UIScreen.main.bounds.height
let Scale = Software.isTopScanHD ? UIScreen.main.bounds.width / 1024 : UIScreen.main.bounds.width / 375


extension TDD_AlertController {
    struct Const {
        static let edgeInsets = UIEdgeInsets(top: 24 * Scale, left: 24 * Scale, bottom: 24 * Scale, right: 24 * Scale)
        static let contentInset: CGFloat = (46 * Scale).adaptHD(to: 312.hdVerticalScale)
        static var isKindOfTopVCI: Bool { Software.isKindOfTopVCI }
        static var isTopVCI: Bool { Software.isTopVCI }
    }
}

extension TDD_AlertController {
    
     public struct AlertPriority : ExpressibleByFloatLiteral, Equatable, Strideable {
        public typealias FloatLiteralType = Float
        
        public let value: Float
        
        public init(floatLiteral value: Float) {
            self.value = value
        }
        
        public init(_ value: Float) {
            self.value = value
        }
        
        public static var greatestFiniteMagnitude: AlertPriority {
            return .init(.greatestFiniteMagnitude)
        }
        
        public static var required: AlertPriority {
            return 1000.0
        }
        
        public static var high: AlertPriority {
            return 750.0
        }
        
        public static var medium: AlertPriority {
            return 500.0
        }
        
        public static var low: AlertPriority {
            return 250.0
        }
        
        public static func ==(lhs: AlertPriority, rhs: AlertPriority) -> Bool {
            return lhs.value == rhs.value
        }

        // MARK: Strideable

        public func advanced(by n: FloatLiteralType) -> AlertPriority {
            return AlertPriority(floatLiteral: value + n)
        }

        public func distance(to other: AlertPriority) -> FloatLiteralType {
            return other.value - value
        }
    }

}


@objc public extension TDD_AlertController {
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @objc static func show(title: String?, content: String?, actions: [TDD_AlertAction]) -> TDD_AlertController {
        show(title, message: content, actions: actions)
    }
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @objc static func show(title: String?, content: String?, shouldNoMoreAlert: Bool = false, priority: Int = 1000, onlyExist: Bool = true, actions: [TDD_AlertAction]) -> TDD_AlertController {
        show(title, message: content, shouldNoMoreAlert: shouldNoMoreAlert,priority: priority, onlyExist: onlyExist, actions: actions)
    }
    
    @discardableResult
    /// 弹出alert
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - actions: 弹框按钮
    /// - Returns: 弹框控件
    @objc static func show(title: String?, content: String?, shouldNoMoreAlert: Bool = false, priority: Int = 1000, onlyExist: Bool = true, messageAlign: NSTextAlignment = .center, actions: [TDD_AlertAction]) -> TDD_AlertController {
        show(title, message: content, shouldNoMoreAlert: shouldNoMoreAlert,priority: priority, onlyExist: onlyExist, messageAlign: messageAlign, actions: actions)
    }
    
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - confirmAction: 确认回调
    /// - Returns: 弹框 控件
    @objc static func showDefault(title: String?, content: String?, confirmAction: ((TDD_AlertAction)->Void)?) -> TDD_AlertController {
        showDefault(title: title, content: content, confirmAction: confirmAction, cacncelAction: nil)
    }
    
    
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    /// - Returns: 弹框控件
    @objc static func showIknow(title: String?, content: String?) -> TDD_AlertController {
        showIknow(title: title, content: content, ikonwAction: nil)
    }
    
    @discardableResult
    /// 弹出Alert  Alert类型为默认类型  带取消、确定按钮
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - confirmAction: 确认回调
    ///   - cacncelAction: 取消回调
    /// - Returns: 弹框控件
    @objc static func showDefault(title: String?, content: String?, confirmAction: ((TDD_AlertAction)->Void)?, cacncelAction: ((TDD_AlertAction)->Void)?) -> TDD_AlertController {
        show(title, message: content, actions: [TDD_AlertAction(style: .cancel, cacncelAction), TDD_AlertAction(style: .confirm, confirmAction)])
    }
    
    @discardableResult
    ///  弹出Alert  Alert类型为 我知道了 类型
    /// - Parameters:
    ///   - title: 弹框标题
    ///   - content: 弹框内容
    ///   - ikonwAction: 我知道了点击回调
    /// - Returns: 弹框控件
    @objc static func showIknow(title: String?, content: String?, ikonwAction: ((TDD_AlertAction)->Void)?) -> TDD_AlertController {
        show(title, message: content, actions: [TDD_AlertAction(style: .iknow, ikonwAction)])
    }
}

extension TDD_AlertController {
    @objc public func setAttributeMessage(_ attributeMsg: NSAttributedString?) {
        guard let attributeMsg = attributeMsg else { return }
        messageLabel.text = nil
        messageLabel.attributedText = attributeMsg
        _updateAttributeMsg(attributeMsg)

    }
    
}

@objc public class TDD_AlertController: UIViewController {
    
    /// 是否需要线上不在提示 选项
    @objc public var isShowNomoreAlert: Bool = false
    
    /// alert 弹框的按钮数组
    private var actions: [TDD_AlertAction] = [TDD_AlertAction]()
    /// 标题字体
    public var titleFont: UIFont? = UIFont.systemFont(ofSize: 16, weight: .bold) {
        didSet {
            self.titleLabel.font = titleFont
        }
    }
    /// message 字体
    public var messageFont: UIFont? = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.messageLabel.font = messageFont
        }
    }
    
    private var link: String?
    private var contentView: UIView = UIView()
    private var titleLabel: UILabel = TDD_CustomLabel()
    @objc public var messageLabel: UILabel = TDD_CustomLabel()
    public var nomoreAlertBtn: UIButton = UIButton(type: .custom)
    private var actionBtns: [UIButton] = [UIButton]()
    private var btnView: UIView = UIView()
    private var alertTitle: String?
    private var message: String?
    private var scrollView: UIScrollView = UIScrollView()
    private var onlyExist: Bool = true
    public var priority: Int = 1000
    private var hasTitle: Bool { !(alertTitle?.isEmpty ?? true) }
    private var hasMessage: Bool { !(message?.isEmpty ?? true) }
    private var messageAlign: NSTextAlignment = .center
    private var btnViewHeight: CGFloat {
        let btnHeight = actions.count > 2 ? 50 * CGFloat(actions.count) * Scale : (Const.isTopVCI ? 70 : 50) * Scale
        return btnHeight + noMoreHeight
    }
    private var noMoreHeight: CGFloat { isShowNomoreAlert ? 40 * Scale : 0 }
    /// 显示alertView 使用方法类似UIAlertController
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 说明
    ///   - actions: actions [TDD_AlertAction]
    @discardableResult
    static internal func show(_ title: String?, message: String?, shouldNoMoreAlert: Bool = false, priority: Int = 1000, onlyExist: Bool = true, messageAlign: NSTextAlignment = .center, actions: [TDD_AlertAction]) -> TDD_AlertController {
        UIApplication.shared.keyWindow?.endEditing(true)
        let alert = TDD_AlertController()
        alert.hidesBottomBarWhenPushed = true
        alert.modalPresentationStyle = .overCurrentContext
        alert.alertTitle = title
        alert.actions = actions
        alert.message = message
        alert.onlyExist = onlyExist
        alert.isShowNomoreAlert = shouldNoMoreAlert
        alert.priority = priority
        alert.messageAlign = messageAlign
        if let alertVC = UIViewController.currentVC as? TDD_AlertController {
            if priority < alertVC.priority { return alert }
            
            if alertVC.onlyExist == true {
                UIViewController.currentVC?.dismiss(animated: false , completion: {
                })
            }else {
                if alert.onlyExist == false && alert.priority > alertVC.priority {
                    UIViewController.currentVC?.dismiss(animated: false , completion: {
                    })
                }
            }
            
            DispatchQueue.main.after(0.03) {
                if UIViewController.currentVC?.tabBarController != nil {
                    UIViewController.currentVC?.tabBarController?.present(alert, animated: false, completion: nil)
                } else {
                    UIViewController.currentVC?.present(alert, animated: false, completion: nil)
                }
            }
        } else {
            if UIViewController.currentVC?.tabBarController != nil {
                UIViewController.currentVC?.tabBarController?.present(alert, animated: false, completion: nil)
            } else {
                UIViewController.currentVC?.present(alert, animated: false, completion: nil)
            }
        }
        
        return alert
        
    }
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        _init()
        
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    /// 初始化UI
    private func _init(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        contentView = UIView()
        if Software.isKindOfTopVCI {
            contentView.backgroundColor = UIColor.tdd_alertBg()
        } else {
            contentView.backgroundColor = UIColor.tdd_background()
        }
        contentView.layer.cornerRadius = 2.5
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.indicatorStyle = Software.isKindOfTopVCI ? .white : .black
        
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        
        titleLabel = TDD_CustomLabel()
        titleLabel.font = titleFont
        titleLabel.textColor = UIColor.tdd_title()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = alertTitle
        
        messageLabel.isUserInteractionEnabled = true
        messageLabel.text = message
        messageLabel.font = messageFont
        messageLabel.textColor = UIColor.tdd_title()
        messageLabel.textAlignment = messageAlign
        messageLabel.numberOfLines = 0
        // 通过NSMutableParagraphStyle来设置特定行的对齐方式
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center // 多行对齐方式为左对齐
         
        // 如果只有一行，使用center对齐
        if let text = message, text.count <= 1 {
            paragraphStyle.alignment = .center
        }
        // 创建属性字典
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
         
        // 为UILabel应用属性
        messageLabel.attributedText = NSAttributedString(string: message ?? "", attributes: attributes)
        
        nomoreAlertBtn.setTitle(TDDLocalized.dialog_vci_vol_tips, for: .normal)
        nomoreAlertBtn.setImage(UIImage.tdd_imageAlertCheckboxNormal(), for: .normal)
        nomoreAlertBtn.setImage(UIImage.tdd_imageAlertCheckboxSelect(), for: .selected)
        nomoreAlertBtn.contentHorizontalAlignment = .left
        nomoreAlertBtn.setTitleColor(UIColor.tdd_title(), for: .normal)
        nomoreAlertBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        nomoreAlertBtn.titleLabel?.numberOfLines = 2
        nomoreAlertBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        nomoreAlertBtn.isHidden = !isShowNomoreAlert
        nomoreAlertBtn.addTarget(self, action: #selector(onNoMoreClick(_:)), for: .touchUpInside)
        contentView.addSubview(nomoreAlertBtn)
        
        
        btnView = UIView()
        btnView.backgroundColor = .clear
        self.contentView.addSubview(btnView)
        
        _setupConstains()
    }
    
    private func _setupConstains(){
        titleLabel.isHidden = !hasTitle
        messageLabel.isHidden = !hasMessage
        let maxScrollHeight: CGFloat = Software.isTopScanHD ? 240 * Scale : 300 * Scale
        var scrollContentHeight: CGFloat = 0
        
        let messageHeight = (message as? NSString)?.boundingRect(with: CGSize(width: ScreenWidth - (140 * Scale).adaptHD(to: (320*2+40*2).hdVerticalScale), height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : messageFont ?? .systemFont(ofSize: 15)], context: nil).height ?? 0
        
        var titleHeight = (alertTitle as? NSString)?.boundingRect(with: CGSize(width: ScreenWidth - (140 * Scale).adaptHD(to: (320*2+40*2).hdVerticalScale), height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: titleFont ?? .systemFont(ofSize: 16, weight: .bold)], context: nil).height ?? 0
        titleHeight = titleHeight == 0 ? 0 : titleHeight + 5 * Scale

        let tHeight = titleHeight
        let mHeight = messageHeight
        let margin = (tHeight > 0 && mHeight > 0) ? (20.0 * Scale).adaptHD(to: 40.hdVerticalScale) : 0
        let contentHeight = tHeight + mHeight + Const.edgeInsets.top * 2 + margin
        scrollContentHeight = min(contentHeight, maxScrollHeight)
        
        contentView.mas_makeConstraints {
            $0?.centerY.equalTo()(view)
            $0?.left.right().equalTo()(view)?.inset()(Const.contentInset)
            $0?.height.mas_equalTo()(scrollContentHeight + btnViewHeight)
        }
        
        scrollView.mas_makeConstraints {
            $0?.edges.equalTo()(contentView)?.insets()(UIEdgeInsets(top: 0, left: 0, bottom: 40 * Scale, right: 0))
        }
        let sContentView = UIView()
        scrollView.addSubview(sContentView)
        sContentView.mas_makeConstraints {
            $0?.edges.equalTo()(scrollView)?.insets()(Const.edgeInsets)
            $0?.width.equalTo()(contentView)?.offset()(-2 * Const.edgeInsets.left)
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        sContentView.addSubview(stackView)
        stackView.mas_makeConstraints {
            $0?.edges.equalTo()(sContentView)
            $0?.bottom.equalTo()(sContentView)
        }
        
        titleLabel.mas_makeConstraints {
            $0?.left.right().equalTo()(stackView)
        }
        
        messageLabel.mas_makeConstraints {
            $0?.left.right().equalTo()(stackView)
        }
        
        _setupBtnsConstatins()
        
        self.view.setNeedsUpdateConstraints()
    }
    
    private func _updateAttributeMsg(_ attribute: NSAttributedString){
        let maxScrollHeight: CGFloat = Software.isTopScanHD ? 240 * Scale : 300 * Scale
        var scrollContentHeight: CGFloat = 0

        let attributes: [NSAttributedString.Key: Any] = [.font: titleLabel.font ?? UIFont.systemFont(ofSize: 16, weight: .bold)]
        var titleHeight = (alertTitle as? NSString)?.boundingRect(with: CGSize(width: ScreenWidth - (140 * Scale).adaptHD(to: (320*2+40*2).hdVerticalScale), height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: attributes, context: nil).height ?? 0
        let messageHeight = attribute.boundingRect(with: CGSize(width: ScreenWidth - (140 * Scale).adaptHD(to: (320*2+40*2).hdVerticalScale), height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height
        titleHeight = titleHeight == 0 ? 0 : titleHeight + 5

        let margin = (titleHeight > 0 && messageHeight > 0) ? (20.0 * Scale).adaptHD(to: 40.hdVerticalScale) : 0
        let contentHeight = titleHeight + messageHeight + Const.edgeInsets.top * 2 + margin
        scrollContentHeight = min(contentHeight, maxScrollHeight)
        
        contentView.snp.updateConstraints {
            $0.height.equalTo(scrollContentHeight + CGFloat(btnViewHeight))
        }
        scrollView.snp.updateConstraints {
            $0.height.equalTo(scrollContentHeight)
        }
    }
    
    private func _setupBtnsConstatins(){
        
        nomoreAlertBtn.snp.makeConstraints {
            $0.bottom.equalTo(btnView.snp.top).offset(-(20.0 * Scale).adaptHD(to: 40.hdVerticalScale))
            $0.left.right.equalToSuperview().inset(Const.edgeInsets.left)
        }
        
        btnView.mas_makeConstraints {
            $0?.height.mas_equalTo()(btnViewHeight - noMoreHeight)
            $0?.left.right().bottom().equalTo()(self.contentView)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.tdd_line()
        btnView.addSubview(lineView)
        lineView.mas_makeConstraints {
            $0?.top.left().right().equalTo()(btnView)
            $0?.height.mas_equalTo()(1)
        }
        
        actionBtns.forEach { $0.removeFromSuperview() }
        actionBtns.removeAll()
        
        for (index, action) in actions.enumerated() {
            let btn = UIButton(type: .custom)
            btn.tag = index
            btn.setTitle(action.title, for: .normal)
            btn.setTitleColor(action.titleColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            btn.backgroundColor = action.backgroundColor
            btn.addTarget(self, action: #selector(onBtnsClick(_:)), for: .touchUpInside)
            if Const.isTopVCI  {
                btn.layer.cornerRadius = 5
                btn.layer.masksToBounds = true
            }
            btnView.addSubview(btn)
            actionBtns.append(btn)
        }
        
        let btnHeight: CGFloat = Const.isTopVCI ? 45 * Scale : 50 * Scale
        lineView.isHidden = Const.isTopVCI
        if actionBtns.count == 1 {
            if Const.isTopVCI {
                lineView.isHidden = true
            }
            
            let inset: CGFloat = Const.isTopVCI ? 32 * Scale : 0
            actionBtns.first?.mas_makeConstraints {
                $0?.top.equalTo()(btnView)
                $0?.left.right().equalTo()(btnView)?.inset()(inset)
                $0?.height.mas_equalTo()(btnHeight)
            }
        } else {
            let btns = actionBtns as NSArray
            
            let spacing: CGFloat = Const.isTopVCI ? 20 * Scale : 0
            let inset: CGFloat = Const.isTopVCI ? 20 * Scale : 0
            btns.mas_distributeViews(along: .horizontal, withFixedSpacing: spacing, leadSpacing: inset, tailSpacing: inset)
            btns.mas_makeConstraints {
                $0?.top.equalTo()(btnView)
                $0?.height.mas_equalTo()(btnHeight)
            }
        }
        btnView.bringSubviewToFront(lineView)
    }
    
    /// 点击了 action 按钮
    @objc final func onBtnsClick(_ sender: UIButton){
        let index = sender.tag
        self.actions.forEach { (action) in
            action.isNomoreAlert = isShowNomoreAlert ? nomoreAlertBtn.isSelected : false
        }
        if index > actions.count {
            return
        }
        hide {
            self.actions[index].action?(self.actions[index])
        }
    }
    
    /// 隐藏Alert
    private  func hide(_ complete: (()->Void)? = nil){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0
        }) { (res) in
            self.dismiss(animated: true, completion: {
                complete?()
            })
        }
    }
    
    @objc func onNoMoreClick(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
    
}

enum TDD_AlertActionStyle {
    /// 确认按钮
    case confirm
    /// 取消按钮
    case cancel
    /// 我知道了  按钮
    case iknow
    
    case custom(title: String, color: UIColor, backgroundColor: UIColor)
    
    var textColor : UIColor {
        switch self {
        case .confirm:
            return UIColor.tdd_colorDiagTheme()
        case .cancel:
            return UIColor.tdd_subTitle()
        case .iknow:
            return UIColor.tdd_colorDiagTheme()
        case .custom(_, let color, _):
            return color
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .confirm:
            return UIColor.tdd_alertConfirmBg()
        case .cancel:
            return UIColor.tdd_alertCancelBg()
        case .iknow:
            return UIColor.tdd_alertConfirmBg()
        case .custom(_, _, let backgroundColor):
            return backgroundColor
        }
    }
    
    var title: String {
        switch self {
        case .confirm:
            return TDDLocalized.app_confirm
        case .cancel:
            return TDDLocalized.app_cancel
        case .iknow:
            return TDDLocalized.app_confirm
        case .custom(let title, _, _):
            return title
        }
    }
}


@objc public class TDD_AlertAction: NSObject {
    fileprivate var titleColor: UIColor { style.textColor }
    /// 标题
    public var title: String!
    /// 图片
    public var image: UIImage?
    /// 点击回调
    public var action: ((_ action: TDD_AlertAction) -> Void)?
    /// 按钮的样式
    fileprivate var style: TDD_AlertActionStyle = .confirm
    
    fileprivate var backgroundColor: UIColor { style.backgroundColor }
    
    @objc public static var confirmAction: TDD_AlertAction { TDD_AlertAction(style: .confirm, nil) }
    
    @objc public static var cancelAction: TDD_AlertAction { TDD_AlertAction(style: .cancel, nil) }
    
    @objc public static var iknowAction: TDD_AlertAction { TDD_AlertAction(style: .iknow, nil) }
    
    // 是否不再提示
    @objc public var isNomoreAlert: Bool = false
    
    /// 快速构建AlertAction  alert 的按钮
    ///
    /// - Parameters:
    ///   - title: 按钮的标题
    ///   - style: TDD_AlertActionStyle 支持default 和 cancel 两种样式
    ///   - image: 按钮的图片
    ///   - action: 点击按钮的回调
    convenience init(style: TDD_AlertActionStyle, image: UIImage? = nil, _ action: ((_ action: TDD_AlertAction) -> Void)?) {
        self.init()
        self.title = style.title
        self.image = image
        self.action = action
        self.style = style
    }
    
    @objc public convenience init(title: String, image: UIImage? = nil, titleColor: UIColor? = nil, action: ((_ action: TDD_AlertAction) -> Void)?) {
        self.init()
        
        self.title = title
        self.image = image
        self.action = action
        if let titleColor = titleColor {
            self.style = .custom(title: title, color: titleColor, backgroundColor: UIColor.tdd_alertConfirmBg())
        }
    }
    
    @objc public convenience init(title: String, image: UIImage? = nil, action: ((_ action: TDD_AlertAction) -> Void)?) {
        self.init()
        
        self.title = title
        self.image = image
        self.action = action
    }
}

extension String {
    func setHilight(`of` subString: String?, hilightColor: UIColor, normalColor: UIColor = .white, forLast: Bool = false, space: CGFloat? = nil) -> NSAttributedString{
        let tempString = NSMutableAttributedString.init(string: self)
        if let space = space {
            let paraGraph = NSMutableParagraphStyle()
            paraGraph.lineSpacing = space
            paraGraph.alignment = .left
            let range = NSRange(location: 0, length: count )
            tempString.addAttributes([NSAttributedString.Key.paragraphStyle: paraGraph], range: range)
        }
        // 如果传入的子文本为空 则返回原文本的富文本
        guard let subString = subString else {
            return tempString as NSAttributedString
        }
        
        // 如果设置的高亮文本不在父文本中 返回原文本的富文本
        guard let _ = self.lowercased().range(of: subString.lowercased()) else {
            return tempString as NSAttributedString
        }
        // 设置普通文本颜色
        let normal = [NSAttributedString.Key.foregroundColor : normalColor]
        let nRange = (self as NSString).range(of: self)
        tempString.addAttributes(normal, range: nRange)
        // 设置文本高亮
        let att = [NSAttributedString.Key.foregroundColor : hilightColor]
        if forLast {
            if let ranges = getAllRange(of: subString).last {
                tempString.addAttributes(att, range: ranges)
            }
        } else {
            let nsRange = (self as NSString).range(of: subString)
            tempString.addAttributes(att, range: nsRange)
        }
        return tempString as NSAttributedString
    }
    
    func getAllRange(of subString: String?) -> [NSRange] {
        var ranges = [NSRange]()
        guard let subString = subString else {
            return ranges
        }
        let nsSelf = self as NSString
        var range = nsSelf.range(of: subString)
        if range.location == NSNotFound {
            return ranges
        }
        
        var temp = nsSelf
        var location = 0
        while range.location != NSNotFound {
            if location == 0 {
                location += range.location
            } else {
                location += range.location + subString.count
            }
            
            let tmpRange = NSRange(location: location, length: subString.count)
            ranges.append(tmpRange)
            
            temp = temp.substring(from: range.location + range.length) as NSString
            range = temp.range(of: subString)
        }
        return ranges
    }
}


extension NSMutableAttributedString {
    func setHilight(`of` subString: String?, hilightColor: UIColor, normalColor: UIColor = .white) -> NSMutableAttributedString{
        let tempString = self.string
        // 如果传入的子文本为空 则返回原文本的富文本
        guard let subString = subString else {
            return self
        }
        
        // 如果设置的高亮文本不在父文本中 返回原文本的富文本
        guard let _ = tempString.lowercased().range(of: subString.lowercased()) else {
            return self
        }
        // 设置文本高亮
        let att = [NSAttributedString.Key.foregroundColor : hilightColor]
        let nsRange = (tempString as NSString).range(of: subString)
        self.addAttributes(att, range: nsRange)
        return self
    }
}

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
    
    public func after(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
}


extension UIViewController {
    private static func topViewController(with topRootViewController: UIViewController?) -> UIViewController? {
        if topRootViewController == nil {
            return nil
        }
        
        if topRootViewController?.presentedViewController != nil {
            return self.topViewController(with:topRootViewController?.presentedViewController!)
        }
        else if topRootViewController is UITabBarController {
            return self.topViewController(with:(topRootViewController as! UITabBarController).selectedViewController)
        }
        else if topRootViewController is UINavigationController {
            return self.topViewController(with:(topRootViewController as! UINavigationController).visibleViewController)
        }
        else {
            return topRootViewController
        }
        
    }
    
    // MARK: - 获取当前屏幕显示的viewcontroller
    @objc static var currentVC: UIViewController? {
        var window = UIApplication.shared.keyWindow
        //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
        if window == nil {
            return nil
        }
        if window!.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin: UIWindow in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                }
            }
        }
        
        return self.topViewController(with: window?.rootViewController)
    }
}
