//
//  TDD_ArtiFreezeModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/6.
//

#import "TDD_ArtiFreezeModel.h"

#if useCarsFramework
#import <CarsFramework/RegFreeze.hpp>
#else
#import "RegFreeze.hpp"
#endif

#import "TDD_CTools.h"
#import "TDD_UnitConversion.h"

@implementation TDD_ArtiFreezeModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegFreeze::Construct(ArtiFreezeModelConstruct);
    CRegFreeze::Destruct(ArtiFreezeModelDestruct);
    CRegFreeze::InitTitle(ArtiFreezeModelInitTitle);
    CRegFreeze::AddItem(ArtiFreezeModelAddItem);
    CRegFreeze::Show(ArtiFreezeModelShow);
    CRegFreeze::AddItemEx(ArtiFreezeModelAddItemEx);
    CRegFreeze::SetHeads(ArtiFreezeModelSetHeads);
    CRegFreeze::SetValueType(ArtiFreezeModelSetValueType);
}

void ArtiFreezeModelConstruct(uint32_t id)
{
    [TDD_ArtiFreezeModel Construct:id];
}

void ArtiFreezeModelDestruct(uint32_t id)
{
    [TDD_ArtiFreezeModel Destruct:id];
}

bool ArtiFreezeModelInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiFreezeModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

void ArtiFreezeModelAddItem(uint32_t id, const std::string& strName, const std::string& strValue, const std::string& strUnit, const std::string& strHelp)
{
    [TDD_ArtiFreezeModel AddItemWithId:id strName:[TDD_CTools CStrToNSString:strName] strValue:[TDD_CTools CStrToNSString:strValue] strUnit:[TDD_CTools CStrToNSString:strUnit] strHelp:[TDD_CTools CStrToNSString:strHelp]];
}

void ArtiFreezeModelAddItemEx(uint32_t id, const std::string& strName, const std::string& strValue1st, const std::string& strValue2nd, const std::string& strUnit, const std::string& strHelp)
{
    [TDD_ArtiFreezeModel AddItemExWithId:id strName:[TDD_CTools CStrToNSString:strName] strValue1st:[TDD_CTools CStrToNSString:strValue1st] strValue2nd:[TDD_CTools CStrToNSString:strValue2nd] strUnit:[TDD_CTools CStrToNSString:strUnit] strHelp:[TDD_CTools CStrToNSString:strHelp]];
}

void ArtiFreezeModelSetValueType(uint32_t id, uint32_t eColumnType)
{
    [TDD_ArtiFreezeModel setValueTypeWithId:id eColumnType:eColumnType];
}

void ArtiFreezeModelSetHeads(uint32_t id, const std::vector<std::string>& vctHeadNames)
{
    [TDD_ArtiFreezeModel setHeadsWithId:id vctHeadNames:[TDD_CTools CVectorToStringNSArray:vctHeadNames]];
}

uint32_t ArtiFreezeModelShow(uint32_t id)
{
    return [TDD_ArtiFreezeModel ShowWithId:id];
}
+ (void)Construct:(uint32_t)ID {
    [super Construct:ID];
    TDD_ArtiFreezeModel *model = (TDD_ArtiFreezeModel *)[self getModelWithID:ID];

//    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
//
//    buttonModel.uButtonId = DF_ID_REPORT;
//
//    buttonModel.strButtonText = TDDLocalized.app_report;
//
//    buttonModel.bIsEnable = YES;
//
//    [model.buttonArr addObject:buttonModel];

//    buttonModel.uStatus = ArtiButtonStatus_ENABLE;

}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    return YES;
}

