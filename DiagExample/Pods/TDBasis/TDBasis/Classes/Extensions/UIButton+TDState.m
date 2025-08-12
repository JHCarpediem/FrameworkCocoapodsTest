//
//  UIButton+TDExtension.swift
//  Pods-TDBasis
//
//  Created by fench on 2023/7/10.
//


#define objc_setObjRETAIN(key,value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define objc_getObj(key) objc_getAssociatedObject(self, key)

#define objc_exchangeMethodAToB(methodA,methodB) method_exchangeImplementations(class_getInstanceMethod([self class], methodA),class_getInstanceMethod([self class], methodB));

#define backgroundColorKEY(state) [NSString stringWithFormat:@"`td_backgroundColor`%zd",state]
#define borderColorKEY(state) [NSString stringWithFormat:@"td_borderColor%zd",state]
#define borderWidthKEY(state) [NSString stringWithFormat:@"td_borderWidth%zd",state]

#import "UIButton+TDState.h"
#import <objc/runtime.h>


//Model
@interface TDPropertyModel : NSObject
@property (nonatomic, assign) UIControlState state;
@property (nonatomic, copy)   NSString *keyPath;
@property (nonatomic, weak)   id value;
+ (instancetype)propertyModelWithValue:(nullable id)value keyPath:(NSString *)keyPath state:(UIControlState)state;
@end

@implementation TDPropertyModel
+ (instancetype)propertyModelWithValue:(id)value keyPath:(NSString *)keyPath state:(UIControlState)state {
    TDPropertyModel *model = [TDPropertyModel new];
    model.value = value;
    model.keyPath = keyPath;
    model.state = state;
    return model;
}
@end

@interface UIButton ()
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSNumber *>*animates;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, UIColor *>*borderColors;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, NSNumber *>*borderWidths;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, UIColor *>*backgroundColors;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, UIFont *>*titleLabelFonts;
@property (nonatomic, strong) NSMutableArray <TDPropertyModel *>*subViewPropertyArr;
@property (nonatomic, assign) NSInteger subViewTag;

@end
@implementation UIButton (TDState)
#pragma mark - lefe cycle
+ (void)load {
    objc_exchangeMethodAToB(@selector(setHighlighted:),
                            @selector(td_setHighlighted:));
    objc_exchangeMethodAToB(@selector(setEnabled:),
                            @selector(td_setEnabled:));
    objc_exchangeMethodAToB(@selector(setSelected:),
                            @selector(td_setSelected:));
}

#pragma mark - public method
- (nullable UIColor *)td_currentBorderColor {
    UIColor *color = [self td_borderColorForState:self.state];
    if (!color) {
        color = [UIColor colorWithCGColor:self.layer.borderColor];
    }
    return color;
}

- (CGFloat)td_currentBorderWidth {
    CGFloat width = [self td_borderWidthForState:self.state-1];
    if (!width) {
        width = self.layer.borderWidth;
    }
    return width;
}

- (nullable UIColor *)td_currentBackgroundColor {
    UIColor *color = [self td_backgroundColorForState:self.state];
    if (!color) {
        color = self.backgroundColor;
    }
    return color;
}

- (UIFont *)td_currentTitleLabelFont {
    UIFont *font = [self td_titleLabelFontForState:(self.state-1)];
    if (!font) {
        font = self.titleLabel.font;
    }
    return font;
}


- (void)td_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated {
    if (backgroundColor) {
        [self.backgroundColors setObject:backgroundColor forKey:@(state)];
        [self.animates setObject:@(animated) forKey:backgroundColorKEY(state)];
    }
    if(self.state == state) {
        self.backgroundColor = backgroundColor;
    }
}

- (void)td_setborderColor:(UIColor *)borderColor forState:(UIControlState)state animated:(BOOL)animated {
    if (borderColor) {
        [self.borderColors setObject:borderColor forKey:@(state)];
        [self.animates setObject:@(animated) forKey:borderColorKEY(state)];
    }
    if(self.state == state) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)td_setborderWidth:(CGFloat)borderWidth forState:(UIControlState)state animated:(BOOL)animated {
    
    [self.borderWidths setObject:@(borderWidth) forKey:@(state)];
    [self.animates setObject:@(animated) forKey:borderWidthKEY(state)];
    
    if(self.state == state) {
        self.layer.borderWidth = borderWidth;
    }
}

- (void)td_setTitleLabelFont:(UIFont *)titleLabelFont forState:(UIControlState)state {
    if (titleLabelFont) {
        [self.titleLabelFonts setObject:titleLabelFont forKey:@(state)];
    }
    if(self.state == state) {
        self.titleLabel.font = titleLabelFont;
    }
}

- (nullable UIColor *)td_borderColorForState:(UIControlState)state {
    return [self.borderColors objectForKey:@(state)];
}

- (CGFloat)td_borderWidthForState:(UIControlState)state {
#if defined(__LP64__) && __LP64__
    return [[self.borderWidths objectForKey:@(state)] doubleValue];
#else
    return [[self.borderWidths objectForKey:@(state)] floatValue];
#endif
}

