//
//  TDD_ArtiWheelBrowModel.m
//  TopdonDiagnosis
//
//  Created by huangjiahui on 2024/5/17.
//

#import "TDD_ArtiWheelBrowModel.h"

#if useCarsFramework
#import <CarsFramework/RegWheelBrow.hpp>
#import <CarsFramework/HStdOtherMaco.h>
#else
#import "RegWheelBrow.hpp"
#import "HStdOtherMaco.h"
#endif

#import "TDD_CTools.h"
#import "TDD_ADASManage.h"

@implementation TDD_ArtiWheelBrowItemModel
- (instancetype)initWithValue:(CGFloat )value {
    if (self = [super init]) {
        _value = value;
    }
    return self;
}
@end

@interface TDD_ArtiWheelBrowModel()
@property (nonatomic, strong)NSArray *warnTipArr;

@end
@implementation TDD_ArtiWheelBrowModel
#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegWheelBrow::Construct(ArtiWheelBrowConstruct);
    CRegWheelBrow::Destruct(ArtiWheelBrowDestruct);
    CRegWheelBrow::InitTips(ArtiWheelBrowInitTips);
    CRegWheelBrow::SetInputDefault(ArtiWheelBrowSetInputDefault);
    CRegWheelBrow::GetInputValue(ArtiWheelBrowGetInputValue);
    //app 轮眉警告 app 处理
//    CRegWheelBrow::SetInputWarning(ArtiWheelBrowSetInputWarning);
    CRegWheelBrow::SetWarningTips(ArtiWheelBorwSetSetWarning);
    CRegWheelBrow::Show(ArtiWheelBrowShow);
    
}

void ArtiWheelBrowConstruct(uint32_t id)
{
    [TDD_ArtiWheelBrowModel Construct:id];
}

void ArtiWheelBrowDestruct(uint32_t id)
{
    [TDD_ArtiWheelBrowModel Destruct:id];
}

bool ArtiWheelBrowInitTips(uint32_t id, const std::string& strTips,uint32_t posType)
{
    return [TDD_ArtiWheelBrowModel InitTipsWithId:id strTips:[TDD_CTools CStrToNSString:strTips] posType:posType];
}

void ArtiWheelBrowSetInputDefault(uint32_t id, uint32_t eAcdType, uint32_t uValue)
{
    [TDD_ArtiWheelBrowModel SetInputDefaultWithId:id acdType:eAcdType value:uValue];
}

uint16_t ArtiWheelBrowGetInputValue(uint32_t id,uint32_t eAcdType)
{
    return [TDD_ArtiWheelBrowModel GetInputValueWithId:id eAcdType:(uint32_t)eAcdType];
}

void ArtiWheelBrowSetInputWarning(uint32_t id, uint32_t eAcdType)
{
    [TDD_ArtiWheelBrowModel SetSetInputWarningWithId:id eAcdType:eAcdType];
}

void ArtiWheelBorwSetSetWarning(uint32_t id,const std::string& strTips)
{
    [TDD_ArtiWheelBrowModel SetSetWarningTipsWithId:id strTips:[TDD_CTools CStrToNSString:strTips]];
}

uint32_t ArtiWheelBrowShow(uint32_t id)
{
    return [TDD_ArtiWheelBrowModel ShowWithId:id];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiWheelBrowModel * model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];

    model.strTitle = TDDLocalized.vehicle_data;
    
    model.strTips = [NSString stringWithFormat:@"* %@", TDDLocalized.input_wheel_brow];//app 写死
    NSString *mmStr = [NSString stringWithFormat:@"*%@",[TDDLocalized.wheel_brow_error stringByReplacingOccurrencesOfString:@"%@" withString:@">5mm"]];
    NSString *inchStr = [NSString stringWithFormat:@"*%@",[TDDLocalized.wheel_brow_error stringByReplacingOccurrencesOfString:@"%@" withString:@">0.2inch"]];
    model.warningTips = [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric ? mmStr : inchStr;
    model.lfBrowModel = [[TDD_ArtiWheelBrowItemModel alloc] initWithValue:[TDD_ADASManage shared].wheelBrowModel.lfBrowModel.value];
    model.rfBrowModel = [[TDD_ArtiWheelBrowItemModel alloc] initWithValue:[TDD_ADASManage shared].wheelBrowModel.rfBrowModel.value];
    model.lrBrowModel = [[TDD_ArtiWheelBrowItemModel alloc] initWithValue:[TDD_ADASManage shared].wheelBrowModel.lrBrowModel.value];
    model.rrBrowModel = [[TDD_ArtiWheelBrowItemModel alloc] initWithValue:[TDD_ADASManage shared].wheelBrowModel.rrBrowModel.value];
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    
    buttonModel.uButtonId = DF_ID_NEXT;
    
    buttonModel.strButtonText = TDDLocalized.app_next;
    
    buttonModel.uStatus = model.lfBrowModel.value>0 ? ArtiButtonStatus_ENABLE : ArtiButtonStatus_DISABLE;
    
    buttonModel.bIsEnable = YES;
    
    [model.buttonArr addObject:buttonModel];
    model.isReloadButton = YES;
}

/**********************************************************
*    功  能：设置轮眉高度输入框的提示文本
*
*    参  数：strTips  提示文本
*            posTyp   TIPS_IS_TOP    轮眉高度的提示符居于顶部显示
*                     TIPS_IS_BOTTOM 轮眉高度的提示符居于底部显示
*
*    返回值：无
**********************************************************/
+ (BOOL)InitTipsWithId:(uint32_t)ID strTips:(NSString *)strTips posType:(uint32_t)posType{
    HLog(@"%@ - 初始化轮眉，同时设置提示文本 - ID:%d - 提示 ：%@ - posType : %d" , [self class], ID, strTips,posType);
    
    [self Destruct:ID];
    
    TDD_ArtiWheelBrowModel * model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];//
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];
        model.posType = (ePosType)posType;//没用，固定位置
    }

    return YES;
}

