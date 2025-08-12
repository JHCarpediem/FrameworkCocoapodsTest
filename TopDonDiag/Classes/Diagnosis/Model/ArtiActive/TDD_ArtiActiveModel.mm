//
//  TDD_ArtiActiveModel.m
//  AD200
//
//  Created by 何可人 on 2022/4/21.
//

#import "TDD_ArtiActiveModel.h"

#if useCarsFramework
#import <CarsFramework/RegActive.hpp>
#else
#import "RegActive.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiActiveModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegActive::Construct(ArtiActiveConstruct);
    CRegActive::Destruct(ArtiActiveDestruct);
    CRegActive::InitTitle(ArtiActiveInitTitle);
    CRegActive::AddItem(ArtiActiveAddItem);
    CRegActive::GetUpdateItems(ArtiActiveGetUpdateItems);
    CRegActive::SetValue(ArtiActiveSetValue);
    CRegActive::SetItem(ArtiActiveSetItem);
    CRegActive::SetUnit(ArtiActiveSetUnit);
    CRegActive::SetOperationTipsOnTop(ArtiActiveSetOperationTipsOnTop);
    CRegActive::SetOperationTipsOnBottom(ArtiActiveSetOperationTipsOnBottom);
    CRegActive::SetTipsTitleOnTop(ArtiActiveSetTipsTitleOnTop);
    CRegActive::SetTipsTitleOnBottom(ArtiActiveSetTipsTitleOnBottom);
    CRegActive::SetHeads(ArtiActiveSetHeads);
    CRegActive::SetLockFirstRow(ArtiActiveSetLockFirstRow);
    CRegActive::AddButton(ArtiActiveAddButton);
    CRegActive::AddButtonEx(ArtiActiveAddButtonEx);
    CRegActive::DelButton(ArtiActiveDelButton);
    CRegActive::SetButtonEnable(ArtiActiveSetButtonEnable);
    CRegActive::SetButtonStatus(ArtiActiveSetButtonStatus);
    CRegActive::SetButtonText(ArtiActiveSetButtonText);
    CRegActive::Show(ArtiActiveShow);
}

void ArtiActiveConstruct(uint32_t id)
{
    [TDD_ArtiActiveModel Construct:id];
}

void ArtiActiveDestruct(uint32_t id)
{
    [TDD_ArtiActiveModel Destruct:id];
}

bool ArtiActiveInitTitle(uint32_t id, const std::string& strTitle)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];
    
    return [TDD_ArtiActiveModel InitTitleWithId:id strTitle:Title];
}

void ArtiActiveAddItem(uint32_t id, const std::string& strItem, const std::string& strValue, bool bIsLocked, const std::string& strUnit)
{
    NSString * Item = [TDD_CTools CStrToNSString:strItem];
    
    NSString * Value = [TDD_CTools CStrToNSString:strValue];
    
    NSString * Unit = [TDD_CTools CStrToNSString:strUnit];
    
    [TDD_ArtiActiveModel AddItemWithId:id strItem:Item strValue:Value bIsLocked:bIsLocked strUnit:Unit];
}

std::vector<uint16_t> ArtiActiveGetUpdateItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiActiveModel GetUpdateItemsWithId:id];
    
    std::vector<uint16_t> intVec = [TDD_CTools NSArrayToInt16CVector:arr];
    
    return intVec;
}

void ArtiActiveSetValue(uint32_t id, uint16_t uIndex, const std::string& strValue)
{
    [TDD_ArtiActiveModel SetValueWithId:id uIndex:uIndex strValue:[TDD_CTools CStrToNSString:strValue]];
}

void ArtiActiveSetItem(uint32_t id, uint16_t uIndex, const std::string& strItem)
{
    [TDD_ArtiActiveModel SetItemWithId:id uIndex:uIndex strItem:[TDD_CTools CStrToNSString:strItem]];
}

void ArtiActiveSetUnit(uint32_t id, uint16_t uIndex, const std::string& strUnit)
{
    [TDD_ArtiActiveModel SetUnitWithId:id uIndex:uIndex strUnit:[TDD_CTools CStrToNSString:strUnit]];
}

void ArtiActiveSetOperationTipsOnTop(uint32_t id, const std::string& strOperationTips)
{
    [TDD_ArtiActiveModel SetOperationTipsOnTopWithId:id strOperationTips:[TDD_CTools CStrToNSString:strOperationTips]];
}

