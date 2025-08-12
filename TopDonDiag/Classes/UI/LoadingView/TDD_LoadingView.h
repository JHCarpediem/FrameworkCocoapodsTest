//
//  TDD_LoadingView.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_LoadingView : UIView
+ (void)setBallWidth:(CGFloat)ballWidth;
+ (void)setFirstBallColor:(UIColor *)ballColor;
+ (void)setSecondBallColor:(UIColor *)ballColor;
+ (void)resetStatic;
//显示方法
+ (void)show;
+ (void)showWith:(NSInteger )tag;
//隐藏方法
+ (void)dissmiss;
+ (void)dissmissWith:(NSInteger )tag;

+ (void)dissmissWithDelay:(CGFloat )delay;

- (void)startAnimated;

- (void)stopAnimated;

- (void)setBGColor:(UIColor *)bgColor;
@end

NS_ASSUME_NONNULL_END
