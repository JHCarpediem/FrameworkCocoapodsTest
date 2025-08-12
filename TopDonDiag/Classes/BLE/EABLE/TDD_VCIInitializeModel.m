//
//  TDD_VCIInitializeModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/7/23.
//

#import "TDD_VCIInitializeModel.h"
///WIFI初始化Error 类型(可包含多个)
typedef enum
{
    /// 重新获取 VCI 信息
    VCI_INIT_TIMER_REGET_MESSAGE         = 1,
    ///重新获取 WIFI 信息
    VCI_INIT_TIMER_REGET_WIFI     = 2,
    ///获取 VCI 信息超时
    VCI_INIT_TIMER_MESSAGE_TIMEOUT    = 3,
    ///获取 Wi-Fi 是否准备好
    VCI_INIT_TIMER_WIFI_REGET_ALREADY      = 4,
    ///获取 Wi-Fi 是否准备好超时
    VCI_INIT_TIMER_WIFI_TIMEOUT      = 5,
    
}eVCIInitTimerType;
@interface TDD_VCIInitializeModel()
///VCISN
@property (nonatomic, copy) NSString *vciSN;
///VCI型号
@property (nonatomic, assign) NSInteger deviceType;
///VCI版本
@property (nonatomic, copy) NSString *fwVersion;
///蓝牙版本
@property (nonatomic, copy) NSString *btVersion;
///引脚电压数组(除开 4、5)
@property (nonatomic, strong) NSMutableDictionary *voltaDict;
///是否支持MT7628
@property (nonatomic, assign) BOOL isSupportMT7628;
///初始化状态
@property (nonatomic, assign) eVCIInitializeStatus initStatus;
@property (nonatomic, assign) NSInteger failIndex;

@property (nonatomic, assign) NSInteger reGetCount;
@property (nonatomic, assign) BOOL isVCITimeout;
///Wi-Fi
@property (nonatomic, assign) BOOL mt7628IsReady;
///MT7628系统版本号
@property (nonatomic, strong) NSString *mt7628OsVersion;
///MT7628App/库版本号
@property (nonatomic, strong) NSString *mt7628AppVersion;
@property (nonatomic, assign) NSInteger mt7628DeviceType;
@property (nonatomic, assign) eWIFIInitializeStatus wifiInitStatus;
@property (nonatomic, assign) NSInteger wifiFailIndex;
@property (nonatomic, assign) NSInteger wifiReGetCount;
@property (nonatomic, assign) BOOL isWIFITimeout;
///获取 VCI 信息定时器
@property (nonatomic) dispatch_source_t reGetMessageTimer;
///获取 WIFI 信息定时器
@property (nonatomic) dispatch_source_t reGetWifiMessageTimer;
///VCI初始化超时定时器
@property (nonatomic) dispatch_source_t vciInitTimer;
///获取Wi-Fi 是否准备好定时器
@property (nonatomic) dispatch_source_t wifiIsReadyTimer;
///获取 Wi-Fi 是否准备好超时定时器
@property (nonatomic) dispatch_source_t wifiTimeoutTimer;
@end

@implementation TDD_VCIInitializeModel

- (instancetype )init {
    if (self = [super init]) {
        [self reset];
    }
    return self;

}

///重置
- (void)reset {
    self.reGetCount = 0;
    self.vciSN = @"";
    self.deviceType = 0;
    self.fwVersion = @"";
    self.btVersion = @"";
    self.voltaDict = @{}.mutableCopy;
    self.isSupportMT7628 = false;
    self.failIndex = 0;
    self.initStatus = VCI_INIT_DEFAULT;
    self.isVCITimeout = false;
    
    self.wifiReGetCount = 0;
    self.mt7628IsReady = false;
    self.mt7628OsVersion = @"";
    self.mt7628AppVersion = @"";
    self.wifiFailIndex = 0;
    self.wifiInitStatus = WIFI_INIT_DEFAULT;
    self.isWIFITimeout = false;
    
    [self cancelTaskTimer:_reGetMessageTimer];
    
    [self cancelTaskTimer:_reGetWifiMessageTimer];
    
    [self cancelTaskTimer:_vciInitTimer];
    
    [self cancelTaskTimer:_wifiIsReadyTimer];
    
    [self cancelTaskTimer:_wifiTimeoutTimer];
    
}

