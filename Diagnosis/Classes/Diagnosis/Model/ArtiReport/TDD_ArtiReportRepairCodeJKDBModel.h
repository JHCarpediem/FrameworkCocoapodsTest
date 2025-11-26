//
//  TDD_ArtiReportRepairCodeJKDBModel.h
//  AD200
//
//  Created by lecason on 2022/9/5.
//

#import "TDD_JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportRepairCodeJKDBModel : TDD_JKDBModel

/// VCI序列号
@property (nonatomic, copy) NSString *VCISerialNumber;
/// USerID
@property (nonatomic, assign) int userId;
/// 车辆型号
@property (nonatomic, copy) NSString *describeBrand;
/// VIN
@property (nonatomic, copy) NSString *VIN;
/// 系统ID
@property (nonatomic, copy) NSString *strID;
/// 系统Name
@property (nonatomic, copy) NSString *strName;
/// 对应系统的故障码个数
@property (nonatomic, assign) UInt32 uDtsNums;
/// 生成时间
@property (nonatomic, assign) UInt32 createTime;

@end

NS_ASSUME_NONNULL_END
