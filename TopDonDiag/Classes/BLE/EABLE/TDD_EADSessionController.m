/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Provides an interface for communication with an EASession. Also the delegate for the EASession input and output stream objects.
 */

#import "TDD_EADSessionController.h"
#import "TDD_DiagnosisManage.h"
#import "TDD_StdCommModel.h"

#define defaultSN @"11031017H21017" //固件兜底 sn

@interface TDD_EADSessionController ()<EAAccessoryDelegate>


@property (nonatomic, strong) NSMutableData *writeData;
@property (nonatomic, strong) NSMutableData *readData;


@property (nonatomic,assign) BOOL isShowSNTip; //是否显示SN不一致提示
@property (nonatomic,assign) BOOL isWriteData; //是否写入数据
@property (nonatomic,strong) NSString * VCIVersion; //VCI版本

@property (nonatomic, strong) TDD_HTipBtnView * tipBtnView;

@property (nonatomic, assign) NSTimeInterval lowBatteryVoltTime;//低电压持续时间

@property (nonatomic, assign) BOOL areadyGetStdSN;

@property (nonatomic, strong) TDD_VCIInitializeModel *vciInitModel;
@end

NSString *EADSessionDataReceivedNotification = @"EADSessionDataReceivedNotification";

@implementation TDD_EADSessionController
{
    BOOL _isBackClose;
    NSTimer *_timer;
    BOOL _isOpeningSession;
}

#pragma mark Internal

// low level write method - write data to the accessory while there is space available and data to write
- (NSInteger)_writeData {
    
    NSInteger bytesWritten = -1;
    
    self.isWriteData = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelector:@selector(cancelWriteData) withObject:nil afterDelay:1];
    });
    
    while ([_writeData length] > 0 && self.isWriteData)
    {
        if (!_session || !_writeData) {
            break;
        }
        if ([[_session outputStream] hasSpaceAvailable]) {
//            BLELog(@"当前数据1：%d", (int)[_writeData length]);
            NSInteger newBytesWritten = [[_session outputStream] write:[_writeData bytes] maxLength:[_writeData length]];
            if (newBytesWritten == -1)
            {
                BLELog(@"数据写入失败");
                break;
            }
            else if (newBytesWritten >= 0)
            {
//                BLELog(@"当前数据2：%d", (int)[_writeData length]);
                if ([_writeData length] >= newBytesWritten) {
                    [_writeData replaceBytesInRange:NSMakeRange(0, newBytesWritten) withBytes:NULL length:0];
                }
                BLELog(@"数据写入成功：%ld", (long)newBytesWritten);
                bytesWritten += newBytesWritten;
            }
        }else {
//            sleep(0.1);
//            BLELog(@"hasSpaceAvailable false");
        }
        if (!_session || !_writeData) {
            break;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelWriteData) object:nil];
    });
    
    return bytesWritten;
}

- (void)cancelWriteData
{
    BLELog(@"写入数据1s超时");
    
    self.isWriteData = NO;
}

