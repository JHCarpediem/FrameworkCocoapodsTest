//
//  TDD_DiagnosisManage.m
//  AD200
//
//  Created by 何可人 on 2022/6/9.
//

#import "TDD_DiagnosisManage.h"
#import "TDD_DiagnosisViewController.h"
#import "TDD_ChooseCarViewController.h"

#import "TDD_ArtiMenuModel.h"

#import "TDD_ArtiActiveModel.h"
#import "TDD_ArtiEcuInfoModel.h"
#import "TDD_ArtiFreezeModel.h"
#import "TDD_ArtiReportModel.h"
#import "TDD_ArtiTroubleModel.h"
#import "TDD_ArtiInputModel.h"
#import "TDD_ArtiListModel.h"
#import "TDD_ArtiMsgBoxModel.h"
#import "TDD_ArtiWebModel.h"
#import "TDD_ArtiFileDialogModel.h"
#import "TDD_ArtiSystemModel.h"
#import "TDD_ArtiLiveDataModel.h"
#import "TDD_ArtiGlobalModel.h"
#import "TDD_ArtiFreqWaveModel.h"
#import "TDD_ArtiCoilReaderModel.h"
#import "TDD_ArtiMiniMsgBoxModel.h"
#import "TDD_ArtiPictureModel.h"
#import "TDD_HistoryDiagModel.h"
#import "TDD_ArtiWheelBrowModel.h"
#import "TDD_ArtiFuelLevelModel.h"

#import "TDD_StdShowModel.h"
#import "TDD_StdCommModel.h"
#import "TDD_ADWebSocket.h"
#import "TDD_JKDBHelper.h"

#import "TDD_TDartsManage.h"
#import "TDD_UnitConversion.h"
#import "Firebase.h" //Firebase
#import "TDD_Reachability.h"
#import "TDD_HTipManage.h"
#import "TDD_ArtiPopupModel.h"
#import "TDD_ArtiBatteryModel.h"
#import "TDD_ArtiObdReviewModel.h"
#import "TDD_ArtiVehAutoAuthModel.h"
#import "TDD_ArtiFloatMiniModel.h"
#import "TDD_ArtiIotRequestModel.h"
#import "TDD_ArtiAppProductModel.h"
#import "TDD_LoadingView.h"

extern "C" uint32_t ArtiDiag(const char* strType, const char* strVehicle);

@implementation TDD_DiagnosisManage {
    TDD_Reachability *_internetReachability;
    BOOL _didSetColorType;
}
+ (TDD_DiagnosisManage *)sharedManage
{
    static TDD_DiagnosisManage * manage = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        manage = [[TDD_DiagnosisManage alloc] init];
        [TDD_DiagnosisTools vehicleDecompressionPackage];
        //默认开启网络检测
        [manage checkNetState];
        manage.appScenarios = AS_EXTERNAL_USE;
        manage.enabledBleLog = YES;
        manage.enabledAD200Log = YES;
    });
    return manage;
}

+ (void)DiagnosisInit
{
    HLog(@"诊断初始化 - 注册方法");
    
    HLog(@"TDDiag版本:V%@",[TDD_DiagnosisManage getVersion]);
    
    [TDD_StdCommModel registSupportTProgMethod];
    
    [TDD_StdShowModel StdShowInit];
    
    [TDD_StdCommModel stdcommInit];
    //DEBUG
    if ([TDD_DiagnosisManage sharedManage].appScenarios==AS_INTERNAL_USE) {
        [TDD_StdShowModel EnableLogcat:YES];

        [TDD_StdCommModel SetLogEnable:YES];
    }
    
    [TDD_ArtiMenuModel registerMethod];
    
    [TDD_ArtiActiveModel registerMethod];
    
    [TDD_ArtiEcuInfoModel registerMethod];
    
    [TDD_ArtiFreezeModel registerMethod];
    
    [TDD_ArtiReportModel registerMethod];
    
    [TDD_ArtiTroubleModel registerMethod];
    
    [TDD_ArtiInputModel registerMethod];
    
    [TDD_ArtiListModel registerMethod];
    
    [TDD_ArtiMsgBoxModel registerMethod];
    
    [TDD_ArtiWebModel registerMethod];
    
    [TDD_ArtiFileDialogModel registerMethod];
    
    [TDD_ArtiSystemModel registerMethod];
    
    [TDD_ArtiLiveDataModel registerMethod];
    
    [TDD_ArtiGlobalModel registerMethod];
    
    [TDD_StdCommModel registerMethod];
    
    [TDD_ArtiFreqWaveModel registerMethod];
    
    [TDD_ArtiCoilReaderModel registerMethod];
    
    [TDD_ArtiMiniMsgBoxModel registerMethod];
    
    [TDD_ArtiPictureModel registerMethod];
    
    [TDD_ArtiPopupModel registerMethod];
    
    [TDD_ArtiBatteryModel registerMethod];
    
    [TDD_ArtiObdReviewModel registerMethod];
    
    [TDD_ArtiWheelBrowModel registerMethod];
    
    [TDD_ArtiFuelLevelModel registerMethod];
    
    [TDD_ArtiVehAutoAuthModel registerMethod];
    
    [TDD_ArtiFloatMiniModel registerMethod];
    
    [TDD_ArtiIotRequestModel registerMethod];
    
    [TDD_ArtiAppProductModel registerMethod];
}

