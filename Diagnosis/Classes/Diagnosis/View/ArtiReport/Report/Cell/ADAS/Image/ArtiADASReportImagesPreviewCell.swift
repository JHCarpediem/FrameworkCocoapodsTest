//
//  ArtiADASReportImagesPreviewCell.swift
//  Diagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import UIKit
import TDBasis

@objc(TDD_ArtiADASReportImagesPreviewCell)
@objcMembers
public class ArtiADASReportImagesPreviewCell: ArtiADASReportBaseCell {
    
    var isA4: Bool = false
    
    var imageSpace: CGFloat {
        isA4 ? 12 : (TDD_DiagnosisTools.isIpad() ? 24.0 : 15.0)
    }

    /// 每一行图片个数
    let lineCount = 4

    var imageSize: CGSize {
        let screenWidth = isA4 ? 595.0 : UIScreen.main.bounds.width
        var gaps = imageSpace * CGFloat(lineCount - 1)
        
        var imageWidth = (screenWidth - gaps - imageSpace * 2) / CGFloat(lineCount)
        if !isA4 && TDD_DiagnosisTools.isIpad() {
            imageWidth = 120.hdHorizontalScale
        }
        return CGSize(width: imageWidth - 1, height: imageWidth - 1)
    }
    
    var imageSource: [Any] = []
    
    public static func cellHeight(imageCount: Int, lineCount: Int = 4, isA4: Bool) -> CGFloat { // 20
        var line = (imageCount + lineCount - 1) / lineCount
        let screenWidth = isA4 ? 595.0 : UIScreen.main.bounds.width
        var imageSpace = isA4 ? 12 : (TDD_DiagnosisTools.isIpad() ? 24.0 : 15.0)
        var gaps = imageSpace * CGFloat(lineCount - 1)
        var imageWidth = (screenWidth - gaps - imageSpace * 2) / CGFloat(lineCount)
        if !isA4 && TDD_DiagnosisTools.isIpad() {
            imageWidth = 120.hdHorizontalScale
            return 15 + (imageWidth + imageSpace) * CGFloat(line) + 25
        } else {
            return (isA4 ? 15.0 : 7.0) + (imageWidth + imageSpace) * CGFloat(line) + 15.0 - imageSpace
        }
    }

    /// UIImage or filePath
    public func update(_ images: [Any]) {
        isA4 = false
        imageSource = images
        collectionView.reloadData()
    }
    
    /// UIImage or filePath
    public func updateA4(_ images: [Any]) {
        self.contentView.backgroundColor = .white
        isA4 = true
        imageSource = images
        collectionView.reloadData()
    }
    
    private func loadImageFromLocal(_ imageResource: Any, imageView: UIImageView) {
        if let path = imageResource as? String {
            DispatchQueue.global().async {
                let url = URL(fileURLWithPath: path)
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        } else if let img = imageResource as? UIImage {
            imageView.image = img
        }
        
    }

    public override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(imageSpace)
            make.top.equalToSuperview().offset(isA4 ? 15 : 7)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = imageSpace
        layout.minimumInteritemSpacing = 0
        
        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        uiCollectionView.backgroundColor = UIColor.clear
        uiCollectionView.dataSource = self
        uiCollectionView.delegate = self
        uiCollectionView.register(PreviewImageCollectionViewCell.self, forCellWithReuseIdentifier: "PreviewImageCollectionViewCellId")
        uiCollectionView.clipsToBounds = false
        return uiCollectionView
    }()
}

extension ArtiADASReportImagesPreviewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewImageCollectionViewCellId", for: indexPath) as? PreviewImageCollectionViewCell {
            let mediaResource = imageSource[indexPath.row]
            loadImageFromLocal(mediaResource, imageView: cell.mediaImageView)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ArtiADASReportImagesPreviewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension ArtiADASReportImagesPreviewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return imageSize
    }
}


internal class PreviewImageCollectionViewCell: UICollectionViewCell {
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
            make.edges.equalToSuperview()
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
}
