#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegFreeze
{
public:
    CRegFreeze();
    ~CRegFreeze();
    
public:
   /*
    *   注册CArtiFreeze的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiFreeze对象时，在CArtiFreeze构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiFreeze的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiFreeze的成员函数InitType
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiFreeze实例调用了 InitType
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiFreeze的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiFreeze对象时，在CArtiFreeze的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   注册CArtiFreeze的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreeze.h的说明
     *
     *   InitTitle 函数说明见 ArtiFreeze.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiFreeze的成员函数SetValueType的回调函数
     *
     *   void SetValueType(uint32_t id, uint32_t eColumnType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreeze.h的说明
     *
     *   SetValueType 函数说明见 ArtiFreeze.h
     */
    static void SetValueType(std::function<void(uint32_t, uint32_t)> fnSetValueType);
   
    /*
     *   注册CArtiFreeze的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id,
     *                const std::string& strName,
     *                const std::string& strValue,
     *                const std::string& strUnit,
     *                const std::string& strHelp);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreeze.h的说明
     *
     *   AddItem 函数说明见 ArtiFreeze.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&)> fnAddItem);
    
    /*
     *   注册CArtiFreeze的成员函数AddItemEx的回调函数
     *
     *   void AddItemEx(uint32_t id,
     *                const std::string& strName,
     *                const std::string& strValue1st,
     *                const std::string& strValue2nd,
     *                const std::string& strUnit,
     *                const std::string& strHelp);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreeze.h的说明
     *
     *   AddItem 函数说明见 ArtiFreeze.h
     */
    static void AddItemEx(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&, const std::string&)> fnAddItemEx);

    /*
     *   注册CArtiFreeze的成员函数SetHeads的回调函数
     *
     *   void SetHeads(uint32_t id, const std::vector<std::string>& vctHeadNames);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreeze.h的说明
     *
     *   SetHeads 函数说明见 ArtiFreeze.h
     */
    static void SetHeads(std::function<void(uint32_t, const std::vector<std::string>&)> fnSetHeads);
    
    /*
     *   注册CArtiFreeze的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiFreeze.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
