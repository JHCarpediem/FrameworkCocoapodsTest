//
//  TDD_ButtonCollectionView.m
//  TopdonDiagnosis
//
//  Created by liuxinwen on 2025/7/29.
//

#import "TDD_ButtonCollectionView.h"

@implementation TDD_ButtonCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass:UIButton.class]) {
        return YES;
    } else if ([view isKindOfClass:UITextField.class]) {
        return YES;
    } else if ([view isKindOfClass:TDD_CustomTextField.class]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
