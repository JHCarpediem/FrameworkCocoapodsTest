/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900系统显示控件接口定义
* 创 建 人 : sujiya 20201210
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTISYSTEM_H_
#define _ARTISYSTEM_H_
#include "StdInclude.h"
#include "ArtiGlobal.h"

/*
    CArtiSystem 按钮包括如下：

    “帮助”
    “诊断报告”
    “一键扫描”/“暂停扫描”/“继续扫描”
    “一键清码”
    “后退”
    “显示全部”/“显示实际”

    按钮规则：
        1、“帮助”按钮，是否可用根据SetHelpButtonVisible接口决定，“帮助”按钮默认不可用

        2、进入CArtiSystem界面，“后退”和“一键扫描”可用，“诊断报告”、“一键清码”不可用

        3、“一键清码”按钮默认显示，状态为不可用，如果SetClearButtonVisible设置“一键清码”不显示
            即使存在故障码，也不显示
          
        4、点击“一键扫描”，“一键扫描”变为“暂停扫描”，其余按钮皆不可用，直至扫描完成或者暂停，
           扫描完成或者暂停由接口SetScanStatus()指定

        5、如果点击了“暂停扫描”，或者SetScanStatus接口指定为暂停，
           “暂停扫描”变成“继续扫描”可用，此时界面状态为暂停，
           “帮助”按钮和“后退”按钮可用，“诊断报告”按钮根据是否有系统，决定是否可用
           如果此时有故障码或者系统未知（DF_ENUM_UNKNOWN），“一键清码”应可用

        6、如果点击了“继续扫描”，“继续扫描”变为“暂停扫描”，其余按钮皆不可用，
           直至扫描完成或者暂停，扫描完成或者暂停由接口SetScanStatus()指定

        7、如果点击了“一键清码”，所有按钮皆不可用，直至清码完成，清码完成由SetClearStatus接口指定

        8、“一键清码”按钮是否可用，由是否存在故障码决定，如果此时正在“一键扫描”中，即使有故障码，按钮也不可用
           如果SetClearButtonVisible设置“一键清码”不显示，即使存在故障码，也不显示此按钮

        9、SetScanStatus()的实参是DF_SYS_SCAN_PAUSE，相当于点击了“暂停扫描”

        10、诊断代码在系统扫描完后，需调用SetScanStatus()，此时系统扫描已完成

        11、诊断代码在一键清码完后，需调用SetClearStatus()，一键清码已完成

        12、如果返回 DF_ID_SYS_START 表示点击了“一键扫描”
            诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_START)通知实现
            一键扫描开始

           如果返回 DF_ID_SYS_STOP  表示点击了“暂停”
           诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_PAUSE)通知实现
            暂停扫描

           如果返回 DF_ID_SYS_ERASE 表示点击了“一键清码”
           诊断程序需立即调用SetClearStatus(DF_SYS_CLEAR_START)通知实现
            一键清码开始
*/


class _STD_SHOW_DLL_API_ CArtiSystem
{
public:
    // 小车探系统扫描类型分类，参考菜单掩码分类，即“诊断的系统掩码值”
    using eSysClassType = CArtiGlobal::eDiagMenuMask;

    enum eSysScanType
    {
        SST_TYPE_DEFAULT = 0,   // 默认系统类型
        SST_TYPE_ADAS    = 1,   // ADAS系统扫描类型
    };

public:
    CArtiSystem();
    ~CArtiSystem();

