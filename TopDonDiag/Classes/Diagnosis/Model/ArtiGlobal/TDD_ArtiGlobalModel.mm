//
//  TDD_ArtiGlobalModel.m
//  AD200
//
//  Created by 何可人 on 2022/6/7.
//

#import "TDD_ArtiGlobalModel.h"
#if useCarsFramework
#import <CarsFramework/RegGlobal.hpp>
#import <CarsFramework/StdShow.hpp>
#include <CarsFramework/HStdOtherMaco.h>
#else
#import "RegGlobal.hpp"
#import "StdShow.hpp"
#include "HStdOtherMaco.h"
#endif

#import "TDD_StdShowModel.h"

#import "TDD_DiagnosisManage.h"

#import "TDD_CTools.h"

#import "TDD_ADWebSocket.h"

#import "TDD_ADDiagnosisModel.h"

#import "TDD_UnitConversion.h"

#import "TDD_HistoryDiagModel.h"
#import "TDD_HistoryDiagManage.h"

#import "TDD_ADASManage.h"
#import "TDD_FCAAuthModel.h"
#import "TDD_ArtiInstanceView.h"
#import "TDD_UserdefaultManager.h"
#import "TDD_JKDBHelper.h"

@implementation TDD_ArtiGlobalModel
{
    NSMutableDictionary *_authPasswordSaveDict;
}
#pragma mark 创建单例
+(TDD_ArtiGlobalModel *)sharedArtiGlobalModel {
    static TDD_ArtiGlobalModel * artiModel = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        artiModel = [[self alloc] init];
    });
    return artiModel;
}

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CRegGlobal::GetAppVersion(ArtiGlobalGetAppVersion);
    CRegGlobal::GetLanguage(ArtiGlobalModelGetLanguage);
    CRegGlobal::GetVehPath(ArtiGlobalModelGetVehPath);
    CRegGlobal::GetVehUserDataPath(ArtiGlobalModelGetVehUserDataPath);
    CRegGlobal::GetVehName(ArtiGlobalModelGetVehName);
    CRegGlobal::GetVIN(ArtiGlobalModelGetVIN);
    CRegGlobal::SetVIN(ArtiGlobalModelSetVIN);
    CRegGlobal::SetVehicle(ArtiGlobalModelSetVehicle);
    CRegGlobal::SetVehicleEx(ArtiGlobalSetVehicleEx);
    CRegGlobal::SetVehInfo(ArtiGlobalModelSetVehInfo);
    CRegGlobal::SetSysName(ArtiGlobalModelSetSysName);
    CRegGlobal::IsNetworkAvailable(ArtiGlobalModelIsNetworkAvailable);
    CRegGlobal::GetHostType(ArtiGlobalModelGetHostType);
    CRegGlobal::GetAppProductName(ArtiGlobalModelGetAppProductName);
    CRegGlobal::GetAppScenarios(ArtiGlobalModelGetAppScenarios);
    CRegGlobal::GetDiagEntryType(ArtiGlobalModelGetDiagEntryType);
    CRegGlobal::GetDiagEntryTypeEx(ArtiGlobalModelGetDiagEntryTypeEx);
    CRegGlobal::RpcSend(ArtiGlobalModelRpcSend);
    CRegGlobal::GetDiagMenuMask(ArtiGlobalModelGetDiagMenuMask);
    CRegGlobal::UnitsConversion(ArtiGlobalModelUnitsConversion);
    CRegGlobal::GetCurUnitMode(ArtiGlobalModelGetCurUnitMode);
    CRegGlobal::GetVehPathEx(ArtiGlobalModelGetVehPathEx);
    CRegGlobal::GetAutoVinEntryType(ArtiGlobalModelGetAutoVinEntryType);
    //历史诊断
    CRegGlobal::GetHistoryRecord(ArtiGlobalModelGetHistoryRecord);
    CRegGlobal::SetHistoryRecord(ArtiGlobalModelSetHistoryRecord);
    CRegGlobal::SetHistoryMileage(ArtiGlobalModelSetHistoryMileage);
    CRegGlobal::SetHistoryDtcItem(ArtiGlobalModelSetHistoryDtcItem);
    CRegGlobal::SetHistoryMMY(ArtiGlobalModelSetHistoryMMY);
    CRegGlobal::SetHistoryEngine(ArtiGlobalModelSetHistoryEngine);
    CRegGlobal::IsEntryFromHistory(IsEntryFromHistory);

    //FCA
    CRegGlobal::FcaInitSend(ArtiGlobalModelFcaInitSend);
    CRegGlobal::FcaRequestSend(ArtiGlobalModelFcaRequestSend);
    CRegGlobal::FcaTrackSend(ArtiGlobalModelFcaTrackSend);
    CRegGlobal::FcaGetLoginRegion(ArtiGlobalFcaGetLoginRegion);

    //TopVCI
    CRegGlobal::SetAutoVinProtocol(ArtiGlobalModelSetAutoVinProtocol);
    CRegGlobal::GetAutoVinProtocol(ArtiGlobalModelGetAutoVinProtocol);
    CRegGlobal::GetAutoVinScannMode(ArtiGlobalModelGetAutoVinScannMode);
    CRegGlobal::GetServerVinInfo(ArtiGlobalGetServerVinInfo);
    //小车探 以及 TopScan4.56 及以后版本才注册这个接口
    if (isTopVCI || ([TDD_DiagnosisTools softWareIsKindOfTopScan] && [[TDD_DiagnosisManage getVersion] compare:@"2.06.000" options:NSNumericSearch] == NSOrderedDescending)) {
        CRegGlobal::SetCurVehNotSupport(ArtiGlobalModelSetCurVehNotSupport);
    }
    CRegGlobal::SetEventTracking(ArtiGlobalModelSetEventTracking);

    CRegGlobal::GetServerVinInfoValue(ArtiGlobalGetServerVinInfoValue);
    CRegGlobal::GetObdEntryType(ArtiGlobalGetObdEntryType);

}

static uint32_t ArtiGlobalGetAppVersion()
{
    return [TDD_ArtiGlobalModel GetAppVersion];
}

static std::string const ArtiGlobalModelGetLanguage()
{
    NSString * language = [TDD_ArtiGlobalModel GetLanguage];
    return [TDD_CTools NSStringToCStr:language];
}

static std::string const ArtiGlobalModelGetVehPath()
{
    NSString * path = [TDD_ArtiGlobalModel GetVehPath];
    
    return [TDD_CTools NSStringToCStr:path];
}

static std::string const ArtiGlobalModelGetVehPathEx(const std::string& type,const std::string& path, const std::string& name)
{
    NSString *fileType = [TDD_CTools CStrToNSString:type];
    NSString *filePath = [TDD_CTools CStrToNSString:path];
    NSString *fileName = [TDD_CTools CStrToNSString:name];
    HLog(@"ArtiGlobalModelGetVehPathEx ")
    return [TDD_CTools NSStringToCStr:[TDD_ArtiGlobalModel getVehPathExWithVehType:fileType strVehArea:filePath strVehName:fileName]];
    
}

static uint32_t const ArtiGlobalModelGetAutoVinEntryType()
{
    return [TDD_ArtiGlobalModel GetAutoVinEntryType];
}

