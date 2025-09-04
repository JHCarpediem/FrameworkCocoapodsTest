/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900远程认证接口定义
* 创 建 人 : sujiya 20201210
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __STD_VEH_AUTO_AUTH_H__
#define __STD_VEH_AUTO_AUTH_H__

#include "StdInclude.h"
#include "StdShowMaco.h"


// 方便阅读使用， CArtiGlobal的FCA接口会迁移到这里
// 
// 涉及到的网关服务算法调用，例如FCA、雷诺等集中到这里
// 
// 包括公司算法服务调用接口
// 
// CVehAutoAuth 不是UI接口，只是网络服务器数据转发调用接口
// CVehAutoAuth是没有Show接口的
// 



////////////////////////////////////////////////////////////////////////////
// 用于特殊界面显示
// uType 是界面类型
// 
//      SST_FUNC_FCA_AUTH      = 0    FCA认证登录界面
//      SST_FUNC_RENAULT_AUTH  = 1,   雷诺认证登录界面
//      SST_FUNC_NISSAN_AUTH   = 2,   日产认证登录界面
//      SST_FUNC_VW_SFD_AUTH   = 3,   大众网关解锁(VW SFD)登录界面
// 
//      SST_FUNC_DEMO_AUTH     = 0xFFFFFFF0,    DEMO演示使用的登录界面
//
// 阻塞界面，直至需要诊断程序参与才返回
// 如果是大众网关解锁登录界面，存在"第三方处理"的按钮值返回(DF_ID_SFD_THIRD)
// 如果判断传值为不识别的值（即不支持），APP不显示页面，返回DF_CUR_BRAND_APP_NOT_SUPPORT(-17)
uint32_t _STD_SHOW_DLL_API_ artiShowSpecial(eSpecialShowType uType);
////////////////////////////////////////////////////////////////////////////


// 当前App还不支持所设置的车辆品牌网关算法
#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)



class CAlgorithmData;
class _STD_SHOW_DLL_API_ CVehAutoAuth
{
public:
    // 用于接口
    enum class eBrandType :uint32_t
    {   // 表示是哪个车品牌
        BT_VEHICLE_TOPDON     = 0,            // 表示当前是公司算法服务器调用

        BT_VEHICLE_FCA        = 1,            // 表示当前的品牌是FCA
        BT_VEHICLE_RENAULT    = 2,            // 表示当前的品牌是雷诺
        BT_VEHICLE_NISSAN     = 3,            // 表示当前的品牌是日产
        BT_VEHICLE_MITSUBISHI = 4,            // 表示当前的品牌是三菱
        BT_VEHICLE_VW_SFD     = 5,            // 表示当前的品牌是大众

        BT_VEHICLE_DEMO       = 0xFFFFFFF0,   // 表示当前的品牌是DEMO的（演示使用）

        BT_VEHICLE_INVALID    = 0xFFFFFFFF,
    };


    // 指定哪个服务接口类型，适用于 SendRecv 接口
    enum class eSendRecvType :uint32_t
    {   // 服务请求接口的类型
        SRT_FCA_DIAG_INIT    = 1,         // 表示当前请求的是FCA的Init接口，即 FcaAuthDiagInit
                                          // FCA服务器认证请求（Authentication初始化）

        SRT_FCA_DIAG_REQ     = 2,         // 表示当前请求的是FCA的Request接口，即 FcaAuthDiagRequest
                                          // 向FCA服务器转发SGW的 Challenge 随机码

        SRT_FCA_DIAG_TRACK   = 3,         // 表示当前请求的是FCA的TrackResp接口，结果追踪，即 FcaAuthDiagTrackResp
                                          // 向FCA服务器转发 SGW解锁的 TrackResponse 结果追踪（可理解为欧洲FCA的SGW解锁埋点）

        SRT_RENAULT_DIAG_REQ = 4,         // 表示当前请求的是雷诺的网关算法请求接口
                                          // 向雷诺网关算法服务器转发 网关算法请求数据

        SRT_NISSAN_DIAG_REQ  = 5,         // 表示当前请求的是日产的网关算法请求接口
                                          // 向日产网关算法服务器转发 网关算法请求数据

        SRT_VW_DIAG_REQ      = 6,         // 表示当前请求的是大众的网关算法请求接口


        SRT_VW_SFD_REPORT    = 0x80,      // 表示当前请求的是公司产品数据中心的网关解锁数据上报接口
                                          // /api/v1/baseinfo/gatewayUnlockRecord/save

        SRT_DEMO_DIAG_REQ   = 0xFFFFFFF0, // 表示当前请求的是DEMO的网关算法请求接口

