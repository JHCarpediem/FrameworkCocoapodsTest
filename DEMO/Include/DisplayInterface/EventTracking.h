#ifndef __STD_EVENT_TRACKING_MACO_H__
#define __STD_EVENT_TRACKING_MACO_H__

#include <string>


///////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------------------------
˵    ����ArtiGlobal ������������¼�ID��������ȫ����Ľӿ�SetEventTracking�β� vctPara

          uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);
-------------------------------------------------------------------------------------------------*/
// ���������Ϣ�¼�IDֵ����
enum eEventTrackingId
{
    ETI_CLICK_DIAGNOSTIC_AUTOMATIC              = 0,     // 0      �������-Automatic                     ����ʹ����
    ETI_CLICK_DIAGNOSTIC_MANUAL                 = 1,     // 1      �������-Manual                        ����ʹ����
    ETI_DIAG_VIN_READ_FAIL                      = 2,     // 2      VIN���ȡʧ��                          
    ETI_DIAG_VIN_READ_SUCC                      = 3,     // 3      VIN���ȡ�ɹ�                          
    ETI_DIAG_VIN_DECODER_SUCC                   = 4,     // 4      ������Ϣ�����ɹ�                       VIN����������Ϣ�ɹ�
    ETI_DIAG_VIN_DECODER_FAIL                   = 5,     // 5      ������Ϣ����ʧ��                       VIN����������Ϣʧ��
    ETI_CLICKVEHICLE_PROFILE_CONFIRM            = 6,     // 6      ѡ�����                               ���VehicleProfile�����Confirm��ť
    ETI_ENTER_SYSTEM_TIME                       = 7,     // 7      ��ϵͳ�ɹ���ʱ                         ���˻�ɱ��APP���ݲ�ͳ��
    ETI_ENTER_SYSTEM_FAIL                       = 8,     // 8      ��ϵͳʧ��                             ��ϵͳʧ�ܣ��񶨻�δ�ظ���
    ETI_READ_DTC_SUCC                           = 9,     // 9      ��ȡ������ɹ�                         
    ETI_READ_DTC_FAIL                           = 10,    // 10     ��ȡ������ʧ��                         �������ȡʧ�ܣ��񶨻�δ�ظ���
    ETI_CLEAR_DTC_FAIL                          = 11,    // 11     ���������ʧ��                         ���������ʧ�ܣ��񶨻�δ�ظ���
    ETI_DS_VALUE_ABNORMAL                       = 12,    // 12     ������ֵ�쳣                           ��ǰ����������ֵ�쳣������ա�N/A�����ȣ�
    ETI_DS_READ_FAIL                            = 13,    // 13     ��ȡ������ʧ��                         ��������ȡʧ�ܣ�ȫ���񶨻�δ�ظ���
    ETI_AT_NAME                                 = 14,    // 14     ��������������                         
    ETI_AT_EXECUTE_FAIL                         = 15,    // 15     ��������ִ��ʧ��                       ����������ִ��ʧ�ܣ��񶨻�δ�ظ���
    ETI_SP_NAME                                 = 16,    // 16     ���⹦��������                         
    ETI_SP_EXECUTE_FAIL                         = 17,    // 17     ���⹦��ִ��ʧ��                       ���⹦����ִ��ʧ��
    ETI_CLICK_HF_OIL_RESET                      = 18,    // 18     HF_Oilreset                            �������㹦��ʹ����
    ETI_HF_OIL_RESET_FAIL                       = 19,    // 19     HF_Oilresetִ��ʧ��                    �������㹦��ִ��ʧ��
    ETI_CLICK_HF_THROTTLE_ADAPTATION            = 20,    // 20     HF_Throttleadaptation                  ������ƥ�书��ʹ����
    ETI_HF_THROTTLE_ADAPTATION_FAIL             = 21,    // 21     HF_Throttleadaptationִ��ʧ��          ������ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_EPB_RESET                      = 22,    // 22     HF_EPBreset                            ɲ��Ƭ��������ʹ����
    ETI_HF_EPB_RESET_FAIL                       = 23,    // 23     HF_EPBresetִ��ʧ��                    ɲ��Ƭ��������ִ��ʧ��
    ETI_CLICK_HF_BMS_RESET                      = 24,    // 24     HF_BMSreset                            ���ƥ�书��ʹ����
    ETI_HF_BMS_RESET_FAIL                       = 25,    // 25     HF_BMSresetִ��ʧ��                    ���ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_SAS_RESET                      = 26,    // 26     HF_SASreset                            ת��Ǹ�λ����ʹ����
    ETI_HF_SAS_RESET_FAIL                       = 27,    // 27     HF_SASresetִ��ʧ��                    ת��Ǹ�λ����ִ��ʧ��
    ETI_CLICK_HF_DPF_REGENERATION               = 28,    // 28     HF_DPFregeneration                     DPF��������ʹ����
    ETI_HF_DPF_REGENERATION_FAIL                = 29,    // 29     HF_DPFregenerationִ��ʧ��             DPF��������ִ��ʧ��
    ETI_CLICK_HF_ABS_BLEEDING                   = 30,    // 30     HF_ABSbleeding                         ABS��������ʹ����
    ETI_HF_ABS_BLEEDING_FAIL                    = 31,    // 31     HF_ABSbleedingִ��ʧ��                 ABS��������ִ��ʧ��
    ETI_CLICK_HF_AIRBAG_RESET                   = 32,    // 32     HF_Airbagreset                         ���Ҹ�λ����ʹ����
    ETI_HF_AIRBAG_RESET_FAIL                    = 33,    // 33     HF_Airbagresetִ��ʧ��                 ���Ҹ�λ����ִ��ʧ��
    ETI_CLICK_HF_TPMS_RESET                     = 34,    // 34     HF_TPMSreset                           ̥ѹ��λ����ʹ����
    ETI_HF_TPMS_RESET_FAIL                      = 35,    // 35     HF_TPMSresetִ��ʧ��                   ̥ѹ��λ����ִ��ʧ��
    ETI_CLICK_HF_INJECTOR_CODING                = 36,    // 36     HF_Injectorcoding                      ��������빦��ʹ����
    ETI_HF_INJECTOR_CODING_FAIL                 = 37,    // 37     HF_Injectorcodingִ��ʧ��              ��������빦��ִ��ʧ��
    ETI_CLICK_HF_IMMO_KEYS                      = 38,    // 38     HF_IMMOkeys                            ����/Կ�׹���ʹ����
    ETI_HF_IMMO_KEYS_FAIL                       = 39,    // 39     HF_IMMOkeysִ��ʧ��                    ����/Կ�׹���ִ��ʧ��
    ETI_CLICK_HF_SUSPENSION_MATCHING            = 40,    // 40     HF_Suspensionmatching                  ����ƥ�书��ʹ����
    ETI_HF_SUSPENSION_MATCHING_FAIL             = 41,    // 41     HF_Suspensionmatchingִ��ʧ��          ����ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_SEAT_CALIBRATION               = 42,    // 42     HF_Seatcalibration                     ���α궨����ʹ����
    ETI_HF_SEAT_CALIBRATION_FAIL                = 43,    // 43     HF_Seatcalibrationִ��ʧ��             ���α궨����ִ��ʧ��
    ETI_CLICK_HF_WINDOWS_CALIBRATION            = 44,    // 44     HF_Windowscalibration                  �Ŵ��궨����ʹ����
    ETI_HF_WINDOWS_CALIBRATION_FAIL             = 45,    // 45     HF_Windowscalibration                  �Ŵ��궨����ִ��ʧ��
    ETI_CLICK_HF_SUNROOF_INITIALIZATION         = 46,    // 46     HF_Sunroofinitialization               �촰��ʼ������ʹ����
    ETI_HF_SUNROOF_INITIALIZATION_FAIL          = 47,    // 47     HF_Sunroofinitializationִ��ʧ��       �촰��ʼ������ִ��ʧ��
    ETI_CLICK_HF_ODO_RESET                      = 48,    // 48     HF_ODOreset                            ��̱���̹���ʹ����
    ETI_HF_ODO_RESETFAIL                        = 49,    // 49     HF_ODOresetִ��ʧ��                    ��̱���̹���ִ��ʧ��
    ETI_CLICK_HF_LANGUAGE_CHANGE                = 50,    // 50     HF_Languagechange                      �������ù���ʹ����
    ETI_HF_LANGUAGE_CHANGE_FAIL                 = 51,    // 51     HF_Languagechangeִ��ʧ��              �������ù���ִ��ʧ��
    ETI_CLICK_HF_AFS_RESET                      = 52,    // 52     HF_AFSreset                            ���ƥ�书��ʹ����
    ETI_HF_AFS_RESET_FAIL                       = 53,    // 53     HF_AFSresetִ��ʧ��                    ���ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_TIRE_RESET                     = 54,    // 54     HF_Tirereset                           ��̥��װ����ʹ����
    ETI_HF_TIRERESET_FAIL                       = 55,    // 55     HF_Tireresetִ��ʧ��                   ��̥��װ����ִ��ʧ��
    ETI_CLICK_HF_GEARBOX_MATCHING               = 56,    // 56     HF_Gearboxmatching                     ������ƥ�书��ʹ����
    ETI_HF_GEARBOX_MATCHING_FAIL                = 57,    // 57     HF_Gearboxmatchingִ��ʧ��             ������ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_CLUTCH_MATCHING                = 58,    // 58     HF_Clutchmatching                      �����ƥ�书��ʹ����
    ETI_HF_CLUTCH_MATCHING_FAIL                 = 59,    // 59     HF_Clutchmatchingִ��ʧ��              �����ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_GEAR_LEARNING                  = 60,    // 60     HF_Gearlearning                        ����ѧϰ����ʹ����
    ETI_HF_GEAR_LEARNING_FAIL                   = 61,    // 61     HF_Gearlearningִ��ʧ��                ����ѧϰ����ִ��ʧ��
    ETI_CLICK_HF_CYLINDER_BALANCE_TEST          = 62,    // 62     HF_Cylinderbalancetest                 ����ƽ����Թ���ʹ����
    ETI_HF_CYLINDER_BALANCE_TEST_FAIL           = 63,    // 63     HF_Cylinderbalancetestִ��ʧ��         ����ƽ����Թ���ִ��ʧ��
    ETI_CLICK_HF_EGR_RESET                      = 64,    // 64     HF_EGRreset                            EGR��ѧϰ����ʹ����
    ETI_HF_EGR_RESET_FAIL                       = 65,    // 65     HF_EGRresetִ��ʧ��                    EGR��ѧϰ����ִ��ʧ��
    ETI_CLICK_HF_VGT_LEARNING                   = 66,    // 66     HF_VGTlearning                         ������ѹƥ�书��ʹ����
    ETI_HF_VGT_LEARNING_FAIL                    = 67,    // 67     HF_VGTlearningִ��ʧ��                 ������ѹƥ�书��ִ��ʧ��
    ETI_CLICK_HF_VIN                            = 68,    // 68     HF_VIN                                 VIN����ʹ����
    ETI_HF_VIN_FAIL                             = 69,    // 69     HF_VINִ��ʧ��                         VIN����ִ��ʧ��
    ETI_CLICK_HF_TRANSPORT_MODE                 = 70,    // 70     HF_Transportmode                       ����ģʽ�������ʹ����
    ETI_HF_TRANSPORT_MODE_FAIL                  = 71,    // 71     HF_Transportmodeִ��ʧ��               ����ģʽ�������ִ��ʧ��
    ETI_CLICK_HF_START_STOP_RESET               = 72,    // 72     HF_StartStopreset                      ��ͣ���ù���ʹ����
    ETI_HF_START_STOP_RESET_FAIL                = 73,    // 73     HF_StartStopresetִ��ʧ��              ��ͣ���ù���ִ��ʧ��
    ETI_CLICK_HF_AC_LEARNING                    = 74,    // 74     HF_AClearning                          �յ�ѧϰ����ʹ����
    ETI_HF_AC_LEARNINGFAIL                      = 75,    // 75     HF_AClearningִ��ʧ��                  �յ�ѧϰ����ִ��ʧ��
    ETI_CLICK_HF_AF_RESET                       = 76,    // 76     HF_AFreset                             A/F ��У����ʹ����
    ETI_HF_AF_RESET_FAIL                        = 77,    // 77     HF_AFresetִ��ʧ��                     A/F ��У����ִ��ʧ��
    ETI_CLICK_HF_RAIN_LIGHT_SENSOR              = 78,    // 78     HF_RainLightsensor                     �������ߴ���������ʹ����
    ETI_HF_RAIN_LIGHT_SENSOR_FAIL               = 79,    // 79     HF_RainLightsensorִ��ʧ��             �������ߴ���������ִ��ʧ��
    ETI_CLICK_HF_ACC_CALIBRATION                = 80,    // 80     HF_ACCcalibration                      Ѳ��У׼����ʹ����
    ETI_HF_ACC_CALIBRATIONFAIL                  = 81,    // 81     HF_ACCcalibrationִ��ʧ��              Ѳ��У׼����ִ��ʧ��
    ETI_CLICK_HF_COOLANT_BLEEDING               = 82,    // 82     HF_Coolantbleeding                     ����ˮ�ü����ʹ����
    ETI_HF_COOLANT_BLEEDING_FAIL                = 83,    // 83     HF_Coolantbleedingִ��ʧ��             ����ˮ�ü����ִ��ʧ��
    ETI_CLICK_HF_NOX_SENSOR_RESET               = 84,    // 84     HF_NOxsensorreset                      NOx��λ����ʹ����
    ETI_HF_NOX_SENSOR_RESET_FAIL                = 85,    // 85     HF_NOxsensorresetִ��ʧ��              NOx��λ����ִ��ʧ��
    ETI_CLICK_HF_AD_BLUE_RESET                  = 86,    // 86     HF_AdBluereset                         ���ظ�λ����ʹ����
    ETI_HF_AD_BLUE_RESET_FAIL                   = 87,    // 87     HF_AdBlueresetִ��ʧ��                 ���ظ�λ����ִ��ʧ��
    ETI_CLICK_HF_HV_BATTERY                     = 88,    // 88     HF_HVbattery                           ��ѹ��ع���ʹ����
    ETI_HF_HV_BATTERYF_AIL                      = 89,    // 89     HF_HVbatteryִ��ʧ��                   ��ѹ��ع���ִ��ʧ��
    ETI_CLICK_HF_ADAS_CALIBRATION               = 90,    // 90     HF_ADAScalibration                     ADASУ׼����ʹ����
    ETI_HF_ADAS_CALIBRATION_FAIL                = 91,    // 91     HF_ADAScalibrationִ��ʧ��             ADASУ׼����ִ��ʧ��
    ETI_CLICK_HF_SMART_KEY_MATCHING             = 92,    // 92     HF_Smartkeymatching                    ����Կ��ƥ�书��ʹ����
    ETI_HF_SMART_KEY_MATCHING_FAIL              = 93,    // 93     HF_Smartkeymatchingִ��ʧ��            ����Կ��ƥ�书��ִ��ʧ��
    ETI_CLICK_HF_PIN_CODE_READING               = 94,    // 94     HF_PINCodereading                      �����ȡ����ʹ����
    ETI_HF_PIN_CODE_READING_FAIL                = 95,    // 95     HF_PINCodereadingִ��ʧ��              �����ȡ����ִ��ʧ��
    ETI_CLICK_HF_EEPROM                         = 96,    // 96     HF_EEPROM                              EEPROM����������ʹ����
    ETI_HF_EEPROM_FAIL                          = 97,    // 97     HF_EEPROMִ��ʧ��                      EEPROM����������ִ��ʧ��

