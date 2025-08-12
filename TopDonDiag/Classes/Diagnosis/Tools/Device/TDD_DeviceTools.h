//
//  TDD_DeviceTools.h
//  AD200
//
//  Created by tangjilin on 2022/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_DeviceTools : NSObject

/// 系统版本
+ (NSString *)getSystemVersion;

/// 获取设备型号
+ (NSString *)getTDD_DeviceModel;

/// 获取项目版本号
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
