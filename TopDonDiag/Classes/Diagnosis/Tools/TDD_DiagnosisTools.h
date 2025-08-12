//
//  TDD_DiagnosisTools.h
//  AD200
//
//  Created by 何可人 on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "TDD_CarModel.h"
#import "TDD_ArtiGlobalModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    ArtiInput_ALL = 0,
    ///0：表示可输入0~9之间的字符
    ArtiInput_0,
    ///F：表示可输入0~9，A~F之间的用来表示16进制的字符
    ArtiInput_F,
    ///#：表示可输入0~9，+，-，*，/字符
    ArtiInput_S,
    ///V：表示可输入0~9，A~Z之间除了I，O，Q外的其他所有可出现在VIN码中的字符
    ArtiInput_V,
    ///A：表示可输入A~Z之间的大写字母
    ArtiInput_A,
    ///B：表示可输入0~9之间的字符和A~Z之间的大写字母
    ArtiInput_B
}ArtiInputType;



@interface TDD_DiagnosisTools : NSObject
#pragma mark - 解压车型包
+ (void)vehicleDecompressionPackage;

#pragma mark - 搜索目录
+ (NSArray<TDD_CarModel *> *)searchAllDirectory;

#pragma mark - 固件升级
/// 固件升级
/// @param filePath 固件包路径
/// @param progressBlock 进度条回调
/// @param completionHandler 完成回调 0、升级失败 1、升级成功 2、头部校验失败
+ (void)firmwareUpdateWithFilePath:(NSString *)filePath version:(NSString *)version progress:(nullable void (^)(NSProgress *progress))progressBlock completionHandler:(nullable void (^)(int result))completionHandler;

+ (ArtiInputType)stringType:(NSString *)str;

#pragma mark - softWare
+ (BOOL )softWareIsTopVCI;
+ (BOOL )softWareIsTopVCIPro;
+ (BOOL )softWareIsTopScan;
+ (BOOL )softWareIsKindOfTopScan;
+ (BOOL )softWareIsSingleApp;

/// CarPal and CarPalGuru
+ (BOOL )softWareIsCarPal;
+ (BOOL )softWareIsCarPalGuru;
+ (BOOL )softWareIsCarPalSeries;

#pragma mark - 数据获取
+ (eProductName )appProduct;
+ (eAppProductGroup )appProductGroup;
+ (BOOL )isIpad;
/// 获取选中VCI sn
+ (NSString *)selectedVCISerialNum;
/// sn是否禁用
+ (BOOL )isSNDisable;
/// 获取选中TDarts sn
+ (NSString *)selectedTDartsSerialNum;
/// 获取用户ID
+ (int )userID;
// 提供用户topdonID
+ (NSString *)topdonID;
/// 用户是否登录
+ (BOOL )userIsLogin;
/// 获取诊断单位
+ (NSString *)diagnosticUnit;
/// 提供用户token
+ (NSString *)userToken;
+ (NSString *)userTwoFATokenToken:(NSString *)account;
+ (NSString *)userAccount;
+ (NSString *)appKey;
+ (NSString *)deviceUUID;
+ (NSString *)ipAddress;
/// 提供服务器地址
+ (NSString *)serverURL;
/// 进车时给Firbase附加crash自定义信息
+ (NSString *)crashCustomValue;
/// 定制设备类型
+ (TDD_Customized_Type )customizedType;
/// 是否在蓝牙连接中页面
+ (BOOL )isInBleConnectingVC;
/// 是否关闭蓝牙 sn 校验
+ (BOOL)isCloseBleVerifySN;
///  请求使用选中的 SN
+ (BOOL )isUseSelectSNToRequest;

+ (void )tdLog:(NSString *)message;
///
+ (NSString *)errorMessageWithCode:(NSInteger )code;

/// 是否仅限试用功能
+ (BOOL)isLimitedTrialFuction;

/// 是否是 DEMO
+ (BOOL)isDEMO;

/// 是否 DEBUG
+ (BOOL)isDebug;

/// 是否是北美 autoAuth
+ (NSInteger )isAutoAuthNa;

#pragma mark 车型功能与系统 无序
+ (NSArray *)carMaintenanceArr;
+ (NSArray *)carMaintenanceExArr;
+ (NSDictionary *)carMaintenanceExDict;

+ (NSArray *)carSystemArr;
+ (NSArray *)carSystemExArr;
+ (NSDictionary *)carSystemExDict;


#pragma mark 静态库版本打印
+ (void)logStaticLibraryVersion;

+ (NSString *)carStaticLibraryVersionWithType:(NSString *)stringType;

+ (NSString *)carGetMainVersionWithModel:(TDD_CarModel *)model;

#pragma mark 弹框
/// 重置弹窗状态
+ (void)resetAlert;
/// 电压过低
+ (void)showBatteryVoltLowAlert;
/// 蓝牙断开
+ (void)showBleBreakAlert;
/// 后台进前台
+ (void)showBackgroundAlert;
// 软件过期续费弹框
+ (void)showSoftExpiredToBuyAlert:(nullable void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
