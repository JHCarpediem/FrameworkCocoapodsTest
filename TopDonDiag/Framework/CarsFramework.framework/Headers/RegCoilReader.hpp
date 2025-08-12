#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// ��Ȧ���ʾ��ͼ

class CRegCoilReader
{
public:
    CRegCoilReader();
    ~CRegCoilReader();
    
public:
   /*
    *   ע��CArtiCoilReader��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiCoilReader����ʱ����CArtiCoilReader����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiCoilReader�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiCoilReader�ĳ�Ա����InitTitle
    *
    *               C++��������Ϊ��void InitTitle(const std::string& strTitle);
    *               ��app�ӿں���Ϊ��void InitTitle(uint32_t id, const std::string& strTitle);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiCoilReaderʵ�������� InitTitle
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiCoilReader����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiCoilReader����ʱ����CArtiCoilReader������
     *         �����л���ô˷�����֪ͨapp�㣬���Ϊid��C++������������
     */
    static void Destruct(std::function<void(uint32_t)> fnDestruct);

    /*
     *   ע��CArtiCoilReader�ĳ�Ա����InitTitle�Ļص�����
     *
     *   void InitTitle(uint32_t id, const std::string& strTitle);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiCoilReader.h��˵��
     *
     *   InitTitle ����˵���� ArtiCoilReader.h
     */
    static void InitTitle(std::function<void(uint32_t, const std::string&)> fnInitTitle);

    /*
     *   ע��CArtiCoilReader�ĳ�Ա����SetModeFrequency�Ļص�����
     *
     *   void SetCoilSignal(uint32_t id, uint32_t type);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiCoilReader.h��˵��
     *
     *   SetCoilSignal ����˵���� ArtiCoilReader.h
     */
    static void SetCoilSignal(std::function<void(uint32_t, uint32_t)> fnSetCoilSignal);

    /*
     *   ע��CArtiCoilReader�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiCoilReader.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
