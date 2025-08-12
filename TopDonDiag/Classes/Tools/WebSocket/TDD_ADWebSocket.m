//
//  TDD_ADWebSocket.m
//  AD200
//
//  Created by fench on 2023/4/11.
//

#import "TDD_ADWebSocket.h"//
#import "SRWebSocket.h"
#import "TDD_NTimeUtil.h"
#import "TDD_ADDiagnosisModel.h"

#define WS_URLPATH @"/out-user/websocket"     // websocket 路径
#define WS_TIMER_KEY @"kWebSocketTimer"       // 定时器Key
#define WS_RECONNCT_TIMER_KEY @"kWebSocketReConnectTimer"       // 重连定时器Key

#pragma mark webSocket 类
@interface TDD_ADWebSocket () <SRWebSocketDelegate>

/// websocket 实例
@property(nonatomic, strong) SRWebSocket* webSocket;

/// 待发送的数据
@property(nonatomic, copy) NSMutableDictionary* waitDatas;

/// 订阅的模型
@property(nonatomic, copy) NSMutableDictionary* subscribeDict;

@property (nonatomic, readonly,copy) NSString* token;

@property (nonatomic,assign) NSInteger receivePongInterval;//收到心跳的间隔(收到后重置为 0)
@end

@implementation TDD_ADWebSocket


// 创建单例
+(TDD_ADWebSocket *)shared
{
    static TDD_ADWebSocket *shared = nil;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        shared = [[self alloc] init];
        [shared initSocket];
    });
    return  shared;
}

+ (NSDictionary *)publicParams {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    currentVersion = [NSString stringWithFormat:@"V%@",currentVersion];
    NSMutableDictionary *params = @{}.mutableCopy;
    NSArray *keyArr = @[@"appKey",@"topdonId",@"ip",@"vin",@"timeZone",@"deviceId",@"clientVersion",@"clientType"];
    NSArray *valueArr = @[[TDD_DiagnosisTools appKey]?:@"",
                          [TDD_DiagnosisTools topdonID]?:@"",
                          [TDD_DiagnosisTools ipAddress]?:@"",
                          [TDD_ArtiGlobalModel sharedArtiGlobalModel].CarVIN?:@"",
                          [NSDate tdd_getWebSocketTimeZone]?:@"",
                          [TDD_DiagnosisTools deviceUUID]?:@"",
                          currentVersion?:@"",
                          @"1"];
#ifdef DEBUG
    if (keyArr.count != valueArr.count) {
        if ([TDD_DiagnosisManage sharedManage].appScenarios == AS_INTERNAL_USE) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [TDD_HTipManage showBtnTipViewWithTitle:@"仅 DEBUG 提示:算法公共参数数据异常" buttonType:HTipBtnOneType block:^(NSInteger btnTag) {
                    
                }];
            });
        }

    }
#endif
    
    for (int i = 0; i < keyArr.count; i++) {
        if (valueArr.count > i && ![NSString tdd_isEmpty:valueArr[i]]) {
            [params setValue:valueArr[i] forKey:keyArr[i]];
        }
    }
    return params;
    
}

- (void)initSocket
{
  
}

/// 开启webSocket 初始化
- (void)openWithToken:(NSString *)token
{
    if (!token) {
        HLog(@"webSocket: Token 为空");
        return;
    }
    self.receivePongInterval = 0;
    NSString* urlStr = [TDD_DiagnosisTools serverURL];;
    NSURL* url = [NSURL URLWithString:urlStr];
    NSString* scheme = url.scheme;
    NSString* domin = url.host;
    // 测试环境的scheme为ws 正式环境的scheme为wss
    NSString* wsScheme = @"wss";
    if (![domin containsString:@"api.topdon.com"] && ![domin containsString:@"carpal.topdon.com"]) { // 非发布环境的域名
        wsScheme = @"ws";
    }
    
    urlStr = [urlStr stringByReplacingOccurrencesOfString:scheme?:@"" withString:wsScheme];
    urlStr = [urlStr stringByAppendingString:WS_URLPATH];
    
//    urlStr = @"Ws://127.0.0.1:9907/websocket";
    HLog(@"webSocket: 服务器地址----------%@", urlStr);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    request.allHTTPHeaderFields = @{@"Token" : token, @"version" : @"2025-05-19"};
    HLog(@"webSocket: 请求头信息：%@", request.allHTTPHeaderFields);
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
//    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlStr]];
    self.webSocket.delegate = self;
    NSOperationQueue *op = [[NSOperationQueue alloc] init];
    op.maxConcurrentOperationCount = 1;
    [self.webSocket setDelegateOperationQueue:op];
    [self.webSocket open];
    
}



