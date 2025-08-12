//
//  TDD_ArtiActiveFloatingView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2022/7/1.
//

#import "TDD_ArtiActiveFloatingView.h"



@interface TDD_ArtiActiveFloatingView()

// 记录手势开始地址
@property (nonatomic, assign) CGPoint beganPoint;
// 记录当前试图开始的FrameOrigin
@property (nonatomic, assign) CGPoint beganOrigin;
@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation TDD_ArtiActiveFloatingView
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TDD_ArtiActiveFloatingViewDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self initSubviews];
        [self activateConstraints];
        [self bindInteraction];
    }
    return self;
}
- (void)initSubviews {
    [self addSubview:self.imageView];

}
- (void)activateConstraints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)bindInteraction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:tap];
    [pan requireGestureRecognizerToFail:tap];
    [self addGestureRecognizer:pan];
}
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(floatingViewDidClickView)]) {
        [self.delegate floatingViewDidClickView];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    if (!panGesture || !panGesture.view) {
        return;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.beganPoint = [panGesture translationInView:panGesture.view];
            self.beganOrigin = self.frame.origin;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [panGesture translationInView:panGesture.view];
            CGFloat offsetX = (point.x - _beganPoint.x);
            CGFloat offsetY = (point.y - _beganPoint.y);
            self.frame = CGRectMake(_beganOrigin.x + offsetX, _beganOrigin.y + offsetY, self.frame.size.width, self.frame.size.height);
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            CGFloat leftDefine = 0;
            CGRect screenrect = self.superview.bounds;
            CGFloat currentCenterX = self.frame.origin.x + self.frame.size.width / 2.0;
            CGFloat finalOriginX = (currentCenterX <= screenrect.size.width / 2.0) ? leftDefine : (screenrect.size.width - self.frame.size.width);
            CGFloat finalOriginY = self.frame.origin.y;
            
            if (self.frame.origin.y <= StatusBarHeight) {
                finalOriginY = StatusBarHeight;
            }
            
            if ((self.frame.origin.y + self.frame.size.height) >= screenrect.size.height) {
                finalOriginY = screenrect.size.height - self.frame.size.height - kSafeBottomHeight;
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                if (self) {
                    self.frame = CGRectMake(finalOriginX , finalOriginY, self.frame.size.width, self.frame.size.height);
                }
            } completion:^(BOOL finished) {
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Getter And Setter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[UIImage tdd_imageDiagBottomTipIcon]];
        _imageView.hidden = NO;
    }
    return _imageView;
}

@end
