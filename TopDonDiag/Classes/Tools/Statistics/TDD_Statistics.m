//
//  TDD_Statistics.m
//  AD200
//
//  Created by lk_ios2023002 on 2023/3/17.
//

#import "TDD_Statistics.h"
@implementation TDD_Statistics
#pragma mark - app umeng提供的统计
// 数量统计
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)param {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdEvent:attributes:eventType:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdEvent:eventId attributes:param eventType:TDD_EventType_APP];
    }

}

+ (void)event:(NSString *)eventId attributes:(NSDictionary * _Nullable)param eventType:(TDD_EventType)eventType {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdEvent:attributes:eventType:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdEvent:eventId attributes:param eventType:eventType];
    }
    
}

// 时长统计
// beginEvent需要与endEvent配套使用
+ (void)beginEvent:(NSString *)eventId attributes:(NSDictionary *)param {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdBeginEvent:attributes:eventType:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdBeginEvent:eventId attributes:param eventType:TDD_EventType_APP];
        
    }
}

+ (void)beginEvent:(NSString *)eventId attributes:(NSDictionary * _Nullable)param eventType:(TDD_EventType)eventType {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdBeginEvent:attributes:eventType:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdBeginEvent:eventId attributes:param eventType:eventType];
        
    }
    
}

+ (void)endEvent:(NSString *)eventId {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdEndEvent:attributes:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdEndEvent:eventId attributes:@{}];
    }
}

+ (void)endEvent:(NSString *)eventId attributes:(NSDictionary *)param {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdEndEvent:attributes:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdEndEvent:eventId attributes:param];
    }
}

/// 暂停记时
+ (void)tdPauseEvent:(NSString *)eventId {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdPauseEvent:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdPauseEvent:eventId];
    }
}

/// 开始记时
+ (void)tdResumeEvent:(NSString *)eventId {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdResumeEvent:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdResumeEvent:eventId];
    }
}

/// 取消埋点
+ (void)tdRemoveEvent:(NSString *)eventId {
    if ([[TDD_DiagnosisManage sharedManage].manageDelegate respondsToSelector:@selector(tdRemoveEvent:)]){
        [[TDD_DiagnosisManage sharedManage].manageDelegate tdRemoveEvent:eventId];
    }
}
@end
