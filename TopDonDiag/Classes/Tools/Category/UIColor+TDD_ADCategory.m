//
//  UIColor+TDD_ADCategory.m
//  AD200
//
//  Created by yong liu on 2022/7/13.
//

#import "UIColor+TDD_ADCategory.h"
#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>
@import TDUIProvider;

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
    return UIColor.td_theme;
}


//报告配色
+ (UIColor *)tdd_colorDiagBottomGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size {
    return UIColor.tdd_BottomView_background;
}

+ (UIColor *)tdd_btnBackground {
    return UIColor.tdd_General_buttonBackground;
}

+ (UIColor *)tdd_btnNormalBackground {
    return UIColor.tdd_BottomView_buttonNormalBackground;
}

+ (UIColor *)tdd_btnDisableBackground {
    return UIColor.tdd_BottomView_buttonDisableBackground;
    
}

+ (UIColor *)tdd_btnHightlightBackground {
    return UIColor.tdd_BottomView_buttonHighlightBackground;
}

+ (UIColor *)tdd_btnNormalTitle {
    return UIColor.tdd_BottomView_buttonNormalText;
}

+ (UIColor *)tdd_btnDisableTitle {
    return UIColor.tdd_BottomView_buttonDisableText;
}

+ (UIColor *)tdd_colorDiagProgressGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size
{
    return [UIColor tdd_MsgProgress_progressTintWithSize:size];
}

+ (UIColor *)tdd_systemScanBgGradient:(TDD_GradientStyle)gradientStyle withFrame:(CGSize)size
{
    return [UIColor tdd_SystemScan_cellHighlightBackgroundWithSize:size];
}

+ (UIColor *)tdd_colorDiagReportSummary {
    return UIColor.tdd_Report_summaryBackground;
}

+ (UIColor *)tdd_viewControllerBackground {
    return UIColor.td_mainBackground;
}

+ (UIColor *)tdd_colorDiagDashLine {
    return UIColor.tdd_General_dashLine;
}


+ (UIColor *)tdd_colorDiagDTCFault {
    return UIColor.tdd_DTC_fault;
}

+ (UIColor *)tdd_colorDiagDTCNoFault {
    return UIColor.tdd_DTC_noFault;
}

+ (UIColor *)tdd_colorDiagListSelectColor:(CGSize)size {
    return [UIColor tdd_List_cellSelectBackgroundWithSize:size];
}


+ (UIColor *)tdd_systemBackgroundColor {
    return [UIColor tdd_SystemScan_viewBackground];
}

+ (UIColor *)tdd_colorDiagHightLightColor:(CGSize)size {
    return [UIColor tdd_List_cellHighlightBackgroundWithSize:size];
    
}

+ (UIColor *)tdd_colorDiagTopTipsBackground {
    return [UIColor tdd_TopView_tipsBackground];
}

+ (UIColor *)tdd_colorDiagTopTipsTextColor {
    return [UIColor tdd_TopView_tipsText];
}

+ (UIColor *)tdd_colorDiagBottomTipsBackground {
    return [UIColor tdd_BottomView_tipsBackground];
}

+ (UIColor *)tdd_colorDiagBottomTipsTextColor {
    return [UIColor tdd_BottomView_tipsText];
}

+ (UIColor *)tdd_fcaAreaBackGroundColor {
    return [UIColor tdd_FCA_areaBackground];
}

+ (UIColor *)cardBg {
    return [UIColor tdd_General_cardBackground];
}

+ (UIColor *)loadingViewBg {
    return [UIColor tdd_Loading_background];
}

+ (UIColor *)tdd_dtcStatusNormalColor {
    return [UIColor tdd_DTC_statusNormal];
}

+ (UIColor *)tdd_pdfDtcStatusNormalColor {
    return [UIColor tdd_DTC_pdfStatsuNormal];
}

+ (UIColor *)tdd_pdfDtcNormalColor {
    return [UIColor tdd_DTC_pdfNormal];
}

+ (UIColor *)tdd_shadowBackgroundColor {
    return [UIColor tdd_General_shadowBackground];
}

+ (UIColor *)tdd_progressTitleTextColor {
    return [UIColor tdd_MsgProgress_titleText];
}

+ (UIColor *)tdd_inputHistoryCellBackground {
    return [UIColor tdd_Input_historyCellBackground];
}

