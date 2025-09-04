#ifndef __DIAG_ENTRY_TYPE_MACO_H__
#define __DIAG_ENTRY_TYPE_MACO_H__

#include "StdInclude.h"


// 功能掩码从64位扩展为128位
// GetDiagEntryTypeEx获取功能掩码值数组
// 
// 
// 用于接口GetDiagEntryTypeEx的返回值下标
enum eDiagEntryTypeEx
{   //当前诊断功能掩码下标

    DETE_BASE_VER_POS        = 0,       // 下标取值后对应(1 << 0), 对应原宏名，DET_BASE_VER，   表示支持基本功能_读版本信息
    DETE_BASE_RDTC_POS       = 1,       // 下标取值后对应(1 << 1), 对应原宏名，DET_BASE_RDTC，  表示支持基本功能_读故障码
    DETE_BASE_CDTC_POS       = 2,       // 下标取值后对应(1 << 2), 对应原宏名，DET_BASE_CDTC，  表示支持基本功能_清故障码
    DETE_BASE_RDS_POS        = 3,       // 下标取值后对应(1 << 3), 对应原宏名，DET_BASE_RDS，   表示支持基本功能_读数据流
    DETE_BASE_ACT_POS        = 4,       // 下标取值后对应(1 << 4), 对应原宏名，DET_BASE_ACT，   表示支持动作测试
    DETE_BASE_FFRAME_POS     = 5,       // 下标取值后对应(1 << 5), 对应原宏名，DET_BASE_FFRAME，表示支持冻结帧


    DETE_OIL_RESET_POS            = 6,  // 对应下标的数组值，(1 << 6), DET_MT_OIL_RESET， OILRESET             机油归零功能掩码，"Oil Reset"
    DETE_THROTTLE_ADAPTATION_POS  = 7,  // (1 << 7),        DET_MT_THROTTLE_ADAPTATION，  THROTTLE             节气门匹配，      "Throttle Adaptation"
    DETE_EPB_RESET_POS            = 8,  // (1 << 8),        DET_MT_EPB_RESET，            EPB                  刹车片更换，      "EPB Reset or Brake Reset"
    DETE_ABS_BLEEDING_POS         = 9,  // (1 << 9),        DEF_MT_ABS_BLEEDING，         ABS                  ABS               "ABS Bleeding"
    DEFE_STEERING_ANGLE_RESET_POS = 10,  // (1 << 10),      DEF_MT_STEERING_ANGLE_RESET   STEERING             转向角复位，      "Steering Angle Reset"


    DEFE_DPF_REGENERATION_POS     = 11,  // (1 << 11),      DEF_MT_DPF_REGENERATION       DPF                  DPF再生，"DPF Regeneration"
    DEFE_AIRBAG_RESET_POS         = 12,  // (1 << 12),      DEF_MT_AIRBAG_RESET           AIRBAG               气囊复位 "Airbag Reset"
    DEFE_BMS_RESET_POS            = 13,  // (1 << 13),      DEF_MT_BMS_RESET              BMS                  电池匹配 "BMS Reset"
    DEFE_ADAS_POS                 = 14,  // (1 << 14),      DEF_MT_ADAS ADAS              ADAS                 校准
    DEFE_IMMO_POS                 = 15,  // (1 << 15),      DEF_MT_IMMO IMMO              IMMO                 防盗匹配


    DEFE_SMART_KEY_POS            = 16,  // (1 << 16),      DEF_MT_SMART_KEY              SMART_KEY            智能钥匙匹配 SmartKey
    DEFE_PASSWORD_READING_POS     = 17,  // (1 << 17),      DEF_MT_PASSWORD_READING       PASSWORD_READING     密码读取 PasswordReading
    DEFE_DYNAMIC_ADAS_POS         = 18,  // (1 << 18),      DEF_MT_DYNAMIC_ADAS           DYADAS               动态ADAS校准
    DEFE_INJECTOR_CODE_POS        = 19,  // (1 << 19),      DEF_MT_INJECTOR_CODE          INJECTOR_CODE        喷油嘴编码 InjectorCode
    DEFE_SUSPENSION_POS           = 20,  // (1 << 20),      DEF_MT_SUSPENSION             SUSPENSION           悬挂匹配 Suspension


    DEFE_TIRE_PRESSURE_POS        = 21,  // (1 << 21),      DEF_MT_TIRE_PRESSURE          TIRE_PRESSURE        胎压复位 TirePressure
    DEFE_TRANSMISSION_POS         = 22,  // (1 << 22),      DEF_MT_TRANSMISSION           TRANSMISSION         变速箱匹配 Gearbox matching, Transmission
    DEFE_GEARBOX_LEARNING_POS     = 23,  // (1 << 23),      DEF_MT_GEARBOX_LEARNING       GEARBOX_LEARNING     齿讯学习 Gear Learn, GearboxLearning
    DEFE_TRANSPORT_MODE_POS       = 24,  // (1 << 24),      DEF_MT_TRANSPORT_MODE         TRANSPORT_MODE       运输模式解除, TransportMode
    DEFE_HEAD_LIGHT_POS           = 25,  // (1 << 25),      DEF_MT_HEAD_LIGHT             HEAD_LIGHT           大灯匹配 AFS Reset, Headlight or AFS Reset


