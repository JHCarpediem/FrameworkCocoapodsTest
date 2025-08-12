//
//  TDD_ArtiFloatMiniModel.m
//  Alamofire
//
//  Created by zhouxiong on 2024/8/15.
//

#import "TDD_ArtiFloatMiniModel.h"
#if useCarsFramework
#import <CarsFramework/RegFloatMini.hpp>
#else
#import "RegFloatMini.hpp"
#endif

#import "TDD_ArtiGlobalModel.h"
#import "TDD_CTools.h"
#import "TDD_ArtiInstanceView.h"

#define DF_ID_INVALID_FLOAT_ID  (0xFFFFFFFF)

enum eFloatType
{
    FT_TIMER_TYPE   = 1,                // 展示时钟
    FT_TYPE_INVALID   = 0xFFFFFFFF,     // 不存在
}eFloatType;

@implementation TDD_ArtiFloatMiniModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    // 大众 SFD 解锁
    CRegFloatMini::NewInstance(ArtiFloatMiniNewInstance);
    CRegFloatMini::DeleteInstance(ArtiFloatMiniDeleteInstance);
    CRegFloatMini::Display(ArtiFloatMiniDisplay);
    CRegFloatMini::Hidden(ArtiFloatMiniHidden);

}

// 创建浮窗
uint32_t ArtiFloatMiniNewInstance(uint32_t eType)
{
    return [TDD_ArtiFloatMiniModel NewInstance:eType];
}

// 删除浮窗
uint32_t ArtiFloatMiniDeleteInstance(uint32_t FloatID)
{
    return [TDD_ArtiFloatMiniModel DeleteInstance:FloatID];
}

// 显示浮窗
uint32_t ArtiFloatMiniDisplay(uint32_t FloatID, const std::string& strContent)
{
    return [TDD_ArtiFloatMiniModel Display:FloatID str:[TDD_CTools CStrToNSString:strContent]];
}

// 隐藏浮窗
uint32_t ArtiFloatMiniHidden(uint32_t FloatID)
{
    return [TDD_ArtiFloatMiniModel HiddenInstance:FloatID];
}


/*-----------------------------------------------------------------------------
  功    能：新建一个悬浮窗

  参数说明：eType  悬浮窗类型，默认是倒计时类型，悬浮窗有一个闹钟图标

  返 回 值：返回悬浮窗编号ID（句柄），例如 0x00000001，表示索引为1的悬浮球
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口

  说    明：浮窗数量最多3个
-----------------------------------------------------------------------------*/
+ (uint32_t)NewInstance:(uint32_t)eType {
    HLog(@"%@ - NewInstance - %@", [self class], @(eType));
    uint32_t ID = [TDD_ArtiFloatMiniModel addUniqueIndex];
    [self Destruct:ID];
    TDD_ArtiFloatMiniModel *model = [TDD_ArtiFloatMiniModel checkHasMiniModel:ID needNew:YES];

    model.showTimer = (eType == FT_TIMER_TYPE);
        
    return ID;
}

/*-----------------------------------------------------------------------------
  功    能：设置悬浮窗图标下的文字说明并显示

  参数说明：FloatID       悬浮窗ID，哪一个悬浮窗
                          FloatID由NewInstance接口返回

            strContent    悬浮窗图标下的文字说明

  返 回 值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

            如果不存在指定的悬浮窗，返回DF_ID_INVALID_FLOAT_ID

            其它值，暂无意义

  说    明：同时显示的浮窗最多3个
-----------------------------------------------------------------------------*/
+ (uint32_t)Display:(uint32_t)FloatID str:(NSString *)str {
    HLog(@"%@ - Display - %@ - %@", [self class], @(FloatID), str);
    TDD_ArtiFloatMiniModel *model = [TDD_ArtiFloatMiniModel checkHasMiniModel:FloatID needNew:NO];
    uint32_t type = DF_ID_INVALID_FLOAT_ID;
    if (model) {
        model.strContent = str;
        type = FloatID;
        [TDD_ArtiFloatMiniModel checkShow:model];
    }
    return type;
}

/*-----------------------------------------------------------------------------
  功    能：删除一个悬浮窗

  参数说明：FloatID  悬浮窗ID
                     FloatID由NewInstance接口返回

  返 回 值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

            如果不存在指定的悬浮窗，返回DF_ID_INVALID_FLOAT_ID

            其它值，暂无意义

  说    明：如果FloatID悬浮窗为显示状态，删除后将消失
-----------------------------------------------------------------------------*/
+ (uint32_t)DeleteInstance:(uint32_t)FloatID {
    HLog(@"%@ - DeleteInstance - %@", [self class], @(FloatID));
    TDD_ArtiFloatMiniModel *model = [TDD_ArtiFloatMiniModel checkHasMiniModel:FloatID needNew:NO];
    uint32_t type = DF_ID_INVALID_FLOAT_ID;
    if (model) {
        type = FloatID;
        model.hidden = YES;
        [TDD_ArtiFloatMiniModel checkShow:model];
        [self Destruct:model.ID];
    }
    
    return type;
}

+ (uint32_t)HiddenInstance:(uint32_t)FloatID {
    HLog(@"%@ - HiddenInstance - %@", [self class], @(FloatID));
    TDD_ArtiFloatMiniModel *model = [TDD_ArtiFloatMiniModel checkHasMiniModel:FloatID needNew:NO];
    uint32_t type = DF_ID_INVALID_FLOAT_ID;
    if (model) {
        type = FloatID;
        model.hidden = YES;
        [TDD_ArtiFloatMiniModel checkShow:model];
    }
    
    return type;
}

+ (TDD_ArtiFloatMiniModel *)checkHasMiniModel:(uint32_t)ID needNew:(BOOL)needNew {

    TDD_ArtiFloatMiniModel * model = (TDD_ArtiFloatMiniModel *)[self getModelWithID:ID];
    if (!model && needNew) {
        [self Construct:ID];
        model = (TDD_ArtiFloatMiniModel *)[self getModelWithID:ID];
        model.ID = [@(ID) intValue];
        model.strContent = @"";
    }
    
    return model;
}

+ (void)checkShow:(TDD_ArtiFloatMiniModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShowFloatMini object:model userInfo:nil];
    });
}

// 新增索引
+ (uint32_t)addUniqueIndex {
    NSMutableArray *idArr = [TDD_ArtiGlobalModel sharedArtiGlobalModel].instanceIDArr;
    if (!idArr) {
        idArr = [NSMutableArray array];
    }
    
    uint32_t newIndex = (uint32_t)(idArr.count + 100); // 初始索引值
    
    while ([idArr containsObject:@(newIndex)]) {
        newIndex += 1; // 如果索引已经存在，增加索引值
    }
    
    [idArr addObject:@(newIndex)];
    NSLog(@"Added Index: %u", newIndex); // 输出新增的索引
    
    return newIndex;
}

@end
