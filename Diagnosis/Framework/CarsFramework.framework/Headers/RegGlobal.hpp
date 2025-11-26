#pragma once
#ifdef __cplusplus
#include <memory>
#include <functional>
#include <vector>
#include <string>

#include "HStdOtherMaco.h"
#include "HEventTracking.h"
class CAlgorithmData;
class CRegGlobal
{
public:
    CRegGlobal() = delete;
    ~CRegGlobal() = delete;

public:
    /*
    *   注册CArtiGlobal静态成员函数GetAppVersion的回调函数
    *
    *   static uint32_t GetAppVersion();
    *
    *   GetAppVersion 函数说明见 ArtiGlobal.h
    */
    static void GetAppVersion(std::function<uint32_t()> fnGetAppVersion);

    /*
    *   注册CArtiGlobal静态成员函数GetLanguage的回调函数
    *
    *   static std::string const GetLanguage();
    *
    *   GetLanguage 函数说明见 ArtiGlobal.h
    */
    static void GetLanguage(std::function<const std::string()> fnGetLanguage);

    /*
    *   注册CArtiGlobal静态成员函数GetVehPath的回调函数
    *
    *   static std::string const GetVehPath();
    *
    *   GetVehPath 函数说明见 ArtiGlobal.h
    */
    static void GetVehPath(std::function<const std::string()> fnGetVehPath);
    
    /*
    *   注册CArtiGlobal静态成员函数GetVehPathEx的回调函数
    *
    *   static std::string const GetVehPathEx(const std::string& strVehType, const std::string& strVehArea, const std::string& strVehName);

    *
    *   GetVehPathEx 函数说明见 ArtiGlobal.h
    */
    static void GetVehPathEx(std::function<const std::string(const std::string&, const std::string&, const std::string&)> fnGetVehPathEx);


    /*
    *   注册CArtiGlobal静态成员函数GetVehUserDataPath的回调函数
    *
    *   static std::string const GetVehUserDataPath();
    *
    *   GetVehUserDataPath 函数说明见 ArtiGlobal.h
    */
    static void GetVehUserDataPath(std::function<const std::string()> fnGetVehUserDataPath);
    
    /*
    *   注册CArtiGlobal静态成员函数GetVehName的回调函数
    *
    *   static std::string const GetVehName();
    *
    *   GetVehName 函数说明见 ArtiGlobal.h
    */
    static void GetVehName(std::function<const std::string()> fnGetVehName);

    /*
    *   注册CArtiGlobal静态成员函数GetVIN的回调函数
    *
    *   static std::string const GetVIN();
    *
    *   GetVIN 函数说明见 ArtiGlobal.h
    */
    static void GetVIN(std::function<const std::string()> fnGetVIN);

    /*
    *   注册CArtiGlobal静态成员函数SetVIN的回调函数
    *
    *   static void SetVIN(const std::string& strVin));
    *
    *   SetVIN 函数说明见 ArtiGlobal.h
    */
    static void SetVIN(std::function<void(const std::string&)> fnSetVIN);
    
    
    /*
    *   注册CArtiGlobal静态成员函数SetVehicle的回调函数
    *
    *   static void SetVehicle(const std::vector<std::string>& vctVehicle);
    *
    *   SetVehicle 函数说明见 ArtiGlobal.h
    */
    static void SetVehicle(std::function<void(const std::vector<std::string>&)> fnSetVehicle);
    
    
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

     static void SetVehicleEx(const std::vector<std::string>& vctVehDir, const std::vector<std::string>& vctVehName, const std::vector<std::string>& vctSoftCode);
     
    注  意：诊断设置当前车辆车型
            AUTOVIN获取VIN码的途径，优先通过GETVIN来获取，其次可以从车辆通讯中获取
    -----------------------------------------------------------------------------*/
    static void SetVehicleEx(std::function<void(const std::vector<std::string>&,const std::vector<std::string>&,const std::vector<std::string>&)> fnSetVehicleEx);
    
    /*
    *   注册CArtiGlobal静态成员函数SetVehInfo的回调函数
    *
    *   static void SetVehInfo(const std::string& strVehInfo));
    *
    *   SetVehInfo 函数说明见 ArtiGlobal.h
    */
    static void SetVehInfo(std::function<void(const std::string&)> fnSetVehInfo);

