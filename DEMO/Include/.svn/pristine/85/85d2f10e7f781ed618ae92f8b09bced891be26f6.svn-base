/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 ADAS轮眉高度输入框组件接口定义
* 创 建 人 : sujiya 20231115
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
*
*******************************************************************************/
#ifndef __ARTI_WHEEL_BROW_H__
#define __ARTI_WHEEL_BROW_H__

#include "StdShowMaco.h"


/*
*
*    ADAS轮眉眉高输入框组件，Show为阻塞接口

*/
// 轮眉输入框提示字串，即strTips，默认在最上面一行
// 
// 
class _STD_SHOW_DLL_API_ CArtiWheelBrow
{
public:
    CArtiWheelBrow();

    ~CArtiWheelBrow();


    /**********************************************************
    *    功  能：设置轮眉高度输入框的提示文本
    * 
    *    参  数：strTips  提示文本
    *            posTyp   TIPS_IS_TOP    轮眉高度的提示符居于顶部显示
    *                     TIPS_IS_BOTTOM 轮眉高度的提示符居于底部显示
    * 
    *    返回值：无
    **********************************************************/
    void InitTips(const std::string& strTips, eTipsPosType posType);


    /**********************************************************
    *    功  能：设置轮眉高度对应项输入框的默认值
    *
    *    参  数：eAcdType  轮眉高度输入项类型
    *
    *                ACD_CAL_WHEEL_BROW_HEIGHT_LF  左前轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_RF  右前轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_LR  左后轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_RR  右后轮
    * 
    *            uValue    对应的输入默认值
    *
    *    返回值：无
    *
    *    注  意：如果没有调用此接口，默认为无值
    **********************************************************/
    void SetInputDefault(eAdasCaliData eAcdType, uint32_t uValue);


    /**********************************************************
    *    功  能：获取轮眉高度对应项的输入值
    *
    *    参  数：eAcdType  轮眉高度输入项类型
    *
    *                ACD_CAL_WHEEL_BROW_HEIGHT_LF  左前轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_RF  右前轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_LR  左后轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_RR  右后轮
    *
    *    返回值：对应的输入值
    **********************************************************/
    uint32_t GetInputValue(eAdasCaliData eAcdType);


    /**********************************************************
    *    功  能：设置轮眉高度对应项输入值警告，例如输入值过大
    *
    *    参  数：eAcdType  轮眉高度输入项类型
    * 
    *                ACD_CAL_WHEEL_BROW_HEIGHT_LF  左前轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_RF  右前轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_LR  左后轮
    *                ACD_CAL_WHEEL_BROW_HEIGHT_RR  右后轮
    *
    *    返回值：无
    *
    *    注  意：如果没有调用此接口，默认为无警告
    **********************************************************/
    void SetInputWarning(eAdasCaliData eAcdType);


    /**********************************************************
    *    功  能：设置轮眉高度警告提示文本
    *
    *    参  数：strTips  轮眉高度警告提示文本
    *
    *    返回值：无
    *
    *    注  意：如果没有调用此接口，默认为没有警告文本
    **********************************************************/
    //void SetWarningTips(const std::string &strTips);


    /**********************************************************
    *    功  能：显示轮眉高度输入框，阻塞
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 组件界面按键返回值
    * 
    *        按键：下一步，DF_ID_NEXT
    *              后台或返回，DF_ID_BACK
    **********************************************************/
    uint32_t Show();

private:
    void*    m_pData;
};


#endif // __ARTI_WHEEL_BROW_H__
