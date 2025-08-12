//
//  TDD_FCALoginModel.h
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/12/1.
//

#import <TopdonDiagnosis.h>

@class TDD_FCAAuthModel;
NS_ASSUME_NONNULL_BEGIN
@protocol TDD_FCALoginModelDelegata <NSObject>

/**********************************************************
*    功  能：FCA登录
**********************************************************/
- (void)ArtiFCALogin:(TDD_FCAAuthModel *)model param:(NSDictionary *)json completeHandle: (nullable void(^)(id result))complete;

/**********************************************************
*    功  能：ecu响应
**********************************************************/
- (void)ArtiFCAGateway:(TDD_FCAAuthModel *)model param:(NSDictionary *)json completeHandle: (nullable void(^)(id result))complete;

/**********************************************************
*    跳转商城首页
**********************************************************/
- (void)ArtiGatewayGotoShop:(TDD_FCAAuthModel *)model param:(NSDictionary *)json;

/// 跳转网页
/// - Parameters:
///   - model: 当前TDD_ArtiModelBase
///   - json:  key:web value:网页地址
- (void)ArtiFatewayGotoWebView:(TDD_FCAAuthModel *)model param:(NSDictionary *)json;
@end

@interface TDD_GatewayProductEquityModel : NSObject
/// 权益类型 1 FCA、2 雷诺、3 日产、4 点数、5 积分、6 ai权益、7 obfcm权益、8 nastf权益、9 大众sfd
@property (nonatomic, assign)NSInteger equityType;
/// 计费类型  1 次数（可使用权益次数） 2 时长（有效期内无限使用） 3 余额（点数 积分）
@property (nonatomic, assign)NSInteger chargeType;
/// 剩余次数 (chargeType:1 有值)
@property (nonatomic, assign)NSInteger remainTimes;
/// 是否有效 0 否 1 是 (chargeType:2 取该字段表示有效)
@property (nonatomic, assign)BOOL available;
/// 过期时间 ( 时间戳到秒 equityType:1,2,3,6,7,8,9有值；equityType:4,5无值)
@property (nonatomic, copy)NSString *expirationTime;
/// 余额 (chargeType:3 取该字段)
@property (nonatomic, assign)NSInteger balance;
/// 是否不限时长: 0 限制、 1不限制 (equityType:1,2,3,6,7,8,9有值；equityType:4,5无值)
@property (nonatomic, assign)NSInteger unlimitedDuration;
/// 明细 (equityType:5没有明细)
@property (nonatomic, strong)NSArray *details;
@end


@interface TDD_FCAAuthModel : TDD_ArtiModelBase
@property (nonatomic, weak) __nullable id<TDD_FCALoginModelDelegata> delegate;
///解锁品牌
@property (nonatomic, assign) eSpecialShowType uType;
///当前展示页面状态:1-权益查询展示、2-登录
@property (nonatomic, assign) NSInteger viewType;
///解锁类型 0-autoAuth 解锁、1-TopDon解锁、2-欧洲FCA解锁
@property (nonatomic, assign) NSInteger unlockType;
///区域 0-北美、1-其他区域
@property (nonatomic, assign) NSInteger area;
///权益模型
@property (nonatomic, strong) TDD_GatewayProductEquityModel *equityModel;
@property (nonatomic, assign) BOOL lastDemoGatewaySuccess;
+ (void)requestFcaLoginWithType:(eSpecialShowType)type complete:(void(^)(BOOL isSuccess,NSInteger code))complete;// 登陆认证
- (void)requestSGWRight:(nullable NSString *)accountStr complete:(nullable void(^)(id result))complete;//权益次数查询
- (void)requestSoftExpire:(nullable void(^)(id result))complete;//软件有效期查询

- (void)setLoginBtnEnable:(BOOL)enable;
- (void)setNextBtnEnable:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