- (nullable UIColor *)td_backgroundColorForState:(UIControlState)state {
    return [self.backgroundColors objectForKey:@(state)];
}

- (UIFont *)td_titleLabelFontForState:(UIControlState)state {
    return [self.titleLabelFonts objectForKey:@(state)];
}

- (void)td_configBorderColors:(NSDictionary <NSNumber *,UIColor *>*)borderColors {
    self.borderColors = [borderColors mutableCopy];
    [borderColors enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIColor * _Nonnull obj, BOOL * _Nonnull stop) {
        [self.animates setObject:@(NO) forKey:borderColorKEY(key.integerValue)];
    }];
    [self updateButton];
}

- (void)td_configBackgroundColors:(NSDictionary <NSNumber *,UIColor *>*)backgroundColors {
    self.backgroundColors = [backgroundColors mutableCopy];
    [backgroundColors enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIColor * _Nonnull obj, BOOL * _Nonnull stop) {
        [self.animates setObject:@(NO) forKey:backgroundColorKEY(key.integerValue)];
    }];
    [self updateButton];
}

- (void)td_configTitleLabelFont:(NSDictionary<NSNumber *,UIFont *> *)titleLabelFonts {
    self.titleLabelFonts = [titleLabelFonts mutableCopy];
    [self updateButton];
}

- (void)td_setSubViewValue:(nullable id)value forKeyPath:(NSString *)keyPath forState:(UIControlState)state withSubViewTag:(NSInteger)tag {
    UIView *subView = [self viewWithTag:tag];
    self.subViewTag = tag;
    if (keyPath) {
        //不能为空
        id nonNullValue = value ? value : [NSNull null];
        TDPropertyModel *model = [TDPropertyModel propertyModelWithValue:nonNullValue keyPath:keyPath state:state];
        [self.subViewPropertyArr addObject:model];
    }

   [self.subViewPropertyArr enumerateObjectsUsingBlock:^(TDPropertyModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
       if (self.state == model.state) {
           //可以为空
           id nullableValue = (model.value == [NSNull null]) ? nil : model.value;
           [subView setValue:nullableValue forKeyPath:model.keyPath];
       }
   }];

}

#pragma mark - override
- (void)td_setSelected:(BOOL)selected {
    [self td_setSelected:selected];
    [self updateButton];
}

- (void)td_setEnabled:(BOOL)enabled {
    [self td_setEnabled:enabled];
    [self updateButton];
}

- (void)td_setHighlighted:(BOOL)highlighted {
    [self td_setHighlighted:highlighted];
    [self updateButton];
}

#pragma mark - private method
- (void)updateButton {
    //updateBackgroundColor
    UIColor *backgroundColor = [self td_backgroundColorForState:self.state];
    if (backgroundColor) {
        [self updateBackgroundColor:backgroundColor];
    } else {
        UIColor *normalColor = [self td_backgroundColorForState:UIControlStateNormal];
        if (normalColor) {
            [self updateBackgroundColor:normalColor];
        }
    }
    
    //updateBorderColor
    UIColor *borderColor = [self td_borderColorForState:self.state];
    if (borderColor) {
        [self updateBorderColor:borderColor];
    } else {
        UIColor *normalColor = [self td_borderColorForState:UIControlStateNormal];
        if (normalColor) {
            [self updateBorderColor:normalColor];
        }
    }
    
    //updateBorderWidth
    CGFloat borderWidth = [self td_borderWidthForState:self.state];
    [self updateBorderWidth:borderWidth];
    
    //updateTitleLabelFont
    UIFont *titleLabelFont = [self td_titleLabelFontForState:self.state];
    if (titleLabelFont) {
        self.titleLabel.font = titleLabelFont;
    } else {
        UIFont *normalFont = [self td_titleLabelFontForState:UIControlStateNormal];
        if (normalFont) {
            self.titleLabel.font = normalFont;
        }
    }
    
    //updateSubViewProperty
    UIView *subView = [self viewWithTag:self.subViewTag];
    if (subView && self.subViewPropertyArr.count>0) {
        [self.subViewPropertyArr enumerateObjectsUsingBlock:^(TDPropertyModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            //点击一次,方法多次调用,model.value可能为nil,此时不应进入赋值,否则覆盖掉之前的值
            if (self.state == model.state && model.value) {
                //转换成nil
                id nullableValue = (model.value == [NSNull null]) ? nil : model.value;
                [subView setValue:nullableValue forKeyPath:model.keyPath];
            }
        }];
    }
}

- (void)updateBackgroundColor:(UIColor *)backgroundColor {
    NSNumber *animateValue = [self.animates objectForKey:backgroundColorKEY(self.state)];
    if (!animateValue) return;//不存在
    
    if (animateValue.integerValue == self.subViewTag) {
        self.backgroundColor = backgroundColor;
    }else {//等于1
        [UIView animateWithDuration:self.td_animatedDuration animations:^{
            self.backgroundColor = backgroundColor;
        }];
    }
}

