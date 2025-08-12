//
//  UIColor+TDD_ADCategory.h
//  AD200
//
//  Created by yong liu on 2022/7/13.
//

#import <UIKit/UIKit.h>
#import "UIImage+TDD_ADCategory.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIColor (TDD_ADCategory)

+ (UIColor *)tdd_colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)tdd_colorWithHex:(int)hexValue;

/**
 * 渐变色
 */
+ (UIColor *)tdd_colorWithTDD_GradientStyle:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size andColors:(NSArray *)colors;

#pragma mark - 动态配色
//主题色
+ (UIColor *)tdd_colorDiagTheme;

+ (UIColor *)tdd_title;

+ (UIColor *)tdd_titleDisable;

+ (UIColor *)tdd_subTitle;

+ (UIColor *)tdd_titleLock;

+ (UIColor *)tdd_errorRed;

+ (UIColor *)tdd_background;

+ (UIColor *)tdd_cellBackground;

+ (UIColor *)tdd_tableViewBG;

+ (UIColor *)tdd_color29394F;

+ (UIColor *)tdd_collectionViewBG;

+ (UIColor *)tdd_line;

+ (UIColor *)tdd_borderColor;

+ (UIColor *)tdd_alertBg;

+ (UIColor *)tdd_alertConfirmBg;

+ (UIColor *)tdd_alertConfirmTextColor;

+ (UIColor *)tdd_alertCancelBg;

+ (UIColor *)tdd_alertLineColor;

+ (UIColor *)tdd_textFieldBg;

+ (UIColor *)tdd_textFieldClearColor;

+ (UIColor *)tdd_btnBackground;

+ (UIColor *)tdd_btnNormalBackground;

+ (UIColor *)tdd_btnDisableBackground;

+ (UIColor *)tdd_btnHightlightBackground;

+ (UIColor *)tdd_btnNormalTitle;

+ (UIColor *)tdd_btnDisableTitle;

+ (UIColor *)placeholderTextColor;

+ (UIColor *)tdd_reportBackground;

+ (UIColor *)tdd_reportPDFBackground;

+ (UIColor *)tdd_cellHeadBackground;

+ (UIColor *)cardBg;

+ (UIColor *)loadingViewBg;

+ (UIColor *)tdd_progressBackground;

+ (UIColor *)tdd_dtcStatusNormalColor;

+ (UIColor *)tdd_pdfDtcStatusNormalColor;

+ (UIColor *)tdd_pdfDtcNormalColor;

+ (UIColor *)tdd_shadowBackgroundColor;
// artiMsg
+ (UIColor *)tdd_progressTitleTextColor;

// artiInput
+ (UIColor *)tdd_inputHistoryCellBackground;

+ (UIColor *)tdd_inputTextViewBackground;

+ (UIColor *)tdd_keyboardViewBackground;

+ (UIColor *)tdd_keyboardItemDisableBackground;

+ (UIColor *)tdd_keyboardItemNormalBackground;

+ (UIColor *)tdd_keyboardItemHightlightBackground;

+ (UIColor *)tdd_keyboardItemHightlightBorderColor;

+ (UIColor *)tdd_keyboardItemNormalTitle;

+ (UIColor *)tdd_keyboardItemDisableTitle;

+ (UIColor *)tdd_keyboardEnterBackground;

+ (UIColor *)tdd_keyboardDeleteBackground;

// artiLiveData
+ (UIColor *)tdd_liveDataCellBackground;

+ (UIColor *)tdd_liveDataSepLineColor;

+ (UIColor *)tdd_liveDataValueNormalColor;

+ (UIColor *)tdd_liveDataUnitNormalColor;

+ (UIColor *)tdd_liveDataSegmentationBackground;

+ (UIColor *)tdd_liveDataRecordBackground;

+ (UIColor *)tdd_liveDataScoreColor;

+ (UIColor *)tdd_liveDataSetBackground;

+ (UIColor *)tdd_liveDataSetRangeColor;

+ (UIColor *)tdd_liveDataSetRangeBackground;

+ (UIColor *)tdd_liveDataLegendColor;

// artiMenu
+ (UIColor *)tdd_menuCellBackground:(CGSize )size;
+ (UIColor *)tdd_menuCellHightlightBackground:(CGSize )size;

// artiPopup
+ (UIColor *)tdd_popupBackground;

