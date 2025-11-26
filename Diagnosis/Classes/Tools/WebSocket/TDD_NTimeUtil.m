//
//  TimeUtil.m
//  计算消耗时间
//
//  Created by 胡烽 on 16/3/16.
//  Copyright © 2016年 胡烽. All rights reserved.
//

#import "TDD_NTimeUtil.h"

static NSMutableDictionary *list;
static const int kTimeout=3;

@implementation TDD_NTimeUtil

NS_INLINE dispatch_time_t BKTimeDelay(NSTimeInterval t) {
    return dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * t));
}
NS_INLINE BOOL BKSupportsDispatchCancellation(void) {
    return (&dispatch_block_cancel != NULL);
}

// 开始默认的计时
+ (void) start{
    [TDD_NTimeUtil start:@"default"];
}
// 开始计时
+(void) start:(NSString *)key
{
    if(!list){
        list=[[NSMutableDictionary alloc]init];
    }
    [list setValue:[NSDate date] forKey:key];
}
// 结束默认的计时
+(double) end
{
    return [TDD_NTimeUtil end:@"default"];
}
// 计时结束
+ (double) end:(NSString *)key
{
    return [TDD_NTimeUtil end:key timeout:kTimeout];
}
// 计时结束
+ (double) end:(NSString *)key
       timeout:(unsigned int) timeout
{
    if(list!=nil){
        NSDate* last=[list valueForKey:key];
        if(last!=nil){
            [list removeObjectForKey:key];
            double deltaTime = [[NSDate date] timeIntervalSinceDate:last];
            return deltaTime;
        }
    }
    NSLog(@"您需要[TimeUtil start:%@]",key);
    return 0;
}
// 延后执行
+ (BKCancellationToken) run:(dispatch_block_t) block
                      delay:(NSTimeInterval) delay
{
    if(block==nil){
        return nil;
    }
    dispatch_time_t time = BKTimeDelay(delay);
    dispatch_queue_t queue = dispatch_get_main_queue();
    if(BKSupportsDispatchCancellation()){
        dispatch_block_t ret = dispatch_block_create(0, block);
        dispatch_after(time, queue, ret);
        return ret;
    }
    __block BOOL cancelled = NO;
    void (^wrapper)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };
    dispatch_after(time, queue, ^{
        wrapper(NO);
    });
    return wrapper;
}

// 取消执行
+ (void) cancelDelay:(BKCancellationToken) block
{
    if(block==nil){
        return;
    }
    if(BKSupportsDispatchCancellation()){
        dispatch_block_cancel((dispatch_block_t)block);
        return;
    }
    void (^wrapper)(BOOL) = (void(^)(BOOL))block;
    wrapper(YES);
}
// 延后执行
+(void) perform:(NSObject *)target
         method:(SEL) method
         object:(id) object
          delay:(NSTimeInterval) delay
{
    [NSObject cancelPreviousPerformRequestsWithTarget:target selector:method object:object];
    [target performSelector:method withObject:object afterDelay: delay];
}
// 取消执行
+ (void) cancelPerform:(NSObject *) target
                method:(SEL) method
                object:(id) object
{
    [NSObject cancelPreviousPerformRequestsWithTarget:target selector:method object:object];
}
// GCD单例
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static TDD_NTimeUtil * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[TDD_NTimeUtil alloc] init];
    });
    return sharedInstance;
}
// 取消全部计时器
+ (void) cancelAll
{
    [[self sharedInstance] cancelAll];
}
// 是否已启动计时器
+ (BOOL) hasTimer:(NSString *)timerName{
    return [[TDD_NTimeUtil sharedInstance] hasTimer:timerName];
}
// 启动启动时器
+ (void) startTimer:(NSString *)timerName
           interval:(NSTimeInterval)interval
            repeats:(BOOL) repeats
             action:(void (^)(void))action
{
    [[TDD_NTimeUtil sharedInstance] startTimer:timerName interval:interval repeats:repeats action:action];
}
+ (void) startTimer:(NSString *)timerName
           interval:(NSTimeInterval)interval
            repeats:(BOOL) repeats
              isNow:(BOOL) isNow
             action:(void (^)(void))action
{
    [[TDD_NTimeUtil sharedInstance] startTimer:timerName interval:interval repeats:repeats isNow:isNow action:action];
}
// 停止计时器
+ (void) stopTimer:(NSString *)timerName
{
    [[TDD_NTimeUtil sharedInstance] stopTimer:timerName];
}

