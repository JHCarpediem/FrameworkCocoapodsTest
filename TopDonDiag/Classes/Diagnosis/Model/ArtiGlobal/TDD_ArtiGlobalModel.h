//
//  TDD_ArtiGlobalModel.h
//  AD200
//
//  Created by 何可人 on 2022/6/7.
//

#import "TDD_ArtiModelBase.h"

#import "TDD_HistoryDiagModel.h"
#import "TDD_Enums.h"
#import "TDD_VehInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

//@class CAlgorithmData;

// 用于接口GetHostType的返回值
typedef enum
{   //APP的宿主机类型
    HT_IS_TABLET    = 1,        //表示当前应用的主机是平板
    HT_IS_PHONE     = 2,        //表示当前应用的主机是手机
    HT_IS_PC        = 3,        //表示当前应用的主机是PC

    HT_IS_INVALID   = 0xFFFFFFFF,
}eHostType;


// 用于接口GetAppProductName的返回值
typedef enum
{   //当前app应用的产品名称
    PD_NAME_AD900   = 1,          // "AD900",     表示当前产品名为AD900
    PD_NAME_AD200   = 2,          // "AD200",     表示当前产品名为AD200
    PD_NAME_TOPKEY  = 3,          // "TOPKEY",    表示当前产品名为TOPKEY

    PD_NAME_NINJA1000PRO = 4,     // "NINJA1000PRO", 表示当前产品名为Ninja1000 Pro
    PD_NAME_AD900_LITE   = 5,     // "AD900 LITE"
    PD_NAME_KEYNOW       = 6,     // "KEYNOW"
    PD_NAME_AD500        = 7,     // "AD500"
    
    PD_NAME_TP005_TOPVCI = 8,     // "TP005", 表示当前产品名为国内版TOPVCI，"小车探"
    PD_NAME_PG1000_DOI   = 9,     // "PG1000 DOI远程诊断"

    PD_NAME_ADAS_TABLET   = 10,   // "ADAS"
    PD_NAME_TOPVCI_PRO    = 11,   // "TP011", 表示当前产品名为国内版"小车探Pro"
    PD_NAME_TOPSCAN_HD    = 12,   // "TOPSCAN HD", 表示当前产品名为"TOPSCAN HD"
    PD_NAME_TOPVCI_CARPAL = 13,   // "CARPAL", 表示当前产品名为国外版"小车探"，即"CarPal"
    PD_NAME_CARPAL_GURU   = 14,   // "CARPAL GURU", 表示当前产品名为"CarPal Guru"（刷隐藏）
    PD_NAME_AD800BT       = 15,   // "AD800BT", 表示当前产品名为"AD800BT 2"（自研AD800BT2）
    PD_NAME_AD_MOTOR      = 16,   // "ArtiDiag Motor", 表示当前产品名为ArtiDiag Moto（硬件与AD500一致）
    PD_NAME_UL_MOTOR      = 17,   // "UltraDiag Motor", 表示当前产品名为UltraDiag Moto（硬件与AD900一致）
    PD_NAME_DEEPSCAN      = 18,   // "DeepScan"，"中性TopScan", 表示当前产品名为中性的TopScan，NT = neutral
    PD_NAME_TOPSCAN_VAG   = 19,   // "TOPSCAN", "TOPSCAN VAG", 表示当前产品名为针对VW的TOPSCAN，通常情况下，只存在于IOS
    PD_NAME_TOPDON_ONE    = 20,   // "TOPDON ONE", "TOPDON ONE", 表示当前产品名为"TOPDON ONE"（自研10寸平板）
    PD_NAME_DS100         = 21,   // "GOOLOO OBD", "DS100", 表示当前产品名为"GOOLOO OBD"（卡儿酷定制CarPal）
    PD_NAME_DS900         = 22,   // "GOOLOO DS900", "DS900", 表示当前产品名为"GOOLOO DS900"（卡儿酷定制DS900）
       
    PD_NAME_INVALID = 0xFFFFFFFF,
}eProductName;

// 用于接口CAppProduct::Group的返回值
typedef enum
{
    //当前 app 应用组的产品组类别
    PD_GROUP_AD900_LIKE                   = ((1 << 16) & 0xFFFF0000),   // "AD900系列",  表示当前产品组类别为，AD900系列
                                                                        // 例如，AD900、AD900 LITE、GOOLOO DS900、AD800BT2等

    PD_GROUP_TOPSCAN_LIKE                 = ((2 << 16) & 0xFFFF0000),   // "TopScan系列",  表示当前产品组类别为，TopScan系列
                                                                        // 例如，TopScan HD、TopScan VAG、DS200、DeepScan

    PD_GROUP_CARPAL_LIKE                  = ((3 << 16) & 0xFFFF0000),   // "CarPal系列",  表示当前产品组类别为，CarPal系列
                                                                        // 例如，CarPal、CarPal Guru、DS100、小车探等

    PD_GROUP_AD500_LIKE                   = ((4 << 16) & 0xFFFF0000),   // "AD500平板系列",  表示当前产品组类别为，AD500平板系列
                                                                        // 例如，AD500、AD600、AD600S、AD500S、AD500 BMS、等

    PD_GROUP_TOPDON_ONE_LIKE              = ((5 << 16) & 0xFFFF0000),   // "TOPDON ONE平板系列",  表示当前产品组类别为，TOPDON ONE平板系列
                                                                        // 例如，TOPDON ONE屏，10寸，13寸等

    PD_GROUP_INVALID = 0xFFFFFFFF,
}eAppProductGroup;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于获取后台VIN接口返回的类型宏，CArtiGlobal 的接口 GetServerVinInfo
          小车探新增需求
