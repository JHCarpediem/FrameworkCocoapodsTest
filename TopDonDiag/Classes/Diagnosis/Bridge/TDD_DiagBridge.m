//
//  TDD_DiagBridge.m
//  TopdonDiagnosis
//
//  Created by liuxinwen on 2025/7/25.
//

#import "TDD_DiagBridge.h"

@implementation TDD_DiagBridge

+ (CGFloat) HD_HeightValue {
    return HD_Height;
}

+ (CGFloat) H_HeightValue {
    return H_Height;
}

+ (CGFloat) IphoneWidthValue {
    return IphoneWidth;
}

+ (CGFloat) IphoneHeightValue {
    return IphoneHeight;
}

+ (BOOL)isPad {
    return IS_IPad;
}

+ (BOOL)isIPhoneX {
    return IS_iPhoneX;
}

+ (CGFloat)kSafeBottomHeightValue {
    return kSafeBottomHeight;
}

+ (BOOL)isKindOfTopVCIValue {
    return isKindOfTopVCI;
}

+ (UIImage* __nullable)kImageNamedValue: (NSString *)named {
    return kImageNamed(named);
}

+ (UIWindow *)FLT_APP_WINDOWValue {
    return FLT_APP_WINDOW;
}

+ (uint32_t)DF_ID_REPORTValue {
    return DF_ID_REPORT;
}

+ (NSString *)getLanguage:(NSString *)str {
    return [TDD_HLanguage getLanguage:str];
}

+ (UIImage *)tdd_imageWithColor:(UIColor *)color rect:(CGRect)rect {
    return [UIImage tdd_imageWithColor:color rect:rect];
}

+ (NSArray <UIColor *> *)chart4Colors {
    return @[
        [UIColor tdd_colorWithHex:0x94D3E1],
        [UIColor tdd_colorWithHex:0xFFA959],
        [UIColor tdd_colorWithHex:0x039500],
        [UIColor tdd_colorWithHex:0x01388B]
    ];
}

@end
