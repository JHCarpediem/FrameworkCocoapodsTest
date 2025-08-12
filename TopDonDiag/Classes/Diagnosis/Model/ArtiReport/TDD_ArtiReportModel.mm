//
//  TDD_ArtiReportModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiReportModel.h"

#if useCarsFramework
#import <CarsFramework/RegReport.hpp>
#else
#import "RegReport.hpp"
#endif

#import "TDD_CTools.h"
#import "TDD_ArtiReportGeneratorModel.h"
#import "TDD_ArtiReportInfoTableViewCell.h"
#import "TDD_ArtiReportSummaryTableViewCell.h"
#import "TDD_ArtiReportHeaderTableViewCell.h"
#import "TDD_ArtiReportTextTableViewCell.h"
#import "TDD_ArtiReportRepairHeaderTableViewCell.h"
#import "TDD_ArtiReportRepairSectionTableViewCell.h"
#import "TDD_ArtiReportRepairRowTableViewCell.h"
#import "TDD_ArtiReportCodeTitleTableViewCell.h"
#import "TDD_ArtiReportCodeSectionTableViewCell.h"
#import "TDD_ArtiReportCodeRowTableViewCell.h"
#import "TDD_ArtiReportFlowSectionTableViewCell.h"
#import "TDD_ArtiReportFlowRowTableViewCell.h"
#import "TDD_ArtiReportCellModel.h"
#import "TDD_ArtiReportRepairCodeJKDBModel.h"
#import "TDD_ArtiReportHistoryJKDBModel.h"
#import <YYModel/YYModel.h>
#import "TDD_UnitConversion.h"
#import "TDD_StdCommModel.h"
#import "TDD_ADASManage.h"

@implementation TDD_ArtiReportModel

#pragma mark 注册方法

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray * titleArr = @[@"person_save"];
        for (int i = 0; i < titleArr.count; i ++) {
            TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
            
            buttonModel.uButtonId = i;
            
            buttonModel.strButtonText = [TDD_HLanguage getLanguage:titleArr[i]];
            
            buttonModel.bIsEnable = YES;
            if ([TDD_DiagnosisTools isDebug]) {
                buttonModel.uiTextIdentify = @"diagReportSave";
            }
            [self.buttonArr addObject:buttonModel];
        }
        self.cellModels = [[NSMutableArray alloc] init];
        self.repairCellModels = [[NSMutableArray alloc] init];
        self.codesItems = [[NSMutableArray alloc] init];
        // 默认车辆额外信息
        if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(carExtraInfo)]) {
            NSDictionary *carExtraInfo =
            [[TDD_DiagnosisManage sharedManage].manageDelegate carExtraInfo];
            self.carExtraInfo = [carExtraInfo copy];
            if (carExtraInfo && carExtraInfo.allKeys.count > 0) {
                self.describe_brand = carExtraInfo[@"describe_brand"];
                self.describe_model = carExtraInfo[@"describe_model"];
                self.describe_year = carExtraInfo[@"describe_year"];
                self.inputVIN = carExtraInfo[@"VIN"];
                self.describe_license_plate_number = carExtraInfo[@"describe_license_plate_number"];
                self.describe_customer_name = carExtraInfo[@"describe_customer_name"];
                self.describe_customer_call = carExtraInfo[@"describe_customer_call"];
                self.describe_engine = carExtraInfo[@"describe_engine"];
                self.describe_engine_subType = carExtraInfo[@"describe_engine_subType"];
            }
        }
        
        // ADAS 默认值
        self.adas_msg = @"";
        self.adas_image_paths = @[].mutableCopy;
        self.tirePressure = [TDD_ArtiADASReportTirePressureUnit bar];
        
        TDD_ADASManage *ADASMgr = [TDD_ADASManage shared];
        
        float lfBrow = ADASMgr.wheelBrowModel.lfBrowModel.value;
        float lrBrow = ADASMgr.wheelBrowModel.lrBrowModel.value;
        float rfBrow = ADASMgr.wheelBrowModel.rfBrowModel.value;
        float rrBrow = ADASMgr.wheelBrowModel.rrBrowModel.value;
        
        if (ADASMgr.wheelBrowModel && (lfBrow > 0 && lrBrow > 0 && rfBrow > 0 && rrBrow > 0)) {
            NSString *unit = [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric ? @"mm" : @"inch";
            if ([unit isEqualToString: @"mm"]) { // mm
                self.wheelEyebrow = [TDD_ArtiADASReportWheelEyebrowUnit mm];
                TDD_ArtiADASReportWheelEyebrowUnit *wheelEyeBrow = (TDD_ArtiADASReportWheelEyebrowUnit *)self.wheelEyebrow;
                [wheelEyeBrow updateWithLf:lfBrow lr:lrBrow rf:rfBrow rr:rrBrow];
            } else { // inch
                self.wheelEyebrow = [TDD_ArtiADASReportWheelEyebrowUnit inch];
                TDD_ArtiADASReportWheelEyebrowUnit *wheelEyeBrow = (TDD_ArtiADASReportWheelEyebrowUnit *)self.wheelEyebrow;
                [wheelEyeBrow updateWithLf:lfBrow lr:lrBrow rf:rfBrow rr:rrBrow];
                
                // 默认 mm
                // [wheelEyeBrow convertTo: @"mm"];
            }

        } else {
            self.wheelEyebrow = [TDD_ArtiADASReportWheelEyebrowUnit mm];
        }
        
        self.fuel = [[TDD_ArtiADASReportFuel alloc] initWithPercent:@"" imagePath:@"" isFold:NO];
        if (ADASMgr.oliValue > 0) {
            NSString *oliStr = [NSString stringWithFormat:@"%ld",(NSInteger)(MIN(100, MAX(0, ADASMgr.oliValue * 10)))];
            self.fuel.percent = oliStr;
        }
        
        self.adas_result = @[].mutableCopy;
    }
    return self;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    if (buttonID == 0) {
        if (self.buttonArr.count > 0) {
            // 点击生成报告
            if (!self.isSaveReport) {
                if (self.generatorTapBlock) {
                    TDD_ArtiButtonModel *buttonModel = self.buttonArr[0];
                    buttonModel.uiTextIdentify = @"diagReportShare";
                    self.generatorTapBlock();
                    self.isSaveReport = YES;
                    [self sharePDF];
                }
            }
            // 点击分享
            else {
                [self sharePDF];
            }
        }
    }
    
    return NO;
}

/// 获取用来可以生成 JSON 的字典
- (NSDictionary *)jsonDictionary {
    
    NSMutableArray *repairs = [[NSMutableArray alloc] init];
    NSMutableArray *flows = [[NSMutableArray alloc] init];
    
    // 诊断列表
    for (TDD_ArtiReportCellModel *cellModel in _repairCellModels) {
        
        if ([cellModel.identifier isEqualToString:[TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]]) {
            [repairs addObject:@{
                @"system_id": [NSString tdd_nullableString: cellModel.system_id defaultString:@""],
                @"system_name": [NSString tdd_nullableString: cellModel.rightUDtsName defaultString:@""],
                @"current_DTC": @(cellModel.rightUDtsNums),
                @"history_DTC": @(cellModel.leftUDtsNums)
            }];
        }
    }
    
    NSMutableDictionary *flowDict = nil;
    
    // 数据流
    for (TDD_ArtiReportCellModel *cellModel in _cellModels) {
        if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier]]) {
            flowDict = [ @{
                   @"system_id": [NSString tdd_nullableString:cellModel.system_id defaultString:@""],
                   @"system_name": [NSString tdd_nullableString:cellModel.headerTitle defaultString:@""],
                   @"DS_list": [NSMutableArray new]
            } mutableCopy];
            [flows addObject:[flowDict copy]];
        }
        else if ([cellModel.identifier isEqualToString:[TDD_ArtiReportFlowRowTableViewCell reuseIdentifier]]) {
            if (flowDict != nil) {
                if (cellModel.liveDatas.count == 4) {
                    NSString *strName = [NSString tdd_nullableString:cellModel.liveDatas[0] defaultString:@""];
                    NSString *value = [NSString tdd_nullableString:cellModel.liveDatas[1] defaultString:@""];
                    NSString *unit = [NSString tdd_nullableString:cellModel.liveDatas[2] defaultString:@""];
                    NSString *min = [NSString tdd_nullableString:[cellModel.liveDatas[3] componentsSeparatedByString:@"~"].firstObject defaultString: @""];
                    NSString *max = [NSString tdd_nullableString:[cellModel.liveDatas[3] componentsSeparatedByString:@"~"].lastObject defaultString: @""];
                    NSMutableArray * list = flowDict[@"DS_list"];
                    if ([list isKindOfClass:[NSMutableArray class]]) {
                        [list addObject:@{
                                                    @"DS_name": strName,
                                                    @"DS_value": value,
                                                    @"DS_unit": unit,
                                                    @"DS_reference": @"",
                                                    @"DS_reference_min": min,
                                                    @"DS_reference_max": max
                        }];
                    }
                }
            }
        }
    }
    
    // ADAS
    NSMutableArray *adasResultJsons = @[].mutableCopy;
    for (TDD_ArtiADASReportResult *result in self.adas_result) {
        [adasResultJsons addObject:[result serverJson]];
    }
    NSDictionary *adasTirePressureJson = (self.adas_tirePressureData != nil) ? [self.adas_tirePressureData serverJson] : @{};
    NSDictionary *adasWheelEyebrowJson = (self.adas_wheelEyebrowData != nil) ? [self.adas_wheelEyebrowData serverJson] : @{};
    NSDictionary *adasFuelJson = [self hasFuel] ? [self.fuel serverJson] : @{};
    
    HLog(@"【REPORT】ArtiReportJSONs:\n adasResultJsons=%@\nadasTirePressureJson:%@\nadasWheelEyebrowJson:%@\nadasFuelJson:%@", adasResultJsons, adasTirePressureJson, adasWheelEyebrowJson, adasFuelJson);
    
    self.reportCreateTime = self.reportCreateTime == 0 ? [NSDate tdd_getTimestampSince1970] : _reportCreateTime;
    self.describe_diagnosis_time = [NSDate tdd_getTimeStringWithInterval:self.reportCreateTime Format:@"yyyy-MM-dd HH:mm:ss"];
    self.describe_version = self.carModel.strVersion;
    self.describe_diagnosis_time_zone = [NSDate tdd_getTopdonTimeZone];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.describe_software_version = [NSString stringWithFormat:@"V%@", currentVersion];
    self.system_overview_title = TDDLocalized.report_generalize;
    if ([TDD_DiagnosisManage sharedManage].currentSoftware == TDDSoftwareDeepScan) {
        self.report_number = [NSString tdd_nullableString:[NSString stringWithFormat:@"%ld", (NSInteger)self.reportCreateTime] defaultString:@""];
    } else {
        self.report_number = [NSString tdd_nullableString:[NSString stringWithFormat:@"TD%ld", (NSInteger)self.reportCreateTime] defaultString:@""];
    }
    return @{
            @"report_info": @{
                @"report_title": [NSString tdd_nullableString: _report_title defaultString:[NSString tdd_reportTitleDiagnosed]],
                @"report_type_title": [NSString tdd_nullableString: _report_type_title defaultString:@""],
                @"report_type": [NSString tdd_nullableString: [NSString stringWithFormat:@"%d", _reportType] defaultString:@""],
                @"report_version": @"V1.10",
                @"report_number": self.report_number,
                @"report_name":  [NSString tdd_nullableString: _reportRecordName defaultString:@""],
            },
            @"software_info": @{
                @"software_language": @([TDD_HLanguage getServiceLanguageId]), // 3.31.0 采用语言id
                @"app_version": [NSString stringWithFormat:@"V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]],
                @"vci_version": [TDD_EADSessionController sharedController].vciInitModel.fwVersion?:@"",
                @"vehicle_name": self.carModel.strVehicle ? : @"",
                @"vehicle_version": self.carModel.strVersion ? : @"",
                @"VIN": [NSString tdd_nullableString: _VIN defaultString:@""],
                @"APP_bind_SN": [TDD_DiagnosisTools selectedVCISerialNum]
            },
            @"describe_info": @{
                @"describe_title": [NSString tdd_nullableString: _describe_title defaultString:@""],
                @"describe_license_plate_number": [NSString tdd_nullableString: _describe_license_plate_number defaultString:@""],
                @"describe_brand": [NSString tdd_nullableString: _describe_brand defaultString:@""],
                @"describe_model": [NSString tdd_nullableString: _describe_model defaultString:@""],
                @"describe_year": [NSString tdd_nullableString: _describe_year defaultString:@""],
                @"describe_mileage": [NSString tdd_nullableString: _describe_mileage defaultString:@""],
                @"describe_engine": [NSString tdd_nullableString: _describe_engine defaultString:@""],
                @"describe_engine_subType": [NSString tdd_nullableString: _describe_engine_subType defaultString:@""],
//                @"describe_diagnosis_time": [NSString nullableString: _describe_diagnosis_time defaultString:@""],
                @"describe_diagnosis_time": [NSString stringWithFormat:@"%ld", (NSInteger)self.reportCreateTime],
                @"describe_diagnosis_time_zone": [NSString tdd_nullableString: _describe_diagnosis_time_zone defaultString:@""],
                @"describe_version": [NSString tdd_nullableString: _describe_version defaultString:@""],
                @"describe_software_version": [NSString tdd_nullableString: _describe_software_version defaultString:@""],
                @"VIN": [NSString tdd_nullableString: _VIN defaultString:@""],
                @"describe_diagnosis_path": [NSString tdd_nullableString: _describe_diagnosis_path defaultString:@""],
                @"describe_customer_name": [NSString tdd_nullableString: _describe_customer_name defaultString:@""],
                @"describe_customer_call": [NSString tdd_nullableString: _describe_customer_call defaultString:@""],
            },
            @"system_info": @{
                @"system_type": @(self.repairIndex),
                @"system_overview_title": [NSString tdd_nullableString: _system_overview_title defaultString:@""],
                @"system_overview_content": [NSString tdd_nullableString: _system_overview_content defaultString:@""],
                @"system_is_history_data": @((self.hasRepairHistory && (self.repairIndex == 2 || self.repairIndex == 3)) ? 1 : 0),
                @"system_strScanPre": [NSString tdd_nullableString: self.adasPreScanTime defaultString:@""],
                @"system_strScanPost": [NSString tdd_nullableString: self.adasPreScanTime defaultString:@""],

            },
            @"system_list": repairs,
            @"DTC_info": _codesItems,
            @"DS_info": flows,
            @"ADAS_result": adasResultJsons,
            @"ADAS_tyre_pressure": adasTirePressureJson,
            @"ADAS_wheel_brow_height": adasWheelEyebrowJson,
            @"ADAS_fuel": adasFuelJson,
        };
}