----------------------------------------------------------------------------------*/
enum eGetVinInfoType
{
    GET_VIN_BRAND               = 0,     //  品牌ID值，表示当前获取的是品牌ID值
    GET_VIN_MODEL               = 1,     //  车型ID值
    GET_VIN_MANUFACTURER_NAME   = 2,     //  厂家名称
    GET_VIN_YEAR                = 3,     //  年份
    GET_VIN_CLASSIS             = 4,     //  底盘号
    GET_VIN_MANUFACTURER_TYPE   = 5,     //  厂家类型
    GET_VIN_VEHICLE_TYPE        = 6,     //  车辆类型
    GET_VIN_FULE_TYPE           = 7,     //  燃油类型
    GET_VIN_ENERGY_TYPE         = 8,     //  能源类型
    GET_VIN_COUNTRY             = 9,     //  国家
    GET_VIN_AREA                = 10,    //  区域
};

// 用于接口GetAppScenarios的返回值
typedef enum
{   //当前app应用使用的场景，例如是否是正式面向用户的使用场景
    AS_EXTERNAL_USE = 1,          // 正式面向用户的使用场景，正常用户使用场景
    AS_INTERNAL_USE = 2,          // 打开了对内使用场景的后门

    AS_OTHER_INVALID = 0xFFFFFFFF,
}eAppScenarios;

