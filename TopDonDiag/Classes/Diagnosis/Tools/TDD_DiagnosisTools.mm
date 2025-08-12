//
//  TDD_DiagnosisTools.m
//  AD200
//
//  Created by 何可人 on 2022/6/7.
//
#import <Foundation/Foundation.h>
#import "TDD_DiagnosisTools.h"
#if useCarsFramework
#import <CarsFramework/version.hpp>
#else
#import "version.hpp"
#endif

#import <SSZipArchive/SSZipArchive.h>
#import "TDD_StdCommModel.h"
#import "TDD_StdShowModel.h"
#import "TDD_CTools.h"
#import "TDD_STDPublicInterface.h"
#import "TDD_AlertTools.h"
#define TDD_kAutoUnZipSoftPackage @"TDD_kAutoUnZipSoftPackage"                          // 是否解压AUTOVIN、ACCSPEED车型


@implementation TDD_DiagnosisTools

+ (void)vehicleDecompressionPackage
{
    //    NSString *key = [NSString stringWithFormat:@"%@%@", TDD_kAutoUnZipSoftPackage, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //    if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) {
    //        return;
    //    }
    
    __block BOOL isUnZipSuccess = YES;
    dispatch_group_t unZipGroup = dispatch_group_create();
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
    NSArray *packageAry;
    if ([appName isEqualToString:@"TopDonDiagDebug"] || [appName isEqualToString:@"DiagExample"] ) {
        packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI",@"DEMO", @"EOBD"];
    }else {
#ifdef DEBUG
        if ([appName isEqualToString:@"TopVCI"] || [appName isEqualToString:@"TopVCI_FENCH"] || [appName isEqualToString:@"CarPal"]) {
            packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI", @"DEMO", @"EOBD"];
        }else {
            if ([appName isEqualToString:@"TOPVCI_PRO"]) {
                packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI", @"EOBD", @"DEMO",@"COMM"];
            }else {
                packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI", @"DEMO",@"COMM"];
            }
        }

#else
        if ([appName isEqualToString:@"TopVCI"] || [appName isEqualToString:@"TopVCI_FENCH"] || [appName isEqualToString:@"CarPal"]) {
            packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI", @"EOBD"];
        }else {
            if ([appName isEqualToString:@"TOPVCI_PRO"]) {
                packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI", @"EOBD", @"DEMO"];
            }else {
                packageAry = @[@"ACCSPEED",@"AUTOVIN", @"IM_PRECHECK", @"CheckVCI", @"DEMO"];
            }
        }

#endif
    }
    for (int i = 0; i < packageAry.count; i++) {
        dispatch_group_enter(unZipGroup);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *resourcePath = [bundle pathForResource:[NSString stringWithFormat:@"TopdonDiagnosis.bundle/%@", [packageAry objectAtIndex:i]] ofType:@"zip"];
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docDir = [NSString stringWithFormat:@"%@/%@/%@",[paths objectAtIndex:0],[TDD_DiagnosisManage sharedManage].documentSubpath,appName];
            NSError * error;
            if (![fileManager fileExistsAtPath:docDir]) {
                BOOL isSuccess = [fileManager createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:&error];
                if (isSuccess) {
                    NSLog(@"创建成功");
                }else {
                    NSLog(@"创建路径失败: %@", error);
                }
                
            } else {
                NSLog(@"目录已存在");
                NSString * path = [NSString stringWithFormat:@"%@/Diagnosis/Public/%@", docDir, packageAry[i]];
                if ([fileManager fileExistsAtPath:path]) {
                    BOOL isSuccess = [fileManager removeItemAtPath:path error:&error];
                    if (isSuccess) {
                        NSLog(@"移除旧文件成功");
                    }else {
                        NSLog(@"移除旧文件失败: %@", error);
                    }
                }
            }
            NSLog(@"开始解压");
            [SSZipArchive unzipFileAtPath:resourcePath toDestination:docDir progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
                
            } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"-------ss----->%@解压成功<------------ss-------", [packageAry objectAtIndex:i]);
                } else {
                    isUnZipSuccess = NO;
                    NSLog(@"s%@解压失败s--%@",[packageAry objectAtIndex:i], error);
                }
                dispatch_group_leave(unZipGroup);
            }];
        });
    }
    
    dispatch_group_notify(unZipGroup, dispatch_get_main_queue(), ^{
        NSString *key = [NSString stringWithFormat:@"%@%@", TDD_kAutoUnZipSoftPackage, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [[NSUserDefaults standardUserDefaults] setBool:isUnZipSuccess forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [TDD_DiagnosisTools searchAllDirectory];
        });
    });
    
}

