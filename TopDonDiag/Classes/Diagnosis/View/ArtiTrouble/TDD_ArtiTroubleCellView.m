//
//  TDD_ArtiTroubleCellView.m
//  AD200
//
//  Created by 何可人 on 2022/5/9.
//

#import "TDD_ArtiTroubleCellView.h"
#import "TDD_DiagnosisManage.h"
#import "TDD_ArtiTroubleShowStateView.h"
#import "TDD_DiagnosisViewController.h"
#import "TDD_ArtiTroubleAIGuildView.h"
@import TDUIProvider;
@interface TDD_ArtiTroubleCellView ()
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) TDD_CustomLabel * codeLab;
@property (nonatomic, strong) TDD_CustomLabel * stateLab;
@property (nonatomic, strong) UIButton *stateBtn;
@property (nonatomic, strong) YYLabel * descLab;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView *lockBGImageView;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UIView * lockBGView;

@property (nonatomic, strong) CAGradientLayer * gl;
@property (nonatomic, strong) NSMutableArray<UIButton *> * btnArray;
@property (nonatomic, strong) NSMutableArray<UIView *> * btnLinesArray;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat itemWidth;
@end

@implementation TDD_ArtiTroubleCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {

//        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        _scale = IS_IPad ? HD_Height : H_Height;
        CGFloat leftSpace = (IS_IPad ? 25 : 15) * _scale;
        CGFloat lineSpace = (IS_IPad ? 10 : 5 ) * _scale;
        _itemWidth = (IS_IPad ? (IphoneWidth - leftSpace * 2 - lineSpace)/2 : (IphoneWidth - leftSpace * 2));

        self.backgroundColor = UIColor.tdd_viewControllerBackground;

        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    CGFloat leftSpace = (IS_IPad ? 16 : 10) * _scale;
    CGFloat topSpace = (IS_IPad ? 16 : 10) * _scale;
    CGFloat centerSpace = (IS_IPad ? 74 : 66) * _scale;
    CGFloat codeFont = IS_IPad ? 18 : 15;
    CGFloat descFont = IS_IPad ? 14 : 13;
    UIView * view = [[UIView alloc] init];
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    view.layer.shadowOffset = CGSizeMake(4,4);
    view.layer.shadowOpacity = 1 * _scale;
    view.layer.shadowRadius = 10 * _scale;
    [self addSubview:view];
    view.backgroundColor = [UIColor tdd_inputHistoryCellBackground];
    self.view = view;
    
    TDD_CustomLabel * codeLab = ({
        // TDD_CustomLabel * label = [[TDD_VXXScrollLabel alloc] init];
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:codeFont weight:UIFontWeightSemibold] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 2;
        label;
    });
    [view addSubview:codeLab];
    self.codeLab = codeLab;
    
    TDD_CustomLabel * stateLab = ({
        TDD_CustomLabel * label = [[TDD_VXXScrollLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
        label.textColor = [UIColor tdd_dtcStatusNormalColor];
        label;
    });
    [view addSubview:stateLab];
    self.stateLab = stateLab;
    
    UIButton * stateBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:kImageNamed(@"truble_more") forState:UIControlStateNormal];
        btn.hidden = YES;
        btn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
        [btn addTarget:self action:@selector(showStateView) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [view addSubview:stateBtn];
    self.stateBtn = stateBtn;
    
    YYLabel * descLab = ({
        YYLabel * label = [[YYLabel alloc] init];
//        label.displaysAsynchronously = YES;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [[UIFont systemFontOfSize:descFont] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 2;
        label.textVerticalAlignment = YYTextVerticalAlignmentTop;
        label.preferredMaxLayoutWidth = _itemWidth - (leftSpace * 2);
        
        NSString *moreString = [NSString stringWithFormat:@"...%@", TDDLocalized.diagnosis_unfold];
        NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:moreString];
        attStr.yy_font = [[UIFont systemFontOfSize:descFont] tdd_adaptHD];
        attStr.yy_color = [UIColor tdd_color2B79D8];
        
        //添加点击事件
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setFont:[[UIFont systemFontOfSize:descFont] tdd_adaptHD]];
        [attStr yy_setTextHighlight:highlight range:[attStr.string rangeOfString:moreString]];

        @kWeakObj(self)
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            @kStrongObj(self)
            //点击展开
            [self moreBtnClick];
        };
        
        YYLabel *seeMore = [YYLabel new];
        seeMore.textAlignment = NSTextAlignmentLeft;
        seeMore.attributedText = attStr;
        [seeMore sizeToFit];
        
        label.truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:attStr.yy_font alignment:(YYTextVerticalAlignmentCenter)];
        label;
    });
    [view addSubview:descLab];
    self.descLab = descLab;
    
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.tdd_line;
    [self.view addSubview:lineView];
    self.lineView = lineView;
    
    [self updateBtnsLayoutWithShowTrouble: NO];
    //软件过期（carpal这里不需要）
    if ([TDD_DiagnosisTools isLimitedTrialFuction] && ![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        _lockBGImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"diag_trouble_lock_bg")];
        _lockBGImageView.userInteractionEnabled = YES;
        [self.view addSubview:_lockBGImageView];
        
        _lockImageView = [[UIImageView alloc] initWithImage:kImageNamed(@"diag_trouble_btn_lock")];
        [self.view addSubview:_lockImageView];
        
        _lockBGView = [UIView new];
        _lockBGView.backgroundColor = UIColor.clearColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockClick)];
        [_lockBGView addGestureRecognizer:tap];
        [self.view addSubview:_lockBGView];
        [_lockBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }

    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(leftSpace);
        make.top.equalTo(view).offset(topSpace);
        make.width.lessThanOrEqualTo(view).multipliedBy(0.4);
    }];
    
    [stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(view).insets(UIEdgeInsetsMake(leftSpace, 0, 0, topSpace));
        make.width.lessThanOrEqualTo(view).multipliedBy(0.4);
    }];
    
    [stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(view).insets(UIEdgeInsetsMake(leftSpace, 0, 0, topSpace));
        make.size.mas_equalTo(CGSizeMake(leftSpace * 2, topSpace * 2));
        
    }];
    
    descLab.preferredMaxLayoutWidth = _itemWidth - (leftSpace * 2);
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(view).insets(UIEdgeInsetsMake(0, leftSpace, 0, topSpace));
        make.top.equalTo(self).offset(centerSpace);
        //make.bottom.mas_lessThanOrEqualTo(lineView.mas_top).offset(-topSpace);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(view).offset(- (IS_IPad ? 56 : 40) * _scale);
    }];
    
    //软件过期
    if ([TDD_DiagnosisTools isLimitedTrialFuction] && ![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        [_lockBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(75 * _scale);
        }];
        
        [_lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.lockBGImageView);
            make.size.mas_equalTo(CGSizeMake(22 * _scale, 22 * _scale));
            make.bottom.equalTo(self.lockBGImageView).offset((IS_IPad ? -16 : -10) * _scale);
        }];
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(topSpace).priorityHigh();
    }];
}

