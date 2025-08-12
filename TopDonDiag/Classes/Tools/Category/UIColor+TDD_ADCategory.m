//
//  UIColor+TDD_ADCategory.m
//  AD200
//
//  Created by yong liu on 2022/7/13.
//

#import "UIColor+TDD_ADCategory.h"
#define DiagShareManageColorType [TDD_DiagnosisManage sharedManage].viewColorType
@implementation UIColor (TDD_ADCategory)
+ (UIColor *)tdd_colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)tdd_colorWithHex:(int)hexValue {
    return [UIColor tdd_colorWithHex:hexValue alpha:1.0];
}

// 渐变色
+ (UIColor *)tdd_colorWithTDD_GradientStyle:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size andColors:(NSArray *)colors {
    
    UIImage *image = [UIImage tdd_imageWithColors:colors size:size gradientStyle:gradientStyle];
    
    return [UIColor colorWithPatternImage:image];
}

#pragma mark - 动态配色
+ (UIColor *)tdd_colorDiagTheme
{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return [UIColor tdd_colorWithHex:0x2B79D8];
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorWithHex:0xFF7B1C];
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithHex:0xF22222];
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1093FF];
        default:
            return [UIColor tdd_colorWithHex:0xF22222];
            break;
    }
}
//主题色渐变
//高亮渐变
+ (UIColor *)tdd_colorDiagThemeGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_color2B79D8], [UIColor tdd_color479AFF]]];
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorWithHex:0xFF7B1C];
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithHex:0x000000 alpha:0.05];
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return UIColor.tdd_color29394F;
        default:
            return [UIColor tdd_colorWithHex:0x000000 alpha:0.05];
            break;
    }
}

+ (UIColor *)tdd_mainBackgroundGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0x232F3D], [UIColor tdd_colorWithHex:0x000F20]]];
    }
    return UIColor.whiteColor;
}

//normal渐变
+ (UIColor *)tdd_colorDiagNormalGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorFFFFFF], [UIColor tdd_colorF2F8FD]]];
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorFFFFFF], [UIColor tdd_colorWithHex:0xFFF5EE]]];
        case TDD_DiagViewColorType_Red:
            return UIColor.tdd_colorFFFFFF;
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0x232F3D], [UIColor tdd_colorWithHex:0x000F20]]];
        default:
            return UIColor.tdd_colorFFFFFF;
            break;
    }
}
//报告配色
+ (UIColor *)tdd_colorDiagBottomGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorFFFFFF], [UIColor tdd_colorF2F8FD]]];
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorFFFFFF], [UIColor tdd_colorWithHex:0xFFF0E4]]];
        case TDD_DiagViewColorType_Red:
            return UIColor.tdd_colorFFFFFF;
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_color29394F];
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
        default:
            return UIColor.tdd_colorFFFFFF;
            break;
    }
}

+ (UIColor *)tdd_btnBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return UIColor.clearColor;
    }
    return [UIColor whiteColor];
}

+ (UIColor *)tdd_btnNormalBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x1093FF];
    }
    return [UIColor whiteColor];
}

+ (UIColor *)tdd_btnDisableBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [[UIColor tdd_colorWithHex:0x1093FF] colorWithAlphaComponent:0.5];
        default:
            return [UIColor whiteColor];
            break;
    }
    
}

+ (UIColor *)tdd_btnHightlightBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x4A72E7];
        default:
            return [UIColor tdd_colorWithHex:0xe4e4e4];
            break;
    }
}

+ (UIColor *)tdd_btnNormalTitle {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor whiteColor];
    }
    return [UIColor tdd_colorDiagTheme];
}

+ (UIColor *)tdd_btnDisableTitle {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    }
    return [UIColor tdd_colorWithHex:0xE9E9E9];
}

+ (UIColor *)tdd_colorDiagProgressGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size
{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0xFFD100], [UIColor tdd_colorWithHex:0xF22222]]];
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0x28EFF5], [UIColor tdd_colorWithHex:0x8930FF]]];
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0x1093FF], [UIColor tdd_colorWithHex:0x00C5B9]]];
        default:
            return UIColor.tdd_colorDiagTheme;
    }
}

