//
//  TDD_DiagnosisManage.h
//  AD200
//
//  Created by 何可人 on 2022/6/9.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TDD_ArtiGlobalModel.h"
#import "TDD_CarModel.h"
#import "TDD_Enums.h"
//#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>
typedef NS_ENUM(NSInteger, TDDHLanguageType);
NS_ASSUME_NONNULL_BEGIN

#pragma mark - NSNotificationKey
#define  KTDDNotificationArtiDiagStart          @"KTDDNotificationArtiDiagStart"                  //进车
#define  KTDDNotificationArtiDiagStop           @"KTDDNotificationArtiDiagStop"                   //退车
#define  KTDDNotificationArtiDiagStopCranking   @"KTDDNotificationArtiDiagStopCranking"           //退出电池检测
#define  KTDDNotificationArtiShow               @"KTDDNotificationArtiShow"                       //show
#define  KTDDNotificationArtiTranslatedShow     @"KTDDNotificationArtiTranslatedShow"             //show - 翻译完成
#define  KTDDNotificationVciStatusChange        @"KTDDNotificationVciStatusChange"                //VCI状态变化(设置状态)
#define  KTDDNotificationVciStatusDidChange     @"KTDDNotificationVciStatusDidChange"             //VCI状态变化(旧状态与新状态不一致)
#define  KTDDNotificationTDartsStatusChange     @"KTDDNotificationTDartsStatusChange"             //T-Darts状态变化
#define  KTDDNotificationTDartsStatusDidChange  @"KTDDNotificationTDartsStatusDidChange"          //T-Darts状态变化(旧状态与新状态不一致)
#define  KTDDNotificationTDartsVCIInfoChanged   @"KTDDNotificationTDartsVCIInfoChanged"           //T-Darts信息变化
#define  KTDDNotificationVCIDisconnect          @"KTDDNotificationVCIDisconnect"                  //VCI断开连接
#define  KTDDNotificationVCIISBOOT              @"KTDDNotificationVCIISBOOT"                      //VCI处于BOOT模式

#define KTDDNotificationVCIInitializedStatusChanged @"KTDDNotificationVCIInitializedStatusChanged" //VCI 连接初始化状态改变
#define  kTDDNotificationVCIWiFiInitializedStatusChanged @"kTDDNotificationVCIWiFiInitializedStatusChanged"//WIFI 连接初始化状态改变
#define  KTDDNotificationVCIAccessoryConnected  @"KTDDNotificationVCIAccessoryConnected"          //系统蓝牙已连接通知

#define  KTDDNotificationBatteryUpdate          @"KTDDNotificationBatteryUpdate"                  // 蓄电池检测更新通知

#define  KTDDNotificationArtLiveSetChange       @"KTDDNotificationArtLiveSetChange"               //检测数据展示样式设置发生变化

#define  KTDDNotificationArtiShowFloatMini      @"KTDDNotificationArtiShowFloatMini"              //是否展示浮窗
#define  KTDDNotificationArtiViewDidAppear       @"KTDDNotificationArtiViewDidAppear"              //VC显示通知

#define  KTDDNotificationArtiInputModelChange   @"KTDDNotificationArtiInputModelChange"           //刷新输入框数据

#define  KTDDNotificationLandscapePortraitChange   @"KTDDNotificationLandscapePortraitChange"     //横竖屏切换

@protocol TDD_DiagnosisManageDelegate <NSObject>
/// 提供app类型
- (eProductName )appProduct;
/// 提供app群组类型
- (eAppProductGroup )appProductGroup;
/// 提供选中的VCI sn
- (NSString *)selectedVCISerialNum;
/// SN是否禁用
- (BOOL )isSNDisable;
/// 提供选中的TDarts sn
- (NSString *)selectedTDartsSerialNum;
/// 提供用户ID
- (int )userID;
/// 提供用户topdonID
- (NSString *)topdonID;
/// 用户是否登录
- (BOOL )userIsLogin;
/// 提供用户token
- (NSString *)userToken;
/// 提供用户二次验证 token
- (NSString *)userTwoFATokenToken:(NSString *)account;
/// 提供服务器地址
- (NSString *)serverURL;
/// crash自定义信息
- (NSString *)crashCustomValue;
/// 提供诊断单位
- (NSString *)diagnosticUnit;
- (NSString *)AESEncrypt:(NSString *)str;
- (NSString *)userAccount;
- (NSString *)appKey;
- (NSString *)ipAddress;
- (NSString *)deviceUUID;
/// 定制设备类型
- (TDD_Customized_Type )customizedType;

