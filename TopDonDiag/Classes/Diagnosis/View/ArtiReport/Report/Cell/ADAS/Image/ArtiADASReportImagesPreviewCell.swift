//
//  ArtiADASReportImagesPreviewCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import UIKit
import TDBasis

@objc(TDD_ArtiADASReportImagesPreviewCell)
@objcMembers
public class ArtiADASReportImagesPreviewCell: ArtiADASReportBaseCell {
    
    static let imageSpace: CGFloat = (TDD_DiagnosisTools.isIpad() ? 24.0 : 12.0)
    
    static var imageSize: CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let gaps: CGFloat = 12.0 * 3
        let fourImageSize = screenWidth - 20 * 2 - gaps
        let imageWidth = TDD_DiagnosisTools.isIpad() ? 120.hdHorizontalScale : fourImageSize / 4.0
        return CGSize(width: imageWidth, height: imageWidth)
    }
    
    static var a4ImageSize: CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    public static var cellHeight: CGFloat { // 20
        if TDD_DiagnosisTools.isIpad() {
            return 20 + imageSize.height + 25
        }
        return 7.0 + imageSize.height + 15.0
    }
    
    public static var a4CellHeight: CGFloat { // 24
        7.0 + a4ImageSize.height + 15.0
    }

    /// UIImage or filePath
    public func update(_ images: [Any]) {
        refreshImages(images)
        layoutPreview()
    }
    
    /// UIImage or filePath
    public func updateA4(_ images: [Any]) {
        self.contentView.backgroundColor = .white
        refreshImages(images)
        layoutA4()
    }

    private func refreshImages(_ images: [Any]) {
        guard !images.isEmpty else {
            imageView0.isHidden = false
            imageView0.image = BridgeTool.tdd_imageNamed("report_add_pic")
            
            imageView1.isHidden = true
            imageView2.isHidden = true
            imageView3.isHidden = true
            return
        }
        
        let maxIndex = images.count - 1
        switch maxIndex {
        case 0:
            imageView0.isHidden = false
            loadImageFromLocal(images[0], imageView: imageView0)
            
            imageView1.isHidden = true
            imageView2.isHidden = true
            imageView3.isHidden = true
        case 1:
            imageView0.isHidden = false
            loadImageFromLocal(images[0], imageView: imageView0)
            
            imageView1.isHidden = false
            loadImageFromLocal(images[1], imageView: imageView1)
            
            imageView2.isHidden = true
            imageView3.isHidden = true
        case 2:
            imageView0.isHidden = false
            loadImageFromLocal(images[0], imageView: imageView0)
            
            imageView1.isHidden = false
            loadImageFromLocal(images[1], imageView: imageView1)
            
            imageView2.isHidden = false
            loadImageFromLocal(images[2], imageView: imageView2)
            
            imageView3.isHidden = true
        case 3:
            imageView0.isHidden = false
            loadImageFromLocal(images[0], imageView: imageView0)
            
            imageView1.isHidden = false
            loadImageFromLocal(images[1], imageView: imageView1)
            
            imageView2.isHidden = false
            loadImageFromLocal(images[2], imageView: imageView2)
            
            imageView3.isHidden = false
            loadImageFromLocal(images[3], imageView: imageView3)
        default:
            break
        }
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
        
        contentView.addSubview(imageView0)
        contentView.addSubview(imageView1)
        contentView.addSubview(imageView2)
        contentView.addSubview(imageView3)
        
        layoutPreview()
    }
    
    private func layoutPreview() {
        imageView0.snp.remakeConstraints { make in
            make.top.equalTo(7.0.adaptHD(to: 20))
            make.left.equalTo(TDD_DiagnosisTools.isIpad() ? 40.0 : 20.0)
            make.size.equalTo(Self.imageSize)
        }
        
        imageView1.snp.remakeConstraints { make in
            make.top.size.equalTo(imageView0)
            make.left.equalTo(imageView0.snp.right).offset(ArtiADASReportImagesPreviewCell.imageSpace)
        }
        
        imageView2.snp.remakeConstraints { make in
            make.top.size.equalTo(imageView0)
            make.left.equalTo(imageView1.snp.right).offset(ArtiADASReportImagesPreviewCell.imageSpace)
        }
        
        imageView3.snp.remakeConstraints { make in
            make.top.size.equalTo(imageView0)
            make.left.equalTo(imageView2.snp.right).offset(ArtiADASReportImagesPreviewCell.imageSpace)
        }
    }
    
    private func layoutA4() {
        imageView0.snp.remakeConstraints { make in
            make.top.equalTo(7.0)
            make.left.equalTo(24.0)
            make.size.equalTo(Self.a4ImageSize)
        }
        
        imageView1.snp.remakeConstraints { make in
            make.top.size.equalTo(imageView0)
            make.left.equalTo(imageView0.snp.right).offset(12.0)
        }
        
        imageView2.snp.remakeConstraints { make in
            make.top.size.equalTo(imageView0)
            make.left.equalTo(imageView1.snp.right).offset(12.0)
        }
        
        imageView3.snp.remakeConstraints { make in
            make.top.size.equalTo(imageView0)
            make.left.equalTo(imageView2.snp.right).offset(12.0)
        }
    }
    
    // MARK: - Lazy Load
    private(set) lazy var imageView0: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 2.5
        imgView.clipsToBounds = true
        imgView.isHidden = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private(set) lazy var imageView1: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 2.5
        imgView.clipsToBounds = true
        imgView.isHidden = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private(set) lazy var imageView2: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 2.5
        imgView.clipsToBounds = true
        imgView.isHidden = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private(set) lazy var imageView3: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 2.5
        imgView.clipsToBounds = true
        imgView.isHidden = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
}
