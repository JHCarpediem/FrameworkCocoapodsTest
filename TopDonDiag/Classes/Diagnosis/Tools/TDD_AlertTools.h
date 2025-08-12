//
//  TDD_AlertTools.h
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2025/3/6.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TDD_AlertTools : NSObject
#pragma mark 弹框
/// 重置弹窗状态
+ (void)resetAlert;
/// 电压过低
+ (void)showBatteryVoltLowAlert;
/// 蓝牙断开
+ (void)showBleBreakAlert;
/// 后台进前台
+ (void)showBackgroundAlert;
/// 软件过期续费弹框
+ (void)showSoftExpiredToBuyAlert:(nullable void (^)(void))completionHandler;
/// 开启二次验证
+ (void)openTwoFaAlert:(NSDictionary *)param;
/// 账号不一致开启二次验证
+ (void)openTwoFaChangeAccountAlert:(NSString *)account;
///
+ (void)showNeedBuyAlert:(void(^)(void))complict;
@end

NS_ASSUME_NONNULL_END
