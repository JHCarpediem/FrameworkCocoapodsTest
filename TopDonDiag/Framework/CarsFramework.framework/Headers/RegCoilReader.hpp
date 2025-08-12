#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// 线圈检测示意图

class CRegCoilReader
{
public:
    CRegCoilReader();
    ~CRegCoilReader();
    
public:
   /*
    *   注册CArtiCoilReader的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiCoilReader对象时，在CArtiCoilReader构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiCoilReader的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiCoilReader的成员函数InitTitle
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiCoilReader实例调用了 InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiCoilReader的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiCoilReader对象时，在CArtiCoilReader的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   注册CArtiCoilReader的成员函数InitTitle的回调函数
     *
     *   void InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiCoilReader.h的说明
     *
     *   InitTitle 函数说明见 ArtiCoilReader.h
     */
    static void InitTitle(std::function<void(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   注册CArtiCoilReader的成员函数SetModeFrequency的回调函数
     *
     *   void SetCoilSignal(uint32_t id, uint32_t type);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiCoilReader.h的说明
     *
     *   SetCoilSignal 函数说明见 ArtiCoilReader.h
     */
    static void SetCoilSignal(std::function<void(uint32_t, uint32_t)> fnSetCoilSignal);

    /*
     *   注册CArtiCoilReader的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiCoilReader.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
