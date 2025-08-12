//
//  UIView+TDD_ADCategory.m
//  AD200
//
//  Created by yong liu on 2022/7/14.
//

#import "UIView+TDD_ADCategory.h"

@implementation UIView (TDD_ADCategory)

- (void)tdd_addCornerRadius:(float) radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)tdd_left {
    return self.frame.origin.x;
}

- (void)setTdd_left:(CGFloat)tdd_left {
    CGRect frame = self.frame;
    frame.origin.x = tdd_left;
    self.frame = frame;
}

- (CGFloat)tdd_top {
    return self.frame.origin.y;
}

- (void)setTdd_top:(CGFloat)tdd_top {
    CGRect frame = self.frame;
    frame.origin.y = tdd_top;
    self.frame = frame;
}

- (CGFloat)tdd_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTdd_right:(CGFloat)tdd_right {
    CGRect frame = self.frame;
    frame.origin.x = tdd_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)tdd_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTdd_bottom:(CGFloat)tdd_bottom {
    CGRect frame = self.frame;
    frame.origin.y = tdd_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)tdd_width {
    return self.frame.size.width;
}

- (void)setTdd_width:(CGFloat)tdd_width {
    CGRect frame = self.frame;
    frame.size.width = tdd_width;
    self.frame = frame;
}

- (CGFloat)tdd_height {
    return self.frame.size.height;
}

- (void)setTdd_height:(CGFloat)tdd_height {
    CGRect frame = self.frame;
    frame.size.height = tdd_height;
    self.frame = frame;
}

- (CGFloat)tdd_centerX {
    return self.center.x;
}

- (void)setTdd_centerX:(CGFloat)tdd_centerX {
    self.center = CGPointMake(tdd_centerX, self.center.y);
}

- (CGFloat)tdd_centerY {
    return self.center.y;
}

- (void)setTdd_centerY:(CGFloat)tdd_centerY{
    self.center = CGPointMake(self.center.x, tdd_centerY);
}

- (CGPoint)tdd_origin {
    return self.frame.origin;
}

- (void)setTdd_origin:(CGPoint)tdd_origin {
    CGRect frame = self.frame;
    frame.origin = tdd_origin;
    self.frame = frame;
}

- (CGSize)tdd_size {
    return self.frame.size;
}

- (void)setTdd_size:(CGSize)tdd_size {
    CGRect frame = self.frame;
    frame.size = tdd_size;
    self.frame = frame;
}

- (void)tdd_addLine:(TDD_LinePositionType)positionType lineTag:(NSInteger)tag lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor edgeInsets:(UIEdgeInsets)edgeInsets {
    UIView *line = [UIView new];
    line.backgroundColor = lineColor;
    [self insertSubview:line atIndex:0];
    line.opaque = NO;
    line.tag = tag;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (positionType) {
            case TDD_LinePositionTypeTop:
            {
                make.left.right.top.equalTo(self).insets(edgeInsets);
                make.height.mas_equalTo(lineWidth);
            }
                break;
            case TDD_LinePositionTypeBottom:
            {
                make.left.right.bottom.equalTo(self).insets(edgeInsets);
                make.height.mas_equalTo(lineWidth);
            }
                break;
            case TDD_LinePositionTypeLeft:
            {
                make.top.bottom.left.equalTo(self).insets(edgeInsets);
                make.width.mas_equalTo(lineWidth);
            }
                break;
            case TDD_LinePositionTypeRight:
            {
                make.top.bottom.right.equalTo(self).insets(edgeInsets);
                make.width.mas_equalTo(lineWidth);
            }
                break;
        }
    }];
}

- (NSString *)tdd_className
{
    return [NSString stringWithUTF8String:class_getName([self class])];
}

#pragma mark - 给View添加圆角 并 设置切那几个角
- (void)tdd_addRoundCorner:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
