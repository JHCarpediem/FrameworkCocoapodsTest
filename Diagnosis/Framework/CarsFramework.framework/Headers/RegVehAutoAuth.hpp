#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)

// OE网关算法服务注册

class CRegVehAutoAuth
{
public:
    CRegVehAutoAuth() = delete;
    ~CRegVehAutoAuth() = delete;
    
public:
   /*
    *   注册CVehAutoAuth的Construct回调函数
    *
    *   void Construct(uint32_t id);
    *
    *   参数说明    id,  对象计数器，对象编号，每构造一个对象，计数加1
    *
    *   返回：无
    *
    *   说明： 当C++代码构造一个CVehAutoAuth对象时，在CVehAutoAuth构造
    *         函数中会调用此方法，通知app，C++对象已购造，同时将对象id传
    *         给app，id从0开始累加，每构造一个对象，计数加1
    *
    *         所有CVehAutoAuth的成员方法的第一个参数，表示C++对象ID编号，通知
    *         app层，是哪一个对象调用的成员方法
    *
    *         例如，CVehAutoAuth的成员函数InitTitle
    *
    *               C++函数声明为：void InitTitle(const std::string& strTitle);
    *               则app接口函数为：void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app 通过id能够判定是哪个CVehAutoAuth实例调用了 InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   注册CVehAutoAuth的析构函数Destruct的回调函数
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   参数说明    id,    哪个对象调用了析构函数
     *
     *   返回：无
     *
     *   说明： 当C++代码析构一个CVehAutoAuth对象时，在CVehAutoAuth的析构
     *         函数中会调用此方法，通知app层，编号为id的C++对象正在析构
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   注册CVehAutoAuth的成员函数SetBrandType的回调函数
     *
     *   uint32_t SetBrandType(uint32_t id, const eBrandType& brandType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetBrandType 函数说明见 VehAutoAuth.h
     */
    static void SetBrandType(std::function<uint32_t(uint32_t, uint32_t)> fnSetBrandType);

    /*
     *   注册CVehAutoAuth的成员函数SetVehBrand的回调函数
     *
     *   uint32_t SetVehBrand(uint32_t id, const std::string& strBrand);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetVehBrand 函数说明见 VehAutoAuth.h
     */
    static void SetVehBrand(std::function<uint32_t(uint32_t, const std::string&)> fnSetVehBrand);
    
    /*
     *   注册CVehAutoAuth的成员函数SetVehModel的回调函数
     *
     *   uint32_t SetVehModel(uint32_t id, const std::string& strModel);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetVehModel 函数说明见 VehAutoAuth.h
     */
    static void SetVehModel(std::function<uint32_t(uint32_t, const std::string&)> fnSetVehModel);
    
    /*
     *   注册CVehAutoAuth的成员函数SetVin的回调函数
     *
     *   uint32_t SetVin(uint32_t id, const std::string& strVin);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetVin 函数说明见 VehAutoAuth.h
     */
    static void SetVin(std::function<uint32_t(uint32_t, const std::string&)> fnSetVin);

    /*
     *   注册CVehAutoAuth的成员函数SetSystemName的回调函数
     *
     *   uint32_t SetSystemName(uint32_t id, const std::string& strSysName);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetSystemName 函数说明见 VehAutoAuth.h
     */
    static void SetSystemName(std::function<uint32_t(uint32_t, const std::string&)> fnSetSystemName);
    
    /*
     *   注册CVehAutoAuth的成员函数SetEcuUnlockType的回调函数
     *
     *   uint32_t SetEcuUnlockType(uint32_t id, const std::string& strType);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetEcuUnlockType 函数说明见 VehAutoAuth.h
     */
    static void SetEcuUnlockType(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuUnlockType);

    /*
     *   注册CVehAutoAuth的成员函数SetEcuPublicServiceData的回调函数
     *
     *   uint32_t SetEcuPublicServiceData(uint32_t id, const std::string& strData);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetEcuPublicServiceData 函数说明见 VehAutoAuth.h
     */
    static void SetEcuPublicServiceData(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuPublicServiceData);

    /*
     *   注册CVehAutoAuth的成员函数SetEcuChallenge的回调函数
     *
     *   uint32_t SetEcuChallenge(uint32_t id, const std::string& strSeed);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetEcuChallenge 函数说明见 VehAutoAuth.h
     */
    static void SetEcuChallenge(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuChallenge);

    /*
     *   注册CVehAutoAuth的成员函数SetEcuTocken的回调函数
     *
     *   uint32_t SetEcuTocken(uint32_t id, const std::string& strChallenge);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetEcuTocken 函数说明见 VehAutoAuth.h
     */
    static void SetEcuTocken(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuTocken);
    
    /*
     *   注册CVehAutoAuth的成员函数SetEcuCanId的回调函数
     *
     *   uint32_t SetEcuCanId(uint32_t id, const std::string& strCanID);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetEcuCanId 函数说明见 VehAutoAuth.h
     */
    static void SetEcuCanId(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuCanId);

    /*
     *   注册CVehAutoAuth的成员函数SetXRoutingPolicy的回调函数
     *
     *   uint32_t SetXRoutingPolicy(uint32_t id, const std::string& strPolicy);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   SetXRoutingPolicy 函数说明见 VehAutoAuth.h
     */
    static void SetXRoutingPolicy(std::function<uint32_t(uint32_t, const std::string&)> fnSetXRoutingPolicy);

    /*
     *   注册CVehAutoAuth的成员函数GetRespondCode的回调函数
     *
     *   const std::string GetRespondCode(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   GetRespondCode 函数说明见 VehAutoAuth.h
     */
    static void GetRespondCode(std::function<const std::string(uint32_t)> fnGetRespondCode);

    /*
     *   注册CVehAutoAuth的成员函数GetRespondMsg的回调函数
     *
     *   const std::string GetRespondMsg(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   GetRespondMsg 函数说明见 VehAutoAuth.h
     */
    static void GetRespondMsg(std::function<const std::string(uint32_t)> fnGetRespondMsg);

    /*
     *   注册CVehAutoAuth的成员函数GetEcuChallenge的回调函数
     *
     *   const std::string GetEcuChallenge(uint32_t id);
     *
     *   id, 对象编号，表示哪一个对象调用的成员方法
     *   其他参数见VehAutoAuth.h的说明
     *
     *   GetEcuChallenge 函数说明见 VehAutoAuth.h
     */
    static void GetEcuChallenge(std::function<const std::string(uint32_t)> fnGetEcuChallenge);

    /*
     *   注册CVehAutoAuth的成员函数SendRecv的回调函数
     *
     *   uint32_t SendRecv(uint32_t id, eSendRecvType Type, uint32_t TimeOutMs);
     *
     *   SendRecv 函数说明见 VehAutoAuth.h
     */
    static void SendRecv(std::function<uint32_t(uint32_t, uint32_t, uint32_t)> fnSendRecv);
};
#endif
