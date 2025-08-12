//
//  TDD_ArtiEcuInfoModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/5.
//

#import "TDD_ArtiEcuInfoModel.h"

#if useCarsFramework
#import <CarsFramework/RegEcuInfo.hpp>
#else
#import "RegEcuInfo.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiEcuInfoModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegEcuInfo::Construct(ArtiEcuInfoConstruct);
    CRegEcuInfo::Destruct(ArtiEcuInfoDestruct);
    CRegEcuInfo::InitTitle(ArtiEcuInfoInitTitle);
    CRegEcuInfo::SetColWidth(ArtiEcuInfoSetColWidth);
    CRegEcuInfo::AddGroup(ArtiEcuInfoAddGroup);
    CRegEcuInfo::AddItem(ArtiEcuInfoAddItem);
    CRegEcuInfo::Show(ArtiEcuInfoShow);
}

void ArtiEcuInfoConstruct(uint32_t id)
{
    [TDD_ArtiEcuInfoModel Construct:id];
}

void ArtiEcuInfoDestruct(uint32_t id)
{
    [TDD_ArtiEcuInfoModel Destruct:id];
}

bool ArtiEcuInfoInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiEcuInfoModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

void ArtiEcuInfoSetColWidth(uint32_t id, int16_t iFirstPercent, int16_t iSecondPercent)
{
    [TDD_ArtiEcuInfoModel SetColWidthWithId:id iFirstPercent:iFirstPercent iSecondPercent:iSecondPercent];
}

void ArtiEcuInfoAddGroup(uint32_t id, const std::string& strGroupName)
{
    [TDD_ArtiEcuInfoModel AddGroupWithId:id strGroupName:[TDD_CTools CStrToNSString:strGroupName]];
}

void ArtiEcuInfoAddItem(uint32_t id, const std::string& strItem, const std::string& strValue)
{
    [TDD_ArtiEcuInfoModel AddItemWithId:id strItem:[TDD_CTools CStrToNSString:strItem] strValue:[TDD_CTools CStrToNSString:strValue]];
}

uint32_t ArtiEcuInfoShow(uint32_t id)
{
    return [TDD_ArtiEcuInfoModel ShowWithId:id];
}


/**********************************************************
*    功  能：设置版本信息项名和值所在列的比例
*    参  数：iFirstPercent 版本信息项宽，
*            strValue 版本信息项值宽
*    返回值：无
**********************************************************/
+ (void)SetColWidthWithId:(uint32_t)ID iFirstPercent:(uint32_t)iFirstPercent iSecondPercent:(uint32_t)iSecondPercent
{
    HLog(@"%@ - 设置版本信息项名和值所在列的比例 - ID:%d - iFirstPercent ：%d - iSecondPercent ：%d", [self class], ID, iFirstPercent, iSecondPercent);
    
    TDD_ArtiEcuInfoModel * model = (TDD_ArtiEcuInfoModel *)[self getModelWithID:ID];
    
    model.iFirstPercent = iFirstPercent;
    
    model.iSecondPercent = iSecondPercent;
}


/**********************************************************
*    功  能：添加版本信息的分组
*    参  数：strGroupName 分组名称文本
*    返回值：无
**********************************************************/
+ (void)AddGroupWithId:(uint32_t)ID strGroupName:(NSString *)strGroupName
{
    HLog(@"%@ - 添加版本信息的分组 - ID:%d - strGroupName ：%@", [self class], ID, strGroupName);
    
    TDD_ArtiEcuInfoModel * model = (TDD_ArtiEcuInfoModel *)[self getModelWithID:ID];
    
    ArtiEcuInfoItemModel * itemModel = [[ArtiEcuInfoItemModel alloc] init];
    
    itemModel.isAddGroup = YES;
    
    if (strGroupName.length == 0) {
        strGroupName = @" ";
    }
    
    itemModel.strGroupName = strGroupName;
    
    [model.itemArr addObject:itemModel];
}


/**********************************************************
*    功  能：添加版本信息项
*    参  数：strItem 版本信息项名称，
*            strValue 版本信息项的值
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem strValue:(NSString *)strValue
{
    HLog(@"%@ - 添加版本信息项 - ID:%d - strItem ：%@ - strValue ： %@", [self class], ID, strItem, strValue);
    
    TDD_ArtiEcuInfoModel * model = (TDD_ArtiEcuInfoModel *)[self getModelWithID:ID];
    
    ArtiEcuInfoItemModel * itemModel = [[ArtiEcuInfoItemModel alloc] init];
    
    if (strItem.length == 0) {
        strItem = @" ";
    }
    
    if (strValue.length == 0) {
        strValue = @" ";
    }
    
    itemModel.strItem = strItem;
    
    itemModel.strValue = strValue;
    
    [model.itemArr addObject:itemModel];
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (ArtiEcuInfoItemModel * model in self.itemArr) {
            if (model.strItem.length > 0 && !model.isStrItemTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strItem];
            }
            if (model.strGroupName.length > 0 && !model.isStrGroupNameTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strGroupName];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (ArtiEcuInfoItemModel * model in self.itemArr) {
        if ([self.translatedDic.allKeys containsObject:model.strItem]) {
            if ([self.translatedDic[model.strItem] length] > 0) {
                model.strTranslatedItem = self.translatedDic[model.strItem];
                model.isStrItemTranslated = YES;
            }
        }
        
        if ([self.translatedDic.allKeys containsObject:model.strGroupName]) {
            if ([self.translatedDic[model.strGroupName] length] > 0) {
                model.strTranslatedGroupName = self.translatedDic[model.strGroupName];
                model.isStrGroupNameTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

- (NSMutableArray<ArtiEcuInfoItemModel *> *)itemArr
{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}

@end

@implementation ArtiEcuInfoItemModel

- (void)setStrItem:(NSString *)strItem
{
    if ([_strItem isEqualToString:strItem]) {
        return;
    }
    
    _strItem = strItem;
    
    self.strTranslatedItem = _strItem;
    
    self.isStrItemTranslated = NO;
}

- (void)setStrGroupName:(NSString *)strGroupName
{
    if ([_strGroupName isEqualToString:strGroupName]) {
        return;
    }
    
    _strGroupName = strGroupName;
    
    self.strTranslatedGroupName = _strGroupName;
    
    self.isStrGroupNameTranslated = NO;
}
@end
