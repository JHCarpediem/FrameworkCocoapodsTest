/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ArtiDiag900Զ����֤�ӿڶ���
* �� �� �� : sujiya 20201210
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef __STD_VEH_AUTO_AUTH_H__
#define __STD_VEH_AUTO_AUTH_H__

#include "StdInclude.h"
#include "StdShowMaco.h"


// �����Ķ�ʹ�ã� CArtiGlobal��FCA�ӿڻ�Ǩ�Ƶ�����
// 
// �漰�������ط����㷨���ã�����FCA����ŵ�ȼ��е�����
// 
// ������˾�㷨������ýӿ�
// 
// CVehAutoAuth ����UI�ӿڣ�ֻ���������������ת�����ýӿ�
// CVehAutoAuth��û��Show�ӿڵ�
// 



////////////////////////////////////////////////////////////////////////////
// �������������ʾ
// uType �ǽ�������
// 
//      SST_FUNC_FCA_AUTH      = 0    FCA��֤��¼����
//      SST_FUNC_RENAULT_AUTH  = 1,   ��ŵ��֤��¼����
//      SST_FUNC_NISSAN_AUTH   = 2,   �ղ���֤��¼����
//      SST_FUNC_VW_SFD_AUTH   = 3,   �������ؽ���(VW SFD)��¼����
// 
//      SST_FUNC_DEMO_AUTH     = 0xFFFFFFF0,    DEMO��ʾʹ�õĵ�¼����
//
// �������棬ֱ����Ҫ��ϳ������ŷ���
// ����Ǵ������ؽ�����¼���棬����"����������"�İ�ťֵ����(DF_ID_SFD_THIRD)
// ����жϴ�ֵΪ��ʶ���ֵ������֧�֣���APP����ʾҳ�棬����DF_CUR_BRAND_APP_NOT_SUPPORT(-17)
uint32_t _STD_SHOW_DLL_API_ artiShowSpecial(eSpecialShowType uType);
////////////////////////////////////////////////////////////////////////////


// ��ǰApp����֧�������õĳ���Ʒ�������㷨
#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)



class CAlgorithmData;
class _STD_SHOW_DLL_API_ CVehAutoAuth
{
public:
    // ���ڽӿ�
    enum class eBrandType :uint32_t
    {   // ��ʾ���ĸ���Ʒ��
        BT_VEHICLE_TOPDON     = 0,            // ��ʾ��ǰ�ǹ�˾�㷨����������

        BT_VEHICLE_FCA        = 1,            // ��ʾ��ǰ��Ʒ����FCA
        BT_VEHICLE_RENAULT    = 2,            // ��ʾ��ǰ��Ʒ������ŵ
        BT_VEHICLE_NISSAN     = 3,            // ��ʾ��ǰ��Ʒ�����ղ�
        BT_VEHICLE_MITSUBISHI = 4,            // ��ʾ��ǰ��Ʒ��������
        BT_VEHICLE_VW_SFD     = 5,            // ��ʾ��ǰ��Ʒ���Ǵ���

        BT_VEHICLE_DEMO       = 0xFFFFFFF0,   // ��ʾ��ǰ��Ʒ����DEMO�ģ���ʾʹ�ã�

        BT_VEHICLE_INVALID    = 0xFFFFFFFF,
    };


    // ָ���ĸ�����ӿ����ͣ������� SendRecv �ӿ�
    enum class eSendRecvType :uint32_t
    {   // ��������ӿڵ�����
        SRT_FCA_DIAG_INIT    = 1,         // ��ʾ��ǰ�������FCA��Init�ӿڣ��� FcaAuthDiagInit
                                          // FCA��������֤����Authentication��ʼ����

        SRT_FCA_DIAG_REQ     = 2,         // ��ʾ��ǰ�������FCA��Request�ӿڣ��� FcaAuthDiagRequest
                                          // ��FCA������ת��SGW�� Challenge �����

        SRT_FCA_DIAG_TRACK   = 3,         // ��ʾ��ǰ�������FCA��TrackResp�ӿڣ����׷�٣��� FcaAuthDiagTrackResp
                                          // ��FCA������ת�� SGW������ TrackResponse ���׷�٣������Ϊŷ��FCA��SGW������㣩

        SRT_RENAULT_DIAG_REQ = 4,         // ��ʾ��ǰ���������ŵ�������㷨����ӿ�
                                          // ����ŵ�����㷨������ת�� �����㷨��������

        SRT_NISSAN_DIAG_REQ  = 5,         // ��ʾ��ǰ��������ղ��������㷨����ӿ�
                                          // ���ղ������㷨������ת�� �����㷨��������

        SRT_VW_DIAG_REQ      = 6,         // ��ʾ��ǰ������Ǵ��ڵ������㷨����ӿ�


        SRT_VW_SFD_REPORT    = 0x80,      // ��ʾ��ǰ������ǹ�˾��Ʒ�������ĵ����ؽ��������ϱ��ӿ�
                                          // /api/v1/baseinfo/gatewayUnlockRecord/save

