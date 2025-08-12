//
//  TDD_TDartsManage.m
//  AD200
//
//  Created by AppTD on 2023/2/20.
//

#import "TDD_TDartsManage.h"

@interface TDD_TDartsManage ()
@property (nonatomic, strong) NSMutableData *readData;
@property (nonatomic, strong) NSCondition * condition;
@end

@implementation TDD_TDartsManage

+ (TDD_TDartsManage *)sharedManage
{
    static TDD_TDartsManage * manage = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        manage = [[TDD_TDartsManage alloc] init];
        
        [manage TDartsInit];
        
        [[NSNotificationCenter defaultCenter] addObserver:manage selector:@selector(HBLEDidDiscoverCharacteristics) name:@"HBLEDidDiscoverCharacteristics" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:manage selector:@selector(didUpdateValue:) name:HBLEDidUpdateValueForUUID object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:manage selector:@selector(BLEDidDisconnectPeripheral) name:HDidDisconnectPeripheral object:nil];
        
    });
    return manage;
}

- (void)TDartsInit
{
    self.strSn = @"";
    self.strCode = @"";
    self.strMcuId = @"";
    self.readData = nil;
}

- (void)setTProgStatus:(uint32_t)TProgStatus {
    
    if (_TProgStatus != TProgStatus && !TProgStatus && [TDD_EADSessionController sharedController].isArtiDiag && [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowType == TDD_DiagShowType_TDarts) {
        [TDD_DiagnosisTools showBleBreakAlert];

    }
    _TProgStatus = TProgStatus;
}

- (void)HBLEDidDiscoverCharacteristics
{
    BLELog(@"TDarts 建立连接完成");
    
    self.isConnect = YES;
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(openConnectTimeOut) object:nil];
//    });
    
//    [self.condition signal];
}

- (void)BLEDidDisconnectPeripheral
{
    self.isConnect = NO;
    
    BLELog(@"TDarts 连接断开");
}

- (BOOL)openConnect
{
    [self TDartsInit];
    
    BLELog(@"TDarts 建立连接：%d", self.isConnect);
    
    if (self.isConnect) {
        return YES;
    }else {
        return NO;
    }
    
//    [self.condition lock];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self performSelector:@selector(openConnectTimeOut) withObject:nil afterDelay:60];
//    });
//
//    [HBLEManager scan];
//
//    [self.condition wait];
//
//    [self.condition unlock];
//
//    BLELog(@"TDarts 建立连接：%d", self.isConnect);
//
//    return self.isConnect;
}

- (void)openConnectTimeOut
{
//    [self.condition signal];
    self.isConnect = NO;
    
    BLELog(@"TDarts 建立连接超时");
}

- (void)cancelConnect
{
    self.isConnect = NO;
    
    [HBLEManager cancelConnect];
}

- (uint32_t)sendBytes:(const uint8_t *)sendBuffer length:(uint32_t)length
{
    NSData * data = [NSData dataWithBytes:sendBuffer length:length];
    
    BLELog(@"T-Darts 发数据：%@", data);
    
    //需要重发3次
    BOOL isOK = [HBLEManager sendData:data];
    
    if (isOK) {
        BLELog(@"T-Darts 发数据成功");
        return (uint32_t)data.length;
    }else {
        BLELog(@"T-Darts 发数据失败");
        return -1;
    }
}

- (void)didUpdateValue:(NSNotification *)noti{
    @autoreleasepool {
        NSDictionary * dic = noti.userInfo;
        
        NSString * UUID = dic[@"UUID"];
        
        NSData * data = dic[@"data"];
        
        BLELog(@"T-Darts 接收数据：%@,UUID:%@", data, UUID);
        
        if ([UUID isEqual:BLEReadUUID]) {
            //处理数据
            if (_readData == nil) {
                _readData = [[NSMutableData alloc] init];
            }
            [_readData appendBytes:data.bytes length:data.length];
        }
    }
}

- (NSData *)readData:(NSUInteger)bytesToRead
{
    NSData *data = nil;
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

- (NSCondition *)condition{
    if (!_condition) {
        _condition = [[NSCondition alloc] init];
    }
    
    return _condition;
}

//- (BOOL)isConnect
//{
//    return HBLEManager.isConnect;
//}
@end
