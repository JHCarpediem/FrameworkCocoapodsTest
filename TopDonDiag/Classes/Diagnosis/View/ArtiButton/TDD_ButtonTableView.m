//
//  TDD_ButtonTableView.m
//  AD200
//
//  Created by 何可人 on 2022/4/28.
//

#import "TDD_ButtonTableView.h"

@implementation TDD_ButtonTableView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass:UIButton.class]) {
        return YES;
    } else if ([view isKindOfClass:UITextField.class]) {
        return YES;
    } else if ([view isKindOfClass:TDD_CustomTextField.class]) {
        return YES;
    }
    return[super touchesShouldCancelInContentView:view];
}

@end
