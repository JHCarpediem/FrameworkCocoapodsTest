//
//  TDD_ArtiGatewayRightsView.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/11/1.
//

#import "TDD_ArtiGatewayRightsView.h"
#import "TDD_ArtiGlobalModel.h"
#import "TDD_LoadingView.h"
@import TDUIProvider;
@interface TDD_ArtiGatewayRightsView()
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *topBGView;
@property (nonatomic, strong)TDD_CustomLabel *snLabel;
@property (nonatomic, strong)TDD_CustomLabel *snExpireLabel;
@property (nonatomic, strong)UIButton *expireRefreshButton;
@property (nonatomic, strong)UIButton *renewButton;
@property (nonatomic, strong)TDD_LoadingView *expireLoadingView;

@property (nonatomic, strong)UIView *accountBGView;
@property (nonatomic, strong)TDD_CustomLabel *accountLabel;
@property (nonatomic, strong)TDD_CustomLabel *countPreLabel;
@property (nonatomic, strong)TDD_CustomLabel *countLabel;
@property (nonatomic, strong)TDD_CustomLabel *expireLabel;
@property (nonatomic, strong)UIButton *changeAccountBtn;
@property (nonatomic, strong)TDD_LoadingView *loadingView;

@property (nonatomic, strong)UIView *buyBGView;
@property (nonatomic, strong)TDD_CustomLabel *buyLabel;
@property (nonatomic, strong)TDD_CustomLabel *noteContentLabel;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat preFontSize;
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)CGFloat topSpaceViewHeight;
@property (nonatomic, assign)CGFloat textTopSpaceMoreHeight;
@property (nonatomic, assign)CGFloat textLeftMoreSpace;
@end
@implementation TDD_ArtiGatewayRightsView

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vciStatusDidChange) name:KTDDNotificationVciStatusDidChange object:nil];
        [self createUI];
    }
    return self;
}

- (void)viewDidAppear {
    if (_buyBGView) {
        //德国定制隐藏购买入口
        _buyBGView.hidden = ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany  || [TDD_DiagnosisTools softWareIsTopVCIPro]);
        [_buyBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_buyBGView.hidden ? 0 : (IS_IPad ? 112 : 84));
        }];
    }
    if (![TDD_DiagnosisTools userIsLogin]) {
        return;
    }
    NSString *typeStr = @"";
    if (_fcaModel.unlockType > 0) {
        typeStr = [NSString stringWithFormat:@"%u_%ld",_fcaModel.uType,_fcaModel.unlockType];
    }else {
        typeStr = [NSString tdd_strFromInterger:_fcaModel.uType];
    }
    NSString *accountStr = [TDD_ArtiGlobalModel sharedArtiGlobalModel].authChangeAccount;
    if ([NSString tdd_isEmpty:accountStr]) {
        accountStr = [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict valueForKey:typeStr];
    }
    if ([NSString tdd_isEmpty:accountStr]) {
        if (![[TDD_DiagnosisTools userAccount] isEqualToString:self.accountLabel.text]) {
            self.accountLabel.text = [TDD_DiagnosisTools userAccount];
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:self.accountLabel.text?:@"" forKey:typeStr];
        }
    }else {
        self.accountLabel.text = accountStr;
    }
    
    [self requestData];

}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow: newWindow];
    
    if (newWindow) {
        [TDD_LoadingView setBallWidth:IS_IPad ? 6 * _scale : 5 * _scale];
    } else {
        [TDD_LoadingView resetStatic];
    }
}


/// 请求用户权益次数接口
/// - Parameters:
///   - accountStr: 用户账号
///   - needSuccess: 需要请求成功才修改次数
///   - complete: 完成回调
- (void)requestRightsCount:(NSString *)accountStr needSuccess:(BOOL )needSuccess complete:(nullable void(^)(BOOL success,NSString *errCode,NSString *errMsg))complete {
    @kWeakObj(self);
    _loadingView.hidden = NO;
    _countLabel.hidden = YES;
    _expireLabel.hidden = YES;
    [_fcaModel requestSGWRight:accountStr complete:^(id  _Nonnull result) {
        @kStrongObj(self)
        NSArray *dataArr = result[@"data"];
        NSNumber *success = result[@"success"];
        NSString *msg = result[@"msg"];
        if (dataArr.count > 0) {
            self.fcaModel.equityModel = dataArr.firstObject;
        }
        NSNumber *code = result[@"code"];
        
        if (complete) {
            NSString *errorStr = @"";
            NSString *errorCode = @"";
            if (!success.boolValue) {
                if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
                    errorCode = @"-1";
                    [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.network_is_abnormal_check_the_network];
                }else if (code.integerValue == -1001) {
                    errorCode = @"-1001";
                    [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.http_time_out];
                }else if (code.integerValue == 13121) {
                    errorCode = @"13121";
                    errorStr = msg;
                }else if(code) {
                    errorCode = [NSString stringWithFormat:@"%@",code];
                    NSString *errStr = [TDD_DiagnosisTools errorMessageWithCode:code.integerValue];
                    if (![NSString tdd_isEmpty:errStr]) {
                        [TDD_HTipManage showBottomTipViewWithTitle:errStr];
                    }

                    
                }
            }

            complete(success.boolValue,errorCode,errorStr);
        }
        [self reloadUI];
    }];
}

