//
//  TDD_ArtiReportTextTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  文本
//

#import "TDD_ArtiReportTextTableViewCell.h"

@implementation TDD_ArtiReportTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.masksToBounds = YES;
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;

    self.valueLabel = [[TDD_CustomLabel alloc] init];
    self.valueLabel.textColor = [TDD_DiagnosisTools softWareIsCarPalSeries] ? [UIColor tdd_title] : [UIColor tdd_reportDisclaimTextColor];

    self.valueLabel.font = [UIFont systemFontOfSize:14];
    self.valueLabel.textAlignment = NSTextAlignmentLeft;
    self.valueLabel.numberOfLines = 0;
    [self.contentView addSubview:self.valueLabel];

    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-15);
    }];
}

-(void)updateLayout {

    self.valueLabel.font = [UIFont systemFontOfSize:IS_IPad ? 18 : 14];
    self.valueLabel.textColor = [TDD_DiagnosisTools softWareIsCarPalSeries] ? [UIColor tdd_title] : [UIColor tdd_reportDisclaimTextColor];

    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
    if (IS_IPad) {
        [self.valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@-40);
        }];
    }
}

-(void)updateA4Layout {
    self.valueLabel.font = [UIFont systemFontOfSize:12];
    self.valueLabel.textColor = [UIColor tdd_pdfDtcNormalColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
