//
//  TDD_CarModel.h
//  DiagnosisSDK
//
//  Created by 何可人 on 2022/6/1.
//

#import <Foundation/Foundation.h>
#import "TDD_Enums.h"
NS_ASSUME_NONNULL_BEGIN
@interface TDD_MaskModel : NSObject
///功能掩码
@property (nonatomic,copy) NSString *maintenanceStr;//传入的 maintenanceStrStr 原样返回
@property (nonatomic,strong) NSArray<NSString *> *maintenanceStrArr;//maintenanceStrStr 解析出来的数组
@property (nonatomic,strong) NSArray<NSString *> *maintenanceSupportArr;//与 ini 功能掩码 与出来的数组
@property (nonatomic,assign) BOOL maintenanceSupport;//与 ini 功能掩码 与出来的结果
///系统掩码
@property (nonatomic,copy) NSString *systemStr;//传入的 systemStrStr 原样返回
@property (nonatomic,strong) NSArray<NSString *> *systemStrArr;//systemStrStr 解析出来的数组
@property (nonatomic,strong) NSArray<NSString *> *systemSupportArr;//与 ini 系统掩码 与出来的数组
@property (nonatomic,assign) BOOL systemSupport;//与 ini 系统掩码 与出来的结果

@end
@interface TDD_CarModel : NSObject
///当前车辆路径
@property (nonatomic, copy) NSString * path;
/// 链接车对应真车路径
@property (nonatomic, copy) NSString * linkCarPath;
/// strType，类型，可能的实参为，"DIAG"或者"IMMO","RFID"，即是诊断车型还是锁匠车型
@property (nonatomic, copy) NSString * strType;
/// strVehicle，车型缩写，Benz、Ford等
@property (nonatomic, copy) NSString * strVehicle;
/// 自资源包版本
@property (nonatomic, copy) NSString * strVersion;
/// 静态库版本
@property (nonatomic, copy) NSString * strStaticLibraryVersion;
/// 显示的名字
@property (nonatomic, copy) NSString * strName;
/// 显示的英文名字
@property (nonatomic, copy) NSString * strENName;
/// 链接的车型
@property (nonatomic, copy) NSString * strLink;
/// 车型支持的语言
@property (nonatomic, strong) NSArray * languageArr;

// 车型包支持功能配置 和eDiagEntryType进行&运算判断
@property (nonatomic, assign) long maintenance;
@property (nonatomic, strong) NSArray * maintenanceExArr;

// 车型实际开发内容配置 和eDiagMenuMask进行&运算判断
@property (nonatomic, assign) long system;
@property (nonatomic, strong) NSArray * systemExArr;

@property (nonatomic, assign) TDD_SoftType softType;

@property (nonatomic, copy) NSString *serviceName;//服务器车型名称
// 缓存文件大小 -- liuyong
@property (nonatomic, copy) NSString *fileSize;
/// 支持专业故障码维修指引(旧版开放故障码维修指引)
@property (nonatomic, assign) BOOL supportProfessionalTrouble;

/// 计算文件大小
- (NSString *)calculateFileSize;

@end

NS_ASSUME_NONNULL_END
