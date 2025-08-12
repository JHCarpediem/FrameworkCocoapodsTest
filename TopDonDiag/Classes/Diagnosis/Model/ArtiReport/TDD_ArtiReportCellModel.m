//
//  TDD_ArtiReportCellModel.m
//  AD200
//
//  Created by lecason on 2022/8/3.
//

#import "TDD_ArtiReportCellModel.h"

#define kSafeString(str, defaultStr) ((str) != nil && [(str) length] > 0 ? (str) : (defaultStr))

@implementation TDD_ArtiReportCellModel

- (NSMutableArray<TDD_ArtiReportInfo *> *)infos {
    
    TDD_ArtiReportInfo *licensePlate = [self getInfoWithTitle:TDDLocalized.report_license_plate
                                                        value: self.describe_license_plate_number];
    TDD_ArtiReportInfo *brand = [self getInfoWithTitle:TDDLocalized.report_brand_of_vehicle
                                                        value: self.describe_brand];
    TDD_ArtiReportInfo *model = [self getInfoWithTitle:TDDLocalized.report_model
                                                        value: self.describe_model];
    TDD_ArtiReportInfo *year = [self getInfoWithTitle:TDDLocalized.report_year
                                                        value: self.describe_year];
    TDD_ArtiReportInfo *mileage = [self getInfoWithTitle:TDDLocalized.report_mileage
                                                        value: self.describe_mileage];
    TDD_ArtiReportInfo *engine = [self getInfoWithTitle:TDDLocalized.report_engine
                                                        value: self.describe_engine];
    TDD_ArtiReportInfo *subModel = [self getInfoWithTitle:TDDLocalized.report_sub_models
                                                        value: self.describe_engine_subType];
    TDD_ArtiReportInfo *diagnosisTime = [self getInfoWithTitle:TDDLocalized.report_diagnosis_time
                                                        value: self.describe_diagnosis_time];
    TDD_ArtiReportInfo *vincode = [self getInfoWithTitle:TDDLocalized.report_vin_code
                                                        value: self.inputVIN];
    TDD_ArtiReportInfo *customerName = [self getInfoWithTitle:[NSString tdd_reportTitleUser]
                                                        value: self.describe_customer_name];
    TDD_ArtiReportInfo *customerCall = [self getInfoWithTitle:[NSString tdd_reportTitleUserPhone]
                                                        value: self.describe_customer_call];
    TDD_ArtiReportInfo *repairOrderNum = [self getInfoWithTitle:TDDLocalized.maintenance_bill_number
                                                        value: self.repairOrderNum];

    if (isKindOfTopVCI) {
        // CarPal (不是 CarPalGuru ), 数据流报告和发动机 去掉车辆品牌、型号、年款、发动机、子型号
        NSMutableArray<TDD_ArtiReportInfo *> *arr = [NSMutableArray array];
        if ([TDD_DiagnosisTools softWareIsCarPal] && (self.reportType == 3 || (self.reportType == 2 && self.obdEntryType == OET_CARPAL_OBD_ENGINE_CHECK))) {
            arr = @[
                licensePlate,
                mileage,
                diagnosisTime,
                vincode,
                customerName,
                customerCall
            ].mutableCopy;
        } else {
            arr = @[
                licensePlate,
                brand,
                model,
                year,
                mileage,
                engine,
                subModel,
                diagnosisTime,
                vincode,
                customerName,
                customerCall
            ].mutableCopy;
        }
        
        if (![TDD_DiagnosisTools softWareIsCarPalSeries]) {
            [arr addObject:repairOrderNum];
        }

        return arr;
   
    } else {
        
        TDD_ArtiReportInfo *drivingDistance = [self getInfoWithTitle:TDDLocalized.report_driving_distance
                                                            value: self.describe_mileage];
        TDD_ArtiReportInfo *softwareVersionNumber = [self getInfoWithTitle:TDDLocalized.report_model_software_version_number
                                                            value: self.describe_version];
        TDD_ArtiReportInfo *applicationSoftwareVersion = [self getInfoWithTitle:TDDLocalized.report_application_software_version
                                                            value: self.describe_software_version];
        TDD_ArtiReportInfo *diagnosisPath = [self getInfoWithTitle:TDDLocalized.report_diagnosis_path
                                                            value: self.describe_diagnosis_path];
        
        NSArray *titleArray = @[
            @[TDDLocalized.report_license_plate,
              TDDLocalized.report_brand_of_vehicle],
            @[TDDLocalized.report_model,
              TDDLocalized.report_year],
            
            @[TDDLocalized.report_driving_distance,
              TDDLocalized.report_engine],
            
            @[TDDLocalized.report_sub_models,
              TDDLocalized.report_diagnosis_time],
            
            @[TDDLocalized.report_model_software_version_number,
              TDDLocalized.report_application_software_version],
            
            @[TDDLocalized.report_vin_code,
              TDDLocalized.report_diagnosis_path],
            
            @[
                [NSString tdd_reportTitleUser],
                [NSString tdd_reportTitleUserPhone]
            ],
            
            @[TDDLocalized.maintenance_bill_number]
        ];
        
        NSArray<TDD_ArtiReportInfo *> *arr = @[
            licensePlate,
            brand,
            model,
            year,
            
            drivingDistance,
            engine,
            subModel,
            diagnosisTime,
            
            softwareVersionNumber,
            applicationSoftwareVersion,
            
            vincode,
            diagnosisPath,
            
            customerName,
            customerCall,
            
            repairOrderNum
        ];
        
        return arr;
    }
}