#pragma mark - 搜索目录
+ (NSArray<TDD_CarModel *> *)searchAllDirectory
{
    NSMutableArray *localDIAGTDD_CarModelArr = [NSMutableArray array];
    NSMutableArray *localIMMOTDD_CarModelArr = [NSMutableArray array];
    NSMutableArray *localRFIDTDD_CarModelArr = [NSMutableArray array];
    NSMutableArray *localMOTORTDD_CarModelArr = [NSMutableArray array];
    
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
    NSMutableArray * directoryArr1 = @[[NSString stringWithFormat:@"%@/%@/Diagnosis",[TDD_DiagnosisManage sharedManage].documentSubpath,appName],[NSString stringWithFormat:@"%@/%@/Immo",[TDD_DiagnosisManage sharedManage].documentSubpath,appName],[NSString stringWithFormat:@"%@/%@/NewEnergy",[TDD_DiagnosisManage sharedManage].documentSubpath,appName], [NSString stringWithFormat:@"%@/%@/RFID",[TDD_DiagnosisManage sharedManage].documentSubpath,appName], [NSString stringWithFormat:@"%@/%@/MOTOR",[TDD_DiagnosisManage sharedManage].documentSubpath,appName]].mutableCopy;
    
    if ([TDD_DiagnosisTools userIsLogin] && ([TDD_DiagnosisTools selectedVCISerialNum].length > 0 || [TDD_DiagnosisTools selectedTDartsSerialNum].length > 0)) {
        
        NSMutableArray * directoryArr = @[@"Diagnosis",@"Immo",@"NewEnergy", @"RFID",@"MOTOR"].mutableCopy;
        
        for (NSInteger i = 0; i < directoryArr.count; i ++) {
            NSString * path = directoryArr[i];
            
            if ([path containsString:@"RFID"]) {
                if ([TDD_DiagnosisTools selectedTDartsSerialNum].length > 0) {
                    path = [NSString stringWithFormat:@"%@/%@/%@/%@", [TDD_DiagnosisManage sharedManage].documentSubpath,appName,[TDD_DiagnosisTools selectedTDartsSerialNum], path];
                }else{
                    path = @"";
                }
            }else {
                if ([TDD_DiagnosisTools selectedVCISerialNum].length > 0) {
                    path = [NSString stringWithFormat:@"%@/%@/%@/%@", [TDD_DiagnosisManage sharedManage].documentSubpath,appName,[TDD_DiagnosisTools selectedVCISerialNum], path];
                }else{
                    path = @"";
                }
            }
            
            if (path.length > 0) {
                [directoryArr1 addObject:path];
            }
        }
    }
    
    NSArray * directoryArr2 = @[@"America",@"Asia",@"China",@"Europe",@"Public",@"Australia"];
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    
    NSMutableArray * linkArr = [[NSMutableArray alloc] init]; //链接车数组
    
    for (int i = 0; i < directoryArr1.count; i ++) {
        
        NSString * path1 = directoryArr1[i];
        
        path1 = [documentsPath stringByAppendingPathComponent:path1];
        
        if ([path1 containsString:@"/RFID"]) {
            NSError * error;
            NSArray * fileArr = [fileManager contentsOfDirectoryAtPath:path1 error:&error];
            if (error) {
                HLog(@"文件夹遍历错误：%@",error);
            }else{
                
                for (int i = 0; i < fileArr.count; i ++) {
                    NSString * fileName = fileArr[i];
                    NSString * carPath = [path1 stringByAppendingPathComponent:fileName];
                    TDD_CarModel * model = [self getINIWithPath:carPath];
                    if (model) {
                        model.path = carPath;
                        model.strType = @"IMMO";
                        model.softType = TDD_SoftType_TDarts;
                        model.languageArr = [self getLangugeWithPath:carPath];
                        [self versionContrast:model];
                        [resultArr addObject:model];
                        
                        if (model.strLink.length > 0) {
                            [linkArr addObject:model];
                        }
                        [localRFIDTDD_CarModelArr addObject:model];
                    }
                }
            }
        } else {
            for (int j = 0; j < directoryArr2.count; j ++) {
                
                NSString * path2 = directoryArr2[j];
                path2 = [path1 stringByAppendingPathComponent:path2];
                
                if (![fileManager fileExistsAtPath:path2]) {
                    //文件夹不存在，创建文件夹
                    BOOL isOK = [self createDirectoryAtPath:path2];
                    
                    if (!isOK) {
                        HLog(@"错误：创建%@失败",path2);
                    }else {
                        HLog(@"创建%@成功",path2);
                    }
                }
                
                if ([fileManager fileExistsAtPath:path2]) {
                    //文件夹存在
                    HLog(@"文件夹%@存在，开始搜索",path2);
                    
                    NSError * error;
                    NSArray * fileArr = [fileManager contentsOfDirectoryAtPath:path2 error:&error];
                    if (error) {
                        HLog(@"文件夹遍历错误：%@",error);
                    }else{
                        
                        for (int i = 0; i < fileArr.count; i ++) {
                            NSString * fileName = fileArr[i];
                            NSString * carPath = [path2 stringByAppendingPathComponent:fileName];
                            TDD_CarModel * model = [self getINIWithPath:carPath];
                            if (model) {
                                model.path = carPath;
                                NSString * type = path1.lastPathComponent;
                                if ([type isEqualToString:@"Diagnosis"]) {
                                    model.strType = @"DIAG";
                                }else if ([type isEqualToString:@"Immo"]) {
                                    model.strType = @"IMMO";
                                }else if ([type isEqualToString:@"RFID"]) {
                                    model.strType = @"IMMO";
                                }else if ([type isEqualToString:@"MOTOR"]) {
                                    model.strType = @"MOTO";
                                }
                                
                                [self versionContrast:model];
                                if (model.strLink.length > 0) {
                                    [linkArr addObject:model];
                                }else {
                                    model.languageArr = [self getLangugeWithPath:carPath];
                                }
                                [resultArr addObject:model];
                                
                                
                                
                                if ([type isEqualToString:@"Diagnosis"]) {
                                    [localDIAGTDD_CarModelArr addObject:model];
                                }else if ([type isEqualToString:@"Immo"]) {
                                    [localIMMOTDD_CarModelArr addObject:model];
                                }else if ([type isEqualToString:@"RFID"]) {
                                    [localRFIDTDD_CarModelArr addObject:model];
                                }else if ([type isEqualToString:@"MOTOR"]) {
                                    [localMOTORTDD_CarModelArr addObject:model];
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        
        
        
    }
    [TDD_DiagnosisManage sharedManage].localDIAGCarModelArr = localDIAGTDD_CarModelArr;
    [TDD_DiagnosisManage sharedManage].localIMMOCarModelArr = localIMMOTDD_CarModelArr;
    [TDD_DiagnosisManage sharedManage].localRFIDCarModelArr = localRFIDTDD_CarModelArr;
    [TDD_DiagnosisManage sharedManage].localMotoCarModelArr = localMOTORTDD_CarModelArr;
    
    NSLog(@"localDIAGTDD_CarModelArr : %@", localDIAGTDD_CarModelArr);
    NSLog(@"localIMMOTDD_CarModelArr : %@", localIMMOTDD_CarModelArr);
    NSLog(@"localRFIDTDD_CarModelArr : %@", localRFIDTDD_CarModelArr);
    NSLog(@"localMOTORTDD_CarModelArr : %@", localMOTORTDD_CarModelArr);
    
    for (TDD_CarModel * model in linkArr) {
        for (TDD_CarModel * linkModel in resultArr) {
            if ([model.strLink isEqualToString:linkModel.strVehicle]) {
                model.linkCarPath = linkModel.path;
                //链接车获取支持语言数组
                model.languageArr = [self getLangugeWithPath:model.linkCarPath];
                break;
            }
        }
    }
    
    return resultArr;
}

#pragma mark 创建文件夹
+ (BOOL)createDirectoryAtPath:(NSString *)path{
    HLog(@"创建文件夹：%@", path);
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        NSError * error;
        
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            HLog(@"创建文件夹错误:%@", error);
            return NO;
        }
    }
    
    return YES;
}
#pragma mark 读取车型支持的语言
+ (NSArray *)getLangugeWithPath:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSError * error;
    
    NSArray * fileArr = [fileManager contentsOfDirectoryAtPath:path error:&error];

    if (error) {
        HLog(@"车型文件夹遍历错误：%@",error);
    }else{
        NSMutableArray * languageArr = [[NSMutableArray alloc] init];
        NSDictionary *fileDict = [TDD_HLanguage getCarAllLanguageFileName];
        for (NSString * fileName in fileArr) {
            NSString * language = @"";
            language = fileDict[fileName.lowercaseString];
            if ([NSString tdd_isEmpty:language]) {
                language = @"";
            }
            
            if (language.length > 0 && ![languageArr containsObject:language]) {
                [languageArr addObject:language];
            }
        }
        
        return languageArr;
    }
    
    return @[];
}

#pragma mark 车型功能与系统
//key:ini value:枚举
+ (NSDictionary *)carMaintenanceDict {
    return @{@"NORMAL_NONE":@(DET_NORMAL_NONE),
             @"BASE_VER":@(DET_BASE_VER),
             @"BASE_RDTC":@(DET_BASE_RDTC),
             @"BASE_CDTC":@(DET_BASE_CDTC),
             @"BASE_RDS":@(DET_BASE_RDS),
             @"BASE_ACT":@(DET_BASE_ACT),
             @"BASE_FFRAME":@(DET_BASE_FFRAME),
             @"OILRESET":@(DET_MT_OIL_RESET),
             @"THROTTLE":@(DET_MT_THROTTLE_ADAPTATION),
             @"EPB":@(DET_MT_EPB_RESET),
             @"ABS":@(DEF_MT_ABS_BLEEDING),
             @"STEERING":@(DEF_MT_STEERING_ANGLE_RESET),
             @"DPF":@(DEF_MT_DPF_REGENERATION),
             @"AIRBAG":@(DEF_MT_AIRBAG_RESET),
             @"BMS":@(DEF_MT_BMS_RESET),
             @"ADAS":@(DEF_MT_ADAS),
             @"IMMO":@(DEF_MT_IMMO),
             @"SMART_KEY":@(DEF_MT_SMART_KEY),
             @"PASSWORD_READING":@(DEF_MT_PASSWORD_READING),
             @"DEF_MT_DYNAMIC_ADAS":@(DEF_MT_DYNAMIC_ADAS),//ini文档还没有
             @"INJECTOR_CODE":@(DEF_MT_INJECTOR_CODE),
             @"SUSPENSION":@(DEF_MT_SUSPENSION),
             @"TIRE_PRESSURE":@(DEF_MT_TIRE_PRESSURE),
             @"TRANSMISSION":@(DEF_MT_TRANSMISSION),
             @"GEARBOX_LEARNING":@(DEF_MT_GEARBOX_LEARNING),
             @"TRANSPORT_MODE":@(DEF_MT_TRANSPORT_MODE),
             @"HEAD_LIGHT":@(DEF_MT_HEAD_LIGHT),
             @"SUNROOF_INIT":@(DEF_MT_SUNROOF_INIT),
             @"SEAT_CALI":@(DEF_MT_SEAT_CALI),
             @"WINDOW_CALI":@(DEF_MT_WINDOW_CALI),
             @"START_STOP":@(DEF_MT_START_STOP),
             @"EGR":@(DEF_MT_EGR),
             @"ODOMETER":@(DEF_MT_ODOMETER),
             @"LANGUAGE":@(DEF_MT_LANGUAGE),
             @"TIRE_MODIFIED":@(DEF_MT_TIRE_MODIFIED),
             @"A_F_ADJ":@(DEF_MT_A_F_ADJ),
             @"ELECTRONIC_PUMP":@(DEF_MT_ELECTRONIC_PUMP),
             @"NOX_RESET":@(DEF_MT_NOx_RESET),
             @"UREA_RESET":@(DEF_MT_UREA_RESET),
             @"TURBINE_LEARNING":@(DEF_MT_TURBINE_LEARNING),
             @"CYLINDER":@(DEF_MT_CYLINDER),
             @"EEPROM":@(DEF_MT_EEPROM),
             @"EXHAUST_PROCESSING":@(DEF_MT_EXHAUST_PROCESSING),
             @"RFID":@(DEF_MT_RFID),
             @"CLUTCH":@(DEF_MT_CLUTCH),
             @"SPEED_PTO":@(DEF_MT_SPEED_PTO),
             @"FRM_RESET":@(DEF_MT_FRM_RESET),
             @"VIN":@(DEF_MT_VIN),
             @"HV_BAT":@(DEF_MT_HV_BATTERY),
             @"ACC":@(DEF_MT_ACC),
             @"AC_LEARNING":@(DEF_MT_AC_LEARNING),
             @"RAIN_LIGH":@(DEF_MT_RAIN_LIGHT_SENSOR),
             @"ECURESET":@(DEF_MT_RESET_CONTROL_UNIT),
             @"REL_COMP":@(DEF_MT_RELATIVE_COMPRESSION),
             @"HVPO":@(DEF_MT_HV_DE_ENERGIZATION),
             @"COOL_REPL":@(DEF_MT_COOLANT_REFRIGERANT_CHANGE),
             @"RESOLVER_CALI":@(DEF_MT_RESOLVER_SENSOR_CALIBRATION),
             @"CAMSHAFT":@(DEF_MT_CAMSHAFT_LEARNING),};
}

+ (NSDictionary *)carSystemDict {
    return @{@"NONE_SYSTEM":@(DMM_SUPPORT_NONE_SYSTEM),
             @"ECM":@(DMM_ECM_CLASS),
             @"TCM":@(DMM_TCM_CLASS),
             @"ABS":@(DMM_ABS_CLASS),
             @"SRS":@(DMM_SRS_CLASS),
             @"HVAC":@(DMM_HVAC_CLASS),
             @"ADAS":@(DMM_ADAS_CLASS),
             @"IMMO":@(DMM_IMMO_CLASS),
             @"BMS":@(DMM_BMS_CLASS),
             @"EPS":@(DMM_EPS_CLASS),
             @"LED":@(DMM_LED_CLASS),
             @"IC":@(DMM_IC_CLASS),
             @"INFORMA":@(DMM_INFORMA_CLASS),
             @"BCM":@(DMM_BCM_CLASS),
             @"OTHER":@(DMM_OTHER_CLASS)};
}

+ (NSDictionary *)carMaintenanceExDict {
    return @{@"BASE_VER": @(DETE_BASE_VER_POS),
             @"BASE_RDTC": @(DETE_BASE_RDTC_POS),
             @"BASE_CDTC": @(DETE_BASE_CDTC_POS),
             @"BASE_RDS": @(DETE_BASE_RDS_POS),
             @"BASE_ACT": @(DETE_BASE_ACT_POS),
             @"BASE_FFRAME": @(DETE_BASE_FFRAME_POS),
             @"OILRESET": @(DETE_OIL_RESET_POS),
             @"THROTTLE": @(DETE_THROTTLE_ADAPTATION_POS),
             @"EPB": @(DETE_EPB_RESET_POS),
             @"ABS": @(DETE_ABS_BLEEDING_POS),
             @"STEERING": @(DEFE_STEERING_ANGLE_RESET_POS),
             @"DPF": @(DEFE_DPF_REGENERATION_POS),
             @"AIRBAG": @(DEFE_AIRBAG_RESET_POS),
             @"BMS": @(DEFE_BMS_RESET_POS),
             @"ADAS": @(DEFE_ADAS_POS),
             @"IMMO": @(DEFE_IMMO_POS),
             @"SMART_KEY": @(DEFE_SMART_KEY_POS),
             @"PASSWORD_READING": @(DEFE_PASSWORD_READING_POS),
             @"DYADAS": @(DEFE_DYNAMIC_ADAS_POS),
             @"INJECTOR_CODE": @(DEFE_INJECTOR_CODE_POS),
             @"SUSPENSION": @(DEFE_SUSPENSION_POS),
             @"TIRE_PRESSURE": @(DEFE_TIRE_PRESSURE_POS),
             @"TRANSMISSION": @(DEFE_TRANSMISSION_POS),
             @"GEARBOX_LEARNING": @(DEFE_GEARBOX_LEARNING_POS),
             @"TRANSPORT_MODE": @(DEFE_TRANSPORT_MODE_POS),
             @"HEAD_LIGHT": @(DEFE_HEAD_LIGHT_POS),
             @"SUNROOF_INIT": @(DEFE_SUNROOF_INIT_POS),
             @"SEAT_CALI": @(DEFE_SEAT_CALI_POS),
             @"WINDOW_CALI": @(DEFE_WINDOW_CALI_POS),
             @"START_STOP": @(DEFE_START_STOP_POS),
             @"EGR": @(DEFE_EGR_POS),
             @"ODOMETER": @(DEFE_ODOMETER_POS),
             @"LANGUAGE": @(DEFE_LANGUAGE_POS),
             @"TIRE_MODIFIED": @(DEFE_TIRE_MODIFIED_POS),
             @"A_F_ADJ": @(DEFE_A_F_ADJ_POS),
             @"ELECTRONIC_PUMP": @(DEFE_ELECTRONIC_PUMP_POS),
             @"NOX_RESET": @(DEFE_NOx_RESET_POS),
             @"UREA_RESET": @(DEFE_UREA_RESET_POS),
             @"TURBINE_LEARNING": @(DEFE_TURBINE_LEARNING_POS),
             @"CYLINDER": @(DEFE_CYLINDER_POS),
             @"EEPROM": @(DEFE_EEPROM_POS),
             @"EXHAUST_PROCESSING": @(DEFE_EXHAUST_PROCESSING_POS),
             @"RFID": @(DEFE_RFID_POS),
             @"SPEC_FUNC": @(DETE_SPEC_FUNC_POS),
             @"CLUTCH": @(DEFE_CLUTCH_POS),
             @"SPEED_PTO": @(DEFE_SPEED_PTO_POS),
             @"FRM_RESET": @(DEFE_FRM_RESET_POS),
             @"VIN": @(DEFE_VIN_POS),
             @"HV_BAT": @(DEFE_HV_BATTERY_POS),
             @"ACC": @(DEFE_ACC_POS),
             @"AC_LEARNING": @(DEFE_AC_LEARNING_POS),
             @"RAIN_LIGH": @(DEFE_RAIN_LIGHT_SENSOR_POS),
             @"ECURESET": @(DEFE_RESET_CONTROL_UNIT_POS),
             @"DEFE_CSS_ACC_POS": @(DEFE_CSS_ACC_POS),//ini 文档划掉
             @"REL_COMP": @(DEFE_RELATIVE_COMPRESSION_POS),
             @"HVPO": @(DEFE_HV_DE_ENERGIZATION_POS),
             @"COOL_REPL": @(DEFE_COOLANT_REFRIGERANT_CHANGE_POS),
             @"RESOLVER_CALI": @(DEFE_RESOLVER_SENSOR_CALIBRATION_POS),
             @"CAMSHAFT": @(DEFE_CAMSHAFT_LEARNING_POS),
             @"59": @(59),//保留
             @"60": @(60),//宏定义保留了这一位不用，为 false 即可
             @"CUSTOMIZE": @(DEFE_MT_CUSTOMIZE_POS),
             @"MOTOR_ANGLE": @(DEFE_MT_MOTOR_ANGLE_POS),
             @"EV_COMPRESSION_TEST": @(DEFE_MT_EV_COMPRESSION_POS),
             @"EV_OBC": @(DEFE_MT_EV_OBC_POS),
             @"EV_DCDC": @(DEFE_MT_EV_DCDC_POS),
             @"EV_48V": @(DEFE_MT_EV_48V_POS),
             @"ODO_CHECK": @(DEFE_MT_ODO_CHECK_POS),
             @"IDLE_ADJ": @(DEFE_MT_IDLE_ADJ_POS),
             @"CO_ADJ": @(DEFE_MT_CO_ADJ_POS),
             @"ECU_FLASH": @(DEFE_MT_ECU_FLASH_POS),
             @"SOFT_EXPIRE": @(DEFE_MT_SOFT_EXPIRATION_POS)
    };
}

+ (NSDictionary *)carSystemExDict {
    return @{@"ECM":@(0),
             @"TCM":@(1),
             @"ABS":@(2),
             @"SRS":@(3),
             @"HVAC":@(4),
             @"ADAS":@(5),
             @"IMMO":@(6),
             @"BMS":@(7),
             @"EPS":@(8),
             @"LED":@(9),
             @"IC":@(10),
             @"INFORMA":@(11),
             @"BCM":@(12)};
}

+ (NSArray *)carMaintenanceArr {
    return [TDD_DiagnosisTools carMaintenanceDict].allValues;
    
}

+ (NSArray *)carSystemArr {
    return [TDD_DiagnosisTools carSystemDict].allValues;
    
}

+ (NSArray *)carMaintenanceExArr {
    return [TDD_DiagnosisTools carMaintenanceExDict].allValues;
}

+ (NSArray *)carSystemExArr {
    return [TDD_DiagnosisTools carSystemExDict].allValues;
}

//支持专业版故障码维修指引的车型
+ (NSArray *)carSupportProfessionalArr {
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        return @[@"CHRYSLER",@"JEEP",@"DODGE",@"FIAT",@"DEMO",@"TOYOTA",@"LEXUS",@"SCION",@"NISSAN",@"INFINITI",@"HONDA",@"ACURA",@"BUICK",@"CADILLAC",@"CHEVROLET",@"GM",@"GMC",@"SAAB"];
    }
    return @[@"CHRYSLER",@"JEEP",@"DODGE",@"FIAT",@"DEMO",@"TOYOTA",@"LEXUS",@"SCION",@"NISSAN",@"INFINITI",@"HONDA",@"ACURA",@"BUICK",@"CADILLAC",@"CHEVROLET",@"GM",@"GMC",@"SAAB"];
}

#pragma mark 读取INI文件
+ (TDD_CarModel *)getINIWithPath:(NSString *)path
{
    NSString *orignPath = path;
    NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
    path = [path stringByAppendingPathComponent:@"Diag.ini"];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        return nil;
    }
    
    NSData* data = [[NSData alloc] init];
    
    data = [fileManager contentsAtPath:path];
    
    NSString * dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray * dataArr = [dataStr componentsSeparatedByString:@"\n"];
    //车型名称
    NSString * strVehicle = @"";
    
    if (dataArr.count > 0) {
        strVehicle = dataArr.firstObject;
        
        strVehicle = [strVehicle stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        strVehicle = [strVehicle stringByReplacingOccurrencesOfString:@"[" withString:@""];
        strVehicle = [strVehicle stringByReplacingOccurrencesOfString:@"]" withString:@""];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [TDD_HTipManage showBottomTipViewWithTitle:[NSString stringWithFormat:@"%@,%@",fileName,TDDLocalized.the_model_file_is_incorrect]];
        });
        HLog(@"ini文件解析失败");
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:orignPath error:&err];
        return nil;
    }
    
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    NSString *keyStr = @"";
    //新版INI文件有很多重名的key
    //以[]内容为key解析出多个字典
    for (NSString * str in dataArr) {
        //;开头的为注释
        if ([str hasPrefix:@";"]) {
            continue;
        }
        if ([str containsString:@"["]&&[str containsString:@"]"]){
            keyStr = [str.uppercaseString stringByReplacingOccurrencesOfString:@"[" withString:@""];
            keyStr = [keyStr stringByReplacingOccurrencesOfString:@"]" withString:@""];
            keyStr = [keyStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            NSMutableDictionary *dict = @{}.mutableCopy;
            [dataDic setObject:dict forKey:keyStr];
        }
        if ([str containsString:@"="]) {
            NSMutableDictionary *dict = [dataDic objectForKey:keyStr];
            NSString * string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            NSArray<NSString *> * arr = [string componentsSeparatedByString:@"="];
            if (arr.count == 2) {
                if (arr[0].length > 0 && arr[1].length > 0) {
                    [dict setObject:arr[1] forKey:arr[0].uppercaseString];
                }
            }
        }
        
    }
    
    TDD_CarModel * model = [[TDD_CarModel alloc] init];
    //version
    if ([dataDic.allKeys containsObject:[strVehicle uppercaseString]]) {
        NSDictionary *dict = [dataDic objectForKey:[strVehicle uppercaseString]];
        if ([dict.allKeys containsObject:@"VERSION"]) {
            model.strVersion = dict[@"VERSION"];
        }
        model.strVersion = [model.strVersion stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    //LINK
    if ([dataDic.allKeys containsObject:@"LINK"]) {
        NSDictionary *dict = [dataDic objectForKey:@"LINK"];
        if ([dict.allKeys containsObject:@"NAME"]) {
            model.strLink = dict[@"NAME"];
            model.strLink = [model.strLink uppercaseString];
        }
    }
    
    //LANGUAGE
    NSString * userLanguage = [TDD_HLanguage getLanguage];
    if ([dataDic.allKeys containsObject:@"LANGUAGE"]) {
        NSDictionary *dict = [dataDic objectForKey:@"LANGUAGE"];
        if ([dict.allKeys containsObject:@"EN"]) {
            model.strENName = dict[@"EN"];
            if (![NSString tdd_isEmpty:model.strENName]) {
                model.strENName = [model.strENName uppercaseString];
            }
            
        }
        NSString *serverLanguageStr = [TDD_HLanguage getServerLanguageShortCode];
        model.strName = dict[serverLanguageStr];
        if (![NSString tdd_isEmpty:model.strName]) {
            model.strName = [model.strName uppercaseString];
        }
    }
    if (model.strName.length == 0) {
        model.strName = model.strENName;
    }
    
    //MAINTENANCE 支持的功能掩码总和
    if ([dataDic.allKeys containsObject:@"MAINTENANCE"]) {
        NSDictionary *maintenanceDict = [TDD_DiagnosisTools carMaintenanceDict];
        NSDictionary *maintenanceExDict = [TDD_DiagnosisTools carMaintenanceExDict];
        NSArray * maintenanceKeyArr = maintenanceDict.allKeys;
        NSArray * maintenanceExKeyArr = maintenanceExDict.allKeys;
        //创建一个跟  maintenanceEx 位数一样的数组
        NSMutableArray *maintenanceExValueArr = [NSMutableArray arrayWithArray:maintenanceExKeyArr];
        long maintenance = 0;
        NSDictionary *dict = [dataDic objectForKey:@"MAINTENANCE"];
        for (int i = 0; i < maintenanceExKeyArr.count; i++) {
            NSString *key = maintenanceExKeyArr[i];
            key = key.uppercaseString;
            //新版功能掩码，下标值
            NSNumber * maintenanceExValue = maintenanceExDict[key];
            //ini 里值为 1
            if (((NSString *)dict[key]).intValue > 0) {
                //旧版功能掩码
                NSNumber *maintenanceValue = maintenanceDict[key];
                if (maintenanceValue) {
                    maintenance = (maintenance += (maintenanceValue.longValue));
                }
                //新版功能掩码
                [maintenanceExValueArr replaceObjectAtIndex:maintenanceExValue.intValue withObject:@"1"];
            }else {
                //ini 里值为 0
                //新版功能掩码
                [maintenanceExValueArr replaceObjectAtIndex:maintenanceExValue.intValue withObject:@"0"];
            }
        }
        model.maintenanceExArr = maintenanceExValueArr;
        model.maintenance = maintenance;
    }
    
    //SYSTEM 支持的系统掩码总和
    if ([dataDic.allKeys containsObject:@"SYSTEM"]) {
        NSDictionary *systemDict = [TDD_DiagnosisTools carSystemDict];
        NSDictionary *systemExDict = [TDD_DiagnosisTools carSystemExDict];
        NSArray * systemKeyArr = systemDict.allKeys;
        NSArray * systemExKeyArr = systemExDict.allKeys;
        //创建一个跟  systemEx 位数一样的数组
        NSMutableArray *systemExValueArr = [NSMutableArray arrayWithArray:systemExKeyArr];
        NSDictionary *dict = [dataDic objectForKey:@"SYSTEM"];
        long system = 0;
        for (int i = 0; i < systemExKeyArr.count; i++) {
            NSString *key = systemExKeyArr[i];
            key = key.uppercaseString;
            //新版功能掩码，下标值
            NSNumber * systemExValue = systemExDict[key];
            //ini 里值为 1
            if (((NSString *)dict[key]).intValue > 0) {
                //旧版功能掩码
                NSNumber *systemValue = systemDict[key];
                if (systemValue) {
                    system = (system += (systemValue.longValue));
                }
                //新版功能掩码
                [systemExValueArr replaceObjectAtIndex:systemExValue.intValue withObject:@"1"];
            }else {
                //ini 里值为 0
                //新版功能掩码
                [systemExValueArr replaceObjectAtIndex:systemExValue.intValue withObject:@"0"];
            }
        }
        model.systemExArr = systemExValueArr;
        model.system = system;
        
    }
    
    model.strVehicle = [strVehicle uppercaseString];
    
    //支持专业版故障码维修指引
    //链接车需要一个个开放
    if ([[TDD_DiagnosisTools carSupportProfessionalArr] containsObject:model.strVehicle]) {
        model.supportProfessionalTrouble = YES;
    }
    
    return model;
}

#pragma mark 静态库和资源的版本对比
+ (BOOL)versionContrast:(TDD_CarModel *)model
{
    //资源版本和静态库版本对比
    
    const char *strType = [model.strType UTF8String];
    
    const char *cVehicle = [model.strVehicle UTF8String];
    
    if (model.strLink.length > 0) {
        cVehicle = [model.strLink UTF8String];
    }
    
    std::string strVersion = ArtiVersion(strType, cVehicle);
    
    NSString * ocVersion = [TDD_CTools CStrToNSString:strVersion];
    
    model.strStaticLibraryVersion = ocVersion;
    
    HLog(@"%@ %@", model.strVehicle, model.strStaticLibraryVersion);
    
    //    if (ocVersion.length == 0 || model.strVersion.length == 0) {
    //        HLog(@"⚠️⚠️⚠️\n%@\n静态库版本号：%@\n资源版本号：%@\n⚠️⚠️⚠️", model.strVehicle, ocVersion, model.strVersion);
    //        return NO;
    //    }
    //
    //    if (![ocVersion localizedCaseInsensitiveContainsString:model.strVersion]) {
    //        HLog(@"⚠️⚠️⚠️\n%@\n静态库版本号：%@\n资源版本号：%@\n⚠️⚠️⚠️", model.strVehicle, ocVersion, model.strVersion);
    //        return NO;
    //    }
    
    return YES;
}

#pragma mark - softWare
+ (BOOL )softWareIsTopVCI {
    return TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopVci;
}

+ (BOOL )softWareIsTopVCIPro {
    return TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopVciPro;
}

+ (BOOL )softWareIsCarPalSeries {
    return (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareCarPal) || (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareCarPalGuru);
}

+ (BOOL )softWareIsCarPal {
    return (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareCarPal) && ( (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareCarPalGuru) == 0);
}

+ (BOOL )softWareIsCarPalGuru {
    return ( (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareCarPal) == 0) && (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareCarPalGuru);
}

+ (BOOL )softWareIsTopScan {
    return TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopScan;
}

+ (BOOL )softWareIsKindOfTopScan {
    return (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopScan || TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopVciPro || TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopScanHD || [TDD_DiagnosisTools softWareIsSingleApp]);
}

+ (BOOL )softWareIsSingleApp {
    return (TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopScanVAG || TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopScanBMW || TDD_DiagnosisManage.sharedManage.currentSoftware & TDDSoftwareTopScanFORD);
    
}


#pragma mark - 数据获取
+ (eProductName )appProduct {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(appProduct)]) {
        return  [[TDD_DiagnosisManage sharedManage].manageDelegate appProduct];
    }
    return PD_NAME_AD200;
}

+ (eAppProductGroup )appProductGroup {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(appProductGroup)]) {
        return  [[TDD_DiagnosisManage sharedManage].manageDelegate appProductGroup];
    }
    return PD_GROUP_TOPSCAN_LIKE;
    
}

