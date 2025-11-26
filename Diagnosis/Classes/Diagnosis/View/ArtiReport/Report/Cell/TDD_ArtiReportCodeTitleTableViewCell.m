//
//  TDD_ArtiReportCodeTitleTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/4.
//
//  故障码标题
//

#import "TDD_ArtiReportCodeTitleTableViewCell.h"

@implementation TDD_ArtiReportCodeTitleTableViewCell

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
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor tdd_reportCodeTitleTextColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@25);
        make.bottom.equalTo(@-5);
    }];
    
}

-(void)updateLayout {
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 24 : 16];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @40 : @15);
        make.right.equalTo(IS_IPad ? @-40 : @-15);
        make.top.equalTo((!self.isLower || IS_IPad) ? @25 : @5);
        make.bottom.equalTo(IS_IPad ? @-10 : @-5);
    }];
    
    self.nameLabel.textColor = [UIColor tdd_reportCodeTitleTextColor];
    self.contentView.backgroundColor = UIColor.tdd_reportBackground;
}

-(void)updateA4Layout {
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
    }];
    
    self.nameLabel.textColor = [UIColor tdd_reportCodeTitleTextColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
