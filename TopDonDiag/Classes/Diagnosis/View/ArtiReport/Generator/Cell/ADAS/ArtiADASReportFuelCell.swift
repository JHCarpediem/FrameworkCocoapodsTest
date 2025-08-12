//
//  ArtiADASReportFuelCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/14.
//

import UIKit
import CoreServices
import Photos

@objc(TDD_ArtiADASReportFuelCell)
@objcMembers
public class ArtiADASReportFuelCell: UITableViewCell, UINavigationControllerDelegate { // 243.5
    
    public weak var viewController: UIViewController?
    
    public var onExpandChanged: ((Bool)->Void)?
    @objc public var onImageChanged: ((UIImage?) -> Void)?
    @objc public var onNotAuthorized: ((String) -> Void)?
    
    public var fuelImage: UIImage? {
        didSet {
            imageAddView.update(fuelImage)
            self.onImageChanged?(fuelImage)
        }
    }
    
    private var fuel: ArtiADASReportFuel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func update(fuel: ArtiADASReportFuel) {
        self.fuel = fuel
        
        expandView.update(fuel: fuel)
        fuelInputView.update(fuel: fuel)
        
        if fuel.isFold {
            imageAddView.isHidden = true
            fuelInputView.isHidden = true
        } else {
            imageAddView.isHidden = false
            fuelInputView.isHidden = false
        }
    }
    
    private func setupUI() {
        contentView.addSubview(expandView)
        contentView.addSubview(imageAddView)
        contentView.addSubview(fuelInputView)
        contentView.addSubview(gapView)
        
        expandView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(48.5)
        }
        
        imageAddView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(expandView.snp.bottom)
            make.height.equalTo(99.0)
        }
        
        fuelInputView.snp.makeConstraints { make in
            make.top.equalTo(imageAddView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(65.5)
        }
        
        gapView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(10.0)
            make.bottom.equalTo(0)
        }
        
        expandView.onExpandChanged = { [weak self] isFold in guard let self else { return }
            
            self.onExpandChanged?(isFold)
        }
        
        imageAddView.onClickAdd = { [weak self] in guard let self else { return }
            
            self.addButtonAction()
        }
        
        imageAddView.onClickDelete = { [weak self] in guard let self else { return }
            
            self.removeButtonAction()
        }
        
    }
    
    private(set) lazy var expandView: ExpandView = {
        let expandView = ExpandView()
        return expandView
    }()
    
    private lazy var imageAddView: ImageAddView = .init(frame: .zero)
    
    private lazy var fuelInputView: FuelLevelView = .init(frame: .zero)
    
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
private extension ArtiADASReportFuelCell {
    
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
private extension ArtiADASReportFuelCell {
    
    func removeButtonAction() {
        self.fuelImage = nil
    }
    
    func addButtonAction() {
        showActionSheet()
    }
    
    private func showActionSheet() {
        // TODO: - 国际化
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "从相册获取", style: .default) { [weak self] action in
            guard let self else { return }
            self.onTapOpenLibrary()
        }
        alert.addAction(library)
        
        let takephoto = UIAlertAction(title: "拍照", style: .default) {  [weak self] action in
            guard let self else { return }
            self.onTapTakePhoto()
        }
        alert.addAction(takephoto)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        viewController?.present(alert, animated: true)
    }
    
    private func onTapOpenLibrary() {
        checkPhotoLibraryAuthorization { [weak self] granted in
            guard let self else { return }
            guard granted else {
                // TODO: - Tips, 开启相册权限
                let tips = String(format: "请在iPhone的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", BridgeTool.tdd_getAppName())
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
                // TODO: - Tips, 开启相机权限
                let tips = String(format: "请在iPhone的\"设置-隐私-相机\"中允许%@访问相机", BridgeTool.tdd_getAppName())
                self.onNotAuthorized?(tips)
                return
            }
            self.takePhoto()
        }
    }
    
}

extension ArtiADASReportFuelCell: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if picker.sourceType == .camera {
            
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.fuelImage = pickedImage
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
                self.fuelImage = pickedImage
            }
        } else {
            picker.dismiss(animated: true)
        }
    }
}


extension ArtiADASReportFuelCell {
    
    class ImageAddView: UIView { //
        
        var onClickDelete: (() -> Void)?
        var onClickAdd: (() -> Void)?
        
        private var image: UIImage?
        
