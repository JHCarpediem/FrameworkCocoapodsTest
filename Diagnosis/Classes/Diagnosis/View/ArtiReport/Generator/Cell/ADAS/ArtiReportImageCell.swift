//
//  ArtiReportImageCell.swift
//  Diagnosis
//
//  Created by xinwenliu on 2024/5/11.
//

import UIKit
//import AVFoundation
import CoreServices
import Photos
import SnapKit
import TZImagePickerController
import TDBasis

@objc(TDD_ArtiReportImageCell)
@objcMembers
open class ArtiReportImageCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
        setupUI()
    }
    
    @objc public var maxPhotoCount = 12
    
    @objc public var images: [UIImage] = []
    
    @objc var addAssetsArray: [Any] = []
    
    @objc public var onImagesChanged: (([UIImage], [Any]) -> Void)?
    
    @objc public func update(_ images: [UIImage], assets: [Any], isNeedAdd: Bool = true) {
        self.images = images
        self.addAssetsArray = assets
        collectionView.reloadData()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(TDD_DiagnosisTools.isIpad() ? 40 :  7.5)
            make.right.equalTo(TDD_DiagnosisTools.isIpad() ? -40 : -7.5)
            make.bottom.equalTo(-10.0)
        }
        
        contentView.addSubview(gapView)
        gapView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(10.0)
            make.bottom.equalTo(0)
        }
        
    }
    
    private func removeItemAndReloadData(at index: Int) {
        self.images.remove(at: index)
        self.addAssetsArray.remove(at: index)
        collectionView.reloadData()
        self.onImagesChanged?(self.images, self.addAssetsArray)
        
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        uiCollectionView.backgroundColor = UIColor.clear
        uiCollectionView.dataSource = self
        uiCollectionView.delegate = self
        // uiCollectionView.contentInset = UIEdgeInsets(top: 0, left: 7.5, bottom: 0, right: 7.5)
        uiCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        uiCollectionView.register(AddImageCollectionViewCell.self, forCellWithReuseIdentifier: AddImageCollectionViewCell.reuseIdentifier)
        uiCollectionView.clipsToBounds = false
        return uiCollectionView
    }()
    
    private lazy var gapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tdd_collectionViewBG()
        return view
    }()
}

// MARK: - 事件
private extension ArtiReportImageCell {
    
    @objc
    func removeButtonAction(_ sender: UIButton) {
        self.removeItemAndReloadData(at: sender.tag)
    }
    
    @objc
    func addButtonAction(_ sender: UIButton) {
        
        if let imagePickerVc = TZImagePickerController(maxImagesCount: maxPhotoCount, delegate: nil) {
            imagePickerVc.maxImagesCount = maxPhotoCount
            imagePickerVc.selectedAssets = NSMutableArray(array: self.addAssetsArray)  // 目前已经选中的图片数组
            imagePickerVc.isSelectOriginalPhoto = true
            imagePickerVc.allowTakePicture = true  // 在内部显示拍照
            imagePickerVc.autoSelectCurrentWhenDone = false
            imagePickerVc.showPhotoCannotSelectLayer = true
            imagePickerVc.cannotSelectLayerColor = UIColor.white.withAlphaComponent(0.8)

            imagePickerVc.allowPickingVideo = false
            imagePickerVc.allowPreview = false
            imagePickerVc.allowPickingOriginalPhoto = true
            imagePickerVc.sortAscendingByModificationDate = false
            imagePickerVc.statusBarStyle = UIStatusBarStyle.lightContent

        //    imagePickerVc.naviTitleFont = [UIFont boldSystemFontOfSize:16]
        //    imagePickerVc.naviBgColor = [UIColor colorFFFFFF]
            
            imagePickerVc.didFinishPickingPhotosHandle = { [weak self] (photos: [UIImage]?, assets: [Any]?, isSelectOriginalPhoto: Bool) in
                guard let self = self else { return }
                self.addAssetsArray = assets ?? []
                self.images = photos ?? []
    //            self.imageArray = [NSMutableArray arrayWithArray:self.localImageArray];
    //            [self.imageArray addObjectsFromArray:self.addArray];
                self.collectionView.reloadData()
                self.onImagesChanged?(self.images, self.addAssetsArray)
            }

            imagePickerVc.showSelectedIndex = true
            imagePickerVc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            imagePickerVc.preferredLanguage = "en"
            UIViewController.tdd_top().present(imagePickerVc, animated: true, completion: nil)
        }
    }
}