void ArtiActiveSetOperationTipsOnBottom(uint32_t id, const std::string& strOperationTips)
{
    [TDD_ArtiActiveModel SetOperationTipsOnBottomWithId:id strOperationTips:[TDD_CTools CStrToNSString:strOperationTips]];
}

void ArtiActiveSetTipsTitleOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType, uint32_t eSize, uint32_t eBold)
{
    [TDD_ArtiActiveModel SetTipsTitleOnTopWithId:id strTips:[TDD_CTools CStrToNSString:strTips] uAlignType:uAlignType eSize:eSize eBold:eBold];
}

void ArtiActiveSetTipsTitleOnBottom(uint32_t id, const std::string& strTips, uint32_t uAlignType, uint32_t eSize, uint32_t eBold)
{
    [TDD_ArtiActiveModel SetTipsTitleOnBottomWithId:id strTips:[TDD_CTools CStrToNSString:strTips] uAlignType:uAlignType eSize:eSize eBold:eBold];
}

void ArtiActiveSetHeads(uint32_t id, const std::vector<std::string>&vctHeadNames)
{
    NSArray * arr = [TDD_CTools CVectorToStringNSArray:vctHeadNames];
    
    [TDD_ArtiActiveModel SetHeadsWithId:id vctHeadNames:arr];
}

void ArtiActiveSetLockFirstRow(uint32_t id)
{
    [TDD_ArtiActiveModel SetLockFirstRowWithId:id];
}

