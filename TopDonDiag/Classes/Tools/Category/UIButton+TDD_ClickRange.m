//
//  UIButton+TDD_ClickRange.m
//  BTMobile Pro
//
//  Created by 何可人 on 2021/3/17.
//

#import "UIButton+TDD_ClickRange.h"

#import <objc/runtime.h>


static const char * kHitEdgeInsets = "hitEdgeInset";
static const char * kHitScale = "tdd_hitScale";
static const char * kHitWidthScale = "tdd_hitWidthScale";
static const char * kHitHeightScale = "tdd_hitWidthScale";

@implementation UIButton (TDD_ClickRange)

#pragma mark - set Method
- (void)setTdd_hitEdgeInsets:(UIEdgeInsets)tdd_hitEdgeInsets {
    NSValue *value = [NSValue value:&tdd_hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, kHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTdd_hitScale:(CGFloat)tdd_hitScale {
    CGFloat width = self.bounds.size.width * tdd_hitScale;
    CGFloat height = self.bounds.size.height * tdd_hitScale;
    self.tdd_hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitScale, @(tdd_hitScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTdd_hitWidthScale:(CGFloat)tdd_hitWidthScale {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * tdd_hitWidthScale;
    self.tdd_hitEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    objc_setAssociatedObject(self, kHitScale, @(tdd_hitWidthScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTdd_hitHeightScale:(CGFloat)tdd_hitHeightScale {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * tdd_hitHeightScale;
    self.tdd_hitEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    objc_setAssociatedObject(self, kHitHeightScale, @(kHitHeightScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - get method
-(UIEdgeInsets)tdd_hitEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, kHitEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets:UIEdgeInsetsZero;
}

-(CGFloat)tdd_hitScale{
    return [objc_getAssociatedObject(self, kHitScale) floatValue];
}

-(CGFloat)tdd_hitWidthScale{
    return [objc_getAssociatedObject(self, kHitWidthScale) floatValue];
}

-(CGFloat)tdd_hitHeightScale{
    return [objc_getAssociatedObject(self, kHitHeightScale) floatValue];
}

#pragma mark - override super method
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //如果 button 边界值无变化  失效 隐藏 或者透明 直接返回
    if(UIEdgeInsetsEqualToEdgeInsets(self.tdd_hitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden || self.alpha == 0 ) {
        return [super pointInside:point withEvent:event];
    }else{
        CGRect relativeFrame = self.bounds;
        CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.tdd_hitEdgeInsets);
        return CGRectContainsPoint(hitFrame, point);
    }
}

@end
