/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ArtiDiag900ȫ�ֽӿڶ���
* �� �� �� : sujiya 20201210
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef _ARTIGLOBAL_H_
#define _ARTIGLOBAL_H_

#include "StdInclude.h"
#include "StdShowMaco.h"
#include "EventTracking.h"

class CAlgorithmData;
class _STD_SHOW_DLL_API_ CArtiGlobal
{
public:

    // ���ڽӿ�GetHostType�ķ���ֵ
    enum class eHostType :uint32_t
    {   //APP������������
        HT_IS_TABLET    = 1,        //��ʾ��ǰӦ�õ�������ƽ��
        HT_IS_PHONE     = 2,        //��ʾ��ǰӦ�õ��������ֻ�
        HT_IS_PC        = 3,        //��ʾ��ǰӦ�õ�������PC

        HT_IS_INVALID   = 0xFFFFFFFF,
    };


    // ���ڽӿ�GetAppProductName�ķ���ֵ
    enum class eProductName :uint32_t
    {   //��ǰappӦ�õĲ�Ʒ����
        PD_NAME_AD900   = 1,          // "AD900",     ��ʾ��ǰ��Ʒ��ΪAD900
        PD_NAME_AD200   = 2,          // "AD200",     ��ʾ��ǰ��Ʒ��ΪAD200
        PD_NAME_TOPKEY  = 3,          // "TOPKEY",    ��ʾ��ǰ��Ʒ��ΪTOPKEY

        PD_NAME_NINJA1000PRO = 4,     // "NINJA1000PRO", ��ʾ��ǰ��Ʒ��ΪNinja1000 Pro
        PD_NAME_AD900_LITE   = 5,     // "AD900 LITE"
        PD_NAME_KEYNOW       = 6,     // "KEYNOW"
        PD_NAME_AD500        = 7,     // "AD500"
        
        PD_NAME_TP005_TOPVCI = 8,     // "TP005", ��ʾ��ǰ��Ʒ��Ϊ���ڰ�TOPVCI��"С��̽"
        PD_NAME_PG1000_DOI   = 9,     // "PG1000 DOIԶ�����"

        PD_NAME_ADAS_TABLET   = 10,   // "ADAS"
        PD_NAME_TOPVCI_PRO    = 11,   // "TP011", ��ʾ��ǰ��Ʒ��Ϊ���ڰ�"С��̽Pro"
        PD_NAME_TOPSCAN_HD    = 12,   // "TOPSCAN HD", ��ʾ��ǰ��Ʒ��Ϊ"TOPSCAN HD"
        PD_NAME_TOPVCI_CARPAL = 13,   // "CARPAL", ��ʾ��ǰ��Ʒ��Ϊ�����"С��̽"����"CarPal"
        PD_NAME_CARPAL_GURU   = 14,   // "CARPAL GURU", ��ʾ��ǰ��Ʒ��Ϊ"CarPal Guru"��ˢ���أ�
        PD_NAME_AD800BT       = 15,   // "AD800BT", ��ʾ��ǰ��Ʒ��Ϊ"AD800BT 2"������AD800BT2��
        PD_NAME_AD_MOTOR      = 16,   // "ArtiDiag Motor", ��ʾ��ǰ��Ʒ��ΪArtiDiag Moto��Ӳ����AD500һ�£�
        PD_NAME_UL_MOTOR      = 17,   // "UltraDiag Motor", ��ʾ��ǰ��Ʒ��ΪUltraDiag Moto��Ӳ����AD900һ�£�
        PD_NAME_DEEPSCAN      = 18,   // "DeepScan"��"����TopScan", ��ʾ��ǰ��Ʒ��Ϊ���Ե�TopScan��NT = neutral
        PD_NAME_TOPSCAN_VAG   = 19,   // "TOPSCAN", "TOPSCAN VAG", ��ʾ��ǰ��Ʒ��Ϊ���VW��TOPSCAN��ͨ������£�ֻ������IOS
        PD_NAME_TOPDON_ONE    = 20,   // "TOPDON ONE", "TOPDON ONE", ��ʾ��ǰ��Ʒ��Ϊ"TOPDON ONE"������10��ƽ�壩
        PD_NAME_DS100         = 21,   // "GOOLOO OBD", "DS100", ��ʾ��ǰ��Ʒ��Ϊ"GOOLOO OBD"�������ᶨ��CarPal��
        PD_NAME_DS900         = 22,   // "GOOLOO DS900", "DS900", ��ʾ��ǰ��Ʒ��Ϊ"GOOLOO DS900"�������ᶨ��DS900��
        
        PD_NAME_INVALID = 0xFFFFFFFF,
    };


    // ���ڽӿ�GetAppScenarios�ķ���ֵ
    enum class eAppScenarios :uint32_t
    {   //��ǰappӦ��ʹ�õĳ����������Ƿ�����ʽ�����û���ʹ�ó���
        AS_EXTERNAL_USE = 1,          // ��ʽ�����û���ʹ�ó����������û�ʹ�ó���
        AS_INTERNAL_USE = 2,          // ���˶���ʹ�ó����ĺ���

        AS_OTHER_INVALID = 0xFFFFFFFF,
    };

    // ���ڽӿ�GetAutoVinScannMode�ķ���ֵ
    enum class eAutoVinScannMode :uint32_t
    {   //��ǰappӦ���У�AutoVin��ɨ��Э��ģʽ������ʹ���ϴα����Э������ȡVIN
        AVSM_MODE_NORMAL            = 1,          // ����AUTOVINЭ��ɨ��ģʽ
        AVSM_MODE_LAST_PROTOCOL     = 2,          // AUTOVINʹ���ϴα����Э��ȥ��ȡVIN

        AVSM_MODE_INVALID = 0xFFFFFFFF,
    };

    // ���ڽӿ�GetDiagMenuMask�ķ���ֵ�����Ӧ�öԳ��͵Ĳ˵����ж�̬����
    enum class eDiagMenuMask :uint64_t
    {   //��ǰ��ϵ�ϵͳ����ֵ
        DMM_SUPPORT_NONE_SYSTEM = 0,            // ��ʾ��ǰ��֧���κ�ϵͳ

        DMM_ECM_CLASS      = (1 << 0),          // ����ϵͳ��    ���������������������ء�Ѳ��������Դ���ϵͳ��ϵͳ
        DMM_TCM_CLASS      = (1 << 1),          // ����ϵ����    �����������ϵͳ
        DMM_ABS_CLASS      = (1 << 2),          // �ƶ�ϵͳ��    ������ABS��EPB��ɲ��Ƭ��ϵͳ
        DMM_SRS_CLASS      = (1 << 3),          // ��ȫ������    ����: SRS/Airbag����ȫ������̥/̥ѹ��ϵͳ
        DMM_HVAC_CLASS     = (1 << 4),          // �յ�ϵ����    �������յ�����������ϵͳ
        DMM_ADAS_CLASS     = (1 << 5),          // ADASϵ����    ������ADAS�������г�������ͷ��
        DMM_IMMO_CLASS     = (1 << 6),          // ��ȫ������    ������immobiliser/immobilizer��Key����������ͷ��ϵͳ
        DMM_BMS_CLASS      = (1 << 7),          // ���ϵͳ��    ������ȼ�ͳ��ĵ�ء�����Դ�ĵ�ع���ϵͳ
        DMM_EPS_CLASS      = (1 << 8),          // ת��ϵͳ��    ������EPS�������̵�
        DMM_LED_CLASS      = (1 << 9),          // �ƹ�ϵͳ��    ����: ��ơ��г��Ƶ�
        DMM_IC_CLASS       = (1 << 10),         // �Ǳ�ϵͳ��    ����: �Ǳ��п���ء�����˿��ϵͳ��
        DMM_INFORMA_CLASS  = (1 << 11),         // ��Ϣ������    ����: DVD�����������г�/���ڼ�¼�ǡ���������λ��ϵͳ
        DMM_BCM_CLASS      = (1 << 12),         // ���������    ���������š�������β�䡢�������ա����ȡ���ε�

        DMM_OTHER_CLASS    = (0xFFFFFFFF),      // ��ֵ��ʾ�޷����࣬ͳһ�á�����������

        DMM_ALL_SYSTEM_SUPPORT  = 0x7FFFFFFFFFFFFFFF,           // ֧������ϵͳ�κι���
        DMM_INVALID             = 0xFFFFFFFFFFFFFFFF,           // ��֧���κ�ϵͳ�κι���
    };

