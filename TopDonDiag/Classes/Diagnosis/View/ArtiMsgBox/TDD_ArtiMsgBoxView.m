//
//  TDD_ArtiMsgBoxView.m
//  AD200
//
//  Created by 何可人 on 2022/5/20.
//

#import "TDD_ArtiMsgBoxView.h"
#import "TDD_ArtiMsgBoxProgressView.h"
#import "TDD_LoadingView.h"
@interface TDD_ArtiMsgBoxView ()
@property (nonatomic, strong) TDD_CustomLabel * contentLabel;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIStackView * stackView;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) TDD_ArtiMsgBoxProgressView * progressView;
@property (nonatomic, strong) NSTimer * animationTimer;
@property (nonatomic, assign) float rotateNub;
@property (nonatomic, assign) BOOL isCustomLoadingView;
@property (nonatomic, strong) TDD_CustomLabel * tipsLabel;
@property (nonatomic, assign) TDD_CustomLoadingType loadingType;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat fontSize;
@end

@implementation TDD_ArtiMsgBoxView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor tdd_collectionViewBG];
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    _scale = IS_IPad ? HD_Height : H_Height;
    _leftSpace = (IS_IPad  ? 20 : 10 ) * _scale;
    _fontSize = IS_IPad ? 20 : 17;
    CGFloat loadingHeight = (IS_IPad ? 80 : 70) * _scale;
    
    TDD_ArtiMsgBoxProgressView * progressView = [[TDD_ArtiMsgBoxProgressView alloc] init];
    [self addSubview:progressView];
    self.progressView = progressView;
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    [self addSubview:scrollView];
    
    // 创建contentView，添加到scrollView作为唯一子视图
    UIView * contentView = [[UIView alloc] init];
//    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    self.contentView = contentView;
    
    UIStackView * stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 10 * _scale;
    [contentView addSubview:stackView];
    self.stackView = stackView;
    
    //外面传自定义loadingView 并且车是AutoVin
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingView:)]
        && [[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingViewRect:)]
        && [[TDD_DiagnosisManage sharedManage].carModel.strVehicle.uppercaseString isEqualToString:@"AUTOVIN"]) {
        _loadingType = TDD_CustomLoadingType_AutoVin;
        UIView *loadingView = [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingView:TDD_CustomLoadingType_AutoVin];
        CGRect loadingViewRect = [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingViewRect:TDD_CustomLoadingType_AutoVin];
        if (loadingView){
            [self setupCustomLoading:loadingView frame:loadingViewRect];
        }

    }
    if (!_isCustomLoadingView){
        TDD_LoadingView *loadingView = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, loadingHeight, loadingHeight)];
        [loadingView setBGColor:UIColor.clearColor];
        loadingView.hidden = YES;
        [stackView addArrangedSubview:loadingView];
        self.loadingView = loadingView;
        [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(loadingHeight, loadingHeight));
        }];
    }
    
    //if (isKindOfTopVCI){
        UIImageView *iconView = [UIImageView new];
        iconView.image = kImageNamed(@"ble_communicate_error");
        [stackView addArrangedSubview:iconView];
        self.iconImageView = iconView;
    //}

    
    TDD_CustomLabel * contentLabel = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.text = [NSString stringWithFormat:@""];
        label.font = [[UIFont systemFontOfSize:_fontSize] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    });
    [stackView addArrangedSubview:contentLabel];
    self.contentLabel = contentLabel;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.stackView);
        make.left.greaterThanOrEqualTo(self.stackView).offset(_leftSpace);
    }];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(scrollView);
        make.bottom.equalTo(stackView).offset(_leftSpace).priorityLow();
        make.top.equalTo(stackView).offset(-_leftSpace).priorityLow();
    }];

}

- (void)setMsgBoxModel:(TDD_ArtiMsgBoxModel *)msgBoxModel
{
    _msgBoxModel = msgBoxModel;
    
    if (msgBoxModel.isShowTranslated) {
        self.contentLabel.text = msgBoxModel.strTranslatedContent;
    }else {
        self.contentLabel.text = msgBoxModel.strContent;
    }
    
    [self changeUI];
    

    
    if (!msgBoxModel.bIsBlock) {
        [msgBoxModel conditionSignalWithTime:0.1];
    }
}