// artiReport
+ (UIColor *)tdd_reportInputNormalCellBackground;
+ (UIColor *)tdd_reportCodeSectionTextColor;
+ (UIColor *)tdd_reportCodeSectionBackground;
+ (UIColor *)tdd_reportCodeTitleTextColor;
+ (UIColor *)tdd_reportInfoValueTextColor;
+ (UIColor *)tdd_reportRepairHeadTextColor;
+ (UIColor *)tdd_reportRepairSectionPDFLineColor;
+ (UIColor *)tdd_reportSummaryDashLineColor;
+ (UIColor *)tdd_reportSummaryPDFBackground;
+ (UIColor *)tdd_reportSummaryBottomLineColor;
+ (UIColor *)tdd_reportSummaryTipsColor;
+ (UIColor *)tdd_reportMilesSelectBackground;
+ (UIColor *)tdd_reportMilesNormalBackground;
+ (UIColor *)tdd_reportHeadCellBackground;
+ (UIColor *)tdd_reportDisclaimTextColor;

//artiSystem
+ (UIColor *)tdd_systemCellBackground:(CGSize )size;
+ (UIColor *)tdd_systemLineColor;

//artiTrouble
+ (UIColor *)tdd_troubleShowStateBackground;
+ (UIColor *)tdd_troubleBackground;

//artiList
+ (UIColor *)tdd_listBackground;

/// active
//高亮色
+ (UIColor *)tdd_colorDiagHightLightColor:(CGSize)size;
+ (UIColor *)tdd_colorDiagTopTipsBackground;
+ (UIColor *)tdd_colorDiagTopTipsTextColor;
+ (UIColor *)tdd_colorDiagBottomTipsBackground;
+ (UIColor *)tdd_colorDiagBottomTextColor;

/// FCA
+ (UIColor *)tdd_fcaAreaBackGroundColor;


//loadingView
+ (UIColor *)tdd_loadingViewFirstBallColor;
+ (UIColor *)tdd_loadingViewSecondBallColor;

+ (UIColor *)tdd_webLinkColor;

/// 215CB0
+ (UIColor *)tdd_blue;

+ (UIColor *)tdd_colorDiagTableViewGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;

+ (UIColor *)tdd_mainBackgroundGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;

+ (UIColor *)tdd_viewControllerBackground;

//主题色渐变
//高亮渐变
+ (UIColor *)tdd_colorDiagThemeGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;
//normal渐变
+ (UIColor *)tdd_colorDiagNormalGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;
//底部渐变
+ (UIColor *)tdd_colorDiagBottomGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;
/// 进车进度条 渐变色
+ (UIColor *)tdd_colorDiagProgressGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;
/// 系统扫描 渐变色 
+ (UIColor *)tdd_systemScanBgGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size;

/// 按钮红色背景渐变色 
+ (UIColor *)tdd_colorButtonBacgroundGradient:(CGSize)size;
//报告配色
+ (UIColor *)tdd_colorDiagReportSummary;

+ (UIColor *)tdd_colorDiagDashLine;

/// 报告故障码 颜色  红色
+ (UIColor *)tdd_colorDiagDTCFault;

/// 报告无故障码 颜色 蓝色
+ (UIColor *)tdd_colorDiagDTCNoFault;

/// list 选中高亮色
+ (UIColor *)tdd_colorDiagListSelectColor:(CGSize)size;
 
+ (UIColor *)tdd_systemBackgroundColor;




#pragma mark - 固定配色
+ (UIColor *)tdd_mainColor;
+ (UIColor *)tdd_colorF5F5F5;
+ (UIColor *)tdd_color000000;
+ (UIColor *)tdd_color333333;
+ (UIColor *)tdd_color666666;
+ (UIColor *)tdd_color777777;
+ (UIColor *)tdd_color999999;
+ (UIColor *)tdd_colorCCCCCC;
+ (UIColor *)tdd_colorFF0000;
+ (UIColor *)tdd_colorF5222D;
+ (UIColor *)tdd_colorF2F8FD;
+ (UIColor *)tdd_colorFFFFFF;
+ (UIColor *)tdd_color2B79D8;
+ (UIColor *)tdd_color479AFF;
+ (UIColor *)tdd_colorF3F3F3;
+ (UIColor *)tdd_color3A85E0;
+ (UIColor *)tdd_color6E9DD5;
+ (UIColor *)tdd_colorEDEDED;
+ (UIColor *)tdd_colorF8F0EF;
/// 数据流普通状态蓝色
+ (UIColor *)tdd_color215CB0;
+ (UIColor *)tdd_ColorEEEEEE;
/// loading黄色
+ (UIColor *)tdd_ColorFF8100;
/// 灰色背景色
+ (UIColor *)tdd_ColorF6F6F6;
///分割线
+ (UIColor *)tdd_ColorDEE3E6;
@end

NS_ASSUME_NONNULL_END
