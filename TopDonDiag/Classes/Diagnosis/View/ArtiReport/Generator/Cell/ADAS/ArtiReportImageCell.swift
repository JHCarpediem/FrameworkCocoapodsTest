//
//  ArtiReportImageCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/11.
//

import UIKit
//import AVFoundation
import CoreServices
import Photos
import SnapKit

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
    
    struct MediaResource {
        
        var image: UIImage
        
        var url: URL?
        
        var data: Data? {
            return image.jpegData(compressionQuality: 1.0)
        }
    }
    
    enum CellType {
        case add
        case media
    }
    
    class Model {
        var type: CellType = .add
        var resource: MediaResource?
        init(type: CellType = .add, resource: MediaResource? = nil) {
            self.type = type
            self.resource = resource
        }
    }
    
    @objc public var maxPhotoCount = 4
    
    var models: [Model] = [.init()]
    
    @objc public var images: [UIImage] {
        var imgs: [UIImage] = []
        for model in models where model.type == .media {
            if let resource = model.resource {
                imgs.append(resource.image)
            }
        }
        return imgs
    }
    
    @objc public weak var viewController: UIViewController?
    
    @objc public var onImagesChanged: (([UIImage]) -> Void)?
    
    @objc public var onNotAuthorized: ((String) -> Void)?
    
    @objc public func update(_ images: [UIImage]) {
        var mos: [Model] = images.map {
            .init(type: .media, resource: MediaResource.init(image: $0))
        }
        if mos.count < 4 {
            mos.append(.init(type: .add))
        }
        self.models = mos
        
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
    
    private func addItemAndReloadData(at index: Int, media: MediaResource) {
        let model = Model(type: .media, resource: media)
        if self.models.count == maxPhotoCount {
            self.models[self.models.count - 1] = model
        } else {
            self.models.insert(model, at: self.models.count - 1)
        }
        collectionView.reloadData()
        self.onImagesChanged?(self.images)
    }
    
    private func removeItemAndReloadData(at index: Int) {

        self.models.remove(at: index)
        if self.models.last?.type == .media {
            self.models.append(.init())
        }
        collectionView.reloadData()
        self.onImagesChanged?(self.images)
        
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
    
    private lazy var imagePickerView: UIImagePickerController = {
        let view = UIImagePickerController()
        if #available(iOS 14.0, *) {
            view.mediaTypes = [UTType.image.identifier]
        } else {
            // Fallback on earlier versions
            view.mediaTypes = [kUTTypeImage as String]
        }
        view.allowsEditing = false
        return view
    }()
}

// MARK: - 相机和相册权限
private extension ArtiReportImageCell {
    
    func checkCameraAuthorization(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func checkPhotoLibraryAuthorization(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if #available(iOS 14, *) {
                        completion(status == .authorized || status == .limited)
                    } else {
                        completion(status == .authorized)
                    }
                }
            }
        case .denied, .restricted:
            completion(false)
        case .limited: // iOS 14 及以后，用户授予有限访问权限
            completion(true)
        @unknown default:
            completion(false)
        }
    }
    
    func takePhoto() {
        let camera = UIImagePickerController.SourceType.camera
        showPicker(sourceType: camera)
    }
    
    func openPhotoLibrary() {
        let photoLibrary = UIImagePickerController.SourceType.photoLibrary
        showPicker(sourceType: photoLibrary)
    }
    
    func showPicker(sourceType: UIImagePickerController.SourceType ) {
        DispatchQueue.main.async {
            self.imagePickerView.modalPresentationStyle = .fullScreen
            self.imagePickerView.delegate = self
            self.imagePickerView.sourceType = sourceType
            self.imagePickerView.allowsEditing = false
            self.viewController?.present(self.imagePickerView, animated: true)
        }
    }
    
}

// MARK: - 事件
private extension ArtiReportImageCell {
    
    @objc
    func removeButtonAction(_ sender: UIButton) {
        self.removeItemAndReloadData(at: sender.tag)
    }
    
    @objc
    func addButtonAction(_ sender: UIButton) {
        imagePickerView.view.tag = sender.tag
        showActionSheet()
    }
    
    private func showActionSheet() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let library = UIAlertAction(title: TDDLocalized.report_image_photos, style: .default) { [weak self] action in
            guard let self else { return }
            self.onTapOpenLibrary()
        }
        alert.addAction(library)
        let takephoto = UIAlertAction(title: TDDLocalized.report_image_camera, style: .default) {  [weak self] action in
            guard let self else { return }
            self.onTapTakePhoto()
        }
        alert.addAction(takephoto)
        