- (void)updateBtnsLayoutWithShowTrouble: (BOOL)isShowTrouble
{
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.btnLinesArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    UIButton * lastButton;
//    NSInteger count = isShowTrouble ? 5 : 4;
    NSInteger count = 4;
    
    for (int i = 0; i < count; i ++) {
        UIButton * button = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            int delta = count == 5 ? 0 : 1;
            int index = delta + i;
            btn.tag = 200 + index;
            NSString * normalImgName = [NSString stringWithFormat:@"trouble_button_%d", index];
            NSString * disableImgName = [NSString stringWithFormat:@"trouble_button_select_%d", index];
            if (([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany || [TDD_DiagnosisManage sharedManage].functionConfigMask & 1) && (i == count-1)) {
                [btn setImage:[UIImage tdd_imageDiagAIIcon] forState:UIControlStateNormal];
                [btn setImage:[UIImage tdd_imageDiagAIIcon] forState:UIControlStateDisabled];
            }else {
                [btn setImage:kImageNamed(normalImgName) forState:UIControlStateNormal];
                [btn setImage:kImageNamed(disableImgName) forState:UIControlStateDisabled];
            }

            btn;
        });
        [self.view addSubview:button];
        [self.btnArray addObject:button];
        CGFloat topSpace = (IS_IPad ? 16 : 12) * _scale;
        if (i < count - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.layer.backgroundColor = UIColor.tdd_line.CGColor;
            if (!isKindOfTopVCI) {
//                lineView.layer.cornerRadius = 8;
                lineView.layer.shadowColor = UIColor.tdd_colorFFFFFF.CGColor;
                lineView.layer.shadowOffset = CGSizeMake(1,0);
                lineView.layer.shadowOpacity = 1 * _scale;
                lineView.layer.shadowRadius = 0;
            }
            [self.view addSubview:lineView];
            [self.btnLinesArray addObject:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button).offset(topSpace);
                make.centerY.equalTo(button);
                make.right.equalTo(button);
                make.width.mas_equalTo(1);
            }];
        }
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom);
            if (!lastButton) {
                make.left.equalTo(self.view);
            }else {
                make.left.equalTo(lastButton.mas_right);
            }
            make.bottom.equalTo(self.view);
            make.width.equalTo(self.view).multipliedBy(1 / (CGFloat)count);
        }];
        
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(26 * _scale, 26 * _scale));
//            make.center.equalTo(button);
//        }];
        
        lastButton = button;
    }

    if (_lockBGImageView && _lockBGImageView.superview) {
        [self.view bringSubviewToFront:_lockBGImageView];
    }
    if (_lockImageView && _lockImageView.superview) {
        [self.view bringSubviewToFront:_lockImageView];
    }
    if (_lockBGView && _lockBGView.superview) {
        [self.view bringSubviewToFront:_lockBGView];
    }
}

