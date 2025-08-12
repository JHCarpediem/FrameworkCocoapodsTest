//
//  TDD_ArtiSystemCellView.m
//  AD200
//
//  Created by 何可人 on 2022/7/29.
//

#import "TDD_ArtiSystemCellView.h"

@interface TDD_ArtiSystemCellView ()
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@property (nonatomic, strong) UIView * rightView;
@property (nonatomic, strong) TDD_CustomLabel * statusLab;
@property (nonatomic, strong) CAGradientLayer * gl;
@property (nonatomic, strong) UIButton * bottomButton;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat statusSuperRightSpace;
@property (nonatomic, strong) UIButton * adasButton;
@end

@implementation TDD_ArtiSystemCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    _scale = IS_IPad ? HD_Height : H_Height;
    CGFloat leftSpace = IS_IPad ? 40 : 20;
    _topSpace = IS_IPad ? 20 : 10;
    CGFloat rightViewLeftSpace = IS_IPad ? 20 : 10;
    CGFloat rightViewRightSpace = IS_IPad ? 32 : 10;
    CGFloat rightViewSuperRightSpace = IS_IPad ? 90 : 40;
    _statusSuperRightSpace = IS_IPad ? 86 : 35;
    
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor tdd_systemScanBgGradient:TDD_GradientStyleLeftToRight withFrame:CGSizeMake(IphoneWidth, 50 * _scale)];
    backView.hidden = YES;
    [self addSubview:backView];
    self.backView = backView;
    
    UIButton * bottomButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(bottomButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(bottomButtonClickDown) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(bottomButtonClickCancel) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchUpInside | UIControlEventTouchCancel];
        btn;
    });
    [self addSubview:bottomButton];
    self.bottomButton = bottomButton;
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self addSubview:titleLab];
    self.titleLab = titleLab;
    
    UIView *rightView = [UIView new];
    _rightView = rightView;
    [self addSubview:rightView];
    
    UIButton * adasButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:kImageNamed(@"arti_adas_system_icon") forState:0];
        btn.hidden = YES;
        [btn addTarget:self action:@selector(adasClick) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [rightView addSubview:adasButton];
    self.adasButton = adasButton;
    
    TDD_CustomLabel * statusLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.textAlignment = NSTextAlignmentRight;
        label.numberOfLines = 0;
        label;
    });
    [rightView addSubview:statusLab];
    self.statusLab = statusLab;
    
    UIImageView * arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = kImageNamed(@"system_arrow");
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:arrowImageView];
    self.arrowImageView = arrowImageView;
    if (isKindOfTopVCI){
        _arrowImageView.hidden = YES;
    }
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_topSpace * _scale);
        make.left.equalTo(self).offset(leftSpace * _scale);
        make.centerY.equalTo(self);
        make.right.equalTo(rightView.mas_left);
        //make.height.mas_greaterThanOrEqualTo(40 * _scale).priorityHigh();
        make.bottom.lessThanOrEqualTo(titleLab.superview).offset(-_topSpace * _scale);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_topSpace * _scale);
        make.left.equalTo(titleLab.mas_right).offset(rightViewLeftSpace * _scale).priorityHigh();
//        make.left.equalTo(self.mas_right).offset(- IphoneWidth / 3.0).priorityHigh();
        make.right.equalTo(arrowImageView.mas_left).offset(-rightViewRightSpace * _scale);
        make.width.mas_equalTo(IphoneWidth / 3.0 - rightViewSuperRightSpace * _scale);
        //make.height.mas_greaterThanOrEqualTo(40 * H_Height).priorityHigh();
        make.bottom.lessThanOrEqualTo(titleLab.superview).offset(-_topSpace * _scale);
    }];
    
    [adasButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.greaterThanOrEqualTo(rightView);
        //make.right.equalTo(statusLab.mas_left).offset(-8 * _scale);
        make.size.mas_equalTo(CGSizeMake(30 * _scale, 30 * _scale));
    }];
    
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_topSpace * _scale);
        make.left.equalTo(rightView).offset(0);
        make.right.equalTo(rightView).offset(-_statusSuperRightSpace * _scale);
//        make.width.mas_equalTo(IphoneWidth / 3.0 - 30 * _scale);
        //make.height.mas_greaterThanOrEqualTo(40 * _scale).priorityHigh();
        make.centerY.equalTo(self);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-leftSpace * _scale);
        make.centerY.equalTo(statusLab);
        make.size.mas_equalTo(CGSizeMake((IS_IPad ? 20 : 10) * _scale, (IS_IPad ? 20 : 10) * _scale));
    }];
}

