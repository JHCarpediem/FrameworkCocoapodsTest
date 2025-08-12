//
//  TDDArtiTroubleBubbleView.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/7/31.
//

import UIKit
import SnapKit

@objc(TDD_ArtiTroubleBubbleView)
@objcMembers
public class TDDArtiTroubleBubbleView: UIView {
    
    public lazy var bgView: UIView = {
        let bgView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    
    public var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.tdd_troubleShowStateBackground()
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.14).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 16
        return contentView
    }()
    
    public var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = Software.isKindOfTopVCI ? TDD_Tools.tdd_imageNamed("icon_diag_arrow").tdd_image(byTintColor:UIColor(hex: 0x323C46)) : TDD_Tools.tdd_imageNamed("icon_diag_arrow")
        return arrowImageView
    }()
    
    public var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        if Software.isKindOfTopVCI {
            scrollView.indicatorStyle = .white
        }
        return scrollView
    }()
    
    public var contentLabel: UILabel = {
        let contentLabel = TDD_CustomLabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        contentLabel.textColor = UIColor.tdd_color000000()
        return contentLabel
    }()
    
    public var maxTextContentHeight: CGFloat = 150.0
    public var maxTextContentWidth: CGFloat = 230.0
    public var arrowHeight: CGFloat = 6.0
    public var arrowTopOffset: CGFloat = 20.0
    public var rowHeight: CGFloat = 17.0
    public var arrowDownBottomOffsetBlock: ((CGFloat) -> CGFloat)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func show(withPopPoint point: CGPoint, content: NSAttributedString) {
        contentLabel.attributedText = content
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(self)
        
        let textSize = content.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        let contentTextWidth = min(textSize.width.rounded(.up), maxTextContentWidth)
        var contentTextHeight = content.boundingRect(with: CGSize(width: maxTextContentWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height.rounded(.up)
        
        if (contentTextWidth < maxTextContentWidth) && contentTextHeight < rowHeight {
            contentTextHeight = max(textSize.height.rounded(.up), contentTextHeight)
        }
        
        let contentWidth = contentTextWidth + 30 // 20
        
        let scrollHeight = min(contentTextHeight, maxTextContentHeight)
        
        if point.y > (UIScreen.main.bounds.height - (scrollHeight + 18) - arrowTopOffset) {
            contentView.snp.makeConstraints { make in
                make.right.equalTo(self).offset(-25)
                make.width.equalTo(contentWidth)
                //make.height.equalTo(scrollHeight + 35)
                make.height.equalTo(scrollHeight + 18)
                make.bottom.equalTo(arrowImageView.snp.top)
            }
            
            arrowImageView.snp.makeConstraints { make in
                make.width.equalTo(12)
                make.height.equalTo(arrowHeight)
                //make.right.equalTo(contentView).offset(-5)
                make.centerX.equalTo(point.x)
                if let arrowDownBottomOffsetBlock = arrowDownBottomOffsetBlock {
                    make.bottom.equalTo(self).offset(arrowDownBottomOffsetBlock(point.y - UIScreen.main.bounds.height))
                } else {
                    make.bottom.equalTo(self).offset(point.y - UIScreen.main.bounds.height)
                }
            }
            
            arrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
        } else {
            contentView.snp.makeConstraints { make in
                make.right.equalTo(self).offset(-25)
                make.width.equalTo(contentWidth)
                //make.height.equalTo(scrollHeight + 35)
                make.height.equalTo(scrollHeight + 18)
                make.top.equalTo(arrowImageView.snp.bottom)
            }
            
            arrowImageView.snp.makeConstraints { make in
                make.width.equalTo(12)
                make.height.equalTo(arrowHeight)
                //make.right.equalTo(contentView).offset(-5)
                make.centerX.equalTo(point.x)
                make.top.equalTo(self).offset(point.y + arrowTopOffset)
            }
        }
        
        scrollView.snp.makeConstraints { make in
            //make.height.equalTo(scrollHeight + 20)
            make.height.equalTo(scrollHeight)
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView).offset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(scrollView).offset(15)
            make.width.equalTo(contentTextWidth)
            make.top.equalTo(scrollView)
        }
        
        layoutIfNeeded()
        scrollView.contentSize = CGSize(width: contentWidth, height: contentTextHeight)
    }
    
    @objc public func dismiss() {
        removeFromSuperview()
    }
    
    func setupUI() {
        
        addSubview(bgView)
        
        addSubview(contentView)
        
        addSubview(arrowImageView)
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
}

fileprivate extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}

