//
//  TDD_ArtiVehAutoAuthModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/8/12.
//

#import "TDD_ArtiVehAutoAuthModel.h"

#if useCarsFramework
#import <CarsFramework/RegVehAutoAuth.hpp>
#else
#import "RegVehAutoAuth.hpp"
#endif

#import "TDD_CTools.h"
@implementation TDD_ArtiVehAutoAuthModel
#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CRegVehAutoAuth::Construct(ArtiAutoAuthModelConstruct);
    CRegVehAutoAuth::Destruct(ArtiAutoAuthModelDestruct);
    CRegVehAutoAuth::SetBrandType(ArtiAutoAuthModelSetBrandType);
    CRegVehAutoAuth::SetVehBrand(ArtiAutoAuthModelSetVehBrand);
    CRegVehAutoAuth::SetVehModel(ArtiAutoAuthModelSetVehModel);
    CRegVehAutoAuth::SetSystemName(ArtiAutoAuthModelSetSystemName);
    CRegVehAutoAuth::SetEcuTocken(ArtiAutoAuthModelSetEcuTocken);
    
    CRegVehAutoAuth::SetVin(ArtiAutoAuthModelSetVin);
    CRegVehAutoAuth::SetEcuUnlockType(ArtiAutoAuthModelSetEcuUnlockType);
    CRegVehAutoAuth::SetEcuPublicServiceData(ArtiAutoAuthModelSetEcuPublicServiceData);
    CRegVehAutoAuth::SetEcuChallenge(ArtiAutoAuthModelSetEcuChallenge);
    CRegVehAutoAuth::SetEcuCanId(ArtiAutoAuthModelSetEcuCanId);
    CRegVehAutoAuth::SetXRoutingPolicy(ArtiAutoAuthModelSetXRoutingPolicy);
    CRegVehAutoAuth::GetRespondCode(ArtiAutoAuthModelGetRespondCode);
    CRegVehAutoAuth::GetRespondMsg(ArtiAutoAuthModelGetRespondMsg);
    CRegVehAutoAuth::GetEcuChallenge(ArtiAutoAuthModelGetEcuChallenge);
    CRegVehAutoAuth::SendRecv(ArtiAutoAuthModelSendRecv);
    
}

void ArtiAutoAuthModelConstruct(uint32_t id)
{
    [TDD_ArtiVehAutoAuthModel Construct:id];
}

void ArtiAutoAuthModelDestruct(uint32_t id)
{
    [TDD_ArtiVehAutoAuthModel Destruct:id];
}

uint32_t ArtiAutoAuthModelSetBrandType(uint32_t id, const uint32_t brandType)
{
    return [TDD_ArtiVehAutoAuthModel setBrandType:id brandType:brandType];
}

uint32_t ArtiAutoAuthModelSetVehBrand(uint32_t id, const std::string& strBrand)
{
    return [TDD_ArtiVehAutoAuthModel setVehBrand:id strBrand:[TDD_CTools CStrToNSString:strBrand]];
}

uint32_t ArtiAutoAuthModelSetVehModel(uint32_t id, const std::string& strModel)
{
    return [TDD_ArtiVehAutoAuthModel setVehModel:id strModel:[TDD_CTools CStrToNSString:strModel]];
}

uint32_t ArtiAutoAuthModelSetSystemName(uint32_t id, const std::string& strSysName)
{
    return [TDD_ArtiVehAutoAuthModel setSystemName:id strSysName:[TDD_CTools CStrToNSString:strSysName]];
}

uint32_t ArtiAutoAuthModelSetEcuTocken(uint32_t id, const std::string& strChallenge)
{
    return [TDD_ArtiVehAutoAuthModel setEcuTocken:id strChallenge:[TDD_CTools CStrToNSString:strChallenge]];
}

uint32_t ArtiAutoAuthModelSetVin(uint32_t id, const std::string& strVin)
{
    return [TDD_ArtiVehAutoAuthModel setVin:id vin:[TDD_CTools CStrToNSString:strVin]];
}