+ (uint32_t)ArtiDiagWithCarModel:(TDD_CarModel *)carModel
{
    HLog(@"进入诊断");
    [TDD_ArtiGlobalModel cleanParamtert];
    
    if (carModel.linkCarPath.length > 0) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarPath = carModel.linkCarPath;
    }else {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarPath = carModel.path;
    }
    
    TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarName = carModel.strVehicle;
    
    TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarVersion = carModel.strVersion;
    
    TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarStaticLibraryVersion = carModel.strStaticLibraryVersion;;
    
    NSString * token = [TDD_DiagnosisTools userToken];
    NSString * accToken =  [NSString stringWithFormat:@"%@", token];
    //websocket -- start

    if (!isTopVCI) {
        [[TDD_ADWebSocket shared] setIsClosed:NO];
        [[TDD_ADWebSocket shared] openWithToken:accToken];
    }

    //TDD_ArtiGlobalModel.sharedArtiGlobalModel.diagMenuMask = (eDiagMenuMask)carModel.system;

    NSString * type = carModel.strType;
    
    uint32_t backInt = 0;
    
    backInt = [TDD_DiagnosisManage ArtiDiagWithType:type Vehicle:carModel];
    
    [TDD_ArtiGlobalModel initParameter];
    
    //websocket -- end
    if (!isTopVCI) {
        [[TDD_ADWebSocket shared] close];
    }
    
    NSString * msg;
    
    switch ((int)backInt) {
        case -2:
        {
            msg = @"参数为空指针";
        }
            break;
        case -1:
        {
            msg = @"无此车型";
        }
            break;
        case 0:
        {
            msg = @"执行车型代码成功";
        }
            break;
        default:
        {
            msg = @"未知参数";
        }
            break;
    }
    
    HLog(@"ArtiDiag 返回参数为：%d -- %@", backInt, msg);
    
    HLog(@"退出诊断");
    
    return backInt;
}

+ (uint32_t)ArtiDiagWithType:(NSString *)Type Vehicle:(TDD_CarModel *)carModel
{
    const char *strType = [Type UTF8String];
    
    const char *strVehicle = [carModel.strVehicle UTF8String];
    
    if (carModel.strLink.length > 0) {
        strVehicle = [carModel.strLink UTF8String];
    }
    
    if ([carModel.strVehicle isEqualToString:@"AUTOVIN"]) {
        [TDD_ArtiGlobalModel SetVehicle:@[]];
    }
    
    NSDictionary * dic = @{@"model":carModel};
    
    [self sharedManage].carModel = carModel;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiDiagStart object:dic];

    [[FIRCrashlytics crashlytics] setCustomValue:[TDD_DiagnosisTools crashCustomValue] forKey:@"附加消息"];
    
    [TDD_StdCommModel StartLogWithTypeName:Type VehName:carModel.strVehicle];

    //进车
    uint32_t backInt = ArtiDiag(strType, strVehicle);
    
    [TDD_StdCommModel StopLog];
    dispatch_async(dispatch_get_main_queue(), ^{
        [TDD_LoadingView dissmiss];
    });
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiDiagStop object:dic];
    
    [self sharedManage].carModel = nil;
    
    //JH: 跳车逻辑暂时仅类TopScan项目，当isCurVehNotSupport为 YES 时。不清除车型 VIN 码，VIN 码用于跳车
    BOOL keepVIN = [TDD_DiagnosisTools softWareIsKindOfTopScan] ? ([TDD_ArtiGlobalModel sharedArtiGlobalModel].isCurVehNotSupport) : NO;
    
    if (![carModel.strVehicle isEqualToString:@"AUTOVIN"] && !keepVIN) {
        [TDD_ArtiGlobalModel SetVIN:@""];
    }
    
    return backInt;
}

