//
//  TDD_ArtiReportRepairHeaderTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  维修前 维修后 头部
//

#import "TDD_ArtiReportRepairHeaderTableViewCell.h"

@interface TDD_ArtiReportRepairHeaderTableViewCell ()

@property(nonatomic, strong) UIView *line;

@end

@implementation TDD_ArtiReportRepairHeaderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI {
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    self.historyLabel = [[TDD_CustomLabel alloc] init];
    self.historyLabel.textColor = [UIColor whiteColor];
    self.historyLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.historyLabel.textAlignment = NSTextAlignmentCenter;
    self.historyLabel.adjustsFontSizeToFitWidth = YES;
    self.historyLabel.backgroundColor = [UIColor tdd_colorDiagTheme];
    self.historyLabel.numberOfLines = 0;
    [self.contentView addSubview:self.historyLabel];
    self.historyLabel.text = TDDLocalized.report_system_type_before;
    
    self.currentLabel = [[TDD_CustomLabel alloc] init];
    self.currentLabel.textColor = [UIColor whiteColor];
    self.currentLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.currentLabel.textAlignment = NSTextAlignmentCenter;
    self.currentLabel.adjustsFontSizeToFitWidth = YES;
    self.currentLabel.backgroundColor = [UIColor tdd_colorDiagTheme];
    self.currentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.currentLabel];
    self.currentLabel.text = TDDLocalized.report_system_type_after;
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor tdd_colorDiagTheme];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@2);
        make.left.equalTo(self.contentView).offset(IS_IPad ? 40 : 0);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}

-(void)updateHistoryLabelPercent:(float)historyPercent withCurrentLabelPercent:(float)currentPercent {
    self.historyLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    self.currentLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 15];
    
    CGFloat gap = IS_IPad ? 40 : 0;
    CGFloat allLabelWidth = IphoneWidth - gap * 2;
    self.currentLabel.tdd_width = allLabelWidth * currentPercent;
    self.currentLabel.tdd_height = self.contentView.tdd_height;
    self.currentLabel.tdd_right = IphoneWidth - gap;
    self.currentLabel.tdd_top = 0;
    
    self.historyLabel.tdd_width = allLabelWidth * historyPercent;
    self.historyLabel.tdd_height = self.contentView.tdd_height;
    self.historyLabel.tdd_right = self.currentLabel.tdd_left;
    self.historyLabel.tdd_top = self.currentLabel.tdd_top;
    
    self.historyLabel.textColor = [UIColor whiteColor];
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

-(void)updateA4HistoryLabelPercent:(float)historyPercent withCurrentLabelPercent:(float)currentPercent
{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@2);
        make.left.equalTo(self.contentView).offset(0);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    if (historyPercent == 0) {
        currentPercent = 0.3;
    }
    self.historyLabel.font = [UIFont systemFontOfSize:10];
    self.currentLabel.font = [UIFont systemFontOfSize:10];
    
    self.currentLabel.tdd_width = A4Width * currentPercent;
    self.currentLabel.tdd_height = 30.0;
    self.currentLabel.tdd_right = A4Width;
    self.currentLabel.tdd_top = 0;
    
    self.historyLabel.tdd_width = A4Width * historyPercent;
    self.historyLabel.tdd_height = 30.0;
    self.historyLabel.tdd_right = self.currentLabel.tdd_left;
    self.historyLabel.tdd_top = self.currentLabel.tdd_top;
    
    self.historyLabel.textColor = [UIColor tdd_reportRepairHeadTextColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
