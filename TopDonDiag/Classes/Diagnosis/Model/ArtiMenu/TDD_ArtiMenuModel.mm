//
//  TDD_ArtiMenuModel.m
//  AD200
//
//  Created by 何可人 on 2022/4/16.
//

#import "TDD_ArtiMenuModel.h"

#if useCarsFramework
#import <CarsFramework/RegMenu.hpp>
#else
#import "RegMenu.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiMenuModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegMenu::Construct(ArtiMenuConstruct);
    CRegMenu::Destruct(ArtiMenuDestruct);
    CRegMenu::InitTitle(ArtiMenuInitTitle);
    CRegMenu::AddItem(ArtiMenuAddItem);
    CRegMenu::SetMenuStatus(ArtiSetMenuStatus);
    CRegMenu::GetItem(ArtiMenuGetItem);
    CRegMenu::SetIcon(ArtiMenuSetIcon);
    CRegMenu::SetHelpButtonVisible(ArtiMenuSetHelpButtonVisible);
    CRegMenu::SetMenuTreeVisible(ArtiMenuSetMenuTreeVisible);
    CRegMenu::SetMenuId(ArtiMenuSetMenuId);
    CRegMenu::GetMenuId(ArtiMenuGetMenuId);
    CRegMenu::Show(ArtiMenuShow);
}

void ArtiMenuConstruct(uint32_t id)
{
    [TDD_ArtiMenuModel Construct:id];
}

void ArtiMenuDestruct(uint32_t id)
{
    [TDD_ArtiMenuModel Destruct:id];
}

bool ArtiMenuInitTitle(uint32_t id, const std::string& strTitle)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];
    
    return [TDD_ArtiMenuModel InitTitleWithId:id strTitle:Title];
}

void ArtiMenuAddItem(uint32_t id, const std::string& strItem, uint32_t uStatus)
{
    NSString * item = [TDD_CTools CStrToNSString:strItem];
    
    [TDD_ArtiMenuModel AddItemWithId:id strItem:item uStatus:uStatus];
}

uint32_t ArtiSetMenuStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus)
{
    return [TDD_ArtiMenuModel SetMenuStatus:id uIndex:uIndex uStatus:uStatus];
}

std::string const ArtiMenuGetItem(uint32_t id, uint16_t uIndex)
{
    NSString * item = [TDD_ArtiMenuModel GetItemWithId:id uIndex:uIndex];
    
    if (item.length == 0) {
        item = @"";
    }
    
    std::string strItem = std::string([item UTF8String]);
    
    return strItem;
}

void ArtiMenuSetIcon(uint32_t id, uint16_t uIndex, const std::string& strIconPath, const std::string& strShortName)
{
    NSString * iconPath = [TDD_CTools CStrToNSString:strIconPath];
    
    NSString * shortName = [TDD_CTools CStrToNSString:strShortName];
    
    [TDD_ArtiMenuModel SetIconWithId:id uIndex:uIndex strIconPath:iconPath strShortName:shortName];
}

void ArtiMenuSetHelpButtonVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiMenuModel SetHelpButtonVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiMenuSetMenuTreeVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiMenuModel SetMenuTreeVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiMenuSetMenuId(uint32_t id, const std::string& strMenuId)
{
    NSString * menuId = [TDD_CTools CStrToNSString:strMenuId];
    
    [TDD_ArtiMenuModel SetMenuIdWithId:id strMenuId:menuId];
}

std::string const ArtiMenuGetMenuId(uint32_t id)
{
    NSString * menuId = [TDD_ArtiMenuModel GetMenuIdWithId:id];
    
    if (menuId.length == 0) {
        menuId = @"";
    }
    
    std::string strMenuId = std::string([menuId UTF8String]);
    
    return strMenuId;
}

uint32_t ArtiMenuShow(uint32_t id)
{
    return [TDD_ArtiMenuModel ShowWithId:id];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    model.selectIndex = -1;
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
    buttonModel.uButtonId = DF_ID_HELP;
    
    buttonModel.strButtonText = @"diagnosis_help";
    
    buttonModel.bIsEnable = YES;
    
    buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    
    [model.buttonArr addObject:buttonModel];
}

/******************************************************************************
*    功  能：添加菜单项
*
*    参  数：strItem   菜单项名称
*            bStatus   菜单项的状态
*
*            DF_ST_MENU_NORMAL       正常状态
*            DF_ST_MENU_EXPIR        软件过期
*            DF_ST_MENU_DISABLE      失能状态，不可用状态
*
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem uStatus:(uint32_t )uStatus{
    HLog(@"%@ - 添加菜单项 - ID:%d - strItem 菜单项名称 ：%@", [self class], ID, strItem);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    ArtiMenuItemModel * itemModel = [[ArtiMenuItemModel alloc] init];
    
    itemModel.uIndex = (uint32_t)model.itemArr.count;
    
    itemModel.strItem = strItem;
    
    itemModel.uStatus = uStatus;

    [model.itemArr addObject:itemModel];
    
    
}

/**************************************************************************************
*    功  能：设置菜单的状态
*
*    参  数：uIndex    指定的菜单项
*            bStatus   菜单项的状态
*
*            DF_ST_MENU_NORMAL       正常状态
*            DF_ST_MENU_EXPIR        软件过期
*            DF_ST_MENU_DISABLE      失能状态，不可用状态
*
*    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
*            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
*            其它值，暂无意义
*
*    说  明：
*            如果没有调用此接口，默认的菜单项状态为AddItem中指定的初始状态
****************************************************************************************/
+ (uint32_t)SetMenuStatus:(uint32_t)ID uIndex:(uint16_t)uIndex uStatus:(uint32_t)uStatus {
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count <= uIndex) {
        return 0;
    }
    ArtiMenuItemModel * itemModel = model.itemArr[uIndex];
    itemModel.uStatus = uStatus;
    
    return 1;
}

