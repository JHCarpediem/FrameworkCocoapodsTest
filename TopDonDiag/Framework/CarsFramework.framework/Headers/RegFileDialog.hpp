#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// �ļ�ѡȡ���ļ����Ϊ

class CRegFileDialog
{
public:
    CRegFileDialog();
    ~CRegFileDialog();
    
public:
   /*
    *   ע��CArtiFileDialog��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiFileDialog����ʱ����CArtiFileDialog����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiFileDialog�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiFileDialog�ĳ�Ա����InitType
    *
    *               C++��������Ϊ��void InitType(bool bType, const std::string& strPath);
    *               ��app�ӿں���Ϊ��void InitType(uint32_t id, bool bType, const std::string& strPath);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiFileDialogʵ�������� InitType
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiFileDialog����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiFileDialog����ʱ����CArtiFileDialog������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CArtiFileDialog�ĳ�Ա����InitType�Ļص�����
     *
     *   void InitType(uint32_t id, bool bType, const std::string& strPath);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFileDialog.h��˵��
     *
     *   InitType ����˵���� CArtiFileDialog.h
     */
    static void InitType(std::function<void(uint32_t, bool, const std::string&)> fnInitType);

    /*
     *   ע��CArtiFileDialog�ĳ�Ա����SetFilter�Ļص�����
     *
     *   void SetFilter(uint32_t id, const std::string& strFilter);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFileDialog.h��˵��
     *
     *   SetFilter ����˵���� ArtiFileDialog.h
     */
    static void SetFilter(std::function<void(uint32_t, const std::string&)> fnSetFilter);

    /*
     *   ע��CArtiFileDialog�ĳ�Ա����GetPathName�Ļص�����
     *
     *   const std::string GetPathName(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFileDialog.h��˵��
     *
     *   GetPathName ����˵���� CArtiFileDialog.h
     */
    static void GetPathName(std::function<const std::string(uint32_t)> fnGetPathName);

    /*
     *   ע��CArtiFileDialog�ĳ�Ա����GetFileName�Ļص�����
     *
     *   const std::string GetFileName(uint32_t id);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFileDialog.h��˵��
     *
     *   GetFileName ����˵���� CArtiFileDialog.h
     */
    static void GetFileName(std::function<const std::string(uint32_t)> fnGetFileName);
    
    /*
     *   ע��CArtiFileDialog�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiFileDialog.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
