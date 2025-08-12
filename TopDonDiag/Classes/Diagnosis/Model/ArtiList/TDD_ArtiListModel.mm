//
//  TDD_ArtiListModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/12.
//

#import "TDD_ArtiListModel.h"
#if useCarsFramework
#import <CarsFramework/RegList.hpp>
#import <CarsFramework/HStdOtherMaco.h>
#else
#import "RegList.hpp"
#import "HStdOtherMaco.h"
#endif

#import "TDD_CTools.h"


@implementation TDD_ArtiListModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegList::Construct(ArtiListConstruct);
    CRegList::Destruct(ArtiListDestruct);
    CRegList::InitTitle(ArtiListInitTitle);
    CRegList::InitTitleType(ArtiListInitTitleType);
    CRegList::SetColWidth(ArtiListSetColWidth);
    CRegList::SetHeads(ArtiListSetHeads);
    CRegList::SetTipsOnTop(ArtiListSetTipsOnTop);
    CRegList::SetTipsOnBottom(ArtiListSetTipsOnBottom);
    CRegList::SetBlockStatus(ArtiListSetBlockStatus);
    CRegList::AddButton(ArtiListAddButton);
    CRegList::AddButtonEx(ArtiListAddButtonEx);
    CRegList::DelButton(ArtiListDelButton);
    CRegList::AddGroup(ArtiListAddGroup);
    CRegList::AddItem(ArtiListAddItem);
    CRegList::AddItemVec(ArtiListAddItemVec);
    CRegList::SetItem(ArtiListSetItem);
    CRegList::SetItemPicture(ArtiListSetItemPicture);
    CRegList::SetLeftLayoutPicture(ArtiListSetLeftLayoutPicture);
    CRegList::SetRowHighLight(ArtiListSetRowHighLight);
    //报库找不到这个方法
    CRegList::SetRowHighLightColour(ArtiListSetRowHighLightColour);
    CRegList::SetRowHighLightColour(ArtiListSetRowHighLightColourList);
    CRegList::SetLockFirstRow(ArtiListSetLockFirstRow);
    CRegList::SetDefaultSelectedRow(ArtiListSetDefaultSelectedRow);
    CRegList::SetCheckBoxStatus(ArtiListSetCheckBoxStatus);
    CRegList::SetButtonStatus(ArtiListSetButtonStatus);
    CRegList::SetButtonStatusU32(ArtiListSetButtonStatusU32);
    CRegList::SetButtonText(ArtiListSetButtonText);
    CRegList::GetSelectedRow(ArtiListGetSelectedRow);
    CRegList::GetSelectedRowEx(ArtiListGetSelectedRowEx);
    CRegList::SetTipsTitleOnTop(ArtiListSetTipsTitleOnTop);
    CRegList::SetSelectedType(ArtiSetSelectedType);
    CRegList::SetRowInCurrentScreen(ArtiSetRowInCurrentScreen);
    CRegList::Show(ArtiListShow);
    
    // 大众 SFD 解锁
    CRegList::SetShareButtonVisible(ArtiListSetShareButtonVisible);
}

// 是否展示分享按钮
uint32_t ArtiListSetShareButtonVisible(uint32_t id, bool bVisible, const std::string& strTitle, const std::string& strContent)
{
    return [TDD_ArtiListModel SetShareButtonWithId:id bVisible:bVisible strTitle:[TDD_CTools CStrToNSString:strTitle] strContent:[TDD_CTools CStrToNSString:strContent]];
}


void ArtiListConstruct(uint32_t id)
{
    [TDD_ArtiListModel Construct:id];
}

void ArtiListDestruct(uint32_t id)
{
    [TDD_ArtiListModel Destruct:id];
}

bool ArtiListInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiListModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

bool ArtiListInitTitleType(uint32_t id, const std::string& strTitle, uint32_t Type)
{
    return [TDD_ArtiListModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] Type:(eListViewType)Type];
}

void ArtiListSetColWidth(uint32_t id, const std::vector<int32_t>& vctColWidth)
{
    [TDD_ArtiListModel SetColWidthWithId:id vctColWidth:[TDD_CTools CVectorToIntNSArray:vctColWidth]];
}

