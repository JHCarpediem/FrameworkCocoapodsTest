//
//  TDLogDebugView.swift
//  TDBasis
//
//  Created by Fench on 2024/5/31.
//

import Foundation

extension LogDebugView {
    
    
    @objc
    public static let shared: LogDebugView = LogDebugView()
    
    /// 设置自定义过滤 item
    /// 诊断项目 默认添加了 AD200蓝牙和 AD200诊断 配合项目打印
    /// eg: `LogDebugView.extraCustomLogLevels.append(.custom(key: "埋点"))`
    public static var extraCustomLogLevels: [ItemsDataSource.FilterSink] = [.custom(key: "【AD200蓝牙】"),
                                                                            .custom(key: "【AD200诊断】")]
    /// 设置忽略的日志等级
    /// 配合 TDLog 日志打印等级
    /// eg: `LogDebugView.ignoreLogLevels = [.debug, .error]`
    public static var ignoreLogLevels: [ItemsDataSource.FilterSink] = [.warnning]
    
    @objc(showLogViewWithExpand:)
    /// 显示日志视图
    /// - Parameter isExpand: 是否直接展开 默认显示小图标 点击小图标展开
    public func showLogView(isExpand: Bool = false){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            defer {
                self.backView.isHidden = false
                if isExpand {
                    self.hud.isHidden = false 
                    self.expandLogView(animation: false)
                } else {
                    self.collapseLogView(animation: false)
                }
                
                self.updateLogs()
            }
            if self.hud.superview == nil, let window = UI.keyWindow  {
                window.addSubview(self.hud)
                window.addSubview(self.backView)
            }
        }
    }
    
    @objc
    /// 隐藏日志视图，小图标也一起隐藏 
    ///（设置`TDLogger.isLogDebugViewEnabled` 为 `false` 时会调用此方法）
    public func hideLogView(){
        DispatchQueue.main.async {
            self.hud.isHidden = true
            self.backView.isHidden = true
        }
    }
}

@objc
@objcMembers
open class LogDebugView: NSObject {
    
