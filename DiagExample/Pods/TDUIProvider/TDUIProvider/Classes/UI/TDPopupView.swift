//
//  TDPopupView.swift
//  TDUIProvider
//
//  Created by Fench on 2025/4/23.
//

import Foundation
import TDBasis

// 弹框优先级
public struct TDPopupPriority: ExpressibleByFloatLiteral, Equatable, Strideable {
    public typealias FloatLiteralType = Float
    
    public let value: Float
    
    public init(floatLiteral value: Float) { self.value = value }
    
    public init(_ value: Float) { self.value = value }
    
    /// 无穷大  优先级最大
    public static var infinity: TDPopupPriority { .init(.infinity) }
    
    /// 浮点最大数
    /// 此优先级比  `infinity` 小
    public static var greatestFiniteMagnitude: TDPopupPriority { return .init(.greatestFiniteMagnitude) }
    
    public static var required: TDPopupPriority { 1000.0 }
    
    public static var high: TDPopupPriority { 750.0 }
    
    public static var medium: TDPopupPriority { 500.0 }
    
    public static var low: TDPopupPriority { 250.0 }
    
    public static func ==(lhs: TDPopupPriority, rhs: TDPopupPriority) -> Bool { lhs.value == rhs.value }

    // MARK: Strideable
    public func advanced(by n: FloatLiteralType) -> TDPopupPriority { TDPopupPriority(floatLiteral: value + n) }

    public func distance(to other: TDPopupPriority) -> FloatLiteralType { other.value - value }
}

@objc
/// 当前弹框的触发显示行为
public enum TDPopupViewUntriggeredBehavior: Int {
    /// 当弹窗触发显示逻辑，但未满足条件时会被直接丢弃
    case discard
    /// 当弹窗触发显示逻辑，但未满足条件时会继续等待
    case await
}

@objc
/// 当前弹框已显示，后续触发其他弹框，当前弹框的显示行为
public enum TDPopupViewSwitchBehavior: Int {
    /// 当该弹窗已经显示，如果后面来了弹窗优先级更高的弹窗时，显示更高优先级弹窗并且当前弹窗会被抛弃
    case discard
    /// 当该弹窗已经显示，如果后面来了弹窗优先级更高的弹窗时，显示更高优先级弹窗并且当前弹窗重新进入队列, PS：优先级相同时同 TDPopupViewSwitchBehaviorDiscard
    case latent
    /// 当该弹窗已经显示时，不会被后续高优线级的弹窗影响
    case await
}

@objc
public protocol TDPopupView: NSObjectProtocol {
    
    @objc(showPopupView)
    /// `PopupSchedulerStrategyQueue`会根据 `showPopup()` 做显示逻辑，如果含有动画请实现`showPopupwith:)`方法
    optional func showPopupView()
    
    @objc(dismissPopupView)
    /// `PopupSchedulerStrategyQueue`会根据 `dismissPopup() `做隐藏逻辑，如果含有动画请实现`dismissPopup(with:)`方法
    optional func dismissPopupView()
    
    @objc(showWithAnimation:)
    /// `PopupSchedulerStrategyQueue`会根据 `showPopup(with:)` 来做显示逻辑。如果`animation`不传可能会出现意料外的问题
    optional func showWithAnimation(_ animation: Block.VoidBlock?)
    
    @objc(dismissWithAnimation:)
    /// `PopupSchedulerStrategyQueue`会根据 `dismissPopup(with:)` 做隐藏逻辑，
    /// 如果含有动画请实现`dismissPopup(with:)`方法，如果`animation`不传可能会出现意料外的问题
    optional func dismissWithAnimation(_ animation: Block.VoidBlock?)
    
    @objc
    /// `PopupSchedulerStrategyQueue`会根据`canRegisterFirstPopupView`判断
    /// 当队列顺序轮到它的时候是否能够成为响应的第一个优先级`PopupView`。
    /// 默认为 `true`
    optional var canRegisterFirstPopupViewResponder: Bool { get }
    
