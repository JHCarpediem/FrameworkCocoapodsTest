#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegFuelLevel
{
public:
    CRegFuelLevel();

    ~CRegFuelLevel();
    
public:
   /*
    *   ע��CArtiFuelLevel��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiFuelLevel����ʱ����CArtiFuelLevel����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiFuelLevel�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiFuelLevel�ĳ�Ա����InitTitle
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiFuelLevelʵ�������� InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiFuelLevel����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiFuelLevel����ʱ����CArtiFuelLevel������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CArtiFuelLevel�ĳ�Ա����InitTips�Ļص�����
     *
     *   void InitTips(uint32_t id, const std::string& strTips, eTipsPosType posType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFuelLevel.h��˵��
     *
     *   InitTips ����˵���� ArtiFuelLevel.h
     */
    static void InitTips(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTips);
    
    /*
     *   ע��CArtiFuelLevel�ĳ�Ա����SetInputDefault�Ļص�����
     *
     *   void SetInputDefault(uint32_t id, uint32_t uValue);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFuelLevel.h��˵��
     *
     *   SetInputDefault ����˵���� ArtiFuelLevel.h
     */
    static void SetInputDefault(std::function<void(uint32_t, uint32_t)> fnSetInputDefault);

    /*
     *   ע��CArtiFuelLevel�ĳ�Ա����GetInputValue�Ļص�����
     *
     *   uint32_t GetInputValue(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFuelLevel.h��˵��
     *
     *   GetInputValue ����˵���� ArtiFuelLevel.h
     */
    static void GetInputValue(std::function<uint32_t(uint32_t)> fnGetInputValue);

    /*
     *   ע��CArtiFuelLevel�ĳ�Ա����SetInputWarning�Ļص�����
     *
     *   void SetInputWarning(uint32_t id, bool bWarning);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFuelLevel.h��˵��
     *
     *   SetInputWarning ����˵���� ArtiFuelLevel.h
     */
    static void SetInputWarning(std::function<void(uint32_t, bool)> fnSetInputWarning);
    
    /*
     *   ע��CArtiFuelLevel�ĳ�Ա����SetWarningTips�Ļص�����
     *
     *   void SetWarningTips(uint32_t id, const std::string &strTips);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFuelLevel.h��˵��
     *
     *   SetWarningTips ����˵���� ArtiFuelLevel.h
     */
    static void SetWarningTips(std::function<void(uint32_t, const std::string&)> fnSetWarningTips);
    
    /*
     *   ע��CArtiFuelLevel�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiFuelLevel.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
