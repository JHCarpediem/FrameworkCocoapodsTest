//
//  UIButton+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TDState)
/** 获取当前borderColor */
@property(nullable, nonatomic, readonly, strong) UIColor *td_currentBorderColor;

/** 获取当前backgroundColor */
@property(nullable, nonatomic, readonly, strong) UIColor *td_currentBackgroundColor;

/** 获取当前borderWidth */
@property (nonatomic, readonly, assign) CGFloat td_currentBorderWidth;

/** 获取当前titleLabelFont */
@property(nonatomic, readonly, strong) UIFont *td_currentTitleLabelFont;


/** 设置不同状态下的borderColor(支持动画效果),需先设置borderWidth */
- (void)td_setborderColor:(UIColor *)borderColor forState:(UIControlState)state animated:(BOOL)animated;

/** 设置不同状态下的borderWidth(支持动画效果) */
- (void)td_setborderWidth:(CGFloat)borderWidth forState:(UIControlState)state animated:(BOOL)animated;

/** 设置不同状态下的backgroundColor(支持动画效果) */
- (void)td_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated;

/** 设置不同状态下的titleLabelFont */
- (void)td_setTitleLabelFont:(UIFont *)titleLabelFont forState:(UIControlState)state;

/** 获取某个状态的borderColor */
- (nullable UIColor *)td_borderColorForState:(UIControlState)state;

/** 获取某个状态的borderWidth */
- (CGFloat)td_borderWidthForState:(UIControlState)state;

/** 获取某个状态的backgroundColor */
- (nullable UIColor *)td_backgroundColorForState:(UIControlState)state;

/** 获取某个状态的titleLabelFont */
- (UIFont *)td_titleLabelFontForState:(UIControlState)state;


/** 为自己的subView设置不同状态下的属性 */
- (void)td_setSubViewValue:(nullable id)value forKeyPath:(NSString *)keyPath forState:(UIControlState)state withSubViewTag:(NSInteger)tag;


#pragma mark - 使用key-value方式设置
/** key:需要将UIControlState枚举包装为NSNumber类型即可(此方式无动画),需先设置borderWidth */
- (void)td_configBorderColors:(NSDictionary <NSNumber *,UIColor *>*)borderColors;

/** key:需要将UIControlState枚举包装为NSNumber类型即可(此方式无动画) */
- (void)td_configBackgroundColors:(NSDictionary <NSNumber *,UIColor *>*)backgroundColors;

/** key:需要将UIControlState枚举包装为NSNumber类型即可 */
- (void)td_configTitleLabelFont:(NSDictionary <NSNumber *,UIFont *>*)titleLabelFonts;


/** 切换按钮状态时,执行动画的时间,默认0.25s(只有动画执行完毕后,才能会执行下一个点击事件) */
@property (nonatomic, assign) NSTimeInterval td_animatedDuration;

@end

NS_ASSUME_NONNULL_END
