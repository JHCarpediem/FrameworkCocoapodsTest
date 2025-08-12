//
//  TDD_HMBLECenterHandle.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/3/12.
//

#import "TDD_HMBLECenterHandle.h"
#import "TDD_HBLETools.h"

#define HBLEUUID  @"HBLEUUID"

#define BLEServiceUUID [TDD_HMBLECenterHandle sharedHMBLECenterHandle].serviceUUID
@interface TDD_HMBLECenterHandle ()

@property (nonatomic, strong) CBService * myService;
@property (nonatomic, strong) NSString *serviceUUID;
@property (nonatomic, strong) NSDictionary *option;
@end

@implementation TDD_HMBLECenterHandle

#pragma mark 创建单例
+(TDD_HMBLECenterHandle *)sharedHMBLECenterHandle {
    static TDD_HMBLECenterHandle *sharedCenter = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        sharedCenter = [[self alloc] init];
        [sharedCenter initObject];
    });
    return  sharedCenter;
}

#pragma mark 初始化
-(void)initObject {
    //CBCentralManagerOptionRestoreIdentifierKey : @"BTMobile BLE"  //后台模式
    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@YES};
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
    _centralManager.delegate = self;
    self.option = @{CBCentralManagerScanOptionAllowDuplicatesKey : [NSNumber numberWithBool:NO],CBCentralManagerOptionShowPowerAlertKey:[NSNumber numberWithBool:YES]};
    [self dataInit];
}

- (void)dataInit{
    BLELog(@"dataInit");
    _isConnect = NO;
    
    [_peripheralArr removeAllObjects];
    
    if (_discoveredPeripheral) {
        _discoveredPeripheral.delegate = nil;
        _discoveredPeripheral = nil;
    }
}

//===================================蓝牙=====================================//
#pragma mark - 蓝牙代理
#pragma mark 蓝牙状态更新
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HBLEDidUpdateState object:self userInfo:@{@"state" : @(central.state)}];
    
    if (central.state != CBManagerStatePoweredOn) {
        BLELog(@"蓝牙未打开,请在设置中打开蓝牙");
        if (_isConnect) {
            [self dataInit];
            [[NSNotificationCenter defaultCenter] postNotificationName:HDidDisconnectPeripheral object:self userInfo:nil];
        }
        return;
    }

    BLELog(@"蓝牙OK~!");
    [self scan];
}

#pragma mark 获取蓝牙恢复时的各种状态
//在蓝牙于后台被杀掉时，重连之后会首先调用此方法，可以获取蓝牙恢复时的各种状态
//- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *,id> *)dict{
//
//}

#pragma mark 蓝牙扫描到设备回调
// 2 当扫描到4.0的设备后，系统会通过回调函数告诉我们设备的信息，然后我们就可以连接相应的设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
//    if (peripheral.name.length > 0) {
//        BLELog(@"发现：%@", peripheral);
//    }
    
    if (peripheral.state == CBPeripheralStateConnecting || peripheral.state == CBPeripheralStateConnected) {
        return;
    }
    NSMutableString * macStr = @"".mutableCopy;
    
    if ([[advertisementData allKeys] containsObject:@"kCBAdvDataManufacturerData"]) {

        NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];

        macStr = [TDD_HBLETools tdd_convertDataToHexStr:data].mutableCopy;

        if (macStr.length >= 4) {
            macStr = [macStr substringFromIndex:4].mutableCopy;
            
            macStr = [macStr uppercaseString].mutableCopy;
            
            int index = (int)macStr.length;
            
            for (int i = 1; i < index / 2; i ++) {
                
                [macStr insertString:@":" atIndex:i * 2 + (i - 1)];
            }
        }else {
            macStr = @"".mutableCopy;
        }
    }
    
