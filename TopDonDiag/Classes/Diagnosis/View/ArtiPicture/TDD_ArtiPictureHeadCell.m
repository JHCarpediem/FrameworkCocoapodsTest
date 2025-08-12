//
//  TDD_ArtiPictureHeadCell.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/8/15.
//

#import "TDD_ArtiPictureHeadCell.h"
@interface TDD_ArtiPictureHeadCell()
@property (nonatomic, strong) TDD_CustomLabel * titleLabel;
@end
@implementation TDD_ArtiPictureHeadCell

+ (NSString *)reuseIdentifier {
    return @"pictureCellHeadIdentifier";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.contentView.backgroundColor = [UIColor tdd_cellBackground];
    
    CGFloat bottomViewH  = 0;
    CGFloat horizontalSpace = 0;
    CGFloat verticalSpace = 0;
    CGFloat fontSize = 0;
    if (IS_IPad){
        bottomViewH = 20 * HD_HHeight;
        horizontalSpace = 40 * HD_Height;
        verticalSpace = 30 * HD_HHeight;
        fontSize = 18;
    }else {
        bottomViewH = 10 * H_HHeight;
        horizontalSpace = 16 * H_Height;
        verticalSpace = 20 * H_HHeight;
        fontSize = 14;
    }
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor tdd_colorWithHex:0xf8f8f8];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomViewH);
        make.left.right.bottom.equalTo(self.contentView);
    }];
    
    TDD_CustomLabel *textLabel = [[TDD_CustomLabel alloc] init];
    [textLabel setTextColor:[UIColor tdd_title]];
    textLabel.font = [[UIFont systemFontOfSize:fontSize] tdd_adaptHD];
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.numberOfLines = 0;
    self.titleLabel = textLabel;
    [self.contentView addSubview:self.titleLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(horizontalSpace);
        make.top.equalTo(self.contentView).offset(verticalSpace);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(bottomView.mas_top).offset(-verticalSpace);
    }];
    

}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
}
@end