- (NSString *)generatPdfFileName: (NSInteger)repairIndex
{
    NSMutableString *pdfName = [NSMutableString string];
    [pdfName appendString: self.describe_brand?:@""];
    if (![NSString tdd_isEmpty:self.describe_brand]) {
        [pdfName appendFormat: @"-"];
    }
    if (![NSString tdd_isEmpty:self.describe_model]) {
        [pdfName appendString:self.describe_model];
        [pdfName appendFormat:@"-"];
    }
    if (![NSString tdd_isEmpty:self.describe_year]) {
        [pdfName appendString:self.describe_year];
        [pdfName appendFormat:@"_"];
    }
    NSString *repairStr = @"";
    if (repairIndex == 1) {
        repairStr = TDDLocalized.report_system_type_before;
    } else if (repairIndex == 2) {
        repairStr = TDDLocalized.report_system_type_after;
    } else if (repairIndex == 3) {
        repairStr = TDDLocalized.report_system_type_ing;
    }
    if (![NSString tdd_isEmpty:repairStr]) {
        [pdfName appendString:repairStr];
        [pdfName appendFormat:@"_"];
    }
    NSString *reportTypeStr = @"";
    if (self.reportType == TDD_ArtiReportTypeSystem) {
        reportTypeStr = [NSString tdd_reportTitleSystemHead];
    } else if (self.reportType == TDD_ArtiReportTypeDTC || self.reportType == TDD_ArtiReportTypeAdasDTC) {
        if (self.obdEntryType == OET_CARPAL_OBD_ENGINE_CHECK) {
            reportTypeStr = @"engine_report_default_name".TDDLocalized;
        } else {
            reportTypeStr = TDDLocalized.fault_code_report;
        }
    } else if (self.reportType == TDD_ArtiReportTypeDataStream || self.reportType == TDD_ArtiReportTypeAdasDataStream) {
        reportTypeStr = [NSString tdd_reportTitleLiveDataHead];
    } else if (self.reportType == TDD_ArtiReportTypeAdasSystem) {
        NSString *adasReport = [NSString stringWithFormat:@"ADAS%@",TDDLocalized.app_report];
        [pdfName appendString: adasReport];
    } else if (self.reportType == TDD_ArtiReportTypeAdasSingleSystem) {
        NSString *adasReport = [NSString stringWithFormat:@"ADAS%@",TDDLocalized.app_report];
        [pdfName appendString: adasReport];
    }
    
    if (![NSString tdd_isEmpty:reportTypeStr]) {
        [pdfName appendString:reportTypeStr];
    }
//    if (self.reportCreateTime > 0){
//        NSString *date = [[NSDate dateWithTimeIntervalSince1970:self.reportCreateTime] tdd_stringWithFormat:@"yyyy-MM-dd_HH-mm-ss"];
//        [pdfName appendString:date];
//    }
    
    return [NSString stringWithString:pdfName];
}

///  点击分享后 执行
- (void)sharePDF
{
    NSURL *url = [NSURL fileURLWithPath:self.a4pdfPath == nil ? @"" : self.a4pdfPath];
    if (url == nil) {
        return;
    }

    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    NSArray *activityItems = @[url];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    if (IS_IPad) {
        activityVC.popoverPresentationController.sourceView = [UIViewController tdd_topViewController].view;
        activityVC.popoverPresentationController.sourceRect = CGRectMake([UIViewController tdd_topViewController].view.bounds.size.width/2, [UIViewController tdd_topViewController].view.bounds.size.height/2, 0, 0);
        activityVC.popoverPresentationController.permittedArrowDirections = 0;
    }
    [[UIViewController tdd_topViewController] presentViewController:activityVC animated:YES completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (@available(iOS 11.0, *)) {
//            // 退出分享页面 将scrollView 的预估偏移量设置成 never
//            if ([[UIViewController tdd_topViewController]  isKindOfClass:NSClassFromString(@"BaseViewController")]) {
                UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            }
        }
    };
}

+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegReport::Construct(ArtiReportConstruct);
    CRegReport::Destruct(ArtiReportDestruct);
    CRegReport::Show(ArtiReportShow);
    CRegReport::InitTitle(ArtiReportInitTitle);
    CRegReport::SetReportType(ArtiReportSetReportType);
    CRegReport::SetTypeTitle(ArtiReportSetTypeTitle);
    CRegReport::SetDescribeTitle(ArtiReportSetDescribeTitle);
    CRegReport::SetSummarize(ArtiReportSetSummarize);
    CRegReport::AddSysItem(ArtiReportAddSysItem);
    CRegReport::AddSysItems(ArtiReportAddSysItems);
    CRegReport::AddDtcItem(ArtiReportAddDtcItem);
    CRegReport::AddDtcItems(ArtiReportAddDtcItems);
    //TODO: 新增程序接口
    CRegReport::AddDtcItemEx(ArtiReportAddDtcItemEx);
    CRegReport::AddDtcItemsEx(ArtiReportAddDtcItemsEx);
    
    CRegReport::AddLiveDataSys(ArtiReportAddLiveDataSys);
    CRegReport::AddLiveDataItem(ArtiReportAddLiveDataItem);
    CRegReport::AddLiveDataItems(ArtiReportAddLiveDataItems);
    CRegReport::SetMileage(ArtiReportSetMileage);
    CRegReport::SetVehInfo(ArtiReportSetVehInfo);
    CRegReport::SetEngineInfo(ArtiReportSetEngineInfo);
    CRegReport::SetVehPath(ArtiReportSetVehPath);
    //ADAS
    CRegReport::SetAdasCaliResult(ArtiReportSetAdasCaliResult); // 完成
    CRegReport::AddSysItemEx(ArtiReportAddSysItemEx);
    CRegReport::AddLiveDataItemSysName(ArtiReportAddLiveDataItemSysName); // 完成
    CRegReport::AddLiveDataItemsSysName(ArtiReportAddLiveDataItemsSysName);//完成
    CRegReport::SetSysScanTime(ArtiReportSetSysScanTime); // 完成
    
    
    
    
    
}

// MARK: - 库方法

void ArtiReportConstruct(uint32_t id)
{
    [TDD_ArtiReportModel Construct:id];
}

void ArtiReportDestruct(uint32_t id)
{
    [TDD_ArtiReportModel Destruct:id];
}

uint32_t ArtiReportShow(uint32_t id)
{
    return [TDD_ArtiReportModel ShowWithId:id];
}


/*-----------------------------------------------------------------------------
*    功  能：初始化诊断报告显示控件，同时设置标题文本
*
*    参  数：strTitle 标题文本
*
*    返回值：true 初始化成功 false 初始化失败
-----------------------------------------------------------------------------*/
bool ArtiReportInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiReportModel ArtiReportInitTitle:id with:[TDD_CTools CStrToNSString:strTitle]];
}

