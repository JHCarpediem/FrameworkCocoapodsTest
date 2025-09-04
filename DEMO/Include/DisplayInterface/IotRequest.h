/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 向IOT服务器请求接口定义
* 创 建 人 : sujiya 20201210
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __STD_IOT_REQUEST_H__
#define __STD_IOT_REQUEST_H__

#include "StdInclude.h"
#include "StdShowMaco.h"


// 向IOT服务器请求接口

// 诊断应用通过App向IOT服务器下载文件的大致流程
// 1、通过CIotRequest::JsonSendRecv获取下载路径URL
// 2、通过CIotRequest::StartDownload让App开始下载对应URL
// 3、通过CIotRequest::GetDownloadStatus获取下载的进度和状态
// 4、通过ArtiGlobal::GetDownloadFilePath获取下载的文件路径

/*--------------------------------------------------------------------------------------
说    明：下载状态和进度宏，CIotRequest接口GetDownloadStatus的返回值定义
--------------------------------------------------------------------------------------*/
#define DF_DOWNLOAD_ST_REQ            (0)     // 下载请求中
#define DF_DOWNLOAD_ST_1_PER          (1)     // 下载进度 1%
#define DF_DOWNLOAD_ST_2_PER          (2)     // 下载进度 2%
// ...
#define DF_DOWNLOAD_ST_OK             (100)   // 下载进度 100%，即下载完成

#define DF_DOWNLOAD_ST_ERR_OTHE       (-9)    // 下载错误（其它错误）
#define DF_DOWNLOAD_ST_ERR_URL        (-10)   // GetDownloadStatus 的 strUrl 错误
#define DF_DOWNLOAD_ST_ERR_ID         (-11)   // GetDownloadStatus 的 uIndex 错误
#define DF_DOWNLOAD_ST_FAILED         (-12)   // 下载失败

#define DF_BACKUP_HD_ST_OK            (100)   // 备份进度 100%，即备份完成
#define DF_BACKUP_HD_ST_ERR_PATH      (-10)   // StartHiddenBk 的 strBackupPath 错误
#define DF_BACKUP_HD_ST_ERR_ID        (-11)   // GetHiddenBkStat 的 uIndex 错误
#define DF_BACKUP_HD_ST_FAILED        (-12)   // 备份失败

