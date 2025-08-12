#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegLiveData
{
public:
    CRegLiveData() = delete;
    ~CRegLiveData() = delete;
    
public:
    /*
    *   注册CArtiLiveData的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiLiveData对象时，在CArtiLiveData构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiLiveData的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiLiveData的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiLiveData对象时，在CArtiLiveData的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiLiveData的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   InitTitle 函数说明见 ArtiLiveData.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*******************************************************************
    *    功  能：设置部件测试类型，此接口只针对小车探（国内版TOPVCI）
    *
    *    参  数：uType 部件测试类型
    *
    *            DF_TYPE_THROTTLE_CARBON      节气门积碳检测
    *            DF_TYPE_FULE_CORRECTION      燃油修正控制系统检测
    *            DF_TYPE_MAF_TEST             空气流量传感器检测
    *            DF_TYPE_INTAKE_PRESSURE      进气压力传感器检测
    *            DF_TYPE_OXYGEN_SENSOR        氧传感器检测
    *
    *    返回值：无
    *******************************************************************/
    static void SetComponentType(std::function<void(uint32_t, uint32_t)> fnSetComponentType);


    /*******************************************************************
    *    功  能：设置部件测试结果值，此接口只针对小车探（国内版TOPVCI）
    *
    *    参  数：uResult 结果类型
    *
    *    当部件测试类型为 DF_TYPE_THROTTLE_CARBON 节气门积碳检测
    *    uResult的值可为：
    *        DF_RESULT_THROTTLE_NORMAL        1  发动机节气门运作正常
    *        DF_RESULT_THROTTLE_LIGHT_CARBON  2  节气门疑似有轻微积碳
    *        DF_RESULT_THROTTLE_SERIOUSLY     3  节气门积碳严重
    *
    *    当部件测试类型为 DF_TYPE_FULE_CORRECTION 燃油修正控制系统检测
    *    uResult的值可为：
    *        DF_RESULT_FULE_NORMAL      1 燃油修正正常
    *        DF_RESULT_FULE_HIGH        2 燃油修正偏浓
    *        DF_RESULT_FULE_LOW         3 燃油修正偏稀
    *        DF_RESULT_FULE_ABNORMAL    4 燃油修正异常
    *
    *    当部件测试类型为 DF_TYPE_MAF_TEST 空气流量传感器检测
    *    uResult的值可为：
    *        DF_RESULT_MAF_NORMAL   1  进气量正常
    *        DF_RESULT_MAF_HIGH     2  进气量偏大
    *        DF_RESULT_MAF_LOW      3  进气量偏小
    *
    *    当部件测试类型为 DF_TYPE_INTAKE_PRESSURE 进气压力传感器检测
    *    uResult的值可为：
    *        DF_RESULT_INTAKE_PRESSURE_NORMAL  1  进气压力正常
    *        DF_RESULT_INTAKE_PRESSURE_HIGH    2  进气压力偏高
    *
    *    当部件测试类型为 DF_TYPE_OXYGEN_SENSOR 氧传感器检测
    *    uResult的值可为：
    *         DF_RESULT_OXYGEN_NORMAL  1  氧传感器正常
    *         DF_RESULT_OXYGEN_ERROR   2  氧传感器出现故障
    *
    *
    *    返回值：无
    **********************************************************/
    static void SetComponentResult(std::function<void(uint32_t, uint32_t)> fnSetComponentResult);
    
    
    /*
     *   注册CArtiLiveData的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id, const std::string& strName, const std::string& strValue,
     *                const std::string& strUnit, const std::string& strMin,
     *                const std::string& strMax, const std::string& strReference);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   AddItem 函数说明见 ArtiLiveData.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&,
                                           const std::string&, const std::string&, const std::string&)> fnAddItem);

    /*
     *   注册CArtiLiveData的成员函数SetNextButtonVisible的回调函数
     *
     *   void SetNextButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetNextButtonVisible 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetNextButtonVisible(std::function<void(uint32_t, bool)> fnSetNextButtonVisible);

    /*
     *   注册CArtiLiveData的成员函数SetNextButtonText的回调函数
     *
     *   void SetNextButtonText(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetNextButtonText 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetNextButtonText(std::function<void(uint32_t, const std::string&)> fnSetNextButtonText);
    
    /*
     *   注册CArtiLiveData的成员函数SetPrevButtonVisible的回调函数
     *
     *   void SetPrevButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetPrevButtonVisible 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetPrevButtonVisible(std::function<void(uint32_t, bool)> fnSetPrevButtonVisible);

    /*
     *   注册CArtiLiveData的成员函数SetPrevButtonText的回调函数
     *
     *   void SetPrevButtonText(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetPrevButtonText 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetPrevButtonText(std::function<void(uint32_t, const std::string&)> fnSetPrevButtonText);
    
    /*
     *   注册CArtiLiveData的成员函数SetName的回调函数
     *
     *   void SetName(uint32_t id, uint16_t uIndex, const std::string& strName);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetName 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetName(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetName);

    /*
     *   注册CArtiLiveData的成员函数SetVaule的回调函数
     *
     *   void SetVaule(uint32_t id, uint16_t uIndex, const std::string& strValue);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetVaule 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetVaule(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetVaule);
        
    
    /*
     *   注册CArtiLiveData的成员函数SetUnit的回调函数
     *
     *   void SetUnit(uint32_t id, uint16_t uIndex, const std::string& strUnit);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetUnit 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetUnit(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetUnit);
    
    /*
     *   注册CArtiLiveData的成员函数SetLimits的回调函数
     *
     *   void SetLimits(uint32_t id, uint16_t uIndex, const std::string& strMin, const std::string& strMax);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetLimits 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetLimits(std::function<void(uint32_t, uint16_t, const std::string&, const std::string&)> fnSetLimits);

    /*
     *   注册CArtiLiveData的成员函数SetReference的回调函数
     *
     *   void SetReference(uint32_t id, uint16_t uIndex, const std::string& strReference);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetReference 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetReference(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetReference);

    /*
     *   注册CArtiLiveData的成员函数SetHelpText的回调函数
     *
     *   void SetHelpText(uint32_t id, uint16_t uIndex, const std::string& strHelpText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetHelpText 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetHelpText(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetHelpText);
    
    /*
     *   注册CArtiLiveData的成员函数SetColWidth的回调函数
     *
     *   void SetColWidth(uint32_t id, int32_t widthName, int32_t widthValue, int32_t widthUnit, int32_t widthRef);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   SetColWidth 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void SetColWidth(std::function<void(uint32_t, int32_t, int32_t, int32_t, int32_t)> fnSetColWidth);

    /*
     *   注册CArtiLiveData的成员函数FlushValue的回调函数
     *
     *   void FlushValue(uint32_t id, uint16_t uIndex, const std::string& strValue);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   FlushValue 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void FlushValue(std::function<void(uint32_t, uint16_t, const std::string&)> fnFlushValue);

    /*
     *   注册CArtiLiveData的成员函数GetUpdateItems的回调函数
     *
     *   std::vector<uint16_t> GetUpdateItems(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetUpdateItems 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetUpdateItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetUpdateItems);
    
    /*
     *   注册CArtiLiveData的成员函数GetItemIsUpdate的回调函数
     *
     *   bool GetItemIsUpdate(uint32_t id, uint16_t uIndex);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetItemIsUpdate 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetItemIsUpdate(std::function<bool(uint32_t, uint16_t)> fnGetItemIsUpdate);

    /*
     *   注册CArtiLiveData的成员函数GetSearchItems的回调函数
     *
     *   std::vector<uint16_t> GetSearchItems(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetSearchItems 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetSearchItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetSearchItems);
    
    /*
     *   注册CArtiLiveData的成员函数GetSelectedItems的回调函数
     *
     *   std::vector<uint16_t> GetSelectedItems(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetSelectedItems 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetSelectedItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetSelectedItems);
    
    /*
     *   注册CArtiLiveData的成员函数GetReportItems的回调函数
     *
     *   std::vector<uint16_t> GetReportItems(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetReportItems 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetReportItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetReportItems);

    /*
     *   注册CArtiLiveData的成员函数GetLimitsModifyItems的回调函数
     *
     *   std::vector<uint16_t> GetLimitsModifyItems(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetLimitsModifyItems 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetLimitsModifyItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetLimitsModifyItems);

    /*
     *   注册CArtiLiveData的成员函数GetLimits的回调函数
     *
     *   uint32_t GetLimits(uint32_t id, uint16_t uIndex, std::string& strMin, std::string& strMax);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiLiveData.h的说明
     *
     *   GetLimits 其它参数和返回值说明见 ArtiLiveData.h
     */
    static void GetLimits(std::function<uint32_t(uint32_t, uint16_t, std::string&, std::string&)> fnGetLimits);
    
    /*
     *   注册CArtiLiveData的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiLiveData.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