//    if (macStr.length == 0) {
//        NSArray * arr = advertisementData[@"kCBAdvDataServiceUUIDs"];
//        
//        if (arr.count >= 3) {
//            for (int i = (int)arr.count - 3; i < arr.count; i ++) {
//                CBUUID * uuid = arr[i];
//                
//                NSString * str = uuid.UUIDString;
//                
//                if (str.length == 4) {
//                    str = [NSString stringWithFormat:@"%@:%@", [str substringWithRange:NSMakeRange(2, 2)], [str substringToIndex:2]];
//                    if (macStr.length == 0) {
//                        macStr = str;
//                    }else{
//                        macStr = [NSString stringWithFormat:@"%@:%@", macStr, str];
//                    }
//                }
//            }
//        }
//    }
    
    NSString * mac = [macStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    mac = [mac lowercaseString];
    
    NSString * BLEName = [peripheral.name uppercaseString];

//    if ([BLEName isEqualToString:@"BTMobile Pros"]) {
    if ([BLEName hasPrefix:@"TD"]) {
//    [BLEName hasPrefix:@""] &&
//    if (([@"785ee89fffff" compare:mac options:NSCaseInsensitiveSearch] == NSOrderedDescending && [@"785ee8900000" compare:mac options:NSCaseInsensitiveSearch] == NSOrderedAscending) || [BLEName localizedCaseInsensitiveContainsString:@"BTMOBILE PROS"]) {
        BLELog(@"%@",[NSString stringWithFormat:@"已发现 peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.identifier, advertisementData]);
        
        TDD_DeviceModel * mod = [[TDD_DeviceModel alloc] init];
        mod.peripheral = peripheral;
        mod.MAC = macStr;
        
        __block BOOL isExist = NO;
        [self.peripheralArr enumerateObjectsUsingBlock:^(TDD_DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (obj.peripheral == mod.peripheral) {//数组中已经存在该对象
                       *stop = YES;
                       isExist = YES;
                 }
        }];
        
       if (!isExist) {//如果不存在就添加进去
           [self.peripheralArr addObject:mod];
           [[NSNotificationCenter defaultCenter] postNotificationName:HDidDiscoverPeripheral object:nil];
       }
        
//        if (![self.peripheralArr containsObject:peripheral]) {
//            [self.peripheralArr addObject:peripheral];
//            [[NSNotificationCenter defaultCenter] postNotificationName:HDidDiscoverPeripheral object:nil];
//        }
        
        NSString * uuid = [[NSUserDefaults standardUserDefaults] valueForKey:HBLEUUID];
        
        NSString * newUUID = [NSString stringWithFormat:@"%@", peripheral.identifier];
        
        //自动重连
        if ([newUUID isEqualToString:uuid]) {
            self.deviceModel = mod;
            [self ConnectedDevicesWithPeripheral:peripheral];
        }
    }
}

#pragma mark 蓝牙自动重连
- (void)ConnectedDevicesWithPeripheral:(CBPeripheral *)peripheral
{
    [self stop];
    
    if (_discoveredPeripheral) {
        [self cancelConnect];
    }
    
    if (_discoveredPeripheral != peripheral || !_isConnect) {
        [self dataInit];
        self.discoveredPeripheral = peripheral;
        if (self.discoveredPeripheral) {
            
            NSString * uuid = [NSString stringWithFormat:@"%@", peripheral.identifier];
            [[NSUserDefaults standardUserDefaults] setValue:uuid forKey:HBLEUUID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [_centralManager connectPeripheral:peripheral options:nil];
            BLELog(@"正在连接");
            
            [self performSelector:@selector(connectionTimeout) withObject:nil afterDelay:30];
        }else{
            BLELog(@"连接无效");
            [self scan];
            return;
        }
    }
}

#pragma mark 蓝牙连接超时
- (void)connectionTimeout{
    BLELog(@"连接超时");
    [self cancelConnect];
    [[NSNotificationCenter defaultCenter] postNotificationName:HDidConnectPeripheralTimeOut object:nil];
}

#pragma mark 蓝牙连接失败回调
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    BLELog(@"连接失败 ： %@，  %@",peripheral,error.localizedDescription);
    
    if (_discoveredPeripheral == peripheral) {
    
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(connectionTimeout) object:nil];
        
        [self dataInit];
        
        [self scan];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HDidDisconnectPeripheral object:self userInfo:nil];
    }
}

#pragma mark 蓝牙连接成功回调
// 3 当连接成功后，系统会通过回调函数告诉我们，然后我们就在这个回调里去扫描设备下所有的服务和特征
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    BLELog(@"%@",[NSString stringWithFormat:@"成功连接 peripheral: %@ with UUID: %@  \n",peripheral,peripheral.identifier]);
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(connectionTimeout) object:nil];
    
//    [self stopDeviceReset];
    
    NSString * BLEName = [peripheral.name uppercaseString];
    
    [self stop];
    
    NSString * uuid = [NSString stringWithFormat:@"%@", peripheral.identifier];
    [[NSUserDefaults standardUserDefaults] setValue:uuid forKey:HBLEUUID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _isConnect = YES;
    
    peripheral.delegate = self;
       //指定服务
//    [peripheral discoverServices:@[[CBUUID UUIDWithString:@"FFE0"],[CBUUID UUIDWithString:@"FFA0"],[CBUUID UUIDWithString:@"0x180A"], [CBUUID UUIDWithString:@"FFF0"]]];
    [peripheral discoverServices:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HDidConnectPeripheral object:self userInfo:nil];
    
}

