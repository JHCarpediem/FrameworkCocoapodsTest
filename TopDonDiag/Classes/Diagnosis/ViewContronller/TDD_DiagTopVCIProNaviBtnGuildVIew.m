//
//  TDD_DiagTopVCIProNaviBtnGuildVIew.m
//  TopDonDiag
//
//  Created by liuyong on 2024/5/25.
//

#import "TDD_DiagTopVCIProNaviBtnGuildVIew.h"

@interface TDD_DiagTopVCIProNaviBtnGuildVIew ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *highlightView;
@property (nonatomic, strong) UIImageView *popImageView;
@property (nonatomic, strong) UIImageView *highlightImageView;

@property (nonatomic, strong) UIView *stepView;
@property (nonatomic, strong) TDD_CustomLabel *tipLabel;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) NSArray *tipArray;
@property (nonatomic, strong) NSArray *highlightImageArray;
@property (nonatomic, assign) NSInteger guildStep;

@property (nonatomic, assign) TDD_DiagNavType diagNavType;

@end


@implementation TDD_DiagTopVCIProNaviBtnGuildVIew

- (instancetype)initWithDiagType:(TDD_DiagNavType)diagNavType {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.guildStep = 0;
        self.diagNavType = diagNavType;

        if (self.diagNavType == TDD_DiagNavType_IMMO) {
            self.highlightImageArray = @[@"navi_more_diagnosis", @"nav_search_ic", @"navi_feedback_diagnosis"];
            self.tipArray = @[TDDLocalized.diagnose_guide_tip_one, TDDLocalized.diagnose_guide_tip_two, TDDLocalized.diagnose_guide_tip_three];
        } else {
            self.highlightImageArray = @[@"nav_search_ic", @"navi_feedback_diagnosis"];
            self.tipArray = @[TDDLocalized.diagnose_guide_tip_two, TDDLocalized.diagnose_guide_tip_three];
        }
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.bgView];
    [self addSubview:self.highlightView];
    [self.highlightView addSubview:self.popImageView];
    [self.highlightView addSubview:self.highlightImageView];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.stepView];
    [self.stepView addSubview:self.tipLabel];
    [self.stepView addSubview:self.nextBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    if (self.diagNavType != TDD_DiagNavType_IMMO) {

        self.highlightView.layer.cornerRadius = 18;
        [self.highlightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_right).offset(-104);
            make.top.equalTo(self).offset(StatusBarHeight + 4);
            make.width.height.mas_equalTo(36);
        }];
        
        self.popImageView.hidden = YES;
        [self.popImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.highlightView);
        }];
        
        [self.highlightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.highlightView);
            make.top.equalTo(self.highlightView).offset(7);
            make.width.height.mas_equalTo(22);
        }];
        
        
        
    } else {
        [self.highlightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-30);
            make.width.mas_equalTo(132);
            make.height.mas_equalTo(103);
            make.top.equalTo(self).offset(StatusBarHeight + 4);
        }];
        
        [self.popImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.highlightView);
        }];
        
        [self.highlightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.highlightView);
            make.top.equalTo(self.highlightView).offset(7);
            make.width.height.mas_equalTo(22);
        }];
    }

    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(6);
        make.centerX.equalTo(self.highlightView).offset(5);
        make.top.equalTo(self.highlightView.mas_bottom).offset(10);
    }];

    [self.stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-14);
        make.width.mas_equalTo(260);
        make.top.equalTo(self.arrowImageView.mas_bottom);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stepView).offset(18);
        make.centerX.equalTo(self.stepView);
        make.top.equalTo(self.stepView).offset(16);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.stepView).offset(-18);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(4);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.stepView).offset(-3);
    }];
    
    
}