        func update(_ img: UIImage?) {
            self.image = img
            
            if let img = img {
                addButton.setImage(img, for: .normal)
                closeButton.isHidden = false
            } else {
                addButton.setImage(BridgeTool.tdd_imageNamed("report_add_pic"), for: .normal)
                closeButton.isHidden = true
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        private func setupUI() {
            addSubview(addButton)
            addSubview(closeButton)
            
            addButton.snp.makeConstraints { make in
                make.size.equalTo(75.0)
                make.top.equalTo(12.0)
                make.left.equalTo(20.0)
            }
            
            closeButton.snp.makeConstraints { make in
                make.size.equalTo(16)
                make.centerX.equalTo(addButton.snp.right)
                make.centerY.equalTo(addButton.snp.top)
            }
        }
        
        private(set) lazy var addButton: UIButton = {
            let button = UIButton()
            button.setImage(BridgeTool.tdd_imageNamed("report_add_pic"), for: .normal)
            button.isHidden = false
            button.addTarget(self, action: #selector(addBttonClick(_:)), for: .touchUpInside)
            button.isHighlighted = false
            button.adjustsImageWhenHighlighted = false
            return button
        }()
        
        private lazy var closeButton: UIButton = {
            let button = UIButton()
            button.isHidden = true
            button.setImage(BridgeTool.tdd_imageNamed("pci_icon_del"), for: .normal)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.addTarget(self, action: #selector(closeBttonClick(_:)), for: .touchUpInside)
            return button
        }()
        
        @objc func addBttonClick(_ btn: UIButton) {
            guard image == nil else { return }
            onClickAdd?()
        }
        
        @objc func closeBttonClick(_ btn: UIButton) {
           onClickDelete?()
        }
    }
    
}

extension ArtiADASReportFuelCell {
    
    class ExpandView: UIView { // height: 48.5
        
        private var fuel: ArtiADASReportFuel?
        
        var onExpandChanged: ((Bool)->Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        func update(fuel: ArtiADASReportFuel) {
            self.fuel = fuel
            
            // TODO: - 国际化
            titleLabel.text = "燃油表"
            
            if fuel.isFold {
                expandButton.setImage(BridgeTool.tdd_imageNamed("report_icon_drop"), for: .normal)
            } else {
                expandButton.setImage(BridgeTool.tdd_imageNamed("report_icon_pickup"), for: .normal)
            }
        }
        
        private(set) lazy var titleLabel: UILabel = {
            let textLabel = TDD_CustomLabel()
            textLabel.font = .systemFont(ofSize: 14, weight: .medium)
            textLabel.textColor = UIColor.tdd_color333333()
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 1
            return textLabel
        }()
        
        private lazy var expandButton: UIButton = {
            let button = UIButton()
            button.setImage(BridgeTool.tdd_imageNamed("report_icon_pickup"), for: .normal)
            button.addTarget(self, action: #selector(expandButtonClicked(_:)), for: .touchUpInside)
            return button
        }()
        
        private lazy var lineView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.tdd_ColorEEEEEE()
            return view
        }()
        
        func setupUI() {
            addSubview(titleLabel)
            addSubview(expandButton)
            addSubview(lineView)
            
            lineView.snp.makeConstraints { make in
                make.left.equalTo(20.0)
                make.bottom.equalTo(0)
                make.height.equalTo(0.5)
                make.right.equalToSuperview()
            }
            
            expandButton.snp.makeConstraints { make in
                make.width.equalTo(55.0)
                make.height.equalTo(48.0)
                make.right.top.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.top.equalToSuperview()
                make.bottom.equalTo(-0.5)
            }
            
        }
        
        // MARK: - Actions
        @objc func expandButtonClicked(_ btn: UIButton) {
            guard let fuel = self.fuel else { return }
            fuel.isFold.toggle()
            onExpandChanged?(fuel.isFold)
        }
    }
    
    class FuelLevelView: UIView,  UITextFieldDelegate {
        
        private var fuel: ArtiADASReportFuel?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupUI()
        }
        
        func update(fuel: ArtiADASReportFuel) {
            self.fuel = fuel
            if let fuel = self.fuel {
                textField.text = fuel.percent
            }
        }
        
        func setupUI() {
            addSubview(titleLabel)
            addSubview(fuelInputView)
            
            fuelInputView.addSubview(textField)
            fuelInputView.addSubview(unitLabel)
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(20.0)
                make.top.equalToSuperview()
            }
            
            fuelInputView.snp.makeConstraints { make in
                make.left.equalTo(20.0)
                make.top.equalTo(21.5)
                make.height.equalTo(44.0)
                make.right.equalTo(-20.0)
            }
            
            unitLabel.snp.makeConstraints { make in
                make.right.equalTo(-16.0)
                make.centerY.equalToSuperview()
                make.width.lessThanOrEqualTo(20.0)
            }
            
            textField.snp.makeConstraints { make in
                make.left.equalTo(16.0)
                make.top.bottom.equalToSuperview().inset(1.0)
                make.right.equalTo(unitLabel.snp.left).offset(-5.0)
            }
            
        }
        
        private(set) lazy var titleLabel: UILabel = {
            let textLabel = TDD_CustomLabel()
            // TODO: - 国际化
            textLabel.text = "燃油液位"
            textLabel.font = .systemFont(ofSize: 12, weight: .regular)
            textLabel.textColor = UIColor.tdd_color666666()
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 1
            return textLabel
        }()
        
        private lazy var fuelInputView: UIView = {
            let view = UIView()
            view.layer.borderColor = UIColor.tdd_colorCCCCCC().cgColor
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 2.5
            return view
        }()
        
        private(set) lazy var textField: UITextField = {
            let view = UITextField()
            view.keyboardType = .numberPad
            // TODO: - 国际化
            view.attributedPlaceholder = NSAttributedString(string: "请输入", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.tdd_colorCCCCCC()])
            view.delegate = self
            return view
        }()
        
        private(set) lazy var unitLabel: UILabel = {
            let textLabel = TDD_CustomLabel()
            textLabel.font = .systemFont(ofSize: 14, weight: .regular)
            textLabel.textColor = UIColor.tdd_color333333()
            textLabel.textAlignment = .right
            textLabel.numberOfLines = 1
            textLabel.text = "%"
            return textLabel
        }()
        
        // MARK: - UITextFieldDelegate
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          
            /*
            guard nil != Int(string.isEmpty ? "0" : string) else {
                return false
            }
            
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 3
            */
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            if updatedText.count > 3 {
                return false
            }
            
            if let number = Int(updatedText) {
                return number >= 0 && number <= 100
            }
            
            return updatedText.isEmpty
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            defer { textField.text = fuel?.percent ?? "" }
            guard let text = textField.text, !text.isEmpty else {
                fuel?.percent = ""
                return
            }
            guard let value = Int(text) else {
                fuel?.percent = ""
                return
            }
            let boundValue = max(0, min(100, value))
            fuel?.percent = "\(boundValue)"
        }
    }
    
}