// 用于接口GetDiagEntryType的返回值
typedef enum
{   //当前诊断的入口类型
    DET_NORMAL_NONE                 = 0,           // 表示当前不支持任何功能

    DET_BASE_VER                    = (1 << 0),    // 表示支持基本功能_读版本信息
    DET_BASE_RDTC                   = (1 << 1),    // 表示支持基本功能_读故障码
    DET_BASE_CDTC                   = (1 << 2),    // 表示支持基本功能_清故障码
    DET_BASE_RDS                    = (1 << 3),    // 表示支持基本功能_读数据流
    DET_BASE_ACT                    = (1 << 4),    // 表示支持动作测试
    DET_BASE_FFRAME                 = (1 << 5),    // 表示支持冻结帧

    // Maintenance 以下表示当前是通过保养下的某项进入的
    /* Oil Reset */
    DET_MT_OIL_RESET            = (1 << 6),  // 机油归零，点击保养"Oil Reset"下的车标进入的车型

    /* Throttle Adaptation */
    DET_MT_THROTTLE_ADAPTATION  = (1 << 7),  // 节气门匹配，点击保养"Throttle Adaptation"下的车标进入的车型

    /* EPB Reset */
    DET_MT_EPB_RESET            = (1 << 8),  // EPB复位，点击保养"EPB Reset"下的车标进入的车型

    /* ABS Bleeding */
    DEF_MT_ABS_BLEEDING         = (1 << 9),  // 点击保养"ABS Bleeding"下的车标进入的车型

    /* Steering Angle Reset */
    DEF_MT_STEERING_ANGLE_RESET = (1 << 10),  // 转向角复位，点击保养"Steering Angle Reset"下的车标进入的车型

    /* DPF Regeneration */
    DEF_MT_DPF_REGENERATION     = (1 << 11),  // DPF再生，点击保养"DPF Regeneration"下的车标进入的车型

    /* Airbag Reset */
    DEF_MT_AIRBAG_RESET         = (1 << 12),  // 点击保养"Airbag Reset"下的车标进入的车型

    /* BMS Reset */
    DEF_MT_BMS_RESET            = (1 << 13),  // 点击保养"BMS Reset"下的车标进入的车型

    /* ADAS               */
    DEF_MT_ADAS                 = (1 << 14),  // ADAS校准

    /* IMMO               */
    DEF_MT_IMMO                 = (1 << 15),  // IMMO防盗匹配

    /* SmartKey           */
    DEF_MT_SMART_KEY            = (1 << 16),  // 智能钥匙匹配

    /* PasswordReading    */
    DEF_MT_PASSWORD_READING     = (1 << 17),  // 密码读取

    /* Dynamic ADAS */
    DEF_MT_DYNAMIC_ADAS         = (1 << 18),  // 动态ADAS校准

    /* InjectorCode       */
    DEF_MT_INJECTOR_CODE        = (1 << 19),  // 喷油嘴编码

    /* Suspension         */
    DEF_MT_SUSPENSION           = (1 << 20),  // 悬挂匹配

    /* TirePressure       */
    DEF_MT_TIRE_PRESSURE        = (1 << 21),  // 胎压复位

    /* Transmission       */
    DEF_MT_TRANSMISSION         = (1 << 22),  // 变速箱匹配

    /* GearboxLearning    */
    DEF_MT_GEARBOX_LEARNING     = (1 << 23),  // 齿讯学习

    /* TransportMode      */
    DEF_MT_TRANSPORT_MODE       = (1 << 24),  // 运输模式解除

    /* Headlight          */
    DEF_MT_HEAD_LIGHT           = (1 << 25),  // 大灯匹配
    

    /* SunroofInit        */
    DEF_MT_SUNROOF_INIT         = (1 << 26),  // 天窗初始化

    /* SeatCali           */
    DEF_MT_SEAT_CALI            = (1 << 27),  // 座椅标定

    /* WindowCali         */
    DEF_MT_WINDOW_CALI          = (1 << 28),  // 门窗标定

    /* StartStop          */
    DEF_MT_START_STOP           = (1 << 29),  // 启停设置

    /* EGR                */
    DEF_MT_EGR                  = (1 << 30),  // ERG自学习

    /* Odometer           */
    DEF_MT_ODOMETER             = 0x80000000,  // 里程表调校, 1 << 31

    /* Language           */
    DEF_MT_LANGUAGE             = 0x100000000,  // 语言设置, 1 << 32

    /* Tire               */
    DEF_MT_TIRE_MODIFIED        = 0x200000000,  // 轮胎改装, 1 << 33

    /* A_F_Adj            */
    DEF_MT_A_F_ADJ              = 0x400000000,  // A/F 调校, 1 << 34

    /* ElectronicPump     */
    DEF_MT_ELECTRONIC_PUMP      = 0x800000000,  // 电子水泵激活, 1 << 35

    /* NoxReset           */
    DEF_MT_NOx_RESET            = 0x1000000000,  // 氮氧排放复位, 1 << 36

    /* UreaReset          */
    DEF_MT_UREA_RESET           = 0x2000000000,  // 尿素复位, 1 << 37

    /* TurbineLearning    */
    DEF_MT_TURBINE_LEARNING     = 0x4000000000,  // 涡轮叶片学习, 1 << 38

    /* Cylinder           */
    DEF_MT_CYLINDER             = 0x8000000000,  // 气缸平衡测试, 1 << 39

    /* EEPROM             */
    DEF_MT_EEPROM               = 0x10000000000,  // EEPROM适配器, 1 << 40

    /* ExhaustProcessing  */
    DEF_MT_EXHAUST_PROCESSING   = 0x20000000000,  // 尾气后处理, 1 << 41

    /* RFID */
    DEF_MT_RFID                 = 0x40000000000,  // RFID,       1 << 42
    
    /* 特殊功能 */
    DET_MT_SPEC_FUNC            = 0x80000000000,  // 特殊功能,   1 << 43
    
    //以下为新增加20240629
    /*Clutch*/
    DEF_MT_CLUTCH               = 0x100000000000,  //离合器匹配,   1 << 44

    /*Speed & PTO*/
    DEF_MT_SPEED_PTO            = 0x200000000000,  //速度与功率,   1 << 45

    /*FRM_RESET*/
    DEF_MT_FRM_RESET            = 0x400000000000,  //FRM复位,   1 << 46

    /*VIN*/
    DEF_MT_VIN                  = 0x800000000000,  //VIN,      1 << 47

    /*HV Battery*/
    DEF_MT_HV_BATTERY           = 0x1000000000000,  //高压电池,   1 << 48

    /*ACC*/
    DEF_MT_ACC                  = 0x2000000000000,  //巡航校准,   1 << 49

    /*A/C*/
    DEF_MT_AC_LEARNING          = 0x4000000000000,  //空调学习,   1 << 50

    /*Rain/Light Sensor*/
    DEF_MT_RAIN_LIGHT_SENSOR    = 0x8000000000000,  //雨水/光传感器,   1 << 51

    /*Reset control unit*/
    DEF_MT_RESET_CONTROL_UNIT   = 0x10000000000000,  //控制单元复位,   1 << 52

    /*CCS/ACC*/
    DEF_MT_CSS_ACC              = 0x20000000000000,  //定速/自适应巡航 ,   1 << 53

    /*Relative Compression*/
    DEF_MT_RELATIVE_COMPRESSION = 0x40000000000000,  //相对压缩 ,   1 << 54

    /*HV De-energization/Energization*/
    DEF_MT_HV_DE_ENERGIZATION      = 0x80000000000000,  //高压断电/启用,   1 << 55

    /*Coolant/Refrigerant Change*/
    DEF_MT_COOLANT_REFRIGERANT_CHANGE  = 0x100000000000000,  //冷却液/制冷剂更换 ,   1 << 56

    /*Resolver Sensor Calibration*/
    DEF_MT_RESOLVER_SENSOR_CALIBRATION = 0x200000000000000,  //旋变传感器标定 ,   1 << 57

    /*Camshaft learning*/
    DEF_MT_CAMSHAFT_LEARNING           = 0x400000000000000,  //凸轮轴学习 ,   1 << 58

    /*VIN/Odometer Check*/
    DEF_MT_VIN_ODOMETER_CHECK          = 0x800000000000000,  //VIN/里程检查,   1 << 59
    
    DEF_BASE_EIGHT_FUNCTION     = 0x3fff, // 基本功能+八大功能 app自己加的
    
    DEF_BASE_THIRTEEN_FUNCTION  = 0x1c283fff, // 基本功能+十三大功能 app自己加的
    
    DET_ALLFUN                  = 0x7FFFFFFFFFFFFFFF,   // 支持任何功能

    DET_ALLFUN_KEYNOW           = 0x7FFFFFFFFFFFFFFF - 0x40000000000, // KeyNOW 支持任何功能 app自己加的
    
    DET_INVALID                 = 0xFFFFFFFFFFFFFFFF,   // 不支持任何功能
    
    
}eDiagEntryType;


