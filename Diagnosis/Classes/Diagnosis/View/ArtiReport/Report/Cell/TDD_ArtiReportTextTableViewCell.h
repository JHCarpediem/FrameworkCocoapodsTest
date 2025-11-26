//
//  TDD_ArtiReportTextTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  文本
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportTextTableViewCell : UITableViewCell

@property (nonatomic, strong) TDD_CustomLabel *valueLabel;

-(void)updateLayout;

-(void)updateA4Layout;

@end

NS_ASSUME_NONNULL_END
