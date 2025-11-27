//
//  Copyright (c) diag. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBBTLEWriteCharacteristicStream : NSOutputStream <NSStreamDelegate>

-(nullable instancetype)initToCharacteristic:(CBCharacteristic*)characteristic;
-(void)characteristicDidWriteValue;

@end

NS_ASSUME_NONNULL_END