#pragma mark 蓝牙连接断开回调
//掉线时调用
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    BLELog(@"外设已经断开：%@", peripheral);
    
    if (_discoveredPeripheral == peripheral) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(connectionTimeout) object:nil];
        
        [self dataInit];
        
        [self scan];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HDidDisconnectPeripheral object:self userInfo:nil];
    }
}

#pragma mark 蓝牙已发现服务回调
// 4 已发现服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (error != nil) {
        BLELog(@"蓝牙服务错误: %@",error.localizedDescription);
    }

    BLELog(@"发现服务： %@",peripheral.services);
    
    //处理我们需要的特征
    for (CBService *service in peripheral.services) {
//        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_MOTION],
//                                              [CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_TAP], [CBUUID UUIDWithString:@"2A25"], [CBUUID UUIDWithString:@"FFF1"], [CBUUID UUIDWithString:@"FFF2"]]
//                                 forService:service];
        
        if ([service.UUID isEqual:[CBUUID UUIDWithString:BLEServiceUUID]]) {
            //BT20
            self.myService = service;
        }
        
        [peripheral discoverCharacteristics:nil forService:service];
        
        BLELog(@"特征值处理完了");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HBLEDidDiscoverServices object:self userInfo:nil];
}

#pragma mark 蓝牙已发现特征值回调
// 5 已搜索到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error != nil) {
        BLELog(@"发现特征错误:  %@",error.localizedDescription);
//        return;
    }

    //属于那个服务
    //根据不同的特征执行不同的命令
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEReadUUID]]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HBLEDidDiscoverCharacteristics" object:self userInfo:nil];
}

#pragma mark 蓝牙获取数据回调
//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error != nil) {
        BLELog(@"获取数据错误:  %@",error.localizedDescription);
        return;
    }
    
    NSString *stringFromData = [TDD_HBLETools hexStringFromData:characteristic.value];
    
    if (stringFromData.length == 0) {
        BLELog(@"蓝牙接收到的数据为空！");
        return;
    }
    
    BLELog(@"\nreceive:\nUUID:%@\nData:%@", characteristic.UUID.UUIDString,stringFromData);
    
    NSString * UUID = characteristic.UUID.UUIDString;
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:HBLEDidUpdateValueForUUID object:nil userInfo:@{@"UUID" : UUID, @"data" : stringFromData}];
    if (characteristic.value) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HBLEDidUpdateValueForUUID object:nil userInfo:@{@"UUID" : UUID, @"data" : characteristic.value}];
    }
    
//    if ([self.delegate respondsToSelector:@selector(didUpdateValueForUUID:withHexString:)]) {
//        if ([characteristic isEqual:self.otaFeature]) {
//            [self.delegate didUpdateValueForUUID:@"OTA" withHexString:stringFromData];
//        }else{
//            [self.delegate didUpdateValueForUUID:characteristic.UUID.UUIDString withHexString:stringFromData];
//        }
//    }
}

#pragma mark 发送数据回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        BLELog(@"写入失败：%@", error);
    }else{
        BLELog(@"写入成功:%@", characteristic.value);
    }
    
}

#pragma mark 中心读取外设实时数据
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //测试
    if (error != nil) {
        BLELog(@"特征通知状态变化错误:%@",error.localizedDescription);
        
    } else {
        
        // Notification has started
        if (characteristic.isNotifying) {
            BLELog(@"特征通知已经开始：%@",characteristic);
            [peripheral readValueForCharacteristic:characteristic];
        } else {// Notification has stopped
            BLELog(@"特征通知已经停止： %@",characteristic);
            [_centralManager cancelPeripheralConnection:peripheral];
        }
    }
}

#pragma mark - 数据处理
#pragma mark 发送10进制数据
- (BOOL)sendData:(NSArray *)dataArr WithUUID:(NSString *)UUID{
    if (!self.myService.characteristics) {
        BLELog(@"无特征值");
        return NO;
    }
    
    for (CBCharacteristic *characteristic in self.myService.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID]]) {
            
            NSMutableString * mStr = @"".mutableCopy;
            
            for (NSNumber * nub in dataArr) {
                NSString * hexStr = [TDD_HBLETools getHexByDecimal:[nub intValue]];
                
                if (hexStr.length == 1) {
                    hexStr = [NSString stringWithFormat:@"0%@", hexStr];
                }
                
                [mStr appendString:hexStr];
            }
            
            NSData *data = [TDD_HBLETools convertHexStrToData:mStr];
            BLELog(@"\nsend:\nUUID:%@\nData:%@", UUID,data);
            [self.discoveredPeripheral writeValue:data forCharacteristic:characteristic type:0];
            
            return YES;
        }
    }
    
    return NO;
}