+ (BOOL )isIpad {
    
    return [TDD_DiagnosisTools appProduct] == PD_NAME_TOPSCAN_HD;
}

/// 获取选中VCI sn
+ (NSString *)selectedVCISerialNum {
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(selectedVCISerialNum)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate selectedVCISerialNum];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}
/// 获取选中TDarts sn
+ (NSString *)selectedTDartsSerialNum {
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(selectedTDartsSerialNum)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate selectedTDartsSerialNum];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}
///SN是否禁用
+ (BOOL )isSNDisable {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(isSNDisable)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate isSNDisable];
    }
    return NO;
}
/// 获取用户ID
+ (int )userID {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(userID)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate userID];
    }
    return 0;
}

+ (NSString *)topdonID {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(topdonID)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate topdonID]?:@"";
    }
    return @"";
}

/// 用户是否登录
+ (BOOL )userIsLogin {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(userIsLogin)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate userIsLogin];
    }
    return NO;
}

+ (NSString *)userAccount {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(userAccount)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate userAccount];
    }
    return @"";
}

+ (NSString *)appKey {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(appKey)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate appKey]?:@"";
    }
    return @"";
}

+ (NSString *)deviceUUID {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(deviceUUID)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate deviceUUID]?:@"";
    }
    return @"";
}

