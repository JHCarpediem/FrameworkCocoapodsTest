#pragma once
#ifdef __cplusplus
#include <vector>
#include <functional>
#include <string>

class CTopVciBatt
{
private:
    CTopVciBatt() = delete;
    ~CTopVciBatt() = delete;
    
public:
    // 获取版本号
    // 版本信息
    // 例如通常情况为：V1.00
    static std::string const Version();
    
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
    static bool StartCranking();
    
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
    static bool StopCranking();
    
 
    
    
//注册回调函数
//===================================================================================
public:
    // 电池启动测试结果返回
    //
    // 启动过程的电压变化，根据电压变动波形，
    // 识别出：最低点，开始点，结束点，时间和电压等内容
    /*
    *   void CrankingResult(int Type, int CrankingTime, int LastPos, float VoltMin, float VoltLast, float VoltPrev, float VoltDone, const float* pData, int DataLen);
    *
    *
    *   参 数:  Type 是识别这段序列的结果。
    *                如果是0 就是常规输出值
    *                      1 极值情况(启动后的电压高于起始电压,启动正常)
    *                      2 稳值情况(启动后的电压低于起始电压,需要用户去判断是否启动成功)
    *                      3 其它信号
    *                      4 是其它
    *
    *           当为启动测试时（点火测试）
    *               CrankingTime  启动时长，即点火启动持续时间，单位为采样点个
    *               LastPos       启动电压位置，VoltLast的位置，即最后一个波谷值的位置（防止VoltMin和VoltLast值相同时误判）
    *
    *               VoltMin    如果类型为点火测试，此值为dataArray数据最小值（最低电压）
    *               VoltLast   如果类型为点火测试，此值为启动电压（最后一个波谷值）
    *               VoltPrev   启动前电压
    *               VoltDone   启动后电压
    *
    *           pData    浮点型数组指针
    *           DataLen  浮点型数组长度
     
    *           经过分析处理的车辆电池电压值序列，作为接口处理的输出数据
    *           数组大小是不定的
    *
    *   返 回  此接口无返回值
    *
    *   说 明：此接口非阻塞，App从而拿到电池检测接口的输出
    *          1 信号为极值，启动后电压不一定是稳定电压。
    *          2 信号为稳值，启动后电压是稳定电压。
    *          3 特别信号，启动后电压是稳定电压。
    */
    static void CrankingResult(std::function<void(int, int, int, float, float, float, float, const float*, int)> fnCrankingResult);
    
};
#endif
