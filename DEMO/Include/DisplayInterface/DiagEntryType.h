#ifndef __DIAG_ENTRY_TYPE_MACO_H__
#define __DIAG_ENTRY_TYPE_MACO_H__

#include "StdInclude.h"


// ���������64λ��չΪ128λ
// GetDiagEntryTypeEx��ȡ��������ֵ����
// 
// 
// ���ڽӿ�GetDiagEntryTypeEx�ķ���ֵ�±�
enum eDiagEntryTypeEx
{   //��ǰ��Ϲ��������±�

    DETE_BASE_VER_POS        = 0,       // �±�ȡֵ���Ӧ(1 << 0), ��Ӧԭ������DET_BASE_VER��   ��ʾ֧�ֻ�������_���汾��Ϣ
    DETE_BASE_RDTC_POS       = 1,       // �±�ȡֵ���Ӧ(1 << 1), ��Ӧԭ������DET_BASE_RDTC��  ��ʾ֧�ֻ�������_��������
    DETE_BASE_CDTC_POS       = 2,       // �±�ȡֵ���Ӧ(1 << 2), ��Ӧԭ������DET_BASE_CDTC��  ��ʾ֧�ֻ�������_�������
    DETE_BASE_RDS_POS        = 3,       // �±�ȡֵ���Ӧ(1 << 3), ��Ӧԭ������DET_BASE_RDS��   ��ʾ֧�ֻ�������_��������
    DETE_BASE_ACT_POS        = 4,       // �±�ȡֵ���Ӧ(1 << 4), ��Ӧԭ������DET_BASE_ACT��   ��ʾ֧�ֶ�������
    DETE_BASE_FFRAME_POS     = 5,       // �±�ȡֵ���Ӧ(1 << 5), ��Ӧԭ������DET_BASE_FFRAME����ʾ֧�ֶ���֡


    DETE_OIL_RESET_POS            = 6,  // ��Ӧ�±������ֵ��(1 << 6), DET_MT_OIL_RESET�� OILRESET             ���͹��㹦�����룬"Oil Reset"
    DETE_THROTTLE_ADAPTATION_POS  = 7,  // (1 << 7),        DET_MT_THROTTLE_ADAPTATION��  THROTTLE             ������ƥ�䣬      "Throttle Adaptation"
    DETE_EPB_RESET_POS            = 8,  // (1 << 8),        DET_MT_EPB_RESET��            EPB                  ɲ��Ƭ������      "EPB Reset or Brake Reset"
    DETE_ABS_BLEEDING_POS         = 9,  // (1 << 9),        DEF_MT_ABS_BLEEDING��         ABS                  ABS               "ABS Bleeding"
    DEFE_STEERING_ANGLE_RESET_POS = 10,  // (1 << 10),      DEF_MT_STEERING_ANGLE_RESET   STEERING             ת��Ǹ�λ��      "Steering Angle Reset"


    DEFE_DPF_REGENERATION_POS     = 11,  // (1 << 11),      DEF_MT_DPF_REGENERATION       DPF                  DPF������"DPF Regeneration"
    DEFE_AIRBAG_RESET_POS         = 12,  // (1 << 12),      DEF_MT_AIRBAG_RESET           AIRBAG               ���Ҹ�λ "Airbag Reset"
    DEFE_BMS_RESET_POS            = 13,  // (1 << 13),      DEF_MT_BMS_RESET              BMS                  ���ƥ�� "BMS Reset"
    DEFE_ADAS_POS                 = 14,  // (1 << 14),      DEF_MT_ADAS ADAS              ADAS                 У׼
    DEFE_IMMO_POS                 = 15,  // (1 << 15),      DEF_MT_IMMO IMMO              IMMO                 ����ƥ��


