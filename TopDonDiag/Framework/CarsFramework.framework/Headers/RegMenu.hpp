#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

class CRegMenu
{
public:
    CRegMenu() = delete;
    ~CRegMenu() = delete;
    
public:
    /*
    *   ע��CArtiMenu��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiMenu����ʱ����CArtiMenu����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiMenu�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
    *   ע��CArtiMenu����������Destruct�Ļص�����
    *
    *   void Destruct(uint32_t id);
    *
    *
    *   ����˵��    id,    �ĸ������������������
    *
    *   ���أ���
    *
    *   ˵���� ��C++��������һ��CArtiMenu����ʱ����CArtiMenu������
    *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
    */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);
    
    /*
     *   ע��CArtiMenu�ĳ�Ա����InitTitle�Ļص�����
     *
     *   bool InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiMenu.h��˵��
     *
     *   InitTitle ����˵���� ArtiMenu.h
     */
    static void InitTitle(std::function<bool(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   ע��CArtiMenu�ĳ�Ա����AddItem�Ļص�����
     *
     *   void AddItem(uint32_t id, const std::string& strItem, uint32_t uStatus);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������CArtiMenu.h��˵��
     *
     *   AddItem ����˵���� ArtiMenu.h
     */
    static void AddItem(std::function<void(uint32_t, const std::string&, uint32_t)> fnAddItem);

    /*
    *   ע��CArtiMenu�ĳ�Ա����SetMenuStatus�Ļص�����
    *
    *   uint32_t SetMenuStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   SetMenuStatus ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void SetMenuStatus(std::function<uint32_t(uint32_t, uint16_t, uint32_t)> fnSetMenuStatus);
    
    /*
    *   ע��CArtiMenu�ĳ�Ա����GetItem�Ļص�����
    *
    *   std::string const GetItem(uint32_t id, uint16_t uIndex);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   GetItem ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void GetItem(std::function<std::string const(uint32_t, uint16_t)> fnGetItem);

    /*
    *   ע��CArtiMenu�ĳ�Ա����SetReference�Ļص�����
    *
    *   void SetIcon(uint32_t id, uint16_t uIndex, const std::string& strIconPath, const std::string& strShortName);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   SetIcon ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void SetIcon(std::function<void(uint32_t, uint16_t, const std::string&, const std::string&)> fnSetIcon);
                        
    /*
    *   ע��CArtiMenu�ĳ�Ա����SetHelpButtonVisible�Ļص�����
    *
    *   void SetHelpButtonVisible(uint32_t id, bool bIsVisible);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   SetHelpButtonVisible ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void SetHelpButtonVisible(std::function<void(uint32_t, bool)> fnSetHelpButtonVisible);
                        
    /*
    *   ע��CArtiMenu�ĳ�Ա����SetMenuTreeVisible�Ļص�����
    *
    *   void SetMenuTreeVisible(uint32_t id, bool bIsVisible);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   SetMenuTreeVisible ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void SetMenuTreeVisible(std::function<void(uint32_t, bool)> fnSetMenuTreeVisible);
                        
    /*
    *   ע��CArtiMenu�ĳ�Ա����SetMenuId�Ļص�����
    *
    *   void SetMenuId(uint32_t id, const std::string& strMenuId);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   SetMenuId ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void SetMenuId(std::function<void(uint32_t, const std::string&)> fnSetMenuId);

    /*
    *   ע��CArtiMenu�ĳ�Ա����GetMenuId�Ļص�����
    *
    *   std::string const GetMenuId(uint32_t id);
    *
    *   id, �����ţ�����һ��������õĳ�Ա����
    *   ����������ArtiMenu.h��˵��
    *
    *   GetMenuId ���������ͷ���ֵ˵���� ArtiMenu.h
    */
    static void GetMenuId(std::function<std::string const(uint32_t)> fnGetMenuId);
                        
    /*
    *   ע��CArtiMenu�ĳ�Ա����Show�Ļص�����
    *
    *   uint32_t Show(uint32_t id);
    *
    *   Show ����˵���� ArtiMenu.h
    */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
