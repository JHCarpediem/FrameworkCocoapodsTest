//
//  TDD_ArtiTroubleAIGuildView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/3/7.
//

#import "TDD_ArtiTroubleAIGuildView.h"
@interface TDD_ArtiTroubleAIGuildView()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *highlightImageView;

@property (nonatomic, strong) UIView *stepView;
@property (nonatomic, strong) TDD_CustomLabel *tipLabel;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_ArtiTroubleAIGuildView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _scale = IS_IPad ? HD_Height : H_Height;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
    [self addSubview:self.bgView];
    [self addSubview:self.highlightImageView];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.stepView];
    [self.stepView addSubview:self.tipLabel];
    [self.stepView addSubview:self.confirmBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
}

- (void)showWithPopPoint:(CGPoint)point {
    [FLT_APP_WINDOW addSubview:self];
    [self.highlightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(point.y - 18 * _scale);
        make.left.equalTo(self).offset(point.x - 18 * _scale);
        make.width.height.mas_equalTo(36 * _scale);
    }];
    if (point.y > IphoneHeight - point.y - 20) {

        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(6);
            make.centerX.equalTo(self.highlightImageView);
            make.bottom.equalTo(self.highlightImageView.mas_top).offset(-10);
        }];
        
        [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView).offset(5);
            make.width.mas_equalTo(260);
            make.bottom.equalTo(self.arrowImageView.mas_top);
        }];
        

        self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
    }else {
        
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(6);
            make.centerX.equalTo(self.highlightImageView);
            make.top.equalTo(self.highlightImageView.mas_bottom).offset(10);
        }];
        
        [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView).offset(5);
            make.width.mas_equalTo(260);
            make.top.equalTo(self.arrowImageView.mas_bottom);
        }];
    }

    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stepView).offset(18);
        make.centerX.equalTo(self.stepView);
        make.top.equalTo(self.stepView).offset(16);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.stepView).offset(-18);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(4);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.stepView).offset(-3);
    }];

}

- (void)dismiss {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TDDDidShowTroubleGuild];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self removeFromSuperview];
}

#pragma mark -- lazy UI
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.5];
    }
    return _bgView;
}

- (UIImageView *)highlightImageView {
    if (!_highlightImageView) {
        _highlightImageView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiagGuildAIIcon]];
    }
    return _highlightImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [kImageNamed(@"icon_diag_arrow") tdd_imageByTintColor:[UIColor tdd_colorWithHex:0x1b212a]];
    }
    return _arrowImageView;
}

- (UIView *)stepView {
    if (!_stepView) {
        _stepView = [[UIView alloc] init];
        _stepView.layer.cornerRadius = 3;
        _stepView.layer.masksToBounds = YES;
        _stepView.backgroundColor = [UIColor tdd_alertBg];
    }
    return _stepView;
}

- (TDD_CustomLabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[TDD_CustomLabel alloc] init];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = TDDLocalized.diag_trouble_ai_leed;
        _tipLabel.textColor = [UIColor tdd_title];
        _tipLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] tdd_adaptHD];
    }
    return _tipLabel;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
        [_confirmBtn setTitle:TDDLocalized.app_i_known forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] tdd_adaptHD];
        [_confirmBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
@end
