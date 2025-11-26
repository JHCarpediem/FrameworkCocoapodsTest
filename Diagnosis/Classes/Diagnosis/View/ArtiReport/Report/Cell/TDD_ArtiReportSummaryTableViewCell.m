//
//  TDD_ArtiReportSummaryTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/3.
//
//  概述
//

#import "TDD_ArtiReportSummaryTableViewCell.h"
#import "TDD_DashLineView.h"

@interface TDD_ArtiReportSummaryTableViewCell()

@property (nonatomic, strong) TDD_DashLineView *lineView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *tipView;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) TDD_CustomLabel *tipsLabel;
@end

@implementation TDD_ArtiReportSummaryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    self.backgroundColor = UIColor.clearColor;
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.valueLabel];
    [self.bgView addSubview:self.tipView];
    [self.tipView addSubview:self.bottomLineView];
    [self.tipView addSubview:self.iconImageView];
    [self.tipView addSubview:self.tipsLabel];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @40 : @15);
        make.top.equalTo(@15);
        make.center.equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @30 : @15);
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(IS_IPad ? @0 : @5);
        make.height.equalTo(IS_IPad ? @64 : @45);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @20 : @10);
        make.right.equalTo(IS_IPad ? @-20 : @-10);
        make.height.equalTo(@1);
        make.top.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self.nameLabel);
        make.top.equalTo(self.lineView.mas_bottom).offset(IS_IPad ? 20 : 10);
    }];
    
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bgView);
        make.top.equalTo(self.valueLabel.mas_bottom).offset(10);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.tipView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(@15);
        make.centerY.equalTo(self.tipView).offset(-2.5);
        
    }];

    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(2.5);
        make.right.equalTo(@-10);
    }];
    
    self.tipView.hidden = !isKindOfTopVCI;
}

-(void)updateWith:(TDD_ArtiReportCellModel *)model {
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 20 : 16 weight:UIFontWeightSemibold];
    self.valueLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14 weight:UIFontWeightMedium];
    
    self.nameLabel.text = model.system_overview_title;
    self.valueLabel.text = model.system_overview_content;

    NSString *iconName = isKindOfTopVCI ? @"report_tips_icon" : @"report_tips_gray_icon";
    self.iconImageView.image = kImageNamed(iconName);
    self.nameLabel.textColor = [UIColor tdd_title];
    self.valueLabel.textColor = [UIColor tdd_title];
    self.lineView.dashLineColor = [UIColor tdd_colorDiagDashLine];
    self.bottomLineView.backgroundColor = [UIColor tdd_colorWithHex:0xffffff alpha:0.2];
    self.tipsLabel.textColor = [UIColor tdd_subTitle];
    self.tipsLabel.font = [UIFont systemFontOfSize:14];
    self.bgView.backgroundColor = [UIColor tdd_colorDiagReportSummary];
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;    
}

-(void)updateA4With:(TDD_ArtiReportCellModel *)model {
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.center.equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(@5);
        make.height.equalTo(@45);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@1);
        make.top.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self.nameLabel);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
    }];
    
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.valueLabel.font = [UIFont systemFontOfSize:10];
    
    self.nameLabel.text = model.system_overview_title;
    self.valueLabel.text = model.system_overview_content;
 
    NSString *iconName = isKindOfTopVCI ? @"report_tips_gray_icon" : @"report_tips_icon";
    self.iconImageView.image = kImageNamed(iconName);
    UIColor *textColor = [UIColor tdd_pdfDtcNormalColor];
    self.nameLabel.textColor = textColor;
    self.valueLabel.textColor = textColor;
    self.lineView.dashLineColor = [UIColor tdd_reportSummaryDashLineColor];
    self.bgView.backgroundColor = [UIColor tdd_reportSummaryPDFBackground];
    self.bottomLineView.backgroundColor = [UIColor tdd_reportSummaryBottomLineColor];
    self.tipsLabel.textColor = [UIColor tdd_reportSummaryTipsColor];
    self.tipsLabel.font = [UIFont systemFontOfSize:10];
    self.contentView.backgroundColor = [UIColor whiteColor];
}


- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor tdd_reportSummaryPDFBackground];
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}

- (TDD_CustomLabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[TDD_CustomLabel alloc] init];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (TDD_CustomLabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[TDD_CustomLabel alloc] init];
        _valueLabel.numberOfLines = 0;
    }
    return _valueLabel;
}

- (TDD_DashLineView *)lineView {
    if (!_lineView) {
        _lineView = [[TDD_DashLineView alloc] init];
        _lineView.lineDotWidth = 2;
        _lineView.lineDotSpacing = 2;
        _lineView.backgroundColor = [UIColor clearColor];
        _lineView.dashLineColor = [UIColor tdd_colorDiagDashLine];
    }
    return _lineView;
}

- (UIView *)tipView {
    if (!_tipView) {
        _tipView = [[UIView alloc] init];
    }
    return _tipView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = UIColor.whiteColor;
    }
    return _bottomLineView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (TDD_CustomLabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[TDD_CustomLabel alloc] init];
        _tipsLabel.textColor = [UIColor tdd_subTitle];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.text = TDDLocalized.report_summarize_tips;
    }
    return _tipsLabel;
}

@end