        SRT_DEMO_DIAG_REQ   = 0xFFFFFFF0, // ��ʾ��ǰ�������DEMO�������㷨����ӿ�

        SRT_INVALID_TYPE = 0xFFFFFFFF,
    };


public:
    CVehAutoAuth();
    ~CVehAutoAuth();

public:
    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����ö�Ӧ��Ʒ��

      ����˵����uBrand ����Ʒ��

                BT_VEHICLE_FCA     = 1  ��ʾ��ǰ��Ʒ����FCA
                BT_VEHICLE_RENAULT = 2  ��ʾ��ǰ��Ʒ������ŵ���ղ����ǣ�

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�������㷨
    
                ���óɹ�����1
                ��������ֵ����������

      ˵    ������
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetBrandType(const eBrandType& brandType);


    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����ó�����Ӧ��Ʒ�ƣ��������ؽ��������ϱ�

      ����˵����strBrand ����Ʒ��, Make
                         ���磬"AUDI"

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�������㷨

                ���óɹ�����1
                ��������ֵ����������

      ˵    ������
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetVehBrand(const std::string& strBrand);


    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����ó�����Ӧ���ͺţ��������ؽ��������ϱ�

      ����˵����strModel �����ͺ�, Model
                         ���磬"�µ�A3"

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    ������
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetVehModel(const std::string& strModel);


    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����������㷨�ӿڵĳ������ܺ�

      ����˵����strVin �������ܺ�

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    ����
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetVin(const std::string& strVin);


    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����������㷨�����ӿڵ�ECU���ƣ��������ؽ��������ϱ�

      ����˵����strSysName ϵͳ����
                           ���磬"19 - ����������Ͻӿ�"

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    �����������ؽ����������ؽ��������ϱ�
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetSystemName(const std::string& strSysName);



    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����������㷨�ӿڵ�ECU�������ͣ�ecuUnlockType

      ����˵����strType     ECU��������
                
                ����1��"UnlockUdsECU" 
                    -> Unlock the ECU using UDS protocole and Asymetric or Symetric Unlocking Algorithm

                ����2��"UnlockSpecBcEcu" -> Unlock the ECU using SpecB protocole

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    ������������ŵ���ղ������㷨
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuUnlockType(const std::string & strType);



    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����������㷨�ӿڵ�ECU�����������ݣ��� ECU-public-service-data��ecuPublicServiceData

      ����˵����strData     ECU�����������ݣ���ʶ��Ҫ������ӦECU��id
                            ֻ�е�ECU��������=UnlockUdsECUʱ���˲������Ǳ����
                            ������SetEcuUnlockType�ӿ�������UnlockUdsECUʱ���˲������Ǳ����

                ��������424F53434845434D�������� BOSCHECM ��ʮ������ֵ

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    ������������ŵ���ղ������㷨
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuPublicServiceData(const std::string& strData);



    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����������㷨�ӿڵ�ECU���ӣ�securitySeed�����ݣ�ecuChallenge����ecuSecuritySeed 

                FCA���� ECU Challenge��Base64��
                Renault �� ECU-security-seed

      ����˵����strSeed     ECU���ص���������

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    ����������FCA����ŵ���ղ��������㷨
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuChallenge(const std::string& strSeed);


    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ����������㷨�ӿڵ�ECU��securityKey�����ݣ�Ҳ����ecuChallenge��SFD�г�ΪTocken��

                �������ؽ�������ϱ�����˾������������׷�٣�����ǰΪ����SFD���������ϱ�

      ����˵����strChallenge     ����ECU��KEY���ݣ���securityKey����ӦSFD�����Tocken
                                 ��IOT�ӿ�unlockReport��token����

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

                ���óɹ�����1
                ��������ֵ����������

      ˵    ���������ڴ���SFD���������ϱ��ӿڵĲ������ã���������;����������ԭ���㷨��������
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuTocken(const std::string& strChallenge);
    


    /*-------------------------------------------------------------------------------------------------
    ��    �ܣ����������㷨�ӿڵ�ECU��ID��ecuCANID��ecu-address

            ŷ��FCA����ȷָ��������Ҫ������ECU��CANID������ "18DA10F1"��ECM��"18DA1020"��BSM
            ����FCA����Ϊ��
            Renault  �� ECU Address used to identify the given ECU

    ����˵����strCanID     ECU��CANID

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
              DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

              DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���
   
              ���óɹ�����1
              ��������ֵ����������

    ˵    ����������FCA����ŵ���ղ��������㷨
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuCanId(const std::string& strCanID);


    /*-------------------------------------------------------------------------------------------------
    ��    �ܣ����������㷨�ӿڵ�x-routing-policy, routingPolicy, ��������ŵ

    ����˵����strPolicy     ·�ɲ���ֵ

                            This parameter set by the consumer is mandatory to access security access 
                            service developed in release R5

              ������"SecurityAccessV2_9"

    ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
              DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

              DF_CUR_BRAND_APP_NOT_SUPPORT����ǰApp����֧�������õĳ���Ʒ�����ؽ���

              ���óɹ�����1
              ��������ֵ����������

    ˵    ������������ŵ�������㷨
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetXRoutingPolicy(const std::string& strPolicy);


    /*-------------------------------------------------------------------------------------------------
    ��    �ܣ���ȡ��˾���������صĴ������ "code"������"200"

    �� �� ֵ����˾���������صĴ������ "code"������"200"

    ˵    ���������ڷ������㷨͸�����˽ӿ�����SendRecv���ú�ȥ����
    -------------------------------------------------------------------------------------------------*/
    const std::string GetRespondCode();


