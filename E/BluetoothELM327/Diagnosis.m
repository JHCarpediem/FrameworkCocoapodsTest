//
//  Diagnosis.m
//  Topdon
//
//  Created by songlei on 2017/11/29.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "Diagnosis.h"
//#include <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>

static Diagnosis *shareInstance;

@interface Diagnosis ()

@property (nonatomic, strong) NSArray<NSString *> *commandArray;

@property (nonatomic, assign) NSInteger commandIndex;

/** 重发机制的次数 */
@property (nonatomic, assign) NSUInteger resendCount;

/** 是否停止发送 YES: 停止  NO: 继续 */
@property (nonatomic, assign) BOOL stopSend;

/** 是否循环发送指令 */
@property (nonatomic, assign) BOOL repeatSend;

/** 指令发送状态 */
@property (nonatomic, assign) CommandSendStatus sendStatus;
//@property (nonatomic, copy) DiagnosisResultBlock diagResultBlock;

@property (nonatomic,copy) NSString *ELMAgreement; /// 协议类型

@end

@implementation Diagnosis

@synthesize boxType = _boxType;

+ (Diagnosis *)shareServicesManager{
    if (!shareInstance) {
        shareInstance = [[self alloc] init];
        shareInstance.commBox = [[CommBox alloc] init];
    }
    return shareInstance;
}

//- (ConnectStatus)connectStatus
//{
//    Connector *connector = self.commBox.connector;
//    if (connector) {
//        if (connector.isConnected) {
//            return ConnectStatusConnected;
//        } else {
//            return ConnectStatusUnconnected;
//        }
//    } else {
//        return ConnectStatusUnconnected;
//    }
//    return ConnectStatusUnconnected;
//}
//
//- (ConnectType)connectType
//{
//    if ([self.commBox.connector isKindOfClass:[Bluetooth4Manager class]]) {
//        return ConnectTypeBLE;
//    }
//    if ([self.commBox.connector isKindOfClass:[SocketManager class]]) {
//        return ConnectTypeWiFi;
//    }
//    return ConnectTypeUnknow;
//}

- (void)setBoxType:(BoxType)boxType
{
    _boxType = boxType;
    self.commBox.connector.boxType = boxType;
}

// 重写get方法，防止直接使用赋值 self.commBox.connector.boxType = boxType; 时self.boxType没有值的情况
- (BoxType)boxType
{
    // 非0返回
    if (_boxType) {
        return _boxType;
    }
    return self.commBox.connector.boxType;
}

- (BOOL)isWiFiEnabled {
    
    return NO;
//    NSCountedSet * cset = [[NSCountedSet alloc] init];
//    struct ifaddrs *interfaces;
//    if(!getifaddrs(&interfaces) ) {
//        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
//            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
//                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
//            }
//        }
//    }
//    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}

- (NSString *)currentConnectedWiFiName
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString *name = @"";
    for (NSString *ifnam in ifs) {
        id info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        name = info[@"SSID"];
        NSString *str2 = info[@"BSSID"];
        NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
        NSLog(@"SSID = %@, BSSID = %@, SSIDDATA = %@", name, str2, str3);
    }
    return name;
}

- (BOOL)isConnectOBD_WiFi
{
    // WiFi_OBDII
    return [[self currentConnectedWiFiName] containsString:@"OBD"];
}

- (BOOL)isConnectOBD_BLE
{
    return NO;
}

- (void)disconnect
{
    [self.commBox.connector disconnect];
}

- (void)sendData:(NSString *)string receiveBlock:(ReceiveDataBlock)receiveBlock
{
    if (self.boxType == BoxTypeCheMi) {
        [self.commBox sendReceive_CheMi:string receiveBlock:receiveBlock];
    } else if (self.boxType == BoxTypeELM327) {
        [self.commBox sendReceive_elm327:string receiveBlock:receiveBlock];
    }
}

- (void)connectStatusBlock:(DiagnosisConnectStatus)connectStatusBlock
{
    self.commBox.connector.connectStatus = connectStatusBlock;
}

- (void)readWriteTimeout:(DiagnosisReadAndWriteTimeout)timeoutBlock
{
    self.commBox.connector.readWriteTimeout = timeoutBlock;
}

- (void)sendCommandArrayData:(NSArray<NSString *> *)commandArr
                      repeat:(BOOL)repeat
                 resultBlock:(DiagnosisResultBlock)block
{
    if (!commandArr || commandArr.count == 0) {
        return ;
    }
    self.stopSend = NO;
    self.commandIndex = 0;
    // repeat=YES表重复发送，反之不循环发送
    self.repeatSend = repeat;
    self.commandArray = commandArr;
//    self.diagResultBlock = block;
    [self sendCommand:self.commandArray[self.commandIndex]
          resultModel:[[ResultDataModel alloc] init]
          resultBlock:block];
//    if (self.sendStatus != SendStatusSending) {
//    }
}