#pragma mark - 获取版本号
+ (NSString *)getVersion {
    return @"2.09.066";//与podspec版本号保持一致
}

#pragma mark - 进入诊断界面
+ (void)enterDiagViewControllerWithCarModel:(TDD_CarModel *)carModel entryType:(eDiagEntryType )diagEntryType menuMask:(eDiagMenuMask)diagMenuMask delegate:(id<DiagnosisVCDelegate>)delegate {
    [self enterDiagViewControllerWithCarModel:carModel entryType:diagEntryType menuMask:diagMenuMask delegate:delegate animated:YES entryTypeExs:@[] systemMaskEx:@[]];
}

+ (void)enterDiagViewControllerWithCarModel:(TDD_CarModel *)carModel entryType:(eDiagEntryType )diagEntryType menuMask:(eDiagMenuMask)diagMenuMask delegate:(id<DiagnosisVCDelegate>)delegate animated:(BOOL)animated {
    [self enterDiagViewControllerWithCarModel:carModel entryType:diagEntryType menuMask:diagMenuMask delegate:delegate animated:animated entryTypeExs:@[] systemMaskEx:@[]];
}

+ (void)enterDiagViewControllerWithCarModel:(TDD_CarModel *)carModel entryType:(eDiagEntryType )diagEntryType menuMask:(eDiagMenuMask)diagMenuMask delegate:(id<DiagnosisVCDelegate>)delegate animated:(BOOL)animated entryTypeExs:(NSArray *)diagEntryTypeExs systemMaskEx:(NSArray *)systemMaskEx {
    //设置进车时间
    [TDD_DiagnosisManage sharedManage].enterTime = [NSDate tdd_getTimestampSince1970];
    
    TDD_DiagNavType navType = TDD_DiagNavType_DIAG;
    if ([carModel.strType isEqualToString:@"IMMO"]) {
        navType = TDD_DiagNavType_IMMO;
    } else if ([carModel.strType isEqualToString:@"RFID"]) {
        navType = TDD_DiagNavType_TDarts;
    } else if ([carModel.strType isEqualToString:@"MOTO"]) {
        navType = TDD_DiagNavType_MOTO;
    }
    
    if ((!diagEntryTypeExs || diagEntryTypeExs.count == 0)) {
        //没有功能新掩码，使用旧掩码转换成新掩码
        TDD_MaskModel *maskModel = [TDD_DiagnosisManage checkMaskWithMaintenance:[NSString stringWithFormat:@"%ld",diagEntryType] system:nil carModel:carModel];
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagEntryExTypes = maskModel.maintenanceSupportArr;

    }else {
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagEntryExTypes = diagEntryTypeExs;
        //旧掩码(64位掩码)由新掩码数组转换得来
        NSArray *arr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel].diagEntryExTypes subarrayWithRange:NSMakeRange(0, 63)];
        NSString *entryType = [TDD_DiagnosisManage converMaskExArrToMaskStr:arr];
        diagEntryType = (eDiagEntryType)entryType.intValue;
    }

    TDD_DiagnosisViewController *vc = [[TDD_DiagnosisViewController alloc] init];
    vc.delegate = delegate;
    vc.carModel = carModel;
    vc.diagNavType = navType;
    vc.diagEntryType = diagEntryType;
    vc.diagMenuMask = diagMenuMask;
    [[UIViewController tdd_topViewController].navigationController pushViewController:vc animated:animated];
    
}

#pragma mark - 历史诊断
+ (void)setHistoryRecord:(NSString *)historyRecord {

    //从历史诊断进车,重新生成一条历史诊断记录缓存，提供给车型知道
    //车型设置historyRecord的时候才会保存到数据库
    HLog(@"setHistoryRecord %@",historyRecord);
    if (![NSString tdd_isEmpty:historyRecord]) {
        TDD_HistoryDiagModel *model = [[TDD_HistoryDiagModel alloc] init];
        model.historyRecordID = historyRecord;
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].historyModel = model;
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].isEntryFromHistory = YES;
    }else {
        HLog(@"setHistoryRecord 为空");
    }

}

