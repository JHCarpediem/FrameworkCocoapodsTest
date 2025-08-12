//
//  TDD_ArtiFuelLevelView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/17.
//

#import "TDD_ArtiFuelLevelView.h"
@interface TDD_ArtiFuelLevelView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, strong)UIImageView *topImgView;
@property (nonatomic, strong)TDD_CustomLabel *topLabel;
@property (nonatomic, strong)TDD_CustomLabel *topTipsLabel;
@property (nonatomic, strong)UIImageView *oliImgBGView;
@property (nonatomic, strong)UIImageView *oliImgRoundView;
@property (nonatomic, strong)UIView *oliIndicatorBGView;
@property (nonatomic, strong)UIImageView *oliImgIndicatorView;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIView *oliBGView;
@property (nonatomic, strong)TDD_CustomLabel *numZeroLab;
@property (nonatomic, strong)TDD_CustomLabel *numHundredLab;
@property (nonatomic, strong)TDD_CustomLabel *bottomTipsLab;
@property (nonatomic, strong)TDD_CustomLabel *bottomValueLab;
@property (nonatomic, strong)TDD_CustomLabel *warnTipsLabel;
@property (nonatomic, assign)CGFloat scale;
// 记录手势开始地址
@property (nonatomic, assign) CGPoint beganPoint;
// 记录当前试图开始的FrameOrigin
@property (nonatomic, assign) CGPoint beganOrigin;