// low level read method - read data while there is data and space available in the input buffer
- (void)_readData {
#define EAD_INPUT_BUFFER_SIZE 128
    uint8_t buf[EAD_INPUT_BUFFER_SIZE];
    if (!_session) {
        BLELog(@"session 为空")
        return;
    }
    while ([[_session inputStream] hasBytesAvailable])
    {
        NSInteger bytesRead = [[_session inputStream] read:buf maxLength:EAD_INPUT_BUFFER_SIZE];
        [self.readData appendBytes:(void *)buf length:bytesRead];
        
        if ([TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE) {
            @autoreleasepool {
                NSString * str = [NSDate tdd_convertDataToHexStr:_readData];
                
                BLELog(@"当前读到数据：%@", str);
            }
        }
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:EADSessionDataReceivedNotification object:self userInfo:nil];
}

#pragma mark Public Methods

+ (TDD_EADSessionController *)sharedController
{
    static TDD_EADSessionController * sessionController = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        sessionController = [[TDD_EADSessionController alloc] init];
        sessionController->_isOpeningSession = NO;
        sessionController.vciInitModel = [[TDD_VCIInitializeModel alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sessionController selector:@selector(_accessoryDidConnect:) name:EAAccessoryDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sessionController selector:@selector(_accessoryDidDisconnect:) name:EAAccessoryDidDisconnectNotification object:nil];
        
        //监听程序进入前台和后台
        if isKindOfTopVCI {
//            [[NSNotificationCenter defaultCenter] addObserver:sessionController
//                                                     selector:@selector(enterBackGround:)
//                                                         name:UIApplicationDidEnterBackgroundNotification
//                                                       object:nil];
//            [[NSNotificationCenter defaultCenter] addObserver:sessionController
//                                                     selector:@selector(enterForeGround:)
//                                                         name:UIApplicationWillEnterForegroundNotification
//                                                       object:nil];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:sessionController selector:@selector(ArtiDiagStart) name:KTDDNotificationArtiDiagStart object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:sessionController selector:@selector(ArtiDiagStop) name:KTDDNotificationArtiDiagStop object:nil];
        
        [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
        
        sessionController.accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
        
        if (sessionController.accessoryList.count > 0) {
            BLELog(@"当前已连接的蓝牙：%@", sessionController.accessoryList);
            [sessionController marryBLE];
        }
    });
    return sessionController;
}

- (void)enterBackGround:(NSNotification *)notif
{
    
    if (!isKindOfTopVCI) { return; }
    BLELog(@"进入后台");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        if (self->_timer) {
            [self->_timer invalidate];
            self->_timer = nil;
        }
        
        self->_timer = [NSTimer scheduledTimerWithTimeInterval:60 * 15 target:self  selector:@selector(enterBackGroundClose) userInfo:nil repeats:NO];

        if (self->_timer) {
            [[NSRunLoop currentRunLoop] addTimer:self->_timer forMode:NSDefaultRunLoopMode];
            
            [[NSRunLoop currentRunLoop] run];
        }
    });
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(enterBackGroundClose) object:nil];
//
//        [self performSelector:@selector(enterBackGroundClose) withObject:nil afterDelay:60];
//    });
   
}

- (void)enterBackGroundClose
{
    if (!isKindOfTopVCI) { return; }
    
    if (_isBackClose) { return; }

    BLELog(@"进入后台15分,断开通讯");
    
    _isBackClose = YES;
    
    [self closeSession];
}

- (void)enterForeGround:(NSNotification *)notif
{
    if (!isKindOfTopVCI) { return; }
    BLELog(@"进入前台");
    
    _isBackClose = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self->_timer) {
            BLELog("进入前台停止后台定时器");
            [self->_timer invalidate];
            self->_timer = nil;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self enterForeGroundOpen];
        });
    });
    
}

- (void)enterForeGroundOpen
{
    if (!isKindOfTopVCI) { return; }
    BLELog(@"进入前台,打开通讯");
    
    [self openSession];
}

- (void)ArtiDiagStart
{
    self.isArtiDiag = YES;
}

- (void)ArtiDiagStop
{
    self.isArtiDiag = NO;
    self.isShowSNTip = NO;
}

- (BOOL)marryBLE
{
    BLELog(@"开始匹配蓝牙");
    
    BOOL  matchFound = FALSE;
    
    self.accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
    
    for (EAAccessory *connectedAccessory in _accessoryList) {
        
        NSArray *protocolStrings = [connectedAccessory protocolStrings];
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSArray * supportedProtocolsStrings = [mainBundle objectForInfoDictionaryKey:@"UISupportedExternalAccessoryProtocols"];
        
        for(NSString *protocolString in protocolStrings)
        {
            
            for ( NSString *item in supportedProtocolsStrings)
            {
                if ([item compare: protocolString] == NSOrderedSame)
                    
                    
                {
                    matchFound = TRUE;
                    
                    NSLog(@"match found - protocolString %@", protocolString);
                }
            }
            
            if (matchFound) {
                BLELog(@"该蓝牙是匹配的蓝牙");
                [self setupControllerForAccessory:connectedAccessory withProtocolString:protocolString];
                return YES;
            }
        }
    }
    
    BLELog(@"没有匹配的蓝牙");
    return NO;
}

- (void)_accessoryDidConnect:(NSNotification *)notification {
    EAAccessory *connectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];

    [_accessoryList addObject:connectedAccessory];
    
    BLELog(@"当前蓝牙已连接：%@", connectedAccessory);
    id internal =  [connectedAccessory valueForKey:@"internal"];
    //这句打印会偶现崩溃
    //BLELog(@"当前蓝牙已连接internal 信息：%@", [internal yy_modelToJSONString]);
    if (!_accessory) {
        [self marryBLE];
    }
}

