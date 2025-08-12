//
//  TDD_CTools.m
//  AD200
//
//  Created by 何可人 on 2022/6/8.
//

#import "TDD_CTools.h"

@implementation TDD_CTools

#pragma mark C++字符串 -> OC字符串
+ (NSString *)CStrToNSString:(const std::string &)cStr
{
    NSString * string = @"";
    @autoreleasepool {
        if (cStr.length() == 0) {
            return @"";
        }
        
        string = [NSString stringWithCString:cStr.c_str() encoding:NSUTF8StringEncoding];
        
        NSString *tempStr = [NSString stringWithCString:cStr.c_str() encoding:[NSString defaultCStringEncoding]];
        
        if (string.length == 0 && tempStr.length != 0) {
            string = [NSString stringWithUTF8String:tempStr.UTF8String];
        }
        
        string = [self adjustString:string];
        
        if (string.length == 0) {
            return @"";
        }
    }
    return string;
}

#pragma mark OC字符串 -> C++字符串
+ (const std::string)NSStringToCStr:(NSString *)str
{
    if (str.length == 0) {
        str = @"";
    }
    
    std::string cStr = std::string([str UTF8String]);
    
    return cStr;
}


#pragma mark int16类型OC数组 -> C++数组
+ (std::vector<uint16_t>)NSArrayToInt16CVector:(NSArray *)arr
{
    std::vector<uint16_t> intVec;
    
    for (int i = 0; i < arr.count; i++) {
        
        intVec.push_back([arr[i] intValue]);
    }
    
    return intVec;
}

#pragma mark int32类型OC数组 -> C++数组
+ (std::vector<uint32_t>)NSArrayToInt32CVector:(NSArray *)arr
{
    std::vector<uint32_t> intVec;
    
    for (int i = 0; i < arr.count; i++) {
        int32_t value;

        [[arr objectAtIndex:i] getValue:&value];
        
        intVec.push_back(value);
    }
    
    return intVec;
}

#pragma mark int32类型OC数组 -> C++ bool 数组
+ (std::vector<bool>)NSArrayToBoolCVector:(NSArray *)arr
{
    std::vector<bool> boolVec;
    
    for (int i = 0; i < arr.count; i++) {
        bool value;
        if ([[arr objectAtIndex:i] isKindOfClass:[NSString class]]) {
            NSString *str = [arr objectAtIndex:i];
            NSNumber *num = @(str.integerValue);
            [num getValue:&value];
        }else {
            [[arr objectAtIndex:i] getValue:&value];
        }
        
        
        boolVec.push_back(value);
    }
    
    return boolVec;
}

#pragma mark int类型C++数组 -> OC数组
+ (NSArray *)CVectorToIntNSArray:(const std::vector<int32_t>&)cArr
{
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < cArr.size(); j++) {

        [nsArray addObject:@(cArr[j])];
    }
    
    return nsArray;
}

+ (NSArray *)CUInt16VectorToIntNSArray:(const std::vector<uint16_t>&)cArr
{
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < cArr.size(); j++) {

        [nsArray addObject:@(cArr[j])];
    }
    
    return nsArray;
    
}

+ (NSArray *)CUInt32VectorToIntNSArray:(const std::vector<uint32_t>&)cArr
{
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < cArr.size(); j++) {

        [nsArray addObject:@(cArr[j])];
    }
    
    return nsArray;
}

#pragma mark 字符串类型C++数组 -> OC数组
+ (NSArray *)CVectorToStringNSArray:(const std::vector<std::string>&)cArr
{
    NSMutableArray *nsArray = [NSMutableArray array];
    
    for (int j = 0; j < cArr.size(); j++) {
        
        [nsArray addObject:[TDD_CTools CStrToNSString:cArr[j]]];
    }
    
    return nsArray;
}

#pragma mark 字符串类型OC数组 -> C++数组
+ (std::vector<std::string>)NSArrayToStringCVector:(NSArray *)arr
{
    std::vector<std::string> strVec;
    
    for (int i = 0; i < arr.count; i++) {
        std::string cStr = [TDD_CTools NSStringToCStr:arr[i]];
        
        strVec.push_back(cStr);
    }
    
    return strVec;
}

#pragma mark 对诊断传输过来的字符串进行处理
+ (NSString *)adjustString:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    
    return str;
}

@end
