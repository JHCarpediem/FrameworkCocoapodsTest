//
//  TDD_ArtiReportFlowRowTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/8.
//
//  数据流 行

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportFlowRowTableViewCell : UITableViewCell

-(void)updateWith:(NSArray *)models;

-(void)updateA4With:(NSArray *)models;

@end

NS_ASSUME_NONNULL_END