uint32_t ArtiAutoAuthModelSetEcuUnlockType(uint32_t id, const std::string& strType)
{
    return [TDD_ArtiVehAutoAuthModel setEcuUnlockType:id strType:[TDD_CTools CStrToNSString:strType]];
}

uint32_t ArtiAutoAuthModelSetEcuPublicServiceData(uint32_t id, const std::string& strData)
{
    return [TDD_ArtiVehAutoAuthModel setEcuPublicServiceData:id strData:[TDD_CTools CStrToNSString:strData]];
}

uint32_t ArtiAutoAuthModelSetEcuChallenge(uint32_t id, const std::string& strSeed)
{
    return [TDD_ArtiVehAutoAuthModel setEcuChallenge:id strSeed:[TDD_CTools CStrToNSString:strSeed]];
}

uint32_t ArtiAutoAuthModelSetEcuCanId(uint32_t id, const std::string& strCanID)
{
    return [TDD_ArtiVehAutoAuthModel setEcuCanId:id strCanID:[TDD_CTools CStrToNSString:strCanID]];
}

uint32_t ArtiAutoAuthModelSetXRoutingPolicy(uint32_t id, const std::string& strPolicy)
{
    return [TDD_ArtiVehAutoAuthModel setXRoutingPolicy:id strPolicy:[TDD_CTools CStrToNSString:strPolicy]];
}

const std::string ArtiAutoAuthModelGetRespondCode(uint32_t id)
{
    return [TDD_CTools NSStringToCStr:[TDD_ArtiVehAutoAuthModel getRespondCode:id]];
}

const std::string ArtiAutoAuthModelGetRespondMsg(uint32_t id)
{
    return [TDD_CTools NSStringToCStr:[TDD_ArtiVehAutoAuthModel getRespondMsg:id]];
}

const std::string ArtiAutoAuthModelGetEcuChallenge(uint32_t id)
{
    return [TDD_CTools NSStringToCStr:[TDD_ArtiVehAutoAuthModel getEcuChallenge:id]];
}

uint32_t ArtiAutoAuthModelSendRecv(uint32_t id, uint32_t Type, uint32_t TimeOutMs)
{
    return [TDD_ArtiVehAutoAuthModel sendRecv:id type:Type timeOutMs:TimeOutMs];
}
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
+ (uint32_t)setBrandType:(uint32_t)ID brandType:(uint32_t)brandType
{
    HLog(@"%@ - 设置 BrandType - ID:%d - brandType:%d",[self class],ID,brandType);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    NSArray *arr = @[@(BT_VEHICLE_TOPDON),@(BT_VEHICLE_FCA),@(BT_VEHICLE_RENAULT),@(BT_VEHICLE_NISSAN),@(BT_VEHICLE_MITSUBISHI),@(BT_VEHICLE_VW_SFD),@(BT_VEHICLE_DEMO),@(BT_VEHICLE_INVALID)];
    
    if (![arr containsObject:@(brandType)]) {
        return DF_CUR_BRAND_APP_NOT_SUPPORT;
    }
    //根据服务器返回判断。 后续 NASTF也需要
    if (brandType == BT_VEHICLE_VW_SFD && !([TDD_DiagnosisManage sharedManage].functionConfigMask & 16)) {
        return DF_CUR_BRAND_APP_NOT_SUPPORT;
    }
    model.brandType = (eBrandType)brandType;

    return 1;
}

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

