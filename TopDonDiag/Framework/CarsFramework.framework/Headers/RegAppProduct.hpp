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
     *   ע��CAppProduct�ĳ�Ա����Name�Ļص�����
     *
     *   static uint32_t Name();
     *
     *   Name ����˵���� IotRequest.h
     */
    static void Name(std::function<uint32_t()> fnName);

    /*
     *   ע��CAppProduct�ĳ�Ա����Group�Ļص�����
     *
     *   static uint32_t Group();
     *
     *   Group ����˵���� IotRequest.h
     */
    static void Group(std::function<uint32_t()> fnGroup);

    /*
     *   ע��CAppProduct�ĳ�Ա����IsSupported�Ļص�����
     *
     *   static bool IsSupported(const std::string& strClass, const std::string& strApi, uint32_t uFunction = -1);
     *
     *   IsSupported ����˵���� IotRequest.h
     */
    static void IsSupported(std::function<bool(const std::string&, const std::string&, uint32_t)> fnIsSupported);

};
#endif