/// 断开连接
- (void)close
{
    _isClosed = YES;
    [self closeReconnectTimer];
    [self _close];
}

- (void)_close
{
    HLog(@"webSocket--------------: 断开连接");
    if (self.webSocket) {
        [self.webSocket close];
        self.webSocket = nil;
        //断开连接 需要停止timer 发送心跳包
        [self stopSendPing];
    }
}

/// 重新连接
- (void)reconnect
{
    if (_isClosed) return;
    [self _close];
    HLog(@"webSocket: 重连");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1), dispatch_get_main_queue(), ^{
        [self openWithToken:self.token];
    });
}

- (void)sendSubscribeData: (ADSubscribeModel *)model
{
    if (!model) {
        return;
    }
    if (!self.webSocket) {
        [self reconnect];
        [self.waitDatas setValue:model forKey:model.key];
        return;
    }
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:model.param options:0 error:nil];
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSError *err = [self sendData:jsonStr];
    [self.subscribeDict removeObjectForKey:model.key];
    [self.subscribeDict setObject:model forKey:model.key];
    
    if (err) {
        [self openReconnectTimer];
        [self.waitDatas setValue:model forKey:model.key];
    }
}

/// 发送数据
/// - Parameter data: 待发送的数据 支持NSData 和 NSString 类型
/// - return : 返回值 返回错误 发送成功 返回空 如果返回的error不为nil 代表发送数据失败 webSocket未连接
- (NSError *)sendData: (id)data
{
    
    if (!self.webSocket) {
        [self openReconnectTimer];
        return nil;
    }
    
    NSError *error;
    if (!data) {
        HLog(@"WebSocket发送空数据-------------：");
        [self.webSocket sendData:nil error:&error];
    } else if ([data isKindOfClass:[NSData class]]) {
        HLog(@"WebSocket发送数据-------------：%@", data);
        [self.webSocket sendData:(NSData*)data error:&error];
    } else if ([data isKindOfClass:[NSString class]]) {
        HLog(@"WebSocket发送数据-------------：%@", data);
        [self.webSocket sendString:(NSString*)data error:&error];
    } else {
        NSAssert(NO, @"无效的数据类型，请传入NSData或NSString类型的数据。");
    }
    
    return error;
}

/// 发送心跳包
- (void)sendPing
{
    // 停止旧的心跳包定时器
    [self stopSendPing];
    // 开启新的心跳包定时器
    @kWeakObj(self)
    [TDD_NTimeUtil startTimer:WS_TIMER_KEY interval:45 repeats:true action:^{
        @kStrongObj(self)
        //算法使用连接的 SN
        NSString * sn = [TDD_EADSessionController sharedController].SN;
        
        NSMutableDictionary *param = @{@"sn":sn?:@"",@"type":@(-1),@"token":self.token?:@""}.mutableCopy;
        [param addEntriesFromDictionary:[TDD_ADWebSocket publicParams]];
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
        NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSData* pingData = [@"xt" dataUsingEncoding:NSUTF8StringEncoding];
//        HLog(@"webSocket: 发送心跳ping: ---------xt");
//        BOOL isSuccess = [self.webSocket sendData:jsonData error:nil];
        BOOL isSuccess = [self.webSocket sendString:jsonStr error:nil];
        self.receivePongInterval += 45;

        if (self.receivePongInterval >= 180) {
            //因为刚链接会马上发一次心跳，所以算 135+45
            HLog(@"webSocket: 135s没有收到心跳出发重连");
            [self openReconnectTimer];
        }
        if (!isSuccess) {
            HLog(@"webSocket: 发送心跳包失败-- webSocket未打开");
            [self openReconnectTimer];
        }
    }];
}

/// 停止心跳包
- (void)stopSendPing
{
    // 停止定时器
    self.receivePongInterval = 0;
    [TDD_NTimeUtil stopTimer:WS_TIMER_KEY];
}

