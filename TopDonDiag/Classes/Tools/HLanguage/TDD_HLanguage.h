//
//  TDD_HLanguage.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import "TDD_CarModel.h"
//#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>
typedef NS_ENUM(NSInteger, TDDHLanguageType);
NS_ASSUME_NONNULL_BEGIN

//语言改变通知
FOUNDATION_EXPORT NSString * const HAppLanguageDidChangeNotification;

@interface TDD_HLanguage : NSObject

+ (void)setLanguage:(TDDHLanguageType)languageType;
/**
 重置系统语言
 */
+ (void)resetSystemLanguage;

///获取当前语言
+ (NSString *)getLanguage;

//获取语言
+ (NSString *)getLanguage:(NSString *)str;

///获取所有支持的语言数组
+ (NSArray *)getAllLanguage;

/// 获取当前语言对应服务器语言id
+ (NSInteger)getServiceLanguageId;

/// 获取当前语言对应服务器语言 code
+ (NSString *)getServerLanguageShortCode;

/// 根据当前语言返回进入诊断传入语言字符串
+ (NSString *)entryDiagLanguage;

+ (NSString *)entryDiagLanguageWithCarModel:(TDD_CarModel *)carModel;

+ (NSDictionary *)getCarAllLanguageFileName;
@end

NS_ASSUME_NONNULL_END