+ (UIColor *)tdd_systemScanBgGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size
{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0xFDECEC], UIColor.tdd_colorFFFFFF]];
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[[UIColor tdd_colorWithHex:0x4A72E7] colorWithAlphaComponent:0.6], [[UIColor tdd_colorWithHex:0x4A72E7] colorWithAlphaComponent:0.1]]];
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[[UIColor tdd_colorWithHex:0x1093FF] colorWithAlphaComponent:0.3], [[UIColor tdd_colorWithHex:0x1093FF] colorWithAlphaComponent:0.0]]];
        default:
            return [UIColor tdd_colorWithTDD_GradientStyle:gradientStyle withFrame:size andColors:@[[UIColor tdd_colorWithHex:0xFDECEC], UIColor.tdd_colorFFFFFF]];
    }
}

+ (UIColor *)tdd_colorDiagReportSummary {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return [UIColor tdd_colorWithHex:0xF8FBFF];
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorWithHex:0xFFF9F8];
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithHex:0xF8F8F8];
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x313845];
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
            
        default:
            return [UIColor tdd_colorWithHex:0xF8F8F8];
            break;
    }
}

+ (UIColor *)tdd_viewControllerBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithTDD_GradientStyle:TDD_GradientStyleUpleftToLowright withFrame:CGSizeMake(IphoneWidth, IphoneHeight) andColors:@[[UIColor tdd_colorWithHex:0x232F3D], [UIColor tdd_colorWithHex:0x000F20]]];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor blackColor];
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_colorDiagDashLine {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return [UIColor tdd_colorWithHex:0xC9E0FF];
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorWithHex:0xFF7B1C];
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithHex:0xC9E0FF];
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        default:
            return [UIColor tdd_colorWithHex:0xC9E0FF];
            break;
    }
}

+ (UIColor *)tdd_colorButtonBacgroundGradient:(CGSize)size
{
    switch(DiagShareManageColorType) {
        case TDD_DiagViewColorType_Red:
            return  [UIColor tdd_colorWithTDD_GradientStyle:TDD_GradientStyleLeftToRight withFrame:size andColors:@[UIColor.tdd_colorDiagTheme, [UIColor tdd_colorWithHex:0xD81515]]];
        default:
            return UIColor.tdd_colorDiagTheme;
    }
}

+ (UIColor *)tdd_colorDiagDTCFault {
    return UIColor.tdd_colorF5222D;
}

+ (UIColor *)tdd_colorDiagDTCNoFault {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Red:
            return UIColor.tdd_color2B79D8;
        default:
            return UIColor.tdd_colorDiagTheme;
    }
}

+ (UIColor *)tdd_colorDiagListSelectColor:(CGSize)size {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return UIColor.tdd_color29394F;
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithTDD_GradientStyle:TDD_GradientStyleTopToBottom withFrame:size andColors:@[[[UIColor tdd_colorWithHex:0x1093FF] colorWithAlphaComponent:0.2], [[UIColor tdd_colorWithHex:0x1093FF] colorWithAlphaComponent:0.5]]];
            break;
        default:
            return [UIColor tdd_colorWithTDD_GradientStyle:TDD_GradientStyleTopToBottom withFrame:size andColors:@[[UIColor tdd_colorWithHex:0xFFE2E2], [UIColor tdd_colorWithHex:0xFFD2D2]]];
            break;
    }
    
}


+ (UIColor *)tdd_systemBackgroundColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return UIColor.tdd_viewControllerBackground;
            break;
        default:
            return [UIColor tdd_line];
            break;
    }
}

+ (UIColor *)tdd_colorDiagHightLightColor:(CGSize)size {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1093FF];
            break;
        default:
            return [UIColor tdd_colorWithTDD_GradientStyle:TDD_GradientStyleTopToBottom withFrame:size andColors:@[[UIColor tdd_colorWithHex:0xFFE074], [UIColor tdd_colorWithHex:0xFFBF1A]]];
            break;
    }
    
}

+ (UIColor *)tdd_colorDiagTopTipsBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x132744];
            break;
        default:
            return [UIColor tdd_colorWithHex:0xE5F0FF];
            break;
    }
    
}

+ (UIColor *)tdd_colorDiagTopTipsTextColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor whiteColor];
            break;
        default:
            return [UIColor tdd_colorWithHex:0x215CB0];
            break;
    }
    
}

+ (UIColor *)tdd_colorDiagBottomTipsBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x53360A];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1b212a];
            break;
        default:
            return [UIColor tdd_colorWithHex:0xFFECD6];
            break;
    }
}

+ (UIColor *)tdd_colorDiagBottomTextColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0xD67012];
            break;
        default:
            return [UIColor tdd_liveDataUnitNormalColor];
            break;
    }
    
}

