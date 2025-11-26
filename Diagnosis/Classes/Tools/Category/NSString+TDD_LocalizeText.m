//
//  NSString+TDD_LocalizeText.m
//  Diag
//
//  Created by diag on 2023/10/18.
//

#import "NSString+TDD_LocalizeText.h"
@implementation NSString (TDD_LocalizeText)
+ (NSString *)tdd_reportTitleUser {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries || TDD_DiagnosisTools.softWareIsTopVCI) {
        return TDDLocalized.title_user;
    } else {
        return TDDLocalized.report_customer;
    }
}

+ (NSString *)tdd_reportTitleUserPhone {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries || TDD_DiagnosisTools.softWareIsTopVCI) {
        return TDDLocalized.title_user_phone;
    } else {
        return TDDLocalized.report_customer_telephone_number;
    }
}

+ (NSString *)tdd_reportTitleDistance {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries || TDD_DiagnosisTools.softWareIsTopVCI) {
        return TDDLocalized.report_driving_distance;
    } else {
        return TDDLocalized.report_mileage;
    }
}

+ (NSString *)tdd_reportTitleSystemHead {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries || TDD_DiagnosisTools.softWareIsTopVCI) {
        return TDDLocalized.func_system_scan_report;
    } else {
        return TDDLocalized.full_system_report;
    }
}

+ (NSString *)tdd_reportTitleLiveDataHead {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries) {
        return TDDLocalized.func_data_report;
    } else {
        return TDDLocalized.data_flow_report;
    }
}

+ (NSString *)tdd_reportTitleDiagnosed {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries) {
        return TDDLocalized.func_diagnose_report;
    } else {
        return TDDLocalized.diagnosis_report;
    }
}

+ (NSString *)tdd_reportTitleVIN {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries) {
        return @"VIN：";
    } else {
        return TDDLocalized.report_vin_code;
    }
}

+ (NSString *)tdd_reportTitleNoDTC {
    if (TDD_DiagnosisTools.softWareIsCarDiagSeries) {
        return TDDLocalized.diag_normal;
    } else {
        return TDDLocalized.diagnosis_no_dtc;
    }
}
@end