+ (NSString *)ipAddress {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(ipAddress)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate ipAddress]?:@"";
    }
    return @"";
    
}


/// 获取诊断单位
+ (NSString *)diagnosticUnit{
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosticUnit)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosticUnit];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}
/// 提供用户token
+ (NSString *)userToken{
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(userToken)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate userToken];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}

/// 提供用户二次验证 token
+ (NSString *)userTwoFATokenToken:(NSString *)account {
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(userTwoFATokenToken:)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate userTwoFATokenToken:account];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}

/// 提供服务器地址
+ (NSString *)serverURL{
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(serverURL)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate serverURL];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}

// crash自定义信息
+ (NSString *)crashCustomValue {
    NSString *str = @"";
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(crashCustomValue)]) {
        str = [[TDD_DiagnosisManage sharedManage].manageDelegate crashCustomValue];
    }
    return [NSString tdd_isEmpty:str]?@"":str;
}

+ (TDD_Customized_Type )customizedType {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(customizedType)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate customizedType];
    }
    return TDD_Customized_None;
}

+ (BOOL )isInBleConnectingVC {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(isInBleConnectingVC)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate isInBleConnectingVC];
    }
    return NO;
}

+ (BOOL)isCloseBleVerifySN {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(isCloseBleVerifySN)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate isCloseBleVerifySN];
    }
    return NO;
}

