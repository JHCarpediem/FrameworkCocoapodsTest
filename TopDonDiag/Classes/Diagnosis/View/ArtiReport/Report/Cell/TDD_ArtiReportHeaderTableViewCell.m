//
//  TDD_ArtiReportHeaderTableViewCell.m
//  AD200
//
//  Created by lecason on 2022/8/3.
//
//  系统报告状态 免责声明 数据流 头部
//

#import "TDD_ArtiReportHeaderTableViewCell.h"
#import "TDD_DashLineView.h"

@interface TDD_ArtiReportHeaderTableViewCell()

@property (nonatomic, strong) UIView *line;

@end

@implementation TDD_ArtiReportHeaderTableViewCell

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
    self.nameLabel = [[TDD_CustomLabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textAlignment = NSTextAlignmentLeft; 
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @55 : @30);
        make.top.equalTo(@15);
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    UIImage *image = [[UIImage tdd_imageDiagReportHeader] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 30) resizingMode:UIImageResizingModeStretch];
    imageView.image = image;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(-15);
        make.right.equalTo(self.nameLabel).offset(20);
        make.top.equalTo(self.nameLabel);
        make.bottom.equalTo(self.nameLabel);
    }];
    self.iconImageView = imageView;
    [self.contentView sendSubviewToBack:imageView];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor tdd_colorDiagTheme];
    self.line = line;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel).offset(20);
        make.right.equalTo(IS_IPad ? @-40 : @-15);
        make.height.equalTo(@2);
        make.bottom.equalTo(self.iconImageView).offset(IS_IPad ? 0 : -1);
    }];

}

-(void)updateLayout {
    if (IS_IPad) {
        self.iconImageView.image = kImageNamed(@"section_title_hd_bg");
    }
    self.nameLabel.font = [UIFont systemFontOfSize:IS_IPad ? 24 : 16];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IS_IPad ? @55 : @30);
        make.top.equalTo(@15);
    }];
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(-15);
        make.right.equalTo(self.nameLabel).offset(IS_IPad ? 40 : 20);
        make.top.equalTo(self.nameLabel);
        make.bottom.equalTo(self.nameLabel);
    }];
    
    self.contentView.backgroundColor = UIColor.tdd_reportHeadCellBackground;
}

-(void)updateA4Layout
{
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@15);
    }];
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(-15);
        make.right.equalTo(self.nameLabel).offset(20);
        make.top.equalTo(self.nameLabel);
        make.bottom.equalTo(self.nameLabel);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel).offset(20);
        make.right.equalTo(@-15);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.iconImageView).offset(-1);
    }];
    self.contentView.backgroundColor = [UIColor tdd_reportCodeSectionBackground];
}

@end
