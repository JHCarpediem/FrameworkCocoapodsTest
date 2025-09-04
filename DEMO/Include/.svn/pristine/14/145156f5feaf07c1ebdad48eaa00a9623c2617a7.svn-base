/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900冻结帧控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTIFREE_H_
#define _ARTIFREE_H_
#include "StdInclude.h"
#include "StdShowMaco.h"

// 冻结帧组件
// 冻结帧组件是一个简易版的ArtiList
// 
// 冻结帧组件，固定列为，“名称”，“值”，“单位”，“帮助”
// “单位”和“帮助”可不设定，不设定情况下默认为共2列
// 
// 冻结帧组件的“值”要么是1列，要么是2列，“值”默认情况下是1列
// AddItem接口用于冻结帧组件的“值”为1列的场景，AddItemEx接口用于冻结帧组件“值”为2列的场景
// SetValueType 接口指定冻结帧组件的“值”是1列还是2列

class _STD_SHOW_DLL_API_ CArtiFreeze
{
public:
    CArtiFreeze();
#ifdef MULTI_SYSTEM
    CArtiFreeze(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiFreeze();

    /**********************************************************
    *    功  能：初始化冻结帧控件，同时设置标题文本
    *    参  数：strTitle 标题文本
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle);


    /**********************************************************
    *    功  能：指定冻结帧项的值为1列类型还是2列类型
    *
    *    参  数：eFreezeValueType  eColumnType
    *            VALUE_1_COLUMN = 1,   // 指定冻结帧的值为1列
    *            VALUE_2_COLUMN = 2,   // 指定冻结帧的值为2列
    *
    *    返回值：无
    * 
    *    注  意：如果没有调用SetValueType接口，默认为1列
    **********************************************************/
    void SetValueType(eFreezeValueType eColumnType);


    /**********************************************************
    *    功  能：添加冻结帧项（值为1列）
    * 
    *    参  数：strName 冻结帧名称
    *            strValue 冻结帧值
    *            strUnit 冻结帧单位
    * 
    *    返回值：无
    *    注  意：如果SetValueType指定了2列，用AddItemEx接口传值
    **********************************************************/
    void AddItem(const string& strName,
        const string& strValue,
        const string& strUnit = "",
        const string& strHelp = "");


    /**********************************************************
    *    功  能：添加冻结帧项（值为2列）
    * 
    *    参  数：strName        冻结帧名称
    *            strValue1st    冻结帧值1
    *            strValue2nd    冻结帧值2
    *            strUnit        冻结帧单位
    * 
    *    返回值：无
    *    注  意：如果SetValueType指定了1列，用AddItem接口传值
    **********************************************************/
    void AddItemEx(const string& strName,
        const string& strValue1st,
        const string& strValue2nd,
        const string& strUnit = "",
        const string& strHelp = "");



    /**********************************************************
    *    功  能：设置冻结帧列表头，该行锁定状态
    * 
    *    参  数：vctHeadNames 列表各列的名称集合
    * 
    *    返回值：无
    * 
    *    注  意：SetHeads必须跟AddItem或者AddItemEx指定列数一致
    *            如果SetHeads实参的vctHeadNames大小大于AddItem
    *            或者AddItemEx中指定的列数，以AddItem或者AddItemEx
    *            的为准
    **********************************************************/
    void SetHeads(const std::vector<string>& vctHeadNames);




    /**********************************************************
    *    功  能：显示冻结帧
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *        按键：返回
    **********************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
