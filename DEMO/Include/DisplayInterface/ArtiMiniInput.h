/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 悬浮输入框（Mini）控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
*
*******************************************************************************/
#ifndef __ARTI_MINI_INPUT_H__
#define __ARTI_MINI_INPUT_H__

#include "StdShowMaco.h"

/*
*   无掩码方式
*   为单行文本输入框，App限制为单行显示

    Mini输入框为用户提供可输入的弹窗界面，存在以下情况
    1、 单输入框，固定为两个按钮， 默认为 确定、取消 按钮
    2、 可修改确定按钮的文本
    3、 可修改取消按钮的文本

*/
// 输入框提示字串，即strTips，默认在输入框上面（上一行）
// 输入框，App限制为单行显示

class _STD_SHOW_DLL_API_ CArtiMiniInput
{
public:
    CArtiMiniInput();
    ~CArtiMiniInput();


    /***************************************************************************************************
    *    功  能：初始化输入框控件
    * 
    *    参  数：strTitle          输入框（弹框）标题文本
    *            strDescribe       输入框（弹框）描述文本
    *            strTips           输入框（弹框）提示文本
    *            strDefault        输入框（弹框）默认值
    * 
    *    返回值：true 初始化成功 false 初始化失败
    ***************************************************************************************************/
    bool InitOneInputBox(const string& strTitle, const std::string& strDescribe, 
        const std::string& strTips, const std::string& strDefault = "");


    /****************************************************************************************************
    *    功    能： 设置输入框的内部提示文本
    * 
    *               如果在 InitOneInputBox 设置了 strDefault，输入框默认按 strDefault
    *               如果用户删除了默认输入值，则显示 strInnerTips
    *               例如，"请输入"
    *
    *    参数说明： strInnerTips          "请输入"
    *
    *    返 回 值： 如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
    *               如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION,
    *               其它值，暂无意义
    ****************************************************************************************************/
    uint32_t SetInputBoxInnerTips(const std::string& strInnerTips);



    /***************************************************************************************************
    *    功  能：获取单输入框的内容
    * 
    *    参  数：无
    * 
    *    返回值：string 输入框输入的值
    ***************************************************************************************************/
    std::string GetOneInputBox();


    /***************************************************************************************************
    *    功  能：设置微型输入框的两个按钮文本
    *
    *    参  数：strOkText     确定按钮文本
    *            strCancelText 取消按钮文本
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 当前App有此接口，但未实现对应功能
    *
    *            其它返回值，暂无意义
    ***************************************************************************************************/
    uint32_t SetButtonText(const std::string& strOkText, const std::string& strCancelText);



    /***************************************************************************************************
    *    功  能：显示输入框
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 组件界面按键返回值
    *        按键：确定，取消
    ***************************************************************************************************/
    uint32_t Show();


private:
    void* m_pData;

};

#endif // __ARTI_MINI_INPUT_H__
