//
//  TDD_ADWebSocket.h
//  AD200
//
//  Created by fench on 2023/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 订阅回调 回调会把服务器返回的数据 包装成Response 数据模型返回 Response 里面有data 字段
typedef void(^SubscribeHandle)(id _Nullable result);

typedef enum {
    /// 诊断算法  目前只有这一个WebSocket 后续添加可在枚举里面新增
    WSEvent_Diagnosis = 0,
    
} WSSubscribeEven;

#pragma mark 回调模型
@interface ADSubscribeModel : NSObject

/// 订阅key （用作不同页面同一个订阅类型的回调 可传类名）
@property(nonatomic, copy) NSString* key;

@property(nonatomic, copy) NSDictionary* param;

/// 回调key  （回调的key）内部修改 外界可不传 
@property(nonatomic, copy) NSString* callbackKey;

/// 回调block
@property(nonatomic, copy) SubscribeHandle callback;

@end


@interface TDD_ADWebSocket : NSObject

@property(nonatomic, copy) NSString* baseUrl;

/// websocket 是否是开启状态
@property(nonatomic, assign, readonly) BOOL isOpen;
/// 是否主动关闭webSocket(退车)，重新进车需要设为 NO
@property(nonatomic, assign) BOOL isClosed;

/// 单例
+ (TDD_ADWebSocket *)shared;

/// 算法/心跳新增的请求参数
+ (NSDictionary *)publicParams;

/// 开启webSocket
- (void)openWithToken:(NSString *) token;

/// 断开连接 关闭webSocket
- (void)close;

/// 订阅事件
/// - Parameter model: 订阅模型
/// 订阅模型里面包含： 订阅的事件 event 订阅的参数： parameter 订阅回调：SubscribeHandle
- (void)subscribe: (ADSubscribeModel *)model;

@end

NS_ASSUME_NONNULL_END