/*-----------------------------------------------------------------------------
功能：获取车型历史记录

      在进入车型时，车型代码在初始化时会调用此接口，判定是否是从历史记录中进入，
      并且获取到"SetHistoryRecord"中保存的字串信息，以便车型代码逻辑快速判定下一
      步操作

参数说明：无

返回值：返回所点击的历史记录中的"SetHistoryRecord"设置的字串
-----------------------------------------------------------------------------*/
static std::string const ArtiGlobalModelGetHistoryRecord()
{
    HLog(@"ArtiGlobalModelGetHistoryRecord:%@",[TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel.historyRecordID);
    return [TDD_CTools NSStringToCStr:[TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel?[TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel.historyRecordID:@""];
}

/*-----------------------------------------------------------------------------
功能：设置车型历史记录

      如果车型代码调用了此接口，App开始一条历史记录，车型代码如果需要添加相关的
      历史信息可通过以下接口设置
      SetHistoryMileage
      SetHistoryDtcItem
      SetHistoryMMY
      SetHistoryEngine
      

参数说明：strRecord  历史记录相关字串信息，信息内容由车型诊断自由决定
                     App负责保存在车型历史数据库中，以便下次车型进入时
                     调用"GetHistoryRecord"去获取

返回值：无

说  明：
      历史记录生成规则说明
      1、选车完成进入诊断功能菜单界面，生成1条诊断历史记录
      2、进系统读码或系统扫描，可以通过接口
         SetHistoryMileage
         SetHistoryDtcItem
         SetHistoryMMY
         SetHistoryEngine
         将当前系统和故障码信息添加到诊断历史记录中
      3、多次调用SetHistoryDtcItem，以系统Name来区分不同系统，
         同一系统的多次故障信息以最后一次为准
      4、多次调用SetHistoryHiddenItem，以功能大类名称和子类名称来区分
      5、历史的VIN可以通过SetVIN接口设置
         历史的车型路径，例如"宝马>302>系统>自动扫描"，可以通过SetVehInfo设置
         如果需要设置VIN和车型诊断路径，需要在SetHistoryRecord调用前设置
-----------------------------------------------------------------------------*/
static void ArtiGlobalModelSetHistoryRecord(const std::string& strHistoryRecord)
{
    NSString *historyRecordID = [TDD_CTools CStrToNSString:strHistoryRecord];
    HLog(@"ArtiGlobalModelSetHistoryRecord:%@",historyRecordID);
    if ([NSString tdd_isEmpty:historyRecordID]) {
        HLog(@"ArtiGlobalModelSetHistoryRecord 为空");
        return;
    }
    TDD_HistoryDiagModel *model = [[TDD_HistoryDiagModel alloc] init];
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel = model;
    @autoreleasepool {
    //    model.reportName = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName;
//        model.dbType = [TDD_JKDBHelper shareInstance].dbType;
        model.topdonId = [TDD_DiagnosisTools topdonID];
        model.language = [TDD_ArtiGlobalModel GetLanguage];
        model.historyRecordID = historyRecordID;
        if ([NSString tdd_isEmpty:model.brandName]) {
            model.brandName = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName;
        }
        
        model.timeStamp = [TDD_DiagnosisManage sharedManage].enterTime;
        model.time = [NSDate tdd_getTimeStringWithInterval:model.timeStamp Format:@"yyyy-MM-dd"];
        model.softwareVersion = [TDD_DiagnosisManage sharedManage].carModel.strVersion ? : @"";
    //    model.diagSoftwareVersion = [NSString stringWithFormat:@"V%u",[TDD_ArtiGlobalModel GetAppVersion]];
        model.diagSoftwareVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        model.vin = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"";
        model.diagPath = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarInfo?:@"";
        model.sn = [TDD_DiagnosisTools selectedVCISerialNum]?:@"";
        model.vehicleName = TDD_DiagnosisManage.sharedManage.carModel.strName?:@"";
        model.entryType = [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagEntryType;
        model.diagShowType = [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowType;
        model.diagShowSecondaryType = [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowSecondaryType;
        model.softCode = [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode?:@"";
        model.appLanguageId = [TDD_ArtiGlobalModel sharedArtiGlobalModel].appLanguageId;
        
        eObdEntryType obdEntryType = [TDD_ArtiGlobalModel sharedArtiGlobalModel].obdEntryType;
        // 小车探 部件检测、数据流、HUD、百公里加速 不记录历史进车
        if isKindOfTopVCI {
            if (obdEntryType == OET_TOPVCI_DATASTREAM || obdEntryType == OET_TOPVCI_HUD || obdEntryType == OET_TOPVCI_OBD_REVIEW || obdEntryType == OET_TOPVCI_ACTIVE_TEST) {
                HLog("ArtiGlobalModelSetHistoryRecord 不需要进车： OBD进车类型 %ld", obdEntryType);
                return;
            }
        }
        
        BOOL isSuccess = [model save];
        HLog(@"ArtiGlobalModelSetHistoryRecord save %@", @(isSuccess));
        
        NSInteger sourceType = 0;
        if (model.diagShowType == TDD_DiagShowType_DIAG) {
            if (model.diagShowSecondaryType != TDD_DiagShowSecondaryType_NONE) {
                sourceType = 2;
            }
        } else if (model.diagShowType == TDD_DiagShowType_IMMO) {
            sourceType = 1;
        } else if (model.diagShowType == TDD_DiagShowType_MOTO) {
            sourceType = 3;
        } else if (model.diagShowType == TDD_DiagShowType_Maintain) {
            sourceType = 2;
        } else if (model.diagShowType == TDD_DiagShowType_Maintain_MOTO) {
            sourceType = 5;
        } else if (model.diagShowType == TDD_DiagShowType_IMMO_MOTO) {
            sourceType = 4;
        }

        NSMutableDictionary *params = @{
            @"vin" : model.vin,
            @"softCode" : model.softCode,
            @"historyRecord" : model.historyRecordID,
            @"sourceType" : @(sourceType),
            @"mainCarVersion" : [TDD_DiagnosisManage sharedManage].carModel.strStaticLibraryVersion ? : @"",
            @"appVersion" : model.diagSoftwareVersion,
            @"sn" : model.sn,
            @"topdonId" : model.topdonId,
            @"brandName" : model.brandName,
            @"linkCarVersion" : [NSString tdd_isEmpty:[TDD_DiagnosisManage sharedManage].carModel.strLink] ? @"" : model.softwareVersion,
            @"productModelId" : @""
        }.mutableCopy;
        if (sourceType == 2 || sourceType == 5) {
            [params setObject:@(model.entryType) forKey:@"eDiagEntryType"];
        }
        if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_UploadHistoryDiagReport param:params completeHandle:nil];
        }
    }
}

/*-----------------------------------------------------------------------------
功能：设置历史记录中显示的车辆行驶里程（KM）

参数说明：诊断设置当前车辆行驶总里程（KM）

        strMileage            当前车辆行驶总里程（KM）
        strMILOnMileage        故障灯亮后的行驶里程（KM）

        例如：568        表示行驶总里程为568KM

返回值：

说  明：如果无“故障灯亮后的行驶里程”，则strMILOnMileage为空串""或空
-----------------------------------------------------------------------------*/
static void ArtiGlobalModelSetHistoryMileage(const std::string& strMileage, const std::string& strMILOnMileage)
{
    NSString *mileage = [TDD_CTools CStrToNSString:strMileage];
    NSString *milOnMileage = [TDD_CTools CStrToNSString:strMILOnMileage];
    if (![NSString tdd_isEmpty:mileage]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carMileage = mileage;
    }
    if (![NSString tdd_isEmpty:milOnMileage]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carMILOnMileage = milOnMileage;
    }
    HLog(@"ArtiGlobalModelSetHistoryMileage:%@  %@",mileage,milOnMileage);
    TDD_HistoryDiagModel *model = [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel;
    if (model && ![NSString tdd_isEmpty:model.historyRecordID]) {
        // 去掉前后空格
        mileage = [mileage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        TDD_UnitConversionModel *unitModel = [TDD_UnitConversion diagUnitConversionWithUnit:@"km" value:mileage];
        model.mileage = unitModel.value;
        model.mileageUnit = unitModel.unit;
        model.language = [TDD_ArtiGlobalModel GetLanguage];
        [model saveOrUpdate];
    }
    
}

/*-----------------------------------------------------------------------------
功能：添加历史记录中显示的故障码信息

参数说明：DtcItem    故障码列表项， 参考stDtcReportItemEx的定义

返回值：无

说  明：增加系统故障码信息，如果系统相同，以最后一次设置为准
-----------------------------------------------------------------------------*/
static void ArtiGlobalModelSetHistoryDtcItem(const stDtcReportItemEx& DtcItem)
{
    HLog(@"ArtiGlobalModelSetHistoryDtcItem:%@ %@",[TDD_CTools CStrToNSString:DtcItem.strID],[TDD_CTools CStrToNSString:DtcItem.strName]);
    TDD_HistoryDiagModel *model = [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel;
    @autoreleasepool {
        if (model && ![NSString tdd_isEmpty:model.historyRecordID]) {
           __block BOOL isContain = NO;
            NSMutableArray *systemMarray = @[].mutableCopy;
            if (![NSString tdd_isEmpty:model.systemArrayStr]) {
                NSArray *systemArray = [NSJSONSerialization JSONObjectWithData:[model.systemArrayStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                systemMarray = systemArray.mutableCopy;
                [systemArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    TDD_HistoryDtcItemModel *item = [TDD_HistoryDtcItemModel yy_modelWithJSON:obj];
                    if ([item.itemName isEqualToString:[TDD_CTools CStrToNSString:DtcItem.strName]]) {
                        item.itemID = [TDD_CTools CStrToNSString:DtcItem.strID];
                        NSMutableArray *nsArray = [NSMutableArray array];
                        
                        for (int j = 0; j < DtcItem.vctNode.size(); j++) {
                            stDtcNodeEx ex = DtcItem.vctNode[j];
                            HLog(@"ArtiGlobalModelSetHistoryDtcItem stDtcNodeEx: strCode:%@ strDescription:%@ strStatus:%@ uStatus:%d",[TDD_CTools CStrToNSString:ex.strCode],[TDD_CTools CStrToNSString:ex.strDescription],[TDD_CTools CStrToNSString:ex.strStatus],ex.uStatus);
                            TDD_HistoryDtcNodeExModel *exModel = [TDD_HistoryDiagManage dtcNodeExModelWith:ex];
                            [nsArray addObject:exModel];
                        }
                        item.vctNodeArr = nsArray;
                        if (systemMarray.count > idx) {
                            [systemMarray replaceObjectAtIndex:idx withObject:[item yy_modelToJSONString]];
                        }
                        isContain = YES;
                        *stop = YES;
                    }
                }];
            }

            if (!isContain) {
                TDD_HistoryDtcItemModel *item = [TDD_HistoryDiagManage dtcItemWith:DtcItem];
                [systemMarray addObject:[item yy_modelToJSONString]];
            }
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:systemMarray options:0 error:nil];
            model.systemArrayStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            model.language = [TDD_ArtiGlobalModel GetLanguage];
            [model saveOrUpdate];
        }
    }

}

/*-----------------------------------------------------------------------------
功能：设置历史记录中的MMY信息

参数说明：strMake     品牌
          strModel    车型
          strYear     年份

返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
          其他值，暂无意义
-----------------------------------------------------------------------------*/
static uint32_t ArtiGlobalModelSetHistoryMMY(const std::string& strMake, const std::string& strModel, const std::string& strYear)
{
    NSString *makeStr = [TDD_CTools CStrToNSString:strMake];
    NSString *modelStr = [TDD_CTools CStrToNSString:strModel];
    NSString *yearStr = [TDD_CTools CStrToNSString:strYear];
    if (![NSString tdd_isEmpty:makeStr]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand = makeStr;
    }
    if (![NSString tdd_isEmpty:modelStr]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel = modelStr;
    }
    if (![NSString tdd_isEmpty:yearStr]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear = yearStr;
    }
    
    HLog(@"ArtiGlobalModelSetHistoryMMY:%@ - %@  - %@",makeStr,modelStr,yearStr);
    TDD_HistoryDiagModel *model = [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel;
    if (model && ![NSString tdd_isEmpty:model.historyRecordID]) {
        model.brandName = makeStr;
        model.modelName = modelStr;
        model.carYear = yearStr;
        model.language = [TDD_ArtiGlobalModel GetLanguage];
        [model saveOrUpdate];
    }
    return 0;
}

/*-----------------------------------------------------------------------------
功能：设置历史记录中的车辆发动机信息

参数说明：
        strInfo      发动机机信息，例如，"F62-D52"
        strSubType   发动机子型号或者其它信息，例如，"N542"

返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
          其他值，暂无意义
-----------------------------------------------------------------------------*/
static uint32_t ArtiGlobalModelSetHistoryEngine(const std::string& strInfo, const std::string& strSubType)
{
    NSString *infoStr = [TDD_CTools CStrToNSString:strInfo];
    NSString *subTypeStr = [TDD_CTools CStrToNSString:strSubType];
    if (![NSString tdd_isEmpty:infoStr]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carEngineInfo = infoStr;
    }
    if (![NSString tdd_isEmpty:subTypeStr]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carEngineSubInfo = subTypeStr;
    }
    
    
    HLog(@"ArtiGlobalModelSetHistoryEngine:%@ - %@",infoStr,subTypeStr);
    TDD_HistoryDiagModel *model = [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel;
    if (model && ![NSString tdd_isEmpty:model.historyRecordID]) {
        model.engine = infoStr;
        model.subEngine = subTypeStr;
        model.language = [TDD_ArtiGlobalModel GetLanguage];
        [model saveOrUpdate];
    }
    return 0;
}

//是否历史进车
bool IsEntryFromHistory()
{
    HLog(@"ArtiGlobal IsEntryFromHistory - %@",@([TDD_ArtiGlobalModel sharedArtiGlobalModel].isEntryFromHistory));
    return [TDD_ArtiGlobalModel sharedArtiGlobalModel].isEntryFromHistory;
}

static std::string const ArtiGlobalModelGetVehUserDataPath()
{
    NSString * path = [TDD_ArtiGlobalModel GetVehUserDataPath];
    
    return [TDD_CTools NSStringToCStr:path];
}

static std::string const ArtiGlobalModelGetVehName()
{
    NSString * name = [TDD_ArtiGlobalModel GetVehName];
    
    return [TDD_CTools NSStringToCStr:name];
}

static std::string const ArtiGlobalModelGetVIN()
{
    NSString * VIN = [TDD_ArtiGlobalModel GetVIN];
    
    return [TDD_CTools NSStringToCStr:VIN];
}

static void ArtiGlobalModelSetVIN(const std::string& strVin)
{
    [TDD_ArtiGlobalModel SetVIN:[TDD_CTools CStrToNSString:strVin]];
}

static void ArtiGlobalModelSetVehicle(const std::vector<std::string>& vctVehicle)
{
    [TDD_ArtiGlobalModel SetVehicle:[TDD_CTools CVectorToStringNSArray:vctVehicle]];
}

static void ArtiGlobalSetVehicleEx(const std::vector<std::string>& vctVehDir, const std::vector<std::string>& vctVehName, const std::vector<std::string>& vctSoftCode)
{
    [TDD_ArtiGlobalModel SetVehicleEx:[TDD_CTools CVectorToStringNSArray:vctVehDir] vctVehName:[TDD_CTools CVectorToStringNSArray:vctVehName] vctSoftCode:[TDD_CTools CVectorToStringNSArray:vctSoftCode]];
    
}

static void ArtiGlobalModelSetVehInfo(const std::string& strVehInfo)
{
    [TDD_ArtiGlobalModel SetVehInfo:[TDD_CTools CStrToNSString:strVehInfo]];
}

static void ArtiGlobalModelSetSysName(const std::string& strSysName)
{
    [TDD_ArtiGlobalModel SetSysName:[TDD_CTools CStrToNSString:strSysName]];
}

static bool ArtiGlobalModelIsNetworkAvailable()
{
    return [TDD_ArtiGlobalModel IsNetworkAvailable];
}

static uint32_t const ArtiGlobalModelGetHostType()
{
    return [TDD_ArtiGlobalModel GetHostType];
}

static uint32_t const ArtiGlobalModelGetAppProductName()
{
    return [TDD_ArtiGlobalModel GetAppProductName];
}

static uint32_t const ArtiGlobalModelGetAppScenarios()
{
    return [TDD_ArtiGlobalModel GetAppScenarios];
}

static uint64_t const ArtiGlobalModelGetDiagEntryType()
{
    return [TDD_ArtiGlobalModel GetDiagEntryType];
}

static std::vector<bool> ArtiGlobalModelGetDiagEntryTypeEx()
{
    NSArray * arr = [TDD_ArtiGlobalModel GetDiagEntryTypeEx];

    std::vector<bool> boolVec;
    
    for (int i = 0; i < arr.count; i++) {
        bool value;
        if ([[arr objectAtIndex:i] isKindOfClass:[NSString class]]) {
            NSString *str = [arr objectAtIndex:i];
            NSNumber *num = @(str.integerValue);
            [num getValue:&value];
        }else {
            [[arr objectAtIndex:i] getValue:&value];
        }
        
        
        boolVec.push_back(value);
    }
    
    return boolVec;
}

static uint32_t ArtiGlobalModelFcaInitSend(const std::string& strSgwUUID, const std::string& strSgwSN, const std::string& strVin, const std::string& strEcuSN, const std::string& strEcuCanId, const std::string& strEcuPolicyType, uint32_t timsOutMs, uint32_t snApi)
{

    return [TDD_ArtiGlobalModel FcaInitSend:[TDD_CTools CStrToNSString:strSgwUUID] strSgwSN:[TDD_CTools CStrToNSString:strSgwSN] strVin:[TDD_CTools CStrToNSString:strVin] strEcuSN:[TDD_CTools CStrToNSString:strEcuSN] strEcuCanId:[TDD_CTools CStrToNSString:strEcuCanId] strEcuPolicyType:[TDD_CTools CStrToNSString:strEcuPolicyType] timsOutMs:timsOutMs snApi:snApi];
    
}

static uint32_t ArtiGlobalModelFcaRequestSend(const std::string& strSessionID, const std::string& strChallenge, uint32_t timsOutMs, uint32_t snApi)
{

    return [TDD_ArtiGlobalModel FcaRequestSend:[TDD_CTools CStrToNSString:strSessionID] strSgwSN:[TDD_CTools CStrToNSString:strChallenge] timsOutMs:timsOutMs snApi:snApi];
    
}

static uint32_t ArtiGlobalModelFcaTrackSend(const std::string& strSessionID, const std::string& strEcuResult, const std::string& strEcuResponse, uint32_t timsOutMs, uint32_t snApi)
{

    return [TDD_ArtiGlobalModel FcaTrackSend:[TDD_CTools CStrToNSString:strSessionID] strEcuResult:[TDD_CTools CStrToNSString:strEcuResult] strEcuResponse:[TDD_CTools CStrToNSString:strEcuResponse] timsOutMs:timsOutMs snApi:snApi];
}

/*------------------------------------------------------------------------------------
 *   功   能： 获取当前的FCA登录界面上用户选择的区域
 *
 *   参数说明：无
 *
 *   返 回 值：eLoginRegionType
 *
 *             LGT_SELECT_AMERICA     表示App的FCA登录中，当前选择的区域是美洲
 *             LGT_SELECT_EUROPE      表示App的FCA登录中，当前选择的区域是欧洲
 *             LGT_SELECT_OTHER       表示App的FCA登录中，当前选择的区域是其它
 *
 *             DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
 ------------------------------------------------------------------------------------*/
static uint32_t ArtiGlobalFcaGetLoginRegion()
{
    uint32_t area = (uint32_t )[[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthArea];
    HLog(@"ArtiGlobalFcaGetLoginRegion - %@",@(area));
    return area;
}

/*-----------------------------------------------------------------------------
功能：设置AUTOVIN通讯的协议类型字串
      APP保存以便下次进车(AutoVin)调用GetAutoVinProtocol获取协议快速进入

参数说明：strProtocol    诊断程序自己决定保存的协议字串信息

返回值：无

说  明：用于诊断程序AutoVin设置保存上一次的通讯协议，加快获取VIN类型
        国内版TOPVCI小车探
-----------------------------------------------------------------------------*/
static void ArtiGlobalModelSetAutoVinProtocol(const std::string& strProtocol)
{
    
    NSString *vin = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN;
    // 如果没有VIN 码 则不存
    if ([NSString tdd_isEmpty:vin]) {
        HLog(@"SetAutoVinProtocol -- 设置 autovin 协议: vin 码不存在, 返回");
        return;
    }
    NSString *protocolText = [TDD_CTools CStrToNSString:strProtocol];
    HLog(@"SetAutoVinProtocol -- 设置 autovin 协议: %@, vin - %@", protocolText, vin);
    NSString *autoVinProtoKey = [NSString stringWithFormat:@"autoVinProtocol_%@", vin];
    [[NSUserDefaults standardUserDefaults] setObject:protocolText forKey:autoVinProtoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*-----------------------------------------------------------------------------
功能：获取上次AUTOVIN通讯的协议类型字串
      APP返回SetAutoVinProtocol保存的协议字串

参数说明：无

返回值：返回上次AUTOVIN通过SetAutoVinProtocol保存的协议类型字串

说  明：用于诊断程序AutoVin使用指定的协议类型去获取车辆VIN，实现快速获取VIN的功能
        国内版TOPVCI小车探
-----------------------------------------------------------------------------*/
static std::string const ArtiGlobalModelGetAutoVinProtocol()
{
    NSString *vin = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN;
    // 如果没有VIN 码 则不存
    if ([NSString tdd_isEmpty:vin]) {
        HLog(@"GetAutoVinProtocol -- 获取 autovin 协议: vin 码不存在, 返回空");
        return [TDD_CTools NSStringToCStr:@""];
    }
    NSString *autoVinProtoKey = [NSString stringWithFormat:@"autoVinProtocol_%@", vin];
    NSString * autoVinProtocol = [[NSUserDefaults standardUserDefaults] objectForKey:autoVinProtoKey];
    HLog(@"GetAutoVinProtocol -- 获取 autovin 协议: %@", autoVinProtocol);
    return [TDD_CTools NSStringToCStr:autoVinProtocol?:@""];
}

/*-----------------------------------------------------------------------------
功能：获取当前AUTOVIN的协议扫描模式
      APP返回，是否用指定的协议去读取VIN，还是用正常的全协议扫描模式去获取VIN
      例如，国内版TOPVCI小车探

参数说明：无

返回值：  AVSM_MODE_NORMAL        = 1,  // 正常AUTOVIN协议扫描模式
          AVSM_MODE_LAST_PROTOCOL = 2,  // AUTOVIN使用上次保存的协议去读取VIN

说  明：国内版TOPVCI小车探
-----------------------------------------------------------------------------*/
static uint32_t const ArtiGlobalModelGetAutoVinScannMode()
{
    // 不是小车探 返回 1
    if (!isKindOfTopVCI) {
        HLog(@"GetAutoVinScannMode -- 获取 autovin 协议 mode 不是小车探 返回 1");
        return AVSM_MODE_NORMAL;
    }
    // 绑车
    if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].isAutoVinBindCar) {
        HLog(@"GetAutoVinScannMode -- 获取 autovin 协议 mode 绑车 返回 1");
        return AVSM_MODE_NORMAL;
    }
    NSString *vin = [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN;
    // 如果没有VIN 码 返回 1
    if ([NSString tdd_isEmpty:vin]) {
        HLog(@"GetAutoVinScannMode -- 获取 autovin 协议 mode vin 码为空 返回 1");
        return AVSM_MODE_NORMAL;
    }
    NSString *autoVinProtoKey = [NSString stringWithFormat:@"autoVinProtocol_%@", vin];
    NSString * autoVinProtocol = [[NSUserDefaults standardUserDefaults] objectForKey:autoVinProtoKey];
    
    // 如果本地存储的 protocol 为空 返回 1
    if ([NSString tdd_isEmpty:autoVinProtocol]) {
        HLog(@"GetAutoVinScannMode -- 获取 autovin 协议 mode 本地协议为空 返回 1 vin: %@", vin);
        return AVSM_MODE_NORMAL;
    }
    HLog(@"GetAutoVinScannMode -- 获取 autovin 协议 mode 获取到本地协议 返回 2 vin: %@", vin);
    return AVSM_MODE_LAST_PROTOCOL;
}

static std::string const ArtiGlobalGetServerVinInfo(uint32_t eGviValue)
{
    return [TDD_CTools NSStringToCStr:[TDD_ArtiGlobalModel ArtiGlobalGetServerVinInfo: eGviValue]];
}

static uint32_t ArtiGlobalModelSetCurVehNotSupport(uint32_t eType)
{
    return [TDD_ArtiGlobalModel ArtiGlobalSetCurVehNotSupport:eType];
}

static uint32_t ArtiGlobalModelSetEventTracking(eEventTrackingId id, const  std::vector<stTrackingItem>& vctPara)
{
    [TDD_ArtiGlobalModel ArtiGlobalModelSetEventTracking:id param:vctPara];

    return 0;
}

/*-----------------------------------------------------------------------------
 *    功    能：获取当前车辆信息（服务器解析VIN的结果）ID
 *              车辆信息由APK根据当前车辆VIN从服务器请求到的VIN解析结果信息
 *
 *     参数说明：eGviValue    获取信息类型的宏值
 *
 *               GET_VIN_BRAND               = 0,     品牌ID值
 *               GET_VIN_MODEL               = 1,     车型ID值
 *               GET_VIN_MANUFACTURER_NAME   = 2,     厂家名称
 *               GET_VIN_YEAR                = 3,     年份
 *               GET_VIN_CLASSIS             = 4,     底盘号
 *               GET_VIN_MANUFACTURER_TYPE   = 5,     厂家类型
 *               GET_VIN_VEHICLE_TYPE        = 6,     车辆类型
 *               GET_VIN_FULE_TYPE           = 7,     燃油类型
 *               GET_VIN_ENERGY_TYPE         = 8,     能源类型
 *               GET_VIN_COUNTRY             = 9,     国家
 *               GET_VIN_AREA                = 10,    区域
 *
 *
 *    返 回 值：服务器返回的VIN码信息ID值（十六进制串）
 *    注    意：此接口返回的都是ID
 -----------------------------------------------------------------------------*/
+ (NSString *)ArtiGlobalGetServerVinInfo: (uint32_t)eGviValue {
    NSString *vinInfo = TDD_ArtiGlobalModel.sharedArtiGlobalModel.vinServerInfo;
    if ([NSString tdd_isEmpty: vinInfo] || vinInfo.length < 88) {
        return @"";
    }
    NSRange range = NSMakeRange(8 * eGviValue, 8);
    if (range.location + range.length >= vinInfo.length) {
        return @"";
    }
    NSString *subVinInfo = [vinInfo substringWithRange:range];
    
    HLog(@"ArtiGlobalGetServerVinInfo - 获取服务器VIN码信息：%@ - eGviValue: %d - value: %@", vinInfo, eGviValue, subVinInfo);
    return subVinInfo;
}

static std::vector<std::string> const ArtiGlobalGetServerVinInfoValue(uint32_t eGviValue)
{
    return [TDD_CTools NSArrayToStringCVector:[TDD_ArtiGlobalModel ArtiGlobalGetServerVinInfoValue:eGviValue]];
}

static uint32_t const ArtiGlobalGetObdEntryType()
{
    return [TDD_ArtiGlobalModel ArtiGlobalGetObdEntryType];
}

+ (eObdEntryType)ArtiGlobalGetObdEntryType
{
    
    HLog(@"ArtiGlobalGetObdEntryType - 获取OBD 进车类型：%d", [TDD_ArtiGlobalModel sharedArtiGlobalModel].obdEntryType);
    
    return [TDD_ArtiGlobalModel sharedArtiGlobalModel].obdEntryType;
}

+ (NSArray *)ArtiGlobalGetServerVinInfoValue: (uint32_t)eGviValue
{
    NSArray *vinInfo = TDD_ArtiGlobalModel.sharedArtiGlobalModel.vinServerInfoValue;
    NSString *info = @"";
    if (eGviValue < vinInfo.count) {
        info = vinInfo[eGviValue];
    }
    HLog(@"ArtiGlobalGetServerVinInfo - 获取服务器VIN码信息：%@ - eGviValue: %d - value: %@", [vinInfo description], eGviValue, info);
    return @[info];
    
}

int ArtiGlobalModelRpcSend(int32_t type, const uint8_t* pAlgorithmData, uint32_t length, uint32_t timeout)
{
    
//    *             如果pAlgorithmData为空，返回-1
//    *             如果length为0，返回-2
//    *             如果此时网络没有连接，返回-3
//    *             如果此时用户未没有登录服务器，返回-4
//    *             如果此时Token失效，返回-5 //暂时不用
    //TODO: 使用WebSocket获取数据
    return [TDD_ArtiGlobalModel ArtiWebSocketModelRpcSendWithType:type algorithData:pAlgorithmData length:length timeout:timeout];
    
}
//TODO: websocket 诊断算法新增WebSocket方式
+ (int) ArtiWebSocketModelRpcSendWithType:(int32_t)type algorithData:(const uint8_t *)pAlgorithmData length:(uint32_t)length timeout:(uint32_t)timeout
{
    //    *             如果pAlgorithmData为空，返回-1
    //    *             如果length为0，返回-2
    //    *             如果此时网络没有连接，返回-3
    //    *             如果此时用户未没有登录服务器，返回-4
    //    *             如果此时Token失效，返回-5 //暂时不用
        
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < length; j++) {

        [nsArray addObject:@(pAlgorithmData[j])];
    }
    HLog(@"ArtiGlobalModelRpcSend - %@ - %@ - %@ - %@",@(type),nsArray,@(length),@(timeout));
    if (nsArray.count == 0) {
        return  -1;
    }
    
    if (length == 0) {
        return -2;
    }
    
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        return -3;
    }
    
    if (![TDD_DiagnosisTools userIsLogin]) {
        if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalEvent:param:)]) {
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalEvent:TDD_DiagOtherEventType_GotoLoginView param:@{}];
        }
        return -4;
    }
    
    //算法使用连接的 SN
    NSString * sn = [TDD_EADSessionController sharedController].SN;
    
    if (sn.length == 0) {
        sn = @"";
    }
//    //信号量锁接口
//    dispatch_semaphore_t lock = dispatch_semaphore_create(0);
    
    __block BOOL hasWebsocketReturn = NO;
    __block int resultCode = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_SEC), dispatch_get_global_queue(0, 0), ^{
        if (!hasWebsocketReturn) {
            std::vector<uint8_t> intVec;
//            resultCode = -8;
//            dispatch_semaphore_signal(lock);
            CStdShow::SetRpcRecv(-8, "算法超时", intVec);

        }
    });
    
//
//    #if DEBUG
//        type = 1;
//    #endif
    long long utc = [[NSDate date] timeIntervalSince1970] * 1000;
    long long x =  (random() * 900000000000000000L) + 1000000000000000000L;
    NSString * serialNumber = [NSString stringWithFormat:@"%lld%lld", utc, x];
        
    //TODO: 测试WebSocket
    NSString * token = [TDD_DiagnosisTools userToken];
    NSString * accToken =  [NSString stringWithFormat:@"%@", token];
    NSString * topdonId = [TDD_DiagnosisTools topdonID];
    NSString * appKey = [TDD_DiagnosisTools appKey];
    NSMutableDictionary *webSocketParam = @{
        @"sn" : sn, // @"KP0102BA100001",
//        @"sn" : @"KP0102BA100001",
//        @"uuid" : [NSUUID UUID].UUIDString,
        @"uuid" : serialNumber,
        @"algorithmData" : nsArray,
        @"algorithmDataLen" : @(length),
        @"type" : @(type),
        @"token" : accToken
    }.mutableCopy;
    [webSocketParam addEntriesFromDictionary:[TDD_ADWebSocket publicParams]];
    ADSubscribeModel *subscribe = [[ADSubscribeModel alloc] init];
    subscribe.param = webSocketParam;
    subscribe.key = [NSString stringWithFormat:@"Diagnosis_%ld", (NSInteger)[NSDate date].timeIntervalSince1970];
    subscribe.callback = ^(id response) {
        hasWebsocketReturn = YES;
        uint32_t code = -1;
        ADDiagnosisWSResponse* result = [ADDiagnosisWSResponse modelWithJSON:response];
        
        NSString * strMsg = result.msg;
        
        std::vector<uint8_t> intVec;
        if (result.success && result.data && ![NSString tdd_isEmpty:result.data.resultData]) {
            HLog(@"算法成功");
            TDD_ADDiagnosisModel* model = result.data;
            NSString* str = [TDD_ArtiGlobalModel textFromBase64String: model.resultData];
            str = [str stringByReplacingOccurrencesOfString:@"\0" withString:@""];
            
            if (str.length > 0) {
                code = 0;
                NSData *myData = [str dataUsingEncoding:NSUTF8StringEncoding];
                Byte *bytes = (Byte *)[myData bytes];
                
                for (int i = 0; i < myData.length; i++) {
                    
                    intVec.push_back(bytes[i]);
                }
            }else {
                HLog(@"数据异常 - 算法失败 data:%@",result.data);
            }
        } else {
            code = (int)result.code;
            if (code == 60515) {
                //算法数据发送失败，token异常
                if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalEvent:param:)]) {
                    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalEvent:TDD_DiagOtherEventType_GotoLoginView param:@{}];
                    //resultCode = -5;
                }
            }else if (code == 60513 || code == 60514){
                //刷新 token，不管成功失败
                if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
                    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_RefreshToken param:nil completeHandle:^(id  _Nonnull result) {
                                            
                    }];
                }

            }
            
            HLog(@"算法失败 data:%@",result.data);
        }
