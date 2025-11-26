#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// 钥匙遥控频率检查波形示意图

class CRegFreqWave
{
public:
    CRegFreqWave();
    ~CRegFreqWave();
    
public:
   /*
    *   注册CArtiFreqWave的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CArtiFreqWave对象时，在CArtiFreqWave构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CArtiFreqWave的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CArtiFreqWave的成员函数InitType
    *
    *               C++函数声明为：void InitType(bool bType, const std::string& strPath);
    *               则app接口函数为：void InitType(uint32_t id, bool bType, const std::string& strPath);
    *
    *               app 通过id能够判定是哪个CArtiFreqWave实例调用了 InitType
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CArtiFreqWave的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CArtiFreqWave对象时，在CArtiFreqWave的析构
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
     *   注册CArtiFreqWave的成员函数SetModeFrequency的回调函数
     *
     *   void SetModeFrequency(uint32_t id, const std::string& strModeValue, const std::string& strFreqValue, const std::string& strIntensity);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreqWave.h的说明
     *
     *   SetModeFrequency 函数说明见 ArtiFreqWave.h
     */
    static void SetModeFrequency(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&)> fnSetModeFrequency);

    /*
     *   注册CArtiFreqWave的成员函数TriggerCrest的回调函数
     *
     *   void TriggerCrest(uint32_t id, uint32_t Type);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreqWave.h的说明
     *
     *   TriggerCrest 函数说明见 ArtiFreqWave.h
     */
    static void TriggerCrest(std::function<void(uint32_t, uint32_t)> fnTriggerCrest);
    
    /*
     *   注册CArtiFreqWave的成员函数SetLeftLayoutPicture的回调函数
     *
     *   bool SetLeftLayoutPicture(uint32_t id, const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见ArtiFreqWave.h的说明
     *
     *   SetLeftLayoutPicture 函数说明见 ArtiFreqWave.h
     */
    static void SetLeftLayoutPicture(std::function<bool(uint32_t, const std::string&, const std::string&, uint16_t)> fnSetLeftLayoutPicture);
    
    /*
     *   注册CArtiFreqWave的成员函数Show的回调函数
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show 函数说明见 ArtiFreqWave.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