    @objc(popupViewUntriggeredBehavior)
    /// `PopupSchedulerStrategyQueue` 会根据 `popupViewUntriggeredBehavior`来决定触发时弹窗的显示行为
    /// 默认为 `.await`
    optional var untriggerBehavior: TDPopupViewUntriggeredBehavior { get }
    
    @objc(popupViewSwitchBehavior)
    /// `TDPopupViewSwitchBehavior` 会根据 `popupViewSwitchBehavior`来决定已经显示的弹窗，是否会被后续更高优先级的弹窗锁影响
    /// 默认为 .await
    optional var switchBehavior: TDPopupViewSwitchBehavior { get }
}

@objc
/*
 为当前对象生成一个popup对象, 用于类似UIAlertController  这类无法直接遵守 <TDPopupView>的对象。类似这一类弹窗对象，需要做到下面3个步骤
 1. 告诉TDPopupViewPlaceHolder如何显示：showPopupViewCallBlock
 2. 告诉TDPopupViewPlaceHolder 如何隐藏：removePopupViewCallBlock
 3. 在<TDPopupView>主动消失的时候， RealPopView 需要通过 -remove：主动把 TDPopupViewPlaceHolder 从 TDPopupScheduler 中移除
 */
@objcMembers
public class TDPopupViewPlaceHolder: NSObject, TDPopupView {
    
    @objc(generatePlaceHolderWith:)
    /// 生成一个占位 popup
    public static func generate(placeHolder: AnyObject) -> TDPopupViewPlaceHolder {
        let handler = TDPopupViewPlaceHolder()
        handler._target = placeHolder
        return handler
    }
    
    // 显示 block
    @objc public var showPopupViewCallBlock: Block.ParameterBlock<AnyObject?>?
    
    // 隐藏 block
    @objc public var removePopupViewCallBlock: Block.ParameterBlock<AnyObject?>?
    
    // show
    public func show() {
        self.showPopupViewCallBlock?(_target)
    }
    
    // dismiss
    public func dismiss() {
        self.removePopupViewCallBlock?(_target)
    }
    
    private weak var _target: AnyObject?
}

@objc(TDPopupScheduler)
@objcMembers
public class TDPopupScheduler: NSObject {
    public static let shared: TDPopupScheduler = .init()
    
    /// 返回当前调度器是否拥有已经显示的弹窗, 如果canRegisterFirstPopupViewResponder为true，registerFirstPopupViewResponder将执行无效
    public var canRegisterFirstPopupViewResponder: Bool {
        var canRegister = false
        DispatchQueue.syncInMain {
            canRegister = self.list.canRegisterFirstFirstPopupViewResponder()
        }
        return canRegister
    }
    
    /// 返回当前调取队列是否存在弹窗
    public var isEmpty: Bool {
        var empty = false
        DispatchQueue.syncInMain {
            empty = self.list.isEmpty()
        }
        return empty
    }
    
    // MARK: - Initialization
    
    override init() {
        self.list = TDPopupQueue()
        super.init()
        TDPopupScheduler.initializeRunLoopObserver()
        TDPopupScheduler.schedulers.add(self)
    }
    
    // MARK: - Public Methods
    
    /// 可以将调度器进行挂起，可以中止队列触发- execute。挂起状态不会影响已经execute的弹窗
    public var suspended: Bool = false {
        didSet {
            if !suspended {
                DispatchQueue.main.async {
                    self.registerFirstPopupViewResponder()
                }
            }
        }
    }
    
    /// 向队列插入一个弹窗，PopupScheduler会根据设置的策略状态来控制在队列中插入的位置,  如果条件允许（通过-hitTest），将会通过showAnimation(with:) or show 显示。 支持线程安全 优先级默认 为 .medium
    /// - Parameter view: 弹框实例
    public func add(_ view: TDPopupView) {
        add(view, priority: .medium)
    }
    
    @available(swift, deprecated: 3.0, message: "swift 请使用 TDPopupPriority option")
    @objc
    public func add(_ view: TDPopupView, priorityValue: Float) {
        add(view, priority: TDPopupPriority.init(priorityValue))
    }
    