extension ArtiReportImageCell: UINavigationControllerDelegate { }

extension ArtiReportImageCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(12, images.count + 1)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < images.count {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell {
                cell.closeButton.tag = indexPath.row
                cell.closeButton.addTarget(self, action: #selector(removeButtonAction(_:)), for: .touchUpInside)
                cell.mediaImageView.image = images[indexPath.row]
                return cell
            }
        } else if indexPath.row == images.count {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.reuseIdentifier, for: indexPath) as? AddImageCollectionViewCell {
                cell.addButton.tag = indexPath.row
                cell.addButton.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension ArtiReportImageCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension ArtiReportImageCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let boxGap: CGFloat = 15
//        let numbersOfBoxPerRow: CGFloat = CGFloat(maxPhotoCount)
        //let boxWidth: CGFloat = (UIScreen.main.bounds.width - 30 - ((numbersOfBoxPerRow - 1) * boxGap)) / numbersOfBoxPerRow
        let boxWidth: CGFloat = TDD_DiagnosisTools.isIpad() ? (20 + 120) : (7.5 + 75 + 7.5) * UI.widthScale
        return CGSize(width: boxWidth, height: boxWidth)
    }
}

// MARK: - AddImageCollectionViewCell

internal class AddImageCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable, message: "This method is no longer supported.")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.clear
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalTo(TDD_DiagnosisTools.isIpad() ? 20 : 15.0 * UI.widthScale)
            make.left.equalTo(TDD_DiagnosisTools.isIpad() ? 10 : 7.5 * UI.widthScale)
            make.right.equalTo(TDD_DiagnosisTools.isIpad() ? -10 : -7.5 * UI.widthScale)
            make.bottom.equalTo(0)
        }
        
        backView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()

        let imageName = (TDD_DiagnosisTools.softWareIsTopVCI() || TDD_DiagnosisTools.softWareIsCarDiagSeries()) ? "image_add_icon" : "report_add_pic"
        if TDD_DiagnosisTools.isIpad() {
            button.setImage(BridgeTool.tdd_imageNamed(imageName)?.td_image(byResize: CGSize(width: 120, height: 120)), for: .normal)
        } else {
            button.setImage(BridgeTool.tdd_imageNamed(imageName)?.td_image(byResize: CGSize(width: 75 * UI.widthScale, height: 75 * UI.widthScale)), for: .normal)
        }
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
}

// MARK: - ImageCollectionViewCell

internal class ImageCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable, message: "This method is no longer supported.")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.clear
        
        contentView.addSubview(mediaImageView)
        mediaImageView.snp.makeConstraints { make in
            make.top.equalTo(TDD_DiagnosisTools.isIpad() ? 20 : 15.0 * UI.widthScale)
            make.left.equalTo(TDD_DiagnosisTools.isIpad() ? 10 : 7.5 * UI.widthScale)
            make.right.equalTo(TDD_DiagnosisTools.isIpad() ? -10 : -7.5 * UI.widthScale)
            make.bottom.equalTo(0)
        }
        
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.centerX.equalTo(mediaImageView.snp.right)
            make.centerY.equalTo(mediaImageView.snp.top)
        }
    }
    
    lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 2.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(BridgeTool.tdd_imageNamed("pci_icon_del"), for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tdd_hitEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        return button
    }()
}

fileprivate extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
