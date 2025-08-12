#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegEcuInfo
{
public:
    CRegEcuInfo();

    ~CRegEcuInfo();
    
public:
   /*
    *   ע��CArtiEcuInfo��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiEcuInfo����ʱ����CArtiEcuInfo����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiEcuInfo�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiEcuInfo�ĳ�Ա����InitTitle
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiEcuInfoʵ�������� InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiEcuInfo����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiEcuInfo����ʱ����CArtiEcuInfo������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CArtiEcuInfo�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiEcuInfo.h��˵��
     *
     *   InitTitle ����˵���� ArtiEcuInfo.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   ע��CArtiEcuInfo�ĳ�Ա����SetColWidth�Ļص�����
     *
     *   void SetColWidth(uint32_t id, int16_t iFirstPercent, int16_t iSecondPercent);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiEcuInfo.h��˵��
     *
     *   SetColWidth ����˵���� ArtiEcuInfo.h
     */
    static void SetColWidth(std::function<void(uint32_t, int16_t, int16_t)> fnSetColWidth);

    /*
     *   ע��CArtiEcuInfo�ĳ�Ա����AddGroup�Ļص�����
     *
     *   void AddGroup(uint32_t id, const std::string& strGroupName);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiEcuInfo.h��˵��
     *
     *   AddGroup ����˵���� ArtiEcuInfo.h
     */
    static void AddGroup(std::function<void(uint32_t, const std::string&)> fnAddGroup);

    /*
     *   ע��CArtiEcuInfo�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id,
     *                const std::string& strItem,
     *                const std::string& strValue);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiEcuInfo.h��˵��
     *
     *   AddItem ����˵���� ArtiEcuInfo.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&)> fnAddItem);
    
    /*
     *   ע��CArtiEcuInfo�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiEcuInfo.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
