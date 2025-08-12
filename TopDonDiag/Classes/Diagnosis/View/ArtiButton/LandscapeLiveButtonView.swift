//
//  LandscapeLiveButtonView.swift
//  TopDonDiag
//
//  Created by AI Assistant on 2024/12/19.
//

import UIKit
import SnapKit

@objc(TDD_LandscapeLiveButtonViewDelegate)
public protocol LandscapeLiveButtonViewDelegate: AnyObject {
    func landscapeLiveButtonClick(_ model: TDD_ArtiButtonModel)
}

@objc(TDD_LandscapeLiveButtonView)
public class LandscapeLiveButtonView: UIView {
    
    // MARK: - Properties
    
    @objc public weak var delegate: LandscapeLiveButtonViewDelegate?
    
    private var collectionView: UICollectionView!
    private var buttonArr: [TDD_ArtiButtonModel] = []
    private var cellArr: [LandscapeLiveButtonCellView] = []
    
    private let btnWidth: CGFloat
    private let btnHeight: CGFloat
    private let spaceWidth: CGFloat
    private let noReuseCount: Int = 10
    
    private var model: TDD_ArtiModelBase?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        self.btnHeight = TDD_DiagBridge.isPad() ? 50 : 35
        self.spaceWidth = TDD_DiagBridge.isPad() ? 20 : 10
        
        let width = 244.0 // ArtiLiveDataLandscapeMoreChartView --> tableViewWidth
        let leftMargin: CGFloat = TDD_DiagBridge.isIPhoneX() ? 3.0 + 44.0 : 10.0
        let btnWidth = width - leftMargin - spaceWidth
        self.btnWidth = btnWidth
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    @objc public func setModel(_ model: TDD_ArtiModelBase) {
        self.model = model
        
        /*
         if !model.isReloadButton {
         return
         } else {
         // 刷新一次即可
         model.isReloadButton = false
         } */
        
        var allButtonArr: [TDD_ArtiButtonModel] = []
        if let customButtonArr = model.customButtonArr as? [TDD_ArtiButtonModel] {
            allButtonArr.append(contentsOf: customButtonArr)
        }
        
        if let buttonArr = model.buttonArr as? [TDD_ArtiButtonModel] {
            allButtonArr.append(contentsOf: buttonArr)
        }
        
        setButtonArr(allButtonArr)
    }
    
