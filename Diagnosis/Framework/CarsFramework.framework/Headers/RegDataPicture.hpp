#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include "HStdShowMaco.h"
#include "HStdOtherMaco.h"

class CRegDataPicture
{
public:
    CRegDataPicture() = delete;
    ~CRegDataPicture() = delete;
    
public:
    /*
    *   注册CArtiDataPicture的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiDataPicture对象时，在CArtiDataPicture构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiDataPicture的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiDataPicture的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiDataPicture对象时，在CArtiDataPicture的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiDataPicture的成员函数InitTitle的回调函数
     *
     *   uint32_t InitTitle(uint32_t id, const std::string& strTitle, uint32_t uType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   InitTitle 函数说明见 ArtiDataPicture.h
     */
    static void InitTitle(std::function<uint32_t(uint32_t, const std::string&, uint32_t)> fnInitTitle);

    /*
     *   注册CArtiDataPicture的成员函数SetItem的回调函数
     *
     *   uint32_t SetItem(uint32_t id, const std::string& strLdID, const stLiveDataItem& ldItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetItem 函数说明见 ArtiDataPicture.h
     */
    static void SetItem(std::function<uint32_t(uint32_t, const std::string&, const stLiveDataItem&)> fnSetItem);

    /*
     *   注册CArtiDataPicture的成员函数SetInformation的回调函数
     *
     *   uint32_t SetInformation(uint32_t id, const std::string& strLdID, const std::vector<stLdInformation>& vctInfor);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetInformation 函数说明见 ArtiDataPicture.h
     */
    static void SetInformation(std::function<uint32_t(uint32_t, const std::string&, const std::vector<stLdInformation>&)> fnSetInformation);

    /*
     *   注册CArtiDataPicture的成员函数SetName的回调函数
     *
     *   uint32_t SetName(uint32_t id, const std::string& strLdID, const std::string& strName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetName 函数说明见 ArtiDataPicture.h
     */
    static void SetName(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnSetName);

    /*
     *   注册CArtiDataPicture的成员函数SetVaule的回调函数
     *
     *   uint32_t SetVaule(uint32_t id, const std::string& strLdID, const std::string& strValue);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetVaule 函数说明见 ArtiDataPicture.h
     */
    static void SetVaule(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnSetVaule);

    /*
     *   注册CArtiDataPicture的成员函数SetUnit的回调函数
     *
     *   uint32_t SetUnit(uint32_t id, const std::string& strLdID, const std::string& strUnit);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetUnit 函数说明见 ArtiDataPicture.h
     */
    static void SetUnit(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnSetUnit);

    /*
     *   注册CArtiDataPicture的成员函数SetLimits的回调函数
     *
     *   uint32_t SetLimits(uint32_t id, const std::string& strLdID, const std::string& strMin, const std::string& strMax);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetLimits 函数说明见 ArtiDataPicture.h
     */
    static void SetLimits(std::function<uint32_t(uint32_t, const std::string&, const std::string&, const std::string&)> fnSetLimits);

    /*
     *   注册CArtiDataPicture的成员函数SetReference的回调函数
     *
     *   uint32_t SetReference(uint32_t id, const std::string& strLdID, const std::string& strReference);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetReference 函数说明见 ArtiDataPicture.h
     */
    static void SetReference(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnSetReference);

    /*
     *   注册CArtiDataPicture的成员函数SetHelpText的回调函数
     *
     *   uint32_t SetHelpText(uint32_t id, const std::string& strLdID, const std::string& strHelpText);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetHelpText 函数说明见 ArtiDataPicture.h
     */
    static void SetHelpText(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnSetHelpText);

    /*
     *   注册CArtiDataPicture的成员函数FlushValue的回调函数
     *
     *   uint32_t FlushValue(uint32_t id, const std::string& strLdID, const std::string& strValue);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   FlushValue 函数说明见 ArtiDataPicture.h
     */
    static void FlushValue(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnFlushValue);

    /*
     *   注册CArtiDataPicture的成员函数GetUpdateItems的回调函数
     *
     *   std::vector<std::string> GetUpdateItems(uint32_t id, uint32_t Priority);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   GetUpdateItems 函数说明见 ArtiDataPicture.h
     */
    static void GetUpdateItems(std::function<std::vector<std::string>(uint32_t, uint32_t)> fnGetUpdateItems);

    /*
     *   注册CArtiDataPicture的成员函数SetMILStatus的回调函数
     *
     *   uint32_t SetMILStatus(uint32_t id, bool bMILStatus);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetMILStatus 函数说明见 ArtiDataPicture.h
     */
    static void SetMILStatus(std::function<uint32_t(uint32_t, bool)> fnSetMILStatus);

    /*
     *   注册CArtiDataPicture的成员函数SetVehFuleType的回调函数
     *
     *   uint32_t SetVehFuleType(uint32_t id, uint32_t uFuleType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiDataPicture.h的说明
     *
     *   SetVehFuleType 函数说明见 ArtiDataPicture.h
     */
    static void SetVehFuleType(std::function<uint32_t(uint32_t, uint32_t)> fnSetVehFuleType);

    /*
     *   注册CArtiDataPicture的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiDataPicture.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