    ETI_CLICK_HF_48V_MHEV_TEST_EV               = 98,     //98     HF_48VMHEVtestEV                       48V��첿������ʹ����
    ETI_HF_48VMHEV_TEST_EV_FAIL                 = 99,     //99     HF_48VMHEVtestEVִ��ʧ��               48V��첿������ִ��ʧ��
    ETI_CLICK_HF_DYNAMIC_ADAS_CALIBRATION       = 100,    //100    HF_DynamicADAScalibration              ��̬ADASУ׼����ʹ����
    ETI_HF_DYNAMIC_ADAS_CALIBRATION_FAIL        = 101,    //101    HF_DynamicADAScalibrationִ��ʧ��      ��̬ADASУ׼����ִ��ʧ��
    ETI_CLICK_HF_AFTER_TREATMENT                = 102,    //102    HF_Aftertreatment                      β������GPF����ʹ����
    ETI_HF_AFTER_TREATMENT_FAIL                 = 103,    //103    HF_Aftertreatmentִ��ʧ��              β������GPF����ִ��ʧ��
    ETI_CLICK_HF_CAMSHAFT_LEARNING              = 104,    //104    HF_Camshaftlearning                    ͹����ѧϰ����ʹ����
    ETI_HF_CAMSHAFT_LEARNING_FAIL               = 105,    //105    HF_Camshaftlearningִ��ʧ��            ͹����ѧϰ����ִ��ʧ��
    ETI_CLICK_HF_COMPRESSOR_TEST_EV             = 106,    //106    HF_CompressortestEV                    ѹ�������Թ���ʹ����
    ETI_HF_COMPRESSOR_TEST_EV_FAIL              = 107,    //107    HF_CompressortestEVִ��ʧ��            ѹ�������Թ���ִ��ʧ��
    ETI_CLICK_HF_DCDC_TEST_EV                   = 108,    //108    HF_DCDCtestEV                          ֱ��ת����(DCDC)����ʹ����
    ETI_HF_DCDC_TEST_EV_FAIL                    = 109,    //109    HF_DCDCtestEVִ��ʧ��                  ֱ��ת����(DCDC)����ִ��ʧ��
    ETI_CLICK_HF_ECU_RESET                      = 110,    //110    HF_ECUreset                            ���Ƶ�Ԫ��λ����ʹ����
    ETI_HF_ECU_RESET_FAIL                       = 111,    //111    HF_ECUresetִ��ʧ��                    ���Ƶ�Ԫ��λ����ִ��ʧ��
    ETI_CLICK_HF_FRM_RESET                      = 112,    //112    HF_FRMreset                            FRM��λ����ʹ����
    ETI_HF_FRM_RESET_FAIL                       = 113,    //113    HF_FRMresetִ��ʧ��                    FRM��λ����ִ��ʧ��
    ETI_CLICK_HF_HV_POWER_OUTAGE                = 114,    //114    HF_HVpoweroutage                       ��ѹ�ϵ�/���ù���ʹ����
    ETI_HF_HV_POWER_OUTAGE_FAIL                 = 115,    //115    HF_HVpoweroutageִ��ʧ��               ��ѹ�ϵ�/���ù���ִ��ʧ��
    ETI_CLICK_HF_MOTOR_ANGLE_CALIBRATION        = 116,    //116    HF_Motoranglecalibration               �����λ�ô������궨����ʹ����
    ETI_HF_MOTOR_ANGLE_CALIBRATION_FAIL         = 117,    //117    HF_Motoranglecalibrationִ��ʧ��       �����λ�ô������궨����ִ��ʧ��
    ETI_CLICK_HF_OBC_TEST_EV                    = 118,    //118    HF_OBCtestEV                           ���س���(OBC)����ʹ����
    ETI_HF_OBC_TEST_EV_FAIL                     = 119,    //119    HF_OBCtestEVִ��ʧ��                   ���س���(OBC)����ִ��ʧ��
    ETI_CLICK_HF_PERSONALIZATION_SETTING        = 120,    //120    HF_Personalizationsettin               ���Ի����ù���ʹ����
    ETI_HF_PERSONALIZATION_SETTING_FAIL         = 121,    //121    HF_Personalizationsettinִ��ʧ��       ���Ի����ù���ִ��ʧ��
    ETI_CLICK_HF_RELATIVE_COMPRESSION           = 122,    //122    HF_Relativecompression                 ���ѹ������ʹ����
    ETI_HF_RELATIVE_COMPRESSION_FAIL            = 123,    //123    HF_Relativecompressionִ��ʧ��         ���ѹ������ִ��ʧ��
    ETI_CLICK_HF_RESOLVER_SENSOR_CALIBRATION    = 124,    //124    HF_Resolversensorcalibration           ���䴫�����궨����ʹ����
    ETI_HF_RESOLVER_SENSOR_CALIBRATION_FAIL     = 125,    //125    HF_Resolversensorcalibrationִ��ʧ��   ���䴫�����궨����ִ��ʧ��
    ETI_CLICK_HF_SPEED_PTO                      = 126,    //126    HF_SpeedPTO                            �ٶ��빦�ʹ���ʹ����
    ETI_HF_SPEED_PTO_FAIL                       = 127,    //127    HF_SpeedPTOִ��ʧ��                    �ٶ��빦�ʹ���ִ��ʧ��
    ETI_CLICK_HF_COOLANT_REPLACEMENT            = 128,    //128    HF_Coolantreplacement                  ��ȴҺ/�������������ʹ����
    ETI_HF_COOLANT_REPLACEMENT_FAIL             = 129,    //129    HF_Coolantreplacementִ��ʧ��          ��ȴҺ/�������������ִ��ʧ��
    
