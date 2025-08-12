//
//  TDD_ArtiPopupSuggestCellView.m
//  TopdonDiagnosis
//
//  Created by lk_ios2023002 on 2024/3/11.
//

#import "TDD_ArtiPopupSuggestCellView.h"
#import "TDD_LoadingView.h"
#import "TDD_ArtiTroubleShowStateView.h"
#import <TopdonDiagnosis/TopdonDiagnosis-Swift.h>
#import "TDD_DiagnosisViewController.h"
#import "TDD_ArtiTroubleAIGuildView.h"

@import TDUIProvider;
@interface TDD_ArtiPopupSuggestCellView()
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) TDD_CustomLabel * codeLab;

@property (nonatomic, strong) UIButton * stateBtn;
@property (nonatomic, strong) TDD_CustomLabel * stateLab;

@property (nonatomic, strong) UIImageView *stateImgView;

@property (nonatomic, strong) YYLabel * descLab;
@property (nonatomic, strong) UIButton *suggestBGView;
@property (nonatomic, strong) TDD_CustomLabel * suggestLab;
@property (nonatomic, strong) UIView * suggestLoadingView;
@property (nonatomic, strong) UIImageView * suggestArrowImgView;
@property (nonatomic, strong) TDD_CustomLabel * suggestNoLab;
@property (nonatomic, strong) TDD_LoadingView *loadingView;
@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, strong) UIView *fuctionBGView;
@end


@implementation TDD_ArtiPopupSuggestCellView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    _scale = IS_IPad ? HD_Height : H_Height;
    
    UIView * view = [[UIView alloc] init];
    view.layer.shadowColor = [UIColor tdd_colorWithHex:0x1b212a].CGColor;
    view.layer.shadowOffset = CGSizeMake(4,4);
    view.layer.shadowOpacity = 1 * _scale;
    view.layer.shadowRadius = 10 * _scale;
    [self addSubview:view];
    view.backgroundColor = [UIColor tdd_inputHistoryCellBackground];
    view.layer.cornerRadius = 4 * _scale;
    view.layer.masksToBounds = YES;
    self.view = view;
    
    //故障码
    TDD_CustomLabel * codeLab = ({
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label;
    });
    [view addSubview:codeLab];
    self.codeLab = codeLab;
    
    //故障码描述
    YYLabel * descLab = ({
        YYLabel * label = [[YYLabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 3;
        label.textVerticalAlignment = YYTextVerticalAlignmentTop;
        
        NSString *moreString = [NSString stringWithFormat:@"...%@", TDDLocalized.diagnosis_unfold];
        NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:moreString];
        attStr.yy_font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
        attStr.yy_color = [UIColor tdd_colorDiagTheme];
        
        //添加点击事件
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setFont:[[UIFont systemFontOfSize:13] tdd_adaptHD]];
        [attStr yy_setTextHighlight:highlight range:[attStr.string rangeOfString:moreString]];
        
        @kWeakObj(self);
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            @kStrongObj(self);
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
    
    //故障码状态
    UIButton *stateBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    stateBtn.layer.cornerRadius = 4.0;
    stateBtn.layer.masksToBounds = YES;
    [stateBtn addTarget:self action:@selector(showStateView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:stateBtn];
    self.stateBtn = stateBtn;
    
    TDD_CustomLabel *stateLab = [[TDD_CustomLabel alloc] init];
    stateLab.font = [[UIFont systemFontOfSize:14] tdd_adaptHD];
    [stateLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [stateLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [view addSubview:stateLab];
    self.stateLab = stateLab;
    
    UIImageView *stateImgView = [[UIImageView alloc] init];
    stateImgView.userInteractionEnabled = NO;
    [view addSubview:stateImgView];
    self.stateImgView = stateImgView;
    
    //功能列表
    UIButton *fuctionBGView = [UIButton buttonWithType:0];
    fuctionBGView.backgroundColor = [UIColor tdd_colorWithHex:0x000000 alpha:0.2];
    [view addSubview:fuctionBGView];
    self.fuctionBGView = fuctionBGView;
    for (int i = 1; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 4) {
            [btn setImage:[UIImage tdd_imageDiagAIIcon] forState:UIControlStateNormal];
            [btn setImage:[UIImage tdd_imageDiagAIDisableIcon] forState:UIControlStateDisabled];
            if ([TDD_DiagnosisTools customizedType] == TDD_Customized_Germany || [TDD_DiagnosisManage sharedManage].functionConfigMask & 1) {
                btn.enabled = YES;
            }else {
                btn.enabled = NO;
            }
        }else {
            NSString * normalImgName = [NSString stringWithFormat:@"trouble_button_dark_type_%d", i];
            NSString * disableImgName = [NSString stringWithFormat:@"trouble_button_dark_type_enable_%d", i];
            [btn setImage:kImageNamed(normalImgName) forState:UIControlStateNormal];
            [btn setImage:kImageNamed(disableImgName) forState:UIControlStateDisabled];
        }

        [self.fuctionBGView addSubview:btn];
        
    }

    [self setupConstraint];
}

- (void)setupConstraint {
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 15 * _scale, 0, 15 * _scale));
        make.bottom.equalTo(_fuctionBGView.mas_bottom);
    }];
    
    [_codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_view).insets(UIEdgeInsetsMake(10 * _scale, 10 * _scale, 0, 0));
        make.right.lessThanOrEqualTo(_stateLab.mas_left).mas_offset(-20);
        make.height.greaterThanOrEqualTo(@(24.0 * _scale));
    }];
    
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view).offset(-18 * _scale).priorityHigh;
        make.top.equalTo(@(14.0 * _scale)); // 14
    }];
    
    [_stateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_stateLab);
        make.right.equalTo(_stateLab.mas_left).offset(-2.5 * _scale);
        make.size.mas_equalTo(CGSizeMake(16 * _scale, 16 * _scale));
    }];
    
    [_stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stateImgView.mas_top).offset(-4.5 * _scale);
        make.bottom.equalTo(_stateImgView.mas_bottom).offset(4.5 * _scale);
        make.left.equalTo(_stateImgView.mas_left).offset(-8.0 * _scale);
        make.right.equalTo(_stateLab.mas_right).offset(8.0 * _scale);
    }];
    
    [_codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_view).insets(UIEdgeInsetsMake(10 * _scale, 10 * _scale, 0, 0));
        make.right.lessThanOrEqualTo(_stateBtn.mas_left).offset(-20 * _scale);
        make.height.greaterThanOrEqualTo(@(24.0 * _scale));
    }];
    
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_view).insets(UIEdgeInsetsMake(0, 10 * _scale, 0, 10 * _scale));
        make.top.equalTo(_codeLab.mas_bottom).mas_equalTo(19 * _scale);
        make.height.greaterThanOrEqualTo(@(24.0 * _scale));
    }];
    
    [_fuctionBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descLab.mas_bottom).offset(10 * _scale);
        make.left.right.bottom.equalTo(_view);
        make.height.mas_offset(48 * _scale);
    }];
    
    UIButton *lastBtn;
    for (int i = 1; i < 5; i++) {
        UIButton *btn = [_fuctionBGView viewWithTag:100 + i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastBtn ? lastBtn.mas_right : _fuctionBGView);
            make.top.bottom.equalTo(_fuctionBGView);
            make.width.equalTo(_fuctionBGView).multipliedBy(1 / 4.0);
        }];
        lastBtn = btn;
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_view.mas_bottom).offset(10 * H_Height).priorityHigh();
    }];
}