#pragma mark 发送16进制数据
- (BOOL)sendhexData:(NSArray *)dataArr WithUUID:(NSString *)UUID{
    if (!self.myService.characteristics) {
        BLELog(@"无特征值");
        return NO;
    }
    
    for (CBCharacteristic *characteristic in self.myService.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID]]) {
            
            NSMutableString * mStr = @"".mutableCopy;
            
            for (NSString * hexStr in dataArr) {
                [mStr appendString:hexStr];
            }
            
            NSMutableData *data = [TDD_HBLETools convertHexStrToData:mStr].mutableCopy;
            
            const Byte*bytes = [data bytes];
            
            Byte sum =0;

            for(int i = 2;i < data.length;i ++)
            {
            sum^=bytes[i];
            }
            
            [data appendData:[NSData dataWithBytes:&sum length:1]];
            BLELog(@"\nsend:\nUUID:%@\nData:%@", UUID,data);
            [self.discoveredPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
            
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)sendData:(NSData *)data{
    if (!self.myService.characteristics) {
        BLELog(@"无特征值");
        return NO;
    }
    
    for (CBCharacteristic *characteristic in self.myService.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEWriteUUID]]) {
            BLELog(@"\nsend:\nUUID:%@\nData:%@", BLEWriteUUID,data);
            [self.discoveredPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//            [self.discoveredPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            
            return YES;
        }
    }
    
    return NO;
}

#pragma mark 读UUID的值
- (void)readValueWithUUID:(NSString *)UUID{
    for (CBCharacteristic *characteristic in self.myService.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID]]) {
            [self.discoveredPeripheral readValueForCharacteristic:characteristic];
        }
    }
}

#pragma mark 扫描外设备
//通过制定的128的UUID，扫描外设备
-(void)scan{
    
//    if (_centralManager.state != CBManagerStatePoweredOn) {
//        BLELog(@"蓝牙未打开,请在设置中打开蓝牙");
//
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"The bluetooth is shut down" message:@"Please turn it on in the setting" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//        [[NSNotificationCenter defaultCenter] postNotificationName:HDidDisconnectPeripheral object:self userInfo:nil];
//        return;
//    }
    
    //    [centralManager scanForPeripheralsWithServices:[[NSArray alloc] initWithObjects:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID], nil] options:[[NSDictionary alloc] initWithObjectsAndKeys:@true,CBCentralManagerScanOptionAllowDuplicatesKey, nil]];
    
    //扫描所有的  这个参数应该也是可以指定特定的peripheral的UUID,那么理论上这个central只会discover这个特定的设备
//    NSArray *uuidArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID],nil];
    [_peripheralArr removeAllObjects];
    
    //不重复扫描已发现设备
    //CBCentralManagerScanOptionAllowDuplicatesKey设置为NO表示不重复扫瞄已发现设备，为YES就是允许。
    //CBCentralManagerOptionShowPowerAlertKey设置为YES就是在蓝牙未打开的时候显示弹框
    
    [_centralManager scanForPeripheralsWithServices:nil options:self.option];
        
    
    BLELog(@"开始扫描");
    
}

#pragma mark 停止扫描外设备
-(void)stop{
    [_centralManager stopScan];
    [_peripheralArr removeAllObjects];
    BLELog(@"停止扫描");
}

#pragma mark 断开设备
-(void)cancelConnect {
    //主动断开设备
    BLELog(@"主动断开设备:%@", _discoveredPeripheral);
    if (_discoveredPeripheral) {
        [_centralManager cancelPeripheralConnection:_discoveredPeripheral];
    }
}

#pragma mark 彻底断开设备
- (void)radicalCancelConnect{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:HBLEUUID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BLELog(@"彻底断开设备:%@", _discoveredPeripheral);
    if (_discoveredPeripheral) {
        [_centralManager cancelPeripheralConnection:_discoveredPeripheral];
    }
}

- (void)startDeviceReset{
    self.isDeviceReset = YES;
    
    [self performSelector:@selector(stopDeviceReset) withObject:nil afterDelay:12];
}

- (void)stopDeviceReset{
    self.isDeviceReset = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopDeviceReset) object:nil];
}

#pragma mark - 懒加载
- (NSMutableArray *)peripheralArr{
    if (!_peripheralArr) {
        _peripheralArr = [[NSMutableArray alloc] init];
        
    }
    return _peripheralArr;
}

- (NSString *)writeUUID
{
    NSString * UUID = @"00010203-0405-0607-0809-0A0B0C0D2B11";
    
    return UUID;
}

- (NSString *)readUUID
{
    NSString * UUID = @"00010203-0405-0607-0809-0A0B0C0D2B10";
    
    return UUID;
}

- (NSString *)serviceUUID
{
    NSString * UUID = @"00010203-0405-0607-0809-0A0B0C0D1910";
    
    return UUID;
}

@end