/**********************************************************
*    功  能：添加冻结帧项（值为1列）
*
*    参  数：strName 冻结帧名称
*            strValue 冻结帧值
*            strUnit 冻结帧单位
*
*    返回值：无
*    注  意：如果SetValueType指定了2列，用AddItemEx接口传值
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strName:(NSString *)strName strValue:(NSString *)strValue strUnit:(NSString *)strUnit strHelp:(NSString *)strHelp
{
    HLog(@"%@ - 添加冻结帧项 - ID:%d - strName ：%@ - strValue ： %@ - strUnit ： %@ - strHelp ： %@", [self class], ID, strName, strValue, strUnit, strHelp);
    
    TDD_ArtiFreezeModel * model = (TDD_ArtiFreezeModel *)[self getModelWithID:ID];
    
    TDD_ArtiFreezeItemModel * itemModel = [[TDD_ArtiFreezeItemModel alloc] init];
    
    itemModel.strName = strName;
    
    itemModel.strValue = strValue;
    
    itemModel.strUnit = strUnit;
    
    itemModel.strHelp = strHelp;
    
    [itemModel changeUnitAndValue];
    
    if (strHelp.length > 0) {
        itemModel.isShowHelpButton = YES;
    }
    
    [model.groupArr addObject:itemModel];
}

/**********************************************************
*    功  能：添加冻结帧项（值为2列）
*
*    参  数：strName        冻结帧名称
*            strValue1st    冻结帧值1
*            strValue2nd    冻结帧值2
*            strUnit        冻结帧单位
*
*    返回值：无
*    注  意：如果SetValueType指定了1列，用AddItem接口传值
**********************************************************/
+ (void)AddItemExWithId:(uint32_t)ID strName:(NSString *)strName strValue1st:(NSString *)strValue1st strValue2nd:(NSString *)strValue2nd strUnit:(NSString *)strUnit strHelp:(NSString *)strHelp
{
    HLog(@"%@ - 添加冻结帧项 - ID:%d - strName ：%@ - strValue1st ： %@ - strValue2nd: %@ - strUnit ： %@ - strHelp ： %@", [self class], ID, strName, strValue1st, strValue2nd, strUnit, strHelp);
    
    TDD_ArtiFreezeModel * model = (TDD_ArtiFreezeModel *)[self getModelWithID:ID];
    
    TDD_ArtiFreezeItemModel * itemModel = [[TDD_ArtiFreezeItemModel alloc] init];
    
    itemModel.strName = strName;
    
    itemModel.strValue = strValue1st;
    
    itemModel.strValue2nd = strValue2nd;
    
    itemModel.strUnit = strUnit;
    
    itemModel.strHelp = strHelp;
    
    itemModel.eColumnType = model.eColumnType;
    
    itemModel.strHead = model.strHead;
    
    itemModel.strHead2nd = model.strHead2nd;
    
    [itemModel changeUnitAndValue];
    
    if (strHelp.length > 0) {
        itemModel.isShowHelpButton = YES;
    }
    
    [model.groupArr addObject:itemModel];
}

/**********************************************************
*    功  能：指定冻结帧项的值为1列类型还是2列类型
*
*    参  数：eFreezeValueType  eColumnType
*            VALUE_1_COLUMN = 1,   // 指定冻结帧的值为1列
*            VALUE_2_COLUMN = 2,   // 指定冻结帧的值为2列
*
*    返回值：无
*
*    注  意：如果没有调用SetValueType接口，默认为1列
**********************************************************/
+ (void)setValueTypeWithId:(uint32_t)ID eColumnType:(uint32_t) eColumnType
{
    HLog(@"%@ - 指定冻结帧项的值为1列类型还是2列类型 - ID:%d - eColumnType ：%d", [self class], ID, eColumnType);
    
    TDD_ArtiFreezeModel * model = (TDD_ArtiFreezeModel *)[self getModelWithID:ID];
    model.eColumnType = eColumnType;
}

