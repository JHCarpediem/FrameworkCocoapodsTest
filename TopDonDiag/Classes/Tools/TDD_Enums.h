//
//  TDD_Enums.h
//  TDDiag
//
//  Created by lk_ios2023002 on 2023/6/8.
//

#ifndef TDD_Enums_h
#define TDD_Enums_h
typedef enum {
    TDD_SoftType_Diagnostic = 0,            // 诊断软件
    TDD_SoftType_IMMO = 13,                 // 防盗软件
    TDD_SoftType_Moto = 14,                 // 摩托软件
    TDD_SoftType_TDarts = 15,               // T-Darts
} TDD_SoftType;

/*
typedef enum {
    TDD_HLanguageType_en = 0,//英语
    TDD_HLanguageType_ja,    //日语
    TDD_HLanguageType_ru,    //俄语
    TDD_HLanguageType_de,    //德语
    TDD_HLanguageType_pt,    //葡萄牙语
    TDD_HLanguageType_es,    //西班牙语
    TDD_HLanguageType_fr,    //法语
    TDD_HLanguageType_zh,    //简体中文
    TDD_HLanguageType_zh_HK, //繁体中文
    TDD_HLanguageType_it,    //意大利语
    TDD_HLanguageType_pl,     //波兰语
    TDD_HLanguageType_ko,      // 韩语
    TDD_HLanguageType_cz,    //捷克语
    TDD_HLanguageType_uk,    //乌克兰语
    TDD_HLanguageType_nl,    //荷兰语
    TDD_HLanguageType_tr,    //土耳其语
    TDD_HLanguageType_da,    //丹麦
    TDD_HLanguageType_nb,    //挪威语
    TDD_HLanguageType_sv,    //瑞典语
    TDD_HLanguageType_ar,    //阿拉伯语
    TDD_HLanguageType_sk,    //斯洛伐克语
    TDD_HLanguageType_fi,    //芬兰语
    TDD_HLanguageType_sr,    //塞尔维亚语
    TDD_HLanguageType_hr,    //克罗地亚语
    TDD_HLanguageType_bg,    //保加利亚
    TDD_HLanguageType_se,   // 瑞典语
} TDD_HLanguageType;
*/

typedef enum
{   //当前诊断的入口类型
    TDD_DiagShowType_DIAG                 = 0,           // 诊断类型
    TDD_DiagShowType_IMMO                 = 13,           // 防盗类型
    TDD_DiagShowType_MOTO                 = 14,           // 摩托类型
    TDD_DiagShowType_TDarts               = 15,            // TDarts类型
    TDD_DiagShowType_Maintain             = 1001,        // 汽车保养进车
    TDD_DiagShowType_Maintain_MOTO        = 1002,        // 摩托保养进车
    TDD_DiagShowType_IMMO_MOTO            = 1013,        // 摩托防盗进车
    TDD_DiagShowType_ADAS                 = 1014,        // ADAS 进车
}TDD_DiagShowType;

typedef enum
{   //当前诊断导航栏类型
    TDD_DiagNavType_DIAG                 = 0,           // 诊断类型
    TDD_DiagNavType_IMMO                 = 13,           // 防盗类型
    TDD_DiagNavType_MOTO                 = 14,           // 摩托类型
    TDD_DiagNavType_TDarts               = 15,            // TDarts类型
}TDD_DiagNavType;


