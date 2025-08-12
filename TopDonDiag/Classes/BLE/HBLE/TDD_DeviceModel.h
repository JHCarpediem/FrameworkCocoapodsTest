//
//  TDD_DeviceModel.h
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_DeviceModel : NSObject
@property (nonatomic, strong) NSString * MAC;
@property (nonatomic, strong) CBPeripheral * peripheral;

@end

NS_ASSUME_NONNULL_END