    private func setButtonArr(_ buttonArr: [TDD_ArtiButtonModel]) {
        // Carpal 进车中退到后台，在后台完成进车。再打开前台。tableView 的 frame 可能为 0
        if collectionView == nil || collectionView.frame.size.width == 0 || collectionView.frame.size.height == 0 {
            createCollectionView()
        }
        
        // 过滤状态 <= 1 的按钮
        let filterArray = buttonArr.filter { $0.uStatus.rawValue <= 1 }
        self.buttonArr = filterArray
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = UIColor.tdd_viewControllerBackground()
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spaceWidth
        layout.minimumLineSpacing = spaceWidth
        // 不设置固定的 sectionInset，让 delegate 方法动态控制
        layout.sectionInset = .zero
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delaysContentTouches = false
        
        // 注册 cell
        for row in 0..<noReuseCount {
            let identify = "Cell0\(row)" // 以indexPath来唯一确定
            collectionView.register(LandscapeLiveButtonCellView.self, forCellWithReuseIdentifier: identify)
        }
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // 更新 collectionView 的 frame
        if let collectionView {
            collectionView.frame = bounds
            
            // 强制刷新布局，确保 inset 在屏幕旋转时能正确更新
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension LandscapeLiveButtonView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonArr.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identify = "Cell0\(indexPath.row)" // 以indexPath来唯一确定
        var cell: LandscapeLiveButtonCellView
        
        if indexPath.row < noReuseCount {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath) as! LandscapeLiveButtonCellView
        } else {
            cell = cellArr[indexPath.row % noReuseCount]
        }
        
        if cell == nil {
            cell = LandscapeLiveButtonCellView(frame: .zero)
            print("不应该来到这里 LandscapeLiveButtonCellView alloc")
        }
        
        if indexPath.item >= buttonArr.count {
            return cell
        }
        
        let model = buttonArr[indexPath.item]
        
        cell.delegate = self
        cell.isShowTranslated = self.model?.isShowTranslated ?? false
        cell.updateWithModel(model)
        
        if TDD_DiagnosisTools.isDebug() {
            if !model.uiTextIdentify.isEmpty {
                cell.btn.accessibilityIdentifier = model.uiTextIdentify
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LandscapeLiveButtonView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item >= buttonArr.count {
            return .zero
        }
        
        let model = buttonArr[indexPath.item]
        
        if model.uStatus == ArtiButtonStatus_UNVISIBLE {
            return .zero
        }
        
        return CGSize(width: btnWidth, height: btnHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 计算所有按钮的总宽度
        let totalButtonWidth = CGFloat(buttonArr.count) * btnWidth + CGFloat(buttonArr.count - 1) * spaceWidth
        
        // 如果按钮总宽度小于容器宽度，则从右边开始布局
        if totalButtonWidth < collectionView.bounds.size.width {
            let leftInset = collectionView.bounds.size.width - totalButtonWidth - spaceWidth
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: spaceWidth)
        } else {
            return UIEdgeInsets(top: 0, left: spaceWidth, bottom: 0, right: spaceWidth)
        }
    }
}

// MARK: - LandscapeLiveButtonCellViewDelegate

extension LandscapeLiveButtonView: LandscapeLiveButtonCellViewDelegate {
    
    func landscapeLiveButtonCellButtonClick(_ button: UIButton, cell: LandscapeLiveButtonCellView) {
        guard let model = cell.model else { return }
        
        let cellCenter = cell.center
        // 将 cell 的中心点转换到 window 坐标系
        let cellCenterInWindow = cell.convert(cellCenter, to: TDD_DiagBridge.flt_APP_WINDOWValue())
        model.clickPoint = cellCenterInWindow
        
        // 过期加锁软件不适用报告置灰逻辑
        if model.uButtonId == TDD_DiagBridge.df_ID_REPORTValue() && !TDD_DiagnosisTools.isLimitedTrialFuction() {
            // 报告按钮
            model.uStatus = ArtiButtonStatus.init(1) // ArtiButtonStatus_DISABLE
            model.bIsTemporaryNoEnable = true
            collectionView.reloadData()
        }
        
        delegate?.landscapeLiveButtonClick(model)
    }
}

// MARK: - LandscapeLiveButtonCellView

class LandscapeLiveButtonCellView: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: LandscapeLiveButtonCellViewDelegate?
    var model: TDD_ArtiButtonModel?
    var isShowTranslated: Bool = false
    
    lazy var btn: TDD_VXXScrollButton = {
        let button = TDD_VXXScrollButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("", for: .normal)
        let normalBgColor = UIColor.tdd_btnNormalBackground()
        let disableBGColor = UIColor.tdd_btnDisableBackground()
        let titleColor = UIColor.tdd_btnNormalTitle()
        let titleDisableColor = UIColor.tdd_btnDisableTitle()
        
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleDisableColor, for: .disabled)
        
        button.setBackgroundImage(TDD_DiagBridge.tdd_image(with: normalBgColor, rect: CGRect(x: 0, y: 0, width: 1, height: 1)), for: .normal)
        button.setBackgroundImage(TDD_DiagBridge.tdd_image(with: disableBGColor, rect: CGRect(x: 0, y: 0, width: 1, height: 1)), for: .disabled)
        button.setBackgroundImage(TDD_DiagBridge.tdd_image(with: UIColor.tdd_btnHightlightBackground(), rect: CGRect(x: 0, y: 0, width: 1, height: 1)), for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.tdd_colorDiagTheme()
        button.layer.cornerRadius = TDD_DiagBridge.isKindOfTopVCIValue() ? 5 : 1.5
        button.layer.masksToBounds = true
        if !TDD_DiagBridge.isKindOfTopVCIValue() {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.tdd_colorDiagTheme().cgColor
        }
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var lockIcon: UIImageView = UIImageView(image: UIImage.tdd_imageDiagBtnLockIcon())
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.addSubview(btn)
        
        contentView.addSubview(lockIcon)
        
        let width = 244.0 // ArtiLiveDataLandscapeMoreChartView --> tableViewWidth
        let leftMargin: CGFloat = TDD_DiagBridge.isIPhoneX() ? 3.0 + 44.0 : 10.0
        let spaceWidth = TDD_DiagBridge.isPad() ? 20 : 10.0
        let btnWidth = width - leftMargin - spaceWidth
        
        btn.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            if TDD_DiagBridge.isPad() {
                make.width.equalTo(btnWidth)
                make.height.equalTo(50)
            } else {
                make.width.equalTo(btnWidth)
                make.height.equalTo(35)
            }
        }
        
        lockIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(btn).offset(-10)
            make.right.equalTo(btn).offset(10)
        }
        
    }
    
    @objc private func buttonClicked() {
        delegate?.landscapeLiveButtonCellButtonClick(btn, cell: self)
    }
    
    // MARK: - Public Methods
    
    func updateWithModel(_ model: TDD_ArtiButtonModel) {
        self.model = model
        
        var title = isShowTranslated ? TDD_DiagBridge.getLanguage(model.strTranslatedButtonText) : TDD_DiagBridge.getLanguage(model.strButtonText)
        title = title.replacingOccurrences(of: "\n", with: " ")
        title = title.replacingOccurrences(of: "\r", with: "")
        btn.titleLabel?.text = title
        btn.setTitle(title, for: .normal)
        
        if model.uStatus.rawValue == 1 || (!model.bIsEnable) { // ArtiButtonStatus_DISABLE
            btn.isEnabled = false
            btn.layer.borderColor = UIColor.tdd_color(withHex: 0xE9E9E9).cgColor
        } else {
            btn.isEnabled = true
            btn.layer.borderColor = UIColor.tdd_colorDiagTheme().cgColor
        }
        
        if model.uStatus.rawValue == 0 && model.bIsEnable && model.isLock { // ArtiButtonStatus_ENABLE
            self.lockIcon.isHidden = false
        } else {
            self.lockIcon.isHidden = true
        }
        
        if model.uStatus.rawValue == 2 {
            btn.isHidden = true
        } else {
            btn.isHidden = false
        }
    }
}

// MARK: - LandscapeLiveButtonCellViewDelegate

protocol LandscapeLiveButtonCellViewDelegate: AnyObject {
    
    func landscapeLiveButtonCellButtonClick(_ button: UIButton, cell: LandscapeLiveButtonCellView)
}