typedef enum
{   //当前诊断的二级入口类型
    TDD_DiagShowSecondaryType_NONE                 = 0,           // 无
    TDD_DiagShowSecondaryType_OIL,         // 机油归零，点击保养"Oil Reset"下的车标进入的车型
    TDD_DiagShowSecondaryType_THROTTLE,// 节气门匹配，点击保养"Throttle Adaptation"下的车标进入的车型
    TDD_DiagShowSecondaryType_EPB,// EPB复位，点击保养"EPB Reset"下的车标进入的车型
    TDD_DiagShowSecondaryType_ABS,// 点击保养"ABS Bleeding"下的车标进入的车型
    TDD_DiagShowSecondaryType_STEERING,// 转向角复位，点击保养"Steering Angle Reset"下的车标进入的车型
    TDD_DiagShowSecondaryType_DPF,// DPF再生，点击保养"DPF Regeneration"下的车标进入的车型
    TDD_DiagShowSecondaryType_AIRBAG,// 点击保养"Airbag Reset"下的车标进入的车型
    TDD_DiagShowSecondaryType_BMS,// 点击保养"BMS Reset"下的车标进入的车型
    TDD_DiagShowSecondaryType_INJECTOR,// 喷油嘴编码
    TDD_DiagShowSecondaryType_TPMS,// 胎压复位
    TDD_DiagShowSecondaryType_SUNROOF,// 天窗初始化
    TDD_DiagShowSecondaryType_SEAT,// 座椅标定
    TDD_DiagShowSecondaryType_WINDOW,// 门窗标定
    TDD_DiagShowSecondaryType_SUSPENSION,   // 悬挂匹配
    TDD_DiagShowSecondaryType_ADBLUE,   // 尿素复位
    TDD_DiagShowSecondaryType_A_F,  // A/F 调校
    TDD_DiagShowSecondaryType_NOX,  // NOx 复位
    TDD_DiagShowSecondaryType_STOP_START,   // 启停设置
    TDD_DiagShowSecondaryType_AFS,  // 大灯匹配
    TDD_DiagShowSecondaryType_GEAR, // 齿讯学习
    TDD_DiagShowSecondaryType_LANGUAGE, // 语言设置
    TDD_DiagShowSecondaryType_TRANSPORT,    // 运输模式解除
    TDD_DiagShowSecondaryType_AFTERTREATMENT,   // 尾气后处理
    TDD_DiagShowSecondaryType_GEARBOX,  // 变速箱匹配
    TDD_DiagShowSecondaryType_EGR,  // EGR自学习
    TDD_DiagShowSecondaryType_IMMO, // 防盗匹配
    TDD_DiagShowSecondaryType_COOLANT,  // 电子水泵激活
    TDD_DiagShowSecondaryType_TIRE, // 轮胎改装
    TDD_DiagShowSecondaryType_POWER_BALANCE,    // 气缸平衡测试
    TDD_DiagShowSecondaryType_VGT,  // 涡轮增加匹配
    TDD_DiagShowSecondaryType_IMMO_PASSWORD,    // 密码读取
    TDD_DiagShowSecondaryType_ODO,   // 里程表
    TDD_DiagShowSecondaryType_SMART_KEY, // 智能钥匙匹配
    TDD_DiagShowSecondaryType_ADAS,     // ADAS 校准
    TDD_DiagShowSecondaryType_DYNAMIC_ADAS, // 动态ADAS校准
    TDD_DiagShowSecondaryType_EEPROM,      // EEPROM适配器
    TDD_DiagShowSecondaryType_RFID,    // RFID
    TDD_DiagShowSecondaryType_SPEC_FUNC,       // 特殊功能
    TDD_DiagShowSecondaryType_CLUTCH,      // 离合器匹配
    TDD_DiagShowSecondaryType_SPEED_PTO,       // 速度与功率
    TDD_DiagShowSecondaryType_FRM_RESET,       // FRM复位
    TDD_DiagShowSecondaryType_VIN,     // VIN（写）
    TDD_DiagShowSecondaryType_HV_BATTERY,      // 高压电池
    TDD_DiagShowSecondaryType_ACC,     // 巡航校准
    TDD_DiagShowSecondaryType_AC_LEARNING,     // 空调学习
    TDD_DiagShowSecondaryType_RAIN_LIGHT_SENSOR,       // 雨水/光传感器
    TDD_DiagShowSecondaryType_RESET_CONTROL_UNIT,      // 控制单元复位
    TDD_DiagShowSecondaryType_CSS_ACC,     // 定速/自适应巡航
    TDD_DiagShowSecondaryType_RELATIVE_COMPRESSION,        // 相对压缩
    TDD_DiagShowSecondaryType_HV_DE_ENERGIZATION,      // 高压断电/启用
    TDD_DiagShowSecondaryType_COOLANT_REFRIGERANT_CHANGE,      // 冷却液/制冷剂更换
    TDD_DiagShowSecondaryType_RESOLVER_SENSOR_CALIBRATION,     // 旋变传感器标定
    TDD_DiagShowSecondaryType_CAMSHAFT_LEARNING,       // 凸轮轴学习
    TDD_DiagShowSecondaryType_CUSTOMIZE,        // 个性化设置（刷隐藏）
    TDD_DiagShowSecondaryType_MOTOR_ANGLE,      // 电机角位置传感器标定
    TDD_DiagShowSecondaryType_EV_COMPRESSION,       // 压缩机测试
    TDD_DiagShowSecondaryType_EV_OBC,       // 车载充电机
    TDD_DiagShowSecondaryType_EV_DCDC,      // 直流转换器（DCDC）
    TDD_DiagShowSecondaryType_EV_48V,       // 48V轻混部件
    TDD_DiagShowSecondaryType_ODO_CHECK,        // 多里程
    TDD_DiagShowSecondaryType_IDLE_ADJ,     // 怠速调整
    TDD_DiagShowSecondaryType_CO_ADJ,       // 一氧化碳调整
    TDD_DiagShowSecondaryType_ECU_FLASH,        // 模块刷写
    TDD_DiagShowSecondaryType_SOFT_EXPIRATION,      // 软件过期
    
}TDD_DiagShowSecondaryType;

