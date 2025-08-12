#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include "HStdOtherMaco.h"
class CRegTrouble
{
public:
    CRegTrouble() = default;
    ~CRegTrouble() = default;

public:
    /*
    *   ע��CArtiTrouble��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiTrouble����ʱ����CArtiTrouble����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiTrouble�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   ע��CArtiTrouble����������Destruct�Ļص�����
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   ����˵��    id,    �ĸ������������������
    *
    *   ���أ���
    *
    *   ˵���� ��C++��������һ��CArtiTrouble����ʱ����CArtiTrouble������
    *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   ע��CArtiTrouble�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   CArtiTrouble ����˵���� ArtiTrouble.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   ע��CArtiTrouble�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id, const std::string& strTroubleCode, const std::string& strTroubleDesc, const std::string& strTroubleStatus, const std::string& strTroubleHelp);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   AddItem ����˵���� ArtiTrouble.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&)> fnAddItem);

    /*
     *   ע��CArtiTrouble�ĳ�Ա����AddItemEx�Ļص�����
     *
     *   void AddItemEx(uint32_t id, const stDtcNodeEx& nodeItem, const std::string& strTroubleHelp);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   AddItemEx ����˵���� ArtiTrouble.h
     */
    static void AddItemEx(std::function<void(uint32_t, const stDtcNodeEx&, const std::string&)> fnAddItemEx);

    
    /*
     *   ע��CArtiTrouble�ĳ�Ա����SetItemHelp�Ļص�����
     *
     *   void SetItemHelp(uint32_t id, uint8_t uIndex, const std::string& strToubleHelp);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   SetItemHelp ���������ͷ���ֵ˵���� ArtiTrouble.h
     */
    static void SetItemHelp(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetItemHelp);
    
    /*
     *   ע��CArtiTrouble�ĳ�Ա����SetMILStatus�Ļص�����
     *
     *   void SetMILStatus(uint32_t id, uint16_t uIndex, bool bIsShow);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   SetMILStatus ���������ͷ���ֵ˵���� ArtiTrouble.h
     */
    static void SetMILStatus(std::function<void(uint32_t, uint16_t, bool)> fnSetMILStatus);

    /*
     *   ע��CArtiTrouble�ĳ�Ա����SetFreezeStatus�Ļص�����
     *
     *   void SetFreezeStatus(uint32_t id, uint16_t uIndex, bool bIsShow);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   SetFreezeStatus ���������ͷ���ֵ˵���� ArtiTrouble.h
     */
    static void SetFreezeStatus(std::function<void(uint32_t, uint16_t, bool)> fnSetFreezeStatus);

    /*
     *   ע��CArtiTrouble�ĳ�Ա����SetCdtcButtonVisible�Ļص�����
     *
     *   void SetCdtcButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   SetCdtcButtonVisible ���������ͷ���ֵ˵���� ArtiTrouble.h
     */
    static void SetCdtcButtonVisible(std::function<void(uint32_t, bool)> fnSetCdtcButtonVisible);
    
    /*
     *   ע��CArtiTrouble�ĳ�Ա����SetRepairManualInfo�Ļص�����
     *
     *   bool SetRepairManualInfo(uint32_t id, const std::vector<stRepairInfoItem>& vctDtcInfo);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiTrouble.h��˵��
     *
     *   SetRepairManualInfo ���������ͷ���ֵ˵���� ArtiTrouble.h
     */
    static void SetRepairManualInfo(std::function<bool(uint32_t, const std::vector<stRepairInfoItem>&)> fnSetRepairManualInfo);

    /*
     *   ע��CArtiTrouble�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiList.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