#pragma mark - 进入本地诊断
+ (void)enterLocalChooseCarViewController:(eDiagEntryType )diagEntryType  delegate:(id<DiagnosisVCDelegate>)delegate {
    TDD_ChooseCarViewController * vc = [[TDD_ChooseCarViewController alloc] init];
    vc.diagEntryType = diagEntryType;
    vc.delegate = delegate;
    [[UIViewController tdd_topViewController].navigationController pushViewController:vc animated:YES];
}

#pragma mark - 搜索目录
+ (NSArray<TDD_CarModel *> *)searchAllDirectory {
    return [TDD_DiagnosisTools searchAllDirectory];
    
}

#pragma mark 设置语言
/// 设置语言
+ (void)setLanguage:(TDDHLanguageType)languageType {
    [TDD_HLanguage setLanguage:languageType];
}

#pragma mark 获取当前语言
///获取当前语言
+ (NSString *)getCurrentLanguage {
    return [TDD_HLanguage getLanguage];
    
}

#pragma mark - 固件升级
+ (void)firmwareUpdateWithFilePath:(NSString *)filePath version:(NSString *)version progress:(nullable void (^)(NSProgress *progress))progressBlock completionHandler:(nullable void (^)(int result))completionHandler {
    [TDD_DiagnosisTools firmwareUpdateWithFilePath:filePath version:version progress:progressBlock completionHandler:completionHandler];
}

#pragma mark 解析公英制文件
+ (void)analysisUnitFile:(NSString *)unit {
    [TDD_UnitConversion analysisUnitFile:unit];
}

#pragma mark 静态库版本打印
+ (void)logStaticLibraryVersion {
    [TDD_DiagnosisTools logStaticLibraryVersion];
}

+ (NSString *)carStaticLibraryVersionWithType:(NSString *)stringType {
    return [TDD_DiagnosisTools carStaticLibraryVersionWithType:stringType];
}

+ (NSString *)carGetMainVersionWithModel:(TDD_CarModel *)model {
    return [TDD_DiagnosisTools carGetMainVersionWithModel:model];
    
}

#pragma mark 车型功能与系统
+ (NSArray *)carMaintenanceArr {
    return [TDD_DiagnosisTools carMaintenanceArr];
}

+ (NSArray *)carSystemArr {
    return [TDD_DiagnosisTools carSystemArr];
}

#pragma mark DB
#pragma mark DB
///设置 groupID,不设置则只会创建本地数据库
///例子:TopScan VAG 使用
+ (void)setStoreGroupID:(NSString *)groupID {
    [TDD_JKDBHelper shareInstance].groupID = groupID;
}
/// 查看app当前设置的 groupID
+ (NSString *)storeGroupID {
    return [TDD_JKDBHelper shareInstance].groupID;
}
///切换数据库
/// 注意: 
/// 1、进车前自动切换并且诊断内调此接口切换无效(正常进车后自动切到本地数据库，特殊(VAG)切到群组数据库)
/// 2、app 注意管理切换取值删除值
+ (void)switchDBType:(TDD_DBType)dbType {
    if ([TDD_EADSessionController sharedController].isArtiDiag) {
        HLog(@"已经进车不允许切换数据库");
    }else {
        [TDD_JKDBHelper shareInstance].dbType = dbType;
    }
    
}
///当前数据库
+ (TDD_DBType)dbType {
    return [TDD_JKDBHelper shareInstance].dbType;
}

+ (NSArray *)carMaintenanceExArr {
    return [TDD_DiagnosisTools carMaintenanceExArr];
}

+ (NSArray *)carSystemExArr {
    return [TDD_DiagnosisTools carSystemExArr];
}