typedef enum
{// artiModel代理事件
    TDD_ArtiModelEventType_Unknow               = 0,
    TDD_ArtiModelEventType_SetRepairManual,                     // 设置维修指南所需要的信息
    TDD_ArtiModelEventType_UploadDiagReport,                    // 上传诊断报告
    TDD_ArtiModelEventType_AuthLogin,                           // FCA认证
    TDD_ArtiModelEventType_AuthGateway,                         // FCA平台ECU数据上报
    TDD_ArtiModelEventType_LoadTroubleCodeList,                 // 根据故障码获取维修指引(列表)
    TDD_ArtiModelEventType_RefreshToken,                        // 刷新 Token
    TDD_ArtiModelEventType_GetOEM,                              // 获取OEM
    TDD_ArtiModelEventType_TrackResponse,                       // 结果追踪
    TDD_ArtiModelEventType_UploadHistoryDiagReport,            // 历史诊断报告上传
    TDD_ArtiModelEventType_UploadShareReport,                  // 分享
    TDD_ArtiModelEventType_GoToScan,                           // 识别文字
    TDD_ArtiModelEventType_QuerySGW,                           // 获取网关权益
    TDD_ArtiModelEventType_UploadUnlockReport,                 // 上传网关解锁报告(例如:SFD)
    TDD_ArtiModelEventType_QueryExpire,                        // 查询软件有效期
    TDD_ArtiModelEventType_IotRequest,                        // 车型调用 iot 接口
    TDD_ArtiModelEventType_GetTwoFactorAuthToken,               // 获取二次验证 token(返回 token 或空字符串给诊断库)
    TDD_ArtiModelEventType_OpenTwoFactorAuthToken,               // 开启二次验证
    TDD_ArtiModelEventType_LoadAITroubleCodeInfo,                 //获取 AI 故障码
    TDD_ArtiModelEventType_ShowSFDUserInfo,                 //显示 SFD 信息页面
}TDD_ArtiModelEventType;

typedef enum
{// 其他代理事件
    TDD_DiagOtherEventType_ToBLEConnect      = 0,           // 跳转蓝牙连接
    TDD_DiagOtherEventType_FeedBackChoose = 1,              // 反馈选择原因
    TDD_DiagOtherEventType_GotoWechatService = 2,           // 跳转微信客服
    TDD_DiagOtherEventType_GotoTroubleDetail = 3,           // 跳转故障码详情
    TDD_DiagOtherEventType_GotoLoginView = 4,               // 跳转登录
    TDD_DiagOtherEventType_GotoHelp = 5,                    // 跳转帮助详情
    TDD_DiagOtherEventType_GotoShop ,                       // 跳转商城首页
    TDD_DiagOtherEventType_GotoWeb ,                        // 跳转webView
    TDD_DiagOtherEventType_GotoAI ,                         // 跳转AI
}TDD_DiagOtherEventType;

typedef enum {
    TDD_DiagViewColorType_Red = 0, //红色 (TopScan 3.40.0 新版)
    TDD_DiagViewColorType_Orange,//橙色 (keyNow)
    TDD_DiagViewColorType_Blue,//蓝色 (TopScan 旧版)
    TDD_DiagViewColorType_GradientBlack, // 渐变黑 (TOPVCI)
    TDD_DiagViewColorType_Black, // 黑色 (Carpal)
}TDD_DiagViewColorType;

typedef enum {
    TDD_NetworkStatusReachable_Not = 0,
    TDD_NetworkStatusReachable_WiFi,
    TDD_NetworkStatusReachable_WWAN
} TDD_NetworkStatus;