void ArtiListSetHeads(uint32_t id, const std::vector<std::string>& vctHeadNames)
{
    [TDD_ArtiListModel SetHeadsWithId:id vctHeadNames:[TDD_CTools CVectorToStringNSArray:vctHeadNames]];
}

void ArtiListSetTipsOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType)
{
   [TDD_ArtiListModel SetTipsOnTopWithId:id strTips:[TDD_CTools CStrToNSString:strTips]];
}

void ArtiListSetTipsTitleOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType,uint32_t eSize, uint32_t eBold)
{
    [TDD_ArtiListModel SetTipsTitleOnTopWithId:id strTips:[TDD_CTools CStrToNSString:strTips] uAlignType:uAlignType eFontSize:eSize eBoldType:eBold];
}

void ArtiListSetTipsOnBottom(uint32_t id, const std::string& strTips)
{
    [TDD_ArtiListModel SetTipsOnBottomWithId:id strTips:[TDD_CTools CStrToNSString:strTips]];
}

void ArtiListSetBlockStatus(uint32_t id, bool bIsBlock)
{
    [TDD_ArtiListModel SetBlockStatusWithId:id bIsBlock:bIsBlock];
}

void ArtiListAddButton(uint32_t id, const std::string& strButtonText)
{
    [TDD_ArtiListModel AddButtonExWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

uint32_t ArtiListAddButtonEx(uint32_t id, const std::string& strButtonText)
{
    return [TDD_ArtiListModel AddButtonExWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

bool ArtiListDelButton(uint32_t id, uint32_t uButtonId)
{
    return [TDD_ArtiListModel DelButtonWithId:id uButtonId:uButtonId];
}

void ArtiListAddGroup(uint32_t id, const std::string& strGroupName)
{
    [TDD_ArtiListModel AddGroupWithId:id strGroupName:[TDD_CTools CStrToNSString:strGroupName]];
}

void ArtiListAddItemVec(uint32_t id, const std::vector<std::string>& vctItems, bool bIsHighLight)
{
    [TDD_ArtiListModel AddItemWithId:id vctItems:[TDD_CTools CVectorToStringNSArray:vctItems] bIsHighLight:bIsHighLight];
}

void ArtiListAddItem(uint32_t id, const std::string& strItem)
{
    [TDD_ArtiListModel AddItemWithId:id strItem:[TDD_CTools CStrToNSString:strItem]];
}

void ArtiListSetItem(uint32_t id, uint16_t uRowIndex, uint16_t uColIndex, const std::string& strValue)
{
    [TDD_ArtiListModel SetItemWithId:id uRowIndex:uRowIndex uColIndex:uColIndex strValue:[TDD_CTools CStrToNSString:strValue]];
}

void ArtiListSetItemPicture(uint32_t id, uint16_t uColIndex, const std::vector<std::string>& vctPath)
{
    [TDD_ArtiListModel SetItemPictureWithId:id uColIndex:uColIndex vctPath:[TDD_CTools CVectorToStringNSArray:vctPath]];
}

void ArtiListSetRowHighLight(uint32_t id, uint16_t uRowIndex)
{
    [TDD_ArtiListModel SetRowHighLightWithId:id uRowIndex:uRowIndex];
}

void ArtiListSetRowHighLightColour(uint32_t id, uint16_t uRowIndex, eColourType uColorType)
{
    [TDD_ArtiListModel SetRowHighLightWithId:id uRowIndex:uRowIndex uColorType:uColorType];
}

void ArtiListSetRowHighLightColourList(uint32_t id, std::vector<uint16_t>rowList, std::vector<uint16_t>colorList)
{
    [TDD_ArtiListModel SetRowHighLightWithId:id uRowList:[TDD_CTools CUInt16VectorToIntNSArray:rowList] uColorList:[TDD_CTools CUInt16VectorToIntNSArray:colorList]];
}

void ArtiListSetLockFirstRow(uint32_t id)
{
    [TDD_ArtiListModel SetLockFirstRowWithId:id];
}

void ArtiListSetDefaultSelectedRow(uint32_t id, uint16_t uRowIndex)
{
    [TDD_ArtiListModel SetDefaultSelectedRowWithId:id uRowIndex:uRowIndex];
}

void ArtiListSetCheckBoxStatus(uint32_t id, uint16_t uRowIndex, bool bChecked)
{
    [TDD_ArtiListModel SetCheckBoxStatusWithId:id uRowIndex:uRowIndex bChecked:bChecked];
}

void ArtiListSetButtonStatus(uint32_t id, uint8_t uIndex, bool bIsEnable)
{
    //已废弃
}

void ArtiListSetButtonStatusU32(uint32_t id, uint16_t uIndex, uint32_t uStatus)
{
    [TDD_ArtiListModel SetButtonStatusWithId:id uIndex:uIndex uStatus:uStatus];
}

void ArtiListSetButtonText(uint32_t id, uint8_t uIndex, const std::string& strButtonText)
{
    [TDD_ArtiListModel SetButtonTextWithId:id uIndex:uIndex strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

uint16_t ArtiListGetSelectedRow(uint32_t id)
{
    return [TDD_ArtiListModel GetSelectedRowWithId:id];
}

std::vector<uint16_t> ArtiListGetSelectedRowEx(uint32_t id)
{
    NSArray * arr = [TDD_ArtiListModel GetSelectedRowExWithId:id];

    return [TDD_CTools NSArrayToInt16CVector:arr];
}



bool ArtiListSetLeftLayoutPicture(uint32_t id, const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType)
{
    return [TDD_ArtiListModel SetLeftLayoutPictureWithId:id strPicturePath:[TDD_CTools CStrToNSString:strPicturePath] strPictureTips:[TDD_CTools CStrToNSString:strPictureTips] uAlignType:uAlignType];
}

uint32_t ArtiSetSelectedType(uint32_t id, uint32_t lstType)
{
    return [TDD_ArtiListModel SetSelectedTypeWithId:id eListSelectType:(eListSelectType)lstType];
}

uint32_t ArtiSetRowInCurrentScreen(uint32_t id, uint32_t rowType, uint32_t uIndex)
{
    return [TDD_ArtiListModel SetRowInCurrentScreenWithId:id eScreenRowType:(eScreenRowType)rowType uIndex:uIndex];
}

uint32_t ArtiListShow(uint32_t id)
{
    return [TDD_ArtiListModel ShowWithId:id];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.scrollToIndex = -1;
        
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    buttonModel.uButtonId = [@(DF_ID_SHARE) intValue];
    buttonModel.strButtonText = TDDLocalized.battery_share;
    buttonModel.bIsEnable = YES;
    buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    [model.customButtonArr addObject:buttonModel];

    model.isReloadButton = YES;
}

+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle
{
    BOOL isInit = [super InitTitleWithId:ID strTitle:strTitle];
    
    [self initModelWithId:ID];
    
    return isInit;
}

/**********************************************************
*    功  能：初始化列表控件，同时设置标题文本，设置列表类型
*
*    参  数：strTitle    标题文本
*             Type        列表类型
*
*    返回值：true 初始化成功 false 初始化失败
**********************************************************/
+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle Type:(eListViewType)Type
{
    HLog(@"%@ - 初始化列表控件，同时设置标题文本，设置列表类型 - ID:%d - strTitle ：%@ - Type : %d", [self class], ID, strTitle, Type);
    
    [self Destruct:ID];
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    }
    
    [self initModelWithId:ID];
    
    model.strTitle = strTitle;
    
    model.listViewType = Type;
    
    if ([model.strTitle isEqualToString:strTitle]) {
        return YES;
    }else{
        return NO;
    }
}

///初始化参数
+ (void)initModelWithId:(uint32_t)ID
{
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.selectedRow = -1;
}

/**********************************************************
*    功  能：设置列表列宽比
*    参  数：vctColWidth 列表各列的宽度
*    返回值：无
*
*     说  明：vctColWidth的大小为列数
*            例如vctColWidth共有2个元素，即列数为2
*             vctColWidth各元素的总和为100
**********************************************************/
+ (void)SetColWidthWithId:(uint32_t)ID vctColWidth:(NSArray *)vctColWidth
{
    HLog(@"%@ - 设置列表列宽比 - ID:%d - vctColWidth ：%@", [self class], ID, vctColWidth);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.vctColWidth = vctColWidth;
}


/**********************************************************
*    功  能：设置列表头，该行锁定状态
*    参  数：vctHeadNames 列表各列的名称集合
*    返回值：无
**********************************************************/
+ (void)SetHeadsWithId:(uint32_t)ID vctHeadNames:(NSArray *)vctHeadNames
{
    HLog(@"%@ - 设置列表头 - ID:%d - vctHeadNames ：%@", [self class], ID, vctHeadNames);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.vctHeadNames = vctHeadNames;
    
    model.isShowHeader = YES;
}

/**********************************************************
*    功  能：在界面顶部设置表格的文本提示
*
*    参  数：strTips   对应的文本提示
*
*    返回值：无
*
*    说  明：如果没有设置（没有调用此接口），则不显示提示
**********************************************************/
+ (void)SetTipsOnTopWithId:(uint32_t)ID strTips:(NSString *)strTips
{
    HLog(@"%@ - 在界面顶部设置表格的文本提示 - ID:%d - strTips ：%@", [self class], ID, strTips);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.strTopTips = strTips;
    
}

  /*
   *   注册CArtiList的成员函数SetTipsTitleOnTop的回调函数
   *
   *   void SetTipsTitleOnTop(uint32_t id, const std::string& strTips, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);
   *
   *   id, 对象编号，表示哪一个对象调用的成员方法
   *   其他参数见ArtiList.h的说明
   *
   *   SetTipsTitleOnTop 函数说明见 ArtiList.h
   */
+ (void)SetTipsTitleOnTopWithId:(uint32_t)ID strTips:(NSString *)strTips uAlignType:(uint32_t)uAlignType eFontSize:(uint32_t)eSize eBoldType:(uint32_t)eBold
{
    HLog(@"%@ - 在界面顶部设置表格的文本提示 - ID:%d - strTips ：%@ - uAlignType : %d - eFontSize : %d - eBoldType : %d", [self class], ID, strTips,uAlignType,eSize,eBold);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.strTitleTopTips = strTips;
    model.uAlignType = uAlignType;
    model.eFontSize = eSize;
    model.eBoldType = eBold;
    
}


/**********************************************************
*    功  能：在界面底部设置表格的文本提示
*
*    参  数：strTips   对应的文本提示
*
*    返回值：无
*
*    说  明：如果没有设置（没有调用此接口），则不显示提示
**********************************************************/
+ (void)SetTipsOnBottomWithId:(uint32_t)ID strTips:(NSString *)strTips
{
    HLog(@"%@ - 在界面底部设置表格的文本提示 - ID:%d - strTips ：%@", [self class], ID, strTips);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.strBottomTips = strTips;
    
}

/**********************************************************
*    功  能：设置界面的阻塞状态
*    参  数：bIsBlock=true 该界面为阻塞的
*            bIsBlock=false 该界面为非阻塞的
*    返回值：无
**********************************************************/
+ (void)SetBlockStatusWithId:(uint32_t)ID bIsBlock:(BOOL)bIsBlock
{
    HLog(@"%@ - 设置界面的阻塞状态 - ID:%d - bIsBlock ：%d", [self class], ID, bIsBlock);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.bIsBlock = bIsBlock;
}


/**********************************************************
*    功  能：添加分组，组为一列，相当于合并了单元格（整行）
*
*    参  数：strGroupName 组名
*
*    返回值：无
**********************************************************/
+ (void)AddGroupWithId:(uint32_t)ID strGroupName:(NSString *)strGroupName
{
    HLog(@"%@ - 添加分组 - ID:%d - strGroupName ：%@", [self class], ID, strGroupName);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    ArtiListItemModel * itemModel = [[ArtiListItemModel alloc] init];
    itemModel.isGroup = YES;
    itemModel.strGroupName = strGroupName;
    itemModel.index = -1;
    

    [model.itemArr addObject:itemModel];
    
}


/**********************************************************
*    功  能：添加数据项, 默认该行不高亮显示
*
*    参  数：vctItems 数据项集合
*
*            bIsHighLight=true   高亮显示该行
*            bIsHighLight=false  不高亮显示该行
*
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID vctItems:(NSArray *)vctItems bIsHighLight:(BOOL)bIsHighLight
{
    HLog(@"%@ - 添加数据项 - ID:%d - vctItems ：%@ - bIsHighLight : %d", [self class], ID, vctItems, bIsHighLight);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    ArtiListItemModel * itemModel = [[ArtiListItemModel alloc] init];
    
    itemModel.vctItems = vctItems.mutableCopy;
    
    itemModel.bIsHighLight = bIsHighLight;
    
    itemModel.index = model.itemCount;
    model.itemCount = model.itemCount + 1;
    [model.itemArr addObject:itemModel];
    
}


/**********************************************************
*    功  能：添加数据项名称
*    参  数：strItem 数据项名称
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem
{
    HLog(@"%@ - 添加数据项名称 - ID:%d - strItem ：%@", [self class], ID, strItem);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    ArtiListItemModel * itemModel = [[ArtiListItemModel alloc] init];
    
    itemModel.vctItems = @[strItem].mutableCopy;
    
    itemModel.index = model.itemCount;
    model.itemCount = model.itemCount + 1;

    [model.itemArr addObject:itemModel];
    
}


/**********************************************************
*    功  能：设置列表指定位置的值
*    参  数：uRowIndex 列表行标
*            uColIndex 列表列标
*            strValue   指定位置需要设置的值
*    返回值：无
**********************************************************/
+ (void)SetItemWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex uColIndex:(uint32_t)uColIndex strValue:(NSString *)strValue
{
    HLog(@"%@ - 设置列表指定位置的值 - ID:%d - uRowIndex 列表行标 ：%d - uColIndex 列表列标 : %d - strValue : %@", [self class], ID, uRowIndex, uColIndex, strValue);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    if (uRowIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return;
    }
    
    ArtiListItemModel * itemModel = model.itemArr[uRowIndex];
    
    if (uColIndex >= model.vctColWidth.count) {
        HLog(@"uColIndex 过界");
        return;
    }
    
    if (uColIndex >= itemModel.vctItems.count) {
        int count = (int)itemModel.vctItems.count;
        for (int i = 0; i <= uColIndex - count; i ++) {
            if (i == uColIndex - count) {
                [itemModel.vctItems addObject:strValue];
            }else {
                [itemModel.vctItems addObject:@" "];
            }
        }
    }else {
        [itemModel.vctItems replaceObjectAtIndex:uColIndex withObject:strValue];
    }
    
    
}


/***************************************************************************
*    功  能：在指定某一列插入图片，图片格式为png
*
*    参  数：uColIndex        List 列标
*                           指定此列显示图片，那此列的所有行将不能显示文本
*
*            vctPath        指定列上显示的各行图片路径
*                           vctPath的大小为总行数
*                           如果小于总行数，最后缺少的行的图片为空
*                           如果vctPath指定行的路径串为非法路径（空串或文件
*                           不存在），此行此列的图片为空
*
*                           图片路径格式为： 绝对路径（全路径）
*
*    返回值：无
*
*    使用场景：需要用到小的图标（图片）来指示每一行的状态
*
***************************************************************************/
+ (void)SetItemPictureWithId:(uint32_t)ID uColIndex:(uint32_t)uColIndex vctPath:(NSArray *)vctPath
{
    HLog(@"%@ - 在指定某一列插入图片 - ID:%d - uColIndex：%d - vctPath : %@", [self class], ID, uColIndex, vctPath);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.isShowImage = YES;
    
    model.uColImageIndex = uColIndex;
    
    model.vctImagePathArr = vctPath;
}


/**********************************************************
*    功  能：设置指定的行需要高亮显示，同时高亮显示行不能被选中
*    参  数：uRowIndex 指定需要高亮显示的行号
*    返回值：无
*            注意：显示高亮显示行与选中行的颜色不一致
**********************************************************/
+ (void)SetRowHighLightWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex
{
    HLog(@"%@ - 设置指定的行需要高亮显示 - ID:%d - uRowIndex：%d", [self class], ID, uRowIndex);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    if (uRowIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return;
    }
    ArtiListItemModel * itemModel;
    for (ArtiListItemModel * item in model.itemArr) {
        if (item.index == uRowIndex) {
            itemModel = item;
            break;
        }
    }
    if (!itemModel) {
        HLog(@"uRowIndex  %d 找不到 %@",uRowIndex,model.itemArr);
        return;
    }
    
    itemModel.bIsHighLight = YES;
}

/**********************************************************
*    功  能：设置指定的行需要高亮显示，同时高亮显示行不能被选中
*    参  数：uRowIndex 指定需要高亮显示的行号
*    返回值：无
*            注意：显示高亮显示行与选中行的颜色不一致
**********************************************************/
+ (void)SetRowHighLightWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex uColorType:(eColourType)uColorType
{
    HLog(@"%@ - 设置指定的行需要高亮显示 - ID:%d - uRowIndex：%d - uColorType: %d", [self class], ID, uRowIndex,uColorType);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    if (uRowIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return;
    }
    
    ArtiListItemModel * itemModel;
    for (ArtiListItemModel * item in model.itemArr) {
        if (item.index == uRowIndex) {
            itemModel = item;
            break;
        }
    }
    if (!itemModel) {
        HLog(@"uRowIndex  %d 找不到 %@",uRowIndex,model.itemArr);
        return;
    }
    itemModel.eHighLighColorType = uColorType;
    itemModel.bIsHighLight = YES;
}

/**********************************************************
*    功  能：设置指定的行需要高亮显示，同时高亮显示行不能被选中
*    参  数：uRowIndex 指定需要高亮显示的行号
*    返回值：无
*            注意：显示高亮显示行与选中行的颜色不一致
**********************************************************/
+ (void)SetRowHighLightWithId:(uint32_t)ID uRowList:(NSArray *)rowList uColorList:(NSArray *)uColorList
{
    HLog(@"%@ - 设置指定的行数组需要高亮显示 - ID:%d - uRowIndexList：%@ - uColorList:%@", [self class], ID, rowList,uColorList);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    [model.itemArr enumerateObjectsUsingBlock:^(ArtiListItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([rowList containsObject:@(obj.index)]) {
            NSInteger i = [rowList indexOfObject:@(obj.index)];
            obj.bIsHighLight = YES;
            if (i < uColorList.count) {
                obj.eHighLighColorType = ((NSNumber *)uColorList[i]).intValue;
            }
            
        }
    }];
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
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.isLockFirstRow = YES;
}


/*******************************************************************
*    功  能：设置默认选中的行
*
*    参  数：uRowIndex 默认选中行的行，以最后一次设置为准
*
*    返回值：无
*
*    注 意：此接口针对 ITEM_NO_CHECKBOX 类型的列表框， 如果是“复选
*           框”(ITEM_WITH_CHECKBOX_SINGLE和ITEM_WITH_CHECKBOX_MULTI)
*           类型，请用SetCheckBoxStatus接口
*********************************************************************/
+ (void)SetDefaultSelectedRowWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex
{
    HLog(@"%@ - 设置默认选中的行 - ID:%d - uRowIndex : %d", [self class], ID, uRowIndex);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.selectedRow = uRowIndex;
}


/**********************************************************
*    功  能：设置复选框默认选中状态
*
*    参  数：uRowIndex 行序号，bChecked 是否选中
*
*    返回值：无
*
*    说 明： 如果没有调用此接口，所有行默认状态都为未选中
**********************************************************/
+ (void)SetCheckBoxStatusWithId:(uint32_t)ID uRowIndex:(uint32_t)uRowIndex bChecked:(BOOL)bChecked
{
    HLog(@"%@ - 设置复选框默认选中状态 - ID:%d - uRowIndex : %d - bChecked : %d", [self class], ID, uRowIndex, bChecked);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    if (bChecked) {
        [model.boxSelectSet addObject:@(uRowIndex)];
    }else {
        [model.boxSelectSet removeObject:@(uRowIndex)];
    }
}

/**********************************************************
*    功  能：获取选中的行号
*
*             即：list类型为ITEM_NO_CHECKBOX时，调用此接口可以
*                获取选中的行号
*
*    参  数：无
*    返回值：选中的行号
**********************************************************/
+ (uint16_t)GetSelectedRowWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取选中的行号 - ID:%d", [self class], ID);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    int32_t selectedRow = model.selectedRow;
    
    return (uint16_t)selectedRow;
}


/**********************************************************
*    功  能：获取选中的行号，适用于复选框情况
*
*            即：list类型为ITEM_WITH_CHECKBOX_SINGLE或
*                者ITEM_WITH_CHECKBOX_MULTI
*
*    参  数：无
*    返回值：选中的行号
*            如果大小为0，表示没有选中任何一项
**********************************************************/
+ (NSArray *)GetSelectedRowExWithId:(uint32_t)ID
{
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    NSArray *arr =  [model.boxSelectSet.allObjects sortedArrayUsingComparator:^NSComparisonResult(NSNumber * obj1, NSNumber * obj2) {
       if (obj1.integerValue < obj2.integerValue )
       {
           return NSOrderedAscending;
       }
       else
       {
           return NSOrderedDescending;
       }
    }];
    HLog(@"%@ - 获取选中的行号，适用于复选框情况 - ID:%d - arr:%@", [self class], ID,arr);
    return arr;
}

/****************************************************************************
*    功  能：设置List所有行是否可被选择，默认可以被选中（触摸/点击）
*            复选框不在此范围（不受影响）
*
*    参  数： eListSelectType lstType
*                  ITEM_SELECT_DEFAULT  任意一行可以被选中
*                  用户可以选择哪一行（触摸/点击选择），相应行被选中状态
*
*                  ITEM_SELECT_DISABLED  所有行都不能被选中（UI用户）
*                  UI用户不可以选择任何一行（触摸/点击选择），选中只能由接口
*                  SetDefaultSelectedRow控制
*                  如果诊断应用程序没有调用SetDefaultSelectedRow接口，Show返回
*                  没有选中任何一行DF_LIST_LINE_NONE
*                  同时GetSelectedRow也返回没有选中任何一行DF_LIST_LINE_NONE
*
*    返回值： 设置正常，返回0
*             如果找不到App对此接口的定义（或者App没有注册此接口回调），
*             返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
*
*    说  明： 如果应用程序调用了此接口并且设置类型为ITEM_SELECT_DISABLED，
*             List所有行将不能被选择（用户UI点击任意一行都将不会被反应，
*             触摸失效的效果），选中哪一行将由接口SetDefaultSelectedRow指定
*             同时Show返回的行与SetDefaultSelectedRow保持一致
*
*             如果应用程序没有调用此接口，默认为ITEM_SELECT_DEFAULT
*             即可以被选中（触摸/点击）
****************************************************************************/
+ (uint32_t)SetSelectedTypeWithId:(uint32_t)ID eListSelectType:(eListSelectType )eListSelectType
{    
    HLog(@"%@ - SetSelectedTypeWithId - eListSelectType:%@",[self class],@(eListSelectType));
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    model.listSelectType = eListSelectType;
    return 0;
    
}

/****************************************************************************
*    功  能：设置当前屏的第一行的行号或者当前屏的最后一行的行号
*            从而诊断程序可以控制当前屏幕需要显示的行
*
*    参  数： eScreenRowType rowType
*                  SCREEN_TYPE_FIRST_ROW  设置的行号是当前屏的第一行
*                  SCREEN_TYPE_LAST_ROW   设置的行号是当前屏的最后一行
*
*    返回值： 设置正常，返回0
*             如果找不到App对此接口的定义（或者App没有注册此接口回调），
*             返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
*
*    说  明： 通过此接口，诊断程序可以控制当前屏幕显示的行
****************************************************************************/
+ (uint32_t)SetRowInCurrentScreenWithId:(uint32_t)ID eScreenRowType:(eScreenRowType )rowType uIndex:(uint32_t)uIndex
{
    HLog(@"%@ - SetRowInCurrentScreenWithId - rowType:%d - uIndex:%d",[self class],rowType,uIndex);
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    if (model.itemCount <= uIndex) {
        HLog(@"SetRowInCurrentScreenWithId - 设置行号超过范围");
        return DF_FUNCTION_APP_CURRENT_NOT_SUPPORT;
    }
    model.scrollToIndex = uIndex;
    model.scrollRowType = rowType;
    return 0;
    
}

/***************************************************************************
*    功  能：在list左边增加一个图片，list半屏靠右显示，增加的图片半屏靠左显示
*
*    参  数：strPicturePath 指定显示的图片路径
*                           如果strPicturePath指定图片路径串为非法路径（空串
*                           或文件不存在），返回失败
*
*            strPictureTips 图片显示的文本提示
*
*            uAlignType     文本提示显示在图片的哪个部位
*                           DT_RIGHT_TOP，文本提示显示在图片的右上角
*                           DT_LEFT_TOP， 文本提示显示在图片的左上角
*
*    返回值：无
*
*    注  意：SetLeftLayoutPicture不能和SetItemPicture一起使用，即调用了
*            SetLeftLayoutPicture后，再调用SetItemPicture无效
*
*    使用场景：防盗芯片识别
*
***************************************************************************/
+ (BOOL)SetLeftLayoutPictureWithId:(uint32_t)ID strPicturePath:(NSString *)strPicturePath strPictureTips:(NSString *)strPictureTips uAlignType:(uint16_t)uAlignType
{
    HLog(@"%@ - 防盗芯片识别,增加一个图片 - ID:%d - strPicturePath:%@ - strPictureTips:%@ - uAlignType:%d", [self class], ID, strPicturePath, strPictureTips, uAlignType);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    model.IMMOStrPicturePath = strPicturePath;
    model.IMMOStrPictureTips = strPictureTips;
    model.IMMOUAlignType = uAlignType;
    
    return YES;
}

/****************************************************************************
*    功  能：  添加固定按钮类型的“分享”按钮，并显示
*              默认没有显示这个“分享”按钮，即bVisible为false
*
*              固定的“分享”按钮点击不做任何返回值
*              即App在Show中不会将用户点击此按钮返回给诊断应用
*
*              通常情况下，分享有3种类型，“二维码”、“邮件”、“本地存储”
*
*    参  数：  bVisible   是否显示按钮并可用
*                         true   显示并可用
*                         false  隐藏
*
*              strTitle   “邮件”分享的标题
*                         “本地存储”分享的标题
*
*              strContent  分享的实际内容
*
*    返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
*              其他值，暂无意义
*
*    注  意：  如果没有调用过此接口，此按钮不显示
****************************************************************************/
+ (uint32_t)SetShareButtonWithId:(uint32_t)ID bVisible:(BOOL)bVisible strTitle:(NSString *)strTitle strContent:(NSString *)strContent
{
    HLog(@"%@ - 添加固定按钮类型的“分享”按钮 - ID:%d - bVisible:%d - strTitle ：%@ - strContent : %@", [self class], ID, bVisible,strTitle,strContent);
    
    TDD_ArtiListModel * model = (TDD_ArtiListModel *)[self getModelWithID:ID];
    
    for (TDD_ArtiButtonModel * buttonModel in model.customButtonArr) {
        if (buttonModel.uButtonId == [@(DF_ID_SHARE) intValue]) {
            if (bVisible) {
                buttonModel.uStatus = ArtiButtonStatus_ENABLE;
            } else {
                buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
            }
        }
    }
        
    model.strShareTitle = strTitle;
    model.strShareContent = strContent;
    
    model.isReloadButton = YES;
    
    return 0;
}

- (NSMutableArray<ArtiListItemModel *> *)itemArr
{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}

- (NSMutableSet *)boxSelectSet
{
    if (!_boxSelectSet) {
        _boxSelectSet = [[NSMutableSet alloc] init];
    }
    return _boxSelectSet;
}

@end


@implementation ArtiListItemModel

@end
