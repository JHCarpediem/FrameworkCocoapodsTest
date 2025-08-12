//
//  TDD_ArtiCoilReaderView.m
//  AD200
//
//  Created by AppTD on 2023/3/4.
//

#import "TDD_ArtiCoilReaderView.h"
#import <AVFAudio/AVFAudio.h>
@interface TDD_ArtiCoilReaderView()
@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIImageView *pkeImgView;
@property (nonatomic, strong)TDD_CustomLabel *pkeLabel;
@property (nonatomic, strong)TDD_CustomLabel *immoLabel;
@property (nonatomic, strong)UIView *pkePoint;
@property (nonatomic, strong)UIView *immoPoint;
@property (nonatomic, strong)UIImageView *immoTopImgView;
@property (nonatomic, strong)UIImageView *immoLeftImgView;
@property (nonatomic, strong)UIImageView *immoRightImgView;
@property (nonatomic, strong)UIImageView *animationImgView;
@property (nonatomic, strong) AVAudioPlayer *audio;
@end
@implementation TDD_ArtiCoilReaderView

- (instancetype)init {
    if(self = [super init]){

        [self setupUI];
        
        [self setupCoilReaderSound];
    }
    return self;
}


- (void)setupUI {
    if (IS_IPad) {
        [self addSubview:self.contentView];
    }else {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, self.tdd_height)];
        _bgScrollView.bounces = NO;
        [self addSubview:_bgScrollView];
        _backView = [UIView new];
        
        [_bgScrollView addSubview:_backView];
        [_backView addSubview:self.contentView];
    }

    [self.contentView addSubview:self.pkeImgView];
    [self.contentView addSubview:self.pkeLabel];
    [self.contentView addSubview:self.immoLabel];
    [self.contentView addSubview:self.pkePoint];
    [self.contentView addSubview:self.immoPoint];
    [self.contentView addSubview:self.immoTopImgView];
    [self.contentView addSubview:self.immoLeftImgView];
    [self.contentView addSubview:self.immoRightImgView];
    [self.contentView addSubview:self.animationImgView];
    if (IS_IPad){
        [self setupIPadLayout];
    }else {
        [self setupLayout];
    }
    

    
}

- (void)setupLayout {

    
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.tdd_colorEDEDED;
    [self.contentView addSubview:line];
    
    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(_bgScrollView);
        make.width.mas_lessThanOrEqualTo(IphoneWidth);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_backView).offset(20*H_Height);
        make.right.equalTo(_backView).offset(-20*H_Height);
        make.bottom.equalTo(_backView).offset(-(IS_iPhoneX?24:20)*H_Height);
    }];
    
    [_pkeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_contentView).offset((IS_iPhoneX?20:18)*H_Height);
        make.size.mas_equalTo(IS_iPhoneX?CGSizeMake(190*H_Height, 130*H_Height):CGSizeMake(130*H_Height, 90*H_Height));
    }];
    
    [_pkeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pkeImgView);
        make.right.equalTo(_contentView.mas_right).offset(- (IS_iPhoneX?42*H_Height:34*H_Height));
    }];
    
    [_pkePoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pkeImgView);
        make.right.equalTo(_pkeLabel.mas_left).offset(-8*H_Height);
        make.size.mas_equalTo(CGSizeMake(6*H_Height, 6*H_Height));
    }];
    
    [_immoPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pkeImgView.mas_bottom).offset((IS_iPhoneX?20:8)*H_Height);
        make.left.equalTo(_contentView).offset((IS_iPhoneX?26:34)*H_Height);
        make.size.mas_equalTo(CGSizeMake(6*H_Height, 6*H_Height));
    }];
    
    [_immoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_immoPoint);
        make.left.equalTo(_immoPoint.mas_right).offset(8*H_Height);
    }];
    
    [_immoTopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).offset((IS_iPhoneX?26:34)*H_Height);
        make.top.equalTo(_immoLabel.mas_bottom).offset((IS_iPhoneX?10:8)*H_Height);
        make.centerX.equalTo(_contentView);
    }];
    
    [_immoLeftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).offset((IS_iPhoneX?26:34)*H_Height);
        make.top.equalTo(_immoTopImgView.mas_bottom).offset((IS_iPhoneX?10:8)*H_Height);
        make.size.mas_equalTo(CGSizeMake((IS_iPhoneX?140:130)*H_Height, (IS_iPhoneX?130:130)*H_Height));
    }];
    
    [_immoRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentView).offset(-(IS_iPhoneX?26:34)*H_Height);
        make.top.equalTo(_immoLeftImgView);
        make.size.mas_equalTo(CGSizeMake((IS_iPhoneX?140:130)*H_Height, (IS_iPhoneX?130:130)*H_Height));
        make.left.equalTo(_immoLeftImgView.mas_right).offset(6*H_Height);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).offset(15*H_Height);
        make.centerX.equalTo(_contentView);
        make.top.equalTo(_immoRightImgView.mas_bottom).offset((IS_iPhoneX?10:2)*H_Height);
        make.height.mas_equalTo(1);
    }];
    
    [_animationImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contentView).offset(-(IS_iPhoneX?20:8)*H_Height);
        make.centerX.equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake((IS_iPhoneX?180:164)*H_Height, (IS_iPhoneX?130:118)*H_Height));
        make.top.equalTo(line.mas_bottom).offset((IS_iPhoneX?10:8)*H_Height);
    }];
}

