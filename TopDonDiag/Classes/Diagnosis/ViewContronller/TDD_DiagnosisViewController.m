//
//  TDD_DiagnosisViewController.m
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import "TDD_DiagnosisViewController.h"

#import "TDD_ArtiContentBaseView.h"

#import "TDD_ArtiButtonView.h"
#import "TDD_ArtiButtonCollectionView.h"

#import "TDD_ArtiMenuView.h"
#import "TDD_ArtiMenuModel.h"

#import "TDD_ArtiActiveView.h"
#import "TDD_ArtiActiveModel.h"

#import "TDD_ArtiEcuInfoModel.h"
#import "TDD_ArtiEcuInfoView.h"

#import "TDD_ArtiFreezeModel.h"
#import "TDD_ArtiFreezeView.h"

#import "TDD_ArtiReportModel.h"
#import "TDD_ArtiReportView.h"

#import "TDD_ArtiTroubleModel.h"
#import "TDD_ArtiTroubleView.h"

#import "TDD_ArtiInputModel.h"
#import "TDD_ArtiInputView.h"

#import "TDD_ArtiListModel.h"
#import "TDD_ArtiListView.h"
#import "TDD_ArtiListTDartsView.h"

#import "TDD_ArtiMsgBoxModel.h"
#import "TDD_ArtiMsgBoxView.h"

#import "TDD_ArtiWebView.h"
#import "TDD_ArtiWebModel.h"

#import "TDD_ArtiFileDialogView.h"
#import "TDD_ArtiFileDialogModel.h"

#import "TDD_ArtiSystemView.h"
#import "TDD_ArtiSystemModel.h"

#import "TDD_ArtiLiveDataView.h"
#import "TDD_ArtiLiveDataModel.h"
#import "TDD_ArtiLiveDataSelectModel.h"
#import "TDD_ArtiLiveDataChartSelectModel.h"
#import "TDD_ArtiLiveDataSelectView.h"
#import "TDD_ArtiLiveDataSetView.h"
#import "TDD_ArtiLiveDataSetModel.h"
#import "TDD_ArtiLiveDataMoreChartModel.h"
#import "TDD_ArtiLiveDataMoreChartView.h"
#import "TDD_ArtiFreqWaveModel.h"
#import "TDD_ArtiFreqWaveView.h"
#import "TDD_ArtiCoilReaderModel.h"
#import "TDD_ArtiCoilReaderView.h"
#import "TDD_ArtiPictureModel.h"
#import "TDD_ArtiPictureView.h"

#import "TDD_ArtiMiniMsgBoxView.h"
#import "TDD_ArtiMiniMsgBoxModel.h"

#import "TDD_ArtiGlobalModel.h"

#import "TDD_StdCommModel.h"
#import "TDD_DiagnosisManage.h"

#import "TDD_RightbuttonView.h"  //tang add

#import "TDD_ArtiReportGeneratorModel.h"
#import "TDD_ArtiReportGeneratorView.h"
#import "TDD_ArtiADASReportGeneratorView.h"

#import "TDD_NaviMoreBtnView.h"
#import "TDD_DiagNaviBtnGuildView.h"
#import "TDD_DiagTopVCIProNaviBtnGuildVIew.h"

#import "TDD_ArtiPopupModel.h"
#import "TDD_ArtiPopupView.h"

#import "TDD_FCAAuthModel.h"
#import "TDD_ArtiFACAuthView.h"

#import "TDD_ArtiGatewayRightsView.h"

#import "TDD_ArtiFuelLevelModel.h"
#import "TDD_ArtiFuelLevelView.h"

#import "TDD_ArtiWheelBrowView.h"
#import "TDD_ArtiWheelBrowModel.h"

#import "TDD_ArtiMsgBoxDsView.h"
#import "TDD_ArtiMsgBoxDsModel.h"

#import "TDD_ArtiMsgBoxGroupModel.h"
#import "TDD_ArtiMsgBoxGroupView.h"

#import "TDD_ArtiMsgBoxDsModel.h"
#import "TDD_ArtiMsgBoxDsView.h"
#import "TDD_ArtiFloatMiniModel.h"


#import <AVFAudio/AVFAudio.h>
#import "TDD_LoadingView.h"

#import "TDD_TDartsManage.h"
#import "TDD_ArtiInstanceView.h"

#import "UIInterface+HXRotation.h"
#import "TDD_ArtiButtonCollectionView.h"

@import TDUIProvider;
@interface TDD_DiagnosisViewController ()<TDD_HTipBtnViewDelegate, TDD_ArtiButtonCollectionViewDelegate, TDD_LandscapeLiveButtonViewDelegate, ArtiContentViewDelegate, TDD_ArtiTroubleModelDelegata, TDD_ArtiReportGeneratorModelDelegata,TDD_ArtiGlobalModelDelegata, TDD_NaviMoreBtnViewDelegate,TDD_ArtiPopupModelDelegata,TDD_NaviViewDelegate,TDD_ArtiSystemModelDelegata,TDD_FCALoginModelDelegata>

@property (nonatomic, strong) NSMutableDictionary * UIDic;
@property (nonatomic, strong) TDD_VciUnConnectTipView * topView;
@property (nonatomic, assign) CGFloat topTipLabH;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) TDD_ArtiModelBase * model;
//@property (nonatomic, strong) TDD_ArtiButtonView * buttonView;
@property (nonatomic, strong) TDD_ArtiButtonCollectionView * buttonView;
@property (nonatomic, strong) TDD_RightbuttonView *rightButtonView;
@property (nonatomic, strong) TDD_NaviMoreBtnView *moreBtnView;
@property (nonatomic, strong) TDD_ArtiInstanceView *instanceView; // 浮窗

@property (nonatomic, strong) AVAudioPlayer *audio;
@property (nonatomic, assign)CGFloat scale;

/// 根据 modId 缓存 搜索关键字 searchKey
@property (nonatomic, strong) NSMutableDictionary *searchKeyDict;

/// 记录数据流显示数组
@property (nonatomic, strong) NSArray *liveDataShowArray;
@property (nonatomic, strong) UIView *loadingView;

@property (nonatomic, assign) BOOL enterBackgroundVCIStatus;
@property (nonatomic, assign) BOOL enterBackgroundTDartsStatus;

/// 数据流视图横屏
@property (nonatomic, assign) BOOL isLiveDataChartLandscape;
@property (nonatomic, assign) BOOL isWillShow;
@property (nonatomic, strong) TDD_LandscapeLiveButtonView * landscapeLiveButtonView;

@end

