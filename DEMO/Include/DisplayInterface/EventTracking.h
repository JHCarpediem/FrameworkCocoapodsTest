#ifndef __STD_EVENT_TRACKING_MACO_H__
#define __STD_EVENT_TRACKING_MACO_H__

#include <string>


///////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------------------------
说    明：ArtiGlobal 用于设置埋点事件ID，适用于全局类的接口SetEventTracking形参 vctPara

          uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);
-------------------------------------------------------------------------------------------------*/
// 埋点所需信息事件ID值定义
enum eEventTrackingId
{
    ETI_CLICK_DIAGNOSTIC_AUTOMATIC              = 0,     // 0      诊断类型-Automatic                     功能使用率
    ETI_CLICK_DIAGNOSTIC_MANUAL                 = 1,     // 1      诊断类型-Manual                        功能使用率
    ETI_DIAG_VIN_READ_FAIL                      = 2,     // 2      VIN码读取失败                          
    ETI_DIAG_VIN_READ_SUCC                      = 3,     // 3      VIN码读取成功                          
    ETI_DIAG_VIN_DECODER_SUCC                   = 4,     // 4      车辆信息解析成功                       VIN解析车型信息成功
    ETI_DIAG_VIN_DECODER_FAIL                   = 5,     // 5      车辆信息解析失败                       VIN解析车型信息失败
    ETI_CLICKVEHICLE_PROFILE_CONFIRM            = 6,     // 6      选车完成                               点击VehicleProfile界面的Confirm按钮
    ETI_ENTER_SYSTEM_TIME                       = 7,     // 7      进系统成功耗时                         大退或杀掉APP数据不统计
    ETI_ENTER_SYSTEM_FAIL                       = 8,     // 8      进系统失败                             进系统失败（否定或未回复）
    ETI_READ_DTC_SUCC                           = 9,     // 9      读取故障码成功                         
    ETI_READ_DTC_FAIL                           = 10,    // 10     读取故障码失败                         故障码读取失败（否定或未回复）
    ETI_CLEAR_DTC_FAIL                          = 11,    // 11     清除故障码失败                         故障码清除失败（否定或未回复）
    ETI_DS_VALUE_ABNORMAL                       = 12,    // 12     数据流值异常                           当前屏数据流项值异常（比如空、N/A、？等）
    ETI_DS_READ_FAIL                            = 13,    // 13     读取数据流失败                         数据流读取失败（全部否定或未回复）
    ETI_AT_NAME                                 = 14,    // 14     动作测试项名称                         
    ETI_AT_EXECUTE_FAIL                         = 15,    // 15     动作测试执行失败                       动作测试项执行失败（否定或未回复）
    ETI_SP_NAME                                 = 16,    // 16     特殊功能项名称                         
    ETI_SP_EXECUTE_FAIL                         = 17,    // 17     特殊功能执行失败                       特殊功能项执行失败
    ETI_CLICK_HF_OIL_RESET                      = 18,    // 18     HF_Oilreset                            保养归零功能使用率
    ETI_HF_OIL_RESET_FAIL                       = 19,    // 19     HF_Oilreset执行失败                    保养归零功能执行失败
    ETI_CLICK_HF_THROTTLE_ADAPTATION            = 20,    // 20     HF_Throttleadaptation                  节气门匹配功能使用率
    ETI_HF_THROTTLE_ADAPTATION_FAIL             = 21,    // 21     HF_Throttleadaptation执行失败          节气门匹配功能执行失败
    ETI_CLICK_HF_EPB_RESET                      = 22,    // 22     HF_EPBreset                            刹车片更换功能使用率
    ETI_HF_EPB_RESET_FAIL                       = 23,    // 23     HF_EPBreset执行失败                    刹车片更换功能执行失败
    ETI_CLICK_HF_BMS_RESET                      = 24,    // 24     HF_BMSreset                            电池匹配功能使用率
    ETI_HF_BMS_RESET_FAIL                       = 25,    // 25     HF_BMSreset执行失败                    电池匹配功能执行失败
    ETI_CLICK_HF_SAS_RESET                      = 26,    // 26     HF_SASreset                            转向角复位功能使用率
    ETI_HF_SAS_RESET_FAIL                       = 27,    // 27     HF_SASreset执行失败                    转向角复位功能执行失败
    ETI_CLICK_HF_DPF_REGENERATION               = 28,    // 28     HF_DPFregeneration                     DPF再生功能使用率
    ETI_HF_DPF_REGENERATION_FAIL                = 29,    // 29     HF_DPFregeneration执行失败             DPF再生功能执行失败
    ETI_CLICK_HF_ABS_BLEEDING                   = 30,    // 30     HF_ABSbleeding                         ABS排气功能使用率
    ETI_HF_ABS_BLEEDING_FAIL                    = 31,    // 31     HF_ABSbleeding执行失败                 ABS排气功能执行失败
    ETI_CLICK_HF_AIRBAG_RESET                   = 32,    // 32     HF_Airbagreset                         气囊复位功能使用率
    ETI_HF_AIRBAG_RESET_FAIL                    = 33,    // 33     HF_Airbagreset执行失败                 气囊复位功能执行失败
    ETI_CLICK_HF_TPMS_RESET                     = 34,    // 34     HF_TPMSreset                           胎压复位功能使用率
    ETI_HF_TPMS_RESET_FAIL                      = 35,    // 35     HF_TPMSreset执行失败                   胎压复位功能执行失败
    ETI_CLICK_HF_INJECTOR_CODING                = 36,    // 36     HF_Injectorcoding                      喷油嘴编码功能使用率
    ETI_HF_INJECTOR_CODING_FAIL                 = 37,    // 37     HF_Injectorcoding执行失败              喷油嘴编码功能执行失败
    ETI_CLICK_HF_IMMO_KEYS                      = 38,    // 38     HF_IMMOkeys                            防盗/钥匙功能使用率
    ETI_HF_IMMO_KEYS_FAIL                       = 39,    // 39     HF_IMMOkeys执行失败                    防盗/钥匙功能执行失败
    ETI_CLICK_HF_SUSPENSION_MATCHING            = 40,    // 40     HF_Suspensionmatching                  悬挂匹配功能使用率
    ETI_HF_SUSPENSION_MATCHING_FAIL             = 41,    // 41     HF_Suspensionmatching执行失败          悬挂匹配功能执行失败
    ETI_CLICK_HF_SEAT_CALIBRATION               = 42,    // 42     HF_Seatcalibration                     座椅标定功能使用率
    ETI_HF_SEAT_CALIBRATION_FAIL                = 43,    // 43     HF_Seatcalibration执行失败             座椅标定功能执行失败
    ETI_CLICK_HF_WINDOWS_CALIBRATION            = 44,    // 44     HF_Windowscalibration                  门窗标定功能使用率
    ETI_HF_WINDOWS_CALIBRATION_FAIL             = 45,    // 45     HF_Windowscalibration                  门窗标定功能执行失败
    ETI_CLICK_HF_SUNROOF_INITIALIZATION         = 46,    // 46     HF_Sunroofinitialization               天窗初始化功能使用率
    ETI_HF_SUNROOF_INITIALIZATION_FAIL          = 47,    // 47     HF_Sunroofinitialization执行失败       天窗初始化功能执行失败
    ETI_CLICK_HF_ODO_RESET                      = 48,    // 48     HF_ODOreset                            里程表调教功能使用率
    ETI_HF_ODO_RESETFAIL                        = 49,    // 49     HF_ODOreset执行失败                    里程表调教功能执行失败
    ETI_CLICK_HF_LANGUAGE_CHANGE                = 50,    // 50     HF_Languagechange                      语言设置功能使用率
    ETI_HF_LANGUAGE_CHANGE_FAIL                 = 51,    // 51     HF_Languagechange执行失败              语言设置功能执行失败
    ETI_CLICK_HF_AFS_RESET                      = 52,    // 52     HF_AFSreset                            大灯匹配功能使用率
    ETI_HF_AFS_RESET_FAIL                       = 53,    // 53     HF_AFSreset执行失败                    大灯匹配功能执行失败
    ETI_CLICK_HF_TIRE_RESET                     = 54,    // 54     HF_Tirereset                           轮胎改装功能使用率
    ETI_HF_TIRERESET_FAIL                       = 55,    // 55     HF_Tirereset执行失败                   轮胎改装功能执行失败
    ETI_CLICK_HF_GEARBOX_MATCHING               = 56,    // 56     HF_Gearboxmatching                     变速箱匹配功能使用率
    ETI_HF_GEARBOX_MATCHING_FAIL                = 57,    // 57     HF_Gearboxmatching执行失败             变速箱匹配功能执行失败
    ETI_CLICK_HF_CLUTCH_MATCHING                = 58,    // 58     HF_Clutchmatching                      离合器匹配功能使用率
    ETI_HF_CLUTCH_MATCHING_FAIL                 = 59,    // 59     HF_Clutchmatching执行失败              离合器匹配功能执行失败
    ETI_CLICK_HF_GEAR_LEARNING                  = 60,    // 60     HF_Gearlearning                        齿轮学习功能使用率
    ETI_HF_GEAR_LEARNING_FAIL                   = 61,    // 61     HF_Gearlearning执行失败                齿轮学习功能执行失败
    ETI_CLICK_HF_CYLINDER_BALANCE_TEST          = 62,    // 62     HF_Cylinderbalancetest                 气缸平衡测试功能使用率
    ETI_HF_CYLINDER_BALANCE_TEST_FAIL           = 63,    // 63     HF_Cylinderbalancetest执行失败         气缸平衡测试功能执行失败
    ETI_CLICK_HF_EGR_RESET                      = 64,    // 64     HF_EGRreset                            EGR自学习功能使用率
    ETI_HF_EGR_RESET_FAIL                       = 65,    // 65     HF_EGRreset执行失败                    EGR自学习功能执行失败
    ETI_CLICK_HF_VGT_LEARNING                   = 66,    // 66     HF_VGTlearning                         涡轮增压匹配功能使用率
    ETI_HF_VGT_LEARNING_FAIL                    = 67,    // 67     HF_VGTlearning执行失败                 涡轮增压匹配功能执行失败
    ETI_CLICK_HF_VIN                            = 68,    // 68     HF_VIN                                 VIN功能使用率
    ETI_HF_VIN_FAIL                             = 69,    // 69     HF_VIN执行失败                         VIN功能执行失败
    ETI_CLICK_HF_TRANSPORT_MODE                 = 70,    // 70     HF_Transportmode                       运输模式解除功能使用率
    ETI_HF_TRANSPORT_MODE_FAIL                  = 71,    // 71     HF_Transportmode执行失败               运输模式解除功能执行失败
    ETI_CLICK_HF_START_STOP_RESET               = 72,    // 72     HF_StartStopreset                      启停设置功能使用率
    ETI_HF_START_STOP_RESET_FAIL                = 73,    // 73     HF_StartStopreset执行失败              启停设置功能执行失败
    ETI_CLICK_HF_AC_LEARNING                    = 74,    // 74     HF_AClearning                          空调学习功能使用率
    ETI_HF_AC_LEARNINGFAIL                      = 75,    // 75     HF_AClearning执行失败                  空调学习功能执行失败
    ETI_CLICK_HF_AF_RESET                       = 76,    // 76     HF_AFreset                             A/F 调校功能使用率
    ETI_HF_AF_RESET_FAIL                        = 77,    // 77     HF_AFreset执行失败                     A/F 调校功能执行失败
    ETI_CLICK_HF_RAIN_LIGHT_SENSOR              = 78,    // 78     HF_RainLightsensor                     雨量光线传感器功能使用率
    ETI_HF_RAIN_LIGHT_SENSOR_FAIL               = 79,    // 79     HF_RainLightsensor执行失败             雨量光线传感器功能执行失败
    ETI_CLICK_HF_ACC_CALIBRATION                = 80,    // 80     HF_ACCcalibration                      巡航校准功能使用率
    ETI_HF_ACC_CALIBRATIONFAIL                  = 81,    // 81     HF_ACCcalibration执行失败              巡航校准功能执行失败
    ETI_CLICK_HF_COOLANT_BLEEDING               = 82,    // 82     HF_Coolantbleeding                     电子水泵激活功能使用率
    ETI_HF_COOLANT_BLEEDING_FAIL                = 83,    // 83     HF_Coolantbleeding执行失败             电子水泵激活功能执行失败
    ETI_CLICK_HF_NOX_SENSOR_RESET               = 84,    // 84     HF_NOxsensorreset                      NOx复位功能使用率
    ETI_HF_NOX_SENSOR_RESET_FAIL                = 85,    // 85     HF_NOxsensorreset执行失败              NOx复位功能执行失败
    ETI_CLICK_HF_AD_BLUE_RESET                  = 86,    // 86     HF_AdBluereset                         尿素复位功能使用率
    ETI_HF_AD_BLUE_RESET_FAIL                   = 87,    // 87     HF_AdBluereset执行失败                 尿素复位功能执行失败
    ETI_CLICK_HF_HV_BATTERY                     = 88,    // 88     HF_HVbattery                           高压电池功能使用率
    ETI_HF_HV_BATTERYF_AIL                      = 89,    // 89     HF_HVbattery执行失败                   高压电池功能执行失败
    ETI_CLICK_HF_ADAS_CALIBRATION               = 90,    // 90     HF_ADAScalibration                     ADAS校准功能使用率
    ETI_HF_ADAS_CALIBRATION_FAIL                = 91,    // 91     HF_ADAScalibration执行失败             ADAS校准功能执行失败
    ETI_CLICK_HF_SMART_KEY_MATCHING             = 92,    // 92     HF_Smartkeymatching                    智能钥匙匹配功能使用率
    ETI_HF_SMART_KEY_MATCHING_FAIL              = 93,    // 93     HF_Smartkeymatching执行失败            智能钥匙匹配功能执行失败
    ETI_CLICK_HF_PIN_CODE_READING               = 94,    // 94     HF_PINCodereading                      密码读取功能使用率
    ETI_HF_PIN_CODE_READING_FAIL                = 95,    // 95     HF_PINCodereading执行失败              密码读取功能执行失败
    ETI_CLICK_HF_EEPROM                         = 96,    // 96     HF_EEPROM                              EEPROM适配器功能使用率
    ETI_HF_EEPROM_FAIL                          = 97,    // 97     HF_EEPROM执行失败                      EEPROM适配器功能执行失败