+ (BOOL )isUseSelectSNToRequest {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(isUseSelectSNToRequest)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate isUseSelectSNToRequest];
    }
    return NO;
    
}

+ (void )tdLog:(NSString *)message {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdLog:)]) {
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdLog:message];
    }else {
        printf("%s\n", [message UTF8String]);
    }
    
}

+ (NSString *)errorMessageWithCode:(NSInteger )code {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(errorMessage:)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate errorMessage:code];
    }else {
        return @"";
    }
}

+ (BOOL)isLimitedTrialFuction {
    //软件过期
    if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].softIsExpire) {
        return YES;
    }
    return NO;
}

+ (BOOL)isDEMO {
    return [[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName isEqualToString:@"DEMO"];
    
}

+ (BOOL)isDebug {
    return [TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE;
    
}

+ (NSInteger )isAutoAuthNa {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(isAutoAuthNa)]) {
        return [[TDD_DiagnosisManage sharedManage].manageDelegate isAutoAuthNa];
    }else {
        return -1;
    }
}

+ (void)resetAlert {
    [TDD_AlertTools resetAlert];
}

+ (void)showBatteryVoltLowAlert {

    [TDD_AlertTools showBatteryVoltLowAlert];

}

+ (void)showBleBreakAlert {

    [TDD_AlertTools showBleBreakAlert];
    
}

