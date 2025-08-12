#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegActive
{
public:
    CRegActive(){}
    ~CRegActive(){}
    
public:
    
   /*
    *   注册CArtiActive的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiActive对象时，在CArtiActive构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiActive的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiActive的成员函数InitTitle
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiActive实例调用了 InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiActive的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiActive对象时，在CArtiActive的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiActive的成员函数InitTitle的回调函数
     *
     *   void InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   InitTitle 函数说明见 ArtiActive.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiActive的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id,
     *                const std::string& strItem,
     *                const std::string& strValue,
     *                bool bIsLocked,
     *                const std::string& strUnit);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   AddItem 函数说明见 ArtiActive.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&, bool, const std::string&)> fnAddItem);

    /*
     *   注册CArtiActive的成员函数GetUpdateItems的回调函数
     *
     *   std::vector<uint16_t> GetUpdateItems(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   GetUpdateItems 函数说明见 ArtiActive.h
     */
    static void GetUpdateItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetUpdateItems);

    /*
     *   注册CArtiActive的成员函数SetValue的回调函数
     *
     *   void SetValue(uint32_t id, uint16_t uIndex, const std::string& strValue);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetValue 函数说明见 ArtiActive.h
     */
    static void SetValue(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetValue);

    /*
     *   注册CArtiActive的成员函数SetItem的回调函数
     *
     *   void SetItem(uint32_t id, uint16_t uIndex, const std::string& strItem);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetItem 函数说明见 ArtiActive.h
     */
    static void SetItem(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetItem);
    
    /*
     *   注册CArtiActive的成员函数SetUnit的回调函数
     *
     *   void SetUnit(uint32_t id, uint16_t uIndex, const std::string& strUnit);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetUnit 函数说明见 ArtiActive.h
     */
    static void SetUnit(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetUnit);
    
    /*
     *   注册CArtiActive的成员函数SetOperationTipsOnTop的回调函数
     *
     *   void SetOperationTipsOnTop(uint32_t id, const std::string& strOperationTips);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetOperationTipsOnTop 函数说明见 ArtiActive.h
     */
    static void SetOperationTipsOnTop(std::function<void(uint32_t, const std::string&)> fnSetOperationTipsOnTop);

    /*
     *   注册CArtiActive的成员函数SetOperationTipsOnBottom的回调函数
     *
     *   void SetOperationTipsOnBottom(uint32_t id, const std::string& strOperationTips);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetOperationTipsOnBottom 函数说明见 ArtiActive.h
     */
    static void SetOperationTipsOnBottom(std::function<void(uint32_t, const std::string&)> fnSetOperationTipsOnBottom);
    
    /*
     *   注册CArtiActive的成员函数SetTipsTitleOnTop的回调函数
     *
     *   void SetTipsTitleOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetTipsTitleOnTop 函数说明见 ArtiActive.h
     */
    static void SetTipsTitleOnTop(std::function<void(uint32_t, const std::string&, uint32_t, uint32_t, uint32_t)> fnSetTipsTitleOnTop);
    
    /*
    *   注册CArtiActive的成员函数SetTipsTitleOnBottom的回调函数
    *
    *   void SetTipsTitleOnBottom(uint32_t id, const std::string& strTips, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);
    *
    *   id, 对象编号，表示哪一个对象调用的成员方法
    *   其他参数见ArtiActive.h的说明
    *
    *   SetTipsTitleOnBottom 函数说明见 ArtiActive.h
    */
   static void SetTipsTitleOnBottom(std::function<void(uint32_t, const std::string&, uint32_t, uint32_t, uint32_t)> fnSetTipsTitleOnBottom);
    
    /*
     *   注册CArtiActive的成员函数SetHeads的回调函数
     *
     *   void SetHeads(uint32_t id, const vector<string>& vctHeadNames);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetHeads 函数说明见 ArtiActive.h
     */
    static void SetHeads(std::function<void(uint32_t, const std::vector<std::string>&)> fnSetHeads);
    
    /*
     *   注册CArtiActive的成员函数SetLockFirstRow的回调函数
     *
     *   void SetLockFirstRow(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetLockFirstRow 函数说明见 ArtiActive.h
     */
    static void SetLockFirstRow(std::function<void(uint32_t)> fnSetLockFirstRow);

    /*
     *   注册CArtiActive的成员函数AddButton的回调函数
     *
     *   void AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   AddButton 函数说明见 ArtiActive.h
     */
    static void AddButton(std::function<void(uint32_t, const std::string&)> fnAddButton);

    /*
     *   注册CArtiActive的成员函数AddButtonEx的回调函数
     *
     *   void AddButtonEx(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   AddButtonEx 函数说明见 ArtiActive.h
     */
    static void AddButtonEx(std::function<uint32_t(uint32_t, const std::string&)> fnAddButtonEx);

    /*
     *   注册CArtiActive的成员函数DelButton的回调函数
     *
     *   void DelButton(uint32_t id, uint32_t uButtonId);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   DelButton 函数说明见 ArtiActive.h
     */
    static void DelButton(std::function<bool(uint32_t, uint32_t)> fnDelButton);
    
    /*
     *   注册CArtiActive的成员函数SetButtonEnable的回调函数
     *
     *   void SetButtonEnable(uint32_t id, uint8_t uIndex, bool bIsEnable);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetButtonEnable 在 ArtiActive.h 中是 SetButtonStatus
     */
    static void SetButtonEnable(std::function<void(uint32_t, uint8_t, bool)> fnSetButtonStatus);

    /*
     *   注册CArtiActive的成员函数SetButtonStatus的回调函数
     *
     *   void SetButtonStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetButtonStatus 函数说明见 ArtiActive.h
     */
    static void SetButtonStatus(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetButtonStatus);

    
    /*
     *   注册CArtiActive的成员函数SetButtonText的回调函数
     *
     *   void SetButtonText(uint32_t id, uint8_t uIndex, const std::string& strButtonText);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiActive.h的说明
     *
     *   SetButtonText 函数说明见 ArtiActive.h
     */
    static void SetButtonText(std::function<void(uint32_t, uint8_t, const std::string&)> fnSetButtonText);
    
    /*
     *   注册CArtiActive的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiActive.h
     */
    static void Show(std::function<uint32_t (uint32_t)> fnShow);
};
#endif