    /**********************************************************
    *    功  能：初始化系统显示控件，同时设置标题文本
    * 
    *    参  数：strTitle       标题文本
    * 
    *            eSysScanType   系统扫描组件类型
    *                           SST_TYPE_DEFAULT 默认系统类型
    *                           SST_TYPE_ADAS    ADAS系统扫描类型
    * 
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle);
    bool InitTitle(const string& strTitle, eSysScanType eType);
    
    

    /******************************************************************
    *    功  能：添加系统项
    * 
    *    参  数：strItem   系统项名称
    * 
    *            eType     小车探系统扫描的系统类型分类
    *                      如果为DMM_INVALID，则不需要分类
    * 
    *                      通常情况下诊断分12类
    *                      CArtiGlobal::eDiagMenuMask
    *                      DMM_ECM_CLASS      动力系统类
    *                      DMM_TCM_CLASS      传动系列类
    *                      DMM_ABS_CLASS      制动系统类
    *                      DMM_SRS_CLASS      安全防御类
    *                      DMM_HVAC_CLASS     空调系列类
    *                      DMM_ADAS_CLASS     ADAS系列类
    *                      DMM_IMMO_CLASS     安全防盗类
    *                      DMM_BMS_CLASS      电池系统类
    *                      DMM_EPS_CLASS      转向系统类
    *                      DMM_LED_CLASS      灯光系统类
    *                      DMM_IC_CLASS       仪表系统类
    *                      DMM_INFORMA_CLASS  信息娱乐类
    *                      DMM_BCM_CLASS      车身控制类
    * 
    *    返回值：无
    *******************************************************************/
    void AddItem(const string& strItem);
    void AddItem(const string& strItem, eSysClassType eType/* = eSysClassType::DMM_INVALID*/);


    /******************************************************************************
    *    功  能：添加系统项
    *
    *    参  数：strItem   系统项名称
    *            bStatus   系统项的状态
    *
    *            DF_ST_SYS_NORMAL       正常状态
    *            DF_ST_SYS_EXPIR        软件过期
    *            DF_ST_SYS_DISABLE      失能状态，不可用状态
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 当前App有此接口，但未实现对应功能
    *
    *            其它返回值，暂无意义
    ******************************************************************************/
    uint32_t AddItemEx(const std::string& strItem, uint32_t uStatus/* = DF_ST_SYS_NORMAL*/);
    

    /**********************************************************
    *    功  能：获取App应用排好序（系统扫描顺序）的系统集合
    *            App根据AddItem的系统编号和eSysClassType类型，
    *            按照产品要求的动画效果进行分类与排序
    * 
    *    参  数：无
    * 
    *    返回值：App应用已排好序（扫描顺序）的系统集合
    *            诊断程序按照此顺序进行扫描，满足小车探扫描系统
    *            的动画效果
    *
    *    例 如，当前系统列表中有5个系统，0,2,4系统编号为动力系统类
    *           1,3系统编号为车身控制类
    *           则App可能的返回值为：0,2,4,1,3
    **********************************************************/
    std::vector<uint16_t> GetScanOrder();


    /**********************************************************
    *    功  能：获取指定系统项的文本串
    *    参  数：uIndex 指定的系统项
    *    返回值：string 指定系统项的文本串
    **********************************************************/
    string GetItem(uint16_t uIndex);


    /**********************************************************
    *    功  能：获取当前有故障码的系统项
    *    参  数：无
    *    返回值：有故障码的系统项，
    *             即扫描结果为“DF_ENUM_DTCNUM”的系统集合
    * 
    *     例如，当前系统列表中有5个系统，0,2,4系统编号有故障码，
    *          则返回的vector大小为3,值分别是0,2,4
    **********************************************************/
    std::vector<uint16_t> GetDtcItems();


    /**********************************************************
    *    功  能：设置帮助按钮是否显示，帮助按钮默认不显示
    *    参  数：bIsVisible=true   显示帮助按钮
    *            bIsVisible=false 隐藏帮助按钮
    *    返回值：无
    **********************************************************/
    void SetHelpButtonVisible(bool bIsVisible = true);


    /**********************************************************
    *    功  能：强制设置一键清码按钮是否显示，一键清码按钮默认显示
    * 
    *    参  数：bIsVisible=true   显示一键清码
    *            bIsVisible=false  隐藏一键清码
    * 
    *    返回值：无
    * 
    *    注 意： 在没有调用此接口下，“一键清码”按钮默认显示
    *            显示的条件是存在故障码
    * 
    *            如果SetClearButtonVisible设置为true，是否显示由是
    *            否存在故障码决定
    * 
    *            如果SetClearButtonVisible设置为false，将强制不显示
    *            即使存在故障码也不显示
    * 
    **********************************************************/
    void SetClearButtonVisible(bool bIsVisible = true);


