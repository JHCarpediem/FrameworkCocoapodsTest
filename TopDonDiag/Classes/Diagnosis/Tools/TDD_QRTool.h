//
//  TDD_QRTool.h
//  TopdonDiagnosis
//
//  Created by zhouxiong on 2024/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_QRTool : NSObject
+ (UIImage *)generateQRCodeFromString:(NSString *)string withSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