@property (nonatomic, assign) CGPoint nowPoint;
@property (nonatomic, assign) CGPoint nowOrigin;
@end
@implementation TDD_ArtiFuelLevelView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, self.tdd_height)];
    _bgScrollView.bounces = NO;
    _bgScrollView.backgroundColor = [UIColor tdd_collectionViewBG];
    [self addSubview:_bgScrollView];
    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_bgScrollView addSubview:self.topImgView];
    UIView *shadowView = [UIView new];
    shadowView.layer.cornerRadius = 2.5;
    shadowView.layer.shadowColor = [UIColor tdd_colorWithHex:0x120505].CGColor;
    shadowView.layer.shadowRadius = 5;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [self.topImgView addSubview:shadowView];
    
    [self.topImgView addSubview:self.topLabel];
    [self.topImgView addSubview:self.topTipsLabel];
    [self.topImgView addSubview:self.oliImgBGView];
    [self.topImgView addSubview:self.oliIndicatorBGView];
    [self.oliIndicatorBGView addSubview:self.oliImgIndicatorView];
    [self.topImgView addSubview:self.oliImgRoundView];
    
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topImgView);
    }];
    
    [_topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16 * _scale);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(335 * _scale, 260 * _scale));
    }];
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImgView).offset(18 * _scale);
        make.left.equalTo(_topImgView).offset(20 * _scale);
    }];
    
    [_topTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topLabel);
        make.top.equalTo(_topLabel.mas_bottom).offset(8 * _scale);
    }];
    
    [_oliImgBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topTipsLabel.mas_bottom).offset(10 * _scale);
        make.centerX.equalTo(_topImgView);
        make.size.mas_equalTo(CGSizeMake(192 * _scale, 196 * _scale));
    }];
    
    [_oliIndicatorBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_oliImgRoundView);
        make.height.mas_equalTo(_oliIndicatorBGView.mas_width).multipliedBy(1);
    }];
    
    [_oliImgIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oliIndicatorBGView);
        make.bottom.equalTo(_oliIndicatorBGView).offset(-28.5 * _scale);
        make.centerX.equalTo(_oliIndicatorBGView);
    }];
    
    [_oliImgRoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImgView).offset(133 * _scale);
        make.centerX.equalTo(_oliImgBGView);
        make.size.mas_equalTo(CGSizeMake(28.5 * _scale, 28.5 * _scale));
    }];
    
    
    UIView *shadowBottomView = [UIView new];
    shadowBottomView.backgroundColor = [UIColor whiteColor];
    shadowBottomView.layer.cornerRadius = 2.5;
    shadowBottomView.layer.shadowColor = [UIColor tdd_colorWithHex:0x120505 alpha:0.08].CGColor;
    shadowBottomView.layer.shadowRadius = 5;
    shadowBottomView.layer.shadowOpacity = 1;
    shadowBottomView.layer.shadowOffset = CGSizeMake(0, 2);
    [_bgScrollView addSubview:shadowBottomView];
    [_bgScrollView addSubview:self.bottomView];
    [shadowBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomView);
    }];
    
    [_bottomView addSubview:self.bottomTipsLab];
    [_bottomView addSubview:self.bottomValueLab];
    [_bottomView addSubview:self.warnTipsLabel];
    [_bottomView addSubview:self.numZeroLab];
    [_bottomView addSubview:self.numHundredLab];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(20 * _scale);
        make.top.equalTo(_topImgView.mas_bottom).offset(16 * _scale);
        make.bottom.equalTo(_bottomValueLab).offset(20 * _scale);
    }];
    [_bottomTipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView).offset(20 * _scale);
        make.centerX.equalTo(_bottomView);
    }];
    _oliBGView = [UIView new];
    [_bottomView addSubview:_oliBGView];
    [_oliBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(24 * _scale);
        make.right.equalTo(_bottomView).offset(-24 * _scale);
        make.top.equalTo(_bottomTipsLab.mas_bottom).offset(12 * _scale);
    }];
    
    UIView *lastView;
    CGFloat btnW = (IphoneWidth - 88 * _scale) / 10;
    for (int i = 0; i < 10; i++) {
        UIButton *oliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        oliBtn.tag = 100 + i;
        if (i == 0) {
            [oliBtn setImage:kImageNamed(@"adas_oll_select_red_left") forState:UIControlStateSelected];
            [oliBtn setImage:kImageNamed(@"adas_oll_select_gray_left") forState:UIControlStateNormal];
        }else if (i == 9){
            [oliBtn setImage:kImageNamed(@"adas_oll_select_green_right") forState:UIControlStateSelected];
            [oliBtn setImage:kImageNamed(@"adas_oll_select_gray_right") forState:UIControlStateNormal];
        }else {
            [oliBtn setImage:(i<3) ? kImageNamed(@"adas_oll_select_red_mid") : kImageNamed(@"adas_oll_select_green_mid") forState:UIControlStateSelected];
            [oliBtn setImage:kImageNamed(@"adas_oll_select_gray_mid") forState:UIControlStateNormal];
        }
        if (i < 5) {
            [oliBtn setSelected:YES];
        }else {
            [oliBtn setSelected:NO];
        }
        
        [oliBtn addTarget:self action:@selector(oliSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        [_oliBGView addSubview:oliBtn];
        [oliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_oliBGView);
            make.left.equalTo(lastView?lastView.mas_right:_oliBGView).offset(0);
            make.width.mas_equalTo(btnW);
            if (i == 9) {
                make.right.equalTo(_oliBGView).offset(0);
            }
        }];
        lastView = oliBtn;
    }
    UIPanGestureRecognizer *swip = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    swip.delegate = self;
    swip.maximumNumberOfTouches = 1;
    [_oliBGView addGestureRecognizer:swip];
    
    [_numZeroLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(24 * _scale);
        make.top.equalTo(lastView.mas_bottom).offset(5 * _scale);
    }];
    
    [_numHundredLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView).offset(-24 * _scale);
        make.top.equalTo(_numZeroLab);
    }];
    
    [_bottomValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView);
        make.top.equalTo(_numZeroLab.mas_bottom).offset(22 * _scale);
    }];
    [_warnTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView);
        make.top.equalTo(_bottomValueLab.mas_bottom).offset(8 * _scale);
    }];
}

- (void)setFuelLevelModel:(TDD_ArtiFuelLevelModel *)fuelLevelModel {
    _fuelLevelModel = fuelLevelModel;
    
    [self setOliImdicatorLevel:fuelLevelModel.oliValue];
    _warnTipsLabel.hidden = !_fuelLevelModel.showWarning;
    _warnTipsLabel.text = _fuelLevelModel.warningTips;
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(20 * _scale);
        make.top.equalTo(_topImgView.mas_bottom).offset(16 * _scale);
        make.bottom.equalTo(fuelLevelModel.showWarning?_warnTipsLabel:_bottomValueLab).offset(20 * _scale);

    }];
}

