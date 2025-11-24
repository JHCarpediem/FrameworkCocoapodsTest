//
//  CommBox.m
//  Topdon
//
//  Created by songlei on 2017/11/29.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "CommBox.h"
#import "ReceiveDataModel.h"

@implementation CommBox

- (void)sendReceive_elm327:(NSString *)string receiveBlock:(ReceiveDataBlock)receiveBlock
{
    self.connector.sendStringData = string;
    char endChar = 0x0D;
    NSMutableData *sendData = [NSMutableData dataWithBytes:[string UTF8String] length:[string length]];
    [sendData appendBytes:&endChar length:1];
    [self.connector sendData:sendData receiveBlock:receiveBlock];
}

- (void)sendReceive_CheMi:(NSString *)string receiveBlock:(ReceiveDataBlock)receiveBlock
{
    self.connector.sendStringData = string;
    /// 1.将string转化成车米的数据格式
    NSString *number = @"05";
    NSString *len = StringFrom10Hex((int)string.length/2);
    NSMutableString *cmd = [NSMutableString stringWithFormat:@"55%@%@%@", number, len, string];
    [cmd appendString:[self endBSBPacket:cmd]];
    NSData *sendData = [[NSData alloc] initWithBytes:[cmd UTF8String] length:string.length];
    /// 2.发送数据
    [self.connector sendData:sendData receiveBlock:receiveBlock];
}

/// 包尾的异或校验
- (NSString *)endBSBPacket:(NSString *)byteStr{
    unsigned char y = 0;
    for (int idx = 0; idx + 2 <= byteStr.length; idx += 2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString *hexStr = [byteStr substringWithRange:range];
        NSScanner *scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        y ^= intValue;
    }
    NSString *res = [NSString stringWithFormat:@"%02x",y];
    // 判断异或码是不是一位，是一位的话就补0
    if (res.length == 1) {
        return [NSString stringWithFormat:@"0%@", res];
    }
    return res;
}

@end
