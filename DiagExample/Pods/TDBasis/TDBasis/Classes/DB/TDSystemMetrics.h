//
//  TDSystemMetrics.h
//  TDBasis
//
//  Created by fench on 2024/1/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDSystemMetrics : NSObject

+ (NSString *)cpuUsage;

+ (CGFloat)appCpuUsage;

@end

NS_ASSUME_NONNULL_END
