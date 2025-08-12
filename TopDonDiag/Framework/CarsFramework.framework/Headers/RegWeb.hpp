#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegWeb
{
public:
    CRegWeb() = default;
    ~CRegWeb() = default;
    
public:
    /*
    *   注册CRegWeb的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CRegWeb对象时，在CRegWeb构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CRegWeb的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    
    /*
    *   注册CRegWeb的析构函数Destruct的回调函数
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   参数说明    id,    哪个对象调用了析构函数
    *
    *   返回：无
    *
    *   说明： 当C++代码析构一个CRegWeb对象时，在CRegWeb的析构
    *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    
    /*
     *   注册CRegWeb的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWeb.h的说明
     *
     *   InitTitle 函数说明见 ArtiWeb.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    

    
    /*
     *   注册CRegWeb的成员函数SetButtonVisible的回调函数
     *
     *   uint32_t SetButtonVisible(uint32_t id, bool bVisible);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWeb.h的说明
     *
     *   SetButtonVisible 函数说明见 ArtiWeb.h
     */
    static void SetButtonVisible(std::function<uint32_t(uint32_t, bool)> fnSetButtonVisible);
    
    /*
     *   注册CRegWeb的成员函数InitTitle的回调函数
     *
     *   bool LoadHtmlFile(uint32_t id, const std::string& strPath);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWeb.h的说明
     *
     *   LoadHtmlFile 函数说明见 ArtiWeb.h
     */
    static void LoadHtmlFile(std::function<bool(uint32_t, const std::string&)> fnLoadHtmlFile);

    
    /*
     *   注册CRegWeb的成员函数LoadHtmlContent的回调函数
     *
     *   bool LoadHtmlContent(uint32_t id, const std::string& strContent);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWeb.h的说明
     *
     *   LoadHtmlContent 函数说明见 ArtiWeb.h
     */
    static void LoadHtmlContent(std::function<bool(uint32_t, const std::string&)> fnLoadHtmlContent);

    /*
     *   注册CArtiWeb的成员函数AddButton的回调函数
     *
     *   uint32_t AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, 对象编号，是哪一个对象调用的成员方法
     *   其他参数见ArtiWeb.h的说明
     *
     *   AddButton 函数说明见 ArtiWeb.h
     */
    static void AddButton(std::function<uint32_t(uint32_t, const std::string&)> fnAddButton);
    
    /*
     *   注册CRegWeb的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiWeb.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