+ (UIColor *)tdd_fcaAreaBackGroundColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [[UIColor tdd_colorDiagTheme] colorWithAlphaComponent:0.1];
            break;
        default:
            return [UIColor tdd_colorWithHex:0xfcf7f7];
            break;
    }
}

+ (UIColor *)cardBg {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x424d59];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
        default:
            return UIColor.tdd_colorF5F5F5;
            break;
    }

}

+ (UIColor *)loadingViewBg {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x424d59];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
        default:
            return UIColor.tdd_colorFFFFFF;
            break;
    }

}

+ (UIColor *)tdd_progressBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor whiteColor];
    }
    return [UIColor tdd_colorWithHex:0xE9E9E9];
    
}

+ (UIColor *)tdd_dtcStatusNormalColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack) {
        return [UIColor whiteColor];
    }
    return [UIColor tdd_colorWithHex:0x2B79D8];
}

+ (UIColor *)tdd_pdfDtcStatusNormalColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor blackColor];
    }
    return [UIColor tdd_colorWithHex:0x2B79D8];
}

+ (UIColor *)tdd_pdfDtcNormalColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor blackColor];
    }
    return [UIColor tdd_title];
}

+ (UIColor *)tdd_shadowBackgroundColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.14];
            break;
        default:
            return [UIColor whiteColor];
    }
}

+ (UIColor *)tdd_progressTitleTextColor {
    
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Red:
            return [UIColor tdd_colorWithHex:0xA41919];
            break;
            
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_inputHistoryCellBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_color29394F];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
            break;
        default:
            return [UIColor whiteColor];
    }
}

+ (UIColor *)tdd_inputTextViewBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor.blackColor colorWithAlphaComponent:0.3];
    }
    return [UIColor whiteColor];
    
}

+ (UIColor *)tdd_keyboardViewBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x000F20];
    }
    return [UIColor tdd_colorWithHex:0xF3F3F3];
}

+ (UIColor *)tdd_keyboardItemDisableBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x424D59];
    }
    return [UIColor tdd_colorWithHex:0xE4E4E4];
    
}

+ (UIColor *)tdd_keyboardItemNormalBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x29394F];
    }
    return [UIColor tdd_colorWithHex:0xFCFCFE];
}

+ (UIColor *)tdd_keyboardItemHightlightBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x1B2737];
    }
    return [UIColor tdd_colorWithHex:0xFFFFFF];
}

+ (UIColor *)tdd_keyboardItemHightlightBorderColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor clearColor];
    }
    return [UIColor tdd_colorDiagTheme];
}

+ (UIColor *)tdd_keyboardItemNormalTitle {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_title];
    }
    return [UIColor tdd_colorDiagTheme];
}

+ (UIColor *)tdd_keyboardItemDisableTitle {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor.whiteColor colorWithAlphaComponent:0.3];
    }
    return [UIColor tdd_color999999];
}

+ (UIColor *)tdd_keyboardEnterBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B2737];
            break;
            
        default:
            return [UIColor tdd_colorDiagTheme];
            break;
    }
}

+ (UIColor *)tdd_keyboardDeleteBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B2737];
            break;
            
        default:
            return [UIColor whiteColor];
            break;
    }
    
}

+ (UIColor *)tdd_liveDataCellBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_color29394F];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
            break;
        case TDD_DiagViewColorType_Orange:
            return [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleTopToBottom withFrame:CGSizeZero];
            break;
            
        default:
            return [UIColor whiteColor];
            break;
    }
    
}

+ (UIColor *)tdd_liveDataSepLineColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x232f3d];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor blackColor];
            break;
            
        default:
            return [UIColor tdd_colorWithHex:0xFBFBFB];
            break;
    }
}

+ (UIColor *)tdd_liveDataValueNormalColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorDiagTheme];
    }
    return [UIColor tdd_color2B79D8];
}

+ (UIColor *)tdd_liveDataUnitNormalColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_title];
    }
    return [UIColor tdd_color666666];
    
}

+ (UIColor *)tdd_liveDataSegmentationBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x313845];
    }
    return [UIColor tdd_colorF5F5F5];
}

+ (UIColor *)tdd_liveDataRecordBackground {

    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x424D59];
    }
    return [UIColor tdd_colorWithHex:0x000000 alpha:0.6];
}