//        dispatch_semaphore_signal(lock);
        CStdShow::SetRpcRecv(code, [TDD_CTools NSStringToCStr:strMsg], intVec);
    };
    
    [[TDD_ADWebSocket shared] subscribe:subscribe];
    return resultCode;
}

static uint64_t const ArtiGlobalModelGetDiagMenuMask()
{
    return [TDD_ArtiGlobalModel GetDiagMenuMask];
}


stUnitItem ArtiGlobalModelUnitsConversion(const stUnitItem& dsItem)
{
    return [TDD_ArtiGlobalModel UnitsConversion:dsItem];
}

static uint32_t const ArtiGlobalModelGetCurUnitMode()
{
    uint32_t mode = (uint32_t)[TDD_UnitConversion sharedUnit].unitConversionType - 1;
    HLog(@"ArtiGlobalModelGetCurUnitMode - %@",@(mode));
    return mode;
}

/**
 *  将base64字符串转换成普通字符串
 *
 *  @param base64 base64字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)textFromBase64String:(NSString *)base64 {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:0];

    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return text;
}


/*-----------------------------------------------------------------------------
功能：诊断程序设置不支持当前VIN码车辆

      APP在车型（非OBD）调用此接口后需要判断此值，如果有设置为不支持，
      小车探/CarPal，需立即进车OBD，TopScan等需要根据SetVehicle的车型进入到指定
      的车型软件，APP需要处理退出逻辑和UI

      诊断程序如不支持当前车辆需要调用此接口
      
参数说明：eVehNotSupportType eType   设置是否支持

          VBST_SUPPORT_NORMAL   = 0,    // 默认值，默认支持
          VBST_VEH_NOT_SUPPORT  = 1,    // 当前车型程序（非OBD）不支持当前车辆

返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
          其他值，暂无意义

说  明： 国内版TOPVCI小车探, TOPSCAN等
-----------------------------------------------------------------------------*/
+ (uint32_t)ArtiGlobalSetCurVehNotSupport: (uint32_t)eType
{
    HLog(@"ArtiGlobalSetCurVehNotSupport - %@",@(eType));
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].isCurVehNotSupport = eType;
    
    return 0;
}

