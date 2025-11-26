//
//  TDD_STDPublicInterface.m
//  AD200
//
//  Created by AppTD on 2022/12/9.
//

#import "TDD_STDPublicInterface.h"

#import "TDD_CTools.h"

#define SPRINTF(STR__, SIZE__, FORMAT__, ...)       {do{snprintf((STR__),  (SIZE__), (FORMAT__), __VA_ARGS__);}while(0);}

extern uint32_t GetStdVersion();

@implementation TDD_STDPublicInterface

std::string Version2String(uint32_t Version)
{
    // 0xHHLLYYXX
    //
    // Coding of version numbers
    // HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
    // LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
    // YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
    // XX 为 最低字节, Bit 7 ~  Bit 0    保留
    /*
    *   例如 0x02010300, 表示 V2.01.003
    *   例如 0x020B0000, 表示 V2.11
    */

    auto fnFormat_02d = [](uint8_t value)
    {
        char TempBuffer[32] = { 0 };
        SPRINTF(TempBuffer, 16, "%02d", value);
        return std::string(TempBuffer);
    };

    auto fnFormat_03d = [](uint8_t value)
    {
        char TempBuffer[32] = { 0 };
        SPRINTF(TempBuffer, 16, "%03d", value);
        return std::string(TempBuffer);
    };

    std::string strHH = std::to_string((Version & 0xFF000000) >> 24);
    std::string strLL = fnFormat_02d((Version & 0x00FF0000) >> 16);
    std::string strYY = fnFormat_03d((Version & 0x0000FF00) >> 8);
    //std::string strXX = std::to_string(Version & 0x000000FF);

    if (((Version & 0x0000FF00) >> 8) == 0)
    {
        return std::string("V") + strHH + std::string(".") + strLL;
    }
    
    return std::string("V") + strHH + std::string(".") + strLL + std::string(".") + strYY;
}

+ (NSString *)getSTDVersion
{
    uint32_t i = GetStdVersion();
    
    std::string cStr = Version2String(i);
    
    NSString * str = [TDD_CTools CStrToNSString:cStr];
    
    HLog(@"STD版本为:%@", str);
    
    return str;
}

@end