// 针对小车探用于接口GetObdEntryType的返回值
typedef enum {
    //当前OBD诊断车型的入口类型

    // 首页“数据流”快捷方式进入，例如国内版TOPVCI(小车探)
    OET_TOPVCI_DATASTREAM       = (1 << 0),  // 国内版TOPVCI首页数据流,   1 << 0

    // 首页“部件测试”快捷方式进入，例如国内版TOPVCI(小车探)
    OET_TOPVCI_ACTIVE_TEST      = (1 << 1),  // 国内版TOPVCI首页部件测试, 1 << 1

    // 首页“抬头显示”快捷方式进入，例如国内版TOPVCI(小车探)
    OET_TOPVCI_HUD              = (1 << 2),  // 国内版TOPVCI首页抬头显示, 1 << 2

    // 首页“年检预审”快捷方式进入，例如国内版TOPVCI(小车探)
    OET_TOPVCI_OBD_REVIEW       = (1 << 3),  // 国内版TOPVCI首页年检预审, 1 << 3

    // 是否进行OBD一键扫描故障码系统，OBD诊断程序根据此值判断增加扫描功能
    OET_TOPVCI_OBD_SCAN_SYS     = (1 << 4),  // 表示需要增加一键扫描OBD故障码系统, 1 << 4
    
    // 首页“发动机检测”快捷方式进入，例如CarPal
    OET_CARPAL_OBD_ENGINE_CHECK = (1 << 5),  // CarPal首页发动机检测, 1 << 5
    
    // 首页“IM预排放”快捷方式进入，例如CarPal
    OET_CARPAL_IM_PROTOCOL      = (1 << 6),  // CarPal首页IM预排放,   1 << 6
    ////////////////////////////////////////////////////////////////////////////////////////


    ///////////////////////////////     CarPal Guru    /////////////////////////////////////
    // CarPal Guru 首页“刷隐藏”快捷方式进入
    OET_CARPAL_GURU_HIDDEN      = (1 << 7),  // CarPal Guru 首页刷隐藏,  1 << 7

    // CarPal Guru 首页“数据流”快捷方式进入
    OET_CARPAL_GURU_DATASTREAM  = (1 << 8),  // CarPal Guru 首页数据流,  1 << 8

    // CarPal Guru 首页“动作测试”快捷方式进入
    OET_CARPAL_GURU_ACTIVE_TEST = (1 << 9),  // CarPal Guru 首页动作测试, 1 << 9
    ////////////////////////////////////////////////////////////////////////////////////////


    ///////////////////////////////     其它    /////////////////////////////////////
    // “汽车诊断” 快捷方式进入
    OET_DIAG_DIAG            = (1 << 16),  // 汽车诊断，路径方式进入,  1 << 16

    // “汽车保养” 快捷方式进入
    OET_DIAG_MAINTENANCE     = (1 << 17),  // 汽车保养，路径方式进入,  1 << 17

    // “汽车防盗” 快捷方式进入
    OET_DIAG_IMMO            = (1 << 18),  // 汽车防盗，路径方式进入,  1 << 18


    // “摩托车诊断” 快捷方式进入
    OET_MOTOR_DIAG            = (1 << 19),  // 摩托车诊断，路径方式进入,  1 << 19
    
    // “摩托车保养” 快捷方式进入
    OET_MOTOR_MAINTENANCE     = (1 << 20),  // 摩托车保养，路径方式进入,  1 << 20

    // “摩托车防盗” 快捷方式进入
    OET_MOTOR_IMMO            = (1 << 21),  // 摩托车防盗，路径方式进入,  1 << 21


    // “ADAS” 快捷方式进入
    OET_ADAS                  = (1 << 22),  // ADAS路径方式进入,  1 << 22
    
    // “TDart”
    OET_TDARTS                = (1 >> 23),
    ////////////////////////////////////////////////////////////////////////////////////////


    // 当前App不支持此入口功能接口
    OET_TOPVCI_APP_NOT_SUPPORT  = 0xFFFFFFF0,
} eObdEntryType;


