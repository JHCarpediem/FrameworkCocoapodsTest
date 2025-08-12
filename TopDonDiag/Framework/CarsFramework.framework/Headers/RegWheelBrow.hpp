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
    *   ע��CArtiWheelBrow��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiWheelBrow����ʱ����CArtiWheelBrow����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiWheelBrow�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiWheelBrow�ĳ�Ա����InitTitle
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiWheelBrowʵ�������� InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiWheelBrow����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiWheelBrow����ʱ����CArtiWheelBrow������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CArtiWheelBrow�ĳ�Ա����InitTips�Ļص�����
     *
     *   void InitTips(uint32_t id, const std::string& strTips, eTipsPosType posType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWheelBrow.h��˵��
     *
     *   InitTips ����˵���� ArtiWheelBrow.h
     */
    static void InitTips(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTips);
    
    /*
     *   ע��CArtiWheelBrow�ĳ�Ա����SetInputDefault�Ļص�����
     *
     *   void SetInputDefault(uint32_t id, eAdasCaliData eAcdType, uint32_t uValue);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWheelBrow.h��˵��
     *
     *   SetInputDefault ����˵���� ArtiWheelBrow.h
     */
    static void SetInputDefault(std::function<void(uint32_t, uint32_t, uint32_t)> fnSetInputDefault);

    /*
     *   ע��CArtiWheelBrow�ĳ�Ա����GetInputValue�Ļص�����
     *
     *   uint32_t GetInputValue(uint32_t id, eAdasCaliData eAcdType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWheelBrow.h��˵��
     *
     *   GetInputValue ����˵���� ArtiWheelBrow.h
     */
    static void GetInputValue(std::function<uint32_t(uint32_t, uint32_t)> fnGetInputValue);

    /*
     *   ע��CArtiWheelBrow�ĳ�Ա����SetInputWarning�Ļص�����
     *
     *   void SetInputWarning(uint32_t id, eAdasCaliData eAcdType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWheelBrow.h��˵��
     *
     *   SetInputWarning ����˵���� ArtiWheelBrow.h
     */
    static void SetInputWarning(std::function<void(uint32_t, uint32_t)> fnSetInputWarning);
    
    /*
     *   ע��CArtiWheelBrow�ĳ�Ա����SetWarningTips�Ļص�����
     *
     *   void SetWarningTips(uint32_t id, const std::string &strTips);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWheelBrow.h��˵��
     *
     *   SetWarningTips ����˵���� ArtiWheelBrow.h
     */
    static void SetWarningTips(std::function<void(uint32_t, const std::string&)> fnSetWarningTips);
    
    /*
     *   ע��CArtiWheelBrow�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiWheelBrow.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
