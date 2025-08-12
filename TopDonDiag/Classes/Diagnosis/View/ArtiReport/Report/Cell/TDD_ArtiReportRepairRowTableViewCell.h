//
//  TDD_ArtiReportRepairRowTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  维修前 维修后 表行
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiReportModel.h"
#import "TDD_ArtiReportCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportRepairRowTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
/// 左标题
@property (nonatomic, strong) TDD_CustomLabel *leftLabel;
/// 右标题
@property (nonatomic, strong) TDD_CustomLabel *rightLabel;
/// 左错误码标题
@property (nonatomic, strong) TDD_CustomLabel *leftCodeTitleLabel;
/// 右错误码标题
@property (nonatomic, strong) TDD_CustomLabel *rightCodeTitleLabel;
/// 左错误码
@property (nonatomic, strong) TDD_CustomLabel *leftCodeLabel;
/// 右错误码
@property (nonatomic, strong) TDD_CustomLabel *rightCodeLabel;
/// 分割线
@property (nonatomic, strong) UIView *lineView;
/// 故障码 状态和数量背景
@property (nonatomic, strong) UIView *troubleCodeBgView;

/// 更新标题宽度
-(void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent;

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent;
/// 更新颜色
-(void)updateLeftLabelColor:(UIColor *)leftColor withRightColor:(UIColor *)rightColor;
/// 更新模型
-(void)updateWith:(TDD_ArtiReportCellModel *)model;

@end

NS_ASSUME_NONNULL_END