//进车初始化参数
+ (void)cleanParamtert {
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].vctVehicle = @[];
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].vctVehName = @[];
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].vctSoftCode = @[];
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].isCurVehNotSupport = NO;
    [TDD_DiagnosisTools resetAlert];
    
    if ([TDD_DiagnosisTools softWareIsSingleApp]) {
        //独立车型app进车后切换到群组数据库
        [TDD_DiagnosisManage switchDBType:TDD_DATA_BASE_TYPE_GROUP];
    }else {
        // 一般 app 进车后切换到本地数据库
        [TDD_DiagnosisManage switchDBType:TDD_DATA_BASE_TYPE_DEFAULT];
    }
}

//退车初始化参数
+ (void)initParameter
{
    //退车设置历史诊断为空
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel = nil;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].isEntryFromHistory = NO;
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName isEqualToString:@"AUTOVIN"]) {
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagEntryType = DEF_BASE_EIGHT_FUNCTION;
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowType = TDD_DiagShowType_DIAG;
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowSecondaryType = TDD_DiagShowSecondaryType_NONE;
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].obdEntryType = OET_TOPVCI_APP_NOT_SUPPORT;
    }
    
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarPath = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarInfo = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].sysName = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carServiceName = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].vehicleLogPath = @[];
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].softIsExpire = false;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].autoVinEntryType = AVET_APP_NOT_SUPPORT;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].vehInfoModel  = nil;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carPaths = [NSMutableArray array];
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carBrand = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carModel = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carYear = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carEngineInfo = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carEngineSubInfo = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carMileage = @"";
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].carMILOnMileage = @"";
    [TDD_DiagnosisTools resetAlert];
    
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode = @"";

    //退车清空网关相关信息
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel] clearAuthMessage:YES];
    //ADAS
    [TDD_ADASManage shared].wheelBrowModel = nil;
    [TDD_ADASManage shared].oliValue = 0;
    
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].instanceIDArr = nil;
}

/*-----------------------------------------------------------------------------
  功    能：获取stdshow版本号

            PC工具中，返回的是StdShow.dll的版本号
            Android中，返回的是libstdshow.so的版本号

  参数说明：无

  返 回 值：32位 整型 0xHHLLYYXX

  说    明：Coding of version numbers
            HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
            LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
            YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
            XX 为 最低字节, Bit 7 ~  Bit 0    保留

            例如 0x02010300, 表示 V2.01.003
            例如 0x020B0000, 表示 V2.11
-----------------------------------------------------------------------------*/
+ (uint32_t)GetVersion
{
    HLog(@"%@ - 获取stdshow版本号", [self class]);
    
    NSString *currentVersion = [TDD_StdShowModel Version];
    
    NSArray * arrVersion = [currentVersion componentsSeparatedByString:@"V"];
    
    currentVersion = arrVersion.lastObject;
    
    NSArray * arr = [currentVersion componentsSeparatedByString:@"."];
    
    NSString * resultStr = @"";
    
    for (NSString * str in arr) {
        NSString * sixStr = [self getHexByDecimal:str.intValue WithLength:2];
        resultStr = [NSString stringWithFormat:@"%@%@", resultStr, sixStr];
    }
    
    for (int i = (int)resultStr.length; i < 8; i ++) {
        resultStr = [NSString stringWithFormat:@"%@0", resultStr];
    }
    
    long result = strtoul([resultStr UTF8String],0,16);
    
    return (uint32_t)result;
}

/*-----------------------------------------------------------------------------
  功    能：获取显示应用的版本号

            PC工具中，返回的是TD.exe的版本号
            Android中，返回的是APK的版本号

  参数说明：无

  返 回 值：32位 整型 0xHHLLYYXX

  说    明：Coding of version numbers
            HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
            LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
            YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
            XX 为 最低字节, Bit 7 ~  Bit 0    保留

            例如 0x02010300, 表示 V2.01.003
            例如 0x020B0000, 表示 V2.11
-----------------------------------------------------------------------------*/
+ (uint32_t)GetAppVersion
{
    HLog(@"%@ - 获取显示应用的版本号", [self class]);
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSArray * arr = [currentVersion componentsSeparatedByString:@"."];
    
    NSString * resultStr = @"";
    
    for (NSString * str in arr) {
        NSString * sixStr = [self getHexByDecimal:str.intValue WithLength:2];
        resultStr = [NSString stringWithFormat:@"%@%@", resultStr, sixStr];
    }
    
    for (int i = (int)resultStr.length; i < 8; i ++) {
        resultStr = [NSString stringWithFormat:@"%@0", resultStr];
    }
    
    long result = strtoul([resultStr UTF8String],0,16);
    
    return (uint32_t)result;
}

/*-----------------------------------------------------------------------------
功能：获取当前语言
参数说明：无
返回值：en,cn
说明：无
-----------------------------------------------------------------------------*/
+ (NSString *)GetLanguage
{
    if ([self sharedArtiGlobalModel].carLanguage.length == 0) {
        //兼容，正常不会有这种情况
        HLog(@"%@ - 获取当前语言 - 进车没设置语言 - 默认为英文", [self class]);
        [self sharedArtiGlobalModel].carLanguage = @"en";
    }
    
    HLog(@"%@ - 获取当前语言 - 语言为：%@", [self class], [self sharedArtiGlobalModel].carLanguage);
    
    return [[self sharedArtiGlobalModel].carLanguage lowercaseString];
}

/*-----------------------------------------------------------------------------
功能：获取当前车型路径
参数说明：无

返回值：当前车型路径，Windows 即Diag.dll所在路径

说明：路径为绝对路径，
      Windows 例如："E:\SVN\Debug\TD\Diagnosis\Car\Europe\Demo"
    如果为链接车比如：别克（Buick）链接GM，进别克时返回GM
-----------------------------------------------------------------------------*/
+ (NSString *)GetVehPath
{
    HLog(@"%@ - 获取当前车型路径:%@/", [self class], [self sharedArtiGlobalModel].CarPath);
    
    NSString * path = [NSString stringWithFormat:@"%@/", [self sharedArtiGlobalModel].CarPath];
    
    return path;
}

/*-----------------------------------------------------------------------------------------------------
  功能：获取指定品牌的车型路径

  参数说明：strVehType    指定的车型类型，区分大小写
                          例如DIAG,      "Diagnosis"
                          例如IMMO,      "Immo"
                          例如RFID,      "RFID"
                          例如NewEnergy, "NewEnergy"

            strVehArea    指定品牌车型所在的区域，区分大小写
                          例如EOBD，     "Europe"
                          例如AUDI，     "Europe"
                          例如AUTOVIN，  "Public"
            
            strVehName    指定品牌车型名称，区分大小写
                          例如EOBD，"EOBD"
                          例如AUDI，"VW"

  返回值：指定车型路径，Windows 即Diag.dll所在路径
          如果strVehType为空，或不存在，返回空串""
          如果strVehArea为空，或不存在，返回空串""
          如果不存在此车，返回空串""

          如果strVehName指定的是链接车，返回链接车指定的实际车型路径
          例如strVehType="Diagnosis", strVehArea="Europe", strVehName="AUDI"，返回应该是实际的VW车型路径
          /sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/AD900/11017762H10003/Diagnosis/Europe/VW

  说 明：路径为绝对路径，
         Windows 例如："E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\Demo"
         Windows 例如："E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\EOBD"
         Windows 例如："E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\VW"
         /sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/AD900/11017762H10003/Diagnosis/Public/AUTOVIN
  ---------------------------------------------------------------------------------------------------------------------------------*/
