//
//  TDD_NaviMoreBtnView.m
//  TopDonDiag
//
//  Created by yong liu on 2023/9/11.
//

#import "TDD_NaviMoreBtnView.h"
#import "TDD_RightbuttonView.h"

@interface TDD_NaviMoreBtnView ()<TDD_BtnLoadingViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UIImageView *popImageView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, assign) CGFloat VCIBtnWidth;

@end

@implementation TDD_NaviMoreBtnView


- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([TDD_DiagnosisManage sharedManage].currentSoftware & TDDSoftwareCarPal) {
            self.VCIBtnWidth = 44;
        } else {
            self.VCIBtnWidth = 36;
        }

        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
    [self addSubview:self.bgView];
    [self addSubview:self.popView];
    [self.popView addSubview:self.popImageView];
//    [self.popView addSubview:self.searchBtn];
//    [self.popView addSubview:self.translateView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            make.centerX.equalTo(self.mas_right).offset(-67- self.VCIBtnWidth);
        }else {
            make.centerX.equalTo(self.mas_right).offset(IS_IPad ? -118.4 : -103);
        }
        make.top.equalTo(self).offset(NavigationHeight - 6);
        make.width.mas_equalTo(116);
        make.height.mas_equalTo(55);
    }];
    
    [self.popImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.popView);
    }];
//
//    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.popView).offset(-11);
//        make.left.equalTo(self.popView).offset(20);
//        make.width.height.mas_equalTo(28);
//    }];
//
//    [self.translateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.popView).offset(-8);
//        make.right.equalTo(self.popView).offset(-15);
//        make.width.height.mas_equalTo(36);
//    }];
    
    
}

- (void)setShowBtnArray:(NSArray *)showBtnArray {
    if (isTopVCIPRO) {
        NSMutableArray *showBtnMarray = showBtnArray.mutableCopy;
        [showBtnMarray removeObject:@(kTranslateBtn)];
        showBtnArray = showBtnMarray;
        
    }
    
    _showBtnArray = showBtnArray;
    for (UIView *view in self.subviews) {
        if (view.tag > 100){
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < showBtnArray.count; i++) {
        NSNumber *type = showBtnArray[i];
        if (type.intValue == kVCIStatusBtn){
            continue;
        }
        if (type.intValue == kTranslateBtn){
            TDD_BtnLoadingView *loadingView = [[TDD_BtnLoadingView alloc] init];
            loadingView.delegate = self;
            loadingView.tag = 100 + type.intValue;
            [self addSubview:loadingView];
            [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.popView).offset(-8);
                make.right.equalTo(self.popView).offset((-28 * i) + (-20 * (i+1)));
                make.width.height.mas_equalTo(36);
                if ((i == showBtnArray.count - 1)){
                    make.left.equalTo(self.popView).offset(20);
                }
            }];
        }else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *image = [TDD_RightbuttonView navBtnImage:type.intValue];
            btn.tag = 100 + type.intValue;
            [btn setImage:image forState:UIControlStateNormal];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.popView).offset(-11);
                make.right.equalTo(self.popView).offset((-28 * i) + (-20 * (i+1)));
                make.height.mas_equalTo(28);
                make.width.mas_equalTo(28);
                if ((i == showBtnArray.count - 1)){
                    make.left.equalTo(self.popView).offset(20);
                }
            }];
        }
    }
}

/// 翻译按钮loading动画
- (void)showTranslateAnimate:(BOOL)show {
    TDD_BtnLoadingView *loadingView = [self viewWithTag:100 + kTranslateBtn];
    if (loadingView && [loadingView isKindOfClass:[TDD_BtnLoadingView class]]){
        [loadingView showTranslateAnimate:show];
    }
}

/// 翻译是否完成
- (void)showTranslateFinish:(BOOL)finish {
    TDD_BtnLoadingView *loadingView = [self viewWithTag:100 + kTranslateBtn];
    if (loadingView && [loadingView isKindOfClass:[TDD_BtnLoadingView class]]){
        [loadingView showTranslateFinish:finish];
    }
}

- (void)show {
    [FLT_APP_WINDOW addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

/// 按钮点击事件
- (void)navBtnClick:(UIControl *)col {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navMoreBtnClick:)]) {
        [self.delegate navMoreBtnClick:col.tag];
    }
    
}
#pragma mark -- TDD_BtnLoadingViewDelegate
/// 翻译按钮点击事件
- (void)loadingBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navMoreBtnClick:)]) {
        [self.delegate navMoreBtnClick:102];
    }
}
#pragma mark -- lazyUI
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.05];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] init];
    }
    return _popView;
}

- (UIImageView *)popImageView {
    if (!_popImageView) {
        _popImageView = [[UIImageView alloc] init];
        _popImageView.image = [[UIImage tdd_imageDiagNavMoreBG] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    }
    return _popImageView;
}


- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage tdd_imageDiagNavSearch] forState:UIControlStateNormal];
//        [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (TDD_BtnLoadingView *)translateView {
    if (!_translateView) {
        _translateView = [[TDD_BtnLoadingView alloc] init];
        _translateView.delegate = self;
    }
    return _translateView;
}

@end
