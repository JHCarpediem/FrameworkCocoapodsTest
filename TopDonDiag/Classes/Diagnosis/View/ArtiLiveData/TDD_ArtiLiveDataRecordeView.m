//
//  TDD_ArtiLiveDataRecordeView.m
//  AD200
//
//  Created by AppTD on 2022/8/27.
//

#import "TDD_ArtiLiveDataRecordeView.h"

@interface TDD_ArtiLiveDataRecordeView ()
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,assign) int time;
@property (nonatomic,strong) UIButton * stopButton;
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic,assign) BOOL stopIng;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,assign) long enterBackgroundTime;
@property (nonatomic,assign) CGFloat scale;
@end

@implementation TDD_ArtiLiveDataRecordeView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        _scale = IS_IPad ? HD_Height : H_Height;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        
        self.userInteractionEnabled = NO;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        self.timeStr = [NSString stringWithFormat:@"%@",[NSDate tdd_getTimeStringWithInterval:[NSDate tdd_getTimestampSince1970] Format:@"yyyy-MM-dd HH-mm-ss"]];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enterBackGround:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enterForeGround:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    HLog(@"生成录制数据流UI");
    CGSize stopBtnSize = IS_IPad ? CGSizeMake(280 * _scale, 70 * _scale) : CGSizeMake(105 * _scale, 34 * _scale);
    CGFloat bottomSpace = (IS_IPad ? 90 : 112) * _scale;
    CGFloat rightSpace = (IS_IPad ? 40 : 20) * _scale;
    CGFloat redViewRightSpace = (IS_IPad ? 64 : 16) * _scale;
    CGFloat redViewH = (IS_IPad ? 24 : 12) * _scale;
    CGFloat titleLeftSpace = (IS_IPad ? 64 : 16) * _scale;
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, NavigationHeight)];
    [FLT_APP_WINDOW addSubview:topView];
    self.topView = topView;
    
    UIButton * backBtn = [[UIButton alloc] init];
    [topView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-20, -15, -20, -20);
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView).offset(StatusBarHeight / 2);
        make.left.equalTo(topView).offset(15 * _scale);
        make.width.mas_equalTo(30 * _scale);
        make.height.mas_equalTo(30 * _scale);
    }];
    
    //底部View
    UIView * bottomView = [[UIView alloc] init];
    [FLT_APP_WINDOW addSubview:bottomView];
    self.bottomView = bottomView;
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(FLT_APP_WINDOW);
        make.height.mas_equalTo(58 * _scale + iPhoneX_D);
    }];
    
    UIButton * stopButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor tdd_liveDataRecordBackground];
        btn.layer.cornerRadius = (IS_IPad ? 70 : 34) * _scale / 2;
        [btn addTarget:self action:@selector(stopButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"00:00:00" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 24 : 12] tdd_adaptHD];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, titleLeftSpace, 0, 0)];
        btn;
    });
    [FLT_APP_WINDOW addSubview:stopButton];
    self.stopButton = stopButton;
    
    UIView * redView = [[UIView alloc] init];
    redView.userInteractionEnabled = NO;
    redView.backgroundColor = [UIColor redColor];
    redView.layer.cornerRadius = (IS_IPad ? 3 : 1.5) * _scale;
    [stopButton addSubview:redView];
 
    [stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(FLT_APP_WINDOW).offset(- iPhoneX_D - bottomSpace);
        make.right.equalTo(FLT_APP_WINDOW).offset(-rightSpace);
        make.size.mas_equalTo(stopBtnSize);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(stopButton.mas_right).offset(-redViewRightSpace);
        make.centerY.equalTo(stopButton);
        make.size.mas_equalTo(CGSizeMake(redViewH, redViewH));
    }];
    
    //最多录制一个小时
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelector:@selector(timeToStopButtonClick) withObject:nil afterDelay:3600];
    });
}

- (void)backButtonClick
{
    @kWeakObj(self);
    [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.live_recording_quit_tip buttonType:HTipBtnTwoType block:^(NSInteger btnTag) {
        if (btnTag == 1) {
            @kStrongObj(self);
            [self showSaveVideoAlert:YES];
        }
    }];
}

- (void)timeToStopButtonClick {
    [self stopButtonClick];
}

- (void)stopButtonClick {
    if (_stopIng) {
        return;
    }
    _stopIng = YES;
    [self showSaveVideoAlert:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeToStopButtonClick) object:nil];
    });
    _stopIng = NO;
}

- (void)dismiss
{
    self.topView.hidden = YES;
    self.bottomView.hidden = YES;
    self.stopButton.hidden = YES;
}

- (void)unInit {
    [self.topView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    [self.stopButton removeFromSuperview];
    [self removeFromSuperview];
    
}

// 自动暂停录制
- (void)autoStopVideo {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
    [self dismiss];
    if (self.stopBlock) {
        self.stopBlock();
    }
    
    if (self.completeBlock) {
        self.completeBlock(self.timeStr, YES, NO);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeToStopButtonClick) object:nil];
    });
}

- (void)showSaveVideoAlert:(BOOL )isBack
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
    [self dismiss];
    if (self.stopBlock) {
        self.stopBlock();
    }
    kWeakSelf(self);
    [TDD_HTipManage showInputTipViewtitle:@"liveData_save" tag:0 delayDismiss:YES defaultValue:self.timeStr completeBlock:^(NSString * _Nullable text, BOOL isOK) {
        kStrongSelf(self);
        
        if (!strongself) {
            return;
        }
        
        HLog(@"清除保存数据流页面UI");
        
//        [strongself.topView removeFromSuperview];
//        [strongself.bottomView removeFromSuperview];
//        [strongself.stopButton removeFromSuperview];
//        [strongself removeFromSuperview];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (strongself.completeBlock) {
                strongself.completeBlock(text, isOK, isBack);
            }
        });

    }];
}

- (void)timerMethod
{
    self.time ++;	
    
    NSString * timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", self.time / 60 / 60, self.time / 60, self.time % 60];
    
    self.stopButton.titleLabel.text = timeStr;
    
    [self.stopButton setTitle:timeStr forState:UIControlStateNormal];
}

- (void)enterForeGround:(NSNotification *)notif
{
    long nowTime = [NSDate tdd_getTimestampSince1970];
    if (nowTime - _enterBackgroundTime + _time >= 3600) {
        [self timeToStopButtonClick];
    }
    _enterBackgroundTime = 0;
}

- (void)enterBackGround:(NSNotification *)notif
{
    _enterBackgroundTime = [NSDate tdd_getTimestampSince1970];
}

- (void)removeFromSuperview {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [super removeFromSuperview];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    HLog(@"录制数据流 -- dealloc -- %s", __func__);
}

@end