#pragma mark - VCI信息
/// 初始化获取信息(sdtCommModel 的方法可能阻塞线程)
- (void)getMessage {
    _isVCITimeout = false;
    
    //VCI初始化超时
    [self cancelTaskTimer:_vciInitTimer];
    @kWeakObj(self);
    [self scheduleTaskAfterDelay:60 timerStorage:_vciInitTimer type:VCI_INIT_TIMER_MESSAGE_TIMEOUT task:^{
        @kStrongObj(self);
        [self vciInitTimeOut];
    }];
    
    [self cancelTaskTimer:_reGetMessageTimer];

    self.reGetCount = 0;
    self.initStatus = VCI_INIT_ING;

    //获取 VCISN
    if (_isVCITimeout) return;
    self.vciSN = [TDD_StdCommModel VciSn];
    
    //获取 VCI 型号
    if (_isVCITimeout) return;
    self.deviceType = [TDD_StdCommModel FwDeviceType];
    
    //获取 VCI 版本
    if (_isVCITimeout) return;
    self.fwVersion = [TDD_StdCommModel FwVersion];
    
    //获取 VCI 蓝牙软件版本号
    if (_isVCITimeout) return;
    self.btVersion = [TDD_StdCommModel BtVersion];
    
    //获取 VCI 是否支持 MT7628
    if (_isVCITimeout) return;
    self.isSupportMT7628 = [TDD_StdCommModel MT7628IsSupported];
    
    NSInteger boot =  [TDD_StdCommModel FwIsBoot];
    //boot 模式不获取电压
    if (boot == 0) {
        //获取 16 个引脚电压
        if (_isVCITimeout) return;
        self.voltaDict = @{}.mutableCopy;
        for (int i = 1; i < 17; i++) {
            if (i != 4 && i != 5) {
                NSInteger volta = [TDD_StdCommModel readPinNum:i];
                [self.voltaDict setValue:@(volta) forKey:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }

    
    if (self.failIndex > 0) {
        [self scheduleTaskAfterDelay:1 timerStorage:_reGetMessageTimer type:VCI_INIT_TIMER_REGET_MESSAGE task:^{
            @kStrongObj(self);
            [self reGetMessage];
        }];
    }else {
        self.initStatus = VCI_INIT_SUCCESS;
    }
    
}

///获取 VCI 信息超时
- (void)vciInitTimeOut {
    if (self.initStatus == VCI_INIT_ING) {
        HLog(@"VCI初始化1分钟超时:failIndex: %ld - SN: %@",self.failIndex,self.vciSN);
        self.isVCITimeout = true;
        self.initStatus = VCI_INIT_FAIL;
        self.reGetCount = 0;
        [self cancelTaskTimer:self.vciInitTimer];
        [self cancelTaskTimer:self.reGetMessageTimer];
    }
}

/// 重新获取 VCI信息
- (void)reGetMessage {
    [self cancelTaskTimer:self.reGetMessageTimer];
    HLog(@"VCI初始化 重试次数:%d - 失败类型:%d - SN: %@",self.reGetCount + 1, self.failIndex, _vciSN);
    self.reGetCount ++;
    if (_isVCITimeout) return;
    if (self.failIndex & VCI_VALUE_ERROR_VCI_SN) {
        self.vciSN = [TDD_StdCommModel VciSn];
    }
    if (_isVCITimeout) return;
    if (self.failIndex & VCI_VALUE_ERROR_DEVCIE_TYPE) {
        self.deviceType = [TDD_StdCommModel FwDeviceType];
    }
    if (_isVCITimeout) return;
    if (self.failIndex & VCI_VALUE_ERROR_FW_VERSION) {
        self.fwVersion = [TDD_StdCommModel FwVersion];
    }
    if (_isVCITimeout) return;
    if (self.failIndex & VCI_VALUE_ERROR_BT_VERSION) {
        self.btVersion = [TDD_StdCommModel BtVersion];
    }
    
    if (self.failIndex > 0 && self.reGetCount < 3) {
        @kWeakObj(self);
        [self scheduleTaskAfterDelay:1 timerStorage:_reGetMessageTimer type:VCI_INIT_TIMER_REGET_MESSAGE task:^{
            @kStrongObj(self);
            [self reGetMessage];
        }];

    }else {
        self.initStatus = (self.failIndex > 0) ? VCI_INIT_FAIL : VCI_INIT_SUCCESS;
        self.reGetCount = 0;
        
    }
}

#pragma mark - WIFI信息
/// 获取 Wi-Fi 是否启动
- (void)getMT7628IsReady {
    if (self.isWIFITimeout) {
        return;
    }
    //获取Wi-Fi已启动超时
    [self cancelTaskTimer:self.wifiTimeoutTimer];
    @kWeakObj(self);
    [self scheduleTaskAfterDelay:120 timerStorage:self.wifiTimeoutTimer type:VCI_INIT_TIMER_WIFI_TIMEOUT task:^{
        @kStrongObj(self);
        [self wifiIsReadyTimeOut];
    }];

    self.mt7628IsReady = [TDD_StdCommModel MT7628IsReady];
    if (self.mt7628IsReady == 0) {
        if (!self.isWIFITimeout) {
            [self scheduleTaskAfterDelay:10 timerStorage:self.wifiIsReadyTimer type:VCI_INIT_TIMER_WIFI_REGET_ALREADY task:^{
                @kStrongObj(self);
                [self getMT7628IsReady];
            }];
            
        }
    }else {
        [self getWifiMessage];
    }
    
}

/// Wi-Fi 是否启动超时
- (void)wifiIsReadyTimeOut {
    if (self.wifiInitStatus == WIFI_INIT_ING && self.mt7628IsReady == 0) {
        HLog(@"2分钟未获取到 Wi-Fi 已启动 - SN: %@",self.vciSN);
        self.isWIFITimeout = true;
        self.wifiInitStatus = WIFI_INIT_FAIL;
        [self cancelTaskTimer:self.wifiIsReadyTimer];
        [self cancelTaskTimer:self.wifiTimeoutTimer];
    }
}

/// 获取 Wi-Fi 信息
- (void)getWifiMessage {
    [self cancelTaskTimer:self.reGetWifiMessageTimer];
    self.wifiReGetCount = 0;
    
    //系统版本
    self.mt7628OsVersion = [TDD_StdCommModel MT7628OsVersion];
    
    //app 版本以及库版本
    self.mt7628AppVersion = [TDD_StdCommModel MT7628AppVersion];
    
    //获取MT7628的设备类型
    self.mt7628DeviceType = [TDD_StdCommModel MT7628DeviceType];
    
    if (self.wifiFailIndex > 0) {
        @kWeakObj(self);
        [self scheduleTaskAfterDelay:1 timerStorage:self.reGetWifiMessageTimer type:VCI_INIT_TIMER_REGET_WIFI task:^{
            @kStrongObj(self);
            [self reGetWifiMessage];
        }];
    }else {
        self.wifiInitStatus = WIFI_INIT_SUCCESS;
    }
    
}

///重新获取 Wi-Fi 信息
- (void)reGetWifiMessage {
    [self cancelTaskTimer:self.reGetWifiMessageTimer];
    HLog(@"wifi初始化 重试次数:%d - 失败类型:%d - SN: %@",self.wifiReGetCount + 1, self.wifiFailIndex, _vciSN);
    self.wifiReGetCount ++;
    
    if (self.wifiFailIndex & WIFI_VALUE_ERROR_OS_VERSION) {
        self.mt7628OsVersion = [TDD_StdCommModel MT7628OsVersion];
    }
    
    if (self.wifiFailIndex & WIFI_VALUE_ERROR_APP_VERSION) {
        self.mt7628AppVersion = [TDD_StdCommModel MT7628AppVersion];
    }
    
    if (self.wifiFailIndex & WIFI_VALUE_ERROR_DEVICE_TYPE) {
        self.mt7628DeviceType = [TDD_StdCommModel MT7628DeviceType];
    }
    
    
    if (self.wifiFailIndex > 0 && self.wifiReGetCount < 3) {
        @kWeakObj(self);
        [self scheduleTaskAfterDelay:1 timerStorage:self.reGetWifiMessageTimer type:VCI_INIT_TIMER_REGET_WIFI task:^{
            @kStrongObj(self);
            [self reGetWifiMessage];
        }];

    }else {
        self.wifiInitStatus = (self.wifiFailIndex > 0) ? WIFI_INIT_FAIL : WIFI_INIT_SUCCESS;
    }
    
}

#pragma mark - 定时器
///创建定时器
- (void)scheduleTaskAfterDelay:(NSTimeInterval)delay
                 timerStorage:(dispatch_source_t )timerStorage
                          type:(eVCIInitTimerType )type
                        task:(void (^)(void))task {
    if (timerStorage) {
        dispatch_source_cancel(timerStorage);
        timerStorage = nil;
    }

    @kWeakObj(self);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), DISPATCH_TIME_FOREVER, 0);

        dispatch_source_set_event_handler(timer, ^{
            @kStrongObj(self);
            if (self) {
                if (task) task();
                if (type == VCI_INIT_TIMER_MESSAGE_TIMEOUT || type == VCI_INIT_TIMER_WIFI_TIMEOUT) {
                    [self setTimer:timerStorage type:type isCancel:true];
                }
            }
        });

        dispatch_resume(timer);
        [self setTimer:timer type:type isCancel:false];
        
    }
}

