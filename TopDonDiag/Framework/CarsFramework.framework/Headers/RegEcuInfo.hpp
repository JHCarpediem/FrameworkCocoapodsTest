#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegEcuInfo
{
public:
    CRegEcuInfo();

    ~CRegEcuInfo();
    
public:
   /*
    *   注册CArtiEcuInfo的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiEcuInfo对象时，在CArtiEcuInfo构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiEcuInfo的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiEcuInfo的成员函数InitTitle
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiEcuInfo实例调用了 InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiEcuInfo的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiEcuInfo对象时，在CArtiEcuInfo的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   注册CArtiEcuInfo的成员函数InitTitle的回调函数
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiEcuInfo.h的说明
     *
     *   InitTitle 函数说明见 ArtiEcuInfo.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   注册CArtiEcuInfo的成员函数SetColWidth的回调函数
     *
     *   void SetColWidth(uint32_t id, int16_t iFirstPercent, int16_t iSecondPercent);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiEcuInfo.h的说明
     *
     *   SetColWidth 函数说明见 ArtiEcuInfo.h
     */
    static void SetColWidth(std::function<void(uint32_t, int16_t, int16_t)> fnSetColWidth);

    /*
     *   注册CArtiEcuInfo的成员函数AddGroup的回调函数
     *
     *   void AddGroup(uint32_t id, const std::string& strGroupName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiEcuInfo.h的说明
     *
     *   AddGroup 函数说明见 ArtiEcuInfo.h
     */
    static void AddGroup(std::function<void(uint32_t, const std::string&)> fnAddGroup);

    /*
     *   注册CArtiEcuInfo的成员函数AddItem的回调函数
     *
     *   void AddItem(uint32_t id,
     *                const std::string& strItem,
     *                const std::string& strValue);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiEcuInfo.h的说明
     *
     *   AddItem 函数说明见 ArtiEcuInfo.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&)> fnAddItem);
    
    /*
     *   注册CArtiEcuInfo的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiEcuInfo.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
