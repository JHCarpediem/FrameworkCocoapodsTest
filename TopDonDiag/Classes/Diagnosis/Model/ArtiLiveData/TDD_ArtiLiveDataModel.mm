//
//  TDD_ArtiLiveDataModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/30.
//

#import "TDD_ArtiLiveDataModel.h"

#if useCarsFramework
#import <CarsFramework/RegLiveData.hpp>
#else
#import "RegLiveData.hpp"
#endif

#import "TDD_CTools.h"

#import "TDD_ArtiLiveDataSelectModel.h"

#import "TDD_HChartModel.h"

#import "TDD_UnitConversion.h"
#import "TDD_DiagnosisViewController.h"

#import "TDD_DiagnosisViewController.h"
@implementation TDD_ArtiLiveDataModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CRegLiveData::Construct(ArtiLiveDataConstruct);
    CRegLiveData::Destruct(ArtiLiveDataDestruct);
    //TopVCI 新增
    CRegLiveData::SetComponentType(ArtiLiveDataSetComponentType);
    CRegLiveData::SetComponentResult(ArtiLiveDataSetComponentResult);
    CRegLiveData::InitTitle(ArtiLiveDataInitTitle);
    CRegLiveData::AddItem(ArtiLiveDataAddItem);
    CRegLiveData::SetNextButtonVisible(ArtiLiveDataSetNextButtonVisible);
    CRegLiveData::SetNextButtonText(ArtiLiveDataSetNextButtonText);
    CRegLiveData::SetPrevButtonVisible(ArtiLiveDataSetPrevButtonVisible);
    CRegLiveData::SetPrevButtonText(ArtiLiveDataSetPrevButtonText);
    //TODO: 数据流接口按钮增加
    CRegLiveData::SetName(ArtiLiveDataSetName);
    CRegLiveData::SetVaule(ArtiLiveDataSetValue);
    CRegLiveData::SetUnit(ArtiLiveDataSetUnit);
    CRegLiveData::SetLimits(ArtiLiveDataSetLimits);
    CRegLiveData::SetReference(ArtiLiveDataSetReference);
    CRegLiveData::SetHelpText(ArtiLiveDataSetHelpText);
    CRegLiveData::SetColWidth(ArtiLiveDataSetColWidth);
    CRegLiveData::FlushValue(ArtiLiveDataFlushValue);
    CRegLiveData::GetUpdateItems(ArtiLiveDataGetUpdateItems);
    CRegLiveData::GetItemIsUpdate(ArtiLiveDataGetItemIsUpdate);

    CRegLiveData::GetSearchItems(ArtiLiveDataGetSearchItems);
    CRegLiveData::GetSelectedItems(ArtiLiveDataGetSelectedItems);
    CRegLiveData::GetLimitsModifyItems(ArtiLiveDataGetLimitsModifyItems);
    CRegLiveData::GetLimits(ArtiLiveDataGetLimits);
    CRegLiveData::GetReportItems(ArtiLiveDataGetReportItems);
    

    CRegLiveData::Show(ArtiLiveDataShow);
}

void ArtiLiveDataSetComponentType(uint32_t id, uint32_t uType)
{
    [TDD_ArtiLiveDataModel SetComponentType:id uType:uType];
}

void ArtiLiveDataSetComponentResult(uint32_t id, uint32_t uResult)
{
    [TDD_ArtiLiveDataModel SetComponentResult:id uResult:uResult];
}

void ArtiLiveDataConstruct(uint32_t id)
{
    [TDD_ArtiLiveDataModel Construct:id];
}

void ArtiLiveDataDestruct(uint32_t id)
{
    [TDD_ArtiLiveDataModel Destruct:id];
}

bool ArtiLiveDataInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiLiveDataModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

void ArtiLiveDataAddItem(uint32_t id, const std::string& strName, const std::string& strValue, const std::string& strUnit, const std::string& strMin, const std::string& strMax, const std::string& strReference)
{
    [TDD_ArtiLiveDataModel AddItemWithId:id strName:[TDD_CTools CStrToNSString:strName] strValue:[TDD_CTools CStrToNSString:strValue] strUnit:[TDD_CTools CStrToNSString:strUnit] strMin:[TDD_CTools CStrToNSString:strMin] strMax:[TDD_CTools CStrToNSString:strMax] strReference:[TDD_CTools CStrToNSString:strReference]];
}

void ArtiLiveDataSetPrevButtonVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiLiveDataModel SetPrevButtonVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiLiveDataSetPrevButtonText(uint32_t id, const std::string& strButtonText)
{
    [TDD_ArtiLiveDataModel SetPrevButtonTextWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

void ArtiLiveDataSetNextButtonVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiLiveDataModel SetNextButtonVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiLiveDataSetNextButtonText(uint32_t id, const std::string& strButtonText)
{
    [TDD_ArtiLiveDataModel SetNextButtonTextWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

//TODO: 数据流接口按钮增加
void ArtiLiveDataSetName(uint32_t id, uint16_t uIndex, const std::string& strName)
{
    [TDD_ArtiLiveDataModel setNameWithId:id uIndex:uIndex strName:[TDD_CTools CStrToNSString:strName]];
}

void ArtiLiveDataSetValue(uint32_t id, uint16_t uIndex, const std::string& strValue)
{
    [TDD_ArtiLiveDataModel setValueWithId:id uIndex:uIndex strValue:[TDD_CTools CStrToNSString:strValue]];
}



void ArtiLiveDataSetUnit(uint32_t id, uint16_t uIndex, const std::string& strUnit)
{
    [TDD_ArtiLiveDataModel SetUnitWithId:id uIndex:uIndex strUnit:[TDD_CTools CStrToNSString:strUnit]];
}

void ArtiLiveDataSetLimits(uint32_t id, uint16_t uIndex, const std::string& strMin, const std::string& strMax)
{
    [TDD_ArtiLiveDataModel SetLimitsWithId:id uIndex:uIndex strMin:[TDD_CTools CStrToNSString:strMin] strMax:[TDD_CTools CStrToNSString:strMax]];
}

void ArtiLiveDataSetReference(uint32_t id, uint16_t uIndex, const std::string& strReference)
{
    [TDD_ArtiLiveDataModel SetReferenceWithId:id uIndex:uIndex strReference:[TDD_CTools CStrToNSString:strReference]];
}

void ArtiLiveDataSetHelpText(uint32_t id, uint16_t uIndex, const std::string& strHelpText)
{
    [TDD_ArtiLiveDataModel SetHelpTextWithId:id uIndex:uIndex strHelpText:[TDD_CTools CStrToNSString:strHelpText]];
}

void ArtiLiveDataSetColWidth(uint32_t id, int32_t widthName, int32_t widthValue, int32_t widthUnit, int32_t widthRef)
{
    [TDD_ArtiLiveDataModel SetColWidthWithId:id widthName:widthName widthValue:widthValue widthUnit:widthUnit widthRef:widthRef];
}

void ArtiLiveDataFlushValue(uint32_t id, uint16_t uIndex, const std::string& strValue)
{
    [TDD_ArtiLiveDataModel FlushValueWithId:id uIndex:uIndex strValue:[TDD_CTools CStrToNSString:strValue]];
}

std::vector<uint16_t> ArtiLiveDataGetUpdateItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiLiveDataModel GetUpdateItemsWithId:id];
    
    std::vector<uint16_t> vct = [TDD_CTools NSArrayToInt16CVector:arr];
    
    return vct;
}

bool ArtiLiveDataGetItemIsUpdate(uint32_t id, uint16_t uIndex)
{
    return [TDD_ArtiLiveDataModel GetItemIsUpdateWithId:id uIndex:uIndex];
}

std::vector<uint16_t> ArtiLiveDataGetSearchItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiLiveDataModel GetSearchItemsWithId:id];
    
    std::vector<uint16_t> vct = [TDD_CTools NSArrayToInt16CVector:arr];
    
    return vct;
}