    // ���ڽӿ�GetHiddenMenuMask�ķ���ֵ��ˢ�������Ӧ�ø��ݺ�̨�Ĳ˵����ж�̬����
    // ��ʾ�������App����ˢ���ع�������ӿڣ�����GetDiagMenuMask��From IOT��App���̨�ӿ���ʹ�����ϵͳ�����ֶΣ�
    enum class eHiddenMenuMask :uint64_t
    {   //��ǰˢ���صĹ�������ֵ
        HMM_SUPPORT_NONE_FUNCTION = 0,               // ��ʾ��ǰ��֧���κι���
                                                     
        HMM_CHASSIS_ENGINE_CLASS   = (1 << 0),       // Chassis & Engine                 ����&����
        HMM_DRIVING_STEER_CLASS    = (1 << 1),       // Driving Assist&Steering Wheel    ��ʻ���� �������̣�
        HMM_AC_CLASS               = (1 << 2),       // Heater & A/C                     �յ�&����
        HMM_IM_CLASS               = (1 << 3),       // Instruments                      �Ǳ�&�п�&��ý��
        HMM_LIGHTS_CLASS           = (1 << 4),       // Lights                           �ƹ�
        HMM_LOCK_CLASS             = (1 << 5),       // Lock                             ��
        HMM_MIRRORS_CLASS          = (1 << 6),       // Mirrors                          ���Ӿ�
        HMM_DOOR_CLASS             = (1 << 7),       // Windows&Door&Sunroof             ��&��
        HMM_WIPERS_CLASS           = (1 << 8),       // Wipers & Washer                  ���
        HMM_SEATS_CLASS            = (1 << 9),       // Seats&Belt                       ����&��ȫ��
        HMM_WARNING_OTHER_CLASS    = (1 << 10),      // Warnings & Other                 �澯������

        HMM_ALLFUN  = 0x7FFFFFFFFFFFFFFF,            // ֧���κι���
        HMM_INVALID = 0xFFFFFFFFFFFFFFFF,            // ��֧���κι���
    };


    // ���������ͣ����ڽӿ�GetObdEntryType�ķ���ֵ�����������в�Ʒ
    enum class eObdEntryType :uint32_t
    {
        //��ǰOBD����ϳ��͵��������

        // ��ҳ������������ݷ�ʽ���룬������ڰ�TOPVCI(С��̽)
        OET_TOPVCI_DATASTREAM       = (1 << 0),  // ���ڰ�TOPVCI��ҳ������,   1 << 0

        // ��ҳ���������ԡ���ݷ�ʽ���룬������ڰ�TOPVCI(С��̽)
        OET_TOPVCI_ACTIVE_TEST      = (1 << 1),  // ���ڰ�TOPVCI��ҳ��������, 1 << 1

        // ��ҳ��̧ͷ��ʾ����ݷ�ʽ���룬������ڰ�TOPVCI(С��̽)
        OET_TOPVCI_HUD              = (1 << 2),  // ���ڰ�TOPVCI��ҳ̧ͷ��ʾ, 1 << 2

        // ��ҳ�����Ԥ�󡱿�ݷ�ʽ���룬������ڰ�TOPVCI(С��̽)
        OET_TOPVCI_OBD_REVIEW       = (1 << 3),  // ���ڰ�TOPVCI��ҳ���Ԥ��, 1 << 3

        // �Ƿ����OBDһ��ɨ�������ϵͳ��OBD��ϳ�����ݴ�ֵ�ж�����ɨ�蹦��
        OET_TOPVCI_OBD_SCAN_SYS     = (1 << 4),  // ��ʾ��Ҫ����һ��ɨ��OBD������ϵͳ, 1 << 4


        ///////////////////////////////       CarPal      /////////////////////////////////////
        // ��ҳ����������⡱��ݷ�ʽ���룬����CarPal
        OET_CARPAL_OBD_ENGINE_CHECK = (1 << 5),  // CarPal��ҳ���������, 1 << 5

        // ��ҳ��IMԤ�ŷš���ݷ�ʽ���룬����CarPal
        OET_CARPAL_IM_PROTOCOL      = (1 << 6),  // CarPal��ҳIMԤ�ŷ�,   1 << 6
        ////////////////////////////////////////////////////////////////////////////////////////


        ///////////////////////////////     CarPal Guru    /////////////////////////////////////
        // CarPal Guru ��ҳ��ˢ���ء���ݷ�ʽ����
        OET_CARPAL_GURU_HIDDEN      = (1 << 7),  // CarPal Guru ��ҳˢ����,  1 << 7

        // CarPal Guru ��ҳ������������ݷ�ʽ����
        OET_CARPAL_GURU_DATASTREAM  = (1 << 8),  // CarPal Guru ��ҳ������,  1 << 8

        // CarPal Guru ��ҳ���������ԡ���ݷ�ʽ����
        OET_CARPAL_GURU_ACTIVE_TEST = (1 << 9),  // CarPal Guru ��ҳ��������, 1 << 9
        ////////////////////////////////////////////////////////////////////////////////////////


        ///////////////////////////////     ����    /////////////////////////////////////
        // ��������ϡ� ��ݷ�ʽ����
        OET_DIAG_DIAG            = (1 << 16),  // ������ϣ�·����ʽ����,  1 << 16

        // ������������ ��ݷ�ʽ����
        OET_DIAG_MAINTENANCE     = (1 << 17),  // ����������·����ʽ����,  1 << 17

        // ������������ ��ݷ�ʽ����
        OET_DIAG_IMMO            = (1 << 18),  // ����������·����ʽ����,  1 << 18


        // ��Ħ�г���ϡ� ��ݷ�ʽ����
        OET_MOTOR_DIAG            = (1 << 19),  // Ħ�г���ϣ�·����ʽ����,  1 << 19
        
        // ��Ħ�г������� ��ݷ�ʽ����
        OET_MOTOR_MAINTENANCE     = (1 << 20),  // Ħ�г�������·����ʽ����,  1 << 20

        // ��Ħ�г������� ��ݷ�ʽ����
        OET_MOTOR_IMMO            = (1 << 21),  // Ħ�г�������·����ʽ����,  1 << 21


        // ��ADAS�� ��ݷ�ʽ����
        OET_ADAS                  = (1 << 22),  // ADAS·����ʽ����,  1 << 22
        
        // ��TDart�� ��ݷ�ʽ����
        OET_TDARTS                = (1 << 23),  // TDARTS��T-Kunai ·����ʽ����,  1 << 23
        ////////////////////////////////////////////////////////////////////////////////////////


        // ��ǰApp��֧�ִ���ڹ��ܽӿڣ�Ӧ�����ж��Ƿ���ڴ�ֵ����������ж��Ƿ�����ĸ�����
        OET_APP_NOT_SUPPORT  = DF_FUNCTION_APP_CURRENT_NOT_SUPPORT,
    };

    // ���AUTOVIN���ڽӿ�GetAutoVinEntryType�ķ���ֵ
    enum class eAutoVinEntryType :uint32_t
    {
        //��ǰAUTOVIN���͵��������

        // ��ҳ ==> ����ϡ� ==> ��AUTOVIN��  ����ҳ�������ڽ�ȥ���ٵ��AUTOVIN
        AVET_DIAG = (1 << 0),     // ����ҳ�������ڽ����AUTOVIN,   1 << 0

        // ��ҳ ==> �������� ==> ��AUTOVIN��  ����ҳ�ķ�����ڽ�ȥ���ٵ��AUTOVIN
        AVET_IMMO = (1 << 1),     // ����ҳ�ķ�����ڽ����AUTOVIN,   1 << 1

        // ��ҳ ==> ��Ħ�г��� ==> ��AUTOVIN��  ����ҳ��Ħ�г���ڽ�ȥ���ٵ��AUTOVIN
        AVET_MOTOR = (1 << 2),    // ����ҳ��Ħ�г���ڽ����AUTOVIN,   1 << 2

        // ��ǰApp��֧�ִ���ڹ��ܽӿ� 
        AVET_APP_NOT_SUPPORT = DF_FUNCTION_APP_CURRENT_NOT_SUPPORT,
    };

public:
    CArtiGlobal() {}
    ~CArtiGlobal() {}

public:
    /*-----------------------------------------------------------------------------
      ��    �ܣ���ȡstdshow�汾��

                PC�����У����ص���StdShow.dll�İ汾��
                Android�У����ص���libstdshow.so�İ汾��

      ����˵������

      �� �� ֵ��32λ ���� 0xHHLLYYXX

      ˵    ����Coding of version numbers
                HH Ϊ ����ֽ�, Bit 31 ~ Bit 24   ���汾�ţ���ʽ���У���0...255
                LL Ϊ �θ��ֽ�, Bit 23 ~ Bit 16   �ΰ汾�ţ���ʽ���У���0...255
                YY Ϊ �ε��ֽ�, Bit 15 ~ Bit 8    ��Ͱ汾�ţ�����ʹ�ã���0...255
                XX Ϊ ����ֽ�, Bit 7 ~  Bit 0    ����

                ���� 0x02010300, ��ʾ V2.01.003
                ���� 0x020B0000, ��ʾ V2.11
    -----------------------------------------------------------------------------*/
    static uint32_t GetVersion();