        SRT_INVALID_TYPE = 0xFFFFFFFF,
    };


public:
    CVehAutoAuth();
    ~CVehAutoAuth();

public:
    /*-------------------------------------------------------------------------------------------------
      功    能：设置对应的品牌

      参数说明：uBrand 车辆品牌

                BT_VEHICLE_FCA     = 1  表示当前的品牌是FCA
                BT_VEHICLE_RENAULT = 2  表示当前的品牌是雷诺（日产三星）

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法
    
                设置成功返回1
                其它返回值，暂无意义

      说    明：无
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetBrandType(const eBrandType& brandType);


    /*-------------------------------------------------------------------------------------------------
      功    能：设置车辆对应的品牌，用于网关解锁数据上报

      参数说明：strBrand 车辆品牌, Make
                         例如，"AUDI"

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

                设置成功返回1
                其它返回值，暂无意义

      说    明：无
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetVehBrand(const std::string& strBrand);


    /*-------------------------------------------------------------------------------------------------
      功    能：设置车辆对应的型号，用于网关解锁数据上报

      参数说明：strModel 车辆型号, Model
                         例如，"奥迪A3"

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：无
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetVehModel(const std::string& strModel);


    /*-------------------------------------------------------------------------------------------------
      功    能：设置网关算法接口的车辆车架号

      参数说明：strVin 车辆车架号

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetVin(const std::string& strVin);


    /*-------------------------------------------------------------------------------------------------
      功    能：设置网关算法解锁接口的ECU名称，用于网关解锁数据上报

      参数说明：strSysName 系统名称
                           例如，"19 - 数据总线诊断接口"

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：用于网关解锁或者网关解锁数据上报
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetSystemName(const std::string& strSysName);



    /*-------------------------------------------------------------------------------------------------
      功    能：设置网关算法接口的ECU解锁类型，ecuUnlockType

      参数说明：strType     ECU解锁类型
                
                举例1："UnlockUdsECU" 
                    -> Unlock the ECU using UDS protocole and Asymetric or Symetric Unlocking Algorithm

                举例2："UnlockSpecBcEcu" -> Unlock the ECU using SpecB protocole

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：适用于雷诺，日产网关算法
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuUnlockType(const std::string & strType);



    /*-------------------------------------------------------------------------------------------------
      功    能：设置网关算法接口的ECU公共服务数据，即 ECU-public-service-data，ecuPublicServiceData

      参数说明：strData     ECU公共服务数据，即识别要用于相应ECU的id
                            只有当ECU解锁类型=UnlockUdsECU时，此参数才是必需的
                            即调用SetEcuUnlockType接口设置了UnlockUdsECU时，此参数才是必需的

                举例：“424F53434845434D”，即是 BOSCHECM 的十六进制值

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：适用于雷诺，日产网关算法
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuPublicServiceData(const std::string& strData);



    /*-------------------------------------------------------------------------------------------------
      功    能：设置网关算法接口的ECU种子（securitySeed）数据，ecuChallenge或者ecuSecuritySeed 

                FCA，即 ECU Challenge（Base64）
                Renault 即 ECU-security-seed

      参数说明：strSeed     ECU返回的种子数据

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：适用于FCA，雷诺，日产等网关算法
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuChallenge(const std::string& strSeed);


    /*-------------------------------------------------------------------------------------------------
      功    能：设置网关算法接口的ECU（securityKey）数据，也叫做ecuChallenge（SFD中称为Tocken）

                用于网关解锁结果上报至公司服务器（数据追踪），当前为大众SFD解锁数据上报

      参数说明：strChallenge     发给ECU的KEY数据，即securityKey，对应SFD界面的Tocken
                                 即IOT接口unlockReport的token参数

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

                设置成功返回1
                其它返回值，暂无意义

      说    明：适用于大众SFD解锁数据上报接口的参数设置，或者其它途径解锁（非原厂算法服务器）
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuTocken(const std::string& strChallenge);
    


    /*-------------------------------------------------------------------------------------------------
    功    能：设置网关算法接口的ECU的ID，ecuCANID，ecu-address

            欧洲FCA，明确指定了是需要解锁的ECU的CANID，例如 "18DA10F1"是ECM，"18DA1020"是BSM
            北美FCA，可为空
            Renault  即 ECU Address used to identify the given ECU

    参数说明：strCanID     ECU的CANID

    返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
              DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

              DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁
   
              设置成功返回1
              其它返回值，暂无意义

    说    明：适用于FCA，雷诺，日产等网关算法
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetEcuCanId(const std::string& strCanID);


    /*-------------------------------------------------------------------------------------------------
    功    能：设置网关算法接口的x-routing-policy, routingPolicy, 适用于雷诺

    参数说明：strPolicy     路由策略值

                            This parameter set by the consumer is mandatory to access security access 
                            service developed in release R5

              举例："SecurityAccessV2_9"

    返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
              DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

              DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关解锁

              设置成功返回1
              其它返回值，暂无意义

    说    明：适用于雷诺等网关算法
    -------------------------------------------------------------------------------------------------*/
    uint32_t SetXRoutingPolicy(const std::string& strPolicy);