+ (NSString *)getVehPathExWithVehType:(NSString *)strVehType strVehArea:(NSString *)strVehArea strVehName:(NSString *)strVehName
{
    HLog(@"%@ - 获取车型路径:%@/%@ - strVehType:%@", [self class], strVehArea, strVehName, strVehType);
    
    if ([NSString tdd_isEmpty:strVehArea] || [NSString tdd_isEmpty:strVehName]) return @"";
    
    NSArray *vehs;
    if ([strVehType isEqualToString:@"Diagnosis"]) {
        vehs = TDD_DiagnosisManage.sharedManage.localDIAGCarModelArr;
    }else if ([strVehType isEqualToString:@"Immo"]){
        vehs = TDD_DiagnosisManage.sharedManage.localIMMOCarModelArr;
    }else if ([strVehType isEqualToString:@"RFID"]){
        vehs = TDD_DiagnosisManage.sharedManage.localRFIDCarModelArr;
    }else if ([strVehType isEqualToString:@"MOTOR"]) {
        vehs = TDD_DiagnosisManage.sharedManage.localMotoCarModelArr;
    }else {
        vehs = @[];
    }
    __block TDD_CarModel * curCar = nil;
    
    
//    curCar = [vehs _filter:^BOOL(CarModel * obj) {
//        return [obj.strVehicle.uppercaseString isEqualToString:strVehName.uppercaseString];
//    }].firstObject;
    
    [vehs enumerateObjectsUsingBlock:^(TDD_CarModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.strVehicle.uppercaseString isEqualToString:strVehName.uppercaseString]) {
            curCar = obj;
            *stop = YES;
        }
    }];
    
    if (!curCar) {
        return @"";
    }
    
    if ([NSString tdd_isEmpty: curCar.strLink]) {
        return curCar.path;
    }
    
    [vehs enumerateObjectsUsingBlock:^(TDD_CarModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.strVehicle.uppercaseString isEqualToString:curCar.strLink.uppercaseString]) {
            curCar = obj;
            *stop = YES;
        }
    }];
    
    return curCar.path;
}


/*-----------------------------------------------------------------------------
功能：获取当前车型的用户数据路径（非车型路径）,此路径下的文件随着车型软件
      升级不会被删除或更改

参数说明：无

返回值：当前车型的用户数据路径

说明：路径为绝对路径，
      Windows 例如："C:\ProgramData\TD\IMMO\BMW"
      Android 例如："/mnt/sdcard/Android/data/com.TD.diag.artidiag
                     /files/TD/AD900/UserData/IMMO/BMW"
-----------------------------------------------------------------------------*/
+ (NSString *)GetVehUserDataPath
{
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * path = [NSString stringWithFormat:@"%@/%@/AD200/UserData/%@/%@", documentsPath,[TDD_DiagnosisManage sharedManage].documentSubpath, TDD_DiagnosisManage.sharedManage.carModel.strType, TDD_DiagnosisManage.sharedManage.carModel.strVehicle];
    
    HLog(@"%@ - 获取当前车型的用户数据路径:%@", [self class], path);
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSError * error;
        
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            HLog(@"创建当前车型的用户数据路径失败返回空");
            return @"";
        }
    }
    
    return path;
}

/*-----------------------------------------------------------------------------
功能：获取当前车型名称
参数说明：无

返回值：当前车型路径的文件夹名称，Windows 即Diag.dll所在路径的文件夹名称

说明：Windows 例如：
      如果车型路径为"E:\SVN\Debug\TD\Diagnosis\Car\Europe\Demo"
      则返回字符串为"Demo"
    如果为链接车比如：别克（Buick）链接GM，进别克时返回别克
-----------------------------------------------------------------------------*/
+ (NSString *)GetVehName
{
    HLog(@"%@ - 获取当前车型名称：%@", [self class], [self sharedArtiGlobalModel].CarName);
    
    return [self sharedArtiGlobalModel].CarName;
}

/*-----------------------------------------------------------------------------
功能：获取当前车辆VIN码
参数说明：无

返回值：应用已知的车辆VIN码（例如调用AutoVin获取到的，或者OCR扫描铭牌得到的）

说明：返回值举例：
                LFV3A23C2H3181097
-----------------------------------------------------------------------------*/
+ (NSString *)GetVIN
{
    HLog(@"%@ - 获取当前车辆VIN码:%@", [self class], [self sharedArtiGlobalModel].CarVIN);
    
    return [self sharedArtiGlobalModel].CarVIN;
}

/*-----------------------------------------------------------------------------
功能：设置当前车辆VIN码

参数说明：诊断设置当前获取到的VIN，例如 LFV3A23C2H3181097

返回值：无
-----------------------------------------------------------------------------*/
+ (void)SetVIN:(NSString *)strVin
{
    HLog(@"%@ - 设置当前车辆VIN码 - strVin:%@", [self class], strVin);
    
    [[FIRCrashlytics crashlytics] setCustomValue:strVin forKey:@"VIN"];
    
    [self sharedArtiGlobalModel].CarVIN = strVin;
}

/*-----------------------------------------------------------------------------
功能：设置VIN解析的车型给APK/APP

      AUTOVIN诊断设置当前车辆车型
      AUTOVIN根据获取到的VIN，解析相应的车型，将VIN对应的车型给APK/APP


参数说明：vctVehicle     解析到的对应可能车型的集合
                         如果解析到的可能车型有好几个，通过参数vctVehicle设给APP/APK
                         如果解析不到对应的车型，则vctVehicle为空
                         如果vctVehicle数组大小为2，则存在2种的可能存在车型

         例如：vctVehicle的数组大小为4，分别是"Chrysler","Fiat","JEEP","Dodge"
         则VIN对应的车可能是4种车型

         例如：vctVehicle的数组大小为7，分别"Fawcar", "FawDaihatsu", "MazdaChina",
         "TJFAW", "ToyotaChina", "BesTune", "HongQi"
         则VIN对应的车可能是7种车型


返回值：无


注  意：诊断设置当前车辆车型
        AUTOVIN获取VIN码的途径，优先通过GETVIN来获取，其次可以从车辆通讯中获取
-----------------------------------------------------------------------------*/
+ (void)SetVehicle:(NSArray<NSString *> *)vctVehicle
{
    HLog(@"%@ - 设置VIN解析的车型给APK/APP - vctVehicle:%@", [self class], vctVehicle);
    
    [self sharedArtiGlobalModel].vctVehicle = vctVehicle;
}

/*-----------------------------------------------------------------------------
功能：设置VIN解析的车型信息给APK/APP，软件编码可为空或者空串""

      AUTOVIN诊断设置当前车辆车型信息
      AUTOVIN根据获取到的VIN，解析相应的车型目录文件夹名称和车型名称，
                              将VIN对应的车型目录文件夹名称和车型名称给APK/APP


参数说明：
         vctVehDir       解析到的对应可能车型的目录文件夹名称的集合
                         如果解析到的可能车型有好几个，通过参数vctVehDir设给APP/APK
                         如果解析不到对应的车型，则vctVehDir为空
                         如果vctVehicle数组大小为2，则存在2种的可能存在车型

         vctVehName      解析到的对应可能车型的车型名称的集合
                         如果解析到的可能车型有好几个，区域就有几个
                         如果解析不到对应的车型，则vctVehDir为空，vctVehName也为空
                         如果vctVehDir数组大小为2，则存在2种的可能存在车型，
                         此时vctVehName的大小也为2

         vctSoftCode     对应的软件编码

返回值：无


注  意：诊断设置当前车辆车型
        AUTOVIN获取VIN码的途径，优先通过GETVIN来获取，其次可以从车辆通讯中获取
-----------------------------------------------------------------------------*/
+ (void)SetVehicleEx:(NSArray<NSString *> *)vctVehDir vctVehName:(NSArray<NSString *> *)vctVehName vctSoftCode:(NSArray<NSString *> *)vctSoftCode {
    HLog(@"%@ - 设置VIN解析的车型给APK/APP - vctVehicle:%@ - vctVehName:%@ - vctSoftCode:%@", [self class], vctVehDir,vctVehName,vctSoftCode);
    
    [self sharedArtiGlobalModel].vctVehicle = vctVehDir;
    [self sharedArtiGlobalModel].vctVehName = vctVehName;
    [self sharedArtiGlobalModel].vctSoftCode = vctSoftCode;
    
}

/*-----------------------------------------------------------------------------
功能：设置车辆信息

参数说明：诊断设置当前车辆信息

        例如：宝马/3'/320Li_B48/F35/

返回值：无
-----------------------------------------------------------------------------*/
+ (void)SetVehInfo:(NSString *)strVehInfo
{
    HLog(@"%@ - 设置车辆信息 - strVehInfo:%@", [self class], strVehInfo);
    
    [[FIRCrashlytics crashlytics] setCustomValue:strVehInfo forKey:@"车辆信息"];
    [self sharedArtiGlobalModel].CarInfo = strVehInfo;
    
    NSTimeInterval time =  [NSDate tdd_getTimestampSince1970];
    TDD_VehInfoModel *vehInfoModel = [[TDD_VehInfoModel alloc] init];
    vehInfoModel.setTime = time * 1000;
    vehInfoModel.vehInfo = strVehInfo;
    vehInfoModel.didSave = false;
    [self sharedArtiGlobalModel].vehInfoModel = vehInfoModel;
    
}

/*-----------------------------------------------------------------------------
功能：设置系统名称

参数说明：诊断设置当前系统名称

        例如：RCM-安全保护控制系统

返回值：无
-----------------------------------------------------------------------------*/
+ (void)SetSysName:(NSString *)strSysName
{
    HLog(@"%@ - 设置系统名称 - strSysName:%@", [self class], strSysName);
    
    [self sharedArtiGlobalModel].sysName = strSysName;
}

/*-----------------------------------------------------------------------------
功    能： 获取当前应用的宿主机是手机还是平板

参数说明： 无

返 回 值： HT_IS_TABLET     表示当前应用的主机是平板
           HT_IS_PHONE      表示当前应用的主机是手机
           
注  意：   例如，AD200可能在手机或者iPad上运行，如果在手机上运行，返回HT_IS_TABLET
           如果在iPad上运行，返回HT_IS_PHONE
-----------------------------------------------------------------------------*/
+ (eHostType)GetHostType
{
    HLog(@"%@ - 获取当前应用的宿主机是手机还是平板", [self class]);
    
    return HT_IS_PHONE;
}

/*-----------------------------------------------------------------------------
功    能： 获取当前app应用的产品名称

参数说明： 无

返 回 值： PD_NAME_AD900              表示当前产品名为AD900
           PD_NAME_AD200              表示当前产品名为AD200
           PD_NAME_TOPKEY             表示当前产品名为TOPKEY
           PD_NAME_NINJA1000PRO       表示当前产品名为Ninja1000 Pro
-----------------------------------------------------------------------------*/
+ (eProductName)GetAppProductName
{
    HLog(@"%@ - 获取当前app应用的产品名称 - %d", [self class],[TDD_DiagnosisTools appProduct]);
    return [TDD_DiagnosisTools appProduct];
}

/*-----------------------------------------------------------------------------
功    能： 获取当前app应用的使用场景

参数说明： 无

返 回 值： AS_EXTERNAL_USE         表示正式面向用户的使用场景，即正常用户使用场景
          AS_INTERNAL_USE         表示打开了Debug使用场景的后门
-----------------------------------------------------------------------------*/
+ (eAppScenarios)GetAppScenarios
{

    eAppScenarios AppScenarios = AS_EXTERNAL_USE;
    
    if ([TDD_DiagnosisManage sharedManage].appScenarios!=0) {
        AppScenarios = [TDD_DiagnosisManage sharedManage].appScenarios;
    }
    
    HLog(@"%@ - 获取当前app应用的使用场景 : %d", [self class],AppScenarios);
    
    return AppScenarios;
}