typedef enum {
    TDD_CustomLoadingType_Unknow = 0,
    TDD_CustomLoadingType_AutoVin,      //autoVin
    TDD_CustomLoadingType_OBDLiveData,  //OBD数据流(TopVCI 实时数据)
    TDD_CustomLoadingType_ScanSystem    //系统扫描(TopVCI 打分)
} TDD_CustomLoadingType;

// 故障码状态
typedef enum {
    TDD_DF_DTC_STATUS_CURRENT =              (1 << 0),       // µ±«∞π ’œ¬Î    Current
    TDD_DF_DTC_STATUS_HISTORY =              (1 << 1),       // ¿˙ ∑π ’œ¬Î    History
    TDD_DF_DTC_STATUS_PENDING =              (1 << 2),       // ¥˝∂®π ’œ¬Î    Pending
    TDD_DF_DTC_STATUS_TEMP =                 (1 << 3),       // ¡Ÿ ±π ’œ¬Î    Temporary
    TDD_DF_DTC_STATUS_NA =                   (1 << 4),       // Œ¥÷™π ’œ¬Î    N/A
    TDD_DF_DTC_STATUS_OTHERS =               (0xFFFFFFFF)   // Œﬁ∑®πÈ¿‡µΩ“‘…œ√∂æŸ∑÷¿‡£¨÷±Ω”∞¥strStatusœ‘ æ
}TDD_DTC_STATUS;


typedef enum {
    TDD_SoftWare_TOPSCAN = 0,
    TDD_SoftWare_TOPVCI,
    TDD_SoftWare_TOPVCI_PRO,
    TDD_SoftWare_CARPAL,
    TDD_SoftWare_CARPAL_GURU,
    TDD_SoftWare_KEYNOW,
    TDD_SoftWare_TOPSCAN_HD,
    TDD_SoftWare_TOPSCAN_VAG,
    TDD_SoftWare_DEEPSCAN,
    TDD_SoftWare_TOPSCAN_BMW,
    TDD_SoftWare_TOPSCAN_FORD,
}TDD_SoftWare;

typedef enum
{
    TDD_DATA_BASE_TYPE_DEFAULT     = 0, // 本地数据库
    TDD_DATA_BASE_TYPE_GROUP       = 1, // 群组数据库
}TDD_DBType;

typedef NS_OPTIONS(NSUInteger, TDDSoftware) {
    TDDSoftwareTopScan          = 1 << 0, // 1
    TDDSoftwareTopVci           = 1 << 1, // 2
    TDDSoftwareTopVciPro        = 1 << 2, // 4
    TDDSoftwareCarPal           = 1 << 3, // 8
    TDDSoftwareCarPalGuru       = 1 << 4, // 16
    TDDSoftwareKeyNow           = 1 << 5, // 32
    TDDSoftwareTopScanHD        = 1 << 6, // 64
    TDDSoftwareTopScanVAG       = 1 << 7,
    TDDSoftwareDeepScan         = 1 << 8,
    TDDSoftwareTopScanBMW       = 1 << 9,
    TDDSoftwareTopScanFORD      = 1 << 10,
};

//定制化设备
typedef enum {
    TDD_Customized_None = 0,
    TDD_Customized_Germany
}TDD_Customized_Type;