// 初始化
- (id)init{
    if ((self = [super init]))
    {
        _timerList=[[NSMutableDictionary alloc]init];
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}
// 是否已启动计时器
- (BOOL) hasTimer:(NSString *)timerName{
    dispatch_source_t timer=[_timerList objectForKey:timerName];
    return timer!=nil;
}
// 启动启动时器
- (void) startTimer:(NSString *)timerName
           interval:(NSTimeInterval)interval
            repeats:(BOOL) repeats
             action:(void (^)(void))action
{
    if(timerName.length<1 || action==nil){
        return;
    }
    dispatch_source_t timer=[_timerList objectForKey:timerName];
    if(timer==nil){
        // 主线程队列
        dispatch_queue_t queue=dispatch_get_main_queue();
        timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
        dispatch_resume(timer);
        [_timerList setObject:timer forKey:timerName];
    }
    dispatch_source_set_timer(timer,DISPATCH_TIME_NOW,interval*NSEC_PER_SEC,0.1*NSEC_PER_SEC);
    __weak typeof(self) weakSelf=self;
    dispatch_source_set_event_handler(timer,^{
        action();
        if(!repeats){
            [weakSelf stopTimer:timerName];
        }
    });
}

- (void) startTimer:(NSString *)timerName
           interval:(NSTimeInterval)interval
            repeats:(BOOL) repeats
              isNow:(BOOL)isNow
             action:(void (^)(void))action
              
{
    if(timerName.length<1 || action==nil){
        return;
    }
    dispatch_source_t timer=[_timerList objectForKey:timerName];
    if(timer==nil){
        // 主线程队列
        dispatch_queue_t queue=dispatch_get_main_queue();
        timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
        dispatch_resume(timer);
        [_timerList setObject:timer forKey:timerName];
    }
    dispatch_time_t start;
    if (isNow) {
        start = DISPATCH_TIME_NOW;
    }else {
        uint64_t intervalInNanoSeconds = interval * NSEC_PER_SEC;
        // 获取当前时间
        dispatch_time_t now = dispatch_time(DISPATCH_TIME_NOW, 0);
        
        // 计算首次触发的时间：当前时间 + 45秒
        dispatch_time_t start = dispatch_time(now, intervalInNanoSeconds);
    }

    dispatch_source_set_timer(timer,start ,interval*NSEC_PER_SEC,0.1*NSEC_PER_SEC);
    __weak typeof(self) weakSelf=self;
    dispatch_source_set_event_handler(timer,^{
        action();
        if(!repeats){
            [weakSelf stopTimer:timerName];
        }
    });
}
// 停止计时器
- (void) stopTimer:(NSString *)timerName
{
    dispatch_source_t timer=[_timerList objectForKey:timerName];
    if(timer==nil){
        return;
    }
    [_timerList removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}
// 停止所有计时器
- (void) cancelAll
{
    @synchronized (_timerList) {
        [_timerList enumerateKeysAndObjectsUsingBlock:^(id key, dispatch_source_t obj, BOOL *stop) {
            if(obj){
                dispatch_source_cancel(obj);
            }
        }];
        [_timerList removeAllObjects];
        NSLog(@"停止所有计时器");
    }
}

//转换字符串为"yyyy-MM-dd HH:mm:ss"格式到NSDate
+ (NSDate *) dencodeTime:(NSString *)dateString
{
    return [[TDD_NTimeUtil sharedInstance].formatter dateFromString:dateString];
}
//转换NSDate格式到NString
+ (NSString *) encodeTime:(NSDate *) date format:(NSString *) format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
    
}
//某天到某天相差的天数
+ (NSString *) timeSince:(NSDate *)sinceDate to:(NSDate *)toDate{
    NSTimeInterval time = [toDate timeIntervalSinceDate:sinceDate];
    //相差的天数
    float day =  time/(24*60*60);
    return [NSString stringWithFormat:@"%f",day];
}


//时间格式1495453213000
+(NSString *)getLocalTimeFormateUTCDate:(NSString *)utcDate
{
    NSTimeInterval interval    = [utcDate doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

@end