- (void)_accessoryDidDisconnect:(NSNotification *)notification {
    EAAccessory *disconnectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];

    BLELog(@"蓝牙已断开：%@", disconnectedAccessory);
    
    
    if (_accessory && [disconnectedAccessory connectionID] == [_accessory connectionID])
    {
        BLELog(@"当前蓝牙已断开");
        [TDD_Statistics event:Event_BLEDisconnection attributes:nil];
        [self setupControllerForAccessory:nil withProtocolString:nil];
        //诊断内蓝牙断开
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVCIDisconnect object:nil];
        
        self.isPreviousConnected = NO;
        self.isPreviousConnectedToDisconnected = NO;
    }

    int disconnectedAccessoryIndex = 0;
    
    for(EAAccessory *accessory in _accessoryList) {
        if ([disconnectedAccessory connectionID] == [accessory connectionID]) {
            break;
        }
        disconnectedAccessoryIndex++;
    }

    if (disconnectedAccessoryIndex < [_accessoryList count]) {
        [_accessoryList removeObjectAtIndex:disconnectedAccessoryIndex];
    } else {
        BLELog(@"无法在配件列表中找到断开连接的配件");
    }
}

- (void)dealloc {
    [self closeSession];
    [self setupControllerForAccessory:nil withProtocolString:nil];
}

// initialize the accessory with the protocolString
- (void)setupControllerForAccessory:(EAAccessory *)accessory withProtocolString:(NSString *)protocolString
{
    self.isShowSNTip = NO;
    
    if (self.accessory == accessory) {
        BLELog("当前session与传入的值相等 直接return");
        return;
    }
    
    id internal =  [accessory valueForKey:@"internal"];

    BLELog(@"VCI的MAC地址:%@", [internal valueForKey:@"macAddress"]);
    
    NSString * SN = [internal valueForKey:@"serialNumber"];
    self.SN = SN;

    
    if (![NSString tdd_isEmpty:SN]) {
        BLELog(@"KTDDNotificationVCIAccessoryConnected - 发送通知")
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVCIAccessoryConnected object:nil];
    }
    
    //重新连接的时候将VCI 版本号以及 SN 置空
    //VCIStatus 为 1 时重新获取
    self.VCIVersion = @"";
    BLELog(@"VCI的MFI的SN:%@", SN);
    
    [self closeSession];
    
    BLELog(@"设置控制器为附件,输入协议字符串是 %@", protocolString);
    
    _accessory = accessory;
    
    _protocolString = [protocolString copy];
    
    if (!accessory) {
        return;
    }
    
    accessory.delegate = self;
    _areadyGetStdSN = NO;
    [self openSession];
    
}

// open a session with the accessory and set up the input and output stream on the default run loop
- (BOOL)openSession
{
    BLELog(@"打开蓝牙通讯");
 
    if (_isBackClose) {
        BLELog(@"应用在后台，禁止通讯");
        return NO;
    }
    //
    if ([TDD_DiagnosisTools isSNDisable]) {
        BLELog(@"SN被禁用，禁止通讯");
        return NO;
    }
    BOOL enabledVerifySn = ![TDD_DiagnosisTools isCloseBleVerifySN] && _areadyGetStdSN;
    if (enabledVerifySn) {
        if (![NSString tdd_isEmpty:[TDD_DiagnosisTools selectedVCISerialNum]] && ![NSString tdd_isEmpty:self.SN] && ![[TDD_DiagnosisTools selectedVCISerialNum] isEqualToString:self.SN] && ![self.SN isEqualToString:defaultSN]){
            BLELog(@"连接的 SN 与 选中的 SN 不一致不打开蓝牙");
            return NO;
        }
    }
    
    if (_session) {
        BLELog(@"蓝牙正在通讯中");
        return YES;
    }
    
    if (_isOpeningSession) {
        BLELog(@"正在Open Session 重复调用 直接return")
        return YES;
    }
    
    _isOpeningSession = YES;
    
//    BOOL isMainThread = [[NSThread currentThread] isMainThread];
//
//    // 创建信号量
//    dispatch_semaphore_t semaphore;
//
//    if (!isMainThread) {
//        semaphore = dispatch_semaphore_create(0);
//    }
//
//    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!self.accessory) {
            [self marryBLE];
        }
        
        if (self.accessory) {
//            [self.accessory setDelegate:self];
            
            if (!self.session) {
                BLELog("创建session1 %p", self.session);
                self.session = [[EASession alloc] initWithAccessory:self.accessory forProtocol:self.protocolString];
                BLELog("创建session2 %p", self.session);
                
                if (self.session)
                {
                    [[self.session inputStream] setDelegate:self];
                    [[self.session inputStream] scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
                    [[self.session inputStream] open];

                    [[self.session outputStream] setDelegate:self];
                    [[self.session outputStream] scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
                    [[self.session outputStream] open];
                    self.canEventBLEError = YES;
                    BLELog(@"创建通讯成功");
                }
                else
                {
                    BLELog(@"创建通讯失败");
                    
                    [self setupControllerForAccessory:nil withProtocolString:nil];
                }
            }
        }
        
//        if (!isMainThread) {
//            //信号量+1
//            dispatch_semaphore_signal(semaphore);
//        }
//    });
//
//    if (!isMainThread) {
//        //信号量等等
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    }
    
    _isOpeningSession = NO;

    return (_session != nil);
}