///设置定时器
- (void )setTimer:(dispatch_source_t)timer type:(eVCIInitTimerType )type isCancel:(BOOL )isCancel {
    switch (type) {
        case VCI_INIT_TIMER_REGET_MESSAGE:
            {
                if (isCancel) {
                    [self cancelTaskTimer:self.reGetMessageTimer];
                }else {
                    self.reGetMessageTimer = timer;
                }
                
            }
            break;
        case VCI_INIT_TIMER_REGET_WIFI:
            {
                if (isCancel) {
                    [self cancelTaskTimer:self.reGetWifiMessageTimer];
                }else {
                    self.reGetWifiMessageTimer = timer;
                }
                
            }
            break;
        case VCI_INIT_TIMER_MESSAGE_TIMEOUT:
            {
                if (isCancel) {
                    [self cancelTaskTimer:self.vciInitTimer];
                }else {
                    self.vciInitTimer = timer;
                }
                
            }
            break;
        case VCI_INIT_TIMER_WIFI_REGET_ALREADY:
            {
                if (isCancel) {
                    [self cancelTaskTimer:self.wifiIsReadyTimer];
                }else {
                    self.wifiIsReadyTimer = timer;
                }
                
            }
            break;
        case VCI_INIT_TIMER_WIFI_TIMEOUT:
            {
                if (isCancel) {
                    [self cancelTaskTimer:self.wifiTimeoutTimer];
                }else {
                    self.wifiTimeoutTimer = timer;
                }
                
            }
            break;
            
        default:
            break;
    }
    
}