/// 是否是北美区域(未获取到:-1、否:0、是:1)
- (NSInteger )isAutoAuthNa;
/// 在绑定页面
- (BOOL )isInBleConnectingVC;

/// SN不一致弹框
- (void)showSNErrorAlert;
/// 关闭 sn 校验
- (BOOL )isCloseBleVerifySN;
///  使用选中的 SN进行请求
- (BOOL )isUseSelectSNToRequest;


/// 往日志库插入信息
/// - Parameters:
///   - message: 信息
///   - type: 待定，目前只有车型路径，后续增加类型改为枚举
- (void)insertMessageToTopDonLog:(NSString *)message time:(NSTimeInterval )time type:(NSInteger )type;
@optional
/// 评分字体
- (UIFont *)scoreFont:(CGFloat )size weight:(UIFontWeight)weight;
///日志打印
- (void)tdLog:(NSString *)message;
/// 提供车辆额外信息
- (NSDictionary *)carExtraInfo;

/// 埋点
/// - Parameters:
///   - eventID: 需要埋点的事件ID
///   - param: 埋点参数
- (void)tdEvent:(NSString *)eventID attributes:(nullable NSDictionary *)param eventType:(TDD_EventType)eventType;

- (void)tdBeginEvent:(NSString *)eventID attributes:(nullable NSDictionary *)param eventType:(TDD_EventType)eventType;

- (void)tdEndEvent:(NSString *)eventID attributes:(nullable NSDictionary *)param;

/// 暂停记时
- (void)tdPauseEvent:(NSString *)eventId;

/// 开始记时
- (void)tdResumeEvent:(NSString *)eventId;

/// 取消埋点
- (void)tdRemoveEvent:(NSString *)eventId;

/// 谷歌翻译
- (void)translateWords:(NSArray *)words toLangeageID:(NSInteger )languageID completion:(void (^)(NSURLResponse * _Nullable response, id  _Nullable responseObject, NSError * _Nullable error))complete;

/// autoVIN仅返回一个可进车车型(没有返回nil)
- (nullable TDD_CarModel *)autoVINMatchToEnter;

/// autoVIN 自定义LoadingView(如果要使用，4个方法都要实现)
- (UIView *)diagnosisCustomLoadingView:(TDD_CustomLoadingType )type;
- (CGRect )diagnosisCustomLoadingViewRect:(TDD_CustomLoadingType )type;
- (void)diagnosisCustomLoadingViewStart:(TDD_CustomLoadingType )type;
- (void)diagnosisCustomLoadingViewStop:(TDD_CustomLoadingType )type;

- (void)lastSystemScanScore:(NSInteger)score scroeColor:(UIColor *)color;
- (NSString *)errorMessage:(NSInteger )code;
@end

@protocol DiagnosisVCDelegate <NSObject>
///退出诊断
- (void)finishDiag:(UIViewController *)diagVC;
///artiModel相关代理回调
- (void)artiModelDelegate:(TDD_ArtiModelBase *)artiModel eventType:(TDD_ArtiModelEventType)eventType param:(nullable NSDictionary *)param diagVC:(UIViewController *)diagVC completeHandle: (nullable void(^)(id result))complete;
///otherEvent回调
- (void)handleOtherEvent:(TDD_DiagOtherEventType )eventType model:(TDD_ArtiModelBase *)artiModel param:(nullable NSDictionary *)param diagVC:(UIViewController *)diagVC;
@end

@interface TDD_DiagnosisManage : NSObject

@property (nonatomic,assign) BOOL isLocalDiagnose;//是否使用本地诊断

@property (nonatomic, strong) TDD_CarModel * _Nullable carModel; //当前进车的model

@property (nonatomic, strong) NSMutableArray<TDD_CarModel *> * localDIAGCarModelArr; //本地诊断车型数组

