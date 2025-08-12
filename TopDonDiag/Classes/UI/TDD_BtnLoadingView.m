//
//  TDD_BtnLoadingView.m
//  TopDonDiag
//
//  Created by yong liu on 2023/9/11.
//

#import "TDD_BtnLoadingView.h"
#import "SVProgressView.h"

@interface TDD_BtnLoadingView ()

@property (nonatomic, strong) UIButton *translateBtn;   // 翻译按钮

@property (nonatomic, strong) SVProgressView *progressView;

@property (nonatomic, assign) CGFloat progress;

@end

@implementation TDD_BtnLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.translateBtn];
    [self addSubview:self.progressView];
    CGFloat scale = IS_IPad ? HD_Height : H_Height;
    CGFloat w = IS_IPad ? 25 : 30;
    [self.translateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}



- (void)showRoundLoading {

    self.progressView.hidden = NO;
    self.progressView.progress = 0.5;
    
}

- (void)showTranslateAnimate:(BOOL)show {
    if (show) {
        [self showRoundLoading];
    } else {
        self.progressView.hidden = YES;
    }
    
    [self.translateBtn setBackgroundImage:[UIImage tdd_imageDiagNavTranslate] forState:UIControlStateNormal];
    
}

- (void)showTranslateFinish:(BOOL )finish {

    self.progressView.hidden = YES;

    [self.translateBtn setBackgroundImage:finish?[UIImage tdd_imageDiagNavTranslateFinish]:[UIImage tdd_imageDiagNavTranslate] forState:UIControlStateNormal];
    
}

- (void)translateBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadingBtnClick)]) {
        [self.delegate loadingBtnClick];
    }
}

#pragma mark -- lazy UI
- (UIButton *)translateBtn {
    if (!_translateBtn) {
        _translateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_translateBtn setBackgroundImage:[UIImage tdd_imageDiagNavTranslate] forState:UIControlStateNormal];
        [_translateBtn addTarget:self action:@selector(translateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _translateBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _translateBtn;
}

- (SVProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[SVProgressView alloc] init];
        _progressView.progress = 0;
        _progressView.hidden = YES;
    }
    return _progressView;
}

@end
