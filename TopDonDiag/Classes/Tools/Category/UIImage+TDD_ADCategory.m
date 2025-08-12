//
//  UIImage+TDD_ADCategory.m
//  AD200
//
//  Created by yong liu on 2022/7/13.
//

#import "UIImage+TDD_ADCategory.h"
#define DiagShareManageColorType [TDD_DiagnosisManage sharedManage].viewColorType
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
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return kImageNamed(@"section_title_bg");
        default:
            return [kImageNamed(@"section_title_bg") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme];
    }
}

+ (UIImage *)tdd_imageDiagReportPageFooter {
    switch ([TDD_DiagnosisManage sharedManage].currentSoftware) {
        case TDDSoftwareKeyNow:
            return kImageNamed(@"arti_reportTable_foot_keyNow");
            break;
        case TDDSoftwareCarPal:
        case TDDSoftwareCarPalGuru:
            return kImageNamed(@"arti_reportTable_foot_carpal");
        case TDDSoftwareTopVci:
            return kImageNamed(@"arti_reportTable_foot_topVCI");
        case TDDSoftwareTopVciPro:
            return kImageNamed(@"arti_reportTable_foot_topVCIpro");
        case TDDSoftwareDeepScan:
            return kImageNamed(@"arti_reportTable_foot_deepscan");
        case TDDSoftwareTopScanHD:
            return kImageNamed(@"arti_reportTable_foot_topscan_hd");
        case TDDSoftwareTopScanBMW:
            return kImageNamed(@"arti_reportTable_foot_topscan_BMW");
        case TDDSoftwareTopScanVAG:
            return kImageNamed(@"arti_reportTable_foot_topscan_VAG");

        default:
            return kImageNamed(@"arti_reportTable_foot");
            break;
    }
    
    
    return kImageNamed(@"arti_reportTable_foot");
}

+ (UIImage *)tdd_imageDiagReportPageHeader {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Orange:
            return kImageNamed(@"arti_reportTable_head_keyNow");
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"arti_reportTable_head_topVCI");
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"arti_reportTable_head_carpal");
        default:
            return kImageNamed(@"arti_reportTable_head");
    }
}

+ (UIImage *)tdd_imageLiveDataSetNumLegend {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artLive_show_type_one");
            break;
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artLive_show_type_one_carpal");
            break;
        default:
            return kImageNamed(@"artLive_show_type_one_default");
            break;
    }
    
}

+ (UIImage *)tdd_imageLiveDataSetNumChartLegend {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artLive_show_type_two");
            break;
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artLive_show_type_two_carpal");
            break;
        default:
            return kImageNamed(@"artLive_show_type_two_default");
            break;
    }
    
}

+ (UIImage *)tdd_imageLiveDataSetDialLegend {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artLive_show_type_three");
            break;
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artLive_show_type_three_carpal");
            break;
        default:
            return kImageNamed(@"artLive_show_type_three_default");
            break;
    }
    
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectText {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artiLiveData_select_text_black");
            break;
        default:
            return kImageNamed(@"artiLiveData_select_text");
            break;
    }
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectChart {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artiLiveData_select_chart_black");
            break;
        default:
            return kImageNamed(@"artiLiveData_select_chart");
            break;
    }
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectDial {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artiLiveData_select_dial_black");
            break;
        default:
            return kImageNamed(@"artiLiveData_select_dial");
            break;
    }
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectTextHL {
    return kImageNamed(@"artiLiveData_select_text_select");
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectChartHL {
    return kImageNamed(@"artiLiveData_select_chart_select");
}

+ (UIImage *)tdd_imageDiagLiveDataSetSelectDialHL {
    return kImageNamed(@"artiLiveData_select_dial_select");
}

+ (UIImage *)tdd_imageDiagLiveDataMore {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"artiLiveData_more_black");
            break;
        default:
            return [kImageNamed(@"artiLiveData_more") tdd_imageByTintColor:UIColor.tdd_title];
            break;
    }
}

+ (UIImage *)tdd_imageCheckDidSelect {
    
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return [kImageNamed(@"test_result_cell_select_yes") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme];
            //return kImageNamed(@"test_result_cell_select_yes_blue");
        default:
            return [kImageNamed(@"test_result_cell_select_yes") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme];
    }
    
}

+ (UIImage *)tdd_imageSingleCheckUnSelect {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"test_result_cell_select_single_black");
        default:
            return kImageNamed(@"test_result_cell_select_single");
    }
}

+ (UIImage *)tdd_imageSingleCheckDidSelect {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return[kImageNamed(@"test_result_cell_select_single_yes") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme];
        default:
            return [kImageNamed(@"test_result_cell_select_single_yes") tdd_imageByTintColor:UIColor.tdd_colorDiagTheme];
    }
    
}

