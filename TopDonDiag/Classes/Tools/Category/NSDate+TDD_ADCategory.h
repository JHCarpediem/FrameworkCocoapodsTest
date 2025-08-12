//
//  NSDate+TDD_ADCategory.h
//  TDDiag
//
//  Created by lk_ios2023002 on 2023/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TDD_ADCategory)
#pragma mark 获取时间
+ (NSString *)tdd_convertDataToHexStr:(NSData *)data;

/// 获取时间
+ (NSTimeInterval)tdd_getTimestampSince1970;

/// 时间格式化
/// @param interval 时间戳
/// @param format 时间格式
+ (NSString *)tdd_getTimeStringWithInterval:(NSTimeInterval)interval Format:(NSString *)format;

- (NSString *)tdd_stringWithFormat:(NSString *)format;

+ (NSString *)tdd_currentDateFromZeroTimeZone:(NSString *)time;

+ (NSString *)tdd_getTopdonTimeZone;

+ (NSString *)tdd_getWebSocketTimeZone;
@end

NS_ASSUME_NONNULL_END
