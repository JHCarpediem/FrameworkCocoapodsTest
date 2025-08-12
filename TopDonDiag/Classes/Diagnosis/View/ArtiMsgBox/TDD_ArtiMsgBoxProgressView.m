//
//  TDD_ArtiMsgBoxProgressView.m
//  AD200
//
//  Created by 何可人 on 2022/7/26.
//

#import "TDD_ArtiMsgBoxProgressView.h"

@interface TDD_ArtiMsgBoxProgressView ()
@property (nonatomic, strong) UIView * progressView;
@property (nonatomic, strong) TDD_CustomLabel * progressLab;
@property (nonatomic, assign) CGFloat height;
@end

@implementation TDD_ArtiMsgBoxProgressView


- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_line];
        _height = IS_IPad ? 30 * HD_Height : 30 * H_Height;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.height);
        }];
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    UIView * progressView = [[UIView alloc] init];
    progressView.backgroundColor = [UIColor tdd_colorDiagTheme];
    [self addSubview:progressView];
    self.progressView = progressView;
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0);
    }];
    
    TDD_CustomLabel * progressLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = [NSString stringWithFormat:@"0%%"];
        label.font = [[UIFont systemFontOfSize:12] tdd_adaptHD];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor tdd_progressTitleTextColor];
        label;
    });
    [self addSubview:progressLab];
    self.progressLab = progressLab;
    
    [progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    
    [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(progress);
    }];
    
    self.progressLab.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
    
    [self setNeedsUpdateConstraints];
    
    self.progressView.backgroundColor = [UIColor tdd_colorDiagProgressGradient:TDD_GradientStyleLeftToRight withFrame:CGSizeMake(IphoneWidth * progress, self.height)];
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    float h = self.height;
    
    if (hidden) {
        h = 0;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
    }];
}

@end