+ (UIColor *)tdd_inputTextViewBackground {
    return [UIColor tdd_Input_textViewBackground];
}

+ (UIColor *)tdd_keyboardViewBackground {
    return [UIColor tdd_Keyboard_background];
}

+ (UIColor *)tdd_keyboardItemDisableBackground {
    return [UIColor tdd_Keyboard_itemDisableBackground];
}

+ (UIColor *)tdd_keyboardItemNormalBackground {
    return [UIColor tdd_Keyboard_itemNormalBackground];
}

+ (UIColor *)tdd_keyboardItemHightlightBackground {
    return [UIColor tdd_Keyboard_itemHighlightBackground];
}

+ (UIColor *)tdd_keyboardItemHightlightBorderColor {
    return [UIColor tdd_Keyboard_itemHighlightBorder];
}

+ (UIColor *)tdd_keyboardItemNormalTitle {
    return [UIColor tdd_Keyboard_itemNormalText];
}

+ (UIColor *)tdd_keyboardItemDisableTitle {
    return [UIColor tdd_Keyboard_itemDisableText];
}

+ (UIColor *)tdd_keyboardEnterBackground {
    return [UIColor tdd_Keyboard_enterBackground];
}

+ (UIColor *)tdd_keyboardDeleteBackground {
    return  [UIColor tdd_Keyboard_deleteBackground];
}

+ (UIColor *)tdd_liveDataCellBackground {
    return [UIColor tdd_LiveData_cellBackground];
}

+ (UIColor *)tdd_liveDataSepLineColor {
    return [UIColor tdd_LiveData_sepLine];
}

+ (UIColor *)tdd_liveDataValueNormalColor {
    return [UIColor tdd_LiveData_valueNormalText];
}

+ (UIColor *)tdd_liveDataUnitNormalColor {
    return [UIColor tdd_LiveData_unitNormalText];
}

+ (UIColor *)tdd_liveDataSegmentationBackground {
    return [UIColor tdd_LiveData_segmentBackground];
}

+ (UIColor *)tdd_liveDataRecordBackground {
    return [UIColor tdd_LiveData_recordBackground];
}

+ (UIColor *)tdd_liveDataScoreColor {
    return [UIColor tdd_LiveData_scoreText];
}

+ (UIColor *)tdd_liveDataSetBackground {
    return [UIColor tdd_LiveData_setBackground];
}

+ (UIColor *)tdd_liveDataSetRangeColor {
    return [UIColor tdd_LiveData_setRangeText];
}

+ (UIColor *)tdd_liveDataSetRangeBackground {
    return [UIColor tdd_LiveData_setRangeBackground];
}

+ (UIColor *)tdd_liveDataLegendColor {
    return [UIColor tdd_LiveData_legendText];
}

+ (UIColor *)tdd_menuCellBackground:(CGSize )size {
    return [UIColor tdd_Menu_cellBackground];
}

+ (UIColor *)tdd_menuCellHightlightBackground:(CGSize )size {
    return [UIColor tdd_Menu_cellHighlightBackground];
}

+ (UIColor *)tdd_popupBackground {
    return [UIColor tdd_Popup_background];
}

+ (UIColor *)tdd_reportInputNormalCellBackground {
    return [UIColor tdd_Report_inputNormalCellBackground];
}

+ (UIColor *)tdd_reportCodeSectionTextColor {
    return [UIColor tdd_Report_codeSectionText];
}

+ (UIColor *)tdd_reportCodeSectionBackground {
    return [UIColor tdd_Report_codeSectionBackground];
}

+ (UIColor *)tdd_reportCodeTitleTextColor {
    return [UIColor tdd_Report_codeTitleText];
}

+ (UIColor *)tdd_reportInfoValueTextColor {
    return [UIColor tdd_Report_infoValueText];
}

+ (UIColor *)tdd_reportRepairHeadTextColor {
    return [UIColor tdd_Report_repairHeaderText];
}

+ (UIColor *)tdd_reportRepairSectionPDFLineColor {
    return [UIColor tdd_Report_repairSectionPDFLine];
}

+ (UIColor *)tdd_reportSummaryDashLineColor {
    return [UIColor tdd_General_dashLine];
}

