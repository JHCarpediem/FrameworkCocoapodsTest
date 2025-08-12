#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegMenu
{
public:
    CRegMenu() = delete;
    ~CRegMenu() = delete;
    
public:
    /*
    *   注册CArtiMenu的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiMenu对象时，在CArtiMenu构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiMenu的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   注册CArtiMenu的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CArtiMenu对象时，在CArtiMenu的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiMenu的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiMenu.h的说明
     *
     *   InitTitle 函数说明见 ArtiMenu.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   注册CArtiMenu的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id, const std::string& strItem, uint32_t uStatus);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见CArtiMenu.h的说明
     *
     *   AddItem 函数说明见 ArtiMenu.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, uint32_t)> fnAddItem);

    /*
    *   注册CArtiMenu的成员函数SetMenuStatus的回调函数
    *
    *   uint32_t SetMenuStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   SetMenuStatus 其它参数和返回值说明见 ArtiMenu.h
    */
    static void SetMenuStatus(std::function<uint32_t(uint32_t, uint16_t, uint32_t)> fnSetMenuStatus);
    
    /*
    *   注册CArtiMenu的成员函数GetItem的回调函数
    *
    *   std::string const GetItem(uint32_t id, uint16_t uIndex);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   GetItem 其它参数和返回值说明见 ArtiMenu.h
    */
    static void GetItem(std::function<std::string const(uint32_t, uint16_t)> fnGetItem);

    /*
    *   注册CArtiMenu的成员函数SetReference的回调函数
    *
    *   void SetIcon(uint32_t id, uint16_t uIndex, const std::string& strIconPath, const std::string& strShortName);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   SetIcon 其它参数和返回值说明见 ArtiMenu.h
    */
    static void SetIcon(std::function<void(uint32_t, uint16_t, const std::string&, const std::string&)> fnSetIcon);
                        
    /*
    *   注册CArtiMenu的成员函数SetHelpButtonVisible的回调函数
    *
    *   void SetHelpButtonVisible(uint32_t id, bool bIsVisible);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   SetHelpButtonVisible 其它参数和返回值说明见 ArtiMenu.h
    */
    static void SetHelpButtonVisible(std::function<void(uint32_t, bool)> fnSetHelpButtonVisible);
                        
    /*
    *   注册CArtiMenu的成员函数SetMenuTreeVisible的回调函数
    *
    *   void SetMenuTreeVisible(uint32_t id, bool bIsVisible);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   SetMenuTreeVisible 其它参数和返回值说明见 ArtiMenu.h
    */
    static void SetMenuTreeVisible(std::function<void(uint32_t, bool)> fnSetMenuTreeVisible);
                        
    /*
    *   注册CArtiMenu的成员函数SetMenuId的回调函数
    *
    *   void SetMenuId(uint32_t id, const std::string& strMenuId);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   SetMenuId 其它参数和返回值说明见 ArtiMenu.h
    */
    static void SetMenuId(std::function<void(uint32_t, const std::string&)> fnSetMenuId);

    /*
    *   注册CArtiMenu的成员函数GetMenuId的回调函数
    *
    *   std::string const GetMenuId(uint32_t id);
    *
    *   id, 对象编号，是哪一个对象调用的成员方法
    *   其他参数见ArtiMenu.h的说明
    *
    *   GetMenuId 其它参数和返回值说明见 ArtiMenu.h
    */
    static void GetMenuId(std::function<std::string const(uint32_t)> fnGetMenuId);
                        
    /*
    *   注册CArtiMenu的成员函数Show的回调函数
    *
    *   uint32_t Show(uint32_t id);
    *
    *   Show 函数说明见 ArtiMenu.h
    */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
