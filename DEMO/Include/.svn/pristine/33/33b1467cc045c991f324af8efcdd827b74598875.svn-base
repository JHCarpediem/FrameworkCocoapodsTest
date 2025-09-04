/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900版本消息框按钮接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTIMINIMSGBOX_H_
#define _ARTIMINIMSGBOX_H_

/*
    消息框分为4种类型
    1、 固定按钮的阻塞消息框；
    2、 固定按钮的非阻塞消息框；
    3、 自由添加按钮的阻塞消息框；
    4、 自由添加按钮的非阻塞消息框。

    消息框按钮在底部，从右向左排列；无按钮的非阻塞消息框有沙漏（即是转圈效果）。
*/

#include "StdShowMaco.h"

/*
    当 uButton 指定为 固定按钮时可：
                DF_MB_NOBUTTON              无按钮的非阻塞消息框
                DF_MB_YES                   Yes 按钮的阻塞消息框
                DF_MB_NO                    No 按钮的阻塞消息框
                DF_MB_YESNO                 Yes/No 按钮的阻塞消息框
                DF_MB_OK                    OK 按钮的阻塞消息框
                DF_MB_CANCEL                Cancel 按钮的阻塞消息框
                DF_MB_OKCANCEL              OK/Cancel 按钮的阻塞消息框
                DF_MB_NEXTEXIT              Next/Exit 按钮的阻塞消息框

    全局消息框函数artiShowMiniMsgBox无自由按钮的模式(会显示忙状态)

注意：当 uButton 指定为 DF_MB_NOBUTTON 时，artiShowMiniMsgBox是
      会显示消息框忙状态，有忙的属性（即转圈圈效果）
*/
    
uint32_t _STD_SHOW_DLL_API_ artiShowMiniMsgBox(const string& strTitle,
    const string& strContent,
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER);