+ (UIColor *)tdd_liveDataScoreColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor whiteColor];
    }
    return [UIColor tdd_color666666];
}

+ (UIColor *)tdd_liveDataSetBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithTDD_GradientStyle:TDD_GradientStyleUpleftToLowright withFrame:CGSizeMake(IphoneWidth, IphoneHeight) andColors:@[[UIColor tdd_colorWithHex:0x232F3D], [UIColor tdd_colorWithHex:0x000F20]]];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor blackColor];
        default:
            return [UIColor tdd_colorWithHex:0xf8f8f8];
            break;
    }
}

+ (UIColor *)tdd_liveDataSetRangeColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x00F4E6];
            break;
            
        default:
            return [UIColor tdd_colorWithHex:0x215CB0];
            break;
    }
    
}

+ (UIColor *)tdd_liveDataSetRangeBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0xFFFFFF alpha:0.1];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x191919];
            break;
        default:
            return [UIColor tdd_ColorEEEEEE];
            break;
    }
    
}

+ (UIColor *)tdd_liveDataLegendColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor whiteColor];
            break;
        default:
            return [UIColor tdd_color999999];
    }
}

+ (UIColor *)tdd_menuCellBackground:(CGSize )size {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x29394F];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
        default:
            return [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleTopToBottom withFrame:size];
            break;
    }
    
}

+ (UIColor *)tdd_menuCellHightlightBackground:(CGSize )size {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [[UIColor tdd_colorWithHex:0x29394F] colorWithAlphaComponent:0.5];
            break;
        case TDD_DiagViewColorType_Black:
            return [[UIColor tdd_colorWithHex:0x1B212A] colorWithAlphaComponent:0.5];
        default:
            return [UIColor tdd_colorWithHex:0xF8F0EF];
            break;
    }
}

+ (UIColor *)tdd_popupBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_viewControllerBackground];
    }
    return [UIColor tdd_colorF5F5F5];
    
}

+ (UIColor *)tdd_reportInputNormalCellBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x39465B];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor blackColor];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_reportCodeSectionTextColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor blackColor];
    }
    return [UIColor tdd_color666666];
}

+ (UIColor *)tdd_reportCodeSectionBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black || DiagShareManageColorType == TDD_DiagViewColorType_Red) {
        return [UIColor whiteColor];
    }
    return [UIColor tdd_colorF5F5F5];
    
}

+ (UIColor *)tdd_reportCodeTitleTextColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorDiagTheme];
    }
    return [UIColor tdd_color215CB0];
}

+ (UIColor *)tdd_reportInfoValueTextColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor blackColor];
    }
    return [UIColor tdd_color777777];
}

+ (UIColor *)tdd_reportRepairHeadTextColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor blackColor];
    }
    return [UIColor whiteColor];
}

+ (UIColor *)tdd_reportRepairSectionPDFLineColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor blackColor];
    }
    return [UIColor tdd_ColorEEEEEE];
}

+ (UIColor *)tdd_reportSummaryDashLineColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0xC9E0FF];
    }
    return [UIColor tdd_colorDiagDashLine];
}

+ (UIColor *)tdd_reportSummaryPDFBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0xF8F8F8];
    }
    return [UIColor tdd_colorDiagReportSummary];
}

+ (UIColor *)tdd_reportSummaryBottomLineColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0xC9E0FF];
    }
    return [UIColor tdd_colorWithHex:0xffffff alpha:0.2];
}

+ (UIColor *)tdd_reportSummaryTipsColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x666666];
    }
    return [UIColor tdd_colorWithHex:0x999999];
}

+ (UIColor *)tdd_reportMilesSelectBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x424D59];
            break;
        default:
            return [UIColor tdd_cellBackground];
            break;
    }
}

+ (UIColor *)tdd_reportMilesNormalBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x39465B];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x202124];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_reportHeadCellBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return UIColor.tdd_color29394F;
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor blackColor];
            break;
        case TDD_DiagViewColorType_Red:
            return [UIColor whiteColor];
            break;
        default:
            return UIColor.tdd_colorF5F5F5;
            break;
    }
}

+ (UIColor *)tdd_reportDisclaimTextColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack) {
        return UIColor.whiteColor;
    } else if (DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0xFFFFFF alpha:0.5];
    }
    return UIColor.tdd_color333333;
}

+ (UIColor *)tdd_reportPDFBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor whiteColor];
            break;
            
        default:
            return [UIColor tdd_reportBackground];
            break;
    }
}

