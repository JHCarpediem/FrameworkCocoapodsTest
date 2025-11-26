//
//  TDD_ArtiReportCodeRowTableViewCell.h
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  故障码 行
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportCodeRowTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) TDD_CustomLabel *nameLabel;
/// 左标题
@property (nonatomic, strong) TDD_CustomLabel *leftLabel;
/// 右标题
@property (nonatomic, strong) TDD_CustomLabel *rightLabel;

/// 更新标题宽度
-(void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent;

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent;
/// 更新颜色
-(void)updateLeftLabelColor:(UIColor *)leftColor withRightColor:(UIColor *)rightColor;

/// 计算`右标题`高度
+ (CGFloat)calRightLabelHeightWithAttributedString:(NSAttributedString *)attributedString maxWidth: (CGFloat)maxwidth isA4:(BOOL)isA4;

/// 更新 `右标题`文字，预览最多`2`行显示, ....。 PDF `不限制`
-(void)updateRightLabelWithAttributedString: (NSAttributedString *)attributedString isA4: (BOOL) isA4;

@end

NS_ASSUME_NONNULL_END
