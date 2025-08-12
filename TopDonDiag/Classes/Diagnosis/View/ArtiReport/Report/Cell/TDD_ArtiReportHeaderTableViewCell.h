//
//  TDD_ArtiReportHeaderTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/3.
//
//  系统报告状态 免责声明 数据流 头部
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportHeaderTableViewCell : UITableViewCell

@property (nonatomic, strong) TDD_CustomLabel *nameLabel;

@property (nonatomic, strong) UIImageView * iconImageView;

-(void)updateLayout;

-(void)updateA4Layout;

@end

NS_ASSUME_NONNULL_END