- (void)showStateView {
//    self.stateView.stateStr = [TDD_DiagnosisManage getDtcNodeStatusDescription:(int)_itemModel.uStatus statusStr:self.isShowTranslated ?_itemModel.strTroubleStatus :_itemModel.strTranslatedTroubleStatus];
    CGPoint point = [self.stateBtn convertPoint:CGPointMake(0,0) toView:[UIApplication sharedApplication].windows.lastObject];
    
    
    TDD_ArtiTroubleShowStateView *stateView = [[TDD_ArtiTroubleShowStateView alloc] init];
    NSAttributedString *stateStr = [TDD_DiagnosisManage getDtcNodeStatusDescription:_itemModel.uStatus statusStr:self.isShowTranslated ?_itemModel.strTranslatedTroubleStatus :_itemModel.strTroubleStatus fromTrouble:YES];
    [stateView showWithPopPoint:point content:stateStr];
    
    NSString *referrer = @"HealthCheck";
    if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]] && [TDD_DiagnosisTools softWareIsCarPalSeries]) {
        referrer = @"EngineInspection";
    }
    [TDD_Statistics event:Event_Cus_ClickTroubleCodeStatus attributes:@{@"TroubleCodeStatusReferrer": referrer}];

}

- (void)showGuildView {

    [self layoutIfNeeded];
    UIButton *btnView = [self.view viewWithTag:204];
    if (btnView) {
        CGPoint point = [btnView.imageView convertPoint:CGPointMake(15 * _scale,15 * _scale) toView:[UIApplication sharedApplication].windows.lastObject];
        TDD_ArtiTroubleAIGuildView *guildView = [[TDD_ArtiTroubleAIGuildView alloc] init];
        [guildView showWithPopPoint:point];
    }

}

- (void)setItemModel:(TDD_ArtiTroubleItemModel *)itemModel
{
    
    _itemModel = itemModel;
    
    self.codeLab.text = [NSString tdd_isEmpty:itemModel.strTroubleCode]?@" ":itemModel.strTroubleCode;
    
    NSString *descStr = @"";
    if ([TDD_DiagnosisTools isLimitedTrialFuction] && ![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        descStr = @"******";
    }else {
        descStr = self.isShowTranslated ?itemModel.strTranslatedTroubleDesc :itemModel.strTroubleDesc;
    }
    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:descStr];
    CGFloat descFont = IS_IPad ? 14 : 13;
    [attStr setYy_font:[[UIFont systemFontOfSize:descFont] tdd_adaptHD]];
    // 设置行高
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; // 行高
    [attStr yy_setParagraphStyle:paragraphStyle range:attStr.yy_rangeOfAll];
    self.descLab.attributedText = attStr;
    
    if (itemModel.strTroubleStatus.length > 20 || [itemModel.strTroubleStatus containsString:@"\n"]) {
        
        self.stateLab.hidden = YES;
        self.stateBtn.hidden = NO;
        
    }else {
        self.stateLab.hidden = NO;
        if (self.isShowTranslated) {
            self.stateLab.attributedText = [TDD_DiagnosisManage getDtcNodeStatusDescription:itemModel.uStatus statusStr:itemModel.strTranslatedTroubleStatus fromTrouble:YES];
        }else {
            self.stateLab.attributedText = [TDD_DiagnosisManage getDtcNodeStatusDescription:itemModel.uStatus statusStr:itemModel.strTroubleStatus fromTrouble:YES];
        }
    }

    
    if (itemModel.isShowMore) {
        self.descLab.numberOfLines = 0;
//        self.descLab.truncationToken = nil;
        
//        [self.descLab layoutIfNeeded];
//        NSString *content = @"";
//        if (self.isShowTranslated) {
//            content = itemModel.strTranslatedTroubleDesc;
//        }else {
//            content = itemModel.strTroubleDesc;
//        }
//        float height = [NSString tdd_getHeightWithText:content width:IphoneWidth - 50 * _scale fontSize:self.descLab.font];
//
//        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(ceil(height));
//        }];
    }else {
        self.descLab.numberOfLines = 2;

//        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(46);
//        }];
    }
    
    [self updateBtnsLayoutWithShowTrouble:_itemModel.isShowMILStatus];
    
    UIButton * helpButton = [self viewWithTag:202];
    
    helpButton.enabled = _itemModel.isShowHelpButton;
    
    UIButton * FreezeStatusButton = [self viewWithTag:203];
    
    FreezeStatusButton.enabled = itemModel.isShowFreezeStatus;
    
    UIButton * FaultCodeButton = [self viewWithTag:204];
    FaultCodeButton.enabled = NO;


    //支持专业版本故障码
    if ([TDD_DiagnosisManage sharedManage].carModel.supportProfessionalTrouble) {
        FaultCodeButton.enabled = YES;

    }
    //德国定制全放开
    if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany || [TDD_DiagnosisManage sharedManage].functionConfigMask & 1) {
        FaultCodeButton.enabled = YES;
    }

}

