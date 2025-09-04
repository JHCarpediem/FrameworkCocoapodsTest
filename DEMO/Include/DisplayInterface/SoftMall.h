#ifndef __SOFT_MALL_MACO_H__
#define __SOFT_MALL_MACO_H__

#include "StdInclude.h"


class _STD_SHOW_DLL_API_ CSoftMall
{
public:
    enum eUserSubscription
    {
        SMUS_SUBSCRIPTION_UNCHANGED = 0,   // 用户权益没有变化
        SMUS_SUBSCRIPTION_CHANGED   = 1,   // 用户权益有变化

        SMUS_PAY_OK                 = 2,   // 用户支付成功
        SMUS_PAY_FAILED             = 3,   // 用户支付失败
    };

public:
    CSoftMall() {}
    ~CSoftMall() {}

public:
    /*-------------------------------------------------------------------------------------------------------
    功    能： 跳转到软件商城界面，诊断应用可以通过此接口跳转到软件商城界面
               此接口阻塞的，直至用户从商城界面返回，返回权益有无变化

    参数说明： uType          跳转类型
                              uType = 1，表示刷隐藏权益类型
                              其它值，保留

    返 回 值： 如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
               如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION
               如果用户在商城购买了产品，返回 SMUS_SUBSCRIPTION_CHANGED（1）
               如果用户没有购买产品，返回 SMUS_SUBSCRIPTION_UNCHANGED（0）
    -------------------------------------------------------------------------------------------------------*/
    static uint32_t Navigate(uint32_t uType);
};

#endif // __SOFT_MALL_MACO_H__