/*-----------------------------------------------------------------------------
*    功  能：设置诊断报告类型
*
*    参  数：Type 诊断报告类型
*
*        REPORT_TYPE_SYSTEM        = 1,            系统诊断报告
*        REPORT_TYPE_DTC = 2,                    故障诊断报告
*        REPORT_TYPE_DATA_STREAM = 3,            数据流诊断报告
 
*       ADAS_REPORT_TYPE_SYSTEM    = 0x11,          adas系统诊断报告
*       ADAS_REPORT_TYPE_DTC = 0x12,                adas故障诊断报告
*       ADAS_REPORT_TYPE_DATA_STREAM = 0x13,          adas数据流诊断报告
        REPORT_TYPE_ADAS_SIGNLE_SYSTEM  = 0x14,    ADAS单系统诊断报告（进入系统内的报告） 
*
*    返回值：true 设置成功 false 设置失败
-----------------------------------------------------------------------------*/
bool ArtiReportSetReportType(uint32_t id, uint32_t Type)
{
    return [TDD_ArtiReportModel ArtiReportSetReportType:id with:Type];
}

/*-----------------------------------------------------------------------------
*    功  能：设置诊断报告类型标题
*
*    参  数：strTitle 标题文本
*            "系统诊断报告状态(59)"
*            "故障码(39)"
*            "数据流(62)"
*
*    返回值：true 初始化成功 false 初始化失败
-----------------------------------------------------------------------------*/
bool ArtiReportSetTypeTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiReportModel ArtiReportSetTypeTitle:id with:[TDD_CTools CStrToNSString:strTitle]];
}

/*-----------------------------------------------------------------------------
*    功  能：设置诊断报告描述部分的标题
*
*    参  数：strTitle 标题文本
*            "2015-09奥迪"
*
*    返回值：true 初始化成功 false 初始化失败
-----------------------------------------------------------------------------*/
bool ArtiReportSetDescribeTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiReportModel ArtiReportSetDescribeTitle:id with:[TDD_CTools CStrToNSString:strTitle]];
}

/*-----------------------------------------------------------------------------
功    能：设置车辆诊断报告概述，概述只在系统报告类型中存在

参数说明：
          strTitle                车辆诊断报告概述的标题，例如，"概述"

          strContent            车辆诊断报告概述的内容，例如，"总共扫描出12个
                                系统，其中12个系统故障，故障数量为105个。为了
                                安全驾驶请你仔细阅读分析报告，并修复相关故障
                                信息组件，及时处理排查。"

返回值：诊断程序如果没有设置此接口，报告将不显示“概述”项

注  意：仅适用于 REPORT_TYPE_SYSTEM 类型
-----------------------------------------------------------------------------*/
void ArtiReportSetSummarize(uint32_t id, const std::string& strTitle, const std::string& strContent)
{
    [TDD_ArtiReportModel ArtiReportSetSummarize:id with:[TDD_CTools CStrToNSString:strTitle] with: [TDD_CTools CStrToNSString:strContent]];
}

/*-----------------------------------------------------------------------------
*    功  能：添加系统列表项
*
*    参  数：sysItem        系统列表项，参考 stSysReportItem 定义
*
*
*    返回值：无
*
*    说  明：仅适用于 REPORT_TYPE_SYSTEM 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddSysItem(uint32_t id, stSysReportItem& sysItem)
{
    [TDD_ArtiReportModel ArtiReportAddSysItem:id with:sysItem];
}

/*-----------------------------------------------------------------------------
*    功  能：添加系统列表项数组
*
*    参  数：vctItem        系统诊断报告对应的系统项的数组，数组大小即列大小
*
*    返回值：无
*
*    说  明：仅适用于 REPORT_TYPE_SYSTEM 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddSysItems(uint32_t id, const std::vector<stSysReportItem> &vctItem)
{
    [TDD_ArtiReportModel ArtiReportAddSysItems:id with:vctItem];
}

/*-----------------------------------------------------------------------------
*    功  能：添加扩展功能的系统列表项
*
*    参  数：sysItem        系统列表项，参考 stSysReportItemEx 定义
*
*
*    返回值：无
*
*    说  明：仅适用于 REPORT_TYPE_ADAS_SYSTEM 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddSysItemEx(uint32_t id, const stSysReportItemEx &sysItem)
{
    [TDD_ArtiReportModel ArtiReportAddSysItemEx:id with:sysItem];
}

/*-----------------------------------------------------------------------------
*    功  能：添加故障码列表项
*
*    参  数：nodeItem    故障码列表项， 参考stDtcReportItem的定义
*
*    返回值：无
*
*    说  明：故障码数组，包含了此系统下的所有故障码
*            适用于 REPORT_TYPE_SYSTEM 类型 和 REPORT_TYPE_DTC 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddDtcItem(uint32_t id, stDtcReportItem& nodeItem)
{
    [TDD_ArtiReportModel ArtiReportAddDtcItem:id with:nodeItem];
}


//TODO: 故障码列表 显示不一致 新增接口
void ArtiReportAddDtcItemEx(uint32_t id, const stDtcReportItemEx& nodeItem)
{
    [TDD_ArtiReportModel ArtiReportAddDtcItemEx:id with: nodeItem];
}


/*-----------------------------------------------------------------------------
*    功  能：添加故障码列表
*
*    参  数：vctItem        故障码列表项数组， 参考stDtcReportItem的定义

*    返回值：无
*
*    说  明：故障码数组，包含了此系统下的所有故障码
*            适用于 REPORT_TYPE_SYSTEM 类型 和 REPORT_TYPE_DTC 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddDtcItems(uint32_t id, const std::vector<stDtcReportItem>& vctItem)
{
    //    std::vector<stDtcReportItemEx> itemExs;
    //    for (int i=0; i<vctItem.size(); i++) {
    //        stDtcReportItemEx item = [ArtiReportModel convertItem:vctItem[i]];
    //        itemExs.push_back(item);
    //    }
    //    [ArtiReportModel ArtiReportAddDtcItemsEx:id with:itemExs];
        [TDD_ArtiReportModel ArtiReportAddDtcItems:id with:vctItem];
}

//TODO: 故障码列表 显示不一致 新增接口
void ArtiReportAddDtcItemsEx(uint32_t id, const std::vector<stDtcReportItemEx>& vctItem)
{
    [TDD_ArtiReportModel ArtiReportAddDtcItemsEx:id with:vctItem];
}

/*-----------------------------------------------------------------------------
*    功  能：添加数据流系统名称
*
*    参  数：
*            std::string strID    系统ID, 如果无，则置空
*            std::string strName  系统Name，此名称不能为空，如空则添加无效
*
*    返回值：无
*
*    说  明：适用于 REPORT_TYPE_DATA_STREAM 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddLiveDataSys(uint32_t id, const std::string& strSysId, const std::string& strSysName)
{
    [TDD_ArtiReportModel ArtiReportAddLiveDataSys:id with:strSysId with:strSysName];
}

/*-----------------------------------------------------------------------------
*    功  能：添加数据流列表项
*
*    参  数：dsItem    数据流列表项， 参考stDsReportItem的定义
*
*    返回值：无
*
*    说  明：适用于 REPORT_TYPE_DATA_STREAM 类型
-----------------------------------------------------------------------------*/
void ArtiReportAddLiveDataItem(uint32_t id, stDsReportItem& dsItem)
{
    [TDD_ArtiReportModel ArtiReportAddLiveDataItem:id with:dsItem];
}

/*-----------------------------------------------------------------------------
*    功  能：添加数据流列表项
*
*    参  数：strSysName   数据流所属的系统名称
*            dsItem       数据流列表项， 参考stDsReportItem的定义
*
*    返回值：无
*
*    说  明：适用于 REPORT_TYPE_DATA_STREAM 类型 和 REPORT_TYPE_ADAS_DATA_STREAM 类型
*            AddLiveDataItem调用前必须先调用AddLiveDataSys或者SetAdasCaliResult
-----------------------------------------------------------------------------*/
void ArtiReportAddLiveDataItems(uint32_t id, const std::vector<stDsReportItem>& vctItem)
{
    [TDD_ArtiReportModel ArtiReportAddLiveDataItems:id with:vctItem];
}

void ArtiReportAddLiveDataItemSysName(uint32_t id, const std::string& strSysName, stDsReportItem& dsItem)
{
    [TDD_ArtiReportModel ArtiReportAddLiveDataItemSysName:id with:strSysName with:dsItem];
}

void ArtiReportAddLiveDataItemsSysName(uint32_t id, const std::string& strSysName, const std::vector<stDsReportItem>& vctItem)
{
    [TDD_ArtiReportModel ArtiReportAddLiveDataItemsSysName:id with:strSysName with:vctItem];
}
/*-----------------------------------------------------------------------------
功能：设置车辆行驶里程（KM）

参数说明：诊断设置当前车辆行驶总里程（KM）

        strMileage            当前车辆行驶总里程（KM）
        strMILOnMileage        故障灯亮后的行驶里程（KM）

        例如：568        表示行驶总里程为568KM

返回值：

说  明：如果无“故障灯亮后的行驶里程”，则strMILOnMileage为空串""或空
-----------------------------------------------------------------------------*/
void ArtiReportSetMileage(uint32_t id, const std::string& strMileage, const std::string& strMILOnMileage)
{
    [TDD_ArtiReportModel ArtiReportSetMileage:id with:[TDD_CTools CStrToNSString:strMileage] with:[TDD_CTools CStrToNSString:strMILOnMileage]];
}

/*-----------------------------------------------------------------------------
功能：设置车辆品牌信息

参数说明：
        strBrand            车辆品牌，例如“宝马”
        strModel            车型，例如“320i”
        strYear                年份，例如“2021”

返回值：
-----------------------------------------------------------------------------*/
void ArtiReportSetVehInfo(uint32_t id, const std::string& strBrand, const std::string& strModel, const std::string& strYear)
{
    [TDD_ArtiReportModel ArtiReportSetVehInfo:id with:[TDD_CTools CStrToNSString:strBrand] with:[TDD_CTools CStrToNSString:strModel] with:[TDD_CTools CStrToNSString:strYear]];
}

/*-----------------------------------------------------------------------------
功能：设置车辆发动机信息

参数说明：
        strInfo                发动机机信息，例如，"F62-D52"
        strSubType            发动机子型号或者其它信息，例如，"N542"

返回值：
-----------------------------------------------------------------------------*/
void ArtiReportSetEngineInfo(uint32_t id, const std::string& strInfo, const std::string& strSubType)
{
    [TDD_ArtiReportModel ArtiReportSetEngineInfo:id with:[TDD_CTools CStrToNSString:strInfo] with:[TDD_CTools CStrToNSString:strSubType]];
}