+ (void)showBackgroundAlert {

    [TDD_AlertTools showBackgroundAlert];
    
}

+ (void)showSoftExpiredToBuyAlert:(nullable void (^)(void))completionHandler {
    [TDD_AlertTools showSoftExpiredToBuyAlert:completionHandler];
}

#pragma mark 静态库版本打印
+ (void)logStaticLibraryVersion
{
    
    //诊断版本
    [self carStaticLibraryVersionWithType:@"DIAG" showLog:YES];
    
    //IMMO版本
    [self carStaticLibraryVersionWithType:@"IMMO" showLog:YES];
    
    //MOTO版本
    [self carStaticLibraryVersionWithType:@"MOTO" showLog:YES];
    
}

#pragma mark 静态库版本打印
+ (NSString *)carGetMainVersionWithModel:(TDD_CarModel *)model {
    //主车
    if ([NSString tdd_isEmpty:model.strLink]) {
        
        return model.strVersion;
    }
    //链接车
    NSArray * carArr = @[];
    
    if ([model.strType isEqualToString:@"DIAG"]) {
        carArr = [TDD_DiagnosisManage sharedManage].localDIAGCarModelArr;
        
    }else if ([model.strType isEqualToString:@"IMMO"]) {
        carArr = [TDD_DiagnosisManage sharedManage].localIMMOCarModelArr;
        
    }else if ([model.strType isEqualToString:@"MOTO"]) {
        carArr = [TDD_DiagnosisManage sharedManage].localMotoCarModelArr;
        
    }
    for (TDD_CarModel *carModel in carArr) {
        
        if ([carModel.strVehicle isEqualToString:model.strLink]) {
            return carModel.strVersion;
        }
    }
    return @"";
}
+ (NSString *)carStaticLibraryVersionWithType:(NSString *)stringType{
    return [self carStaticLibraryVersionWithType:stringType showLog:NO];
}

+ (NSString *)carStaticLibraryVersionWithType:(NSString *)stringType showLog:(BOOL)showLog
{
    
    //诊断版本
    NSArray * staticLibraryArr = @[];
    
    if ([stringType isEqualToString:@"DIAG"]) {
        staticLibraryArr = [TDD_DiagnosisTools carDiagVersionArr];
        
    }else if ([stringType isEqualToString:@"IMMO"]) {
        staticLibraryArr = [TDD_DiagnosisTools carIMMOVersionArr];
        
    }else if ([stringType isEqualToString:@"MOTO"]) {
        staticLibraryArr = [TDD_DiagnosisTools motoDiagVersionArr];
        
    }
    
    NSString * log = @"";
    
    for (int i = 0; i < staticLibraryArr.count; i ++) {
        const char *strType = [stringType UTF8String];
        
        const char *cVehicle = [staticLibraryArr[i] UTF8String];

        std::string strVersion = ArtiVersion(strType, cVehicle);
        
        NSString * ocVersion = [TDD_CTools CStrToNSString:strVersion];
        
        ocVersion = [ocVersion uppercaseString];
        
        log = [NSString stringWithFormat:@"%@\n%@\t%@", log, staticLibraryArr[i], ocVersion];
        
        if ([stringType isEqualToString:@"DIAG"]) {
            [TDD_DiagnosisManage.sharedManage.carStaticLibraryVersionDic setValue:ocVersion forKey:staticLibraryArr[i]];
        }else if ([stringType isEqualToString:@"IMMO"]) {
            [TDD_DiagnosisManage.sharedManage.IMMOStaticLibraryVersionDic setValue:ocVersion forKey:staticLibraryArr[i]];
        }else if ([stringType isEqualToString:@"MOTO"]) {
            [TDD_DiagnosisManage.sharedManage.MOTOStaticLibraryVersionDic setValue:ocVersion forKey:staticLibraryArr[i]];
        }
    }
    
    if ([stringType isEqualToString:@"DIAG"]) {
        log = [NSString stringWithFormat:@"诊断车型版本：\n%@\nStd\t%@\nStdShow\t%@\nStdComm\t%@", log, [TDD_STDPublicInterface getSTDVersion],[TDD_StdShowModel Version], [TDD_StdCommModel Version]];
    }else if ([stringType isEqualToString:@"IMMO"]) {
        log = [NSString stringWithFormat:@"IMMO车型版本：\n%@", log];
    }else if ([stringType isEqualToString:@"MOTO"]) {
        log = [NSString stringWithFormat:@"MOTO车型版本：\n%@", log];
        
    }
    if (showLog) {
        HLog(@"%@", log);
    }
    
    return log?:@"";
}