@implementation TDD_DiagnosisViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _isWillShow = YES;
    if (_isLiveDataChartLandscape) {
        [self notifyLandscape:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for(UIGestureRecognizer* gesture in self.view.window.gestureRecognizers){
        gesture.delaysTouchesBegan = NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiViewDidAppear object:nil];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for(UIGestureRecognizer* gesture in self.view.window.gestureRecognizers){
        gesture.delaysTouchesBegan = YES;
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    _isWillShow = NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self layoutLandscapeOrPortrait];
}

- (void) layoutLandscapeOrPortrait {
    /// 更新横竖屏导航栏高度
    CGFloat navHeight = 44.0;
    if (!_isLiveDataChartLandscape) { if (@available(iOS 11.0, *)) { navHeight += self.view.safeAreaInsets.top; } }
    self.naviView.frame = CGRectMake(0, 0, self.view.bounds.size.width, navHeight);
    [self.naviView layouForLandscape:_isLiveDataChartLandscape];
    
    /// 更新 topView contentView bottomViews
    [self setupTopViewConstraintsLandscape:_isLiveDataChartLandscape];
    [self setupContentViewConstraintsLandscape:_isLiveDataChartLandscape bottomHidden:_bottomView.hidden];
    [self setupBottomViewsConstraintsLandscape:_isLiveDataChartLandscape];
}

- (void)notifyLandscape:(BOOL)isLandscape {
    if (isLandscape) {
        UIInterfaceOrientation orientation = UIInterfaceOrientationLandscapeRight;
        [NSNotificationCenter.defaultCenter postNotificationName:KTDDNotificationLandscapePortraitChange object:@(orientation) userInfo:@{@"vc": self}];
    } else {
        UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
        [NSNotificationCenter.defaultCenter postNotificationName:KTDDNotificationLandscapePortraitChange object:@(orientation) userInfo:@{@"vc": self}];
    }
}

- (void)dealloc {
    
}

- (void)setDiagEntryType:(eDiagEntryType)diagEntryType
{
    _diagEntryType = diagEntryType;
    
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagEntryType = diagEntryType;
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate = self;
}

- (void)setDiagMenuMask:(eDiagMenuMask)diagMenuMask {
    _diagMenuMask = diagMenuMask;
    
    [TDD_ArtiGlobalModel sharedArtiGlobalModel].diagMenuMask = diagMenuMask;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor tdd_viewControllerBackground];
    _scale = IS_IPad ? HD_HHeight : H_HHeight;
    if (isKindOfTopVCI){
        self.naviView.naviType = kNaviTypeClear;
    } else {
        self.naviView.naviType = kNaviTypeWhite;
    }
    [self setupNaviButton];
    
    self.searchKeyDict = [NSMutableDictionary dictionary];
    self.naviView.titleLabel.hidden = YES;
    [self creatUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(artiShow:) name:KTDDNotificationArtiShow object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(artiTranslatedShow:) name:KTDDNotificationArtiTranslatedShow object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(artiDiagExit) name:KTDDNotificationArtiDiagStop object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(artiShowFloatMini:) name:KTDDNotificationArtiShowFloatMini object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackGround:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterForeGround:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    if (self.diagNavType != TDD_DiagNavType_TDarts) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vciStatusDidChange) name:KTDDNotificationVciStatusDidChange object:nil];
    }
    
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [self artiDiagStopSound];
    
    
    //    [Start start];
    
    [self enterDiagnosis];
    
    
}

- (void)setupNaviButton {
    
    _rightButtonView = [[TDD_RightbuttonView alloc] initWithType:self.diagNavType];
    @kWeakObj(self)
    _rightButtonView.buttonblock = ^(NSInteger indexBtn) {
        @kStrongObj(self)
        switch (indexBtn) {
            case 100:
                [self gotoTDartsDeviceConnect];
                break;
            case 101:
                [self feedBackClick];
                break;
            case 102:
                [self translateBtnClick];
                break;
            case 103:
                [self setDiagNaviTypeSearch];
                break;
            case 104:
                [self serviceBtnClick];
                break;
            case 105:
                [self gotoTDartsDeviceConnect];
                break;
            case 106:
                [self helpBtnClick];
                break;
            case 111:
                [self saveBtnClick];
                break;
                
            default:
                break;
        }
    };
    _rightButtonView.moreBtnBlock = ^(NSArray * _Nonnull showBtnArray) {
        @kStrongObj(self)
        self.moreBtnView.showBtnArray = showBtnArray;
        //翻译按钮状态
        if (self.model.isShowTranslated && self.model.translateSucc) {
            if (self.model.isTranslating) {
                [self.moreBtnView showTranslateAnimate:true];
            }else {
                [self.moreBtnView showTranslateFinish:YES];
            }
            
        }else {
            [self.moreBtnView showTranslateFinish:NO];
            
        }
        [self showNaviMoreBtnView];
    };
    [self.naviView addSubview:_rightButtonView];
    [_rightButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.naviView.mas_right).offset(-9);
        make.centerY.equalTo(self.naviView.backBtn);
        make.height.mas_equalTo(44);
    }];
}

- (void)gotoTDartsDeviceConnect {
    if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]) {
        [self.delegate handleOtherEvent:TDD_DiagOtherEventType_ToBLEConnect model:self.model param:nil diagVC:self];
    }
}
- (void)feedBackClick {
    
    if (_isLiveDataChartLandscape) {
        [self notifyLandscape:NO]; // 强制横屏
    }
    
    [self eventWithKey:Event_Clickfeedback isFeedback:YES];
    [self.moreBtnView dismiss];
    if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]){
        [self.delegate handleOtherEvent:TDD_DiagOtherEventType_FeedBackChoose model:self.model param:nil diagVC:self];
    }
}

- (void)liftbutton{
    
}

#pragma mark 进入诊断
- (void)enterDiagnosis
{
    
    //    dispatch_block_t work = dispatch_block_create(0, ^{
    //        // 你的任务代码
    //    });
    //
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), work);
    //
    //    // 取消任务
    //    dispatch_block_cancel(work);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [TDD_ArtiGlobalModel cleanParamtert];
        NSString * carLanguage = [TDD_HLanguage entryDiagLanguageWithCarModel:self.carModel];
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].carLanguage = carLanguage;
        self.carLanguage = carLanguage;
        
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].carServiceName = self.carModel.serviceName;
        
        uint32_t backInt = [TDD_DiagnosisManage ArtiDiagWithCarModel:self.carModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (backInt != 0) {
                [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.diagnosis_no_car buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
                    
                }];
            }
            //退车重置键盘
            [self resignFirstResponder];
            if ([[self.carModel.strVehicle uppercaseString] isEqualToString:@"AUTOVIN"] || ([TDD_ArtiGlobalModel sharedArtiGlobalModel].isCurVehNotSupport && [TDD_DiagnosisTools softWareIsKindOfTopScan])){
                TDD_CarModel *carModel = nil;
                if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(autoVINMatchToEnter)]){
                    carModel = [[TDD_DiagnosisManage sharedManage].manageDelegate autoVINMatchToEnter];
                }
                if (carModel && [carModel isKindOfClass:[TDD_CarModel class]]){
                    self.carModel = carModel;
                    [self enterDiagnosis];
                    
                }else{
                    if ([self.delegate respondsToSelector:@selector(finishDiag:)]) {
                        [self.delegate finishDiag:self];
                    }else{
                        [super backClick];
                    }
                }
            }else {
                if ([self.delegate respondsToSelector:@selector(finishDiag:)]) {
                    [self.delegate finishDiag:self];
                }else{
                    [super backClick];
                }
            }
            
            
        });
    });
}

#pragma mark 创建UI
- (void)creatUI{
    [self.view addSubview:self.topView];

    //底部View
    UIView * bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    //底部按钮
    TDD_ArtiButtonCollectionView * buttonView = [[TDD_ArtiButtonCollectionView alloc] init];
    buttonView.delegate = self;
    [_bottomView addSubview:buttonView];
    self.buttonView = buttonView;
    
    //中间View
    UIView * contentView = [[UIView alloc] init];
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self setupTopViewConstraintsLandscape:_isLiveDataChartLandscape];
    [self setupContentViewConstraintsLandscape:_isLiveDataChartLandscape bottomHidden:NO];
    [self setupBottomViewsConstraintsLandscape:_isLiveDataChartLandscape];
    
    //浮窗 View
    TDD_ArtiInstanceView *instanceView = [[TDD_ArtiInstanceView alloc] init];
    [self.view addSubview:instanceView];
    [self.view bringSubviewToFront:instanceView];
    instanceView.hidden = true;
    self.instanceView = instanceView;
    
    [instanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView);
    }];
    
    [self vciStatusDidChange];
    
}

- (void)setupTopViewConstraintsLandscape: (BOOL)isLandscape {
    _topTipLabH = [NSString tdd_getHeightWithText:TDDLocalized.tips_vci_unconnect width:IS_IPad ? (IphoneWidth - 112) : (IphoneWidth - 66) fontSize:[[UIFont systemFontOfSize:IS_IPad ? 18 : 14 weight:UIFontWeightMedium] tdd_adaptHD]];
    
    CGFloat height = NavigationHeight;
    if (isLandscape && _isWillShow) { height = 44.0; }
    
    [_topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(height);
        make.height.mas_equalTo(_topTipLabH + (IS_IPad ? 40 : 25));
    }];
}