+ (TDD_MaskModel *)checkMaskWithMaintenance:(nullable NSString *)maintenanceStr system:(nullable NSString *)systemStr carModel:(nullable TDD_CarModel *)carModel{
    TDD_MaskModel *model = [[TDD_MaskModel alloc] init];
    if (maintenanceStr.integerValue < 0) {
        maintenanceStr = @"0";
    }
    if (systemStr.integerValue < 0) {
        systemStr = @"0";
    }
    //功能掩码
    if (![NSString tdd_isEmpty:maintenanceStr]) {
        model.maintenanceStr = maintenanceStr;
        NSArray *binaryArr = [NSString tdd_convertDecimalToBinary:maintenanceStr arrCount:[TDD_DiagnosisTools carMaintenanceExArr].count];
        model.maintenanceStrArr = binaryArr;
        if (carModel) {
            [TDD_DiagnosisManage handleMaskModelWithCarModel:carModel maskModel:model type:0];
        }else {
            model.maintenanceSupportArr = model.maintenanceStrArr;
            model.maintenanceSupport = [model.maintenanceSupportArr containsObject:@"1"];
        }
    }
    //系统掩码
    if (![NSString tdd_isEmpty:systemStr]) {
        model.systemStr = systemStr;
        NSArray *binaryArr = [NSString tdd_convertDecimalToBinary:systemStr arrCount:[TDD_DiagnosisTools carSystemExArr].count];
        model.systemStrArr = binaryArr;
        if (carModel) {
            [TDD_DiagnosisManage handleMaskModelWithCarModel:carModel maskModel:model type:1];
        }else {
            model.systemSupportArr = model.systemStrArr;
            model.systemSupport = [model.systemSupportArr containsObject:@"1"];
        }
    }

    return model;
}
//传入掩码和 ini 掩码进行与操作
+ (void)handleMaskModelWithCarModel:(TDD_CarModel *)carModel maskModel:(TDD_MaskModel *)maskModel type:(NSInteger)type {
    NSArray *binaryArr = (type==0) ? maskModel.maintenanceStrArr : maskModel.systemStrArr;
    NSArray *exArr = (type==0) ? carModel.maintenanceExArr : carModel.systemExArr;
    NSInteger minCount = MIN(binaryArr.count, exArr.count);
    NSMutableArray *supportArr = @[].mutableCopy;
    //传入掩码和 carModel(ini)掩码进行与操作
    for (int i = 0; i < minCount; i++) {
        NSString *exItemStr = exArr[i];
        NSString *parameterStr = binaryArr[i];
        if ([exItemStr isEqualToString:parameterStr]) {
            //相同直接 add
            [supportArr addObject:exItemStr];
        }else {
            [supportArr addObject:@"0"];
        }
    }
    //缺少元素补0(功能/系统不支持)
    if (supportArr.count < exArr.count) {
        for (int i = 0; i < exArr.count - supportArr.count; i++) {
            [supportArr addObject:@"0"];
        }
    }
    
    if (type == 0) {
        maskModel.maintenanceSupportArr = supportArr;
        maskModel.maintenanceSupport = [supportArr containsObject:@"1"];
    }else {
        maskModel.systemSupportArr = supportArr;
        maskModel.systemSupport = [supportArr containsObject:@"1"];
    }

    
}

+ (NSString *)converMaskExArrToMaskStr:(NSArray *)maskArr {
    return [NSString tdd_converBinaryArrToDecimal:maskArr];
}

#pragma mark stdComm
/// 退出此模块的时候调用
+ (void)stdcommDeInit {
    [TDD_StdCommModel stdcommDeInit];
    
}

// 获取VCI的序列号
+ (NSString *)stdcommVciSn {
    return [TDD_StdCommModel VciSn];
}

// 获取VCI的6字节注册码
+ (NSString *)stdcommVciCode {
    return [TDD_StdCommModel VciCode];
}

// VCI是否处于BOOT模式
+ (uint32_t)stdcommFwIsBoot {
    return [TDD_StdCommModel FwIsBoot];
}

// VCI固件版本信息
+ (NSString *)stdcommFwVersion {
    return [TDD_StdCommModel FwVersion];
}

// 获取蓝牙软件版本号
+ (NSString *)stdcommBtVersion {
    return [TDD_StdCommModel BtVersion];
}

// 蓝牙模组 JB6321 进入升级模式
+ (BOOL)stdcommBtEnterUpdate {
    return [TDD_StdCommModel BtEnterUpdate];
}

// 设置蓝牙模组退出升级模式
+ (BOOL)stdcommBtExitUpdate {
    return [TDD_StdCommModel BtExitUpdate];
}

// 蓝牙模组复位
+ (BOOL)stdcommBtReset {
    return [TDD_StdCommModel BtReset];
}

// 获取诊断通信日志
+ (NSArray *)stdcommGetLogPath {
    if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].vehicleLogPath) {
        return [TDD_ArtiGlobalModel sharedArtiGlobalModel].vehicleLogPath;
    }
    if ([TDD_EADSessionController sharedController].isArtiDiag) {
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].vehicleLogPath = [TDD_StdCommModel getLogPath]?:@[];
        return [TDD_ArtiGlobalModel sharedArtiGlobalModel].vehicleLogPath;
    }else {
        return @[];
    }

}

