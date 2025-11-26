//
//  TDD_DashLineView.h
//  AD200
//
//  Created by lecason on 2022/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDD_DashLineView : UIView

/*!
 *  @brief 虚线颜色。
 */
@property(nonatomic,strong)IBInspectable UIColor* dashLineColor;
/*!
 *  @brief 虚线点之间的间距
 */

@property(nonatomic,assign)IBInspectable NSInteger lineDotSpacing;
/*!
 *  @brief 虚线点的宽度。
 */
@property(nonatomic,assign)IBInspectable NSInteger lineDotWidth;

/*!
 *  @brief 虚线的方向，横向和竖向。
 */
@property(nonatomic,assign,getter=isVertical)IBInspectable BOOL vertical;

/*!
 *  @brief 虚线的方向，横向和竖向。
 */
@property(nonatomic,assign,getter=isCircleDot)IBInspectable BOOL circleDot;

@end

NS_ASSUME_NONNULL_END