// close the session with the accessory.
- (void)closeSession
{
    BLELog(@"关闭蓝牙通讯");
    
    if (!_session || !_session.accessory) {
        if (_session.accessory){
            [[FIRCrashlytics crashlytics] setCustomValue:_session.accessory forKey:@"EADSessionAccessory"];
            BLELog(@"_session.accessory - %@",_session.accessory);
        }else {
            [[FIRCrashlytics crashlytics] setCustomValue:@"EADSessionAccessory 为 nil" forKey:@"EADSessionAccessory"];
            BLELog(@"_session.accessory 为空");
        }
        BLELog(@"_session - %@",_session);
        return;
    }
    [[FIRCrashlytics crashlytics] setCustomValue:_session forKey:@"EADSession"];

    
    @try {
        if (self.session.inputStream) {
            [[self.session inputStream] close];
            [[self.session inputStream] removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            [[self.session inputStream] setDelegate:nil];
        }

        if (self.session.outputStream) {
            [[self.session outputStream] close];
            [[self.session outputStream] removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            [[self.session outputStream] setDelegate:nil];
        }


        self.session = nil;
        [self.writeData setData:NSData.new];
        [self.readData setData:NSData.new];
        //self.writeData = nil;
//        self.readData = nil;
        
    } @catch (NSException *exception) {
        [[FIRCrashlytics crashlytics] setCustomValue:_session.accessory forKey:@"EADSessionAccessory"];
        BLELog(@"关闭蓝牙崩溃 - %@", exception.description);
    } @finally {
        
        BLELog(@"关闭蓝牙通讯成功");
    }
//    dispatch_async(dispatch_get_main_queue(), ^{
       
//        _accessory = nil;
//    });
}

- (void)closeSessionWithCloseStream
{
    
    BLELog(@"关闭蓝牙通讯 -- 流关闭");
    if (!_session) {
        BLELog(@"session 不存在")
        return;
    }
    if (self.session.inputStream) {
        [self.session.inputStream setDelegate:nil];
    }
    if (self.session.outputStream) {
        [self.session.outputStream setDelegate:nil];
    }
    
    self.session = nil;
    [self.writeData setData:NSData.new];
    [self.readData setData:NSData.new];
    //self.writeData = nil;
//    self.readData = nil;
    BLELog(@"关闭蓝牙通讯成功");
}

// high level write data method
- (NSInteger)writeData:(NSData *)data
{
    if ([TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE) {
        @autoreleasepool {
            NSString * str = [NSDate tdd_convertDataToHexStr:data];
            
            BLELog(@"向蓝牙写入数据:%@",str);
        }
    }
    [self.writeData setData:NSData.new];
    //self.writeData = nil;
    
    [self.writeData appendData:data];
    
    NSInteger bytesWritten = [self _writeData];

    return bytesWritten;
}

// high level read method
- (NSData *)readData:(NSUInteger)bytesToRead
{
    NSData *data = nil;
    if ([TDD_DiagnosisTools isSNDisable]) {
        BLELog(@"SN被禁用，禁止通讯");
        return self.closeData;
    }
    BOOL enabledVerifySn = ![TDD_DiagnosisTools isCloseBleVerifySN] && _areadyGetStdSN;
    if (enabledVerifySn) {
        if (![NSString tdd_isEmpty:[TDD_DiagnosisTools selectedVCISerialNum]] && ![NSString tdd_isEmpty:self.SN] && ![[TDD_DiagnosisTools selectedVCISerialNum] isEqualToString:self.SN] && ![self.SN isEqualToString:defaultSN]){
            BLELog(@"与绑定SN号不一致时不通讯");
            return self.closeData;
        }
    }
    [self _readData];
    if ([_readData length] > 0) {
        if (bytesToRead > [_readData length]) {
            bytesToRead = [_readData length];
        }
        NSRange range = NSMakeRange(0, bytesToRead);
        data = [_readData subdataWithRange:range];
        [_readData replaceBytesInRange:range withBytes:NULL length:0];
    }
    return data;
}

// get number of bytes read into local buffer
- (NSUInteger)readBytesAvailable
{
    return [_readData length];
}

#pragma mark EAAccessoryDelegate
//- (void)accessoryDidDisconnect:(EAAccessory *)accessory
//{
//    BLELog(@"当前蓝牙已断开：%@", accessory);
//    // do something ...
//
////    [self setupControllerForAccessory:nil withProtocolString:nil];
//
////    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVCIDisconnect object:nil];
//}

#pragma mark NSStreamDelegateEventExtensions

// asynchronous NSStream handleEvent method
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventNone:
            BLELog(@"流 - None");
            break;
        case NSStreamEventOpenCompleted:
            BLELog(@"流 - 开启完成");
            break;
        case NSStreamEventHasBytesAvailable:
            BLELog(@"流 - 有可用的字节数 - 可读取");
//            [self _readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            BLELog(@"流 - 有可用空间 - 可写入");
//            [self _writeData];
            break;
        case NSStreamEventErrorOccurred:
        {
            NSError *theError = [aStream streamError];
            if (self.canEventBLEError){
                [TDD_Statistics event:Event_BLECommunicationError attributes:nil];
                self.canEventBLEError = NO;
            }
            
            BLELog(@"流 - 错误:%@",theError);
        }
            break;
        case NSStreamEventEndEncountered:
            BLELog(@"流 - 结束");
//            [self closeSession];
            [self closeSessionWithCloseStream];
            break;
        default:
            BLELog(@"流 - 未知");
            break;
    }
}

- (void)setBatteryVolt:(float)BatteryVolt {
    _BatteryVolt = BatteryVolt;
    NSArray *buildInVehicles = @[@"IM_PRECHECK",@"AUTOVIN",@"ACCSPEED"];
    if (_BatteryVolt < 9
        && _isArtiDiag
        && [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowType != TDD_DiagShowType_TDarts
        && _VciStatus
        && ![buildInVehicles containsObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName.uppercaseString]) {
        if (_lowBatteryVoltTime == 0) {
            _lowBatteryVoltTime = [NSDate tdd_getTimestampSince1970];
        }
        //电压持续低于 9v 的时间大于 3 秒才弹框
        if ([NSDate tdd_getTimestampSince1970] - _lowBatteryVoltTime >= 3) {
            [TDD_DiagnosisTools showBatteryVoltLowAlert];
        }
    
    }else if (_BatteryVolt >= 9 || !_VciStatus || !_isArtiDiag) {
        _lowBatteryVoltTime = 0;
    }
}

- (void)setVciStatus:(BOOL)VciStatus {
    //蓝牙断开弹框
    if (_VciStatus != VciStatus &&
        !VciStatus
        && _isArtiDiag
        && [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowType != TDD_DiagShowType_TDarts
        && ![[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName.uppercaseString isEqualToString:@"AUTOVIN"]) {
        [TDD_DiagnosisTools showBleBreakAlert];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(VCINoHeartBeat) object:nil];
    });
    if (VciStatus) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Event_Pub_VCINoHeartbeat 事件，蓝牙通讯心跳异常
            [self performSelector:@selector(VCINoHeartBeat) withObject:nil afterDelay:10.0];
        });
        //已连接且由未连接变为已连接
        if (VciStatus && VciStatus!=_VciStatus) {
            [self vciInit];
        }
        
        if (self.VCIVersion.length == 0) {
            self.VCIVersion = self.vciInitModel.fwVersion;
            
            if (self.VCIVersion.length != 0) {
                [[NSUserDefaults standardUserDefaults] setValue:self.VCIVersion forKey:@"HLastVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            if ([TDD_StdCommModel FwIsBoot]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVCIISBOOT object:nil];
            }
        }
        
        // 已连接过设备
        self.isPreviousConnected = YES;
        
    } else {
        if (self.isPreviousConnected) {
            // 连接过设备后断开
            self.isPreviousConnectedToDisconnected = YES;
        }

    }
    
    _VciStatus = VciStatus;
}