- (void)lockClick {
    if ([self.delegate respondsToSelector:@selector(ArtiTroubleCellLockClick:)]) {
        [self.delegate ArtiTroubleCellLockClick:self];
    }
}

- (void)buttonClick:(UIButton *)button
{
    //软件过期前往购买
    if ([TDD_DiagnosisTools isLimitedTrialFuction] && ![TDD_DiagnosisTools softWareIsCarPalSeries]) {
        if ([self.delegate respondsToSelector:@selector(ArtiTroubleCellLockClick:)]) {
            [self.delegate ArtiTroubleCellLockClick:self];
            return;
        }
    }

    
    long tag = button.tag - 200;
    
    if (tag == 2) {
        //帮助
        NSString *referrer = @"HealthCheck";
        if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]] && [TDD_DiagnosisTools softWareIsCarPalSeries]) {
            referrer = @"EngineInspection";
        }
        [TDD_Statistics event:Event_Troublecodehelp attributes:@{@"TroublecodehelpReferrer": referrer}];

        
        LMSAlertAction * action = [LMSAlertAction confirmAction];
        
        if (self.isShowTranslated) {
            [LMSAlertController showWithTitle:self.itemModel.strTroubleCode content:self.itemModel.strTranslatedTroubleHelp image:nil priority:1002 actions:@[action]];
        }else {
            [LMSAlertController showWithTitle:self.itemModel.strTroubleCode content:self.itemModel.strTroubleHelp image:nil priority:1002 actions:@[action]];
        }
        
    }else if (tag == 3 || tag == 4) {
        //冻结
        if (tag == 3){
            NSString *referrer = @"HealthCheck";
            if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]] && [TDD_DiagnosisTools softWareIsCarPalGuru]) {
                referrer = @"EngineInspection";
            }
            [TDD_Statistics event:Event_Troublecodefreezeframe attributes:@{@"TroublecodefreezeframeReferrer": referrer}];
        }else {
            // 带参数，埋在 C++ 回调之后
            //[TDD_Statistics event:Event_Troublecodetechnicalservice attributes:nil];
        }
        
        if ([self.delegate respondsToSelector:@selector(ArtiTroubleCellButtonClick:)]) {
            [self.delegate ArtiTroubleCellButtonClick:button];
        }
    }else if (tag == 1) {
        //搜索
        NSString *referrer = @"HealthCheck";
        if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]] && [TDD_DiagnosisTools softWareIsCarPalSeries]) {
            referrer = @"EngineInspection";
        }
        [TDD_Statistics event:Event_Troublecodesearch attributes:@{@"TroublecodesearchSkipReferrer": referrer}];
        NSString * str = self.itemModel.strTroubleCode;
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@" "];

        NSString *urlString = @"";
        if (isTopVCIPRO || isTopVCI) {
            urlString = [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@ %@", [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName,str];
        }else {
            urlString = [NSString stringWithFormat:@"https://www.google.com/search?q=%@ %@", [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarName,str];
        }
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)moreBtnClick
{

//    if (IS_IPad) {
        
        LMSAlertController * alert = [LMSAlertController showWithTitle:_itemModel.strTroubleCode content:_itemModel.strTroubleDesc image:nil priority:1002 actions:@[LMSAlertAction.confirmAction]];
//    }else {
//        if ([self.delegate respondsToSelector:@selector(ArtiTroubleCellMoreButtonClick:)]) {
//            [self.delegate ArtiTroubleCellMoreButtonClick:self];
//        }
//    }

}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
//    [self addLayer];
}

- (void)addLayer
{
    [self.gl removeFromSuperlayer];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.view.bounds;
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:242/255.0 green:248/255.0 blue:253/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 10 * _scale;
    [self.view.layer insertSublayer:gl atIndex:0];
    
    self.gl = gl;
}

- (NSMutableArray<UIButton *> *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray<UIView *> *)btnLinesArray
{
    if (!_btnLinesArray) {
        _btnLinesArray = [NSMutableArray array];
    }
    return _btnLinesArray;
}

@end
