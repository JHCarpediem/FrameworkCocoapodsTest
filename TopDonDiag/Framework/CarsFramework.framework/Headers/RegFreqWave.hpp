#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>

// Կ��ң��Ƶ�ʼ�鲨��ʾ��ͼ

class CRegFreqWave
{
public:
    CRegFreqWave();
    ~CRegFreqWave();
    
public:
   /*
    *   ע��CArtiFreqWave��Construct�ص�����
    *
    *   void Construct(uint32_t id);
    *
    *   ����˵��    id,  ����������������ţ�ÿ����һ�����󣬼�����1
    *
    *   ���أ���
    *
    *   ˵���� ��C++���빹��һ��CArtiFreqWave����ʱ����CArtiFreqWave����
    *         �����л���ô˷�����֪ͨapp��C++�����ѹ��죬ͬʱ������id��
    *         ��app��id��0��ʼ�ۼӣ�ÿ����һ�����󣬼�����1
    *
    *         ����CArtiFreqWave�ĳ�Ա�����ĵ�һ����������ʾC++����ID��ţ�֪ͨ
    *         app�㣬����һ��������õĳ�Ա����
    *
    *         ���磬CArtiFreqWave�ĳ�Ա����InitType
    *
    *               C++��������Ϊ��void InitType(bool bType, const std::string& strPath);
    *               ��app�ӿں���Ϊ��void InitType(uint32_t id, bool bType, const std::string& strPath);
    *
    *               app ͨ��id�ܹ��ж����ĸ�CArtiFreqWaveʵ�������� InitType
    *
    */
    static void Construct(std::function<void(uint32_t)> fnConstruct);
    
    /*
     *   ע��CArtiFreqWave����������Destruct�Ļص�����
     *
     *   void Destruct(uint32_t id);
     *
     *
     *   ����˵��    id,    �ĸ������������������
     *
     *   ���أ���
     *
     *   ˵���� ��C++��������һ��CArtiFreqWave����ʱ����CArtiFreqWave������
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
     *   ע��CArtiFreqWave�ĳ�Ա����SetModeFrequency�Ļص�����
     *
     *   void SetModeFrequency(uint32_t id, const std::string& strModeValue, const std::string& strFreqValue, const std::string& strIntensity);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreqWave.h��˵��
     *
     *   SetModeFrequency ����˵���� ArtiFreqWave.h
     */
    static void SetModeFrequency(std::function<void(uint32_t, const std::string&, const std::string&, const std::string&)> fnSetModeFrequency);

    /*
     *   ע��CArtiFreqWave�ĳ�Ա����TriggerCrest�Ļص�����
     *
     *   void TriggerCrest(uint32_t id, uint32_t Type);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreqWave.h��˵��
     *
     *   TriggerCrest ����˵���� ArtiFreqWave.h
     */
    static void TriggerCrest(std::function<void(uint32_t, uint32_t)> fnTriggerCrest);
    
    /*
     *   ע��CArtiFreqWave�ĳ�Ա����SetLeftLayoutPicture�Ļص�����
     *
     *   bool SetLeftLayoutPicture(uint32_t id, const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType);
     *
     *   id, �����ţ���ʾ��һ��������õĳ�Ա����
     *   ����������ArtiFreqWave.h��˵��
     *
     *   SetLeftLayoutPicture ����˵���� ArtiFreqWave.h
     */
    static void SetLeftLayoutPicture(std::function<bool(uint32_t, const std::string&, const std::string&, uint16_t)> fnSetLeftLayoutPicture);
    
    /*
     *   ע��CArtiFreqWave�ĳ�Ա����Show�Ļص�����
     *
     *   uint32_t Show(uint32_t id);
     *
     *   Show ����˵���� ArtiFreqWave.h
     */
    static void Show(std::function<uint32_t(uint32_t)> fnShow);
};

#endif
