//
//  TDD_HMBLECenterHandle.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/3/12.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>
#import "TDD_DeviceModel.h"


//蓝牙
#define HDidDiscoverPeripheral @"HDidDiscoverPeripheral" //找到设备
#define HDidConnectPeripheral @"HDidConnectPeripheral" //已经连接
#define HDidDisconnectPeripheral @"HDidDisconnectPeripheral" //连接断开
#define HBLEDidDiscoverServices @"HBLEDidDiscoverServices"//已发现服务
#define HBLEDidUpdateState @"HBLEDidUpdateState"//蓝牙状态更新
#define HDidConnectPeripheralTimeOut @"HDidConnectPeripheralTimeOut" //连接超时

#define BLEWriteUUID [TDD_HMBLECenterHandle sharedHMBLECenterHandle].writeUUID

#define BLEReadUUID [TDD_HMBLECenterHandle sharedHMBLECenterHandle].readUUID

#define HBLEManager [TDD_HMBLECenterHandle sharedHMBLECenterHandle]

#define HBLEDidUpdateValueForUUID @"HBLEDidUpdateValueForUUID"

@protocol HBLECenterDelegate <NSObject>

- (void)didUpdateValueForUUID:(NSString *)UUID withHexString:(NSString *)hexString;

@end

@interface TDD_HMBLECenterHandle : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,strong)CBCentralManager *centralManager;
@property (nonatomic,strong)CBPeripheral *discoveredPeripheral;
@property (nonatomic,assign)BOOL isConnect;
@property (nonatomic, assign) BOOL isDeviceReset;
@property (nonatomic,strong)NSMutableArray *peripheralArr;
@property (nonatomic, weak) id<HBLECenterDelegate>delegate;

@property (nonatomic,copy)NSString * writeUUID;//写入的UUID
@property (nonatomic,copy)NSString * readUUID;//读取的UUID

@property (nonatomic, assign) int deviceType; //0、通用设备

@property (nonatomic,strong) TDD_DeviceModel * deviceModel;

+(TDD_HMBLECenterHandle *)sharedHMBLECenterHandle;

-(void)scan;
-(void)stop;
-(void)cancelConnect;
- (void)radicalCancelConnect; //彻底断开设备

- (BOOL)sendData:(NSArray *)dataStr WithUUID:(NSString *)UUID;
- (BOOL)sendhexData:(NSArray *)dataArr WithUUID:(NSString *)UUID;
- (BOOL)sendData:(NSData *)data;

- (void)readValueWithUUID:(NSString *)UUID;
- (void)ConnectedDevicesWithPeripheral:(CBPeripheral *)peripheral;

- (void)startDeviceReset;
- (void)stopDeviceReset;
@end
