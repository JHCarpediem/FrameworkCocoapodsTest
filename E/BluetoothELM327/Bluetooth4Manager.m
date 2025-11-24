//
//  Bluetooth4Manager.m
//  ELM327Test
//
//  Created by songlei on 2017/11/22.
//  Copyright © 2017年 songlei. All rights reserved.
//

#import "Bluetooth4Manager.h"
#import "Diagnosis.h"

@interface Bluetooth4Manager()

@property (nonatomic, retain) NSData *myData;
@property (nonatomic, retain) NSTimer *connectTimer;   ////超时取消

@end


@implementation Bluetooth4Manager

- (instancetype)init{
    self = [super init];
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    self.peripheralArray = [NSMutableArray arrayWithCapacity:0];
    self.peripheralsArrCopy = [NSMutableArray arrayWithCapacity:0];
    self.servicesArr = [NSMutableArray arrayWithCapacity:0];
    self.activeService = nil;
    self.activePeripheral = nil;
    self.dataWriteCharateristic = nil;
    self.dataNotifyCharateristic = nil;
    return self;
}

//判断 蓝牙是否开启
- (BOOL)isLECapableHardware
{
    int state = (int)[self.centralManager state];
    NSLog(@"Central manager state: %i", state);
    if (state == CBManagerStatePoweredOn) {
        return YES;
    }
    return NO;
}

#pragma mark- xlz 发送数据 和 接收数据
- (void)sendData:(NSData *)data receiveBlock:(ReceiveDataBlock)receBlock
{
    [super sendData:data receiveBlock:receBlock];
    if (self.activePeripheral != nil && self.dataWriteCharateristic != nil) {
        [self.activePeripheral writeValue:data forCharacteristic:self.dataWriteCharateristic type:self.writeType];
    }
}

#pragma mark - ---扫描 链接
- (void)startScanPeripherals{
    if (self.centralManager) {
        [self.peripheralArray removeAllObjects];
        [self.peripheralsArrCopy removeAllObjects];
        [self.centralManager scanForPeripheralsWithServices:nil options:0];
    }
}

- (void)stopScanPeripherals{
    [self.centralManager stopScan];
    sleep(0.2);
}

- (void)connectTimeout{
    if (self.activePeripheral) {
        [self.centralManager cancelPeripheralConnection:self.activePeripheral];
    }
    self.activePeripheral = nil;
    self.activeService = nil;
    [self.peripheralArray removeAllObjects];
}

- (void)disconnect
{
    [self disconnectPeripheral];
}

- (void)disconnectPeripheral{
    if (self.activePeripheral) {
        [self.centralManager cancelPeripheralConnection:self.activePeripheral];
    }
}

- (void)connectPeripheralWithIndex:(NSInteger)index{
    [Diagnosis shareServicesManager].connectStatus = 1;
    if (self.peripheralArray.count > 0) {
        self.activePeripheral = [self.peripheralArray objectAtIndex:index];
        self.activePeripheral.delegate = self;
        
        [self.centralManager connectPeripheral:self.activePeripheral options:nil];
    }
}

- (void)connectBluetooth:(CBPeripheral *)peripheral{
    
    if (peripheral) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopScanPeripherals];
            [self.centralManager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES),CBConnectPeripheralOptionNotifyOnNotificationKey:@(YES)}];
            peripheral.delegate = self;
        });
    }
}

#pragma mark- xlz bluetooth delegate datasource

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBManagerStateUnknown:
//            NSLog(@"Central manager state unknown");
            break;
        case CBManagerStateUnsupported:
//            NSLog(@"Central manager state unsupported");
            break;
        case CBManagerStateUnauthorized:
//            NSLog(@"Central manager state unauthorized");
            break;
        case CBManagerStateResetting:
//            NSLog(@"Central manager state resetting");
            break;
        case CBManagerStatePoweredOff:
//            NSLog(@"Central manager state power off");
            break;
        case CBManagerStatePoweredOn:{
//            [_centralManager scanForPeripheralsWithServices:nil options:nil];
        }
//            NSLog(@"Central manager state power on");
            break;
        default:
            break;
    }
//    if (central.state != CBManagerStatePoweredOn || [Diagnosis shareServicesManager].connectStatus != 0) {
//        [Diagnosis shareServicesManager].connectStatus = 0;
//    }
    if ([self.commDelegate respondsToSelector:@selector(bluetooth4GetState:)]) {
        [self.commDelegate bluetooth4GetState:central];
    }
}


 
#pragma mark - CBCentralManagerDelegate 中心设备协议
// 发现了设备 连接
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"peripheral = %@ -- adver = %@",peripheral,advertisementData);
    
    if (!peripheral || !peripheral.name || [peripheral.name isEqualToString:@""]) {
        return;
    }
    int i;
    int j;
    for (i = 0; i < [self.peripheralArray count]; i++) {
        CBPeripheral *tempPeriph = [self.peripheralArray objectAtIndex:i];
        if ([[tempPeriph.identifier UUIDString] isEqualToString:[peripheral.identifier UUIDString]]) {
            break;
        }
    }
    
    for (j = 0; j < [self.peripheralsArrCopy count]; j++) {
        CBPeripheral *tempPeriph = [self.peripheralsArrCopy objectAtIndex:j];
        if ([[tempPeriph.identifier UUIDString] isEqualToString:[peripheral.identifier UUIDString]]) {
            break;
        }
    }
    if (i == [self.peripheralArray count]) {
        [self.peripheralArray addObject:peripheral];
    }
    if (j == [self.peripheralsArrCopy count]) {
        [self.peripheralsArrCopy addObject:peripheral];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bluetooth4DidScanPeripheral" object:self];
    if ([self.scanDelegate respondsToSelector:@selector(bluetooth4DidScanPerpheral)]) {
        [self.scanDelegate bluetooth4DidScanPerpheral];
    }
}

