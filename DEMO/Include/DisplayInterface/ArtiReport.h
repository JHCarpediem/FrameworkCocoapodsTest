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
#ifndef _ARTIREPORT_H_
#define _ARTIREPORT_H_
#include "StdInclude.h"
#include "StdShowMaco.h"


// 建议开发工程师在诊断报告编码前，参考产品经理给的UI参考图

/*
    诊断报告分为3种类型
    1、系统诊断报告
    2、故障诊断报告
    3、数据流诊断报告
    4、冻结帧诊断报告
*/


class _STD_SHOW_DLL_API_ CArtiReport
{
public:
    /* 诊断报告类型 */
    enum eReportType
    {
        REPORT_TYPE_SYSTEM         = 1,           /* 系统诊断报告 */
        REPORT_TYPE_DTC            = 2,           /* 故障诊断报告 */
        REPORT_TYPE_DATA_STREAM    = 3,           /* 数据流诊断报告 */
        REPORT_TYPE_FREEZE_FRAME   = 4,           /* 冻结帧诊断报告 */

        REPORT_TYPE_ADAS_SYSTEM         = 0x11,   /* ADAS系统扫描-系统诊断报告 */
        REPORT_TYPE_ADAS_DTC            = 0x12,   /* ADAS故障诊断报告 */
        REPORT_TYPE_ADAS_DATA_STREAM    = 0x13,   /* ADAS数据流诊断报告 */
        REPORT_TYPE_ADAS_SIGNLE_SYSTEM  = 0x14,   /* ADAS单系统诊断报告（进入系统内的报告） */

