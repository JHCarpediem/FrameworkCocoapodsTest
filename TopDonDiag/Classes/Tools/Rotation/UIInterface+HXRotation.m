//
//  UIInterface+HXRotation.m
//  HXRotationTool
//
//  Created by Mac on 2022/12/9.
//

#import "UIInterface+HXRotation.h"

@implementation UIViewController (HXRotation)

- (BOOL)hx_rotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // 转换为 Mask，避免直接移位造成不兼容
    UIInterfaceOrientationMask mask = [self.class maskFromOrientation:interfaceOrientation];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 160000
    if (@available(iOS 16.0, *)) {
        __block BOOL result = YES;
        
        // 确保系统刷新支持的方向
        [self setNeedsUpdateOfSupportedInterfaceOrientations];
        
        // 获取当前 windowScene（多 Scene 兜底处理）
        UIWindow *targetWindow = self.view.window;
        if (!targetWindow) {
            targetWindow = UIApplication.sharedApplication.keyWindow; // iOS 13 之前
        }
        if (!targetWindow && UIApplication.sharedApplication.connectedScenes.count > 0) {
            for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive &&
                    [scene isKindOfClass:[UIWindowScene class]]) {
                    UIWindowScene *ws = (UIWindowScene *)scene;
                    targetWindow = ws.windows.firstObject;
                    if (targetWindow) break;
                }
            }
        }
        
        if (!targetWindow.windowScene) {
            return NO; // 没有可用 windowScene，直接失败
        }
        
        // 请求系统旋转
        UIWindowSceneGeometryPreferencesIOS *pref =
        [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:mask];
        
        [targetWindow.windowScene requestGeometryUpdateWithPreferences:pref
                                                          errorHandler:^(NSError * _Nonnull error) {
            if (error) {
                NSLog(@"❌ hx_rotateToInterfaceOrientation error: %@", error);
                result = NO;
            }
        }];
        
        return result;
    }
#endif
    
    // iOS 11 ~ 15
    [[UIDevice currentDevice] setValue:@(interfaceOrientation) forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
    
    return YES;
}

+ (UIInterfaceOrientationMask)maskFromOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            return UIInterfaceOrientationMaskPortrait;
        case UIInterfaceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationMaskPortraitUpsideDown;
        case UIInterfaceOrientationLandscapeLeft:
            return UIInterfaceOrientationMaskLandscapeLeft;
        case UIInterfaceOrientationLandscapeRight:
            return UIInterfaceOrientationMaskLandscapeRight;
        default:
            return UIInterfaceOrientationMaskAll;
    }
}

- (void)hx_setNeedsUpdateOfSupportedInterfaceOrientations {
    
    if (@available(iOS 16.0, *)) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 160000
        [self setNeedsUpdateOfSupportedInterfaceOrientations];
#else
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            SEL supportedInterfaceSelector = NSSelectorFromString(@"setNeedsUpdateOfSupportedInterfaceOrientations");
            [self performSelector:supportedInterfaceSelector];
#pragma clang diagnostic pop
        
#endif
        });
        
    }

}

@end

// UINavigationController
@implementation UINavigationController (HXRotation)

- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return [self.viewControllers lastObject];
}

@end

// UITabBarController
@implementation UITabBarController (HXRotation)

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