    public struct Const {
        static var contentHorizInset: CGFloat = 20
        static var contentVertiInset: CGFloat = UI.STATUS_NAV_BAR_HEIGHT
        static var contentBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.9)
        static var defaultSpec: String = """
                                            蓝牙日志查看工具
                                            =============================
                                            使用说明>>>>>>>>>>>>>>>>>>>>>>>
                                            只有 DEBUG 包才能开启蓝牙日志查看工具
                                            ------------------------------
                                            开启步骤：后门（关于我们 app 图标连续点击开启后门）-> 打开蓝牙日志连接显示开关
                                            ------------------------------
                                            右上角关闭图标：缩小日志页面到屏幕边缘
                                            缩小后点击图标可以重新打开日志页面
                                            长按所缩小后的图标 5 秒：关闭蓝牙日志查看工具
                                            关闭后再次开启需要去后门开启
                                            注意⚠️：关闭后不会收集蓝牙日志，如果需要收集日志 需要先开启开关。
                                            ------------------------------
                                          """
        static var logTextColor: UIColor = .white
        static var toolbarColor: UIColor = UIColor.td.color(hex6: 0x202124)
    }
    
    var log: String = "蓝牙日志"
    typealias LogInfo = (level: TDLogger.TDLogLevel, log: String)
    
    var logs: [LogInfo] = [] {
        didSet {
            LogDebugView.shared.updateLogs()
        }
    }
    var isExpand: Bool = false
    
    var expandFrame: CGRect?
    var isScrolled: Bool = false
    
    var logItems: [LogInfo] = []
    
    let logQueue = DispatchQueue(label: "com.TDBasis.logQueue")
    
    lazy var expandImageView: UIButton = {
        let imageView = UIButton(type: .custom)
        imageView.setTitle("📖", for: .normal)
        imageView.setTitleColor(.white, for: .normal)
        imageView.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.td.register(cellWithClass: LogCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        return tableView
    }()
    
    lazy var hud: UIView = {
        let hud = UIView()
        hud.isUserInteractionEnabled = true
        hud.backgroundColor = .clear
        hud.frame = UI.SCREEN_BOUNDS
        hud.isHidden = true
        hud.td.addTap { [weak self] tap in
            guard let self = self else { return }
            if self.toolBar.isEdtingCustom {
                self.toolBar.tableView.endEditing(true)
            } else {
                self.toolBar.hideTableView()
            }
        }
        return hud
    }()
    
    lazy var toolBar: ToolBar = ToolBar()
    
    var selectFilter: ItemsDataSource.FilterSink = .all
    
    lazy var panGes: UIPanGestureRecognizer = {
        let panGes = UIPanGestureRecognizer(actionBlock: { [weak self] ges in
            guard let self = self else { return }
            guard let ges = ges as? UIPanGestureRecognizer, let view = ges.view else { return }

            if self.isExpand { return }
            
            let translation = ges.translation(in: UI.keyWindow)
            
            let maxTop: CGFloat = UI.STATUSBAR_HEIGHT
            let maxBottom: CGFloat = (UI.SCREEN_HEIGHT - UI.BOTTOM_HEIGHT - 50 - 10)
            let maxLeft: CGFloat = 10
            let maxRight: CGFloat = (UI.SCREEN_WIDTH - 50)
            switch ges.state {
            case .began, .changed:
                var x = (view.td.left + translation.x).td.clamped(to: maxLeft...maxRight)
                var y = (view.td.top + translation.y).td.clamped(to: maxTop...maxBottom)
                view.td.origin = CGPoint(x: x, y: y)
                ges.setTranslation(.zero, in: UI.keyWindow)
            case .ended, .cancelled, .failed:
                let parentView = view.superview!
                let viewCenterX = view.td.centerX
                let viewCenterY = view.td.centerY
                let lastX = viewCenterX > UI.SCREEN_WIDTH / 2 ? maxRight : maxLeft
                
                UIView.animate(withDuration: 0.25) {
                    view.frame = CGRect(x: lastX, y: view.td.top, width: view.td.width, height: view.td.height)
                }
                
            default:
                return
            }
        })
        return panGes
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.td.cornerRadius = 3
        view.td.addTap { [weak self] tap in
            guard let self = self else { return }
            if !self.isExpand {
                self.expandLogView()
            }
        }
        view.addGestureRecognizer(panGes)
        
        view.addSubview(expandImageView)
        
        view.addSubview(tableView)
        
        view.addSubview(closeBtn)
        
        view.addSubview(toolBar)
        
        return view
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("❎", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.td.addblock(for: .touchUpInside) { [weak self] sender in
            guard let self = self else { return }
            self.collapseLogView()
        }
        return btn
    }()
    
    func clearLog(with type: ItemsDataSource.ClearSink) {
        if case type = ItemsDataSource.ClearSink.all {
            logs = []
        } else {
            logs = logs.filter { !($0.level.filterType ~== self.selectFilter) }
        }
        isScrolled = false
        updateLogs()
    }
    
    // 收起
    private func collapseLogView(animation: Bool = true){
        DispatchQueue.main.async {
            self.isExpand = false
            self.closeBtn.isHidden = true
            self.tableView.isHidden = true
            self.toolBar.isHidden = true
            self.hud.isHidden = true
            let exFrame = self.expandFrame ?? CGRect(x: UI.SCREEN_WIDTH - 60, y: UI.SCREEN_HEIGHT - 120, width: 40, height: 40)
            if animation {
                UIView.animate(withDuration: 0.25) {
                    self.backView.frame = exFrame
                    self.tableView.frame = exFrame
                    self.backView.td.cornerRadius = 20
                } completion: { _ in
                    self.expandImageView.isHidden = false
                    self.updateSubviewsFrame()
                }
            } else {
                self.backView.frame = exFrame
                self.tableView.frame = exFrame
                self.backView.td.cornerRadius = 20
                self.expandImageView.isHidden = false
                self.updateSubviewsFrame()
            }
        }
        
    }
    
    // 展开
    private func expandLogView(animation: Bool = true) {
        DispatchQueue.main.async {
            self.isExpand = true
            
            self.expandFrame = self.backView.frame
            self.expandImageView.isHidden = true
            self.hud.isHidden = false
            let tbFrame = CGRect(x: Const.contentHorizInset,
                                 y: Const.contentVertiInset,
                                 width: UI.SCREEN_WIDTH - Const.contentHorizInset * 2,
                                 height: UI.SCREEN_HEIGHT - Const.contentVertiInset * 2)
            if animation {
                UIView.animate(withDuration: 0.25) {
                    self.backView.frame = tbFrame
                    self.backView.td.cornerRadius = 5
                    self.tableView.frame = tbFrame
                } completion: { _ in
                    self.closeBtn.isHidden = false
                    self.tableView.isHidden = false
                    self.toolBar.isHidden = false
                    self.updateSubviewsFrame()
                }
            } else {
                self.backView.frame = tbFrame
                self.backView.td.cornerRadius = 5
                self.tableView.frame = tbFrame
                self.closeBtn.isHidden = false
                self.toolBar.isHidden = false
                self.tableView.isHidden = false
                self.updateSubviewsFrame()
            }
        }
    }
    
    func updateSubviewsFrame(){
        DispatchQueue.main.async {
            if self.isExpand {
                let tbFrame = self.backView.bounds.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 35, right: 8))
                self.closeBtn.frame = CGRect(x: self.backView.td.width - 40, y: 0, width: 40, height: 40)
                self.toolBar.frame = CGRect(x: 0, y: self.backView.td.height - 30, width: self.backView.td.width, height: 30)
                self.tableView.frame = tbFrame
            } else {
                self.expandImageView.frame = self.backView.bounds
            }
        }
    }
    
    func updateLogs() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.tableView.isHidden || self.isScrolled { return }
            self.logQueue.async {
                let logs = self.logs.filter {
                    if self.selectFilter == .all {
                        return true
                    }
                    return $0.level.filterType ~== self.selectFilter
                }
                let usageInfo: LogInfo = (.debug, Const.defaultSpec)
                self.logItems = logs
                self.logItems.insert(usageInfo, at: 0)
                
                DispatchQueue.main.async {
                    self.reloadTableView()
                }
            }
        }
        
    }
    
    @objc func reloadTableView(){
        
        if tableView.isHidden || self.isScrolled { return }
        self.tableView.reloadData()
        self.tableView.reloadData()
        self.tableView.td.scrollToRow(at: IndexPath(row: self.logItems.count - 1, section: 0), at: .bottom, animated: false)
    }
}