    DEFE_SUNROOF_INIT_POS         = 26,  // (1 << 26),      DEF_MT_SUNROOF_INIT           SUNROOF_INIT         天窗初始化 SunroofInit
    DEFE_SEAT_CALI_POS            = 27,  // (1 << 27),      DEF_MT_SEAT_CALI              SEAT_CALI            座椅标定 SeatCali
    DEFE_WINDOW_CALI_POS          = 28,  // (1 << 28),      DEF_MT_WINDOW_CALI            WINDOW_CALI          门窗标定 WindowCali
    DEFE_START_STOP_POS           = 29,  // (1 << 29),      DEF_MT_START_STOP             START_STOP           启停设置 StartStop
    DEFE_EGR_POS                  = 30,  // (1 << 30),      DEF_MT_EGR                    EGR                  EGR自学习, 废气再循环 （ Exhaust Gas Recirculation）


    DEFE_ODOMETER_POS                    = 31,  // 0x80000000,               DEF_MT_ODOMETER                    里程表调校,          ODOMETER                1 << 31   Odometer
    DEFE_LANGUAGE_POS                    = 32,  // 0x100000000,              DEF_MT_LANGUAGE                    语言设置,            LANGUAGE                1 << 32   Language
    DEFE_TIRE_MODIFIED_POS               = 33,  // 0x200000000,              DEF_MT_TIRE_MODIFIED               轮胎改装,            TIRE_MODIFIED           1 << 33   Tire
    DEFE_A_F_ADJ_POS                     = 34,  // 0x400000000,              DEF_MT_A_F_ADJ A/F                 调校,                A_F_ADJ                 1 << 34   A_F_Adj
    DEFE_ELECTRONIC_PUMP_POS             = 35,  // 0x800000000,              DEF_MT_ELECTRONIC_PUMP             电子水泵激活,        ELECTRONIC_PUMP         1 << 35   Coolant Bleed,ElectronicPump


    DEFE_NOx_RESET_POS                   = 36,  // 0x1000000000,             DEF_MT_NOx_RESET                   氮氧排放复位,         NOX_RESET              1 << 36   NoxReset
    DEFE_UREA_RESET_POS                  = 37,  // 0x2000000000,             DEF_MT_UREA_RESET                  尿素复位,             UREA_RESET             1 << 37   UreaReset or  AdBlue Reset
    DEFE_TURBINE_LEARNING_POS            = 38,  // 0x4000000000,             DEF_MT_TURBINE_LEARNING            涡轮叶片学习,         TURBINE_LEARNING       1 << 38   TurbineLearning
    DEFE_CYLINDER_POS                    = 39,  // 0x8000000000,             DEF_MT_CYLINDER                    气缸平衡测试,         CYLINDER               1 << 39   Cylinder
    DEFE_EEPROM_POS                      = 40,  // 0x10000000000,            DEF_MT_EEPROM                      EEPROM适配器,         EEPROM                 1 << 40   EEPROM


    DEFE_EXHAUST_PROCESSING_POS          = 41,  // 0x20000000000,            DEF_MT_EXHAUST_PROCESSING          尾气后处理,           EXHAUST_PROCESSING     1 << 41   ExhaustProcessing
    DEFE_RFID_POS                        = 42,  // 0x40000000000,            DEF_MT_RFID                        RFID,                 RFID                   1 << 42   RFID
    DETE_SPEC_FUNC_POS                   = 43,  // 0x80000000000,            DET_MT_SPEC_FUNC                   特殊功能,             SPEC_FUNC              1 << 43
    DEFE_CLUTCH_POS                      = 44,  // 0x100000000000,           DEF_MT_CLUTCH                      离合器匹配,           CLUTCH                 1 << 44   Clutch
    DEFE_SPEED_PTO_POS                   = 45,  // 0x200000000000,           DEF_MT_SPEED_PTO                   速度与功率,           SPEED_PTO              1 << 45   Speed & PTO


    DEFE_FRM_RESET_POS                   = 46,  // 0x400000000000,           DEF_MT_FRM_RESET                   FRM复位,              FRM_RESET              1 << 46    FRM_RESET
    DEFE_VIN_POS                         = 47,  // 0x800000000000,           DEF_MT_VIN                         VIN（写）,            VIN                    1 << 47    VIN
    DEFE_HV_BATTERY_POS                  = 48,  // 0x1000000000000,          DEF_MT_HV_BATTERY                  高压电池,             HV_BAT                 1 << 48    HV Battery
    DEFE_ACC_POS                         = 49,  // 0x2000000000000,          DEF_MT_ACC                         巡航校准,             ACC                    1 << 49    ACC
    DEFE_AC_LEARNING_POS                 = 50,  // 0x4000000000000,          DEF_MT_AC_LEARNING                 空调学习,             AC_LEARNING            1 << 50    A/C