- (void)oliSelect:(UIButton *)btn {

    [btn setSelected:YES];
    [self setOliImdicatorLevel:btn.tag - 100 + 1];
    _fuelLevelModel.showWarning = _fuelLevelModel.oliValue <= 3;
    [self setFuelLevelModel:_fuelLevelModel];
}


- (void)swipAction:(UIPanGestureRecognizer *)panGesture {
    if (!panGesture || !panGesture.view) {
        return;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.beganPoint = [panGesture translationInView:panGesture.view];
            self.beganOrigin = self.frame.origin;
            self.nowPoint = self.nowOrigin = [panGesture locationInView:_oliBGView];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [panGesture translationInView:panGesture.view];
            CGFloat offsetX = (point.x - _beganPoint.x);
            CGFloat offsetY = (point.y - _beganPoint.y);
            
            if ((offsetX < 10 && offsetX >= 0) || (offsetX > -10 && offsetX <= 0)) {
                return;
            }
            _nowOrigin = CGPointMake(_nowPoint.x + offsetX, _nowPoint.y + offsetY);
            if (_nowOrigin.x < _oliBGView.tdd_left) {
                [self setOliImdicatorLevel:0];
                return;
            }

            for (int i = 0; i < 10; i++) {
                UIButton *button = [_bottomView viewWithTag:100 + i];
//                if (i = 0 && button.frame.origin.x >= _nowOrigin.x) {
//                    [self setOliImdicatorLevel:0];
//                    break;
//                }
                if (button.frame.origin.x < _nowOrigin.x && button.tdd_right > _nowOrigin.x) {
                    [button setSelected:YES];
                    [self setOliImdicatorLevel:button.tag - 100 + 1];
                    break;
                }
        
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            _fuelLevelModel.showWarning = _fuelLevelModel.oliValue <= 3;
            [self setFuelLevelModel:_fuelLevelModel];
        }
            break;
        default:
            break;
    }
    
}



- (void)oliDraw:(UIButton *)btn {
    for (int i = 0; i < 10; i++) {
        UIButton *button = [_bottomView viewWithTag:100 + i];
        [button setSelected:i < (btn.tag - 100)];
    }
    [btn setSelected:YES];
    [self setOliImdicatorLevel:btn.tag - 100 + 1];
}

- (void)setOliImdicatorLevel:(NSInteger )round {
    for (int i = 0; i < 10; i++) {
        UIButton *button = [_bottomView viewWithTag:100 + i];
        [button setSelected:i < round];
    }
    _fuelLevelModel.oliValue = (uint32_t)round;
    NSString *oliStr = [NSString stringWithFormat:@"%@: ", TDDLocalized.fuel_level];
    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:[NSString stringWithFormat:@"%@%d%%",oliStr,_fuelLevelModel.oliValue * 10]];
    UIColor *oliColor = _fuelLevelModel.oliValue>3?[UIColor tdd_color333333]:[UIColor tdd_errorRed];
    [attStr yy_setColor:oliColor range:NSMakeRange(oliStr.length, attStr.length-oliStr.length)];
    _bottomValueLab.attributedText = attStr;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat angle = ((round - 5) / 10.0) * (74/90.0) * M_PI;
        CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
        //CGAffineTransform roundTransForm = CGAffineTransformTranslate(transform, 0.5, 1);
        self.oliIndicatorBGView.transform = transform;
    }];
}


- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:kImageNamed(@"adas_bg")];
    }
    return _topImgView;;
}

- (UIImageView *)oliImgBGView {
    if (!_oliImgBGView) {
        _oliImgBGView = [[UIImageView alloc] initWithImage:kImageNamed(@"adas_oll_bg")];
    }
    return _oliImgBGView;;
}

