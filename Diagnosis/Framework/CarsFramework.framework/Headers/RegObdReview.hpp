#pragma once
#ifdef __cplusplus
#include "HStdOtherMaco.h"

#include <string>
#include <memory>
#include <functional>
#include <vector>

class CRegObdReview
{
public:
    CRegObdReview() = delete;
    ~CRegObdReview() = delete;
    
public:
    /*
    *   注册CArtiObdReview的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiObdReview对象时，在CArtiObdReview构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiObdReview的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiObdReview的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiObdReview对象时，在CArtiObdReview的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiObdReview的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   InitTitle 函数说明见 ArtiObdReview.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiObdReview的成员函数SetProtocol的回调函数
     *
     *   bool SetProtocol(uint32_t id, bool bCommOK, const std::string& strProtocol);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   Type, 报告类型，
     *                1,        系统诊断报告
     *                2,        故障诊断报告
     *                3,        数据流诊断报告
     *   具体见ArtiObdReview.h的说明
     *
     *   SetProtocol 函数说明见 ArtiObdReview.h
     */
    static void SetProtocol(std::function<bool(uint32_t, bool, const std::string&)> fnSetProtocol);
    
    /*
     *   注册CArtiObdReview的成员函数SetReportResult的回调函数
     *
     *   void SetReportResult(uint32_t id, eResultType eResult);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetReportResult 函数说明见 ArtiObdReview.h
     */
    static void SetReportResult(std::function<void(uint32_t, uint32_t)> fnSetReportResult);

    /*
     *   注册 CArtiObdReview 的成员函数 SetReCheckResult 的回调函数
     *
     *   void SetReCheckResult(uint32_t id, uint32_t eResult);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetReCheckResult 函数说明见 ArtiObdReview.h
     */
    static void SetReCheckResult(std::function<void(uint32_t, uint32_t)> fnSetReCheckResult);

    /*
     *   注册CArtiObdReview的成员函数SetNeedReCheck的回调函数
     *
     *   void SetNeedReCheck(uint32_t id, bool isNeed, const std::string& strReCheck);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetNeedReCheck 函数说明见 ArtiObdReview.h
     */
    static void SetNeedReCheck(std::function<void(uint32_t, bool, const std::string&)> fnSetNeedReCheck);

    /*
     *   注册CArtiObdReview的成员函数SetMILStatus的回调函数
     *
     *   void SetMILStatus(uint32_t id, bool bMILStatus);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetMILStatus 函数说明见 ArtiObdReview.h
     */
    static void SetMILStatus(std::function<void(uint32_t, bool)> fnSetMILStatus);

    /*
     *   注册 CArtiObdReview 的成员函数 SetObdStatus 的回调函数
     *
     *   void SetObdStatus(uint32_t id, uint32_t eResult);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetObdStatus 函数说明见 ArtiObdReview.h
     */
    static void SetObdStatus(std::function<void(uint32_t, uint32_t)> fnSetObdStatus);

    /*
     *   注册CArtiObdReview的成员函数SetMILOnMileage的回调函数
     *
     *   void SetMILOnMileage(uint32_t id, const std::string& strMILOnMileage);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetMILOnMileage 函数说明见 ArtiObdReview.h
     */
    static void SetMILOnMileage(std::function<void(uint32_t, const std::string&)> fnSetMILOnMileage);
    
    /*
     *   注册CArtiObdReview的成员函数 AddReadinessMainType 的回调函数
     *
     *   void AddReadinessMainType(uint32_t id, const std::string& strName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddReadinessMainType 函数说明见 ArtiObdReview.h
     */
    static void AddReadinessMainType(std::function<void(uint32_t, const std::string&)> fnAddReadinessMainType);

    /*
     *   注册CArtiObdReview的成员函数AddReadinessStatusItems的回调函数
     *
     *   void AddReadinessStatusItems(uint32_t id, const std::string& strName, uint32_t Status);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddReadinessStatusItems 函数说明见 ArtiObdReview.h
     */
    static void AddReadinessStatusItems(std::function<void(uint32_t, const std::string&, uint32_t)> fnAddReadinessStatusItems);

