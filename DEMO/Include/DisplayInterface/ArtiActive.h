/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900动作测试控件接口定义
* 创 建 人 : sujiya 20201210
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTIACTIVE_H_
#define _ARTIACTIVE_H_
#include "StdInclude.h"
#include "StdShowMaco.h"

// 动作测试一般只有2列或者3列的
// 如果多于3列，应该用CArtiList

class _STD_SHOW_DLL_API_ CArtiActive
{
public:
    CArtiActive();
#ifdef MULTI_SYSTEM
    CArtiActive(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiActive();


    /**********************************************************
    *    功  能：初始化动作测试控件，同时设置标题文本
    *    参  数：strTitle 标题文本
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle);


    /**********************************************************
    *    功  能：添加动作测试项
    * 
    *    参  数：strItem   动作测试项名称，
    * 
    *            bIsLocked=true, 排除该行刷新，获取刷新项时，排除此行
    *            bIsLocked=false,不排除该行刷新，获取刷新项时，包含此行
    * 
    *            strValue  动作测试项值
    *            strUnit   动作测试项单位
    * 
    *    返回值：无
    * 
    *    注  意：bIsLocked为true时，并不是“冻结此行”的显示效果
    *            而是GetUpdateItems不包括此行
    **********************************************************/
    void AddItem(const string& strItem, 
        const string& strValue = "",
        bool bIsLocked = false,
        const string& strUnit = "");


    /**********************************************************
    *    功  能：获取当前屏的刷新项（排除锁定行）
    * 
    *    参  数：无
    * 
    *    返回值：vector<uint16_t> 当前屏需要刷新的项的下标集合
    * 
    *    注  意：如果调用了SetLockFirstRow，首行不能被排除
    *            即SetLockFirstRow的首行不属于GetUpdateItems的
    *            “锁定行”
    *            如果没有调用SetLockFirstRow，首行属于正常行，
    *            需要在此接口GetUpdateItems上返回
    **********************************************************/
    vector<uint16_t> GetUpdateItems();


    /**********************************************************
    *    功  能：设置动作测试某一项的值
    *    参  数：uIndex 动作测试项，strValue 动作测试项值
    *    返回值：无
    **********************************************************/
    void SetValue(uint16_t uIndex, const string& strValue);


    /**********************************************************
    *    功  能：设置动作测试某一项的动作测试项名称
    *    参  数：uIndex 动作测试项，strItem 动作测试项名称
    *    返回值：无
    **********************************************************/
    void SetItem(uint16_t uIndex, const string& strItem);


    /**********************************************************
    *    功  能：设置动作测试某一项的单位
    *    参  数：uIndex 动作测试项，strUnit 动作测试项单位
    *    返回值：无
    **********************************************************/
    void SetUnit(uint16_t uIndex, const string& strUnit);


    /**********************************************************
    *    功  能：在界面顶部设置动作测试操作提示
    *    参  数：strOperationTips 动作测试操作提示
    *    返回值：无
    **********************************************************/
    void SetOperationTipsOnTop(const string& strOperationTips = "");


    /***********************************************************************
    *    功  能：在界面顶部设置表格文本提示的标题
    *
    *    参  数：strTipsTitle     对应文本提示的标题
    *            uAlignType       对应文本标题的对齐方式，例如
    *                             DT_CENTER, 表示居中对齐
    *                             DT_LEFT, 表示左对齐
    *            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
    *                             FORT_SIZE_MEDIUM 表示 中等字体
    *                             FORT_SIZE_LARGE 表示 大字体
    *            eBold            是否粗体显示
    *                             BOLD_TYPE_NONE, 表示不加粗
    *                             BOLD_TYPE_BOLD, 表示加粗
    *
    *    返回值：无
    *
    *    说  明：如果没有设置（没有调用此接口），则不显示提示标题
    ***********************************************************************/
    void SetTipsTitleOnTop(const string& strTipsTitle, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);


    /**********************************************************
    *    功  能：在界面底部设置动作测试操作提示
    *    参  数：strOperationTips 动作测试操作提示
    *    返回值：无
    **********************************************************/
    void SetOperationTipsOnBottom(const string& strOperationTips = "");


    /***********************************************************************
    *    功  能：在界面底部设置表格文本提示的标题
    *
    *    参  数：strTipsTitle     对应文本提示的标题
    *            uAlignType       对应文本标题的对齐方式，例如
    *                             DT_CENTER, 表示居中对齐
    *                             DT_LEFT, 表示左对齐
    *            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
    *                             FORT_SIZE_MEDIUM 表示 中等字体
    *                             FORT_SIZE_LARGE 表示 大字体
    *            eBold            是否粗体显示
    *                             BOLD_TYPE_NONE, 表示不加粗
    *                             BOLD_TYPE_BOLD, 表示加粗
    *
    *    返回值：无
    *
    *    说  明：如果没有设置（没有调用此接口），则不显示提示标题
    ***********************************************************************/
    void SetTipsTitleOnBottom(const string& strTipsTitle, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);



    /**********************************************************
    *    功  能：设置列表头，该行锁定状态
    * 
    *    参  数：vctHeadNames 列表各列的名称集合
    * 
    *    返回值：无
    * 
    *    注  意：有可能是没有列表头的，如果调用了这个，列表头显示
    *            出来，然后按照SetHeads指定的名称显示
    **********************************************************/
    void SetHeads(const vector<string>& vctHeadNames);


    /**********************************************************
    *    功  能：设置第一行是锁定状态，类似Excel表格的“冻结首行”
    *
    *    参  数：无
    *
    *    返回值：无
    *
    *    注  意：首行和列表头(Head)是不一样的
    *            如果设置了列表头，SetHeads
    *            并且锁定了首行，SetLockFirstRow
    *            会有类似冻结了2行的效果
    *
    *            列表头 和 SetLockFirstRow的首行 底纹 应该有区别的效果
    * 
    *            如果调用了SetLockFirstRow，首行在GetUpdateItems中不
    *            能被排除， 即SetLockFirstRow的首行不属于
    *            GetUpdateItems的“锁定行”
    **********************************************************/
    void SetLockFirstRow();


    /**********************************************************
    *    功  能：添加动作测试按钮,添加完按钮默认可点击
    *
    *    参  数：strButtonText 动作测试按钮文本
    *
    *    返回值：按钮的ID，此ID用于DelButton接口的参数
    *            可能的返回值：
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *                         DF_ID_FREEBTN_2
    *                         DF_ID_FREEBTN_3
    *                         DF_ID_FREEBTN_XX
    **********************************************************/
    void AddButton(const string& strButtonText);
    uint32_t AddButtonEx(const string& strButtonText);


    /**********************************************************
    *    功  能：删除自由按钮
    *
    *    参  数：uButtonId  按钮的编号
    *
    *            uButtonId 可能值是 DF_ID_FREEBTN_0
    *                               DF_ID_FREEBTN_1
    *                               DF_ID_FREEBTN_2
    *                               DF_ID_FREEBTN_3
    *                               DF_ID_FREEBTN_XX
    *
    *    返回值：true  自用添加的按钮删除成功
    *            false 自用添加的按钮删除失败
    **********************************************************/
    bool DelButton(uint32_t uButtonId);


    /**********************************************************
    *    功  能：设置指定的动作测试按钮状态
    *    参  数：uIndex 指定的动作测试按钮
    *            bIsEnable=true 按钮可点击
    *            bIsEnable=false 按钮不可点击
    *    返回值：无
    **********************************************************/
    [[deprecated("is deprecated, please use CArtiActive::SetButtonStatus(uint16_t, uint32_t) instead.")]]
    void SetButtonStatus(uint8_t uIndex, bool bIsEnable);


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
    *    功  能：设置指定的动作测试按钮文本
    *    参  数：uIndex 指定的按钮
    *            strButtonText 需要设置的动作测试按钮文本
    *    返回值：无
    **********************************************************/
    void SetButtonText(uint8_t uIndex, const string& strButtonText);

    /**********************************************************
    *    功  能：显示动作测试
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *        按键：动作测试功能键，返回
    **********************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
