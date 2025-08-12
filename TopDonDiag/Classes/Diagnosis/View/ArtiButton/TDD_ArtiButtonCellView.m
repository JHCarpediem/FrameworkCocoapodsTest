//
//  TDD_ArtiButtonCellView.m
//  AD200
//
//  Created by 何可人 on 2022/4/28.
//

#import "TDD_ArtiButtonCellView.h"
@import TDBasis;

@interface TDD_ArtiButtonCellView ()

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) UIImageView *lockIcon;

@end

@implementation TDD_ArtiButtonCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        HLog(@"创建cell");
        self.backgroundColor = [UIColor clearColor];
        
        self.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{
    _scale = IS_IPad ? HD_HHeight : H_Height;
    UIButton * btn = ({
        UIButton * btn = [TDD_VXXScrollButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 10000;
        UIColor *normalBgColor = UIColor.tdd_btnNormalBackground;
        UIColor *disableBGColor = UIColor.tdd_btnDisableBackground;
        UIColor *titleColor = UIColor.tdd_btnNormalTitle;
        UIColor *titleDisableColor = UIColor.tdd_btnDisableTitle;
        btn.frame = CGRectMake(0, 0, IS_IPad ? 160 * _scale : 100 * _scale, IS_IPad ? 50 * _scale : 35 * _scale);
        btn.center = CGPointMake(btn.center.x, IS_IPad ? (100 * _scale / 2.0) : (59 * _scale / 2.0));
        btn.titleLabel.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:titleDisableColor forState:UIControlStateDisabled];
        
//        [btn td_setBackgroundColor:normalBgColor forState:UIControlStateNormal animated:YES];
//        [btn td_setBackgroundColor:disableBGColor forState:UIControlStateDisabled animated:YES];
        [btn setBackgroundImage:[UIImage tdd_imageWithColor:normalBgColor rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage tdd_imageWithColor:disableBGColor rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateDisabled];
        [btn setBackgroundImage:[UIImage tdd_imageWithColor:[UIColor tdd_btnHightlightBackground] rect:CGRectMake(0, 0, 1, 1)] forState:UIControlStateHighlighted];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        btn.titleLabel.numberOfLines = 0;
        btn.layer.cornerRadius = (isKindOfTopVCI ? 5 : 1.5) * _scale;
        btn.layer.masksToBounds = YES;
        if (!isKindOfTopVCI) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor tdd_colorDiagTheme].CGColor;
        }
        btn;
    });
    [self.contentView addSubview:btn];
    self.btn = btn;
    
    [self.contentView addSubview:self.lockIcon];
    [_lockIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20 * _scale, 20 * _scale));
        make.top.equalTo(self.btn).offset(-10 * _scale);
        make.right.equalTo(self.btn).offset(10 * _scale);
    }];
}

- (void)setModel:(TDD_ArtiButtonModel *)model{
    _model = model;
    
    NSString * titleStr = @"";
    
    if (self.isShowTranslated) {
        titleStr = [TDD_HLanguage getLanguage:model.strTranslatedButtonText];
    }else {
        titleStr = [TDD_HLanguage getLanguage:model.strButtonText];
    }
    titleStr = [titleStr stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    titleStr = [titleStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.btn.titleLabel.text = titleStr;
    [self.btn setTitle:titleStr forState:UIControlStateNormal];
    
    if (model.uStatus == ArtiButtonStatus_DISABLE || !model.bIsEnable) {
        self.btn.enabled = NO;
        self.btn.layer.borderColor = [UIColor tdd_colorWithHex:0xE9E9E9].CGColor;
    }else{
        self.btn.enabled = YES;
        self.btn.layer.borderColor = [UIColor tdd_colorDiagTheme].CGColor;
    }
    //按钮锁定
    if (model.uStatus == ArtiButtonStatus_ENABLE && model.bIsEnable && model.isLock) {
        self.lockIcon.hidden = false;
    }else {
        self.lockIcon.hidden = true;
    }
    
    if (model.uStatus == ArtiButtonStatus_UNVISIBLE) {
        self.btn.hidden = YES;
    }else{
        self.btn.hidden = NO;
    }
}

- (void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(ArtiButtonCellButtonClick:cell:)]) {
        [self.delegate ArtiButtonCellButtonClick:btn cell:self];
    }
}


#pragma mark - lazy
- (UIImageView *)lockIcon {
    if (!_lockIcon) {
        _lockIcon = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiagBtnLockIcon]];
    }
    return _lockIcon;
}
@end