    DEFE_SMART_KEY_POS            = 16,  // (1 << 16),      DEF_MT_SMART_KEY              SMART_KEY            ����Կ��ƥ�� SmartKey
    DEFE_PASSWORD_READING_POS     = 17,  // (1 << 17),      DEF_MT_PASSWORD_READING       PASSWORD_READING     �����ȡ PasswordReading
    DEFE_DYNAMIC_ADAS_POS         = 18,  // (1 << 18),      DEF_MT_DYNAMIC_ADAS           DYADAS               ��̬ADASУ׼
    DEFE_INJECTOR_CODE_POS        = 19,  // (1 << 19),      DEF_MT_INJECTOR_CODE          INJECTOR_CODE        ��������� InjectorCode
    DEFE_SUSPENSION_POS           = 20,  // (1 << 20),      DEF_MT_SUSPENSION             SUSPENSION           ����ƥ�� Suspension


    DEFE_TIRE_PRESSURE_POS        = 21,  // (1 << 21),      DEF_MT_TIRE_PRESSURE          TIRE_PRESSURE        ̥ѹ��λ TirePressure
    DEFE_TRANSMISSION_POS         = 22,  // (1 << 22),      DEF_MT_TRANSMISSION           TRANSMISSION         ������ƥ�� Gearbox matching, Transmission
    DEFE_GEARBOX_LEARNING_POS     = 23,  // (1 << 23),      DEF_MT_GEARBOX_LEARNING       GEARBOX_LEARNING     ��Ѷѧϰ Gear Learn, GearboxLearning
    DEFE_TRANSPORT_MODE_POS       = 24,  // (1 << 24),      DEF_MT_TRANSPORT_MODE         TRANSPORT_MODE       ����ģʽ���, TransportMode
    DEFE_HEAD_LIGHT_POS           = 25,  // (1 << 25),      DEF_MT_HEAD_LIGHT             HEAD_LIGHT           ���ƥ�� AFS Reset, Headlight or AFS Reset


    DEFE_SUNROOF_INIT_POS         = 26,  // (1 << 26),      DEF_MT_SUNROOF_INIT           SUNROOF_INIT         �촰��ʼ�� SunroofInit
    DEFE_SEAT_CALI_POS            = 27,  // (1 << 27),      DEF_MT_SEAT_CALI              SEAT_CALI            ���α궨 SeatCali
    DEFE_WINDOW_CALI_POS          = 28,  // (1 << 28),      DEF_MT_WINDOW_CALI            WINDOW_CALI          �Ŵ��궨 WindowCali
    DEFE_START_STOP_POS           = 29,  // (1 << 29),      DEF_MT_START_STOP             START_STOP           ��ͣ���� StartStop
    DEFE_EGR_POS                  = 30,  // (1 << 30),      DEF_MT_EGR                    EGR                  EGR��ѧϰ, ������ѭ�� �� Exhaust Gas Recirculation��


    DEFE_ODOMETER_POS                    = 31,  // 0x80000000,               DEF_MT_ODOMETER                    ��̱��У,          ODOMETER                1 << 31   Odometer
    DEFE_LANGUAGE_POS                    = 32,  // 0x100000000,              DEF_MT_LANGUAGE                    ��������,            LANGUAGE                1 << 32   Language
    DEFE_TIRE_MODIFIED_POS               = 33,  // 0x200000000,              DEF_MT_TIRE_MODIFIED               ��̥��װ,            TIRE_MODIFIED           1 << 33   Tire
    DEFE_A_F_ADJ_POS                     = 34,  // 0x400000000,              DEF_MT_A_F_ADJ A/F                 ��У,                A_F_ADJ                 1 << 34   A_F_Adj
    DEFE_ELECTRONIC_PUMP_POS             = 35,  // 0x800000000,              DEF_MT_ELECTRONIC_PUMP             ����ˮ�ü���,        ELECTRONIC_PUMP         1 << 35   Coolant Bleed,ElectronicPump


