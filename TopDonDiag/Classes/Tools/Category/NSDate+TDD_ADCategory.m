//
//  NSDate+TDD_ADCategory.m
//  TDDiag
//
//  Created by lk_ios2023002 on 2023/5/16.
//

#import "NSDate+TDD_ADCategory.h"

@implementation NSDate (TDD_ADCategory)
#pragma mark 获取时间
+ (NSString *)tdd_convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];

    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];

    return string;
}

+ (NSTimeInterval)tdd_getTimestampSince1970
{
    NSDate *datenow = [NSDate date];//现在时间

    NSTimeInterval interval = [datenow timeIntervalSince1970];//13位的*1000

    return interval;
}

+ (NSString *)tdd_getTimeStringWithInterval:(NSTimeInterval)interval Format:(NSString *)format{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:format];
    
    formatter.locale = [NSLocale systemLocale];
    
    NSString *str = [formatter stringFromDate:date];
    
    return str;
}

+ (NSString *)tdd_currentDateFromZeroTimeZone:(NSString *)time {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *currentTime = [formatter stringFromDate:date];

    return currentTime;
}

/*
 * This guy can be a little unreliable and produce unexpected results,
 * you're better off using daysAgoAgainstMidnight
 */

- (NSString *)tdd_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSString *)tdd_getTopdonTimeZone
{
    NSInteger sec = [NSTimeZone localTimeZone].secondsFromGMT;
    NSString *res = @"E+8";
    NSString *symbol = @"E";
    NSInteger value = 0;
    if (sec < 0) {
        symbol = @"W";
    } else {
        symbol = @"E";
    }
    value = sec / (60 * 60);
    res = [NSString stringWithFormat:@"%@+%ld", symbol, value];
    return res;
}

+ (NSString *)tdd_getWebSocketTimeZone
{
    NSInteger sec = [NSTimeZone localTimeZone].secondsFromGMT;
    NSString *res = @"UTC+8";
    NSString *symbol = @"UTC";
    NSInteger value = 0;
    if (sec < 0) {
        symbol = @"-";
    } else {
        symbol = @"+";
    }
    value = sec / (60 * 60);
    res = [NSString stringWithFormat:@"UTC%@%ld", symbol, value];
    return res;
}

@end