@property (nonatomic, strong) NSMutableArray<TDD_CarModel *> * localIMMOCarModelArr; //本地IMMO车型数组

@property (nonatomic, strong) NSMutableArray<TDD_CarModel *> * localRFIDCarModelArr; //本地T-Dart车型数组

@property (nonatomic, strong) NSMutableArray<TDD_CarModel *> * localMotoCarModelArr; //本地Moto车型数组

@property (nonatomic, strong) NSMutableDictionary * carStaticLibraryVersionDic; //诊断车型本地静态库版本

@property (nonatomic, strong) NSMutableDictionary * IMMOStaticLibraryVersionDic; //IMMO车型本地静态库版本

@property (nonatomic, strong) NSMutableDictionary * MOTOStaticLibraryVersionDic; //Moto车型本地静态库版本

@property (nonatomic, assign) TDD_NetworkStatus netState;

@property (nonatomic, assign) eAppScenarios appScenarios; //app运行环境:debug/release

@property (nonatomic, assign) BOOL isOpenDisorderlyScan;

@property (nonatomic, assign) TDD_DiagViewColorType viewColorType; //诊断配色

@property (nonatomic, copy) NSString *softwareCode; //软件编码

@property (nonatomic, copy) NSString *documentSubpath; //沙盒文件夹子路径

@property (nonatomic, weak)   id<TDD_DiagnosisManageDelegate> manageDelegate;

@property (nonatomic, assign)NSTimeInterval enterTime; //进车时间戳
@property (nonatomic,assign) BOOL enabledBleLog;//是否开启蓝牙日志
@property (nonatomic,assign) BOOL enabledAD200Log;//是否开启AD200诊断日志
@property (nonatomic,assign) TDDSoftware currentSoftware;

@property (nonatomic,assign) long functionConfigMask;//设备支持功能

+ (TDD_DiagnosisManage *)sharedManage;

#pragma mark - 初始化
+ (void)DiagnosisInit;

#pragma mark - 获取版本号
+ (NSString *)getVersion;

#pragma mark - 进入诊断界面
+ (void)enterDiagViewControllerWithCarModel:(TDD_CarModel *)carModel entryType:(eDiagEntryType )diagEntryType menuMask:(eDiagMenuMask)diagMenuMask delegate:(id<DiagnosisVCDelegate>)delegate;

/// 进入诊断(增加新版掩码)
/// - Parameters:
///   - carModel: 进入车型
///   - diagEntryType: 旧版功能掩码
///   - diagMenuMask: 旧版系统掩码
///   - delegate: 代理
///   - animated:  push 动画
///   - diagEntryTypeExs: 新版功能掩码数组(使用checkMaskWithMaintenance方法获取)
///   - systemMaskEx: 保留字段，可以传空数组
+ (void)enterDiagViewControllerWithCarModel:(TDD_CarModel *)carModel entryType:(eDiagEntryType )diagEntryType menuMask:(eDiagMenuMask)diagMenuMask delegate:(id<DiagnosisVCDelegate>)delegate animated:(BOOL)animated entryTypeExs:(NSArray *)diagEntryTypeExs systemMaskEx:(NSArray *)systemMaskEx;

+ (void)enterDiagViewControllerWithCarModel:(TDD_CarModel *)carModel entryType:(eDiagEntryType )diagEntryType menuMask:(eDiagMenuMask)diagMenuMask delegate:(id<DiagnosisVCDelegate>)delegate animated:(BOOL)animated;
#pragma mark - 历史诊断
/// 进入历史诊断需要先设置历史诊断记录值
+ (void)setHistoryRecord:(NSString *)historyRecord;

#pragma mark - 进入车型
/// 进入车型
+ (uint32_t)ArtiDiagWithCarModel:(TDD_CarModel *)carModel;

#pragma mark - 进入本地诊断
+ (void)enterLocalChooseCarViewController:(eDiagEntryType )diagEntryType  delegate:(id<DiagnosisVCDelegate>)delegate;

#pragma mark - 搜索目录
+ (NSArray<TDD_CarModel *> *)searchAllDirectory;

#pragma mark 设置语言
/// 设置语言
+ (void)setLanguage:(TDDHLanguageType)languageType;