- (void)setupIPadLayout {
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_pkePoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16 * HD_HHeight);
        make.left.equalTo(self.contentView).offset(40 * HD_HHeight);
        make.size.mas_equalTo(CGSizeMake(13 * HD_HHeight, 13 * HD_HHeight));
    }];
    
    [_pkeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pkePoint);
        make.left.equalTo(_pkePoint.mas_right).offset(12 * HD_HHeight);
    }];
    
    [_pkeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pkeLabel.mas_bottom).offset(12 * HD_HHeight);
        make.left.equalTo(_pkePoint);
        make.size.mas_equalTo(CGSizeMake(495 * HD_HHeight, 345 * HD_HHeight));
    }];
    
    [_immoPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pkePoint);
        make.left.equalTo(_pkeImgView.mas_right);
        make.size.mas_equalTo(CGSizeMake(13 * HD_HHeight, 13 * HD_HHeight));
    }];
    
    [_immoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_immoPoint);
        make.left.equalTo(_immoPoint.mas_right).offset(8 * HD_HHeight);
    }];
    
    [_immoTopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_immoLabel);
        make.top.equalTo(_pkeImgView);
        make.size.mas_equalTo(CGSizeMake(428 * HD_HHeight, 141 * HD_HHeight));
    }];
    
    [_immoLeftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_immoTopImgView);
        make.top.equalTo(_immoTopImgView.mas_bottom).offset(15 * HD_HHeight);
        make.size.mas_equalTo(CGSizeMake(231 * HD_HHeight,188 * HD_HHeight));
    }];
    
    [_immoRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_immoTopImgView);
        make.top.equalTo(_immoLeftImgView);
        make.size.mas_equalTo(CGSizeMake(184 * HD_HHeight,188 * HD_HHeight));
        make.left.equalTo(_immoLeftImgView.mas_right).offset(12 * HD_HHeight);
    }];
    
    [_animationImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.bottom.equalTo(_contentView).offset(-28 * H_Height);
        make.centerX.equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake(195 * HD_HHeight, 141 * HD_HHeight));
        make.top.equalTo(_pkeImgView.mas_bottom).offset(36*HD_HHeight);
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

