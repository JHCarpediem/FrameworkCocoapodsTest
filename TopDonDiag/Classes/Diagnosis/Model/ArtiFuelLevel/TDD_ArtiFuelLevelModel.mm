//
//  TDD_ArtiFuelLevelModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/17.
//

#import "TDD_ArtiFuelLevelModel.h"
#if useCarsFramework
#import <CarsFramework/RegFuelLevel.hpp>
#import <CarsFramework/HStdOtherMaco.h>
#else
#import "RegFuelLevel.hpp"
#import "HStdOtherMaco.h"
#endif

#import "TDD_CTools.h"
#import "TDD_ADASManage.h"
@implementation TDD_ArtiFuelLevelModel
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegFuelLevel::Construct(ArtiFuelLevelConstruct);
    CRegFuelLevel::Destruct(ArtiFuelLevelDestruct);
    CRegFuelLevel::InitTips(ArtiFuelLevelInitTips);
    //沒实现的都是 app 写死的
    CRegFuelLevel::GetInputValue(ArtiFuelLevelGetInputValue);
    CRegFuelLevel::SetInputDefault(ArtiFuelLevelSetInputDefault);
    CRegFuelLevel::Show(ArtiFuelLevelShow);
    
}

void ArtiFuelLevelConstruct(uint32_t id)
{
    [TDD_ArtiFuelLevelModel Construct:id];
}

void ArtiFuelLevelDestruct(uint32_t id)
{
    [TDD_ArtiFuelLevelModel Destruct:id];
}

bool ArtiFuelLevelInitTips(uint32_t id, const std::string& strTips,uint32_t posType)
{
    return [TDD_ArtiFuelLevelModel InitTipsWithId:id strTips:[TDD_CTools CStrToNSString:strTips] posType:posType];
}

void ArtiFuelLevelSetInputDefault(uint32_t id,uint32_t uValue)
{
    [TDD_ArtiFuelLevelModel SetInputDefaultWithId:id value:uValue];
}

uint16_t ArtiFuelLevelGetInputValue(uint32_t id)
{
    return [TDD_ArtiFuelLevelModel GetInputValueWithId:id];
}

uint32_t ArtiFuelLevelShow(uint32_t id)
{
    return [TDD_ArtiFuelLevelModel ShowWithId:id];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiFuelLevelModel * model = (TDD_ArtiFuelLevelModel *)[self getModelWithID:ID];
    if ([TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric) {
        
    }
    if ([TDD_ADASManage shared].oliValue > 0) {
        model.oliValue = [TDD_ADASManage shared].oliValue;
    }else {
        model.oliValue = 5;
    }
    model.warningTips = [NSString stringWithFormat:@"*%@", TDDLocalized.insufficient_fuel_tip];
    model.strTitle = TDDLocalized.vehicle_data;
    model.strTips = [NSString stringWithFormat:@"* %@", TDDLocalized.input_oli];//app 写死
    
    NSArray * titleArr = @[TDDLocalized.app_prev,TDDLocalized.app_confirm];
    
    NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_ENABLE)];
    
    NSArray * IDArr = @[@(DF_ID_BACK),@(DF_ID_OK)];
    
    for (int i = 0; i < titleArr.count; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
        buttonModel.uButtonId = [IDArr[i] intValue];
        
        buttonModel.strButtonText = titleArr[i];
        
        buttonModel.uStatus = (ArtiButtonStatus)[statusArr[i] intValue];
        
        buttonModel.bIsEnable = YES;
        
        [model.buttonArr addObject:buttonModel];
    }
    model.isReloadButton = YES;
}

/****************************************************************
*    功  能：设置燃油液位输入框的提示文本
*
*    参  数：strTips  提示文本
*            posTyp   TIPS_IS_TOP    燃油液位的提示符居于顶部显示
*                     TIPS_IS_BOTTOM 燃油液位的提示符居于底部显示
*
*    返回值：无
****************************************************************/
+ (BOOL)InitTipsWithId:(uint32_t)ID strTips:(NSString *)strTips posType:(uint32_t)posType{
    HLog(@"%@ - 初始化轮眉，同时设置提示文本 - ID:%d - 提示 ：%@ - posType : %d" , [self class], ID, strTips,posType);
    
    [self Destruct:ID];
    
    TDD_ArtiFuelLevelModel * model = (TDD_ArtiFuelLevelModel *)[self getModelWithID:ID];//
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiFuelLevelModel *)[self getModelWithID:ID];
    }

    model.posType = (ePosType)posType;//没用，固定位置
    return YES;
}

/****************************************************************
*    功  能：设置燃油液位对应项输入框的默认值
*
*    参  数：uValue    输入框默认值
*                      范围是[0~10]
*                      例如 0 代表 0%
*                           1 代表 10%
*                           2 代表 20%
*                           3 代表 30%
*                           4 代表 40%
*                           5 代表 50%
*                           6 代表 60%
*                           7 代表 70%
*                           8 代表 80%
*                           9 代表 90%
*                           10 代表100%
*
*    返回值：无
*
*    注  意：如果没有调用此接口，默认为无值
****************************************************************/
+ (void)SetInputDefaultWithId:(uint32_t)ID value:(uint32_t)value{
    HLog(@"%@ - 设置燃油的默认值 - ID:%d  - value : %d" , [self class], ID,value);
    if ([TDD_ADASManage shared].oliValue > 0) {
        return;
    }
    TDD_ArtiFuelLevelModel * model = (TDD_ArtiFuelLevelModel *)[self getModelWithID:ID];
    value = MIN(10, value);
    value = MAX(0, value);
    model.oliValue = value;
}

/****************************************************************
*    功  能：获取燃油液位对应的输入值
*
*    参  数：无
*
*    返回值：对应的返回值
*            范围是[0~10]
*            例如 0 代表 0%
*                 1 代表 10%
*                 2 代表 20%
*                 3 代表 30%
*                 4 代表 40%
*                 5 代表 50%
*                 6 代表 60%
*                 7 代表 70%
*                 8 代表 80%
*                 9 代表 90%
*                 10 代表100%
****************************************************************/
+ (uint32_t )GetInputValueWithId:(uint32_t)ID {
    TDD_ArtiFuelLevelModel * model = (TDD_ArtiFuelLevelModel *)[self getModelWithID:ID];

    return model.oliValue;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    if (buttonID == DF_ID_OK) {
        if (self.oliValue <=3) {
            self.showWarning = YES;
            [self reloadButtonView];
            return NO;
        }else {
            [TDD_ADASManage shared].oliValue = _oliValue;
            self.showWarning = NO;
        }
    }
    
    return YES;
}
- (void)reloadButtonView {
    self.isReloadButton = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
    });
}
@end