+ (NSArray *)carDiagVersionArr {
    switch ([TDD_DiagnosisManage sharedManage].currentSoftware) {
        case TDDSoftwareTopVci:
            return @[@"ACCSPEED",@"AUTOVIN",
                     @"BENZ",@"BMW",@"BYD",
                     @"CHRYSLER",@"COMM",@"CHECKVCI",@"CMC",
                     @"DEMO",@"DAIHATSU",@"DFXK",
                     @"EOBD",
                     @"FORD",@"FIAT",@"FIATBRAZIL",
                     @"GM",
                     @"HONDA",@"HYUNDAI",
                     @"ISUZU",@"IM_PRECHECK",
                     @"JAC",@"JMC",
                     @"LANDROVER",@"LANDWIND",@"LIFAN",
                     @"MAZDA",@"MARUTI",@"MAHINDRA",@"MITSUBISHI",
                     @"NISSAN",
                     @"OPEL",
                     @"PORSCHE",@"PEUGEOT",@"PERODUA",
                     @"RENAULT",
                     @"SUBARU",@"SUZUKI",@"SSANGYONG",@"SAAB",@"SMART",@"SPRINTER",@"SWMMOTOR",
                     @"TOYOTA",@"TATA",
                     @"VW",@"VOLVO",
                     @"YEMAAUTO",
                     @"ZOTYE",@"ZZNISSAN",
                     @"FORCE"
            ];
            break;
        case TDDSoftwareTopScanVAG:
            return @[@"AUTOVIN",@"DEMO",@"EOBD",@"VW"];
        case TDDSoftwareTopScanBMW:
            return @[@"AUTOVIN",@"DEMO",@"EOBD",@"BMW"];
        case TDDSoftwareTopScanFORD:
            return @[@"AUTOVIN",@"DEMO",@"EOBD",@"FORD"];
        case TDDSoftwareTopVciPro:
            return @[@"ACCSPEED",@"AUTOVIN",
                     @"BENZ",@"BMW",@"BYD",@"BAICMOTOR",
                     @"CHRYSLER",@"CMC",@"CHANGAN",@"CHERY",
                     @"DEMO",@"DAIHATSU",@"DFXK",@"DFFS",@"DFFX",
                     @"EOBD",
                     @"FORD",@"FIAT",@"FIATBRAZIL",@"FERRARI",@"FAWCAR",
                     @"GM",@"GEELY",@"GREATWALL",@"GACMOTOR",
                     @"HONDA",@"HYUNDAI",@"HAFEI",
                     @"ISUZU",@"IM_PRECHECK",@"IVECO_LD",
                     @"JAC",@"JMC",
                     @"LANDROVER",@"LYNKCO",
                     @"MITSUBISHI",@"MAZDA",@"MASERATI",
                     @"NISSAN",
                     @"OPEL",
                     @"PORSCHE",@"PEUGEOT",@"PERODUA",@"POLESTAR",
                     @"RENAULT",
                     @"SUBARU",@"SUZUKI",@"SSANGYONG",@"SAAB",@"SMART",@"SPRINTER",@"SWMMOTOR",@"SAICMG",@"SGMW",@"SAICMAXUS",
                     @"TOYOTA",@"TATA",
                     @"VW",@"VOLVO"];
            break;
        default:
            //默认:TopScan
            return @[
                @"ACCSPEED",@"AUTOVIN",@"BAICMOTOR",@"BENZ",@"BMW",@"BYD",@"CHANGAN",@"CHERY",@"CHRYSLER",@"CMC",@"DAIHATSU",@"DEMO",@"DFFS",@"DFFX",@"DFXK",@"EOBD",@"FAWCAR",@"FERRARI",@"FIAT",@"FIATBRAZIL",@"FORCE",@"FORD",@"GACMOTOR",@"GEELY",@"GM",@"GREATWALL",@"HAFEI",@"HONDA",@"HYUNDAI",@"IM_PRECHECK",@"ISUZU",@"IVECO_LD",@"JAC",@"JMC",@"LANDROVER",@"LYNKCO",@"MAHINDRA",@"MASERATI",@"MAZDA",@"MITSUBISHI",@"NISSAN",@"OPEL",@"PERODUA",@"PEUGEOT",@"POLESTAR",@"PORSCHE",@"PROTON",@"RENAULT",@"SAAB",@"SAICMAXUS",@"SAICMG",@"SGMW",@"SMART",@"SPRINTER",@"SSANGYONG",@"SUBARU",@"SUZUKI",@"SWMMOTOR",@"TATA",@"TOYOTA",@"VOLVO",@"VW"
            ];
            break;
    }
    
}

+ (NSArray *)carIMMOVersionArr {
    switch ([TDD_DiagnosisManage sharedManage].currentSoftware) {
        case TDDSoftwareTopScanVAG:
        case TDDSoftwareTopScanBMW:
        case TDDSoftwareTopScanFORD:
            return @[];
            break;
        default:
            //默认:TopScan
            return @[
                @"ABARTH",@"ACURA",@"ALFAROMEO",@"AUDI",@"Algorithm",@"BAICHUANSU",@"BAICMOTOR",@"BAICSENOVA",@"BAICWEIWANG",@"BJEV",@"BYD",@"CHANGAN",@"CHERY",@"CHRYSLER",@"CITROEN",@"DENZA",@"DFHONDA",@"DFNISSAN",@"DFVENUCIA",@"DODGE",@"DS",@"EMGRAND",@"ENGLON",@"FERRARI",@"FIAT",@"FIATBRAZIL",@"FORD",@"FORDAU",@"FORDEU",@"FORD_CHANGAN",@"FREQUENCY_DETECTION",@"GACAION",@"GACMOTOR",@"GEELY",@"GENERATE_TRANSPONDER",@"GENESIS",@"GLEAGLE",@"GM",@"GMBRAZIL",@"GREATWALL",@"GZHONDA",@"HAVAL",@"HOLDEN",@"HONDA",@"HUMMER",@"HYUNDAI",@"HYUNDAI_BEIJING",@"INFINITI",@"ISUZU",@"JAC",@"JAGUAR",@"JEEP",@"JMC",@"KARRY",@"KIA",@"KIA_CHINA",@"LANCIA",@"LANDROVER",@"LEXUS",@"MAHINDRA",@"MAPLE",@"MARUTI_SUZUKI",@"MASERATI",@"MAZDA",@"MAZDA_CHINA",@"MG",@"MITSUBISHI",@"NISSAN",@"OPEL",@"PEUGEOT",@"RELY",@"RENAULT",@"RIICH",@"ROEWE",@"SAAB",@"SAICMAXUS",@"SCION",@"SEAT",@"SKODA",@"SMART",@"SSANGYONG",@"SUBARU",@"SUZUKI",@"TATA",@"TEST_IMMO_PKE_COIL",@"TOYOTA",@"TOYOTACN",@"TRANSPONDER_RECOGNITION",@"VAUXHALL",@"VW",@"WEY"
            ];
            break;
    }
}

+ (NSArray *)motoDiagVersionArr {
    switch ([TDD_DiagnosisManage sharedManage].currentSoftware) {
        case TDDSoftwareTopScanVAG:
        case TDDSoftwareTopScanBMW:
        case TDDSoftwareTopScanFORD:
            return @[];
            break;
        case TDDSoftwareTopVciPro:
            return @[@"AGUSTA",
                     @"BMW",@"BRP",@"BENELLI",@"BROUGH",
                     @"DUCATI",@"DEMO",
                     @"FANTIC",
                     @"GGTECHNIK",
                     @"HARLEY",@"HONDA",@"HM",@"HUSQVARNA",
                     @"INDIAN",@"ITALJET",
                     @"KAWASAKI",@"KTM",@"KYMCO",@"KELLER",@"KSRMOTO",@"KEEWAY",
                     @"LEXMOTO",
                     @"MORINI",@"MGK",@"MH",@"MALAGUTI",
                     @"PIAGGIO",@"PEUGEOT",@"POLARIS",
                     @"SUZUKI",@"SHERCO",@"SYM",
                     @"TRIUMPH",
                     @"VICTORY",@"VENT",@"VERVE",
                     @"YAMAHA",
                     @"ARCTICCAT",
                     @"MACBOR",
                     @"BROSE",
                     @"BAJAJ",
                     @"TVS",
                     @"DAFRA",
                     @"RVM",
                     @"URAL",
                     @"ABS_CHINA",
                     @"ZEEHO",
                     @"VOGE",
                     @"ENFIELD",
                     @"ENGINE_CHINA",
                     @"CFMOTO",
                     @"HERO",
                     @"ORCAL",
                     @"HAOJUE",
                     @"AKT",
                     @"EOBD"
                    ];
                       break;
        default:
            //默认:TopScan
            return @[
                @"ABS_CHINA",@"AGUSTA",@"ARCTICCAT",@"BAJAJ",@"BENELLI",@"BMW",@"BROSE",@"BROUGH",@"BRP",@"DAFRA",@"DEMO",@"DUCATI",@"ENFIELD",@"ENGINE_CHINA",@"EOBD",@"FANTIC",@"GGTECHNIK",@"HAOJUE",@"HARLEY",@"HM",@"HONDA",@"HUSQVARNA",@"INDIAN",@"ITALJET",@"KAWASAKI",@"KEEWAY",@"KELLER",@"KSRMOTO",@"KTM",@"KYMCO",@"LEXMOTO",@"MACBOR",@"MALAGUTI",@"MGK",@"MH",@"MORINI",@"PEUGEOT",@"PIAGGIO",@"POLARIS",@"RVM",@"SHERCO",@"SUZUKI",@"SYM",@"TRIUMPH",@"TVS",@"URAL",@"VENT",@"VERVE",@"VICTORY",@"VOGE",@"YAMAHA",@"ZEEHO"
            ];
            break;
    }
}