- (void)setupCustomLoading:(UIView *)loadingView frame:(CGRect )loadingViewRect {
    _isCustomLoadingView = YES;
    [self.stackView removeArrangedSubview:self.loadingView];
    loadingView.frame = loadingViewRect;
    self.loadingView = loadingView;
    self.stackView.alignment = UIStackViewAlignmentFill;
    [self.stackView insertArrangedSubview:loadingView atIndex:0];
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.stackView);
        make.width.mas_equalTo(loadingViewRect.size.width);
        make.height.mas_equalTo(loadingViewRect.size.height);
    }];
    
    if (_loadingType == TDD_CustomLoadingType_AutoVin) {
        TDD_CustomLabel * tipsLabel = ({
            TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
            label.text = TDDLocalized.autovin_time_tips;
            label.font = [[UIFont systemFontOfSize:_fontSize] tdd_adaptHD];
            label.textColor = [UIColor tdd_title];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 0;
            label;
        });
        [self.contentView addSubview:tipsLabel];
        self.tipsLabel = tipsLabel;
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-_leftSpace);
            make.left.equalTo(self.contentView).offset(_leftSpace);
        }];
    }
    
}

- (void)changeUI
{
    if (self.msgBoxModel.isBusyVisible) {
        self.loadingView.hidden = NO;
        if (_isCustomLoadingView){
            if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingViewStart:)]) {
                [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingViewStart:_loadingType];
            }
            
        }
        
    }else {
        self.loadingView.hidden = YES;
        if (_isCustomLoadingView){
            if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(diagnosisCustomLoadingViewStop:)]) {
                [[TDD_DiagnosisManage sharedManage].manageDelegate diagnosisCustomLoadingViewStop:_loadingType];
            }
        }
        
    }
    
    if (isTopVCI){
        if (self.msgBoxModel.uType != 0) {
            self.iconImageView.hidden = NO;
            self.loadingView.hidden = YES;
        } else {
            self.iconImageView.hidden = YES;
        }
    }
    

    if (self.msgBoxModel.specialViewType == 1) {
        self.iconImageView.image = kImageNamed(@"no_data");
        self.iconImageView.hidden = NO;
        self.loadingView.hidden = YES;
    } else {
        self.iconImageView.hidden = YES;
    }
    
    
    if (self.msgBoxModel.isProcessBarVisible) {
        self.progressView.hidden = NO;
        if (self.isCustomLoadingView) {
            self.tipsLabel.hidden = NO;
        }
        
        if (self.msgBoxModel.iTotalPercent > 0) {
            self.progressView.progress = self.msgBoxModel.iCurPercent / (float)self.msgBoxModel.iTotalPercent;
        }

    }else {
        self.progressView.hidden = YES;
        self.tipsLabel.hidden = YES;
    }
    self.contentLabel.textAlignment = NSTextAlignmentLeft;

    int alignType = self.msgBoxModel.uAlignType;
    switch (alignType) {
        case DT_LEFT:
        {
            if isKindOfTopVCI {
                self.contentLabel.textAlignment = NSTextAlignmentLeft;
            }
            [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.isCustomLoadingView) {
                    make.top.equalTo(self.progressView.mas_bottom);
                }else {
                    make.centerY.equalTo(self.contentView);
                }
                
                make.left.equalTo(self.contentView).offset(_leftSpace);
                make.right.lessThanOrEqualTo(self.contentView).offset(-_leftSpace);
            }];
        }
            break;
        case DT_RIGHT:
        {
            if isKindOfTopVCI {
                self.contentLabel.textAlignment = NSTextAlignmentRight;
            }
            [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.isCustomLoadingView) {
                    make.top.equalTo(self.progressView.mas_bottom);
                }else {
                    make.centerY.equalTo(self.contentView);
                }
                make.right.equalTo(self.contentView).offset(-_leftSpace);
                make.left.greaterThanOrEqualTo(self.contentView).offset(_leftSpace);
            }];
        }
            break;
        case DT_CENTER:
        {
            if (_loadingType == TDD_CustomLoadingType_AutoVin) {
                self.contentLabel.textAlignment = NSTextAlignmentCenter;
            }
            [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.isCustomLoadingView) {
                    make.top.equalTo(self.progressView.mas_bottom);
                    make.centerX.equalTo(self.contentView);
                }else {
                    make.center.equalTo(self.contentView);
                }
                make.left.greaterThanOrEqualTo(self.contentView).offset(_leftSpace);
                make.right.lessThanOrEqualTo(self.contentView).offset(-_leftSpace);
            }];
        }
            break;
        case DT_BOTTOM:
        {
            [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView);
                if (self.isCustomLoadingView) {
                    make.bottom.equalTo(self.tipsLabel.mas_top).offset(-_leftSpace);
                }else {
                    make.bottom.equalTo(self.contentView).offset(-_leftSpace);
                }
                
                make.left.greaterThanOrEqualTo(self.contentView).offset(_leftSpace);
                make.right.lessThanOrEqualTo(self.contentView).offset(-_leftSpace);
            }];
        }
            break;

        default:
            break;
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [TDD_LoadingView resetStatic];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}


@end
