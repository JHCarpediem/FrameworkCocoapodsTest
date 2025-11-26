//
//  TDD_ArtiReportRepairHeaderTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  维修前 维修后 头部
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportRepairHeaderTableViewCell : UITableViewCell

/// 维修后
@property (nonatomic, strong) TDD_CustomLabel *currentLabel;
/// 维修前
@property (nonatomic, strong) TDD_CustomLabel *historyLabel;

/// 更新标题宽度
-(void)updateHistoryLabelPercent:(float)historyPercent withCurrentLabelPercent:(float)currentPercent;

-(void)updateA4HistoryLabelPercent:(float)historyPercent withCurrentLabelPercent:(float)currentPercent;

@end

NS_ASSUME_NONNULL_END
