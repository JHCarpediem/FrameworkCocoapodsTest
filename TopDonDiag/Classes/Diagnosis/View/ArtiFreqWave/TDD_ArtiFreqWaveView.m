//
//  TDD_ArtiFreqWaveView.m
//  AD200
//
//  Created by AppTD on 2023/2/23.
//

#import "TDD_ArtiFreqWaveView.h"
#import "TDD_HChartView.h"
#import "TDD_HChartModel.h"
#import <AVFAudio/AVFAudio.h>
@interface TDD_ArtiFreqWaveView ()
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) TDD_HChartView * chartView;
@property (nonatomic,strong) NSMutableArray * chartDataArr;
@property (nonatomic,strong) UIView * view;
@property (nonatomic, strong) CAGradientLayer * gl;
@property (nonatomic,strong) NSTimer * chartTimer;
@property (nonatomic, strong) AVAudioPlayer *audio;
@property (nonatomic,assign) CGFloat scale;
@property (nonatomic,assign) CGFloat multiple;
@end

@implementation TDD_ArtiFreqWaveView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_line];
        _scale = IS_IPad ? HD_Height : H_Height;
        _multiple = IS_IPad ? 1.5 : 1;
        [self creatUI];
        [self setupCoilReaderSound];
    }
    
    return self;
}

- (void)creatUI
{
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    
    UIView * contentView = [[UIView alloc] init];
    //contentView.backgroundColor = UIColor.whiteColor;
    [scrollView addSubview:contentView];
    
    UIView * view = [[UIView alloc] init];
    [contentView addSubview:view];
    self.view = view;
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.backgroundColor = UIColor.redColor;
    [view addSubview:imageView];
    self.imageView = imageView;
    
//    TDD_HChartView * chartView = [[TDD_HChartView alloc] init];
    TDD_HChartView * chartView = [[TDD_HChartView alloc] initWithShowType:ShowType_FreqWave];
//    chartView.showType = ShowType_FreqWave;
    chartView.userInteractionEnabled = NO;
    [view addSubview:chartView];
    self.chartView = chartView;
    
    UIView * lastView;
    
    for (int i = 0; i < 3; i ++) {
        TDD_CustomLabel * lab = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.tag = 100 + i;
            label.font = [[UIFont systemFontOfSize:IS_IPad ? 24 : 15] tdd_adaptHD];
            label.textColor = [UIColor tdd_color666666];
            label.numberOfLines = 0;
            label.text = @" ";
            label;
        });
        [view addSubview:lab];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor tdd_systemBackgroundColor];
        [view addSubview:lineView];
        
        if (i == 2) {
            lineView.hidden = YES;
        }
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.top.equalTo(chartView.mas_bottom).offset(13 * _multiple * _scale);
            }else{
                make.top.equalTo(lastView.mas_bottom).offset(13 * _multiple * _scale);
            }
            make.left.right.equalTo(view).insets(UIEdgeInsetsMake(15 * _multiple * _scale, 15 * _multiple * _scale, 15 * _multiple * _scale, 15 * _multiple * _scale));
            make.bottom.equalTo(lineView).offset(-13 * _multiple * _scale);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view).insets(UIEdgeInsetsMake(15 * _multiple * _scale, 15 * _multiple * _scale, 15 * _multiple * _scale, 15 * _multiple * _scale));
            make.height.mas_equalTo(1);
        }];
        
        lastView = lineView;
    }
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(IS_IPad ? 100 * _scale : IphoneWidth/2);
        make.top.equalTo(self.view).offset(IS_IPad ? 0 : 50 * _multiple * _scale);
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.imageView.mas_width);
    }];
    
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(15 * _scale);
        make.left.right.equalTo(view).insets(UIEdgeInsetsMake(20 * _multiple * _scale, 0 * _scale, 20 * _multiple * _scale, 0 * _scale));
        if (IS_IPad) {
            make.height.mas_equalTo(300 * _scale);
        }else {
            make.height.equalTo(chartView.mas_width).multipliedBy(0.5);
        }
        
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(contentView).insets(UIEdgeInsetsMake(20 * _multiple * _scale, 20 * _multiple * _scale, 20 * _multiple * _scale, 20 * _multiple * _scale));
        make.bottom.equalTo(lastView);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
        make.bottom.equalTo(view).offset(20 * _multiple * _scale);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setupCoilReaderSound {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *voice = [bundle URLForResource:[NSString stringWithFormat:@"TopdonDiagnosis.bundle/%@",kSoundCoilReaderSet] withExtension:nil];
    self.audio = [[AVAudioPlayer alloc] initWithContentsOfURL:voice error:nil];
    self.audio.volume = 1;
    self.audio.numberOfLoops = 0;
    [self.audio prepareToPlay];
    
}

