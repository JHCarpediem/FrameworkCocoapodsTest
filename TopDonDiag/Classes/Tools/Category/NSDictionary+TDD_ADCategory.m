//
//  NSDictionary+TDASCategory.m
//  Supplement
//
//  Created by Kowloon on 12-4-17.
//  Copyright (c) 2012年 Goome. All rights reserved.
//

#import "NSDictionary+TDD_ADCategory.h"

static NSString * PercentEscapedQueryStringPairMemberFromStringWithEncoding(NSString *string)
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

@implementation NSDictionary (ASCategory)

- (id)tdd_objectForTreeStyleKey:(NSString*)key
{
    NSArray *keys = [key componentsSeparatedByString:@"/"];
    NSDictionary *dictionary = [self copy];
    NSInteger count = [keys count];
    for (NSInteger n = 0; n < count - 1; n ++) {
        dictionary = [dictionary objectForKey:[keys objectAtIndex:n]];
    }
    return [dictionary objectForKey:[keys objectAtIndex:count - 1]];
}

- (BOOL)tdd_getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (NSInteger)tdd_getIntValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] integerValue];
}

- (time_t)tdd_getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
    NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}

- (double)tdd_getDoubleValueForKey:(NSString *)key defaultValue:(double)defaultValue{
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] doubleValue];
}

- (long long)tdd_getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)tdd_getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    if ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) {
        return defaultValue;
    } else if ([[self objectForKey:key] isKindOfClass:[NSNumber class]]) {
        return [[self objectForKey:key] stringValue];
    }
    return [self objectForKey:key];
}

- (NSDate *)tdd_getDateValueForKey:(NSString *)key defaultValue:(NSDate *)defaultValue{
    if ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) {
        return defaultValue;
    }else {
        return [NSDate dateWithTimeIntervalSince1970:[[self objectForKey:key] doubleValue]/1000];
    }
}

- (NSArray *)tdd_getArrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue{
    NSArray *value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSArray class]]) {
        return value;
    }
    
    return defaultValue;
}


- (NSString*)tdd_kp_description{
    NSString *desc = [self description];
    NSString *encode = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
//    NSString *encode = [[NSString alloc] initWithData:[desc dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] encoding:NSNonLossyASCIIStringEncoding];
    
    if (!encode) {
        encode = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSWindowsCP1251StringEncoding];
    }
    return encode ? encode : desc;
}

+ (NSDictionary *)tdd_nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self tdd_changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

+ (NSArray *)tdd_nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self tdd_changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

+ (NSString *)tdd_stringToString:(NSString *)string
{
    return string;
}

+ (NSString *)tdd_nullToString
{
    return @"";
}

#pragma mark - 公有方法
+ (id)tdd_changeType:(id)myObj{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self tdd_nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self tdd_nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self tdd_stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self tdd_nullToString];
    }
    else
    {
        return myObj;
    }
}

@end