extension LogDebugView: UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetDelta = (scrollView.contentOffset.y + scrollView.td.height - scrollView.contentSize.height)
        let isScrollToBottom = abs(offsetDelta) < 10
        print("contentOffset:", scrollView.contentOffset.y + scrollView.td.height, scrollView.contentSize.height, isScrollToBottom)
        
        isScrolled = !isScrollToBottom
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolled = true
        if toolBar.isEdtingCustom {
            toolBar.tableView.endEditing(true)
        } else {        
            toolBar.hideTableView()
        }
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.td.dequeueReusableCell(withClass: LogCell.self, for: indexPath)
        if let logInfo = logItems[indexPath.row~] {
            cell.logLabel.text = logInfo.log
        }
        return cell
    }
}

extension TDLogger.TDLogLevel {
    var filterType: LogDebugView.ItemsDataSource.FilterSink {
        switch self {
        case .default:
            return .all
        case .debug:
            return .debug
        case .warning:
            return .warnning
        case .error:
            return .error
        case .custom(let value):
            return .custom(key: value)
        }
    }
}

infix operator ~== : AssignmentPrecedence

extension LogDebugView {
    public enum ItemsDataSource {
        public enum FilterSink: Equatable {
            case all
            case debug
            case error
            case warnning
            case input(key: String)
            case custom(key: String)
            
