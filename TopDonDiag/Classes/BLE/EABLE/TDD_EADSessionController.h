/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Provides an interface for communication with an EASession. Also the delegate for the EASession input and output stream objects.
 */
#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "TDD_VCIInitializeModel.h"
//@import Foundation;
//@import ExternalAccessory;

extern NSString *EADSessionDataReceivedNotification;

// NOTE: TDD_EADSessionController is not threadsafe, calling methods from different threads will lead to unpredictable results
@interface TDD_EADSessionController : NSObject <EAAccessoryDelegate, NSStreamDelegate>

+ (TDD_EADSessionController *)sharedController;

- (void)setupControllerForAccessory:(EAAccessory *)accessory withProtocolString:(NSString *)protocolString;

- (BOOL)openSession;
- (void)closeSession;

- (NSInteger)writeData:(NSData *)data;

- (NSUInteger)readBytesAvailable;
- (NSData *)readData:(NSUInteger)bytesToRead;

@property (nonatomic, readonly) EAAccessory *accessory;
@property (nonatomic, strong) EASession *session;
@property (nonatomic, readonly) NSString *protocolString;
@property (nonatomic, strong) NSMutableArray *accessoryList;

@property (nonatomic, assign) float BatteryVolt;
@property (nonatomic, assign) BOOL VciStatus;
@property (nonatomic, strong) NSString * SN;//mfiSN 或者stdSN
@property (nonatomic, assign) BOOL canEventBLEError;
@property (nonatomic, assign) BOOL isArtiDiag; //是否在诊断中
@property (nonatomic, assign) BOOL noMoreShowBatteryVoltLowTip; //不在提醒电压过低弹窗
@property (nonatomic, strong) NSData *closeData;//不通讯返回-1
@property (nonatomic, readonly) TDD_VCIInitializeModel *vciInitModel;
#pragma mark -- 埋点使用
/// 是否连接过设备
@property (nonatomic, assign) BOOL isPreviousConnected;

/// 是否连接过设备后再断开
@property (nonatomic, assign) BOOL isPreviousConnectedToDisconnected;

@end