- (void)vciInit {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.vciInitModel reset];
        [self.vciInitModel getMessage];
        if (![NSString tdd_isEmpty:self.vciInitModel.vciSN]) {
            self.SN = self.vciInitModel.vciSN;
        }
        if ([TDD_DiagnosisTools isSNDisable]) {
            BLELog(@"SN被禁用，禁止通讯");
            self.VciStatus = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVciStatusDidChange object:nil];
            });
        }
        self.areadyGetStdSN = YES;
        BOOL enabledVerifySn = ![TDD_DiagnosisTools isCloseBleVerifySN];
        //与绑定SN号不一致时不通讯
        if (enabledVerifySn) {
            if (![NSString tdd_isEmpty:[TDD_DiagnosisTools selectedVCISerialNum]] && ![NSString tdd_isEmpty:self.SN] && ![[TDD_DiagnosisTools selectedVCISerialNum] isEqualToString:self.SN] && ![self.SN isEqualToString:defaultSN]){
                BLELog(@"setVciStatus 与绑定SN号不一致时不通讯");
                if (!self.isShowSNTip) {
                    BLELog(@"提示不一致");
                    self.isShowSNTip = YES;
                    
                    self.VciStatus = 0;
                    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(showSNErrorAlert)]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationVciStatusDidChange object:nil];
                            [[TDD_DiagnosisManage sharedManage].manageDelegate showSNErrorAlert];
                        });
                        
                    }
                }
            }
        }
        [self saveUserdefaultSN];
        
    });
}

