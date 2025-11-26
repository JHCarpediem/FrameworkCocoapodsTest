//
//  UIDevice+TDD_Info.h
//  JumpSurge
//
//  Created by zhi zhou on 2/15/23.
//

#import <UIKit/UIKit.h>
#import "TDD_DeviceInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Info)
+ (TDD_DeviceInfoModel *)modelInfo;

/// SIM卡 运营商
+ (NSString *)carrierName;

/// 设备是否越狱
+ (BOOL)isJailbroken;


/// 顶部安全区高度
+ (CGFloat)vg_safeDistanceTop;

/// 底部安全区高度
+ (CGFloat)vg_safeDistanceBottom;

/// 顶部状态栏高度（包括安全区）
+ (CGFloat)vg_statusBarHeight;

/// 导航栏高度
+ (CGFloat)vg_navigationBarHeight;

/// 状态栏+导航栏的高度
+ (CGFloat)vg_navigationFullHeight;

/// 底部导航栏高度
+ (CGFloat)vg_tabBarHeight;

/// 底部导航栏高度（包括安全区）
+ (CGFloat)vg_tabBarFullHeight;

@end

NS_ASSUME_NONNULL_END