/*-----------------------------------------------------------------------------
功    能： 获取当前autoVIN 入口

参数说明： 无
-----------------------------------------------------------------------------*/
+ (eAutoVinEntryType)GetAutoVinEntryType
{

    eAppScenarios AppScenarios = AS_EXTERNAL_USE;
    
    if ([TDD_DiagnosisManage sharedManage].appScenarios!=0) {
        AppScenarios = [TDD_DiagnosisManage sharedManage].appScenarios;
    }
    eAutoVinEntryType autoVinEntryType = [self sharedArtiGlobalModel].autoVinEntryType;
    if (autoVinEntryType <= 0) {
        autoVinEntryType = AVET_APP_NOT_SUPPORT;
    }
    HLog(@"%@ - 当前autoVIN 入口：%ld", [self class], (long)autoVinEntryType);
    
    return autoVinEntryType;
}

/*----------------------------------------------------------------------------------------------
功    能： 获取当前诊断的入口类型
           GetDiagEntryType 接口返回值只支持64位，因功能掩码已超64个，不建议使用
           GetDiagEntryType 已被 GetDiagEntryTypeEx 代替
           GetDiagEntryTypeEx 接口返回值是一个bool型数组，功能掩码个数不受限制

参数说明： 无

返 回 值： GetDiagEntryType返回DET_ALLFUN  表示当前是通过，点击正常诊断下车标进入的车型
           GetDiagEntryType返回DET_MT_OIL_RESET  表示机油归零的功能掩码
           
           GetDiagEntryTypeEx返回的是一个bool型数组，数组下标表示对应的功能掩码位置，数组下标
           对应的值表示对应的功能掩码值，true代表"1"，false代表"0"
           
           GetDiagEntryTypeEx 返回值举例
           返回的数组大小为66，数组的每个元素都是true，则支持所有功能
           如果下标为DET_MT_OIL_RESET的值为false，即第6个（小标从0数）值为false，即不支持
           "Oil Reset"功能
----------------------------------------------------------------------------------------------*/
+ (eDiagEntryType)GetDiagEntryType
{
    NSArray *arr = [[self sharedArtiGlobalModel].diagEntryExTypes subarrayWithRange:NSMakeRange(0, 63)];
    NSString *diagEntryType = [TDD_DiagnosisManage converMaskExArrToMaskStr:arr];
    
    HLog(@"%@ - 获取当前诊断的入口类型：%ld", [self class], diagEntryType.integerValue);

    
    return [self sharedArtiGlobalModel].diagEntryType;
}

+ (NSArray *)GetDiagEntryTypeEx
{
    HLog(@"%@ - 获取新版功能掩码数组:%@",[self class],[self sharedArtiGlobalModel].diagEntryExTypes);
    return [self sharedArtiGlobalModel].diagEntryExTypes;
}

/*-----------------------------------------------------------------------------
功    能： 获取菜单屏蔽掩码，用于获取当前产品（App）是否支持哪些类型系统菜单（功能）

           车型代码通过此接口获取可支持的系统菜单掩码，再配合接口GetDiagEntryType
           获取入口类型支持的功能掩码，对不可展示的菜单进行过滤（不展示），形成不
           同的产品搭配要求

参数说明： 无

返 回 值： eDiagMenuMask      支持的系统掩码，"位"值为"1"表示支持，"0"表示不支持

           例如，DMM_ECM_CLASS，即0x01，表示支持“动力系统类”
           例如，0x03，表示支持“动力系统类”且支持“传动系列类”
           DMM_ALL_SYSTEM_SUPPORT，表示支持所有系统类
-----------------------------------------------------------------------------*/
+ (eDiagMenuMask)GetDiagMenuMask
{
    HLog(@"%@ - 获取支持哪些类型系统菜单：%ld", [self class], (long)[TDD_ArtiGlobalModel sharedArtiGlobalModel].diagMenuMask);
    return [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagMenuMask;
}

/*-----------------------------------------------------------------------------
 *    功    能：单位制转换，将相应的单位值转换成显示给用户的单位值
 *
 *    参数说明：stUnitItem uiSource          需要转换的单位和值
 *
 *    返 回 值：转换后的单位和值
 *
 *              1234 千米 [km] = 766.7721 英里 [mi]
 *              例如：输入 ("km", "1234")
 *                    返回 ("mi.", "766.7721")
 -----------------------------------------------------------------------------*/
+ (stUnitItem)UnitsConversion:(const stUnitItem)dsItem
{
    stUnitItem unitItem;
    TDD_UnitConversionModel * model = [TDD_UnitConversion diagUnitConversionWithUnit:[TDD_CTools CStrToNSString:dsItem.strUnit] value:[TDD_CTools CStrToNSString:dsItem.strValue]];
    unitItem.strUnit = [TDD_CTools NSStringToCStr:model.unit];
    unitItem.strValue = [TDD_CTools NSStringToCStr:model.value];
    HLog(@"%@ - UnitsConversion诊断内单位转换 unit: %@ value: %@", [self class], model.unit,model.value);
    return unitItem;
}

/*-----------------------------------------------------------------------------
 *    功    能：网络连接是否存在，并且可以建立连接并传递数据
 *
 *    参数说明：无
 *
 *    返 回 值：true     网络连接存在，并且可以建立连接并传递数据
 *              false    网络没有连接
 -----------------------------------------------------------------------------*/
+ (BOOL)IsNetworkAvailable
{
    HLog(@"%@ - 网络连接是否存在", [self class]);
    
    BOOL isNetwork = NO;
    
    if ([TDD_DiagnosisManage sharedManage].netState > 0) {
        isNetwork = YES;
    }
    
    return isNetwork;
}

// JH 测试： sn = @"11024412K20038"; accountStr = @"tchenautoauth"; passwordStr = @"Tchen@autoauth123";
/*------------------------------------------------------------------------------------
 *   功   能： FCA服务器认证请求（Authentication初始化）
 *
 *   参数说明：Req          请求FCA服务器的本地数据结构体，包含SGW的识别码
 *             Ans          FCA服务器返回的初始化信息，即AuthDiag证书
 *
 *             struct stFcaAdInitReqEx
 *             {
 *                 std::string strSgwUUID;   // SGW(Secure Gateway) 的UUID（Base64）
 *                 std::string strSgwSN;     // SGW 的序列号
 *                 std::string strVin;       // 车辆车架号
 *
 *                 std::string strEcuSN;     // 需要解锁的ECU序列号，ECU如果是SGW则跟strSgwSN一致
 *                                           // 北美可为空，欧洲必填，例如 "TF1170919C15240"
 *
 *                 std::string strEcuCanId;  // 需要解锁的ECU的CANID，北美可为空，欧洲必填
 *                                           // 例如 "18DA10F1"是ECM，"18DA1020"是BSM
 *
 *                 std::string strEcuPolicyType; // 需要解锁的ECU的策略类型，
 *                                               // 北美可为空，欧洲必填，例如"1"
 *
 *             };
 *
 *             struct stFcaAdInitAns
 *             {
 *                 std::string strCode;      // 公司服务器返回的错误代码 "code"
 *                 std::string strMsg;       // 公司服务器返回的描述 "msg"
 *
 *                 std::string strOemInit;   // FCA返回，OEM特定的初始化缓冲区
 *                                           // 对于FCA，这是AuthDiag证书（Base64）
 *
 *                 std::string strSessionID; // FCA返回（Base64）
 *             };
 *
 *   返 回 值：FCA服务器认证请求的返回码
 *             如果FCA服务器认证请求调用成功，返回0
 *
 *             如果此时网络没有连接，返回-3
 *             如果此时用户没有登录服务器，返回-4
 *             如果此时Token失效，返回-5
 *             其它错误，当前统一返回-9
 *
 *             此接口为阻塞接口，直至服务器返回数据（如果在TimeOutMs时间内，接口形
 *             参默认为1分半钟内(90秒)，APK都没有数据返回将返回-6，失败）
 ------------------------------------------------------------------------------------*/
+ (int)FcaInitSend:(NSString *)strSgwUUID
          strSgwSN:(NSString *)strSgwSN
            strVin:(NSString *)strVin
          strEcuSN:(NSString *)strEcuSN
       strEcuCanId:(NSString *)strEcuCanId
  strEcuPolicyType:(NSString *)strEcuPolicyType
         timsOutMs:(uint32_t)timsOutMs
             snApi:(uint32_t)snApi
{
    HLog(@"%@ - ArtiGlobalModelFcaInitSend: strSgwUUID-%@  strSgwSN-%@ strVin-%@ strEcuSN-%@ strEcuCanId-%@ strEcuPolicyType-%@ timsOutMs-%u",[self class],strSgwUUID,strSgwSN,strVin,strEcuSN,strEcuCanId,strEcuPolicyType,timsOutMs);
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        HLog(@"ArtiGlobalModelFcaInitSend: 无网络");
        return -3;
    }
    
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"FcaInitSend代理未实现")
        return -9;
    }
    
    // 创建一个信号量，初始值为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    // 定义最大重试次数
    int maxRetryCount = 1;
    int currentRetryCount = 0;
    __block BOOL needRetry = NO; // 默认值
    
    __block int returnValue = 0;
    while (currentRetryCount <= maxRetryCount) {
        needRetry = NO;
         
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setValue:strSgwUUID?:@"" forKey:@"ecuPKIUUID"];
        [param setValue:strSgwSN?:@"" forKey:@"ecuSN"];
        [param setValue:strVin?:@"" forKey:@"vin"];
        [param setValue:strEcuCanId?:@"" forKey:@"ecuCANID"];
        [param setValue:strEcuSN?:@"" forKey:@"sgwSN"];
        [param setValue:strEcuPolicyType?:@"" forKey:@"ecuPolicyType"];
        if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].authUnlockType == 1) {
            [param setValue:@(5) forKey:@"brand"];
            
        }else {
            [param setValue:@(1) forKey:@"brand"];
        }
        [param setValue:[self sharedArtiGlobalModel].authToken forKey:@"token"];
        if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel] authUnlockType] == 0) {

            [param setValue:@(1) forKey:@"source"];
        }else {
            [param setValue:@(2) forKey:@"source"];
        }
        
        [param setValue:@(2) forKey:@"model"];//默认传2
        //连接的SN
        NSString *sn = [TDD_EADSessionController sharedController].SN;
        [param setValue:sn?:@"" forKey:@"sn"];
        HLog(@"fcaInitSend sn:%@",sn);
        //账户
        NSString *accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
        if (![NSString tdd_isEmpty:accountStr]){
            if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(AESEncrypt:)]){
                accountStr = [[TDD_DiagnosisManage sharedManage].manageDelegate AESEncrypt:accountStr];
            }
        }
        [param setValue:accountStr?:@"" forKey:@"username"];
        HLog(@"fcaInitSend username:- %@",accountStr);
        [param setValue:@(timsOutMs) forKey:@"timeOut"];
        [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_GetOEM param:param completeHandle:^(id  _Nonnull result) {
            NSDictionary *responsDic = result;
            NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
            NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
            NSString *msg = responsDic[@"msg"];
            NSString *oem = @"";
            NSString *sessionID = @"";
            if (responsDic && [responsDic isKindOfClass:[NSDictionary class]]) {
                oem = [responsDic tdd_getStringValueForKey:@"oemBuffer" defaultValue:@""];
                sessionID = [responsDic tdd_getStringValueForKey:@"sessionID" defaultValue:@""];
            }
            if ([NSString tdd_isEmpty:msg]) {
                msg = @"";
            }

            HLog(@"FcaInitSend snApi = %u requestTraceId = %@", snApi, responsDic[@"requestTraceId"]);

            if (code == 102055) { // authToken失效!
                returnValue = - 4;
                if (currentRetryCount < maxRetryCount) {
                    needRetry = YES;
                    [TDD_FCAAuthModel requestFcaLoginWithType:SST_FUNC_FCA_AUTH complete:^(BOOL isSuccess,NSInteger code) {
                        if (!isSuccess) {
                            returnValue = - 4;
                            NSNumber *httpCode = responsDic[@"httpCode"];
                            NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
                            CStdShow::SetFcaAdInitRecv([TDD_CTools NSStringToCStr:codeStr],[TDD_CTools NSStringToCStr:msg],[TDD_CTools NSStringToCStr:oem],[TDD_CTools NSStringToCStr:sessionID],snApi);
                        }
                        // 网络请求完成后，发送信号
                        dispatch_semaphore_signal(semaphore);
                    }];
                } else {
                    returnValue = - 4;
                    // 网络请求完成后，发送信号
                    dispatch_semaphore_signal(semaphore);
                }
            } else {
                if (![TDD_DiagnosisTools userIsLogin]) { // 再次登录失败
                    HLog(@"ArtiGlobalModelFcaInitSend: 未登录");
                    returnValue = -4;
                    NSNumber *httpCode = responsDic[@"httpCode"];
                    NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
                    CStdShow::SetFcaAdInitRecv([TDD_CTools NSStringToCStr:codeStr],[TDD_CTools NSStringToCStr:msg],[TDD_CTools NSStringToCStr:oem],[TDD_CTools NSStringToCStr:sessionID],snApi);
                } else {
                    if (code != -1) {
                        if (code == 2000) {
                            //成功
                            CStdShow::SetFcaAdInitRecv([TDD_CTools NSStringToCStr:codeStr],[TDD_CTools NSStringToCStr:msg],[TDD_CTools NSStringToCStr:oem],[TDD_CTools NSStringToCStr:sessionID],snApi);
                        } else {
                            //失败
                            returnValue = 0;
                            CStdShow::SetFcaAdInitRecv([TDD_CTools NSStringToCStr:codeStr],[TDD_CTools NSStringToCStr:msg],[TDD_CTools NSStringToCStr:oem],[TDD_CTools NSStringToCStr:sessionID],snApi);
                        }
                    }else {
                        //失败并且没有code
                        returnValue = - 9;
                        NSNumber *httpCode = responsDic[@"httpCode"];
                        NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
                        CStdShow::SetFcaAdInitRecv([TDD_CTools NSStringToCStr:codeStr],[TDD_CTools NSStringToCStr:msg],[TDD_CTools NSStringToCStr:oem],[TDD_CTools NSStringToCStr:sessionID],snApi);
                    }
                }
                
                // 网络请求完成后，发送信号
                dispatch_semaphore_signal(semaphore);
            }
        }];
        
        // 等待信号量，阻塞当前线程直到信号量被触发
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        if (!needRetry) {
            break;
        }
        
        // 增加重试次数
        currentRetryCount++;
    }
    
    HLog(@"FcaInitSend returnValue: %d", returnValue);
    return returnValue;
}