- (void)cancelTaskTimer:(dispatch_source_t )timerStorage{
    if (timerStorage) {
        dispatch_source_cancel(timerStorage);
        timerStorage = nil;
    }
}


#pragma mark - Lazy
- (void)setVciSN:(NSString *)vciSN {
    _vciSN = vciSN;
    if ([NSString tdd_isEmpty:vciSN]) {
        self.failIndex |= VCI_VALUE_ERROR_VCI_SN;
    }else {
        self.failIndex &= ~VCI_VALUE_ERROR_VCI_SN;
    }
}

- (void)setDeviceType:(NSInteger)deviceType {
    _deviceType = deviceType;
    if (deviceType == 0 || deviceType == 0xFFFFFFFF) {
        self.failIndex |= VCI_VALUE_ERROR_DEVCIE_TYPE;
    }else {
        self.failIndex &= ~VCI_VALUE_ERROR_DEVCIE_TYPE;
    }
}

- (void)setFwVersion:(NSString *)fwVersion {
    _fwVersion = fwVersion;
    if ([NSString tdd_isEmpty:fwVersion]) {
        self.failIndex |= VCI_VALUE_ERROR_FW_VERSION;
    }else {
        self.failIndex &= ~VCI_VALUE_ERROR_FW_VERSION;
    }
}

- (void)setBtVersion:(NSString *)btVersion {
    _btVersion = btVersion;
    if ([NSString tdd_isEmpty:btVersion]) {
        self.failIndex |= VCI_VALUE_ERROR_BT_VERSION;
    }else {
        self.failIndex &= ~VCI_VALUE_ERROR_BT_VERSION;
    }
    
}