    DEFE_NOx_RESET_POS                   = 36,  // 0x1000000000,             DEF_MT_NOx_RESET                   �����ŷŸ�λ,         NOX_RESET              1 << 36   NoxReset
    DEFE_UREA_RESET_POS                  = 37,  // 0x2000000000,             DEF_MT_UREA_RESET                  ���ظ�λ,             UREA_RESET             1 << 37   UreaReset or  AdBlue Reset
    DEFE_TURBINE_LEARNING_POS            = 38,  // 0x4000000000,             DEF_MT_TURBINE_LEARNING            ����ҶƬѧϰ,         TURBINE_LEARNING       1 << 38   TurbineLearning
    DEFE_CYLINDER_POS                    = 39,  // 0x8000000000,             DEF_MT_CYLINDER                    ����ƽ�����,         CYLINDER               1 << 39   Cylinder
    DEFE_EEPROM_POS                      = 40,  // 0x10000000000,            DEF_MT_EEPROM                      EEPROM������,         EEPROM                 1 << 40   EEPROM


    DEFE_EXHAUST_PROCESSING_POS          = 41,  // 0x20000000000,            DEF_MT_EXHAUST_PROCESSING          β������,           EXHAUST_PROCESSING     1 << 41   ExhaustProcessing
    DEFE_RFID_POS                        = 42,  // 0x40000000000,            DEF_MT_RFID                        RFID,                 RFID                   1 << 42   RFID
    DETE_SPEC_FUNC_POS                   = 43,  // 0x80000000000,            DET_MT_SPEC_FUNC                   ���⹦��,             SPEC_FUNC              1 << 43
    DEFE_CLUTCH_POS                      = 44,  // 0x100000000000,           DEF_MT_CLUTCH                      �����ƥ��,           CLUTCH                 1 << 44   Clutch
    DEFE_SPEED_PTO_POS                   = 45,  // 0x200000000000,           DEF_MT_SPEED_PTO                   �ٶ��빦��,           SPEED_PTO              1 << 45   Speed & PTO


    DEFE_FRM_RESET_POS                   = 46,  // 0x400000000000,           DEF_MT_FRM_RESET                   FRM��λ,              FRM_RESET              1 << 46    FRM_RESET
    DEFE_VIN_POS                         = 47,  // 0x800000000000,           DEF_MT_VIN                         VIN��д��,            VIN                    1 << 47    VIN
    DEFE_HV_BATTERY_POS                  = 48,  // 0x1000000000000,          DEF_MT_HV_BATTERY                  ��ѹ���,             HV_BAT                 1 << 48    HV Battery
    DEFE_ACC_POS                         = 49,  // 0x2000000000000,          DEF_MT_ACC                         Ѳ��У׼,             ACC                    1 << 49    ACC
    DEFE_AC_LEARNING_POS                 = 50,  // 0x4000000000000,          DEF_MT_AC_LEARNING                 �յ�ѧϰ,             AC_LEARNING            1 << 50    A/C


    DEFE_RAIN_LIGHT_SENSOR_POS           = 51,  // 0x8000000000000,          DEF_MT_RAIN_LIGHT_SENSOR           ��ˮ/�⴫����,        RAIN_LIGH              1 << 51    Rain/Light Sensor
    DEFE_RESET_CONTROL_UNIT_POS          = 52,  // 0x10000000000000,         DEF_MT_RESET_CONTROL_UNIT          ���Ƶ�Ԫ��λ,         ECURESET               1 << 52    Reset control unit
                                                // 0x20000000000000,         DEF_MT_RESERVED                    ����                  RESERVED               1 << 53
    DEFE_RELATIVE_COMPRESSION_POS        = 54,  // 0x40000000000000,         DEF_MT_RELATIVE_COMPRESSION        ���ѹ�� ,            REL_COMP               1 << 54    Relative Compression
    DEFE_HV_DE_ENERGIZATION_POS          = 55,  // 0x80000000000000,         DEF_MT_HV_DE_ENERGIZATION          ��ѹ�ϵ�/����,        HVPO                   1 << 55    HV De-energization/Energization


