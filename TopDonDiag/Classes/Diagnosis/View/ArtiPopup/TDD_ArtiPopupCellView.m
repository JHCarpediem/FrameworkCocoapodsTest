//
//  TDD_ArtiPopupCellView.m
//  TopDonDiag
//
//  Created by fench on 2023/8/29.
//

#import "TDD_ArtiPopupCellView.h"
#import "TDD_DiagnosisManage.h"
#import "TDD_ArtiTroubleShowStateView.h"
#import "TDD_DiagnosisViewController.h"
#import "TDD_ArtiTroubleAIGuildView.h"
@import TDUIProvider;

@interface TDD_ArtiPopupCellView ()
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) TDD_CustomLabel * codeLab;
@property (nonatomic, strong) TDD_CustomLabel * stateLab;
@property (nonatomic, strong) UIButton *stateBtn;
@property (nonatomic, strong) YYLabel * descLab;
@property (nonatomic, strong) UIButton *codeCopyBtn;
@property (nonatomic, strong) CAGradientLayer * gl;
@property (nonatomic, strong) NSMutableArray<UIButton *> * btnArray;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) NSMutableArray<UIView *> * btnLinesArray;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_ArtiPopupCellView

- (instancetype)init{
    self = [super init];
    
    if (self) {
//        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        _scale = IS_IPad ? HD_Height : H_Height;
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI
{
    UIView * view = [[UIView alloc] init];
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    view.layer.shadowOffset = CGSizeMake(4,4);
    view.layer.shadowOpacity = 1 * _scale;
    view.layer.shadowRadius = 10 * _scale;
    [self addSubview:view];
    view.backgroundColor = [UIColor tdd_inputHistoryCellBackground];
    view.layer.cornerRadius = isKindOfTopVCI ? 5 : 3;
    view.layer.masksToBounds = YES;
    self.view = view;
    
    TDD_CustomLabel * codeLab = ({
        // TDD_CustomLabel * label = [[TDD_VXXScrollLabel alloc] init];
        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
        label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
        label;
    });
    [view addSubview:codeLab];
    self.codeLab = codeLab;
    
    UIButton *codeCopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeCopyBtn setBackgroundImage:kImageNamed(@"trouble_copy") forState:UIControlStateNormal];
    [codeCopyBtn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeCopyBtn];
    _codeCopyBtn = codeCopyBtn;
    
    YYLabel * descLab = ({
        YYLabel * label = [[YYLabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
//        label.displaysAsynchronously = YES;
        label.font = [[UIFont systemFontOfSize:13] tdd_adaptHD];
        label.textColor = [UIColor tdd_title];
        label.numberOfLines = 0;
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
    
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.tdd_line;
    [self.view addSubview:lineView];
    self.lineView = lineView;
    
    [self updateBtnsLayoutWithShowTrouble: NO];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 15 * _scale, 0, 15 * _scale));
        make.bottom.equalTo(lineView.mas_bottom).offset(40 * _scale);
    }];
    
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(view).insets(UIEdgeInsetsMake(10 * _scale, 10 * _scale, 0, 0));
        make.width.lessThanOrEqualTo(view).multipliedBy(0.4);
    }];
    
    [codeCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeLab);
        make.left.equalTo(codeLab.mas_right).offset(15 * _scale);
        make.size.mas_equalTo(CGSizeMake(20 * _scale, 20 * _scale));
    }];
    
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(view).insets(UIEdgeInsetsMake(0, 10 * _scale, 0, 10 * _scale));
        make.top.equalTo(codeLab.mas_bottom).mas_equalTo(8 * _scale);
        make.height.mas_equalTo(46 * _scale);
//        make.height.mas_greaterThanOrEqualTo(45 * H_Height);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLab.mas_bottom).offset(10 * _scale);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(0.5);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(10 * _scale).priorityHigh();
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
    NSInteger count = 2;
    
    for (int i = 0; i < count; i ++) {
        UIButton * button = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            int index = i;
            btn.tag = 200 + index;
            if (i == 0){
                [btn setImage:kImageNamed(@"trouble_level_3") forState:UIControlStateNormal];
                NSString *levelStr = [NSString stringWithFormat:@"%@:  %@",TDDLocalized.diag_ignore,TDDLocalized.popup_trouble_code_status_title];
                btn.titleLabel.font = [[UIFont systemFontOfSize:14 weight:UIFontWeightMedium] tdd_adaptHD];
                [btn setTitle:levelStr forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.tdd_width + 4, 0, btn.imageView.tdd_width - 4)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.tdd_width - 4, 0, -btn.titleLabel.tdd_width + 4)];

            }else {
                NSString * normalImgName = [NSString stringWithFormat:@"popup_button_%d", index - 1];
                [btn setImage:[kImageNamed(normalImgName) tdd_imageByTintColor:UIColor.tdd_title] forState:UIControlStateNormal];
            }

            btn;
        });
        [self.view addSubview:button];
        [self.btnArray addObject:button];
        
        if (i < count - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.layer.backgroundColor = UIColor.tdd_line.CGColor;
//            lineView.layer.cornerRadius = 8;
//            lineView.layer.shadowColor = UIColor.tdd_colorFFFFFF.CGColor;
//            lineView.layer.shadowOffset = CGSizeMake(1,0);
//            lineView.layer.shadowOpacity = 1 * H_Height;
//            lineView.layer.shadowRadius = 0;
            [self.view addSubview:lineView];
            [self.btnLinesArray addObject:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.right.equalTo(button).insets(UIEdgeInsetsMake(12 * _scale, 0, 12 * _scale, 0));
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
//            make.size.mas_equalTo(CGSizeMake(26 * H_Height, 26 * H_Height));
//            make.center.equalTo(button);
//        }];
        
        lastButton = button;
    }
}

