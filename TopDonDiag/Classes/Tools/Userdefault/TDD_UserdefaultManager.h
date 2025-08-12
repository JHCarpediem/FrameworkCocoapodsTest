//
//  TDD_UserdefaultManager.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#pragma mark - NSUserdefaultKey
///翻译时间段(开始)
#define  KTDDUDTranslateStartTime         @"KTDDUDTranslateStartTime"
///翻译次数
#define  KTDDUDTranslateCount        @"KTDDUDTranslateCount"
///翻译字符量(成功)
#define  KTDDUDTranslateChartNum         @"KTDDUDTranslateChartNum"

///auth account
#define  KTDDUDAUTHAccount          @"KTDDUDAUTHAccount"
///auth area
#define  KTDDUDAUTHArea             @"KTDDUDAUTHArea"

///FCA account
#define  KTDDUDFCAAccount           @"KTDDUDFCAAccount"
///FCA area
#define  KTDDUDFCAArea              @"KTDDUDFCAArea"

@interface TDD_UserdefaultManager : NSObject

#pragma mark 翻译统计相关
///翻译时间段(开始)
+ (NSString *)getTranslateStartTime;
+ (void)setTranslateStartTime:(NSString *)str;
///翻译次数
+ (NSInteger )getTranslateCount;
+ (void)setTranslateCount:(NSInteger )count;
///翻译字符量(成功的原字符)
+ (NSInteger )getTranslateChartNum;
+ (void)setTranslateChartNum:(NSInteger )count;

///清空翻译统计
+ (void )resetTranslate;

#pragma mark 网关解锁
+ (NSString *)getAuthAccount:(NSInteger)type;
+ (NSString *)getAuthAccount:(NSInteger)type unlockType:(NSInteger)unlockType;
+ (void)setAuthAccount:(NSString *)account type:(NSInteger)type;
+ (void)setAuthAccount:(NSString *)account type:(NSInteger)type unlockType:(NSInteger)unlockType;

+ (NSInteger )getAuthArea:(NSInteger)type;
+ (NSInteger )getAuthArea:(NSInteger)type unlockType:(NSInteger)unlockType;
+ (void)setAuthArea:(NSInteger )area type:(NSInteger)type;
+ (void)setAuthArea:(NSInteger )area type:(NSInteger)type unlockType:(NSInteger)unlockType;
@end

NS_ASSUME_NONNULL_END
