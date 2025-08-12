//
//  NSString+TDD_LocalizeText.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/10/18.
//

#import "NSString+TDD_LocalizeText.h"
#define DiagShareManageColorType [TDD_DiagnosisManage sharedManage].viewColorType
@implementation NSString (TDD_LocalizeText)
+ (NSString *)tdd_reportTitleUser {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.title_user;
            break;
        case TDD_DiagViewColorType_Black:
            return TDDLocalized.title_user;
            break;
        default:
            return TDDLocalized.report_customer;
            break;
    }
}

+ (NSString *)tdd_reportTitleUserPhone {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.title_user_phone;
            break;
        case TDD_DiagViewColorType_Black:
            return TDDLocalized.title_user_phone;
            break;
        default:
            return TDDLocalized.report_customer_telephone_number;
            break;
    }
}

+ (NSString *)tdd_reportTitleDistance {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.report_driving_distance;
            break;
        case TDD_DiagViewColorType_Black:
            return TDDLocalized.report_driving_distance;
            break;
        default:
            return TDDLocalized.report_mileage;
            break;
    }
    
}

+ (NSString *)tdd_reportTitleSystemHead {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.func_system_scan_report;
            break;
        case TDD_DiagViewColorType_Black:
            return TDDLocalized.func_system_scan_report;
            break;
        default:
            return TDDLocalized.full_system_report;
            break;
    }
}

+ (NSString *)tdd_reportTitleLiveDataHead {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.func_data_report;
            break;
        default:
            return TDDLocalized.data_flow_report;
            break;
    }
}

+ (NSString *)tdd_reportTitleDiagnosed {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.func_diagnose_report;
            break;
        default:
            return TDDLocalized.diagnosis_report;
            break;
    }
    
}

+ (NSString *)tdd_reportTitleVIN {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return @"VIN：";
            break;
        default:
            return TDDLocalized.report_vin_code;
            break;
    }
    
}

+ (NSString *)tdd_reportTitleNoDTC {
    switch (DiagShareManageColorType) {
        case TDD_DiagViewColorType_GradientBlack:
            return TDDLocalized.diag_normal;
            break;
        default:
            return TDDLocalized.diagnosis_no_dtc;
            break;
    }
    
}
@end