    /*-----------------------------------------------------------------------------
      ��    �ܣ���ȡ��ʾӦ�õİ汾��

                PC�����У����ص���TOPDON.exe�İ汾��
                Android�У����ص���APK�İ汾��

      ����˵������

      �� �� ֵ��32λ ���� 0xHHLLYYXX

      ˵    ����Coding of version numbers
                HH Ϊ ����ֽ�, Bit 31 ~ Bit 24   ���汾�ţ���ʽ���У���0...255
                LL Ϊ �θ��ֽ�, Bit 23 ~ Bit 16   �ΰ汾�ţ���ʽ���У���0...255
                YY Ϊ �ε��ֽ�, Bit 15 ~ Bit 8    ��Ͱ汾�ţ�����ʹ�ã���0...255
                XX Ϊ ����ֽ�, Bit 7 ~  Bit 0    ����

                ���� 0x02010300, ��ʾ V2.01.003
                ���� 0x020B0000, ��ʾ V2.11
    -----------------------------------------------------------------------------*/
    static uint32_t GetAppVersion();


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ��ǰ����
    ����˵������
    ����ֵ��en,cn
    ˵������
    -----------------------------------------------------------------------------*/
    static std::string const GetLanguage() ;


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ��ǰ����·��
    ����˵������

    ����ֵ����ǰ����·����Windows ��Diag.dll����·��

    ˵����·��Ϊ����·����
          Windows ���磺"E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\Demo"
    -----------------------------------------------------------------------------*/
    static std::string const GetVehPath();


    /*-----------------------------------------------------------------------------------------------------
    ���ܣ���ȡָ��Ʒ�Ƶĳ���·��

    ����˵����strVehType    ָ���ĳ������ͣ����ִ�Сд
                            ����DIAG,      "Diagnosis"
                            ����IMMO,      "Immo"
                            ����RFID,      "RFID"
                            ����NewEnergy, "NewEnergy"

              strVehArea    ָ��Ʒ�Ƴ������ڵ��������ִ�Сд
                            ����EOBD��     "Europe"
                            ����AUDI��     "Europe"
                            ����AUTOVIN��  "Public"
              
              strVehName    ָ��Ʒ�Ƴ������ƣ����ִ�Сд
                            ����EOBD��"EOBD"
                            ����AUDI��"VW"

    ����ֵ��ָ������·����Windows ��Diag.dll����·��
            ���strVehTypeΪ�գ��򲻴��ڣ����ؿմ�""
            ���strVehAreaΪ�գ��򲻴��ڣ����ؿմ�""
            ��������ڴ˳������ؿմ�""

            ���strVehNameָ���������ӳ����������ӳ�ָ����ʵ�ʳ���·��
            ����strVehType="Diagnosis", strVehArea="Europe", strVehName="AUDI"������Ӧ����ʵ�ʵ�VW����·��
            /sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/AD900/11017762H10003/Diagnosis/Europe/VW

    ˵ ����·��Ϊ����·����
           Windows ���磺"E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\Demo"
           Windows ���磺"E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\EOBD"
           Windows ���磺"E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\VW"
           /sdcard/Android/data/com.topdon.diag.artidiag/files/TopDon/AD900/11017762H10003/Diagnosis/Public/AUTOVIN
    ---------------------------------------------------------------------------------------------------------------------------------*/
    static std::string const GetVehPathEx(const std::string& strVehType, const std::string& strVehArea, const std::string& strVehName);


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ��ǰ���͵��û�����·�����ǳ���·����,��·���µ��ļ����ų������
          �������ᱻɾ�������

    ����˵������

    ����ֵ����ǰ���͵��û�����·��

    ˵����·��Ϊ����·����
          Windows ���磺"C:\ProgramData\TOPDON\IMMO\BMW"
          Android ���磺"/mnt/sdcard/Android/data/com.topdon.diag.artidiag
                         /files/TopDon/AD900/UserData/IMMO/BMW"
    -----------------------------------------------------------------------------*/
    static std::string const GetVehUserDataPath();



    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ��ǰ��������
    ����˵������

    ����ֵ����ǰ����·�����ļ������ƣ�Windows ��Diag.dll����·�����ļ�������

    ˵����Windows ���磺
          �������·��Ϊ"E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\Demo"
          �򷵻��ַ���Ϊ"Demo"
    -----------------------------------------------------------------------------*/
    static std::string const GetVehName();


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ��ǰ����VIN��
    ����˵������

    ����ֵ��Ӧ����֪�ĳ���VIN�루�������AutoVin��ȡ���ģ�����OCRɨ�����Ƶõ��ģ�

    ˵��������ֵ������
                    LFV3A23C2H3181097
    -----------------------------------------------------------------------------*/
    static std::string const GetVIN();


    /*-----------------------------------------------------------------------------
    ���ܣ����õ�ǰ����VIN��
          �������ʷ��VIN����Դ���

    ����˵����������õ�ǰ��ȡ����VIN������ LFV3A23C2H3181097

    ����ֵ����
    -----------------------------------------------------------------------------*/
    static void SetVIN(const std::string& strVin);


    /*-----------------------------------------------------------------------------
    ���ܣ�����VIN�����ĳ��͸�APK/APP��AUTOVIN����ϳ��͵���

          AUTOVIN������õ�ǰ��������
          AUTOVIN���ݻ�ȡ����VIN��������Ӧ�ĳ��ͣ���VIN��Ӧ�ĳ��͸�APK/APP
          ��ϳ��������A���������⵽��ǰ�Լ�����������ܲ��Ե�ǰ���������Բ��Եĳ�
          �������B�������ͨ���˽ӿ����ø�APK/APP��ͬʱͨ��SetCurVehNotSupport�ӿ�֪ͨ
          APK/APP��Ҫ�л����½���

    ����˵����vctVehicle     �������Ķ�Ӧ���ܳ��͵ļ���
                             ����������Ŀ��ܳ����кü�����ͨ������vctVehicle���APP/APK
                             �������������Ӧ�ĳ��ͣ���vctVehicleΪ��
                             ���vctVehicle�����СΪ2�������2�ֵĿ��ܴ��ڳ���
                             APP/APK��Ҫ������ĸ��Сд

             ���磺vctVehicle�������СΪ4���ֱ���"Chrysler","Fiat","JEEP","Dodge"
             ��VIN��Ӧ�ĳ�������4�ֳ���

             ���磺vctVehicle�������СΪ7���ֱ�"Fawcar", "FawDaihatsu", "MazdaChina",
             "TJFAW", "ToyotaChina", "BesTune", "HongQi"
             ��VIN��Ӧ�ĳ�������7�ֳ���


    ����ֵ����


    ע  �⣺������õ�ǰ��������
            AUTOVIN��ȡVIN���;��������ͨ��GETVIN����ȡ����ο��Դӳ���ͨѶ�л�ȡ
    -----------------------------------------------------------------------------*/
    static void SetVehicle(const std::vector<std::string>& vctVehicle);
    

    /*-----------------------------------------------------------------------------
    ���ܣ�����VIN�����ĳ�����Ϣ��APK/APP����������Ϊ�ջ��߿մ�""

          AUTOVIN������õ�ǰ����������Ϣ
          AUTOVIN���ݻ�ȡ����VIN��������Ӧ�ĳ���Ŀ¼�ļ�������
                                  ��VIN��Ӧ�ĳ���Ŀ¼�ļ������Ƹ�APK/APP


    ����˵����
             vctVehDir       �������Ķ�Ӧ���ܳ��͵�Ŀ¼�ļ������Ƶļ���
                             ����������Ŀ��ܳ����кü�����ͨ������vctVehDir���APP/APK
                             �������������Ӧ�ĳ��ͣ���vctVehDirΪ��
                             ���vctVehDir�����СΪ2�������2�ֵĿ��ܴ��ڳ���

             vctVehName      ��û��ʹ�ã�����

             vctSoftCode     ��Ӧ��������룬vctVehDir��vctSoftCode�Ĵ�С����һ��


             ����1��vctVehDir�Ĵ�СΪ3���ֱ���"BUICK", "CADILLAC", "CHEVROLET"

                    vctVehNameΪ��

                    vctSoftCode�ĵ�УΪ3���ֱ���"AD900_CarSW_BUICK", "AD900_CarSW_CADILLAC", "AD900_CarSW_CHEVROLET"

             ����2��vctVehDir�Ĵ�СΪ2���ֱ���"GM", "GMBRAZIL"

                    vctVehNameΪ��

                    vctSoftCodeΪ�գ��ֱ���"AD900_CarSW_GM", "AD900_CarSW_GMBRAZIL"

    ����ֵ����


    ע  �⣺������õ�ǰ��������
            AUTOVIN��ȡVIN���;��������ͨ��GETVIN����ȡ����ο��Դӳ���ͨѶ�л�ȡ
    -----------------------------------------------------------------------------*/
    static void SetVehicleEx(const std::vector<std::string>& vctVehDir, const std::vector<std::string>& vctVehName, const std::vector<std::string>& vctSoftCode);