- (void)setupBottomViewsConstraintsLandscape: (BOOL)isLandscape {
    
    TDD_ArtiModelBase * model = self.buttonView.model;
    if (isLandscape && _isWillShow) {
        CGFloat height = IS_IPad ? 55.0 : 55.0;
        CGFloat width = 244.0;
        
        _bottomView.backgroundColor = UIColor.clearColor;
        _bottomView.layer.shadowColor = nil;
        _bottomView.layer.shadowOffset = CGSizeZero;
        _bottomView.layer.shadowOpacity = 0;
        _bottomView.layer.shadowRadius = 0;
        _bottomView.layer.masksToBounds = NO;
        _bottomView.clipsToBounds = NO;
        
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeBottomHeight);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
        }];
        
        [_buttonView setModel:model];
        
        [_buttonView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(_bottomView);
            make.height.mas_equalTo(height);
        }];
        
        self.landscapeLiveButtonView.hidden = NO;
        [_landscapeLiveButtonView setModel:model];
        [_buttonView addSubview:_landscapeLiveButtonView];
        [_landscapeLiveButtonView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_buttonView);
        }];
        
        /// 确保 _bottomView 在最前面，这样阴影能正确显示
        [self.view bringSubviewToFront:_bottomView];
    
    } else {
        CGFloat height  = IS_IPad ? 100 * _scale : 58 * _scale;
        _bottomView.backgroundColor = [UIColor tdd_colorDiagBottomGradient:TDD_GradientStyleTopToBottom withFrame:CGSizeMake(IphoneWidth, height + 1 + iPhoneX_D)];
        _bottomView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0,1);
        _bottomView.layer.shadowOpacity = 1 * _scale;
        _bottomView.layer.shadowRadius = 25 * _scale;
        // 确保阴影能正确显示
        _bottomView.layer.masksToBounds = NO;
        _bottomView.clipsToBounds = NO;
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(height + iPhoneX_D);
        }];
        
        [_buttonView setModel:model];
        
        [_buttonView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(_bottomView);
            make.height.mas_equalTo(height);
        }];
        
        if (_landscapeLiveButtonView) {
            _landscapeLiveButtonView.hidden = NO;
            if (_landscapeLiveButtonView.superview) {
                [_landscapeLiveButtonView removeFromSuperview];
            }
        }
        /// 确保 _bottomView 在最前面，这样阴影能正确显示
        [self.view bringSubviewToFront:_bottomView];
    }
}

- (void)setupContentViewConstraintsLandscape: (BOOL)isLandscape bottomHidden: (BOOL) bottomHidden {
    
    UIView *relativeView = self.topView.hidden ? self.naviView : self.topView;
    
    if (isLandscape && _isWillShow) {
        if (self.carModel.softType == TDD_SoftType_TDarts) {
            [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.naviView.mas_bottom);
                make.bottom.equalTo(self.view).offset(-kSafeBottomHeight);
            }];
        }else {
            [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(relativeView.mas_bottom);
                make.bottom.equalTo(self.view).offset(-kSafeBottomHeight);
            }];
        }
    } else {
        if (self.carModel.softType == TDD_SoftType_TDarts) {
            [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.naviView.mas_bottom);
                if (bottomHidden) {
                    make.bottom.equalTo(self.view).offset(-kSafeBottomHeight);
                } else {
                    make.bottom.equalTo(self.bottomView.mas_top);
                }
            }];
        }else {
            
            [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(relativeView.mas_bottom);
                if (bottomHidden) {
                    make.bottom.equalTo(self.view).offset(-kSafeBottomHeight);
                } else {
                    make.bottom.equalTo(self.bottomView.mas_top);
                }
            }];
        }
    }
}

#pragma mark -- TDD_NaviMoreBtnViewDelegate
- (void)navMoreBtnClick:(NSInteger)btnIndex {
    if (btnIndex == 101) {
        [self feedBackClick];
    } else if (btnIndex == 102) {
        [self translateBtnClick];
    } else if (btnIndex == 103) {
        [self setDiagNaviTypeSearch];
    } else if (btnIndex == 104) {
        [self serviceBtnClick];
    }
    
}

- (void)translateBtnClick {
    [self eventWithKey:Event_Cus_ClickTranslate isFeedback:NO];

    if (!self.model.isShowTranslated && [TDD_DiagnosisManage sharedManage].netState == TDD_NetworkStatusReachable_Not) {
        [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.network_is_abnormal_check_the_network];
        return;
    }
    self.model.isShowTranslated = !self.model.isShowTranslated;
    if (self.model.isShowTranslated) {
        if (self.rightButtonView.showBtnArray.count > 3 && [self.moreBtnView.showBtnArray containsObject:@(kTranslateBtn)]) {
            [self.moreBtnView showTranslateAnimate:true];
        } else {
            [self.rightButtonView showTranslateAnimate:true];
        }
        [self.model machineTranslation];
    }else {
        [self.model translationCompleted];
    }
}

- (void)serviceBtnClick {
    if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]){
        [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoWechatService model:self.model param:nil diagVC:self];
    }
}

- (void)helpBtnClick {
    if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]){
        [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoHelp model:self.model param:nil diagVC:self];
    }
}

- (void)saveBtnClick {
    if (isKindOfTopVCI) {
        TDD_ArtiContentBaseView *view = [self getUIWithClass:[TDD_ArtiLiveDataSetView class]];
        
        [(TDD_ArtiLiveDataSetView *)view saveLiveData];
    }

    
    [self.model backClick];
}

/// 翻译和反馈埋点
- (void)eventWithKey:(NSString *)key isFeedback:(BOOL)isFeedback {
    NSString *feedbackreferrer = @"";
    if ([self.model isKindOfClass:[TDD_ArtiSystemModel class]]) {
        feedbackreferrer = @"AutoScan";
    } else if ([self.model isKindOfClass:[TDD_ArtiTroubleModel class]] || [self.model isKindOfClass:[TDD_ArtiPopupModel class]]) {
        feedbackreferrer = @"ReadCode";
    } else if ([self.model isKindOfClass:[TDD_ArtiLiveDataModel class]]) {
        feedbackreferrer = @"LiveData";
    }
    
    if (![NSString tdd_isEmpty:feedbackreferrer]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.naviView.title?:@"" forKey:@"TitleName"];
        
        if (!isFeedback) {
            [dic setObject:[TDD_ArtiGlobalModel GetVehName]?:@"" forKey:@"Make"];
            [dic setObject:[TDD_ArtiGlobalModel GetLanguage]?:@"" forKey:@"Language"];
            [dic setObject:feedbackreferrer forKey:@"Translatorsreferrer"];
        } else {
            [dic setObject:feedbackreferrer forKey:@"Feedbackreferrer"];
        }

        [TDD_Statistics event:key attributes:dic];
    }
}

// 设置页面为搜索状态
- (void)setDiagNaviTypeSearch {
    [self.moreBtnView dismiss];
    if (!self.model.isSearch) {
        if ([self.model isKindOfClass:[TDD_ArtiMenuModel class]]) {
            [TDD_Statistics event:Event_Cus_ClickMenuSearch attributes:@{@"TitleName":self.naviView.title?:@"",@"Make":self.carModel.strVehicle?:@""}];
        }else if ([self.model isKindOfClass:[TDD_ArtiLiveDataModel class]]) {
            [TDD_Statistics event:Event_Cus_ClickLiveDataSerch attributes:@{@"Make":[TDD_ArtiGlobalModel GetVehName]?:@""}];
        }else if ([self.model isKindOfClass:[TDD_ArtiLiveDataSelectModel class]]) {
            [TDD_Statistics event:Event_Cus_ClickLiveDataEditSerch attributes:@{@"Make":[TDD_ArtiGlobalModel GetVehName]?:@""}];
        }

        self.model.isSearch = YES;
        self.naviView.searchField.hidden = NO;
        [self.naviView.searchField becomeFirstResponder];
        self.naviView.searchField.text = self.model.searchKey;
    }
    [self resetRightButtonView:self.model];
}

// 菜单页面导航栏更多按钮弹窗显示
- (void)showNaviMoreBtnView {
    [self.moreBtnView show];
}

- (void)searchKeyChanged:(NSString *)searchKey {
    self.model.searchKey = searchKey;
    if ([self.model isKindOfClass:[TDD_ArtiLiveDataModel class]]) {
        TDD_ArtiLiveDataModel *liveDataModel = (TDD_ArtiLiveDataModel *)self.model;
        [liveDataModel updateLiveDataModel];
    } else if ([self.model isKindOfClass:[TDD_ArtiLiveDataSelectModel class]]) {
        
        TDD_ArtiLiveDataSelectModel *liveDataSelectModel = (TDD_ArtiLiveDataSelectModel *)self.model;
        [liveDataSelectModel updateShowLiveData];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.model userInfo:nil];
}