std::vector<uint16_t> ArtiLiveDataGetSelectedItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiLiveDataModel GetSelectedItemsWithId:id];
    
    std::vector<uint16_t> vct = [TDD_CTools NSArrayToInt16CVector:arr];
    
    return vct;
}

std::vector<uint16_t> ArtiLiveDataGetLimitsModifyItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiLiveDataModel GetModifyLimitItems:id];
    
    std::vector<uint16_t> vct = [TDD_CTools NSArrayToInt16CVector:arr];
    
    return vct;
}

uint32_t ArtiLiveDataGetLimits(uint32_t id, uint16_t uIndex, std::string& strMin, std::string& strMax)
{
    
    return [TDD_ArtiLiveDataModel getLimits:id uIndex:uIndex strMin:strMin strMax:strMax];
}

std::vector<uint16_t> ArtiLiveDataGetReportItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiLiveDataModel GetReportItemsWithId:id];
    
    std::vector<uint16_t> vct = [TDD_CTools NSArrayToInt16CVector:arr];
    
    return vct;
}

uint32_t ArtiLiveDataShow(uint32_t id)
{
    return [TDD_ArtiLiveDataModel ShowWithId:id];
}


//非阻塞

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    NSTimeInterval time = [NSDate tdd_getTimestampSince1970];
    
    model.startTime = time;
    
    model.widthName = 2 / 5.0 / 0.9 * 100;
    model.widthValue = 1 / 5.0 / 0.9 * 100;
    model.widthUnit = 1 / 10.0 / 0.9 * 100;
    model.widthRef = 1 / 5.0 / 0.9 * 100;
    
    //    NSArray * titleArr = @[@"图形(0/6)",@"组合(0/4)",@"app_next"];
    
    NSArray *titleArr = @[@"app_edit",@"app_report",@"live_data_recording",@"app_next",@"app_prev"];
    if (isKindOfTopVCI) {
        if ([TDD_DiagnosisTools softWareIsCarPal]) {
            titleArr = @[@"app_edit",@"generate_report",@"live_data_recording",@"app_next",@"app_prev"];
        }else if (isTopVCI){
            titleArr = @[@"pseudo_custom_title",@"generate_report",@"app_next",@"app_prev"];
        }
        
    }
    
    for (int i = 0; i < titleArr.count; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
        buttonModel.uButtonId = i;
        
        NSString *title = titleArr[i];
        buttonModel.strButtonText = title.TDDLocalized;//[TDD_HLanguage getLanguage:titleArr[i]];
        
        buttonModel.bIsEnable = YES;
        
        if (i == titleArr.count - 1) {
            buttonModel.uButtonId = DF_ID_LIVEDATA_PREV;
            
            buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
        }else if (i == titleArr.count - 2) {
            buttonModel.uButtonId = DF_ID_LIVEDATA_NEXT;
            
            buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
        }else if (i == 1){
            buttonModel.uButtonId = DF_ID_LIVEDATA_REPORT;
        }
        
        [model.buttonArr addObject:buttonModel];
    }
    
    model.isReloadButton = YES;
}

#pragma mark 设置部件测试类型
/*******************************************************************
*    功  能：设置部件测试类型，此接口只针对小车探（国内版TOPVCI）
*
*    参  数：uType 部件测试类型
*
*            DF_TYPE_THROTTLE_CARBON      节气门积碳检测
*            DF_TYPE_FULE_CORRECTION      燃油修正控制系统检测
*            DF_TYPE_MAF_TEST             空气流量传感器检测
*            DF_TYPE_INTAKE_PRESSURE      进气压力传感器检测
*            DF_TYPE_OXYGEN_SENSOR        氧传感器检测
*
*    返回值：无
*******************************************************************/
+ (void)SetComponentType:(uint32_t)ID uType:(uint32_t)uType {
    HLog(@"%@ - 设置部件测试类型- ID:%d - uType:%d", [self class], ID, uType);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    model.uType = uType;
    
    [model.recordChangeDict setValue:@(uType) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(uType))]];
    
}