// 用于接口GetDiagMenuMask的返回值，诊断应用对车型的菜单进行动态屏蔽
typedef enum
{   //当前诊断的系统掩码值

    DMM_SUPPORT_NONE_SYSTEM = 0,            // 表示当前不支持任何系统

    DMM_ECM_CLASS      = (1 << 0),          // 动力系统类    包含：发动机、汽车网关、巡航、新能源电机系统等系统

    DMM_TCM_CLASS      = (1 << 1),          // 传动系列类    包含：波箱等系统

    DMM_ABS_CLASS      = (1 << 2),          // 制动系统类    包含：ABS、EPB、刹车片等系统

    DMM_SRS_CLASS      = (1 << 3),          // 安全防御类    包含: SRS/Airbag、安全带、轮胎/胎压等系统

    DMM_HVAC_CLASS     = (1 << 4),          // 空调系列类    包含：空调、交换机等系统

    DMM_ADAS_CLASS     = (1 << 5),          // ADAS系列类    包含：ADAS、辅助行车类摄像头等

    DMM_IMMO_CLASS     = (1 << 6),          // 安全防盗类    包含：immobiliser/immobilizer、Key、防盗摄像头等系统

    DMM_BMS_CLASS      = (1 << 7),          // 电池系统类    包含：燃油车的电池、新能源的电池管理系统

    DMM_EPS_CLASS      = (1 << 8),          // 转向系统类    包含：EPS、方向盘等

    DMM_LED_CLASS      = (1 << 9),          // 灯光系统类    包含: 大灯、行车灯等

    DMM_IC_CLASS       = (1 << 10),         // 仪表系统类    包含: 仪表、中控相关、保险丝的系统等

    DMM_INFORMA_CLASS  = (1 << 11),         // 信息娱乐类    包含: DVD、收音机、行车/车内记录仪、导航、定位等系统

    DMM_BCM_CLASS      = (1 << 12),         // 车身控制类    包含：车门、车窗、尾箱、发动机舱、喇叭、雨刮等
    
    DMM_OTHER_CLASS    = (0xFFFFFFFF),      // 此值表示无法归类，统一用“其它”处理

    DMM_ALL_SYSTEM_SUPPORT  = 0x7FFFFFFFFFFFFFFF,           // 支持所有系统任何功能

    DMM_INVALID             = 0xFFFFFFFFFFFFFFFF,           // 不支持任何系统任何功能

}eDiagMenuMask;

// 针对AUTOVIN用于接口GetAutoVinEntryType的返回值
typedef enum eAutoVinEntryType
{
    //当前AUTOVIN车型的入口类型

    // 首页 ==> “诊断” ==> “AUTOVIN”  从首页的诊断入口进去后再点的AUTOVIN
    AVET_DIAG = (1 << 0),     // 从首页的诊断入口进入的AUTOVIN,   1 << 0

    // 首页 ==> “防盗” ==> “AUTOVIN”  从首页的防盗入口进去后再点的AUTOVIN
    AVET_IMMO = (1 << 1),     // 从首页的防盗入口进入的AUTOVIN,   1 << 1

    // 首页 ==> “摩托车” ==> “AUTOVIN”  从首页的摩托车入口进去后再点的AUTOVIN
    AVET_MOTOR = (1 << 2),    // 从首页的摩托车入口进入的AUTOVIN,   1 << 2

    // 当前App不支持此入口功能接口
    AVET_APP_NOT_SUPPORT = 0xFFFFFFF0,//DF_FUNCTION_APP_CURRENT_NOT_SUPPORT,
}eAutoVinEntryType;

typedef enum
{
    TIPS_IS_TOP = 0,    // 轮眉高度的提示符居于顶部显示
    TIPS_IS_BOTTOM  = 1,    // 轮眉高度的提示符居于底部显示
}ePosType;

@protocol TDD_ArtiGlobalModelDelegata <NSObject>

/**********************************************************
*    功  能：网络请求
**********************************************************/
- (void)ArtiGlobalNetwork:(TDD_ArtiModelEventType )eventType param:(NSDictionary *)json completeHandle: (nullable void(^)(id result))complete;
/**********************************************************
*    功  能：事件
**********************************************************/
- (void)ArtiGlobalEvent:(TDD_DiagOtherEventType )eventType param:(NSDictionary *)json;

