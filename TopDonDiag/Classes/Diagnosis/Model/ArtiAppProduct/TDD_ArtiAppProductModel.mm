//
//  TDD_ArtiAppProductModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/7/24.
//

#import "TDD_ArtiAppProductModel.h"
#import "TDD_ArtiModelHeader.h"
#import "TDD_CTools.h"
#if useCarsFramework
#import <CarsFramework/RegAppProduct.hpp>
#else
#import "RegAppProduct.hpp"
#endif
@implementation TDD_ArtiAppProductModel
#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    CRegAppProduct::Name(ArtiAppProductName);
    CRegAppProduct::Group(ArtiAppProductGroup);
    CRegAppProduct::IsSupported(ArtiAppProductIsSupported);
}

static uint32_t ArtiAppProductName() {
    
    return [TDD_ArtiAppProductModel name];
}

static uint32_t ArtiAppProductGroup() {

    return [TDD_ArtiAppProductModel group];
    
}

static bool ArtiAppProductIsSupported(const std::string& strClass, const std::string& strApi, uint32_t uFunction = -1) {
    
    NSString *cppClassName = [TDD_CTools CStrToNSString:strClass];
    NSString *methodName = [TDD_CTools CStrToNSString:strApi];
    return [TDD_ArtiAppProductModel isSupported:cppClassName strApi:methodName uFunction:uFunction];
    
}


/*-----------------------------------------------------------------------------
功    能： 获取当前app应用的产品名称

参数说明： 无

返 回 值： PD_NAME_AD900              表示当前产品名为AD900
           PD_NAME_AD200              表示当前产品名为AD200
           PD_NAME_TOPKEY             表示当前产品名为TOPKEY
           PD_NAME_NINJA1000PRO       表示当前产品名为Ninja1000 Pro
-----------------------------------------------------------------------------*/
+ (eProductName)name
{
    HLog(@"%@ - 获取当前app应用的产品名称 - %d", [self class],[TDD_DiagnosisTools appProduct]);
    return [TDD_DiagnosisTools appProduct];
}

/*------------------------------------------------------------------------------------------
功    能： 获取当前app应用的产品组名称（产品系列）

参数说明： 无

返 回 值：     PD_GROUP_AD900_LIKE     例如，AD900、AD900 LITE、GOOLOO DS900等
               PD_GROUP_TOPSCAN_LIKE   例如，TopScan HD、TopScan VAG、DS200、DeepScan等
               PD_GROUP_CARPAL_LIKE    例如，CarPal、CarPal Guru、DS100、小车探等
               PD_GROUP_AD500_LIKE     例如，AD500、AD600、AD600S、AD500S、AD500 BMS、等
------------------------------------------------------------------------------------------*/
+ (eAppProductGroup)group
{
    HLog(@"%@ - 获取当前app应用的群组名称 - %d", [self class],[TDD_DiagnosisTools appProductGroup]);
    return [TDD_DiagnosisTools appProductGroup];
}

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
+ (BOOL)isSupported:(NSString *)strClass strApi:(NSString *)strApi uFunction:(uint32_t)uFunction {
    HLog(@"%@ - 获取当前 App 应用的功能 或 接口 是否支持 - strClass:%@ - strApi:%@ - uFunction:%d", [self class],strClass,strApi,uFunction);
    if (uFunction != -1) {
        HLog(@"%@ - 获取当前 App 应用的功能 或 接口 是否支持 - uFunction不为-1 需要沟通单独处理", [self class]);
        return false;
    }
    // 获取类对象
    Class targetClass = NSClassFromString(strClass);
    if (!targetClass) {
        HLog(@"%@ - 获取当前 App 应用的功能 或 接口 是否支持 - 类不存在", [self class]);
        return false; // 类不存在
    }
    
    // 检查类方法是否存在
    NSString *objcMethodName = [NSString stringWithFormat:@"%@", strApi];

    SEL methodSelector = sel_registerName([objcMethodName UTF8String]);
    if ([targetClass respondsToSelector:methodSelector]) {
        HLog(@"%@ - 获取当前 App 应用的功能 或 接口 支持 - 找到类方法", [self class]);
        return true;
    }
    
    // 检查实例方法是否存在
    id target = [targetClass new];
    if (target && [target respondsToSelector:methodSelector]) {
        HLog(@"%@ - 获取当前 App 应用的功能 或 接口 支持 - 找到实例方法", [self class]);
        return true;
    }
    
    HLog(@"%@ - 获取当前 App 应用的功能 或 接口 不支持 - 未找到方法", [self class]);
    return false;
}
@end