    /*-------------------------------------------------------------------------------------------------
    ��    �ܣ���ȡ��˾���������ص����� "msg"������"User authentication failed!"

    �� �� ֵ����˾���������ص����� "msg"������"User authentication failed!"

    ˵    ���������ڷ������㷨͸�����˽ӿ�����SendRecv���ú�ȥ����
    -------------------------------------------------------------------------------------------------*/
    const std::string GetRespondMsg();


    /*-------------------------------------------------------------------------------------------------
    ��    �ܣ���ȡOE���������ص�Challenge

              FCA, SGW Challenge Response��Base64��
              Renault, ECU-security-seed ����Ӧ


    �� �� ֵ��Challenge

    ˵    ���������ڷ������㷨͸�����˽ӿ�����SendRecv���ú�ȥ����
    -------------------------------------------------------------------------------------------------*/
    const std::string GetEcuChallenge();


    /*------------------------------------------------------------------------------------
     *   ��   �ܣ� ��ȡ��ǰ�������û���¼�������û�ѡ�������
     *
     *   ����˵������
     *
     *   �� �� ֵ��eLoginRegionType
     *
     *             LGT_SELECT_AMERICA     ��ʾApp�������û���¼�У���ǰѡ�������������
     *             LGT_SELECT_EUROPE      ��ʾApp�������û���¼�У���ǰѡ���������ŷ��
     *             LGT_SELECT_OTHER       ��ʾApp�������û���¼�У���ǰѡ�������������
     *
     *             DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
     ------------------------------------------------------------------------------------*/
    eLoginRegionType GetLoginRegion();
    

    /*-----------------------------------------------------------------------------------------------------------
     *   ��   �ܣ� ��OE������������TOPDON��˾�㷨��������ת���㷨�ӿڣ���������˾IOT�������ӿ�
     *             ����ĳ������ݲ���eSendRecvType����
     *
     *   ����˵����eSendRecvType Type   �㷨�ӿڵ����ͣ�ָ���˴ε�������ʲô����
     *
     *            Type ֵ�����£�
     *            SRT_FCA_DIAG_INIT     ��ʾ��ǰ�������FCA��Init�ӿڣ��� FcaAuthDiagInit
     *                                  FCA��������֤����Authentication��ʼ����
     * 
     *            SRT_FCA_DIAG_REQ      ��ʾ��ǰ�������FCA��Request�ӿڣ��� FcaAuthDiagRequest
     *                                  ��FCA������ת��SGW�� Challenge �����
     * 
     *            SRT_FCA_DIAG_TRACK    ��ʾ��ǰ�������FCA��TrackResp�ӿڣ����׷�٣��� FcaAuthDiagTrackResp
     *                                  ��FCA������ת�� SGW������ TrackResponse ���׷�٣������Ϊŷ��FCA��SGW������㣩
     * 
     *            SRT_RENAULT_DIAG_REQ  ��ʾ��ǰ���������ŵ�������㷨����ӿ�
     *                                  ����ŵ�����㷨������ת�� �����㷨��������
     * 
     *            SRT_VW_SFD_REPORT     ��ʾ��ǰ������ǹ�˾��Ʒ�������ĵ����ؽ��������ϱ��ӿ�
     * 
     * 
     *   �� �� ֵ����������֤����ķ�����
     *             �����������֤������óɹ�������0
     *
     *             �����ʱ����û�����ӣ�����-3
     *             �����ʱ�û�û�е�¼������������-4
     *             �����ʱTokenʧЧ������-5
     *             �������󣬵�ǰͳһ����-9
     *
     *             �˽ӿ�Ϊ�����ӿڣ�ֱ���������������ݣ������TimeOutMsʱ���ڣ��ӿ���
     *             ��Ĭ��Ϊ1�ְ�����(90��)��APK��û�����ݷ��ؽ�����-6��ʧ�ܣ�
     * 
     *             �����ǰApp����֧��ָ��Ʒ�Ƶ����ؽ������ܣ�App����ֵΪDF_CUR_BRAND_APP_NOT_SUPPORT(-17)
     -----------------------------------------------------------------------------------------------------------*/
    uint32_t SendRecv(eSendRecvType Type, uint32_t TimeOutMs = 90 * 1000);


private:
    void* m_pData = NULL;
};
#endif
