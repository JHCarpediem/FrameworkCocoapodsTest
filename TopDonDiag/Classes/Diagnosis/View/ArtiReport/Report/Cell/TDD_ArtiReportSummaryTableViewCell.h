//
//  TDD_ArtiReportSummaryTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/3.
//
//  概述
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiReportCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportSummaryTableViewCell : UITableViewCell

@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
@property (nonatomic, strong) TDD_CustomLabel *valueLabel;

-(void)updateWith:(TDD_ArtiReportCellModel *)model;

-(void)updateA4With:(TDD_ArtiReportCellModel *)model;

@end

NS_ASSUME_NONNULL_END
