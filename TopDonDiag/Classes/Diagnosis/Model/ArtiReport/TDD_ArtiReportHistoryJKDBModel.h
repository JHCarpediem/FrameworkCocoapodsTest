//
//  TDD_ArtiReportHistoryJKDBModel.h
//  AD200
//
//  Created by Lecason on 2022/9/13.
//

#import "TDD_JKDBModel.h"
#import "TDD_ArtiReportCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportHistoryJKDBModel : TDD_JKDBModel

/// 数据库key
@property (nonatomic, strong) NSString * key;
/// VCI序列号
@property (nonatomic, copy) NSString *VCISerialNumber;
/// USerID
@property (nonatomic, assign) int userId;
/// 车辆型号
@property (nonatomic, copy) NSString *describeBrand;
/// VIN
@property (nonatomic, copy) NSString *VIN;
/// 生成时间
@property (nonatomic, assign) UInt32 createTime;
/// 文件名
@property (nonatomic, copy) NSString *pdfFileName;
/// 文件显示名称
@property (nonatomic, copy) NSString *displayName;
/// 数据源数据
@property (nonatomic, strong) NSMutableArray<TDD_ArtiReportCellModel*> *items;
/// 存储数据源转化成JSON字符串
@property (nonatomic, strong) NSString * strData;
/// 报告URL
@property (nonatomic, copy) NSString * reportUrl;
/// 报告语言ID
@property (nonatomic, assign) int languageId;
/// 报告类型
@property (nonatomic, assign) int reportType;
/// 维修前后 (1 维修前 2 维修后)
@property (nonatomic, assign) int repairIndex;

/// 数据库位置
@property (nonatomic, assign) TDD_DBType dbType;

@end

NS_ASSUME_NONNULL_END