    /*
    *   注册CArtiGlobal静态成员函数SetSysName的回调函数
    *
    *   static void SetSysName(const std::string& strSysName));
    *
    *   SetSysName 函数说明见 ArtiGlobal.h
    */
    static void SetSysName(std::function<void(const std::string&)> fnSetSysName);

    /*
    *   注册CArtiGlobal静态成员函数 SetAdasMMYS 的回调函数
    *
    *   static void SetAdasMMYS(const std::string& strMake, const std::string& strModel, const std::string& strYear, const std::string& strSys);
    *
    *   SetAdasMMYS 函数说明见 ArtiGlobal.h
    */
    static void SetAdasMMYS(std::function<void(const std::string&, const std::string&, const std::string&, const std::string&)> fnSetAdasMMYS);
    
    /*
    *   注册CArtiGlobal静态成员函数GetAdasCalData的回调函数
    *
    *   static float GetAdasCalData(eAdasCaliData eAcdType);
    *
    *   GetAdasCalData 函数说明见 ArtiGlobal.h
    */
    static void GetAdasCalData(std::function<float(uint32_t)> fnGetAdasCalData);
    
    /*
    *   注册CArtiGlobal静态成员函数GetHistoryRecord的回调函数
    *
    *   static std::string const GetHistoryRecord();
    *
    *   GetHistoryRecord 函数说明见 ArtiGlobal.h
    */
    static void GetHistoryRecord(std::function<const std::string()> fnGetHistoryRecord);

    /*
    *   注册CArtiGlobal静态成员函数SetHistoryRecord的回调函数
    *
    *   static void SetHistoryRecord(const std::string& strRecord));
    *
    *   SetHistoryRecord 函数说明见 ArtiGlobal.h
    */
    static void SetHistoryRecord(std::function<void(const std::string&)> fnSetHistoryRecord);

    /*
    *   注册CArtiGlobal静态成员函数SetHistoryMileage的回调函数
    *
    *   static void SetHistoryMileage(const std::string& strMileage, const std::string& strMILOnMileage);
    *
    *   SetHistoryMileage 函数说明见 ArtiGlobal.h
    */
    static void SetHistoryMileage(std::function<void(const std::string&, const std::string&)> fnSetHistoryMileage);

    /*
    *   注册CArtiGlobal静态成员函数SetHistoryDtcItem的回调函数
    *
    *   static void SetHistoryDtcItem(const stDtcReportItemEx &DtcItem);
    *
    *   SetHistoryDtcItem 函数说明见 ArtiGlobal.h
    */
    static void SetHistoryDtcItem(std::function<void(const stDtcReportItemEx &)> fnSetHistoryDtcItem);

    /*
    *   注册CArtiGlobal静态成员函数 SetHistoryMMY 的回调函数
    *
    *   static uint32_t SetHistoryMMY(const std::string& strMake, const std::string& strModel, const std::string& strYear);
    *
    *   SetHistoryMMY 函数说明见 ArtiGlobal.h
    */
    static void SetHistoryMMY(std::function<uint32_t(const std::string&, const std::string&, const std::string&)> fnSetHistoryMMY);

    /*
    *   注册CArtiGlobal静态成员函数 SetHistoryEngine 的回调函数
    *
    *   static uint32_t SetHistoryEngine(const std::string& strInfo, const std::string& strSubType)
    *
    *   SetHistoryEngine 函数说明见 ArtiGlobal.h
    */
    static void SetHistoryEngine(std::function<uint32_t(const std::string&, const std::string&)> fnSetHistoryEngine);
    
    /*
    *   注册CArtiGlobal静态成员函数IsEntryFromHistory的回调函数
    *
    *   static bool IsEntryFromHistory();
    *
    *   IsEntryFromHistory 函数说明见 ArtiGlobal.h
    */
    static void IsEntryFromHistory(std::function<bool()> fnIsEntryFromHistory);
    
    /*
    *   注册CArtiGlobal静态成员函数Copy2RunPath的回调函数
    *
    *   static std::string const Copy2RunPath(const std::string& strSoName);
    *
    *   Copy2RunPath 函数说明见 ArtiGlobal.h
    */
    static void Copy2RunPath(std::function<std::string const(const std::string&)> fnCopy2RunPath);

    /*
    *   注册CArtiGlobal静态成员函数IsNetworkAvailable的回调函数
    *
    *   static bool IsNetworkAvailable();
    *
    *   IsNetworkAvailable 函数说明见 ArtiGlobal.h
    */
    static void IsNetworkAvailable(std::function<bool()> fnIsNetworkAvailable);
    
