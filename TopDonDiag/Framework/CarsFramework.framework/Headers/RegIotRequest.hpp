#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// ��IOT����������ӿ�ע��

class CRegIotRequest
{
public:
    CRegIotRequest() = delete;
    ~CRegIotRequest() = delete;
    
public:
    /*
     *   ע��CIotRequest�ĳ�Ա����JsonSendRecv�Ļص�����
     *
     *   uint32_t JsonSendRecv(const std::string& strApiPath, const std::string& strJsonReq, std::string& strJsonAns, uint32_t TimeOutMs);
     *
     *   JsonSendRecv ����˵���� IotRequest.h
     */
    static void JsonSendRecv(std::function<uint32_t(const std::string&, const std::string&, std::string&, uint32_t)> fnJsonSendRecv);
};
#endif
