//
//  UIViewController+TDD_ASCategory.m
//  Path
//
//  Created by Kowloon on 12-7-30.
//  Copyright (c) 2012年 Personal. All rights reserved.
//

#import "UIViewController+TDD_ASCategory.h"

@implementation UIViewController (TDD_ASCategory)

#pragma mark - Compatible

+ (UIViewController*)tdd_topViewController {
    return [UIViewController tdd_topViewControllerWithRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
}

+ (UIViewController*)tdd_topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self tdd_topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self tdd_topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self tdd_topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