    /*
    *   注册CArtiGlobal静态成员函数GetTabletSN的回调函数
    *
    *   static std::string const GetTabletSN();
    *
    *   GetTabletSN 函数说明见 ArtiGlobal.h
    */
    static void GetTabletSN(std::function<const std::string()> fnGetTabletSN);

    /*
    *   注册CArtiGlobal静态成员函数GetTabletKey的回调函数
    *
    *   static std::string const GetTabletKey();
    *
    *   GetTabletKey 函数说明见 ArtiGlobal.h
    */
    static void GetTabletKey(std::function<const std::string()> fnGetTabletKey);
    
    /*
    *   注册CArtiGlobal静态成员函数GetHostType的回调函数
    *
    *   返回值:
    *        1        表示当前应用的主机是平板
    *        2        表示当前应用的主机是手机
    *
    *   static uint32_t const GetHostType();
    *
    *   GetHostType 函数说明见 ArtiGlobal.h
    */
    static void GetHostType(std::function<uint32_t()> fnGetHostType);
    
    /*
    *   注册CArtiGlobal静态成员函数GetAppProductName的回调函数
    *
    *   返回值:
    *        1        表示当前产品名为AD900
    *        2        表示当前产品名为AD200
    *        3        表示当前产品名为TOPKEY
    *        4        表示当前产品名为Ninja1000 Pro
    *
    *   static uint32_t const GetAppProductName();
    *
    *   GetAppProductName 函数说明见 ArtiGlobal.h
    */
    static void GetAppProductName(std::function<uint32_t()> fnGetAppProductName);
    
    /*
    *   注册CArtiGlobal静态成员函数GetDiagEntryType的回调函数
    *
    *   返回值:
    *        1        表示当前是通过，点击正常诊断下车标进入的车型
    *        2        表示当前是通过，点击保养下的车标进入的车型，例如AD200下的保养快捷菜单
    *
    *   static uint32_t const GetDiagEntryType();
    *
    *   GetDiagEntryType 函数说明见 ArtiGlobal.h
    */
    static void GetDiagEntryType(std::function<uint64_t()> fnGetDiagEntryType);
    
    /*
    *   注册CArtiGlobal静态成员函数GetDiagEntryTypeEx的回调函数
    *
    *   static std::vector<bool> const GetDiagEntryTypeEx();
    *
    *   GetDiagEntryTypeEx 函数说明见 ArtiGlobal.h
    */
    static void GetDiagEntryTypeEx(std::function<std::vector<bool> const()> fnGetDiagEntryTypeEx);
    
    /*
    *   注册CArtiGlobal静态成员函数GetDiagMenuMask的回调函数
    *
    *   static uint32_t const GetDiagMenuMask();
    *
    *   GetDiagMenuMask 函数说明见 ArtiGlobal.h
    */
    static void GetDiagMenuMask(std::function<uint64_t()> fnGetDiagMenuMask);
    
    /*
    *   注册CArtiGlobal静态成员函数GetAutoVinEntryType的回调函数
    *
    *   static uint32_t const GetAutoVinEntryType();
    *
    *   GetAutoVinEntryType 函数说明见 ArtiGlobal.h
    */
    static void GetAutoVinEntryType(std::function<uint32_t()> fnGetAutoVinEntryType);
    
    /*
    *   注册CArtiGlobal静态成员函数GetAppScenarios的回调函数
    *
    *   返回值:
    *        1        正式面向用户的使用场景，正常用户使用场景
    *        2        打开了对内使用场景的后门
    *
    *   static uint32_t const GetAppScenarios();
    *
    *   GetAppScenarios 函数说明见 ArtiGlobal.h
    */
    static void GetAppScenarios(std::function<uint32_t()> fnGetAppScenarios);

    /*
    *   注册CArtiGlobal静态成员函数UnitsConversion的回调函数
    *
    *   单位制转换，将相应的单位值转换成显示给用户的单位值
    *
    *   static stUnitItem UnitsConversion(const stUnitItem& uiSource);
    *
    *   UnitsConversion 函数说明见 ArtiGlobal.h
    */
    static void UnitsConversion(std::function<stUnitItem(const stUnitItem&)> fnUnitsConversion);
    