- (void)setSystemItemModel:(ArtiSystemItemModel *)systemItemModel
{
    _systemItemModel = systemItemModel;
    if isKindOfTopVCI {
        _arrowImageView.hidden = YES;
    }
    self.statusLab.text = @"";
    
//    self.titleLab.text = [NSString stringWithFormat:@"%d %@", systemItemModel.uIndex + 1, systemItemModel.strItem];
//    self.titleLab.text = [NSString stringWithFormat:@"%d %@", self.index + 1, systemItemModel.strItem];
    self.titleLab.text = [NSString stringWithFormat:@"%@", systemItemModel.strItem];
    
    self.statusLab.textColor = [UIColor tdd_title];
    
//    self.titleLab.text = [NSString stringWithFormat:@"%d %@", systemItemModel.uIndex + 1, systemItemModel.strItem];
//    self.titleLab.text = [NSString stringWithFormat:@"%d %@", self.index + 1, systemItemModel.strItem];
    
    if (self.isShowTranslated) {
        self.titleLab.text = [NSString stringWithFormat:@"%@", systemItemModel.strTranslatedItem];
        if (systemItemModel.strTranslatedStatus.length > 0) {
            self.statusLab.text = systemItemModel.strTranslatedStatus;
        }
    }else {
        self.titleLab.text = [NSString stringWithFormat:@"%@", systemItemModel.strItem];
        if (systemItemModel.strStatus.length > 0) {
            self.statusLab.text = systemItemModel.strStatus;
        }
    }
    
    self.adasButton.hidden = !systemItemModel.uAdasResult;
    [_statusLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).insets(UIEdgeInsetsMake(_topSpace * _scale, 0, 0, _statusSuperRightSpace * _scale));
        make.left.equalTo(systemItemModel.uAdasResult?_adasButton.mas_right:_rightView).offset(systemItemModel.uAdasResult?8 * _scale:0);
        make.right.equalTo(_rightView);
//        make.width.mas_equalTo(IphoneWidth / 3.0 - 30 * _scale);
        make.height.mas_greaterThanOrEqualTo(40 * _scale).priorityHigh();
        make.bottom.lessThanOrEqualTo(_titleLab.superview).offset(-10 * _scale);
    }];
    if (systemItemModel.uResult > 0 && [NSString tdd_isEmpty:systemItemModel.strStatus]) {
        
        NSString * result = @"";
        BOOL hadDTC = NO;
        if (systemItemModel.uResult == DF_ENUM_UNKNOWN) {
            //未知
            result = TDDLocalized.diagnosis_unknown;
            hadDTC = NO;
        }else if (systemItemModel.uResult == DF_ENUM_NOTEXIST) {
            //不存在
            result = TDDLocalized.diagnosis_no_exist;
            hadDTC = NO;
        }else if (systemItemModel.uResult == DF_ENUM_NODTC) {
            //无码
            self.statusLab.textColor = [UIColor tdd_subTitle];
            result = [NSString tdd_reportTitleNoDTC];
            hadDTC = NO;
        }else if (systemItemModel.uResult >= DF_ENUM_DTCNUM) {
            //有码
            hadDTC = YES;
            self.statusLab.textColor = UIColor.tdd_errorRed;
            
            int nub = systemItemModel.uResult - DF_ENUM_DTCNUM;
            
            if (nub == 0) {
                result = TDDLocalized.fault;
            }else {
                result = [NSString stringWithFormat:@"%@ | %d", TDDLocalized.fault, nub];
            }
        }
        if (isKindOfTopVCI){
            if (hadDTC){
                _arrowImageView.hidden = NO;
            }else{
                _arrowImageView.hidden = YES;
            }
        }
        self.statusLab.text = result;
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.backgroundColor = [UIColor tdd_systemCellBackground:self.bounds.size];
    //[self addLayer];
}

- (void)addLayer
{
    [self.gl removeFromSuperlayer];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bounds;
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self.layer insertSublayer:gl atIndex:0];
    
    self.gl = gl;
}


- (void)adasClick {
    if ([self.delegate respondsToSelector: @selector(ArtiSystemCellViewAdasButtonClick:)]) {
        [self.delegate ArtiSystemCellViewAdasButtonClick:self];
    }
    
}

//底部按钮点击
- (void)bottomButtonClick
{
    if ([self.delegate respondsToSelector: @selector(ArtiSystemCellViewBottomButtonClick:)]) {
        [self.delegate ArtiSystemCellViewBottomButtonClick:self];
    }
}

- (void)bottomButtonClickDown
{
    [self.bottomButton setBackgroundColor:[UIColor tdd_systemScanBgGradient:TDD_GradientStyleLeftToRight withFrame:CGSizeMake(IphoneWidth, 50 * _scale)]];
}

- (void)bottomButtonClickCancel
{
    [self.bottomButton setBackgroundColor:[UIColor clearColor]];
}

- (void)setTitleLabelTextColor:(UIColor *)color {
    self.titleLab.textColor = color;
}

- (void)highlightBackView
{
    self.backView.hidden = NO;
}

- (void)cancelHighlightBackView
{
    self.backView.hidden = YES;
}

@end
