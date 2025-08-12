//
//  TDD_Statistics.h
//  AD200
//
//  Created by lk_ios2023002 on 2023/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//诊断
static NSString * const Event_ClickAutoscan = @"Event_ClickAutoscan";
static NSString * const Event_Enterautoscantime = @"Event_Enterautoscantime";
static NSString * const Event_ClicksystemPause = @"Event_ClicksystemPause";
static NSString * const Event_ClicksystemclearDTCs = @"Event_ClicksystemclearDTCs";
static NSString * const Event_Clicksystemhelp = @"Event_Clicksystemhelp";
static NSString * const Event_ClickRecord = @"Event_ClickRecord";
static NSString * const Event_ClickLiveDataReport = @"Event_ClickLiveDataReport";
static NSString * const Event_ClickLiveDataHelp = @"Event_ClickLiveDataHelp";
static NSString * const Event_ClickLiveDataNext = @"Event_ClickLiveDataNext";
static NSString * const Event_ClickLiveDataEdit = @"Event_ClickLiveDataEdit";
static NSString * const Event_ClickLiveDataSet = @"Event_ClickLiveDataSet";
static NSString * const Event_Troublecodesearch = @"Event_Troublecodesearch";
static NSString * const Event_Troublecodehelp = @"Event_Troublecodehelp";
static NSString * const Event_Cus_ClickTroubleCodeStatus = @"Event_Cus_ClickTroubleCodeStatus";
static NSString * const Event_Troublecodefreezeframe = @"Event_Troublecodefreezeframe";
static NSString * const Event_Troublecodetechnicalservice = @"Event_Troublecodetechnicalservice";
static NSString * const Event_TroublecodeDataInfo  = @"Event_TroublecodeDataInfo";
static NSString * const Event_ClickReport = @"Event_ClickReport";
static NSString * const Event_Cus_ClickTranslate = @"Event_Cus_ClickTranslate";
static NSString * const Event_Clickfeedback = @"Event_Clickfeedback";
static NSString * const Event_Cus_ClickMenuSearch = @"Event_Cus_ClickMenuSearch";
static NSString * const Event_Cus_ClickLiveDataSerch = @"Event_Cus_ClickLiveDataSerch";
static NSString * const Event_Cus_ClickLiveDataEditSerch = @"Event_Cus_ClickLiveDataEditSerch";
static NSString * const Event_Pub_VCINoHeartbeat = @"Event_Pub_VCINoHeartbeat";
static NSString * const Event_TroublecodetechnicalserviceTime = @"Event_TroublecodetechnicalserviceTime";
static NSString * const Event_Cus_SystemList = @"Event_Cus_SystemList";
static NSString * const Event_Cus_ReadCode = @"Event_Cus_ReadCode";
static NSString * const Event_Cus_ClickTopFix = @"Event_Cus_ClickTopFix";
//其他
static NSString * const Event_BLEDisconnection = @"Event_BLEDisconnection";
static NSString * const Event_BLECommunicationError = @"Event_BLECommunicationError";
//获取 StdSN为空
static NSString * const Event_Cus_SNObtainFail = @"Event_Cus_SNObtainFail";
//VCI初始化失败
static NSString * const Event_Cus_FirmwareInitializationFail = @"Event_Cus_FirmwareInitializationFail";
@interface TDD_Statistics : NSObject

#pragma mark app提供的统计
/* 事件统计
 eventId、attributes中key和value都不能使用空格和特殊字符，必须是NSString,且长度不能超过255个字符（否则将截取前255个字符）
 id， ts， du是保留字段，不能作为eventId及key的名称
@param  eventId 事件Id.
@param  param 每个event的param不能超过100个
 */


/* 事件数量统计
 */
+ (void)event:(NSString *)eventId attributes:(NSDictionary * _Nullable)param;

+ (void)event:(NSString *)eventId attributes:(NSDictionary * _Nullable)param eventType:(TDD_EventType)eventType;

/* 事件时长统计
 beginEvent需要与endEvent配套使用
 注:如果调用了多次beginEvent且eventId相同，时长会算离endEvent相同eventId最近触发的那次beginEvent之间的时长
 @param  time 自己计时,单位毫秒
 */

+ (void)beginEvent:(NSString *)eventId attributes:(NSDictionary * _Nullable)param;

+ (void)beginEvent:(NSString *)eventId attributes:(NSDictionary * _Nullable)param eventType:(TDD_EventType)eventType;

+ (void)endEvent:(NSString *)eventId;

+ (void)endEvent:(NSString *)eventId attributes:(NSDictionary *)param;

/// 暂停记时
+ (void)tdPauseEvent:(NSString *)eventId;

/// 开始记时
+ (void)tdResumeEvent:(NSString *)eventId;

/// 取消埋点
+ (void)tdRemoveEvent:(NSString *)eventId;

@end

NS_ASSUME_NONNULL_END