/*-----------------------------------------------------------------------------
功能：设置诊断路径

参数说明：
        strVehPath            例如，"宝马>320>系统>自动扫描"

返回值：
-----------------------------------------------------------------------------*/
void ArtiReportSetVehPath(uint32_t id, const std::string& strVehPath)
{
    return [TDD_ArtiReportModel ArtiReportSetVehPath:id with:[TDD_CTools CStrToNSString:strVehPath]];
}

/*-----------------------------------------------------------------------------
*    功  能：设置系统报告的扫描前（校准前）时间和扫描后（校准后）时间
*
*    参  数：strScanPre       扫描前（校准前）时间，例如："2022-06-27 20:54:29"
*            strScanPost      扫描后（校准后）时间，例如："2022-06-27 20:59:48"
*
*
*    返回值：无
*
*    说  明：仅适用于 REPORT_TYPE_ADAS_SYSTEM 类型
-----------------------------------------------------------------------------*/
void ArtiReportSetSysScanTime(uint32_t id, const std::string& strScanPre, const std::string& strScanPost)
{
    [TDD_ArtiReportModel ArtiReportSetSysScanTime:id with:[TDD_CTools CStrToNSString:strScanPre] with:[TDD_CTools CStrToNSString:strScanPost]];
}

+ (stDtcReportItemEx)convertItem:(stDtcReportItem) nodeItem {
    stDtcReportItemEx itemEx;
    itemEx.strID = nodeItem.strID;
    itemEx.strName = nodeItem.strName;
    std::vector<stDtcNodeEx> nodes;
    for (int i=0; i<nodeItem.vctNode.size(); i++) {
        stDtcNodeEx node;
        node.strCode = nodeItem.vctNode[i].strCode;
        node.strDescription = nodeItem.vctNode[i].strDescription;
        node.uStatus = nodeItem.vctNode[i].uStatus;
        node.strStatus = [self statusString:node.uStatus];
        nodes.push_back(node);
    }
    itemEx.vctNode = nodes;
    return itemEx;
}

+ (std::string)statusString: (uint32_t) dtcNodeStatus
{
    std::string res = "";
    if (dtcNodeStatus & DF_DTC_STATUS_CURRENT) {
        res += [TDD_CTools NSStringToCStr:TDDLocalized.report_trouble_code_status_curr];
    }
    if (dtcNodeStatus & DF_DTC_STATUS_NA) {
        if (isKindOfTopVCI) {
            res += [TDD_CTools NSStringToCStr:TDDLocalized.diag_ignore];
        }else {
            res += "N/A";
        }
        
    }
    if (dtcNodeStatus & DF_DTC_STATUS_HISTORY) {
        res += [TDD_CTools NSStringToCStr:TDDLocalized.report_trouble_code_status_his];
    }
    if (dtcNodeStatus & DF_DTC_STATUS_PENDING) {
        res += [TDD_CTools NSStringToCStr:TDDLocalized.report_trouble_code_status_pending];
    }
    if (dtcNodeStatus & DF_DTC_STATUS_TEMP) {
        res += [TDD_CTools NSStringToCStr:TDDLocalized.report_trouble_code_status_temporary];
    }
    return res;
}

/*----------------------------------------------------------------------------------
*    功  能：设置ADAS报告的ADAS执行信息结果展示状态
*
*    参  数：
*            vctSysItem  系统结果信息项
*
*            struct stReportAdasResult
*            {
*                std::string  strSysName;  系统Name，此名称不能为空，如空则添加无效
*                std::string  strStartTime;校准开始时间，例如："2022-06-27 20:55:40"
*                std::string  strStopTime; 校准结束时间，例如："2022-06-27 20:56:48"
*                uint32_t     uTotalTimeS; 总校准耗时时间，单位为秒
*                uint32_t     uType;       ADAS系统校准类型
*                                          0   静态校准
*                                          1   动态校准
*                uint32_t     uStatus;     系统校准结果状态
*                                          0   ADAS校准OK
*                                          1   ADAS校准失败
*            };
*
*
*    返回值：无
*
*    说  明：没有调用此接口，即无ADAS校准记录
*            适用于ADAS相关的诊断报告
----------------------------------------------------------------------------------*/
void ArtiReportSetAdasCaliResult(uint32_t id, const std::vector<stReportAdasResult>& vctSysItem)
{
    [TDD_ArtiReportModel ArtiReportSetAdasCaliResult:id with:vctSysItem];
}

/*-----------------------------------------------------------------------------
*    功  能：显示诊断报告
*
*    参  数：无
*
*    返回值：uint32_t 组件界面按键返回值
*    按键：返回
-----------------------------------------------------------------------------*/
-(uint32_t)show
{
    [self.condition lock];
    
    TDD_ArtiReportGeneratorModel *generatorModel = [[TDD_ArtiReportGeneratorModel alloc] init];
    generatorModel.strTitle = TDDLocalized.generate_report;
    generatorModel.reportModel = self;
    [generatorModel show];
    
    [self.condition wait];
    [self.condition unlock];
    
    return [super show];
}

-(void)reloadView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
    });
}

// MARK: - 模型方法

+(bool) ArtiReportInitTitle:(uint32_t)id with:(NSString *)strTitle
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.strTitle = strTitle;
    HLog(@"【REPORT】ArtiReportInitTitle %@", strTitle);
    return YES;
}

+(bool) ArtiReportSetReportType:(uint32_t)id with:(uint32_t)type
{
    
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
        
    HLog(@"【REPORT】ArtiReportSetReportType %@", @(type));

    if (model.reportType != 0) {
        HLog(@"诊断报告重复设置类型 %@", [self class]);
        return NO;
    }
    model.obdEntryType = [TDD_ArtiGlobalModel sharedArtiGlobalModel].obdEntryType;
    model.reportType = [self reportTypeFromValue:type];

    

    // 设置一些信息
    
    if (isKindOfTopVCI){
        if (![NSString tdd_isEmpty:[TDD_ArtiGlobalModel GetVIN]]){
            model.inputVIN = [TDD_ArtiGlobalModel GetVIN];
            model.VIN = [TDD_ArtiGlobalModel GetVIN];
        }

    }else {
        model.inputVIN = [TDD_ArtiGlobalModel GetVIN];
        model.VIN = [TDD_ArtiGlobalModel GetVIN];
    }

    
    // 设置完类型后添加相应表头 1系统诊断报告 2故障诊断报告 3数据流诊断报告 0x11 adas系统诊断报告 0x12 adas故障诊断报告 0x13 adas数据流诊断报告
    if (type == 1 || type == 0x11) {
        // 维修前后
        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel1.headerTitle = [NSString tdd_reportTitleSystemHead];
        cellModel1.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
        cellModel1.cellA4Height = 60;
        [model.cellModels addObject:cellModel1];
        
        if (!isKindOfTopVCI){
            TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
            BOOL isADAS = [model isAdasReport];
            if (isADAS) {
                cellModel2.identifier = [TDD_ArtiADASReportRepairHeaderCell reuseIdentifier];
                cellModel2.cellHeight = 50.0;
                cellModel2.cellA4Height = 40;
            } else {
                cellModel2.identifier = [TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier];
                cellModel2.cellHeight = IS_IPad ? 50 : 40.0;
                cellModel2.cellA4Height = 30;
            }
            cellModel2.leftWidth = 0.3;
            cellModel2.rightWidth = 0.3;
            [model.cellModels addObject:cellModel2];
        }


        TDD_ArtiReportCellModel *cellModel3 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel3.identifier = [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier];
        cellModel3.cellHeight = IS_IPad ? 60 : 50.0;
        cellModel3.cellA4Height = 30.0;
        cellModel3.leftWidth = 0.3;
        cellModel3.rightWidth = 0.3;
        [model.cellModels addObject:cellModel3];

    } else if (type == 2 || type == 0x12) {
        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel1.headerTitle = TDDLocalized.fault_code_report;
        cellModel1.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
        cellModel1.cellA4Height = 60;
        [model.cellModels addObject:cellModel1];
    } else if (type == 3 || type == 0x13) {
        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel1.headerTitle = [NSString tdd_reportTitleLiveDataHead];
        cellModel1.identifier = [TDD_ArtiReportHeaderTableViewCell reuseIdentifier];
        cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
        cellModel1.cellA4Height = 60;
        [model.cellModels addObject:cellModel1];
    }
    
    return YES;
}

+(bool) ArtiReportSetTypeTitle:(uint32_t)id with:(NSString *)strTitle
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.report_type_title = strTitle;
    
    HLog(@"【REPORT】ArtiReportSetTypeTitle %@", strTitle);
    int type = model.reportType;
    for (TDD_ArtiReportCellModel *cellModel in model.cellModels) {
        if ([cellModel.identifier isEqualToString:[TDD_ArtiReportHeaderTableViewCell reuseIdentifier]]) {
            cellModel.headerTitle = strTitle;
            if (type == 1) {
                cellModel.headerTitle = [NSString tdd_reportTitleSystemHead];
            } else if (type == 2) {
                cellModel.headerTitle = TDDLocalized.fault_code_report;
            } else if (type == 3) {
                cellModel.headerTitle = [NSString tdd_reportTitleLiveDataHead];
            } else {
                cellModel.headerTitle = [NSString tdd_reportTitleSystemHead];
            }
        }
    }
    
    return YES;
}

+(bool) ArtiReportSetDescribeTitle:(uint32_t)id with:(NSString *)strTitle
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.describe_title = strTitle;
    
    HLog(@"【REPORT】ArtiReportSetDescribeTitle %@", strTitle);
    
    return YES;
}

+ (void)ArtiReportSetSysScanTime:(uint32_t)id with:(NSString *)strScanPre with:(NSString *)strScanPost {
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.adasPreScanTime  = strScanPre;
    model.adasPostScanTime = strScanPost;
    
    HLog(@"【REPORT】ArtiReportSetSysScanTime PreScanTime:%@, PostScanTime:%@", strScanPre, strScanPost);
}

+(void) ArtiReportSetSummarize:(uint32_t)id with:(NSString *)strTitle with:(NSString *)strContent
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.system_overview_title = TDDLocalized.report_generalize;
    int scanedSystemCount = 0;
    int errorSystemCount = 0;
    int totalErrorCode = 0;
    model.system_overview_content = [NSString stringWithFormat:TDDLocalized.report_overview_content, @(scanedSystemCount), @(errorSystemCount), @(totalErrorCode)];
    
    HLog(@"【REPORT】ArtiReportSetSummarize title: %@ content: %@", strTitle, strContent);
}

