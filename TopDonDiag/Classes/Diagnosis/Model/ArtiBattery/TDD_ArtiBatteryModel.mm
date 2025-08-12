//
//  TDD_ArtiBatteryModel.m
//  TopDonDiag
//
//  Created by fench on 2023/9/1.
//

#import "TDD_ArtiBatteryModel.h"
#if useCarsFramework
#import <CarsFramework/topvcibattery.hpp>
#import <CarsFramework/StdComm.hpp>
#else
#import "topvcibattery.hpp"
#import "StdComm.hpp"
#endif


@implementation TDD_ArtiBatteryModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CTopVciBatt::CrankingResult(CrankingResult);
}


/******************************************************************
*    功  能：电池检测启动测试开始，点击小车探主页进入电池测试，
*                 调用此接口开始启动测试
*
*    bool StartCranking();
*
*    参  数：无
*
*    返回值：true   开始测试成功
*                  false  开始测试失败
******************************************************************/
+ (BOOL)StartCranking {
    
    BOOL res = CTopVciBatt::StartCranking();
    
    HLog(@"%@ - StartCranking - %d", [self class], res);
    
    return res;
}

/******************************************************************
 *    功  能：停止电池检测的启动测试
 *
 *    bool StopCranking();
 *
 *    参  数：无
 *
 *    返回值：true   停止测试成功
 *           false  停止测试失败
******************************************************************/
+ (BOOL)StopCranking {
    BOOL res = CTopVciBatt::StopCranking();
    HLog(@"%@ - StopCranking - %d", [self class], res);
    return res;
}

// 电压曲线分析结果返回
//
// 启动过程的电压变化，根据电压变动波形，
// 识别出：最低点，开始点，结束点，时间和电压等内容
// 方便Apk端进行电压曲线分析展示
/*
*   void CrankingResult(int Type, int CrankingTime, int LastPos, float VoltMin, float VoltLast, const float* pData, int DataLen);
*
*
*   参 数:  Type 是识别这段序列的结果。 如果是0 就是常规输出值，
*                                       如果是1 就是点火测试，
*                                       如果是2 就是充电测试。
*
*           当为启动测试时（点火测试）
*               CrankingTime  启动时长，即点火启动持续时间，单位为采样点个
*               LastPos       启动位置，VoltLast的位置，即最后一个波谷值的位置（防止VoltMin和VoltLast值相同时误判）
*
*               VoltMin    如果类型为点火测试，此值为dataArray数据最小值
*               VoltLast   如果类型为点火测试，此值为最后一个波谷值，即启动电压
*
*
*           当为充电测试时
*               CrankingTime  负载电压长度
*               LastPos       保留，当前未使用，未定义(负载电压的估计启点)
*
*               VoltMin       负载电压
*               VoltLast      空载电压
*
*           pData    浮点型数组指针
*           DataLen  浮点型数组长度
*
*           经过分析处理的车辆电池电压值序列，作为接口处理的输出数据
*           数组大小是不定的
*
*   返 回  此接口无返回值
*
*   说 明：此接口非阻塞，App从而拿到电池检测接口的输出
*/
void CrankingResult(int Type, int CrankingTime, int LastPos, float VoltMin, float VoltLast, float VoltPrev, float VoltDone, const float* pData, int DataLen) {
    [TDD_ArtiBatteryModel artiBatteryCrankingResult:Type crankingTime:CrankingTime lastPos:LastPos voltMin:VoltMin VoltLast:VoltLast VoltPrev:VoltPrev VoltDone:VoltDone pData:pData dataLen:DataLen];
}

+ (void)artiBatteryCrankingResult:(int)type crankingTime:(int)time lastPos:(int)lastPos voltMin:(float)voltMin VoltLast:(float)voltLast VoltPrev:(float)voltPrev VoltDone:(float)voltDone pData:(const float *)pData dataLen:(int)dataLen {
    
    HLog(@"%@ - 电压曲线分析结果返回: type - %d, crankingTime - %d, lastPos - %d, volMin - %f, volLast - %f", [self class], type, time, lastPos, voltMin, voltLast);
    
    TDD_ArtiBatteryModel *model = [TDD_ArtiBatteryModel new];
    model.type = type;
    model.crankingTime = time;
    model.lastPos = lastPos;
    model.voltMin = voltMin;
    model.voltLast = voltLast;
    model.voltPrev = voltPrev;
    model.voltDone = voltDone;
    
    // 创建一个 NSMutableArray
    NSMutableArray *array = [NSMutableArray array];
    
    NSUInteger count = 0; // 初始化计数器

    // 遍历指针指向的数组，直到遇到结束标记（假设结束标记为 0）
    while (*pData != 0) {
        float value = *pData; // 获取指针指向的浮点数
        [array addObject:@(value)]; // 将浮点数转换为 NSNumber 对象并添加到数组中
        pData++; // 指针移动到下一个元素
        count++; // 计数器加一
    }
    
    model.dataArray = array;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KTDDNotificationBatteryUpdate" object:model];
}

float ReadVBat()
{
    return [TDD_ArtiBatteryModel readVBat];
}

+ (float)readVBat
{
    float vbat = (float)CStdComm::ReadVBat();
    HLog(@"读取电池电压 - %f", vbat)
    return vbat;
}

@end
