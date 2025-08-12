//
//  TDD_Tools.m
//  TDDiag
//
//  Created by lk_ios2023002 on 2023/6/12.
//

#import "TDD_Tools.h"
@import TDBasis;

@interface TDD_Tools()

@property (nonatomic, strong) NSArray *troubleCodeArr;

@end

@implementation TDD_Tools

+ (void)bleLog:(NSString *)message file:(NSString *)file func:(NSString *)func line:(NSInteger)line
{
    //[[FIRCrashlytics crashlytics] log:[NSString stringWithFormat:@"【AD200蓝牙】%@",message]];
    [TDLogger logCustom:message customLevel:@"【AD200蓝牙】" file:file function:func line:line asynchronous:false];
}

+ (void)diagLog:(NSString *)message file:(NSString *)file func:(NSString *)func line:(NSInteger)line
{
    [[FIRCrashlytics crashlytics] log:[NSString stringWithFormat:@"【AD200诊断】%@",message]];
    [TDLogger logCustom:message customLevel:@"【AD200诊断】" file:file function:func line:line asynchronous:false];
}

+ (TDD_Tools *)sharedInstance
{
    static TDD_Tools * shared;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken,^{
        shared = [[TDD_Tools alloc] init];
        [shared readTroubleJson];
    });
    return shared;
}

+ (UIImage *)tdd_imageNamed:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"TopdonDiagnosis.bundle/image/%@",imageName] inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

+ (int )troubleCodeLevelWithVehicle:(NSString *)vehicle statusStr:(NSString *)statusStr {
    if ([NSString tdd_isEmpty:statusStr]) {
        return 2;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"model LIKE[c] %@", vehicle];
    
//    NSArray *filterArray = [TDD_Tools troubleCodeLevelArr]; // [[TDD_Tools troubleCodeLevelArr] filteredArrayUsingPredicate:predicate];
    
    NSArray *filterArray = [TDD_Tools sharedInstance].troubleCodeArr;
    
    
    predicate = [NSPredicate predicateWithFormat:@"state LIKE[c] %@", statusStr];
    filterArray = [filterArray filteredArrayUsingPredicate:predicate];
    if (filterArray.count > 0) {
        NSDictionary *dict = filterArray.firstObject;
        NSString *level = dict[@"level"];
        HLog("当前故障码故障码: - %@ - %@", statusStr, level);
        return level.intValue;
    }
    return 2;
}

- (void)readTroubleJson {
    // 获取文件路径
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"TopdonDiagnosis.bundle/故障码状态" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    self.troubleCodeArr = arr;
    
    HLog("故障码列表: - %@", arr.description);
}

+ (NSDictionary *)readVehicleEventJson {
    // 获取文件路径
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"TopdonDiagnosis.bundle/vehicleEventID" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dict?:@{};
}

+ (NSString *)readVehicleEventNameFromID:(NSString *)eventID {
    if ([NSString tdd_isEmpty:eventID]) {
        HLog(@"埋点ID key 为空");
        return @"";
    }
    NSDictionary *eventDict = [TDD_Tools readVehicleEventJson];
    NSString *eventName = [eventDict objectForKey:eventID];
    if ([NSString tdd_isEmpty:eventName]){
        HLog(@"埋点ID key 未找到");
        return eventID;
    }
    return eventName;
}

+ (NSDictionary *)readVehicleEventTypeJson {
    // 获取文件路径
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"TopdonDiagnosis.bundle/vehicleEventType" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dict?:@{};
}

+ (NSString *)readVehicleEventNameFromType:(NSString *)type {
    if ([NSString tdd_isEmpty:type]) {
        HLog(@"埋点Type key 为空");
        return @"";
    }
    NSDictionary *eventDict = [TDD_Tools readVehicleEventTypeJson];
    NSString *eventName = [eventDict objectForKey:type];
    if ([NSString tdd_isEmpty:eventName]){
        HLog(@"埋点Type key 未找到");
        return type;
    }
    return eventName;
}

