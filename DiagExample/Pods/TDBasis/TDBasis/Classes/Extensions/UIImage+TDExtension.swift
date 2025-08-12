//
//  UIImage+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//

import UIKit

@objc
public enum GradientStyle: Int {
    case topToBottom, leftToRight, topLeftToBottomRight, topRightToBottomLeft
}

//MARK: UIView 扩展 所有的 TD 分类 在Swift中使用都采用 ·td· 做命名空间 OC 中使用 使用 td_xxx
/**
 eg:
 swift:
 let image = UIImage()
 image.td.image(byResize: CGSize.zero)
 
 oc:
 UIImage * image =  [UIImage imageName: @"xxx"];
 [image td_imageByResize: CGSizeMakeZero];
 
 */

public extension TDBasisWrap where Base: UIImage {
    /// 通过颜色创建一张纯色的图片
    static func color(_ color: UIColor, size: CGSize) -> UIImage {
        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, 1)

        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return UIImage()
        }

        return UIImage(cgImage: aCgImage)
    }
    
    /// 图片重设尺寸
    /// - Parameter toSize: 目标尺寸
    /// - Returns: 新图片
    func image(byResize toSize: CGSize) -> UIImage {
        base.td_image(byResize: toSize)
    }
    
    
    /// 设置图片的tintColor
    /// - Parameter color: tintColor
    /// - Returns: 新的图片
    func image(byTintColor color: UIColor) -> UIImage {
        base.td_image(byTintColor: color)
    }
    
    /// 压缩图片  压缩比例 0.5
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        base.td_compressed(quality: quality)
    }

    /// sendCaptchaCompressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        base.td_compressedData(quality: quality)
    }

    /// sendCaptchaUIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    func cropped(to rect: CGRect) -> UIImage {
        base.td_cropped(to: rect)
    }

    /// sendCaptchaUIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        base.td_scaled(toHeight: toHeight, opaque: opaque)
    }

    /// sendCaptchaUIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        base.td_scaled(toWidth: toWidth, opaque: opaque)
    }

    /// sendCaptchaCreates a copy of the receiver rotated by the given angle.
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: Measurement(value: 180, unit: .degrees))
    ///
    /// - Parameter angle: The angle measurement by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    @available(tvOS 10.0, watchOS 3.0, *)
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        base.td_rotated(by: angle)
    }

    /// sendCaptchaCreates a copy of the receiver rotated by the given angle (in radians).
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    ///
    /// - Parameter radians: The angle, in radians, by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    func rotated(by radians: CGFloat) -> UIImage? {
        base.td_rotated(by: radians)
    }

    /// sendCaptchaUIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    func filled(withColor color: UIColor) -> UIImage {
        base.td_filled(withColor: color)
    }

    /// sendCaptchaUIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    func tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        base.td_tint(color, blendMode: blendMode, alpha: alpha)
    }

    /// sendCaptchaUImage with background color
    ///
    /// - Parameters:
    ///   - backgroundColor: Color to use as background color
    /// - Returns: UIImage with a background color that is visible where alpha < 1
    func withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {
        base.td_withBackgroundColor(backgroundColor)
    }

    /// sendCaptchaUIImage with rounded corners
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    func withRoundedCorners(radius: CGFloat = 0) -> UIImage? {
        base.td_withRoundedCorners(radius: radius)
    }

    /// sendCaptchaBase 64 encoded PNG data of the image.
    ///
    /// - returns: Base 64 encoded PNG data of the image as a String.
    func pngBase64String() -> String? {
        base.td_pngBase64String()
    }

    /// sendCaptchaBase 64 encoded JPEG data of the image.
    ///
    /// - parameter compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    /// - returns: Base 64 encoded JPEG data of the image as a String.
    func jpegBase64String(compressionQuality: CGFloat) -> String? {
        base.td_jpegBase64String(compressionQuality: compressionQuality)
    }
    
    func scaled(to newSize: CGSize, opaque: Bool = false) -> UIImage? {
        base.td_scaled(to: newSize, opaque: opaque)
    }
    
    static func gradient(colors: [UIColor], size: CGSize, style: GradientStyle = .leftToRight) -> UIImage? {
        return gradient(colors: colors, size: size, style: style, baseColor: nil)
    }
    
    static func gradient(colors: [UIColor], size: CGSize, style: GradientStyle = .leftToRight, baseColor: UIColor?) -> UIImage? {
        if colors.isEmpty { return nil }
        if size.width == 0 || size.height == 0 { return nil }
        
        let cgColors = colors.map { $0.cgColor }
        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) }
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, true, UIScreen.main.scale)
        guard let contenxt = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        if let baseColor = baseColor {
            contenxt.setFillColor(baseColor.cgColor)
            contenxt.fill(CGRect(origin: .zero, size: topdon_new_size))
        }
        
        contenxt.saveGState()
        let colorSpace = cgColors.last!.colorSpace
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: nil) else {
            return nil
        }
        var startPt = CGPoint.zero
        var endPt = CGPoint.zero
        switch style {
        case .topToBottom:
            endPt = CGPoint(x: 0, y: size.height)
        case .leftToRight:
            endPt = CGPoint(x: size.width, y: 0)
        case .topLeftToBottomRight:
            endPt = CGPoint(x: size.width, y: size.height)
        case .topRightToBottomLeft:
            startPt = CGPoint(x: 0, y: size.height)
            endPt = CGPoint(x: size.width, y: 0)
        }
        
        contenxt.drawLinearGradient(gradient, start: startPt, end: endPt, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        contenxt.restoreGState()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func gradient(colors: [UIColor], size: CGSize, startPoint: CGPoint, endPoint: CGPoint, locations: UnsafePointer<CGFloat>?) -> UIImage? {
        if colors.isEmpty { return nil }
        if size.width == 0 || size.height == 0 { return nil }

        let cgColors = colors.map { $0.cgColor }
        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, true, UIScreen.main.scale)
        guard let contenxt = UIGraphicsGetCurrentContext() else {
            return nil
        }
        contenxt.saveGState()
        let colorSpace = cgColors.last!.colorSpace
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: nil) else {
            return nil
        }
        contenxt.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        contenxt.restoreGState()
        UIGraphicsEndImageContext()
        return image
    }
}

@objc public extension UIImage {
    
    @objc(td_gradientWithColors:size:style:)
    public static func td_gradient(colors: [UIColor], size: CGSize, style: GradientStyle = .leftToRight) -> UIImage? {
        td.gradient(colors: colors, size: size, style: style)
    }
    
    /// 图片重设尺寸
    /// - Parameter toSize: 目标尺寸
    /// - Returns: 新图片
    @objc public func td_image(byResize toSize: CGSize) -> UIImage {
        if toSize.width <= 0 || toSize.height <= 0 { return self }
        var topdon_new_size = toSize
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, scale)
        self.draw(in: CGRect(origin: .zero, size: toSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? self
    }
    
    /// 设置图片的tintColor
    /// - Parameter color: tintColor
    /// - Returns: 新的图片
    @objc public func td_image(byTintColor color: UIColor) -> UIImage {
        var topdon_new_size = self.size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        color.set()
        UIRectFill(rect)
        self.draw(at: .zero, blendMode: .destinationIn, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    
    /// sendCaptchaCompressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    @objc public func td_compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// sendCaptchaCompressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    @objc public func td_compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }

    /// sendCaptchaUIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    @objc public func td_cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= size.width && rect.size.height <= size.height else { return self }
        let scaledRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        guard let image = cgImage?.cropping(to: scaledRect) else { return self }
        return UIImage(cgImage: image, scale: scale, orientation: imageOrientation)
    }

    /// sendCaptchaUIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    @objc public func td_scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        let topdon_new_size = CGSize(width: max(0.1, newWidth), height: max(0.1, toHeight))
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// sendCaptchaUIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    @objc public func td_scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        let topdon_new_size = CGSize(width: max(0.1, toWidth), height: max(0.1, newHeight))
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// sendCaptchaCreates a copy of the receiver rotated by the given angle.
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: Measurement(value: 180, unit: .degrees))
    ///
    /// - Parameter angle: The angle measurement by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    @available(tvOS 10.0, watchOS 3.0, *)
    @objc(td_rotatedByAngle:)
    public func td_rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)

        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        var topdon_new_size = roundedDestRect.size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, UIScreen.main.scale)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// sendCaptchaCreates a copy of the receiver rotated by the given angle (in radians).
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    ///
    /// - Parameter radians: The angle, in radians, by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    @objc(td_rotatedByRadians:)
    public func td_rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        var topdon_new_size = roundedDestRect.size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, UIScreen.main.scale)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// sendCaptchaUIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    @objc public func td_filled(withColor color: UIColor) -> UIImage {

        #if !os(watchOS)
        if #available(tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            let renderer = UIGraphicsImageRenderer(size: size, format: format)
            return renderer.image { context in
                color.setFill()
                context.fill(CGRect(origin: .zero, size: size))
            }
        }
        #endif

        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// sendCaptchaUIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    @objc public func td_tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: size)

        #if !os(watchOS)
        if #available(tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            return UIGraphicsImageRenderer(size: size, format: format).image { context in
                color.setFill()
                context.fill(drawRect)
                draw(in: drawRect, blendMode: blendMode, alpha: alpha)
            }
        }
        #endif

        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    /// sendCaptchaUImage with background color
    ///
    /// - Parameters:
    ///   - backgroundColor: Color to use as background color
    /// - Returns: UIImage with a background color that is visible where alpha < 1
    @objc public func td_withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {

        #if !os(watchOS)
        if #available(tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            return UIGraphicsImageRenderer(size: size, format: format).image { context in
                backgroundColor.setFill()
                context.fill(context.format.bounds)
                draw(at: .zero)
            }
        }
        #endif

        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, scale)
        defer { UIGraphicsEndImageContext() }

        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        draw(at: .zero)

        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    /// sendCaptchaUIImage with rounded corners
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    @objc public func td_withRoundedCorners(radius: CGFloat = 0) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        var topdon_new_size = size
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// sendCaptchaBase 64 encoded PNG data of the image.
    ///
    /// - returns: Base 64 encoded PNG data of the image as a String.
    @objc public func td_pngBase64String() -> String? {
        return pngData()?.base64EncodedString()
    }

    /// sendCaptchaBase 64 encoded JPEG data of the image.
    ///
    /// - parameter compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    /// - returns: Base 64 encoded JPEG data of the image as a String.
    @objc public func td_jpegBase64String(compressionQuality: CGFloat) -> String? {
        return jpegData(compressionQuality: compressionQuality)?.base64EncodedString()
    }
    
    //MARK: - 将图片缩放成指定尺寸（多余部分自动删除）
    @objc public func td_scaled(to newSize: CGSize, opaque: Bool = false) -> UIImage? {
        //计算比例
        let aspectWidth = newSize.width / size.width
        let aspectHeight = newSize.height / size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图形绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y = (newSize.height - size.height * aspectRatio) / 2.0
        
        //绘制并获取最终图片
        var topdon_new_size = newSize
        if topdon_new_size.width <= 0 || topdon_new_size.height <= 0{ topdon_new_size=CGSizeMake(0.1,0.1) } 
        UIGraphicsBeginImageContextWithOptions(topdon_new_size, opaque, scale)
        draw(in: scaledImageRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