#pragma mark 翻译完成回调
- (void)artiTranslatedShow:(NSNotification *)info{
    
    [self.moreBtnView dismiss];
    HLog(@"翻译完成回调");
    
    TDD_ArtiModelBase * model = info.object;
    
    if (model == self.model) {
        [self resetRightButtonView:model];
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:model userInfo:nil];
    }
}



#pragma mark UI展示
- (void)artiShow:(NSNotification *)info{
    
    HLog(@"展示UI");
    
    TDD_ArtiModelBase * model = info.object;
        
    // LECASON: TEST
//    model = [[TDD_ArtiReportModel alloc] init];
    
    if (self.model != model) {
        //避免相同页面刷新时关闭提示
        [TDD_HTipManage deallocView];
        [TDD_HTipManage deallocViewWithTag:26790];
        
        //切换页面时刷新按钮
        model.isReloadButton = YES;
#warning:TODO 数据流数据由model保存
        if ([self.model isKindOfClass:[TDD_ArtiReportModel class]]){
            //退出报告清除数据流缓存数据
            self.liveDataShowArray = nil;
        }
        
        //导航栏右边按钮
        [self resetRightButtonView:model];
    }
    
    // 控制导航栏显示标题还是搜索框
    self.naviView.searchField.hidden = !model.isSearch;
    self.naviView.titleLabel.hidden = model.isSearch;
    if (model.isSearch && ![model.searchKey isEqualToString:self.naviView.searchKey]) {
        [self.naviView updateSearckKey:model.searchKey];
        self.naviView.searchKey = model.searchKey;
    }
    if (![self.model isKindOfClass:[model class]] && !self.model.isShowOtherView && ![model isKindOfClass:[TDD_ArtiMiniMsgBoxModel class]] || ([self.model isKindOfClass:[TDD_FCAAuthModel class]])) {
        HLog(@"移除旧UI");
        if ([TDD_DiagnosisTools softWareIsCarPalSeries] && [model isKindOfClass:[TDD_ArtiSystemModel class]]) {
            //Carpal 系统扫描曝光率埋点
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[TDD_DiagnosisTools selectedVCISerialNum] forKey:@"SN"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carBrand?:@"" forKey:@"Make"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carModel?:@"" forKey:@"Model"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].carYear?:@"" forKey:@"Year"];
            [dic setObject:[TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"" forKey:@"VIN"];
            [TDD_Statistics event:Event_Cus_SystemList attributes:dic];
        }
        if (self.contentView.subviews.count > 0) {
            UIView * view = self.contentView.subviews.lastObject;
            [view removeFromSuperview];
            [self removeContentUIWithClass:view];
        }
        UIView *view = [FLT_APP_WINDOW viewWithTag:500600];
        [view removeFromSuperview];
        view = nil;
    }


    [self showBackButton];
    
    self.model = model;
    
    
    // portrait or landscape
    if ([model isKindOfClass:[TDD_ArtiLiveDataMoreChartModel class]]) {
        if (_isLiveDataChartLandscape == NO) {
            _isLiveDataChartLandscape = YES;
            [self notifyLandscape:YES];
        }
    } else {
        if (_isLiveDataChartLandscape == YES) {
            _isLiveDataChartLandscape = NO;
            [self notifyLandscape:NO];
        }
    }
    
    if (![model isKindOfClass:[TDD_ArtiMiniMsgBoxModel class]]) {
        //MiniMsgBox 不需要修改VC标题
        self.buttonView.model = model;
        
        if (model.isShowTranslated) {
            self.titleStr = model.strTranslatedTitle;
        }else {
            self.titleStr = model.strTitle;
        }
        if (isKindOfTopVCI && [model isKindOfClass:[TDD_ArtiReportModel class]]) {
            self.titleStr = TDDLocalized.func_diagnose_report;
        }else if (isKindOfTopVCI && [model isKindOfClass:[TDD_ArtiSystemModel class]]) {
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]){
                self.titleStr = TDDLocalized.func_system_scan;
            }else {
                self.titleStr = TDDLocalized.system_title;
            }
        }