@end
@interface TDD_ArtiGlobalModel : TDD_ArtiModelBase
@property (nonatomic, strong) NSString * CarPath; //车型路径
@property (nonatomic, strong) NSString * CarName; //车型名称 -- 车型缩写
@property (nonatomic, copy) NSString * carServiceName; //车型名称 -- 服务器名称
@property (nonatomic, strong) NSString * CarVIN; //车辆VIN码
@property (nonatomic, strong) NSString * CarInfo; //车辆信息
@property (nonatomic, strong) NSString * CarVersion; //车辆版本
@property (nonatomic, strong) NSString * CarStaticLibraryVersion; //车辆静态库版本
@property (nonatomic, strong) NSString * sysName; //系统名称
@property (nonatomic, assign) eDiagEntryType diagEntryType; //当前诊断的入口类型
@property (nonatomic, strong) NSArray *diagEntryExTypes;//诊断功能掩码数组
@property (nonatomic, strong) NSArray<NSString *> *vctVehicle;//VIN解析的车型缩写
@property (nonatomic, strong) NSArray<NSString *> *vctVehName;//VIN解析的车型名称
@property (nonatomic, strong) NSArray<NSString *> *vctSoftCode;//VIN解析的车型软件编码
@property (nonatomic, strong) NSString * carLanguage; //CN、EN
@property (nonatomic, assign) eDiagMenuMask diagMenuMask;//车型菜单支持系统
@property (nullable,nonatomic, strong) TDD_HistoryDiagModel *historyModel;//历史诊断model
@property (nonatomic, assign) TDD_DiagShowType diagShowType; // 进车类型(历史诊断类型区分使用)
@property (nonatomic, assign) TDD_DiagShowSecondaryType diagShowSecondaryType; // 进车二级入口
@property (nonatomic, strong) NSString * softCode;
@property (nonatomic, assign) NSInteger appLanguageId;         // app 语言id
@property (nonatomic, assign) BOOL softIsExpire;//软件已经过期
@property (nonatomic, assign) BOOL isEntryFromHistory;//是否历史进车
///车辆品牌
@property (nonatomic, copy) NSString *carBrand;
///车辆年款
@property (nonatomic, copy) NSString *carYear;
///车辆型号
@property (nonatomic, copy) NSString *carModel;
///车辆发动机信息
@property (nonatomic, copy) NSString *carEngineInfo;
///车辆发动机子信息
@property (nonatomic, copy) NSString *carEngineSubInfo;
///车辆行驶里程
@property (nonatomic, copy) NSString *carMileage;
///车辆故障灯亮后行驶里程
@property (nonatomic, copy) NSString *carMILOnMileage;
//网关
@property (nonatomic, assign) eSpecialShowType authType;
///解锁类型 0-autoAuth 解锁、1-TopDon解锁
@property (nonatomic, assign) NSInteger authUnlockType;
///auth账户
@property (nullable, nonatomic, strong) NSMutableDictionary * authAccountDict;
///auth区域
@property (nullable, nonatomic, strong) NSMutableDictionary * authAreaDict;
///auth密码(内存存储,退车后清除)
@property (nullable, nonatomic, strong) NSMutableDictionary * authPasswordDict;
/// authtoken
@property (nullable, nonatomic, copy) NSString * authToken;
/// 切换账号缓存
@property (nullable, nonatomic, copy) NSString * authChangeAccount;
@property (nonatomic, weak)id <TDD_ArtiGlobalModelDelegata> delegate;
//autoVIN
@property (nonatomic, assign) BOOL isAutoVinBindCar; // autoVin 扫描模式 是否是绑定车辆
@property (nonatomic, assign) BOOL isCurVehNotSupport; // 小车探 当前车辆是否支持进车 不支持 直接进 EOBD  YES: 支持 NO: 不支持
@property (nonatomic, assign) eAutoVinEntryType autoVinEntryType;//autoVin 入口

// 弹框
@property (nonatomic, assign) BOOL isShowBatteryVoltTip;
@property (nonatomic, assign) BOOL isShowBleBreakTip;
@property (nonatomic, assign) BOOL isShowBackgroundTip;

/// 小车探
@property (nonatomic, assign) eObdEntryType obdEntryType; // 当前OBD诊断入口类型

/// 小车探VIN码 服务器透传信息 为ID
@property (nonatomic, strong) NSString *vinServerInfo;
/// 小车探VIN码信息 传具体值 （不是ID）例如:品牌 VW  eGetVinInfoType
@property (nonatomic, strong) NSArray<NSString *> *vinServerInfoValue;

@property (nonatomic, strong) NSArray *vehicleLogPath;//车型诊断日志文件地址
@property (nonatomic, strong) NSMutableArray<NSNumber *> *instanceIDArr;//所有创建的悬浮窗 ID
@property (nonatomic, strong) NSString * strShareAccount; // 分享邮箱

@property (nonatomic, strong, nullable) TDD_VehInfoModel *vehInfoModel;//车型路径临时存储

/// 缓存车型路径数组，最多 50 条数据
@property (nonatomic, strong) NSMutableArray <NSString *>*carPaths;

#pragma mark 创建单例
+ (TDD_ArtiGlobalModel *)sharedArtiGlobalModel;

//进车初始化参数
+ (void)cleanParamtert;
//退车初始化参数
+ (void)initParameter;

/*-----------------------------------------------------------------------------
  功    能：获取stdshow版本号

            PC工具中，返回的是StdShow.dll的版本号
            Android中，返回的是libstdshow.so的版本号

  参数说明：无

  返 回 值：32位 整型 0xHHLLYYXX

  说    明：Coding of version numbers
            HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
            LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
            YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
            XX 为 最低字节, Bit 7 ~  Bit 0    保留

            例如 0x02010300, 表示 V2.01.003
            例如 0x020B0000, 表示 V2.11
-----------------------------------------------------------------------------*/
+ (uint32_t)GetVersion;

/*-----------------------------------------------------------------------------
  功    能：获取显示应用的版本号

            PC工具中，返回的是TD.exe的版本号
            Android中，返回的是APK的版本号

  参数说明：无

  返 回 值：32位 整型 0xHHLLYYXX

  说    明：Coding of version numbers
            HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
            LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
            YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
            XX 为 最低字节, Bit 7 ~  Bit 0    保留

            例如 0x02010300, 表示 V2.01.003
            例如 0x020B0000, 表示 V2.11
-----------------------------------------------------------------------------*/
+ (uint32_t)GetAppVersion;

