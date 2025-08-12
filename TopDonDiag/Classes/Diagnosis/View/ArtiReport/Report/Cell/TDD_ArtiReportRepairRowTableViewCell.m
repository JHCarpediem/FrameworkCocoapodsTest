//
//  TDD_ArtiReportRepairRowTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  维修前 维修后 表行
//

#import "TDD_ArtiReportRepairRowTableViewCell.h"

@interface TDD_ArtiReportRepairRowTableViewCell()

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation TDD_ArtiReportRepairRowTableViewCell

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
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        self.troubleCodeBgView = [[UIView alloc] init];
        self.troubleCodeBgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.troubleCodeBgView];
    }
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor tdd_title];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.text = TDDLocalized.tsb_notice_system;
    
    self.leftLabel = [[TDD_CustomLabel alloc] init];
    self.leftLabel.textColor = [UIColor tdd_title];
    self.leftLabel.font = [UIFont systemFontOfSize:14];
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    self.leftLabel.adjustsFontSizeToFitWidth = YES;
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.numberOfLines = 0;
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [[TDD_CustomLabel alloc] init];
    self.rightLabel.textColor = [UIColor tdd_title];
    self.rightLabel.font = [UIFont systemFontOfSize:14];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel.adjustsFontSizeToFitWidth = YES;
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.numberOfLines = 0;
    [self.contentView addSubview:self.rightLabel];
    
    self.leftCodeTitleLabel = [[TDD_CustomLabel alloc] init];
    self.leftCodeTitleLabel.textColor = [UIColor tdd_title];
    self.leftCodeTitleLabel.font = [UIFont systemFontOfSize:14];
    self.leftCodeTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.leftCodeTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.leftCodeTitleLabel.backgroundColor = [UIColor clearColor];
    self.leftCodeTitleLabel.numberOfLines = 0;
    [self.leftLabel addSubview:self.leftCodeTitleLabel];
    
    self.leftCodeLabel = [[TDD_CustomLabel alloc] init];
    self.leftCodeLabel.textColor = [UIColor tdd_title];
    self.leftCodeLabel.font = [UIFont systemFontOfSize:14];
    self.leftCodeLabel.textAlignment = NSTextAlignmentCenter;
    self.leftCodeLabel.adjustsFontSizeToFitWidth = YES;
    self.leftCodeLabel.backgroundColor = [UIColor clearColor];
    self.leftCodeLabel.numberOfLines = 0;
    [self.leftLabel addSubview:self.leftCodeLabel];
    
    self.rightCodeLabel = [[TDD_CustomLabel alloc] init];
    self.rightCodeLabel.textColor = [UIColor tdd_title];
    self.rightCodeLabel.font = [UIFont systemFontOfSize:14];
    self.rightCodeLabel.textAlignment = NSTextAlignmentCenter;
    self.rightCodeLabel.adjustsFontSizeToFitWidth = YES;
    self.rightCodeLabel.backgroundColor = [UIColor clearColor];
    self.rightCodeLabel.numberOfLines = 0;
    [self.rightLabel addSubview:self.rightCodeLabel];
    
    self.rightCodeTitleLabel = [[TDD_CustomLabel alloc] init];
    self.rightCodeTitleLabel.textColor = [UIColor tdd_title];
    self.rightCodeTitleLabel.font = [UIFont systemFontOfSize:14];
    self.rightCodeTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.rightCodeTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.rightCodeTitleLabel.backgroundColor = [UIColor clearColor];
    self.rightCodeTitleLabel.numberOfLines = 0;
    [self.rightLabel addSubview:self.rightCodeTitleLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = UIColor.tdd_line;
    [self.leftLabel addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.5);
        make.height.equalTo(self.contentView);
        make.top.equalTo(@0);
        make.left.equalTo(self.leftLabel.mas_right ).offset(0.5);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor tdd_line];
    [self.contentView addSubview:bottomLine];
    self.bottomLine = bottomLine;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(@0.5);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [self.troubleCodeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftCodeTitleLabel);
            make.top.right.bottom.equalTo(self.contentView);
        }];
    }

}

