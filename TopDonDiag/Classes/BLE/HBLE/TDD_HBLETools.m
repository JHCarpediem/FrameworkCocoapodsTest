//
//  TDD_HBLETools.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/5/27.
//

#import "TDD_HBLETools.h"

@implementation TDD_HBLETools
#pragma mark string转data
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return [[NSData alloc] init];
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

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

#pragma mark 10进制转16进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}

#pragma mark 10进制转16进制不足补零
+ (NSString *)getHexByDecimal:(NSInteger)decimal WithLength:(NSUInteger)length{
    NSString * hexStr = [self getHexByDecimal:decimal];//需要补零
    
    if (hexStr.length < length) {
        for (int i = 0; i < hexStr.length - length; i ++) {
            hexStr = [NSString stringWithFormat:@"0%@", hexStr];
        }
    }else if (hexStr.length > length){
        hexStr = [hexStr substringToIndex:length];
    }
    
    return hexStr;
}

#pragma mark 16进制转10进制数组
+ (NSArray *)dealData:(NSString *)hexString WithDigits:(int)digits{
    //ff01取8位，别的取4位
    
    NSMutableArray * marr = @[].mutableCopy;
    
    for (int i = 0; i < hexString.length / digits; i ++) {
        //取n位数
        NSString * str = [hexString substringWithRange:NSMakeRange(i * digits, digits)];
        
        //前后交换
        NSMutableString * mstr = @"".mutableCopy;
        for (int i = 0; i < digits / 2; i ++) {
            [mstr appendString:[str substringWithRange:NSMakeRange(digits - (i + 1) * 2, 2)]];
        }
        
        //16进制转10进制
        str = [NSString stringWithFormat:@"%lu",strtoul([mstr UTF8String],0,16)];
        
        [marr addObject:@(str.intValue)];
    }
    
    return marr;
}

#pragma mark data转换为十六进制的。
+ (NSString *)hexStringFromData:(NSData *)myD{
    
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

#pragma mark 字符串转成ascii字符串
+ (NSString *)stringToAsci:(NSString *)string {
    NSMutableString *mustring = [[NSMutableString alloc]init];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char *ch = [string cStringUsingEncoding:enc];
    for (int i = 0; i < strlen(ch); i++) {
        [mustring appendString:[NSString stringWithFormat:@"%x",ch[i]]];
    }
    return mustring;
}

#pragma mark ascii字符串转成字符串
+ (NSString *)asciToString:(NSString *)string {
    NSData * data = [self hexToBytes:string];
    
    NSString *ssid = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ssid;
}

+ (NSData *)hexToBytes:(NSString *)dataStr {
    NSMutableData * data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= dataStr.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString * hexStr = [dataStr substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

@end
