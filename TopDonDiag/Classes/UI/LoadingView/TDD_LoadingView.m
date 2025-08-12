//
//  TDD_LoadingView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/7/18.
//

#import "TDD_LoadingView.h"

//球宽
static CGFloat BallWidth = 11.0f;

//球速
static CGFloat BallSpeed = 0.7f;

//球缩放比例
static CGFloat BallZoomScale = 0.25;

//暂停时间 s
static CGFloat PauseSecond = 0.12;

static UIColor *FirstBallColor;

static UIColor *SecondBallColor;

static BOOL isCustom;

//球的运动方向，以绿球向右、红球向左运动为正向，
typedef NS_ENUM(NSInteger, BallMoveDirection) {
    //正向
    BallMoveDirectionPositive = 1,
    //逆向
    BallMoveDirectionNegative = -1,
};
@interface TDD_LoadingView ()
//总容器
@property (nonatomic, strong) UIView * conatinerView;
//总容器
@property (nonatomic, strong) UIView * ballContainerBGView;
//球的容器
@property (nonatomic, strong) UIView *ballContainer;
//绿球
@property (nonatomic, strong) UIView *greenBall;
//红球
@property (nonatomic, strong) UIView *redBall;
//移动方向
@property (nonatomic, assign) BallMoveDirection ballMoveDirection;
//刷新器
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation TDD_LoadingView

#pragma mark -
#pragma mark 显示/隐藏方法

+ (TDD_LoadingView *)shared
{
    static  dispatch_once_t oncetocken;
    static  TDD_LoadingView * view = nil;
    dispatch_once(&oncetocken, ^{
        view = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
        view.conatinerView.backgroundColor = UIColor.clearColor;
        view.ballContainerBGView.hidden = false;
    });
    return view;
}

+ (void)setBallWidth:(CGFloat)ballWidth {
    BallSpeed = BallSpeed * (ballWidth / BallWidth);
    BallWidth = ballWidth;
    isCustom = YES;
}

+ (void)setFirstBallColor:(UIColor *)ballColor {
    FirstBallColor = ballColor;
    
}

+ (void)setSecondBallColor:(UIColor *)ballColor {
    SecondBallColor = ballColor;
}

+ (void)resetStatic {
    BallWidth = 11.0f;
    BallSpeed = 0.7f;
    FirstBallColor = nil;
    SecondBallColor = nil;
    isCustom = NO;
}

+ (void)show
{
    [FLT_APP_WINDOW addSubview:self.shared];
    [self.shared startAnimated];
}

+ (void)showWith:(NSInteger )tag {
    TDD_LoadingView *view = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
    view.tag = tag;
    [FLT_APP_WINDOW addSubview:view];
    [view startAnimated];
}

+ (void)dissmissWith:(NSInteger )tag {
    TDD_LoadingView *view = [FLT_APP_WINDOW viewWithTag:tag];
    if (view && [view isKindOfClass:[TDD_LoadingView class]]) {
        [view stopAnimated];
        [view removeFromSuperview];
    }else {
        NSLog(@"此 loading 找不到");
    }

}

+ (void)dissmiss
{
    [self.shared stopAnimated];
    [self.shared removeFromSuperview];
}

+ (void)dissmissWithDelay:(CGFloat )delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.shared stopAnimated];
        [self.shared removeFromSuperview];
    });
}

#pragma mark 初始化方法

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

#pragma mark 动画相关

- (void)buildUI {
    CGFloat scale = IS_IPad ? HD_Height : H_Height;
    UIView * conatinerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, isCustom? self.tdd_width : 70 * scale, isCustom ? self.tdd_height : 70 * scale)];
    conatinerView.center = self.center;
    conatinerView.backgroundColor = [UIColor loadingViewBg];
    conatinerView.layer.cornerRadius = 15;
    self.conatinerView = conatinerView;
    [self addSubview:conatinerView];
    
    CGFloat width = conatinerView.frame.size.width;
    CGFloat height = conatinerView.frame.size.height;
    UIView * ballContainerBGView = [[UIView alloc] initWithFrame:CGRectMake((width - 80)/2.0, (height - 80)/2.0, 80, 80)];
//    ballContainerBGView.center = self.center;
    ballContainerBGView.backgroundColor = [UIColor cardBg];
    ballContainerBGView.hidden = true;
    ballContainerBGView.layer.cornerRadius = 15;
    self.ballContainerBGView = ballContainerBGView;
    [self.conatinerView addSubview:ballContainerBGView];
    
    self.ballContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth * 3, BallWidth * 3)];
    self.ballContainer.center = CGPointMake(conatinerView.tdd_width * 0.5, conatinerView.tdd_height * 0.5);
    [conatinerView addSubview:self.ballContainer];
    
    self.greenBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth, BallWidth)];
    self.greenBall.center = CGPointMake(BallWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.greenBall.layer.cornerRadius = BallWidth/2.0f;
    self.greenBall.layer.masksToBounds = true;
    self.greenBall.backgroundColor = FirstBallColor?:[UIColor tdd_loadingViewFirstBallColor];
    [self.ballContainer addSubview:self.greenBall];
    
    self.redBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth, BallWidth)];
    self.redBall.center = CGPointMake(self.ballContainer.bounds.size.width - BallWidth/2.0f, self.ballContainer.bounds.size.height/2.0f);
    self.redBall.layer.cornerRadius = BallWidth/2.0f;
    self.redBall.layer.masksToBounds = true;
    self.redBall.backgroundColor = SecondBallColor?:[UIColor tdd_loadingViewSecondBallColor];
    [self.ballContainer addSubview:self.redBall];
    
    //初始化方向是正向
    self.ballMoveDirection = BallMoveDirectionPositive;
    //初始化刷新方法
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBallAnimations)];
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)startAnimated
{
    self.displayLink.paused = NO;
}

- (void)stopAnimated
{
    self.displayLink.paused = YES;
}

- (void)setBGColor:(UIColor *)bgColor {
    _conatinerView.backgroundColor = bgColor;
}

- (void)pauseAnimated
{
    [self stopAnimated];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PauseSecond * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self startAnimated];
    });
}

- (void)updateBallAnimations
{
    if (self.ballMoveDirection == BallMoveDirectionPositive) {//正向运动
        //更新绿球位置
        CGPoint center = self.greenBall.center;
        center.x += BallSpeed;
        self.greenBall.center = center;
        
        //更新红球位置
        center = self.redBall.center;
        center.x -= BallSpeed;
        self.redBall.center = center;
        
        //更新方向+改变三个球的相对位置
        if (CGRectGetMaxX(self.greenBall.frame) >= self.ballContainer.bounds.size.width || CGRectGetMinX(self.redBall.frame) <= 0) {
            //切换为反向
            self.ballMoveDirection = BallMoveDirectionNegative;
        }
    } else if (self.ballMoveDirection == BallMoveDirectionNegative) {//反向运动
        //更新绿球位置
        CGPoint center = self.greenBall.center;
        center.x -= BallSpeed;
        self.greenBall.center = center;
        
        //更新红球位置
        center = self.redBall.center;
        center.x += BallSpeed;
        self.redBall.center = center;
        
        //更新方向+改变三个球的相对位置
        if (CGRectGetMinX(self.greenBall.frame) <= 0 || CGRectGetMaxX(self.redBall.frame) >= self.ballContainer.bounds.size.width) {
            //切换为正向
            self.ballMoveDirection = BallMoveDirectionPositive;
            //暂停动画
//            [self pauseAnimated];
        }
    }
}
@end