- (void)sendCommand:(NSString *)command
        resultModel:(ResultDataModel *)resultModel
        resultBlock:(DiagnosisResultBlock)block
{
//    __weak __typeof(self) weakSelf = self;
    // 进入正在发送的状态
    self.sendStatus = SendStatusSending;
    [self sendData:command receiveBlock:^(ReceiveDataModel *recevModel, BoxType boxType) {
        // 根据boxType判断是用不同的方法解析
        switch (boxType) {
            case BoxTypeELM327:
                // 该方法将recevModel中的数据解析成 resultModel
                if ([command isEqualToString:@"ATDPN"]) {
                    
                    [self parsingElm327ReceiveModel:recevModel resultModel:resultModel command:command resultBlock:block isATDPN:ATDPNTypeA];
                    
                    if (recevModel.receiveDataArr.count >= 2) {
                        
                        self.ELMAgreement = recevModel.receiveDataArr[1];
                    }
                }else if ([command isEqualToString:@"03"] ||[command isEqualToString:@"07"] ||[command isEqualToString:@"0A"]){
                    
                    if ([self.ELMAgreement isEqualToString:@"A6"] ||[self.ELMAgreement isEqualToString:@"A7"] ||[self.ELMAgreement isEqualToString:@"A8"] ||[self.ELMAgreement isEqualToString:@"A9"]) {
                         [self parsingElm327ReceiveModel:recevModel resultModel:resultModel command:command resultBlock:block isATDPN:ATDPNTypeISOCAN];
                        
//                        [self parsingElm327ReceiveModel:recevModel resultModel:resultModel command:command resultBlock:block isATDPN:ATDPNTypeISONoCAN];
                        
                    }else{
                         [self parsingElm327ReceiveModel:recevModel resultModel:resultModel command:command resultBlock:block isATDPN:ATDPNTypeISONoCAN];
                    }
                }
                else{
                    [self parsingElm327ReceiveModel:recevModel resultModel:resultModel command:command resultBlock:block isATDPN:ATDPNTypeA];
                }
                
                break;
            case BoxTypeCheMi:
                [self parsingCheMIReceiveModel:recevModel resultModel:resultModel command:command resultBlock:block];
            default:
                break;
        }
        // 更改状态为一条指令接收完毕
        self.sendStatus = SendStatusAReceived;
        // 收到数据就回调一次
        if (self.everyDataReceivedBlock) {
            self.everyDataReceivedBlock(resultModel);
        }
        /** 指令数组存在且指令索引小于指令数组个数,要继续发送 */
        if (self.commandArray && self.commandIndex < self.commandArray.count-1) {
            // 不停止递归就继续发送命令
            if (!self.stopSend) {
                self.commandIndex++;
                [self sendCommand:self.commandArray[self.commandIndex]
                      resultModel:resultModel
                      resultBlock:block];
            }
        } else { // 跳出递归
            if (block) {
                block(resultModel);
            }
//            if (weakSelf.diagResultBlock) {
//                weakSelf.diagResultBlock(resultModel);
//            }
            if (self.repeatSend) { // 继续循环发送指令
                [self sendCommandArrayData:self.commandArray
                                    repeat:self.repeatSend
                               resultBlock:block];
            }
        }
    }];
}

- (void)sendSingleCommand:(NSString *)command
              resultBlock:(DiagnosisResultBlock)block
{
    [self sendCommand:command
          resultModel:[[ResultDataModel alloc] init]
          resultBlock:block];
}

- (void)stopSendCommand
{
    self.stopSend = YES;
    self.repeatSend = NO;
}


/** elm327的解析方式
 recevModel:  原始数据转换成的对象
 resultModel: 将recevModel中的数据按elm327解析公式计算结果
 command:     校验命令是否一致
 resultBlock:    命令不一致时，重发时需要传递的参数
 */
