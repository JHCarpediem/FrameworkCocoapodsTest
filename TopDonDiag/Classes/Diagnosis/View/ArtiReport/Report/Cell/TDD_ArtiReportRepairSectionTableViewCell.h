//
//  TDD_ArtiReportRepairSectionTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  维修前 维修后 表头
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportRepairSectionTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
/// 左标题
@property (nonatomic, strong) TDD_CustomLabel *leftLabel;
/// 右标题
@property (nonatomic, strong) TDD_CustomLabel *rightLabel;

/// 更新标题宽度
-(void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent;

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent;

@end

NS_ASSUME_NONNULL_END