- (void)showStateView {
//    self.stateView.stateStr = [TDD_DiagnosisManage getDtcNodeStatusDescription:(int)_itemModel.uStatus statusStr:self.isShowTranslated ?_itemModel.strTroubleStatus :_itemModel.strTranslatedTroubleStatus];
    CGPoint point = [self.stateBtn convertPoint:CGPointMake(0,0) toView:[UIApplication sharedApplication].windows.lastObject];
    
    
    TDD_ArtiTroubleShowStateView *stateView = [[TDD_ArtiTroubleShowStateView alloc] init];
    NSString *stateStr = _isShowTranslated ? self.itemModel.strTranslatedStatus : self.itemModel.status;
    NSAttributedString *stateMStr = [TDD_DiagnosisManage getDtcNodeStatusDescription:0 statusStr:stateStr fromTrouble:YES];
    [stateView showWithPopPoint:point content:stateStr];
    
    NSString *referrer = @"HealthCheck";
    if (![[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
        referrer = @"EngineInspection";
    }
    [TDD_Statistics event:Event_Cus_ClickTroubleCodeStatus attributes:@{@"TroubleCodeStatusReferrer": referrer}];
}

- (void)copyAction {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.itemModel.code;
    [TDD_HTipManage showBottomTipViewWithTitle:TDDLocalized.copy_success];
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

- (void)setItemModel:(TDD_ArtiPopupItemModel *)itemModel
{
    _itemModel = itemModel;
    
    self.codeLab.text = itemModel.code;
    
    self.descLab.text = itemModel.content;
    
    //前往故障码详情
    UIButton *troubleDetailBtn = [self.view viewWithTag:201];
    if (troubleDetailBtn){
        troubleDetailBtn.enabled = [itemModel.code.uppercaseString containsString:@"P"];
    }

//    if (itemModel.status.length > 20 ||  [itemModel.status containsString:@"\n"]){
//        self.stateLab.hidden = YES;
//        self.stateBtn.hidden = NO;
//    }else {
//        self.stateLab.hidden = NO;
//        self.stateLab.text = itemModel.status;
//    }
    
    if (itemModel.isShowMore) {
        self.descLab.numberOfLines = 0;
//        self.descLab.truncationToken = nil;
        
        [self.descLab layoutIfNeeded];
        
        float height = [NSString tdd_getHeightWithText:itemModel.content width:IphoneWidth - 50 * H_Height fontSize:self.descLab.font];
        
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    }else {
        self.descLab.numberOfLines = 3;
        
        [self.descLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(46);
        }];
    }
    
    UIButton *btn = [self.view viewWithTag:200];
    int codeLevel = [TDD_Tools troubleCodeLevelWithVehicle:[TDD_ArtiGlobalModel GetVehName] statusStr:_itemModel.status];
    codeLevel = MIN(codeLevel, 3);
    codeLevel = MAX(codeLevel, 1);
    NSArray *levelArr = @[TDDLocalized.report_trouble_code_status_seriousness,TDDLocalized.report_trouble_code_status_slight,TDDLocalized.diag_ignore];
    NSArray *colorArr = @[[UIColor tdd_errorRed],[UIColor tdd_colorWithHex:0xFEC121],UIColor.whiteColor];
    NSString * normalImgName = [NSString stringWithFormat:@"trouble_level_%d", codeLevel];
    UIColor *color = colorArr[codeLevel - 1];
    NSString *levelStr = [NSString stringWithFormat:@"%@:  %@",TDDLocalized.popup_trouble_code_status_title,levelArr[codeLevel - 1]];
    [btn setImage:[kImageNamed(normalImgName) tdd_imageByTintColor:color] forState:UIControlStateNormal];
    [btn setTitle:levelStr forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
}

- (void)buttonClick:(UIButton *)button
{
    long tag = button.tag - 200;
    if (tag == 0) {

    }else if (tag == 1) {
        if ([self.delegate respondsToSelector:@selector(ArtiPopupToTroubleDetailClick:)]){
            [self.delegate ArtiPopupToTroubleDetailClick:self];
        }
    }
}

- (void)moreBtnClick
{
    [LMSAlertController showDefaultWithTitle:self.itemModel.code content:self.itemModel.content image:nil confirmAction:^(LMSAlertAction * _Nonnull action) {
                
    }];
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
    gl.cornerRadius = 10 * H_Height;
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