/*******************************************************************
*    功  能：设置部件测试结果值，此接口只针对小车探（国内版TOPVCI）
*
*    参  数：uResult 结果类型
*
*    当部件测试类型为 DF_TYPE_THROTTLE_CARBON 节气门积碳检测
*    uResult的值可为：
*        DF_RESULT_THROTTLE_NORMAL        1  发动机节气门运作正常
*        DF_RESULT_THROTTLE_LIGHT_CARBON  2  节气门疑似有轻微积碳
*        DF_RESULT_THROTTLE_SERIOUSLY     3  节气门积碳严重
*
*    当部件测试类型为 DF_TYPE_FULE_CORRECTION 燃油修正控制系统检测
*    uResult的值可为：
*        DF_RESULT_FULE_NORMAL      1 燃油修正正常
*        DF_RESULT_FULE_HIGH        2 燃油修正偏浓
*        DF_RESULT_FULE_LOW         3 燃油修正偏稀
*        DF_RESULT_FULE_ABNORMAL    4 燃油修正异常
*
*    当部件测试类型为 DF_TYPE_MAF_TEST 空气流量传感器检测
*    uResult的值可为：
*        DF_RESULT_MAF_NORMAL   1  进气量正常
*        DF_RESULT_MAF_HIGH     2  进气量偏大
*        DF_RESULT_MAF_LOW      3  进气量偏小
*
*    当部件测试类型为 DF_TYPE_INTAKE_PRESSURE 进气压力传感器检测
*    uResult的值可为：
*        DF_RESULT_INTAKE_PRESSURE_NORMAL  1  进气压力正常
*        DF_RESULT_INTAKE_PRESSURE_HIGH    2  进气压力偏高
*
*    当部件测试类型为 DF_TYPE_OXYGEN_SENSOR 氧传感器检测
*    uResult的值可为：
*         DF_RESULT_OXYGEN_NORMAL  1  氧传感器正常
*         DF_RESULT_OXYGEN_ERROR   2  氧传感器出现故障
*
*
*    返回值：无
**********************************************************/
+ (void)SetComponentResult:(uint32_t)ID uResult:(uint32_t)uResult {
    HLog(@"%@ - 设置部件测试类型- ID:%d - uResult:%d", [self class], ID, uResult);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    model.uResult = uResult;
    
    [model.recordChangeDict setValue:@(uResult) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(uResult))]];
}

/**********************************************************
 *    功  能：添加数据流项
 *    参  数：strName 数据流名称
 *            strValue 数据流值
 *            strUnit 数据流单位
 *            strMin 数据流最小参考值  - 在下
 *            strMax 数据流最大参考值 - 在下
 *            strReference 数据流枚举型的参考值 - 在上
 *    返回值：无
 *     说明：  如果某一列全是空，就隐藏该列
 *     通常情况下，4列，名称-值-单位-参考值
 *    范围由最小参考值和最大参考值构成
 **********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strName:(NSString *)strName strValue:(NSString *)strValue strUnit:(NSString *)strUnit strMin:(NSString *)strMin strMax:(NSString *)strMax strReference:(NSString *)strReference
{
    HLog(@"%@ - 添加数据流项 - ID:%d - strName:%@ - strValue:%@ - strUnit:%@ - strMin:%@ - strMax:%@ - strReference:%@", [self class], ID, strName, strValue, strUnit, strMin, strMax, strReference);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    TDD_ArtiLiveDataItemModel * itemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
    itemModel.startTime = model.startTime;
    itemModel.index = (uint32_t)model.itemArr.count;
    itemModel.strName = strName;
    itemModel.strUnit = strUnit;
    //去掉前后空格
    strValue = [NSString tdd_removeWhiteSpaceFromPreOrSuff:strValue];
    itemModel.strValue = strValue;
    itemModel.strMin = strMin;
    itemModel.strMax = strMax;
    itemModel.strReference = strReference;
    
    [model.itemArr addObject:itemModel];
    
    if (model.isRecording) {
        TDD_ArtiLiveDataItemModel * newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
        newItemModel.isTempe = YES;
        newItemModel.startTime = model.startTime;
        newItemModel.index = MAX(0, (uint32_t)model.itemArr.count - 1);
        newItemModel.strName = strName;
        newItemModel.strUnit = strUnit;
        newItemModel.strValue = strValue;
        newItemModel.strMin = strMin;
        newItemModel.strMax = strMax;
        newItemModel.strReference = strReference;

        NSString *indexStr = [NSString stringWithFormat:@"%u",newItemModel.index];
        [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
    }

}

/**********************************************************
 *    功  能：设置Next按钮是否显示，控件默认不显示（Benz车系需求，默认文本Next）
 *    参  数：bIsVisible = true  显示Next按钮
 *            bIsVisible = false 隐藏Next按钮
 *    返回值：无
 *
 *     说明： 此按钮返回值 DF_ID_LIVEDATA_NEXT 在Show中返回
 **********************************************************/
+ (void)SetNextButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置Next按钮是否显示 - ID:%d - bIsVisible:%d", [self class], ID, bIsVisible);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    model.isShowNextButton = bIsVisible;
    if (model.isRecording) {
        [model.recordChangeDict setValue:@(bIsVisible) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(isShowNextButton))]];
    }
}

/**********************************************************
 *    功  能：修改Next按钮的文本
 *    参  数：strButtonText  修改按钮显示的文本
 *    返回值：无
 **********************************************************/
+ (void)SetNextButtonTextWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 修改Next按钮的文本 - ID:%d - strButtonText:%@", [self class], ID, strButtonText);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    model.NextButtonText = strButtonText;
    if (model.isRecording) {
        [model.recordChangeDict setValue:strButtonText forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(NextButtonText))]];
    }
}

/**********************************************************
*    功  能：设置Prev按钮是否显示，控件默认不显示
*           （大众通道数据流需求，默认文本Prev）
*
*    参  数：bIsVisible = true  显示Prev按钮
*            bIsVisible = false 隐藏Prev按钮
*
*    返回值：无
*
*     说明： 此按钮返回值 DF_ID_LIVEDATA_PREV 在Show中返回
**********************************************************/
+ (void)SetPrevButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置Prev按钮是否显示 - ID:%d - bIsVisible:%d", [self class], ID, bIsVisible);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    model.isShowPrevButton = bIsVisible;
    if (model.isRecording) {
        [model.recordChangeDict setValue:@(bIsVisible) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(isShowPrevButton))]];
    }
}

/**********************************************************
*    功  能：修改Prev按钮的文本
*
*    参  数：strButtonText  修改按钮显示的文本
*
*    返回值：无
**********************************************************/
+ (void)SetPrevButtonTextWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 修改Prev按钮的文本 - ID:%d - strButtonText:%@", [self class], ID, strButtonText);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    model.PrevButtonText = strButtonText;
    if (model.isRecording) {
        [model.recordChangeDict setValue:strButtonText forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(PrevButtonText))]];
    }
}

