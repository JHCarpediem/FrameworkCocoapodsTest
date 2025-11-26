//
//  UIImage+TDD_ADCategory.m
//  AD200
//
//  Created by yong liu on 2022/7/13.
//

#import "UIImage+TDD_ADCategory.h"
#import <Diagnosis/Diagnosis-Swift.h>
@import TDUIProvider;
@implementation UIImage (TDD_ADCategory)


#pragma mark - 颜色渐变
+ (UIImage *)tdd_imageWithColors:(NSArray <UIColor *>*)colors size:(CGSize)size gradientStyle:(TDD_GradientStyle)gradientStyle
{
    NSMutableArray *colorMarray = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors)
    {
        [colorMarray addObject:(id)color.CGColor];
    }
    if (size.width <= 0 || size.height <= 0){
        return UIImage.new;
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorMarray, NULL);
    
    //左右渐变
    CGPoint startPoint = CGPointMake(0.0f, 0.0f);
    if (gradientStyle == 3)
    {
        startPoint = CGPointMake(0.0f, size.height);
    }
    CGPoint endPoint = CGPointZero;
    switch (gradientStyle)
    {
        case TDD_GradientStyleTopToBottom:
            endPoint = CGPointMake(0.0f, size.height);
            break;
            
        case TDD_GradientStyleLeftToRight:
            endPoint = CGPointMake(size.width, 0.0f);
            break;
            
        case TDD_GradientStyleUpleftToLowright:
            endPoint = CGPointMake(size.width, size.height);
            break;
            
        case TDD_GradientStyleUprightToLowleft:
            endPoint = CGPointMake(size.width, 0.0f);
            break;
            
        default:
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 动态配图
+ (UIImage *)tdd_imageDiagReportHeader {
    return [[UIImage tdd_diagReportHeader] tdd_imageByTintColor:UIColor.tdd_colorDiagTheme];
}

+ (UIImage *)tdd_imageDiagReportPageFooter {
    return [UIImage tdd_diagReportPageFooter];
}

+ (UIImage *)tdd_imageDiagReportPageHeader {
    return [UIImage tdd_diagReportPageHeader];
}

+ (UIImage *)tdd_imageLiveDataSetNumLegend {
    return [UIImage tdd_liveDataSetNumLegend];
}

+ (UIImage *)tdd_imageLiveDataSetNumChartLegend {
    return [UIImage tdd_liveDataSetNumChartLegend];
}

+ (UIImage *)tdd_imageLiveDataSetDialLegend {
    return [UIImage tdd_liveDataSetDialLegend];
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectText {
    return [UIImage tdd_diagLiveDataSetSelectText];
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectChart {
    return [UIImage tdd_diagLiveDataSetSelectChart];
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectDial {
    return [UIImage tdd_diagLiveDataSetSelectDial];
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectTextHL {
    return [UIImage tdd_diagLiveDataSetSelectTextHL];
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectChartHL {
    return [UIImage tdd_diagLiveDataSetSelectChartHL];
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectDialHL {
    return [UIImage tdd_diagLiveDataSetSelectDialHL];
}

+ (UIImage *)tdd_imageDiagLiveDataMore {
    return [UIImage tdd_diagLiveDataMore];
}

+ (UIImage *)tdd_imageCheckboxSquareSelected {
    return [UIImage tdd_checkboxSquareSelected];
}

+ (UIImage *)tdd_imageCheckboxRoundNormal {
    return [UIImage tdd_checkboxRoundNormal];
}

+ (UIImage *)tdd_imageCheckboxRoundSelect {
    return [UIImage tdd_checkboxRoundSelect];
}

+ (UIImage *)tdd_imageDiagReportInfo {
    return [UIImage tdd_diagReportInfo];
}

+ (UIImage *)tdd_imageDiagKeyboardHightlightBG {
    return [UIImage tdd_diagKeyboardHightlightBG];
}

+ (UIImage *)tdd_imageDiagKeyboardDelete {
    return [UIImage tdd_diagKeyboardDelete];
}

+ (UIImage *)tdd_imageDiagUpArrow {
    return [UIImage tdd_diagUpArrow];
}

+ (UIImage *)tdd_imageDiagDownArrow {
    return [UIImage tdd_diagDownArrow];
}

+ (UIImage *)tdd_imageDiagBottomTipIcon {
    return [UIImage tdd_diagBottomTipIcon];
}

+ (UIImage *)tdd_imageDiagBottomNoteIcon {
    return [UIImage tdd_diagBottomNoteIcon];
}

+ (UIImage *)tdd_imageDiagBottomCloseIcon {
    return [UIImage tdd_diagBottomCloseIcon];
}

+ (UIImage *)tdd_imageDiagHelpUnableIcon {
    return [UIImage tdd_diagHelpUnableIcon];
}

+ (UIImage *)tdd_imageDiagAuthAreaArrow {
    return kImageNamed(@"artiInput_down");
}
+ (UIImage *)tdd_imageDiagFileDictIcon {
    return [UIImage tdd_diagFileDictIcon];
}

+ (UIImage *)tdd_imageCheckboxSquareNormal {
    return [UIImage tdd_checkboxSquareNormal];
}

+ (UIImage *)tdd_imageCheckboxSquareUnselectDisabled {
    return [UIImage tdd_checkboxSquareUnselectDisabled];
}

+ (UIImage *)tdd_imageDiagAIIcon {
    return [UIImage tdd_diagAIIcon];
}

+ (UIImage *)tdd_imageDiagAuthAreaArrowDisable {
    return [TDD_UIProvider imageWith:@"artiInput_down_disable"];
}
+ (UIImage *)tdd_imageDiagAIDisableIcon {
    return [UIImage tdd_diagAIDisableIcon];
}

+ (UIImage *)tdd_imageDiagGuildAIIcon {
    return [UIImage tdd_diagGuildAIIcon];
}

+ (UIImage *)tdd_imageDiagGuildAIArrow {
    return [TDD_UIProvider imageWith:@"icon_diag_arrow"];
}

+ (UIImage *)tdd_imageDiagBtnLockIcon {
    return [UIImage tdd_diagBtnLockIcon];
}

/// 网关
+ (UIImage *)tdd_imageDiageGateWayToBuyImage {
    return [UIImage tdd_diageGateWayToBuyImage];
}

+ (UIImage *)tdd_imageDiageGateWayToBuyArrow {
    return [UIImage tdd_diageGateWayToBuyArrow];
}

+ (UIImage *)tdd_imageDiageGateWayChangeAccount {
    return [UIImage tdd_diageGateWayChangeAccount];
}

+ (UIImage *)tdd_imageDiageGateWayRefresh {
    return [UIImage tdd_diageGateWayRefresh];
}

+ (UIImage *)tdd_imageDiagGateWayFCAdiagLogo {
    return [UIImage tdd_diagGateWayFCAdiagLogo];
}
+ (UIImage *)tdd_imageDiagGateWayRenualtLogo {
    return [UIImage tdd_diagGateWayRenualtLogo];
}
+ (UIImage *)tdd_imageDiagGateWayNissanLogo {
    return [UIImage tdd_diagGateWayNissanLogo];
}
+ (UIImage *)tdd_imageDiagGateWayVWSFDLogo {
    return [UIImage tdd_diagGateWayVWSFDLogo];
}
+ (UIImage *)tdd_imageDiagGateWayDEMOLogo {
    return [UIImage tdd_diagGateWayDEMOLogo];
}

+ (UIImage *)tdd_imageDiagGateWaySwitchBG {
    return [UIImage tdd_diagGateWaySwitchBG];
}

+ (UIImage *)tdd_imageSFDSharePopBG {
    return [UIImage tdd_SFDSharePopBG];
}

+ (UIImage *)tdd_imageSFDQrIcon {
    return [UIImage tdd_SFDQrIcon];
}

+ (UIImage *)tdd_imageSFDEmailIcon {
    return [UIImage tdd_SFDEmailIcon];
}

+ (UIImage *)tdd_imageDiagVCIConnect {
    return [UIImage tdd_diagVCIConnect];
}

+ (UIImage *)tdd_imageDiagVCIUnConnect {
    return [UIImage tdd_diagVCIUnConnect];
}

+ (UIImage *)tdd_imageDiagNavFeedBack {
    return [UIImage tdd_diagNavFeedBack];
}

+ (UIImage *)tdd_imageDiagNavMore {
    return [UIImage tdd_diagNavMore];
}

+ (UIImage *)tdd_imageDiagNavTranslate {
    return [UIImage tdd_diagNavTranslate];
}

+ (UIImage *)tdd_imageDiagNavTranslateFinish {
    return [UIImage tdd_diagNavTranslateFinish];
}

+ (UIImage *)tdd_imageDiagNavSearch {
    return [UIImage tdd_diagNavSearch];
}

+ (UIImage *)tdd_imageDiagNavMoreBG {
    return [UIImage tdd_diagNavMoreBG];
}

+ (nullable UIImage *)tdd_imageDiagReportHeaderLogo {
    return [UIImage tdd_diagReportHeaderLogo];
}

+ (nullable UIImage *)tdd_imageDiagReportPageWatermark {
    return [UIImage tdd_diagReportPageWatermark];
}


- (UIImage *)tdd_imageByTintColor:(UIColor *)color {
    if (self.size.width <= 0 || self.size.height <= 0){
        return UIImage.new;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color set];
    UIRectFill(rect);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


// 返回一张纯色图片
+ (UIImage *)tdd_imageWithColor:(UIColor *)color rect:(CGRect)rect {
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