- (void)show {
    [FLT_APP_WINDOW addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}


- (void)nextBtnClick {
    if (self.diagNavType != TDD_DiagNavType_IMMO) {
        
        if (self.guildStep < self.tipArray.count - 1) {
            self.guildStep++;
            self.highlightImageView.image = kImageNamed(self.highlightImageArray[self.guildStep]);
            self.tipLabel.text = self.tipArray[self.guildStep];
            if (self.guildStep == self.tipArray.count - 1) {
                [self.nextBtn setTitle:TDDLocalized.got_it forState:UIControlStateNormal];
            } else {
                [self.nextBtn setTitle:TDDLocalized.app_next forState:UIControlStateNormal];
            }
            
            [self.highlightView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_right).offset(-68);
                make.top.equalTo(self).offset(StatusBarHeight + 4);
                make.width.height.mas_equalTo(36);
            }];
        } else if (self.guildStep == self.tipArray.count - 1) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserDefaultDiagNaviGuild];
            [self dismiss];
        }
        
    } else {
        if (self.guildStep < self.tipArray.count - 1) {
            self.popImageView.hidden = YES;
            self.highlightView.layer.cornerRadius = 18;
            self.guildStep++;
            if (self.guildStep == 1) {
                if (self.block) {
                    self.block(YES);
                }
                [FLT_APP_WINDOW bringSubviewToFront:self];
            } 

            self.highlightImageView.image = kImageNamed(self.highlightImageArray[self.guildStep]);
            self.tipLabel.text = self.tipArray[self.guildStep];
            if (self.guildStep == self.tipArray.count - 1) {
                [self.nextBtn setTitle:TDDLocalized.got_it forState:UIControlStateNormal];
            } else {
                [self.nextBtn setTitle:TDDLocalized.app_next forState:UIControlStateNormal];
            }
            
            CGFloat right = -113 - 18;
            CGFloat top = NavigationHeight + 5;
            if (self.guildStep == 2) {
                right = -60 - 18;
            } else if (self.guildStep == 3) {
                right = -50 - 18;
                top = StatusBarHeight + 4;
            }
            
            [self.highlightView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_right).offset(right);
                make.top.equalTo(self).offset(top);
                make.width.height.mas_equalTo(36);
            }];
            
            [self.arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.highlightView);
            }];
        } else if (self.guildStep == self.tipArray.count - 1) {
            if (self.block) {
                self.block(NO);
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserDefaultDiagNaviGuild];
            [self dismiss];
        }
    }

}


#pragma mark -- lazy UI
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.5];
    }
    return _bgView;
}

- (UIView *)highlightView {
    if (!_highlightView) {
        _highlightView = [[UIView alloc] init];
        _highlightView.backgroundColor = [UIColor whiteColor];
        _highlightView.layer.masksToBounds = YES;
        _highlightView.layer.cornerRadius = 5;
    }
    return _highlightView;
}

- (UIImageView *)popImageView {
    if (!_popImageView) {
        _popImageView = [[UIImageView alloc] init];
        _popImageView.image = kImageNamed(@"guide_btn_pop_topvcipro");
    }
    return _popImageView;
}

- (UIImageView *)highlightImageView {
    if (!_highlightImageView) {
        _highlightImageView = [[UIImageView alloc] init];
        _highlightImageView.image = kImageNamed(self.highlightImageArray[0]);
    }
    return _highlightImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = kImageNamed(@"icon_diag_arrow");
    }
    return _arrowImageView;
}

- (UIView *)stepView {
    if (!_stepView) {
        _stepView = [[UIView alloc] init];
        _stepView.layer.cornerRadius = 3;
        _stepView.layer.masksToBounds = YES;
        _stepView.backgroundColor = [UIColor whiteColor];
    }
    return _stepView;
}

- (TDD_CustomLabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[TDD_CustomLabel alloc] init];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = self.tipArray[0];
        _tipLabel.textColor = [UIColor tdd_color333333];
        _tipLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] tdd_adaptHD];
    }
    return _tipLabel;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitleColor:[UIColor tdd_colorDiagTheme] forState:UIControlStateNormal];
        [_nextBtn setTitle:TDDLocalized.app_next forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] tdd_adaptHD];
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}


@end