- (void)parsingElm327ReceiveModel:(ReceiveDataModel *)recevModel
                      resultModel:(ResultDataModel *)resultModel
                          command:(NSString *)command
                      resultBlock:(DiagnosisResultBlock)block isATDPN:(ATDPNType)ATDPN
{
    /** 判断mode模式收到的数据是否合法,且命令是否一致,不合法或超时就重发最多3次就向下执行 */
    if (self.resendCount <= 3 &&
        ![recevModel.command isEqualToString:command]) {
        self.resendCount++;
        if (!self.stopSend) {
            [self sendCommand:self.commandArray[self.commandIndex]
                  resultModel:resultModel
                  resultBlock:block];
        }
        return ;
    }
    self.resendCount = 0;
    [resultModel.rawReceviceModelArr addObject:recevModel];
    if (recevModel.support) {
        NSString *key = recevModel.command;
        /** AT 指令 */
        if (recevModel.isATCommand) {
            if (recevModel.receiveDataArr.count > 1) {
                [resultModel.commandAndDataDictM setValue:recevModel.receiveDataArr[1] forKey:key];
            }
        } else { // 数据指令
            /** 这里判断使用不同的公式 */
            switch (recevModel.obdMode) {
                case OBDMode01: {  ///数据流支持
                    if (recevModel.pid == 19 || recevModel.pid == 29) {
                        NSArray *array = [OBDFormula oxygenSensorMode5List:recevModel.ascIIData];
                        [resultModel.commandAndDataDictM setValue:array forKey:key];
                    } else {
                        [resultModel.commandAndDataDictM addEntriesFromDictionary:[OBDFormula mode1Formula:recevModel.pid data:recevModel.valueData]];
                    }
                }
                    break;
                case OBDMode02: {  ///数据流支持
                    NSMutableArray *pidData1 = [OBDFormula mode2FreezeFrame:recevModel.value];
                    [resultModel.commandAndDataDictM setValue:pidData1 forKey:key];
                }
                    break;
                case OBDMode03:   ////故障码 当前 历史 永久
                case OBDMode07:
                case OBDMode0A:{
                    
                    switch (ATDPN) {
                        case ATDPNTypeA:{
                            
                        }
                            break;
                        case ATDPNTypeISOCAN:{
                            NSData *cmd = recevModel.receiveDataArr.firstObject;
                            if (recevModel.receiveDataArr.count > 1) {
                                NSData *resposeCmd = recevModel.receiveDataArr[1];
                                if (((UInt8 *)cmd.bytes)[0]+0x40 != ((UInt8 *)resposeCmd.bytes)[0]) {
                                    UInt8 len = ((UInt8 *)resposeCmd.bytes)[1];
                                    NSUInteger subLen = len;
                                    if (subLen <= recevModel.valueData.length && recevModel.valueData.length > 2) {
                                        recevModel.valueData = [recevModel.valueData subdataWithRange:NSMakeRange(2, subLen)];
                                    }
                                }
                                if (((UInt8 *)resposeCmd.bytes)[1] == 0x00) {
                                    return ;
                                }
                            }
                            
                            if (recevModel.receiveDataArr.count > 1) {
                                
                                NSMutableArray *pidData1 = [OBDFormula modeErrorCodesData:recevModel.valueData can:NO];
                                [resultModel.commandAndDataDictM setValue:pidData1 forKey:key];
                            }
                        }
                            break;
                        case ATDPNTypeISONoCAN:{
                            NSData *cmd = recevModel.receiveDataArr.firstObject;
                            if (recevModel.receiveDataArr.count > 1) {
                                for (int j = 1; j < recevModel.receiveDataArr.count; j++) {
                                    NSData *resposeCmd = recevModel.receiveDataArr[j];
                                    if (((UInt8 *)cmd.bytes)[0]+0x40 != ((UInt8 *)resposeCmd.bytes)[0]) {
                                        UInt8 len = ((UInt8 *)resposeCmd.bytes)[1];
                                        NSUInteger subLen = len;
                                        if (subLen <= recevModel.valueData.length && recevModel.valueData.length > 2) {
                                            recevModel.valueData = [recevModel.valueData subdataWithRange:NSMakeRange(2, subLen)];
                                        }
                                    }
//                                    if (j == (recevModel.receiveDataArr.count - 1)) {
//                                        if (((UInt8 *)resposeCmd.bytes)[1] == 0x00) {
//                                            return ;
//                                        }
//                                    }
                                }
                            }
                            
                            if (recevModel.receiveDataArr.count > 1) {
                                NSMutableArray *pidData1 = [NSMutableArray arrayWithCapacity:0];
                                for (int k = 1; k < recevModel.receiveDataArr.count; k++) {
                                    [pidData1 addObjectsFromArray:[OBDFormula modeErrorCodesData:recevModel.receiveDataArr[k] can:YES]];
                                }
                                
                                [resultModel.commandAndDataDictM setValue:pidData1 forKey:key];
                            }
                            
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                case OBDMode05:{  ////氧传感器
                    NSArray *array = [OBDFormula oxysenSenorMode5:recevModel.ascIIData cid:command];
                    [resultModel.commandAndDataDictM setValue:array forKey:key];
                }
                    break;
                case OBDMode06:{ ///Mode6
                    NSData *valueData = recevModel.valueData;
                    BOOL isResponseFrame = ((UInt8 *)valueData.bytes)[0] == ((UInt8 *)recevModel.cmdData.bytes)[0]+0x40;
                    // 6: 非CAN  9: CANBUS
                    BOOL isCanProtocol = NO;
                    // 判断命令是不是获取支持项
                    if ([recevModel.command isEqualToString:@"0600"] ||
                        [recevModel.command isEqualToString:@"0620"] ||
                        [recevModel.command isEqualToString:@"0640"] ||
                        [recevModel.command isEqualToString:@"0660"] ||
                        [recevModel.command isEqualToString:@"0680"] ||
                        [recevModel.command isEqualToString:@"06A0"] ||
                        [recevModel.command isEqualToString:@"06C0"] ||
                        [recevModel.command isEqualToString:@"06E0"]) {
                        if (isResponseFrame) {
                            // 去除响应帧头
                            valueData = [valueData subdataWithRange:NSMakeRange(2, valueData.length-2)];
                        }
                        NSArray *supportArr = [OBDFormula mode6Support:recevModel.pid data:valueData];
                        if (supportArr.count) {
                            [resultModel.commandAndDataDictM setValue:supportArr forKey:key];
                        }
                    } else {
                        // 不是响应帧表示有多条数据，第一二字节表总长度
                        if (!isResponseFrame) {
                            int totalLen = ((UInt8 *)valueData.bytes)[1];
                            NSUInteger loc = 2;
                            NSRange subRange = NSMakeRange(loc, totalLen);
                            valueData = [valueData subdataWithRange:subRange];
                        }
                        NSUInteger actualNeedDataLen = valueData.length-1;
                        // 特殊情况 6和9都整除
                        if (actualNeedDataLen%9 == 0 && actualNeedDataLen%6 == 0) {
                            if (((UInt8 *)valueData.bytes)[10] == recevModel.pid) {
                                isCanProtocol = YES;
                            }
                        } else if (actualNeedDataLen%9 == 0) {
                            isCanProtocol = YES;
                        } else if (actualNeedDataLen%6 == 0) {
                            isCanProtocol = NO;
                        }
                        NSArray *dataArr = nil;
                        if (isCanProtocol) {
                            dataArr = [OBDFormula mode6TestCanbusData:valueData];
                        } else {
                            dataArr = [OBDFormula mode6TestNotCanbusData:valueData];
                        }
                        if (dataArr.count) {
                            [resultModel.mode6dataArr addObject:dataArr];
                        }
                    }
                }
                    break;
                case OBDMode09: {  ////汽车信息
                    
                    NSString *pidData9 = [OBDFormula mode09:recevModel.pid string:recevModel.value];
                    [resultModel.commandAndDataDictM setValue:pidData9 forKey:key];
                }
                    break;
                case OBDMode04:{  ////00 清码成功  其他清码失败
                    //[resultModel.commandAndDataDictM setValue:recevModel.value forKey:key];
                }
                    break;
                case OBDMode08:{ ///特殊模式
                    
                }
                    break;
                default:
                    break;
            }
        }
    }
}

/** 车米的解析方式 */
- (void)parsingCheMIReceiveModel:(ReceiveDataModel *)recevModel
                     resultModel:(ResultDataModel *)resultModel
                         command:(NSString *)command
                     resultBlock:(DiagnosisResultBlock)block
{
    // 数据流请求
    if ([command hasPrefix:@"6200"]) {
        
    } else if ([command hasPrefix:@"6201"]) { // 时间同步
        
    } else if ([command hasPrefix:@"6202"]) { // 读取行程
        
    } else if ([command hasPrefix:@"6209"]) { // 读取故障码
        
    } else if ([command hasPrefix:@"6207"]) { // 读取版本信息
        
    } else if ([command hasPrefix:@"6208"]) { // 清除故障码
        
    } else if ([command hasPrefix:@"620D"] || [command hasPrefix:@"620d"]) { // 读取VIN码
        
    } else if ([command hasPrefix:@"6252"]) { // 读取ACC状态
        
    } else if ([command hasPrefix:@"62c5"] || [command hasPrefix:@"62C5"]) { // 读取CPUID
        
    } else if ([command hasPrefix:@"621101"]) { // 读取数据流
        
    } else if ([command hasPrefix:@"621102"]) { // 读取冻结帧
        
    }
}

@end


#pragma mark - ResultDataModel
@implementation ResultDataModel

- (NSMutableDictionary *)commandAndDataDictM
{
    if (!_commandAndDataDictM) {
        _commandAndDataDictM = [NSMutableDictionary dictionary];
    }
    return _commandAndDataDictM;
}

- (NSMutableArray *)mode6dataArr
{
    if (!_mode6dataArr) {
        _mode6dataArr = [NSMutableArray array];
    }
    return _mode6dataArr;
}

- (NSMutableArray<ReceiveDataModel *> *)rawReceviceModelArr
{
    if (!_rawReceviceModelArr) {
        _rawReceviceModelArr = [NSMutableArray array];
    }
    return _rawReceviceModelArr;
}

@end