+ (UIColor *)tdd_reportBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x232F3D];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor blackColor];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_systemCellBackground:(CGSize )size {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor clearColor];
    }
    return [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleTopToBottom withFrame:size];
}

+ (UIColor *)tdd_systemLineColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor clearColor];
    }
    return [UIColor tdd_colorWithHex:0xEBEBEB];
}

+ (UIColor *)tdd_troubleShowStateBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x323C46];
    }
    return [UIColor whiteColor];
}

+ (UIColor *)tdd_troubleBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_viewControllerBackground];
    }
    return [UIColor tdd_colorWithHex:0xF5F5F5];
}

+ (UIColor *)tdd_listBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_viewControllerBackground];
    }
    return [UIColor tdd_colorWithHex:0xDDDDDD];
}

+ (UIColor *)tdd_loadingViewFirstBallColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x0164E6];
            break;
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x00F4E6];
        default:
            return [UIColor tdd_ColorFF8100];
            break;
    }
    
}

+ (UIColor *)tdd_loadingViewSecondBallColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x00D1FF];
            break;
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x1093FF];
        default:
            return [UIColor tdd_colorWithHex:0xF22222];
            break;
    }
    
}

+ (UIColor *)tdd_webLinkColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_mainColor];
            break;
        default:
            return [UIColor tdd_colorWithHex:0x3A82E9];
            break;
    }
}

+ (UIColor *)tdd_cellHeadBackground {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorWithHex:0x232F3D];
    }
    return [UIColor tdd_ColorEEEEEE];
}

+ (UIColor *)tdd_background
{
    return UIColor.tdd_colorFFFFFF;
}

+ (UIColor *)tdd_cellBackground {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return UIColor.tdd_color29394F;
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
            break;
        default:
            return UIColor.tdd_colorF5F5F5;
            break;
    }
}

+ (UIColor *)tdd_tableViewBG
{
    return [UIColor tdd_colorWithHex:0xFBFBFB];
}

+ (UIColor *)tdd_colorDiagTableViewGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor tdd_colorDiagNormalGradient:gradientStyle withFrame:size];
    }
    return UIColor.tdd_colorF5F5F5;
}

+ (UIColor *)tdd_title
{
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return UIColor.whiteColor;
    }
    return UIColor.tdd_color333333;
}

+ (UIColor *)tdd_titleDisable
{
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return UIColor.whiteColor;
    }
    return [UIColor tdd_colorWithHex:0xBBBBBB];;
}

+ (UIColor *)tdd_alertBg {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorWithHex:0x424d59];
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1B212A];
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_alertConfirmBg {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_colorDiagTheme];
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_btnBackground];
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)tdd_alertConfirmTextColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x1093FF];
        default:
            return [UIColor tdd_keyboardItemNormalTitle];
            break;
    }
}

+ (UIColor *)tdd_alertCancelBg {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor tdd_line];
        case TDD_DiagViewColorType_Black:
            return [UIColor clearColor];
        default:
            return [UIColor whiteColor];
    }
}

+ (UIColor *)tdd_alertLineColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [[UIColor tdd_ColorEEEEEE] colorWithAlphaComponent:0.2];
        default:
            return [UIColor tdd_colorF5F5F5];
    }
}

+ (UIColor *)tdd_textFieldBg {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x424D59];
        default:
            return [UIColor tdd_colorF5F5F5];
    }
}

+ (UIColor *)tdd_textFieldClearColor {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0x484848];
        default:
            return [UIColor tdd_colorWithHex:0xAAAAAA];
    }
}

+ (UIColor *)tdd_subTitle
{
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor.whiteColor colorWithAlphaComponent:0.8];
    }
    return UIColor.tdd_color999999;
}

+ (UIColor *)tdd_titleLock {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor.whiteColor colorWithAlphaComponent:0.6];
    }
    return [UIColor tdd_colorWithHex:0xc4c4c4];
}

+ (UIColor *)placeholderTextColor {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor.whiteColor colorWithAlphaComponent:0.5];
    }
    return UIColor.tdd_color999999;
}

+ (UIColor *)tdd_blue
{
    return UIColor.tdd_color215CB0;
}

+ (UIColor *)tdd_errorRed
{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Red:
            return  [UIColor tdd_colorWithHex:0xF22222];
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [UIColor tdd_colorWithHex:0xFF565F];
        default:
            return UIColor.redColor;
    }
}