    /**********************************************************
    *    功  能：设置指定系统项的状态
    *    参  数：uIndex 指定的系统项
    *            strStatus 指定系统项的状态
    *            （正在初始化.../正在读码.../正在清码...）
    *    返回值：无
    **********************************************************/
    void SetItemStatus(uint16_t uIndex, const string& strStatus);


    /**********************************************************
    *    功  能：设置指定系统项的扫描结果
    * 
    *    参  数：uIndex 指定的系统项
    *            uResult 指定系统项的最终结果
    *            （不存在/不支持/有码/无码/未知）
    * 
    *    返回值：无
    **********************************************************/
    void SetItemResult(uint16_t uIndex, uint32_t uResult);



    /**********************************************************
    *    功  能：设置指定系统项的ADAS扫描结果
    * 
    *    参  数：uIndex 指定的系统项
    * 
    *            uResult 指定系统项的ADAS结果
    *            （存在ADAS/不存在ADAS）
    * 
    *    返回值：无
    **********************************************************/
    void SetItemAdas(uint16_t uIndex, uint32_t uAdasResult);


    /**************************************************************************************
    *    功  能：设置系统项的软件锁状态
    *
    *    参  数：uIndex    指定的系统项
    *            bStatus   系统项的状态
    *
    *            DF_ST_SYS_NORMAL       正常状态
    *            DF_ST_SYS_EXPIR        软件过期
    *            DF_ST_SYS_DISABLE      失能状态，不可用状态
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    * 
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 当前App有此接口，但未实现对应功能
    * 
    *            其它值，暂无意义
    *
    *    说  明：
    *            如果没有调用此接口，默认的系统项状态为AddItem/AddItemEx中指定的初始状态
    ****************************************************************************************/
    uint32_t SetItemLockStatus(uint16_t uIndex, uint32_t uStatus);


    /**********************************************************
    *    功  能：设置扫描按键是否隐藏，控件默认显示
    *    参  数：bIsHidden=true 按钮区隐藏
    *            bIsHidden=false 按钮区显示
    *    返回值：无
    **********************************************************/
    void SetButtonAreaHidden(bool bIsHidden = true);


    /***************************************************************
    *    功  能：设置“一键扫描”自动开始是否使能
    *
    *    参  数：bEnable   false,  第一次Show不返回DF_ID_SYS_START
    *                      true,   第一次Show返回DF_ID_SYS_START
    *
    *    返回值：默认不开启，如果设置了此参数，诊断应用在调用了
    *            第一次Show以后将开始系统扫描，即第一次Show的返回
    *            值为"DF_ID_SYS_START"
    ***************************************************************/
    void SetAtuoScanEnable(bool bEnable);


    /**********************************************************
    *    功  能：设置系统扫描状态
    * 
    *    参  数：uStatus
    *                DF_SYS_SCAN_PAUSE,   暂停扫描
    *                DF_SYS_SCAN_FINISH,  扫描结束
    *            
    *    返回值：无
    **********************************************************/
    void SetScanStatus(uint32_t uStatus);



    /**********************************************************
    *    功  能：设置一键清码状态
    *
    *    参  数：uStatus
    *               DF_SYS_CLEAR_FINISH,   一键清码结束
    *               DF_SYS_CLEAR_START,   一键清码开始
    * 
    *    返回值：无
    **********************************************************/
    void SetClearStatus(uint32_t uStatus);



    /**********************************************************
    *    功  能：显示系统控件
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *        按键：一键扫描，一键清码，帮助，诊断报告，返回等
    * 
    *     说明
    *        如果返回 DF_ID_SYS_START 表示点击了“一键扫描”
    *       诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_START)通知实现
    *        一键扫描开始
    * 
    *       如果返回 DF_ID_SYS_STOP  表示点击了“暂停”
    *       诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_PAUSE)通知实现
    *        暂停扫描
    * 
    *       如果返回 DF_ID_SYS_ERASE 表示点击了“一键清码”
    *       诊断程序需立即调用SetClearStatus(DF_SYS_CLEAR_START)通知实现
    *        一键清码开始
    **********************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