//TODO: 数据流接口按钮增加
/**********************************************************
 *    功  能：设置某条数据流的名字
 *    参  数：uIndex 指定的数据流
 *          strName 需要设置的名字文本
 *    返回值：无
 **********************************************************/
+ (void)setNameWithId:(uint32_t)ID uIndex:(uint16_t)uIndex strName:(NSString *)strName
{
    HLog(@"%@ - 设置某条数据流的名字 - ID:%d - uIndex:%d - strName:%@", [self class], ID, uIndex, strName);
    TDD_ArtiLiveDataModel *model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    itemModel.strName = strName;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.index = uIndex;
            newItemModel.startTime = model.startTime;
            newItemModel.isTempe = YES;
            newItemModel.strName = strName;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strName = strName;
        }
    }
}

/**********************************************************
 *    功  能：设置某条数据流的值
 *    参  数：uIndex 指定的数据流
 *          strName 需要设置的值文本
 *    返回值：无
 **********************************************************/
+ (void)setValueWithId:(uint32_t)ID uIndex:(uint16_t)uIndex strValue:(NSString *)strValue
{
    HLog(@"%@ - 设置某条数据流的值 - ID:%d - uIndex:%d - strValue:%@", [self class], ID, uIndex, strValue);
    TDD_ArtiLiveDataModel *model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    //去掉前后空格
    strValue = [NSString tdd_removeWhiteSpaceFromPreOrSuff:strValue];
    itemModel.strValue = strValue;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.index = uIndex;
            newItemModel.startTime = model.startTime;
            newItemModel.isTempe = YES;
            newItemModel.strValue = strValue;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strValue = strValue;
        }
    }
}

/**********************************************************
 *    功  能：设置某条数据流的单位
 *    参  数：uIndex 指定的数据流
 *            strUnit 需要设置的单位文本
 *    返回值：无
 **********************************************************/
+ (void)SetUnitWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strUnit:(NSString *)strUnit
{
    HLog(@"%@ - 设置某条数据流的单位 - ID:%d - uIndex:%d - strUnit:%@", [self class], ID, uIndex, strUnit);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.strUnit = strUnit;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.index = uIndex;
            newItemModel.startTime = model.startTime;
            newItemModel.isTempe = YES;
            newItemModel.strUnit = strUnit;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strUnit = strUnit;
        }
    }
}

/**********************************************************
 *    功  能：设置某条数据流的范围
 *    参  数：uIndex 指定的数据流
 *            strMin 需要设置的最小值参考值
 *            strMax 需要设置的最大值参考值
 *    返回值：无
 **********************************************************/
+ (void)SetLimitsWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strMin:(NSString *)strMin strMax:(NSString *)strMax
{
    HLog(@"%@ - 设置某条数据流的范围 - ID:%d - uIndex:%d - strMin:%@ - strMax:%@", [self class], ID, uIndex, strMin, strMax);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.strMin = strMin;
    
    itemModel.strMax = strMax;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.index = uIndex;
            newItemModel.startTime = model.startTime;
            newItemModel.isTempe = YES;
            newItemModel.strMin = strMin;
            newItemModel.strMax = strMax;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strMin = strMin;
            newItemModel.strMax = strMax;
        }
    }
}

/**********************************************************
 *    功  能：设置某条数据流的枚举型参考值
 *    参  数：uIndex 指定的数据流
 *           strReference 需要设置的枚举型参考值
 *    返回值：无
 **********************************************************/
+ (void)SetReferenceWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strReference:(NSString *)strReference
{
    HLog(@"%@ - 设置某条数据流的枚举型参考值 - ID:%d - uIndex:%d - strReference:%@", [self class], ID, uIndex, strReference);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.strReference = strReference;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.index = uIndex;
            newItemModel.startTime = model.startTime;
            newItemModel.isTempe = YES;
            newItemModel.strReference = strReference;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strReference = strReference;
        }
    }
}

/**********************************************************
 *    功  能：设置某条数据流的帮助信息
 *    参  数：uIndex 指定的数据流
 *            strHelp 需要设置的帮助文本
 *    返回值：无
 **********************************************************/
+ (void)SetHelpTextWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strHelpText:(NSString *)strHelpText
{
    HLog(@"%@ - 设置某条数据流的帮助信息 - ID:%d - uIndex:%d - strHelpText:%@", [self class], ID, uIndex, strHelpText);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.strHelpText = strHelpText;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.index = uIndex;
            newItemModel.startTime = model.startTime;
            newItemModel.isTempe = YES;
            newItemModel.strHelpText = strHelpText;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strHelpText = strHelpText;
        }
    }
}

/**********************************************************
 *    功  能：设置各列表列宽比，如果列宽百分比为0，则隐藏该列
 *            4列列宽比加起来为100
 *
 *    参  数： widthName        "名称"   列宽占比
 *             widthValue    "值"     列宽占比
 *             widthUnit        "单位"   列宽占比
 *             widthRef      "参考值" 列宽占比
 *
 *    返回值：无
 *
 *     说  明：4列列宽比加起来为100
 **********************************************************/
+ (void)SetColWidthWithId:(uint32_t)ID widthName:(int32_t)widthName widthValue:(int32_t)widthValue widthUnit:(int32_t)widthUnit widthRef:(int32_t)widthRef
{
    HLog(@"%@ - 设置各列表列宽比 - ID:%d - widthName:%d - widthValue:%d - widthUnit:%d - widthRef:%d", [self class], ID, widthName, widthValue, widthUnit, widthRef);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    model.widthName = widthName;
    model.widthValue = widthValue;
    model.widthUnit = widthUnit;
    model.widthRef = widthRef;

    if (model.isRecording) {
        [model.recordChangeDict setValue:@(widthName) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(widthName))]];
        [model.recordChangeDict setValue:@(widthValue) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(widthValue))]];
        [model.recordChangeDict setValue:@(widthUnit) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(widthUnit))]];
        [model.recordChangeDict setValue:@(widthRef) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(widthRef))]];
    }
}

/**********************************************************
 *    功  能：刷新某条数据流的值
 *    参  数：uIndex 指定的数据流
 *            strValue 需要设置的数据流值
 *    返回值：无
 **********************************************************/
