//
//  Copyright (c) diag. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBBTLEReadCharacteristicStream : NSInputStream <NSStreamDelegate>

-(nullable instancetype)initWithCharacteristic:(CBCharacteristic*)characteristic;
-(void)characteristicDidUpdateValue;

@end

NS_ASSUME_NONNULL_END