- (void)requestSNInfo {
    @kWeakObj(self);
    [self setSNExpirStatus:4 expireStr:nil];
    [_fcaModel requestSoftExpire:^(id  _Nonnull result) {
        @kStrongObj(self);
        NSDictionary *dataDict = result[@"data"];
        NSNumber *success = result[@"success"];
        NSString *msg = result[@"msg"];
        NSString *effectiveTime = [NSString stringWithFormat:@"%@",dataDict[@"effectiveTime"]];
        NSNumber *code = result[@"code"];
        NSNumber *isEffect = dataDict[@"isEffective"];
        if ([TDD_EADSessionController sharedController].VciStatus) {
            if ([NSString tdd_isEmpty:effectiveTime] || effectiveTime.integerValue <= 0) {
                [self setSNExpirStatus:2 expireStr:TDDLocalized.get_faild];
            }else {
                NSString *expireStr = [NSDate tdd_getTimeStringWithInterval:effectiveTime.integerValue Format:@"yyyy-MM-dd HH:mm:ss"];
                if (isEffect.boolValue) {
                    [self setSNExpirStatus:0 expireStr:expireStr];
                }else {
                    [self setSNExpirStatus:1 expireStr:expireStr];
                }
            }
        }else {
            [self setSNExpirStatus:3 expireStr:@"--"];
        }

        if (!success.boolValue) {
            if ([TDD_DiagnosisManage sharedManage].netState <= 0) {
                [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.network_is_abnormal_check_the_network];
            }else if (code.integerValue == -1001) {
                [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.http_time_out];
            }else if(code){
                NSString *errStr = [TDD_DiagnosisTools errorMessageWithCode:code.integerValue];
                if (![NSString tdd_isEmpty:errStr]) {
                    [TDD_HTipManage showBottomTipViewWithTitle:errStr];
                }
                
            }
        }
            
    }];
}

- (void)createUI {
    _scale = IS_IPad ? HD_Height : H_Height;
    _preFontSize = IS_IPad ? 18 : 14;
    _fontSize =  IS_IPad ? 20 : 16;
    _topSpaceViewHeight = (IS_IPad ? 12 : 10) * _scale;
    _textTopSpaceMoreHeight = (IS_IPad ? 4 : 0) * _scale;
    _textLeftMoreSpace = (IS_IPad ? 20 : 0) * _scale;
    
    self.backgroundColor = [UIColor tdd_viewControllerBackground];
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [self createTopView];
    
    if ([TDD_DiagnosisTools isAutoAuthNa] < 1) {
        [self createMidView];
    }

    [self createBottomView];
  
}

- (void)createTopView {
    UIView *topSpaceView = [UIView new];
    topSpaceView.backgroundColor = [UIColor tdd_liveDataSetBackground];
    [self.scrollView addSubview:topSpaceView];
    
    UIView *topBGView = [UIView new];
    topBGView.backgroundColor = [UIColor tdd_liveDataCellBackground];
    [self.scrollView addSubview:topBGView];
    self.topBGView = topBGView;
    
    //顶部信息 view
    //SN
    TDD_CustomLabel *snPreLabel = [TDD_CustomLabel new];
    snPreLabel.textColor = [UIColor tdd_color666666];
    snPreLabel.font = [[UIFont systemFontOfSize:_preFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    snPreLabel.text = [NSString stringWithFormat:@"%@: ",TDDLocalized.current_connect_sn];
    [topBGView addSubview:snPreLabel];
    
    [topBGView addSubview:self.snLabel];
    
    UIView *snMidLineView = [UIView new];
    snMidLineView.backgroundColor = [UIColor tdd_line];
    [topBGView addSubview:snMidLineView];
    
    TDD_CustomLabel *expirePreLabel = [TDD_CustomLabel new];
    expirePreLabel.textColor = [UIColor tdd_color666666];
    expirePreLabel.font = [[UIFont systemFontOfSize:_preFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    expirePreLabel.text = [NSString stringWithFormat:@"%@: ",TDDLocalized.software_period_of_validity];
    [topBGView addSubview:expirePreLabel];
    [topBGView addSubview:self.snExpireLabel];
    [topBGView addSubview:self.expireLoadingView];
    [topBGView addSubview:self.renewButton];
    [topBGView addSubview:self.expireRefreshButton];
    
    UIView *snSpaceView = [UIView new];
    snSpaceView.backgroundColor = [UIColor tdd_liveDataSetBackground];
    [topBGView addSubview:snSpaceView];
    
    [topSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scrollView);
        make.width.mas_equalTo(IphoneWidth);
        make.height.mas_equalTo(_topSpaceViewHeight);
    }];
    
    [topBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topSpaceView.mas_bottom);
        make.width.mas_equalTo(IphoneWidth);
    }];
    
    [snPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBGView).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(topBGView).offset(-20 * _scale - _textLeftMoreSpace);
    }];
    
    [self.snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.top.equalTo(snPreLabel.mas_bottom).offset(8 * _scale + _textTopSpaceMoreHeight);
        make.right.lessThanOrEqualTo(topBGView).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [snMidLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.equalTo(topBGView).offset(-(20 * _scale + _textLeftMoreSpace));
        make.top.equalTo(self.snLabel.mas_bottom).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.height.mas_equalTo(1);
    }];
    
    [expirePreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snMidLineView.mas_bottom).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(topBGView).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.snExpireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expirePreLabel.mas_bottom).offset(8 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(topBGView).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.expireLoadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expirePreLabel.mas_bottom).offset(8 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.size.mas_equalTo(IS_IPad ? CGSizeMake(40 * _scale, 40 * _scale) : CGSizeMake(20 * _scale, 20 * _scale));
    }];
    
    [self.renewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((IS_IPad ? 140 * _scale : 100 * _scale), (IS_IPad ? 38 * _scale : 28 * _scale)));
        make.top.equalTo(expirePreLabel.mas_bottom).offset(IS_IPad ? 7 * _scale : 3.5 * _scale);
        make.right.equalTo(topBGView.mas_right).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.expireRefreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(IS_IPad ? 33 * _scale : 22 * _scale, IS_IPad ? 24 * _scale : 16 * _scale));
        make.left.equalTo(self.snExpireLabel.mas_right).offset(IS_IPad ? 12 * _scale : 6 * _scale);
        make.centerY.equalTo(self.snExpireLabel);
    }];
    
    [snSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(IphoneWidth);
        make.top.equalTo(self.snExpireLabel.mas_bottom).offset(IS_IPad ? 25 * _scale : 15 * _scale);
        make.height.mas_equalTo(_topSpaceViewHeight);
        make.bottom.equalTo(topBGView.mas_bottom);

    }];
}

