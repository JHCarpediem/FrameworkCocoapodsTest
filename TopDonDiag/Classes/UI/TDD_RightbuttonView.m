//
//  TDD_RightbuttonView.m
//  AD200
//
//  Created by tangjilin on 2022/7/20.
//

#import "TDD_RightbuttonView.h"
#import "TDD_TDartsManage.h"
@import TDUIProvider;
@interface TDD_RightbuttonView ()<TDD_BtnLoadingViewDelegate>

@property (nonatomic, assign) TDD_DiagNavType diagNavType;
@property (nonatomic, strong) TDD_LoittleAnimationView *vciUnConnectView;
@property (nonatomic, assign) CGFloat btnH;
@property (nonatomic, assign) CGFloat vciW;
@property (nonatomic, assign) CGFloat vciH;
@property (nonatomic, strong) TDD_BtnLoadingView *translateBtnView;
@end

@implementation TDD_RightbuttonView

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (_vciUnConnectView && _vciUnConnectView.superview && !_vciUnConnectView.hidden) {
        [_vciUnConnectView playAnimation];
    }
}

+ (UIImage *)navBtnImage:(DiagNaviShowRightBtn )showRightBtnType {
    switch (showRightBtnType) {
        case kVCIStatusBtn:{
            if (TDD_EADSessionController.sharedController.VciStatus) {
                return [UIImage tdd_imageDiagVCIConnect];
            }else {
                return [UIImage tdd_imageDiagVCIUnConnect];
            }
            break;
        }
        case kFeedBackBtn:
            return [UIImage tdd_imageDiagNavFeedBack];
            break;
        case kTranslateBtn:
            return nil;
            break;
        case kSearchBtn:
            return kImageNamed(isKindOfTopVCI? @"nav_search_ic_white" : @"nav_search_ic");
            break;
        case kNavMoreBtn:
            return [UIImage tdd_imageDiagNavMore];
            break;
        case kServiceBtn:
            return kImageNamed(@"nav_service_btn");
            break;
        case kIMMOTDartsStatusBtn:
        {
            if ([TDD_DiagnosisManage getTDartsTProgStatus]) {
                return kImageNamed(@"navi_diag_tdarts_connect");
            } else {
                return kImageNamed(@"navi_diag_tdarts_unconnect");
            }
        }
            break;
        case kHelpBtn:
            return kImageNamed(@"nav_help");
        default:
            return nil;
    }
    
    
}

- (instancetype)initWithType:(TDD_DiagNavType)diagNavType {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bluetoothConnectedChanged) name:KTDDNotificationVciStatusChange object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tDartsStatusChanged) name:KTDDNotificationTDartsStatusChange object:nil];
        _btnH = IS_IPad ? 30 : 36;
        _vciW = IS_IPad ? _btnH * 1.18 : _btnH;
        _vciH = IS_IPad ? 30 : ([TDD_DiagnosisTools softWareIsCarPal] ? 44 : 36);
        self.diagNavType = diagNavType;
        [self setupUI];
        [self setVciStatusBtnImage];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.vciStatusBtn];
    [self addSubview:self.vciUnConnectView];
    [self.vciStatusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-5);
        make.width.mas_equalTo(self.diagNavType == TDD_DiagNavType_TDarts ? 72 : _vciW);
        if ([TDD_DiagnosisTools softWareIsCarPal]) {
            make.height.mas_lessThanOrEqualTo(NavigationHeight);
        }else {
            make.height.mas_equalTo(_btnH);
        }
    }];
    
    [self.vciUnConnectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-5);
        make.width.mas_equalTo(self.diagNavType == TDD_DiagNavType_TDarts ? 72 : _vciW);
        make.height.mas_equalTo(_vciH);
    }];
    
    [self addSubview:self.saveBtn];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.right.equalTo(self).offset(-10);
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            make.width.equalTo(@100);
        }else {
            make.width.equalTo(@52);
        }
        make.height.mas_equalTo(_btnH);
    }];
    [self.vciUnConnectView playAnimationWithName:@"VCIUnConnect"];
}

