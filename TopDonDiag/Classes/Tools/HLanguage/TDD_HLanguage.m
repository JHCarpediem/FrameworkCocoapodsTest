//
//  TDD_HLanguage.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/3/16.
//

#import "TDD_HLanguage.h"

#define STANDARD_USER_DEFAULT  [NSUserDefaults standardUserDefaults]
#define AppleTDDHLanguages  @"AppleTDDHLanguages" //用于保存语言
NSString * const HAppLanguageDidChangeNotification = @"h.topdon.languagedidchange";

@implementation TDD_HLanguage

+ (void)setLanguage:(TDDHLanguageType)languageType
{
    NSString * userLanguage = [TDDHLanguage languageWithType:languageType].localizedGroup;
    //跟随手机系统
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        [self setLanguage:TDDHLanguageTypeEnglish];
        return;
    }
    
    //用户自定义
    [STANDARD_USER_DEFAULT setValue:userLanguage forKey:AppleTDDHLanguages];
    [STANDARD_USER_DEFAULT setValue:@[userLanguage] forKey:@"AppleTDDLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage
{
    [STANDARD_USER_DEFAULT removeObjectForKey:AppleTDDHLanguages];
    [STANDARD_USER_DEFAULT setValue:nil forKey:@"AppleTDDLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}

///获取当前语言
+ (NSString *)getLanguage {
    return [STANDARD_USER_DEFAULT valueForKey:AppleTDDHLanguages];
}

+ (NSString *)getLanguage:(NSString *)str{
    
    NSString * language = [STANDARD_USER_DEFAULT valueForKeyPath:AppleTDDHLanguages];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"TopdonDiagnosis.bundle/%@", language] ofType:@"lproj"];
    
    NSString *string = [[NSBundle bundleWithPath:path] localizedStringForKey:str value:nil table:nil];

    if ([string isEqualToString:str] || string.length == 0) {
        NSString *path = [bundle pathForResource:@"TopdonDiagnosis.bundle/en" ofType:@"lproj"];
        
        string = [[NSBundle bundleWithPath:path] localizedStringForKey:str value:nil table:nil];
    }
    return string;
}

+ (NSArray *)getAllLanguage{
    
    /*
    NSArray * arr = @[
        @"en",
        @"ja-JP",
        @"ru-RU",
        @"de-DE",
        @"pt-PT",
        @"es-ES",
        @"fr-FR",
        @"zh-Hans",
        @"zh-HK",
        @"it-IT",
        @"pl-PL",
        @"ko-KR",
        @"cs-CZ",
        @"uk-UA",
        @"nl-NL",
        @"tr-TR",
        @"da",
        @"nb",
        @"sv",
        @"ar",
        @"sk-SK",
        @"fi-FI",
        @"sr",
        @"hr-HR",
        @"bg-BG",
        @"sv"
    ];
    
    return arr;
     */
    return [TDDHLanguage allSupportLanguageLocalizedGroups];
}

/// 获取当前语言对应服务器语言id
+ (NSInteger)getServiceLanguageId {
    NSString *language = [STANDARD_USER_DEFAULT valueForKey:AppleTDDHLanguages];
    NSArray * languageArr = [TDD_HLanguage getAllLanguage];
    
    if (![languageArr containsObject:language]) {
        language = @"en";
    }
    return [TDDHLanguage languageWithLocalizedGroup:language].serverCode;
}

/// 获取当前语言对应服务器语言 code
+ (NSString *)getServerLanguageShortCode {
    
    NSString *language = [TDD_HLanguage getLanguage];
    NSArray * languageArr = [TDD_HLanguage getAllLanguage];
    
    if (![languageArr containsObject:language]) {
        language = @"en";
    }

    return [TDDHLanguage languageWithLocalizedGroup:language].serverAbbreviation;
}

/// 根据当前语言返回进入诊断传入语言字符串
+ (NSString *)entryDiagLanguage {
    NSString *language = [STANDARD_USER_DEFAULT valueForKey:AppleTDDHLanguages];
    NSArray * languageArr = [TDD_HLanguage getAllLanguage];
    
    if (![languageArr containsObject:language]) {
        language = @"en";
    }
    
    return [TDDHLanguage languageWithLocalizedGroup:language].serverAbbreviation;
}

/// 根据当前语言返回进入诊断传入语言字符串
+ (NSString *)entryDiagLanguageWithCarModel:(TDD_CarModel *)carModel {
    NSString *language = [TDD_HLanguage getLanguage]?:@"en";
    NSArray * languageArr = [TDD_HLanguage getAllLanguage];
    
    if (![languageArr containsObject:language]) {
        language = @"en";
    }
    if (![carModel.languageArr containsObject:language]) {
        return @"EN";
    }
    return [TDDHLanguage languageWithLocalizedGroup:language].serverAbbreviation;
}

+ (NSDictionary *)getCarAllLanguageFileName {
    NSDictionary *dict = TDDHLanguage.allLanguageTypeValue;
    return dict;
}
@end