+(void) ArtiReportSetMileage:(uint32_t)id with:(NSString *)strMileage with:(NSString *)strMILOnMileage
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.describe_mileage = strMileage;
    
    HLog(@"【REPORT】ArtiReportSetMileage %@", strMileage);
}

+(void) ArtiReportSetVehInfo:(uint32_t)id with:(NSString *)strBrand with:(NSString *)strModel with:(NSString *)strYear
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    NSString *exBrand = model.carExtraInfo[@"describe_brand"];
    NSString *exModel = model.carExtraInfo[@"describe_model"];
    NSString *exYear = model.carExtraInfo[@"describe_year"];
    
    //车辆信息公共存储
    if (![NSString tdd_isEmpty:strBrand]){
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand = strBrand;
    }
    if (![NSString tdd_isEmpty:strModel]){
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel = strModel;
    }
    if (![NSString tdd_isEmpty:strYear]){
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear = strYear;
    }
    
    model.describe_brand = [NSString tdd_isEmpty: exBrand] ? strBrand : exBrand;
    model.describe_model = [NSString tdd_isEmpty: exModel] ? strModel : exModel;
    model.describe_year = [NSString tdd_isEmpty: exYear] ? strYear : exYear;
    
    HLog(@"【REPORT】ArtiReportSetMileage strBrand %@ strModel %@ strYear %@", strBrand, strModel, strYear);
}

+(void) ArtiReportSetEngineInfo:(uint32_t)id with:(NSString *)strInfo with:(NSString *)strSubType
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    NSString *exEngine = model.carExtraInfo[@"describe_engine"];
    NSString *exEngineSub = model.carExtraInfo[@"describe_engine_subType"];
    
    model.describe_engine = [NSString tdd_isEmpty:exEngine] ? strInfo : exEngine;
    model.describe_engine_subType = [NSString tdd_isEmpty:exEngineSub] ? strSubType : exEngineSub;
    
    if (![NSString tdd_isEmpty:strInfo]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carEngineInfo = strInfo;
    }
    if (![NSString tdd_isEmpty:strSubType]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carEngineSubInfo = strSubType;
    }
    
    HLog(@"【REPORT】ArtiReportSetEngineInfo strInfo %@ strSubType %@", strInfo, strSubType);
}

+(void) ArtiReportSetVehPath:(uint32_t)id with:(NSString *)strVehPath
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    model.describe_diagnosis_path = strVehPath;
    
    HLog(@"【REPORT】ArtiReportSetVehPath %@", strVehPath);
}

+(void) ArtiReportAddSysItem:(uint32_t)id with:(stSysReportItem)sysItem
{
    // 维修前后
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel1.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
    cellModel1.cellHeight = IS_IPad ? 60 : 50.0;
    cellModel1.cellA4Height = 30.0;
    cellModel1.leftWidth = 0.3;
    cellModel1.rightWidth = 0.3;
    cellModel1.system_id = [TDD_CTools CStrToNSString:sysItem.strID];
    cellModel1.rightUDtsName = [TDD_CTools CStrToNSString:sysItem.strName];
    cellModel1.rightUDtsNums = sysItem.uDtsNums;
    [model.repairCellModels addObject:cellModel1];
    
    HLog(@"【REPORT】ArtiReportAddSysItem %@", cellModel1);
}

+(void) ArtiReportAddSysItems:(uint32_t)id with: (std::vector<stSysReportItem>)vctItem
{
    // 维修前后
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    for (int i = 0; i < vctItem.size(); i++) {
       
        stSysReportItem sysItem = vctItem[i];
        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel1.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
        cellModel1.cellHeight = IS_IPad ? 60 : 50.0;
        cellModel1.cellA4Height = 30.0;
        cellModel1.leftWidth = 0.3;
        cellModel1.rightWidth = 0.3;
        cellModel1.system_id = [TDD_CTools CStrToNSString:sysItem.strID];
        cellModel1.rightUDtsName = [TDD_CTools CStrToNSString:sysItem.strName];
        cellModel1.rightUDtsNums = sysItem.uDtsNums;

        [model.repairCellModels addObject:cellModel1];
        
        HLog(@"【REPORT】ArtiReportAddSysItems %@", cellModel1);
    }
}

+ (void)ArtiReportAddSysItemEx:(uint32_t)id with:(stSysReportItemEx)sysItem
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    
    TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel1.identifier = [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier];
    cellModel1.cellHeight = IS_IPad ? 60 : 50.0;
    cellModel1.cellA4Height = 30.0;
    cellModel1.leftWidth = 0.3;
    cellModel1.rightWidth = 0.3;
    cellModel1.system_id = [TDD_CTools CStrToNSString:sysItem.strID];
    cellModel1.rightUDtsName = [TDD_CTools CStrToNSString:sysItem.strName];
    // pre 不用，兼容以前的历史记录
    cellModel1.rightUDtsNums = sysItem.uDtsNumsPost;
    
    [model.repairCellModels addObject:cellModel1];
    
    
    HLog(@"【REPORT】ArtiReportAddSysItemEx %@", cellModel1);
}

+(void) ArtiReportAddDtcItem:(uint32_t)id with:(stDtcReportItem)nodeItem
{
 
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel1.identifier = [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier];
    cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
    cellModel1.cellA4Height = 30.0;
    cellModel1.leftWidth = 0.6;
    cellModel1.rightWidth = 0.2;
    cellModel1.system_id = [TDD_CTools CStrToNSString:nodeItem.strID];
    cellModel1.headerTitle = [TDD_CTools CStrToNSString:nodeItem.strName];
    [model.cellModels addObject:cellModel1];
    
    TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel2.identifier = [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier];
    cellModel2.cellHeight = IS_IPad ? 60 : 40.0;
    cellModel2.cellA4Height = 30.0;
    cellModel2.leftWidth = 0.6;
    cellModel2.rightWidth = 0.2;
    [model.cellModels addObject:cellModel2];
   
    NSMutableArray *dtcs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < nodeItem.vctNode.size(); i++) {
        stDtcNode stDtcNode = nodeItem.vctNode[i];
        TDD_ArtiReportCellModel *cellModel = [[TDD_ArtiReportCellModel alloc] init];
        cellModel.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
        cellModel.cellHeight = IS_IPad ? 100 : 50.0;
        cellModel.cellA4Height = 30.0;
        cellModel.leftWidth = 0.6;
        cellModel.rightWidth = 0.2;
        cellModel.headerTitle = [TDD_CTools CStrToNSString:stDtcNode.strCode];
        cellModel.leftTitle = [TDD_CTools CStrToNSString:stDtcNode.strDescription];
        cellModel.dtcNodeStatus = stDtcNode.uStatus;
        [model.cellModels addObject:cellModel];
        
        [dtcs addObject:@{
            @"DTC_code": cellModel.headerTitle,
            @"DTC_describe": cellModel.leftTitle,
            @"DTC_state_type": @(cellModel.dtcNodeStatus)
        }];
        
        HLog(@"【REPORT】ArtiReportAddDtcItem %@", cellModel);
    }
    
    NSDictionary *dtcJson = @{
            @"system_id": [TDD_CTools CStrToNSString:nodeItem.strID],
            @"system_name": [TDD_CTools CStrToNSString:nodeItem.strName],
            @"DTC_list": dtcs
    };
    [model.codesItems addObject:dtcJson];
}

//TODO: 故障码状态传递增加接口
+(void) ArtiReportAddDtcItemEx:(uint32_t)id with:(stDtcReportItemEx)nodeItem
{
 
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel1.identifier = [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier];
    cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
    cellModel1.cellA4Height = 30.0;
    cellModel1.leftWidth = 0.6;
    cellModel1.rightWidth = 0.2;
    cellModel1.system_id = [TDD_CTools CStrToNSString:nodeItem.strID];
    cellModel1.headerTitle = [TDD_CTools CStrToNSString:nodeItem.strName];
    [model.cellModels addObject:cellModel1];
    
    TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel2.identifier = [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier];
    cellModel2.cellHeight = IS_IPad ? 60 : 40.0;
    cellModel2.cellA4Height = 30.0;
    cellModel2.leftWidth = 0.6;
    cellModel2.rightWidth = 0.2;
    [model.cellModels addObject:cellModel2];
   
    NSMutableArray *dtcs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < nodeItem.vctNode.size(); i++) {
        stDtcNodeEx stDtcNode = nodeItem.vctNode[i];
        TDD_ArtiReportCellModel *cellModel = [[TDD_ArtiReportCellModel alloc] init];
        cellModel.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
        cellModel.cellHeight = IS_IPad ? 100 : 50.0;
        cellModel.cellA4Height = 30.0;
        cellModel.leftWidth = 0.6;
        cellModel.rightWidth = 0.2;
        cellModel.headerTitle = [TDD_CTools CStrToNSString:stDtcNode.strCode];
        cellModel.leftTitle = [TDD_CTools CStrToNSString:stDtcNode.strDescription];
        cellModel.dtcNodeStatus = stDtcNode.uStatus;
        cellModel.dtcNodeStatusStr = [TDD_CTools CStrToNSString:stDtcNode.strStatus];
        [model.cellModels addObject:cellModel];
        
        [dtcs addObject:@{
            @"DTC_code": cellModel.headerTitle,
            @"DTC_describe": cellModel.leftTitle,
            @"DTC_state_type": @(cellModel.dtcNodeStatus),
            @"DTC_state_str" : cellModel.dtcNodeStatusStr
        }];
        
        HLog(@"【REPORT】ArtiReportAddDtcItem %@", cellModel);
    }
    
    NSDictionary *dtcJson = @{
            @"system_id": [TDD_CTools CStrToNSString:nodeItem.strID],
            @"system_name": [TDD_CTools CStrToNSString:nodeItem.strName],
            @"DTC_list": dtcs
    };
    [model.codesItems addObject:dtcJson];
}