+ (void)FlushValueWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strValue:(NSString *)strValue
{
    HLog(@"%@ - 刷新某条数据流的值 - ID:%d - uIndex:%d - strValue:%@", [self class], ID, uIndex, strValue);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界");
        return;
    }
    
    TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
    //去掉前后空格
    strValue = [NSString tdd_removeWhiteSpaceFromPreOrSuff:strValue];
    itemModel.strValue = strValue;
    
    if (model.isRecording) {
        NSString *indexStr = [NSString stringWithFormat:@"%u",uIndex];
        TDD_ArtiLiveDataItemModel * newItemModel = model.recordChangeItemDict[indexStr];
        if (!newItemModel) {
            newItemModel = [[TDD_ArtiLiveDataItemModel alloc] init];
            newItemModel.startTime = model.startTime;
            newItemModel.index = uIndex;
            newItemModel.isTempe = YES;
            newItemModel.strValue = strValue;
            [model.recordChangeItemDict setValue:newItemModel forKey:indexStr];
        }else {
            newItemModel.strValue = strValue;
        }
    }
}

/**********************************************************
 *    功  能：获取当前显示屏的更新项的下标集合
 *    参  数：无
 *    返回值：更新项的下标集合
 **********************************************************/
+ (NSArray *)GetUpdateItemsWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取当前显示屏的更新项的下标集合 - ID:%d", [self class], ID);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if ([model.delegate respondsToSelector:@selector(GetUpdateItems)]) {
        NSMutableArray * arr = [model.delegate GetUpdateItems].mutableCopy;
        
        for (TDD_ArtiLiveDataItemModel * itemModel in model.chartItmes) {
            if (![arr containsObject:@(itemModel.index)]) {
                [arr addObject:@(itemModel.index)];
            }
        }
        
        HLog(@"%@ - 获取当前显示屏的更新项的下标集合为：%@", [self class], arr);
        
        return arr;
    }
    
    return @[];
}

/**********************************************************
 *    功  能：获取某条数据流是否需要更新 - 在当前屏幕即需要更新
 *    参  数：无
 *    返回值：true 需要更新，false 不需要更新
 **********************************************************/
+ (BOOL)GetItemIsUpdateWithId:(uint32_t)ID uIndex:(uint32_t)uIndex
{
    HLog(@"%@ - 获取某条数据流是否需要更新 - ID:%d - uIndex:%d", [self class], ID, uIndex);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if ([model.delegate respondsToSelector:@selector(GetItemIsUpdateWithUIndex:)]) {
        return [model.delegate GetItemIsUpdateWithUIndex:uIndex];
    }
    
    return NO;
}

/**********************************************************
*    功  能：获取搜索后的数据流下标集合
*
*    参  数：无
*
*    返回值：搜索后的数据流下标集合
**********************************************************/
+ (NSArray *)GetSearchItemsWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取搜索后的数据流下标集合 - ID:%d", [self class], ID);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if ([model.delegate respondsToSelector:@selector(GetSearchItems)]) {
        NSMutableArray * arr = [model.delegate GetSearchItems].mutableCopy;
        
        for (TDD_ArtiLiveDataItemModel * itemModel in model.chartItmes) {
            if (![arr containsObject:@(itemModel.index)]) {
                [arr addObject:@(itemModel.index)];
            }
        }
        
        HLog(@"%@ - 获取搜索后的数据流下标集合为：%@", [self class], arr);
        
        return arr;
    }
    
    return @[];
}

/**********************************************************
*    功  能：获取选中的数据流行号下标集合
*
*    参  数：无
*
*    返回值：选中的数据流行号下标集合
*            如果大小为0，表示没有选中任何一项
**********************************************************/
+ (NSArray *)GetSelectedItemsWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取选中的数据流下标集合 - ID:%d", [self class], ID);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if ([model.delegate respondsToSelector:@selector(GetSelectedItems)]) {
        NSMutableArray * arr = [model.delegate GetSelectedItems].mutableCopy;
        
        for (TDD_ArtiLiveDataItemModel * itemModel in model.chartItmes) {
            if (![arr containsObject:@(itemModel.index)]) {
                [arr addObject:@(itemModel.index)];
            }
        }
        
        HLog(@"%@ - 获取选中的数据流下标集合为：%@", [self class], arr);
        
        return arr;
    }
    
    return @[];
}

+ (NSArray *)GetModifyLimitItems:(uint32_t)ID {
    
    HLog(@"%@ - GetModifyLimitItems - ID:%d", [self class], ID);
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if ([model.delegate respondsToSelector:@selector(GetModifyLimitItems)]) {
        NSMutableArray * arr = [model.delegate GetModifyLimitItems].mutableCopy;
        
        for (TDD_ArtiLiveDataItemModel * itemModel in model.chartItmes) {
            if (![arr containsObject:@(itemModel.index)]) {
                [arr addObject:@(itemModel.index)];
            }
        }
        
        HLog(@"%@ - GetModifyLimitItems - 集合为：%@", [self class], arr);
        
        return arr;
    }
    
    return @[];
}

/***********************************************************************************
*    功  能：获取在数据流报告上需要展示的数据流下标集合
*
*            注意GetReportItems和GetSelectedItems、GetSearchItems是有区别的
*            实际返回的集合场景，根据不同产品APP可能存在差异
*
*    参  数：无
*
*    返回值：需要在报告中展示的数据流下标集合
*************************************************************************************/
+ (NSArray *)GetReportItemsWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取报告中展示的数据流下标集合 - ID:%d", [self class], ID);
    
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    
    if ([model.delegate respondsToSelector:@selector(GetReportItems)]) {
        NSMutableArray * arr = [model.delegate GetReportItems].mutableCopy;
        
        for (TDD_ArtiLiveDataItemModel * itemModel in model.chartItmes) {
            if (![arr containsObject:@(itemModel.index)]) {
                [arr addObject:@(itemModel.index)];
            }
        }
        
        HLog(@"%@ - 获取报告中展示的数据流下标集合为：%@", [self class], arr);
        
        return arr;
    }
    
    return @[];
}