class _STD_SHOW_DLL_API_ CIotRequest
{
public:
    enum eDlStatus
    {
        DL = 0,    // ADAS校准OK
        RAR_ADAS_CALI_FAILED = 1,    // ADAS校准失败
    };

public:
    CIotRequest();
    ~CIotRequest();

public:
    /*-------------------------------------------------------------------------------------------------------------------------------------------------------------
     *   功   能： 向IOT服务器透传接口数据，App将解释参数strJson的内容，并将参数和内容填到请求IOT的接口，请求后将响应数据JSON格式返回
     *
     *   参数说明：
    *           strApiPath    API接口的路径，即表示哪个接口，绝对路径
    *                         例如, "/api/v1/platBaesinfo/obfcm/save"
    *
    *           strJsonReq       JSON格式的请求数据，App需要解释JSON字串内容，并将对应的参数填至strApiPath上，即透传诊断应用的JSON到IOT
    *
    *           strJsonAns       JSON格式的响应数据，App将IOT在strApiPath指定的接口返回的数据，透传给诊断应用
    *
    *           TimeOutMs     超时时间，指定时间内如果还没有成功，直接失败返回-6
    *
    *           strJsonReq参数举例:
    *           {
    *              "vehicleInfo" : {
    *                 "app" : {
    *                    "name" : 1,
    *                    "version" : 16842784
    *                 },
    *                 "chargeDeplFuel" : 25096743.920,
    *                 "chargeDeplOprEngineOff" : 116223367.20,
    *                 "chargeDeplOprEngineOn" : 129697772.80,
    *                 "chargeIncrFuel" : 26444184.480,
    *                 "chargeIncrOpr" : 143172181.60,
    *                 "companyId" : "",
    *                 "energyIntoBattery" : 358762696.80,
    *                 "language" : "cn",
    *                 "saveDate" : "1740652012",
    *                 "saveTime" : "2025-02-27 18:26:52",
    *                 "sn" : "FFFFFFFFFFFFFFFF",
    *                 "totLifetimeDist" : "",
    *                 "totLifetimeFuel" : "",
    *                 "vin" : "1FV3A23C2H3181097"
    *              }
    *           }
    * 
    *   返 回 值：服务器认证请求的返回结果，在参数strJsonAns中以JSON形式返回
    *             如果调用服务器接口调用成功，返回0
    *
    *             如果此时网络没有连接，返回-3
    *             如果此时用户没有登录服务器，返回-4
    *             如果此时Token失效，返回-5
    *             如果strApiPath或者strJsonReq为空或空串，返回-10
    *             如果strApiPath或者strJsonReq解析错误，返回-11
    *             其它错误，当前统一返回-9
    *             
    *             此接口为阻塞接口，直至服务器返回数据（如果在TimeOutMs时间内，接口形
    *             参默认为1分半钟内(90秒)，APK都没有数据返回将返回"-6"，失败）
    *             如果当前APP版本还没有此接口，返回DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
    *             
    *   注  意:   此接口具有通用性，不仅仅只针对具体的一个接口
    -------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static uint32_t JsonSendRecv(const std::string& strApiPath, const std::string& strJsonReq, std::string& strJsonAns, uint32_t TimeOutMs = 90 * 1000);

    

   /*-------------------------------------------------------------------------------------------------------------------------------------------------------------
    *   功   能： 向IOT服务器请求下载对应的URL文件
    *
    *   参数说明：strUrl     对应的URL地址，表示需要下载的文件地址
    *                        此URL地址通过 JsonSendRecv 接口获取到
    *
    *   返 回 值：App开启下载任务的唯一ID，区分不同的下载任务
    *             如果调用服务器接口调用成功，返回对应的下载ID（由App生成，在获取下载进度时使用）
    *
    *             如果此时网络没有连接，返回-3
    *             如果此时用户没有登录服务器，返回-4
    *             如果此时Token失效，返回-5
    *             如果 strUrl 无效或者解析错误，返回 DF_DOWNLOAD_ST_ERR_URL(-10)
    *             其它错误，当前统一返回-9
    *
    *             此接口为阻塞接口，直至服务器返回数据（开始下载）
    *             如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
    *             如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, 
    *
    *   注  意:   此接口具有通用性，不仅仅只针对具体的某一个功能
    -------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static uint32_t StartDownload(const std::string& strUrl);


   /*-------------------------------------------------------------------------------------------------------------------------------------------------------------
    *   功   能： 获取App当前下载对应URL文件的下载状态
    * 
    *             非阻塞接口，立即返回，诊断应用可以在任何时候调用此接口获取指定下载任务的状态
    *
    *   参数说明：strUrl     对应的URL地址，表示 StartDownload 需要下载的文件URL地址
    *                        如果对应的URL地址跟 StartDownload 不一致，返回DF_DOWNLOAD_ST_ERR_URL(-10)
    * 
    *             uIndex     StartDownload返回的下载ID，用于标记对应的下载任务
    *                        如果对应的uIndex跟 StartDownload 不一致，返回DF_DOWNLOAD_ST_ERR_ID(-11)
    * 
    *
    *   返 回 值：当前App下载对应URL文件的状态
    *             如果调用服务器接口成功，返回对应下载ID任务的状态，例如下载进度百分比
    *             如果当前下载进度已经完成了1%，则返回1
    *             如果当前下载进度已经完成了50%，则返回50
    *             如果当前下载进度已经完成了100%，则返回DF_DOWNLOAD_ST_OK(100)
    *
    *             如果此时网络没有连接，返回-3
    *             如果此时用户没有登录服务器，返回-4
    *             如果此时Token失效，返回-5
    *             如果 strUrl 无效或者解析错误，返回 DF_DOWNLOAD_ST_ERR_URL(-10)
    *             如果 uIndex 无效，返回 DF_DOWNLOAD_ST_ERR_ID(-11)
    *             如果 下载失败，返回 DF_DOWNLOAD_ST_FAILED(-12)
    *             其它错误，当前统一返回-9
    *
    *             如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
    *             如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION,
    *
    *   注  意:   strUrl与uIndex必须一致
    -------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static uint32_t GetDownloadStat(const std::string& strUrl, uint32_t uIndex);


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------------
     *   功   能： 获取App当前下载对应URL文件的下载路径（全路径）
     *
     *             非阻塞接口，立即返回，诊断应用在确保已下载完成后，调用此接口获取下载的文件路径
     *
     *   参数说明：strUrl     对应的URL地址，表示 StartDownload 需要下载的文件URL地址
     *                        如果对应的URL地址跟 StartDownload 不一致，返回DF_DOWNLOAD_ST_ERR_URL(-10)
     *
     *             uIndex     StartDownload返回的下载ID，用于标记对应的下载任务
     *                        如果对应的uIndex跟 StartDownload 不一致，返回DF_DOWNLOAD_ST_ERR_ID(-11)
     *
     *
     *   返 回 值：当前App已下载对应URL文件的本地存储路径
     *             如果App下载成功，返回对应下载ID任务的本地存储路径
     *
     *             其它错误，当前统一返回空串
     * 
     *   注  意:   strUrl与uIndex必须一致
     -------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static std::string const GetDownloadPath(const std::string& strUrl, uint32_t uIndex);


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------------
     *   功   能： 向IOT服务器请求备份刷隐藏数据包
     *             App负责将文件夹数据打包成zip格式，并将zip文件上传到IOT服务器
     *
     *   参数说明：uBackupType      备份类型，0表示正常备份，1表示静默备份
     *
     *             strBackupPath    需要备份的文件路径，表示需要备份的文件夹（文件夹里含有的所有文件及子文件夹）
     *             strBackupJsonReq 需要备份的参数集合，json格式
     *                              例如：
     *                                  {
     *                                    "sn": "1233",
     *                                    "softCode": "1223",
     *                                    "vin": "1FV3A23C2H3181097",
     *                                    "backupType": 1,
     *                                    "searchId": "12323",  // 备份此次数据的id，用于通过id获取备份文件。BMW规则为VIN+功能ID拼接
     *                                    "name": "as",
     *                                    "contentType": 1,
     *                                  }
     *
     *   返 回 值：App开启备份刷隐藏任务的唯一ID，区分不同的刷隐藏备份任务
     *
     *             如果此时网络没有连接，返回-3
     *             如果此时用户没有登录服务器，返回-4
     *             如果此时Token失效，返回-5
     *             其它错误，当前统一返回-9
     *
     *             如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
     *             如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION,
     *
     *   注  意:   
     -------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static uint32_t StartHiddenBk(uint32_t uBackupType, const std::string& strBackupPath, const std::string& strBackupJsonReq);


    /*-------------------------------------------------------------------------------------------------------------------------------------------------------------
     *   功   能： 获取App当前上传刷隐藏备份数据包的状态
     * 
     *             非阻塞接口，立即返回，诊断应用可以在任何时候调用此接口获取指定备份任务的状态
     *
     *   参数说明：strBkPath   对应的备份文件夹路径，表示 StartHiddenBk 需要备份的路径地址
     *                         如果对应的路径跟 StartHiddenBk 不一致，返回DF_BACKUP_HD_ST_ERR_PATH(-10)
     *
     *             uIndex     StartHiddenBk返回的备份ID，用于标记对应的备份任务
     *                        如果对应的uIndex跟 StartHiddenBk 不一致，返回DF_BACKUP_HD_ST_ERR_ID(-11)
     *
     *
     *   返 回 值：当前App上传刷隐藏备份数据包的状态
     *             如果当前备份进度已经完成了1%，则返回1
     *             如果当前备份进度已经完成了50%，则返回50
     *             如果当前备份进度已经完成了100%，则返回DF_BACKUP_HD_ST_OK(100)
     *
     *             如果此时网络没有连接，返回-3
     *             如果此时用户没有登录服务器，返回-4
     *             如果此时Token失效，返回-5
     *             如果 strUrl 无效或者解析错误，返回 DF_BACKUP_HD_ST_ERR_PATH(-10)
     *             如果 uIndex 无效，返回 DF_BACKUP_HD_ST_ERR_ID(-11)
     *             如果 备份失败，返回 DF_BACKUP_HD_ST_FAILED(-12)
     *             其它错误，当前统一返回-9
     *
     *             如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
     *             如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION,
     *
     *   注  意:   strBkPath 与 uIndex 必须与 StartHiddenBk 中的一致
     -------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    static uint32_t GetHiddenBkStat(const std::string& strBkPath, uint32_t uIndex);


private:
    void* m_pData = NULL;
};
#endif // __STD_IOT_REQUEST_H__
