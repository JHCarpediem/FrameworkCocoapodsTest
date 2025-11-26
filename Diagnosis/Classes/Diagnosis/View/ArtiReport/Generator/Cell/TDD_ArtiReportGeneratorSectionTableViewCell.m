//
//  TDD_ArtiReportGeneratorSectionTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/9.
//

#import "TDD_ArtiReportGeneratorSectionTableViewCell.h"

@implementation TDD_ArtiReportGeneratorSectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.backgroundColor = [UIColor tdd_collectionViewBG];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_colorDiagTheme];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(IS_IPad ? @6 : @4);
        make.height.equalTo(IS_IPad ? @30 : @15);
        make.left.equalTo(IS_IPad ? @40 : @15);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor tdd_colorDiagTheme];
    self.nameLabel.font = IS_IPad ? [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold] : [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(IS_IPad ? 10 : 5);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
  
}

@end