// 功能掩码从64位扩展为128位
// GetDiagEntryTypeEx获取功能掩码值数组
//
//
// 用于接口GetDiagEntryTypeEx的返回值下标
typedef enum
{   //当前诊断功能掩码下标

    DETE_BASE_VER_POS        = 0,       // 下标取值后对应(1 << 0), 对应原宏名，DET_BASE_VER，   表示支持基本功能_读版本信息
    DETE_BASE_RDTC_POS       = 1,       // 下标取值后对应(1 << 1), 对应原宏名，DET_BASE_RDTC，  表示支持基本功能_读故障码
    DETE_BASE_CDTC_POS       = 2,       // 下标取值后对应(1 << 2), 对应原宏名，DET_BASE_CDTC，  表示支持基本功能_清故障码
    DETE_BASE_RDS_POS        = 3,       // 下标取值后对应(1 << 3), 对应原宏名，DET_BASE_RDS，   表示支持基本功能_读数据流
    DETE_BASE_ACT_POS        = 4,       // 下标取值后对应(1 << 4), 对应原宏名，DET_BASE_ACT，   表示支持动作测试
    DETE_BASE_FFRAME_POS     = 5,       // 下标取值后对应(1 << 5), 对应原宏名，DET_BASE_FFRAME，表示支持冻结帧


    DETE_OIL_RESET_POS            = 6,  // 对应下标的数组值，(1 << 6), DET_MT_OIL_RESET，     机油归零功能掩码，"Oil Reset"
    DETE_THROTTLE_ADAPTATION_POS  = 7,  // (1 << 7),        DET_MT_THROTTLE_ADAPTATION，      节气门匹配，"Throttle Adaptation"
    DETE_EPB_RESET_POS            = 8,  // (1 << 8),        DET_MT_EPB_RESET，                刹车片更换，"EPB Reset or Brake Reset"
    DETE_ABS_BLEEDING_POS         = 9,  // (1 << 9),        DEF_MT_ABS_BLEEDING，             "ABS Bleeding"
    DEFE_STEERING_ANGLE_RESET_POS = 10,  // (1 << 10),      DEF_MT_STEERING_ANGLE_RESET       转向角复位，"Steering Angle Reset"


    DEFE_DPF_REGENERATION_POS     = 11,  // (1 << 11),      DEF_MT_DPF_REGENERATION           DPF再生，"DPF Regeneration"
    DEFE_AIRBAG_RESET_POS         = 12,  // (1 << 12),      DEF_MT_AIRBAG_RESET               "Airbag Reset"
    DEFE_BMS_RESET_POS            = 13,  // (1 << 13),      DEF_MT_BMS_RESET                  "BMS Reset"
    DEFE_ADAS_POS                 = 14,  // (1 << 14),      DEF_MT_ADAS ADAS                  校准
    DEFE_IMMO_POS                 = 15,  // (1 << 15),      DEF_MT_IMMO IMMO                  防盗匹配


    DEFE_SMART_KEY_POS            = 16,  // (1 << 16),      DEF_MT_SMART_KEY                  智能钥匙匹配 SmartKey
    DEFE_PASSWORD_READING_POS     = 17,  // (1 << 17),      DEF_MT_PASSWORD_READING           密码读取 PasswordReading
    DEFE_DYNAMIC_ADAS_POS         = 18,  // (1 << 18),      DEF_MT_DYNAMIC_ADAS               动态ADAS校准
    DEFE_INJECTOR_CODE_POS        = 19,  // (1 << 19),      DEF_MT_INJECTOR_CODE              喷油嘴编码 InjectorCode
    DEFE_SUSPENSION_POS           = 20,  // (1 << 20),      DEF_MT_SUSPENSION                 悬挂匹配 Suspension


    DEFE_TIRE_PRESSURE_POS        = 21,  // (1 << 21),      DEF_MT_TIRE_PRESSURE              胎压复位 TirePressure
    DEFE_TRANSMISSION_POS         = 22,  // (1 << 22),      DEF_MT_TRANSMISSION               变速箱匹配 Gearbox matching, Transmission
    DEFE_GEARBOX_LEARNING_POS     = 23,  // (1 << 23),      DEF_MT_GEARBOX_LEARNING           齿讯学习 Gear Learn, GearboxLearning
    DEFE_TRANSPORT_MODE_POS       = 24,  // (1 << 24),      DEF_MT_TRANSPORT_MODE             运输模式解除, TransportMode
    DEFE_HEAD_LIGHT_POS           = 25,  // (1 << 25),      DEF_MT_HEAD_LIGHT                 大灯匹配 AFS Reset, Headlight or AFS Reset


    DEFE_SUNROOF_INIT_POS         = 26,  // (1 << 26),      DEF_MT_SUNROOF_INIT               天窗初始化 SunroofInit
    DEFE_SEAT_CALI_POS            = 27,  // (1 << 27),      DEF_MT_SEAT_CALI                  座椅标定 SeatCali
    DEFE_WINDOW_CALI_POS          = 28,  // (1 << 28),      DEF_MT_WINDOW_CALI                门窗标定 WindowCali
    DEFE_START_STOP_POS           = 29,  // (1 << 29),      DEF_MT_START_STOP                 启停设置 StartStop
    DEFE_EGR_POS                  = 30,  // (1 << 30),      DEF_MT_EGR                        EGR自学习, 废气再循环 （ Exhaust Gas Recirculation）


    DEFE_ODOMETER_POS                    = 31,  // 0x80000000,               DEF_MT_ODOMETER                    里程表调校,              1 << 31   Odometer
    DEFE_LANGUAGE_POS                    = 32,  // 0x100000000,              DEF_MT_LANGUAGE                    语言设置,                1 << 32   Language
    DEFE_TIRE_MODIFIED_POS               = 33,  // 0x200000000,              DEF_MT_TIRE_MODIFIED               轮胎改装,                1 << 33   Tire
    DEFE_A_F_ADJ_POS                     = 34,  // 0x400000000,              DEF_MT_A_F_ADJ A/F                 调校,                    1 << 34   A_F_Adj
    DEFE_ELECTRONIC_PUMP_POS             = 35,  // 0x800000000,              DEF_MT_ELECTRONIC_PUMP             电子水泵激活,            1 << 35   Coolant Bleed,ElectronicPump


    DEFE_NOx_RESET_POS                   = 36,  // 0x1000000000,             DEF_MT_NOx_RESET                   氮氧排放复位,            1 << 36   NoxReset
    DEFE_UREA_RESET_POS                  = 37,  // 0x2000000000,             DEF_MT_UREA_RESET                  尿素复位,                1 << 37   UreaReset or  AdBlue Reset
    DEFE_TURBINE_LEARNING_POS            = 38,  // 0x4000000000,             DEF_MT_TURBINE_LEARNING            涡轮叶片学习,            1 << 38   TurbineLearning
    DEFE_CYLINDER_POS                    = 39,  // 0x8000000000,             DEF_MT_CYLINDER                    气缸平衡测试,            1 << 39   Cylinder
    DEFE_EEPROM_POS                      = 40,  // 0x10000000000,            DEF_MT_EEPROM                      EEPROM适配器,            1 << 40   EEPROM


    DEFE_EXHAUST_PROCESSING_POS          = 41,  // 0x20000000000,            DEF_MT_EXHAUST_PROCESSING          尾气后处理,              1 << 41   ExhaustProcessing
    DEFE_RFID_POS                        = 42,  // 0x40000000000,            DEF_MT_RFID                        RFID,                    1 << 42   RFID
    DETE_SPEC_FUNC_POS                   = 43,  // 0x80000000000,            DET_MT_SPEC_FUNC                   特殊功能,                1 << 43
    DEFE_CLUTCH_POS                      = 44,  // 0x100000000000,           DEF_MT_CLUTCH                      离合器匹配,              1 << 44   Clutch
    DEFE_SPEED_PTO_POS                   = 45,  // 0x200000000000,           DEF_MT_SPEED_PTO                   速度与功率,              1 << 45   Speed & PTO


    DEFE_FRM_RESET_POS                   = 46,  // 0x400000000000,           DEF_MT_FRM_RESET                   FRM复位,                 1 << 46    FRM_RESET
    DEFE_VIN_POS                         = 47,  // 0x800000000000,           DEF_MT_VIN                         VIN（写）,               1 << 47    VIN
    DEFE_HV_BATTERY_POS                  = 48,  // 0x1000000000000,          DEF_MT_HV_BATTERY                  高压电池,                1 << 48    HV Battery
    DEFE_ACC_POS                         = 49,  // 0x2000000000000,          DEF_MT_ACC                         巡航校准,                1 << 49    ACC
    DEFE_AC_LEARNING_POS                 = 50,  // 0x4000000000000,          DEF_MT_AC_LEARNING                 空调学习,                1 << 50    A/C


    DEFE_RAIN_LIGHT_SENSOR_POS           = 51,  // 0x8000000000000,          DEF_MT_RAIN_LIGHT_SENSOR           雨水/光传感器,           1 << 51    Rain/Light Sensor
    DEFE_RESET_CONTROL_UNIT_POS          = 52,  // 0x10000000000000,         DEF_MT_RESET_CONTROL_UNIT          控制单元复位,            1 << 52    Reset control unit
    DEFE_CSS_ACC_POS                     = 53,  // 0x20000000000000,         DEF_MT_CSS_ACC                     定速/自适应巡航 ,        1 << 53    CCS/ACC
    DEFE_RELATIVE_COMPRESSION_POS        = 54,  // 0x40000000000000,         DEF_MT_RELATIVE_COMPRESSION        相对压缩 ,               1 << 54    Relative Compression
    DEFE_HV_DE_ENERGIZATION_POS          = 55,  // 0x80000000000000,         DEF_MT_HV_DE_ENERGIZATION          高压断电/启用,           1 << 55    HV De-energization/Energization


    DEFE_COOLANT_REFRIGERANT_CHANGE_POS  = 56,  // 0x100000000000000,        DEF_MT_COOLANT_REFRIGERANT_CHANGE  冷却液/制冷剂更换,       1 << 56    Coolant/Refrigerant Change
    DEFE_RESOLVER_SENSOR_CALIBRATION_POS = 57,  // 0x200000000000000,        DEF_MT_RESOLVER_SENSOR_CALIBRATION 旋变传感器标定 ,         1 << 57    Resolver Sensor Calibration
    DEFE_CAMSHAFT_LEARNING_POS           = 58,  // 0x400000000000000,        DEF_MT_CAMSHAFT_LEARNING           凸轮轴学习 ,             1 << 58    Camshaft learning
    // 0x800000000000000,        DEF_MT_RESERVED                    保留                  RESERVED               1 << 59
    // 0x1000 0000 0000 0000     DEF_MT_RESERVED                    保留                  RESERVED               1 << 60

    DEFE_MT_CUSTOMIZE_POS                = 61,  // 0x2000 0000 0000 0000,    DEF_MT_CUSTOMIZE                   个性化设置（刷隐藏）     1 << 61    Personalization Setting
    DEFE_MT_MOTOR_ANGLE_POS              = 62,  // 0x4000 0000 0000 0000,    DEF_MT_MOTOR_ANGLE                 电机角位置传感器标定     1 << 62    Motor Angle Calibration
    DEFE_MT_EV_COMPRESSION_POS           = 63,  // 0x8000 0000 0000 0000,    DEF_MT_EV_COMPRESSION              压缩机测试,              1 << 63    Compressor Test(EV)
    DEFE_MT_EV_OBC_POS                   = 64,  // 0x1 0000 0000 0000 0000,  DEF_MT_EV_OBC                      车载充电机,              1 << 64    OBC Test(EV)
    DEFE_MT_EV_DCDC_POS                  = 65,  // 0x2 0000 0000 0000 0000,  DEF_MT_EV_DCDC                     直流转换器（DCDC）,      1 << 65    DCDC Test(EV)


    DEFE_MT_EV_48V_POS                   = 66,  // 0x4 0000 0000 0000 0000,  DEF_MT_EV_48V                      48V轻混部件,             1 << 66    48V MHEV Test(EV)
    DEFE_MT_ODO_CHECK_POS                = 67,  // 0x8  0000 0000 0000 0000, DEF_MT_ODO_CHECK_POS               多里程                ODO_CHECK              1 << 67    ODO CHECK
    DEFE_MT_IDLE_ADJ_POS                 = 68,   // 0x10 0000 0000 0000 0000, DEF_MT_IDLE_ADJ                    怠速调整                 1 << 68    Idle Adjustment
    DEFE_MT_CO_ADJ_POS                   = 69,   // 0x20 0000 0000 0000 0000, DEF_MT_CO_ADJ                      一氧化碳调整             1 << 69    CO Adjustment
    DEFE_MT_ECU_FLASH_POS                = 70,   // 0x40 0000 0000 0000 0000, DEF_MT_ECU_FLASH                   模块刷写                 1 << 70    ECU Flashing
    DEFE_MT_SOFT_EXPIRATION_POS          = 71,  // 0x80 0000 0000 0000 0000, DEF_MT_SOFT_EXPIRATION             软件过期              SOFT_EXPIRE            1 << 71    Software Expiration
}eDiagEntryTypeEx;

typedef enum
{   //埋点类型
    TDD_EventType_APP                 = 0,           //  app 埋点
    TDD_EventType_Car                          // 车型埋点
}TDD_EventType;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于artiShowSpecial接口，形参uType，指定UI消息类型
          绘制特殊UI，例如FCA登录界面
----------------------------------------------------------------------------------*/
typedef enum
{
    SST_FUNC_FCA_AUTH     = 0, // FCA认证登录界面
    SST_FUNC_RENAULT_AUTH = 1, // 雷诺认证登录界面，Renault
    SST_FUNC_NISSAN_AUTH  = 2, // 日产认证登录界面，Nissan
    SST_FUNC_VW_SFD_AUTH  = 3, //大众网关解锁(VW SFD)登录界面
    SST_FUNC_DEMO_AUTH    = 0xFFFFFFF0,   //DEMO演示使用的登录界面
}eSpecialShowType;
#endif /* TDD_Enums_h */