+ (UIImage *)tdd_imageAlertCheckboxNormal {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"checkbox_btn_normal_gray");
        default:
            return kImageNamed(@"checkbox_btn_nor");
    }
}

+ (UIImage *)tdd_imageAlertCheckboxSelect {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"checkbox_btn_se_blue");
        default:
            return kImageNamed(@"checkbox_btn_sel");
    }
}

+ (UIImage *)tdd_imageDiagReportInfo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return kImageNamed(@"topdon_report_bg");
        case TDD_DiagViewColorType_Orange:
            return kImageNamed(@"topdon_report_bg_orange");
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"topdon_report_bg_carpal");
        default:
            return kImageNamed(@"topdon_report_bg_topVCI");
    }
}

+ (UIImage *)tdd_imageDiagKeyboardHightlightBG {
    
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"keyboard_hightlight_black");
        default:
            return kImageNamed(@"keyboard_hightlight_white");
    }
    
}

+ (UIImage *)tdd_imageDiagNumKeyboardHightlightBG {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"keyboard_num_hightlight_black");
        default:
            return kImageNamed(@"keyboard_num_hightlight_white");
    }
}

+ (UIImage *)tdd_imageDiagKeyboardDelete {
    
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"keyboard_exit");
        default:
            return [kImageNamed(@"keyboard_exit") tdd_imageByTintColor:[UIColor tdd_colorDiagTheme]];
    }
    
}

+ (UIImage *)tdd_imageDiagUpArrow {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return [kImageNamed(@"trouble_icon_up_arrow") tdd_imageByTintColor:[UIColor whiteColor]];
        default:
            return kImageNamed(@"trouble_icon_up_arrow");
    }
    
}

+ (UIImage *)tdd_imageDiagDownArrow {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return [kImageNamed(@"trouble_icon_down_arrow") tdd_imageByTintColor:[UIColor whiteColor]];
        default:
            return kImageNamed(@"trouble_icon_down_arrow");
    }
    
}

+ (UIImage *)tdd_imageDiagBottomTipIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"trouble_icon_note_black");
        default:
            return kImageNamed(@"trobule_icon_note");
    }
}

+ (UIImage *)tdd_imageDiagBottomNoteIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"trouble_small_icon_note_black");
        default:
            return kImageNamed(@"trouble_small_icon_note");
    }
    
}

+ (UIImage *)tdd_imageDiagBottomCloseIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"close_icon_black");
        default:

            return [kImageNamed(@"close_icon") tdd_imageByTintColor:UIColor.blackColor];
    }
}

+ (UIImage *)tdd_imageDiagHelpUnableIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artiFreeze_no_help_black");
        default:
            return kImageNamed(@"artiFreeze_no_help");
    }
}

+ (UIImage *)tdd_imageDiagFileDictIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"dialog_dict_blue");
        default:
            return kImageNamed(@"arti_diag_log_dict");
    }
}

+ (UIImage *)tdd_imageDiagCellSelect {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"test_result_cell_select_black");
        default:
            return kImageNamed(@"test_result_cell_select");
    }
}

+ (UIImage *)tdd_imageDiagCellSelectNO {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"test_result_cell_select_no_black");
        default:
            return kImageNamed(@"test_result_cell_select_no");
    }
}

+ (UIImage *)tdd_imageDiagAIIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"trouble_button_ai_beta");
        default:
            return kImageNamed(@"trouble_button_ai_beta_white");
    }
    
}

+ (UIImage *)tdd_imageDiagAIDisableIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"trouble_button_ai_beta_disable");
        default:
            return kImageNamed(@"trouble_button_ai_beta_disable_white");
    }
    
}

+ (UIImage *)tdd_imageDiagGuildAIIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"diag_trouble_ai_guild_icon_black");
        default:
            return kImageNamed(@"diag_trouble_ai_guild_icon");
    }
    
}

+ (UIImage *)tdd_imageDiagBtnLockIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"diag_btn_lock_black");
        default:
            return kImageNamed(@"diag_btn_lock");
    }
    
}

/// 网关
+ (UIImage *)tdd_imageDiageGateWayToBuyImage {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"diag_gateway_purchase_black");
            break;
            
        default:
            return kImageNamed(@"diag_gateway_purchase_bg");
            break;
    }
    
}

+ (UIImage *)tdd_imageDiageGateWayToBuyArrow {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"diag_arrow_blue");
            break;
            
        default:
            return kImageNamed(@"diag_arrow_red");
            break;
    }

}

