#ifndef __APP_PRODUCT_MACO_H__
#define __APP_PRODUCT_MACO_H__

#include "StdInclude.h"

// ���ڽӿ�CAppProduct::Name�ķ���ֵ
enum class eAppProductName :uint32_t
{
    //��ǰappӦ�õĲ�Ʒ����
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

// ���ڽӿ�CAppProduct::Group�ķ���ֵ
enum class eAppProductGroup :uint32_t
{
    //��ǰ app Ӧ����Ĳ�Ʒ�����
    PD_GROUP_AD900_LIKE                   = ((1 << 16) & 0xFFFF0000),   // "AD900ϵ��",  ��ʾ��ǰ��Ʒ�����Ϊ��AD900ϵ��
                                                                        // ���磬AD900��AD900 LITE��GOOLOO DS900��AD800BT2��

    PD_GROUP_TOPSCAN_LIKE                 = ((2 << 16) & 0xFFFF0000),   // "TopScanϵ��",  ��ʾ��ǰ��Ʒ�����Ϊ��TopScanϵ��
                                                                        // ���磬TopScan HD��TopScan VAG��DS200��DeepScan

    PD_GROUP_CARPAL_LIKE                  = ((3 << 16) & 0xFFFF0000),   // "CarPalϵ��",  ��ʾ��ǰ��Ʒ�����Ϊ��CarPalϵ��
                                                                        // ���磬CarPal��CarPal Guru��DS100��С��̽��

    PD_GROUP_AD500_LIKE                   = ((4 << 16) & 0xFFFF0000),   // "AD500ƽ��ϵ��",  ��ʾ��ǰ��Ʒ�����Ϊ��AD500ƽ��ϵ��
                                                                        // ���磬AD500��AD600��AD600S��AD500S��AD500 BMS����

    PD_GROUP_TOPDON_ONE_LIKE              = ((5 << 16) & 0xFFFF0000),   // "TOPDON ONEƽ��ϵ��",  ��ʾ��ǰ��Ʒ�����Ϊ��TOPDON ONEƽ��ϵ��
                                                                        // ���磬TOPDON ONE����10�磬13���

    PD_GROUP_INVALID = 0xFFFFFFFF,
};


class _STD_SHOW_DLL_API_ CAppProduct
{
public:

public:
    CAppProduct() {}
    ~CAppProduct() {}

public:
    /*-----------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰappӦ�õĲ�Ʒ����

               �������ܸ�CArtiGlobal::GetAppProductNameһģһ��
               ��CArtiGlobal::GetAppProductName�Ѳ�����ʹ�ã�����CAppProduct::Name

    ����˵���� ��

    �� �� ֵ�� PD_NAME_AD900              ��ʾ��ǰ��Ʒ��ΪAD900
               PD_NAME_AD200              ��ʾ��ǰ��Ʒ��ΪAD200
               PD_NAME_TOPKEY             ��ʾ��ǰ��Ʒ��ΪTOPKEY
               PD_NAME_NINJA1000PRO       ��ʾ��ǰ��Ʒ��ΪNinja1000 Pro
    -----------------------------------------------------------------------------*/
    static eAppProductName const Name();


    /*------------------------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰappӦ�õĲ�Ʒ�����ƣ���Ʒϵ�У�

    ����˵���� ��

    �� �� ֵ��     PD_GROUP_AD900_LIKE     ���磬AD900��AD900 LITE��GOOLOO DS900��
                   PD_GROUP_TOPSCAN_LIKE   ���磬TopScan HD��TopScan VAG��DS200��DeepScan��
                   PD_GROUP_CARPAL_LIKE    ���磬CarPal��CarPal Guru��DS100��С��̽��
                   PD_GROUP_AD500_LIKE     ���磬AD500��AD600��AD600S��AD500S��AD500 BMS����
    ------------------------------------------------------------------------------------------*/
    static eAppProductGroup const Group();


    /*-------------------------------------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰ App Ӧ�õĹ��� �� �ӿ� �Ƿ�֧��
               ��Բ�ͬ��������ͽӿ����ơ�Functionֵ
               ����true��ʾ֧�֣�false��ʾ��֧��
               
               ͬһ��App�����ͬһ���ӿڣ���ӦApp�Ĳ�ͬ�汾�����ܻ��в�ͬ��֧�����

    ����˵���� strClass          ��ʾ�ĸ����     ���磬"CVehAutoAuth"
               strApi            ��ʾ�ĸ�API�ӿ�  ���磬"SendRecv"

               uFunction         ��ʾ������ͽӿ��£�����Ĺ����Ƿ�֧��
                                 Ĭ��0xFFFFFFFF(-1)����ʾ�����ֹ��ܣ�ֻ����ýӿ��Ƿ�֧��

                                 ������strClassClass = "CVehAutoAuth"
                                       strApi = "SendRecv"
                                       uFunction = SRT_NISSAN_DIAG_REQ(5)
                                       ���� true ���ʾ��ǰApp��֧���ղ������㷨����ӿ�
                                       ���� false ���ʾ��ǰApp����֧���ղ������㷨����ӿ�

    �� �� ֵ�� true     ��Ӧ������֧��
               false    ��Ӧ����δ֧��
    -------------------------------------------------------------------------------------------------------*/
    static bool const IsSupported(const std::string& strClass, const std::string& strApi, uint32_t uFunction = -1);


    /*-------------------------------------------------------------------------------------------------------
    ��    �ܣ� ��ȡ��ǰ�������������

    ����˵���� uVehType          ��������ǰ��������

    �� �� ֵ�� ���磬"AD900_CarSW_MAZDA"
               ���Appû�д˽ӿڣ����ؿմ�
    -------------------------------------------------------------------------------------------------------*/
    static const std::string CurVehSoftCode(uint32_t uVehType);
};

#endif // __APP_PRODUCT_MACO_H__