//        diag_fca_login
        self.naviView.title = self.titleStr;
        if ([model isKindOfClass:[TDD_FCAAuthModel class]] && [NSString tdd_isEmpty:self.titleStr]) {
            self.naviView.title = TDDLocalized.diag_fca_login;
        }
    }
    
    //bottomView 是否隐藏
    [self bottomViewShouldHide:NO];
    
    BOOL isNeedMake = NO;
    
    TDD_ArtiContentBaseView * view;
    
    if ([model isKindOfClass:[TDD_ArtiMenuModel class]]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultDiagNaviGuild]  && !isKindOfTopVCI) {
            if (isTopVCIPRO) {
                TDD_DiagTopVCIProNaviBtnGuildVIew *guildView = [[TDD_DiagTopVCIProNaviBtnGuildVIew alloc] initWithDiagType:self.diagNavType];
                @kWeakObj(self)
                guildView.block = ^(BOOL isShow) {
                    @kStrongObj(self)
                    if (isShow) {
                        UIButton *moreBtn = [self.rightButtonView viewWithTag:100 + kNavMoreBtn];
                        [self.rightButtonView navBtnClick:moreBtn];
                    } else {
                        [self.moreBtnView dismiss];
                    }
                };
                [guildView show];
            } else {
                TDD_DiagNaviBtnGuildView *guildView = [[TDD_DiagNaviBtnGuildView alloc] initWithDiagType:self.diagNavType];
                @kWeakObj(self)
                guildView.block = ^(BOOL isShow) {
                    @kStrongObj(self)
                    if (isShow) {
                        UIButton *moreBtn = [self.rightButtonView viewWithTag:100 + kNavMoreBtn];
                        [self.rightButtonView navBtnClick:moreBtn];
                    } else {
                        [self.moreBtnView dismiss];
                    }
                };
                [guildView show];
            }
        }
        
        view = [self getUIWithClass:[TDD_ArtiMenuView class]];
        
        [(TDD_ArtiMenuView *)view updateMenuViewWithModel:(TDD_ArtiMenuModel *)model searchKeyDict:self.searchKeyDict];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiActiveModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiActiveView class]];
        
        [(TDD_ArtiActiveView *)view setActiveModel:(TDD_ArtiActiveModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiEcuInfoModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiEcuInfoView class]];
        
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        
        [(TDD_ArtiEcuInfoView *)view setEcuInfoModel:(TDD_ArtiEcuInfoModel *)model];
    }else if ([model isKindOfClass:[TDD_ArtiFreezeModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiLiveDataView class]];
        
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        
        [(TDD_ArtiLiveDataView *)view setFreezeModel:(TDD_ArtiFreezeModel *)model];
        
    }else if ([model isKindOfClass:[TDD_ArtiReportModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiReportView class]];
        
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        
        [(TDD_ArtiReportView *)view setReportModel:(TDD_ArtiReportModel *)model showLiveData:self.liveDataShowArray];
    }else if ([model isKindOfClass:[TDD_ArtiTroubleModel class]]) {
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            view = [self getUIWithClass:[TDD_ArtiPopupView class]];
            
            [self.contentView addSubview:view];
            
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            [self.view layoutIfNeeded];
            [(TDD_ArtiTroubleModel *)model setDelegate:self];
            [(TDD_ArtiPopupView *)view setTroubleModel:(TDD_ArtiTroubleModel *)model];
        }else {
            view = [self getUIWithClass:[TDD_ArtiTroubleView class]];
            
            [self.contentView addSubview:view];
            
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            [self.view layoutIfNeeded];
            
            [(TDD_ArtiTroubleModel *)model setDelegate:self];
            
            [(TDD_ArtiTroubleView *)view setTroubleModel:(TDD_ArtiTroubleModel *)model];
        }
    } else if ([model isKindOfClass:[TDD_ArtiPopupModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiPopupView class]];
        
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        [(TDD_ArtiPopupModel *)model setDelegate:self];
        [(TDD_ArtiPopupView *)view setPopupModel:(TDD_ArtiPopupModel *)model];
    } else if ([model isKindOfClass:[TDD_ArtiInputModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiInputView class]];
        
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        
        [(TDD_ArtiInputView *)view setInputModel:(TDD_ArtiInputModel *)model];
    }else if ([model isKindOfClass:[TDD_ArtiListModel class]]) {
        
        TDD_ArtiListModel * listModel = (TDD_ArtiListModel *)model;
        if (listModel.IMMOStrPicturePath.length > 0) {
            view = [self getUIWithClass:[TDD_ArtiListTDartsView class]];
            [self.contentView addSubview:view];
            
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            [self.view layoutIfNeeded];
            
            [(TDD_ArtiListTDartsView *)view setListModel:(TDD_ArtiListModel *)model];
        }else {
            view = [self getUIWithClass:[TDD_ArtiListView class]];
            
            [self.contentView addSubview:view];
            
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            [self.view layoutIfNeeded];
            
            [(TDD_ArtiListView *)view setListModel:(TDD_ArtiListModel *)model];
        }
        
    }else if ([model isKindOfClass:[TDD_ArtiMsgBoxModel class]]) {
        [self hiddenBackButton];
        
        view = [self getUIWithClass:[TDD_ArtiMsgBoxView class]];
        
        [(TDD_ArtiMsgBoxView *)view setMsgBoxModel:(TDD_ArtiMsgBoxModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiWebModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiWebView class]];
        
        [(TDD_ArtiWebView *)view setWebModel:(TDD_ArtiWebModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiFileDialogModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiFileDialogView class]];
        
        [(TDD_ArtiFileDialogView *)view setFileDialogModel:(TDD_ArtiFileDialogModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiSystemModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiSystemView class]];
        ((TDD_ArtiSystemModel *)model).delegate = self;
        [(TDD_ArtiSystemView *)view setSystemModel:(TDD_ArtiSystemModel *)model];
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiLiveDataModel class]]) {
        //EOBD 有概率不响应上一次的 back 导致 loading不消失 卡住页面
        //增加兼容:数据流 show 的时候去掉 loading
        //点击返回时可能刚好 show LiveDataModel,会重新上锁导致loading提前消失
        if (model.returnID != DF_ID_BACK) {
            [TDD_HTipManage deallocViewWithTag:26790];
        }
        
        if (isKindOfTopVCI) {
            self.naviView.title = TDDLocalized.obd_data_line_title;
        }
        
        view = [self getUIWithClass:[TDD_ArtiLiveDataView class]];
        
        [(TDD_ArtiLiveDataView *)view setLiveDataModel:(TDD_ArtiLiveDataModel *)model];
        
        [(TDD_ArtiLiveDataView *)view setCarModel:self.carModel];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiLiveDataSelectModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiLiveDataSelectView class]];
        
        TDD_ArtiLiveDataSelectModel *selectModel = (TDD_ArtiLiveDataSelectModel *)model;
        [(TDD_ArtiLiveDataSelectView *)view setLiveDataSelectModel:selectModel];
        self.bottomView.hidden = selectModel.showItems.count == 0;
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiLiveDataChartSelectModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiLiveDataSelectView class]];
        
        [(TDD_ArtiLiveDataSelectView *)view setLiveDataChartSelectModel:(TDD_ArtiLiveDataChartSelectModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiLiveDataSetModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiLiveDataSetView class]];
            
        [(TDD_ArtiLiveDataSetView *)view setSetModel:(TDD_ArtiLiveDataSetModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiLiveDataMoreChartModel class]]) {
//        view = [self getUIWithClass:[TDD_ArtiLiveDataMoreChartViewNew class]];
//        
//        [(TDD_ArtiLiveDataMoreChartViewNew *)view setModel:(TDD_ArtiLiveDataMoreChartModel *)model];
        
        view = [self getUIWithClass:[TDD_ArtiLiveDataLandscapeMoreChartView class]];
        
        [(TDD_ArtiLiveDataLandscapeMoreChartView *)view setModel:(TDD_ArtiLiveDataMoreChartModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiReportGeneratorModel class]]) {
        [self hiddenBackButton];
        
        BOOL isADASReport = [((TDD_ArtiReportGeneratorModel *)model).reportModel isAdasReport];
        if (isADASReport) {
            view = [self getUIWithClass:[TDD_ArtiADASReportGeneratorView class]];
        } else {
            view = [self getUIWithClass:[TDD_ArtiReportGeneratorView class]];
        }

        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        
        TDD_ArtiReportModel *reportModel = ((TDD_ArtiReportGeneratorModel *)model).reportModel;
        ((TDD_ArtiReportGeneratorModel *)model).delegate = self;
        reportModel.carModel = self.carModel;
        
        if (isADASReport) {
            TDD_ArtiADASReportGeneratorView * adasView = (TDD_ArtiADASReportGeneratorView *) view;
            adasView.owningViewController = self;
            [adasView setReportModel: reportModel];
        } else {
            [(TDD_ArtiReportGeneratorView *)view setReportModel: reportModel];
        }
    }else if ([model isKindOfClass:[TDD_ArtiFreqWaveModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiFreqWaveView class]];
        
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.view layoutIfNeeded];
        
        [(TDD_ArtiFreqWaveView *)view setFreqWaveModel:(TDD_ArtiFreqWaveModel *)model];
    }else if ([model isKindOfClass:[TDD_ArtiCoilReaderModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiCoilReaderView class]];
        
        [self.contentView addSubview:view];
        
        [(TDD_ArtiCoilReaderView *)view setCoilReaderModel:(TDD_ArtiCoilReaderModel *)model];
        
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiMiniMsgBoxModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiMiniMsgBoxView class]];
        view.tag = 500600;
        view.frame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
        [FLT_APP_WINDOW addSubview:view];
        
        [(TDD_ArtiMiniMsgBoxView *)view setMiniMsgBoxModel:(TDD_ArtiMiniMsgBoxModel *)model];
        
        
    }
    else if ([model isKindOfClass:[TDD_ArtiPictureModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiPictureView class]];

        [self.contentView addSubview:view];

        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];

        [self.view layoutIfNeeded];

        [(TDD_ArtiPictureView *)view setPictureModel:(TDD_ArtiPictureModel *)model];
    }else if ([model isKindOfClass:[TDD_FCAAuthModel class]]) {
        TDD_FCAAuthModel *fcaModel = (TDD_FCAAuthModel*)model;
        fcaModel.delegate = self;
        if (fcaModel.viewType == 1) {
            view = [self getUIWithClass:[TDD_ArtiGatewayRightsView class]];
            [((TDD_ArtiGatewayRightsView *)view) setFcaModel:(TDD_FCAAuthModel*)model];
        }else {
            view = [self getUIWithClass:[TDD_ArtiFACAuthView class]];
            [((TDD_ArtiFACAuthView *)view) setFcaModel:(TDD_FCAAuthModel*)model];
        }
        
        isNeedMake = YES;

    }else if ([model isKindOfClass:[TDD_ArtiWheelBrowModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiWheelBrowView class]];
        [((TDD_ArtiWheelBrowView *)view) setWheelBrowModel:(TDD_ArtiWheelBrowModel *)model];
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiFuelLevelModel class]]) {
        view = [self getUIWithClass:[TDD_ArtiFuelLevelView class]];
        [((TDD_ArtiFuelLevelView *)view) setFuelLevelModel:(TDD_ArtiFuelLevelModel *)model];
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiMsgBoxGroupModel class]]) {
        [self hiddenBackButton];
        view = [self getUIWithClass:[TDD_ArtiMsgBoxGroupView class]];
        [((TDD_ArtiMsgBoxGroupView *)view) setGroupModel:(TDD_ArtiMsgBoxGroupModel *)model];
        isNeedMake = YES;
    }else if ([model isKindOfClass:[TDD_ArtiMsgBoxDsModel class]]) {
        [self hiddenBackButton];
        view = [self getUIWithClass:[TDD_ArtiMsgBoxDsView class]];
        [((TDD_ArtiMsgBoxDsView *)view) setDsModel:(TDD_ArtiMsgBoxDsModel *)model];
        isNeedMake = YES;
    }
    
    view.delegate = self;
    [self bottomViewShouldHide:model.isHideBottomView];
    if (isNeedMake) {
        [self.contentView addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    if (!model.isSearch) {
        [self.view endEditing:YES];
    }
    HLog(@"完成展示UI");
}

/// 检查底部按钮 view 是否隐藏
- (void)bottomViewShouldHide:(BOOL )hide {
    if (hide) {
        if (!self.bottomView.isHidden) {
            self.bottomView.hidden = YES;
//            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(self.view);
//                make.top.equalTo(self.topView.mas_bottom);
//                make.bottom.equalTo(self.view).offset(-kSafeBottomHeight);
//            }];
            [self setupContentViewConstraintsLandscape:_isLiveDataChartLandscape bottomHidden:YES];
        }

    }else {
        if (self.bottomView.isHidden) {
            self.bottomView.hidden = NO;
//            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(self.view);
//                make.top.equalTo(self.topView.mas_bottom);
//                make.bottom.equalTo(self.bottomView.mas_top);
//            }];
            [self setupContentViewConstraintsLandscape:_isLiveDataChartLandscape bottomHidden:NO];
        }
    }
}

- (void)vciStatusDidChange {
    if (self.carModel.softType == TDD_SoftType_TDarts) {
        return;
    }
    if ([TDD_EADSessionController sharedController].VciStatus || [self.carModel.strVehicle isEqualToString:@"DEMO"]) {

        self.topView.hidden = YES;
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.naviView.mas_bottom);
            make.height.mas_equalTo(0);
        }];
    }else {
//        self.vciTipsLabel.hidden = NO;
        self.topView.hidden = NO;

        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(NavigationHeight);
            make.height.mas_equalTo(_topTipLabH + (IS_IPad ? 40 : 25));
        }];
        
    }
    
}