    DEFE_RAIN_LIGHT_SENSOR_POS           = 51,  // 0x8000000000000,          DEF_MT_RAIN_LIGHT_SENSOR           雨水/光传感器,        RAIN_LIGH              1 << 51    Rain/Light Sensor
    DEFE_RESET_CONTROL_UNIT_POS          = 52,  // 0x10000000000000,         DEF_MT_RESET_CONTROL_UNIT          控制单元复位,         ECURESET               1 << 52    Reset control unit
                                                // 0x20000000000000,         DEF_MT_RESERVED                    保留                  RESERVED               1 << 53
    DEFE_RELATIVE_COMPRESSION_POS        = 54,  // 0x40000000000000,         DEF_MT_RELATIVE_COMPRESSION        相对压缩 ,            REL_COMP               1 << 54    Relative Compression
    DEFE_HV_DE_ENERGIZATION_POS          = 55,  // 0x80000000000000,         DEF_MT_HV_DE_ENERGIZATION          高压断电/启用,        HVPO                   1 << 55    HV De-energization/Energization


    DEFE_COOLANT_REFRIGERANT_CHANGE_POS  = 56,  // 0x100000000000000,        DEF_MT_COOLANT_REFRIGERANT_CHANGE  冷却液/制冷剂更换,    COOL_REPL              1 << 56    Coolant/Refrigerant Change
    DEFE_RESOLVER_SENSOR_CALIBRATION_POS = 57,  // 0x200000000000000,        DEF_MT_RESOLVER_SENSOR_CALIBRATION 旋变传感器标定 ,      RESOLVER_CALI          1 << 57    Resolver Sensor Calibration
    DEFE_CAMSHAFT_LEARNING_POS           = 58,  // 0x400000000000000,        DEF_MT_CAMSHAFT_LEARNING           凸轮轴学习 ,          CAMSHAFT               1 << 58    Camshaft learning
                                                // 0x800000000000000,        DEF_MT_RESERVED                    保留                  RESERVED               1 << 59
                                                // 0x1000 0000 0000 0000     DEF_MT_RESERVED                    保留                  RESERVED               1 << 60

    DEFE_MT_CUSTOMIZE_POS                = 61,  // 0x2000 0000 0000 0000,    DEF_MT_CUSTOMIZE                   个性化设置（刷隐藏）  CUSTOMIZE              1 << 61    Personalization Setting
    DEFE_MT_MOTOR_ANGLE_POS              = 62,  // 0x4000 0000 0000 0000,    DEF_MT_MOTOR_ANGLE                 电机角位置传感器标定  MOTOR_ANGLE            1 << 62    Motor Angle Calibration
    DEFE_MT_EV_COMPRESSION_POS           = 63,  // 0x8000 0000 0000 0000,    DEF_MT_EV_COMPRESSION              压缩机测试,           EV_COMPRESSION_TEST    1 << 63    Compressor Test(EV)
    DEFE_MT_EV_OBC_POS                   = 64,  // 0x1 0000 0000 0000 0000,  DEF_MT_EV_OBC                      车载充电机,           EV_OBC                 1 << 64    OBC Test(EV)
    DEFE_MT_EV_DCDC_POS                  = 65,  // 0x2 0000 0000 0000 0000,  DEF_MT_EV_DCDC                     直流转换器（DCDC）,   EV_DCDC                1 << 65    DCDC Test(EV)


    DEFE_MT_EV_48V_POS                   = 66,  // 0x4  0000 0000 0000 0000, DEF_MT_EV_48V                      48V轻混部件,          EV_48V                 1 << 66    48V MHEV Test(EV)
    DEFE_MT_ODO_CHECK_POS                = 67,  // 0x8  0000 0000 0000 0000, DEF_MT_ODO_CHECK_POS               多里程                ODO_CHECK              1 << 67    ODO CHECK
    DEFE_MT_IDLE_ADJ_POS                 = 68,  // 0x10 0000 0000 0000 0000, DEF_MT_IDLE_ADJ                    怠速调整              IDLE_ADJ               1 << 68    Idle Adjustment
    DEFE_MT_CO_ADJ_POS                   = 69,  // 0x20 0000 0000 0000 0000, DEF_MT_CO_ADJ                      一氧化碳调整          CO_ADJ                 1 << 69    CO Adjustment
    DEFE_MT_ECU_FLASH_POS                = 70,  // 0x40 0000 0000 0000 0000, DEF_MT_ECU_FLASH                   模块刷写              ECU_FLASH              1 << 70    ECU Flashing

    DEFE_MT_SOFT_EXPIRATION_POS          = 71,  // 0x80 0000 0000 0000 0000, DEF_MT_SOFT_EXPIRATION             软件过期              SOFT_EXPIRE            1 << 71    Software Expiration
};

#endif // __DIAG_ENTRY_TYPE_MACO_H__