/// 历史诊断报告信息
- (NSArray<TDD_ArtiReportInfo *> *)historyDiagReportInfos {
    
    TDD_ArtiReportInfo *licensePlate = [self getInfoWithTitle:TDDLocalized.report_license_plate
                                                        value: self.describe_license_plate_number];
    TDD_ArtiReportInfo *brand = [self getInfoWithTitle:TDDLocalized.report_brand_of_vehicle
                                                        value: self.describe_brand];
    TDD_ArtiReportInfo *model = [self getInfoWithTitle:TDDLocalized.report_model
                                                        value: self.describe_model];
    TDD_ArtiReportInfo *year = [self getInfoWithTitle:TDDLocalized.report_year
                                                        value: self.describe_year];
    TDD_ArtiReportInfo *mileage = [self getInfoWithTitle:TDDLocalized.report_mileage
                                                        value: self.describe_mileage];
    TDD_ArtiReportInfo *engine = [self getInfoWithTitle:TDDLocalized.report_engine
                                                        value: self.describe_engine];
    TDD_ArtiReportInfo *subModel = [self getInfoWithTitle:TDDLocalized.report_sub_models
                                                        value: self.describe_engine_subType];
    TDD_ArtiReportInfo *diagnosisTime = [self getInfoWithTitle:TDDLocalized.report_diagnosis_time
                                                        value: self.describe_diagnosis_time];
    TDD_ArtiReportInfo *vincode = [self getInfoWithTitle:TDDLocalized.report_vin_code
                                                        value: self.inputVIN];
    TDD_ArtiReportInfo *customerName = [self getInfoWithTitle:[NSString tdd_reportTitleUser]
                                                        value: self.describe_customer_name];
    TDD_ArtiReportInfo *customerCall = [self getInfoWithTitle:[NSString tdd_reportTitleUserPhone]
                                                        value: self.describe_customer_call];
    TDD_ArtiReportInfo *repairOrderNum = [self getInfoWithTitle:TDDLocalized.maintenance_bill_number
                                                            value: self.repairOrderNum];
    if (isKindOfTopVCI) {
        NSArray<TDD_ArtiReportInfo *> *arr = @[
            licensePlate,
            brand,
            model,
            year,
            mileage,
            engine,
            subModel,
            diagnosisTime,
            vincode,
            customerName,
            customerCall
        ];
        
        return arr;
   
    } else {
        
        TDD_ArtiReportInfo *drivingDistance = [self getInfoWithTitle:TDDLocalized.report_driving_distance
                                                            value: self.describe_mileage];
        TDD_ArtiReportInfo *softwareVersionNumber = [self getInfoWithTitle:TDDLocalized.report_model_software_version_number
                                                            value: self.describe_version];
        TDD_ArtiReportInfo *applicationSoftwareVersion = [self getInfoWithTitle:TDDLocalized.report_application_software_version
                                                            value: self.describe_software_version];
        TDD_ArtiReportInfo *diagnosisPath = [self getInfoWithTitle:TDDLocalized.report_diagnosis_path
                                                            value: self.describe_diagnosis_path];
        
        NSArray *titleArray = @[
            @[TDDLocalized.report_license_plate,
              TDDLocalized.report_brand_of_vehicle],
            @[TDDLocalized.report_model,
              TDDLocalized.report_year],
            
            @[TDDLocalized.report_driving_distance,
              TDDLocalized.report_engine],
            
            @[TDDLocalized.report_sub_models,
              TDDLocalized.report_diagnosis_time],
            
            @[TDDLocalized.report_model_software_version_number,
              TDDLocalized.report_application_software_version],
            
            @[TDDLocalized.report_vin_code,
              TDDLocalized.report_diagnosis_path],
            
            @[
                [NSString tdd_reportTitleUser],
                [NSString tdd_reportTitleUserPhone]
            ]
        ];
        
        NSArray<TDD_ArtiReportInfo *> *arr = @[
            licensePlate,
            brand,
            model,
            year,
            
            drivingDistance,
            engine,
            subModel,
            diagnosisTime,
            
            softwareVersionNumber,
            applicationSoftwareVersion,
            
            vincode,
            diagnosisPath,
            
            customerName,
            customerCall
        ];
        
        return arr;
    }
}

- (TDD_ArtiReportInfo *)getInfoWithTitle: (NSString *)title value: (NSString *)value {
    return [[TDD_ArtiReportInfo alloc] initWithTitle:title value:kSafeString(value, @"")];
}

@end