- (void)setCoilReaderModel:(TDD_ArtiCoilReaderModel *)coilReaderModel {
    _coilReaderModel = coilReaderModel;
    
    if(_coilReaderModel.eType == 1){
        //播放音效
        if (![self.audio isPlaying]){
            [self.audio play];
        }
        
        //设置动画帧
        if (!_animationImgView.isAnimating) {
            _animationImgView.animationImages = [NSArray arrayWithObjects:
            kImageNamed(@"arti_coliAnimation_2"),
                                             kImageNamed(@"arti_coliAnimation_3"),
                                             kImageNamed(@"arti_coliAnimation_4"),nil ];
            _animationImgView.animationDuration = 0.5;
            _animationImgView.animationRepeatCount = 0;
            [_animationImgView startAnimating];
            
        }
    }else{
        [_animationImgView stopAnimating];
    }
    
    [self layoutIfNeeded];
    [coilReaderModel conditionSignalWithTime:0.1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.backgroundColor = [UIColor tdd_colorDiagNormalGradient:TDD_GradientStyleTopToBottom withFrame:_contentView.tdd_size];
}

- (void)dealloc {
    [_animationImgView stopAnimating];
}

#pragma mark - Lazy
- (UIView *)contentView {
    if(!_contentView){
        _contentView = [UIView new];
        _contentView.layer.cornerRadius = 20;
        _contentView.layer.shadowColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.05].CGColor;
        _contentView.layer.shadowRadius = 8;
        _contentView.layer.shadowOpacity = 0.8;
        _contentView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _contentView;
}
- (UIImageView *)pkeImgView {
    if(!_pkeImgView){
        _pkeImgView = [[UIImageView alloc] initWithImage:IS_IPad ? kImageNamed(@"hd_arti_coliPKE") : kImageNamed(@"arti_coliPKE")];
    }
    return _pkeImgView;
}
- (TDD_CustomLabel *)pkeLabel {
    if(!_pkeLabel){
        _pkeLabel = [[TDD_CustomLabel alloc] initWithFrame:CGRectZero];
        _pkeLabel.text = @"PKE";
        _pkeLabel.textColor = UIColor.tdd_title;
        _pkeLabel.font = kBoldSystemFont(IS_IPad ? 22 : 12);
    }
    return _pkeLabel;
}
- (TDD_CustomLabel *)immoLabel {
    if(!_immoLabel){
        _immoLabel = [[TDD_CustomLabel alloc] initWithFrame:CGRectZero];
        _immoLabel.text = @"IMMO";
        _immoLabel.textColor = UIColor.tdd_title;
        _immoLabel.font = kBoldSystemFont(IS_IPad ? 22 : 12);
    }
    return _immoLabel;
}
- (UIView *)pkePoint {
    if(!_pkePoint){
        _pkePoint = UIView.new;
        _pkePoint.backgroundColor = UIColor.tdd_colorDiagTheme;
        _pkePoint.layer.cornerRadius = IS_IPad ? 6.5 * HD_HHeight : 3 * H_Height;
    }
    return _pkePoint;;
}
- (UIView *)immoPoint {
    if(!_immoPoint){
        _immoPoint = UIView.new;
        _immoPoint.backgroundColor = UIColor.tdd_colorDiagTheme;
        _immoPoint.layer.cornerRadius = IS_IPad ? 6.5 * HD_HHeight : 3 * H_Height;;
    }
    return _immoPoint;;
}
- (UIImageView *)immoTopImgView {
    if(!_immoTopImgView){
        _immoTopImgView = [[UIImageView alloc] initWithImage:kImageNamed(IS_IPad ? @"hd_arti_coliIMMO_top" : @"arti_coliIMMO_top")];
        if (!IS_IPad) {
            //切图没带阴影
            _immoTopImgView.backgroundColor = UIColor.whiteColor;
            _immoTopImgView.layer.cornerRadius = 10;
            _immoTopImgView.layer.shadowColor = [UIColor tdd_colorWithHex:0xc4c4c4].CGColor;
            _immoTopImgView.layer.shadowRadius = 10;
            _immoTopImgView.layer.shadowOpacity = 0.8;
            _immoTopImgView.layer.shadowOffset = CGSizeMake(2, 2);
        }

    }
    return _immoTopImgView;
}
- (UIImageView *)immoLeftImgView {
    if(!_immoLeftImgView){
        _immoLeftImgView = [[UIImageView alloc] initWithImage:kImageNamed(IS_IPad ? @"hd_arti_coliIMMO_left" :@"arti_coliIMMO_left")];
    }
    return _immoLeftImgView;
}
- (UIImageView *)immoRightImgView {
    if(!_immoRightImgView){
        _immoRightImgView = [[UIImageView alloc] initWithImage:kImageNamed(IS_IPad ? @"hd_arti_coliIMMO_right" : @"arti_coliIMMO_right")];
    }
    return _immoRightImgView;
}
- (UIImageView *)animationImgView {
    if(!_animationImgView){
        _animationImgView = [[UIImageView alloc] initWithImage:kImageNamed(@"arti_coliAnimation_1")];
    }
    return _animationImgView;
}
@end