// 获取引脚电压
+ (uint32_t)stdcommReadPinNumVoltage:(uint32_t )pinNum {
    return [TDD_StdCommModel readPinNum:pinNum];
}

+ (void)writeLogToVehicle:(NSString *)strLog {
    
    if ([TDD_EADSessionController sharedController].isArtiDiag) {
        [TDD_StdCommModel logVehWithString:strLog];
    }
    
}

// FwDeviceType
//
// 获取当前VCI的设备类型
//                                     uint32_t            固件标识             VCI名称
// AD900 Tool 的设备类型是：            0x41443900         "AD900Relay207"       "AD900TOOL"
// AD900 VCI（小接头）的设备类型是：      0x4E333247         "AD900VCIN32G455"     "AD900VCI"
// TOPKEY EasyVCI（小接头）的设备类型是： 0x45564349         "EasyVCIGD32F305"     "EasyVCI"
+ (uint32_t)FwDeviceType {
    return [TDD_StdCommModel FwDeviceType];
}

// 国内版TOPVCI 获取空气质量等级接口【0, 100】
/*
*   返 回 值：如果设备没有连接或者指针为空，返回-1
*            返回获取到的空气传感器模组的空气质量等级，【0, 100】
*/
+ (uint32_t)getAirQuality {
    return [TDD_StdCommModel GetAirQuality];
}

// 国内版TOPVCI 获取空气传感器已运行多少时间，单位毫秒
/*
*   返 回 值：如果设备没有连接或者指针为空，返回-1
*           返回获取到空气传感器已运行多少时间，单位毫秒
*/
+ (uint32_t)GetAirUpTime {
    return [TDD_StdCommModel GetAirUpTime];
}


/******************************************************************
*    功  能：电池检测启动测试开始，点击小车探主页进入电池测试，
*                 调用此接口开始启动测试
*
*    bool StartCranking();
*
*    参  数：无
*
*    返回值：true   开始测试成功
*                  false  开始测试失败
******************************************************************/
+ (BOOL)StartCranking {
    [[FIRCrashlytics crashlytics] setCustomValue:[TDD_DiagnosisTools crashCustomValue] forKey:@"附加消息"];
    [TDD_StdCommModel StartLogWithTypeName:@"DIAG" VehName:@"Battery"];
    return [TDD_ArtiBatteryModel StartCranking];
}

/******************************************************************
 *    功  能：停止电池检测的启动测试
 *
 *    bool StopCranking();
 *
 *    参  数：无
 *
 *    返回值：true   停止测试成功
 *           false  停止测试失败
******************************************************************/
+ (BOOL)StopCranking {
    [TDD_StdCommModel StopLog];
    if (isKindOfTopVCI) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiDiagStopCranking object:nil];
    }
    return [TDD_ArtiBatteryModel StopCranking];
}

+ (float)readVBat
{
    return [TDD_ArtiBatteryModel readVBat];
}

+ (uint32_t )setLock
{
    return [TDD_StdCommModel setLock];
}

+ (uint32_t )setUnlock
{
    return [TDD_StdCommModel setUnLock];
}

+ (uint32_t )getVCILock
{
    return [TDD_StdCommModel getVCILock];
}

#pragma mark 获取TDarts信息
//0，未连接； 1，已连接；
+ (uint32_t)getTDartsTProgStatus {
    return [TDD_TDartsManage.sharedManage TProgStatus];
}
//SN
+ (NSString *)getTDartsSN {
    return [TDD_TDartsManage.sharedManage strSn];
}
//注册码
+ (NSString *)getTDartsCode {
    return [TDD_TDartsManage.sharedManage strCode];
}
//MCUID
+ (NSString *)getTDartsMcuId {
    return [TDD_TDartsManage.sharedManage strMcuId];
}

#pragma mark 翻译统计相关
///翻译时间段(开始)
+ (NSString *)getTranslateStartTime {
    return [TDD_UserdefaultManager getTranslateStartTime];
}

///翻译次数
+ (NSInteger )getTranslateCount {
    return [TDD_UserdefaultManager getTranslateCount];
    
}
///翻译字符量(成功的原字符)
+ (NSInteger )getTranslateChartNum {
    return [TDD_UserdefaultManager getTranslateChartNum];
    
}
///清空翻译统计
+ (void )resetTranslate {
    [TDD_UserdefaultManager resetTranslate];

}