#pragma mark 浮窗UI展示
- (void)artiShowFloatMini:(NSNotification *)info {
    
    HLog(@"展示FloatMiniUI");
    
    TDD_ArtiModelBase * model = info.object;
    if ([model isKindOfClass:[TDD_ArtiFloatMiniModel class]]) {
        self.instanceView.hidden = NO;
        [self.view bringSubviewToFront:self.instanceView];
        
        [self.instanceView checkShowInstanceView:(TDD_ArtiFloatMiniModel *)model];
    }
}

- (void)resetRightButtonView:(TDD_ArtiModelBase *)model {
    NSLog(@"diagNavType : %@", @(self.diagNavType));
    //搜索、翻译按钮是否显示
    NSArray *btnArr = @[];
    if (isTopVCI){
        if ([model isKindOfClass:[TDD_ArtiPopupModel class]]) {
            btnArr = @[@(kVCIStatusBtn), @(kServiceBtn),@(kHelpBtn)];
        }
        else if ([model isKindOfClass: [TDD_ArtiSystemModel class]] || [model isKindOfClass:[TDD_ArtiTroubleModel class]]) {
            btnArr = @[@(kVCIStatusBtn), @(kServiceBtn)];
        }
        else if ([model isKindOfClass: [TDD_ArtiLiveDataSetModel class]]) {
            btnArr = @[];
        } else {
            btnArr = @[@(kVCIStatusBtn)];
        }
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
    } else if ([model isKindOfClass:[TDD_ArtiMenuModel class]]) {
        
        btnArr = @[@(kVCIStatusBtn), @(kFeedBackBtn), @(kTranslateBtn), @(kSearchBtn)];
        if (self.diagNavType == TDD_DiagNavType_IMMO && self.diagNavType != TDD_DiagNavType_TDarts) {
            btnArr = @[@(kVCIStatusBtn), @(kIMMOTDartsStatusBtn), @(kFeedBackBtn), @(kTranslateBtn), @(kSearchBtn)];
        }
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
        //翻译按钮状态
        if (model.isShowTranslated && model.translateSucc) {
            [self.moreBtnView showTranslateFinish:YES];
            
        }else {
            if (model.isTranslating) {
                [self.moreBtnView showTranslateAnimate:true];
            }else {
                [self.moreBtnView showTranslateFinish:NO];
            }
            
        }
        
    } else if ([model isKindOfClass:[TDD_ArtiLiveDataSelectModel class]] ||
               [model isKindOfClass:[TDD_ArtiLiveDataModel class]]) {
        btnArr = @[@(kVCIStatusBtn), @(kFeedBackBtn), @(kSearchBtn)];
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
    } else if ([model isKindOfClass:[TDD_ArtiEcuInfoModel class]] || [model isKindOfClass:[TDD_ArtiFreezeModel class]] || [model isKindOfClass:[TDD_ArtiInputModel class]] || [model isKindOfClass:[TDD_ArtiMsgBoxModel class]] || [model isKindOfClass:[TDD_ArtiPictureModel class]] || [model isKindOfClass:[TDD_ArtiTroubleModel class]] || [model isKindOfClass:[TDD_ArtiSystemModel class]] || [model isKindOfClass:[TDD_ArtiMsgBoxGroupModel class]] || [model isKindOfClass:[TDD_ArtiMsgBoxDsModel class]] || [model isKindOfClass:[TDD_ArtiWheelBrowModel class]] || [model isKindOfClass:[TDD_ArtiFuelLevelModel class]]) {
        if ([[self.carModel.strVehicle uppercaseString] isEqualToString:@"AUTOVIN"]){
            btnArr = @[@(kVCIStatusBtn)];
            if (self.diagNavType == TDD_DiagNavType_IMMO && self.diagNavType != TDD_DiagNavType_TDarts) {
                btnArr = @[@(kVCIStatusBtn), @(kIMMOTDartsStatusBtn)];
            }
        } else {
            btnArr = @[@(kVCIStatusBtn), @(kFeedBackBtn), @(kTranslateBtn)];
            if (self.diagNavType == TDD_DiagNavType_IMMO && self.diagNavType != TDD_DiagNavType_TDarts) {
                btnArr = @[@(kVCIStatusBtn), @(kIMMOTDartsStatusBtn), @(kFeedBackBtn), @(kTranslateBtn)];
            }
        }
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
        //翻译按钮状态
        if (model.isShowTranslated && model.translateSucc) {
            [self.rightButtonView showTranslateFinish:YES];
            
        }else {
            if (model.isTranslating) {
                [self.rightButtonView showTranslateAnimate:true];

            }else {
                [self.rightButtonView showTranslateFinish:NO];
            }
            
        }
    } else if ([model isKindOfClass:[TDD_FCAAuthModel class]]) {
        btnArr = @[@(kVCIStatusBtn), @(kFeedBackBtn)];
        if (self.diagNavType == TDD_DiagNavType_IMMO && self.diagNavType != TDD_DiagNavType_TDarts) {
            btnArr = @[@(kVCIStatusBtn), @(kIMMOTDartsStatusBtn)];
        }
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
    } else if ([model isKindOfClass:[TDD_ArtiPopupModel class]] || [model isKindOfClass:[TDD_ArtiTroubleModel class]]) {
        btnArr = @[@(kVCIStatusBtn),@(kHelpBtn), @(kFeedBackBtn),@(kTranslateBtn)];
        if (self.diagNavType == TDD_DiagShowType_IMMO) {
            btnArr = @[@(kVCIStatusBtn),@(kHelpBtn),  @(kIMMOTDartsStatusBtn), @(kFeedBackBtn)];
        }
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
    }  else if([model isKindOfClass:[TDD_ArtiLiveDataSetModel class]]){
        btnArr = @[];

        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
    }
    else {
        btnArr = @[@(kVCIStatusBtn), @(kFeedBackBtn)];
        if (self.diagNavType == TDD_DiagNavType_IMMO && self.diagNavType != TDD_DiagNavType_TDarts) {
            btnArr = @[@(kVCIStatusBtn), @(kIMMOTDartsStatusBtn), @(kFeedBackBtn)];
        }
        [self.rightButtonView updateShowBtn:btnArr isSearch:model.isSearch];
    }
}