/**********************************************************
*    功  能：获取指定菜单项的文本串
*    参  数：uIndex 指定的菜单项
*    返回值：string 指定菜单项的文本串
**********************************************************/
+ (NSString *)GetItemWithId:(uint32_t)ID uIndex:(uint32_t)uIndex{
    HLog(@"%@ - 获取指定菜单项的文本串 - ID:%d - 指定的菜单项 ：%d", [self class], ID, uIndex);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count <= uIndex) {
        return @"";
    }
    
    ArtiMenuItemModel * itemModel = model.itemArr[uIndex];
    
    return itemModel.strItem;
    
}

/**********************************************************
*    功  能：设置指定菜单项需要附加的图片
*
*    参  数：uIndex 指定的菜单项
*            strIconPath   需要设置的图片路径
*            strShortName  菜单项的名称缩写
*                          如果strShortName为空串，则不改变菜
*                          单项的名称
*
*    返回值：无
*
*    注 意： 菜单图标的大小暂设定为150*150，输入图标长宽如果
*            不等于150，等比例缩放到长宽最大值为150显示
**********************************************************/
+ (void)SetIconWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strIconPath:(NSString *)strIconPath strShortName:(NSString *)strShortName{

    HLog(@"%@ - 设置指定菜单项需要附加的图片 - ID:%d - 指定的菜单项 ：%d -  需要设置的图片路径:%@ - 菜单项的名称缩写:%@", [self class], ID, uIndex, strIconPath, strShortName);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count <= uIndex) {
        return;
    }
    
    ArtiMenuItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.strIconPath = strIconPath;
    
    if (strShortName.length > 0) {
        itemModel.strShortName = strShortName;
    }
}

/**********************************************************
*    功  能：设置帮助按钮是否显示，控件默认不显示
*    参  数：bIsVisible = true  显示帮助按钮
*            bIsVisible = false 隐藏帮助按钮
*    返回值：无
**********************************************************/
+ (void)SetHelpButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible{

    HLog(@"%@ - 设置帮助按钮是否显示：%d - ID:%d", [self class], bIsVisible, ID);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    model.helpButtonVisible = bIsVisible;
    
}

/**********************************************************
*    功  能：设置左侧菜单树要不要显示，默认不显示
*    参  数：bIsVisible = true  显示左侧菜单树
*            bIsVisible = false 隐藏左侧菜单树
*    返回值：无
**********************************************************/
+ (void)SetMenuTreeVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible{

    HLog(@"%@ - 设置左侧菜单树要不要显示：%d - ID:%d", [self class], bIsVisible, ID);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    model.menuTreeVisiblel = bIsVisible;
}

/**********************************************************
*    功  能：设置菜单ID给显示层，由显示层存储，必要时去取
*    参  数：strMenuId 菜单ID
*    返回值：无
**********************************************************/
+ (void)SetMenuIdWithId:(uint32_t)ID strMenuId:(NSString *)strMenuId{
    HLog(@"%@ - 设置菜单ID给显示层 - ID:%d - 菜单ID:%@", [self class], ID, strMenuId);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    model.strMenuId = strMenuId;
}

/**********************************************************
*    功  能：获取菜单树选择项的菜单ID
*    参  数：无
*    返回值：string 设置过的菜单ID
**********************************************************/
+ (NSString *)GetMenuIdWithId:(uint32_t)ID{
    HLog(@"%@ - 获取菜单树选择项的菜单ID - ID:%d", [self class], ID);
    
    TDD_ArtiMenuModel * model = (TDD_ArtiMenuModel *)[self getModelWithID:ID];
    
    return model.strMenuId;
}

- (void)setHelpButtonVisible:(BOOL)helpButtonVisible
{
    _helpButtonVisible = helpButtonVisible;
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr.firstObject;
        
    if (helpButtonVisible) {
        buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    }else {
        buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    }
    
    self.isReloadButton = YES;
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (ArtiMenuItemModel * model in self.itemArr) {
            if (model.strItem.length > 0 && !model.isStrItemTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strItem];
            }
            if (model.strShortName.length > 0 && !model.isStrShortNameTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strShortName];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (ArtiMenuItemModel * model in self.itemArr) {
        if ([self.translatedDic.allKeys containsObject:model.strItem]) {
            if ([self.translatedDic[model.strItem] length] > 0) {
                model.strTranslatedItem = self.translatedDic[model.strItem];
                model.isStrItemTranslated = YES;
            }
        }
        
        if ([self.translatedDic.allKeys containsObject:model.strShortName]) {
            if ([self.translatedDic[model.strShortName] length] > 0) {
                model.strTranslatedShortName = self.translatedDic[model.strShortName];
                model.isStrShortNameTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

- (NSMutableArray<ArtiMenuItemModel *> *)itemArr{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    
    return _itemArr;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

@end

@implementation ArtiMenuItemModel

-  (void)setStrItem:(NSString *)strItem
{
    if ([_strItem isEqualToString:strItem]) {
        return;
    }
    
    _strItem = strItem;
    
    self.strTranslatedItem = _strItem;
    
    self.isStrItemTranslated = NO;
}

- (void)setStrShortName:(NSString *)strShortName
{
    if ([_strShortName isEqualToString:strShortName]) {
        return;
    }
    
    _strShortName = strShortName;
    
    self.strTranslatedShortName = _strShortName;
    
    self.isStrShortNameTranslated = NO;
}

@end