/*------------------------------------------------------------------------------------
 *   功   能： 向FCA服务器转发SGW的 Challenge 随机码
 *
 *   参数说明：Req          Challenge 随机码的本地数据结构体
 *             Ans          FCA服务器返回的Challenge响应
 *
 *             struct stFcaAdChallReq
 *             {
 *                 std::string strSessionID; // FcaAuthDiagInit返回的SessionID（Base64）
 *                 std::string strChallenge; // ECU Challenge（Base64）
 *             };
 *
 *             struct stFcaAdChallAns
 *             {
 *                 std::string strCode;      // 公司服务器返回的错误代码 "code"
 *                 std::string strMsg;       // 公司服务器返回的描述 "msg"
 *
 *                 std::string strChallenge; // SGW Challenge Response（Base64）
 *             };
 *
 *   返 回 值：FCA服务器认证请求的返回码
 *             如果FCA服务器认证请求调用成功，返回0
 *
 *             如果此时网络没有连接，返回-3
 *             如果此时用户没有登录服务器，返回-4
 *             如果此时Token失效，返回-5
 *             其它错误，当前统一返回-9
 *
 *             此接口为阻塞接口，直至服务器返回数据（如果在TimeOutMs时间内，接口形
 *             参默认为1分半钟内(90秒)，APK都没有数据返回将返回-6，失败）
 ------------------------------------------------------------------------------------*/
+ (int)FcaRequestSend:(NSString *)strSessionID
             strSgwSN:(NSString *)strChallenge
            timsOutMs:(uint32_t)timsOutMs
                snApi:(uint32_t)snApi
{
    HLog(@"%@ - ArtiGlobalModelFcaRequestSend: strSessionID-%@  strChallenge-%@ timsOutMs-%u",[self class],strSessionID,strChallenge,timsOutMs);
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        return -3;
    }

    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"FcaRequestSend代理未实现")
        return -9;
    }
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:strSessionID?:@"" forKey:@"sessionId"];
    [param setValue:strChallenge?:@"" forKey:@"ecuChallenge"];
    [param setValue:@(timsOutMs) forKey:@"timeOut"];
    [param setValue:[self sharedArtiGlobalModel].authToken?:@"" forKey:@"token"];
    [param setValue:[TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode?:@"" forKey:@"softCode"];
    [param setValue:@([[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthBrand]) forKey:@"brand"];
    
    if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel] authUnlockType] == 0) {

        [param setValue:@(1) forKey:@"source"];
    }else {
        [param setValue:@(2) forKey:@"source"];
    }
    NSString *snStr = [TDD_EADSessionController sharedController].SN;
    if (![NSString tdd_isEmpty:snStr]) {
        [param setValue:snStr forKey:@"sn"];
    }
    __block int returnValue = 0;
    // 创建一个信号量，初始值为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_AuthGateway param:param completeHandle:^(id  _Nonnull result) {
        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
        NSString *msg = responsDic[@"msg"];
        NSString *sgwChallengeResponse = @"";
        if (responsDic && [responsDic isKindOfClass:[NSDictionary class]]) {
            sgwChallengeResponse = [responsDic tdd_getStringValueForKey:@"sgwChallengeResponse" defaultValue:@""];
        }
        if ([NSString tdd_isEmpty:msg]) {
            msg = @"";
        }
        
        HLog(@"FcaRequestSend snApi = %u requestTraceId = %@", snApi, responsDic[@"requestTraceId"]);

        if (![TDD_DiagnosisTools userIsLogin]) { // 再次登录失败
            HLog(@"ArtiGlobalModelFcaInitSend: 未登录");
            returnValue = -4;
            NSNumber *httpCode = responsDic[@"httpCode"];
            NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
            CStdShow::SetFcaAdRequestRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:sgwChallengeResponse],snApi);
        } else {
            if (code != -1) {
                if (code == 2000) {
                    //成功
                    CStdShow::SetFcaAdRequestRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:sgwChallengeResponse],snApi);
                }else if (code == 102055){ // authToken失效!
                    returnValue = -4;
                    NSNumber *httpCode = responsDic[@"httpCode"];
                    NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
                    CStdShow::SetFcaAdRequestRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:sgwChallengeResponse],snApi);
                }else{
                    //失败
                    returnValue = 0;
                    CStdShow::SetFcaAdRequestRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:sgwChallengeResponse],snApi);
                }
            }else {
                //失败并且没有code
                returnValue = - 9;
                NSNumber *httpCode = responsDic[@"httpCode"];
                NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
                CStdShow::SetFcaAdRequestRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:sgwChallengeResponse],snApi);
            }
        }
        
        // 网络请求完成后，发送信号
        dispatch_semaphore_signal(semaphore);
    }];
    
    // 等待信号量，阻塞当前线程直到信号量被触发
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    HLog(@"FcaRequestSend returnValue: %d", returnValue);
    return returnValue;
}

/*------------------------------------------------------------------------------------
 *   功   能： 向FCA服务器转发 SGW解锁的 TrackResponse 结果追踪（可理解为欧洲FCA的SGW解锁埋点）
 *
 *   参数说明：Req          TrackResponse 结果追踪的本地数据结构体
 *             Ans          FCA服务器返回的TrackResponse响应
 *
 *             struct stFcaAdTrackReq
 *             {
 *                 std::string strSessionID;   // FcaAuthDiagInit返回的SessionID（Base64）
 *                 std::string strEcuResult;   // ECU 解锁的结果（Boolean），例如"True"
 *                 std::string strEcuResponse; // ECU Response（Base64），例如6712...，或者7F27...
 *             };
 *
 *             struct stFcaAdTrackAns
 *             {
 *                 std::string strCode;    // 公司服务器返回的错误代码 "code"，例如"200"
 *                 std::string strMsg;     // 公司服务器返回的描述 "msg"，例如"User authentication failed!"
 *
 *                 std::string strSuccess; // In case of success, true（Base64），例如"true"
 *             };
 *
 *   返 回 值：FCA服务器结果追踪请求的返回码
 *             如果FCA服务器结果追踪请求调用成功，返回0
 *
 *             如果此时网络没有连接，返回-3
 *             如果此时用户没有登录服务器，返回-4
 *             如果此时Token失效，返回-5
 *             其它错误，当前统一返回-9
 *
 *             此接口为阻塞接口，直至服务器返回数据（如果在TimeOutMs时间内，接口形
 *             参默认为1分半钟内(90秒)，APK都没有数据返回将返回-6，失败）
 ------------------------------------------------------------------------------------*/
+ (int)FcaTrackSend:(NSString *)strSessionID
       strEcuResult:(NSString *)strEcuResult
     strEcuResponse:(NSString *)strEcuResponse
          timsOutMs:(uint32_t)timsOutMs
              snApi:(uint32_t)snApi
{
    HLog(@"%@ - ArtiGlobalModelFcaTrack: strSessionID-%@  strEcuResponse-%@ timsOutMs-%u",[self class],strSessionID,strEcuResponse,timsOutMs);
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        return -3;
    }
    
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate
        respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"FcaTrackSend代理未实现")
        return -9;
    }
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:strSessionID?:@"" forKey:@"sessionId"];
    [param setValue:strEcuResult?:@"" forKey:@"ecuResult"];
    [param setValue:strEcuResponse?:@"" forKey:@"ecuResponse"];
    [param setValue:@(timsOutMs) forKey:@"timeOut"];
    [param setValue:[self sharedArtiGlobalModel].authToken forKey:@"token"];
    if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel] authUnlockType] == 0) {

        [param setValue:@(1) forKey:@"source"];
    }else {
        [param setValue:@(2) forKey:@"source"];
    }
    
    __block int returnValue = 0;
    // 创建一个信号量，初始值为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_TrackResponse param:param completeHandle:^(id  _Nonnull result) {
        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
        NSString *msg = responsDic[@"msg"];
        NSString *sgwChallengeResponse = @"";
        if (responsDic && [responsDic isKindOfClass:[NSDictionary class]]) {
            sgwChallengeResponse = [responsDic tdd_getStringValueForKey:@"sgwChallengeResponse" defaultValue:@""];
        }
        if ([NSString tdd_isEmpty:msg]) {
            msg = @"";
        }
        
        HLog(@"FcaTrackSend snApi = %u requestTraceId = %@", snApi, responsDic[@"requestTraceId"]);

        if (![TDD_DiagnosisTools userIsLogin]) { // 再次登录失败
            HLog(@"ArtiGlobalModelFcaInitSend: 未登录");
            returnValue = -4;
            NSNumber *httpCode = responsDic[@"httpCode"];
            NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
            CStdShow::SetFcaAdTrackRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:@"false"], snApi);
        } else {
            if (code != -1) {
                if (code == 2000) {
                    //成功
                    CStdShow::SetFcaAdTrackRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:@"true"], snApi);
                }else if (code == 102055){ // authToken失效!
                    returnValue = -4;
                    CStdShow::SetFcaAdTrackRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:@"false"], snApi);
                }else{
                    //失败
                    returnValue = 0;
                    CStdShow::SetFcaAdTrackRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:@"false"], snApi);
                }
            }else {
                //失败并且没有code
                returnValue = - 9;
                NSNumber *httpCode = responsDic[@"httpCode"];
                NSString *codeStr = [NSString stringWithFormat:@"%@",httpCode];
                CStdShow::SetFcaAdTrackRecv([TDD_CTools NSStringToCStr:codeStr], [TDD_CTools NSStringToCStr:msg], [TDD_CTools NSStringToCStr:@"false"], snApi);
            }
        }
        
        // 网络请求完成后，发送信号
        dispatch_semaphore_signal(semaphore);
    }];

    // 等待信号量，阻塞当前线程直到信号量被触发
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    HLog(@"FcaTrackSend returnValue: %d", returnValue);
    return returnValue;
}

