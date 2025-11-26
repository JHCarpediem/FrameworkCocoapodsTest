//
//  UIDevice+TDD_Info.m
//  JumpSurge
//
//  Created by zhi zhou on 2/15/23.
//

#import "UIDevice+TDD_Info.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/sysctl.h>
@implementation UIDevice (Info)
+ (NSString *)modelIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (TDD_DeviceInfoModel *)modelInfo {
    return [self modelInfoForModelIdentifier:[self modelIdentifier]];
}

+ (TDD_DeviceInfoModel *)modelInfoForModelIdentifier:(NSString *)modelIdentifier {
        NSDictionary *deviceModels = @{
        @"i386" : @{@"modelName":@"iPhone Simulator",@"type":@(1.0)},
        @"x86_64" :@{@"modelName":@"iPhone Simulator",@"type":@(1.0)},
        @"arm64" :@{@"modelName":@"iPhone Simulator",@"type":@(1.0)},
        @"iPhone1,1" :@{@"modelName":@"iPhone",@"type":@(2.0)},
        @"iPhone1,2" :@{@"modelName":@"iPhone 3G",@"type":@(2.0)},
        @"iPhone2,1" :@{@"modelName":@"iPhone 3GS",@"type":@(2.0)},
        @"iPhone3,1" :@{@"modelName":@"iPhone 4",@"type":@(3.0)},
        @"iPhone3,2" :@{@"modelName":@"iPhone 4 GSM Rev A",@"type":@(3.0)},
        @"iPhone3,3" :@{@"modelName":@"iPhone 4 CDMA",@"type":@(3.0)},
        @"iPhone4,1" :@{@"modelName":@"iPhone 4S",@"type":@(3.0)},
        @"iPhone5,1" :@{@"modelName":@"iPhone 5 (GSM)",@"type":@(4.0)},
        @"iPhone5,2" :@{@"modelName":@"iPhone 5 (GSM+CDMA)",@"type":@(4.0)},
        @"iPhone5,3" :@{@"modelName":@"iPhone 5C (GSM)",@"type":@(4.0)},
        @"iPhone5,4" :@{@"modelName":@"iPhone 5C (Global)",@"type":@(4.0)} ,
        @"iPhone6,1" :@{@"modelName":@"iPhone 5S (GSM)",@"type":@(4.0)} ,
        @"iPhone6,2" :@{@"modelName":@"iPhone 5S (Global)",@"type":@(4.0)} ,
        @"iPhone7,1" :@{@"modelName":@"iPhone 6 Plus",@"type":@(5.0)},
        @"iPhone7,2" :@{@"modelName":@"iPhone 6",@"type":@(5.0)},
        @"iPhone8,1" :@{@"modelName":@"iPhone 6s",@"type":@(5.0)},
        @"iPhone8,2" :@{@"modelName":@"iPhone 6s Plus",@"type":@(5.0)},
        @"iPhone8,4" :@{@"modelName":@"iPhone SE (GSM)",@"type":@(5.0)} ,
        @"iPhone9,1" :@{@"modelName":@"iPhone 7",@"type":@(6.0)} ,
        @"iPhone9,2" :@{@"modelName":@"iPhone 7 Plus",@"type":@(6.0)} ,
        @"iPhone9,3" :@{@"modelName":@"iPhone 7",@"type":@(6.0)} ,
        @"iPhone9,4" :@{@"modelName":@"iiPhone 7 Plus",@"type":@(6.0)} ,
        @"iPhone10,1" :@{@"modelName":@"iPhone 8",@"type":@(7.0)}  ,
        @"iPhone10,2" :@{@"modelName":@"iPhone 8 Plus",@"type":@(7.0)} ,
        @"iPhone10,3" :@{@"modelName":@"iPhone X Global",@"type":@(7.0)} ,
        @"iPhone10,4" :@{@"modelName":@"iPhone 8",@"type":@(7.0)} ,
        @"iPhone10,5" :@{@"modelName":@"iPhone 8 Plus",@"type":@(7.0)}  ,
        @"iPhone10,6" :@{@"modelName":@"iPhone X GSM",@"type":@(8.0)}  ,
        @"iPhone11,2" :@{@"modelName":@"iPhone XS",@"type":@(8.0)} ,
        @"iPhone11,4" :@{@"modelName":@"iPhone XS Max",@"type":@(8.0)} ,
        @"iPhone11,6" :@{@"modelName":@"iPhone XS Max Global",@"type":@(8.0)} ,
        @"iPhone11,8" :@{@"modelName":@"iPhone XR",@"type":@(8.0)} ,
        @"iPhone12,1" :@{@"modelName":@"iPhone 11",@"type":@(9.0)} ,
        @"iPhone12,3" :@{@"modelName": @"iPhone 11 Pro",@"type":@(9.0)} ,
        @"iPhone12,5" :@{@"modelName": @"iPhone 11 Pro Max",@"type":@(9.0)} ,
        @"iPhone12,8" :@{@"modelName":@"iPhone SE 2nd Gen",@"type":@(9.0)} ,
        @"iPhone13,1" :@{@"modelName":@"iPhone 12 Mini",@"type":@(10.0)} ,
        @"iPhone13,2" :@{@"modelName":@"iPhone 12",@"type":@(10.0)} ,
        @"iPhone13,3" :@{@"modelName":@"iPhone 12 Pro",@"type":@(10.0)} ,
        @"iPhone13,4" :@{@"modelName":@"iPhone 12 Pro Max",@"type":@(10.0)}  ,
        @"iPhone14,2" :@{@"modelName":@"iPhone 13 Pro",@"type":@(11.0)}  ,
        @"iPhone14,3" :@{@"modelName":@"iPhone 13 Pro Max",@"type":@(11.0)} ,
        @"iPhone14,4" :@{@"modelName":@"iPhone 13 Mini",@"type":@(11.0)} ,
        @"iPhone14,5" :@{@"modelName":@"iPhone 13",@"type":@(11.0)} ,
        @"iPhone14,6" :@{@"modelName":@"iPhone SE 3rd Gen",@"type":@(11.0)} ,
        @"iPhone14,7" :@{@"modelName":@"iPhone 14",@"type":@(12.0)} ,
        @"iPhone14,8" :@{@"modelName":@"iPhone 14 Plus",@"type":@(12.0)}  ,
        @"iPhone15,2" :@{@"modelName":@"iPhone 14 Pro",@"type":@(12.0)} ,
        @"iPhone15,3" :@{@"modelName":@"iPhone 14 Pro Max",@"type":@(12.0)} ,

    };
    TDD_DeviceInfoModel *model = [TDD_DeviceInfoModel new];
    // Device Model
    if (deviceModels[modelIdentifier] != nil) {
        NSDictionary *dic = deviceModels[modelIdentifier];
        model.modelName   = dic[@"modelName"];
        model.type        = [dic[@"type"] floatValue];
        return model;
    }
    model.type = 10.0;
    return model;
    // Simulator
   
}