/*-----------------------------------------------------------------------------
功能：获取当前语言
参数说明：无
返回值：en,cn
说明：无
-----------------------------------------------------------------------------*/
+ (NSString *)GetLanguage;

/*-----------------------------------------------------------------------------
功能：获取当前车型路径
参数说明：无

返回值：当前车型路径，Windows 即Diag.dll所在路径

说明：路径为绝对路径，
      Windows 例如："E:\SVN\Debug\TopDon\Diagnosis\Car\Europe\Demo"
-----------------------------------------------------------------------------*/
+ (NSString *)GetVehPath;

/*-----------------------------------------------------------------------------
功能：获取当前车型的用户数据路径（非车型路径）,此路径下的文件随着车型软件
      升级不会被删除或更改

参数说明：无

返回值：当前车型的用户数据路径

说明：路径为绝对路径，
      Windows 例如："C:\ProgramData\TD\IMMO\BMW"
      Android 例如："/mnt/sdcard/Android/data/com.TD.diag.artidiag
                     /files/TD/AD900/UserData/IMMO/BMW"
-----------------------------------------------------------------------------*/
+ (NSString *)GetVehUserDataPath;

/*-----------------------------------------------------------------------------
功能：获取当前车型名称
参数说明：无

返回值：当前车型路径的文件夹名称，Windows 即Diag.dll所在路径的文件夹名称

说明：Windows 例如：
      如果车型路径为"E:\SVN\Debug\TD\Diagnosis\Car\Europe\Demo"
      则返回字符串为"Demo"
-----------------------------------------------------------------------------*/
+ (NSString *)GetVehName;

/*-----------------------------------------------------------------------------
功能：获取当前车辆VIN码
参数说明：无

返回值：应用已知的车辆VIN码（例如调用AutoVin获取到的，或者OCR扫描铭牌得到的）

说明：返回值举例：
                LFV3A23C2H3181097
-----------------------------------------------------------------------------*/
+ (NSString *)GetVIN;

/*-----------------------------------------------------------------------------
功能：设置当前车辆VIN码

参数说明：诊断设置当前获取到的VIN，例如 LFV3A23C2H3181097

返回值：无
-----------------------------------------------------------------------------*/
+ (void)SetVIN:(NSString *)strVin;

/*-----------------------------------------------------------------------------
功能：设置VIN解析的车型给APK/APP

      AUTOVIN诊断设置当前车辆车型
      AUTOVIN根据获取到的VIN，解析相应的车型，将VIN对应的车型给APK/APP


参数说明：vctVehicle     解析到的对应可能车型的集合
                         如果解析到的可能车型有好几个，通过参数vctVehicle设给APP/APK
                         如果解析不到对应的车型，则vctVehicle为空
                         如果vctVehicle数组大小为2，则存在2种的可能存在车型

         例如：vctVehicle的数组大小为4，分别是"Chrysler","Fiat","JEEP","Dodge"
         则VIN对应的车可能是4种车型

         例如：vctVehicle的数组大小为7，分别"Fawcar", "FawDaihatsu", "MazdaChina",
         "TJFAW", "ToyotaChina", "BesTune", "HongQi"
         则VIN对应的车可能是7种车型


返回值：无


注  意：诊断设置当前车辆车型
        AUTOVIN获取VIN码的途径，优先通过GETVIN来获取，其次可以从车辆通讯中获取
-----------------------------------------------------------------------------*/
+ (void)SetVehicle:(NSArray<NSString *> *)vctVehicle;

/*-----------------------------------------------------------------------------
功能：设置VIN解析的车型信息给APK/APP，软件编码可为空或者空串""

      AUTOVIN诊断设置当前车辆车型信息
      AUTOVIN根据获取到的VIN，解析相应的车型目录文件夹名称和车型名称，
                              将VIN对应的车型目录文件夹名称和车型名称给APK/APP


参数说明：
         vctVehDir       解析到的对应可能车型的目录文件夹名称的集合
                         如果解析到的可能车型有好几个，通过参数vctVehDir设给APP/APK
                         如果解析不到对应的车型，则vctVehDir为空
                         如果vctVehicle数组大小为2，则存在2种的可能存在车型

         vctVehName      解析到的对应可能车型的车型名称的集合
                         如果解析到的可能车型有好几个，区域就有几个
                         如果解析不到对应的车型，则vctVehDir为空，vctVehName也为空
                         如果vctVehDir数组大小为2，则存在2种的可能存在车型，
                         此时vctVehName的大小也为2

         vctSoftCode     对应的软件编码

返回值：无


注  意：诊断设置当前车辆车型
        AUTOVIN获取VIN码的途径，优先通过GETVIN来获取，其次可以从车辆通讯中获取
-----------------------------------------------------------------------------*/
+ (void)SetVehicleEx:(NSArray<NSString *> *)vctVehDir vctVehName:(NSArray<NSString *> *)vctVehName vctSoftCode:(NSArray<NSString *> *)vctSoftCode;


