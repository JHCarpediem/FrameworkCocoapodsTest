//
//  TDD_HLoadingView.m
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import "TDD_HLoadingView.h"

@interface TDD_HLoadingView ()
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIImageView * loadingImageView;
@property (nonatomic, assign) float loadNub;
@property (nonatomic, strong) NSTimer * loadingTimer;
@property (nonatomic, strong) TDD_CustomLabel * titleLab;
@end

@implementation TDD_HLoadingView

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
        self.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200 * H_Height, 162 * H_Height)];
    whiteView.center = CGPointMake(IphoneWidth / 2, IphoneHeight / 2);
    whiteView.backgroundColor = UIColor.tdd_alertBg;
    whiteView.layer.cornerRadius = 8;
    [self addSubview:whiteView];
    
    UIImageView * loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(86 * H_Height, 47 * H_Height, 29 * H_Height, 29 * H_Height)];
    loadingImageView.image = kImageNamed(@"tipView_loading2");
    [whiteView addSubview:loadingImageView];
    self.loadingImageView = loadingImageView;
    
    TDD_CustomLabel * titleLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.frame = CGRectMake(0, 91 * H_Height, 200 * H_Height, 0 * H_Height);
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.text = [TDD_HLanguage getLanguage:self.title];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.center = CGPointMake(200 * H_Height / 2, label.center.y);
        label;
    });
    self.titleLab = titleLab;
    [whiteView addSubview:titleLab];
    
    [self startTimer];
}

- (void)updateTitle:(NSString *)title{
    self.titleLab.text = [TDD_HLanguage getLanguage:title];
    self.titleLab.frame = CGRectMake(0, 91 * H_Height, 200 * H_Height, 0 * H_Height);
    [self.titleLab sizeToFit];
    self.titleLab.center = CGPointMake(200 * H_Height / 2, self.titleLab.center.y);
}

- (void)loadingImageRotating{
    self.loadNub += 0.1;
    
    self.loadingImageView.transform = CGAffineTransformMakeRotation(self.loadNub);
}

- (void)startTimer{
    if (!self.loadingTimer) {
        self.loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loadingImageRotating) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer{
    if (self.loadingTimer) {
        [self.loadingTimer invalidate];
        self.loadingTimer = nil;
    }
}

- (void)deallocView{
    
    [self stopTimer];
    
    [super deallocView];
}

@end
