#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegWheelBrow
{
public:
    CRegWheelBrow();

    ~CRegWheelBrow();
    
public:
   /*
    *   注册CArtiWheelBrow的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiWheelBrow对象时，在CArtiWheelBrow构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiWheelBrow的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiWheelBrow的成员函数InitTitle
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CArtiWheelBrow实例调用了 InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiWheelBrow的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiWheelBrow对象时，在CArtiWheelBrow的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   注册CArtiWheelBrow的成员函数InitTips的回调函数
     *
     *   void InitTips(uint32_t id, const std::string& strTips, eTipsPosType posType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWheelBrow.h的说明
     *
     *   InitTips 函数说明见 ArtiWheelBrow.h
     */
    static void InitTips(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTips);
    
    /*
     *   注册CArtiWheelBrow的成员函数SetInputDefault的回调函数
     *
     *   void SetInputDefault(uint32_t id, eAdasCaliData eAcdType, uint32_t uValue);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWheelBrow.h的说明
     *
     *   SetInputDefault 函数说明见 ArtiWheelBrow.h
     */
    static void SetInputDefault(std::function<void(uint32_t, uint32_t, uint32_t)> fnSetInputDefault);

    /*
     *   注册CArtiWheelBrow的成员函数GetInputValue的回调函数
     *
     *   uint32_t GetInputValue(uint32_t id, eAdasCaliData eAcdType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWheelBrow.h的说明
     *
     *   GetInputValue 函数说明见 ArtiWheelBrow.h
     */
    static void GetInputValue(std::function<uint32_t(uint32_t, uint32_t)> fnGetInputValue);

    /*
     *   注册CArtiWheelBrow的成员函数SetInputWarning的回调函数
     *
     *   void SetInputWarning(uint32_t id, eAdasCaliData eAcdType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWheelBrow.h的说明
     *
     *   SetInputWarning 函数说明见 ArtiWheelBrow.h
     */
    static void SetInputWarning(std::function<void(uint32_t, uint32_t)> fnSetInputWarning);
    
    /*
     *   注册CArtiWheelBrow的成员函数SetWarningTips的回调函数
     *
     *   void SetWarningTips(uint32_t id, const std::string &strTips);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiWheelBrow.h的说明
     *
     *   SetWarningTips 函数说明见 ArtiWheelBrow.h
     */
    static void SetWarningTips(std::function<void(uint32_t, const std::string&)> fnSetWarningTips);
    
    /*
     *   注册CArtiWheelBrow的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiWheelBrow.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