class _STD_SHOW_DLL_API_ CArtiMiniMsgBox
{
public:
    CArtiMiniMsgBox();
#ifdef MULTI_SYSTEM
    /* 多线程诊断编号，目前支持最多4线程 */
    CArtiMiniMsgBox(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiMiniMsgBox();

    /**********************************************************
    *    功  能：初始化消息框
    *    参  数：strTitle 消息框标题文本
    *            strContent 消息框内容文本
    *            uButtonType 消息框按钮类型
    *            uAlignType 消息框文本对齐方式
    *    返回值：true 初始化成功 false 初始化失败
    *
    *    注：
    *     uButtonType值可以如下：
    *            DF_MB_NOBUTTON             //  无按钮的非阻塞消息框
    *            DF_MB_YES                  //  Yes 按钮的阻塞消息框
    *            DF_MB_NO                   //  No 按钮的阻塞消息框
    *            DF_MB_YESNO                //  Yes/No 按钮的阻塞消息框
    *            DF_MB_OK                   //  OK 按钮的阻塞消息框
    *            DF_MB_CANCEL               //  Cancel 按钮的阻塞消息框
    *            DF_MB_OKCANCEL             //  OK/Cancel 按钮的阻塞消息框
    *            DF_MB_FREE | DF_MB_BLOCK   //  自由按钮的阻塞消息框
    * 
    *    注  意： 如果设置了自由按钮DF_MB_FREE，Show之前需要调用AddButton
    *             如果不需要按钮请用DF_MB_NOBUTTON
    *
    **********************************************************/
    bool InitMsgBox(const string& strTitle,
        const string& strContent,
        uint32_t uButtonType = DF_MB_OK,
        uint16_t uAlignType = DT_CENTER);
    

    /**********************************************************
    *    功  能：设置消息框标题
    *    参  数：strTitle 消息框标题
    *    返回值：无
    **********************************************************/
    void SetTitle(const string& strTitle);

    /**********************************************************
    *    功  能：设置消息框文本内容
    *    参  数：strContent 消息框内容
    *    返回值：无
    **********************************************************/
    void SetContent(const string& strContent);


    /**********************************************************
    *    功  能：自由添加按钮，初始化的时候使用了DF_MB_FREE，此接口才生效
    * 
    *    参  数：strButtonText 按钮文本
    * 
    *    返回值：按钮的ID，此ID用于DelButton接口的参数
    *            可能的返回值：
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *   
    *    注 意：最多添加2个按钮
    **********************************************************/
    uint32_t AddButton(const string& strButtonText);


    /**********************************************************
    *    功  能：设置消息框按钮类型
    *    参  数：uButtonTyp 按钮类型
    *    返回值：无
    **********************************************************/
    void SetButtonType(uint32_t uButtonTyp);


    /******************************************************************
    *    功  能：设置自定义按钮的状态
    * 
    *    参  数：uIndex      自定义按钮下标
    *            bStatus     自定义按钮的状态
    * 
    *                  DF_ST_BTN_ENABLE    按钮状态为可见并且可点击
    *                  DF_ST_BTN_DISABLE   按钮状态为可见但不可点击
    *                  DF_ST_BTN_UNVISIBLE 按钮状态为不可见，隐藏
    * 
    *    返回值：无
    *            如果没有调用此接口，默认为按钮状态为可见并且可点击
    ********************************************************************/
    void SetButtonStatus(uint16_t uIndex, uint32_t uStatus);


    /**********************************************************
    *    功  能：设置消息框按钮文本
    *    参  数：uIndex 按钮下标
    *            strButtonText对应下标按钮的文本串
    *    返回值：无
    **********************************************************/
    void SetButtonText(uint16_t uIndex, const string& strButtonText);


    /**********************************************************
    *    功  能：设置消息框内容对齐方式
    *    参  数：uAlignType 对齐方式
    *    返回值：无
    **********************************************************/
    void SetAlignType(uint16_t uAlignType);


    /**********************************************************
    *    功  能：设置消息框忙状态是否显示
    *    参  数：bIsVisible = true; 显示消息框忙状态，如沙漏或者其他
    *            bIsVisible = false; 不显示显示消息框忙状态
    *    返回值：无
    **********************************************************/
    void SetBusyVisible(bool bIsVisible);



    /**********************************************************
    *    功  能：设置选择框选项的文本（单选）
    *            如果调用了此接口，将显示多选1的复选框
    * 
    *    参  数：vctCheckBox 各选择框选项文本
    *            例如，二选一情况下，vctCheckBox的大小为2，分别为
    *                  “熄灭”，“点亮”    
    * 
    *            默认选中第一个
    * 
    *    返回值：无
    **********************************************************/
    void SetSingleCheckBoxText(const std::vector<std::string>& vctCheckBox);



    /**********************************************************
    *    功  能：获取选择框选项的文本（单选）
    *
    *    参  数：vctCheckBox 各选择框选项文本
    *            例如，二选一情况下，vctCheckBox的大小为2，分别为
    *                  “熄灭”，“点亮”
    *
    *    返回值：无
    **********************************************************/
    std::string const GetSingleCheckBoxText();



    /*************************************************************************
    *    功  能：显示消息框
    *    参  数：无
    *    返回值：uint32_t 按钮返回值
    *
    *            固定按钮返回固定按钮返回值，
    *            自定义按钮返回自定义按钮返回值
    *
    *    说明
    *        1. 参考 固定按钮返回值
    *           例如， DF_ID_OK 用户点击了 OK 按钮
    *
    *        2. 参考 消息框自由按钮返回值
    *           有按键操作返回用户选择按钮 DF_ID_FREEBTN_XXX
    *           例如：返回的值是 DF_ID_FREEBTN_1(0x03000101) 
    *                  代表点击了第2个自由按钮
    *
    *        3. 当用户定义为阻塞消息框，等待用户操作返回选择按钮;
    *        
    *        4. DF_ID_NOKEY 当定义为非阻塞消息框，无操作返回 ;
    *           例如，在动作测试有按钮非阻塞消息框，需要固定发指令多少条后自动返回
    **************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif // _ARTIMINIMSGBOX_H_