+ (void) ArtiReportAddDtcItems:(uint32_t)id with:(const std::vector<stDtcReportItem>)vctItem
{
    for (int i = 0; i < vctItem.size(); i++) {
        
        TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel1.identifier = [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier];
        cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
        cellModel1.cellA4Height = 30.0;
        cellModel1.leftWidth = 0.6;
        cellModel1.rightWidth = 0.2;
        cellModel1.system_id = [TDD_CTools CStrToNSString:vctItem[i].strID];
        cellModel1.headerTitle = [TDD_CTools CStrToNSString:vctItem[i].strName];
        [model.cellModels addObject:cellModel1];
        
        TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel2.identifier = [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier];
        cellModel2.cellHeight = IS_IPad ? 60 : 40.0;
        cellModel2.cellA4Height = 30.0;
        cellModel2.leftWidth = 0.6;
        cellModel2.rightWidth = 0.2;
        [model.cellModels addObject:cellModel2];
        
        NSMutableArray *dtcs = [[NSMutableArray alloc] init];

        for (int j = 0; j < vctItem[i].vctNode.size(); j++) {
            stDtcNode stDtcNode = vctItem[i].vctNode[j];
            TDD_ArtiReportCellModel *cellModel = [[TDD_ArtiReportCellModel alloc] init];
            cellModel.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
            cellModel.cellHeight = IS_IPad ? 100 : 50.0;
            cellModel.cellA4Height = 30.0;
            cellModel.leftWidth = 0.6;
            cellModel.rightWidth = 0.2;
            cellModel.headerTitle = [TDD_CTools CStrToNSString:stDtcNode.strCode];
            cellModel.leftTitle = [TDD_CTools CStrToNSString:stDtcNode.strDescription];
            cellModel.dtcNodeStatus = stDtcNode.uStatus;
            [model.cellModels addObject:cellModel];
            
            [dtcs addObject:@{
                @"DTC_code": cellModel.headerTitle,
                @"DTC_describe": cellModel.leftTitle,
                @"DTC_state_type": @(cellModel.dtcNodeStatus)
            }];
            
            HLog(@"【REPORT】ArtiReportAddDtcItems %@", cellModel);
        }
        
        NSDictionary *dtcJson = @{
                @"system_id": [TDD_CTools CStrToNSString:vctItem[i].strID],
                @"system_name": [TDD_CTools CStrToNSString:vctItem[i].strName],
                @"DTC_list": dtcs
        };
        [model.codesItems addObject:dtcJson];
    }
}

//TODO: 故障码状态传递增加接口
+(void) ArtiReportAddDtcItemsEx:(uint32_t)id with:(const std::vector<stDtcReportItemEx>)vctItem
{
    for (int i = 0; i < vctItem.size(); i++) {
        
        TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
        TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel1.identifier = [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier];
        cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
        cellModel1.cellA4Height = 30.0;
        cellModel1.leftWidth = 0.6;
        cellModel1.rightWidth = 0.2;
        cellModel1.system_id = [TDD_CTools CStrToNSString:vctItem[i].strID];
        cellModel1.headerTitle = [TDD_CTools CStrToNSString:vctItem[i].strName];
        [model.cellModels addObject:cellModel1];
        
        TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel2.identifier = [TDD_ArtiReportCodeSectionTableViewCell reuseIdentifier];
        cellModel2.cellHeight = IS_IPad ? 60 : 40.0;
        cellModel2.cellA4Height = 30.0;
        cellModel2.leftWidth = 0.6;
        cellModel2.rightWidth = 0.2;
        [model.cellModels addObject:cellModel2];
        
        NSMutableArray *dtcs = [[NSMutableArray alloc] init];

        for (int j = 0; j < vctItem[i].vctNode.size(); j++) {
            stDtcNodeEx stDtcNode = vctItem[i].vctNode[j];
            TDD_ArtiReportCellModel *cellModel = [[TDD_ArtiReportCellModel alloc] init];
            cellModel.identifier = [TDD_ArtiReportCodeRowTableViewCell reuseIdentifier];
            cellModel.cellHeight = IS_IPad ? 100 : 50.0;
            cellModel.cellA4Height = 30.0;
            cellModel.leftWidth = 0.6;
            cellModel.rightWidth = 0.2;
            cellModel.headerTitle = [TDD_CTools CStrToNSString:stDtcNode.strCode];
            cellModel.leftTitle = [TDD_CTools CStrToNSString:stDtcNode.strDescription];
            cellModel.dtcNodeStatus = stDtcNode.uStatus;
            cellModel.dtcNodeStatusStr = [TDD_CTools CStrToNSString:stDtcNode.strStatus];
            [model.cellModels addObject:cellModel];
            
            [dtcs addObject:@{
                @"DTC_code": cellModel.headerTitle,
                @"DTC_describe": cellModel.leftTitle,
                @"DTC_state_type": @(cellModel.dtcNodeStatus),
                @"DTC_state_type_str" : cellModel.dtcNodeStatusStr
            }];
            
            HLog(@"【REPORT】ArtiReportAddDtcItems %@", cellModel);
        }
        
        NSDictionary *dtcJson = @{
                @"system_id": [TDD_CTools CStrToNSString:vctItem[i].strID],
                @"system_name": [TDD_CTools CStrToNSString:vctItem[i].strName],
                @"DTC_list": dtcs
        };
        [model.codesItems addObject:dtcJson];
    }
}

+(void) ArtiReportAddLiveDataSys:(uint32_t)id with:(std::string)strSysId with:(std::string)strSysName
{
    
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    if ([model isAdasReport]) { return; }
    TDD_ArtiReportCellModel *cellModel1 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel1.identifier = [TDD_ArtiReportCodeTitleTableViewCell reuseIdentifier];
    cellModel1.cellHeight = IS_IPad ? 80 : 60.0;
    cellModel1.cellA4Height = 30.0;
    cellModel1.leftWidth = 0.6;
    cellModel1.rightWidth = 0.2;
    cellModel1.headerTitle = [TDD_CTools CStrToNSString:strSysName];
    cellModel1.system_id = [TDD_CTools CStrToNSString:strSysId];
    [model.cellModels addObject:cellModel1];
    
    TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel2.identifier = [TDD_ArtiReportFlowSectionTableViewCell reuseIdentifier];
    cellModel2.cellHeight = 60.0;
    cellModel2.cellA4Height = 30.0;
    cellModel2.headerTitle = [TDD_CTools CStrToNSString:strSysName];
    cellModel2.system_id = [TDD_CTools CStrToNSString:strSysId];
    [model.cellModels addObject:cellModel2];
    
    HLog(@"【REPORT】ArtiReportAddLiveDataSys %@", cellModel1.headerTitle);
}

+(void) ArtiReportAddLiveDataItem:(uint32_t)id with:(stDsReportItem)dsItem
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    if ([model isAdasReport]) { return; }
    
    TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
    cellModel2.identifier = [TDD_ArtiReportFlowRowTableViewCell reuseIdentifier];
    cellModel2.cellHeight = 60.0;
    cellModel2.cellA4Height = 30.0;
    TDD_UnitConversionModel *unitAndValueModel = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:dsItem.strUnit] value:[TDD_CTools CStrToNSString:dsItem.strValue]];
    TDD_UnitConversionModel *unitAndValueMinModel = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:dsItem.strUnit] value:[TDD_CTools CStrToNSString:dsItem.strMin]];
    TDD_UnitConversionModel *unitAndValueMaxModel = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:dsItem.strUnit] value:[TDD_CTools CStrToNSString:dsItem.strMax]];
    
    NSString * reference;
    
    if (unitAndValueMinModel.value.length > 0 && unitAndValueMaxModel.value.length > 0) {
        reference = [NSString stringWithFormat:@"%@-%@", unitAndValueMinModel.value, unitAndValueMaxModel.value];
    }else if (unitAndValueMinModel.value.length > 0){
        reference = [NSString stringWithFormat:@">=%@", unitAndValueMinModel.value];
    }else if (unitAndValueMaxModel.value.length > 0){
        reference = [NSString stringWithFormat:@"<=%@", unitAndValueMaxModel.value];
    }else {
        reference = [TDD_CTools CStrToNSString:dsItem.strReference];
    }
    cellModel2.liveDatas = @[[TDD_CTools CStrToNSString:dsItem.strName], unitAndValueModel.value, unitAndValueModel.unit, reference];
    
    [model.cellModels addObject:cellModel2];
    
    HLog(@"【REPORT】ArtiReportAddLiveDataItem %@", cellModel2);
}

+(void) ArtiReportAddLiveDataItems:(uint32_t)id with:(std::vector<stDsReportItem>)vctItem
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    if ([model isAdasReport]) { return; }
    
    for (int i = 0; i < vctItem.size(); i++) {
        TDD_ArtiReportCellModel *cellModel2 = [[TDD_ArtiReportCellModel alloc] init];
        cellModel2.identifier = [TDD_ArtiReportFlowRowTableViewCell reuseIdentifier];
        cellModel2.cellHeight = 60.0;
        cellModel2.cellA4Height = 30.0;
        TDD_UnitConversionModel *unitAndValueModel = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:vctItem[i].strUnit] value:[TDD_CTools CStrToNSString:vctItem[i].strValue]];
        TDD_UnitConversionModel *unitAndValueMinModel = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:vctItem[i].strUnit] value:[TDD_CTools CStrToNSString:vctItem[i].strMin]];
        TDD_UnitConversionModel *unitAndValueMaxModel = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:vctItem[i].strUnit] value:[TDD_CTools CStrToNSString:vctItem[i].strMax]];
        
        NSString * reference;
        
        if (unitAndValueMinModel.value.length > 0 && unitAndValueMaxModel.value.length > 0) {
            reference = [NSString stringWithFormat:@"%@-%@", unitAndValueMinModel.value, unitAndValueMaxModel.value];
        }else if (unitAndValueMinModel.value.length > 0){
            reference = [NSString stringWithFormat:@">=%@", unitAndValueMinModel.value];
        }else if (unitAndValueMaxModel.value.length > 0){
            reference = [NSString stringWithFormat:@"<=%@", unitAndValueMaxModel.value];
        }else {
            reference = [TDD_CTools CStrToNSString:vctItem[i].strReference];
        }
        cellModel2.liveDatas = @[[TDD_CTools CStrToNSString:vctItem[i].strName], unitAndValueModel.value, unitAndValueModel.unit, reference];
        [model.cellModels addObject:cellModel2];
        
        HLog(@"【REPORT】ArtiReportAddLiveDataItems %@", cellModel2);
    }
}

+ (void)ArtiReportAddLiveDataItemSysName:(uint32_t)id with:(std::string)sysName with:(stDsReportItem)dsItem
{
    std::vector<stDsReportItem> vctItem = { dsItem };
    [self adasAddCaliResultWithId:id with:sysName with:vctItem];
}

+ (void)ArtiReportAddLiveDataItemsSysName:(uint32_t)id with:(std::string)sysName with:(std::vector<stDsReportItem>)vctItem
{
    [self adasAddCaliResultWithId:id with:sysName with:vctItem];
}