+ (uint32_t)setVehBrand:(uint32_t)ID strBrand:(NSString *)strBrand
{
    HLog(@"%@ - 设置 VehBrand - ID:%d - strBrand:%d",[self class],ID,strBrand);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strBrand = strBrand;
    if (![NSString tdd_isEmpty:strBrand]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand = strBrand;
    }
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置车辆对应的型号，用于网关解锁数据上报

  参数说明：strModel 车辆型号, Model
                     例如，"奥迪A3"

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
            DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：无
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setVehModel:(uint32_t)ID strModel:(NSString *)strModel
{
    HLog(@"%@ - 设置 VehModel - ID:%d - strModel:%d",[self class],ID,strModel);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strModel = strModel;
    if (![NSString tdd_isEmpty:strModel]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel = strModel;
    }
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置网关算法解锁接口的ECU名称，用于网关解锁数据上报

  参数说明：strSysName 系统名称
                       例如，"19 - 数据总线诊断接口"

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
            DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：用于网关解锁或者网关解锁数据上报
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setSystemName:(uint32_t)ID strSysName:(NSString *)strSysName
{
    HLog(@"%@ - 设置 SystemName - ID:%d - strSysName:%d",[self class],ID,strSysName);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strSysName = strSysName;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置网关算法接口的ECU（securityKey）数据，也叫做ecuChallenge（SFD中称为Tocken）

            用于网关解锁结果上报至公司服务器（数据追踪），当前为大众SFD解锁数据上报

  参数说明：strChallenge     发给ECU的KEY数据，即securityKey，对应SFD界面的Tocken
                             即IOT接口unlockReport的token参数

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：适用于大众SFD解锁数据上报接口的参数设置，或者其它途径解锁（非原厂算法服务器）
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setEcuTocken:(uint32_t)ID strChallenge:(NSString *)strChallenge
{
    HLog(@"%@ - 设置 EcuTocken - ID:%d - strChallenge:%d",[self class],ID,strChallenge);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strChallenge = strChallenge;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置网关算法接口的车辆车架号

  参数说明：strVin 车辆车架号

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setVin:(uint32_t)ID vin:(NSString *)vin
{
    HLog(@"%@ - 设置 Vin - ID:%d - Vin:%@",[self class],ID,vin);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.vin = vin;
    if (![NSString tdd_isEmpty:vin]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarVIN = vin;
    }
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置网关算法接口的ECU解锁类型，ecuUnlockType

  参数说明：strType     ECU解锁类型
            
            举例1："UnlockUdsECU"
                -> Unlock the ECU using UDS protocole and Asymetric or Symetric Unlocking Algorithm

            举例2："UnlockSpecBcEcu" -> Unlock the ECU using SpecB protocole

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：适用于雷诺，日产网关算法
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setEcuUnlockType:(uint32_t)ID strType:(NSString *)strType
{
    HLog(@"%@ - 设置 EcuUnlockType - ID:%d - strType:%@",[self class],ID,strType);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strType = strType;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置网关算法接口的ECU公共服务数据，即 ECU-public-service-data，ecuPublicServiceData

  参数说明：strData     ECU公共服务数据，即识别要用于相应ECU的id
                        只有当ECU解锁类型=UnlockUdsECU时，此参数才是必需的
                        即调用SetEcuUnlockType接口设置了UnlockUdsECU时，此参数才是必需的

            举例：“424F53434845434D”，即是 BOSCHECM 的十六进制值

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：适用于雷诺，日产网关算法
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setEcuPublicServiceData:(uint32_t)ID strData:(NSString *)strData
{
    HLog(@"%@ - 设置 EcuPublicServiceData - ID:%d - strData:%@",[self class],ID,strData);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strData = strData;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
  功    能：设置网关算法接口的ECU种子数据，ecuChallenge或者ecuSecuritySeed

            FCA，即 ECU Challenge（Base64）
            Renault 即 ECU-security-seed

  参数说明：strSeed     ECU返回的种子数据

  返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

            设置成功返回1
            其它返回值，暂无意义

  说    明：适用于FCA，雷诺，日产等网关算法
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setEcuChallenge:(uint32_t)ID strSeed:(NSString *)strSeed
{
    HLog(@"%@ - 设置 EcuChallenge - ID:%d - strSeed:%@",[self class],ID,strSeed);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strSeed = strSeed;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
功    能：设置网关算法接口的ECU的ID，ecuCANID，ecu-address

        欧洲FCA，明确指定了是需要解锁的ECU的CANID，例如 "18DA10F1"是ECM，"18DA1020"是BSM
        北美FCA，可为空
        Renault  即 ECU Address used to identify the given ECU

参数说明：strCanID     ECU的CANID

返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
          DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

          设置成功返回1
          其它返回值，暂无意义

说    明：适用于FCA，雷诺，日产等网关算法
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setEcuCanId:(uint32_t)ID strCanID:(NSString *)strCanID
{
    HLog(@"%@ - 设置 EcuCanId - ID:%d - strCanID:%@",[self class],ID,strCanID);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strCanID = strCanID;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
功    能：设置网关算法接口的x-routing-policy, routingPolicy, 适用于雷诺

参数说明：strPolicy     路由策略值

                        This parameter set by the consumer is mandatory to access security access
                        service developed in release R5

          举例："SecurityAccessV2_9"

返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
          DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
 DF_CUR_BRAND_APP_NOT_SUPPORT，当前App还不支持所设置的车辆品牌网关算法

          设置成功返回1
          其它返回值，暂无意义

说    明：适用于雷诺等网关算法
-------------------------------------------------------------------------------------------------*/
+ (uint32_t)setXRoutingPolicy:(uint32_t)ID strPolicy:(NSString *)strPolicy
{
    HLog(@"%@ - 设置 XRoutingPolicy - ID:%d - strPolicy:%@",[self class],ID,strPolicy);
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    model.strPolicy = strPolicy;
    return 1;
}

/*-------------------------------------------------------------------------------------------------
功    能：获取公司服务器返回的错误代码 "code"，例如"200"

返 回 值：公司服务器返回的错误代码 "code"，例如"200"

说    明：适用于服务器算法透传，此接口需在SendRecv调用后去调用
-------------------------------------------------------------------------------------------------*/
+ (NSString *)getRespondCode:(uint32_t)ID
{
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    HLog(@"%@ - 获取 RespondCode - ID:%d - respondCode:%@",[self class],ID,model.respondCode);
    return model.respondCode;
}

/*-------------------------------------------------------------------------------------------------
功    能：获取公司服务器返回的描述 "msg"，例如"User authentication failed!"

返 回 值：公司服务器返回的描述 "msg"，例如"User authentication failed!"

说    明：适用于服务器算法透传，此接口需在SendRecv调用后去调用
-------------------------------------------------------------------------------------------------*/
+ (NSString *)getRespondMsg:(uint32_t)ID
{
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    HLog(@"%@ - 获取 RespondMsg - ID:%d - eespondMsg:%@",[self class],ID,model.respondMsg);
    return model.respondMsg;
}

/*-------------------------------------------------------------------------------------------------
功    能：获取OE服务器返回的Challenge

          FCA, SGW Challenge Response（Base64）
          Renault, ECU-security-seed 的响应


返 回 值：Challenge

说    明：适用于服务器算法透传，此接口需在SendRecv调用后去调用
-------------------------------------------------------------------------------------------------*/
+ (NSString *)getEcuChallenge:(uint32_t)ID
{
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    HLog(@"%@ - 获取 EcuChallenge - ID:%d - chanllenge - %@",[self class],ID,model.sgwChallengeResponse);
    return model.sgwChallengeResponse;
}

/*-----------------------------------------------------------------------------------------------------------
 *   功   能： 向OE服务器，或者TOPDON公司算法服务器，转发算法接口
 *             具体的
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
 *            SRT_VW_SFD_REPORT     表示当前请求的是公司产品数据中心的网关解锁数据上报接口
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
 -----------------------------------------------------------------------------------------------------------*/
+ (uint32_t)sendRecv:(uint32_t)ID type:(uint32_t)type timeOutMs:(uint32_t)timeOutMs
{
    
    HLog(@"ArtiVehAutoAuthSendRecv: ID-%d  type-%d timsOutMs-%u",ID,type,timeOutMs);
    [TDD_ArtiVehAutoAuthModel clearResponseData:ID];
    if (type == SRT_RENAULT_DIAG_REQ || type == SRT_NISSAN_DIAG_REQ) {
        return [TDD_ArtiVehAutoAuthModel renaultDiagRequest:ID type:type timeOutMs:timeOutMs];
    }else if (type == SRT_VW_SFD_REPORT) {
        return [TDD_ArtiVehAutoAuthModel uploadSFDReport:ID type:type timeOutMs:timeOutMs];
    }else {
        return -9;
    }

}

+ (uint32_t)renaultDiagRequest:(uint32_t)ID type:(uint32_t)type timeOutMs:(uint32_t)timeOutMs
{
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        HLog(@"renaultDiagRequest 无网络");
        return -3;
    }

    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"renaultDiagRequest代理未实现");
        return -9;
    }
    __block TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    if (!model) {
        HLog(@"renaultDiagRequest ID-%d 不存在",ID);
        return -9;
    }
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:@(model.brandType) forKey:@"brand"];
    [param setValue:model.vin?:@"" forKey:@"vin"];
    [param setValue:model.strType?:@"" forKey:@"ecuUnlockType"];
    [param setValue:model.strData?:@"" forKey:@"ecuPublicServiceData"];
    [param setValue:model.strSeed?:@"" forKey:@"ecuChallenge"];
    [param setValue:model.strCanID?:@"" forKey:@"ecuCANID"];
    [param setValue:model.strPolicy?:@"" forKey:@"routingPolicy"];
    [param setValue:[TDD_ArtiGlobalModel sharedArtiGlobalModel].authToken forKey:@"token"];
    [param setValue:@(2) forKey:@"source"];
    [param setValue:@(timeOutMs) forKey:@"timeOut"];
    [param setValue:[TDD_DiagnosisTools topdonID]?:@"" forKey:@"toolUserId"];
    NSString *snStr = [TDD_EADSessionController sharedController].SN;
    NSString *softCodeStr = [TDD_ArtiGlobalModel sharedArtiGlobalModel].softCode;
    if (![NSString tdd_isEmpty:snStr]) {
        [param setValue:snStr forKey:@"sn"];
    }
    if (![NSString tdd_isEmpty:softCodeStr]) {
        [param setValue:softCodeStr forKey:@"softCode"];
    }
    
    __block int returnValue = 0;
    // 创建一个信号量，初始值为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_AuthGateway param:param completeHandle:^(id  _Nonnull result) {
        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
        NSString *msg = responsDic[@"msg"];
        NSString *sgwChallengeResponse = @"";
        if (responsDic && [responsDic isKindOfClass:[NSDictionary class]]) {
            sgwChallengeResponse = [responsDic tdd_getStringValueForKey:@"sgwChallengeResponse" defaultValue:@""];
        }
        if ([NSString tdd_isEmpty:msg]) {
            msg = @"";
        }
        
        model.respondMsg = msg;
        model.respondCode = codeStr;

        if (![TDD_DiagnosisTools userIsLogin]) { // 再次登录失败
            HLog(@"renaultDiagRequest: 未登录");
            returnValue = -4;
        } else {
            if (code != -1) {
                if (code == 2000) {
                    //成功
                    model.sgwChallengeResponse = sgwChallengeResponse;
                }else if (code == 102055){
                    returnValue = -5;
                    HLog(@"renaultDiagRequest: 网关接口token过期");
                }else if(code == -1001){
                    returnValue = -6;
                    HLog(@"renaultDiagRequest: 接口超时");
                }
                else{
                    HLog(@"renaultDiagRequest: 接口失败");
                    //失败
                    returnValue = -9;
                }
            }else {
                //失败并且没有code
                HLog(@"renaultDiagRequest: 接口失败并且没有 code");
                returnValue = - 9;
                
            }
        }
        
        // 网络请求完成后，发送信号
        dispatch_semaphore_signal(semaphore);
    }];
    
    // 等待信号量，阻塞当前线程直到信号量被触发
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    HLog(@"renaultDiagRequest returnValue: %d", returnValue);
    return returnValue;
}

+ (uint32_t)uploadSFDReport:(uint32_t)ID type:(uint32_t)type timeOutMs:(uint32_t)timeOutMs
{
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        HLog(@"uploadSFDReport 无网络");
        return -3;
    }

    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"uploadSFDReport代理未实现");
        return -9;
    }
    __block TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    if (!model) {
        HLog(@"uploadSFDReport ID-%d 不存在",ID);
        return -9;
    }

    NSMutableDictionary *param = @{}.mutableCopy;
    [param setValue:[TDD_EADSessionController sharedController].SN?:@"" forKey:@"sn"];
    [param setValue:model.strBrand forKey:@"carBrandName"];
    [param setValue:model.vin?:@"" forKey:@"vin"];
    [param setValue:model.strModel?:@"" forKey:@"carType"];
    [param setValue:model.strSysName?:@"" forKey:@"systemName"];
    [param setValue:model.strSeed?:@"" forKey:@"unlockRequestInfo"];
    [param setValue:model.strChallenge?:@"" forKey:@"thirdToken"];
    [param setValue:[TDD_DiagnosisTools topdonID]?:@"" forKey:@"topdonId"];
    [param setValue:@(timeOutMs) forKey:@"timeOut"];
    
    __block int returnValue = 0;
    // 创建一个信号量，初始值为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_UploadUnlockReport param:param completeHandle:^(id  _Nonnull result) {
        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
        NSString *msg = responsDic[@"msg"];
        if ([NSString tdd_isEmpty:msg]) {
            msg = @"";
        }
        
        model.respondMsg = msg;
        model.respondCode = codeStr;

        if (![TDD_DiagnosisTools userIsLogin]) { // 再次登录失败
            HLog(@"uploadSFDReport: 未登录");
            returnValue = -4;
        } else {
            if (code != -1) {
                if (code == 2000) {
                    //成功

                }else if(code == -1001){
                    returnValue = -6;
                    HLog(@"uploadSFDReport: 接口超时");
                }else if (code == 401){
                    returnValue = -4;
                }
                else{
                    //失败
                    returnValue = -9;
                }
            }else {
                //失败并且没有code
                returnValue = - 9;
                
            }
        }
        
        // 网络请求完成后，发送信号
        dispatch_semaphore_signal(semaphore);
    }];
    
    // 等待信号量，阻塞当前线程直到信号量被触发
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    HLog(@"uploadSFDReport returnValue: %d", returnValue);
    return returnValue;
}

+ (void)clearResponseData:(uint32_t )ID
{
    TDD_ArtiVehAutoAuthModel *model = (TDD_ArtiVehAutoAuthModel *)[self getModelWithID:ID];
    
    if (!model) {
        HLog(@"%@ - clearResponseData ID-%d 不存在",[self class],ID);

    }else {
        model.respondMsg = @"";
        model.respondCode = @"";
        model.sgwChallengeResponse = @"";
    }
}

+ (NSInteger )mappingBrandType:(eBrandType)brandType {
    switch (brandType) {
        case BT_VEHICLE_TOPDON:
            return 0;
            break;
        case BT_VEHICLE_FCA:
            return 1;
            break;
        case BT_VEHICLE_RENAULT:
            return 2;
            break;
        case BT_VEHICLE_NISSAN:
            return 3;
            break;
        case BT_VEHICLE_MITSUBISHI:
            return 0;
            break;
        case BT_VEHICLE_VW_SFD:
            return 4;
            break;
        default:
            return 0;
            break;
    }
    
    
}
@end
