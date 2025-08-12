//
//  TDD_HTipManage.m
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import "TDD_HTipManage.h"
#import "TDD_HLoadingView.h"
#import "TDD_LoadingView.h"
#import "TDD_HTipBtnView.h"
#import "TDD_HTipInputView.h"
#import "TDD_ArtiShareView.h"
@import TDBasis;
@import TDUIProvider;
@interface TDD_HTipManage ()
@property (nonatomic, strong) TDD_TipBaseView * tipView;
@property (nonatomic, strong) TDD_CustomLabel * bottomTipLabel;
@property (nonatomic, weak) id <TDD_HTipBtnViewDelegate> tipBtnViewDelegata;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation TDD_HTipManage
#pragma mark 创建单例
+(TDD_HTipManage *)sharedHTipManage {
    static TDD_HTipManage *tipManage = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        tipManage = [[self alloc] init];
        tipManage.scale = IS_IPad ? HD_Height : H_Height;
    });
    return tipManage;
}

+ (void)showLoadingView {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [TDD_HTipManage showNewLoadingViewWithTitle:nil];
        //[self showLoadingViewWithTitle:@"tip_loading"];
    });
}

+ (void)showLoadingViewWithTag:(NSInteger)tag {
    dispatch_async(dispatch_get_main_queue(), ^{

        [TDD_LoadingView showWith:tag];
    });
}

+ (void)showLoadingViewWithTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[self sharedHTipManage].tipView isKindOfClass: [TDD_HLoadingView class]]) {
            [self updateLoadingViewWithTitle:title];
        }else {
            [self deallocView];
            
            TDD_HLoadingView * loadingView = [[TDD_HLoadingView alloc] initWithTitle:title];
            
            [FLT_APP_WINDOW addSubview:loadingView];
            
            [self sharedHTipManage].tipView = loadingView;
        }
    });
}

+ (void)showNewLoadingViewWithTitle:(NSString *)title {
    [TDHUD showLoadingWith:title delay:60 inView:nil];
    return;
//    [self deallocView];
//
//    TDD_TipBaseView *backView = [[TDD_TipBaseView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
//    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    [FLT_APP_WINDOW addSubview:backView];
//    [self sharedHTipManage].tipView = backView;
//
//    UIView * whiteView = [[UIView alloc] init];
//    whiteView.backgroundColor =  UIColor.tdd_alertBg;
//    whiteView.layer.cornerRadius = 10;
//    
//    TDD_LoadingView *loadingView = [[TDD_LoadingView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
//
//    TDD_CustomLabel *label = [[TDD_CustomLabel alloc] init];
//    label.font = [[UIFont systemFontOfSize:15] tdd_adaptHD];
//    label.textColor = [UIColor tdd_title];
//    label.text = title;
//    label.numberOfLines = 0;
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    [backView addSubview:whiteView];
//    [whiteView addSubview:loadingView];
//    [whiteView addSubview:label];
//    
//    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.equalTo(backView);
//        make.width.equalTo(@(IphoneWidth-90));
//        make.height.equalTo(@((IphoneWidth-90)*3/5.0));
//    }];
//    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(whiteView);
//        make.centerY.equalTo(@-10);
//        make.width.height.equalTo(@(70));
//    }];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(loadingView.mas_bottom).offset(15);
//        make.left.equalTo(@15);
//        make.centerX.equalTo(whiteView);
//        make.bottom.lessThanOrEqualTo(@-20);
//    }];
}

+ (void)showSharePopView:(TDD_ArtiListModel *)model {
    [self deallocView];

    TDD_ArtiShareView *backView = [[TDD_ArtiShareView alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight) model:model];
    [FLT_APP_WINDOW addSubview:backView];
    [self sharedHTipManage].tipView = backView;
}

+ (void)updateLoadingViewWithTitle:(NSString *)title{
    if ([[self sharedHTipManage].tipView isKindOfClass:[TDD_HLoadingView class]]) {
        [(TDD_HLoadingView *)[self sharedHTipManage].tipView updateTitle:title];
    }else{
        [self showLoadingViewWithTitle:title];
    }
}

