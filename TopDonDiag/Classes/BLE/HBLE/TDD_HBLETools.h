//
//  TDD_HBLETools.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/5/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_HBLETools : NSObject

///string转data
+ (NSData *)convertHexStrToData:(NSString *)str;

///data转string
+ (NSString *)tdd_convertDataToHexStr:(NSData *)data;

///10进制转16进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal;

///10进制转16进制不足补零
+ (NSString *)getHexByDecimal:(NSInteger)decimal WithLength:(NSUInteger)length;

///16进制转10进制数组
+ (NSArray *)dealData:(NSString *)hexString WithDigits:(int)digits;

///data转换为十六进制的。
+ (NSString *)hexStringFromData:(NSData *)myD;

///字符串转成ascii字符串
+ (NSString *)stringToAsci:(NSString *)string;

///ascii字符串转成字符串
+ (NSString *)asciToString:(NSString *)string;

/////BTNationN32获取电压model
//+ (NSArray *)BleDataMagageBTNationN32GetVoltageWithData:(NSString *)data;
@end

NS_ASSUME_NONNULL_END
