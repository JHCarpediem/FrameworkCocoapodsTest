//
//  ArtiADASReportFuelPreviewCell.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/5/16.
//

import UIKit

@objc(TDD_ArtiADASReportFuelPreviewCell)
@objcMembers
public class ArtiADASReportFuelPreviewCell: ArtiADASReportBaseCell {
    
    public static var cellHeight: CGFloat {
        7.0 + 80 + 15.0
    }
    
    public func update(_ model: ArtiADASReportFuel) {
        percentLabel.text = "\(model.displayPercent)%"
        //setupImage(path: model.imagePath)
    }
    
    public func updateA4(_ model: ArtiADASReportFuel) {
        percentLabel.text = "\(model.displayPercent)%"
        //setupImage(path: model.imagePath)
        updateA4Background()
        
        fuelImageView.snp.updateConstraints { make in
            make.left.equalTo(24.0)
        }
    }
    
    public func setupImage(path: String) {
        guard !path.isEmpty else {
            self.updateImage(nil)
            return
        }
        
        DispatchQueue.global().async {
            let url = URL(fileURLWithPath: path)
            guard let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async { self.updateImage(nil) }
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.updateImage(image)
            }
        }
    }
    
    public func updateImage(_ image: UIImage?) {
        if let image = image {
            self.fuelImageView.image = image
        } else {
            self.fuelImageView.image = BridgeTool.tdd_imageNamed("adas_pic_fuel")
        }
    }
    
    public override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(fuelImageView)
        contentView.addSubview(stackView)
        
        fuelImageView.snp.makeConstraints { make in
            make.left.equalTo(20.0)
            make.top.equalTo(7.0)
            make.size.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(fuelImageView.snp.right).offset(28)
            make.centerY.equalTo(fuelImageView)
        }
        
    }
    
    // MARK: - Lazy Load
    private lazy var fuelImageView: UIImageView = {
        let imgView = UIImageView()
        //imgView.backgroundColor = .yellow.withAlphaComponent(0.5)
        return imgView
    }()
    
    // TODO: - Montserrat Bold 字体
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [percentLabel, fuelLabel])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private(set) lazy var percentLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        textLabel.font = .systemFont(ofSize: 20, weight: .bold)
        textLabel.textColor = UIColor.tdd_color333333()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    private(set) lazy var fuelLabel: UILabel = {
        let textLabel = TDD_CustomLabel()
        // TODO: - 国际化
        textLabel.text = "燃油液位"
        textLabel.font = .systemFont(ofSize: 12, weight: .regular)
        textLabel.textColor = UIColor.tdd_color999999()
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
}