// 固定配色
+ (UIColor *)tdd_mainColor
{
    return [UIColor tdd_colorWithHex:0x2B79D8];
}

+ (UIColor *)tdd_colorF5F5F5
{
    return [UIColor tdd_colorWithHex:0xF5F5F5];
}

+ (UIColor *)tdd_collectionViewBG {
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return UIColor.clearColor;
    }
    return UIColor.tdd_colorF5F5F5;
}



+ (UIColor *)tdd_color000000
{
    return [UIColor tdd_colorWithHex:0x000000];
}

+ (UIColor *)tdd_color333333
{
    return [UIColor tdd_colorWithHex:0x333333];
}

+ (UIColor *)tdd_color666666
{
    if (DiagShareManageColorType == TDD_DiagViewColorType_GradientBlack || DiagShareManageColorType == TDD_DiagViewColorType_Black) {
        return [UIColor.tdd_title colorWithAlphaComponent:0.6];
    }
    return [UIColor tdd_colorWithHex:0x666666];
}

+ (UIColor *)tdd_color777777 {
    return [UIColor tdd_colorWithHex:0x777777];
}

+ (UIColor *)tdd_color999999 {
    return [UIColor tdd_colorWithHex:0x999999];
}

+ (UIColor *)tdd_colorCCCCCC
{
    return [UIColor tdd_colorWithHex:0xCCCCCC];
}

+ (UIColor *)tdd_colorF5222D
{
    return [UIColor tdd_colorWithHex:0xF5222D];
}

+ (UIColor *)tdd_colorF2F8FD
{
    return [UIColor tdd_colorWithHex:0xF2F8FD];
}

+ (UIColor *)tdd_colorFFFFFF
{
    return [UIColor tdd_colorWithHex:0xFFFFFF];
}

+ (UIColor *)tdd_color29394F
{
    return [UIColor tdd_colorWithHex:0x29394F];
}

+ (UIColor *)tdd_colorFF0000
{
    return [UIColor tdd_colorWithHex:0xFF0000];
}

+ (UIColor *)tdd_color2B79D8
{
    return [UIColor tdd_colorWithHex:0x2B79D8];
}

+ (UIColor *)tdd_color479AFF
{
    return [UIColor tdd_colorWithHex:0x479AFF];
}

+ (UIColor *)tdd_color2B79D805
{
    return [UIColor tdd_colorWithHex:0x2B79D8 alpha:0.2];
}

+ (UIColor *)tdd_colorF3F3F3
{
    return [UIColor tdd_colorWithHex:0xF3F3F3];
}

+ (UIColor *)tdd_color3A85E0
{
    return [UIColor tdd_colorWithHex:0x3A85E0];
}

+ (UIColor *)tdd_color6E9DD5
{
    return [UIColor tdd_colorWithHex:0x6E9DD5];
}

+ (UIColor *)tdd_colorEDEDED
{
    return [UIColor tdd_colorWithHex:0xEDEDED];
}

+ (UIColor *)tdd_colorF8F0EF
{
    return [UIColor tdd_colorWithHex:0xF8F0EF];
}

+ (UIColor *)tdd_color215CB0
{
    return [UIColor tdd_colorWithHex:0x215CB0];
}

+ (UIColor *)tdd_ColorEEEEEE
{
    return [UIColor tdd_colorWithHex:0xEEEEEE];
}

+ (UIColor *)tdd_line
{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor.whiteColor colorWithAlphaComponent:0.2];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor.tdd_ColorEEEEEE colorWithAlphaComponent:0.2];
            break;
            
        default:
            return UIColor.tdd_ColorEEEEEE;
            break;
    }
}

+ (UIColor *)tdd_borderColor
{
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return [UIColor.whiteColor colorWithAlphaComponent:0.2];
            break;
        case TDD_DiagViewColorType_Black:
            return [UIColor.tdd_ColorEEEEEE colorWithAlphaComponent:0.2];
            break;
            
        default:
            return UIColor.tdd_colorCCCCCC;
            break;
    }
}

+ (UIColor *)tdd_ColorFF8100
{
    return [UIColor tdd_colorWithHex:0xFF8100];
}

+ (UIColor *)tdd_ColorF6F6F6
{
    return [UIColor tdd_colorWithHex:0xF6F6F6];
}

+ (UIColor *)tdd_ColorDEE3E6
{
    return [UIColor tdd_colorWithHex:0xDEE3E6];
}
@end