+ (uint32_t)getLimits:(uint32_t)ID uIndex:(NSInteger)uIndex strMin:(std::string& )strMin strMax:(std::string&)strMax {
    HLog(@"%@ - ArtiLiveDataGetLimitsModifyItems - ID:%d", [self class], ID);
    TDD_ArtiLiveDataModel * model = (TDD_ArtiLiveDataModel *)[self getModelWithID:ID];
    if (uIndex >= model.itemArr.count) {
        HLog(@"%@ - ArtiLiveDataGetLimitsModifyItems - uIndex 过界", [self class]);
        return -1;
    }
    @autoreleasepool {
        TDD_ArtiLiveDataItemModel * itemModel = model.itemArr[uIndex];
        strMin = [TDD_CTools NSStringToCStr:itemModel.setStrMin];
        strMax = [TDD_CTools NSStringToCStr:itemModel.setStrMax];
        HLog(@"%@ - ArtiLiveDataGetLimitsModifyItems - ID:%d - uIndex - %@ - strMin - %@ - strMax - %@", [self class], ID, @(uIndex), itemModel.setStrMin,itemModel.setStrMax);
    }

    return 0;
    
}

/**********************************************************
 *    功  能：显示数据流控件
 *    参  数：无
 *    返回值：uint32_t 组件界面按键返回值
 *
 *           DF_ID_LIVEDATA_BACK        点击了返回
 *            DF_ID_LIVEDATA_NEXT     点击了NEXT按钮
 **********************************************************/
- (uint32_t)show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TDD_ArtiLiveDataModelShow" object:self];
    });
    
    return [super show];
}

- (void)setIsShowNextButton:(BOOL)isShowNextButton
{
    _isShowNextButton = isShowNextButton;
    
    ArtiButtonStatus status = ArtiButtonStatus_UNVISIBLE;
    
    if (isShowNextButton) {
        status = ArtiButtonStatus_ENABLE;
    }
    
    if (self.buttonArr.count < 4) {
        HLog(@"Next按钮不存在");
        return;
    }
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr[3];
    
    if ([buttonModel isKindOfClass:[TDD_ArtiButtonModel class]]) {
        //数据流播放的时候取出来的字典，所以需要判断
        buttonModel.uStatus = status;
    }
    
    self.isReloadButton = YES;
}

- (void)setNextButtonText:(NSString *)NextButtonText
{
    _NextButtonText = NextButtonText;
    
    if (NextButtonText.length > 0 && self.buttonArr.count >= 4) {
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[3];
        
        buttonModel.strButtonText = NextButtonText;
    }
    
    self.isReloadButton = YES;
}

- (void)setIsShowPrevButton:(BOOL)isShowPrevButton
{
    _isShowPrevButton = isShowPrevButton;
    
    ArtiButtonStatus status = ArtiButtonStatus_UNVISIBLE;
    
    if (isShowPrevButton) {
        status = ArtiButtonStatus_ENABLE;
    }
    
    if (self.buttonArr.count < 5) {
        HLog(@"Prev按钮不存在");
        return;
    }
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr[4];
    
    if ([buttonModel isKindOfClass:[TDD_ArtiButtonModel class]]) {
        //数据流播放的时候取出来的字典，所以需要判断
        buttonModel.uStatus = status;
    }
    
    self.isReloadButton = YES;
}

- (void)setPrevButtonText:(NSString *)PrevButtonText
{
    _PrevButtonText = PrevButtonText;
    
    if (PrevButtonText.length > 0 && self.buttonArr.count >= 5) {
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[4];
        
        buttonModel.strButtonText = PrevButtonText;
    }
    
    self.isReloadButton = YES;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    if (buttonID == DF_ID_LIVEDATA_NEXT || buttonID == DF_ID_REPORT || buttonID == DF_ID_LIVEDATA_PREV) {
        if(buttonID == DF_ID_REPORT) {
            //报告
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
                NSString *referrer = @"LiveData";
                if ([[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
                    referrer = @"AutoScan";
                }
                [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":referrer}];
            }else {
                [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":@"LiveData"}];
            }
        }else {
            //下一步
            [TDD_Statistics event:Event_ClickLiveDataNext attributes:nil];
        }
        return YES;
    }else {
        if (buttonID == 0) {
            //编辑
            
            // 数据流搜索 清空搜索列表
            self.isSearch = NO;
            self.searchKey = @"";
            [self updateLiveDataModel];
            self.isShowOtherView = YES;
            TDD_ArtiLiveDataSelectModel * selectModel = [[TDD_ArtiLiveDataSelectModel alloc] init];
            selectModel.strTitle = TDDLocalized.live_data_add;
            selectModel.liveDataModel = self;
            selectModel.selectItmes = [NSMutableArray arrayWithArray:self.recordSelectItmes];
            [selectModel show];
            [TDD_Statistics event:Event_ClickLiveDataEdit attributes:nil];

        }else if (buttonID == 2) {
            //录制
            dispatch_async(dispatch_get_main_queue(), ^{
                self.isRecording = YES;
                [self reloadButtonData];
                [TDD_Statistics event:Event_ClickRecord attributes:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ArtiLiveData_RecordeButtonClick" object:nil userInfo:nil];
            });
        }else if (buttonID == DF_ID_HELP){
            //帮助
            [TDD_Statistics event:Event_ClickLiveDataHelp attributes:nil];
        }
        return NO;
    }
}

- (void)updateLiveDataModel {
    
    if (self.searchKey.length == 0) {
        self.searchItems = nil;
    } else { // 如果输入框里面有值 在用户编辑的selectItems数组里面匹配数据
        NSMutableArray *tempArr = [NSMutableArray array];
        [self.selectItmes  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TDD_ArtiLiveDataItemModel *objModel;
            if ([obj isKindOfClass:[TDD_ArtiLiveDataItemModel class]]){
                objModel = obj;
            }else {
                objModel = [TDD_ArtiLiveDataItemModel yy_modelWithJSON:obj];
            }
            if ([objModel.strName.lowercaseString containsString:self.searchKey.lowercaseString]) {
                [tempArr addObject:objModel];
            }
        }];
        self.searchItems = tempArr;
    }
    
}

#pragma mark - 更新按钮状态
- (void)reloadButtonData
{

    if (_isRecording) {
        for (TDD_ArtiButtonModel *model in self.buttonArr) {
            if (model.uStatus == ArtiButtonStatus_ENABLE) {
                model.uStatus = ArtiButtonStatus_DISABLE;
            }
            
        }
    }else{
        for (TDD_ArtiButtonModel *model in self.buttonArr) {
            if (model.uStatus == ArtiButtonStatus_DISABLE) {
                model.uStatus = ArtiButtonStatus_ENABLE;
            }
        }
    }
    self.isReloadButton = YES;
    

}

- (NSMutableArray<TDD_ArtiLiveDataItemModel *> *)itemArr
{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }

    return _itemArr;
}

- (NSMutableArray *)selectItmes
{
    if (!_selectItmes) {
        _selectItmes = [[NSMutableArray alloc] initWithArray:self.itemArr];
    }

    return _selectItmes;
}

- (NSMutableArray<TDD_ArtiLiveDataItemModel *> *)searchItems
{
    if (!_searchItems) {
        _searchItems = [[NSMutableArray alloc] initWithArray:self.selectItmes];
    }

    return _searchItems;
}

- (NSMutableArray<TDD_ArtiLiveDataItemModel *> *)showItems
{
    return self.isSearch ? self.searchItems : self.selectItmes;
}

- (NSMutableDictionary *)recordChangeDict
{
    if (!_recordChangeDict) {
        _recordChangeDict = @{}.mutableCopy;
    }
    return _recordChangeDict;
}

- (NSMutableDictionary *)recordChangeItemDict
{
    if (!_recordChangeItemDict) {
        _recordChangeItemDict = @{}.mutableCopy;
    }
    return _recordChangeItemDict;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key containsString:@"showItems"]) {
        return;
    }
    [super setValue:value forUndefinedKey:key];
}

