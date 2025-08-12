//
//  TDD_ArtiIotRequestModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/5/29.
//

#import "TDD_ArtiIotRequestModel.h"
#if useCarsFramework
#import <CarsFramework/RegIotRequest.hpp>
#else
#import "RegIotRequest.hpp"
#endif

#import "TDD_CTools.h"
@implementation TDD_ArtiIotRequestModel
#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    CRegIotRequest::JsonSendRecv(ArtiIotRequestJsonSendRecv);
    
}

static uint32_t ArtiIotRequestJsonSendRecv(const std::string& strApiPath, const std::string& strJsonReq, std::string& strJsonAns, uint32_t TimeOutMs = 90 * 1000) {
    return [TDD_ArtiIotRequestModel iotRequestJsonSendRecv:[TDD_CTools CStrToNSString:strApiPath] strJsonReq:[TDD_CTools CStrToNSString:strJsonReq] strJsonAns:strJsonAns timeOutMs:TimeOutMs];
    
}

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

+ (uint32_t )iotRequestJsonSendRecv:(NSString *)strApiPath strJsonReq:(NSString *)strJsonReq strJsonAns:(std::string&)strJsonAns timeOutMs:(uint32_t)timeOutMs {
    
    HLog(@"iotRequestJsonSendRecv strApiPath: %@,strJsonReq: %@,strJsonAns:%@,timeOutMs:%ld", strApiPath,strJsonReq,[TDD_CTools CStrToNSString:strJsonAns],timeOutMs);
    
    if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
        HLog(@"renaultDiagRequest 无网络");
        return -3;
    }
    if (![[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
        HLog(@"renaultDiagRequest代理未实现");
        return -9;
    }
    
    if ([NSString tdd_isEmpty:strApiPath] || [NSString tdd_isEmpty:strJsonReq]) {
        NSLog(@"iotRequestJsonSendRecv strApiPath 或 strJsonReq 为空");
        return -10;
    }
    
    NSData *jsonData = [strJsonReq dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    if (error) {
        return -11;
        NSLog(@"iotRequestJsonSendRecv strJsonReq 解析失败: %@", error.localizedDescription);
    }
    NSMutableDictionary *mParam = param.mutableCopy;
    [mParam setValue:strApiPath?:@"" forKey:@"strApiPath"];
    [mParam setValue:@(timeOutMs) forKey:@"timeOut"];
    __block int returnValue = 0;
    // 创建一个信号量，初始值为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_IotRequest param:mParam completeHandle:^(id  _Nonnull result) {
        NSDictionary *responsDic = result;
        NSInteger code = [responsDic tdd_getIntValueForKey:@"code" defaultValue:-1];
        NSString *codeStr = [NSString stringWithFormat:@"%ld",(long)code];
        NSString *msg = responsDic[@"msg"];
        if ([NSString tdd_isEmpty:msg]) {
            msg = @"";
        }
        if (![TDD_DiagnosisTools userIsLogin]) { // 再次登录失败
            HLog(@"iotRequestJsonSendRecv: 未登录");
            returnValue = -4;
        } else {
            if (code != -1) {
                if (code == 2000) {

                }else if(code == -1001){
                    returnValue = -6;
                    HLog(@"iotRequestJsonSendRecv: 接口超时");
                }
                else{
                    HLog(@"iotRequestJsonSendRecv: 接口失败");
                    //失败
                    returnValue = -9;
                }
            }else {
                //失败并且没有code
                HLog(@"iotRequestJsonSendRecv: 接口失败并且没有 code");
                returnValue = - 9;
                
            }
        }
        if (responsDic) {
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responsDic
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];

            if (error) {
                NSLog(@"iotRequestJsonSendRecv JSON 序列化失败: %@", error.localizedDescription);
            } else {
                @autoreleasepool {
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    strJsonAns = [TDD_CTools NSStringToCStr:jsonString];
                    NSLog(@"iotRequestJsonSendRecv JSON 字符串:\n%@", jsonString);
                }
            }
        }
        // 网络请求完成后，发送信号
        dispatch_semaphore_signal(semaphore);
    }];
    
    // 等待信号量，阻塞当前线程直到信号量被触发
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    HLog(@"iotRequestJsonSendRecv returnValue: %d", returnValue);
    return returnValue;
}
@end