/**********************************************************
*    功  能：设置冻结帧列表头，该行锁定状态
*
*    参  数：vctHeadNames 列表各列的名称集合
*
*    返回值：无
*
*    注  意：SetHeads必须跟AddItem或者AddItemEx指定列数一致
*            如果SetHeads实参的vctHeadNames大小大于AddItem
*            或者AddItemEx中指定的列数，以AddItem或者AddItemEx
*            的为准
**********************************************************/
+ (void)setHeadsWithId:(uint32_t)ID vctHeadNames:(NSArray<NSString*>*)vctHeadNames
{
    HLog(@"%@ - 指定冻结帧项的heads - ID:%d - vctHeadNames ：%@", [self class], ID, vctHeadNames);
    if (vctHeadNames.count>3) {
        TDD_ArtiFreezeModel * model = (TDD_ArtiFreezeModel *)[self getModelWithID:ID];
        if (model.eColumnType == 1 && vctHeadNames.count == 4) {
            model.strHead = vctHeadNames[1];
        } else if (model.eColumnType == 2 && vctHeadNames.count == 5){
            model.strHead = vctHeadNames[1];
            model.strHead2nd = vctHeadNames[2];
        }
        
    }

    
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (TDD_ArtiFreezeItemModel * model in self.groupArr) {
            if (model.strName.length > 0 && !model.isStrNameTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strName];
            }
            if (model.strHelp.length > 0 && !model.isStrHelpTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strHelp];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (TDD_ArtiFreezeItemModel * model in self.groupArr) {
        if ([self.translatedDic.allKeys containsObject:model.strName]) {
            if ([self.translatedDic[model.strName] length] > 0) {
                model.strTranslatedName = self.translatedDic[model.strName];
                model.isStrNameTranslated = YES;
            }
        }
        
        if ([self.translatedDic.allKeys containsObject:model.strHelp]) {
            if ([self.translatedDic[model.strHelp] length] > 0) {
                model.strTranslatedHelp = self.translatedDic[model.strHelp];
                model.isStrHelpTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

- (NSMutableArray<TDD_ArtiFreezeItemModel *> *)groupArr
{
    if (!_groupArr) {
        _groupArr = [[NSMutableArray alloc] init];
    }
    return _groupArr;
}



@end


@implementation TDD_ArtiFreezeItemModel
- (void)changeUnitAndValue
{
    TDD_UnitConversionModel * model = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strValue];
    self.strChangeUnit = model.unit;
    self.strChangeValue = model.value;
    
    TDD_UnitConversionModel * model2 = [TDD_UnitConversion diagUnitConversionWithUnit:self.strUnit value:self.strValue2nd];
    self.strChangeUnit = model2.unit;
    self.strChangeValue2nd = model2.value;
    
}

- (void)setStrName:(NSString *)strName
{
    if ([_strName isEqualToString:strName]) {
        return;
    }
    
    _strName = strName;
    
    self.isStrNameTranslated = NO;
    CGFloat scale = IS_IPad ? HD_Height : H_Height;;
    CGFloat leftSpace = (IS_IPad ? 40 : 20) * scale;
    CGFloat w = IphoneWidth - (leftSpace + leftSpace + 24 * scale + 16 * scale);
    UIFont *font = [[UIFont systemFontOfSize:IS_IPad ? 18 : 16 weight:UIFontWeightSemibold] tdd_adaptHD];
    _nameHeight = [NSString tdd_getHeightWithText:strName width:w fontSize:font];
    CGFloat lineHeight = font.lineHeight;
    CGFloat maxHeight = lineHeight * 2 + 5;

    if (_nameHeight > maxHeight) {
        _nameHeight = maxHeight;
    }
    self.strTranslatedName = _strName;
}

- (void)setStrTranslatedName:(NSString *)strTranslatedName {
    if ([_strTranslatedName isEqualToString: strTranslatedName]) {
        return;
    }

    _strTranslatedName = strTranslatedName;
    if ([_strName isEqualToString:_strTranslatedName]) {
        _translatedNameHeight = _nameHeight;
        return;
    }
    CGFloat scale = IS_IPad ? HD_Height : H_Height;;
    CGFloat leftSpace = (IS_IPad ? 40 : 20) * scale;
    CGFloat w = IphoneWidth - (leftSpace + leftSpace + 24 * scale + 16 * scale);
    UIFont *font = [[UIFont systemFontOfSize:IS_IPad ? 18 : 16 weight:UIFontWeightSemibold] tdd_adaptHD];
    _translatedNameHeight = [NSString tdd_getHeightWithText:strTranslatedName width:w fontSize:font];
    CGFloat lineHeight = font.lineHeight;
    CGFloat maxHeight = lineHeight * 2;

    if (_translatedNameHeight > maxHeight) {
        _translatedNameHeight = maxHeight;
    }
    
}

- (void)setStrHelp:(NSString *)strHelp
{
    if ([_strHelp isEqualToString:strHelp]) {
        return;
    }
    
    _strHelp = strHelp;
    
    self.strTranslatedHelp = _strHelp;
    
    self.isStrHelpTranslated = NO;
}
@end
