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

};
#endif
