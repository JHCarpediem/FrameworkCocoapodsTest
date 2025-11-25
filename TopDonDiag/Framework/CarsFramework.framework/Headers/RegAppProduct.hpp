#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegAppProduct
{
public:
    CRegAppProduct() = delete;
    ~CRegAppProduct() = delete;
    
public:
    /*
     *   注册CAppProduct的成员函数Name的回调函数
     *
     *   static uint32_t Name();
     *
     *   Name 函数说明见 IotRequest.h
     */
    static void Name(std::function<uint32_t()> fnName);

    /*
     *   注册CAppProduct的成员函数Group的回调函数
     *
     *   static uint32_t Group();
     *
     *   Group 函数说明见 IotRequest.h
     */
    static void Group(std::function<uint32_t()> fnGroup);

    /*
     *   注册CAppProduct的成员函数IsSupported的回调函数
     *
     *   static bool IsSupported(const std::string& strClass, const std::string& strApi, uint32_t uFunction = -1);
     *
     *   IsSupported 函数说明见 IotRequest.h
     */
    static void IsSupported(std::function<bool(const std::string&, const std::string&, uint32_t)> fnIsSupported);

    /*
     *   获取当前app应用的产品名称
     *
     *   static const std::string CurVehSoftCode(uint32_t uVehType);
     *
     *   CurVehSoftCode 函数说明见 IotRequest.h
     */
    static void CurVehSoftCode(std::function<std::string(uint32_t)> fnCurVehSoftCode);

    /*
     *   获取当前用户的偏好设置
     *
     *   static const uint32_t GetUserPreference(eAppUserPref ePreferenceType);
     *
     *   GetUserPreference 函数说明见 IotRequest.h
     */
    static void GetUserPreference(std::function<uint32_t(uint32_t)> fnGetUserPreference);

    /*
     *   获取当前进车的软件编码
     *
     *   static const std::string HwProductModel(uint32_t uType);
     *
     *   HwProductModel 函数说明见 IotRequest.h
     */
    static void HwProductModel(std::function<std::string(uint32_t)> fnHwProductModel);
};
#endif
