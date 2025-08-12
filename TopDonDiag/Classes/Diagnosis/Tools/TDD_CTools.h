//
//  TDD_CTools.h
//  AD200
//
//  Created by 何可人 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#include <vector>
#include <string>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_CTools : NSObject

#pragma mark C++字符串 -> OC字符串
/// C++字符串 -> OC字符串
/// @param cStr c++字符串
+ (NSString *)CStrToNSString:(const std::string&)cStr;

#pragma mark OC字符串 -> C++字符串
/// OC字符串 -> C++字符串
/// @param str OC字符串
+ (const std::string)NSStringToCStr:(NSString *)str;

#pragma mark int16类型OC数组 -> C++数组
/// int16类型OC数组 -> C++数组
/// @param arr OC数组
+ (std::vector<uint16_t>)NSArrayToInt16CVector:(NSArray *)arr;

#pragma mark int32类型OC数组 -> C++数组
/// int32类型OC数组 -> C++数组
/// @param arr OC数组
+ (std::vector<uint32_t>)NSArrayToInt32CVector:(NSArray *)arr;

#pragma mark int32类型OC数组 -> C++ bool数组
/// int32类型OC数组 -> C++ bool数组
/// @param arr OC数组
+ (std::vector<bool>)NSArrayToBoolCVector:(NSArray *)arr;

#pragma mark int类型C++数组 -> OC数组
/// int类型C++数组 -> OC数组
/// @param cArr c++数组
+ (NSArray *)CVectorToIntNSArray:(const std::vector<int32_t>&)cArr;

#pragma mark uint16类型C++数组 -> OC数组
/// int类型C++数组 -> OC数组
/// @param cArr c++数组
+ (NSArray *)CUInt16VectorToIntNSArray:(const std::vector<uint16_t>&)cArr;

#pragma mark uint32类型C++数组 -> OC数组
/// int类型C++数组 -> OC数组
/// @param cArr c++数组
+ (NSArray *)CUInt32VectorToIntNSArray:(const std::vector<uint32_t>&)cArr;

#pragma mark 字符串类型C++数组 -> OC数组
/// 字符串类型C++数组 -> OC数组
/// @param cArr c++数组
+ (NSArray *)CVectorToStringNSArray:(const std::vector<std::string>&)cArr;

#pragma mark 字符串类型OC数组 -> C++数组
+ (std::vector<std::string>)NSArrayToStringCVector:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
