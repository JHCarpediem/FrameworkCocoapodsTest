#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// 向IOT服务器请求接口注册

class CRegIotRequest
{
public:
    CRegIotRequest() = delete;
    ~CRegIotRequest() = delete;
    
public:
    /*
     *   注册CIotRequest的成员函数JsonSendRecv的回调函数
     *
     *   uint32_t JsonSendRecv(const std::string& strApiPath, const std::string& strJsonReq, std::string& strJsonAns, uint32_t TimeOutMs);
     *
     *   JsonSendRecv 函数说明见 IotRequest.h
     */
    static void JsonSendRecv(std::function<uint32_t(const std::string&, const std::string&, std::string&, uint32_t)> fnJsonSendRecv);
};
#endif
