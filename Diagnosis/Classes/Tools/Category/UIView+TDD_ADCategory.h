//
//  UIView+TDD_ADCategory.h
//  AD200
//
//  Created by yong liu on 2022/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TDD_LinePositionType) {
    TDD_LinePositionTypeTop = 0,
    TDD_LinePositionTypeLeft,
    TDD_LinePositionTypeBottom,
    TDD_LinePositionTypeRight
};

@interface UIView (TDD_ADCategory)


/// 设置圆角
/// @param radius 弧度
- (void)tdd_addCornerRadius:(float)radius;


@property (nonatomic) CGFloat tdd_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat tdd_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat tdd_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat tdd_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat tdd_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat tdd_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat tdd_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat tdd_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint tdd_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  tdd_size;        ///< Shortcut for frame.size.


/// 给view 添加 line
/// - Parameters:
///   - positionType: 添加的位置  top / left / bottom / right
///   - tag: line 的 tag
///   - lineWidth: line 的宽度
///   - lineColor: line 的颜色
///   - edgeInsets: line 的内边距
- (void)tdd_addLine:(TDD_LinePositionType)positionType lineTag:(NSInteger)tag lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor edgeInsets:(UIEdgeInsets)edgeInsets;

- (NSString *)tdd_className;

- (void)tdd_addRoundCorner:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner;
@end

NS_ASSUME_NONNULL_END