- (void)checkNetState {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _internetReachability = [TDD_Reachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    self.netState = (TDD_NetworkStatus)[_internetReachability currentReachabilityStatus];
    
}
                  
- (void)reachabilityChanged:(NSNotification *)note
{
    TDD_Reachability* curReach = [note object];
    NSLog(@"%ld",(long)[curReach currentReachabilityStatus]);
    self.netState = (TDD_NetworkStatus)[curReach currentReachabilityStatus];
}
                  
- (BOOL)isLocalDiagnose
{
     BOOL isLocalDiagnose = NO;
    //DEBUG
    if ([TDD_DiagnosisManage sharedManage].appScenarios==AS_INTERNAL_USE) {
        isLocalDiagnose = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLocalDiagnose"];
    }
    
    return isLocalDiagnose;
}

- (void)setIsLocalDiagnose:(BOOL)isLocalDiagnose {
    
    [[NSUserDefaults standardUserDefaults] setBool:isLocalDiagnose forKey:@"isLocalDiagnose"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)documentSubpath {
    if (!_documentSubpath || [NSString tdd_isEmpty:_documentSubpath]) {
        return @"TD";
    }
    return _documentSubpath;
}

- (NSMutableArray *)localDIAGCarModelArr
{
    if (!_localDIAGCarModelArr) {
        _localDIAGCarModelArr = [[NSMutableArray alloc] init];
    }
    
    return _localDIAGCarModelArr;
}

- (NSMutableArray *)localIMMOCarModelArr
{
    if (!_localIMMOCarModelArr) {
        _localIMMOCarModelArr = [[NSMutableArray alloc] init];
    }
    
    return _localIMMOCarModelArr;
}

- (NSMutableArray *)localRFIDCarModelArr
{
    if (!_localRFIDCarModelArr) {
        _localRFIDCarModelArr = [[NSMutableArray alloc] init];
    }
    
    return _localRFIDCarModelArr;
}

- (NSMutableArray<TDD_CarModel *> *)localMotoCarModelArr {
    
    if (!_localMotoCarModelArr) {
        _localMotoCarModelArr = [[NSMutableArray alloc] init];
    }
    
    return _localMotoCarModelArr;
    
}

- (NSMutableDictionary *)carStaticLibraryVersionDic
{
    if (!_carStaticLibraryVersionDic) {
        _carStaticLibraryVersionDic = [[NSMutableDictionary alloc] init];
    }
    
    return _carStaticLibraryVersionDic;
}

- (NSMutableDictionary *)IMMOStaticLibraryVersionDic
{
    if (!_IMMOStaticLibraryVersionDic) {
        _IMMOStaticLibraryVersionDic = [[NSMutableDictionary alloc] init];
    }
    
    return _IMMOStaticLibraryVersionDic;
}

- (NSMutableDictionary *)MOTOStaticLibraryVersionDic
{
    if (!_MOTOStaticLibraryVersionDic) {
        _MOTOStaticLibraryVersionDic = [[NSMutableDictionary alloc] init];
    }
    
    return _MOTOStaticLibraryVersionDic;
}

- (eAppScenarios)appScenarios {
    if (_appScenarios==0) {
        _appScenarios = AS_EXTERNAL_USE;
    }
    return _appScenarios;
}


+ (NSMutableAttributedString *)getDtcNodeStatusDescription:(long long)dtcNodeStatus statusStr:(NSString *)dtcNodeStatusStr fromTrouble:(BOOL )fromTrouble
{
    
    UIColor *redColor = [UIColor tdd_colorF5222D];
    UIColor *blueColor = [UIColor tdd_dtcStatusNormalColor];
    UIColor *blackColor = [UIColor tdd_title];
    UIFont *font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
    NSMutableArray *dtcCodes = [[NSMutableArray alloc] init];
    
    UIColor *statusColor = blueColor;
    if (dtcNodeStatus == DF_DTC_STATUS_OTHERS) {
        [dtcCodes addObject:@""];
        statusColor = blueColor;
    } else {
        if (dtcNodeStatus & DF_DTC_STATUS_CURRENT) {
            
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_curr];
            statusColor = redColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_NA) {
            if (isKindOfTopVCI) {
                [dtcCodes addObject:TDDLocalized.diag_ignore];
            }else {
                [dtcCodes addObject:@"N/A"];
            }
            
            statusColor = blueColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_HISTORY) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_his];
            statusColor = blueColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_PENDING) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_pending];
            statusColor = blueColor;
        }
        if (dtcNodeStatus & DF_DTC_STATUS_TEMP) {
            [dtcCodes addObject:TDDLocalized.report_trouble_code_status_temporary];
            statusColor = blueColor;
        }
    }
    
    
    //TODO: 适配新版
    if (![NSString tdd_isEmpty:dtcNodeStatusStr]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 6;
        paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        return [[NSMutableAttributedString alloc] initWithString:dtcNodeStatusStr attributes:@{ NSForegroundColorAttributeName : statusColor, NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle }];
    }
    
    if (fromTrouble) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    NSString *result = [dtcCodes componentsJoinedByString: @"&"];
    NSMutableAttributedString *dtcAttributedString = [NSMutableAttributedString mutableAttributedStringWithLTRString:result];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blackColor, NSFontAttributeName : font } range:NSMakeRange(0, result.length)];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : redColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_curr]];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_his]];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_pending]];
    [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.report_trouble_code_status_temporary]];
    if (isKindOfTopVCI) {
        [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:TDDLocalized.diag_ignore]];
    }else {
        [dtcAttributedString addAttributes:@{ NSForegroundColorAttributeName : blueColor } range:[result rangeOfString:@"N/A"]];
    }

    return dtcAttributedString;
}

