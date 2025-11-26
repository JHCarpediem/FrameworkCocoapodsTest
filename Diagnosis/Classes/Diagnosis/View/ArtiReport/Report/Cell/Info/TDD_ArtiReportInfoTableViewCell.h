//
//  TDD_ArtiReportInfoTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/3.
//
//  诊断信息
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiReportCellModel.h"
#import "TDD_DashLineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportInfoTableViewCell : UITableViewCell

/// 描述标题
@property (nonatomic, strong) TDD_CustomLabel *describeTitleLabel;
/// 车牌号
@property (nonatomic, strong) TDD_CustomLabel *describeLicensePlateNumberLabel;
/// 车辆品牌
@property (nonatomic, strong) TDD_CustomLabel *describeBrandLabel;
/// 车型
@property (nonatomic, strong) TDD_CustomLabel *describeModelLabel;
/// 年款
@property (nonatomic, strong) TDD_CustomLabel *describeYearLabel;
/// 行驶里程
@property (nonatomic, strong) TDD_CustomLabel *describeMileageLabel;
/// 发动机
@property (nonatomic, strong) TDD_CustomLabel *describeEngineLabel;
/// 子型号
@property (nonatomic, strong) TDD_CustomLabel *describeEngineSubTypeLabel;
/// 诊断时间
@property (nonatomic, strong) TDD_CustomLabel *describeDiagnosisTimeLabel;
/// 车型软件版本号
@property (nonatomic, strong) TDD_CustomLabel *describeVersionLabel;
/// 诊断应用软件版本
@property (nonatomic, strong) TDD_CustomLabel *describeSoftwareVersionLabel;
/// VIN码
@property (nonatomic, strong) TDD_CustomLabel *VINLabel;
/// 诊断路径
@property (nonatomic, strong) TDD_CustomLabel *describeDiagnosisPathLabel;
/// 客户名字
@property (nonatomic, strong) TDD_CustomLabel *describeCustomerNameLabel;
/// 客户电话
@property (nonatomic, strong) TDD_CustomLabel *describeCustomerCallLabel;
/// 维修单号
@property (nonatomic, strong) TDD_CustomLabel *repairOrderNumLabel;

/// 标题
@property (nonatomic, strong) NSMutableArray<TDD_CustomLabel *> *titleLabelArray;
/// 线
@property (nonatomic, strong) TDD_DashLineView *lineView;

///// 更新属性
//-(void)updateWith:(TDD_ArtiReportModel *)model;
///// 获取 Cell 的调试
//+(CGFloat)getCellHeightWith:(TDD_ArtiReportModel *)model;

/// 更新属性
//-(void)updateA4With:(TDD_ArtiReportModel *)model;
///// 获取 Cell 在A4纸上的高度
//+(CGFloat)getCellA4HeightWith:(TDD_ArtiReportModel *)model;

/// 更新属性
-(void)updateWith:(TDD_ArtiReportCellModel *)model;
/// 获取 Cell 的调试
+(CGFloat)getCellHeightWith:(TDD_ArtiReportCellModel *)model;

// 更新属性
// A4 使用 TDD_ArtiReportInfosA4Cell
//-(void)updateA4With:(TDD_ArtiReportCellModel *)model;
/// 获取 Cell 在A4纸上的高度
//+(CGFloat)getCellA4HeightWith:(TDD_ArtiReportCellModel *)model;

#ifdef TOPVCI

#else
#pragma mark -- 历史诊断报告
// 更新属性
- (void)updateHistoryReportWithModel:(TDD_ArtiReportCellModel *)model;
/// 获取 Cell 的高度
+ (CGFloat)getHistoryReportCellHeightWith:(TDD_ArtiReportCellModel *)model;

// 更新属性A4
//- (void)updateA4HistoryReportWithModel:(TDD_ArtiReportCellModel *)model;
/// 获取 Cell 在A4纸上的高度
//+ (CGFloat)getHistoryReportCellA4HeightWith:(TDD_ArtiReportCellModel *)model;
#endif



@end

NS_ASSUME_NONNULL_END
