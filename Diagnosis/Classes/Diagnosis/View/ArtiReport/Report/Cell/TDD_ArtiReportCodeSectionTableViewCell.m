//
//  TDD_ArtiReportCodeSectionTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/8.
//
//  故障码表行
//

#import "TDD_ArtiReportCodeSectionTableViewCell.h"

@interface TDD_ArtiReportCodeSectionTableViewCell()

@property (nonatomic, strong) UIView *line;

@end

@implementation TDD_ArtiReportCodeSectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = [UIColor tdd_cellBackground];
    
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor tdd_color666666];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    
    self.leftLabel = [[TDD_CustomLabel alloc] init];
    self.leftLabel.textColor = [UIColor tdd_color666666];
    self.leftLabel.font = [UIFont systemFontOfSize:15];
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.adjustsFontSizeToFitWidth = YES;
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.numberOfLines = 0;
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [[TDD_CustomLabel alloc] init];
    self.rightLabel.textColor = [UIColor tdd_color666666];
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel.adjustsFontSizeToFitWidth = YES;
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.numberOfLines = 0;
    [self.contentView addSubview:self.rightLabel];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_line];
    self.line = line;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(@0.5);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

-(void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent {
//    self.nameLabel.textAlignment = NSTextAlignmentCenter;
//    self.leftLabel.textAlignment = NSTextAlignmentCenter;
//    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat leftGap = IS_IPad ? 40 : 0;
    CGFloat allLabelWidth = IphoneWidth - leftGap * 2;
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.leftLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.rightLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    
    self.rightLabel.tdd_width = allLabelWidth * rightPercent;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = IphoneWidth - leftGap;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = allLabelWidth * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    self.nameLabel.tdd_width = allLabelWidth - self.leftLabel.tdd_width - self.rightLabel.tdd_width - 10;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap + 5;
    self.nameLabel.tdd_top = 0;
    
    self.nameLabel.textColor = [UIColor tdd_color666666];
    self.leftLabel.textColor = [UIColor tdd_color666666];
    self.rightLabel.textColor = [UIColor tdd_color666666];
    self.line.backgroundColor = [UIColor tdd_line];
    self.contentView.backgroundColor = UIColor.tdd_cellBackground;
}

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent
{
//    self.nameLabel.textAlignment = NSTextAlignmentCenter;
//    self.leftLabel.textAlignment = NSTextAlignmentLeft;
//    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    self.leftLabel.font = [UIFont systemFontOfSize:10];
    self.rightLabel.font = [UIFont systemFontOfSize:10];
    
    self.rightLabel.tdd_width = A4Width * rightPercent - 20;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = A4Width - 10;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = A4Width * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    float leftGap = 0;
    self.nameLabel.tdd_width = A4Width - self.leftLabel.tdd_width - self.rightLabel.tdd_width - leftGap - 20;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap + 5;
    self.nameLabel.tdd_top = 0;
    
    self.nameLabel.textColor = [UIColor tdd_reportCodeSectionTextColor];
    self.leftLabel.textColor = [UIColor tdd_reportCodeSectionTextColor];
    self.rightLabel.textColor = [UIColor tdd_reportCodeSectionTextColor];
    self.line.backgroundColor = [UIColor tdd_ColorEEEEEE];
    self.contentView.backgroundColor = [UIColor tdd_reportCodeSectionBackground];
    
    HLog("codeRowSectionWidth: %f -- %f", self.rightLabel.tdd_width, self.rightLabel.tdd_centerX);
}


-(void)updateLeftLabelColor:(UIColor *)leftColor withRightColor:(UIColor *)rightColor
{
    self.leftLabel.textColor = leftColor;
    self.rightLabel.textColor = rightColor;
}
@end
