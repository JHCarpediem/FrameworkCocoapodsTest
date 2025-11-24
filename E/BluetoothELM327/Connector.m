//
//  Connector.m
//  iOBD2
//
//  Created by xtool.tech on 12-8-3.
//  Copyright (c) 2012年 xtool.tech. All rights reserved.
//

#import "Connector.h"

@interface Connector ()

/** 发送的数据 */
@property (nonatomic, strong) NSData *sendData;

/** 接收的数据 */
@property (nonatomic, strong) NSMutableData *receviceData;

/// 接收到数据的回调， 参数是 ReceviceDataModel 对象
@property (nonatomic, copy) ReceiveDataBlock receiveBlock;

/** 数据接收的总长度 */
@property (nonatomic, assign) int receiveLen;

@end

@implementation Connector

- (void)didReceiveData:(NSData *)receData withError:(NSError *)error
{
    NSData *resultData = nil;
    // 使用不同的方式判断数据有没有接收完毕
    if (self.boxType == BoxTypeCheMi) {
        resultData = [self cheMiData:receData];
    } else if (self.boxType == BoxTypeELM327) {
        resultData = [self elm327Data:receData];
    }
    if (resultData && self.receiveBlock) {
        ReceiveDataModel *receModel = nil;
        switch (self.boxType) {
            case BoxTypeCheMi:
            {
                receModel = [ReceiveDataModel receiveModelWithCheMiData:resultData command:self.sendData];
            }
                break;
            case BoxTypeELM327:
            {
                NSString *cmd = [[[NSString alloc] initWithData:self.sendData encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                
                /*
                NSString *getStr = @"";
                if ([cmd isEqualToString:@"03"]) {
                    getStr = [NSString stringWithFormat:@"30330d3433203030203030203030203030203030203030200d3433203030203030203030203030203030203030200d"];
                }else if ([cmd isEqualToString:@"07"]){
                    /// 0747
                    getStr = [NSString stringWithFormat:@"30370d3437203033203433203030203030203030203030200d"];
//                    getStr = [NSString stringWithFormat:@"30370d3437203030203030203030203030203030203030200d3437203033203433203030203030203030203030200d"];
                }else if ([cmd isEqualToString:@"0a"]) {
                    getStr = [NSString stringWithFormat:@"30410d374620304120313120"];
                }
                NSData *getData = [self stringToByte:getStr];
                receModel = [ReceiveDataModel receiveModelWithELM327Data:getData command:cmd];
                */
                
                
                receModel = [ReceiveDataModel receiveModelWithELM327Data:resultData command:cmd];
                
            }
                break;
            default:
                break;
        }
        self.receiveBlock(receModel, self.boxType);
        self.receviceData = nil;
    }
}

- (NSData *)elm327Data:(NSData *)data
{
    int endChar = 62; // > 即结束字符
    Byte *dataByte = (Byte *)[data bytes];
    /** 表示已接收完毕 */
    NSData *tempData = nil;
    if (endChar == dataByte[data.length-1]) {
        NSLog(@"接收完毕!");
        if (self.receviceData) {
            [self.receviceData appendData:data];
            tempData = self.receviceData;
        } else {
            tempData = data;
        }
    } else {
        NSLog(@"未接收完毕......");
//        NSLog(@"Current Recevice Data = %@", data);
        if (!self.receviceData) {
            self.receviceData = [NSMutableData data];
        }
        [self.receviceData appendData:data];
        return nil;
    }
    return tempData;
}

- (NSData *)cheMiData:(NSData *)data
{
    int currentLen = 0;
    // 是不是0xaa开头，不是表示多帧回复
    if (((UInt8 *)data.bytes)[0] == 0xaa && self.receiveLen == 0) {
        // 取数据总长度
        self.receiveLen = ((UInt8 *)data.bytes)[2];
        // 当前接收的数据长度 -4: 帧头 帧序号 数据个数 校验位
        currentLen = (int)data.length - 4;
    } else {
        // -1: 校验位
        currentLen = (int)data.length - 1;
    }
    BOOL isReceOver = self.receiveLen == currentLen ? YES : NO;
    NSData *tempData = nil;
    /** 表示已接收完毕 */
    if (isReceOver) {
        NSLog(@"接收完毕!");
        self.receiveLen = 0;
        tempData = self.receviceData ? self.receviceData : data;
    } else {
        NSLog(@"未接收完毕......");
//        NSLog(@"Current Recevice Data = %@", data);
        if (!self.receviceData) {
            self.receviceData = [NSMutableData data];
        }
        [self.receviceData appendData:data];
    }
    return tempData;
}

- (void)sendData:(NSData *)data receiveBlock:(ReceiveDataBlock)receBlock
{
    self.receiveBlock = receBlock;
    self.sendData = data;
}

- (void)disconnect
{
    NSLog(@"子类重写断开连接");
}



#pragma mark- xlz 字符串转换成data 发送给蓝牙
- (NSData*)stringToByte:(NSString*)string{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++){
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

@end