- (void)updateBorderColor:(UIColor *)borderColor {
    NSNumber *animateValue = [self.animates objectForKey:borderColorKEY(self.state)];
    if (!animateValue) return;//不存在
    
    if (animateValue.integerValue == 0) {
        self.layer.borderColor = borderColor.CGColor;
        [self.layer removeAnimationForKey:@"borderColorAnimationKey"];
    }else {//等于1
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (__bridge id _Nullable)(self.layer.borderColor);
        animation.toValue = (__bridge id _Nullable)(borderColor.CGColor);
        animation.duration = self.td_animatedDuration;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:animation forKey:@"borderColorAnimationKey"];
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)updateBorderWidth:(CGFloat)borderWidth {
    NSNumber *animateValue = [self.animates objectForKey:borderWidthKEY(self.state)];
    if (!animateValue) return;//不存在
    
    if (animateValue.integerValue == 0) {
        self.layer.borderWidth = borderWidth;
        [self.layer removeAnimationForKey:@"borderWidthAnimationKey"];
    }else {//等于1
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
        animation.fromValue = @(self.layer.borderWidth);
        animation.toValue = @(borderWidth);
        animation.duration = self.td_animatedDuration;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:animation forKey:@"borderWidthAnimationKey"];
        self.layer.borderWidth = borderWidth;
    }
}

#pragma mark - getters and setters
- (void)setAnimates:(NSMutableDictionary *)animates {
    objc_setObjRETAIN(@selector(animates), animates);
}

- (NSMutableDictionary *)animates {
    NSMutableDictionary *animates = objc_getObj(@selector(animates));
    if (!animates) {
        animates = [NSMutableDictionary new];
        self.animates = animates;
    }
    return animates;
}

- (void)setBorderColors:(NSMutableDictionary *)borderColors {
    objc_setObjRETAIN(@selector(borderColors), borderColors);
}

- (NSMutableDictionary *)borderColors {
    NSMutableDictionary *borderColors = objc_getObj(@selector(borderColors));
    if (!borderColors) {
        borderColors = [NSMutableDictionary new];
        self.borderColors = borderColors;
    }
    return borderColors;
}

- (void)setBorderWidths:(NSMutableDictionary<NSNumber *,NSNumber *> *)borderWidths {
    objc_setObjRETAIN(@selector(borderWidths), borderWidths);

}
- (NSMutableDictionary<NSNumber *,NSNumber *> *)borderWidths {

    NSMutableDictionary *borderWidths = objc_getObj(@selector(borderWidths));
    if (!borderWidths) {
        borderWidths = [NSMutableDictionary new];
        self.borderWidths = borderWidths;
    }
    return borderWidths;
}

- (void)setBackgroundColors:(NSMutableDictionary *)backgroundColors {
    objc_setObjRETAIN(@selector(backgroundColors), backgroundColors);
}

- (NSMutableDictionary *)backgroundColors {
    NSMutableDictionary *backgroundColors = objc_getObj(@selector(backgroundColors));
    if(!backgroundColors) {
        backgroundColors = [[NSMutableDictionary alloc] init];
        self.backgroundColors = backgroundColors;
    }
    return backgroundColors;
}

- (void)setTitleLabelFonts:(NSMutableDictionary *)titleLabelFonts {
    objc_setObjRETAIN(@selector(titleLabelFonts), titleLabelFonts);
}

- (NSMutableDictionary *)titleLabelFonts {
    NSMutableDictionary *titleLabelFonts = objc_getObj(@selector(titleLabelFonts));
    if(!titleLabelFonts) {
        titleLabelFonts = [[NSMutableDictionary alloc] init];
        self.titleLabelFonts = titleLabelFonts;
    }
    return titleLabelFonts;
}

- (void)settd_animatedDuration:(NSTimeInterval)td_animatedDuration {
    objc_setObjRETAIN(@selector(td_animatedDuration), @(td_animatedDuration));
}

- (NSTimeInterval)td_animatedDuration {
    NSTimeInterval duartion = [objc_getObj(@selector(td_animatedDuration)) doubleValue];
    if (duartion == 0) {
        duartion = 0.25;
    }
    return duartion;
}

- (void)setSubViewPropertyArr:(NSMutableArray<TDPropertyModel *> *)subViewPropertyArr {
    objc_setObjRETAIN(@selector(subViewPropertyArr), subViewPropertyArr);
}

- (NSMutableArray<TDPropertyModel *> *)subViewPropertyArr {
    NSMutableArray *subViewPropertyArr = objc_getObj(@selector(subViewPropertyArr));
    if(!subViewPropertyArr) {
        subViewPropertyArr = [[NSMutableArray alloc] init];
        self.subViewPropertyArr = subViewPropertyArr;
    }
    return subViewPropertyArr;
}

-(void)setSubViewTag:(NSInteger)subViewTag {
    objc_setObjRETAIN(@selector(subViewTag), @(subViewTag));
}

- (NSInteger)subViewTag {
    return [objc_getObj(@selector(subViewTag)) integerValue];
}
@end
