//
//  TDD_DiagBridge.h
//  TopdonDiagnosis
//
//  Created by liuxinwen on 2025/7/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_DiagBridge : NSObject

+ (CGFloat) HD_HeightValue;

+ (CGFloat) H_HeightValue;

// IphoneWidth
+ (CGFloat) IphoneWidthValue;

// IphoneHeight
+ (CGFloat) IphoneHeightValue;

+ (BOOL) isPad;

+ (BOOL) isIPhoneX;

+ (CGFloat)kSafeBottomHeightValue;

+ (BOOL) isKindOfTopVCIValue;

+ (UIImage* __nullable)kImageNamedValue: (NSString *)named;

+ (UIWindow *)FLT_APP_WINDOWValue;

+ (uint32_t)DF_ID_REPORTValue;

+ (NSString *)getLanguage:(NSString *)str;

+ (UIImage *)tdd_imageWithColor:(UIColor *)color rect:(CGRect)rect;

+ (NSArray <UIColor *> *)chart4Colors;

@end

NS_ASSUME_NONNULL_END