- (UIView *)oliIndicatorBGView {
    if (!_oliIndicatorBGView) {
        _oliIndicatorBGView = [UIView new];
        //_oliIndicatorBGView.backgroundColor = UIColor.redColor;
    }
    return _oliIndicatorBGView;
}

- (UIImageView *)oliImgIndicatorView {
    if (!_oliImgIndicatorView) {
        _oliImgIndicatorView = [[UIImageView alloc] initWithImage:kImageNamed(@"adas_oll_indicator")];
    }
    return _oliImgIndicatorView;;
}

- (UIImageView *)oliImgRoundView {
    if (!_oliImgRoundView) {
        _oliImgRoundView = [[UIImageView alloc] initWithImage:kImageNamed(@"adas_oll_indicator_round")];
    }
    return _oliImgRoundView;;
}

- (TDD_CustomLabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [TDD_CustomLabel new];
        _topLabel.textColor = [UIColor tdd_color333333];
        _topLabel.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
        _topLabel.text = TDDLocalized.fuel_level;
    }
    return _topLabel;
}

- (TDD_CustomLabel *)topTipsLabel {
    if (!_topTipsLabel) {
        _topTipsLabel = [TDD_CustomLabel new];
        _topTipsLabel.textColor = [UIColor tdd_color666666];
        _topTipsLabel.font = [[UIFont systemFontOfSize:11 weight:UIFontWeightRegular] tdd_adaptHD];
        _topTipsLabel.numberOfLines = 0;
        _topTipsLabel.text = [NSString stringWithFormat:@"* %@", TDDLocalized.input_oli];
        
    }
    return _topTipsLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.layer.cornerRadius = 2.5 * _scale;
        _bottomView.layer.borderColor = [[UIColor tdd_colorWithHex:0xe2e2e2] CGColor];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}

- (TDD_CustomLabel *)numZeroLab {
    if (!_numZeroLab) {
        _numZeroLab = [[TDD_CustomLabel alloc] init];
        _numZeroLab.textColor = [UIColor tdd_color999999];
        _numZeroLab.font = [[UIFont systemFontOfSize:11 weight:UIFontWeightRegular] tdd_adaptHD];
        _numZeroLab.text = @"0";
    }
    return _numZeroLab;
}

- (TDD_CustomLabel *)numHundredLab {
    if (!_numHundredLab) {
        _numHundredLab = [[TDD_CustomLabel alloc] init];
        _numHundredLab.textColor = [UIColor tdd_color999999];
        _numHundredLab.font = [[UIFont systemFontOfSize:11 weight:UIFontWeightRegular] tdd_adaptHD];
        _numHundredLab.text = @"100";
    }
    return _numHundredLab;
}

- (TDD_CustomLabel *)bottomTipsLab {
    if (!_bottomTipsLab) {
        _bottomTipsLab = [TDD_CustomLabel new];
        _bottomTipsLab.textColor = [UIColor tdd_color999999];
        _bottomTipsLab.font = [[UIFont systemFontOfSize:11 weight:UIFontWeightRegular] tdd_adaptHD];
        _bottomTipsLab.numberOfLines = 0;
        _bottomTipsLab.text = TDDLocalized.oli_select_tip;
    }
    return _bottomTipsLab;;
}

- (TDD_CustomLabel *)bottomValueLab {
    if (!_bottomValueLab) {
        _bottomValueLab = [TDD_CustomLabel new];
        _bottomValueLab.textColor = [UIColor tdd_color333333];
        _bottomValueLab.font = [[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] tdd_adaptHD];
        _bottomValueLab.numberOfLines = 0;
        _bottomValueLab.text = [NSString stringWithFormat:@"%@: 50%", TDDLocalized.fuel_level];
    }
    return _bottomValueLab;
}

- (TDD_CustomLabel *)warnTipsLabel {
    if (!_warnTipsLabel) {
        _warnTipsLabel = [TDD_CustomLabel new];
        _warnTipsLabel.textColor = [UIColor tdd_errorRed];
        _warnTipsLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
        _warnTipsLabel.hidden = YES;
        _warnTipsLabel.numberOfLines = 0;
    }
    return _warnTipsLabel;
}
@end