/*-------------------------------------------------------------------------------------------------------
功能：设置埋点事件
      诊断程序调用此接口设置埋点事件给App，App将对应的埋点事件上传给后台，App注意此
      接口不能阻塞，App缓存好对应的事件后立即返回给诊断程序

参数说明：eEventTrackingId                   eEventId   事件ID，所有事件宏值参考eEventTrackingId的定义
          例如 eEventId = ETI_CLICK_HF_OIL_RESET 表示 HF_Oilreset 事件，用于统计“保养归零功能使用率”

          std::vector<stTrackingItem>        &vctPara   参数集合
          stTrackingItem结构体信息：
          struct stTrackingItem
          {
              eTrackingInfoType eType;         // 埋点的参数类型
              // 例如 TIT_DTC_CODE，表示strValue 此值是 "故障码编码"

              std::string     strValue;       // 实际埋点参数类型的字符串值
              // 例如当 eType = TIT_DTC_CODE，strValue为 "P1145"
              // 例如当 eType = TIT_VIN，strValue为 "KMHSH81DX9U478798"
          };

          eTrackingInfoType 可能宏值举例：
          TIT_VIN               表示类型为车辆车架号
          TIT_MAKE              表示类型为车辆品牌
          TIT_MODEL             表示类型为车型
          TIT_VEH_INFORMATION   表示类型为车辆信息，例如，宝马/3'/320Li_B48/F35/
          TIT_DTC_CODE          表示类型为故障码编码，例如，"P1145"

          例如，“带VIN&品牌&车辆信息&系统信息”
          即：数组有4个元素，分别是VIN、品牌、车辆信息、系统信息
          如果VIN没有获取到，则VIN字段为空

返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口，此值由so返回
          其他值，暂无意义

说  明：  无
-------------------------------------------------------------------------------------------------------*/
+ (void)ArtiGlobalModelSetEventTracking:(eEventTrackingId )trackingID param:(std::vector<stTrackingItem>)param {
    NSString *idStr = [NSString stringWithFormat:@"%d",trackingID];
    //idStr = [TDD_Tools readVehicleEventNameFromID:idStr];
    NSMutableDictionary *MDict = [NSMutableDictionary new];
    for (int i = 0; i < param.size(); i++){
        
        stTrackingItem item = param[i];
        NSString *type = [NSString stringWithFormat:@"%d",item.eType];
        //type = [TDD_Tools readVehicleEventNameFromType:type];
        [MDict setValue:[TDD_CTools CStrToNSString:item.strValue] forKey:type];
        
    }
    
    [TDD_Statistics event:idStr attributes:MDict eventType:TDD_EventType_Car];
    
    TDD_VehInfoModel *vehicleInfoModel = [TDD_ArtiGlobalModel sharedArtiGlobalModel].vehInfoModel;
    if (!vehicleInfoModel.didSave) {
        if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(insertMessageToTopDonLog:time:type:)]) {
            [[TDD_DiagnosisManage sharedManage].manageDelegate insertMessageToTopDonLog:vehicleInfoModel.vehInfo time:vehicleInfoModel.setTime type:0];
            
            vehicleInfoModel.didSave = YES;
            
            if (![NSString tdd_isEmpty:vehicleInfoModel.vehInfo]) {
                if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].carPaths.count >= 50) {
                    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].carPaths removeObjectAtIndex:0];
                }
                [[TDD_ArtiGlobalModel sharedArtiGlobalModel].carPaths addObject:[NSString stringWithFormat:@"%@:%@", @(vehicleInfoModel.setTime), vehicleInfoModel.vehInfo]];
            }
        }
    }

    
    HLog(@"%@ - ArtiGlobalModelSetEventTracking: trackingID-%@  param-%@",[self class],idStr,MDict);
}

#pragma mark 10进制转16进制不足补零
+ (NSString *)getHexByDecimal:(long)decimal WithLength:(NSUInteger)length{
    NSString * hexStr = [self getHexByDecimal:decimal];//需要补零
    
    if (hexStr.length < length) {
        for (int i = 0; i < hexStr.length - length; i ++) {
            hexStr = [NSString stringWithFormat:@"0%@", hexStr];
        }
    }else if (hexStr.length > length){
        hexStr = [hexStr substringToIndex:length];
    }
    
    return hexStr;
}

#pragma mark 10进制转16进制
+ (NSString *)getHexByDecimal:(long)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}

//当前诊断的入口类型
- (eDiagEntryType)diagEntryType
{
    //TopScanV5.40及之后 所有 app 掩码为空时不做兜底逻辑
//    if (!_diagEntryType) {
//        if (TDD_DiagnosisManage.sharedManage.currentSoftware == TDD_SoftWare_KEYNOW) {
//            _diagEntryType = DET_ALLFUN_KEYNOW;
//        } else if ([TDD_DiagnosisTools softWareIsTopVCIPro]) {
//            _diagEntryType = DEF_BASE_THIRTEEN_FUNCTION;
//        } else {
//            _diagEntryType = DEF_BASE_EIGHT_FUNCTION;
//        }
//        
//    }
    return _diagEntryType;
}

- (void)setDiagEntryExTypes:(NSArray *)diagEntryExTypes {
    //不足位数补 0
    NSMutableArray *arr = diagEntryExTypes.mutableCopy;
    if (arr.count < [TDD_DiagnosisTools carMaintenanceExArr].count) {
        NSInteger count = [TDD_DiagnosisTools carMaintenanceExArr].count - arr.count;
        for (int i = 0; i < count; i++) {
            [arr addObject:@"0"];
        }
    }
    _diagEntryExTypes = arr;
    
}

// 当前OBD诊断入口类型
- (eObdEntryType)obdEntryType {
    if (!_obdEntryType) {
        _obdEntryType = OET_TOPVCI_APP_NOT_SUPPORT;
    }
    return _obdEntryType;
}

//车型菜单支持系统
- (eDiagMenuMask)diagMenuMask
{
    //TopScanV5.40及之后 所有 app 掩码为空时不做兜底逻辑
//    if (!_diagMenuMask) {
//        _diagMenuMask = DMM_ALL_SYSTEM_SUPPORT;
//    }
    return _diagMenuMask;
}

// 进车类型(历史诊断类型区分使用)
- (void)setDiagShowType:(TDD_DiagShowType)diagShowType {
    _diagShowType = diagShowType;
    if (!_obdEntryType || _obdEntryType == OET_TOPVCI_APP_NOT_SUPPORT) {
        switch (diagShowType) {
            case TDD_DiagShowType_DIAG:
                _obdEntryType = OET_DIAG_DIAG;
                break;
            case TDD_DiagShowType_IMMO:
                _obdEntryType = OET_DIAG_IMMO;
                break;
            case TDD_DiagShowType_MOTO:
                _obdEntryType = OET_MOTOR_DIAG;
                break;
            case TDD_DiagShowType_TDarts:
                _obdEntryType = OET_TDARTS;
                break;
            case TDD_DiagShowType_Maintain:
                _obdEntryType = OET_DIAG_MAINTENANCE;
                break;
            case TDD_DiagShowType_Maintain_MOTO:
                _obdEntryType = OET_MOTOR_MAINTENANCE;
                break;
            case TDD_DiagShowType_IMMO_MOTO:
                _obdEntryType = OET_MOTOR_IMMO;
                break;
            case TDD_DiagShowType_ADAS:
                _obdEntryType = OET_ADAS;
                break;
            default:
                break;
        }
    }
}

//网关本地化
//区域
- (void)saveGatewayArea {
    [TDD_UserdefaultManager setAuthArea:[self getAuthArea] type:_authType unlockType:_authUnlockType];
}

//账号
- (void)saveGatewayAccount {
    [TDD_UserdefaultManager setAuthAccount:[self getAuthAccount] type:_authType unlockType:_authUnlockType];
}

//清除输入框缓存
- (void)clearAuthMessage:(BOOL)clearSavePWD {
    self.authAreaDict = nil;
    self.authAccountDict = nil;
    self.authPasswordDict = nil;
    if (clearSavePWD) {
        _authPasswordSaveDict = @{}.mutableCopy;
        _authChangeAccount = @"";
        _authType = SST_FUNC_FCA_AUTH;
        _authToken = @"";
        _authUnlockType = 1;
    }

}
//登录成功后缓存密码
- (void)saveAuthPassword {
    if (!_authPasswordSaveDict) {
        _authPasswordSaveDict = @{}.mutableCopy;
    }
    [_authPasswordSaveDict addEntriesFromDictionary:self.authPasswordDict];
}

- (NSString *)getSaveAuthPassword {
    NSString *passwordStr = @"";
    if (_authUnlockType > 0) {
        passwordStr = _authPasswordSaveDict[[NSString stringWithFormat:@"%ld_%ld",_authType,_authUnlockType]];
    }else {
        passwordStr = _authPasswordSaveDict[[NSString tdd_strFromInterger:_authType]];
    }
    
    if (![NSString tdd_isEmpty:passwordStr]) {
        return passwordStr;
    }
    return @"";
}

- (NSString *)getAuthAccount{
    NSString *accountStr = @"";
    if (self.authUnlockType > 0) {
        accountStr = self.authAccountDict[[NSString stringWithFormat:@"%u_%ld",_authType,_authUnlockType]];
    }else {
        accountStr = self.authAccountDict[[NSString tdd_strFromInterger:_authType]];
    }
    
    if (![NSString tdd_isEmpty:accountStr]) {
        return accountStr;
    }
    //雷诺、日产、大众以及 TopDon 解锁的 FCA 默认登录账号
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(userAccount)]) {
        if (_authUnlockType == 1) {
            return [[TDD_DiagnosisManage sharedManage].manageDelegate userAccount];
        }else {
            return @"";
        }
    }
    return @"";
}

- (NSInteger )getAuthArea {
    NSNumber *area;
    if (_authUnlockType > 0) {
        area = self.authAreaDict[[NSString stringWithFormat:@"%ld_%ld",_authType,_authUnlockType]];
    }else {
        area = self.authAreaDict[[NSString tdd_strFromInterger:_authType]];
    }

    if (area) {
        return area.integerValue;
    }
    //雷诺、日产以及 TopDon 解锁的 FCA 仅欧洲
    if (_authType == 1 || _authType == 2 || (_authType == 0 && _authUnlockType == 1)) {
        return 1;
    }else {
        return 0;
    }

}

- (NSString *)getAuthPassword {
    NSString *passwordStr = @"";
    if (_authUnlockType > 0) {
        passwordStr = self.authPasswordDict[[NSString stringWithFormat:@"%ld_%ld",_authType,_authUnlockType]];
    }else {
        passwordStr = self.authPasswordDict[[NSString tdd_strFromInterger:_authType]];
    }

    if (![NSString tdd_isEmpty:passwordStr]) {
        return passwordStr;
    }
    return @"";
}

- (NSInteger )getAuthBrand {
    switch (_authType) {
        case SST_FUNC_FCA_AUTH:
            return (_authUnlockType == 0) ? 1 : 5;
            break;
        case SST_FUNC_RENAULT_AUTH:
            return 2;
            break;
        case SST_FUNC_NISSAN_AUTH:
            return  (_authUnlockType == 0) ? 6 : 3;
            break;
        case SST_FUNC_VW_SFD_AUTH:
            return 4;
            break;
        case SST_FUNC_DEMO_AUTH:
            //DEMO不调接口
            return 0;
            break;
            
        default:
            break;
    }
    
}

- (NSMutableDictionary *)authPasswordDict {
    if (!_authPasswordDict) {
        _authPasswordDict = [[NSMutableDictionary alloc] init];
    }
    return _authPasswordDict;
}

- (NSMutableDictionary *)authAccountDict {
    if (!_authAccountDict) {
        _authAccountDict = [[NSMutableDictionary alloc] init];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_FCA_AUTH] forKey:@"0"];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_FCA_AUTH unlockType:1] forKey:@"0_1"];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_FCA_AUTH unlockType:2] forKey:@"0_2"];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_RENAULT_AUTH unlockType:1] forKey:@"1_1"];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_NISSAN_AUTH unlockType:0] forKey:@"2_0"];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_NISSAN_AUTH unlockType:1] forKey:@"2_1"];
        [_authAccountDict setValue:[TDD_UserdefaultManager getAuthAccount:SST_FUNC_VW_SFD_AUTH unlockType:1] forKey:@"3_1"];
    }
    return _authAccountDict;
}

- (NSMutableDictionary *)authAreaDict {
    if (!_authAreaDict) {
        _authAreaDict = [[NSMutableDictionary alloc] init];
        [_authAreaDict setValue:@([TDD_UserdefaultManager getAuthArea:0]) forKey:@"0"];
        [_authAreaDict setValue:@([TDD_UserdefaultManager getAuthArea:0 unlockType:1]) forKey:@"0_1"];
        [_authAreaDict setValue:@([TDD_UserdefaultManager getAuthArea:1 unlockType:1]) forKey:@"1_1"];
        [_authAreaDict setValue:@([TDD_UserdefaultManager getAuthArea:2 unlockType:1]) forKey:@"2_1"];
        [_authAreaDict setValue:@([TDD_UserdefaultManager getAuthArea:3 unlockType:1]) forKey:@"3_1"];
    }
    return _authAreaDict;
}

- (NSMutableArray<NSString *> *)carPaths {
    if (!_carPaths) {
        _carPaths = [NSMutableArray array];
    }
    return _carPaths;
}

@end