    /*
    *   注册CArtiGlobal静态成员函数GetCurUnitMode的回调函数
    *
    *   返回值:
    *        0        公制
    *        1        英制
    *
    *   static uint32_t const GetCurUnitMode();
    *
    *   GetCurUnitMode 函数说明见 ArtiGlobal.h
    */
    static void GetCurUnitMode(std::function<uint32_t()> fnGetCurUnitMode);
    
    /*
    *   注册CArtiGlobal静态成员函数fnRpcSend的回调函数
    *
    *   static uint32_t RpcSend(CAlgorithmData* pAlgoData);
    */
    // 发送算法数据给App，App会打包这些数据发送给服务器
    //
    // App透传数据到算法服务器，App根据此接口的数据进行HttpPost
    // 可能的请求是"发送算法信息", api/client/sendAlgorithmInformation
    /*
    *   int RpcSend(int32_t type, const uint8_t* pAlgorithmData, uint32_t length, uint32_t TimeOutMs);
    *
    *
    *   参 数:  int32_t type             算法服务器类型：
    *                                   0 算法服务器
    *                                   1 网络算法服务器
    *
    *           const uint8_t* pAlgorithmData   算法数据buffer的指针
    *           uint32_t length                 算法数据
    *           uint32_t TimeOutMs              发送超时，单位毫秒
    *   返 回:
    *              0， 发送执行成功
    *
    *             如果pAlgorithmData为空，返回-1
    *             如果length为0，返回-2
    *             如果此时网络没有连接，返回-3
    *             如果此时用户未没有登录服务器，返回-4
    *             如果此时Tokin失效，返回-5
    *             如果发送超时，返回-8
    *
    *   说 明：此接口可阻塞或非阻塞，stdshow调用App，App将此接口的数据发送给
    *          算法服务器，算法服务器返回的运算结果将在RpcRecv中
    *          返回给stdshow
    */
    static void RpcSend(std::function<int32_t(int32_t, const uint8_t*, uint32_t, uint32_t)> fnRpcSend);
    
    /*-----------------------------------------------------------------------------
       功能：设置AUTOVIN通讯的协议类型字串
             APP保存以便下次进车(AutoVin)调用GetAutoVinProtocol获取协议快速进入

       参数说明：strProtocol    诊断程序自己决定保存的协议字串信息

       返回值：无

       说  明：用于诊断程序AutoVin设置保存上一次的通讯协议，加快获取VIN类型
               国内版TOPVCI小车探
       -----------------------------------------------------------------------------*/
       static void SetAutoVinProtocol(std::function<void(const std::string&)> fnSetProtocol);


       /*-----------------------------------------------------------------------------
       功能：获取上次AUTOVIN通讯的协议类型字串
             APP返回SetAutoVinProtocol保存的协议字串

       参数说明：无

       返回值：返回上次AUTOVIN通过SetAutoVinProtocol保存的协议类型字串

       说  明：用于诊断程序AutoVin使用指定的协议类型去获取车辆VIN，实现快速获取VIN的功能
               国内版TOPVCI小车探
       -----------------------------------------------------------------------------*/
        static void GetAutoVinProtocol(std::function<const std::string()> fnGetAutoVinProtocol);
    
    
    /*-----------------------------------------------------------------------------
     *    功    能：单位制转换，将相应的单位值转换成显示给用户的单位值
     *
     *    参数说明：stUnitItem uiSource          需要转换的单位和值
     *
     *    返 回 值：转换后的单位和值
     *
     *              1234 千米 [km] = 766.7721 英里 [mi]
     *              例如：输入 ("km", "1234")
     *                    返回 ("mi.", "766.7721")
     -----------------------------------------------------------------------------*/
    static stUnitItem UnitsConversion(const stUnitItem& uiSource);



