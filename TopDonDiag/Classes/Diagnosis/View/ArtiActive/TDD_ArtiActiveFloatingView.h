//
//  TDD_ArtiActiveFloatingView.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2022/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TDD_ArtiActiveFloatingViewDelegate <NSObject>
/// 点击悬浮窗回调
- (void)floatingViewDidClickView;

@end
@interface TDD_ArtiActiveFloatingView : UIView
@property (nonatomic, weak) id<TDD_ArtiActiveFloatingViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TDD_ArtiActiveFloatingViewDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