    /// 向队列插入一个弹窗，PopupScheduler会根据设置的策略状态来控制在队列中插入的位置,  如果条件允许（通过-hitTest），将会通过showAnimation(with:) or show 显示。 支持线程安全
    /// - Parameters:
    ///   - view: 弹框实例
    ///   - priority: 优先级
    public func add(_ view: TDPopupView, priority: TDPopupPriority) {
        DispatchQueue.asyncInMain {
            self.list.addPopupView(view, priority: priority)
            self.registerFirstPopupViewResponder()
        }
    }
    
    /// 把弹窗种队列种移除, 不会触发<TDPopupView>的dismiss or dismissAnimation(with:) 方法，支持线程安全
    public func remove(_ view: TDPopupView) {
        DispatchQueue.asyncInMain {
            self.list.removePopupView(view)
        }
    }
    
    ///  移除队列中所有的弹窗队列，显示的弹窗将会触发<TDPopupView>的dismiss or dismissAnimation(with:)方法,  并优先执行dismissAnimation(with:)方法。 支持线程安全
    public func removeAllPopupViews() {
        DispatchQueue.asyncInMain {
            self.list.clear()
        }
    }
    
    /// 向调度器主动发送一个执行显示弹窗的命令, 支持线程安全
    public func registerFirstPopupViewResponder() {
        guard !suspended && canRegisterFirstPopupViewResponder else { return }
        DispatchQueue.asyncInMain {
            self.list.execute()
        }
    }
    
    // MARK: - Private Methods
    private var list: TDPopupQueue
    
    private static func createStrategyQueue() -> TDPopupQueue {
        TDPopupQueue()
    }
    
    // MARK: - Static Properties & Methods
    
    private static var schedulers = NSHashTable<TDPopupScheduler>.weakObjects()
    
    static func initializeRunLoopObserver() {
        DispatchQueue.once(token: "com.td.TDPopupScheduler") {
            let info = Unmanaged.passUnretained(schedulers).toOpaque()
            
            var context = CFRunLoopObserverContext(
                version: 0,
                info: info,
                retain: nil,
                release: nil,
                copyDescription: nil
            )
            
            let observer = CFRunLoopObserverCreate(
                kCFAllocatorDefault,
                CFRunLoopActivity.beforeWaiting.rawValue | CFRunLoopActivity.exit.rawValue,
                true,
                0xFFFFFF,
                runLoopObserverCallback,
                &context
            )
            CFRunLoopAddObserver(CFRunLoopGetMain(), observer, CFRunLoopMode.commonModes)
        }
    }
}

extension DispatchQueue {
    public static func syncInMain(_ handler: @escaping Block.VoidBlock) {
        if Thread.current.isMainThread {
            handler()
        } else {
            DispatchQueue.main.sync {
                handler()
            }
        }
    }
    
    public static func asyncInMain(_ handler: @escaping Block.VoidBlock) {
        if Thread.current.isMainThread {
            handler()
        } else {
            DispatchQueue.main.async {
                handler()
            }
        }
    }
}

private func runLoopObserverCallback(observer: CFRunLoopObserver?, activity: CFRunLoopActivity, info: UnsafeMutableRawPointer?) {
    // 从info中获取我们需要的数据
    guard let info = info else { return }
    let schedulers = Unmanaged<NSHashTable<TDPopupScheduler>>.fromOpaque(info).takeUnretainedValue()
    
    for scheduler in schedulers.allObjects {
        if !scheduler.isEmpty {
            scheduler.registerFirstPopupViewResponder()
        }
    }
}

class TDPopupQueue: NSObject {
    private var list: [PopupElement] = []
    private(set) var firstFirstResponderElement: PopupElement?
    
    func canRegisterFirstFirstPopupViewResponder() -> Bool {
        return firstFirstResponderElement == nil
    }
    
