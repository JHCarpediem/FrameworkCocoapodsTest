//
//  TDD_StdShowModel.m
//  AD200
//
//  Created by 何可人 on 2022/6/14.
//

#import "TDD_StdShowModel.h"

#if useCarsFramework
#import <CarsFramework/StdShow.hpp>
#else
#import "StdShow.hpp"
#endif

#import "TDD_CTools.h"
@implementation TDD_StdShowModel

/* 显示接口初始化函数，加载此模块的时候调用（应用初始化libstdshow.a） */
+ (void)StdShowInit
{
    BLELog(@"stdShow - 初始化");
    CStdShow::Init();
}

/* 退出此模块的时候调用，一般不需要调用 */
+ (void)StdShowDeInit
{
    BLELog(@"stdShow - 退出模块");
    CStdShow::DeInit();
}

/* bFlag, true, 使能 printf */
/* bFlag, false, 关闭 printf */
+ (void)EnableLogcat:(BOOL)bFlag
{
    BLELog(@"stdShow - EnableLogcat - %d",bFlag);
    CStdShow::EnableLogcat(bFlag);
}

/*
    获取libstdshow.a版本号
    返回，例如: "May 18 2022 V1.08"
 */
+ (NSString *)Version
{
    std::string vetCStr = CStdShow::Version();
    NSString *version = [TDD_CTools CStrToNSString:vetCStr];
    BLELog(@"stdShow - Version - %@",version);
    return version;
}

// SetRpcRecv
// App将收到算法服务器返回的数据传给stdshow接口
// SetRpcRecv接口是RpcSend接口的返回
//
// App在stdshow接口调用了"RpcSend"后，会将算法数据发送给算法服务器
// 参考"平台API文档V1.0.34.doc"中“APP调用接口指派后台给算法服务器发信息”
// 可能的服务器请求地址是api/client/sendAlgorithmInformation
// 可能的服务器请求地址是api/client/queryAlgorithmResult/1
// App在收到算法服务器返回的算法运算结果后，通过此接口将结果返回给stdshow接口
//
// Code                 服务器返回的结果，0成功，非0失败
// strMsg               返回提示信息，服务如果没有返回提示信息，则为空
// algorithmData        服务器返回的算法数据结果
//
// 返回值               无
//
// stdshow在调用了RpcSend接口后，会一直等待App的返回，直到App调用了SetRpcRecv接口
/*
*   void SetRpcRecv(int Code, String strMsg, byte[] algorithmData);
*
*   说明：此接口非阻塞，App调用stdshow，App将收到的服务器返回的算法数据结果
*         传给stdshow
*/
//static void SetRpcRecv(uint32_t Code, const std::string& strMsg, const std::vector<uint8_t> &vctAlgorithm);
+ (void)SetRpcRecvWithCode:(uint32_t)Code strMsg:(NSString *)strMsg vctAlgorithm:(NSArray *)vctAlgorithm
{
    std::string cStrMsg = [TDD_CTools NSStringToCStr:strMsg];
    
    
}

// 用于.a库测试数据是否通畅
+ (void)DataTest
{
    CStdShow::DataTest();
}

@end
