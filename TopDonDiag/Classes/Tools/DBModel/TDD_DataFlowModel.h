//
//  TDD_DataFlowModel.h
//  AD200
//
//  Created by yong liu on 2022/8/24.
//

#import <Foundation/Foundation.h>
#import "TDD_JKDBModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TDD_DataFlowModel : TDD_JKDBModel

@property (nonatomic, copy) NSString *name; //显示名字

@property (nonatomic, copy) NSString *createTime; //创建时间

@property (nonatomic, copy) NSString *sn; //sn号

@property (nonatomic, copy) NSString *VIN; //VIN码

@property (nonatomic, copy) NSString *app_version; //app版本

@property (nonatomic, copy) NSString *vci_version; //VCI版本

@property (nonatomic, copy) NSString *vehicle_name; //车型名称

@property (nonatomic, copy) NSString *vehicle_version; //车型版本

@property (nonatomic, copy) NSString *firstStrData; //第一次的数据

@property (nonatomic, assign) TDD_DBType dbType;

@property (nonatomic, copy) NSString *dataVersion;//数据流数据库版本

@end

NS_ASSUME_NONNULL_END