+ (UIColor *)tdd_reportSummaryPDFBackground {
    return [UIColor tdd_Report_summaryPDFBackground];
}

+ (UIColor *)tdd_reportSummaryBottomLineColor {
    return [UIColor tdd_Report_summaryBottomLine];
}

+ (UIColor *)tdd_reportSummaryTipsColor {
    return [UIColor tdd_Report_summaryTipsText];
}

+ (UIColor *)tdd_reportMilesSelectBackground {
    return [UIColor tdd_Report_mileSelectBackground];
}

+ (UIColor *)tdd_reportMilesNormalBackground {
    return [UIColor tdd_Report_mileNormalBackground];
}

+ (UIColor *)tdd_reportHeadCellBackground {
    return [UIColor tdd_Report_headCellBackground];
}

+ (UIColor *)tdd_reportDisclaimTextColor {
    return [UIColor tdd_Report_disclaimText];
}

+ (UIColor *)tdd_reportPDFBackground {
    return [UIColor tdd_Report_PDFBackground];
}

+ (UIColor *)tdd_reportBackground {
    return [UIColor tdd_Report_background];
}

+ (UIColor *)tdd_systemCellBackground:(CGSize )size {
    return [UIColor tdd_SystemScan_cellBackground];
}

+ (UIColor *)tdd_systemLineColor {
    return [UIColor tdd_SystemScan_line];
}

+ (UIColor *)tdd_troubleShowStateBackground {
    return [UIColor tdd_Trouble_showStateBackground];
}

+ (UIColor *)tdd_troubleBackground {
    return [UIColor tdd_Trouble_background];
}

+ (UIColor *)tdd_listBackground {
    return [UIColor tdd_List_background];
}

+ (UIColor *)tdd_loadingViewFirstBallColor {
    return [UIColor tdd_Loading_topBallBackground];
}

+ (UIColor *)tdd_loadingViewSecondBallColor {
    return [UIColor tdd_Loading_bottomBallBackground];
}

+ (UIColor *)tdd_webLinkColor {
    return [UIColor tdd_General_webLinkText];
}

+ (UIColor *)tdd_cellHeadBackground {
    return [UIColor tdd_General_cellHeadBackground];
}

+ (UIColor *)tdd_background
{
    return UIColor.tdd_colorFFFFFF;
}

+ (UIColor *)tdd_cellBackground {
    return [UIColor tdd_General_cellBackground];
}

+ (UIColor *)tdd_tableViewBG
{
    return [UIColor tdd_colorWithHex:0xFBFBFB];
}

+ (UIColor *)tdd_title
{
    return [UIColor td_title];
}

+ (UIColor *)tdd_titleDisable
{
    return [UIColor tdd_Menu_textDisable];
}

+ (UIColor *)tdd_alertBg {
    return [UIColor tdd_Alert_background];
}

+ (UIColor *)tdd_alertConfirmBg {
    return [UIColor tdd_Alert_confirmBackground];
}

+ (UIColor *)tdd_alertConfirmTextColor {
    return [UIColor tdd_Alert_confirmText];
}

+ (UIColor *)tdd_alertCancelBg {
    return [UIColor tdd_Alert_cancelBackground];
}

+ (UIColor *)tdd_alertLineColor {
    return [UIColor td_line];
}

+ (UIColor *)tdd_textFieldBg {
    return [UIColor tdd_General_textFieldBackground];
}

+ (UIColor *)tdd_textFieldClearColor {
    return [UIColor tdd_General_textFieldClearButtonTint];
}

+ (UIColor *)tdd_subTitle
{
    return [UIColor td_subTitle];
}

+ (UIColor *)tdd_titleLock {
    return [UIColor tdd_General_titleLock];
}

+ (UIColor *)placeholderTextColor {
    return [UIColor tdd_General_placeholderText];
}

+ (UIColor *)tdd_blue
{
    return UIColor.tdd_color215CB0;
}

+ (UIColor *)tdd_errorRed
{
    return [UIColor td_error];
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
    return [UIColor tdd_General_collectionViewBackground];
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
    if (TDD_DiagnosisTools.softWareIsCarPalSeries || TDD_DiagnosisTools.softWareIsTopVCI) {
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
    return [UIColor tdd_General_line];
}

+ (UIColor *)tdd_borderColor
{
    return [UIColor tdd_General_viewBorder];
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