#pragma mark 获取当前语言
///获取当前语言
+ (NSString *)getCurrentLanguage;

#pragma mark - 固件升级
/// 固件升级
/// @param filePath 固件包路径
/// @param progressBlock 进度条回调
/// @param completionHandler 完成回调 0、升级失败 1、升级成功 2、头部校验失败
+ (void)firmwareUpdateWithFilePath:(NSString *)filePath version:(NSString *)version progress:(nullable void (^)(NSProgress *progress))progressBlock completionHandler:(nullable void (^)(int result))completionHandler;

#pragma mark 解析公英制文件
+ (void)analysisUnitFile:(NSString *)unit;

#pragma mark 静态库版本打印
+ (void)logStaticLibraryVersion;

///获取静态库版本
/// - Parameter stringType: DIAG或者IMMO
+ (NSString *)carStaticLibraryVersionWithType:(NSString *)stringType;
///获取主车版本号
+ (NSString *)carGetMainVersionWithModel:(TDD_CarModel *)model;
#pragma mark 车型功能与系统
+ (NSArray *)carMaintenanceArr;
+ (NSArray *)carMaintenanceExArr;

+ (NSArray *)carSystemArr;
+ (NSArray *)carSystemExArr;

#pragma mark DB
///初始化需要设置 groupID,不设置则只会创建本地数据库
///例子:TopScan VAG 使用
+ (void)setStoreGroupID:(NSString *)groupID;
///切换数据库
/// 注意: 1、进车前自动切换并且诊断内调此接口切换无效(正常进车后自动切到本地数据库，特殊(VAG)切到群组数据库)
/// 2、app 注意管理切换取值删除值
+ (void)switchDBType:(TDD_DBType)dbType;
/// 查看app当前设置的 groupID
+ (NSString *)storeGroupID;
///当前数据库
+ (TDD_DBType)dbType;

///检查传入掩码值与 ini 的掩码值
/// - Parameters:
///   - maintenanceStr: 传入功能掩码值字符串，为空不解析
///   - systemStr: 传入系统掩码值字符串，为空不解析
///   - carModel: 进入的车型，为空则仅解析掩码字符串(为空相当于跟全功能与，即supporArr 为strArr)
+ (TDD_MaskModel *)checkMaskWithMaintenance:(nullable NSString *)maintenanceStr system:(nullable NSString *)systemStr carModel:(nullable TDD_CarModel *)carModel;

/// 将掩码数组转换成掩码字符串
/// - Parameter maskArr: 掩码数组
+ (NSString *)converMaskExArrToMaskStr:(NSArray *)maskArr;

#pragma mark stdComm
/// 退出此模块的时候调用
+ (void)stdcommDeInit;

// 获取VCI的序列号
// 返回VCI的序列号, 例如：“JV0013BA100044”
// 如果VCI设备没有连接，返回空串，""
// 此接口  app 调用 stdcomm
+ (NSString *)stdcommVciSn;

// 获取VCI的6字节注册码
// 返回VCI的注册码, 例如：“123456”
// 如果VCI设备没有连接，返回空串，""
// 此接口  app 调用 stdcomm
+ (NSString *)stdcommVciCode;

// VCI是否处于BOOT模式
// 1，BOOT模拟，即升级模式
// 0，APP模式，即正常模式
+ (uint32_t)stdcommFwIsBoot;

// VCI固件版本信息
// 例如通常情况为：
// AD900 RelayV3 Jul  8 2021 V1.02
// App应用自己去掉前面的日期字串，例如去掉后是V1.02
+ (NSString *)stdcommFwVersion;

// 获取蓝牙软件版本号
// 蓝牙模组 JB631 蓝牙
// 例如通常情况为：F.DJ.BD025.JB6321-30B1_v1.1.4.10
+ (NSString *)stdcommBtVersion;

// 设置蓝牙模组进入升级模式
// 蓝牙模组 JB6321 进入升级模式
// true, 进入成功
// false，进入升级模式失败
+ (BOOL)stdcommBtEnterUpdate;