+ (void)adasAddCaliResultWithId:(uint32_t)id with:(std::string &)sysName with:(std::vector<stDsReportItem> &)vctItem {
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    
    NSString *sysNameText = [TDD_CTools CStrToNSString:sysName];
    if ([NSString tdd_isEmpty:sysNameText]) return;
    
    TDD_ArtiADASReportResult *tResult = nil;
    for (TDD_ArtiADASReportResult *result in model.adas_result) {
        if ([result.sysName isEqualToString:sysNameText]) {
            tResult = result;
            break;
        }
    }
    
    if (tResult == nil) {
        HLog(@"【REPORT】adasAddCaliResultWithId tResult为 nil");
        return;
    }
    
    CGFloat maxValueWidth = 0;
    CGFloat maxRefWidth = 0;
    
    if (tResult.parameters == nil) {
        TDD_ArtiADASParameters *header = [[TDD_ArtiADASParameters alloc]
                                          //initWithKey:@"名称" value:@"数值" reference:@"参考范围"
                                          initWithKey:TDDLocalized.diagnosis_name value:TDDLocalized.report_data_stream_number reference:TDDLocalized.report_data_stream_reference
                                          isHeader:YES horizonalInset:12.0];
        maxValueWidth = header.valueWidth;
        maxRefWidth = header.referenceWidth;
        tResult.parameters = @[header].mutableCopy;
    }
    
    for (const stDsReportItem& item: vctItem) {
        NSString *key = [TDD_CTools CStrToNSString:item.strName];
        NSString *value = [TDD_CTools CStrToNSString:item.strValue];
        NSString *originReference = [TDD_CTools CStrToNSString:item.strReference];
        NSString *unit = [TDD_CTools CStrToNSString:item.strUnit];
        NSString *min = [TDD_CTools CStrToNSString:item.strMin];
        NSString *max = [TDD_CTools CStrToNSString:item.strMax];
        
        TDD_UnitConversionModel *unitAndValueModel = [TDD_UnitConversion diagUnitConversionWithUnit:unit value:value];
        TDD_UnitConversionModel *unitAndValueMinModel = [TDD_UnitConversion diagUnitConversionWithUnit:unit value:min];
        TDD_UnitConversionModel *unitAndValueMaxModel = [TDD_UnitConversion diagUnitConversionWithUnit:unit value:max];
        
        NSString * reference;
        if (unitAndValueMinModel.value.length > 0 && unitAndValueMaxModel.value.length > 0) {
            reference = [NSString stringWithFormat:@"%@-%@", unitAndValueMinModel.value, unitAndValueMaxModel.value];
        }else if (unitAndValueMinModel.value.length > 0){
            reference = [NSString stringWithFormat:@">=%@", unitAndValueMinModel.value];
        }else if (unitAndValueMaxModel.value.length > 0){
            reference = [NSString stringWithFormat:@"<=%@", unitAndValueMaxModel.value];
        }else {
            reference = originReference;
        }
        
        TDD_ArtiADASParameters *adasItem = [[TDD_ArtiADASParameters alloc] initWithKey:key value:[NSString stringWithFormat:@"%@%@",value,unit] reference:reference unit:unit min:min max:max isHeader:NO horizonalInset:12.0];
        
        if (adasItem.valueWidth > maxValueWidth) {
            maxValueWidth = adasItem.valueWidth;
        }
        if (adasItem.referenceWidth > maxRefWidth) {
            maxRefWidth = adasItem.referenceWidth;
        }
        HLog(@"【REPORT】adasAddCaliResultWithId %@", adasItem);
        [tResult addWithParameter:adasItem];
    }
    
    // 更新
    for (TDD_ArtiADASParameters *adasItem in tResult.parameters) {
        adasItem.valueWidth = maxValueWidth;
        adasItem.referenceWidth = maxRefWidth;
    }
    
}

+ (void)ArtiReportSetAdasCaliResult:(uint32_t)id with:(std::vector<stReportAdasResult>)vctSysItem
{
    TDD_ArtiReportModel *model = (TDD_ArtiReportModel *)[self getModelWithID:id];
    
    for (const stReportAdasResult& item : vctSysItem) {
        NSString *sysName = [TDD_CTools CStrToNSString: item.strSysName];
        
        if (model.reportType == TDD_ArtiReportTypeAdasSingleSystem) {
            model.adasSingleSysName = sysName;
            TDD_ArtiADASReportResult *result = [[TDD_ArtiADASReportResult alloc] initWithSysName:sysName startTime:[TDD_CTools CStrToNSString:item.strStartTime] stopTime:[TDD_CTools CStrToNSString:item.strStopTime] totalTime:NSInteger(item.uTotalTimeS) type:NSInteger(item.uType) status:NSInteger(item.uStatus)];
            if (model.adas_result.count == 0) {
                [model.adas_result addObject:result];
            } else {
                [model.adas_result replaceObjectAtIndex:0 withObject:result];
            }
            HLog(@"【REPORT】ArtiReportSetAdasCaliResult %@ %@", sysName, result);
        } else {
            
            if (![NSString tdd_isEmpty:sysName]) {
                TDD_ArtiADASReportResult *result = [[TDD_ArtiADASReportResult alloc] initWithSysName:sysName startTime:[TDD_CTools CStrToNSString:item.strStartTime] stopTime:[TDD_CTools CStrToNSString:item.strStopTime] totalTime:NSInteger(item.uTotalTimeS) type:NSInteger(item.uType) status:NSInteger(item.uStatus)];
                [model.adas_result addObject:result];
                
                HLog(@"【REPORT】ArtiReportSetAdasCaliResult %@ %@", sysName, result);
            }
            
        }
    }
    
}


+ (TDD_ArtiReportCellModel *)reportCellModelWithItem:(TDD_ArtiLiveDataItemModel *)itemModel {
    TDD_ArtiReportCellModel *cellModel = [[TDD_ArtiReportCellModel alloc] init];
    cellModel.identifier = [TDD_ArtiReportFlowRowTableViewCell reuseIdentifier];
    cellModel.cellHeight = 60.0;
    cellModel.cellA4Height = 30.0;
    
    NSString * reference;
    if (itemModel.setStrMin.length > 0 && itemModel.setStrMax.length > 0) {
        reference = [NSString stringWithFormat:@"%@-%@", itemModel.setStrMin, itemModel.setStrMax];
    }else if (itemModel.setStrMin.length > 0){
        reference = [NSString stringWithFormat:@">=%@", itemModel.setStrMin];
    }else if (itemModel.setStrMax.length > 0){
        reference = [NSString stringWithFormat:@"<=%@", itemModel.setStrMax];
    }else {
        reference = itemModel.strReference;
    }
    cellModel.liveDatas = @[itemModel.strName, itemModel.strChangeValue, itemModel.strChangeUnit, reference];
    return cellModel;
}

// MARK: - 其它

-(void)updateRepairHistory
{
    // 获取最新一条一个月内的数据
    NSDate *afterOneMonthDate = [self getAroundDateFromDate:[NSDate new] month:-1];
    UInt32 interaval = (UInt32)[afterOneMonthDate timeIntervalSince1970];
    NSString *safeVIN = [NSString tdd_isEmpty:self.VIN] ? @"" : self.VIN;
    
    // 只查维修前的
    NSString *criteria = [NSString stringWithFormat:@"WHERE (VIN = '%@' OR VIN isNULL OR VIN = '') AND VCISerialNumber = '%@' AND createTime > %u AND reportType = %zd AND repairIndex = 1 AND languageId = %zd or languageId ISNULL ORDER BY createTime DESC;", safeVIN, [TDD_DiagnosisTools selectedVCISerialNum], interaval, self.reportType, TDD_HLanguage.getServiceLanguageId];
    NSArray <TDD_ArtiReportHistoryJKDBModel *> *adasReports = [TDD_ArtiReportHistoryJKDBModel findByCriteria:criteria];
    
    // 是否有历史记录
    self.hasRepairHistory = adasReports.count > 0;
    
    // 更新一列还是二列
    for (int i = 0; i < self.cellModels.count; i++) {
        TDD_ArtiReportCellModel *cellModel = self.cellModels[i];
        if ([cellModel.identifier isEqualToString: [TDD_ArtiReportRepairHeaderTableViewCell reuseIdentifier]] || [cellModel.identifier isEqualToString: [TDD_ArtiADASReportRepairHeaderCell reuseIdentifier]]) {
            if (self.hasRepairHistory == YES && (self.repairIndex == 2 || self.repairIndex == 3)) {
                cellModel.leftWidth = 0.3;
                cellModel.rightWidth = 0.3;
            } else {
                cellModel.leftWidth = 0.0;
                cellModel.rightWidth = 0.48;
            }
        }
        if ([cellModel.identifier isEqualToString: [TDD_ArtiReportRepairSectionTableViewCell reuseIdentifier]]) {
            if (self.hasRepairHistory == YES && (self.repairIndex == 2 || self.repairIndex == 3)) {
                cellModel.leftWidth = 0.3;
                cellModel.rightWidth = 0.3;
            } else {
                cellModel.leftWidth = 0.0;
                cellModel.rightWidth = 0.48;
            }
        }
    }
    
    TDD_ArtiReportHistoryJKDBModel *latestAdasReport = adasReports.firstObject;
    latestAdasReport.items = [NSArray yy_modelArrayWithClass:[TDD_ArtiReportCellModel class] json:latestAdasReport.strData];
    
    // 更新一列还是二列
    for (int i = 0; i < self.repairCellModels.count; i++) {
        TDD_ArtiReportCellModel *cellModel = self.repairCellModels[i];
        if ([cellModel.identifier isEqualToString: [TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]]) {
            if (self.hasRepairHistory == YES && (self.repairIndex == 2 || self.repairIndex == 3)) {
                cellModel.leftWidth = 0.3;
                cellModel.rightWidth = 0.3;
                
                for (int j = 0; j < latestAdasReport.items.count; j++) {
                    TDD_ArtiReportCellModel* historyModel = latestAdasReport.items[j];
                    NSString *safeHistoryVIN = [NSString tdd_isEmpty:latestAdasReport.VIN] ? @"" : latestAdasReport.VIN;
                    if ([historyModel.identifier isEqualToString:[TDD_ArtiReportRepairRowTableViewCell reuseIdentifier]] && [historyModel.rightUDtsName isEqualToString:cellModel.rightUDtsName] && [safeHistoryVIN isEqualToString:safeVIN]) {
                        cellModel.leftUDtsNums = historyModel.rightUDtsNums;
                        cellModel.leftUDtsName = historyModel.rightUDtsName;
                    }
                    
                    if (j == (latestAdasReport.items.count - 1) && [NSString tdd_isEmpty:cellModel.leftUDtsName]) {
                        cellModel.leftUDtsName = @"-";
                    }
                }
                
            } else {
                cellModel.leftWidth = 0.0;
                cellModel.rightWidth = 0.48;
            }
        }
    }
    
    // ADAS
    [self updateADASHistoryIfNeededWithLatestAdasReport:latestAdasReport];
}