- (void)createMidView {
    //账号次数
    UIView *accountBGView = [UIView new];
    accountBGView.backgroundColor = [UIColor tdd_liveDataCellBackground];
    [self.scrollView addSubview:accountBGView];
    self.accountBGView = accountBGView;
    
    TDD_CustomLabel *accountPreLabel = [[TDD_CustomLabel alloc] init];
    accountPreLabel.textColor = [UIColor tdd_color666666];
    accountPreLabel.font = [[UIFont systemFontOfSize:_preFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    accountPreLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
    accountPreLabel.text = TDDLocalized.fca_current_account_number;
    [accountBGView addSubview:accountPreLabel];
    [accountBGView addSubview:self.accountLabel];
    [accountBGView addSubview:self.changeAccountBtn];
    
    UIView *topBGMidLineView = [UIView new];
    topBGMidLineView.backgroundColor = [UIColor tdd_line];
    [accountBGView addSubview:topBGMidLineView];
    
    TDD_CustomLabel *countPreLabel = [TDD_CustomLabel new];
    countPreLabel.textColor = [UIColor tdd_color666666];
    countPreLabel.font = [[UIFont systemFontOfSize:_preFontSize weight:UIFontWeightRegular] tdd_adaptHD];
    countPreLabel.text = [NSString stringWithFormat:@"%@: ",TDDLocalized.permission_status];
    [accountBGView addSubview:countPreLabel];
    self.countPreLabel = countPreLabel;
    
    [accountBGView addSubview:self.loadingView];
    [accountBGView addSubview:self.countLabel];
    [accountBGView addSubview:self.expireLabel];
    
    UIView *midSpaceView = [UIView new];
    midSpaceView.backgroundColor = [UIColor tdd_liveDataSetBackground];
    [accountBGView addSubview:midSpaceView];
    
    [accountBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBGView.mas_bottom);
        make.left.right.equalTo(self.topBGView);
    }];
    
    [accountPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountBGView).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(accountBGView).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.top.equalTo(accountPreLabel.mas_bottom).offset(8 * _scale + _textTopSpaceMoreHeight);
        make.right.lessThanOrEqualTo(self.changeAccountBtn.mas_left).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.changeAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(IS_IPad ? 36 * _scale : 22 * _scale, IS_IPad ? 25 * _scale : 16 * _scale));
        make.centerY.equalTo(self.accountLabel);
        make.right.equalTo(accountBGView.mas_right).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [topBGMidLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.centerX.equalTo(accountBGView);
        make.top.equalTo(self.accountLabel.mas_bottom).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.height.mas_equalTo(1);
    }];
    
    [countPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBGMidLineView.mas_bottom).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(accountBGView).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countPreLabel.mas_bottom).offset(6 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(accountBGView).offset(-(20 * _scale + _textLeftMoreSpace));
        
    }];
    
    [self.expireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.mas_bottom).offset(6 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(accountBGView).offset(-(20 * _scale + _textLeftMoreSpace));
    }];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countPreLabel.mas_bottom).offset(8 * _scale + _textTopSpaceMoreHeight);
        //make.bottom.equalTo(topBGView.mas_bottom).offset(-(20 * _scale + textTopSpaceMoreHeight));
        make.left.equalTo(accountBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.size.mas_equalTo(IS_IPad ? CGSizeMake(40 * _scale, 40 * _scale) : CGSizeMake(20 * _scale, 20 * _scale));
    }];
    
    ///分割
    [midSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(IphoneWidth);
        make.top.equalTo(self.expireLabel.mas_bottom).offset((16 * _scale + _textTopSpaceMoreHeight));
        make.height.mas_equalTo(_topSpaceViewHeight);
        make.bottom.equalTo(accountBGView.mas_bottom);
    }];
}

