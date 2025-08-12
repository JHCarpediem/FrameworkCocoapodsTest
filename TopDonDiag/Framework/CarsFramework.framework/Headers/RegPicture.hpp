#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// ͼƬ��ʾ���

class CRegPicture
{
public:
    CRegPicture();
    ~CRegPicture();
    
public:
   /*
    *   ע��CArtiPicture��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiPicture����ʱ����CArtiPicture����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiPicture�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiPicture�ĳ�Ա����InitTitle
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiPictureʵ�������� InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiPicture����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiPicture����ʱ����CArtiPicture������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CArtiPicture�ĳ�Ա����InitTitle�Ļص�����
     *
     *   void InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiPicture.h��˵��
     *
     *   InitTitle ����˵���� ArtiPicture.h
     */
    static void InitTitle(std::function<void(uint32_t, const std::string&)> fnInitTitle);
    
    /*
     *   ע��CArtiPicture�ĳ�Ա����AddButton�Ļص�����
     *
     *   uint32_t AddButton(uint32_t id, const std::string& strButtonText);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiPicture.h��˵��
     *
     *   AddButton ����˵���� ArtiPicture.h
     */
    static void AddButton(std::function<uint32_t(uint32_t, const std::string&)> fnAddButton);
    
    
    /*
     *   ע��CArtiPicture�ĳ�Ա����AddPicture�Ļص�����
     *
     *   uint32_t AddPicture(uint32_t id, const std::string& strPicturePath, const std::string& strBottomTips);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiPicture.h��˵��
     *
     *   AddPicture ����˵���� ArtiPicture.h
     */
    static void AddPicture(std::function<uint32_t(uint32_t, const std::string&, const std::string&)> fnAddPicture);
    
    
    /*
     *   ע��CArtiPicture�ĳ�Ա����AddTopTips�Ļص�����
     *
     *   void AddTopTips(uint32_t id, uint32_t uiPictID, const std::string& strTopTips, eFontSize eSize, eBoldType eBold));
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiPicture.h��˵��
     *
     *   AddTopTips ����˵���� ArtiPicture.h
     */
    static void AddTopTips(std::function<void(uint32_t, uint32_t, const std::string&, uint32_t, uint32_t)> fnAddTopTips);

    
    /*
     *   ע��CArtiPicture�ĳ�Ա����AddText�Ļص�����
     *
     *   void AddText(uint32_t id, const std::string& strText);
     *
     *   id, �����ţ�����һ��������õĳ�Ա����
     *   ����������ArtiPicture.h��˵��
     *
     *   AddText ����˵���� ArtiPicture.h
     */
    static void AddText(std::function<void(uint32_t, const std::string&)> fnAddText);
    
    
    /*
     *   ע��CArtiPicture�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiPicture.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};
#endif