- (void)updateADASHistoryIfNeededWithLatestAdasReport:(TDD_ArtiReportHistoryJKDBModel*)latestAdasReport {
    // 准备数据
    // 数据转换
    self.adas_tirePressureData = self.tirePressure.asADASTirePDFData;
    self.adas_wheelEyebrowData = self.wheelEyebrow.asADASTirePDFData;
    
    // 重置数据
    self.adasHisotryFuel = nil;
    self.fuel.type = TDD_ArtiADASReportFuelTypeCurrent;
    
    // 条件
    if (self.reportType != TDD_ArtiReportTypeAdasSystem) return;
    if (self.repairIndex != 2) return;
    if (latestAdasReport == nil) return;

    // 胎压
    TDD_ArtiReportCellModel *historyTirePressure = nil;
    // 轮眉
    TDD_ArtiReportCellModel *historyWheelEyebrow = nil;
    // 燃油表
    TDD_ArtiReportCellModel *historyFuel = nil;
    
    for (TDD_ArtiReportCellModel *item in latestAdasReport.items) {
        
        if ([item.identifier isEqualToString:[TDD_ArtiADASReportTirePreviewCell reuseIdentifier]]) {
            if (item.adasTireData && item.adasTireData.type == TDD_ArtiADASTirePDFTypeTirePressure) {
                historyTirePressure = item;
            } else if (item.adasTireData && item.adasTireData.type == TDD_ArtiADASTirePDFTypeWheelEyebrow) {
                historyWheelEyebrow = item;
            }
        }
        
        if ([item.identifier isEqualToString:[TDD_ArtiADASReportFuelPreviewCell reuseIdentifier]]) {
            historyFuel = item;
        }
    }
    
    if (historyTirePressure && self.adas_tirePressureData) { // 处理胎压 校准前和校准后
        [self.adas_tirePressureData insertWithHistoryTireData: historyTirePressure.adasTireData];
    }
    
    if (historyWheelEyebrow && self.adas_wheelEyebrowData) {
        [self.adas_wheelEyebrowData insertWithHistoryTireData: historyWheelEyebrow.adasTireData];
    }
    
    if (historyFuel && self.hasFuel) {
        self.adasHisotryFuel = historyFuel.adasFuel;
    }
    
}

-(NSDate *)getAroundDateFromDate:(NSDate *)date month:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calender dateByAddingComponents:comps toDate:date options:0];;
}

// MARK: - ReportType

+ (TDD_ArtiReportType)reportTypeFromValue:(uint32_t)value {
    TDD_ArtiReportType type;
    switch (value) {
        case 1:
            type = TDD_ArtiReportTypeSystem;
            break;
        case 2:
            type = TDD_ArtiReportTypeDTC;
            break;
        case 3:
            type = TDD_ArtiReportTypeDataStream;
            break;
        case 0x11:
            type = TDD_ArtiReportTypeAdasSystem;
            break;
        case 0x12:
            type = TDD_ArtiReportTypeAdasDTC;
            break;
        case 0x13:
            type = TDD_ArtiReportTypeAdasDataStream;
        case 0x14:
            type = TDD_ArtiReportTypeAdasSingleSystem;
            break;
        default:
            break;
    }
    
    return type;
}
- (BOOL) isAdasReport {
    switch (_reportType) {
        case TDD_ArtiReportTypeAdasSystem:
            return YES;
            break;
        // 0x12 和 0x13 此版本走以前的逻辑，UI未定义
        case TDD_ArtiReportTypeAdasDTC:
            return NO;
            break;
        case TDD_ArtiReportTypeAdasDataStream:
            return NO;
            break;
        case TDD_ArtiReportTypeAdasSingleSystem:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

- (BOOL)hasFuel {
    return ((![NSString tdd_isEmpty:self.fuel.percent]) || self.fuelImage);
}

// MARK: - 图片操作

+ (NSString *)reportImageDir {
    NSString *reportImageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ReportImages"];
    return reportImageDirPath;
}

+ (NSString *)adasImageDir:(TDD_DBType)dbType {
    if (dbType == TDD_DATA_BASE_TYPE_GROUP) {
        NSString *documentPath = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:[TDD_DiagnosisManage storeGroupID]] path];
        documentPath = [documentPath stringByAppendingPathComponent:@"ReportImages"];
        return  [documentPath stringByAppendingPathComponent:@"ADAS"];;
    }
    NSString *adasImageDirPath = [[self reportImageDir] stringByAppendingPathComponent:@"ADAS"];
    return adasImageDirPath;
}

+ (NSString *)adasFuelImageDir {
    NSString *adasImageDirPath = [[self reportImageDir] stringByAppendingPathComponent:@"ADAS_Fuel"];
    return adasImageDirPath;
}

+ (void)saveAdasImages:(NSArray<UIImage *> *)imageDatas dbType:(TDD_DBType)dbType withCreateTime:(NSTimeInterval)createTime withBlock:(void (^)(void))completionBlock {
    if (imageDatas == nil || imageDatas.count == 0) {
        [self removeAdasImages: createTime dbType:dbType];
        if (completionBlock) { completionBlock(); }
    } else { // 最多4张
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *adasImageDirPath = [TDD_ArtiReportModel adasImageDir:dbType];
        if (![fileMgr fileExistsAtPath: adasImageDirPath]) {
            NSError *error;
            [fileMgr createDirectoryAtPath:adasImageDirPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"xinwen create %@ %@", adasImageDirPath, error);
            }
        }
        
        
        NSString *timeDirPath = [adasImageDirPath stringByAppendingPathComponent:[self dateStringFromTimestamp: createTime]];
        if (![fileMgr fileExistsAtPath: timeDirPath]) {
            NSError *error;
            [fileMgr createDirectoryAtPath:timeDirPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"xinwen create %@ %@", timeDirPath, error);
            }
        }
        
        dispatch_group_t group = dispatch_group_create();
        for (int i = 0; i < imageDatas.count; i++) {
            UIImage *image = imageDatas[i];
            dispatch_group_enter(group);
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
                NSString *imageName = [NSString stringWithFormat:@"adasImg_%zd", i];
                NSString *imagePath = [timeDirPath stringByAppendingPathComponent:imageName];
                [imgData writeToFile:imagePath atomically:YES];
                dispatch_group_leave(group);
            });
        }
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (completionBlock) { completionBlock(); }
        });
        
    }
}

+(void)removeAdasImages:(NSTimeInterval) createTime dbType:(TDD_DBType)dbType {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *adasImageDirPath = [TDD_ArtiReportModel adasImageDir:dbType];
    NSString *timeDirPath = [adasImageDirPath stringByAppendingPathComponent:[self dateStringFromTimestamp: createTime]];
    
    if ([fileMgr fileExistsAtPath:timeDirPath]) {
        NSError *error;
        [fileMgr removeItemAtPath:timeDirPath error:&error];
        if (error) {
            NSLog(@"xinwen remove %@ %@", timeDirPath, error);
        }
    }
}

+ (NSArray<NSString *> *)fetchAdasImagePathsWithCreateTime:(NSTimeInterval)createTime dbType:(TDD_DBType)dbType {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *adasImageDirPath = [TDD_ArtiReportModel adasImageDir:dbType];
    NSString *timeDirPath = [adasImageDirPath stringByAppendingPathComponent:[self dateStringFromTimestamp:createTime]];
    if ([fileMgr fileExistsAtPath:timeDirPath]) {
        NSError *error;
        NSArray<NSString *> *files = [fileMgr contentsOfDirectoryAtPath:timeDirPath error: &error];
        if (error) {
            NSLog(@"xinwen contentsOfDirectoryAtPath: %@, %@", timeDirPath, error);
            return @[].mutableCopy;
        } else {
            NSMutableArray <NSString *> *fullPaths = @[].mutableCopy;
            NSArray *sortedFiles = [files sortedArrayUsingComparator:^NSComparisonResult(NSString* _Nonnull obj1, NSString* _Nonnull obj2) {
                if (obj1 < obj2) {
                    return NSOrderedAscending;
                } else {
                    return NSOrderedDescending;
                }
            }];
            
            for (NSString *name in sortedFiles) {
                NSString *fullPath = [timeDirPath stringByAppendingPathComponent: name];
                [fullPaths addObject: fullPath];
            }
            
            return [fullPaths copy];
        }
    } else {
        return @[].mutableCopy;
    }
}

+ (void)saveAdasFuelImage: (UIImage * _Nullable)imageData withCreateTime: (NSTimeInterval)createTime withBlock:(void (^)(void))completionBlock {
    if (imageData == nil) {
        [self removeFuelImage: createTime];
        if (completionBlock) { completionBlock(); }
    } else { // 最多4张
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *adasFuelDirPath = [TDD_ArtiReportModel adasFuelImageDir];
        if (![fileMgr fileExistsAtPath: adasFuelDirPath]) {
            NSError *error;
            [fileMgr createDirectoryAtPath:adasFuelDirPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"xinwen create %@ %@", adasFuelDirPath, error);
            }
        }
        
        
        NSString *timeDirPath = [adasFuelDirPath stringByAppendingPathComponent:[self dateStringFromTimestamp: createTime]];
        if (![fileMgr fileExistsAtPath: timeDirPath]) {
            NSError *error;
            [fileMgr createDirectoryAtPath:timeDirPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"xinwen create %@ %@", timeDirPath, error);
            }
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *image = imageData;
            NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
            NSString *imageName = @"adasFuelImg";
            NSString *imagePath = [timeDirPath stringByAppendingPathComponent:imageName];
            [imgData writeToFile:imagePath atomically:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) { completionBlock(); }
            });
        });
    }
    
}

+ (void)removeFuelImage:(NSTimeInterval)createTime {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *adasFuelDirPath = [TDD_ArtiReportModel adasFuelImageDir];
    NSString *timeDirPath = [adasFuelDirPath stringByAppendingPathComponent:[self dateStringFromTimestamp: createTime]];
    
    if ([fileMgr fileExistsAtPath:timeDirPath]) {
        NSError *error;
        [fileMgr removeItemAtPath:timeDirPath error:&error];
        if (error) {
            NSLog(@"xinwen remove %@ %@", timeDirPath, error);
        }
    }
}

+ (NSString * _Nullable) fetchAdasFuelImagePathWithCreateTime: (NSTimeInterval)createTime {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *adasFuelDirPath = [TDD_ArtiReportModel adasFuelImageDir];
    NSString *timeDirPath = [adasFuelDirPath stringByAppendingPathComponent:[self dateStringFromTimestamp:createTime]];
    if ([fileMgr fileExistsAtPath:timeDirPath]) {
        NSError *error;
        NSArray<NSString *> *files = [fileMgr contentsOfDirectoryAtPath:timeDirPath error: &error];
        if (error) {
            NSLog(@"xinwen contentsOfDirectoryAtPath: %@, %@", timeDirPath, error);
            return nil;
        } else {
            NSString *name = files.firstObject;
            if (!name) { return nil; }
            NSString *fullPath = [timeDirPath stringByAppendingPathComponent: name];
            return fullPath;
        }
    } else {
        return nil;
    }
}

// MARK: - Help

+ (NSString *)dateStringFromTimestamp:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end

