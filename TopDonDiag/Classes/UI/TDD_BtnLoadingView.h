//
//  TDD_BtnLoadingView.h
//  TopDonDiag
//
//  Created by yong liu on 2023/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TDD_BtnLoadingViewDelegate <NSObject>

- (void)loadingBtnClick;

@end

@interface TDD_BtnLoadingView : UIView

@property (nonatomic, weak) id<TDD_BtnLoadingViewDelegate> delegate;

/// 翻译按钮loading动画
- (void)showTranslateAnimate:(BOOL)show;

/// 翻译是否完成
- (void)showTranslateFinish:(BOOL)finish;


@end

NS_ASSUME_NONNULL_END