        REPORT_TYPE_INVALID = 0xFF            
    };

public:
    CArtiReport();
#ifdef MULTI_SYSTEM
    CArtiReport(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiReport();


    /*-----------------------------------------------------------------------------
    *    功  能：初始化诊断报告显示控件，同时设置标题文本
    * 
    *    参  数：strTitle 标题文本
    * 
    *    返回值：true 初始化成功 false 初始化失败
    -----------------------------------------------------------------------------*/
    bool InitTitle(const std::string& strTitle);



    /*-----------------------------------------------------------------------------
    *    功  能：设置诊断报告类型
    *
    *    参  数：Type 诊断报告类型
    * 
    *        REPORT_TYPE_SYSTEM        = 1,            系统诊断报告 
    *        REPORT_TYPE_DTC           = 2,            故障诊断报告 
    *        REPORT_TYPE_DATA_STREAM   = 3,            数据流诊断报告 
    * 
    *       REPORT_TYPE_ADAS_SYSTEM      = 0x11,       ADAS系统诊断报告 
    *       REPORT_TYPE_ADAS_DTC         = 0x12,       ADAS故障诊断报告 
    *       REPORT_TYPE_ADAS_DATA_STREAM = 0x13,       ADAS数据流诊断报告
    *
    *    返回值：true 设置成功 false 设置失败
    -----------------------------------------------------------------------------*/
    bool SetReportType(eReportType Type);


    /*-----------------------------------------------------------------------------
    *    功  能：设置诊断报告类型标题
    *
    *    参  数：strTitle 标题文本
    *            "系统诊断报告状态(59)"
    *            "故障码(39)"
    *            "数据流(62)"
    *            "冻结帧"
    *
    *    返回值：true 初始化成功 false 初始化失败
    -----------------------------------------------------------------------------*/
    bool SetTypeTitle(const std::string& strTitle);


    /*-----------------------------------------------------------------------------
    *    功  能：设置诊断报告描述部分的标题
    *
    *    参  数：strTitle 标题文本
    *            "2015-09奥迪"
    *
    *    返回值：true 初始化成功 false 初始化失败
    -----------------------------------------------------------------------------*/
    bool SetDescribeTitle(const std::string& strTitle);


    /*-----------------------------------------------------------------------------
    功    能：设置车辆诊断报告概述，概述只在系统报告类型中存在

    参数说明：
              strTitle                车辆诊断报告概述的标题，例如，"概述"

              strContent            车辆诊断报告概述的内容，例如，"总共扫描出12个
                                    系统，其中12个系统故障，故障数量为105个。为了
                                    安全驾驶请你仔细阅读分析报告，并修复相关故障
                                    信息组件，及时处理排查。"

    返回值：诊断程序如果没有设置此接口，报告将不显示“概述”项

    注  意：仅适用于 REPORT_TYPE_SYSTEM 类型
    -----------------------------------------------------------------------------*/
    void SetSummarize(const std::string& strTitle, const std::string& strContent);


    /*-----------------------------------------------------------------------------
    *    功  能：添加系统列表项
    *
    *    参  数：sysItem        系统列表项，参考 stSysReportItem 定义
    *
    *
    *    返回值：无
    *
    *    说  明：仅适用于 REPORT_TYPE_SYSTEM 类型
    -----------------------------------------------------------------------------*/
    void AddSysItem(stSysReportItem& sysItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加系统列表项数组
    *
    *    参  数：vctItem        系统诊断报告对应的系统项的数组，数组大小即列大小
    *
    *    返回值：无
    *
    *    说  明：仅适用于 REPORT_TYPE_SYSTEM 类型
    -----------------------------------------------------------------------------*/
    void AddSysItems(const std::vector<stSysReportItem> &vctItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加扩展功能的系统列表项
    *
    *    参  数：sysItem        系统列表项，参考 stSysReportItemEx 定义
    *
    *
    *    返回值：无
    *
    *    说  明：仅适用于 REPORT_TYPE_ADAS_SYSTEM 类型
    -----------------------------------------------------------------------------*/
    void AddSysItemEx(stSysReportItemEx& sysItem);


    /*-----------------------------------------------------------------------------
    *    功  能：设置系统报告的扫描前（校准前）时间和扫描后（校准后）时间
    *
    *    参  数：strScanPre       扫描前（校准前）时间，例如："2022-06-27 20:54:29"
    *            strScanPost      扫描后（校准后）时间，例如："2022-06-27 20:59:48"
    *
    *
    *    返回值：无
    *
    *    说  明：仅适用于 REPORT_TYPE_ADAS_SYSTEM 类型
    -----------------------------------------------------------------------------*/
    void SetSysScanTime(const std::string& strScanPre, const std::string& strScanPost);


    /*-----------------------------------------------------------------------------
    *    功  能：添加故障码列表项
    *
    *    参  数：nodeItem    故障码列表项， 参考stDtcReportItem的定义
    *
    *    返回值：无
    *
    *    说  明：故障码数组，包含了此系统下的所有故障码
    *            适用于 REPORT_TYPE_SYSTEM 类型 和 REPORT_TYPE_DTC 类型
    -----------------------------------------------------------------------------*/
    void AddDtcItem(stDtcReportItem & nodeItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加故障码列表
    *
    *    参  数：vctItem        故障码列表项数组， 参考stDtcReportItem的定义

    *    返回值：无
    *
    *    说  明：故障码数组，包含了此系统下的所有故障码
    *            适用于 REPORT_TYPE_SYSTEM 类型 和 REPORT_TYPE_DTC 类型
    -----------------------------------------------------------------------------*/
    void AddDtcItems(const std::vector<stDtcReportItem>& vctItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加故障码列表项
    *
    *    参  数：nodeItem    故障码列表项， 参考stDtcReportItemEx的定义
    *
    *    返回值：无
    *
    *    说  明：故障码数组，包含了此系统下的所有故障码
    *            适用于 REPORT_TYPE_SYSTEM 类型 和 REPORT_TYPE_DTC 类型
    -----------------------------------------------------------------------------*/
    void AddDtcItemEx(const stDtcReportItemEx& nodeItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加故障码列表
    *
    *    参  数：vctItem        故障码列表项数组， 参考stDtcReportItemEx的定义

    *    返回值：无
    *
    *    说  明：故障码数组，包含了此系统下的所有故障码
    *            适用于 REPORT_TYPE_SYSTEM 类型 和 REPORT_TYPE_DTC 类型
    -----------------------------------------------------------------------------*/
    void AddDtcItemsEx(const std::vector<stDtcReportItemEx>& vctItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加数据流系统名称
    *
    *    参  数：
    *            std::string strID    系统ID, 如果无，则置空
    *            std::string strName  系统Name，此名称不能为空，如空则添加无效
    * 
    *    返回值：无
    *
    *    说  明：适用于 REPORT_TYPE_DATA_STREAM 类型
    -----------------------------------------------------------------------------*/
    void AddLiveDataSys(const std::string& strSysId, const std::string& strSysName);


    /*-----------------------------------------------------------------------------
    *    功  能：添加数据流列表项
    *
    *    参  数：strSysName   数据流所属的系统名称
    *            dsItem       数据流列表项， 参考stDsReportItem的定义
    *
    *    返回值：无
    *
    *    说  明：适用于 REPORT_TYPE_DATA_STREAM 类型 和 REPORT_TYPE_ADAS_DATA_STREAM 类型
    *            AddLiveDataItem调用前必须先调用AddLiveDataSys或者SetAdasCaliResult
    -----------------------------------------------------------------------------*/
    void AddLiveDataItem(stDsReportItem& dsItem);
    void AddLiveDataItem(const std::string& strSysName, stDsReportItem& dsItem);


    /*-----------------------------------------------------------------------------
    *    功  能：添加数据流列表
    *
    *    参  数：vctItem   数据流所属的系统名称
    *            vctItem   数据流列表项数组， 参考stDsReportItem的定义
    *
    *    返回值：无
    *
    *    说  明：适用于 REPORT_TYPE_DATA_STREAM 类型 和 REPORT_TYPE_ADAS_DATA_STREAM 类型
    *            AddLiveDataItems调用前必须先调用AddLiveDataSys或者SetAdasCaliResult
    -----------------------------------------------------------------------------*/
    void AddLiveDataItems(const std::vector<stDsReportItem>& vctItem);
    void AddLiveDataItems(const std::string& strSysName, const std::vector<stDsReportItem>& vctItem);



    /*-----------------------------------------------------------------------------
    功能：设置车辆行驶里程（KM）

    参数说明：诊断设置当前车辆行驶总里程（KM）

            strMileage            当前车辆行驶总里程（KM）
            strMILOnMileage        故障灯亮后的行驶里程（KM）

            例如：568        表示行驶总里程为568KM

    返回值：

    说  明：如果无“故障灯亮后的行驶里程”，则strMILOnMileage为空串""或空
    -----------------------------------------------------------------------------*/
    void SetMileage(const std::string& strMileage, const std::string& strMILOnMileage);



    /*-----------------------------------------------------------------------------
    功能：设置车辆品牌信息

    参数说明：
            strBrand            车辆品牌，例如“宝马”
            strModel            车型，例如“320i”
            strYear                年份，例如“2021”

    返回值：
    -----------------------------------------------------------------------------*/
    void SetVehInfo(const std::string& strBrand, const std::string& strModel, const std::string& strYear);



    /*-----------------------------------------------------------------------------
    功能：设置车辆发动机信息

    参数说明：
            strInfo                发动机机信息，例如，"F62-D52"
            strSubType            发动机子型号或者其它信息，例如，"N542"

    返回值：
    -----------------------------------------------------------------------------*/
    void SetEngineInfo(const std::string& strInfo, const std::string& strSubType);



    /*-----------------------------------------------------------------------------
    功能：设置诊断路径

    参数说明：
            strVehPath            例如，"宝马>320>系统>自动扫描"

    返回值：
    -----------------------------------------------------------------------------*/
    void SetVehPath(const std::string& strVehPath);


    /*----------------------------------------------------------------------------------
    *    功  能：设置ADAS报告的ADAS执行信息结果展示状态
    *
    *    参  数：
    *            vctSysItem  系统结果信息项
    * 
    *            struct stReportAdasResult
    *            {
    *                std::string  strSysName;  系统Name，此名称不能为空，如空则添加无效
    *                std::string  strStartTime;校准开始时间，例如："2022-06-27 20:55:40"
    *                std::string  strStopTime; 校准结束时间，例如："2022-06-27 20:56:48"
    *                uint32_t     uTotalTimeS; 总校准耗时时间，单位为秒
    *                uint32_t     uType;       ADAS系统校准类型
    *                                          0   静态校准
    *                                          1   动态校准
    *                uint32_t     uStatus;     系统校准结果状态
    *                                          0   ADAS校准OK
    *                                          1   ADAS校准失败
    *            };
    *            
    *
    *    返回值：无
    *
    *    说  明：没有调用此接口，即无ADAS校准记录
    *            适用于ADAS相关的诊断报告
    ----------------------------------------------------------------------------------*/
    void SetAdasCaliResult(const std::vector<stReportAdasResult>& vctSysItem);



    /*-----------------------------------------------------------------------------
    *    功  能：显示诊断报告
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 组件界面按键返回值
    *    按键：返回
    -----------------------------------------------------------------------------*/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