- (void)updateShowBtn:(NSArray *)showBtnArray isSearch:(BOOL)isSearch {

//    if (self.diagNavType == TDD_DiagNavType_TDarts) {
//        return;
//    }
    NSMutableArray *mArr = showBtnArray.mutableCopy;
    if (isTopVCIPRO) {
        [mArr removeObject:@(kTranslateBtn)];
    }
    if ([TDD_DiagnosisTools softWareIsCarPal]) {
        //Carpal 没有防盗Tdarts
        [mArr removeObjectsInArray:@[@(kIMMOTDartsStatusBtn)]];
    }
    if (isSearch && mArr.count <= 3 && [mArr containsObject:@(kSearchBtn)]) {
        [mArr removeObject:@(kSearchBtn)];
    }
    showBtnArray = mArr;
    _showBtnArray = showBtnArray;
    for (UIView *view in self.subviews) {
        if (view.tag > 100){
            [view removeFromSuperview];
        }
    }
    
    if (showBtnArray.count == 1) {
        NSNumber *type = showBtnArray[0];
        
        if (type.intValue == kNavSaveBtn) {
            
            [self.vciStatusBtn setHidden:YES];
            [self.vciUnConnectView setHidden:YES];
            [self.saveBtn setHidden:NO];
            
        } else {
            [self.vciStatusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-5);
                make.width.mas_equalTo(self.diagNavType == TDD_DiagShowType_TDarts ? 72 : ([TDD_DiagnosisTools softWareIsCarPal] ? 44 : _vciW));
                if ([TDD_DiagnosisTools softWareIsCarPal]) {
                    make.height.mas_lessThanOrEqualTo(NavigationHeight);
                }else {
                    make.height.mas_equalTo(_vciH);
                }
                make.left.equalTo(self).offset(10);
            }];
        }
        return;
    } else {
        if (showBtnArray.count == 0) {
            [self.vciStatusBtn setHidden:YES];
            [self.vciUnConnectView setHidden:YES];
            [self.vciStatusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-5);
                make.width.mas_equalTo(self.diagNavType == TDD_DiagNavType_TDarts ? 72 : _vciW);
                make.height.mas_equalTo(_vciH);
                make.left.equalTo(self).offset(10);
            }];
        }else {
            if ([TDD_DiagnosisTools softWareIsKindOfTopScan]) {
                [self.vciStatusBtn setHidden:TDD_EADSessionController.sharedController.VciStatus?NO:YES];
                [self.vciUnConnectView setHidden:TDD_EADSessionController.sharedController.VciStatus?YES:NO];
            }
            [self.saveBtn setHidden:YES];
            [self.vciStatusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-5);
                make.width.mas_equalTo(self.diagNavType == TDD_DiagShowType_TDarts ? 72 : ([TDD_DiagnosisTools softWareIsCarPal] ? 44 : _vciW));
                if ([TDD_DiagnosisTools softWareIsCarPal]) {
                    make.height.mas_lessThanOrEqualTo(NavigationHeight);
                }else {
                    make.height.mas_equalTo(_vciH);
                }
            }];
        }

    }
    // 蓝牙状态按钮固定显示，翻译和搜索按钮根据页面显示,反馈按钮根据app显示
    for (int i = 0; i < showBtnArray.count; i++) {
        NSNumber *type = showBtnArray[i];
        if (type.intValue == kVCIStatusBtn){
            continue;
        }
        BOOL showMoreBtn = (i == 2 && showBtnArray.count > 3);
        if (type.intValue == kTranslateBtn && !showMoreBtn){
            TDD_BtnLoadingView *loadingView = [[TDD_BtnLoadingView alloc] init];
            loadingView.delegate = self;
            loadingView.tag = 100 + type.intValue;
            [self addSubview:loadingView];
            self.translateBtnView = loadingView;
            //翻译的圆形进度条需要更大的宽高
            CGFloat loadingH = IS_IPad ? 36 : _btnH;
            [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                //减掉 VCI 按钮宽度
                make.right.equalTo(self.vciStatusBtn.mas_left).offset((-_btnH) * (i - 1) + ( -(IS_IPad ? 12 : 0) * i));
                make.height.mas_equalTo(loadingH);
                make.width.mas_equalTo(loadingH);
                if (showMoreBtn || (i == showBtnArray.count - 1)){
                    make.left.equalTo(self).offset(10);
                }
            }];
        } else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *image;
            [btn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (showMoreBtn){
                image = [TDD_RightbuttonView navBtnImage:kNavMoreBtn];
                btn.tag = 100 + kNavMoreBtn;
            }else {
                image = [TDD_RightbuttonView navBtnImage:type.intValue];
                btn.tag = 100 + type.intValue;
            }
            if (IS_IPad) {
                [btn setBackgroundImage:image forState:UIControlStateNormal];
            }else {
                [btn setImage:image forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            //翻译的圆形进度条需要更大的宽高
            CGFloat loadingH = 0;
            CGFloat right = 0;
            //减掉 VCIBtn 以及翻译按钮的宽度
            if ([self.subviews containsObject:self.translateBtnView]) {
                loadingH = IS_IPad ? 36 : _btnH;
                right = (-_vciW) * (i - 2) + ( -(IS_IPad ? 12 : 0) * i) - loadingH;
            }else {
                right = (-_vciW) * (i - 1) + ( -(IS_IPad ? 12 : 0) * i);
            }
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self.vciStatusBtn.mas_left).offset(right);
                make.height.mas_equalTo(_btnH);
                make.width.mas_equalTo(_btnH);
                if (showMoreBtn || (i == showBtnArray.count - 1)){
                    make.left.equalTo(self).offset(10);
                }
            }];
        }
        if (showMoreBtn) {
            break;
        }
    }
    
}