void ArtiActiveAddButton(uint32_t id, const std::string& strButtonText)
{
    [TDD_ArtiActiveModel AddButtonExWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

uint32_t ArtiActiveAddButtonEx(uint32_t id, const std::string& strButtonText)
{
    return [TDD_ArtiActiveModel AddButtonExWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

bool ArtiActiveDelButton(uint32_t id, uint32_t uButtonId)
{
    return [TDD_ArtiActiveModel DelButtonWithId:id uButtonId:uButtonId];
}

void ArtiActiveSetButtonEnable(uint32_t id, uint8_t uIndex, bool bIsEnable)
{
    [TDD_ArtiActiveModel SetButtonStatusWithId:id uIndex:uIndex bIsEnable:bIsEnable];
}

void ArtiActiveSetButtonStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus)
{
    [TDD_ArtiActiveModel SetButtonStatusWithId:id uIndex:uIndex uStatus:uStatus];
}

void ArtiActiveSetButtonText(uint32_t id, uint8_t uIndex, const std::string& strButtonText)
{
    [TDD_ArtiActiveModel SetButtonTextWithId:id uIndex:uIndex strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

uint32_t ArtiActiveShow(uint32_t id)
{
    return [TDD_ArtiActiveModel ShowWithId:id];
}


+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    [self SetHeadsWithId:ID vctHeadNames:@[TDDLocalized.diagnosis_name,TDDLocalized.engine_results,@""]];
}

/**********************************************************
*    功  能：添加动作测试项
*
*    参  数：strItem   动作测试项名称，
*
*            bIsLocked=true, 锁定该行，获取刷新项时，排除此行
*            bIsLocked=false,不锁定该行，获取刷新项时，包含此行
*
*            strValue  动作测试项值
*            strUnit   动作测试项单位
*
*    返回值：无
*    注  意：bIsLocked为true时，并不是“冻结此行”的显示效果
*            而是GetUpdateItems不包括此行
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem strValue:(NSString *)strValue bIsLocked:(BOOL)bIsLocked strUnit:(NSString *)strUnit
{
    HLog(@"%@ - 添加菜单项 - ID:%d - strItem 菜单项名称 ：%@ - strValue ：%@ - bIsLocked : %d - strUnit : %@", [self class], ID, strItem, strValue, bIsLocked, strUnit);
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    ArtiActiveItemModel * itemModel = [[ArtiActiveItemModel alloc] init];
    
    itemModel.uIndex = (uint32_t)model.itemArr.count;
    
    itemModel.strItem = strItem;
    
    itemModel.strValue = strValue;
    
    itemModel.strUnit = strUnit;
    
    itemModel.bIsLocked = bIsLocked;
    itemModel.valueFont = model.valueFont;
    itemModel.titleFont = model.titleFont;
    itemModel.headValueFont = model.headValueFont;
    [itemModel getTitleHeight];
    [itemModel getTextMaxHeight];
    [model.itemArr addObject:itemModel];
}

/**********************************************************
*    功  能：获取当前屏的刷新项（排除锁定行）
*    参  数：无
*    返回值：vector<uint32_t> 当前屏需要刷新的项的下标集合
**********************************************************/
+ (NSArray *)GetUpdateItemsWithId:(uint32_t)ID
{
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    NSArray * arr = @[];
    
    if ([model.delegate respondsToSelector:@selector(TDD_ArtiActiveModelGetUpdateItems)]) {
        arr = [model.delegate TDD_ArtiActiveModelGetUpdateItems];
    }
    HLog(@"%@ - 获取当前屏的刷新项（排除锁定行） - ID:%d - %@", [self class], ID, arr);
    return arr;
}


/**********************************************************
*    功  能：设置动作测试某一项的值
*    参  数：uIndex 动作测试项，strValue 动作测试项值
*    返回值：无
**********************************************************/
+ (void)SetValueWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strValue:(NSString *)strValue
{
    HLog(@"%@ - 设置动作测试某一项的值 - ID:%d - uIndex:%d - strValue:%@", [self class], ID, uIndex, strValue);
    
    [self SetUnitWithId:ID uIndex:uIndex strItem:nil strValue:strValue strUnit:nil];
}


/**********************************************************
*    功  能：设置动作测试某一项的动作测试项名称
*    参  数：uIndex 动作测试项，strItem 动作测试项名称
*    返回值：无
**********************************************************/
+ (void)SetItemWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strItem:(NSString *)strItem
{
    HLog(@"%@ - 设置动作测试某一项的动作测试项名称 - ID:%d - strItem:%@", [self class], ID, strItem);
    
    [self SetUnitWithId:ID uIndex:uIndex strItem:strItem strValue:nil strUnit:nil];
}


/**********************************************************
*    功  能：设置动作测试某一项的单位
*    参  数：uIndex 动作测试项，strUnit 动作测试项单位
*    返回值：无
**********************************************************/
+ (void)SetUnitWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strUnit:(NSString *)strUnit
{
    HLog(@"%@ - 设置动作测试某一项的单位 - ID:%d - uIndex:%d - strUnit:%@", [self class], ID, uIndex, strUnit);
    
    [self SetUnitWithId:ID uIndex:uIndex strItem:nil strValue:nil strUnit:strUnit];
}

+ (void)SetUnitWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strItem:(NSString *)strItem strValue:(NSString *)strValue strUnit:(NSString *)strUnit
{
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    if (model.itemArr.count <= uIndex) {
        HLog(@"没有uIndex：%d",uIndex);
        return;
    }
    
    ArtiActiveItemModel * itemModel = model.itemArr[uIndex];
    
    if (strItem) {
        if (![itemModel.strItem isEqualToString:strItem]) {
            itemModel.strItem = strItem;
            [itemModel getTitleHeight];
        }
        
    }
    if (strValue || strUnit) {
        if (strValue && ![itemModel.strValue isEqualToString:strValue]) {
            itemModel.strValue = strValue;
        }
        if (strUnit && ![itemModel.strUnit isEqualToString:strUnit]) {
            itemModel.strUnit = strUnit;
        }
        [itemModel getTextMaxHeight];
    }

//    if (![model.changeItemArr containsObject:@(uIndex)]) {
//        [model.changeItemArr addObject:@(uIndex)];
//    }
}


/**********************************************************
*    功  能：在界面顶部设置动作测试操作提示
*    参  数：strOperationTips 动作测试操作提示
*    返回值：无
**********************************************************/
+ (void)SetOperationTipsOnTopWithId:(uint32_t)ID strOperationTips:(NSString *)strOperationTips
{
    HLog(@"%@ - 在界面顶部设置动作测试操作提示 - ID:%d - strOperationTips:%@", [self class], ID, strOperationTips);
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    model.strOperationTopTips = strOperationTips;
}


/**********************************************************
*    功  能：在界面底部设置动作测试操作提示
*    参  数：strOperationTips 动作测试操作提示
*    返回值：无
**********************************************************/
+ (void)SetOperationTipsOnBottomWithId:(uint32_t)ID strOperationTips:(NSString *)strOperationTips
{
    HLog(@"%@ - 在界面底部设置动作测试操作提示 - ID:%d - strOperationTips:%@", [self class], ID, strOperationTips);
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    model.strOperationBottomTips = strOperationTips;
}

/***********************************************************************
*    功  能：在界面顶部设置表格文本提示的标题
*
*    参  数：strTipsTitle     对应文本提示的标题
*            uAlignType       对应文本标题的对齐方式，例如
*                             DT_CENTER, 表示居中对齐
*                             DT_LEFT, 表示左对齐
*            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
*                             FORT_SIZE_MEDIUM 表示 中等字体
*                             FORT_SIZE_LARGE 表示 大字体
*            eBold            是否粗体显示
*                             BOLD_TYPE_NONE, 表示不加粗
*                             BOLD_TYPE_BOLD, 表示加粗
*
*    返回值：无
*
*    说  明：如果没有设置（没有调用此接口），则不显示提示标题
***********************************************************************/
+ (void)SetTipsTitleOnTopWithId:(uint32_t)ID strTips:(NSString *)strTips uAlignType:(uint32_t)uAlignType eSize:(uint32_t)eSize eBold:(uint32_t)eBold
{
    HLog(@"%@ - 在界面顶部设置表格的文本提示 - ID:%d - strTips ：%@ - uAlignType : %d - eFontSize : %d - eBoldType : %d", [self class], ID, strTips,uAlignType,eSize,eBold);
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    model.strTitleTopTips = strTips;
    model.uTitleTopAlignType = uAlignType;
    model.eTitleTopFontSize = eSize;
    model.eTitleTopBoldType = eBold;
}

/***********************************************************************
*    功  能：在界面底部设置表格文本提示的标题
*
*    参  数：strTipsTitle     对应文本提示的标题
*            uAlignType       对应文本标题的对齐方式，例如
*                             DT_CENTER, 表示居中对齐
*                             DT_LEFT, 表示左对齐
*            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
*                             FORT_SIZE_MEDIUM 表示 中等字体
*                             FORT_SIZE_LARGE 表示 大字体
*            eBold            是否粗体显示
*                             BOLD_TYPE_NONE, 表示不加粗
*                             BOLD_TYPE_BOLD, 表示加粗
*
*    返回值：无
*
*    说  明：如果没有设置（没有调用此接口），则不显示提示标题
***********************************************************************/
+ (void)SetTipsTitleOnBottomWithId:(uint32_t)ID strTips:(NSString *)strTips uAlignType:(uint32_t)uAlignType eSize:(uint32_t)eSize eBold:(uint32_t)eBold
{
    HLog(@"%@ - 在界面底部设置表格的文本提示 - ID:%d - strTips ：%@ - uAlignType : %d - eFontSize : %d - eBoldType : %d", [self class], ID, strTips,uAlignType,eSize,eBold);
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    model.strTitleBottomTips = strTips;
    model.uTitleBottomAlignType = uAlignType;
    model.eTitleBottomFontSize = eSize;
    model.eTitleBottomBoldType = eBold;
}

/**********************************************************
*    功  能：设置列表头，该行锁定状态
*    参  数：vctHeadNames 列表各列的名称集合
*    返回值：无
**********************************************************/
+ (void)SetHeadsWithId:(uint32_t)ID vctHeadNames:(NSArray<NSString *> *)vctHeadNames
{
    HLog(@"%@ - 设置列表头 - ID:%d - vctHeadNames:%@", [self class], ID, vctHeadNames);
    
    for (NSString * str in vctHeadNames) {
        if (![str isKindOfClass:[NSString class]]) {
            HLog(@"%@ 不是字符串类型", str);
            return;
        }
    }
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    CGFloat valueFontSize = IS_IPad ? 18 : 14 ;
    model.valueFont = [[UIFont systemFontOfSize:valueFontSize weight:UIFontWeightMedium] tdd_adaptHD];
    model.titleFont = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
    model.headValueFont = [[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] tdd_adaptHD];
    ArtiActiveItemModel * headModel = [[ArtiActiveItemModel alloc] init];
    
    headModel.strItem = vctHeadNames.count>0 ? vctHeadNames[0] : @" ";
    
    headModel.strValue = vctHeadNames.count>1 ? vctHeadNames[1] : @" ";
    
    headModel.strUnit = vctHeadNames.count>2 ? vctHeadNames[2] : @" ";
    headModel.valueFont = model.valueFont;
    headModel.titleFont = model.titleFont;
    headModel.headValueFont = model.headValueFont;
    dispatch_async(dispatch_get_main_queue(), ^{
        [headModel getMaxHeadHeight];
    });

    
    model.headModel = headModel;
}


/**********************************************************
*    功  能：设置第一行是锁定状态，类似Excel表格的“冻结首行”
*
*    参  数：无
*
*    返回值：无
*
*    注  意：首行和列表头(Head)是不一样的
*            如果设置了列表头，SetHeads
*            并且锁定了首行，SetLockFirstRow
*            会有类似冻结了2行的效果
*
*            列表头 和 SetLockFirstRow的首行 底纹 应该有区别的效果
**********************************************************/
+ (void)SetLockFirstRowWithId:(uint32_t)ID
{
    HLog(@"%@ - 设置第一行是锁定状态 - ID:%d", [self class], ID);
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    model.SetLockFirstRow = YES;
    
    if (model.itemArr.count > 0) {
        ArtiActiveItemModel * itemModel = model.itemArr[0];
        itemModel.bIsLocked = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [itemModel getMaxHeadHeight];
        });
    }

}

/**********************************************************
*    功  能：设置指定的动作测试按钮状态
*    参  数：uIndex 指定的动作测试按钮
*            bIsEnable=true 按钮可点击
*            bIsEnable=false 按钮不可点击
*    返回值：无
**********************************************************/
+ (void)SetButtonStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex bIsEnable:(BOOL)bIsEnable
{
    HLog(@"%@ - 设置指定的动作测试按钮状态 - ID:%d - uIndex:%d - bIsEnable:%d", [self class], ID, uIndex, bIsEnable);
    
    if (uIndex >= DF_ID_FREEBTN_0) {
        uIndex -= DF_ID_FREEBTN_0;
    }
    
    TDD_ArtiActiveModel * model = (TDD_ArtiActiveModel *)[self getModelWithID:ID];
    
    if (model.buttonArr.count <= uIndex) {
        HLog(@"没有uIndex：%d",uIndex);
        return;
    }
    
    TDD_ArtiButtonModel * buttonModel = model.buttonArr[uIndex];
    
    buttonModel.bIsEnable = bIsEnable;
    
    model.isReloadButton = YES;
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    if (buttonID == DF_ID_REPORT) {
        [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":@"ActiveTest"}];
    }
    return YES;
}


- (NSMutableArray<ArtiActiveItemModel *> *)itemArr{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    
    return _itemArr;
}

@end

@implementation ArtiActiveItemModel
{
    CGFloat _width;
    CGFloat _scale;
    CGFloat _spaceWidth;
    CGFloat _spaceHeight;
    CGFloat _centerspaceWidth;
    CGFloat _bottomHeight;
}
- (instancetype)init {
    if (self = [super init]) {

        _scale = IS_IPad ? HD_Height : H_Height;
        _spaceWidth = IS_IPad ? 40 * _scale  : 16 * _scale;
        _spaceHeight = IS_IPad ? 20 * HD_HHeight  : 16 * H_HHeight;
        _centerspaceWidth = IS_IPad ? 40 * _scale : 25 * _scale;
        _width = (IphoneWidth - _spaceWidth * 2 - _centerspaceWidth)/4;
        _bottomHeight = IS_IPad ? 100 * _scale : 58 * _scale;
    }
    return self;
}
- (void)getMaxHeadHeight {
    [self getValueHeight];
    [self getTitleHeight];
    CGFloat cellH = MAX(_titleHeight, _valueHeight) + _spaceHeight * 2;
    self.headMaxHeight = (IphoneHeight - NavigationHeight - _bottomHeight)/2;
    self.headHeight = MIN(self.headMaxHeight, cellH);
}

- (void)getTextMaxHeight {
    NSMutableAttributedString *attStr = [NSMutableAttributedString mutableAttributedStringWithLTRString:[NSString stringWithFormat:@"%@ %@",_strValue,_strUnit]];
    NSRange valueRange = NSMakeRange(0, _strValue.length);
    [attStr setYy_font:[[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] tdd_adaptHD]];
    [attStr yy_setFont:_valueFont range:valueRange];
    [attStr setYy_color:self.bIsLocked?[UIColor tdd_titleLock]:[UIColor tdd_title]];
    [attStr yy_setColor:self.bIsLocked?[UIColor tdd_titleLock]:[UIColor tdd_color2B79D8] range:valueRange];
    
    _valueHeight = [NSString tdd_isEmpty:attStr.string] ? 0 :[NSString tdd_calculateHeightForAttributedString:attStr width:_width] + 5;
    CGFloat maxHeight = MAX(_titleHeight,_valueHeight) + _spaceHeight * 2;
    CGFloat minHeight = IS_IPad ? 62 * _scale : 52 * _scale;
    _textMaxHeight =  MAX(maxHeight,minHeight);
    
}

- (void)getValueHeight {

    _valueHeight = [NSString tdd_isEmpty:self.strValue] ? 0 :[NSString tdd_getHeightWithText:self.strValue width:_width fontSize:_headValueFont];
}

- (void)getTitleHeight {
    _titleHeight = [NSString tdd_getHeightWithText:self.strItem width:_width  * 3 fontSize:_titleFont];
    
}

@end
