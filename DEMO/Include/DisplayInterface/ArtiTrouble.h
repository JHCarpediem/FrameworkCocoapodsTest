/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900故障码控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTITROUBLE_H_
#define _ARTITROUBLE_H_
#include "StdInclude.h"
#include "StdShowMaco.h"

// 故障码界面，包含List 表，故障码帮助、冻结帧信息，搜索，清故障码等部分

class _STD_SHOW_DLL_API_ CArtiTrouble
{
public:
    CArtiTrouble();
#ifdef MULTI_SYSTEM
    CArtiTrouble(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiTrouble();



    /**********************************************************
    *    功  能：初始化故障码控件，同时设置标题文本
    *    参  数：strTitle 标题文本
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle);



    /**********************************************************
    *    功  能：添加故障码
    *    参  数：strTroubleCode 故障码号
    *            strTroubleDesc 故障码描述
    *            strTroubleState 故障码状态
    *    返回值：无
    **********************************************************/
    void AddItem(const string& strTroubleCode,
        const string& strTroubleDesc,
        const string& strTroubleStatus,
        const string& strTroubleHelp = "");


    /**********************************************************
    *    功  能：添加故障码
    * 
    *    参  数：stDtcReportItemEx nodeItem 故障码节点
    *            nodeItem 节点 结构定义
    *            struct stDtcNodeEx
    *            {
    *                std::string strCode;        // 故障代码
    *                std::string strDescription; // 故障码描述
    *                std::string strStatus;      // 故障码状态
    *                uint32_t    uStatus;        // 故障码状态
    *            };
    * 
    *            strTroubleHelp 故障码帮助信息
    * 
    *    返回值：无
    **********************************************************/
    void AddItemEx(const stDtcNodeEx& nodeItem, const string& strTroubleHelp = "");



    /**********************************************************
    *    功  能：设置指定故障码的帮助信息
    *    参  数：uIndex 指定的故障码
    *            strToubleHelp 故障码帮助信息
    *    返回值：无
    **********************************************************/
    void SetItemHelp(uint16_t uIndex, const string& strToubleHelp);
    


    /**********************************************************
    *    功  能：设置指定故障码后边故障灯的状态
    *    参  数：uIndex 指定的故障码
    *            bIsShow=true 显示一个点亮的故障灯
    *            bIsShow=false 不显示故障灯
    *    返回值：无
    **********************************************************/
    void SetMILStatus(uint16_t uIndex, bool bIsShow = true);



    /**********************************************************
    *    功  能：设置指定故障码后边冻结帧标志的状态
    *    参  数：uIndex 指定的故障码
    *            bIsShow=true 显示冻结帧标志
    *            bIsShow=false 不显示冻结帧标志
    *    返回值：无
    **********************************************************/
    void SetFreezeStatus(uint16_t uIndex, bool bIsShow = true);



    /**********************************************************
    *    功  能：设置清码按钮是否显示
    *    参  数：bIsVisible=true  显示清码按钮
    *            bIsVisible=false 隐藏清码按钮
    *    返回值：无
    **********************************************************/
    void SetCdtcButtonVisible(bool bIsVisible = true);



    /*********************************************************************************
    *    功  能：设置维修指南所需要的信息
    * 
    *    参  数：vctDtcInfo    维修资料所需信息数组
    *            
    *             stRepairInfoItem类型的元素
    *             eRepairInfoType eType          维修资料所需信息的类型
    *                                            例如 RIT_DTC_CODE，表示是 "故障码编码"
    *             std::string     strValue       实际的字符串值
    *                                            例如当 eType = RIT_VIN时
    *                                            strValue为 "KMHSH81DX9U478798"
    * 
    *    返回值：设置失败
    *            例如当数组元素为空时，返回false
    *            例如当数组中不包含"故障码编码"，返回false
    *********************************************************************************/
    bool SetRepairManualInfo(const std::vector<stRepairInfoItem>& vctDtcInfo);



    /**********************************************************
    *    功  能：显示故障码
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *           按键：冻结帧，清码，返回，报告，"维修资料"
    *    
    *     可能存在以下返回：
    *                        DF_ID_TROUBLE_BACK
    *                        DF_ID_TROUBLE_CLEAR
    *                        DF_ID_TROUBLE_REPORT
    *                        DF_ID_TROUBLE_0
    *                        DF_ID_TROUBLE_1
    *                        ......
    *                        DF_ID_TROUBLE_X
    * 
    *                        维修资料按钮
    *                         DF_ID_REPAIR_MANUAL_0
    *                         DF_ID_REPAIR_MANUAL_1
    *                         DF_ID_REPAIR_MANUAL_2
    *                         DF_ID_REPAIR_MANUAL_3
    *                         DF_ID_REPAIR_MANUAL_4
    *                         DF_ID_REPAIR_MANUAL_XXXX
    **********************************************************/
    uint32_t Show();


private:
    void*        m_pData;
};

#endif