//- (void)setShowItems:(NSArray<ArtiLiveDataItemModel *> * _Nonnull)showItems
//{
//    NSMutableArray *mutItems = [NSMutableArray arrayWithArray:showItems];
//
//    self.isSearching ? self.searchItems = mutItems : self.selectItmes = mutItems;
//}

//##下面代码你只需要更换下model的类型，可直接复用。（在使用的地方需要导入   #import <objc/message.h>）
-(id)copyWithZone:(NSZone *)zone{
    id objCopy = [[TDD_ArtiLiveDataModel allocWithZone:zone] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([TDD_ArtiLiveDataModel class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (value&&([value isKindOfClass:[NSMutableArray class]]||[value isKindOfClass:[NSArray class]])) {
            id valueCopy  = [[NSArray alloc]initWithArray:value copyItems:YES];
            [objCopy setValue:valueCopy forKey:propertyName];
        }else if (value) {
            [objCopy setValue:[value copy] forKey:propertyName];
        }
    }
    free(properties);
    return objCopy;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    id objCopy = [[[self class] allocWithZone:zone] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (value&&([value isKindOfClass:[NSMutableArray class]]||[value isKindOfClass:[NSArray class]])) {
            id valueCopy  = [[NSMutableArray alloc]initWithArray:value copyItems:YES];
            [objCopy setValue:valueCopy forKey:propertyName];
        }else if(value){
            [objCopy setValue:[value copy] forKey:propertyName];
        }
    }
    free(properties);
    return objCopy;
}

//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"itemArr":[ArtiLiveDataItemModel class],@"selectItmes":[ArtiLiveDataItemModel class]};
//}
//
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"itemArr":[ArtiLiveDataItemModel class],@"selectItmes":[ArtiLiveDataItemModel class]};
//}

//+ (NSArray *)modelPropertyBlacklist{
//    return @[@"selectItmes",@"delegate"];
//}

+ (NSArray *)modelPropertyBlacklist{
    return @[@"delegate"];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"itemArr":[TDD_ArtiLiveDataItemModel class],
             @"selectItmes":[TDD_ArtiLiveDataItemModel class],
             @"recordSelectItmes":[TDD_ArtiLiveDataItemModel class],
             @"chartItmes":[TDD_ArtiLiveDataItemModel class],
             @"searchItems":[TDD_ArtiLiveDataItemModel class]};
}
@end

@implementation TDD_ArtiLiveDataItemModel
{
    
}

//- (void)setStrName:(NSString *)strName {
//    if ([_strName isEqualToString:strName]) {
//        return;
//    }
//    _strName = strName;
//    _strTranslatedName = strName;
//    _isStrNameTranslated = NO;
//}

- (void)setStrValue:(NSString *)strValue
{
    _strValue = strValue;
    if (_isTempe) {
        [self.recordChangeDict setValue:strValue forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strValue))]];
    
        if (self.startTime == 0) {
            [self.recordChangeDict setValue:@(0) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(chartTime))]];
        }else {
            NSTimeInterval time = [NSDate tdd_getTimestampSince1970];
            [self.recordChangeDict setValue:@(time - self.startTime) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(chartTime))]];
        }
    }else {
        [self changeUnitAndValue];
    }
    
    
}

- (void)setStrUnit:(NSString *)strUnit
{
    _strUnit = strUnit;
    if (_isTempe) {
        [self.recordChangeDict setValue:strUnit forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strUnit))]];
        if (self.startTime == 0) {
            [self.recordChangeDict setValue:@(0) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(chartTime))]];
        }else {
            NSTimeInterval time = [NSDate tdd_getTimestampSince1970];
            [self.recordChangeDict setValue:@(time - self.startTime) forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(chartTime))]];
        }
    }else {
        [self changeUnitAndValue];
        
        [self changeMaxAndMin];
    }


}

- (void)changeUnitAndValue
{
    TDD_UnitConversionModel * model = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strValue unitConversionType:self.unitConversionType];
    self.strChangeUnit = model.unit;
    self.strChangeValue = model.value;
    
}

- (void)setStrMin:(NSString *)strMin
{
    _strMin = strMin;
    
    if (self.setStrMin.length == 0) {
        self.setStrMin = strMin;
    }
    if (_isTempe) {
        [self.recordChangeDict setValue:strMin forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strMin))]];
    }else {
        [self changeMaxAndMin];
    }
    
}

- (void)setStrMax:(NSString *)strMax
{
    _strMax = strMax;
    
    if (self.setStrMax.length == 0) {
        self.setStrMax = strMax;
    }

    if (_isTempe) {
        [self.recordChangeDict setValue:strMax forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strMax))]];
    }else {
        [self changeMaxAndMin];
    }
}

- (void)setStrName:(NSString *)strName
{
    _strName = strName;
    if (_isTempe) {
        [self.recordChangeDict setValue:strName forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strName))]];
    }
}

- (void)setStrReference:(NSString *)strReference
{
    _strReference = strReference;
    if (_isTempe) {
        [self.recordChangeDict setValue:strReference forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strReference))]];
    }
    
}

