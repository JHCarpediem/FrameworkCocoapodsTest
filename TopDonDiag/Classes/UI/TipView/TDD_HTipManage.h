//
//  TDD_HTipManage.h
//  BT20
//
//  Created by 何可人 on 2021/10/28.
//

#import <Foundation/Foundation.h>
#import "TDD_HTipBtnView.h"
#import "TDD_HTipInputView.h"
#import "TDD_ArtiListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_HTipManage : NSObject
+ (void)showLoadingView;
+ (void)showLoadingViewWithTag:(NSInteger)tag;
+ (void)showLoadingViewWithTitle:(NSString *)title;
+ (void)showNewLoadingViewWithTitle:(NSString *)title;
+ (void)updateLoadingViewWithTitle:(NSString *)title;
+ (void)showBottomTipViewWithTitle:(NSString *)title;
+ (void)showInputTipViewtitle:(NSString *)title tag:(int)tag delayDismiss:(BOOL )delayDismiss completeBlock:(CompleteBlock)completeBlock;
+ (void)showInputTipViewtitle:(NSString *)title tag:(int)tag completeBlock:(CompleteBlock)completeBlock;
+ (void)showInputTipViewtitle:(NSString *)title tag:(int)tag
                 delayDismiss:(BOOL )delayDismiss
                 defaultValue:(NSString *)defaultValue completeBlock:(CompleteBlock)completeBlock;
//+ (void)showBtnTipViewWithDelegata:(id <TDD_HTipBtnViewDelegate> __nullable)delegata title:(NSString *)title buttonType:(HTipBtnType)tipBtnType tag:(int)tag;
//+ (void)showBtnTipViewWithDelegata:(id <TDD_HTipBtnViewDelegate> __nullable)delegata title:(NSString *)title buttonType:(HTipBtnType)tipBtnType buttonTitles:(NSArray *)btnTitles tag:(int)tag;
+ (void)showBtnTipViewWithTitle:(NSString *)title buttonType:(HTipBtnType)tipBtnType block:(void (^)(NSInteger btnTag))clickBlock;
+ (void)showBtnTipViewWithTitle:(NSString *)title content:(NSString *)content buttonType:(HTipBtnType)tipBtnType block:(void (^)(NSInteger btnTag))clickBlock;
+ (void)showSharePopView:(TDD_ArtiListModel *)model;

//+ (void)setTipBtnViewDelegata:(id <TDD_HTipBtnViewDelegate>)tipBtnViewDelegata;
+ (BOOL)tipViewIsSave;
+ (int)getTipViewTag;
+ (void)deallocView;
+ (void)deallocLoadingView;
+ (void)deallocViewWithDelay:(CGFloat )delay;
+ (void)deallocViewWithTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
