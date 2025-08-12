//
//  TDD_NaviMoreBtnView.h
//  TopDonDiag
//
//  Created by yong liu on 2023/9/11.
//

#import <UIKit/UIKit.h>
#import "TDD_BtnLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TDD_NaviMoreBtnViewDelegate <NSObject>

- (void)navMoreBtnClick:(NSInteger )btnIndex;

- (void)setDiagNaviTypeSearch;

@end

@interface TDD_NaviMoreBtnView : UIView

@property (nonatomic, strong) TDD_BtnLoadingView *translateView;
//UI暂时只能加2个按钮
@property (nonatomic, strong) NSArray <NSNumber *>*showBtnArray;
@property (nonatomic, weak) id<TDD_NaviMoreBtnViewDelegate> delegate;

- (void)show;


- (void)dismiss;

/// 翻译按钮loading动画
- (void)showTranslateAnimate:(BOOL)show;

/// 翻译是否完成
- (void)showTranslateFinish:(BOOL)finish;

@end

NS_ASSUME_NONNULL_END