// 重连定时器
- (void)openReconnectTimer
{
    [self closeReconnectTimer];
    [TDD_NTimeUtil startTimer:WS_RECONNCT_TIMER_KEY interval:3 repeats:true action:^{
        if (self.webSocket.readyState == SR_CONNECTING) {
            return;
        }
        if (self.webSocket.readyState == SR_OPEN) {
            [self closeReconnectTimer];
            return;
        }
        [self reconnect];
    }];
    
}
// 关闭重连定时器
- (void)closeReconnectTimer
{
    // 停止定时器
    [TDD_NTimeUtil stopTimer:WS_RECONNCT_TIMER_KEY];
    
}

- (BOOL)isOpen
{
    if (!self.webSocket) return NO;
    return self.webSocket.readyState == SR_OPEN;
}


/// 发起订阅 订阅消息
/// - Parameter model: 订阅模型
- (void)subscribe:(ADSubscribeModel *)model
{
    if (!model) {
        return;
    }
    [self sendSubscribeData:model];
}


#pragma mark ----------SRWebSocketDelegate--------
/// websocket 已开启
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    HLog(@"WebSocket 已连接------------:%@", webSocket.url);
    [self closeReconnectTimer];
    // websocket 已连接 发送心跳包
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1), dispatch_get_main_queue(), ^{
        [self sendPing];
    });
    
    // 如果有未发送的数据 发送数据
    for (ADSubscribeModel *data in self.waitDatas.allValues) {
        [self sendSubscribeData:data];
    }
    
    // 发送完成 删除所有待发送数据
    [self.waitDatas removeAllObjects];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    // 连接失败发起重连
    //[self reconnect];
    if (![TDD_NTimeUtil hasTimer:WS_RECONNCT_TIMER_KEY]) {
        HLog(@"webSocket: 连接失败发起重连");
        [self openReconnectTimer];
    }

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    // 服务端主动关闭连接 在这里做特殊情况的处理
    HLog(@"WebSocket: 连接已断开------------:%@", reason);
}

/// WebSocket接收到服务端返回的数据的回调
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSString *msg = message;
    HLog(@"WebSocket接收数据：---------%@", msg);
    ADDiagnosisWSResponse* result = [ADDiagnosisWSResponse modelWithJSON:msg];
    if (result.type == 1) {
        //收到心跳回调，重置心跳间隔
        self.receivePongInterval = 0;
    }
    
    if (result.code == 60513 || result.code == 60514) {
            // token失效
            //刷新 token，不管成功失败
            if (self.subscribeDict.allValues.count == 0) {
                if ([[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate respondsToSelector:@selector(ArtiGlobalNetwork:param:completeHandle:)]) {
                    [[TDD_ArtiGlobalModel sharedArtiGlobalModel].delegate ArtiGlobalNetwork:TDD_ArtiModelEventType_RefreshToken param:@{} completeHandle:^(id  _Nonnull result) {
                        
                    }];
                }
            }
        }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.subscribeDict.allValues enumerateObjectsUsingBlock:^(ADSubscribeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.callback(message);
            [self.subscribeDict removeObjectForKey:obj.key];
        }];
    });
}

/// 收到pong 心跳回调
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongData
{
//    NSString* str = [[NSString alloc] initWithData:pongData encoding:NSUTF8StringEncoding];
//    HLog(@"WebSocket接收pong: ---------%@", str);
}

    
#pragma mark ----------懒加载------------
- (NSMutableDictionary *)waitDatas
{
    if (!_waitDatas) {
        _waitDatas = [[NSMutableDictionary alloc] init];
    }
    return _waitDatas;
}

- (NSMutableDictionary *)subscribeDict
{
    if (!_subscribeDict) {
        _subscribeDict = [[NSMutableDictionary alloc] init];
    }
    return _subscribeDict;
}

/// 获取订阅事件枚举的 字符串编码
- (NSString *)subscribeEventName: (WSSubscribeEven)event
{
    switch (event) {
        case WSEvent_Diagnosis:
            
            return @"";
            
        default:
            break;
    }
}

- (NSString *)token {
    NSString * token = [TDD_DiagnosisTools userToken];
    NSString * accToken =  [NSString stringWithFormat:@"%@", token];
    return accToken;
    
}

@end


#pragma mark ------------------ ADSubscribeModel -------------
@implementation ADSubscribeModel


@end