    ETI_CLICK_HF_48V_MHEV_TEST_EV               = 98,     //98     HF_48VMHEVtestEV                       48V轻混部件功能使用率
    ETI_HF_48VMHEV_TEST_EV_FAIL                 = 99,     //99     HF_48VMHEVtestEV执行失败               48V轻混部件功能执行失败
    ETI_CLICK_HF_DYNAMIC_ADAS_CALIBRATION       = 100,    //100    HF_DynamicADAScalibration              动态ADAS校准功能使用率
    ETI_HF_DYNAMIC_ADAS_CALIBRATION_FAIL        = 101,    //101    HF_DynamicADAScalibration执行失败      动态ADAS校准功能执行失败
    ETI_CLICK_HF_AFTER_TREATMENT                = 102,    //102    HF_Aftertreatment                      尾气后处理GPF功能使用率
    ETI_HF_AFTER_TREATMENT_FAIL                 = 103,    //103    HF_Aftertreatment执行失败              尾气后处理GPF功能执行失败
    ETI_CLICK_HF_CAMSHAFT_LEARNING              = 104,    //104    HF_Camshaftlearning                    凸轮轴学习功能使用率
    ETI_HF_CAMSHAFT_LEARNING_FAIL               = 105,    //105    HF_Camshaftlearning执行失败            凸轮轴学习功能执行失败
    ETI_CLICK_HF_COMPRESSOR_TEST_EV             = 106,    //106    HF_CompressortestEV                    压缩机测试功能使用率
    ETI_HF_COMPRESSOR_TEST_EV_FAIL              = 107,    //107    HF_CompressortestEV执行失败            压缩机测试功能执行失败
    ETI_CLICK_HF_DCDC_TEST_EV                   = 108,    //108    HF_DCDCtestEV                          直流转换器(DCDC)功能使用率
    ETI_HF_DCDC_TEST_EV_FAIL                    = 109,    //109    HF_DCDCtestEV执行失败                  直流转换器(DCDC)功能执行失败
    ETI_CLICK_HF_ECU_RESET                      = 110,    //110    HF_ECUreset                            控制单元复位功能使用率
    ETI_HF_ECU_RESET_FAIL                       = 111,    //111    HF_ECUreset执行失败                    控制单元复位功能执行失败
    ETI_CLICK_HF_FRM_RESET                      = 112,    //112    HF_FRMreset                            FRM复位功能使用率
    ETI_HF_FRM_RESET_FAIL                       = 113,    //113    HF_FRMreset执行失败                    FRM复位功能执行失败
    ETI_CLICK_HF_HV_POWER_OUTAGE                = 114,    //114    HF_HVpoweroutage                       高压断电/启用功能使用率
    ETI_HF_HV_POWER_OUTAGE_FAIL                 = 115,    //115    HF_HVpoweroutage执行失败               高压断电/启用功能执行失败
    ETI_CLICK_HF_MOTOR_ANGLE_CALIBRATION        = 116,    //116    HF_Motoranglecalibration               电机角位置传感器标定功能使用率
    ETI_HF_MOTOR_ANGLE_CALIBRATION_FAIL         = 117,    //117    HF_Motoranglecalibration执行失败       电机角位置传感器标定功能执行失败
    ETI_CLICK_HF_OBC_TEST_EV                    = 118,    //118    HF_OBCtestEV                           车载充电机(OBC)功能使用率
    ETI_HF_OBC_TEST_EV_FAIL                     = 119,    //119    HF_OBCtestEV执行失败                   车载充电机(OBC)功能执行失败
    ETI_CLICK_HF_PERSONALIZATION_SETTING        = 120,    //120    HF_Personalizationsettin               个性化设置功能使用率
    ETI_HF_PERSONALIZATION_SETTING_FAIL         = 121,    //121    HF_Personalizationsettin执行失败       个性化设置功能执行失败
    ETI_CLICK_HF_RELATIVE_COMPRESSION           = 122,    //122    HF_Relativecompression                 相对压缩功能使用率
    ETI_HF_RELATIVE_COMPRESSION_FAIL            = 123,    //123    HF_Relativecompression执行失败         相对压缩功能执行失败
    ETI_CLICK_HF_RESOLVER_SENSOR_CALIBRATION    = 124,    //124    HF_Resolversensorcalibration           旋变传感器标定功能使用率
    ETI_HF_RESOLVER_SENSOR_CALIBRATION_FAIL     = 125,    //125    HF_Resolversensorcalibration执行失败   旋变传感器标定功能执行失败
    ETI_CLICK_HF_SPEED_PTO                      = 126,    //126    HF_SpeedPTO                            速度与功率功能使用率
    ETI_HF_SPEED_PTO_FAIL                       = 127,    //127    HF_SpeedPTO执行失败                    速度与功率功能执行失败
    ETI_CLICK_HF_COOLANT_REPLACEMENT            = 128,    //128    HF_Coolantreplacement                  冷却液/制冷剂更换功能使用率
    ETI_HF_COOLANT_REPLACEMENT_FAIL             = 129,    //129    HF_Coolantreplacement执行失败          冷却液/制冷剂更换功能执行失败
    
