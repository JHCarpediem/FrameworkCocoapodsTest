#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include "HStdOtherMaco.h"
class CRegTrouble
{
public:
    CRegTrouble() = default;
    ~CRegTrouble() = default;

public:
    /*
    *   注册CArtiTrouble的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiTrouble对象时，在CArtiTrouble构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiTrouble的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiTrouble的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiTrouble对象时，在CArtiTrouble的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiTrouble的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   CArtiTrouble 函数说明见 ArtiTrouble.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   注册CArtiTrouble的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id, const std::string& strTroubleCode, const std::string& strTroubleDesc, const std::string& strTroubleStatus, const std::string& strTroubleHelp);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   AddItem 函数说明见 ArtiTrouble.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&)> fnAddItem);

    /*
     *   注册CArtiTrouble的成员函数AddItemEx的回调函数
     *
     *   void AddItemEx(uint32_t id, const stDtcNodeEx& nodeItem, const std::string& strTroubleHelp);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   AddItemEx 函数说明见 ArtiTrouble.h
     */
    static void AddItemEx(std::function<void(uint32_t, const stDtcNodeEx&, const std::string&)> fnAddItemEx);

    
    /*
     *   注册CArtiTrouble的成员函数SetItemHelp的回调函数
     *
     *   void SetItemHelp(uint32_t id, uint8_t uIndex, const std::string& strToubleHelp);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   SetItemHelp 其它参数和返回值说明见 ArtiTrouble.h
     */
    static void SetItemHelp(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetItemHelp);
    
    /*
     *   注册CArtiTrouble的成员函数SetMILStatus的回调函数
     *
     *   void SetMILStatus(uint32_t id, uint16_t uIndex, bool bIsShow);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   SetMILStatus 其它参数和返回值说明见 ArtiTrouble.h
     */
    static void SetMILStatus(std::function<void(uint32_t, uint16_t, bool)> fnSetMILStatus);

    /*
     *   注册CArtiTrouble的成员函数SetFreezeStatus的回调函数
     *
     *   void SetFreezeStatus(uint32_t id, uint16_t uIndex, bool bIsShow);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   SetFreezeStatus 其它参数和返回值说明见 ArtiTrouble.h
     */
    static void SetFreezeStatus(std::function<void(uint32_t, uint16_t, bool)> fnSetFreezeStatus);

    /*
     *   注册CArtiTrouble的成员函数SetCdtcButtonVisible的回调函数
     *
     *   void SetCdtcButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   SetCdtcButtonVisible 其它参数和返回值说明见 ArtiTrouble.h
     */
    static void SetCdtcButtonVisible(std::function<void(uint32_t, bool)> fnSetCdtcButtonVisible);
    
    /*
     *   注册CArtiTrouble的成员函数SetRepairManualInfo的回调函数
     *
     *   bool SetRepairManualInfo(uint32_t id, const std::vector<stRepairInfoItem>& vctDtcInfo);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiTrouble.h的说明
     *
     *   SetRepairManualInfo 其它参数和返回值说明见 ArtiTrouble.h
     */
    static void SetRepairManualInfo(std::function<bool(uint32_t, const std::vector<stRepairInfoItem>&)> fnSetRepairManualInfo);

    /*
     *   注册CArtiTrouble的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiList.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