+ (NSArray *)troubleCodeLevelArr {
    return @[
        @{@"state": @"当前", @"level": @"1"},
        @{@"state": @"历史", @"level": @"3"},
        @{@"state": @"待定", @"level": @"2"},
        @{@"state": @"丢失", @"level": @"2"},
        @{@"state": @"消极的/偶发的", @"level": @"3"},
        @{@"state": @"消极的", @"level": @"3"},
        @{@"state": @"偶发的", @"level": @"3"},
        @{@"state": @"主动的/静态的", @"level": @"1"},
        @{@"state": @"主动的 ", @"level": @"1"},
        @{@"state": @"静态的", @"level": @"3"},
        @{@"state": @"临时", @"level": @"2"},
        @{@"state": @"永久", @"level": @"1"},
        @{@"state": @"永久的", @"level": @"1"},
        @{@"state": @"间歇性的", @"level": @"2"},
        @{@"state": @"暂时的", @"level": @"2"},
        @{@"state": @"历史的", @"level": @"3"},
        @{@"state": @"激活的", @"level": @"1"},
        @{@"state": @"等待中", @"level": @"2"},
        @{@"state": @"失败", @"level": @"2"},
        @{@"state": @"已确认", @"level": @"1"},
        @{@"state": @"存储的", @"level": @"2"},
        @{@"state": @"激活", @"level": @"1"},
        @{@"state": @"存储", @"level": @"2"},
        @{@"state": @"N/A", @"level": @"3"},
        @{@"state": @"空白", @"level": @"2"},
        @{@"state": @"NA", @"level": @"2"},
        @{@"state": @"当前码/活动码", @"level": @"1"},
        @{@"state": @"存储码", @"level": @"2"},
        @{@"state": @"待定码", @"level": @"2"},
        @{@"state": @"未知码", @"level": @"2"},
        @{@"state": @"CMDTC", @"level": @"1"},
        @{@"state": @"ODDTC", @"level": @"3"},
        @{@"state": @"目前", @"level": @"1"},
        @{@"state": @"历史记录", @"level": @"2"},
        @{@"state": @"通过和失败", @"level": @"2"},
        @{@"state": @"未运行", @"level": @"2"},
        @{@"state": @"自清除DTC起已失败", @"level": @"2"},
        @{@"state": @"自清除DTC起测试未完成", @"level": @"2"},
        @{@"state": @"测试未完成该操作循环", @"level": @"2"},
        @{@"state": @"不合理", @"level": @"2"},
        @{@"state": @"未失败", @"level": @"2"},
        @{@"state": @"当前的 ", @"level": @"1"},
        @{@"state": @"已存储的 ", @"level": @"2"},
        @{@"state": @"未定义 ", @"level": @"2"},
        @{@"state": @"当前的和已存储的 ", @"level": @"1"},
        @{@"state": @"不存在", @"level": @"2"},
        @{@"state": @"故障不能再现", @"level": @"3"},
        @{@"state": @"故障持续存在", @"level": @"1"},
        @{@"state": @"间歇性", @"level": @"2"},
        @{@"state": @"持续性故障", @"level": @"1"},
        @{@"state": @"偶尔的故障", @"level": @"3"},
        @{@"state": @"存在", @"level": @"1"},
        @{@"state": @"永久性", @"level": @"1"},
        @{@"state": @"故障间歇出现", @"level": @"2"},
        @{@"state": @"隐藏 ", @"level": @"2"},
        @{@"state": @"间歇性故障", @"level": @"2"},
        @{@"state": @"遥控故障", @"level": @"2"},
        @{@"state": @"去除的持久故障", @"level": @"2"},
        @{@"state": @"偶然激活", @"level": @"2"},
        @{@"state": @"持续性激活", @"level": @"1"},
        @{@"state": @"去除的临时故障", @"level": @"3"},
        @{@"state": @"触发", @"level": @"2"},
        @{@"state": @"当前存在故障 ", @"level": @"1"},
        @{@"state": @"故障状态目前未知；未满足故障识别条件 ", @"level": @"2"},
        @{@"state": @"上次试验周期的状态：不存在故障", @"level": @"2"},
        @{@"state": @"目前不存在", @"level": @"3"},
        @{@"state": @"目前存在", @"level": @"2"},
        @{@"state": @"当前不存在故障，车载诊断系统未删除", @"level": @"3"},
        @{@"state": @"故障目前不存在，车载诊断系统已删除", @"level": @"3"},
        @{@"state": @"当前存在故障，车载诊断系统还未删除", @"level": @"2"},
        @{@"state": @"当前存在故障，车载诊断系统已删除", @"level": @"3"},
        @{@"state": @"故障状态目前未知，未满足故障识别条件", @"level": @"2"},
        @{@"state": @"当前存在故障", @"level": @"1"},
        @{@"state": @"当前不存在故障", @"level": @"3"},
        @{@"state": @"当前不存在故障，但已被存储", @"level": @"3"},
        @{@"state": @"当前存在故障且已存储", @"level": @"2"},
        @{@"state": @"当前存在故障，但还未存储 (删除阶段)", @"level": @"2"},
        @{@"state": @"故障目前不存在", @"level": @"3"},
        @{@"state": @"目前不存在故障 ", @"level": @"3"},
        @{@"state": @"故障未删除", @"level": @"2"},
        @{@"state": @"故障至今未出现", @"level": @"3"},
        @{@"state": @"故障不重要", @"level": @"3"},
        @{@"state": @"存在故障", @"level": @"1"},
        @{@"state": @"故障已排除或极其偶尔出现", @"level": @"2"},
        @{@"state": @"偶尔出现的故障", @"level": @"2"},
        @{@"state": @"故障状态目前未知，故障识别条件未满足", @"level": @"2"},
        @{@"state": @"数字传感器的故障状态", @"level": @"2"},
        @{@"state": @"故障被存储", @"level": @"2"},
        @{@"state": @"上一试验周期的存储状态错误：不存在故障", @"level": @"3"},
        @{@"state": @"上一试验周期的存储状态错误：存在故障", @"level": @"1"},
        @{@"state": @"上次试验周期的状态： 不存在故障", @"level": @"3"},
        @{@"state": @"上次试验周期的状态： 存在故障", @"level": @"1"},
        @{@"state": @"上次试验周期的状态：故障被存储", @"level": @"2"},
        @{@"state": @"上次试验周期的状态：未知", @"level": @"2"},
        @{@"state": @"上个试验周期状态，故障不存在", @"level": @"3"},
        @{@"state": @"上个试验周期状态，故障存在", @"level": @"1"},
        @{@"state": @"未知的故障类型", @"level": @"2"},
        @{@"state": @"当前故障码", @"level": @"1"},
        @{@"state": @"历史故障码", @"level": @"3"},
        @{@"state": @"当前的", @"level": @"1"},
        @{@"state": @"间歇的", @"level": @"2"},
        @{@"state": @"偶发故障", @"level": @"2"},
        @{@"state": @"当前故障", @"level": @"1"},
        @{@"state": @"无状态", @"level": @"2"},
        @{@"state": @"未定义", @"level": @"2"},
        @{@"state": @"间歇", @"level": @"2"},
        @{@"state": @"待定当前", @"level": @"2"},
        @{@"state": @"待定历史", @"level": @"3"},
        @{@"state": @"存储非当前", @"level": @"2"},
        @{@"state": @"当前非存储", @"level": @"1"},
        @{@"state": @"存储故障码", @"level": @"2"},
        @{@"state": @"历史故障", @"level": @"3"},
        @{@"state": @"偶发", @"level": @"2"},
        @{@"state": @"老化", @"level": @"3"},
        @{@"state": @"无故障", @"level": @"3"},
        @{@"state": @"当前未检测到", @"level": @"3"},
        @{@"state": @"已检测到，但当前不存在", @"level": @"2"},
        @{@"state": @"当前存在", @"level": @"1"},
        @{@"state": @"挂起", @"level": @"2"},
        @{@"state": @"在请求时间内没有检测到故障码", @"level": @"3"},
        @{@"state": @"故障码已检测到但在请求时间内不存在", @"level": @"2"},
        @{@"state": @"在时间请求内故障码偶发", @"level": @"2"},
        @{@"state": @"在时间请求内故障码存在", @"level": @"1"},
        @{@"state": @"故障码已检测到但在当前请求时间内不存在", @"level": @"2"},
        @{@"state": @"当前故障码永久/间歇", @"level": @"1"},
        @{@"state": @"故障码在当前请求时间内存在", @"level": @"1"},
        @{@"state": @"存储故障", @"level": @"2"},
        @{@"state": @"零星故障", @"level": @"2"},
        @{@"state": @"间歇故障", @"level": @"2"},
        @{@"state": @"未确认故障", @"level": @"3"},
        @{@"state": @"电气故障", @"level": @"2"},
        @{@"state": @"存储器故障", @"level": @"2"},
        @{@"state": @"已证实故障", @"level": @"2"},
        @{@"state": @"自上次清除后测试未完成", @"level": @"3"},
        @{@"state": @"自上次清除后测试失败", @"level": @"2"},
        @{@"state": @"这次操作测试未完成", @"level": @"2"},
        @{@"state": @"未决故障", @"level": @"2"},
        @{@"state": @"历史或当前故障", @"level": @"2"},
        @{@"state": @"未知状态", @"level": @"2"},
        @{@"state": @"非激活", @"level": @"3"},
        @{@"state": @"历史故障,不点亮故障灯", @"level": @"3"},
        @{@"state": @"当前故障,不点亮故障灯", @"level": @"1"},
        @{@"state": @"历史故障,点亮故障灯", @"level": @"2"},
        @{@"state": @"当前故障,点亮故障灯", @"level": @"1"},
        @{@"state": @"缺陷-偶然性故障", @"level": @"2"},
        @{@"state": @"[历史]", @"level": @"3"},
        @{@"state": @"[间歇]", @"level": @"2"},
        @{@"state": @"[当前]", @"level": @"1"},
        @{@"state": @"目前故障间歇发生", @"level": @"2"},
        @{@"state": @"当前故障，也是历史故障", @"level": @"1"},
        @{@"state": @"间歇发生", @"level": @"2"},
        @{@"state": @"当前故障,也是历史故障", @"level": @"1"},
        @{@"state": @"永久故障", @"level": @"1"},
        @{@"state": @"无指示-持续性故障", @"level": @"1"},
        @{@"state": @"Activated", @"level": @"2"},
        @{@"state": @"OPEN-偶发故障", @"level": @"2"},
        @{@"state": @"Activated-偶发故障", @"level": @"2"},
        @{@"state": @"偶然", @"level": @"2"},
        @{@"state": @"永久性故障", @"level": @"1"},
        @{@"state": @"偶然性故障", @"level": @"2"},
        @{@"state": @"未知故障", @"level": @"2"},
        @{@"state": @"未确定", @"level": @"2"},
        @{@"state": @"持续", @"level": @"1"},
        @{@"state": @"偶尔性故障", @"level": @"2"},
        @{@"state": @"历史故障码；此故障没有点亮故障灯", @"level": @"3"},
        @{@"state": @"当前故障码；此故障没有点亮故障灯", @"level": @"1"},
        @{@"state": @"历史故障码；此故障点亮故障灯", @"level": @"3"},
        @{@"state": @"当前故障码；此故障点亮故障灯", @"level": @"1"},
        @{@"state": @"故障号检测到，并存储到 EEPROM", @"level": @"1"},
        @{@"state": @"故障号未检测到", @"level": @"3"},
        @{@"state": @"当前故障码/历史故障码", @"level": @"2"},
        @{@"state": @"历史故障 - 无故障征兆", @"level": @"3"},
        @{@"state": @"故障灯点亮,历史故障", @"level": @"2"},
        @{@"state": @"故障灯点亮,当前故障", @"level": @"1"},
        @{@"state": @"本检测周期测试失效", @"level": @"2"},
        @{@"state": @"上次清零后测试未完成", @"level": @"2"},
        @{@"state": @"上次清零后测试失效", @"level": @"2"},
        @{@"state": @"本检测周期测试未完成", @"level": @"2"},
        @{@"state": @"活性故障", @"level": @"1"},
        @{@"state": @"确认的故障码", @"level": @"2"},
        @{@"state": @"挂起的故障码", @"level": @"2"},
        @{@"state": @"当前和历史故障", @"level": @"1"},
        @{@"state": @"当前&历史故障", @"level": @"2"},
        @{@"state": @"历史或偶然", @"level": @"3"},
        @{@"state": @"无效值", @"level": @"2"},
        @{@"state": @"无故障码状态", @"level": @"3"},
        @{@"state": @"没有故障类型", @"level": @"2"},
        @{@"state": @"无信号", @"level": @"2"},
        @{@"state": @"用久码", @"level": @"1"},
        @{@"state": @"当前码", @"level": @"1"},
        @{@"state": @"历史码", @"level": @"3"},
        @{@"state": @"被动/偶尔发生", @"level": @"3"},
        @{@"state": @"主动/静态", @"level": @"1"},
        @{@"state": @"被动/偶发", @"level": @"3"},
        @{@"state": @"tbd.", @"level":@"2"},
        @{@"state": @"上次试验周期的状态： 未知", @"level": @"2"},
        @{@"state": @"上次试验周期的状态：存在故障", @"level": @"1"}
        
    ];
}


@end