    /*
     *   注册CArtiObdReview的成员函数AddEcuInfoItems的回调函数
     *
     *   void AddEcuInfoItems(uint32_t id, const std::string& strName, const std::vector<std::string>& vctCALID, const std::vector<std::string>& vctCVN);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddEcuInfoItems 函数说明见 ArtiObdReview.h
     */
    static void AddEcuInfoItems(std::function<void(uint32_t, const std::string&, const std::vector<std::string>&, const std::vector<std::string>&)> fnAddEcuInfoItems);

    /*
     *   注册CArtiObdReview的成员函数AddDtcItem的回调函数
     *
     *   void AddDtcItem(uint32_t id, const stDtcNodeEx& dtcItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddDtcItem 函数说明见 ArtiObdReview.h
     */
    static void AddDtcItem(std::function<void(uint32_t, const stDtcNodeEx&)> fnAddDtcItem);


    /*
     *   注册CArtiObdReview的成员函数AddDtcItems的回调函数
     *
     *   void AddDtcItems(uint32_t id, const std::vector<stDtcNodeEx>& vctItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddDtcItems 函数说明见 ArtiObdReview.h
     */
    static void AddDtcItems(std::function<void(uint32_t, const std::vector<stDtcNodeEx>&)> fnAddDtcItems);

    /*
     *   注册CArtiObdReview的成员函数 AddLiveDataMainType 的回调函数
     *
     *   void AddLiveDataMainType(uint32_t id, const std::string& strName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddLiveDataMainType 函数说明见 ArtiObdReview.h
     */
    static void AddLiveDataMainType(std::function<void(uint32_t, const std::string&)> fnAddLiveDataMainType);

    /*
     *   注册CArtiObdReview的成员函数AddLiveDataItem的回调函数
     *
     *   void AddLiveDataItem(uint32_t id, stDsReportItem& dsItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddLiveDataItem 函数说明见 ArtiObdReview.h
     */
    static void AddLiveDataItem(std::function<void(uint32_t, stDsReportItem&)> fnAddLiveDataItem);


    /*
     *   注册CArtiObdReview的成员函数AddLiveDataItems的回调函数
     *
     *   void AddLiveDataItems(uint32_t id, const std::vector<stDsReportItem>& vctItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddLiveDataItems 函数说明见 ArtiObdReview.h
     */
    static void AddLiveDataItems(std::function<void(uint32_t, const std::vector<stDsReportItem>&)> fnAddLiveDataItems);


    /*
     *   注册CArtiObdReview的成员函数 AddIUPRMainType 的回调函数
     *
     *   void AddIUPRMainType(uint32_t id, const std::string& strName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddIUPRMainType 函数说明见 ArtiObdReview.h
     */
    static void AddIUPRMainType(std::function<void(uint32_t, const std::string&)> fnAddIUPRMainType);


    /*
     *   注册CArtiObdReview的成员函数AddIUPRStatusItem的回调函数
     *
     *   void AddIUPRStatusItem(uint32_t id, const std::string& strName, const std::string& strStatus);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   AddIUPRStatusItem 函数说明见 ArtiObdReview.h
     */
    static void AddIUPRStatusItem(std::function<void(uint32_t, const std::string&, const std::string&)> fnAddIUPRStatusItem);

    /*
     *   注册CArtiObdReview的成员函数SetEngineInfo的回调函数
     *
     *   void SetEngineInfo(uint32_t id, const std::string& strInfo, const std::string& strSubType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiObdReview.h的说明
     *
     *   SetEngineInfo 函数说明见 ArtiObdReview.h
     */
    static void SetEngineInfo(std::function<void(uint32_t, const std::string&, const std::string&)> fnSetEngineInfo);

    /*
     *   注册CArtiObdReview的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiObdReview.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif

