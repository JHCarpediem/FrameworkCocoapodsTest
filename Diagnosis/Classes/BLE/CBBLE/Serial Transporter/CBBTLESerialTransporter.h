//
//  Copyright (c) diag. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const CBBTLESerialTransporterDidUpdateSignalStrength;

typedef void(^CBBTLESerialTransporterConnectionBlock)(NSInputStream* _Nullable inputStream, NSOutputStream* _Nullable outputStream);

@interface CBBTLESerialTransporter : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property(strong,nonatomic,readonly) NSNumber* signalStrength;

+(instancetype)transporterWithIdentifier:(nullable NSUUID*)identifier serviceUUIDs:(NSArray<CBUUID*>*)serviceUUIDs;
-(void)connectWithBlock:(CBBTLESerialTransporterConnectionBlock)block;
-(void)disconnect;

-(void)startUpdatingSignalStrengthWithInterval:(NSTimeInterval)interval;
-(void)stopUpdatingSignalStrength;

@end

NS_ASSUME_NONNULL_END