    DEFE_COOLANT_REFRIGERANT_CHANGE_POS  = 56,  // 0x100000000000000,        DEF_MT_COOLANT_REFRIGERANT_CHANGE  ��ȴҺ/���������,    COOL_REPL              1 << 56    Coolant/Refrigerant Change
    DEFE_RESOLVER_SENSOR_CALIBRATION_POS = 57,  // 0x200000000000000,        DEF_MT_RESOLVER_SENSOR_CALIBRATION ���䴫�����궨 ,      RESOLVER_CALI          1 << 57    Resolver Sensor Calibration
    DEFE_CAMSHAFT_LEARNING_POS           = 58,  // 0x400000000000000,        DEF_MT_CAMSHAFT_LEARNING           ͹����ѧϰ ,          CAMSHAFT               1 << 58    Camshaft learning
                                                // 0x800000000000000,        DEF_MT_RESERVED                    ����                  RESERVED               1 << 59
                                                // 0x1000 0000 0000 0000     DEF_MT_RESERVED                    ����                  RESERVED               1 << 60

    DEFE_MT_CUSTOMIZE_POS                = 61,  // 0x2000 0000 0000 0000,    DEF_MT_CUSTOMIZE                   ���Ի����ã�ˢ���أ�  CUSTOMIZE              1 << 61    Personalization Setting
    DEFE_MT_MOTOR_ANGLE_POS              = 62,  // 0x4000 0000 0000 0000,    DEF_MT_MOTOR_ANGLE                 �����λ�ô������궨  MOTOR_ANGLE            1 << 62    Motor Angle Calibration
    DEFE_MT_EV_COMPRESSION_POS           = 63,  // 0x8000 0000 0000 0000,    DEF_MT_EV_COMPRESSION              ѹ��������,           EV_COMPRESSION_TEST    1 << 63    Compressor Test(EV)
    DEFE_MT_EV_OBC_POS                   = 64,  // 0x1 0000 0000 0000 0000,  DEF_MT_EV_OBC                      ���س���,           EV_OBC                 1 << 64    OBC Test(EV)
    DEFE_MT_EV_DCDC_POS                  = 65,  // 0x2 0000 0000 0000 0000,  DEF_MT_EV_DCDC                     ֱ��ת������DCDC��,   EV_DCDC                1 << 65    DCDC Test(EV)


    DEFE_MT_EV_48V_POS                   = 66,  // 0x4  0000 0000 0000 0000, DEF_MT_EV_48V                      48V��첿��,          EV_48V                 1 << 66    48V MHEV Test(EV)
    DEFE_MT_ODO_CHECK_POS                = 67,  // 0x8  0000 0000 0000 0000, DEF_MT_ODO_CHECK_POS               �����                ODO_CHECK              1 << 67    ODO CHECK
    DEFE_MT_IDLE_ADJ_POS                 = 68,  // 0x10 0000 0000 0000 0000, DEF_MT_IDLE_ADJ                    ���ٵ���              IDLE_ADJ               1 << 68    Idle Adjustment
    DEFE_MT_CO_ADJ_POS                   = 69,  // 0x20 0000 0000 0000 0000, DEF_MT_CO_ADJ                      һ����̼����          CO_ADJ                 1 << 69    CO Adjustment
    DEFE_MT_ECU_FLASH_POS                = 70,  // 0x40 0000 0000 0000 0000, DEF_MT_ECU_FLASH                   ģ��ˢд              ECU_FLASH              1 << 70    ECU Flashing

    DEFE_MT_SOFT_EXPIRATION_POS          = 71,  // 0x80 0000 0000 0000 0000, DEF_MT_SOFT_EXPIRATION             �������              SOFT_EXPIRE            1 << 71    Software Expiration
};

#endif // __DIAG_ENTRY_TYPE_MACO_H__
