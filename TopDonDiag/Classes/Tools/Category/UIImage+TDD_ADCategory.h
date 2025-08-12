//
//  UIImage+TDD_ADCategory.h
//  AD200
//
//  Created by yong liu on 2022/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//渐变风格
typedef enum {
    TDD_GradientStyleTopToBottom = 0,  //竖直渐变
    TDD_GradientStyleLeftToRight,      //水平渐变
    TDD_GradientStyleUpleftToLowright, //左上到右下
    TDD_GradientStyleUprightToLowleft, //右上到左下
} TDD_GradientStyle;

@interface UIImage (TDD_ADCategory)


#pragma mark - 颜色渐变
+ (UIImage *)tdd_imageWithColors:(NSArray <UIColor *>*)colors size:(CGSize)size gradientStyle:(TDD_GradientStyle)gradientStyle;
/// 通过颜色创建图片 修改图片颜色 （背景为透明通道）
- (UIImage *)tdd_imageByTintColor:(UIColor *)color;

#pragma mark - 动态配图
+ (UIImage *)tdd_imageDiagReportHeader;

+ (UIImage *)tdd_imageDiagReportInfo;

+ (UIImage *)tdd_imageDiagVCIConnect;

+ (UIImage *)tdd_imageDiagVCIUnConnect;

+ (UIImage *)tdd_imageDiagNavFeedBack;

+ (UIImage *)tdd_imageDiagNavMore;

+ (UIImage *)tdd_imageDiagNavTranslate;

+ (UIImage *)tdd_imageDiagNavTranslateFinish;

+ (UIImage *)tdd_imageDiagNavSearch;

+ (UIImage *)tdd_imageDiagNavMoreBG;

+ (UIImage *)tdd_imageDiagReportPageFooter;

+ (UIImage *)tdd_imageDiagReportPageHeader;
//选择框
+ (UIImage *)tdd_imageCheckDidSelect;

+ (UIImage *)tdd_imageSingleCheckUnSelect;

+ (UIImage *)tdd_imageSingleCheckDidSelect;

+ (UIImage *)tdd_imageAlertCheckboxNormal;

+ (UIImage *)tdd_imageAlertCheckboxSelect;

+ (UIImage *)tdd_imageLiveDataSetNumLegend;

+ (UIImage *)tdd_imageLiveDataSetNumChartLegend;

+ (UIImage *)tdd_imageLiveDataSetDialLegend;

+ (UIImage *)tdd_imageDiagLiveDataSetSelectText;

+ (UIImage *)tdd_imageDiagLiveDataSetSelectChart;

+ (UIImage *)tdd_imageDiagLiveDataSetSelectDial;

+ (UIImage *)tdd_imageDiagLiveDataSetSelectTextHL;

+ (UIImage *)tdd_imageDiagLiveDataSetSelectChartHL;

+ (UIImage *)tdd_imageDiagLiveDataSetSelectDialHL;

+ (UIImage *)tdd_imageDiagLiveDataMore;

+ (UIImage *)tdd_imageDiagKeyboardHightlightBG;

+ (UIImage *)tdd_imageDiagNumKeyboardHightlightBG;

+ (UIImage *)tdd_imageDiagKeyboardDelete;

+ (UIImage *)tdd_imageDiagUpArrow;

+ (UIImage *)tdd_imageDiagDownArrow;

+ (UIImage *)tdd_imageDiagBottomTipIcon;
+ (UIImage *)tdd_imageDiagBottomNoteIcon;
+ (UIImage *)tdd_imageDiagBottomCloseIcon;

+ (UIImage *)tdd_imageDiagHelpUnableIcon;

+ (UIImage *)tdd_imageDiagFileDictIcon;

+ (UIImage *)tdd_imageDiagCellSelect;

+ (UIImage *)tdd_imageDiagCellSelectNO;

+ (UIImage *)tdd_imageDiagAIIcon;

+ (UIImage *)tdd_imageDiagAIDisableIcon;

+ (UIImage *)tdd_imageDiagGuildAIIcon;

+ (UIImage *)tdd_imageDiagBtnLockIcon;

/// 网关
+ (UIImage *)tdd_imageDiageGateWayToBuyImage;
+ (UIImage *)tdd_imageDiageGateWayToBuyArrow;
+ (UIImage *)tdd_imageDiageGateWayChangeAccount;
+ (UIImage *)tdd_imageDiageGateWayRefresh;
+ (UIImage *)tdd_imageDiagGateWayFCATopDonLogo;
+ (UIImage *)tdd_imageDiagGateWayRenualtLogo;
+ (UIImage *)tdd_imageDiagGateWayNissanLogo;
+ (UIImage *)tdd_imageDiagGateWayVWSFDLogo;
+ (UIImage *)tdd_imageDiagGateWayDEMOLogo;
+ (UIImage *)tdd_imageDiagGateWaySwitchBG;

/// SFD
+ (UIImage *)tdd_imageSFDSharePopBG;
+ (UIImage *)tdd_imageSFDQrIcon;
+ (UIImage *)tdd_imageSFDEmailIcon;
/// 右上角 app logo
+ (nullable UIImage *)tdd_imageDiagReportHeaderLogo;

/// 全屏水印
+ (nullable UIImage *)tdd_imageDiagReportPageWatermark;

+ (UIImage *)tdd_imageWithColor:(UIColor *)color rect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