- (void)showGuildView {

    [self layoutIfNeeded];
    UIButton *btnView = [self.view viewWithTag:104];
    if (btnView) {
        CGPoint point = [btnView.imageView convertPoint:CGPointMake(15 * _scale,15 * _scale) toView:[UIApplication sharedApplication].windows.lastObject];
        TDD_ArtiTroubleAIGuildView *guildView = [[TDD_ArtiTroubleAIGuildView alloc] init];
        [guildView showWithPopPoint:point];
    }

}

- (void)setItemModel:(TDD_ArtiPopupItemModel *)itemModel
{
    _itemModel = itemModel;
    _troubleItemModel = nil;
    
    self.codeLab.text = itemModel.code;
    NSString *contentStr = self.isShowTranslated ?_itemModel.strTranslatedContent:_itemModel.content;
    if ([NSString tdd_isEmpty:contentStr]) {
        contentStr = _itemModel.content?:@"";
    }

    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:contentStr];
    attStr.yy_lineSpacing = 10;
    attStr.yy_font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
    attStr.yy_color = [UIColor tdd_title];
    self.descLab.attributedText = attStr;
    
    if (itemModel.isShowMore) {
        //旧版伸缩逻辑
        self.descLab.numberOfLines = 0;
        
        [self.descLab layoutIfNeeded];
        
        float height = [NSString tdd_getHeightWithText:itemModel.content width:IphoneWidth - 50 * H_Height fontSize:self.descLab.font];
        
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MAX(height, 24.0 * _scale));
        }];
    }else {
        self.descLab.numberOfLines = 3;
        CGSize introSize = CGSizeMake(IphoneWidth - 50 * _scale, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attStr];
        CGFloat introHeight = layout.textBoundingSize.height;
        float height = MIN(introHeight, 72 * _scale);
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MAX(height, 24.0 * _scale));
        }];
    }
    
    int codeLevel = [TDD_Tools troubleCodeLevelWithVehicle:[TDD_ArtiGlobalModel GetVehName] statusStr:_itemModel.status];
    codeLevel = MIN(codeLevel, 3);
    codeLevel = MAX(codeLevel, 1);
    NSArray *levelArr = @[TDDLocalized.report_trouble_code_status_seriousness,TDDLocalized.report_trouble_code_status_slight,TDDLocalized.diag_ignore];
    NSArray *codeLevelArr = @[@(1),@(2),@(4)];
    NSArray *colorArr = @[[UIColor tdd_errorRed],[UIColor tdd_colorWithHex:0xFF9500],[UIColor tdd_color999999]];

    [_stateBtn setBackgroundColor:colorArr[codeLevel - 1]];
    NSString * normalImgName = [NSString stringWithFormat:@"trouble_level_3"];
    UIColor *color = UIColor.tdd_title;
    
    NSString *levelStr = [NSString stringWithFormat:@"%@",levelArr[codeLevel - 1]];
    [_stateImgView setImage:[kImageNamed(normalImgName) tdd_imageByTintColor:color]];
    [_stateLab setText:levelStr];
    [_stateLab setTextColor:color];
    
    UIButton * helpButton = [self viewWithTag:102];
    helpButton.enabled = false;
    
    UIButton * FreezeStatusButton = [self viewWithTag:103];
    FreezeStatusButton.enabled = false;
    
}

