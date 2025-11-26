#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include <string>

class CRegSystem
{
public:
    CRegSystem() = delete;
    ~CRegSystem() = delete;
    
public:
    /*
    *   注册CArtiSystem的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiSystem对象时，在CArtiSystem构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiSystem的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiSystem的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiSystem对象时，在CArtiSystem的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiSystem的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   CArtiSystem 函数说明见 ArtiSystem.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   注册CArtiSystem的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const string& strTitle, eSysScanType eType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   CArtiSystem 函数说明见 ArtiSystem.h
     */
    static void InitTitleWithType(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTitleWithType);
    
    /*
     *   注册CArtiSystem的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id, const std::string& strItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   AddItem 函数说明见 ArtiSystem.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&)> fnAddItem);

    /*
     *   注册CArtiSystem的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id, const std::string& strItem, eSysClassType eType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   AddItem 函数说明见 ArtiSystem.h
     */
    static void AddItemWithType(std::function<void(uint32_t, const std::string&, uint32_t)> fnAddItem);
    
    /*
     *   注册CArtiSystem的成员函数GetScanOrder的回调函数
     *
     *   std::vector<uint16_t> GetScanOrder(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   GetScanOrder 其它参数和返回值说明见 ArtiSystem.h
     */
    static void GetScanOrder(std::function<std::vector<uint16_t>(uint32_t)> fnGetScanOrder);
    
    /*
    *   注册CArtiSystem的成员函数GetItem的回调函数
    *
    *   std::string const GetItem(uint32_t id, uint16_t uIndex);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiSystem.h的说明
    *
    *   GetItem 其它参数和返回值说明见 ArtiSystem.h
    */
    static void GetItem(std::function<std::string const(uint32_t, uint16_t)> fnGetItem);

    /*
     *   注册CArtiSystem的成员函数GetDtcItems的回调函数
     *
     *   std::vector<uint16_t> GetDtcItems(uint32_t id);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   GetDtcItems 其它参数和返回值说明见 ArtiSystem.h
     */
    static void GetDtcItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetDtcItems);

    /*
     *   注册CArtiSystem的成员函数SetHelpButtonVisible的回调函数
     *
     *   void SetHelpButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetHelpButtonVisible 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetHelpButtonVisible(std::function<void(uint32_t, bool)> fnSetHelpButtonVisible);

    /*
     *   注册CArtiSystem的成员函数SetClearButtonVisible的回调函数
     *
     *   void SetClearButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetClearButtonVisible 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetClearButtonVisible(std::function<void(uint32_t, bool)> fnSetClearButtonVisible);

    /*
     *   注册CArtiSystem的成员函数SetItemStatus的回调函数
     *
     *   void SetItemStatus(uint32_t id, uint16_t uIndex, const std::string& strStatus);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetItemStatus 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetItemStatus(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetItemStatus);

    /*
     *   注册CArtiSystem的成员函数SetItemResult的回调函数
     *
     *   void SetItemResult(uint32_t id, uint16_t uIndex, uint32_t uResult);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetItemResult 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetItemResult(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetItemResult);
    
    /*
     *   注册CArtiSystem的成员函数SetItemAdas的回调函数
     *
     *   void SetItemAdas(uint32_t id, uint16_t uIndex, uint32_t uAdasResult);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetItemAdas 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetItemAdas(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetItemAdas);
    
    /*
     *   注册CArtiSystem的成员函数SetButtonAreaHidden的回调函数
     *
     *   void SetButtonAreaHidden(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetButtonAreaHidden 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetButtonAreaHidden(std::function<void(uint32_t, bool)> fnSetButtonAreaHidden);

    /*
     *   注册CArtiSystem的成员函数SetAtuoScanEnable的回调函数
     *
     *   void SetAtuoScanEnable(uint32_t id, bool bEnable);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetAtuoScanEnable 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetAtuoScanEnable(std::function<void(uint32_t, bool)> fnSetAtuoScanEnable);
    
    /*
     *   注册CArtiSystem的成员函数SetScanStatus的回调函数
     *
     *   void SetScanStatus(uint32_t id, uint32_t uStatus);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetScanStatus 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetScanStatus(std::function<void(uint32_t, uint32_t)> fnSetScanStatus);

    /*
     *   注册CArtiSystem的成员函数SetScanStatus的回调函数
     *
     *   void SetClearStatus(uint32_t id, uint32_t uStatus);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiSystem.h的说明
     *
     *   SetClearStatus 其它参数和返回值说明见 ArtiSystem.h
     */
    static void SetClearStatus(std::function<void(uint32_t, uint32_t)> fnSetClearStatus);

    /*
     *   注册CArtiSystem的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiSystem.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
