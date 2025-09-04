/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900版本信息显示控件接口定义
* 创 建 人 : sujiya 20201210
* 实 现 人 : 
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTIECUINFO_H_
#define _ARTIECUINFO_H_
#include "StdInclude.h"

class _STD_SHOW_DLL_API_ CArtiEcuInfo
{
public:
    CArtiEcuInfo();
#ifdef MULTI_SYSTEM
    CArtiEcuInfo(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiEcuInfo();

    /**********************************************************
    *    功  能：初始化版本信息显示控件，同时设置标题文本
    *    参  数：strTitle 标题文本
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle);

    /**********************************************************
    *    功  能：设置版本信息项名和值所在列的比例
    *    参  数：iFirstPercent 版本信息项宽，
    *            strValue 版本信息项值宽
    *    返回值：无
    **********************************************************/
    void SetColWidth(int16_t iFirstPercent, int16_t iSecondPercent);

    /**********************************************************
    *    功  能：添加版本信息的分组
    *    参  数：strGroupName 分组名称文本
    *    返回值：无
    **********************************************************/
    void AddGroup(const string& strGroupName);

    /**********************************************************
    *    功  能：添加版本信息项
    *    参  数：strItem 版本信息项名称，
    *            strValue 版本信息项的值
    *    返回值：无
    **********************************************************/
    void AddItem(const string& strItem, const string& strValue);

    /**********************************************************
    *    功  能：显示版本信息控件
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *        按键：返回
    **********************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
