#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegWeb
{
public:
    CRegWeb() = default;
    ~CRegWeb() = default;
    
public:
    /*
    *   ע��CRegWeb��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CRegWeb����ʱ����CRegWeb����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CRegWeb�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    
    /*
    *   ע��CRegWeb����������Destruct�Ļص�����
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   ����˵��    id,    �ĸ������������������
    *
    *   ���أ���
    *
    *   ˵���� ��C++��������һ��CRegWeb����ʱ����CRegWeb������
    *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    
    /*
     *   ע��CRegWeb�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWeb.h��˵��
     *
     *   InitTitle ����˵���� ArtiWeb.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);
    

    
    /*
     *   ע��CRegWeb�ĳ�Ա����SetButtonVisible�Ļص�����
     *
     *   uint32_t SetButtonVisible(uint32_t id, bool bVisible);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWeb.h��˵��
     *
     *   SetButtonVisible ����˵���� ArtiWeb.h
     */
    static void SetButtonVisible(std::function<uint32_t(uint32_t, bool)> fnSetButtonVisible);
    
    /*
     *   ע��CRegWeb�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool LoadHtmlFile(uint32_t id, const std::string& strPath);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWeb.h��˵��
     *
     *   LoadHtmlFile ����˵���� ArtiWeb.h
     */
    static void LoadHtmlFile(std::function<bool(uint32_t, const std::string&)> fnLoadHtmlFile);

    
    /*
     *   ע��CRegWeb�ĳ�Ա����LoadHtmlContent�Ļص�����
     *
     *   bool LoadHtmlContent(uint32_t id, const std::string& strContent);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiWeb.h��˵��
     *
     *   LoadHtmlContent ����˵���� ArtiWeb.h
     */
    static void LoadHtmlContent(std::function<bool(uint32_t, const std::string&)> fnLoadHtmlContent);

    /*
     *   ע��CArtiWeb�ĳ�Ա����AddButton�Ļص�����
     *
     *   uint32_t AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiWeb.h��˵��
     *
     *   AddButton ����˵���� ArtiWeb.h
     */
    static void AddButton(std::function<uint32_t(uint32_t, const std::string&)> fnAddButton);
    
    /*
     *   ע��CRegWeb�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiWeb.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