        let cancel = UIAlertAction(title: TDDLocalized.app_cancel, style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        // Configure popover presentation for iPad
        if let popover = alert.popoverPresentationController {
            // You need to specify either sourceView+sourceRect or barButtonItem
            // Option 1: Center of the screen
            popover.sourceView = viewController?.view
            popover.sourceRect = CGRect(x: (viewController?.view.bounds.midX) ?? 0,
                                  y: (viewController?.view.bounds.midY) ?? 0,
                                  width: 0,
                                  height: 0)
            popover.permittedArrowDirections = [] // Optional - hides the arrow
        }
        
        viewController?.present(alert, animated: true)
    }
    
   @objc private func onTapOpenLibrary() {
        checkPhotoLibraryAuthorization { [weak self] granted in
            guard let self else { return }
            guard granted else {
                // TODO: - Tips, 开启相册权限
                let tips = String(format: TDDLocalized.allow_access_iPhone_photos, BridgeTool.tdd_getAppName())
                self.onNotAuthorized?(tips)
                return
            }
            self.openPhotoLibrary()
        }
    }
    
    private func onTapTakePhoto() {
        checkCameraAuthorization { [weak self] granted in
            guard let self else { return }
            guard granted else {
                let tips = String(format: TDDLocalized.allow_access_iPhone_camera, BridgeTool.tdd_getAppName())
                self.onNotAuthorized?(tips)
                return
            }
            self.takePhoto()
        }
    }
    
}

extension ArtiReportImageCell: UINavigationControllerDelegate { }

extension ArtiReportImageCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if models[indexPath.row].type == .media {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell {
                cell.closeButton.tag = indexPath.row
                cell.closeButton.addTarget(self, action: #selector(removeButtonAction(_:)), for: .touchUpInside)
                let mediaResource = models[indexPath.row].resource
                cell.mediaImageView.image = mediaResource?.image
                return cell
            }
        } else if models[indexPath.row].type == .add {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.reuseIdentifier, for: indexPath) as? AddImageCollectionViewCell {
                cell.addButton.tag = indexPath.row
                cell.addButton.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
                cell.isHidden = self.models.filter({ $0.type == .media }).count  >= maxPhotoCount
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
        let boxWidth: CGFloat = TDD_DiagnosisTools.isIpad() ? (20 + 120) : (7.5 + 75 + 7.5)
        return CGSize(width: boxWidth, height: boxWidth)
    }
}

extension ArtiReportImageCell: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if picker.sourceType == .camera {
            
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let media = MediaResource(image: pickedImage)
                self.addItemAndReloadData(at: picker.view.tag, media: media)
            }
            
            picker.dismiss(animated: true)
            return
        }
        
        guard let mediaType = info[.mediaType] as? String else {
            picker.dismiss(animated: true)
            return
        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageUrl = info[.imageURL] as? URL {
            picker.dismiss(animated: true) { [weak self] in guard let self else { return }
                let media = MediaResource(image: pickedImage)
                self.addItemAndReloadData(at: picker.view.tag, media: media)
            }
        } else {
            picker.dismiss(animated: true)
        }
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
            make.top.equalTo(TDD_DiagnosisTools.isIpad() ? 20 : 15.0)
            make.left.equalTo(TDD_DiagnosisTools.isIpad() ? 10 : 7.5)
            make.right.equalTo(TDD_DiagnosisTools.isIpad() ? -10 : -7.5)
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

        let imageName = (TDD_DiagnosisTools.softWareIsTopVCI() || TDD_DiagnosisTools.softWareIsCarPalSeries()) ? "image_add_icon" : "report_add_pic"
        if TDD_DiagnosisTools.isIpad() {
            button.setImage(BridgeTool.tdd_imageNamed(imageName)?.td_image(byResize: CGSize(width: 120, height: 120)), for: .normal)
        } else {
            button.setImage(BridgeTool.tdd_imageNamed(imageName), for: .normal)
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
            make.top.equalTo(TDD_DiagnosisTools.isIpad() ? 20 : 15.0)
            make.left.equalTo(TDD_DiagnosisTools.isIpad() ? 10 : 7.5)
            make.right.equalTo(TDD_DiagnosisTools.isIpad() ? -10 : -7.5)
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
        return button
    }()
}

fileprivate extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