    /*-----------------------------------------------------------------------------
    ���ܣ����ó�����Ϣ
          ��ʷ��ϵ����·����Դ���

    ����˵����������õ�ǰ������Ϣ

            ���磺����/3'/320Li_B48/F35/

    ����ֵ����
    -----------------------------------------------------------------------------*/
    static void SetVehInfo(const std::string& strVehInfo);


    /*-----------------------------------------------------------------------------
    ���ܣ�����ϵͳ����

    ����˵����������õ�ǰϵͳ����

            ���磺RCM-��ȫ��������ϵͳ

    ����ֵ����
    -----------------------------------------------------------------------------*/
    static void SetSysName(const std::string& strSysName);


    /*-----------------------------------------------------------------------------
    ���ܣ�����ADAS��MMYS��Ϣ

    ����˵����strMake     Ʒ��
              strModel    ����
              strYear     ���
              strSys      ϵͳ

    ����ֵ����
    -----------------------------------------------------------------------------*/
    static void SetAdasMMYS(const std::string& strMake, const std::string& strModel, const std::string& strYear, const std::string& strSys);


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡADAS�ĵ�У׼���ݣ�������ü�߶ȣ�ȼ��Һλ

    ����˵����eAcdType    ��ȡADASУ׼���ݵ�����

                      ACD_CAL_WHEEL_BROW_HEIGHT_LF   ��ǰ����������
                      ACD_CAL_WHEEL_BROW_HEIGHT_RF   ��ǰ����������
                      ACD_CAL_WHEEL_BROW_HEIGHT_LR   �������������
                      ACD_CAL_WHEEL_BROW_HEIGHT_RR   �Һ�����������
                      ACD_CAL_FUEL_LEVEL             ȼ��Һλ��������

    ����ֵ������eAcdType��Ӧ���������ֵ
    -----------------------------------------------------------------------------*/
    static float GetAdasCalData(eAdasCaliData eAcdType);


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ������ʷ��¼

          �ڽ��복��ʱ�����ʹ����ڳ�ʼ��ʱ����ô˽ӿڣ��ж��Ƿ��Ǵ���ʷ��¼�н��룬
          ���һ�ȡ��"SetHistoryRecord"�б�����ִ���Ϣ���Ա㳵�ʹ����߼������ж���һ
          ������

    ����˵������

    ����ֵ���������������ʷ��¼�е�"SetHistoryRecord"���õ��ִ�
    -----------------------------------------------------------------------------*/
    static std::string const GetHistoryRecord();


    /*-----------------------------------------------------------------------------
    ���ܣ����ó�����ʷ��¼

          ������ʹ�������˴˽ӿڣ�App��ʼһ����ʷ��¼�����ʹ��������Ҫ�����ص�
          ��ʷ��Ϣ��ͨ�����½ӿ�����
          SetHistoryMileage
          SetHistoryDtcItem
          SetHistoryMMY
          SetHistoryEngine
          

    ����˵����strRecord  ��ʷ��¼����ִ���Ϣ����Ϣ�����ɳ���������ɾ���
                         App���𱣴��ڳ�����ʷ���ݿ��У��Ա��´γ��ͽ���ʱ
                         ����"GetHistoryRecord"ȥ��ȡ

    ����ֵ����
    
    ˵  ����
          ��ʷ��¼���ɹ���˵��
          1��ѡ����ɽ�����Ϲ��ܲ˵����棬����1�������ʷ��¼
          2����ϵͳ�����ϵͳɨ�裬����ͨ���ӿ�
             SetHistoryMileage
             SetHistoryDtcItem
             SetHistoryMMY
             SetHistoryEngine
             ����ǰϵͳ�͹�������Ϣ��ӵ������ʷ��¼��
          3����ε���SetHistoryDtcItem����ϵͳName�����ֲ�ͬϵͳ��
             ͬһϵͳ�Ķ�ι�����Ϣ�����һ��Ϊ׼
          4����ε���SetHistoryHiddenItem���Թ��ܴ������ƺ���������������
          5����ʷ��VIN����ͨ��SetVIN�ӿ�����
             ��ʷ�ĳ���·��������"����>302>ϵͳ>�Զ�ɨ��"������ͨ��SetVehInfo����
             �����Ҫ����VIN�ͳ������·������Ҫ��SetHistoryRecord����ǰ����
    -----------------------------------------------------------------------------*/
    static void SetHistoryRecord(const std::string& strRecord);


    /*-----------------------------------------------------------------------------
    ���ܣ�������ʷ��¼����ʾ�ĳ�����ʻ��̣�KM��

    ����˵����������õ�ǰ������ʻ����̣�KM��

            strMileage            ��ǰ������ʻ����̣�KM��
            strMILOnMileage        ���ϵ��������ʻ��̣�KM��

            ���磺568        ��ʾ��ʻ�����Ϊ568KM

    ����ֵ��

    ˵  ��������ޡ����ϵ��������ʻ��̡�����strMILOnMileageΪ�մ�""���
    -----------------------------------------------------------------------------*/
    static void SetHistoryMileage(const std::string& strMileage, const std::string& strMILOnMileage);


    /*-----------------------------------------------------------------------------
    ���ܣ������ʷ��¼����ʾ�Ĺ�������Ϣ

    ����˵����DtcItem    �������б�� �ο�stDtcReportItemEx�Ķ���

    ����ֵ����

    ˵  ��������ϵͳ��������Ϣ�����ϵͳ��ͬ�������һ������Ϊ׼
    -----------------------------------------------------------------------------*/
    static void SetHistoryDtcItem(const stDtcReportItemEx &DtcItem);


    /*-----------------------------------------------------------------------------
    ���ܣ�������ʷ��¼�е�MMY��Ϣ

    ����˵����strMake     Ʒ��
              strModel    ����
              strYear     ���

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
              ����ֵ����������
    -----------------------------------------------------------------------------*/
    static uint32_t SetHistoryMMY(const std::string& strMake, const std::string& strModel, const std::string& strYear);


    /*-----------------------------------------------------------------------------
    ���ܣ�������ʷ��¼�еĳ�����������Ϣ

    ����˵����
            strInfo      ����������Ϣ�����磬"F62-D52"
            strSubType   ���������ͺŻ���������Ϣ�����磬"N542"

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
              ����ֵ����������
    -----------------------------------------------------------------------------*/
    static uint32_t SetHistoryEngine(const std::string& strInfo, const std::string& strSubType);


    /*-----------------------------------------------------------------------------------------------
    ���ܣ������ʷ��¼�е�ˢ���ع�������Ϣ

    ����˵����
            HiddenItem      ˢ���ع�������Ϣ

            struct stHistoryHidden
            {
                // ˢ���ع��ܴ���
                std::string strName;      // ϵͳ���ƻ��ܴ�������
                                          // ���硰ǰ�˵���ģ�顱���ƹ����á�

                // ˢ���ع�������
                std::string strSubName;   // �������ƣ��ӹ��ܣ�
                                          // ���硰�ռ��г��ơ�����ת��ơ�����ת��ơ�

                // ˢдǰ���״̬
                std::string strBeforeVal; // ˢдǰ��״̬�����硰δ���������Ѽ��
                std::string strAfterVal;  // ˢд���״̬�����硰������  ��δ���

                // ˢд���ö��
                uint32_t    uCurStatus;   // ��ǰ����ִ�е�״̬ö�٣���ˢд״̬
                                          // HNS_FUNC_HIDDEN_OK      1 ˢд�ɹ�
                                          // HNS_FUNC_HIDDEN_FAILED  2 ˢдʧ��
            };

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
              ����ֵ����������

    ˵  ���� ˢ���ع�������Ϣ

             �����ε���SetHistoryHiddenItem�����ܴ���͹������඼��ͬ��
             �򣺶�Ӧ���ܴ����ˢд�������䣬���������������һ������Ϊ׼

             ��ε���SetHistoryHiddenItem�����ܴ�����ͬ��strName��Ϊ�մ�����
             �������಻ͬ��strSubName��Ϊ�մ���
             �򣬶�Ӧ���ܴ����ˢд������1

             ������ܴ�����ͬ��strName��Ϊ�մ�������������strSubNameΪ�մ�
             ��û�ж�Ӧ�����๦����ʷ��¼������Ӧ���ܴ����ˢд����Ϊ0
             ��Ӧ���ܴ����ˢд����Ϊ0�������һ�ε���Ϊ׼
             
             ���磬ǰ�������˹��ܴ�������࣬����Ҫ��ָ���Ĺ��ܴ���ˢд�����������
             ����Ӧ����Ĺ���������Ϊ�մ�����
    -----------------------------------------------------------------------------------------------*/
    static uint32_t SetHistoryHiddenItem(const stHistoryHidden& HiddenItem);
    


