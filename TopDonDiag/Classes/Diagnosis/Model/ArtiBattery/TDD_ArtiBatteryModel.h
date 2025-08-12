//
//  TDD_ArtiBatteryModel.h
//  TopDonDiag
//
//  Created by fench on 2023/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiBatteryModel : NSObject

/// 识别这段序列的结果。 如果是0 就是常规输出值， 如果是1 就是点火测试，如果是2 就是充电测试。
@property (nonatomic, assign) int type;
///  启动时长，即点火启动持续时间，单位为采样点个
///  当为充电测试时  负载电压长度
@property (nonatomic, assign) int crankingTime;
/// 启动位置，VoltLast的位置，即最后一个波谷值的位置（防止VoltMin和VoltLast值相同时误判）
/// 当为充电测试时 保留，当前未使用，未定义(负载电压的估计启点)
@property (nonatomic, assign) int lastPos;
/// 如果类型为点火测试，此值为dataArray数据最小值
/// 当为充电测试时 负载电压
@property (nonatomic, assign) float voltMin;
/// 如果类型为点火测试，此值为最后一个波谷值，即启动电压
/// 当为充电测试时  空载电压
@property (nonatomic, assign) float voltLast;
//启动前电压
@property (nonatomic, assign) float voltPrev;
//启动后电压
@property (nonatomic, assign) float voltDone;

/// 结果数组  浮点数组
@property (nonatomic, strong) NSMutableArray *dataArray;


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
+ (BOOL)StartCranking;

// 获取车辆电池电压
// 注意，获取到的电池电压值，单位毫伏
+ (float)readVBat;

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
+ (BOOL)StopCranking;

#pragma mark 注册方法
+ (void)registerMethod;

@end

NS_ASSUME_NONNULL_END
