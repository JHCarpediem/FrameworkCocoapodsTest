#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)

// OE�����㷨����ע��

class CRegVehAutoAuth
{
public:
    CRegVehAutoAuth() = delete;
    ~CRegVehAutoAuth() = delete;
    
public:
   /*
    *   ע��CVehAutoAuth��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CVehAutoAuth����ʱ����CVehAutoAuth����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CVehAutoAuth�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CVehAutoAuth�ĳ�Ա����InitTitle
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CVehAutoAuthʵ�������� InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CVehAutoAuth����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CVehAutoAuth����ʱ����CVehAutoAuth������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetBrandType�Ļص�����
     *
     *   uint32_t SetBrandType(uint32_t id, const eBrandType& brandType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetBrandType ����˵���� VehAutoAuth.h
     */
    static void SetBrandType(std::function<uint32_t(uint32_t, uint32_t)> fnSetBrandType);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetVehBrand�Ļص�����
     *
     *   uint32_t SetVehBrand(uint32_t id, const std::string& strBrand);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetVehBrand ����˵���� VehAutoAuth.h
     */
    static void SetVehBrand(std::function<uint32_t(uint32_t, const std::string&)> fnSetVehBrand);
    
    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetVehModel�Ļص�����
     *
     *   uint32_t SetVehModel(uint32_t id, const std::string& strModel);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetVehModel ����˵���� VehAutoAuth.h
     */
    static void SetVehModel(std::function<uint32_t(uint32_t, const std::string&)> fnSetVehModel);
    
    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetVin�Ļص�����
     *
     *   uint32_t SetVin(uint32_t id, const std::string& strVin);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetVin ����˵���� VehAutoAuth.h
     */
    static void SetVin(std::function<uint32_t(uint32_t, const std::string&)> fnSetVin);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetSystemName�Ļص�����
     *
     *   uint32_t SetSystemName(uint32_t id, const std::string& strSysName);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetSystemName ����˵���� VehAutoAuth.h
     */
    static void SetSystemName(std::function<uint32_t(uint32_t, const std::string&)> fnSetSystemName);
    
    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetEcuUnlockType�Ļص�����
     *
     *   uint32_t SetEcuUnlockType(uint32_t id, const std::string& strType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetEcuUnlockType ����˵���� VehAutoAuth.h
     */
    static void SetEcuUnlockType(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuUnlockType);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetEcuPublicServiceData�Ļص�����
     *
     *   uint32_t SetEcuPublicServiceData(uint32_t id, const std::string& strData);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetEcuPublicServiceData ����˵���� VehAutoAuth.h
     */
    static void SetEcuPublicServiceData(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuPublicServiceData);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetEcuChallenge�Ļص�����
     *
     *   uint32_t SetEcuChallenge(uint32_t id, const std::string& strSeed);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetEcuChallenge ����˵���� VehAutoAuth.h
     */
    static void SetEcuChallenge(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuChallenge);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetEcuTocken�Ļص�����
     *
     *   uint32_t SetEcuTocken(uint32_t id, const std::string& strChallenge);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetEcuTocken ����˵���� VehAutoAuth.h
     */
    static void SetEcuTocken(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuTocken);
    
    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetEcuCanId�Ļص�����
     *
     *   uint32_t SetEcuCanId(uint32_t id, const std::string& strCanID);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetEcuCanId ����˵���� VehAutoAuth.h
     */
    static void SetEcuCanId(std::function<uint32_t(uint32_t, const std::string&)> fnSetEcuCanId);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SetXRoutingPolicy�Ļص�����
     *
     *   uint32_t SetXRoutingPolicy(uint32_t id, const std::string& strPolicy);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   SetXRoutingPolicy ����˵���� VehAutoAuth.h
     */
    static void SetXRoutingPolicy(std::function<uint32_t(uint32_t, const std::string&)> fnSetXRoutingPolicy);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����GetRespondCode�Ļص�����
     *
     *   const std::string GetRespondCode(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   GetRespondCode ����˵���� VehAutoAuth.h
     */
    static void GetRespondCode(std::function<const std::string(uint32_t)> fnGetRespondCode);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����GetRespondMsg�Ļص�����
     *
     *   const std::string GetRespondMsg(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   GetRespondMsg ����˵���� VehAutoAuth.h
     */
    static void GetRespondMsg(std::function<const std::string(uint32_t)> fnGetRespondMsg);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����GetEcuChallenge�Ļص�����
     *
     *   const std::string GetEcuChallenge(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������VehAutoAuth.h��˵��
     *
     *   GetEcuChallenge ����˵���� VehAutoAuth.h
     */
    static void GetEcuChallenge(std::function<const std::string(uint32_t)> fnGetEcuChallenge);

    /*
     *   ע��CVehAutoAuth�ĳ�Ա����SendRecv�Ļص�����
     *
     *   uint32_t SendRecv(uint32_t id, eSendRecvType Type, uint32_t TimeOutMs);
     *
     *   SendRecv ����˵���� VehAutoAuth.h
     */
    static void SendRecv(std::function<uint32_t(uint32_t, uint32_t, uint32_t)> fnSendRecv);
};
#endif
