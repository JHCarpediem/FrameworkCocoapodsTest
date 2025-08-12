//
//  UIButton+TDD_ClickRange.h
//  BTMobile Pro
//
//  Created by 何可人 on 2021/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TDD_ClickRange)
/**
自定义响应边界 UIEdgeInsetsMake(-3, -4, -5, -6). 表示扩大
例如： self.btn.tdd_hitEdgeInsets = UIEdgeInsetsMake(-3, -4, -5, -6);
*/
@property(nonatomic, assign) UIEdgeInsets tdd_hitEdgeInsets;
/**
 自定义响应边界 自定义的边界的范围 范围扩大3.0
 例如：self.btn.tdd_hitScale = 3.0;
 */
@property(nonatomic, assign) CGFloat tdd_hitScale;
/*
 自定义响应边界 自定义的宽度的范围 范围扩大3.0
 例如：self.btn.tdd_hitWidthScale = 3.0;
 */
@property(nonatomic, assign) CGFloat tdd_hitWidthScale;

/*
 自定义响应边界 自定义的高度的范围 范围扩大3.0
 例如：self.btn.tdd_hitHeightScale = 3.0;
 */
@property(nonatomic, assign) CGFloat tdd_hitHeightScale;
@end

NS_ASSUME_NONNULL_END