// 设置蓝牙模组退出升级模式
// 蓝牙模组 JB6321 退出升级模式
// true, 退出成功
// false, 退出升级模式失败
// 注意，调用此接口会断开蓝牙一次
+ (BOOL)stdcommBtExitUpdate;

// 获取诊断通信日志
+ (NSArray *)stdcommGetLogPath;

// 获取引脚电压
+ (uint32_t)stdcommReadPinNumVoltage:(uint32_t )pinNum;

// 向车型日志写入日志
+ (void)writeLogToVehicle:(NSString *)strLog;

// 蓝牙模组复位
// true, 复位成功
// false, 复位失败
+ (BOOL)stdcommBtReset;

// FwDeviceType
//
// 获取当前VCI的设备类型
//                                     uint32_t            固件标识             VCI名称
// AD900 Tool 的设备类型是：            0x41443900         "AD900Relay207"       "AD900TOOL"
// AD900 VCI（小接头）的设备类型是：      0x4E333247         "AD900VCIN32G455"     "AD900VCI"
// TOPKEY EasyVCI（小接头）的设备类型是： 0x45564349         "EasyVCIGD32F305"     "EasyVCI"
+ (uint32_t)FwDeviceType;

// 国内版TOPVCI 获取空气质量等级接口【0, 100】
/*
*   返 回 值：如果设备没有连接或者指针为空，返回-1
*            返回获取到的空气传感器模组的空气质量等级，【0, 100】
*/
+ (uint32_t)getAirQuality;

// 国内版TOPVCI 获取空气传感器已运行多少时间，单位毫秒
/*
*   返 回 值：如果设备没有连接或者指针为空，返回-1
*           返回获取到空气传感器已运行多少时间，单位毫秒
*/
+ (uint32_t)GetAirUpTime;

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
+ (BOOL)StartCranking;

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
+ (BOOL)StopCranking;

/// 读取电池电压
+ (float)readVBat;

// 设置VCI锁状态
// 成功返回1，失败返回0
// 说明：此接口阻塞，耗时大概500毫秒左右
+ (uint32_t )setLock;
// 设置VCI解锁状态
// 成功返回1，失败返回0
// 说明：此接口非阻塞，APK调用SO，SO返回，大概耗时500毫秒左右
+ (uint32_t )setUnlock;
// 获取锁状态
// 获取成功并且未锁返回1
// 获取成功并且已锁返回2
// 获取失败返回0
+ (uint32_t )getVCILock;
#pragma mark 获取TDarts信息
//0，未连接； 1，已连接；
+ (uint32_t)getTDartsTProgStatus;
//SN
+ (NSString *)getTDartsSN;
//注册码
+ (NSString *)getTDartsCode;
//MCUID
+ (NSString *)getTDartsMcuId;

#pragma mark 翻译统计相关
///翻译时间段(开始)
+ (NSString *)getTranslateStartTime;
///翻译次数
+ (NSInteger )getTranslateCount;
///翻译字符量(成功的原字符)
+ (NSInteger )getTranslateChartNum;
///清空翻译统计
+ (void )resetTranslate;


/// 获取诊断码 颜色 富文本
+ (NSMutableAttributedString *)getDtcNodeStatusDescription:(long long)dtcNodeStatus statusStr:(NSString *)dtcNodeStatusStr fromTrouble:(BOOL )fromTrouble;

+ (void)hideLoading;

// 开启诊断通信日志
// TypeName       对应的诊断类型，例如"DIAG"表示现在是诊断车型，或者"IMMO"表示现在是锁匠车型
// VehName        对应的车型名称，例如"Nissan"
//
// 注意，App应加载诊断车型前调用此接口，保证诊断日志的完整性
//
+ (void)StartLogWithTypeName:(NSString *)TypeName VehName:(NSString *)VehName;

// 停止诊断通信日志
+ (void)stopLog;

// 获取诊断通信日志
// 返回std::string数组，数组个数为文件个数，每个元素为一个日志文件路径
// 如果std::string数组只有一个元素，则只有一个日志文件
+ (NSArray *)getLogPath;

// 获取通信库版本号
// 通信层版本信息
// 例如通常情况为：V1.00
+ (NSString *)stdVersion;

#pragma mark
@end

NS_ASSUME_NONNULL_END