            var title: String {
                switch self {
                case .all:
                    return "全部"
                case .debug:
                    return "Debug"
                case .error:
                    return "error"
                case .warnning:
                    return "warnning"
                case .input(let key):
                    return key
                case .custom(let key):
                    return key
                }
            }
            
            var logLevel: TDLogger.TDLogLevel {
                switch self {
                case .all:
                    return .default
                case .debug:
                    return .debug
                case .error:
                    return .error
                case .warnning:
                    return .warning
                case .input(let key):
                    return .custom(value: key)
                case .custom(let key):
                    return .custom(value: key)
                }
            }
            
            public static func == (lhs: Self, rhs: Self) -> Bool {
                if case .all = lhs, case .all = rhs {
                    return true
                }
                if case .debug = lhs, case .debug = rhs {
                    return true
                }
                if case .error = lhs, case .error = rhs {
                    return true
                }
                if case .warnning = lhs, case .warnning = rhs {
                    return true
                }
                if case .custom(let key1) = lhs, case .custom(let key2) = rhs {
                    return key1 == key2
                }
                if case .input(let key1) = lhs, case .input(let key2) = rhs {
                    return key1 == key2
                }
                return false
            }
            
            static func ~== (lhs: Self, rhs: Self) -> Bool {
                if case .all = lhs, case .all = rhs {
                    return true
                }
                if case .debug = lhs, case .debug = rhs {
                    return true
                }
                if case .error = lhs, case .error = rhs {
                    return true
                }
                if case .warnning = lhs, case .warnning = rhs {
                    return true
                }
                if case .custom(let key1) = lhs, case .custom(let key2) = rhs {
                    return key1.lowercased().contains(key2.lowercased()) || key2.lowercased().contains(key1.lowercased())
                }
                if case .input(let key1) = lhs, case .input(let key2) = rhs {
                    return key1.lowercased().contains(key2.lowercased()) || key2.lowercased().contains(key1.lowercased())
                }
                return false
            }
        }
        
        public enum ClearSink {
            case current
            case all
            
            var title: String {
                switch self {
                case .current:
                    return "当前"
                case .all:
                    return "所有"
                }
            }
        }
        
        case filter(type: FilterSink)
        case clear(type: ClearSink)
        
        var title: String {
            switch self {
            case .filter(let type):
                return type.title
            case .clear(let type):
                return type.title
            }
        }
        
        var isInput: Bool {
            if case .filter(let type) = self {
                if case .input(let key) = type {
                    return true
                }
            }
            return false
        }
    }
}

extension LogDebugView {
    class ToolBar: UIView, UITableViewDataSource, UITableViewDelegate {
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }
        
        var items: [ItemsDataSource] = []
        
        lazy var filterBtn: UIButton = creatBtn(title: "筛选")
        
        lazy var copyAllBtn: UIButton = creatBtn(title: "复制")
        
        lazy var clearBtn: UIButton = creatBtn(title: "清空")
        
        lazy var openBtn: UIButton = creatBtn(title: "▶︎")
        
        var currentFilters: [ItemsDataSource.FilterSink] = []
        
        var isEdtingCustom: Bool = false
        
        var selectFilter: ItemsDataSource.FilterSink = .all {
            didSet {
                self.filterBtn.setTitle(selectFilter.title, for: .normal)
                LogDebugView.shared.selectFilter = selectFilter
                LogDebugView.shared.isScrolled = false
                LogDebugView.shared.updateLogs()
            }
        }
        
        lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.showsVerticalScrollIndicator = false
            tableView.td.register(cellWithClass: ItemCell.self)
            tableView.separatorStyle = .singleLine
            tableView.backgroundColor = .clear
            tableView.rowHeight = 30
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
        }()
        
        func creatBtn(title: String) -> UIButton {
            let btn = UIButton(type: .custom)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            return btn
        }
        
        func setupUI(){
            backgroundColor = Const.toolbarColor
            
            td.addSubviews(filterBtn, copyAllBtn, clearBtn, openBtn)
            openBtn.setTitle("◀︎", for: .selected)
            let toolBarWidth = UI.SCREEN_WIDTH - LogDebugView.Const.contentHorizInset * 2
            
            let width: CGFloat = (toolBarWidth - 30) / 3
            
            self.frame = CGRect(x: 0, y: 0, width: toolBarWidth, height: 30)
            openBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            filterBtn.frame = CGRect(x: openBtn.td.right, y: 0, width: width, height: 30)
            
            filterBtn.td.addDashLine(in: CGRect(x: 0, y: 5, width: 0.5, height: 20), lineColor: UIColor.white.withAlphaComponent(0.6))
            clearBtn.frame = CGRect(x: filterBtn.td.right, y: 0, width: width, height: 30)
            clearBtn.td.addDashLine(in: CGRect(x: 0, y: 5, width: 0.5, height: 20), lineColor: UIColor.white.withAlphaComponent(0.6))
            copyAllBtn.frame = CGRect(x: clearBtn.td.right, y: 0, width: width, height: 30)
            copyAllBtn.td.addDashLine(in: CGRect(x: 0, y: 5, width: 0.5, height: 20), lineColor: UIColor.white.withAlphaComponent(0.6))
            
            openBtn.addTarget(self, action: #selector(openClick(_:)), for: .touchUpInside)
            filterBtn.addTarget(self, action: #selector(filterClick), for: .touchUpInside)
            clearBtn.addTarget(self, action: #selector(clearClick), for: .touchUpInside)
            copyAllBtn.addTarget(self, action: #selector(copyLog), for: .touchUpInside)
            
            currentFilters = [.all, .debug, .warnning, .error]
            currentFilters = currentFilters.filter { f in !LogDebugView.ignoreLogLevels.contains { i in f == i } }
            currentFilters += LogDebugView.extraCustomLogLevels
            currentFilters.append(.input(key: ""))
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.td.dequeueReusableCell(withClass: ItemCell.self, for: indexPath)
            let item = items[indexPath.row]
            cell.titleLabel.text = item.title
            cell.titleLabel.isHidden = item.isInput
            cell.textField.isHidden = !item.isInput
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let item = items[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! ItemCell
            
            switch item {
            case .filter(let type):
                selectFilter = type
                if item.isInput {
                    let custom = cell.textField.text ?? ""
                    updateFilter(custom: custom)
                    selectFilter = .custom(key: custom)
                }
            case .clear(let type):
                LogDebugView.shared.clearLog(with: type)
            }
            
            hideTableView()
        }
        
        func updateFilter(custom: String) {
            currentFilters = [.all, .debug, .warnning, .error]
            currentFilters = currentFilters.filter { f in !LogDebugView.ignoreLogLevels.contains { i in f == i } }
            currentFilters += LogDebugView.extraCustomLogLevels
            currentFilters.append(.input(key: custom))
            
            items = currentFilters.map { ItemsDataSource.filter(type: $0) }
            tableView.reloadData()
        }
        
        @objc func clearClick(){
            items = [.clear(type: .all), .clear(type: .current)]
            
            let clearFrame = clearBtn.convert(clearBtn.bounds, to: UI.keyWindow)
            let tableHeight: CGFloat = 30 * 2
            
            let tableFrame = CGRect(center: CGPoint(x: clearFrame.center.x, y: clearFrame.minY - 35), size: CGSize(width: 130, height: tableHeight))
            
            showTableView(to: tableFrame)
            
        }
        
        @objc func filterClick(){
            items = currentFilters.map { ItemsDataSource.filter(type: $0) }
            
            let filterFrame = filterBtn.convert(filterBtn.bounds, to: UI.keyWindow)
            let tableHeight: CGFloat = CGFloat(items.count * 30)
            
            let tableFrame = CGRect(center: CGPoint(x: filterFrame.center.x, y: filterFrame.minY - tableHeight / 2 - 5), size: CGSize(width: 130, height: tableHeight))
            showTableView(to: tableFrame)
        }
        
        @objc func openClick(_ sender: UIButton) {
            sender.isSelected = !sender.isSelected
            
            let toolBarWidth = UI.SCREEN_WIDTH - LogDebugView.Const.contentHorizInset * 2
            if sender.isSelected {
                UIView.animate(withDuration: 0.25) {
                    self.filterBtn.isHidden = true
                    self.copyAllBtn.isHidden = true
                    self.clearBtn.isHidden = true
                    self.frame = CGRect(x: toolBarWidth - 30, y: self.td.top, width: 30, height: 30)
                }
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.filterBtn.isHidden = false
                    self.copyAllBtn.isHidden = false
                    self.clearBtn.isHidden = false
                    self.frame = CGRect(x: 0, y: self.td.top, width: toolBarWidth, height: 30)
                }
            }
        }
        
        @objc func copyLog(){
            UIPasteboard.general.string = LogDebugView.shared.logItems.map { $0.log }.reduce("\n") { $0 + $1 }
        }
        
        func showTableView(to frame: CGRect) {
            if tableView.superview == nil {
                UI.keyWindow?.addSubview(tableView)
            }
            
            tableView.isHidden = false
            tableView.alpha = 1
            tableView.frame = CGRect(center: frame.center, size: CGSize(width: frame.width, height: 0))
            UIView.animate(withDuration: 0.25) {
                self.tableView.frame = CGRect(center: frame.center, size: CGSize(width: frame.width, height: frame.height))
            }
            tableView.reloadData()
        }
        
        func hideTableView() {
            UIView.animate(withDuration: 0.25) {
                self.tableView.alpha = 0
                self.tableView.frame = CGRect(center: self.tableView.center, size: CGSize(width: self.tableView.td.width, height: 0))
            } completion: { _ in
                self.tableView.isHidden = true
            }
        }
        
        @objc func keyboardWillShow(_ note: Notification) {
            guard let info = note.userInfo else {
                return
            }
            isEdtingCustom = true
            var animationCurve: UIView.AnimationOptions =  UIView.AnimationOptions.curveEaseOut.union(.beginFromCurrentState)
            if let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
                animationCurve = UIView.AnimationOptions(rawValue: curve).union(.beginFromCurrentState)
            }
            let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
            if let kbFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve) {
                    let tbFrame = self.tableView.frame
                    self.tableView.frame = CGRect(x: tbFrame.minX, y: tbFrame.minY - kbFrame.height, width: tbFrame.width, height: tbFrame.height)
                }
            }
            
        }
        
        @objc func keyboardWillHide(_ note: Notification) {
            guard let info = note.userInfo else {
                return
            }
            isEdtingCustom = false
            let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
            if let kbFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                UIView.animate(withDuration: animationDuration) {
                    let tbFrame = self.tableView.frame
                    self.tableView.frame = CGRect(x: tbFrame.minX, y: tbFrame.minY + kbFrame.height, width: tbFrame.width, height: tbFrame.height)
                }
            }
            
        }
    }
    
    class ItemCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        let titleLabel = UILabel(text: nil, textColor: .white, font: .systemFont(ofSize: 12))
        
        lazy var textField: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            textField.layer.borderWidth = 0.5
            textField.textColor = .white
            textField.font = .systemFont(ofSize: 12)
            textField.textAlignment = .center
            textField.placeholder = "过滤字段"
            textField.backgroundColor = .clear
            return textField
        }()
        
        func setupUI() {
            contentView.backgroundColor = Const.toolbarColor
            backgroundColor = .clear
            contentView.td.addSubviews(titleLabel, textField)
            titleLabel.textAlignment = .center
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            titleLabel.frame = contentView.bounds
            textField.frame = contentView.bounds.inset(by: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 40))
        }
    }
}

extension LogDebugView {
    class LogCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        func setupUI(){
            backgroundColor = .clear
            contentView.backgroundColor = .clear
            contentView.addSubview(logLabel)
            selectionStyle = .none
            
            logLabel.numberOfLines = 0
            logLabel.textAlignment = .left
            logLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
               logLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               logLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
               logLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
               logLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
           ])
        }
        
        let logLabel = UILabel(text: "", textColor: .white, font: .systemFont(ofSize: 12))
        
        
    }
}
