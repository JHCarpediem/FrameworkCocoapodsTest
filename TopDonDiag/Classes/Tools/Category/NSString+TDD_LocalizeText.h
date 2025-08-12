//
//  NSString+TDD_LocalizeText.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TDD_LocalizeText)


#pragma mark - 不同app文案
+ (NSString *)tdd_reportTitleUser;
+ (NSString *)tdd_reportTitleUserPhone;
+ (NSString *)tdd_reportTitleDistance;
+ (NSString *)tdd_reportTitleSystemHead;
+ (NSString *)tdd_reportTitleLiveDataHead;
+ (NSString *)tdd_reportTitleDiagnosed;
+ (NSString *)tdd_reportTitleVIN;
+ (NSString *)tdd_reportTitleNoDTC;
@end

NS_ASSUME_NONNULL_END