+ (void)showBottomTipViewWithTitle:(NSString *)title{
    [[self sharedHTipManage].bottomTipLabel removeFromSuperview];
    CGFloat fontSize = IS_IPad ? 20 : 14;
    title = [TDD_HLanguage getLanguage:title];
    [TDHUD showMessage:title];
    //使用 TDHUD
    return;
//    
//    float tipLab_h = 32 * [self sharedHTipManage].scale;
//    
//    float tipLab_w = [NSString tdd_getWidthWithText:title height:tipLab_h fontSize:[[UIFont systemFontOfSize:fontSize] tdd_adaptHD]] + 20 * [self sharedHTipManage].scale;
//    
//    if (tipLab_w > IphoneWidth - 60 * [self sharedHTipManage].scale) {
//        tipLab_w = IphoneWidth - 60 * [self sharedHTipManage].scale;
//        
//        tipLab_h = [NSString tdd_getHeightWithText:title width:tipLab_w fontSize:[[UIFont systemFontOfSize:14] tdd_adaptHD]] + 20 * [self sharedHTipManage].scale;
//        
//        tipLab_w += 20 * [self sharedHTipManage].scale;
//    }
//    
//    TDD_CustomLabel * tipLab = ({
//        TDD_CustomLabel * label = [[TDD_CustomLabel alloc] init];
//        label.frame = CGRectMake(0, IphoneHeight - IS_iPhoneX - 63 * [self sharedHTipManage].scale, tipLab_w, tipLab_h);
//        label.center = CGPointMake(IphoneWidth / 2, IphoneHeight - IS_iPhoneX - 47 * [self sharedHTipManage].scale);
//        label.text = [TDD_HLanguage getLanguage:title];
//        label.font = [[UIFont systemFontOfSize:fontSize] tdd_adaptHD];
//        label.textColor = [UIColor whiteColor];
//        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.layer.cornerRadius = 4;
//        label.numberOfLines = 0;
//        label.clipsToBounds = YES;
//        
//        label;
//    });
//    [FLT_APP_WINDOW addSubview:tipLab];
//    [self sharedHTipManage].bottomTipLabel = tipLab;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [tipLab removeFromSuperview];
//    });
}

//+ (void)showBtnTipViewWithDelegata:(id <TDD_HTipBtnViewDelegate>)delegata title:(NSString *)title buttonType:(HTipBtnType)tipBtnType tag:(int)tag{
//    [self deallocView];
//    
//    TDD_HTipBtnView * tipBtnView = [[TDD_HTipBtnView alloc] initWithTitle:title buttonType:tipBtnType];
//    tipBtnView.tag = 500500 + tag;
//    if (delegata) {
//        tipBtnView.delegata = delegata;
//    }
//    [FLT_APP_WINDOW addSubview:tipBtnView];
//    
//    [self sharedHTipManage].tipView = tipBtnView;
//}
//
//+ (void)showBtnTipViewWithDelegata:(id <TDD_HTipBtnViewDelegate> __nullable)delegata title:(NSString *)title buttonType:(HTipBtnType)tipBtnType buttonTitles:(NSArray *)btnTitles tag:(int)tag
//{
//    TDD_HTipBtnView * tipBtnView = [[TDD_HTipBtnView alloc] initWithTitle:title buttonType:tipBtnType];
//    [tipBtnView setupButtonTitles:btnTitles];
//    tipBtnView.tag = 500500 + tag;
//    if (delegata) {
//        tipBtnView.delegata = delegata;
//    }
//    [FLT_APP_WINDOW addSubview:tipBtnView];
//    
//    [self sharedHTipManage].tipView = tipBtnView;
//}

+ (void)showBtnTipViewWithTitle:(NSString *)title buttonType:(HTipBtnType)tipBtnType block:(void (^)(NSInteger btnTag))clickBlock {
    [TDD_HTipManage showBtnTipViewWithTitle:title content:nil buttonType:tipBtnType block:clickBlock];
    return;
//    TDD_HTipBtnView * tipBtnView = [[TDD_HTipBtnView alloc] initWithTitle:title buttonType:tipBtnType];
//    if(clickBlock){
//        tipBtnView.clickBlock = clickBlock;
//    }
//    [FLT_APP_WINDOW addSubview:tipBtnView];
//    
//    [self sharedHTipManage].tipView = tipBtnView;
}

