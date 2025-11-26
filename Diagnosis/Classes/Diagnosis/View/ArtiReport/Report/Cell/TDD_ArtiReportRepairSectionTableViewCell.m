//
//  TDD_ArtiReportRepairSectionTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  维修前 维修后 表头
//

#import "TDD_ArtiReportRepairSectionTableViewCell.h"

@interface TDD_ArtiReportRepairSectionTableViewCell()

/// 分割线
@property (nonatomic, strong) UIView *line;

@end

@implementation TDD_ArtiReportRepairSectionTableViewCell

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
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.text = TDDLocalized.tsb_notice_system;
    
    self.leftLabel = [[TDD_CustomLabel alloc] init];
    self.leftLabel.textColor = [UIColor tdd_color666666];
    self.leftLabel.font = [UIFont systemFontOfSize:15];
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    self.leftLabel.adjustsFontSizeToFitWidth = YES;
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.numberOfLines = 0;
    [self.contentView addSubview:self.leftLabel];
    self.leftLabel.text = TDDLocalized.report_system_status;
    
    self.rightLabel = [[TDD_CustomLabel alloc] init];
    self.rightLabel.textColor = [UIColor tdd_color666666];
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel.adjustsFontSizeToFitWidth = YES;
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.numberOfLines = 0;
    [self.contentView addSubview:self.rightLabel];
    self.rightLabel.text = TDDLocalized.report_system_status;
    
    UIView *line = [[UIView alloc] init];
    self.line = line;
    line.backgroundColor = [UIColor tdd_line];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(@0.5);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

-(void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent {
    
    CGFloat leftGap = IS_IPad ? 40 : 15;
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
    
    
    self.nameLabel.tdd_width = allLabelWidth - self.leftLabel.tdd_width - self.rightLabel.tdd_width;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap;
    self.nameLabel.tdd_top = 0;
    
    if (leftPercent == 0) {
        self.leftLabel.hidden = YES;
    } else {
        self.leftLabel.hidden = NO;
    }
    
    if (rightPercent == 0) {
        self.rightLabel.hidden = YES;
    } else {
        self.rightLabel.hidden = NO;
    }
    
    self.nameLabel.textColor = [UIColor tdd_color666666];
    self.leftLabel.textColor = [UIColor tdd_color666666];
    self.rightLabel.textColor = [UIColor tdd_color666666];
    self.line.backgroundColor = [UIColor tdd_line];
    self.contentView.backgroundColor = [UIColor tdd_inputHistoryCellBackground];
}

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent
{
    if (leftPercent == 0) {
        rightPercent = 0.3;
    }
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    self.leftLabel.font = [UIFont systemFontOfSize:10];
    self.rightLabel.font = [UIFont systemFontOfSize:10];
    
    self.rightLabel.tdd_width = A4Width * rightPercent;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = A4Width;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = A4Width * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    float leftGap = 15;
    self.nameLabel.tdd_width = A4Width - self.leftLabel.tdd_width - self.rightLabel.tdd_width - leftGap;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap;
    self.nameLabel.tdd_top = 0;
    
    if (leftPercent == 0) {
        self.leftLabel.hidden = YES;
    } else {
        self.leftLabel.hidden = NO;
    }
    
    if (rightPercent == 0) {
        self.rightLabel.hidden = YES;
    } else {
        self.rightLabel.hidden = NO;
    }
    
    UIColor *textColor = [UIColor tdd_reportCodeSectionTextColor];
    self.nameLabel.textColor = textColor;
    self.leftLabel.textColor = textColor;
    self.rightLabel.textColor = textColor;
    self.line.backgroundColor = [UIColor tdd_reportRepairSectionPDFLineColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
