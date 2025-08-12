#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include <string>

class CRegSystem
{
public:
    CRegSystem() = delete;
    ~CRegSystem() = delete;
    
public:
    /*
    *   ע��CArtiSystem��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiSystem����ʱ����CArtiSystem����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiSystem�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   ע��CArtiSystem����������Destruct�Ļص�����
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   ����˵��    id,    �ĸ������������������
    *
    *   ���أ���
    *
    *   ˵���� ��C++��������һ��CArtiSystem����ʱ����CArtiSystem������
    *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   ע��CArtiSystem�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   CArtiSystem ����˵���� ArtiSystem.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   ע��CArtiSystem�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const string& strTitle, eSysScanType eType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   CArtiSystem ����˵���� ArtiSystem.h
     */
    static void InitTitleWithType(std::function<bool(uint32_t, const std::string&, uint32_t)> fnInitTitleWithType);
    
    /*
     *   ע��CArtiSystem�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id, const std::string& strItem);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   AddItem ����˵���� ArtiSystem.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&)> fnAddItem);

    /*
     *   ע��CArtiSystem�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id, const std::string& strItem, eSysClassType eType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   AddItem ����˵���� ArtiSystem.h
     */
    static void AddItemWithType(std::function<void(uint32_t, const std::string&, uint32_t)> fnAddItem);
    
    /*
     *   ע��CArtiSystem�ĳ�Ա����GetScanOrder�Ļص�����
     *
     *   std::vector<uint16_t> GetScanOrder(uint32_t id);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   GetScanOrder ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void GetScanOrder(std::function<std::vector<uint16_t>(uint32_t)> fnGetScanOrder);
    
    /*
    *   ע��CArtiSystem�ĳ�Ա����GetItem�Ļص�����
    *
    *   std::string const GetItem(uint32_t id, uint16_t uIndex);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiSystem.h��˵��
    *
    *   GetItem ���������ͷ���ֵ˵���� ArtiSystem.h
    */
    static void GetItem(std::function<std::string const(uint32_t, uint16_t)> fnGetItem);

    /*
     *   ע��CArtiSystem�ĳ�Ա����GetDtcItems�Ļص�����
     *
     *   std::vector<uint16_t> GetDtcItems(uint32_t id);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   GetDtcItems ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void GetDtcItems(std::function<std::vector<uint16_t>(uint32_t)> fnGetDtcItems);

    /*
     *   ע��CArtiSystem�ĳ�Ա����SetHelpButtonVisible�Ļص�����
     *
     *   void SetHelpButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetHelpButtonVisible ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetHelpButtonVisible(std::function<void(uint32_t, bool)> fnSetHelpButtonVisible);

    /*
     *   ע��CArtiSystem�ĳ�Ա����SetClearButtonVisible�Ļص�����
     *
     *   void SetClearButtonVisible(uint32_t id, bool bIsVisible);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetClearButtonVisible ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetClearButtonVisible(std::function<void(uint32_t, bool)> fnSetClearButtonVisible);

    /*
     *   ע��CArtiSystem�ĳ�Ա����SetItemStatus�Ļص�����
     *
     *   void SetItemStatus(uint32_t id, uint16_t uIndex, const std::string& strStatus);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetItemStatus ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetItemStatus(std::function<void(uint32_t, uint16_t, const std::string&)> fnSetItemStatus);

    /*
     *   ע��CArtiSystem�ĳ�Ա����SetItemResult�Ļص�����
     *
     *   void SetItemResult(uint32_t id, uint16_t uIndex, uint32_t uResult);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetItemResult ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetItemResult(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetItemResult);
    
    /*
     *   ע��CArtiSystem�ĳ�Ա����SetItemAdas�Ļص�����
     *
     *   void SetItemAdas(uint32_t id, uint16_t uIndex, uint32_t uAdasResult);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetItemAdas ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetItemAdas(std::function<void(uint32_t, uint16_t, uint32_t)> fnSetItemAdas);
    
    /*
     *   ע��CArtiSystem�ĳ�Ա����SetButtonAreaHidden�Ļص�����
     *
     *   void SetButtonAreaHidden(uint32_t id, bool bIsVisible);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetButtonAreaHidden ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetButtonAreaHidden(std::function<void(uint32_t, bool)> fnSetButtonAreaHidden);

    /*
     *   ע��CArtiSystem�ĳ�Ա����SetAtuoScanEnable�Ļص�����
     *
     *   void SetAtuoScanEnable(uint32_t id, bool bEnable);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetAtuoScanEnable ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetAtuoScanEnable(std::function<void(uint32_t, bool)> fnSetAtuoScanEnable);
    
    /*
     *   ע��CArtiSystem�ĳ�Ա����SetScanStatus�Ļص�����
     *
     *   void SetScanStatus(uint32_t id, uint32_t uStatus);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetScanStatus ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetScanStatus(std::function<void(uint32_t, uint32_t)> fnSetScanStatus);

    /*
     *   ע��CArtiSystem�ĳ�Ա����SetScanStatus�Ļص�����
     *
     *   void SetClearStatus(uint32_t id, uint32_t uStatus);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiSystem.h��˵��
     *
     *   SetClearStatus ���������ͷ���ֵ˵���� ArtiSystem.h
     */
    static void SetClearStatus(std::function<void(uint32_t, uint32_t)> fnSetClearStatus);

    /*
     *   ע��CArtiSystem�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiSystem.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