    /*-----------------------------------------------------------------------------
    ���ܣ��Ƿ��Ǵ���ʷ��¼�н���

    ����˵������

    ����ֵ������û��ǵ������ʷ����ģ����� true
            ����û����ǵ����ʷ����ģ����� false

    ˵  ������������ж��Ƿ����ʷ��¼����
    -----------------------------------------------------------------------------*/
    static bool IsEntryFromHistory();


    /*-----------------------------------------------------------------------------
    ���ܣ�����AUTOVINͨѶ��Э�������ִ�
          APP�����Ա��´ν���(AutoVin)����GetAutoVinProtocol��ȡЭ����ٽ���

    ����˵����strProtocol    ��ϳ����Լ����������Э���ִ���Ϣ

    ����ֵ����

    ˵  ����������ϳ���AutoVin���ñ�����һ�ε�ͨѶЭ�飬�ӿ��ȡVIN����
            ���ڰ�TOPVCIС��̽
    -----------------------------------------------------------------------------*/
    static void SetAutoVinProtocol(const std::string& strProtocol);


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ�ϴ�AUTOVINͨѶ��Э�������ִ�
          APP����SetAutoVinProtocol�����Э���ִ�

    ����˵������

    ����ֵ�������ϴ�AUTOVINͨ��SetAutoVinProtocol�����Э�������ִ�

    ˵  ����������ϳ���AutoVinʹ��ָ����Э������ȥ��ȡ����VIN��ʵ�ֿ��ٻ�ȡVIN�Ĺ���
            ���ڰ�TOPVCIС��̽
    -----------------------------------------------------------------------------*/
    static std::string const GetAutoVinProtocol();


    /*-----------------------------------------------------------------------------
    ���ܣ���ȡ��ǰAUTOVIN��Э��ɨ��ģʽ
          APP���أ��Ƿ���ָ����Э��ȥ��ȡVIN��������������ȫЭ��ɨ��ģʽȥ��ȡVIN
          ���磬���ڰ�TOPVCIС��̽

    ����˵������

    ����ֵ��  AVSM_MODE_NORMAL        = 1,  // ����AUTOVINЭ��ɨ��ģʽ
              AVSM_MODE_LAST_PROTOCOL = 2,  // AUTOVINʹ���ϴα����Э��ȥ��ȡVIN

    ˵  �������ڰ�TOPVCIС��̽
    -----------------------------------------------------------------------------*/
    static eAutoVinScannMode GetAutoVinScannMode();


    /*-----------------------------------------------------------------------------
    ���ܣ���ϳ������ò�֧�ֵ�ǰVIN�복��

          APP�ڳ��ͣ���OBD�����ô˽ӿں���Ҫ�жϴ�ֵ�����������Ϊ��֧�֣�
          С��̽/CarPal������������OBD��TopScan����Ҫ����SetVehicle�ĳ��ͽ��뵽ָ��
          �ĳ��������APP��Ҫ�����˳��߼���UI

          ��ϳ����粻֧�ֵ�ǰ������Ҫ���ô˽ӿ�
          
    ����˵����eVehNotSupportType eType   �����Ƿ�֧��

              VBST_SUPPORT_NORMAL   = 0,    // Ĭ��ֵ��Ĭ��֧��
              VBST_VEH_NOT_SUPPORT  = 1,    // ��ǰ���ͳ��򣨷�OBD����֧�ֵ�ǰ����

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
              ����ֵ����������

    ˵  ���� ���ڰ�TOPVCIС��̽, TOPSCAN��
    -----------------------------------------------------------------------------*/
    static uint32_t SetCurVehNotSupport(eVehNotSupportType eType);