    /*-----------------------------------------------------------------------------
     *    功    能：获取当前车辆信息（服务器解析VIN的结果）
     *              车辆信息由APK根据当前车辆VIN从服务器请求到的VIN解析结果信息
     *
     *     参数说明：eGviValue    获取信息类型的宏值
     *
     *               GET_VIN_BRAND               = 0,     //  品牌ID值
     *               GET_VIN_MODEL               = 1,     //  车型ID值
     *               GET_VIN_MANUFACTURER_NAME   = 2,     //  厂家名称
     *               GET_VIN_YEAR                = 3,     //  年份
     *               GET_VIN_CLASSIS             = 4,     //  底盘号
     *               GET_VIN_MANUFACTURER_TYPE   = 5,     //  厂家类型
     *               GET_VIN_VEHICLE_TYPE        = 6,     //  车辆类型
     *               GET_VIN_FULE_TYPE           = 7,     //  燃油类型
     *               GET_VIN_ENERGY_TYPE         = 8,     //  能源类型
     *               GET_VIN_COUNTRY             = 9,     //  国家
     *               GET_VIN_AREA                = 10,    //  区域
     *
     *
     *    返 回 值：服务器返回的VIN码信息ID值（十六进制串）
     -----------------------------------------------------------------------------*/
    static void GetServerVinInfo(std::function<const std::string(uint32_t)> fnGetServerVinInfo);

    
    /*-----------------------------------------------------------------------------
     *    功    能：获取当前车辆信息（服务器解析VIN的结果），不是ID
     *              车辆信息由APK根据当前车辆VIN从服务器请求到的VIN解析结果信息
     *
     *     参数说明：eGviValue    获取信息类型的宏值
     *
     *               GET_VIN_BRAND               = 0,     品牌
     *               GET_VIN_MODEL               = 1,     车型
     *               GET_VIN_MANUFACTURER_NAME   = 2,     厂家名称
     *               GET_VIN_YEAR                = 3,     年份
     *               GET_VIN_CLASSIS             = 4,     底盘号
     *               GET_VIN_MANUFACTURER_TYPE   = 5,     厂家类型
     *               GET_VIN_VEHICLE_TYPE        = 6,     车辆类型
     *               GET_VIN_FULE_TYPE           = 7,     燃油类型
     *               GET_VIN_ENERGY_TYPE         = 8,     能源类型
     *               GET_VIN_COUNTRY             = 9,     国家
     *               GET_VIN_AREA                = 10,    区域
     *
     *
     *    返 回 值：服务器返回的VIN码信息
     *
     *    注    意：此接口返回的都是值，不是ID
     -----------------------------------------------------------------------------*/
    static void GetServerVinInfoValue(std::function<std::vector<std::string>(uint32_t)> fnGetServerVinInfoValue);
    
        /*
        *   注册CArtiGlobal静态成员函数SetCurVehNotSupport的回调函数
        *
        *   static uint32_t SetCurVehNotSupport(uint32_t eType);
        *
        *   SetCurVehNotSupport 函数说明见 ArtiGlobal.h
        */
    static void SetCurVehNotSupport(std::function<uint32_t(uint32_t)> fnSetCurVehNotSupport);
    
    /*
    *   注册CArtiGlobal静态成员函数SetEventTracking的回调函数
    *
    *   static uint32_t SetEventTracking(eEventTrackingId eEventId, const std::vector<stTrackingItem> &vctPara)
    *
    *   SetEventTracking 函数说明见 ArtiGlobal.h
    */
    static void SetEventTracking(std::function<uint32_t(eEventTrackingId, const std::vector<stTrackingItem>&)> fnSetEventTracking);
    
    // 注册FcaInitSend函数
    // 发送FCA认证初始化数据给App，App打包这些数据发送给服务器
    // 即FcaAuthDiagInit接口的发送
    /*
    *   uint32_t FcaInitSend(String strSgwUUID, String strSgwSN, String strVin, uint32_t timsOutMs, uint32_t SnApi);
    *
    *   参 数:  strSgwUUID         ECU的UUID
    *           strSgwSN           ECU的SN
    *           strVin             车架号
    *           timsOutMs          发送超时时间，毫秒
    *           snApi              接口的序号（stdshow从0开始计数，诊断调用FcaAuthDiagInit一次加一）
    *                              App在SetFcaInitRecv中需要将此snApi值传回给stdshow
    *                              snApi参数诊断不可见
    *   返 回:
    *             0， 发送执行成功
    *
    *             如果此时网络没有连接，返回-3
    *             如果此时用户未没有登录服务器，返回-4
    *             如果此时Tokin失效，返回-5
    *
    *   说 明：此接口为非阻塞接口，立即返回，SO调用APK，APK将此接口的数据发送给
    *          服务器，服务器返回的运算结果将在SetFcaInitRecv中返回给JNI
    */
    static void FcaInitSend(std::function<uint32_t(const std::string&, const std::string&, const std::string&,const std::string&, const std::string&, const std::string&, uint32_t, uint32_t)> fnFcaInitSend);
    
    
    // 注册FcaRequestSend函数
    // 向FCA服务器转发认证数据给APK，APK会打包这些数据发送给服务器
    // 即FcaRequestSend接口的发送
    /*
    *   int FcaRequestSend(String strSessionID, String strChallenge, int timsOutMs, uint32_t SnApi);
    *
    *   参 数:  strSessionID       FcaAuthDiagInit返回的SessionID（Base64）
    *           strChallenge       ECU Challenge（Base64）
    *           timsOutMs          发送超时时间，毫秒
    *           snApi              接口的序号（stdshow从0开始计数，诊断调用FcaAuthDiagRequest一次加一）
    *                              App在SetFcaRequestRecv中需要将此snApi值传回给stdshow
    *                              snApi参数诊断不可见
    *
    *   返 回:
    *             0， 发送执行成功
    *
    *             如果此时网络没有连接，返回-3
    *             如果此时用户未没有登录服务器，返回-4
    *             如果此时Tokin失效，返回-5
    *
    *   说 明：此接口为非阻塞接口，立即返回，SO调用APK，APK将此接口的数据发送给
    *          服务器，服务器返回的运算结果将在SetFcaRequestRecv中返回给JNI
    */
    static void FcaRequestSend(std::function<uint32_t(const std::string&, const std::string&, uint32_t, uint32_t)> fnFcaRequestSend);

