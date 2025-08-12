#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegFreeze
{
public:
    CRegFreeze();
    ~CRegFreeze();
    
public:
   /*
    *   ע��CArtiFreeze��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiFreeze����ʱ����CArtiFreeze����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiFreeze�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiFreeze�ĳ�Ա����InitType
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiFreezeʵ�������� InitType
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiFreeze����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiFreeze����ʱ����CArtiFreeze������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   ע��CArtiFreeze�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreeze.h��˵��
     *
     *   InitTitle ����˵���� ArtiFreeze.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   ע��CArtiFreeze�ĳ�Ա����SetValueType�Ļص�����
     *
     *   void SetValueType(uint32_t id, uint32_t eColumnType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreeze.h��˵��
     *
     *   SetValueType ����˵���� ArtiFreeze.h
     */
    static void SetValueType(std::function<void(uint32_t, uint32_t)> fnSetValueType);
   
    /*
     *   ע��CArtiFreeze�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id,
     *                const std::string& strName,
     *                const std::string& strValue,
     *                const std::string& strUnit,
     *                const std::string& strHelp);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreeze.h��˵��
     *
     *   AddItem ����˵���� ArtiFreeze.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&)> fnAddItem);
    
    /*
     *   ע��CArtiFreeze�ĳ�Ա����AddItemEx�Ļص�����
     *
     *   void AddItemEx(uint32_t id,
     *                const std::string& strName,
     *                const std::string& strValue1st,
     *                const std::string& strValue2nd,
     *                const std::string& strUnit,
     *                const std::string& strHelp);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreeze.h��˵��
     *
     *   AddItem ����˵���� ArtiFreeze.h
     */
    static void AddItemEx(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&, const std::string&, const std::string&)> fnAddItemEx);

    /*
     *   ע��CArtiFreeze�ĳ�Ա����SetHeads�Ļص�����
     *
     *   void SetHeads(uint32_t id, const std::vector<std::string>& vctHeadNames);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreeze.h��˵��
     *
     *   SetHeads ����˵���� ArtiFreeze.h
     */
    static void SetHeads(std::function<void(uint32_t, const std::vector<std::string>&)> fnSetHeads);
    
    /*
     *   ע��CArtiFreeze�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiFreeze.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