    func addPopupView(_ view: TDPopupView, priority: TDPopupPriority) {
        monitorRemoveEvent(with: view)
        
        var index = 0
        // Create FIFO
        enumerateObjects { (obj, idx, stop) in
            if obj.priority > priority {
                index += 1
            } else if obj.priority == priority  {
                index += 1
            } else {
                stop = true
            }
        }
        
        insert(PopupElement.element(with: view, priority: priority), at: index)
        
        guard let firstResponderElement = firstFirstResponderElement else { return }
        let firstResponderPopup = firstResponderElement.data
        let firstResponderPriority = firstResponderElement.priority
        
        let jump = firstResponderPopup.responds(to: #selector(getter: TDPopupView.switchBehavior)) &&
                  firstResponderPopup.switchBehavior != .await
        let highPriority = firstResponderPriority < priority
        
        var reinsert = false
        if jump && highPriority {
            switch firstResponderPopup.switchBehavior {
            case .await:
                break
            case .latent:
                reinsert = firstResponderPriority < priority
                discardPopupElement(firstResponderElement)
            case .discard:
                discardPopupElement(firstResponderElement)
            case .none:
                break 
            }
        }
        
        if reinsert {
            addPopupView(firstResponderPopup, priority: firstResponderPriority)
        }
    }
    
    private func discardPopupElement(_ element: PopupElement) {
        if element.data.responds(to: #selector(TDPopupView.dismissPopupView)) {
            element.data.dismissPopupView?()
        } else if element.data.responds(to: #selector(TDPopupView.dismissWithAnimation(_:))) {
            element.data.dismissWithAnimation? {
                TDLogDebug("-dismissPopupViewWithAnimation: Triggered by a higher priority popover")
            }
        }
    }
    
    func removePopupView(_ view: TDPopupView) {
        removeData(view)
        if firstFirstResponderElement?.data === view {
            firstFirstResponderElement = nil
        }
    }
    
    func execute() {
        guard let element = hitTestFirstPopupResponder() else { return }
        let view = element.data
        firstFirstResponderElement = element
        
        if view.responds(to: #selector(TDPopupView.showWithAnimation(_:))) {
            view.showWithAnimation?({})
        } else if view.responds(to: #selector(TDPopupView.showPopupView)) {
            view.showPopupView?()
        } else {
            assertionFailure("You must implement either -showPopupViewWithAnimation: or -showPopupView")
        }
    }
    
    func isEmpty() -> Bool {
        return list.isEmpty
    }
    
    func clear() {
        list.removeAll()
        
        guard let data = firstFirstResponderElement?.data else { return }
        if data.responds(to: #selector(TDPopupView.dismissWithAnimation(_:))) {
            data.dismissWithAnimation? { [weak self] in
                self?.firstFirstResponderElement = nil
            }
        }else if data.responds(to: #selector(TDPopupView.dismissPopupView)) {
            data.dismissPopupView?()
            firstFirstResponderElement = nil
        }
        
    }
    
    // MARK: - Private Methods
    
    private func hitTestFirstPopupResponder() -> PopupElement? {
        var element: PopupElement?
        var index = 0
        
        while index < list.count {
            let temp = list[index]
            let data = temp.data
            var canRegisterFirstPopupViewResponder = true
            
            if let canRegister = data.canRegisterFirstPopupViewResponder {
                canRegisterFirstPopupViewResponder = canRegister
            }
            
            if canRegisterFirstPopupViewResponder {
                element = temp
                break
            } else if let behavior = data.untriggerBehavior, behavior == .discard {
                list.remove(at: index)
                continue
            }
            
            index += 1
        }
        
        return element
    }
    
    private func pushBack(_ element: PopupElement) {
        list.append(element)
    }
    
    private func pushFront(_ element: PopupElement) {
        list.insert(element, at: 0)
    }
    
    private func insert(_ element: PopupElement, at index: Int) {
        let safeIndex: Int = {
            if index < 0 {
                TDLogDebug("⚠️ 插入索引值异常: \(index) 已自动修正为0")
                return 0
            }
            if index > list.count {
                let clampedIndex = list.count
                TDLogDebug("⚠️ 插入越界: \(index)/\(list.count) 已修正为末尾")
                return clampedIndex
            }
            return index
        }()
        list.insert(element, at: safeIndex)
    }
    
    private func remove(_ element: PopupElement) {
        removeData(element.data)
    }
    
    private func enumerateObjects(using block: (PopupElement, Int, inout Bool) -> Void) {
        var stop = false
        for (index, element) in list.enumerated() where !stop {
            block(element, index, &stop)
        }
    }
    
    private func removeData(_ data: TDPopupView) {
        list.removeAll { $0.data === data }
    }
    
}

private var kTDPopupListPopupMonitorKey: UInt8 = 0
extension TDPopupQueue {
    func monitorRemoveEvent(with popup: TDPopupView) {
        // 强引用持有监控对象（避免野指针）
        objc_setAssociatedObject(
            popup,
            &kTDPopupListPopupMonitorKey,
            self,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
        
        // 获取弹出视图的实际类（非协议类型）
        guard let popupClass = object_getClass(popup) else {
            assertionFailure("Popup必须为NSObject类型")
            return
        }
        
        // 安全的方法交换
        let originalSelectors = [
            #selector(TDPopupView.dismissPopupView),
            #selector(TDPopupView.dismissWithAnimation(_:))
        ]
        
        originalSelectors.forEach { selector in
            guard popup.responds(to: selector) else { return }
            
            let monitorSelector = Selector("Monitor_\(selector.description)")
            let originalMethod = class_getInstanceMethod(popupClass, selector)
            let monitorMethod = class_getInstanceMethod(type(of: self), monitorSelector)
            
            // 动态添加监控方法到弹出类
            let added = class_addMethod(
                popupClass,
                monitorSelector,
                method_getImplementation(monitorMethod!),
                method_getTypeEncoding(monitorMethod!)
            )
            
            // 交换实现
            if added {
                method_exchangeImplementations(
                    class_getInstanceMethod(popupClass, selector)!,
                    class_getInstanceMethod(popupClass, monitorSelector)!
                )
            }
        }
    }
    
    @objc private func Monitor_dismissPopupView() {
        self.Monitor_dismissPopupView()
        
        if let obj = self as? TDPopupView {
            TDPopupQueue.tryRemovePopupView(obj)
        }
    }
    
    @objc private func Monitor_dismissWithAnimation(_ block: Block.VoidBlock?) {
        let monitorBlock = {
            block?()
            if let obj = self as? TDPopupView {
                TDPopupQueue.tryRemovePopupView(obj)
            }
        }
        
        self.Monitor_dismissWithAnimation(monitorBlock)
    }
    
    private static func tryRemovePopupView(_ obj: any TDPopupView) {
        if let list = objc_getAssociatedObject(obj, &kTDPopupListPopupMonitorKey) as? TDPopupQueue {
            objc_setAssociatedObject(obj, &kTDPopupListPopupMonitorKey, nil, .OBJC_ASSOCIATION_ASSIGN)
            list.removePopupView(obj)
            // Wake up main thread for hitTest
            list.perform(#selector(NSObject.hash), with: nil, afterDelay: 0)
        }
    }
}

// MARK: - Method Swizzling Helper

extension NSObject {
    class func swizzleOrAddInstanceMethod(
        originalSelector: Selector,
        newSelector: Selector,
        newClass: AnyClass
    ) {
        guard let originalMethod = class_getInstanceMethod(self, originalSelector),
              let newMethod = class_getInstanceMethod(newClass, newSelector) else {
            return
        }
        
        if class_addMethod(
            self,
            originalSelector,
            method_getImplementation(newMethod),
            method_getTypeEncoding(newMethod)
        ) {
            class_replaceMethod(
                self,
                newSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, newMethod)
        }
    }
}

@objc(TDPopupElement)
@objcMembers
public class PopupElement: NSObject {
    public var data: TDPopupView
    public var priority: TDPopupPriority
    public var createStamp: Double
    public var latent: Bool = false
    
    init(data: TDPopupView, priority: TDPopupPriority) {
        self.data = data
        self.priority = priority
        self.createStamp = ProcessInfo.processInfo.systemUptime
    }
    
    static func element(with data: TDPopupView, priority: TDPopupPriority) -> PopupElement {
        return PopupElement(data: data, priority: priority)
    }
}