    // 注册FcaTrackSend函数
    // 即FcaAuthDiagTrackResp接口的发送
    /*
    *   int FcaTrackSend(String strSessionID, String strEcuResult, String strEcuResponse, int timsOutMs, uint32_t SnApi);
    *
    *   参 数:  strSessionID       FcaAuthDiagInit返回的SessionID（Base64）
    *           strEcuResult       ECU 解锁的结果（Boolean），例如"True"
    *           strEcuResponse     ECU Response（Base64），例如6712...，或者7F27...
    *           timsOutMs          发送超时时间，毫秒
    *           snApi              接口的序号（stdshow从0开始计数，诊断调用FcaAuthDiagTrackResp一次加一）
    *                              App在SetFcaAdTrackRecv中需要将此snApi值传回给stdshow
    *                              snApi参数诊断不可见
    *
    *   返 回:
    *             0， 发送执行成功
    *
    *             如果此时网络没有连接，返回-3
    *             如果此时用户未没有登录服务器，返回-4
    *             如果此时Tokin失效，返回-5
    *
    *   说 明：此接口为非阻塞接口，立即返回，SO调用APK，APK将此接口的数据发送给
    *          服务器，服务器返回的运算结果将在SetFcaAdTrackRecv中返回给JNI
    */
    static void FcaTrackSend(std::function<uint32_t(const std::string&, const std::string&, const std::string&, uint32_t, uint32_t)> fnFcaTrackSend);
    
    /*
    *   注册CArtiGlobal静态成员函数FcaGetLoginRegion的回调函数
    *
    *   返回值:
    *        0        表示App的FCA登录中，当前选择的区域是美洲
    *        1        表示App的FCA登录中，当前选择的区域是欧洲
    *        2        表示App的FCA登录中，当前选择的区域是其它
    *
    *   static eLoginRegionType FcaGetLoginRegion()
    *
    *   FcaGetLoginRegion 函数说明见 ArtiGlobal.h
    */
    static void FcaGetLoginRegion(std::function<uint32_t()> fnFcaGetLoginRegion);
    
    /*-----------------------------------------------------------------------------
     功能：获取当前AUTOVIN的协议扫描模式
     APP返回，是否用指定的协议去读取VIN，还是用正常的全协议扫描模式去获取VIN
     例如，国内版TOPVCI小车探
     
     参数说明：无
     
     返回值：  AVSM_MODE_NORMAL        = 1,  // 正常AUTOVIN协议扫描模式
     AVSM_MODE_LAST_PROTOCOL = 2,  // AUTOVIN使用上次保存的协议去读取VIN
     
     说  明：国内版TOPVCI小车探
     -----------------------------------------------------------------------------*/
    static void GetAutoVinScannMode(std::function<uint32_t()> GetAutoVinScannMode);
    
    
    /*
    *   注册CArtiGlobal静态成员函数GetObdEntryType的回调函数
    *
    *   static uint32_t const GetObdEntryType();
    *
    *   GetObdEntryType 函数说明见 ArtiGlobal.h
    */
    static void GetObdEntryType(std::function<uint32_t()> fnGetObdEntryType);

};
#endif