    /*-------------------------------------------------------------------------------------------------------
    ���ܣ���������¼�
          ��ϳ�����ô˽ӿ���������¼���App��App����Ӧ������¼��ϴ�����̨��Appע���
          �ӿڲ���������App����ö�Ӧ���¼����������ظ���ϳ���

    ����˵����eEventTrackingId                   eEventId   �¼�ID�������¼���ֵ�ο�eEventTrackingId�Ķ���
              ���� eEventId = ETI_CLICK_HF_OIL_RESET ��ʾ HF_Oilreset �¼�������ͳ�ơ��������㹦��ʹ���ʡ�

              std::vector<stTrackingItem>        &vctPara   ��������
              stTrackingItem�ṹ����Ϣ��
              struct stTrackingItem
              {
                  eTrackingInfoType eType;         // ���Ĳ�������
                  // ���� TIT_DTC_CODE����ʾstrValue ��ֵ�� "���������"

                  std::string     strValue;       // ʵ�����������͵��ַ���ֵ
                  // ���統 eType = TIT_DTC_CODE��strValueΪ "P1145"
                  // ���統 eType = TIT_VIN��strValueΪ "KMHSH81DX9U478798"
              };

              eTrackingInfoType ���ܺ�ֵ������
              TIT_VIN               ��ʾ����Ϊ�������ܺ�
              TIT_MAKE              ��ʾ����Ϊ����Ʒ��
              TIT_MODEL             ��ʾ����Ϊ����
              TIT_VEH_INFORMATION   ��ʾ����Ϊ������Ϣ�����磬����/3'/320Li_B48/F35/
              TIT_DTC_CODE          ��ʾ����Ϊ��������룬���磬"P1145"

              ���磬����VIN&Ʒ��&������Ϣ&ϵͳ��Ϣ��
              ����������4��Ԫ�أ��ֱ���VIN��Ʒ�ơ�������Ϣ��ϵͳ��Ϣ
              ���VINû�л�ȡ������VIN�ֶ�Ϊ��

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿڣ���ֵ��so����
              ����ֵ����������

    ˵  ����  ��
    -------------------------------------------------------------------------------------------------------*/
    static uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);


    /*-----------------------------------------------------------------------------
    *    ��  �ܣ����̱߳�źͳ�����Ϣ�������������ڶ�ϵͳ���
    * 
    *    ��  ����
                uThread    �̱߳��  uThread<=3
                pVehicleInfo  ָ���ʾ�����ܶ�λ��ϵͳ���� ����Ϊ��
    *
    *    ����ֵ����
    -----------------------------------------------------------------------------*/
    static void SetThreadVehiInfo(uint8_t uThread, void* pVehicleInfo);


    /*-----------------------------------------------------------------------------
    *    ��  �ܣ���ָ��SO���Ƶ��ļ�����������Ŀ¼�����ش�Ŀ¼�����ڳ����ļ��µ�so�ļ�
    * 
    *    ��  ����
    *            strSoName    ��Ҫ������so�ļ���������׺��
    *            
    *    ����ֵ��
    *           ��������ʵ��Ŀ¼·����
    *           ���磺/data/user/0/com.topdon.artidiag/app_libs/TopDon/Diagnosis/Car/Asia/DEMO
    * 
    * 
    *    ����1��˵����
    *    Դ�ļ�·��Ϊ��
    *    /storage/emulated/0/TopDon/TD001/Diagnosis/Europe/BMW/libBmwPrg.so
    *
    *    ����Ŀ��Ŀ¼Ϊ��
    *    /data/user/0/com.topdon.artidiag/app_libs/TopDon/Diagnosis/Car/Europe/BMW
    *
    *    ʵ�� strSoName Ϊ�� "libBmwPrg.so"
    *    ����ֵΪ��
    *    "/data/user/0/com.topdon.artidiag/app_libs/TopDon/Diagnosis/Car/Europe/BMW"
    * 
    * 
    *    ����2��˵����
    *    Դ�ļ�·��Ϊ��
    *    /storage/emulated/0/Android/data/com.topdon.diag.artidiag/files/TopDon/AD900/11017762H10003/Diagnosis/China/COMM/TEST/Test.so
    * 
    *    ����Ŀ��Ŀ¼Ϊ��
    *    /data/user/0/com.topdon.diag.artidiag/app_libs/TopDon/Diagnosis/Car/COMM/TEST/Test.so
    * 
    *    ʵ�� strSoName Ϊ�� "TEST/Test.so"
    *    ����ֵΪ��
    *    "/data/user/0/com.topdon.diag.artidiag/app_libs/TopDon/Diagnosis/Car/COMM/"
    * 
    * 
    *    *********
    *    ע�⣺���˳����˳��󣬲�����Ҫ��so����������Ŀ¼���APK����ά��ɾ��
    * 
    -----------------------------------------------------------------------------*/
    static std::string const Copy2RunPath(const std::string& strSoName);



    /*-----------------------------------------------------------------------------
    *    ��  �ܣ���ָ��SO���Ƶ��ļ�����������Ŀ¼�����ش�Ŀ¼
    *            ����ָ���������͵�so�ļ������ҿ���������Ŀ��so�ļ���
    *
    *    ��  ����
    *            strVehType    ָ���ĳ������ͣ����ִ�Сд
    *                          ����DIAG,      "Diagnosis"
    *                          ����IMMO,      "Immo"
    *                          ����RFID,      "RFID"
    *                          ����NewEnergy, "NewEnergy"
    * 
    *            strVehArea    ָ����Ҫ����so�ļ������ڳ�����������Europe
    * 
    *            strVehName    ָ����Ҫ����so�ļ������ڳ������ƣ�����BMW
    * 
    *            strSoSrc      ��Ҫ������soԴ�ļ����ƣ����԰������·��
    *                          ����: E66/libDiag.so �� libDiag.so
    *            
    *            strSoDst      ��Ҫ������soĿ���ļ����ƣ��������������԰������·��
    *                          ����: E66/libBmwPrg.so �� libBmwPrg.so
    * 
    *    ����ֵ����������ʵ��Ŀ¼·����
    *           
    *           ���磺strVehType = Diagnosis, strVehArea = Europe, strVehName = BMW, strSoSrc = E66/libDiag.so, strSoDst = E66/libBmwPrg.so
    *           ����ֵ��/data/user/0/com.topdon.diag.artidiag/app_libs/TopDon/Diagnosis/Car/Europe/BMW
    *
    *
    *    ����˵����
    *    *********************************************************************
    *    ��ǰ����ΪNISSAN����Ҫ����AUTOVIN�µ�API/libDiag.so�ṩ�Ľӿڣ����追��������Ŀ¼
    * 
    *    ��Ҫ����Դ�ļ�·��Ϊ��
    *    /storage/emulated/0/Android/data/com.topdon.diag.artidiag/files/TopDon/AD900/11017762H10003/Diagnosis/Public/AUTOVIN/API/libDiag.so
    *
    *    ����Ŀ���ļ�·��Ϊ��
    *    /data/user/0/com.topdon.artidiag/app_libs/TopDon/Diagnosis/Public/AUTOVIN/API/libDiag_20230601.so
    *
    *    ��ʵ�Σ�
    *           strVehType Ϊ�� "Diagnosis"
    *           strVehArea Ϊ�� "Public"
    *           strVehName Ϊ�� "AUTOVIN"
    *           strSoSrc   Ϊ�� "API/libDiag.so"
    *           strSoDst   Ϊ�� "API/libDiag_20230601.so"
    * 
    *    ����ֵΪ��
    *    "/data/user/0/com.topdon.artidiag/app_libs/TopDon/Diagnosis/Public/AUTOVIN"
    *    *********************************************************************
    * 
    *    ע�⣺���˳����˳��󣬲�����Ҫ��so����������Ŀ¼���APK����ά��ɾ��
    *
    -----------------------------------------------------------------------------*/
    static std::string const Copy2RunPathEx(const std::string& strVehType, const std::string& strVehArea, const std::string& strVehName, const std::string& strSoSrc, const std::string& strSoDst);


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡƽ������к�

    ����˵���� ��

    �� �� ֵ������ƽ������к�, ���磺��ST0013BA100044��
    -----------------------------------------------------------------------------*/
    static std::string const GetTabletSN();


    /*-----------------------------------------------------------------------------
        ��    �ܣ� ��ȡƽ���6�ֽ�У����

        ����˵���� ��

        �� �� ֵ������ƽ���У����, ���磺��123456��
    -----------------------------------------------------------------------------*/
    static std::string const GetTabletKey();


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰӦ�õ����������ֻ�����ƽ��

    ����˵���� ��

    �� �� ֵ�� HT_IS_TABLET     ��ʾ��ǰӦ�õ�������ƽ��
               HT_IS_PHONE      ��ʾ��ǰӦ�õ��������ֻ�
               
    ע  �⣺   ���磬AD200�������ֻ�����iPad�����У�������ֻ������У�����HT_IS_TABLET
               �����iPad�����У�����HT_IS_PHONE
    -----------------------------------------------------------------------------*/
    static eHostType const GetHostType();


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰappӦ�õĲ�Ʒ����

    ����˵���� ��

    �� �� ֵ�� PD_NAME_AD900              ��ʾ��ǰ��Ʒ��ΪAD900
               PD_NAME_AD200              ��ʾ��ǰ��Ʒ��ΪAD200
               PD_NAME_TOPKEY             ��ʾ��ǰ��Ʒ��ΪTOPKEY
               PD_NAME_NINJA1000PRO       ��ʾ��ǰ��Ʒ��ΪNinja1000 Pro
    -----------------------------------------------------------------------------*/
    //[[deprecated("is deprecated, please use CAppProduct::Name() instead.")]]
    static eProductName const GetAppProductName();


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰappӦ�õ�ʹ�ó���

    ����˵���� ��

    �� �� ֵ�� AS_EXTERNAL_USE         ��ʾ��ʽ�����û���ʹ�ó������������û�ʹ�ó���
               AS_INTERNAL_USE         ��ʾ����Debugʹ�ó����ĺ���
    -----------------------------------------------------------------------------*/
    static eAppScenarios const GetAppScenarios();


    /*----------------------------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰ��ϵ��������
               GetDiagEntryType �ӿڷ���ֵֻ֧��64λ�����������ѳ�64����������ʹ��
               GetDiagEntryType �ѱ� GetDiagEntryTypeEx ����
               GetDiagEntryTypeEx �ӿڷ���ֵ��һ��bool�����飬�������������������

    ����˵���� ��

    �� �� ֵ�� GetDiagEntryType����DET_ALLFUN  ��ʾ��ǰ��ͨ���������������³������ĳ���
               GetDiagEntryType����DET_MT_OIL_RESET  ��ʾ���͹���Ĺ�������
               
               GetDiagEntryTypeEx���ص���һ��bool�����飬�����±��ʾ��Ӧ�Ĺ�������λ�ã������±�
               ��Ӧ��ֵ��ʾ��Ӧ�Ĺ�������ֵ��true����"1"��false����"0"
               
               GetDiagEntryTypeEx ����ֵ����
               ���ص������СΪ66�������ÿ��Ԫ�ض���true����֧�����й���
               ����±�ΪDET_MT_OIL_RESET��ֵΪfalse������6����С���0����ֵΪfalse������֧��
               "Oil Reset"����
    ----------------------------------------------------------------------------------------------*/
    //[[deprecated("is deprecated, please use CArtiGlobal::GetDiagEntryTypeEx() instead.")]]
    //static eDiagEntryType const GetDiagEntryType();
    static std::vector<bool> const GetDiagEntryTypeEx();


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡ�˵��������룬���ڻ�ȡ��ǰ��Ʒ��App���Ƿ�֧����Щ����ϵͳ�˵������ܣ�

               ���ʹ���ͨ���˽ӿڻ�ȡ��֧�ֵ�ϵͳ�˵����룬����Ͻӿ�GetDiagEntryType
               ��ȡ�������֧�ֵĹ������룬�Բ���չʾ�Ĳ˵����й��ˣ���չʾ�����γɲ�
               ͬ�Ĳ�Ʒ����Ҫ��

    ����˵���� ��

    �� �� ֵ�� eDiagMenuMask      ֧�ֵ�ϵͳ���룬"λ"ֵΪ"1"��ʾ֧�֣�"0"��ʾ��֧��

               ���磬DMM_ECM_CLASS����0x01����ʾ֧�֡�����ϵͳ�ࡱ
               ���磬0x03����ʾ֧�֡�����ϵͳ�ࡱ��֧�֡�����ϵ���ࡱ
               DMM_ALL_SYSTEM_SUPPORT����ʾ֧������ϵͳ��
    -----------------------------------------------------------------------------*/
    static eDiagMenuMask const GetDiagMenuMask(); 


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡˢ���ع��ܲ˵����룬���ڻ�ȡ��̨�Ƿ�֧����Щ���ܲ˵�

               ���ʹ���ͨ���˽ӿڻ�ȡ��֧�ֵĹ��ܲ˵�����

    ����˵���� ��

    �� �� ֵ�� eHiddenMenuMask      ֧�ֵĹ������룬"λ"ֵΪ"1"��ʾ֧�֣�"0"��ʾ��֧��
    -----------------------------------------------------------------------------*/
    static eHiddenMenuMask const GetHiddenMenuMask();


    /*-------------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰOBD���ͻ����������͵��������
    
               Ӧ�����ж��Ƿ����OET_APP_NOT_SUPPORT��ֵ����������ж��Ƿ�����ĸ�����

    ����˵���� ��

    �� �� ֵ�� 
               OET_TOPVCI_DATASTREAM      ��ҳ������������ʽ����
               OET_TOPVCI_ACTIVE_TEST     ��ҳ���������ԡ���ʽ����
               OET_TOPVCI_HUD             ��ҳ��̧ͷ��ʾ����ʽ����
               OET_TOPVCI_OBD_REVIEW      ��ҳ�����Ԥ�󡱷�ʽ����
               OET_TOPVCI_OBD_SCAN_SYS    ��ʾ��Ҫ����һ��ɨ��OBD������ϵͳ

               OET_CARPAL_OBD_ENGINE_CHECK     CarPal��ҳ���������
               OET_CARPAL_IM_PROTOCOL          CarPal��ҳIMԤ�ŷ�

               OET_CARPAL_GURU_HIDDEN          CarPal Guru ��ҳˢ����
               OET_CARPAL_GURU_DATASTREAM      CarPal Guru ��ҳ������
               OET_CARPAL_GURU_ACTIVE_TEST     CarPal Guru ��ҳ��������

               OET_DIAG_DIAG                    ��������ϡ�·����ʽ����
               OET_DIAG_MAINTENANCE             ������������·����ʽ����
               OET_DIAG_IMMO                    ������������·����ʽ����
               OET_MOTOR_DIAG                   ��Ħ�г���ϡ�·����ʽ����
               OET_MOTOR_MAINTENANCE            ��Ħ�г�������·����ʽ����
               OET_MOTOR_IMMO                   ��Ħ�г�������·����ʽ����
               OET_ADAS                         ��ADAS��·����ʽ����

               OET_APP_NOT_SUPPORT             ��ǰApp��֧�ִ���ڹ��ܣ�stdshow���ش�ֵ��
    -----------------------------------------------------------------------------------*/
    static eObdEntryType const GetObdEntryType();


    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰAUTOVIN��������ͣ�AUTOVIN����

    ����˵���� ��

    �� �� ֵ��
               AVET_DIAG              ����ҳ�������ڽ����AUTOVIN,   1 << 0
               AVET_IMMO              ����ҳ�ķ�����ڽ����AUTOVIN,   1 << 1
               AVET_MOTOR             ����ҳ��Ħ�г���ڽ����AUTOVIN,   1 << 2
               AVET_APP_NOT_SUPPORT   ��ǰApp��֧�ִ���ڹ��ܽӿ�
    -----------------------------------------------------------------------------*/
    static eAutoVinEntryType const GetAutoVinEntryType();


    /*-----------------------------------------------------------------------------
     *    ��    �ܣ����������Ƿ���ڣ����ҿ��Խ������Ӳ���������
     *
     *    ����˵������
     *
     *    �� �� ֵ��true     �������Ӵ��ڣ����ҿ��Խ������Ӳ���������
     *              false    ����û������
     -----------------------------------------------------------------------------*/
    static bool IsNetworkAvailable();


    /*-----------------------------------------------------------------------------
     *    ��    �ܣ���λ��ת��������Ӧ�ĵ�λֵת������ʾ���û��ĵ�λֵ
     *
     *    ����˵����stUnitItem uiSource          ��Ҫת���ĵ�λ��ֵ
     *
     *    �� �� ֵ��ת����ĵ�λ��ֵ
     * 
     *              1234 ǧ�� [km] = 766.7721 Ӣ�� [mi]
     *              ���磺���� ("km", "1234")
     *                    ���� ("mi.", "766.7721")
     -----------------------------------------------------------------------------*/
    static stUnitItem UnitsConversion(const stUnitItem& uiSource);


    /*-----------------------------------------------------------------------------
     *    ��    �ܣ���ȡ��ǰ�ĵ�λ��ģʽ�����ƻ���Ӣ�ƣ�
     *
     *    ����˵������
     *
     *    �� �� ֵ��eUnitType
     *                        UT_METRIC_MODE   ��ʾApp�У���ǰѡ����ǹ��Ƶ�λ
     *                        UT_ENGLISH_MODE  ��ʾApp�У���ǰѡ�����Ӣ�Ƶ�λ
     * 
     *              DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
     -----------------------------------------------------------------------------*/
    static eUnitType GetCurUnitMode();


    /*-----------------------------------------------------------------------------
     *    ��    �ܣ���ȡ��ǰ������Ϣ������������VIN�Ľ����ID
     *              ������Ϣ��APK���ݵ�ǰ����VIN�ӷ��������󵽵�VIN���������Ϣ
     *
     *     ����˵����eGviValue    ��ȡ��Ϣ���͵ĺ�ֵ
     * 
     *               GET_VIN_BRAND               = 0,     Ʒ��IDֵ
     *               GET_VIN_MODEL               = 1,     ����IDֵ
     *               GET_VIN_MANUFACTURER_NAME   = 2,     ��������
     *               GET_VIN_YEAR                = 3,     ���
     *               GET_VIN_CLASSIS             = 4,     ���̺�
     *               GET_VIN_MANUFACTURER_TYPE   = 5,     ��������
     *               GET_VIN_VEHICLE_TYPE        = 6,     ��������
     *               GET_VIN_FULE_TYPE           = 7,     ȼ������
     *               GET_VIN_ENERGY_TYPE         = 8,     ��Դ����
     *               GET_VIN_COUNTRY             = 9,     ����
     *               GET_VIN_AREA                = 10,    ����
     * 
     * 
     *    �� �� ֵ�����������ص�VIN����ϢIDֵ��ʮ�����ƴ���
     *    ע    �⣺�˽ӿڷ��صĶ���ID
     -----------------------------------------------------------------------------*/
    static std::string const GetServerVinInfo(eGetVinInfoType eGviValue);


    /*-----------------------------------------------------------------------------
     *    ��    �ܣ���ȡ��ǰ������Ϣ������������VIN�Ľ����������ID
     *              ������Ϣ��APK���ݵ�ǰ����VIN�ӷ��������󵽵�VIN���������Ϣ
     *
     *     ����˵����eGviValue    ��ȡ��Ϣ���͵ĺ�ֵ
     *
     *               GET_VIN_BRAND               = 0,     Ʒ��
     *               GET_VIN_MODEL               = 1,     ����
     *               GET_VIN_MANUFACTURER_NAME   = 2,     ��������
     *               GET_VIN_YEAR                = 3,     ���
     *               GET_VIN_CLASSIS             = 4,     ���̺�
     *               GET_VIN_MANUFACTURER_TYPE   = 5,     ��������
     *               GET_VIN_VEHICLE_TYPE        = 6,     ��������
     *               GET_VIN_FULE_TYPE           = 7,     ȼ������
     *               GET_VIN_ENERGY_TYPE         = 8,     ��Դ����
     *               GET_VIN_COUNTRY             = 9,     ����
     *               GET_VIN_AREA                = 10,    ����
     *
     *
     *    �� �� ֵ�����������ص�VIN����Ϣ
     * 
     *    ע    �⣺�˽ӿڷ��صĶ���ֵ������ID
     -----------------------------------------------------------------------------*/
    static std::vector<std::string> const GetServerVinInfoValue(eGetVinInfoType eGviValue);


    /*----------------------------------------------------------------------------------------
     *    ��    �ܣ���ȡApp�����ص����ļ�·��(����·��)
     *
     *     ����˵����eDlScenariosType eType      ����������
     *               eTypeΪDS_HIDDEN_PATH_IDʱ����ˢ����·��ʶ�������·��
     *                                           ����ˢ�������ݰ�ʧ�ܣ����ؿ�·��
     * 
     *               ���磬DS_HIDDEN_FUN_ZIP_DIR ָ������ID��ˢ�������С������
     *
     *               SwCode  ��Ӧ��������룬���Ϊ�ջ�մ�����App����Ӧ���������
     * 
     *               FunId   ��eTypeΪDS_HIDDEN_FUN_ZIPʱ��FunIdΪ��Ӧ�Ĺ���ID
     *
     *
     *    �� �� ֵ�������������Ѿ����ص����ļ�Ŀ¼·��������·����Ŀ¼
     * 
     *              ���磺��eTypeΪDS_HIDDEN_FUN_ZIP_DIRʱ����׿Apk���ص����ļ�·����App�ѽ�ѹ��Ŀ¼
     *              "/storage/emulated/0/Android/data/com.topdon.diag.carpal/files/TopDon/
     *               CarPal/Download/hidden"
     *
     *    ע    �⣺
     ----------------------------------------------------------------------------------------*/
    static std::string const GetDownloadFilePath(eDlScenariosType eType, const std::string& SwCode, const std::string& FunId);


    /*-----------------------------------------------------------------------------
     *   ��   �ܣ� Զ�̵����㷨����ӿ�
     *             �㷨�������������CAlgorithmData��
     *
     *   ����˵����pAlgoData    �㷨���ݶ���ָ��
     *             TimeOutMs    �ӿ��������ص����ʱʱ�䣬��λms
     *                          Ĭ��Ϊ90�룬�����1�ְ�����(90��)�������޷��ؽӿ�
     *                          ������-6��ʧ��
     *
     *   �� �� ֵ��Զ�̵��õķ�����
     *             ���Զ���㷨����ӿڵ��óɹ�������0
     *
     *             ���pAlgoData����GetPackedDataΪ�գ�����-1
     *             ���pAlgoData->GetPackedDataLength()Ϊ0������-2
     *             �����ʱ����û�����ӣ�����-3
     *             �����ʱ�û�û�е�¼������������-4
     *             �����ʱTokenʧЧ������-5
     *
     *             �˽ӿ�Ϊ�����ӿڣ�ֱ���������������ݣ������TimeOutMsʱ���ڣ��ӿ���
     *             ��Ĭ��Ϊ1�ְ�����(90��)��APK��û�����ݷ��ؽ�����-6��ʧ�ܣ�
     * 
     *             ���SetKeyData����ʧ�ܣ�����-7
     *             ���RpcSend���ͳ�ʱ����ʧ�ܣ�����-8
     *             �������󣬵�ǰͳһ����-9
     *
     -----------------------------------------------------------------------------*/
    static uint32_t RpcSendRecv(CAlgorithmData *pAlgoData, uint32_t TimeOutMs = 90 * 1000);


    /*------------------------------------------------------------------------------------
     *   ��   �ܣ� FCA��������֤����Authentication��ʼ����
     *
     *   ����˵����Req          ����FCA�������ı������ݽṹ�壬����SGW��ʶ����
     *             Ans          FCA���������صĳ�ʼ����Ϣ����AuthDiag֤��
     * 
     *             struct stFcaAdInitReqEx
     *             {
     *                 std::string strSgwUUID;   // SGW(Secure Gateway) ��UUID��Base64��
     *                 std::string strSgwSN;     // SGW �����к�
     *                 std::string strVin;       // �������ܺ�
     * 
     *                 std::string strEcuSN;     // ��Ҫ������ECU���кţ�ECU�����SGW���strSgwSNһ��
     *                                           // ������Ϊ�գ�ŷ�ޱ������ "TF1170919C15240"
     * 
     *                 std::string strEcuCanId;  // ��Ҫ������ECU��CANID��������Ϊ�գ�ŷ�ޱ���
     *                                           // ���� "18DA10F1"��ECM��"18DA1020"��BSM
     * 
     *                 std::string strEcuPolicyType; // ��Ҫ������ECU�Ĳ������ͣ�
     *                                               // ������Ϊ�գ�ŷ�ޱ������"1"
     * 
     *             };
     * 
     *             struct stFcaAdInitAns
     *             {
     *                 std::string strCode;      // ��˾���������صĴ������ "code"
     *                 std::string strMsg;       // ��˾���������ص����� "msg"
     *
     *                 std::string strOemInit;   // FCA���أ�OEM�ض��ĳ�ʼ��������
     *                                           // ����FCA������AuthDiag֤�飨Base64��
     *
     *                 std::string strSessionID; // FCA���أ�Base64��
     *             };
     *
     *   �� �� ֵ��FCA��������֤����ķ�����
     *             ���FCA��������֤������óɹ�������0
     *
     *             �����ʱ����û�����ӣ�����-3
     *             �����ʱ�û�û�е�¼������������-4
     *             �����ʱTokenʧЧ������-5
     *             �������󣬵�ǰͳһ����-9
     *
     *             �˽ӿ�Ϊ�����ӿڣ�ֱ���������������ݣ������TimeOutMsʱ���ڣ��ӿ���
     *             ��Ĭ��Ϊ1�ְ�����(90��)��APK��û�����ݷ��ؽ�����-6��ʧ�ܣ�
     ------------------------------------------------------------------------------------*/
    static uint32_t FcaAuthDiagInit(const stFcaAdInitReq& Req, stFcaAdInitAns &Ans, uint32_t TimeOutMs = 90 * 1000);
    static uint32_t FcaAuthDiagInit(const stFcaAdInitReqEx& Req, stFcaAdInitAns& Ans, uint32_t TimeOutMs = 90 * 1000);


    /*------------------------------------------------------------------------------------
     *   ��   �ܣ� ��FCA������ת��SGW�� Challenge �����
     *
     *   ����˵����Req          Challenge �����ı������ݽṹ��
     *             Ans          FCA���������ص�Challenge��Ӧ
     *
     *             struct stFcaAdChallReq
     *             {
     *                 std::string strSessionID; // FcaAuthDiagInit���ص�SessionID��Base64��
     *                 std::string strChallenge; // ECU Challenge��Base64��
     *             };
     *
     *             struct stFcaAdChallAns
     *             {
     *                 std::string strCode;      // ��˾���������صĴ������ "code"
     *                 std::string strMsg;       // ��˾���������ص����� "msg"
     *
     *                 std::string strChallenge; // SGW Challenge Response��Base64��
     *             };
     *
     *   �� �� ֵ��FCA��������֤����ķ�����
     *             ���FCA��������֤������óɹ�������0
     *
     *             �����ʱ����û�����ӣ�����-3
     *             �����ʱ�û�û�е�¼������������-4
     *             �����ʱTokenʧЧ������-5
     *             �������󣬵�ǰͳһ����-9
     *
     *             �˽ӿ�Ϊ�����ӿڣ�ֱ���������������ݣ������TimeOutMsʱ���ڣ��ӿ���
     *             ��Ĭ��Ϊ1�ְ�����(90��)��APK��û�����ݷ��ؽ�����-6��ʧ�ܣ�
     ------------------------------------------------------------------------------------*/
    static uint32_t FcaAuthDiagRequest(const stFcaAdChallReq& Req, stFcaAdChallAns& Ans, uint32_t TimeOutMs = 90 * 1000);


    /*------------------------------------------------------------------------------------
     *   ��   �ܣ� ��FCA������ת�� SGW������ TrackResponse ���׷�٣������Ϊŷ��FCA��SGW������㣩
     *
     *   ����˵����Req          TrackResponse ���׷�ٵı������ݽṹ��
     *             Ans          FCA���������ص�TrackResponse��Ӧ
     *
     *             struct stFcaAdTrackReq
     *             {
     *                 std::string strSessionID;   // FcaAuthDiagInit���ص�SessionID��Base64��
     *                 std::string strEcuResult;   // ECU �����Ľ����Boolean��������"True"
     *                 std::string strEcuResponse; // ECU Response��Base64��������6712...������7F27...
     *             };
     *
     *             struct stFcaAdTrackAns
     *             {
     *                 std::string strCode;    // ��˾���������صĴ������ "code"������"200"
     *                 std::string strMsg;     // ��˾���������ص����� "msg"������"User authentication failed!"
     *
     *                 std::string strSuccess; // In case of success, true��Base64��������"true"
     *             };
     *
     *   �� �� ֵ��FCA���������׷������ķ�����
     *             ���FCA���������׷��������óɹ�������0
     *
     *             �����ʱ����û�����ӣ�����-3
     *             �����ʱ�û�û�е�¼������������-4
     *             �����ʱTokenʧЧ������-5
     *             �������󣬵�ǰͳһ����-9
     *
     *             �˽ӿ�Ϊ�����ӿڣ�ֱ���������������ݣ������TimeOutMsʱ���ڣ��ӿ���
     *             ��Ĭ��Ϊ1�ְ�����(90��)��APK��û�����ݷ��ؽ�����-6��ʧ�ܣ�
     ------------------------------------------------------------------------------------*/
    static uint32_t FcaAuthDiagTrackResp(const stFcaAdTrackReq& Req, stFcaAdTrackAns& Ans, uint32_t TimeOutMs = 90 * 1000);
    

    /*------------------------------------------------------------------------------------
     *   ��   �ܣ� ��ȡ��ǰ��FCA��¼�������û�ѡ�������
     *
     *   ����˵������
     *
     *   �� �� ֵ��eLoginRegionType
     *
     *             LGT_SELECT_AMERICA     ��ʾApp��FCA��¼�У���ǰѡ�������������
     *             LGT_SELECT_EUROPE      ��ʾApp��FCA��¼�У���ǰѡ���������ŷ��
     *             LGT_SELECT_OTHER       ��ʾApp��FCA��¼�У���ǰѡ�������������
     * 
     *             DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
     ------------------------------------------------------------------------------------*/
    static eLoginRegionType FcaGetLoginRegion();
};
#endif
