//
//  TDD_ArtiTroubleRepairInfoModle.h
//  AD200
//
//  Created by AppTD on 2023/2/18.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiTroubleRepairInfoModle : TDD_ArtiModelBase
@property (nonatomic, strong) NSString * RIT_DTC_CODE;//故障码编码
@property (nonatomic, strong) NSString * RIT_VEHICLE_BRAND;//车辆品牌
@property (nonatomic, strong) NSString * RIT_VEHICLE_MODEL;//车型
@property (nonatomic, strong) NSString * RIT_VEHICLE_YEAR;//车辆年款
@property (nonatomic, strong) NSString * RIT_VIN;//车辆VIN
@property (nonatomic, strong) NSString * RIT_SYSTEM_NAME;//系统名称
@property (nonatomic, strong) NSString * RIT_TROUBLE_DESC;//故障定义
@end

NS_ASSUME_NONNULL_END