- (void)setFreqWaveModel:(TDD_ArtiFreqWaveModel *)freqWaveModel
{
    if (freqWaveModel.Type) {
        [self closeChartTimer];
        [self addChartsDataWitheCrestType:freqWaveModel.Type];
        [self openChartTimer];
        freqWaveModel.Type = 0;
    }else {
        if (!self.chartTimer) {
            [self addChartsData];
        }
        [self openChartTimer];
    }
    //播放音效
    if (![self.audio isPlaying]){
        [self.audio play];
    }

    NSArray * arr = @[freqWaveModel.strModeValue,freqWaveModel.strFreqValue,freqWaveModel.strIntensity];
    for (int i = 0; i < 3; i ++) {
        TDD_CustomLabel * lab = [self viewWithTag:100 + i];
        NSString * string = arr[i];
        if (string.length > 0) {
            lab.text = string;
        }
    }
    
    self.imageView.image = [UIImage imageWithContentsOfFile:freqWaveModel.strPicturePath];
    if (!self.imageView.image) {
        [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(IS_IPad ? 100 * _scale : IphoneWidth/2);
            make.top.equalTo(self.view).offset(IS_IPad ? 0 : 50 * _multiple * _scale);
            make.centerX.equalTo(self.view);
            make.height.mas_equalTo(0);
        }];
        [_chartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(0);
        }];
    }else {
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(IS_IPad ? 100 * _scale : IphoneWidth/2);
            make.top.equalTo(self.view).offset(IS_IPad ? 0 : 50 * _multiple * _scale);
            make.centerX.equalTo(self.view);
            make.height.equalTo(self.imageView.mas_width);
        }];
        [_chartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(15 * _scale);
        }];
    }
    [self layoutIfNeeded];

    [self layoutSubviews];
    
    [freqWaveModel conditionSignalWithTime:0.1];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
//    if (!IS_IPad) {
        [self addLayer];
//    }
    
}

- (void)addLayer
{
    [self.gl removeFromSuperlayer];
    
    // gradient
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = self.view.bounds;
//    gl.startPoint = CGPointMake(0.5, 0);
//    gl.endPoint = CGPointMake(0.5, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0), @(1.0f)];
//    gl.cornerRadius = 10 * _scale;
//    [self.view.layer insertSublayer:gl atIndex:0];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.view.bounds;
    gl.startPoint = CGPointMake(0.5, 0.36);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 20 * _scale;
    gl.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0500].CGColor;
    gl.shadowOffset = CGSizeMake(0,2);
    gl.shadowOpacity = 1;
    gl.shadowRadius = 8;
    [self.view.layer insertSublayer:gl atIndex:0];
    
    self.gl = gl;
}

- (void)addChartsData
{
    long lastTime = 0;
    
    if (self.chartDataArr.count > 0) {
        TDD_HChartModel * mod = self.chartDataArr.lastObject;
        lastTime = mod.time;
    }
    
    TDD_HChartModel * mod = [[TDD_HChartModel alloc] init];
    mod.time = lastTime + 1;
    mod.value = 2;
    [self.chartDataArr addObject:mod];
    
    [self.chartView setValueArr:@[self.chartDataArr]];
}

- (void)addChartsDataWitheCrestType:(eCrestType)type
{
    long lastTime = 0;
    
    if (self.chartDataArr.count > 0) {
        TDD_HChartModel * mod = self.chartDataArr.lastObject;
        lastTime = mod.time;
    }
    
    if (type == TRIGGER_ONE_CREST) {
        TDD_HChartModel * mod = [[TDD_HChartModel alloc] init];
        mod.time = lastTime + 0.5;
        mod.value = 8;
        [self.chartDataArr addObject:mod];
        
        TDD_HChartModel * mod2 = [[TDD_HChartModel alloc] init];
        mod2.time = lastTime + 1;
        mod2.value = 2;
        [self.chartDataArr addObject:mod2];
    }else {
        TDD_HChartModel * mod = [[TDD_HChartModel alloc] init];
        mod.time = lastTime + 0.5;
        mod.value = 8;
        [self.chartDataArr addObject:mod];
        
        TDD_HChartModel * mod1 = [[TDD_HChartModel alloc] init];
        mod1.time = lastTime + 1;
        mod1.value = 5;
        [self.chartDataArr addObject:mod1];
        
        TDD_HChartModel * mod2 = [[TDD_HChartModel alloc] init];
        mod2.time = lastTime + 1.5;
        mod2.value = 8;
        [self.chartDataArr addObject:mod2];
        
        TDD_HChartModel * mod3 = [[TDD_HChartModel alloc] init];
        mod3.time = lastTime + 2;
        mod3.value = 2;
        [self.chartDataArr addObject:mod3];
    }
    
    [self.chartView setValueArr:@[self.chartDataArr]];
}

- (void)openChartTimer
{
    if (!self.chartTimer) {
        self.chartTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addChartsData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.chartTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)closeChartTimer
{
    if (self.chartTimer) {
        [self.chartTimer invalidate];
        self.chartTimer = nil;
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self closeChartTimer];
}

- (NSMutableArray *)chartDataArr
{
    if (!_chartDataArr) {
        _chartDataArr = [[NSMutableArray alloc] init];
    }
    
    return _chartDataArr;
}

@end
