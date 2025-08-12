#pragma once
#ifdef __cplusplus
#include "HStdShowMaco.h"
#include "HStdOtherMaco.h"
#include <memory>
#include <functional>
#include <vector>

class CRegReport
{
public:
    CRegReport() = delete;
    ~CRegReport() = delete;
    
public:
    /*
    *   注册CArtiReport的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiReport对象时，在CArtiReport构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiReport的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiReport的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiReport对象时，在CArtiReport的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiReport的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   InitTitle 函数说明见 ArtiReport.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiReport的成员函数SetReportType的回调函数
     *
     *   bool SetReportType(uint32_t id, uint32_t Type);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   Type, 报告类型，
     *                1,        系统诊断报告
     *                2,        故障诊断报告
     *                3,        数据流诊断报告
     *   具体见ArtiReport.h的说明
     *
     *   SetReportType 函数说明见 ArtiReport.h
     */
    static void SetReportType(std::function<bool(uint32_t, uint32_t)> fnSetReportType);
    
    /*
     *   注册CArtiReport的成员函数SetTypeTitle的回调函数
     *
     *   bool SetTypeTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetTypeTitle 函数说明见 ArtiReport.h
     */
    static void SetTypeTitle(std::function<bool(uint32_t, const std::string&)> fnSetTypeTitle);

    /*
     *   注册CArtiReport的成员函数SetDescribeTitle的回调函数
     *
     *   bool SetDescribeTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetDescribeTitle 函数说明见 ArtiReport.h
     */
    static void SetDescribeTitle(std::function<bool(uint32_t, const std::string&)> fnSetDescribeTitle);
    
    /*
     *   注册CArtiReport的成员函数SetSummarize的回调函数
     *
     *   void SetSummarize(uint32_t id, const std::string& strTitle, const std::string& strContent);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetSummarize 函数说明见 ArtiReport.h
     */
    static void SetSummarize(std::function<void(uint32_t, const std::string&, const std::string&)> fnSetSummarize);

    /*
     *   注册CArtiReport的成员函数AddSysItem的回调函数
     *
     *   void AddSysItem(uint32_t id, stSysReportItem& sysItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddSysItem 函数说明见 ArtiReport.h
     */
    static void AddSysItem(std::function<void(uint32_t, stSysReportItem&)> fnAddSysItem);

    /*
     *   注册CArtiReport的成员函数AddSysItemEx的回调函数
     *
     *   void AddSysItemEx(uint32_t id, stSysReportItemEx& sysItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddSysItemEx 函数说明见 ArtiReport.h
     */
    static void AddSysItemEx(std::function<void(uint32_t, stSysReportItemEx&)> fnAddSysItemEx);
    
    /*
     *   注册CArtiReport的成员函数SetSysScanTime的回调函数
     *
     *   void SetSysScanTime(uint32_t id, const std::string& strScanPre, const std::string& strScanPost);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetSysScanTime 函数说明见 ArtiReport.h
     */
    static void SetSysScanTime(std::function<void(uint32_t, const std::string&, const std::string&)> fnSetSysScanTime);
    
    
    /*
     *   注册CArtiReport的成员函数AddSysItems的回调函数
     *
     *   void AddSysItems(uint32_t id, const std::vector<stSysReportItem> &vctItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddSysItems 函数说明见 ArtiReport.h
     */
    static void AddSysItems(std::function<void(uint32_t, const std::vector<stSysReportItem>&)> fnAddSysItems);


    /*
     *   注册CArtiReport的成员函数AddDtcItem的回调函数
     *
     *   void AddDtcItem(uint32_t id, stDtcReportItem& nodeItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddDtcItem 函数说明见 ArtiReport.h
     */
    static void AddDtcItem(std::function<void(uint32_t, stDtcReportItem&)> fnAddDtcItem);


    /*
     *   注册CArtiReport的成员函数AddDtcItems的回调函数
     *
     *   void AddDtcItems(uint32_t id, const std::vector<stDtcReportItem>& vctItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddDtcItems 函数说明见 ArtiReport.h
     */
    static void AddDtcItems(std::function<void(uint32_t, const std::vector<stDtcReportItem>&)> fnAddDtcItems);