    ETI_CLICK_HF_IDLE_ADJUSTMENT                = 130,    //130    HF_IdleAdjustment                      怠速调整功能使用率
    ETI_HF_IDLE_ADJUSTMENT_FAIL                 = 131,    //131    HF_IdleAdjustment执行失败              怠速调整功能执行失败
    ETI_CLICK_HF_CO_ADJUSTMENT                  = 132,    //132    HF_COAdjustment                        一氧化碳调整功能使用率
    ETI_HF_CO_ADJUSTMENT_FAIL                   = 133,    //133    HF_COAdjustment执行失败                一氧化碳调整功能执行失败
    ETI_CLICK_HF_ECU_FLASHING                   = 134,    //134    HF_ECUFlashing                         模块刷写功能使用率
    ETI_HF_ECU_FLASHING_FAIL                    = 135,    //135    HF_ECUFlashing执行失败                 模块刷写功能执行失败
};



///////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------------------------
说    明：ArtiGlobal 用于设置埋点事件，适用于全局类的接口SetEventTracking形参 vctPara

          uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);
-------------------------------------------------------------------------------------------------*/
// 埋点所需信息参数的类型定义
enum eTrackingInfoType
{
    TIT_VIN = 0,               //  表示类型为车辆车架号
    TIT_MAKE = 1,              //  表示类型为车辆品牌
    TIT_MODEL = 2,             //  表示类型为车型
    TIT_YEAR = 3,              //  表示类型为车辆年份
    TIT_VEH_INFORMATION = 4,   //  表示类型为车辆信息，例如，宝马/3'/320Li_B48/F35/
    TIT_SYS_NAME = 5,          //  表示类型为系统名称，例如，RCM-安全保护控制系统
    TIT_ENGINE_INFO = 6,       //  表示类型为发动机信息，例如，"F62-D52"
    TIT_ENGINE_SUB_TYPE = 7,   //  表示类型为发动机子型号或者其它信息，例如，"N542"
    TIT_DTC_CODE = 8,          //  表示类型为故障码编码，例如，"P1145"
    TIT_FUNC_INFOR = 9,        //  表示类型为功能名，例如，"Oil Reset"
    TIT_DS_INFOR = 10,         //  表示类型为数据流信息，例如，"0x00002661"或者""0x00002661$0x00002662""
    TIT_ENTER_SYS_TIME = 11,   //  表示类型为进系统耗时，单位为秒，例如，"3.216"表示3.216秒
};


///////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------------------------------------------------------------------
说    明：ArtiGlobal 用于设置埋点事件，适用于全局类的接口SetEventTracking形参 vctPara

          uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara);
-------------------------------------------------------------------------------------------------*/
// 埋点所需信息的结构体
struct stTrackingItem
{
    eTrackingInfoType eType;         // 埋点的参数类型
    // 例如 TIT_DTC_CODE，表示strValue 此值是 "故障码编码"

    std::string     strValue;       // 实际埋点参数类型的字符串值
    // 例如当 eType = TIT_DTC_CODE，strValue为 "P1145"
    // 例如当 eType = TIT_VIN，strValue为 "KMHSH81DX9U478798"
};



#endif // __STD_EVENT_TRACKING_MACO_H__