- (void)showTranslateFinish:(BOOL )finish {
    TDD_BtnLoadingView *loadingView = [self viewWithTag:100 + kTranslateBtn];
    if (loadingView && [loadingView isKindOfClass:[TDD_BtnLoadingView class]]){
        [loadingView showTranslateFinish:finish];
    }
    
}

- (void)showTranslateAnimate:(BOOL )show {
    TDD_BtnLoadingView *loadingView = [self viewWithTag:100 + kTranslateBtn];
    if (loadingView && [loadingView isKindOfClass:[TDD_BtnLoadingView class]]){
        [loadingView showTranslateAnimate:show];
    }
    
}

/// 设置蓝牙按钮图片
- (void)setVciStatusBtnImage {

//    if (_showBtnArray.count == 0) {
//        return;
//    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (TDD_EADSessionController.sharedController.VciStatus) {
            self.vciUnConnectView.hidden = YES;
            self.vciStatusBtn.hidden = NO;
            
        }else {
            if ([TDD_DiagnosisTools softWareIsKindOfTopScan]) {
                self.vciUnConnectView.hidden = NO;
                self.vciStatusBtn.hidden = YES;
                if (_vciUnConnectView && _vciUnConnectView.superview && !_vciUnConnectView.hidden) {
                    [_vciUnConnectView playAnimation];
                }
            }else {
                self.vciUnConnectView.hidden = YES;
                self.vciStatusBtn.hidden = NO;
                
            }
        }
        if ([TDD_DiagnosisManage sharedManage].viewColorType == TDD_DiagViewColorType_Red && TDD_EADSessionController.sharedController.VciStatus) {
            UIImage *image = [TDD_RightbuttonView navBtnImage:kVCIStatusBtn];
            if (IS_IPad) {
                [self.vciStatusBtn setBackgroundImage:image forState:UIControlStateNormal];
            }else {
                [self.vciStatusBtn setImage:image forState:UIControlStateNormal];
            }
        }else {
            UIImage *image = [TDD_RightbuttonView navBtnImage:kVCIStatusBtn];
            if (IS_IPad) {
                [self.vciStatusBtn setBackgroundImage:image forState:UIControlStateNormal];
            }else {
                [self.vciStatusBtn setImage:image forState:UIControlStateNormal];
            }
        }

        if (self.diagNavType == TDD_DiagNavType_IMMO) {
            UIButton *tdartsBtn = [self viewWithTag:100 + kIMMOTDartsStatusBtn];
            UIImage *image = [TDD_RightbuttonView navBtnImage:kIMMOTDartsStatusBtn];
            if (IS_IPad) {
                [tdartsBtn setBackgroundImage:image forState:UIControlStateNormal];
            }else {
                [tdartsBtn setImage:image forState:UIControlStateNormal];
            }
        }
        
    });
}

