#ifndef __APP_PRODUCT_MACO_H__
#define __APP_PRODUCT_MACO_H__

#include "StdInclude.h"

// 用于接口CAppProduct::Name的返回值
enum class eAppProductName :uint32_t
{
    //当前app应用的产品名称
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
};

// 用于接口CAppProduct::Group的返回值
enum class eAppProductGroup :uint32_t
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
};


class _STD_SHOW_DLL_API_ CAppProduct
{
public:

public:
    CAppProduct() {}
    ~CAppProduct() {}

public:
    /*-----------------------------------------------------------------------------
    功    能： 获取当前app应用的产品名称

               函数功能跟CArtiGlobal::GetAppProductName一模一样
               但CArtiGlobal::GetAppProductName已不建议使用，移至CAppProduct::Name

    参数说明： 无

    返 回 值： PD_NAME_AD900              表示当前产品名为AD900
               PD_NAME_AD200              表示当前产品名为AD200
               PD_NAME_TOPKEY             表示当前产品名为TOPKEY
               PD_NAME_NINJA1000PRO       表示当前产品名为Ninja1000 Pro
    -----------------------------------------------------------------------------*/
    static eAppProductName const Name();


    /*------------------------------------------------------------------------------------------
    功    能： 获取当前app应用的产品组名称（产品系列）

    参数说明： 无

    返 回 值：     PD_GROUP_AD900_LIKE     例如，AD900、AD900 LITE、GOOLOO DS900等
                   PD_GROUP_TOPSCAN_LIKE   例如，TopScan HD、TopScan VAG、DS200、DeepScan等
                   PD_GROUP_CARPAL_LIKE    例如，CarPal、CarPal Guru、DS100、小车探等
                   PD_GROUP_AD500_LIKE     例如，AD500、AD600、AD600S、AD500S、AD500 BMS、等
    ------------------------------------------------------------------------------------------*/
    static eAppProductGroup const Group();


    /*-------------------------------------------------------------------------------------------------------
    功    能： 获取当前 App 应用的功能 或 接口 是否支持
               针对不同的类组件和接口名称、Function值
               返回true表示支持，false表示不支持
               
               同一个App，针对同一个接口，对应App的不同版本，可能会有不同的支持情况

    参数说明： strClass          表示哪个组件     例如，"CVehAutoAuth"
               strApi            表示哪个API接口  例如，"SendRecv"

               uFunction         表示具体类和接口下，具体的功能是否支持
                                 默认0xFFFFFFFF(-1)，表示不区分功能，只代表该接口是否支持

                                 举例，strClassClass = "CVehAutoAuth"
                                       strApi = "SendRecv"
                                       uFunction = SRT_NISSAN_DIAG_REQ(5)
                                       返回 true 则表示当前App已支持日产网关算法请求接口
                                       返回 false 则表示当前App还不支持日产网关算法请求接口

    返 回 值： true     对应功能已支持
               false    对应功能未支持
    -------------------------------------------------------------------------------------------------------*/
    static bool const IsSupported(const std::string& strClass, const std::string& strApi, uint32_t uFunction = -1);


    /*-------------------------------------------------------------------------------------------------------
    功    能： 获取当前进车的软件编码

    参数说明： uVehType          保留，当前不起作用

    返 回 值： 例如，"AD900_CarSW_MAZDA"
               如果App没有此接口，返回空串
    -------------------------------------------------------------------------------------------------------*/
    static const std::string CurVehSoftCode(uint32_t uVehType);
};

#endif // __APP_PRODUCT_MACO_H__