- (void)createBottomView {
    
    //底部
    UIView *bottomBGView = [UIView new];
    bottomBGView.backgroundColor = [UIColor tdd_liveDataCellBackground];
    [self.scrollView addSubview:bottomBGView];
    
    UIView *buyBGView = [UIView new];
    buyBGView.backgroundColor = [UIColor clearColor];
    buyBGView.layer.cornerRadius = 1;
    buyBGView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    buyBGView.layer.shadowRadius = 5;
    buyBGView.layer.shadowOpacity = 8;
    buyBGView.layer.shadowOffset = CGSizeMake(4, 4);
    self.buyBGView = buyBGView;
    [bottomBGView addSubview:buyBGView];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    
    [buyBtn setBackgroundImage:IS_IPad ? kImageNamed(@"diag_gateway_purchase_bg_hd") : [UIImage tdd_imageDiageGateWayToBuyImage] forState:UIControlStateNormal];
    [buyBGView addSubview:buyBtn];
    
    TDD_CustomLabel *buyLabel = [TDD_CustomLabel new];

    buyLabel.textColor = [UIColor tdd_colorDiagTheme];
    buyLabel.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightMedium] tdd_adaptHD];
    buyLabel.numberOfLines = 0;
    buyLabel.userInteractionEnabled = NO;
    _buyLabel = buyLabel;
    [buyBGView addSubview:buyLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage tdd_imageDiageGateWayToBuyArrow]];
    arrowImageView.userInteractionEnabled = NO;
    [buyBGView addSubview:arrowImageView];
    
    //德国定制隐藏购买入口
    _buyBGView.hidden = ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany  || [TDD_DiagnosisTools softWareIsTopVCIPro]);
    [_buyBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_buyBGView.hidden ? 0  : (IS_IPad ? 112 : 84) * _scale);
    }];
    
    UIView *noteSignView = [UIView new];
    noteSignView.backgroundColor = [UIColor tdd_colorDiagTheme];
    [bottomBGView addSubview:noteSignView];
    
    TDD_CustomLabel *noteLabel = [TDD_CustomLabel new];
    noteLabel.textColor = [UIColor tdd_title];
    noteLabel.font = [[UIFont systemFontOfSize:_preFontSize weight:UIFontWeightMedium] tdd_adaptHD];
    NSString *str = TDDLocalized.setting_notice;
    str = [str stringByReplacingOccurrencesOfString:@":" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"：" withString:@""];
    noteLabel.text = [NSString stringWithFormat:@"%@:",str];
    [bottomBGView addSubview:noteLabel];
    
    TDD_CustomLabel *noteContentLabel = [TDD_CustomLabel new];
    noteContentLabel.textColor = [UIColor tdd_color666666];
    noteContentLabel.numberOfLines = 0;
    noteContentLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 18 : 12 weight:UIFontWeightRegular] tdd_adaptHD];
    noteContentLabel.text = ([TDD_DiagnosisTools appProduct] == PD_NAME_DEEPSCAN) ? TDDLocalized.renault_gateway_hint_neutral : TDDLocalized.renault_gateway_hint;
    _noteContentLabel = noteContentLabel;
    [bottomBGView addSubview:noteContentLabel];
    
    ///底部
    [bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView);
        if ([TDD_DiagnosisTools isAutoAuthNa] == 1) {
            make.top.equalTo(self.topBGView.mas_bottom);
        }else {
            make.top.equalTo(self.accountBGView.mas_bottom);
        }
        
        make.width.mas_equalTo(IphoneWidth);
    }];
    
    [buyBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBGView).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(bottomBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.equalTo(bottomBGView).offset(-(20 * _scale + _textLeftMoreSpace));
        make.height.mas_equalTo(IS_IPad ? 112 * _scale : 84 * _scale);
        
    }];
    
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(buyBGView);
    }];
    
    [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyBtn);
        make.left.equalTo(buyBtn).offset(IS_IPad ? 40 * _scale : 16 * _scale);
        make.right.equalTo(arrowImageView.mas_left).offset(IS_IPad ? -24 * _scale : -10 * _scale);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(IS_IPad ? CGSizeMake(20 * _scale, 20 * _scale) : CGSizeMake(12 * _scale, 12 * _scale));
        make.centerY.equalTo(buyLabel);
        make.right.lessThanOrEqualTo(buyBtn).offset(IS_IPad ? -112 * _scale : -60 * _scale);
    }];
    
    [noteSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.top.equalTo(buyBGView.mas_bottom).offset(23 * _scale + _textTopSpaceMoreHeight);
        make.size.mas_equalTo(IS_IPad ? CGSizeMake(6 * _scale, 20 * _scale) : CGSizeMake(3 * _scale, 13 * _scale));
    }];
    
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyBGView.mas_bottom).offset(20 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(noteSignView.mas_right).offset(IS_IPad ? 16 * _scale : 8 * _scale);
        
    }];
    
    [noteContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.equalTo(bottomBGView).offset(-(20 * _scale + _textLeftMoreSpace));
        make.top.equalTo(noteLabel.mas_bottom).offset(IS_IPad ? 28 * _scale : 10 * _scale);
        make.bottom.lessThanOrEqualTo(bottomBGView).offset(IS_IPad ? -30 * _scale : -24 * _scale);
    }];
    
}

- (void)reloadUI {
    _loadingView.hidden = YES;

    if (!_fcaModel.equityModel) {
        //请求失败
        HLog(@"queryUserAllEquity 接口失败显示--");
        _expireLabel.textColor = [UIColor tdd_title];
        _expireLabel.text = @"--";
        _countLabel.hidden = YES;
    }else {
        if (_fcaModel.equityModel.chargeType == 1) {
            //按次数
            if (_fcaModel.equityModel.remainTimes > 0) {
                NSMutableAttributedString *countAttStr = [self rightAttStr:[NSString stringWithFormat:@"%@: ",TDDLocalized.count] valueStr:[NSString stringWithFormat:@"%ld",_fcaModel.equityModel.remainTimes]];
                _countLabel.attributedText = countAttStr;
                
                if (_fcaModel.equityModel.unlimitedDuration == 1) {
                    //时间不限时长
                    NSMutableAttributedString *expireAttStr = [self rightAttStr:[NSString stringWithFormat:@"%@: ",TDDLocalized.deadline] valueStr:TDDLocalized.unlimited];
                    _expireLabel.attributedText = expireAttStr;
                }else {
                    NSString *dateStr =  [NSDate tdd_getTimeStringWithInterval:_fcaModel.equityModel.expirationTime.longLongValue Format:@"yyyy-MM-dd"];
                    NSMutableAttributedString *expireAttStr = [self rightAttStr:[NSString stringWithFormat:@"%@: ",TDDLocalized.deadline] valueStr:_fcaModel.equityModel.expirationTime?dateStr:@""];
                    _expireLabel.attributedText = expireAttStr;
                }
                
                _countLabel.hidden = NO;
            }else {
                //次数小于等于 0
                HLog(@"queryUserAllEquity chargeType为 1、次数小于等于 0");
                _expireLabel.attributedText = [self unRightAttStr];
                _countLabel.hidden = YES;
            }
            
        }else if (_fcaModel.equityModel.chargeType == 2) {
            NSMutableAttributedString *countAttStr = [self rightAttStr:[NSString stringWithFormat:@"%@: ",TDDLocalized.count] valueStr:TDDLocalized.unlimited];
            _countLabel.attributedText = countAttStr;
            
            //按时间
            if (_fcaModel.equityModel.available == 1) {
                //时间有效
                if ([NSString tdd_isEmpty:_fcaModel.equityModel.expirationTime] || [_fcaModel.equityModel.expirationTime containsString:@"null"] || [_fcaModel.equityModel.expirationTime containsString:@"NULL"]) {
                    //时间为空
                    HLog(@"queryUserAllEquity chargeType为 2、 日期没有");
                    _expireLabel.attributedText = [self unRightAttStr];
                    _countLabel.hidden = YES;
                }else if (_fcaModel.equityModel.unlimitedDuration == 1) {
                    //时间不限时长
                    NSMutableAttributedString *expireAttStr = [self rightAttStr:[NSString stringWithFormat:@"%@: ",TDDLocalized.deadline] valueStr:TDDLocalized.unlimited];
                    _expireLabel.attributedText = expireAttStr;
                    _countLabel.hidden = NO;
                }else {
                    NSString *dateStr =  [NSDate tdd_getTimeStringWithInterval:_fcaModel.equityModel.expirationTime.longLongValue Format:@"yyyy-MM-dd"];
                    NSMutableAttributedString *expireAttStr = [self rightAttStr:[NSString stringWithFormat:@"%@: ",TDDLocalized.deadline] valueStr:_fcaModel.equityModel.expirationTime?dateStr:@""];
                    _expireLabel.attributedText = expireAttStr;
                    _countLabel.hidden = NO;
                }
                
            }else {
                //时间无效
                HLog(@"queryUserAllEquity chargeType为 2、 时间无效");
                _expireLabel.attributedText = [self unRightAttStr];
                _countLabel.hidden = YES;
                
            }

        }else {
            //其他类型诊断内暂不支持
            HLog(@"queryUserAllEquity chargeType不为 1/2 暂不支持");
            _expireLabel.textColor = [UIColor tdd_title];
            _expireLabel.text = @"--";
            _countLabel.hidden = YES;
        }
        
    }
    
    [_expireLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.hidden ? self.countPreLabel.mas_bottom : self.countLabel.mas_bottom).offset(6 * _scale + _textTopSpaceMoreHeight);
        make.left.equalTo(self.topBGView).offset(20 * _scale + _textLeftMoreSpace);
        make.right.lessThanOrEqualTo(self.topBGView).offset(-(20 * _scale + _textLeftMoreSpace));
//        make.bottom.equalTo(self.topBGView.mas_bottom).offset(-(16 * _scale + _textTopSpaceMoreHeight));
    }];
    _expireLabel.hidden = NO;

}

//权限状态的次数和截止日期的富文本
- (NSMutableAttributedString *)rightAttStr:(NSString *)preStr valueStr:(NSString *)valueStr {
    NSString *str = [NSString stringWithFormat:@"%@%@",preStr,valueStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange hlRange = NSMakeRange(preStr.length, str.length - preStr.length);
    [attStr setYy_font:kSystemFont(14)];
    [attStr setYy_color:[UIColor tdd_subTitle]];
    [attStr yy_setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] range:hlRange];
    [attStr yy_setColor:[UIColor tdd_title] range:hlRange];
    
    return attStr;
}

- (NSMutableAttributedString *)unRightAttStr {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:TDDLocalized.unlock_rights_zero];
    [attStr setYy_color:[TDD_DiagnosisTools softWareIsCarPalSeries] ? [UIColor tdd_title] : [UIColor td_error]];
    [attStr setYy_font:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
    return attStr;
    
}

- (void)buyAction {
    if (_fcaModel.uType == SST_FUNC_DEMO_AUTH) {
        [LMSAlertController showWithTitle:TDDLocalized.buy_tips content:TDDLocalized.demo_buy_tips image:nil priority:1002 actions:@[LMSAlertAction.confirmAction]];
        
    }else if ([_fcaModel.delegate respondsToSelector:@selector(ArtiGatewayGotoShop:param:)]) {
        NSNumber *mallType = @((NSInteger)_fcaModel.uType + 1);
        [_fcaModel.delegate ArtiGatewayGotoShop:_fcaModel param:@{@"mallType":mallType,@"unlockCount":@(_fcaModel.equityModel.remainTimes)}];
    }
}

- (void)vciStatusDidChange {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([TDD_EADSessionController sharedController].VciStatus) {
            self.snLabel.text = [TDD_EADSessionController sharedController].SN?:@"--";
            if (self.fcaModel.uType == SST_FUNC_DEMO_AUTH){
                [self requestData];
            }else {
                [self requestSNInfo];
            }

        }else {
            [self setSNExpirStatus:3 expireStr:@"--"];

        }
    });
}


/// 设置有效期时间状态
/// - Parameter expirStatus:  0:未过期、1:已过期、2:未获取到、3:sn 未连接、4:请求中
- (void)setSNExpirStatus:(NSInteger )expirStatus expireStr:(NSString *)expireStr{
    @kWeakObj(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @kStrongObj(self)
        switch (expirStatus) {
            case 0:
                {
                    self.snExpireLabel.text = expireStr;
                    self.snExpireLabel.textColor = [UIColor tdd_title];
                    self.snExpireLabel.hidden = false;
                    self.expireRefreshButton.hidden = YES;
                    self.renewButton.hidden = YES;
                    self.expireLoadingView.hidden = YES;
                    [self.fcaModel setNextBtnEnable:true];
                }
                break;
            case 1:
                {
                    self.snExpireLabel.text = expireStr;
                    self.snExpireLabel.textColor = [UIColor tdd_errorRed];
                    self.snExpireLabel.hidden = false;
                    self.expireRefreshButton.hidden = YES;
                    self.renewButton.hidden = NO;
                    self.expireLoadingView.hidden = YES;
                    [self.fcaModel setNextBtnEnable:false];
                }
                break;
            case 2:
                {
                    self.snExpireLabel.text = expireStr;
                    self.snExpireLabel.textColor = [UIColor tdd_errorRed];
                    self.snExpireLabel.hidden = false;
                    self.expireRefreshButton.hidden = NO;
                    self.renewButton.hidden = YES;
                    self.expireLoadingView.hidden = YES;
                    [self.fcaModel setNextBtnEnable:false];
                }
                break;
            case 3:
                {
                    self.snExpireLabel.text = expireStr;
                    self.snExpireLabel.textColor = [UIColor tdd_title];
                    self.snExpireLabel.hidden = false;
                    self.expireRefreshButton.hidden = YES;
                    self.renewButton.hidden = YES;
                    self.snLabel.text = @"--";
                    self.expireLoadingView.hidden = YES;
                    [self.fcaModel setNextBtnEnable:false];
                }
                break;
            case 4:
                {
                    self.expireLoadingView.hidden = NO;
                    self.snExpireLabel.hidden = YES;
                    self.expireRefreshButton.hidden = YES;
                    self.renewButton.hidden = YES;

                    [self.fcaModel setNextBtnEnable:false];
                }
                break;
                
            default:
                break;
        }
        if ([self.delegate respondsToSelector:@selector(ArtiContentViewDelegateReloadData:)]) {
            [self.delegate ArtiContentViewDelegateReloadData:self.fcaModel];
        }
    });

    
}

- (void)changeAccountAction {
    TDD_UpdateEquityAccountView *view = [[TDD_UpdateEquityAccountView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
    @kWeakObj(self);
    [view showInViewWithSuperView:FLT_APP_WINDOW account:_accountLabel.text updateAccount:^(NSString * _Nonnull account) {
        @kStrongObj(self);
        if (self.fcaModel.uType == SST_FUNC_DEMO_AUTH){
            //DEMO 不调接口
            NSString *year = [NSDate tdd_getTimeStringWithInterval:[NSDate tdd_getTimestampSince1970] Format:@"yyyy"];
            year = [NSString stringWithFormat:@"%ld",year.integerValue + 30];
            NSString *expireStr = [NSString stringWithFormat:@"%@-12-31 23:59:59",year];
            [self setSNExpirStatus:0 expireStr:expireStr];
            self.expireLabel.textColor = [UIColor tdd_title];
            self.expireLabel.text = TDDLocalized.unlimited;
            self.countLabel.hidden = YES;
            self.loadingView.hidden = YES;
            self.accountLabel.text = account;
            NSString *typeStr = @"";
            if (self.fcaModel.unlockType > 0) {
                typeStr = [NSString stringWithFormat:@"%u_%ld",self.fcaModel.uType,self.fcaModel.unlockType];
            }else {
                typeStr = [NSString tdd_strFromInterger:self.fcaModel.uType];
            }
            [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:account?:@"" forKey:typeStr];
            //切换账号成功缓存账号
            [TDD_ArtiGlobalModel sharedArtiGlobalModel].authChangeAccount = account?:@"";
            [view removeFromSuperview];
            return;
        }
        [self requestRightsCount:account needSuccess:YES complete:^(BOOL success, NSString *errCode, NSString *errMsg) {
            if (success) {
                [view removeFromSuperview];
                self.accountLabel.text = account;
                NSString *typeStr = @"";
                if (self.fcaModel.unlockType > 0) {
                    typeStr = [NSString stringWithFormat:@"%u_%ld",self.fcaModel.uType,self.fcaModel.unlockType];
                }else {
                    typeStr = [NSString tdd_strFromInterger:self.fcaModel.uType];
                }
                [[TDD_ArtiGlobalModel sharedArtiGlobalModel].authAccountDict setValue:account?:@"" forKey:typeStr];
                //切换账号成功缓存账号
                [TDD_ArtiGlobalModel sharedArtiGlobalModel].authChangeAccount = account?:@"";
            }else {
                if (![NSString tdd_isEmpty:errMsg]) {
                    if (errCode.integerValue == 13121) {
                        view.confirmBtn.enabled = false;
                    }
                    view.errorTipLabel.hidden = NO;
                    view.errorTipLabel.text = errMsg;
                    [view updateUIWithIsErrorTipLabelHidden:NO];
                }else {
                    [view updateUIWithIsErrorTipLabelHidden:YES];
                }
            }
        }];
        
    }];
    
}

- (void)renewAction {
    
    [self buyAction];
}

- (void)requestData {
    if (self.fcaModel.uType == SST_FUNC_DEMO_AUTH){
        NSString *year = [NSDate tdd_getTimeStringWithInterval:[NSDate tdd_getTimestampSince1970] Format:@"yyyy"];
        year = [NSString stringWithFormat:@"%ld",year.integerValue + 30];
        NSString *expireStr = [NSString stringWithFormat:@"%@-12-31 23:59:59",year];
        [self setSNExpirStatus:0 expireStr:expireStr];
        _expireLabel.textColor = [UIColor tdd_title];
        _expireLabel.text = TDDLocalized.unlimited;
        _countLabel.hidden = YES;
        _loadingView.hidden = YES;
    }else {
        if ([TDD_DiagnosisTools isAutoAuthNa] < 1) {
            [self requestRightsCount:nil needSuccess:NO complete:nil];
        }
        
        [self requestSNInfo];
    }
}

- (void)setFcaModel:(TDD_FCAAuthModel *)fcaModel {
    _fcaModel = fcaModel;
    [self requestData];

    self.accountLabel.text = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
    NSString *buyTips = _fcaModel.uType == SST_FUNC_NISSAN_AUTH ? TDDLocalized.gateway_purchase_nissan :TDDLocalized.unlock_rights_to_buy;
    [_buyLabel setText:buyTips];
    
    NSString *normalNoteStr = @"";
    switch (_fcaModel.uType) {
        case SST_FUNC_FCA_AUTH:
            normalNoteStr = isDeepScan ? TDDLocalized.fca_gateway_hint_deepscan : ([TDD_DiagnosisTools isAutoAuthNa] == 1) ? TDDLocalized.fca_north_america_gateway_hint : TDDLocalized.fca_other_gateway_hint;
            break;
        case SST_FUNC_RENAULT_AUTH:
            normalNoteStr = isDeepScan ? TDDLocalized.gateway_buy_tips_neutral_deepscan : TDDLocalized.gateway_buy_tips_neutral;
            break;
        case SST_FUNC_NISSAN_AUTH:
            normalNoteStr = isDeepScan ? TDDLocalized.renault_gateway_hint_new_nissan_deepscan : TDDLocalized.nissan_gateway_hint;
            break;
        case SST_FUNC_VW_SFD_AUTH:
            normalNoteStr = isDeepScan ? TDDLocalized.vw_gateway_hint_deepscan : TDDLocalized.vw_gateway_hint;
            break;
        case SST_FUNC_DEMO_AUTH:
            normalNoteStr = TDDLocalized.demo_gateway_hint;
            break;
        default:
            break;
    }
    _noteContentLabel.text = normalNoteStr;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vciStatusDidChange) name:KTDDNotificationVciStatusDidChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear) name:KTDDNotificationArtiViewDidAppear object:nil];
}

#pragma mark lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor tdd_viewControllerBackground];
        _scrollView.delaysContentTouches = NO;
    }
    return _scrollView;
}

- (TDD_CustomLabel *)snLabel {
    if (!_snLabel) {
        _snLabel = [TDD_CustomLabel new];
        _snLabel.textColor = [UIColor tdd_title];
        _snLabel.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightMedium] tdd_adaptHD];
        _snLabel.text = [NSString tdd_isEmpty:[TDD_EADSessionController sharedController].SN]?@"--":[TDD_EADSessionController sharedController].SN;
    }
    return _snLabel;
}

- (TDD_CustomLabel *)snExpireLabel {
    if (!_snExpireLabel) {
        _snExpireLabel = [TDD_CustomLabel new];
        _snExpireLabel.textColor = [UIColor tdd_title];
        _snExpireLabel.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightMedium] tdd_adaptHD];
        _snExpireLabel.text = @"--";
        _snExpireLabel.hidden = YES;
    }
    return _snExpireLabel;
}

- (TDD_CustomLabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [TDD_CustomLabel new];
        _accountLabel.textColor = [UIColor tdd_title];
        _accountLabel.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightMedium] tdd_adaptHD];
        NSString *account = [[TDD_ArtiGlobalModel sharedArtiGlobalModel] getAuthAccount];
        _accountLabel.text = [NSString tdd_isEmpty:account] ? @"--" : account;

        
    }
    return _accountLabel;
}

- (TDD_CustomLabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [TDD_CustomLabel new];
        _countLabel.textColor = [UIColor tdd_title];
        _countLabel.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightMedium] tdd_adaptHD];
        _countLabel.hidden = YES;
    }
    return _countLabel;
}

- (TDD_CustomLabel *)expireLabel {
    if (!_expireLabel) {
        _expireLabel = [TDD_CustomLabel new];
        _expireLabel.textColor = [UIColor tdd_title];
        _expireLabel.font = [[UIFont systemFontOfSize:_fontSize weight:UIFontWeightMedium] tdd_adaptHD];
    }
    return _expireLabel;
    
}

- (TDD_LoadingView *)expireLoadingView {
    if (!_expireLoadingView) {
        [TDD_LoadingView setBallWidth:5];
        _expireLoadingView = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, 20 * _scale, 20 * _scale)];
        [_expireLoadingView setBGColor:UIColor.clearColor];
    }
    return _expireLoadingView;
}

- (UIButton *)expireRefreshButton {
    if (!_expireRefreshButton) {
        _expireRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expireRefreshButton setBackgroundImage:[UIImage tdd_imageDiageGateWayRefresh] forState:UIControlStateNormal];
        [_expireRefreshButton addTarget:self action:@selector(requestSNInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expireRefreshButton;
}

- (UIButton *)renewButton {
    if (!_renewButton) {
        _renewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_renewButton setTitle:TDDLocalized.renewal forState:0];
        _renewButton.backgroundColor = [UIColor tdd_errorRed];
        _renewButton.titleLabel.font = [[UIFont systemFontOfSize:IS_IPad ? 16 : 12 weight:UIFontWeightMedium] tdd_adaptHD];
        _renewButton.titleLabel.textColor = [UIColor tdd_title];
        _renewButton.layer.cornerRadius = 14;
        _renewButton.hidden = YES;
        [_renewButton addTarget:self action:@selector(renewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _renewButton;
}

- (UIButton *)changeAccountBtn {
    if (!_changeAccountBtn) {
        _changeAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeAccountBtn setImage:IS_IPad ? kImageNamed(@"diag_change_account_hd") : [UIImage tdd_imageDiageGateWayChangeAccount] forState:UIControlStateNormal];
        [_changeAccountBtn addTarget:self action:@selector(changeAccountAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAccountBtn;
}

- (TDD_LoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, 20 * _scale, 20 * _scale)];
        [_loadingView setBGColor:UIColor.clearColor];
    }
    return _loadingView;
}

@end