    /*
     *   注册CArtiReport的成员函数AddDtcItemEx的回调函数
     *
     *   void AddDtcItemEx(uint32_t id, const tDtcReportItemEx& nodeItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddDtcItemEx 函数说明见 ArtiReport.h
     */
    static void AddDtcItemEx(std::function<void(uint32_t, const stDtcReportItemEx&)> fnAddDtcItemEx);


    /*
     *   注册CArtiReport的成员函数AddDtcItemsEx的回调函数
     *
     *   void AddDtcItemsEx(uint32_t id, const std::vector<stDtcReportItemEx>& vctItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddDtcItemsEx 函数说明见 ArtiReport.h
     */
    static void AddDtcItemsEx(std::function<void(uint32_t, const std::vector<stDtcReportItemEx>&)> fnAddDtcItemsEx);

    /*
     *   注册CArtiReport的成员函数AddLiveDataSys的回调函数
     *
     *   void AddLiveDataSys(uint32_t id, const std::string& strSysId, const std::string& strSysName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddLiveDataSys 函数说明见 ArtiReport.h
     */
    static void AddLiveDataSys(std::function<void(uint32_t, const std::string&, const std::string&)> fnAddLiveDataSys);


    /*
     *   注册CArtiReport的成员函数AddLiveDataItem的回调函数
     *
     *   void AddLiveDataItem(uint32_t id, stDsReportItem& dsItem);
     *   void AddLiveDataItem(uint32_t id, const std::string& strSysName, stDsReportItem& dsItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddLiveDataItem 函数说明见 ArtiReport.h
     */
    static void AddLiveDataItem(std::function<void(uint32_t, stDsReportItem&)> fnAddLiveDataItem);

    static void AddLiveDataItemSysName(std::function<void(uint32_t, const std::string&, stDsReportItem&)> fnAddLiveDataItemSysName);

    /*
     *   注册CArtiReport的成员函数AddLiveDataItems的回调函数
     *
     *   void AddLiveDataItems(uint32_t id, const std::vector<stDsReportItem>& vctItem);
     *   void AddLiveDataItems(uint32_t id, const std::string& strSysName, const std::vector<stDsReportItem>& vctItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   AddLiveDataItems 函数说明见 ArtiReport.h
     */
    static void AddLiveDataItems(std::function<void(uint32_t, const std::vector<stDsReportItem>&)> fnAddLiveDataItems);
    static void AddLiveDataItemsSysName(std::function<void(uint32_t, const std::string&, const std::vector<stDsReportItem>&)> fnAddLiveDataItemsSysName);

    /*
     *   注册CArtiReport的成员函数SetMileage的回调函数
     *
     *   void SetMileage(uint32_t id, const std::string& strMileage, const std::string& strMILOnMileage);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetMileage 函数说明见 ArtiReport.h
     */
    static void SetMileage(std::function<void(uint32_t, const std::string&, const std::string&)> fnSetMileage);

    /*
     *   注册CArtiReport的成员函数SetVehInfo的回调函数
     *
     *   void SetVehInfo(uint32_t id, const std::string& strBrand, const std::string& strModel, const std::string& strYear);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetVehInfo 函数说明见 ArtiReport.h
     */
    static void SetVehInfo(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&)> fnSetVehInfo);

    /*
     *   注册CArtiReport的成员函数SetEngineInfo的回调函数
     *
     *   void SetEngineInfo(uint32_t id, const std::string& strInfo, const std::string& strSubType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetEngineInfo 函数说明见 ArtiReport.h
     */
    static void SetEngineInfo(std::function<void(uint32_t, const std::string&, const std::string&)> fnSetEngineInfo);
    
    /*
     *   注册CArtiReport的成员函数SetVehPath的回调函数
     *
     *   void SetVehPath(uint32_t id, const std::string& strVehPath);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetVehPath 函数说明见 ArtiReport.h
     */
    static void SetVehPath(std::function<void(uint32_t, const std::string&)> fnSetVehPath);

    /*
     *   注册CArtiReport的成员函数SetAdasCaliResult的回调函数
     *
     *   void SetAdasCaliResult(uint32_t id, const std::vector<stReportAdasResult>& vctSysItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiReport.h的说明
     *
     *   SetAdasCaliResult 函数说明见 ArtiReport.h
     */
    static void SetAdasCaliResult(std::function<void(uint32_t, const std::vector<stReportAdasResult>&)> fnSetAdasCaliResult);
    
    /*
     *   注册CArtiReport的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiReport.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif

