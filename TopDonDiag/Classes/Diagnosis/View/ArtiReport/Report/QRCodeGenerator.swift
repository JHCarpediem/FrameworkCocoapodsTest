//
//  QRCodeGenerator.swift
//  TopdonDiagnosis
//
//  Created by xinwenliu on 2024/6/4.
//

import UIKit
import CoreImage

@objc(TDD_QRCodeGenerator)
@objcMembers
public class QRCodeGenerator: NSObject {
    
    public static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: .utf8)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel") // 设置容错级别
        
        guard let ciImage = filter.outputImage else {
            return nil
        }
        return createImage(from: ciImage, with: 2 * UIScreen.main.scale)
    }
    
    private static func createImage(from ciImage: CIImage, with scale: CGFloat) -> UIImage? {
        let extent = ciImage.extent.integral
        let widthScale = scale * extent.size.width
        let heightScale = scale * extent.size.height
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CIContext(options: nil)
        if let bitmapContext = CGContext(data: nil, width: Int(widthScale), height: Int(heightScale), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue),
           let bitmapImage = context.createCGImage(ciImage, from: extent) {
            
            bitmapContext.interpolationQuality = .none
            bitmapContext.scaleBy(x: scale, y: scale)
            bitmapContext.draw(bitmapImage, in: extent)
            
            if let scaledImage = bitmapContext.makeImage() {
                return UIImage(cgImage: scaledImage)
            }
        }
        return nil
    }
    
}