#pragma mark - 固件升级
+ (void)firmwareUpdateWithFilePath:(NSString *)filePath version:(NSString *)version progress:(nullable void (^)(NSProgress *progress))progressBlock completionHandler:(nullable void (^)(int result))completionHandler
{
    //异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        BOOL isExist = [fileManager fileExistsAtPath:filePath];
        
        if (isExist) {
            
            NSData * localData = [[NSFileHandle fileHandleForReadingAtPath:filePath] readDataToEndOfFile];
         
            //头部校验
            if isKindOfTopVCI {
                
                NSData *deviceTypeData = [localData subdataWithRange:NSMakeRange(0, 12)];
                NSString *deviceTypeStr = [[NSString alloc] initWithData:deviceTypeData encoding:NSUTF8StringEncoding];
                
                if (![deviceTypeStr isEqualToString:@"PD001N32G455"]) {
                    if (completionHandler) {
                        completionHandler(2);
                    }
                    return;
                }
            } else if isDeepScan {
                NSData *deviceTypeData = [localData subdataWithRange:NSMakeRange(0, 15)];
                NSString *deviceTypeStr = [[NSString alloc] initWithData:deviceTypeData encoding:NSUTF8StringEncoding];
                
                if (![deviceTypeStr isEqualToString:@"DEEPSCANN32H487"]) {
                    if (completionHandler) {
                        completionHandler(2);
                    }
                    return;
                }
            } else {
                NSInteger deviceID = [TDD_StdCommModel FwDeviceType];
                NSString *header = @"AD900VCIN32G455";
                if (deviceID == 0x48343837) {
                    header = @"TSP2VCIN32H487";
                } else if (deviceID == 0x4E333247) {
                    header = @"AD900VCIN32G455";
                } else if (deviceID == 0x444F4950) {
                    header = @"TSMVCIN32H487";
                }
                NSData *deviceTypeData = [localData subdataWithRange:NSMakeRange(0, header.length)];
                NSString *deviceTypeStr = [[NSString alloc] initWithData:deviceTypeData encoding:NSUTF8StringEncoding];
                
                if (![deviceTypeStr isEqualToString:header]) {
                    if (completionHandler) {
                        completionHandler(2);
                    }
                    return;
                }
            }
            
            //版本号
            NSData * versionData = [localData subdataWithRange:NSMakeRange(16, 16)];
            
            NSString * versionStr = [[NSString alloc] initWithData:versionData encoding:NSUTF8StringEncoding];
            
            NSArray * versionArr = [versionStr componentsSeparatedByString:@"V"];
            
            if (versionArr.count == 0) {
                if (completionHandler) {
                    completionHandler(2);
                }
                return;
            }
            
            versionStr = [NSString stringWithFormat:@"V%@", versionArr.lastObject];
            //V1.22 version
            if (![versionStr localizedCaseInsensitiveContainsString:version]) {
                if (completionHandler) {
                    completionHandler(2);
                }
                return;
            }
            
            //升级包长度
            NSData * sizeData = [localData subdataWithRange:NSMakeRange(32, 4)];
            
            uint32_t totalSize = 0;
            
            [sizeData getBytes:&totalSize length:sizeData.length];
            
            totalSize = CFSwapInt32HostToBig(totalSize);
            
            //校验值
            NSData * checkData = [localData subdataWithRange:NSMakeRange(36, 4)];
            
            uint32_t checkSum = 0;
            
            [checkData getBytes:&checkSum length:checkData.length];
            
            checkSum = CFSwapInt32HostToBig(checkSum);
            
            localData = [localData subdataWithRange:NSMakeRange(64, localData.length - 64)];
            
            int singleSize = 4 * 1024;
            
            unsigned long totalCount = (localData.length % singleSize)?(localData.length/singleSize + 1):(localData.length/singleSize);
            
            int count = 0;
            
            NSProgress * progress = [NSProgress progressWithTotalUnitCount:totalCount];
            
            long begin;
            
            long remaining;
            
            NSData * data;
            
            int result;
            
            HLog(@"开始升级");
            
            int time = 0;
            
            while (![TDD_StdCommModel FwIsBoot]) {
                
                //60s超时
                time ++;
                
                [TDD_StdCommModel FwEnterBoot];
                
                if (time == 60) {
                    if (completionHandler) {
                        completionHandler(0);
                    }
                    
                    return;
                }
                
                sleep(1);
            }
            
            while (count < totalCount) {
                
                if (!TDD_EADSessionController.sharedController.accessory.isConnected) {
                    HLog(@"升级失败，蓝牙已断开");
                    
                    if (completionHandler) {
                        completionHandler(0);
                    }
                    
                    return;
                }
                
                begin = singleSize * count;
                
                remaining = localData.length - begin;

                if (remaining > singleSize) {
                    remaining = singleSize;
                }
                
                data = [localData subdataWithRange:NSMakeRange(begin, remaining)];
                
                result = [TDD_StdCommModel FwDownloadWithFileTotalSize:totalSize PackNo:count vctPackData:data];
                
                count ++;
                
                if (result == 0) {
                    HLog(@"发包失败");
//                    count = 0;
                    if (completionHandler) {
                        completionHandler(0);
                    }
                    return;
                }
                
                progress.completedUnitCount = count;
                
                if (progressBlock) {
                    progressBlock(progress);
                }
            }
          
            HLog(@"固件包发送完成");
            
            result = [TDD_StdCommModel FwCheckSumWithFileTotalSize:totalSize CheckSum:checkSum];
            
            if (result == 0) {
                HLog(@"升级失败");
            }else {
                HLog(@"升级成功");
            }
            
            if (completionHandler) {
                completionHandler(result);
            }
            
        }else{
            HLog(@"升级失败，文件不存在：%@", filePath);
            
            if (completionHandler) {
                completionHandler(0);
            }
        }
    });
    
}

+ (ArtiInputType)stringType:(NSString *)str
{
    int nub = (int)str.length;
        
    if (nub == 0) {
        return ArtiInput_ALL;
    }
    
    NSString * firstStr = [str substringToIndex:1];
    
    for (int i = 1; i < nub; i ++) {
        NSString * nextStr = [str substringWithRange:NSMakeRange(i, 1)];
        if (![firstStr localizedCaseInsensitiveContainsString:nextStr]) {
            return ArtiInput_ALL;
        }
    }
    
    NSArray * contrastArr = @[@"0",@"F",@"#",@"V",@"A",@"B"];
    
    for (int i = 0; i < contrastArr.count; i ++) {
        NSString * contrastStr = contrastArr[i];
        if ([firstStr localizedCaseInsensitiveContainsString:contrastStr]) {
            return (ArtiInputType)(i + 1);
        }
    }
    
    return ArtiInput_ALL;
}

@end