- (void)setTroubleItemModel:(TDD_ArtiTroubleItemModel *)troubleItemModel {
    _troubleItemModel = troubleItemModel;
    
    _itemModel = nil;
    
    self.codeLab.text = _troubleItemModel.strTroubleCode;
    NSString *descStr = self.isShowTranslated ? _troubleItemModel.strTranslatedTroubleDesc : _troubleItemModel.strTroubleDesc;
    if ([NSString tdd_isEmpty:descStr]) {
        descStr = _troubleItemModel.strTroubleDesc?:@"";
    }

    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:descStr];
    attStr.yy_lineSpacing = 10;
    attStr.yy_font = [[UIFont systemFontOfSize:13] tdd_adaptHD];

    attStr.yy_color = [UIColor tdd_title];
    self.descLab.attributedText = attStr;
    
    if (_troubleItemModel.isShowMore) {
        //旧版伸缩逻辑
        self.descLab.numberOfLines = 0;
        
        [self.descLab layoutIfNeeded];
        
        float height = [NSString tdd_getHeightWithText:_troubleItemModel.strTroubleDesc width:IphoneWidth - 50 * H_Height fontSize:self.descLab.font];
        
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MAX(height, 24.0 * _scale));
        }];
    }else {
        CGSize introSize = CGSizeMake(IphoneWidth - 50 * _scale, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attStr];
        CGFloat introHeight = layout.textBoundingSize.height;
        float height = MIN(introHeight, 72 * _scale);
        self.descLab.numberOfLines = 3;
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MAX(height, 24.0 * _scale));
        }];
    }
    
    int codeLevel = [TDD_Tools troubleCodeLevelWithVehicle:[TDD_ArtiGlobalModel GetVehName] statusStr:_troubleItemModel.strTroubleStatus];
    codeLevel = MIN(codeLevel, 3);
    codeLevel = MAX(codeLevel, 1);
    NSArray *levelArr = @[TDDLocalized.report_trouble_code_status_seriousness,TDDLocalized.report_trouble_code_status_slight,TDDLocalized.diag_ignore];
    NSArray *codeLevelArr = @[@(1),@(2),@(4)];
    NSArray *colorArr = @[[UIColor tdd_errorRed],[UIColor tdd_colorWithHex:0xFF9500],[UIColor tdd_color999999]];
    /*
    NSString * normalImgName = [NSString stringWithFormat:@"trouble_level_%@", codeLevelArr[codeLevel - 1]];
    UIColor *color = colorArr[codeLevel - 1];
     */
    [_stateBtn setBackgroundColor:colorArr[codeLevel - 1]];
    NSString * normalImgName = [NSString stringWithFormat:@"trouble_level_3"];
    UIColor *color = UIColor.tdd_title;
    
    NSString *levelStr = [NSString stringWithFormat:@"%@",levelArr[codeLevel - 1]];
    [_stateImgView setImage:[kImageNamed(normalImgName) tdd_imageByTintColor:color]];
    [_stateLab setText:levelStr];
    [_stateLab setTextColor:color];
    
    UIButton * helpButton = [self viewWithTag:102];
    helpButton.enabled = _troubleItemModel.isShowHelpButton;
    
    UIButton * FreezeStatusButton = [self viewWithTag:103];
    FreezeStatusButton.enabled = _troubleItemModel.isShowFreezeStatus;
}

