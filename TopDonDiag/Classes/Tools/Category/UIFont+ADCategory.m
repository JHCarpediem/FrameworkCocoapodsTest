//
//  UIFont+ADCategory.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/4/14.
//

#import "UIFont+ADCategory.h"
@import TDUIProvider;
@import TDBasis;
@implementation UIFont (ADCategory)
- (UIFont *)tdd_adaptHD {
    if (IS_IPad) {
        return [self fontWithSize:self.pointSize * 1.1];
    }
    return self;
}
@end