- (void)setStrHelpText:(NSString *)strHelpText
{
    _strHelpText = strHelpText;
    if (_isTempe) {
        [self.recordChangeDict setValue:strHelpText forKey:[NSString stringWithFormat:@"%@", NSStringFromSelector(@selector(strHelpText))]];
    }
    
}

- (void)changeMaxAndMin
{
    // self.strUnit.length >0 注释，由于strUnit为空，会导致strChangeMin为空，设置页面无法展示范围设置
    if (self.strUnit.length > 0) {
        TDD_UnitConversionModel * model = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strMin unitConversionType:self.unitConversionType];
        if (self.strChangeMin.length == 0) {
            self.setStrMin = model.value;
        }else {
            //转换单位后的值被修改时重设用户设置的值(防止车型修改的最小值比用户设置的旧的最小值大)
            if (![self.strChangeMin isEqualToString:model.value]) {
                self.setStrMin = model.value;
            }
        }
        self.strChangeMin = model.value;
        
        BOOL isUnitMetric = (self.unitConversionType == TDD_UnitConversionType_Metric) || (self.unitConversionType == TDD_UnitConversionType_None && [TDD_UnitConversion sharedUnit].unitConversionType == TDD_UnitConversionType_Metric);
        if (isUnitMetric) {
            TDD_UnitConversionModel * imperialModel = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strMin unitConversionType:TDD_UnitConversionType_Imperial];
            self.strMetricMin = model.value;
            self.strImperialMin = imperialModel.value;
        }else {
            TDD_UnitConversionModel * metricModel = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strMin unitConversionType:TDD_UnitConversionType_Metric];
            self.strMetricMin = metricModel.value;
            self.strImperialMin = model.value;
        }
        
        TDD_UnitConversionModel * model2 = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strMax unitConversionType:self.unitConversionType];
        if (self.strChangeMax.length == 0) {
            self.setStrMax = model2.value;
        }else {
            //转换单位后的值被修改时重设用户设置的值(防止车型修改的最大值比用户设置的旧的最大值小)
            if (![self.strChangeMax isEqualToString:model2.value]) {
                self.setStrMax = model2.value;
            }
        }
        self.strChangeMax = model2.value;
        if (isUnitMetric) {
            TDD_UnitConversionModel * imperialModel = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strMax unitConversionType:TDD_UnitConversionType_Imperial];
            self.strMetricMax = model2.value;
            self.strImperialMax = imperialModel.value;
        }else {
            TDD_UnitConversionModel * metricModel = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strMax unitConversionType:TDD_UnitConversionType_Metric];
            self.strMetricMax = metricModel.value;
            self.strImperialMax = model2.value;
        }
    }else {
        if ([NSString tdd_isEmpty:self.strChangeMin]) {
            self.strChangeMin = self.strMin;
        }
        if ([NSString tdd_isEmpty:self.strChangeMax]) {
            self.strChangeMax = self.strMax;
        }
    }
}

- (void)setStrChangeValue:(NSString *)strChangeValue
{
    _strChangeValue = strChangeValue;
    
    if (strChangeValue.length > 0 && [NSString tdd_isNum:strChangeValue]) {
        
        NSTimeInterval time = [NSDate tdd_getTimestampSince1970];
        
        if (self.startTime == 0) {
            self.startTime = time;
        }
        
        TDD_HChartModel * chartModel = [[TDD_HChartModel alloc] init];
        chartModel.valueStrArr = self.valueStrArr;
        chartModel.valueStr = strChangeValue;
        chartModel.time = self.chartTime?:time - self.startTime;
        if (![self.valueArr isKindOfClass:[NSMutableArray class]]) {
            self.valueArr = [NSMutableArray arrayWithArray:self.valueArr];
        }
        if (self.valueArr.count > 0) {
            TDD_HChartModel * lastChartModel = self.valueArr.lastObject;
            if ([lastChartModel isKindOfClass:[TDD_HChartModel class]] && lastChartModel.time > chartModel.time) {
                if (self.isPlay) {
                    //回溯
                    [self.valueArr removeLastObject];
                }
                return;
            }
        }
        [self.valueArr addObject:chartModel];
        
        if (self.valueArr.count > 1000) {
            [self.valueArr removeObjectsInRange:NSMakeRange(0, self.valueArr.count - 1000)];
        }
    }
}

- (NSMutableArray *)valueArr
{
    if (!_valueArr) {
        _valueArr = [[NSMutableArray alloc] init];
    }
    
    return _valueArr;
}

- (NSMutableArray *)valueStrArr
{
    if (!_valueStrArr) {
        _valueStrArr = [[NSMutableArray alloc] init];
    }
    
    return _valueStrArr;
}

- (NSMutableDictionary *)recordChangeDict
{
    if (!_recordChangeDict) {
        _recordChangeDict = [[NSMutableDictionary alloc] init];
    }
    
    return _recordChangeDict;
}


//##下面代码你只需要更换下model的类型，可直接复用。（在使用的地方需要导入   #import <objc/message.h>）
-(id)copyWithZone:(NSZone *)zone{
    id objCopy = [[[self class] allocWithZone:zone] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (value&&([value isKindOfClass:[NSMutableArray class]]||[value isKindOfClass:[NSArray class]])) {
            id valueCopy  = [[NSArray alloc]initWithArray:value copyItems:YES];
            [objCopy setValue:valueCopy forKey:propertyName];
        }else if (value) {
            [objCopy setValue:[value copy] forKey:propertyName];
        }
    }
    free(properties);
    return objCopy;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    id objCopy = [[[self class] allocWithZone:zone] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (value&&([value isKindOfClass:[NSMutableArray class]]||[value isKindOfClass:[NSArray class]])) {
            id valueCopy  = [[NSMutableArray alloc]initWithArray:value copyItems:YES];
            [objCopy setValue:valueCopy forKey:propertyName];
        }else if(value){
            [objCopy setValue:[value copy] forKey:propertyName];
        }
    }
    free(properties);
    return objCopy;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"valueArr":[TDD_HChartModel class]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"valueArr":[TDD_HChartModel class]};
}

//+ (NSArray *)modelPropertyBlacklist{
//    return @[@"valueArr",@"valueStrArr",@"UIType"];
//}

@end