+ (UIImage *)tdd_imageDiageGateWayChangeAccount {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"diag_change_account_blue");
            break;
            
        default:
            return kImageNamed(@"diag_change_account");
            break;
    }
    
}

+ (UIImage *)tdd_imageDiageGateWayRefresh {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"diag_refresh_blue");
            break;
            
        default:
            return kImageNamed(@"diag_refresh");
            break;
    }
    
}

+ (UIImage *)tdd_imageDiagGateWayFCATopDonLogo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"FCA_topdon_logo_black");
            break;
            
        default:
            return kImageNamed(@"FCA_topdon_logo");
            break;
    }
}
+ (UIImage *)tdd_imageDiagGateWayRenualtLogo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"FCA_Logo_renualt_black");
            break;
            
        default:
            return kImageNamed(@"FCA_Logo_renualt");
            break;
    }
}
+ (UIImage *)tdd_imageDiagGateWayNissanLogo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"FCA_Logo_nissan_black");
            break;
            
        default:
            return kImageNamed(@"FCA_Logo_nissan");
            break;
    }
}
+ (UIImage *)tdd_imageDiagGateWayVWSFDLogo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"vw_sfd_logo_black");
            break;
            
        default:
            return kImageNamed(@"vw_sfd_logo");
            break;
    }
}
+ (UIImage *)tdd_imageDiagGateWayDEMOLogo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"gateway_demo_logo_black");
            break;
            
        default:
            return kImageNamed(@"gateway_demo_logo");
            break;
    }
}

+ (UIImage *)tdd_imageDiagGateWaySwitchBG {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"gateway_switch_unlock_type_black");
            break;
            
        default:
            return kImageNamed(@"gateway_switch_unlock_type");
            break;
    }
    
}

+ (UIImage *)tdd_imageSFDSharePopBG {
    
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artiList_share_back_black");
            break;
            
        default:
            return kImageNamed(@"artiList_share_back");
            break;
    }
    
}

+ (UIImage *)tdd_imageSFDQrIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artiList_share_qr_black");
            break;
            
        default:
            return kImageNamed(@"artiList_share_qr");
            break;
    }
}

+ (UIImage *)tdd_imageSFDEmailIcon {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Black:
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"artiList_share_email_black");
            break;
            
        default:
            return kImageNamed(@"artiList_share_email");
            break;
    }
}

+ (UIImage *)tdd_imageDiagVCIConnect {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_Blue:
            return kImageNamed(@"navi_vci_connect_blue");
        case TDD_DiagViewColorType_Orange:
            return kImageNamed(@"navi_vci_connect_orange");
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"navi_vci_connect_topVCI");
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"navi_vci_connect_carpal");
        default:
            return kImageNamed(@"navi_vci_connect_blue");
    }
    
}

+ (UIImage *)tdd_imageDiagVCIUnConnect {
    
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"navi_vci_unconnect_topVCI");
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"navi_vci_unconnect_carpal");
        default:
            return kImageNamed(@"navi_vci_unconnect");
    }
}

+ (UIImage *)tdd_imageDiagNavFeedBack {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"navi_feedback_diagnosis_white");
            break;
            
        default:
            return kImageNamed(@"navi_feedback_diagnosis");
            break;
    }
    
}

+ (UIImage *)tdd_imageDiagNavMore {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"navi_more_diagnosis_white");
            break;
            
        default:
            return kImageNamed(@"navi_more_diagnosis");
            break;
    }
}

+ (UIImage *)tdd_imageDiagNavTranslate {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"navi_translate_normal_white");
            break;
            
        default:
            return kImageNamed(@"navi_translate_normal");
            break;
    }
}

+ (UIImage *)tdd_imageDiagNavTranslateFinish {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"navi_translate_finish_white");
            break;
            
        default:
            return kImageNamed(@"navi_translate_finish_black");
            break;
    }
}

+ (UIImage *)tdd_imageDiagNavSearch {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"nav_search_ic_white");
            break;
            
        default:
            return kImageNamed(@"nav_search_ic");
            break;
    }
}

+ (UIImage *)tdd_imageDiagNavMoreBG {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"diagnosis_navipop_icon_bg_black");
            break;
            
        default:
            return kImageNamed(@"diagnosis_navipop_icon_bg");
            break;
    }
}

+ (nullable UIImage *)tdd_imageDiagReportHeaderLogo {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"pdf_car_check_logo");
        default:
            return nil;
    }
}

+ (nullable UIImage *)tdd_imageDiagReportPageWatermark {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return kImageNamed(@"pdf_fullscreen_watermark");
        case TDD_DiagViewColorType_Black:
            return kImageNamed(@"pdf_fullscreen_watermark");
        default:
            return nil;
    }
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