/**********************************************************
*    功  能：设置轮眉高度对应项输入框的默认值
*
*    参  数：eAcdType  轮眉高度输入项类型
*
*                ACD_CAL_WHEEL_BROW_HEIGHT_LF  左前轮
*                ACD_CAL_WHEEL_BROW_HEIGHT_RF  右前轮
*                ACD_CAL_WHEEL_BROW_HEIGHT_LR  左后轮
*                ACD_CAL_WHEEL_BROW_HEIGHT_RR  右后轮
*
*            uValue    对应的输入默认值
*
*    返回值：无
*
*    注  意：如果没有调用此接口，默认为无值
**********************************************************/
+ (void)SetInputDefaultWithId:(uint32_t)ID acdType:(uint32_t )acdType value:(uint32_t)value{
    HLog(@"%@ - 设置轮眉高度对应项输入框的默认值 - ID:%d - eAcdType ：%d - value : %d" , [self class], ID, acdType,value);
    
    TDD_ArtiWheelBrowModel * model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];
    if ([TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric) {
        value = MIN(1000, value);
        value = MAX(500, value);
    }else {
        value = MIN(39.4, value);
        value = MAX(19.7, value);
    }
    switch ((eAdasCaliData)acdType) {
        case ACD_CAL_WHEEL_BROW_HEIGHT_LF:
            model.lfBrowModel.value = value;
            break;
        case ACD_CAL_WHEEL_BROW_HEIGHT_RF:
            model.rfBrowModel.value = value;
            break;
        case ACD_CAL_WHEEL_BROW_HEIGHT_LR:
            model.lrBrowModel.value = value;
            break;
        case ACD_CAL_WHEEL_BROW_HEIGHT_RR:
            model.rrBrowModel.value = value;
            break;
            
        default:
            break;
    }

}

+ (uint32_t )GetInputValueWithId:(uint32_t)ID eAcdType:(uint32_t)eAcdType {
    TDD_ArtiWheelBrowModel * model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];//
    switch ((eAdasCaliData)eAcdType) {
        case ACD_CAL_WHEEL_BROW_HEIGHT_LF:
            return model.lfBrowModel.value;

        case ACD_CAL_WHEEL_BROW_HEIGHT_RF:
            return model.rfBrowModel.value;

        case ACD_CAL_WHEEL_BROW_HEIGHT_LR:
            return model.lrBrowModel.value;

        case ACD_CAL_WHEEL_BROW_HEIGHT_RR:
            return model.rrBrowModel.value;

            
        default:
            return 0;
            break;
    }
}

+ (void )SetSetInputWarningWithId:(uint32_t)ID eAcdType:(uint32_t)eAcdType {
    TDD_ArtiWheelBrowModel * model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];//
    switch ((eAdasCaliData)eAcdType) {
        case ACD_CAL_WHEEL_BROW_HEIGHT_LF:
            model.lfBrowModel.showWarn = YES;

        case ACD_CAL_WHEEL_BROW_HEIGHT_RF:
            model.rfBrowModel.showWarn = YES;

        case ACD_CAL_WHEEL_BROW_HEIGHT_LR:
            model.lrBrowModel.showWarn = YES;

        case ACD_CAL_WHEEL_BROW_HEIGHT_RR:
            model.rrBrowModel.showWarn = YES;

            
        default:
            break;
    }
}

+ (void )SetSetWarningTipsWithId:(uint32_t)ID strTips:(NSString *)strTips {
    //app写死
//    TDD_ArtiWheelBrowModel * model = (TDD_ArtiWheelBrowModel *)[self getModelWithID:ID];
    //model.warningTips = strTips;
}

//误差值根据单位切换 公制 - 5mm 英制 - 0.2inch
- (void)handleDifference {
    CGFloat error = [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric ? 5: 0.2;
    BOOL frontError = (fabsf(self.lfBrowModel.value - self.rfBrowModel.value) > error) && self.lfBrowModel.value >0 && self.rfBrowModel.value >0;
    BOOL backError = fabsf(self.lrBrowModel.value - self.rrBrowModel.value) > error  && self.lrBrowModel.value >0 && self.rrBrowModel.value >0;
    NSInteger warnType = 0;
    if (frontError && backError) {
        _warningType = 3;
    }else if (frontError) {
        _warningType = 1;
    }else if (backError) {
        _warningType = 2;
    }else {
        _warningType = 0;
    }
    if (_warningType > 0) {
        _warningTips = self.warnTipArr[_warningType - 1];
    }
    
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    if (buttonID == DF_ID_NEXT) {
        if (_warningType > 0) {
            return NO;
        }else {
            [TDD_ADASManage shared].wheelBrowModel = [self yy_modelCopy];
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

- (NSArray *)warnTipArr {
    if (!_warnTipArr) {
        NSString *errorStr = [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric ? @">5mm" : @">0.2inch";
        NSString *allError = [TDDLocalized.wheel_brow_error stringByReplacingOccurrencesOfString:@"%@" withString:errorStr];
        _warnTipArr = @[[TDDLocalized.wheel_brow_error stringByReplacingOccurrencesOfString:@"%@" withString:errorStr],[TDDLocalized.wheel_brow_front_error stringByReplacingOccurrencesOfString:@"%@" withString:errorStr],[TDDLocalized.wheel_brow_rear_error stringByReplacingOccurrencesOfString:@"%@" withString:errorStr]];
    }
    
    return _warnTipArr;
}
@end