#pragma mark - action
- (void)searchClick {
    //搜索
    NSString *referrer = @"HealthCheck";
    if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
        referrer = @"EngineInspection";
    }
    [TDD_Statistics event:Event_Troublecodesearch attributes:@{@"TroublecodesearchSkipReferrer": referrer}];
    
    NSString * str = self.troubleItemModel ? self.troubleItemModel.strTroubleCode : self.itemModel.code;
    
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
- (void)functionClick:(UIButton *)sender {
    switch (sender.tag - 100) {
        case 1:
        {
            [self searchClick];
        }
            break;
        case 2:
        {
            //帮助
            NSString *referrer = @"HealthCheck";
            if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
                referrer = @"EngineInspection";
            }
            [TDD_Statistics event:Event_Troublecodehelp attributes:@{@"TroublecodehelpReferrer": referrer}];
            
            if (self.isShowTranslated) {
                if (_troubleItemModel) {
                    [LMSAlertController showDefaultWithTitle:self.troubleItemModel.strTroubleCode content:self.troubleItemModel.strTranslatedTroubleHelp image:nil confirmAction:^(LMSAlertAction * _Nonnull action) {
                                
                    }];
                }

            }else {
                if (_troubleItemModel) {
                    [LMSAlertController showDefaultWithTitle:self.troubleItemModel.strTroubleCode content:self.troubleItemModel.strTroubleHelp image:nil confirmAction:^(LMSAlertAction * _Nonnull action) {
                                
                    }];
                }

            }
        }
            break;
        case 3:
        {
            if ([self.delegate respondsToSelector:@selector(ArtiPopupFuctionButtonClick:)]) {
                [self.delegate ArtiPopupFuctionButtonClick:sender];
            }
            
            NSString *referrer = @"HealthCheck";
            if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
                referrer = @"EngineInspection";
            }
            [TDD_Statistics event:Event_Troublecodefreezeframe attributes:@{@"Event_Troublecodefreezeframe": referrer}];
        }
            break;
        case 4:
        {
            if ([self.delegate respondsToSelector:@selector(ArtiPopupFuctionButtonClick:)]) {
                [self.delegate ArtiPopupFuctionButtonClick:sender];
            }
            
        }
        default:
            break;
    }
}

- (void)moreBtnClick
{
    if (_troubleItemModel) {
        LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.app_confirm titleColor:[UIColor tdd_blue] backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull action) {
            
        }] ;
        [LMSAlertController showWithTitle:self.troubleItemModel.strTroubleCode content:self.troubleItemModel.strTroubleDesc image:nil shouldNoMoreAlert:NO actions:@[action]];
    }else if(_itemModel) {
        LMSAlertAction *action = [[LMSAlertAction alloc] initWithTitle:TDDLocalized.app_confirm titleColor:[UIColor tdd_blue] backgroundColor:nil image:nil :^(LMSAlertAction * _Nonnull action) {
            
        }] ;
        [LMSAlertController showWithTitle:self.itemModel.code content:self.itemModel.content image:nil priority:1002 actions:@[action]];
    }

}

- (void)showStateView {

    CGRect btnFrame = self.stateBtn.bounds;
    CGFloat centerX = CGRectGetMaxX(btnFrame) - btnFrame.size.width / 2.0;
    CGPoint btnBottomCenter = CGPointMake(centerX, CGRectGetMaxY(btnFrame));
    CGPoint point = [self.stateBtn convertPoint:btnBottomCenter toView:[UIApplication sharedApplication].windows.lastObject];
    TDD_ArtiTroubleBubbleView *stateView = [[TDD_ArtiTroubleBubbleView alloc] initWithFrame:CGRectZero];
    
    CGFloat arrowTopOffset = 5.0;
    stateView.arrowTopOffset = arrowTopOffset;
    stateView.arrowDownBottomOffsetBlock = ^CGFloat (CGFloat arrowDownBottom) {
        return arrowDownBottom - arrowTopOffset - btnFrame.size.height;
    };
    
    NSAttributedString *stateStr;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    UIFont *font = [[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular] tdd_adaptHD];
    
    NSString *state;
    if (_troubleItemModel) {
        state = _isShowTranslated ? _troubleItemModel.strTranslatedTroubleStatus : _troubleItemModel.strTroubleStatus;
    } else if (_itemModel) {
        state = _isShowTranslated ? _itemModel.strTranslatedStatus :_itemModel.status;
    }
    if ([NSString tdd_isEmpty:state]) { state = @""; }
    
    stateStr = [[NSMutableAttributedString alloc] initWithString: state attributes:@{ NSForegroundColorAttributeName : [UIColor tdd_title], NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle }];
    
    if (!stateStr || [stateStr.string isEqualToString:@""]) {
        return;
    }
    
    [stateView showWithPopPoint:point content:stateStr];
    
    NSString *referrer = @"HealthCheck";
    if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
        referrer = @"EngineInspection";
    }
    [TDD_Statistics event:Event_Cus_ClickTroubleCodeStatus attributes:@{@"TroubleCodeStatusReferrer": referrer}];
}

@end