/// 蓝牙状态按钮点击事件
- (void)vciStatusBtnClick {
    if (self.diagNavType == TDD_DiagNavType_TDarts) {
        if (self.buttonblock) {
            self.buttonblock(100);
        }
        return;
    }
    if (![TDD_EADSessionController sharedController].VciStatus) {
        NSString *title = [TDDLocalized.tip_connect_vci stringByReplacingOccurrencesOfString:@"%@" withString:TDDSelectdVCISerialNum];
        LMSAlertAction *connectAction = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.to_connect titleColor:[UIColor tdd_colorDiagTheme] backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [LMSAlertController showWithTitle:TDDLocalized.app_tip content:title image:nil priority:1002 actions:@[LMSAlertAction.cancelAction,connectAction]];
    }
}

/// 保存按钮点击
- (void)saveBtnClick {
    if (self.buttonblock) {
        self.buttonblock(100 + kNavSaveBtn);
    }
}


/// 按钮点击事件
- (void)navBtnClick:(UIButton *)col {
    if (col.tag == 100 + kNavMoreBtn){
        if (self.moreBtnBlock && self.showBtnArray.count > 3){
            self.moreBtnBlock([self.showBtnArray subarrayWithRange:NSMakeRange(2, self.showBtnArray.count-2)]);
        }
    }else {
        if (self.buttonblock) {
            self.buttonblock(col.tag);
        }
    }

}

#pragma mark -- TDD_BtnLoadingViewDelegate
/// 翻译按钮点击事件
- (void)loadingBtnClick {
    if (self.buttonblock) {
        self.buttonblock(102);
    }
}

// VCI连接状态改变
- (void)bluetoothConnectedChanged {
    //状态发生变化
    [self setVciStatusBtnImage];
}

// t-Darts连接状态改变
- (void)tDartsStatusChanged {
    [self setVciStatusBtnImage];
}

- (void)dealloc{
    NSLog(@"%s - dealloc",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- lazy UI
- (UIButton *)vciStatusBtn {
    if (!_vciStatusBtn) {
        _vciStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_vciStatusBtn setImage:[UIImage tdd_imageDiagVCIUnConnect] forState:UIControlStateNormal];
//        self.vcl.tag = 100;
        _vciStatusBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        [_vciStatusBtn addTarget:self action:@selector(vciStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vciStatusBtn;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:[TDD_HLanguage getLanguage:@"person_save"] forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor tdd_colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [[UIFont systemFontOfSize:16] tdd_adaptHD];
        _saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setHidden:YES];
    }
    return _saveBtn;
}

- (TDD_LoittleAnimationView *)vciUnConnectView {
    if (!_vciUnConnectView) {
        _vciUnConnectView = [[TDD_LoittleAnimationView alloc] init];
        _vciUnConnectView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vciStatusBtnClick)];
        [_vciUnConnectView addGestureRecognizer:tap];
    }
    return _vciUnConnectView;
}
@end