/*-----------------------------------------------------------------------------
功能：设置车辆信息

参数说明：诊断设置当前车辆信息

        例如：宝马/3'/320Li_B48/F35/

返回值：无
-----------------------------------------------------------------------------*/
+ (void)SetVehInfo:(NSString *)strVehInfo;

/*-----------------------------------------------------------------------------
功能：设置系统名称

参数说明：诊断设置当前系统名称

        例如：RCM-安全保护控制系统

返回值：无
-----------------------------------------------------------------------------*/
+ (void)SetSysName:(NSString *)strSysName;


/*-----------------------------------------------------------------------------
功    能： 获取当前应用的宿主机是手机还是平板

参数说明： 无

返 回 值： HT_IS_TABLET     表示当前应用的主机是平板
           HT_IS_PHONE      表示当前应用的主机是手机
           
注  意：   例如，AD200可能在手机或者iPad上运行，如果在手机上运行，返回HT_IS_TABLET
           如果在iPad上运行，返回HT_IS_PHONE
-----------------------------------------------------------------------------*/
+ (eHostType)GetHostType;

/*-----------------------------------------------------------------------------
功    能： 获取当前app应用的产品名称

参数说明： 无

返 回 值： PD_NAME_AD900              表示当前产品名为AD900
           PD_NAME_AD200              表示当前产品名为AD200
           PD_NAME_TOPKEY             表示当前产品名为TOPKEY
           PD_NAME_NINJA1000PRO       表示当前产品名为Ninja1000 Pro
-----------------------------------------------------------------------------*/
+ (eProductName)GetAppProductName;

/*-----------------------------------------------------------------------------
功    能： 获取当前app应用的使用场景

参数说明： 无

返 回 值： AS_EXTERNAL_USE         表示正式面向用户的使用场景，即正常用户使用场景
          AS_INTERNAL_USE         表示打开了Debug使用场景的后门
-----------------------------------------------------------------------------*/
+ (eAppScenarios)GetAppScenarios;

/*-----------------------------------------------------------------------------
功    能： 获取当前诊断的入口类型

参数说明： 无

返 回 值： DET_ALLFUN         表示当前是通过，点击正常诊断下车标进入的车型
           DET_MT_OIL_RESET   表示当前是通过，点击保养下的车标进入的车型，例如
                              AD200下的保养快捷菜单
-----------------------------------------------------------------------------*/
+ (eDiagEntryType)GetDiagEntryType;

/*-----------------------------------------------------------------------------
功    能： 获取菜单屏蔽掩码，用于获取当前产品（App）是否支持哪些类型系统菜单（功能）

           车型代码通过此接口获取可支持的系统菜单掩码，再配合接口GetDiagEntryType
           获取入口类型支持的功能掩码，对不可展示的菜单进行过滤（不展示），形成不
           同的产品搭配要求

参数说明： 无

返 回 值： eDiagMenuMask      支持的系统掩码，"位"值为"1"表示支持，"0"表示不支持

           例如，DMM_ECM_CLASS，即0x01，表示支持“动力系统类”
           例如，0x03，表示支持“动力系统类”且支持“传动系列类”
           DMM_ALL_SYSTEM_SUPPORT，表示支持所有系统类
-----------------------------------------------------------------------------*/
+ (eDiagMenuMask)GetDiagMenuMask;

/*-----------------------------------------------------------------------------
 *    功    能：网络连接是否存在，并且可以建立连接并传递数据
 *
 *    参数说明：无
 *
 *    返 回 值：true     网络连接存在，并且可以建立连接并传递数据
 *              false    网络没有连接
 -----------------------------------------------------------------------------*/

+ (BOOL)IsNetworkAvailable;

/*-----------------------------------------------------------------------------
 *   功   能： 远程调用算法服务接口
 *             算法的输入与输出在CAlgorithmData中
 *
 *   参数说明：pAlgoData    算法数据对象指针
 *
 *   返 回 值：远程调用的返回码
 *             如果远程算法服务接口调用成功，返回收到的算法结果数据长度
 *             如果pAlgoData为空，返回-1
 *             如果pAlgoData->GetPackedDataLength()为0，返回-1
 *
 *             此接口为阻塞接口，直至服务器返回数据（如果1分半钟内，APK都没有数据返回
 *             将返回-1，失败）
 *
 -----------------------------------------------------------------------------*/
//+ (uint32_t)RpcSendRecv:(CAlgorithmData *)pAlgoData;
//static uint32_t RpcSendRecv(CAlgorithmData *pAlgoData);

+ (NSString *)getVehPathExWithVehType:(NSString *)strVehType strVehArea:(NSString *)strVehArea strVehName:(NSString *)strVehName;

- (NSString *)getAuthAccount;
- (NSInteger )getAuthArea;
- (NSString *)getAuthPassword;
- (NSString *)getSaveAuthPassword;
- (NSInteger )getAuthBrand;
- (NSString *)getAuthAccount:(NSInteger )viewType;
//清空缓存
- (void)clearAuthMessage:(BOOL)clearSavePWD;
- (void)saveAuthPassword;
//本地化网关相关信息
- (void)saveGatewayArea;

- (void)saveGatewayAccount;
@end

NS_ASSUME_NONNULL_END