+ (NSString *)carrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry = [carrier carrierName];
//    ASLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
    return currentCountry;
}

+ (BOOL)isJailbroken{
    
    BOOL jailbroken = NO;
    
    NSString *cydiaPath = @"/Applications/Cydia.app";
    
    NSString *aptPath = @"/private/var/lib/apt/";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]){
        jailbroken = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]){
        jailbroken = YES;
    }
    
    return jailbroken;
    
}


#pragma mark -- 状态栏、导航栏、tabbar、安全区域高度
/// 顶部安全区高度
+ (CGFloat)vg_safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// 底部安全区高度
+ (CGFloat)vg_safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


/// 顶部状态栏高度（包括安全区）
+ (CGFloat)vg_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

/// 导航栏高度
+ (CGFloat)vg_navigationBarHeight {
    return 44.0f;
}

/// 状态栏+导航栏的高度
+ (CGFloat)vg_navigationFullHeight {
    return [UIDevice vg_statusBarHeight] + [UIDevice vg_navigationBarHeight];
}

/// 底部导航栏高度
+ (CGFloat)vg_tabBarHeight {
    return 49.0f;
}

/// 底部导航栏高度（包括安全区）
+ (CGFloat)vg_tabBarFullHeight {
    return [UIDevice vg_tabBarHeight] + [UIDevice vg_safeDistanceBottom];
}

@end
