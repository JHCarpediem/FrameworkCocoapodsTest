//
//  TDD_ArtiReportCodeTitleTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  故障码标题
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportCodeTitleTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) TDD_CustomLabel *nameLabel;

@property (nonatomic, assign) BOOL isLower;

-(void)updateLayout;

-(void)updateA4Layout;

@end

NS_ASSUME_NONNULL_END