    ETI_CLICK_HF_IDLE_ADJUSTMENT                = 130,    //130    HF_IdleAdjustment                      ���ٵ�������ʹ����
    ETI_HF_IDLE_ADJUSTMENT_FAIL                 = 131,    //131    HF_IdleAdjustmentִ��ʧ��              ���ٵ�������ִ��ʧ��
    ETI_CLICK_HF_CO_ADJUSTMENT                  = 132,    //132    HF_COAdjustment                        һ����̼��������ʹ����
    ETI_HF_CO_ADJUSTMENT_FAIL                   = 133,    //133    HF_COAdjustmentִ��ʧ��                һ����̼��������ִ��ʧ��
    ETI_CLICK_HF_ECU_FLASHING                   = 134,    //134    HF_ECUFlashing                         ģ��ˢд����ʹ����
    ETI_HF_ECU_FLASHING_FAIL                    = 135,    //135    HF_ECUFlashingִ��ʧ��                 ģ��ˢд����ִ��ʧ��
};



///////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------------------------
˵    ����ArtiGlobal ������������¼���������ȫ����Ľӿ�SetEventTracking�β� vctPara

          uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);
-------------------------------------------------------------------------------------------------*/
// ���������Ϣ���������Ͷ���
enum eTrackingInfoType
{
    TIT_VIN = 0,               //  ��ʾ����Ϊ�������ܺ�
    TIT_MAKE = 1,              //  ��ʾ����Ϊ����Ʒ��
    TIT_MODEL = 2,             //  ��ʾ����Ϊ����
    TIT_YEAR = 3,              //  ��ʾ����Ϊ�������
    TIT_VEH_INFORMATION = 4,   //  ��ʾ����Ϊ������Ϣ�����磬����/3'/320Li_B48/F35/
    TIT_SYS_NAME = 5,          //  ��ʾ����Ϊϵͳ���ƣ����磬RCM-��ȫ��������ϵͳ
    TIT_ENGINE_INFO = 6,       //  ��ʾ����Ϊ��������Ϣ�����磬"F62-D52"
    TIT_ENGINE_SUB_TYPE = 7,   //  ��ʾ����Ϊ���������ͺŻ���������Ϣ�����磬"N542"
    TIT_DTC_CODE = 8,          //  ��ʾ����Ϊ��������룬���磬"P1145"
    TIT_FUNC_INFOR = 9,        //  ��ʾ����Ϊ�����������磬"Oil Reset"
    TIT_DS_INFOR = 10,         //  ��ʾ����Ϊ��������Ϣ�����磬"0x00002661"����""0x00002661$0x00002662""
    TIT_ENTER_SYS_TIME = 11,   //  ��ʾ����Ϊ��ϵͳ��ʱ����λΪ�룬���磬"3.216"��ʾ3.216��
};


///////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------------------------
˵    ����ArtiGlobal ������������¼���������ȫ����Ľӿ�SetEventTracking�β� vctPara

          uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);
-------------------------------------------------------------------------------------------------*/
// ���������Ϣ�Ľṹ��
struct stTrackingItem
{
    eTrackingInfoType eType;         // ���Ĳ�������
    // ���� TIT_DTC_CODE����ʾstrValue ��ֵ�� "���������"

    std::string     strValue;       // ʵ�����������͵��ַ���ֵ
    // ���統 eType = TIT_DTC_CODE��strValueΪ "P1145"
    // ���統 eType = TIT_VIN��strValueΪ "KMHSH81DX9U478798"
};



#endif // __STD_EVENT_TRACKING_MACO_H__
