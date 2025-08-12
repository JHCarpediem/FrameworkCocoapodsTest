//
//  TDD_ArtiReportGeneratorSelectTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/10.
//

#import "TDD_ArtiReportGeneratorSelectTableViewCell.h"
#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>

@interface TDD_ArtiReportGeneratorSelectTableViewCell ()

@property (nonatomic, assign) BOOL rotateFlag;

@end

@implementation TDD_ArtiReportGeneratorSelectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.backgroundColor = UIColor.tdd_btnBackground;
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = UIColor.cardBg;
    bg.layer.cornerRadius = 4;
    [self.contentView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @40 : @15);
        make.center.equalTo(self.contentView);
        make.top.equalTo(@15);
    }];
    
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor tdd_title];
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 20 : 15];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 0;
    [bg addSubview:self.nameLabel];
    self.nameLabel.text = TDDLocalized.report_system_type_before;

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@-15);
    }];
    
    self.arrow = [[UIImageView alloc] init];
    self.arrow.image = kImageNamed(@"down_arrow");
    [bg addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(bg);
    }];
  
}

-(void)setSelectedIndex:(int)selectedIndex
{
    if (selectedIndex == 0) {
        self.nameLabel.text = TDDLocalized.report_system_type_before;
    } else if (selectedIndex == 1) {
        self.nameLabel.text = TDDLocalized.report_system_type_after;
    } else if (selectedIndex == 2) {
        self.nameLabel.text = TDDLocalized.report_system_type_ing;
    }
    
    if (_isADAS) {
        self.nameLabel.text = [[self.nameLabel.text replaceBeforeMaintenanceToCalibration] replaceAfterMaintenanceToCalibration];
    }
}

- (void)arrowImageRotate {
    self.rotateFlag = !self.rotateFlag;
    if (self.rotateFlag) {
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.arrow.transform = CGAffineTransformMakeRotation(2 * M_PI);
    }
}

@end