+ (void)hideLoading {
    [TDD_HTipManage deallocView];
}

- (void)setViewColorType:(TDD_DiagViewColorType)viewColorType {
    _viewColorType = viewColorType;
    _didSetColorType = YES;
}

- (void)setCurrentSoftware:(TDDSoftware)currentSoftware {
    _currentSoftware = currentSoftware;
    if (!_didSetColorType) {
        
        if ( (currentSoftware & TDDSoftwareTopVciPro) || (currentSoftware & TDDSoftwareTopScan) ) {
            _viewColorType = TDD_DiagViewColorType_Red;
        } else if (currentSoftware & TDDSoftwareTopVci) {
            _viewColorType = TDD_DiagViewColorType_GradientBlack;
        } else if ( (currentSoftware & TDDSoftwareCarPal) || (currentSoftware & TDDSoftwareCarPalGuru) ) {
            _viewColorType = TDD_DiagViewColorType_Black;
        } else if (currentSoftware & TDDSoftwareKeyNow) {
            _viewColorType = TDD_DiagViewColorType_Orange;
        } else { // default
            _viewColorType = TDD_DiagViewColorType_Red;
        }
        
        /*
        switch (currentSoftware) {
            case TDDSoftwareTopVciPro:
            case TDDSoftwareTopScan:
            case TDDSoftwareTopScanVAG:
            case TDDSoftwareTopScanBMW:
            case TDDSoftwareTopScanFORD:
            case TDDSoftwareTopScanHD:
                _viewColorType = TDD_DiagViewColorType_Red;
                break;
            case TDDSoftwareTopVci:
                _viewColorType = TDD_DiagViewColorType_GradientBlack;
                break;
            case TDDSoftwareCarPal:
                _viewColorType = TDD_DiagViewColorType_Black;
                break;
            case TDDSoftwareKeyNow:
                _viewColorType = TDD_DiagViewColorType_Orange;
                break;
            default:
                _viewColorType = TDD_DiagViewColorType_Red;
                break;
        }
         */
    }
}

//- (TDD_SoftWare)currentSoftware {
//    if ([self.softwareCode isEqualToString:@"TOPVCIPro_DisplaySW_iOS"]) {
//        return TDD_SoftWare_TOPVCI_PRO;
//    } else if ([self.softwareCode isEqualToString:@"TOPVCI_DisplaySW_iOS"]) {
//        return TDD_SoftWare_TOPVCI;
//    } else {
//        return TDD_SoftWare_TOPSCAN;
//    }
//}

+ (void)StartLogWithTypeName:(NSString *)TypeName VehName:(NSString *)VehName {
    [TDD_StdCommModel StartLogWithTypeName:TypeName VehName:VehName];
}

+ (void)stopLog {
    [TDD_StdCommModel StopLog];
}

+ (NSArray *)getLogPath {
    return [TDD_StdCommModel getLogPath];
}

+ (NSString *)stdVersion {
    return [TDD_StdCommModel Version];
}

@end