//连接上了设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"didConnectPeripheral");
    if ([self.connectTimer isValid]) {
        [self.connectTimer invalidate];
    }
    
    self.activePeripheral = peripheral;
    [self.activePeripheral discoverServices:nil];
    if (self.connectStatus) {
        self.connectStatus(YES, self);
    }
    self.isConnected = YES;
    if ([self.commDelegate respondsToSelector:@selector(bluetooth4DidConnect)]) {
        [self.commDelegate bluetooth4DidConnect];
    }
}

//断开了连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"didDisconnectPeripheral");
    if ([self.connectTimer isValid]) {
        [self.connectTimer invalidate];
    }
    
    self.activePeripheral = nil;
    self.activeService = nil;
    
    self.isConnected = NO;
    if ([self.commDelegate respondsToSelector:@selector(bluetooth4DidConnectFailed)]) {
        [self.commDelegate bluetooth4DidConnectFailed];
    }
    if (self.connectStatus) {
        self.connectStatus(NO, self);
    }
    if ([self.scanDelegate respondsToSelector:@selector(bluetooth4DidDisconnectPeripheral)]) {
        [self.scanDelegate bluetooth4DidDisconnectPeripheral];
    }
    if (([Diagnosis shareServicesManager].connectStatus = 0)) {
        return;
    }
}

//连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"didFailToConnectPeripheral");
    self.activePeripheral = nil;
    self.activeService = nil;
    [self.peripheralArray removeAllObjects];
    
    if (self.connectStatus) {
        self.connectStatus(NO, self);
    }
    if (([Diagnosis shareServicesManager].connectStatus = 0)) {
        return;
    }
}

#pragma mark - 扫描service CBPeripheralDelegate  外设协议
//发现外设服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"Services 服务UUID== > %@",peripheral.services);
    if (!error) {
        for (int i=0; i<peripheral.services.count; i++) {
            CBService *service = [peripheral.services objectAtIndex:i];
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
    if ([self.scanDelegate respondsToSelector:@selector(bluetooth4DidScanService:)]) {
        [self.scanDelegate bluetooth4DidScanService:YES];
    }
}

///发现外设 服务特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"Characteristics == > %@",peripheral.services);
    
    if (!error) {
        //        if ([service.UUID.UUIDString isEqualToString:@"FFF0"]) {
        for (int j = 0; j < service.characteristics.count; j++) {
            CBCharacteristic *characteritic = [service.characteristics objectAtIndex:j];
            if ((characteritic.properties == CBCharacteristicPropertyWriteWithoutResponse) || (characteritic.properties == CBCharacteristicPropertyWrite)) {
                if ([[[characteritic UUID] UUIDString] isEqualToString:@"FFF0"]) {
                    self.dataWriteCharateristic = characteritic;
                }
                
                [self.activePeripheral setNotifyValue:YES forCharacteristic:characteritic];
                if (characteritic.properties & CBCharacteristicPropertyWrite) {
                    self.writeType = CBCharacteristicWriteWithResponse;
                }else {
                    self.writeType = CBCharacteristicWriteWithoutResponse;
                }
                
            } else if (characteritic.properties == CBCharacteristicPropertyNotify){
                self.dataNotifyCharateristic = characteritic;
                [self.activePeripheral setNotifyValue:YES forCharacteristic:self.dataNotifyCharateristic];
            }else {
                
                self.dataWriteCharateristic = characteritic;
                [self.activePeripheral setNotifyValue:YES forCharacteristic:self.dataWriteCharateristic];
            }
        }
        //        }
    }
    if (self.scanDelegate && [self.scanDelegate respondsToSelector:@selector(bluetooth4DidSacnCharateristic:)]) {
        [self.scanDelegate bluetooth4DidSacnCharateristic:error ? NO : YES];
    }
}

////收到外设发来数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    [self didReceiveData:characteristic.value withError:error];
    NSLog(@"value:%@",[[NSString alloc] initWithData:characteristic.value encoding:NSASCIIStringEncoding]);
    
}

//// 接收到数据写入结果的回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
//    NSLog(@"didWriteValueForCharacteristic:%@",error.description);
    if (error) {
        if (self.readWriteTimeout) {
            self.readWriteTimeout(NO, YES);
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    NSLog(@"didUpdateNotificationStateForCharacteristic:%@",error.description);
    if (error) {
        if (self.readWriteTimeout) {
            self.readWriteTimeout(YES, NO);
        }
    }
}





@end

