//
//  TDD_QRTool.m
//  TopdonDiagnosis
//
//  Created by zhouxiong on 2024/8/16.
//

#import "TDD_QRTool.h"
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface TDD_QRTool()

+ (UIImage *)generateQRCodeFromString:(NSString *)string withSize:(CGFloat)size;

@end

@implementation TDD_QRTool

+ (UIImage *)generateQRCodeFromString:(NSString *)string withSize:(CGFloat)size {
    // 将字符串转换为 NSData
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    // 创建二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:stringData forKey:@"inputMessage"];
    
    // 设置二维码的纠错级别（L, M, Q, H）
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // 生成二维码图像
    CIImage *qrCodeImage = filter.outputImage;
    
    // 将二维码图像放大到所需的大小
    CGFloat scaleX = size / qrCodeImage.extent.size.width;
    CGFloat scaleY = size / qrCodeImage.extent.size.height;
    CIImage *transformedImage = [qrCodeImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];
    
    // 将 CIImage 转换为 UIImage 并返回
    return [UIImage imageWithCIImage:transformedImage];
}

@end