- (void)updateLeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent {
    
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        self.troubleCodeBgView.backgroundColor =  [UIColor tdd_colorWithHex:0x1B212A];
    }

    CGFloat leftGap = IS_IPad ? 40 : 15;
    CGFloat allLabelWidth = IphoneWidth - leftGap * 2;   
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.leftLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.rightLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.leftCodeTitleLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.leftCodeLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.rightCodeLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.rightCodeTitleLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];

    self.leftCodeTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.leftCodeLabel.textAlignment = NSTextAlignmentCenter;
    self.rightCodeTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.rightCodeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.rightLabel.tdd_width = allLabelWidth * rightPercent;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = IphoneWidth - leftGap;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = allLabelWidth * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    float gap = 10;
    
    self.leftCodeTitleLabel.tdd_width = self.leftLabel.tdd_width / 2 - gap;
    self.leftCodeTitleLabel.tdd_height = self.leftLabel.tdd_height;
    self.leftCodeTitleLabel.tdd_left = gap;
    self.leftCodeTitleLabel.tdd_top = 0;
    
    self.leftCodeLabel.tdd_width = self.leftLabel.tdd_width / 2 - gap;
    self.leftCodeLabel.tdd_height = self.leftLabel.tdd_height;
    self.leftCodeLabel.tdd_left = self.leftCodeTitleLabel.tdd_right;
    self.leftCodeLabel.tdd_top = self.leftCodeTitleLabel.tdd_top;
    
    self.rightCodeTitleLabel.tdd_width = self.rightLabel.tdd_width / 2 - gap;
    self.rightCodeTitleLabel.tdd_height = self.rightLabel.tdd_height;
    self.rightCodeTitleLabel.tdd_left = gap;
    self.rightCodeTitleLabel.tdd_top = 0;
    
    self.rightCodeLabel.tdd_width = self.rightLabel.tdd_width / 2 - gap;
    self.rightCodeLabel.tdd_height = self.rightLabel.tdd_height;
    self.rightCodeLabel.tdd_right = self.rightLabel.tdd_width - gap;
    self.rightCodeLabel.tdd_top = self.rightCodeTitleLabel.tdd_top;
    
    self.nameLabel.tdd_width = allLabelWidth - self.leftLabel.tdd_width - self.rightLabel.tdd_width;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap;
    self.nameLabel.tdd_top = 0;
    
    if (leftPercent == 0) {
        self.leftLabel.hidden = YES;
        self.leftCodeLabel.hidden = YES;
        self.leftCodeTitleLabel.hidden = YES;
    } else {
        self.leftLabel.hidden = NO;
        self.leftCodeLabel.hidden = NO;
        self.leftCodeTitleLabel.hidden = NO;
    }
    
    if (rightPercent == 0) {
        self.rightLabel.hidden = YES;
        self.rightCodeLabel.hidden = YES;
        self.rightCodeTitleLabel.hidden = YES;
    } else {
        self.rightLabel.hidden = NO;
        self.rightCodeLabel.hidden = NO;
        self.rightCodeTitleLabel.hidden = NO;
    }
    
    UIColor *textColor = [UIColor tdd_title];
    
    self.nameLabel.textColor = textColor;
    self.leftLabel.textColor = textColor;
    self.rightLabel.textColor = textColor;
    self.leftCodeTitleLabel.textColor = textColor;
    self.leftCodeLabel.textColor = textColor;
    self.rightCodeLabel.textColor = textColor;
    self.rightCodeTitleLabel.textColor = textColor;
    self.bottomLine.backgroundColor = [UIColor tdd_line];
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

