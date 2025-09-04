/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900弹出框接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTIPOPUP_H_
#define _ARTIPOPUP_H_



// 弹出框组件，在应用中弹出一个消息提示窗口、提示框等
// 弹出框组件用于弹出一个覆盖到页面上的内容
// 使用场景如：系统扫描界面上弹出故障码详情，底部弹出分享弹窗，页面插屏等

/*
   弹出框根据方向弹出类型可分为
    1、 顶部弹出
    2、 底部弹出，组件默认为底部弹出
    3、 左侧弹出
    4、 右侧弹出
    5、 居中弹出，居中弹出可与ArtiMiniMsgBox达到类似效果

    弹出框根据弹出的内容可分为
    1、消息弹出框，弹出框只包含标题和文本消息，组件默认为消息弹出框
    2、列表弹出框，弹出框可包含标题，列表等

    弹出框可自由添加按钮，弹出框默认没有按钮

    弹出框默认为阻塞接口，除非调用了SetBlockStatus接口
*/

#include "StdShowMaco.h"




class _STD_SHOW_DLL_API_ CArtiPopup
{
public:
    CArtiPopup();

    ~CArtiPopup();

    /**********************************************************
    *    功  能：初始化弹出框控件，同时设置标题文本
    *
    *    参  数：strTitle    标题文本
    *            uPopupType  弹出框类型
    *                        DF_POPUP_TYPE_MSG 纯消息文本弹出框类型
    *                        DF_POPUP_TYPE_LIST 表格类型的弹出框
    *
    *    返回值：true 初始化成功 false 初始化失败
    *
    *     注意： 对象实例调用了InitTitle接口后，相当于重新初始化
    *           弹出框，此实例在InitTitle前调用的其它接口均无效，
    *           如需保持此前的行为，应用必须重复调用除InitTitle外
    *           外的其它接口
    **********************************************************/
    bool InitTitle(const std::string& strTitle, uint32_t uPopupType);
    

    /**********************************************************
    *    功  能：设置弹出框标题
    * 
    *    参  数：strTitle 弹出框标题
    * 
    *    返回值：无
    **********************************************************/
    void SetTitle(const string& strTitle);


    /**********************************************************
    *    功  能：设置弹出框框文本内容
    *    参  数：strContent 弹出框内容
    *    返回值：无
    **********************************************************/
    void SetContent(const string& strContent);


    /**********************************************************
    *    功  能：设置弹出方向
    *
    *    参  数：uDirection    弹出框弹出的方向
    *                          DF_POPUP_DIR_TOP        顶部弹出
    *                          DF_POPUP_DIR_LEFT       左侧弹出
    *                          DF_POPUP_DIR_CENTER     居中弹出
    *                          DF_POPUP_DIR_RIGHT      右侧弹出
    *                          DF_POPUP_DIR_BOTTOM     底部弹出
    * 
    *            如果没有调用此接口，组件默认为底部弹出
    *
    *    返回值：无
    **********************************************************/
    void SetPopDirection(uint32_t uDirection);


    /**********************************************************
    *    功  能：自由添加按妞
    * 
    *    参  数：strButtonText 按钮文本
    * 
    *    返回值：按钮的ID
    *            可能的返回值：
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *                         DF_ID_FREEBTN_2
    *                         DF_ID_FREEBTN_3
    *                         DF_ID_FREEBTN_XX
    **********************************************************/
    uint32_t AddButton(const string& strButtonText);


    /**********************************************************
    *    功  能：设置消息框按钮文本
    *    参  数：uIndex 按钮下标
    *            strButtonText对应下标按钮的文本串
    *    返回值：无
    **********************************************************/
    void SetButtonText(uint16_t uIndex, const string& strButtonText);


    /************************************************************************************
    *    功  能：设置自定义按钮的状态
    *
    *    参  数：uIndex      自定义按钮下标
    *            bStatus     自定义按钮的状态
    *
    *                  DF_ST_BTN_ENABLE    按钮状态为可见并且可点击
    *                  DF_ST_BTN_DISABLE   按钮状态为可见但不可点击
    *                  DF_ST_BTN_UNVISIBLE 按钮状态为不可见，隐藏
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 当前App有此接口，但未实现对应功能
    * 
    *    注 意： 如果没有调用此接口，默认为按钮状态为可见并且可点击
    **************************************************************************************/
    uint32_t SetButtonStatus(uint16_t uIndex, uint32_t uStatus);


    /*******************************************************************************************
    *    功  能：设置界面的阻塞状态
    *
    *    参  数：bIsBlock = true  该界面为阻塞的
    *            bIsBlock = false 该界面为非阻塞的
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 当前App有此接口，但未实现对应功能
    *
    *            其它返回值，暂无意义
    * 
    *    注  意：如果没有调用此接口，默认为阻塞
    *******************************************************************************************/
    uint32_t SetBlockStatus(bool bIsBlock);


    /**********************************************************
    *    功  能：设置列表列宽比，列数不包括序号列
    *    参  数：vctColWidth 列表各列的宽度
    *    返回值：无
    *
    *     说  明：vctColWidth的大小为列数
    *            例如vctColWidth共有2个元素，即列数为2
    *            vctColWidth各元素的总和为100
    **********************************************************/
    void SetColWidth(const std::vector<uint32_t>& vctColWidth);


    /**********************************************************
    *    功  能：添加数据项, 默认该行不高亮显示
    *
    *    参  数：vctItems 数据项集合
    *
    *
    *    返回值：无
    **********************************************************/
    void AddItem(const std::vector<std::string>& vctItems);


    /*********************************************************************************
    *    功  能：设置维修指南所需要的信息（针对小车探和CarPal）
    *
    *    参  数：vctDtcInfo    维修资料所需信息数组
    *
    *             stRepairInfoItem类型的元素
    *             eRepairInfoType eType       维修资料所需信息的类型
    *                                         例如 RIT_DTC_CODE，表示是 "故障码编码"
    *             std::string     strValue    实际的字符串值
    *                                         例如当 eType = RIT_VIN时
    *                                         strValue为 "KMHSH81DX9U478798"
    *
    *    返回值：设置失败
    *            例如当数组元素为空时，返回false
    *            例如当数组中不包含"故障码编码"，返回false
    *********************************************************************************/
    //bool SetRepairManualInfo(const std::vector<stRepairInfoItem>& vctDtcInfo);



    /****************************************************************************************
    *    功  能：设置弹出框忙状态是否显示
    * 
    *    参  数：bIsVisible = true;  显示弹出框忙状态，如沙漏或者其他
    *            bIsVisible = false; 不显示弹出框忙状态
    * 
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 当前App有此接口，但未实现对应功能
    ****************************************************************************************/
    uint32_t SetBusyVisible(bool bIsVisible);



    /*************************************************************************
    *    功  能：显示弹出框
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 退出返回或者按钮返回值
    *            自定义按钮返回自定义按钮返回值
    *
    *    说明
    *
    *        1. 参考 消息框自由按钮返回值
    *           有按键操作返回用户选择按钮 DF_ID_FREEBTN_XXX
    *           例如：返回的值是 DF_ID_FREEBTN_3(0x03000103) 
    *                  代表点击了第四个自由按钮
    *
    *        2. 此接口为阻塞/非阻塞弹出框两种
    *        
    **************************************************************************/
    uint32_t Show();


private:
    void*        m_pData;
};


#endif