- (void)showBackButton {
    [self.naviView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.naviView.backBtn);
        make.left.equalTo(self.naviView.backBtn.mas_right).offset(12);
        make.right.equalTo(self.rightButtonView.mas_left).offset(-10);
        make.height.mas_equalTo(40);
    }];
    self.naviView.titleLabel.userInteractionEnabled = YES;
    [super showBackButton];
}

- (void)hiddenBackButton {
    [self.naviView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.naviView.backBtn);
        make.left.equalTo(self.naviView).offset(15 * _scale);
        make.right.equalTo(self.rightButtonView.mas_left).offset(-10 * _scale);
        make.height.mas_equalTo(40 * _scale);
    }];
    self.naviView.titleLabel.userInteractionEnabled = NO;
    [super hiddenBackButton];
}

#pragma mark - content代理 - 刷新UI
- (void)ArtiContentViewDelegateReloadData:(TDD_ArtiModelBase *)model
{
    if ([model isKindOfClass:[TDD_ArtiLiveDataModel class]] || [model isKindOfClass:[TDD_FCAAuthModel class]]) {
        self.buttonView.model = model;
    }
}

#pragma mark 通过类获取UI
- (TDD_ArtiContentBaseView *)getUIWithClass:(Class)ocClass{
    
    NSString * classStr = NSStringFromClass(ocClass);
    
    TDD_ArtiContentBaseView * view;
    
    if ([self.UIDic.allKeys containsObject:classStr]) {
        view = self.UIDic[classStr];
    }else{
        view = [[ocClass alloc] init];
        self.UIDic[classStr] = view;
    }
    
    return view;
}

#pragma mark 删除中间UI
- (void)removeContentUIWithClass:(UIView *)view
{
    NSString * classStr = NSStringFromClass(view.class);
    
    if ([self.UIDic.allKeys containsObject:classStr]) {
        [self.UIDic removeObjectForKey:classStr];
    }
    
    view = nil;
}

#pragma mark 底部按钮点击回调
- (void)ArtiButtonClick:(TDD_ArtiButtonModel *)model
{
    NSLog(@"按钮点击：%u", model.uButtonId);
    //记录最后一次点击的按钮，用于确认 returnID 是否有效
    self.model.lastClickButtonModel = model;
    
    if ([self.model isKindOfClass:[TDD_ArtiLiveDataModel class]]) {
        if (model.uButtonId == DF_ID_REPORT) {
            // 报告
            TDD_ArtiLiveDataModel *liveDataModel = (TDD_ArtiLiveDataModel *)self.model;
            self.liveDataShowArray = liveDataModel.showItems;
        } else if (model.uButtonId == 0) {
            // 编辑
            [self.naviView updateSearckKey:@""];
        }
    }
    if ([self.model isKindOfClass:[TDD_ArtiLiveDataSelectModel class]] && model.uButtonId == 1) {
        [self.naviView updateSearckKey:@""];
    }
    
    if (isKindOfTopVCI && [self.model isKindOfClass:[TDD_ArtiSystemModel class]] && model.uButtonId == DF_ID_SYS_ERASE) {
        @kWeakObj(self)
        
        LMSAlertAction *actionSure = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.diagnosis_clear_fault_code titleColor:LMSAlertAction.confirmAction.titleColor backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull) {
            @kStrongObj(self)
            BOOL isBlack = [self.model ArtiButtonClick:model.uButtonId];

            if (isBlack && self.model.isLock) {
                
                self.model.returnID = model.uButtonId;
                
                [self.model conditionSignal];
            }
        }] ;
        
        LMSAlertController *alert = [LMSAlertController showWithTitle:TDDLocalized.diagnosis_clear_fault_code content:TDDLocalized.diagnosis_clear_fault_code_tips image:nil priority:1002 actions:@[LMSAlertAction.cancelAction,actionSure]];
        alert.messageLabel.textAlignment = NSTextAlignmentLeft;

        return;
    }
    
    /// 展示分享
    if ([self.model isKindOfClass:[TDD_ArtiListModel class]] && model.uButtonId == [@(DF_ID_SHARE) intValue]) {
        TDD_ArtiListModel *model = (TDD_ArtiListModel *)self.model;
        if (![NSString tdd_isEmpty:model.strShareTitle] || ![NSString tdd_isEmpty:model.strShareContent]) {
            [TDD_HTipManage showSharePopView:model];
        }
    }
    
    /// 跳转到扫描页
    if ([self.model isKindOfClass:[TDD_ArtiInputModel class]] && model.uButtonId == [@(DF_ID_QR) intValue]) {
        TDD_ArtiInputModel *inputModel = (TDD_ArtiInputModel *)self.model;
        @kWeakObj(self)
        if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalEvent:param:)]) {
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_GoToScan param:@{} completeHandle:^(id  _Nonnull result) {
                @kStrongObj(self)
                NSString *token = result;
                ArtiInputItemModel *itemModel = inputModel.itemArr.firstObject;
                itemModel.strText = [itemModel filterTextMatch:token];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiInputModelChange object:itemModel userInfo:nil];
                });

            }];
        }
    }
    
    BOOL isBlack = [self.model ArtiButtonClick:model.uButtonId];

    if (isBlack && self.model.isLock) {
        
        self.model.returnID = model.uButtonId;
        
        [self.model conditionSignal];
    }
}

/// 横屏曲线图形底部按钮
- (void)landscapeLiveButtonClick:(TDD_ArtiButtonModel *)model {
    [self ArtiButtonClick:model];
}

#pragma mark 点击退出按钮
- (void)backClick{
    
    HLog(@"点击返回按钮");
    
    // 页面是搜索状态返回先隐藏搜索框
    if (self.model.isSearch) {
        self.model.isSearch = NO;
        [self.naviView updateSearckKey:@""];
        self.model.searchKey = @"";
        [self searchKeyChanged:@""];
        [self.view endEditing:YES];
        // 显示搜索按钮
        [self resetRightButtonView:self.model];
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self.model userInfo:nil];
        return;
    }
    
    if ([self.model isKindOfClass:[TDD_ArtiLiveDataSetModel class]]) {
        TDD_ArtiContentBaseView *view = [self getUIWithClass:[TDD_ArtiLiveDataSetView class]];
        
        if ([(TDD_ArtiLiveDataSetView *)view checkNeedSavaLiveData]) {
            [LMSAlertController showDefaultWithTitle:TDDLocalized.app_tip content:TDDLocalized.live_date_leave_tip priorityValue:1003 confirmAction:^(LMSAlertAction * _Nonnull action) {
                [self.model backClick];
            }];

        } else {
            [self.model backClick];
        }
    }else if ([self.model isKindOfClass:[TDD_ArtiLiveDataModel class]]){
        //数据流返回时车型可能会卡很久处理东西，处理完才会 show。增加 loading
        //http://172.16.50.96/zentao/bug-view-26790.html?tid=1t7a11g0
        [TDD_HTipManage showLoadingViewWithTag:26790];
        [self.model backClick];
    }else {
        [self.model backClick];
    }
   
}

- (void)hTipBtnViewTag:(int)viewTag didClickWithBtnTag:(int)btnTag
{
    if (viewTag == 1 && btnTag == 1) {
        self.model.returnID = DF_ID_BACK;
        
        if (self.model.isLock) {
            [self.model conditionSignal];
        }
    }
}

- (void)toBleConnect {
    [self.rightButtonView vciStatusBtnClick];
}

#pragma mark model代理
- (void)ArtiTroubleSetRepairManualInfo:(TDD_ArtiTroubleRepairInfoModle *)model
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(artiModelDelegate:eventType:param:diagVC:completeHandle:)]){
            [self.delegate artiModelDelegate:model eventType:TDD_ArtiModelEventType_SetRepairManual param:nil diagVC:self completeHandle:nil];
        }
    });
}

- (void)ArtiTroubleGotoAI:(TDD_ArtiTroubleModel *)model itemIndex:(NSInteger)itemIndex
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]) {
            TDD_ArtiTroubleItemModel *item;
            if (model.itemArr.count <= itemIndex) {
                HLog(@"ArtiTroubleGotoAI 数组越界")
                item = TDD_ArtiTroubleItemModel.new;
            }else {
                item = model.itemArr[itemIndex];
            }
            
            [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoAI model:model param:@{@"faultCode":item.strTroubleCode?:@"", @"componentLocation":item.strTroubleDesc?:@"",@"carBrandDetailName":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand?:@"",@"carYear":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear?:@"",@"carModelDetailName":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel?:@""} diagVC:self];
        }
    });
    
}