+ (void)showBtnTipViewWithTitle:(NSString *)title content:(NSString *)content buttonType:(HTipBtnType)tipBtnType block:(void (^)(NSInteger btnTag))clickBlock {
    [self deallocView];
    if (tipBtnType == HTipBtnOneType) {
        LMSAlertAction *confirmAction = [LMSAlertAction confirmAction];
        confirmAction.action = ^(LMSAlertAction * _Nonnull action) {
            if (clickBlock) {
                clickBlock(0);
            }
        };
        [LMSAlertController showWithTitle:title content:content image:nil priority:1002 actions:@[confirmAction]];
    }else {
        [LMSAlertController showDefaultWithTitle:title content:content image:nil confirmAction:^(LMSAlertAction * _Nonnull action) {
            if (clickBlock) {
                clickBlock(1);
            }
        } cacncelAction:^(LMSAlertAction * _Nonnull action) {
            if (clickBlock) {
                clickBlock(0);
            }
        }];
    }
}

+ (void)showInputTipViewtitle:(NSString *)title tag:(int)tag delayDismiss:(BOOL )delayDismiss completeBlock:(CompleteBlock)completeBlock{
    [self deallocView];
    
    TDD_HTipInputView * tipBtnView = [[TDD_HTipInputView alloc] initWithTitle:title delayDismiss:delayDismiss completeBlock:completeBlock];
    tipBtnView.tag = 500500 + tag;
    [FLT_APP_WINDOW addSubview:tipBtnView];
//    tipBtnView.inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    tipBtnView.showClearBtn = YES;
    
    [self sharedHTipManage].tipView = tipBtnView;
}

+ (void)showInputTipViewtitle:(NSString *)title tag:(int)tag completeBlock:(CompleteBlock)completeBlock{
    [self deallocView];
    
    TDD_HTipInputView * tipBtnView = [[TDD_HTipInputView alloc] initWithTitle:title completeBlock:completeBlock];
    tipBtnView.tag = 500500 + tag;
    [FLT_APP_WINDOW addSubview:tipBtnView];
//    tipBtnView.inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    tipBtnView.showClearBtn = YES;
    
    [self sharedHTipManage].tipView = tipBtnView;
}

+ (void)showInputTipViewtitle:(NSString *)title tag:(int)tag
                 delayDismiss:(BOOL )delayDismiss
                 defaultValue:(NSString *)defaultValue completeBlock:(CompleteBlock)completeBlock {
    [self deallocView];
    
    TDD_HTipInputView * tipBtnView = [[TDD_HTipInputView alloc] initWithTitle:title delayDismiss:delayDismiss defaultValue:defaultValue completeBlock:completeBlock];
    tipBtnView.tag = 500500 + tag;
    [FLT_APP_WINDOW addSubview:tipBtnView];
    tipBtnView.showClearBtn = YES;
    
    [self sharedHTipManage].tipView = tipBtnView;
    
}

//+ (void)setTipBtnViewDelegata:(id <TDD_HTipBtnViewDelegate>)tipBtnViewDelegata{
//    [self sharedHTipManage].tipBtnViewDelegata = tipBtnViewDelegata;
//    
//    if ([[self sharedHTipManage].tipView isKindOfClass:[TDD_HTipBtnView class]]) {
//        [(TDD_HTipBtnView *)[self sharedHTipManage].tipView setDelegata:[self sharedHTipManage].tipBtnViewDelegata];
//    }
//}

+ (BOOL)tipViewIsSave{
    if ([self sharedHTipManage].tipView.superview) {
        return YES;
    }
    return NO;
}

+ (int)getTipViewTag{
    int tag = (int)[self sharedHTipManage].tipView.tag - 500500;
    
    if (tag > 0) {
        return tag;
    }else{
        return 0;
    }
}

+ (void)deallocView{
    [TDHUD hideLoading];
    [TDD_LoadingView dissmissWithDelay:0.1];
    [[self sharedHTipManage].tipView deallocView];
    [self sharedHTipManage].tipView = nil;
}

+ (void)deallocLoadingView{
    [TDD_LoadingView dissmissWithDelay:0.1];
}

+ (void)deallocViewWithDelay:(CGFloat )delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TDD_LoadingView dissmiss];
        [[self sharedHTipManage].tipView deallocView];
        [self sharedHTipManage].tipView = nil;
    });
}

+ (void)deallocViewWithTag:(NSInteger)tag {
    dispatch_async(dispatch_get_main_queue(), ^{
        [TDD_LoadingView dissmissWith:tag];
    });
}
@end