- (void)saveUserdefaultSN {
    @try {
        NSString *currentSN = self.SN.mutableCopy;
        if ([NSString tdd_isEmpty:currentSN]) {
            return;
        }
        [[NSUserDefaults standardUserDefaults] setObject:currentSN forKey:@"HLastSN"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //连接过的设备的 sn 用于埋点
        NSMutableArray *connectVCIArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"kUserDefaultsConnectedVCIList"].mutableCopy;
        if (!connectVCIArray) {
            connectVCIArray = [NSMutableArray array];
        }
        if (![NSString tdd_isEmpty:currentSN] && ![connectVCIArray containsObject:currentSN]) {
            [connectVCIArray addObject:currentSN];
            [[NSUserDefaults standardUserDefaults] setObject:connectVCIArray forKey:@"kUserDefaultsConnectedVCIList"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } @catch (NSException *exception) {
        BLELog("【CRASH】catch saveUserdefaultSN crash");
    } @finally {
        
    }
}

- (void)VCINoHeartBeat {
    [TDD_DiagnosisManage writeLogToVehicle:@"[AppLog] VciStatus 超时 10s"];
    
    NSLog(@"VCINoHeartBeat 方法调用");
    if (self.VciStatus) {
        [TDD_Statistics event:Event_Pub_VCINoHeartbeat attributes:nil];
    }
}

#pragma mark Lazy
- (NSString *)SN {
    //DEBUG下 并且开启后门使用选中 sn
    NSString *sn = _SN?:@"";
    if ([TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE && [TDD_DiagnosisTools isUseSelectSNToRequest]) {
        return [NSString tdd_isEmpty:[TDD_DiagnosisTools selectedVCISerialNum]] ? sn : [TDD_DiagnosisTools selectedVCISerialNum];
    }
    return sn;
}

- (TDD_HTipBtnView *)tipBtnView
{
    if (!_tipBtnView) {
        _tipBtnView = [[TDD_HTipBtnView alloc] initWithTitle:@"vci_sn_no_agree" buttonType:HTipBtnOneType];
    }
    
    [FLT_APP_WINDOW addSubview:_tipBtnView];
    
    return _tipBtnView;
}

- (NSMutableData *)writeData {
    if (!_writeData) {
        _writeData = [[NSMutableData alloc] init];
    }
    return _writeData;
}

- (NSMutableData *)readData {
    if (!_readData) {
        _readData = [[NSMutableData alloc] init];
    }
    return _readData;
}

- (NSData *)closeData {
    if (!_closeData) {
        int myInt = -1;
        _closeData = [NSData dataWithBytes:&myInt length:sizeof(myInt)];
    }
    return _closeData;
}
@end
