//
//  TDD_ArtiReportInfoCell.h
//  TopdonDiagnosis
//
//  Created by liuyong on 2025/3/27.
//

#import <UIKit/UIKit.h>
#import "TDD_ArtiReportCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiReportInfoCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                  labelMargin:(CGFloat)labelMargin
                  lineSpacing:(CGFloat)lineSpacing
             interItemSpacing:(CGFloat)interItemSpacing;

- (void)updateUIWithModel:(TDD_ArtiReportCellModel *)model;

@end

@interface InfoItemView : UIView

@property (nonatomic, strong) TDD_CustomLabel *contentLabel;

@end

NS_ASSUME_NONNULL_END