-(void)updateA4LeftLabelPercent:(float)leftPercent withRightLabelPercent:(float)rightPercent
{
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    self.leftLabel.font = [UIFont systemFontOfSize:10];
    self.rightLabel.font = [UIFont systemFontOfSize:10];
    self.leftCodeTitleLabel.font = [UIFont systemFontOfSize:10];
    self.leftCodeLabel.font = [UIFont systemFontOfSize:10];
    self.rightCodeLabel.font = [UIFont systemFontOfSize:10];
    self.rightCodeTitleLabel.font = [UIFont systemFontOfSize:10];
    
    self.rightLabel.tdd_width = A4Width* rightPercent;
    self.rightLabel.tdd_height = self.contentView.tdd_height;
    self.rightLabel.tdd_right = A4Width;
    self.rightLabel.tdd_top = 0;
    
    self.leftLabel.tdd_width = A4Width * leftPercent;
    self.leftLabel.tdd_height = self.contentView.tdd_height;
    self.leftLabel.tdd_right = self.rightLabel.tdd_left;
    self.leftLabel.tdd_top = self.rightLabel.tdd_top;
    
    float gap = 10;
    
    self.leftCodeTitleLabel.tdd_width = self.leftLabel.tdd_width / 2 - gap;
    self.leftCodeTitleLabel.tdd_height = self.leftLabel.tdd_height;
    self.leftCodeTitleLabel.tdd_left = gap;
    self.leftCodeTitleLabel.tdd_top = 0;
    
    self.leftCodeLabel.tdd_width = self.leftLabel.tdd_width / 2 - gap;
    self.leftCodeLabel.tdd_height = self.leftLabel.tdd_height;
    self.leftCodeLabel.tdd_left = self.leftCodeTitleLabel.tdd_right;
    self.leftCodeLabel.tdd_top = self.leftCodeTitleLabel.tdd_top;
    
    self.rightCodeTitleLabel.tdd_width = self.rightLabel.tdd_width / 2 - gap;
    self.rightCodeTitleLabel.tdd_height = self.rightLabel.tdd_height;
    self.rightCodeTitleLabel.tdd_left = gap;
    self.rightCodeTitleLabel.tdd_top = 0;
    
    self.rightCodeLabel.tdd_width = self.rightLabel.tdd_width / 2 - gap;
    self.rightCodeLabel.tdd_height = self.rightLabel.tdd_height;
    self.rightCodeLabel.tdd_right = self.rightLabel.tdd_width - gap;
    self.rightCodeLabel.tdd_top = self.rightCodeTitleLabel.tdd_top;
    
    float leftGap = 15;
    self.nameLabel.tdd_width = A4Width - self.leftLabel.tdd_width - self.rightLabel.tdd_width - leftGap;
    self.nameLabel.tdd_height = self.contentView.tdd_height;
    self.nameLabel.tdd_left = leftGap;
    self.nameLabel.tdd_top = 0;
    
    if (leftPercent == 0) {
        self.leftLabel.hidden = YES;
        self.leftCodeLabel.hidden = YES;
        self.leftCodeTitleLabel.hidden = YES;
    } else {
        self.leftLabel.hidden = NO;
        self.leftCodeLabel.hidden = NO;
        self.leftCodeTitleLabel.hidden = NO;
    }
    
    if (rightPercent == 0) {
        self.rightLabel.hidden = YES;
        self.rightCodeLabel.hidden = YES;
        self.rightCodeTitleLabel.hidden = YES;
    } else {
        self.rightLabel.hidden = NO;
        self.rightCodeLabel.hidden = NO;
        self.rightCodeTitleLabel.hidden = NO;
    }
    
    UIColor *textColor = [UIColor tdd_pdfDtcNormalColor];
    
    self.nameLabel.textColor = textColor;
    self.leftLabel.textColor = textColor;
    self.rightLabel.textColor = textColor;
    self.leftCodeTitleLabel.textColor = textColor;
    self.leftCodeLabel.textColor = textColor;
    self.rightCodeLabel.textColor = textColor;
    self.rightCodeTitleLabel.textColor = textColor;
    self.bottomLine.backgroundColor = [UIColor tdd_ColorEEEEEE];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)updateLeftLabelColor:(UIColor *)leftColor withRightColor:(UIColor *)rightColor
{
    self.leftCodeTitleLabel.textColor = leftColor;
    self.rightCodeTitleLabel.textColor = rightColor;
}

-(void)updateWith:(TDD_ArtiReportCellModel *)model
{
    self.nameLabel.text = model.cell_header_title;
    
    if (model.rightUDtsNums == 999) {
        self.rightCodeLabel.text = @"";
    }else {
        self.rightCodeLabel.text = [NSString stringWithFormat:@"%u", model.rightUDtsNums];
    }
    
    self.rightCodeTitleLabel.text = model.rightUDtsNums > 0 ? TDDLocalized.report_has_error_code : TDDLocalized.trouble_free;
    self.rightCodeTitleLabel.textColor = model.rightUDtsNums > 0 ? [UIColor tdd_colorDiagDTCFault] : [UIColor tdd_colorDiagDTCNoFault];
    
    if (model.leftUDtsNums == 999) {
        self.leftCodeLabel.text = @"";
    }else {
        self.leftCodeLabel.text = [NSString stringWithFormat:@"%u", model.leftUDtsNums];
    }
    
    self.leftCodeTitleLabel.text = model.leftUDtsNums > 0 ? TDDLocalized.report_has_error_code : TDDLocalized.trouble_free;
    self.leftCodeTitleLabel.textColor = model.leftUDtsNums > 0 ? [UIColor tdd_colorDiagDTCFault] : [UIColor tdd_colorDiagDTCNoFault];
    
    NSString *lack = @"-";
    if ([model.leftUDtsName isEqualToString:lack]) {
        self.leftCodeLabel.text = lack;
        self.leftCodeTitleLabel.text = lack;
        self.leftCodeTitleLabel.textColor = [UIColor tdd_title];
    }
}

@end