- (void)ArtiPopupGotoAI:(TDD_ArtiPopupModel *)model itemIndex:(NSInteger)itemIndex {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]) {
            TDD_ArtiPopupItemModel *item;
            if (model.items.count <= itemIndex) {
                HLog(@"ArtiTroubleGotoAI 数组越界")
                item = TDD_ArtiPopupItemModel.new;
            }else {
                item = model.items[itemIndex];
            }
            
            [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoAI model:model param:@{@"faultCode":item.code?:@"", @"componentLocation":item.content?:@"",@"carBrandDetailName":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand?:@"",@"carYear":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear?:@"",@"carModelDetailName":TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel?:@""} diagVC:self];
        }
    });
    
}

- (void)ArtiUploadDiagReport:(TDD_ArtiReportModel *)model param:(NSDictionary *)json completeHandle: (nullable void(^)(id result))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(artiModelDelegate:eventType:param:diagVC:completeHandle:)]){
            [self.delegate artiModelDelegate:model eventType:TDD_ArtiModelEventType_UploadDiagReport param:json diagVC:self completeHandle:complete];
        }
        
    });
}

- (void)ArtiPopupSetRepairManualInfo:(TDD_ArtiTroubleRepairInfoModle *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(artiModelDelegate:eventType:param:diagVC:completeHandle:)]){
            [self.delegate artiModelDelegate:model eventType:TDD_ArtiModelEventType_SetRepairManual param:nil diagVC:self completeHandle:nil];
        }
    });
    
}

- (void)ArtiPopupToTroubleDetail:(NSString *)troubleCode {
    NSLog(@"");
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]) {
            [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoTroubleDetail model:self.model param:@{@"troubleCode" : troubleCode} diagVC:self];
        }
    });
    
}

- (void)ArtiSystemSetAutoEnable:(TDD_ArtiButtonModel *)buttonModel {
    [self ArtiButtonClick:buttonModel];
}

- (void)ArtiGatewayGotoShop:(TDD_FCAAuthModel *)model param:(NSDictionary *)json {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]) {
            [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoShop model:self.model param:json diagVC:self];
        }
    });
}

- (void)ArtiFatewayGotoWebView:(TDD_FCAAuthModel *)model param:(nonnull NSDictionary *)json {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]) {
            [self.delegate handleOtherEvent:TDD_DiagOtherEventType_GotoWeb model:model param:json diagVC:self];
        }
    });
}

#pragma mark globalModel代理
- (void)ArtiGlobalNetwork:(TDD_ArtiModelEventType)eventType param:(NSDictionary *)json completeHandle:(void (^)(id _Nonnull))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(artiModelDelegate:eventType:param:diagVC:completeHandle:)]){
            [self.delegate artiModelDelegate:TDD_ArtiGlobalModel.sharedArtiGlobalModel eventType:eventType param:json diagVC:self completeHandle:complete];
        }
        
    });
}

- (void)ArtiGlobalEvent:(TDD_DiagOtherEventType )eventType param:(NSDictionary *)json {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(handleOtherEvent:model:param:diagVC:)]){
            [self.delegate handleOtherEvent:eventType model:TDD_ArtiGlobalModel.sharedArtiGlobalModel param:json diagVC:self];
        }
    });
}

#pragma mark 禁止右滑返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
                                      *)gestureRecognizer{
    //YES：允许右滑返回  NO：禁止右滑返回
    return NO;
}

#pragma mark 退出诊断
- (void)artiDiagExit{
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (![self.carModel.strVehicle.uppercaseString isEqualToString:@"ACCSPEED"]&&![self.carModel.strVehicle.uppercaseString isEqualToString:@"IM_PRECHECK"]) {
//            [self.audio play];
//        }
        
        if (([TDD_EADSessionController sharedController].VciStatus && ![[self.carModel.strVehicle uppercaseString] isEqualToString:@"AUTOVIN"] && self.diagNavType != TDD_DiagNavType_TDarts)) {
            //TopScan 跳车不提示
            if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].isCurVehNotSupport && [TDD_DiagnosisTools softWareIsKindOfTopScan]) {
                return;
            }
            if (!isKindOfTopVCI) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSString *title = [NSString stringWithFormat:@"%@\n\n%@", TDDLocalized.remind, TDDLocalized.diagnose_exit_remind];
                    [TDD_HTipManage showBtnTipViewWithTitle:title buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
                        
                    }];
                });
                [self.audio play];
            }
            
        }
    });
}

- (void)artiDiagStopSound {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *voice = [bundle URLForResource:[NSString stringWithFormat:@"TopdonDiagnosis.bundle/%@",kSoundArtiStop] withExtension:nil];
    self.audio = [[AVAudioPlayer alloc] initWithContentsOfURL:voice error:nil];
    self.audio.volume = 1;
    self.audio.numberOfLoops = 0;
    [self.audio prepareToPlay];
    
}

- (void)enterForeGround:(NSNotification *)notif
{

    [TDD_DiagnosisManage writeLogToVehicle:@"[AppLog] 应用处于前台"];
    
    //进入后台前时 VCI 是已连接并且回到后台时是未连接
    HLog(@"进入前台时，VCI 连接状态:%d - TDarts 连接状态:%d",[TDD_EADSessionController sharedController].VciStatus,[TDD_TDartsManage sharedManage].TProgStatus);
    if ([TDD_ArtiGlobalModel sharedArtiGlobalModel].diagShowType == TDD_DiagShowType_TDarts) {
        if (![TDD_TDartsManage sharedManage].TProgStatus 
            && [TDD_EADSessionController sharedController].isArtiDiag
            && _enterBackgroundTDartsStatus
            && ![[self.carModel.strVehicle uppercaseString] isEqualToString:@"AUTOVIN"]) {
            [TDD_DiagnosisTools showBackgroundAlert];
            
        }
    }else {
        if ((![TDD_EADSessionController sharedController].VciStatus || [TDD_EADSessionController sharedController].BatteryVolt <= 0) 
            && [TDD_EADSessionController sharedController].isArtiDiag
            && _enterBackgroundVCIStatus
            && ![[self.carModel.strVehicle uppercaseString] isEqualToString:@"AUTOVIN"]) {
            [TDD_DiagnosisTools showBackgroundAlert];
            
        }
    }

}

- (void)enterBackGround:(NSNotification *)notif
{
    _enterBackgroundVCIStatus = [TDD_EADSessionController sharedController].VciStatus;
    _enterBackgroundTDartsStatus = [TDD_TDartsManage sharedManage].TProgStatus;
    HLog(@"进入后台时，VCI 连接状态:%d - TDarts 连接状态:%d",_enterBackgroundVCIStatus,_enterBackgroundTDartsStatus);
    [TDD_DiagnosisManage writeLogToVehicle:@"[AppLog] 应用处于后台"];
    
}

- (NSMutableDictionary *)UIDic{
    if (!_UIDic) {
        _UIDic = [[NSMutableDictionary alloc] init];
    }
    return _UIDic;
}


- (TDD_NaviMoreBtnView *)moreBtnView {
    if (!_moreBtnView) {
        _moreBtnView = [[TDD_NaviMoreBtnView alloc] init];
        _moreBtnView.delegate = self;
    }
    return _moreBtnView;
}

- (TDD_VciUnConnectTipView *)topView {
    if (!_topView) {
        _topView = [[TDD_VciUnConnectTipView alloc] init];
        _topView.hidden = YES;
        @kWeakObj(self)
        _topView.clickTap = ^{
            @kStrongObj(self)
            [self toBleConnect];
        };

    }
    return _topView;
}

- (TDD_LandscapeLiveButtonView *)landscapeLiveButtonView {
    if (!_landscapeLiveButtonView) {
        _landscapeLiveButtonView = [[TDD_LandscapeLiveButtonView alloc] init];
        _landscapeLiveButtonView.delegate = self;
        _landscapeLiveButtonView.hidden = YES;
    }
    return _landscapeLiveButtonView;
}

@end