    /*-------------------------------------------------------------------------------------------------
    功    能：获取公司服务器返回的错误代码 "code"，例如"200"

    返 回 值：公司服务器返回的错误代码 "code"，例如"200"

    说    明：适用于服务器算法透传，此接口需在SendRecv调用后去调用
    -------------------------------------------------------------------------------------------------*/
    const std::string GetRespondCode();


    /*-------------------------------------------------------------------------------------------------
    功    能：获取公司服务器返回的描述 "msg"，例如"User authentication failed!"

    返 回 值：公司服务器返回的描述 "msg"，例如"User authentication failed!"

    说    明：适用于服务器算法透传，此接口需在SendRecv调用后去调用
    -------------------------------------------------------------------------------------------------*/
    const std::string GetRespondMsg();


    /*-------------------------------------------------------------------------------------------------
    功    能：获取OE服务器返回的Challenge

              FCA, SGW Challenge Response（Base64）
              Renault, ECU-security-seed 的响应


    返 回 值：Challenge

    说    明：适用于服务器算法透传，此接口需在SendRecv调用后去调用
    -------------------------------------------------------------------------------------------------*/
    const std::string GetEcuChallenge();


    /*------------------------------------------------------------------------------------
     *   功   能： 获取当前的网关用户登录界面上用户选择的区域
     *
     *   参数说明：无
     *
     *   返 回 值：eLoginRegionType
     *
     *             LGT_SELECT_AMERICA     表示App的网关用户登录中，当前选择的区域是美洲
     *             LGT_SELECT_EUROPE      表示App的网关用户登录中，当前选择的区域是欧洲
     *             LGT_SELECT_OTHER       表示App的网关用户登录中，当前选择的区域是其它
     *
     *             DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
     ------------------------------------------------------------------------------------*/
    eLoginRegionType GetLoginRegion();
    

    /*-----------------------------------------------------------------------------------------------------------
     *   功   能： 向OE服务器，或者TOPDON公司算法服务器，转发算法接口，或者请求公司IOT服务器接口
     *             具体的场景根据参数eSendRecvType定义
     *
     *   参数说明：eSendRecvType Type   算法接口的类型，指明此次调用属于什么类型
     *
     *            Type 值可如下：
     *            SRT_FCA_DIAG_INIT     表示当前请求的是FCA的Init接口，即 FcaAuthDiagInit
     *                                  FCA服务器认证请求（Authentication初始化）
     * 
     *            SRT_FCA_DIAG_REQ      表示当前请求的是FCA的Request接口，即 FcaAuthDiagRequest
     *                                  向FCA服务器转发SGW的 Challenge 随机码
     * 
     *            SRT_FCA_DIAG_TRACK    表示当前请求的是FCA的TrackResp接口，结果追踪，即 FcaAuthDiagTrackResp
     *                                  向FCA服务器转发 SGW解锁的 TrackResponse 结果追踪（可理解为欧洲FCA的SGW解锁埋点）
     * 
     *            SRT_RENAULT_DIAG_REQ  表示当前请求的是雷诺的网关算法请求接口
     *                                  向雷诺网关算法服务器转发 网关算法请求数据
     * 
     *            SRT_VW_SFD_REPORT     表示当前请求的是公司产品数据中心的网关解锁数据上报接口
     * 
     * 
     *   返 回 值：服务器认证请求的返回码
     *             如果服务器认证请求调用成功，返回0
     *
     *             如果此时网络没有连接，返回-3
     *             如果此时用户没有登录服务器，返回-4
     *             如果此时Token失效，返回-5
     *             其它错误，当前统一返回-9
     *
     *             此接口为阻塞接口，直至服务器返回数据（如果在TimeOutMs时间内，接口形
     *             参默认为1分半钟内(90秒)，APK都没有数据返回将返回-6，失败）
     * 
     *             如果当前App还不支持指定品牌的网关解锁功能，App返回值为DF_CUR_BRAND_APP_NOT_SUPPORT(-17)
     -----------------------------------------------------------------------------------------------------------*/
    uint32_t SendRecv(eSendRecvType Type, uint32_t TimeOutMs = 90 * 1000);


private:
    void* m_pData = NULL;
};
#endif
