//
//  PopoverLabel.swift
//  TDDiag
//
//  Created by fench on 2023/6/16.
//

import UIKit

@objc public class ProgressIndicator: UIView {
    
    @objc public var isShowPop: Bool = false {
        didSet {
            self.textLabel.isHidden = !isShowPop
            self.setNeedsLayout()
        }
    }
    
    @objc public var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    fileprivate var textLabel = IndicatorLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = UIColor.clear
        
        let bg = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        bg.layer.cornerRadius = 11
        bg.backgroundColor = UIColor.tdd_background()
        self.addSubview(bg)
        bg.addShadowView(color: UIColor.tdd_color000000().withAlphaComponent(0.2), offset: CGSize(width: 0, height: 1), opacity: 0.5, radius: 8, tag: 112234)
        
        let round = UIView()
        round.backgroundColor = UIColor.tdd_colorDiagTheme()
        self.addSubview(round)
        round.mas_makeConstraints {
            $0?.center.equalTo()(self)
            $0?.size.mas_equalTo()(CGSize(width: 8, height: 8))
        }
        round.layer.cornerRadius = 4
        
        textLabel.contentInset = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        textLabel.font = UIFont.systemFont(ofSize:  12)
        textLabel.textColor = UIColor.tdd_color666666()
        textLabel.backgroundColor = UIColor.clear
        textLabel.isHidden = !isShowPop
        textLabel.cornerRadius = 4
        self.addSubview(textLabel)
        
        textLabel.mas_makeConstraints {
            $0?.bottom.equalTo()(self.mas_top)?.offset()(-10)
            $0?.centerX.equalTo()(self)
        }
        
        self.clipsToBounds = false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viewWithTag(112233)?.removeFromSuperview()
        if isShowPop {        
            self.textLabel.addShadowView(color: UIColor.tdd_color000000().withAlphaComponent(0.3), offset: CGSize(width: 0, height: 1), opacity: 0.5, radius: 8, tag: 112233)
        }
    }

}

extension ProgressIndicator {
    class IndicatorLabel: UILabel {
        
        var contentInset: UIEdgeInsets = .zero
            
        override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
            var rect: CGRect = super.textRect(forBounds: bounds.inset(by: contentInset), limitedToNumberOfLines: numberOfLines)
            //根据edgeInsets，修改绘制文字的bounds
            rect.origin.x -= contentInset.left;
            rect.origin.y -= contentInset.top;
            rect.size.width += contentInset.left + contentInset.right;
            rect.size.height += contentInset.top + contentInset.bottom;
            return rect
        }
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: contentInset))
        }
        
        
        var isCornerLeftArrow: Bool {
          return false
        }
        
        var isCornerRightArrow: Bool {
          return false 
        }
        
        fileprivate var arrowShowPoint: CGPoint!
        let arrowSize = CGSize(width: 8, height: 4)
        var cornerRadius: CGFloat = 4
        
        func radians(_ degrees: CGFloat) -> CGFloat {
          return CGFloat.pi * degrees / 180
        }
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            let arrow = UIBezierPath()
            let color = UIColor.tdd_background()
            let arrowPoint = CGPoint(x: rect.maxX / 2, y: rect.size.height + arrowSize.height)
            arrow.move(to: CGPoint(x: arrowPoint.x, y: self.bounds.height))
            arrow.addLine(
              to: CGPoint(
                x: arrowPoint.x - arrowSize.width * 0.5,
                y: self.isCornerLeftArrow ? self.arrowSize.height : self.bounds.height - self.arrowSize.height
              )
            )

            arrow.addLine(to: CGPoint(x: self.cornerRadius, y: self.bounds.height - self.arrowSize.height))
            arrow.addArc(
              withCenter: CGPoint(
                x: self.cornerRadius,
                y: self.bounds.height - self.arrowSize.height - self.cornerRadius
              ),
              radius: self.cornerRadius,
              startAngle: self.radians(90),
              endAngle: self.radians(180),
              clockwise: true)

            arrow.addLine(to: CGPoint(x: 0, y: self.cornerRadius))
            arrow.addArc(
              withCenter: CGPoint(
                x: self.cornerRadius,
                y: self.cornerRadius
              ),
              radius: self.cornerRadius,
              startAngle: self.radians(180),
              endAngle: self.radians(270),
              clockwise: true)

            arrow.addLine(to: CGPoint(x: self.bounds.width - self.cornerRadius, y: 0))
            arrow.addArc(
              withCenter: CGPoint(
                x: self.bounds.width - self.cornerRadius,
                y: self.cornerRadius
              ),
              radius: self.cornerRadius,
              startAngle: self.radians(270),
              endAngle: self.radians(0),
              clockwise: true)

            arrow.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - self.arrowSize.height - self.cornerRadius))
            arrow.addArc(
              withCenter: CGPoint(
                x: self.bounds.width - self.cornerRadius,
                y: self.bounds.height - self.arrowSize.height - self.cornerRadius
              ),
              radius: self.cornerRadius,
              startAngle: self.radians(0),
              endAngle: self.radians(90),
              clockwise: true)

            arrow.addLine(
              to: CGPoint(
                x: arrowPoint.x + self.arrowSize.width * 0.5,
                y: self.isCornerRightArrow ? self.arrowSize.height : self.bounds.height - self.arrowSize.height
              )
            )
            
            color.setFill()
            arrow.fill()
            
            guard let cxt = UIGraphicsGetCurrentContext() else { return }
            let tFont = self.font ?? UIFont.systemFont(ofSize: 12)
            let tColor = self.textColor ?? UIColor.tdd_color666666()
            let centP = CGPoint(x: rect.width / 2, y: (rect.height - arrowSize.height - tFont.lineHeight) / 2)
            self.drawText(context: cxt, text: self.text ?? "", point:  centP, align: .center, attributes: [.foregroundColor: tColor, .font : tFont])
        }
        
        
        
        fileprivate func drawText(context: CGContext,
                                  text: String,
                                  point: CGPoint,
                                  align: NSTextAlignment,
                                  attributes: [NSAttributedString.Key : Any]?) {
            
            var point = point
            
            if align == .center
            {
                point.x -= text.size(withAttributes: attributes).width / 2.0
            }
            else if align == .right
            {
                point.x -= text.size(withAttributes: attributes).width
            }
            
            UIGraphicsPushContext(context)
            
            (text as NSString).draw(at: point, withAttributes: attributes)
            
            UIGraphicsPopContext()
        }
    }
}


@objc public extension UIView {
    func addShadowView(color: UIColor, offset: CGSize, opacity: CGFloat, radius: CGFloat, tag: Int) {
        //Remove previous shadow views
        superview?.viewWithTag(tag)?.removeFromSuperview()

        //Create new shadow view with frame
        let shadowView = UIView(frame: frame)
        shadowView.tag = tag
        shadowView.layer.shadowColor = color.cgColor
        shadowView.layer.shadowOffset = offset
        shadowView.layer.masksToBounds = false

        shadowView.layer.shadowOpacity = Float(opacity)
        shadowView.layer.shadowRadius = radius
        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true

        superview?.insertSubview(shadowView, belowSubview: self)
    }
    
    func removeShadowView(_ tag: Int){
        superview?.viewWithTag(tag)?.removeFromSuperview()
    }
}