- (void)setInitStatus:(eVCIInitializeStatus)initStatus {
    if (_initStatus != initStatus) {
        NSString *errorStr = @"";
        if (initStatus == VCI_INIT_FAIL) {
            errorStr = [self getErrorFuctionName];
            [TDD_Statistics event:Event_Cus_FirmwareInitializationFail attributes:@{@"SN":_vciSN?:@"",@"stdComm":errorStr?:@""}];
        }
        
        _initStatus = initStatus;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVCIInitializedStatusChanged object:nil];
            
            HLog(@"VCI初始化状态修改: %ld - failIndex: %ld - errorStr:%@ - SN: %@",initStatus,self.failIndex,errorStr,self.vciSN);
        });
        
        //VCI 成功或者失败都去获取 Wi-Fi 信息
        if (initStatus == VCI_INIT_SUCCESS || initStatus == VCI_INIT_FAIL) {
            //支持MT7628获取Wi-Fi 信息并且不在 boot 模式，不支持直接返回失败
            
            if (self.isSupportMT7628 && ([TDD_StdCommModel FwIsBoot] == 0)) {
                self.wifiInitStatus = WIFI_INIT_ING;
                [self getMT7628IsReady];
            }else {
                HLog(@"isSupportMT7628 为 false 不进行wifi初始化 - SN: %@",self.vciSN);
                self.wifiInitStatus = WIFI_INIT_FAIL;
            }
        }
    }
    
}

- (void)setMt7628OsVersion:(NSString *)mt7628OsVersion {
    _mt7628OsVersion = mt7628OsVersion;
    if ([NSString tdd_isEmpty:mt7628OsVersion]) {
        self.wifiFailIndex |= WIFI_VALUE_ERROR_OS_VERSION;
    }else {
        self.wifiFailIndex &= ~WIFI_VALUE_ERROR_OS_VERSION;
    }
}

- (void)setMt7628AppVersion:(NSString *)mt7628AppVersion {
    _mt7628AppVersion = mt7628AppVersion;
    if ([NSString tdd_isEmpty:mt7628AppVersion]) {
        self.wifiFailIndex |= WIFI_VALUE_ERROR_APP_VERSION;
    }else {
        self.wifiFailIndex &= ~WIFI_VALUE_ERROR_APP_VERSION;
    }
}

- (void)setMt7628DeviceType:(NSInteger)mt7628DeviceType {
    _mt7628DeviceType = mt7628DeviceType;
    if (mt7628DeviceType == 0) {
        self.failIndex |= WIFI_VALUE_ERROR_DEVICE_TYPE;
    }else {
        self.failIndex &= ~WIFI_VALUE_ERROR_DEVICE_TYPE;
    }
}

- (void)setWifiInitStatus:(eWIFIInitializeStatus)wifiInitStatus {
    if (_wifiInitStatus != wifiInitStatus) {
        NSString *errorStr = @"";
        if (_wifiInitStatus == WIFI_INIT_FAIL) {
            errorStr = [self getErrorFuctionName];
            [TDD_Statistics event:Event_Cus_FirmwareInitializationFail attributes:@{@"SN":_vciSN?:@"",@"stdComm":errorStr?:@""}];
        }
        
        _wifiInitStatus = wifiInitStatus;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kTDDNotificationVCIWiFiInitializedStatusChanged object:nil];
            HLog(@"WIFI初始化状态修改: %ld - failIndex: %ld - errorStr: %@ - SN: %@",wifiInitStatus,self.wifiFailIndex,errorStr,self.vciSN);
        });
    }
}

/// 获取埋点需要的字符串
- (NSString *)getErrorFuctionName {
    NSString *errorFuctionStr = @"";
    if (_failIndex > 0) {
        if ([NSString tdd_isEmpty:_vciSN]) {
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",VciSn"];
        }
        if (_deviceType == 0 || _deviceType == 0xFFFFFFFF){
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",FwDeviceType"];
        }
        if ([NSString tdd_isEmpty:_fwVersion]) {
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",FwVersion"];
        }
        if ([NSString tdd_isEmpty:_btVersion]) {
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",BtVersion"];
        }
    }
    
    if (self.mt7628IsReady == 0) {
        errorFuctionStr = [errorFuctionStr stringByAppendingString:@",MT7628IsReady"];
    }
    if (_wifiFailIndex > 0) {
        if ([NSString tdd_isEmpty:_mt7628OsVersion]){
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",MT7628OsVersion"];
        }
        if ([NSString tdd_isEmpty:_mt7628AppVersion]){
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",MT7628AppVersion"];
        }
        if (_mt7628DeviceType == 0){
            errorFuctionStr = [errorFuctionStr stringByAppendingString:@",MT7628DeviceType"];
        }
    }
    if ([errorFuctionStr hasPrefix:@","] && errorFuctionStr.length > 1) {
        errorFuctionStr = [errorFuctionStr substringFromIndex:1];
    }
    return errorFuctionStr;
}
@end
