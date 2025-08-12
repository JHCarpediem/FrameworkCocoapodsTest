//
//  TDD_UserdefaultManager.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/5.
//

#import "TDD_UserdefaultManager.h"

@implementation TDD_UserdefaultManager

#pragma mark 翻译统计相关
///翻译时间段(开始)
+ (NSString *)getTranslateStartTime {
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:KTDDUDTranslateStartTime];
    return str;
}

+ (void)setTranslateStartTime:(NSString *)str {
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:KTDDUDTranslateStartTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

///翻译次数
+ (NSInteger )getTranslateCount {
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:KTDDUDTranslateCount];
    return count;
}

+ (void)setTranslateCount:(NSInteger )count {
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:KTDDUDTranslateCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

///翻译字符量(成功的原字符)
+ (NSInteger )getTranslateChartNum {
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:KTDDUDTranslateChartNum];
    return count;
}

+ (void)setTranslateChartNum:(NSInteger )count {
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:KTDDUDTranslateChartNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

///清空翻译统计
+ (void )resetTranslate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:KTDDUDTranslateStartTime];
    [defaults setInteger:0 forKey:KTDDUDTranslateCount];
    [defaults setInteger:0 forKey:KTDDUDTranslateChartNum];
    [defaults synchronize];
}

#pragma mark 网关解锁
+ (NSString *)getAuthAccount:(NSInteger)type {
    return [TDD_UserdefaultManager getAuthAccount:type unlockType:0];
}

+ (NSString *)getAuthAccount:(NSInteger)type unlockType:(NSInteger)unlockType {
    NSString *str;
    NSString *key;
    if (unlockType > 0) {
        key = [KTDDUDAUTHAccount stringByAppendingFormat:@"_%ld_%ld",type,unlockType];
    }else {
        key = [KTDDUDAUTHAccount stringByAppendingFormat:@"_%ld",type];
    }

    str = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //初版存下来的FCA数据
    if ([NSString tdd_isEmpty:str] && type == 0 && unlockType == 0) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:KTDDUDFCAAccount];
    }

    return str;
    
    
}

+ (void)setAuthAccount:(NSString *)account type:(NSInteger)type {
    [TDD_UserdefaultManager setAuthAccount:account type:type unlockType:0];
}

+ (void)setAuthAccount:(NSString *)account type:(NSInteger)type unlockType:(NSInteger)unlockType {
    NSString *key;
    if (unlockType > 0) {
        key = [KTDDUDAUTHAccount stringByAppendingFormat:@"_%ld_%ld",type,unlockType];
    }else {
        key = [KTDDUDAUTHAccount stringByAppendingFormat:@"_%ld",type];
    }

    [[NSUserDefaults standardUserDefaults] setObject:account forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSInteger )getAuthArea:(NSInteger)type {

    return [TDD_UserdefaultManager getAuthArea:type unlockType:0];
    
}

+ (NSInteger )getAuthArea:(NSInteger)type unlockType:(NSInteger)unlockType {
    
    NSString *key;
    if (unlockType > 0) {
        key = [KTDDUDAUTHArea stringByAppendingFormat:@"_%ld_%ld",type,unlockType];
    }else {
        key = [KTDDUDAUTHArea stringByAppendingFormat:@"_%ld",type];
    }
    NSNumber *countNum =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!countNum) {
        if (type == SST_FUNC_FCA_AUTH && unlockType == 0) {
            return 0;
        }
    }
    NSInteger count = countNum.integerValue;
    if (count == 0) {
        if (type == 0 && unlockType == 1) {
            count = 1;
        }
    }
    return count;
}

+ (void)setAuthArea:(NSInteger )area type:(NSInteger)type {
    [TDD_UserdefaultManager setAuthArea:area type:type unlockType:0];
    
}

+ (void)setAuthArea:(NSInteger )area type:(NSInteger)type unlockType:(NSInteger)unlockType {
    NSString *key;
    if (unlockType > 0) {
        key = [KTDDUDAUTHArea stringByAppendingFormat:@"_%ld_%ld",type,unlockType];
    }else {
        key = [KTDDUDAUTHArea stringByAppendingFormat:@"_%ld",type];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@(area) forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
