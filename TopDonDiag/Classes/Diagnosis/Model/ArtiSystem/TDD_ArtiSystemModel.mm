//
//  TDD_ArtiSystemModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/25.
//

#import "TDD_ArtiSystemModel.h"

#if useCarsFramework
#import <CarsFramework/RegSystem.hpp>
#else
#import "RegSystem.hpp"
#endif

#import "TDD_CTools.h"

typedef enum {
    ///帮助按钮
    SystemButtonType_Help = 0,
    ///报告按钮
    SystemButtonType_Report,
    ///扫描按钮
    SystemButtonType_Scan,
    ///清码按钮
    SystemButtonType_ClearCode,
    ///显示按钮
    SystemButtonType_Show
   
}SystemButtonType;



const uint32_t DF_ID_SYS_H_ACTUAL = 1;

const uint32_t DF_ID_SYS_H_ALL = 2;

@interface TDD_ArtiSystemModel ()
@property (nonatomic,assign)BOOL clickStopScanBtn;//点击了暂停扫描
@property (nonatomic,assign)BOOL clickClearCodeBtn;//点击了清码按钮
@property (nonatomic,assign)BOOL clickStartScanBtn;//点击了一键扫描
@end

@implementation TDD_ArtiSystemModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegSystem::Construct(ArtiSystemConstruct);
    CRegSystem::Destruct(ArtiSystemDestruct);
    CRegSystem::InitTitle(ArtiSystemInitTitle);
    CRegSystem::InitTitleWithType(ArtiSystemInitTitleWithType);
    CRegSystem::AddItem(ArtiSystemAddItem);
    CRegSystem::AddItemWithType(ArtiSystemAddItemWithType);
    CRegSystem::GetScanOrder(ArtiGetScanOrder);
    CRegSystem::GetItem(ArtiSystemGetItem);
    CRegSystem::GetDtcItems(ArtiSystemGetDtcItems);
    CRegSystem::SetHelpButtonVisible(ArtiSystemSetHelpButtonVisible);
    CRegSystem::SetClearButtonVisible(ArtiSystemSetClearButtonVisible);
    CRegSystem::SetItemStatus(ArtiSystemSetItemStatus);
    CRegSystem::SetItemResult(ArtiSystemSetItemResult);
    CRegSystem::SetItemAdas(ArtiSystemSetItemAdas);
    CRegSystem::SetButtonAreaHidden(ArtiSystemSetButtonAreaHidden);
    CRegSystem::SetScanStatus(ArtiSystemSetScanStatus);
    CRegSystem::SetClearStatus(ArtiSystemSetClearStatus);
    CRegSystem::SetAtuoScanEnable(ArtiSystemAtuoScanEnable);
    CRegSystem::Show(ArtiSystemShow);
}

void ArtiSystemConstruct(uint32_t id)
{
    [TDD_ArtiSystemModel Construct:id];
}

void ArtiSystemDestruct(uint32_t id)
{
    [TDD_ArtiSystemModel Destruct:id];
}

bool ArtiSystemInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiSystemModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

bool ArtiSystemInitTitleWithType(uint32_t id, const std::string& strTitle, uint32_t eSysScanType)
{
    return [TDD_ArtiSystemModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle] eSysScanType:eSysScanType];
}

void ArtiSystemAddItem(uint32_t id, const std::string& strItem)
{
    [TDD_ArtiSystemModel AddItemWithId:id strItem:[TDD_CTools CStrToNSString:strItem]];
}

void ArtiSystemAddItemWithType(uint32_t id, const std::string& strItem, uint32_t etype)
{
    [TDD_ArtiSystemModel AddItemWithId:id strItem:[TDD_CTools CStrToNSString:strItem] eSysClassType:etype];
}

std::vector<uint16_t> ArtiGetScanOrder(uint32_t id)
{
    //TODO:暂时返回数组数量 index
    NSArray *arr = [TDD_ArtiSystemModel GetScanOrderWithId:id];
    return [TDD_CTools NSArrayToInt16CVector:arr];
    
}

std::string const ArtiSystemGetItem(uint32_t id, uint16_t uIndex)
{
    NSString * str = [TDD_ArtiSystemModel GetItemWithId:id uIndex:uIndex];
    
    return [TDD_CTools NSStringToCStr:str];
}

std::vector<uint16_t> ArtiSystemGetDtcItems(uint32_t id)
{
    NSArray * arr = [TDD_ArtiSystemModel GetDtcItemsWithId:id];
    
    return [TDD_CTools NSArrayToInt16CVector:arr];
}

void ArtiSystemSetHelpButtonVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiSystemModel SetHelpButtonVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiSystemSetClearButtonVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiSystemModel SetClearButtonVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiSystemSetItemStatus(uint32_t id, uint16_t uIndex, const std::string& strStatus)
{
    [TDD_ArtiSystemModel SetItemStatusWithId:id uIndex:uIndex strStatus:[TDD_CTools CStrToNSString:strStatus]];
}

void ArtiSystemSetItemResult(uint32_t id, uint16_t uIndex, uint32_t uResult)
{
    [TDD_ArtiSystemModel SetItemResultWithId:id uIndex:uIndex uResult:uResult];
}

void ArtiSystemSetItemAdas(uint32_t id, uint16_t uIndex, uint32_t uResult)
{
    [TDD_ArtiSystemModel SetItemAdasWithId:id uIndex:uIndex uAdasResult:uResult];
}

void ArtiSystemSetButtonAreaHidden(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiSystemModel SetButtonAreaHiddenWithId:id bIsHidden:bIsVisible];
}

void ArtiSystemSetScanStatus(uint32_t id, uint32_t uStatus)
{
    [TDD_ArtiSystemModel SetScanStatusWithId:id uStatus:uStatus];
}

void ArtiSystemSetClearStatus(uint32_t id, uint32_t uStatus)
{
    [TDD_ArtiSystemModel SetClearStatusWithId:id uStatus:uStatus];
}

void ArtiSystemAtuoScanEnable(uint32_t id, bool bEnable)
{
    [TDD_ArtiSystemModel SetAtuoScanEnableWithId:id bIsHidden:bEnable];
}

uint32_t ArtiSystemShow(uint32_t id)
{
    return [TDD_ArtiSystemModel ShowWithId:id];
}



/*
    CArtiSystem 按钮包括如下：

    “帮助”
    “诊断报告”
    “一键扫描”/“暂停扫描”/“继续扫描”
    “一键清码”
    “后退”
    “显示全部”/“显示实际”

    按钮规则：
        1、“帮助”按钮，是否可用根据SetHelpButtonVisible接口决定，“帮助”按钮默认不可用

        2、进入CArtiSystem界面，“后退”和“一键扫描”可用，“诊断报告”、“一键清码”不可用

        3、“一键清码”按钮默认显示，状态为不可用，如果SetClearButtonVisible设置“一键清码”不显示
            即使存在故障码，也不显示
          
        4、点击“一键扫描”，“一键扫描”变为“暂停扫描”，其余按钮皆不可用，直至扫描完成或者暂停，
           扫描完成或者暂停由接口SetScanStatus()指定

        5、如果点击了“暂停扫描”，或者SetScanStatus接口指定为暂停，
           “暂停扫描”变成“继续扫描”可用，此时界面状态为暂停，
           “帮助”按钮和“后退”按钮可用，“诊断报告”按钮根据是否有系统，决定是否可用
           如果此时有故障码或者系统未知（DF_ENUM_UNKNOWN），“一键清码”应可用

        6、如果点击了“继续扫描”，“继续扫描”变为“暂停扫描”，其余按钮皆不可用，
           直至扫描完成或者暂停，扫描完成或者暂停由接口SetScanStatus()指定

        7、如果点击了“一键清码”，所有按钮皆不可用，直至清码完成，清码完成由SetClearStatus接口指定

        8、“一键清码”按钮是否可用，由是否存在故障码决定，如果此时正在“一键扫描”中，即使有故障码，按钮也不可用
           如果SetClearButtonVisible设置“一键清码”不显示，即使存在故障码，也不显示此按钮

        9、SetScanStatus()的实参是DF_SYS_SCAN_PAUSE，相当于点击了“暂停扫描”

        10、诊断代码在系统扫描完后，需调用SetScanStatus()，此时系统扫描已完成

        11、诊断代码在一键清码完后，需调用SetClearStatus()，一键清码已完成

        12、如果返回 DF_ID_SYS_START 表示点击了“一键扫描”
            诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_START)通知实现
            一键扫描开始

           如果返回 DF_ID_SYS_STOP  表示点击了“暂停”
           诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_PAUSE)通知实现
            暂停扫描

           如果返回 DF_ID_SYS_ERASE 表示点击了“一键清码”
           诊断程序需立即调用SetClearStatus(DF_SYS_CLEAR_START)通知实现
            一键清码开始
*/

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    /*
    “诊断报告” -- 有故障码就显示或者扫描完成显示   0
    “一键扫描”/“暂停扫描”/“继续扫描”            1
    “一键清码”                               2
    “显示实际”/“显示全部” -- 有不存在项时可点击   3
    “帮助”                                  4
    */
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.scanStatus = -1;
    
    model.clearStatus = -1;
    
    model.isShowActual = NO;
    
    NSArray * titleArr = @[@"diagnosis_help",@"app_report",@"diagnostic_button_scan",@"diagnosis_remove_code",@"diagnosis_show_actual"];
    
    NSArray * statusArr = @[@(ArtiButtonStatus_UNVISIBLE),@(ArtiButtonStatus_UNVISIBLE),@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_DISABLE),@(ArtiButtonStatus_DISABLE)];
    
    NSArray * IDArr = @[@(DF_ID_SYS_HELP),@(DF_ID_SYS_REPORT),@(DF_ID_SYS_START),@(DF_ID_SYS_ERASE),@(DF_ID_SYS_H_ACTUAL)];
    
    NSArray *lockArr = @[@(false),@(false),@(false),@(false),@(false)];

    if ([TDD_DiagnosisTools isLimitedTrialFuction]) {
        if (isTopVCI){
            lockArr = @[@(true),@(true),@(false),@(true)];

        }else {
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
                lockArr = @[@(false),@(false),@(false),@(true),@(false)];
            }else {
                lockArr = @[@(true),@(true),@(false),@(true),@(false)];
            }
        }

    }
    if (isTopVCI) {
        titleArr = @[@"diagnosis_help",@"app_report",@"diagnostic_button_scan",@"diagnosis_remove_code"];
        statusArr = @[@(ArtiButtonStatus_UNVISIBLE),@(isTopVCI ? ArtiButtonStatus_DISABLE : ArtiButtonStatus_UNVISIBLE),@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_DISABLE)];

        IDArr = @[@(DF_ID_SYS_HELP),@(DF_ID_SYS_REPORT),@(DF_ID_SYS_START),@(DF_ID_SYS_ERASE)];
    }
    
    for (int i = 0; i < titleArr.count; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
        buttonModel.uButtonId = [IDArr[i] intValue];
        
        buttonModel.strButtonText = titleArr[i];
        
        buttonModel.uStatus = (ArtiButtonStatus)[statusArr[i] intValue];
        
        buttonModel.bIsEnable = YES;
        
        buttonModel.isLock = [lockArr[MIN(lockArr.count-1, i)] boolValue];
        if ([TDD_DiagnosisTools isDebug]) {
            if ([buttonModel.strButtonText isEqualToString:@"diagnostic_button_scan"]) {
                buttonModel.uiTextIdentify = @"diagSystemScanButton";
            }
        }

        [model.buttonArr addObject:buttonModel];
    }
    
    model.isScanButtonVisible = YES;
    model.isClearButtonVisible = YES;
    model.bIsLock = YES;
    
    model.isReloadButton = YES;
    
    model.selectItem = -1;
}

+ (BOOL)InitTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle eSysScanType:(uint32_t )eType{
    HLog(@"%@ - 初始化菜单显示控件，同时设置标题文本 - ID:%d - 标题 ：%@ - 扫描类型 : %d", [self class], ID, strTitle,eType);
    
    [self Destruct:ID];
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    model.eType = (eSysScanType)eType;
    if ([model.strTitle isEqualToString:strTitle]) {
        return YES;
    }else{
        return NO;
    }
}

/**********************************************************
*    功  能：添加系统项
*    参  数：strItem 系统项名称
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem
{
    HLog(@"%@ - 添加系统项 - ID:%d - strItem:%@", [self class], ID, strItem);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    ArtiSystemItemModel * itemModel = [[ArtiSystemItemModel alloc] init];
    
    itemModel.uIndex = (uint32_t)model.itemArr.count;
    
    itemModel.strItem = strItem;
    
    [model.itemArr addObject:itemModel];
}

/**********************************************************
*    功  能：添加系统项
*    参  数：strItem 系统项名称
            eType 小车探系统扫描的系统类型分类
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strItem:(NSString *)strItem eSysClassType:(uint32_t)eType
{
    HLog(@"%@ - 添加系统项 - ID:%d - strItem:%@", [self class], ID, strItem);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    ArtiSystemItemModel * itemModel = [[ArtiSystemItemModel alloc] init];
    
    itemModel.uIndex = (uint32_t)model.itemArr.count;
    
    itemModel.strItem = strItem;
    
    itemModel.eType = eType;
    
    [model.itemArr addObject:itemModel];
}

/*
 *   注册CArtiSystem的成员函数GetScanOrder的回调函数
 *
 *   std::vector<uint16_t> GetScanOrder(uint32_t id);
 *
 *   id, 对象编号，是哪一个对象调用的成员方法
 *   其他参数见ArtiSystem.h的说明
 *
 *   GetScanOrder 其它参数和返回值说明见 ArtiSystem.h
 */
+ (NSArray *)GetScanOrderWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取系统扫描项排序 - ID:%d", [self class], ID);
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    //DEBUG 返回乱序
    NSMutableArray *oddArr = [[NSMutableArray alloc] init];
    NSMutableArray *evenArr = [[NSMutableArray alloc] init];
    //release 返回顺序
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i < model.itemArr.count; i++) {
        [arr addObject:@(i)];
        if (i % 2 == 0) {
            [oddArr addObject:@(i)];
        }else {
            [evenArr addObject:@(i)];
        }
        
    }
    [oddArr addObjectsFromArray:evenArr];
    //DEBUG
    if ([TDD_DiagnosisManage sharedManage].appScenarios==AS_INTERNAL_USE &&  [TDD_DiagnosisManage sharedManage].isOpenDisorderlyScan) {
        return oddArr;
    }else {
        return arr;
    }
    
}
/**********************************************************
*    功  能：获取指定系统项的文本串
*    参  数：uIndex 指定的系统项
*    返回值：string 指定系统项的文本串
**********************************************************/
+ (NSString *)GetItemWithId:(uint32_t)ID uIndex:(uint32_t)uIndex
{
    HLog(@"%@ - 获取指定系统项的文本串 - ID:%d - uIndex:%d", [self class], ID, uIndex);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return @"";
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uIndex == %u", uIndex];
    
    NSArray *filterArray = [model.itemArr filteredArrayUsingPredicate:predicate];
    
    ArtiSystemItemModel * itemModel;
    
    if (filterArray.count) {
        itemModel = filterArray.firstObject;
    }
    
    return itemModel.strItem;
}

/**********************************************************
*    功  能：获取当前有故障码的系统项
*    参  数：无
*    返回值：有故障码的系统项，
*             即扫描结果为“DF_ENUM_DTCNUM”的系统集合
*
*     例如，当前系统列表中有5个系统，0,2,4系统编号有故障码，
*          则返回的vector大小为3,值分别是0,2,4
**********************************************************/
+ (NSArray *)GetDtcItemsWithId:(uint32_t)ID
{
    HLog(@"%@ - 获取当前有故障码的系统项 - ID:%d", [self class], ID);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];

    return [model GetDtcItems];
}

/**********************************************************
*    功  能：设置帮助按钮是否显示，帮助按钮默认不显示
*    参  数：bIsVisible=true   显示帮助按钮
*            bIsVisible=false 隐藏帮助按钮
*    返回值：无
**********************************************************/
+ (void)SetHelpButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置帮助按钮是否显示 - ID:%d - bIsVisible:%d", [self class], ID, bIsVisible);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.isHelpButtonVisible = bIsVisible;
}


/**********************************************************
*    功  能：强制设置一键清码按钮是否显示，一键清码按钮默认显示
*
*    参  数：bIsVisible=true   显示一键清码
*            bIsVisible=false  隐藏一键清码
*
*    返回值：无
*
*    注 意： 在没有调用此接口下，“一键清码”按钮默认显示
*            显示的条件是存在故障码
*
*            如果SetClearButtonVisible设置为true，是否显示由是
*            否存在故障码决定
*
*            如果SetClearButtonVisible设置为false，将强制不显示
*            即使存在故障码也不显示
*
**********************************************************/
+ (void)SetClearButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置一键清码按钮是否显示 - ID:%d - bIsVisible:%d", [self class], ID, bIsVisible);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.isClearButtonVisible = bIsVisible;
}


/**********************************************************
*    功  能：设置指定系统项的状态
*    参  数：uIndex 指定的系统项
*            strStatus 指定系统项的状态
*            （正在初始化.../正在读码.../正在清码...）
*    返回值：无
**********************************************************/
+ (void)SetItemStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strStatus:(NSString *)strStatus
{
    HLog(@"%@ - 设置指定系统项的状态 - ID:%d - uIndex:%d - strStatus:%@", [self class], ID, uIndex, strStatus);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uIndex == %u", uIndex];
    
    NSArray *filterArray = [model.itemArr filteredArrayUsingPredicate:predicate];
    
    ArtiSystemItemModel * itemModel;
    
    if (filterArray.count) {
        itemModel = filterArray.firstObject;
        
        model.selectItem = itemModel.uIndex;
        
        itemModel.strStatus = strStatus;
    }
}


/**********************************************************
*    功  能：设置指定系统项的扫描结果
*    参  数：uIndex 指定的系统项
*            uResult 指定系统项的最终结果
*            （不存在/有码/无码/未知）
*    返回值：无
**********************************************************/
+ (void)SetItemResultWithId:(uint32_t)ID uIndex:(uint32_t)uIndex uResult:(uint32_t)uResult
{
    HLog(@"%@ - 设置指定系统项的扫描结果 - ID:%d - uIndex:%d - strStatus:%u", [self class], ID, uIndex, uResult);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uIndex == %u", uIndex];
    
    NSArray *filterArray = [model.itemArr filteredArrayUsingPredicate:predicate];
    
    if (model.clearStatus == DF_SYS_CLEAR_START) {
        model.clearStartFinishRowCount += 1;
    }
    
    ArtiSystemItemModel * itemModel;
    
    if (filterArray.count) {
        itemModel = filterArray.firstObject;
        
        model.selectItem = itemModel.uIndex;
        
        //        model.isScrollToSelect = YES;
        
        itemModel.strStatus = @"";
        
        itemModel.uResult = uResult;
        //单进系统
        //如果结果不是不存在，修改清码/报告按钮
        //结果是不存在修改显示按钮
        //扫描中/清码中设置结果不修改按钮
        if (model.scanStatus != DF_SYS_SCAN_START && model.clearStatus != DF_SYS_CLEAR_START) {
            [model updateButtonStatue:YES];
            
        }
        
    }
  
}

/**********************************************************
*    功  能：设置指定系统项的ADAS扫描结果
*
*    参  数：uIndex 指定的系统项
*
*            uResult 指定系统项的ADAS结果
*            （存在ADAS/不存在ADAS）
*
*    返回值：无
**********************************************************/
+ (void)SetItemAdasWithId:(uint32_t)ID uIndex:(uint32_t)uIndex uAdasResult:(uint32_t)uAdasResult
{
    HLog(@"%@ - 设置指定ADAS系统项的扫描结果 - ID:%d - uIndex:%d - strStatus:%u", [self class], ID, uIndex, uAdasResult);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uRowIndex 过界");
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uIndex == %u", uIndex];
    
    NSArray *filterArray = [model.itemArr filteredArrayUsingPredicate:predicate];
    
    if (model.clearStatus == DF_SYS_CLEAR_START) {
        model.clearStartFinishRowCount += 1;
    }
    
    ArtiSystemItemModel * itemModel;
    
    if (filterArray.count) {
        itemModel = filterArray.firstObject;
        
        model.selectItem = itemModel.uIndex;
        
        //        model.isScrollToSelect = YES;
        
        itemModel.uAdasResult = uAdasResult;
        
    }
  
}

/**********************************************************
*    功  能：设置扫描按键是否隐藏，控件默认显示
*    参  数：bIsHidden=true 按钮区隐藏
*            bIsHidden=false 按钮区显示
*    返回值：无
**********************************************************/
+ (void)SetButtonAreaHiddenWithId:(uint32_t)ID bIsHidden:(BOOL)bIsHidden
{
    HLog(@"%@ - 设置扫描按键是否隐藏 - ID:%d - bIsHidden:%d", [self class], ID, bIsHidden);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.isScanButtonVisible = !bIsHidden;
}

/***************************************************************
*    功  能：设置“一键扫描”自动开始是否使能
*
*    参  数：bEnable   false,  第一次Show不返回DF_ID_SYS_START
*                      true,   第一次Show返回DF_ID_SYS_START
*
*    返回值：默认不开启，如果设置了此参数，诊断应用在调用了
*            第一次Show以后将开始系统扫描，即第一次Show的返回
*            值为"DF_ID_SYS_START"
***************************************************************/
+ (void)SetAtuoScanEnableWithId:(uint32_t)ID bIsHidden:(BOOL)bEnable
{
    HLog(@"%@ - 设置“一键扫描”自动开始是否使用 - ID:%d - bEnable:%d", [self class], ID, bEnable);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.isAutoScanEnable = bEnable;
}

/**********************************************************
*    功  能：设置系统扫描状态
*
*    参  数：uStatus
*                DF_SYS_SCAN_PAUSE,   暂停扫描
*                DF_SYS_SCAN_FINISH,  扫描结束
*
*    返回值：无
**********************************************************/
+ (void)SetScanStatusWithId:(uint32_t)ID uStatus:(uint32_t)uStatus
{
    HLog(@"%@ - 设置系统扫描状态 - ID:%d - uStatus:%d", [self class], ID, uStatus);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.scanStatus = uStatus;
    
    if (uStatus == DF_SYS_SCAN_FINISH) {
        model.selectItem = -1;
    }
}

/**********************************************************
*    功  能：设置一键清码状态
*
*    参  数：uStatus
*                DF_SYS_CLEAR_FINISH,   一键清码结束
*               DF_SYS_CLEAR_START,   一键清码开始
*
*    返回值：无
**********************************************************/
+ (void)SetClearStatusWithId:(uint32_t)ID uStatus:(uint32_t)uStatus
{
    HLog(@"%@ - 设置一键清码状态 - ID:%d - uStatus:%d", [self class], ID, uStatus);
    
    TDD_ArtiSystemModel * model = (TDD_ArtiSystemModel *)[self getModelWithID:ID];
    
    model.clearStatus = uStatus;
}

/**********************************************************
*    功  能：显示系统控件
*    参  数：无
*    返回值：uint32_t 组件界面按键返回值
*        按键：一键扫描，一键清码，帮助，诊断报告，返回等
*
*     说明
*        如果返回 DF_ID_SYS_START 表示点击了“一键扫描”
*       诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_START)通知实现
*        一键扫描开始
*
*       如果返回 DF_ID_SYS_STOP  表示点击了“暂停”
*       诊断程序需立即调用SetScanStatus(DF_SYS_SCAN_PAUSE)通知实现
*        暂停扫描
*
*       如果返回 DF_ID_SYS_ERASE 表示点击了“一键清码”
*       诊断程序需立即调用SetClearStatus(DF_SYS_CLEAR_START)通知实现
*        一键清码开始
**********************************************************/


#pragma mark - 是否显示一键清码按钮
- (void)setIsClearButtonVisible:(BOOL)isClearButtonVisible
{
    //显示的条件是存在故障码
    _isClearButtonVisible = isClearButtonVisible;
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr[SystemButtonType_ClearCode];
    
    if (!isClearButtonVisible) {
        buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    }else {
        //有码系统数组
        NSArray * DtcArr = [self GetDtcItems];
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[SystemButtonType_ClearCode];
        if (DtcArr.count > 0) {
            //一键清码按钮 - 显示的条件是存在故障码
            buttonModel.uStatus = ArtiButtonStatus_ENABLE;
        }
    }
    
    self.isReloadButton = YES;
}

#pragma mark - 是否显示帮助按钮
- (void)setIsHelpButtonVisible:(BOOL)isHelpButtonVisible
{
    _isHelpButtonVisible = isHelpButtonVisible;
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr[SystemButtonType_Help];
    
    if (isHelpButtonVisible) {
        buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    }else {
        buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    }
    
    self.isReloadButton = YES;
}

#pragma mark - 是否显示扫描按钮
- (void)setIsScanButtonVisible:(BOOL)isScanButtonVisible
{
    _isScanButtonVisible = isScanButtonVisible;
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr[SystemButtonType_Scan];
    
    if (isScanButtonVisible) {
        buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    }else {
        buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    }
    
    self.isReloadButton = YES;
}

#pragma mark - 设置扫描状态
- (void)setScanStatus:(uint32_t)scanStatus
{
    /**
     #define DF_SYS_SCAN_START                        0  // 开始扫描
     #define DF_SYS_SCAN_PAUSE                        1  // 暂停扫描
     #define DF_SYS_SCAN_FINISH                       2  // 扫描结束
     */
    
    BOOL beforeScanStatusIsPause = (_scanStatus == DF_SYS_SCAN_PAUSE);
    
    _scanStatus = scanStatus;

    if (scanStatus == DF_SYS_SCAN_START) {
        // 开始扫描
        _hadScan = YES;
        _clearStatus = -1;
        //埋点
        if (self.clickStartScanBtn) {
            if (!beforeScanStatusIsPause) {
                NSString *VIN = [TDD_ArtiGlobalModel GetVIN]?:@"";
                NSString *Make = [TDD_ArtiGlobalModel GetVehName]?:@"";
                NSString *Path = TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarInfo;
                NSString *combinedString = [NSString stringWithFormat:@"%@&%@&%@", VIN, Make, Path];
                [TDD_Statistics beginEvent:Event_Enterautoscantime attributes:@{@"Enterautoscantime_information":combinedString}];
                
                for (ArtiSystemItemModel * model in self.itemArr) {
                    model.uResult = 0;
                }
                [TDD_Statistics event:Event_ClickAutoscan attributes:nil];
            } 
            
            self.clickStartScanBtn = NO;
        }
        //数据重新排序
        NSSortDescriptor *indexSD = [NSSortDescriptor sortDescriptorWithKey:@"uIndex" ascending:YES];
        
        self.itemArr = [[self.itemArr sortedArrayUsingDescriptors:@[indexSD]] mutableCopy];
        
        self.isStartScan = YES;
        
        self.bIsLock = NO; //非阻塞
        
        //报告按钮不可点击
        TDD_ArtiButtonModel * reportButtonModel = self.buttonArr[SystemButtonType_Report];

        reportButtonModel.uStatus = ArtiButtonStatus_DISABLE;
        
        //扫描按钮 文字 改为 停止扫描
        TDD_ArtiButtonModel * scanButtonModel = self.buttonArr[SystemButtonType_Scan];
        scanButtonModel.uButtonId = DF_ID_SYS_STOP;
        scanButtonModel.strButtonText = @"download_pause";
        scanButtonModel.uStatus = ArtiButtonStatus_ENABLE;
        
        //一键清码按钮不可点击
        TDD_ArtiButtonModel * clearButtonModel = self.buttonArr[SystemButtonType_ClearCode];
        clearButtonModel.uStatus = ArtiButtonStatus_DISABLE;
        
        if (!isTopVCI) {
            //显示按钮不可点 文字 改为 显示实际
            TDD_ArtiButtonModel * showButtonModel = self.buttonArr[SystemButtonType_Show];
            showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
            
            self.isShowActual = NO;
        }
        
    }else if (scanStatus == DF_SYS_SCAN_PAUSE || scanStatus == DF_SYS_SCAN_FINISH) {
        // 暂停扫描 - 扫描结束
        
        self.bIsLock = YES; //阻塞
        
        if (scanStatus == DF_SYS_SCAN_FINISH) {
            
            [TDD_Statistics endEvent:Event_Enterautoscantime];
            
            //扫码完成后数据排序
            [self sortSystemItemArr];
            ArtiSystemItemModel *model = self.itemArr.firstObject;
            self.selectItem = model.uIndex;
        }else {
            //暂停
            if (self.clickStopScanBtn) {
                [TDD_Statistics event:Event_ClicksystemPause attributes:nil];
                [TDD_Statistics tdRemoveEvent:Event_Enterautoscantime];
                self.clickStopScanBtn = NO;
            }
            
        }
        
        [self updateButtonStatue];
    }
    
    self.isReloadButton = YES;
}

#pragma mark - 设置清码状态
- (void)setClearStatus:(uint32_t)clearStatus
{
    _clearStatus = clearStatus;
    
    if (clearStatus == DF_SYS_CLEAR_START) {
        //一键清码开始
        if (self.clickClearCodeBtn) {
            [TDD_Statistics event:Event_ClicksystemclearDTCs attributes:nil];
            self.clickClearCodeBtn = NO;
        }
        self.clearStartDtcRowCount = [self GetDtcItems].count;
        
        self.isStartClear = YES;
        
        self.bIsLock = NO; //非阻塞
        for (int i = 0; i<self.buttonArr.count; i++) {
            TDD_ArtiButtonModel * buttonModel = self.buttonArr[i];
            if (i == SystemButtonType_Show) {
                self.clearStartShowBtnStatus = buttonModel.uStatus;
            }
            if (buttonModel.uStatus == ArtiButtonStatus_ENABLE) {
                buttonModel.uStatus = ArtiButtonStatus_DISABLE;
            }

        }
    }else {
        self.bIsLock = YES; //阻塞
        
        if (clearStatus == DF_SYS_CLEAR_FINISH) {
            self.clearStartFinishRowCount = 0;
            //清码完成后，数据排序
            [self sortSystemItemArr];
            ArtiSystemItemModel *model = self.itemArr.firstObject;
            self.selectItem = model.uIndex;
        }
        [self updateButtonStatue];
    }
    
    self.isReloadButton = YES;
}

#pragma mark - 更新按钮状态
//APP诊断文档
//单进系统
- (void)updateButtonStatue:(BOOL )clickSystem {
    //扫描按钮
    NSString * scanTitle;
    
    if (self.scanStatus == DF_SYS_SCAN_PAUSE) {
        //扫描暂停
        //扫描按钮 文字 改为 继续扫描
        scanTitle = @"system_continue_scan";
        
    }else if (self.scanStatus == DF_SYS_SCAN_FINISH || self.scanStatus == -1) {
        //扫描结束
        //扫描按钮 文字 改为 扫描
        scanTitle = @"diagnostic_button_scan";
        
    }else {
        //扫描开始
        //扫描按钮 文字 改为 暂停扫描
        scanTitle = @"download_pause";
        
    }
    
    if (self.buttonArr.count == 0) {
        //此时在初始化
        HLog(@"此时在初始化");
        return;
    }
        
    //有码系统数组
    NSArray * DtcArr = [self GetDtcItems];
    //未知系统数字
    NSArray * unKnowArr = [self GetUnknowItems];
    
    //扫描按钮
    if (self.isScanButtonVisible && self.buttonArr.count > 2) {
        TDD_ArtiButtonModel * STOPButtonModel = self.buttonArr[SystemButtonType_Scan];
        STOPButtonModel.uButtonId = DF_ID_SYS_START;
        STOPButtonModel.strButtonText = scanTitle;
        STOPButtonModel.uStatus = ArtiButtonStatus_ENABLE;
    }
    
    //一键清码
    if (self.isClearButtonVisible && self.buttonArr.count > 3) {
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[SystemButtonType_ClearCode];
        if (DtcArr.count > 0 || unKnowArr.count > 0) {
            //一键清码按钮 - 显示的条件是存在故障码 或者 存在未知
            buttonModel.uStatus = ArtiButtonStatus_ENABLE;
        }else {
            buttonModel.uStatus = ArtiButtonStatus_DISABLE;
        }
    }
    
    //报告按钮
    BOOL isShowReport = NO; //是否显示报告按钮
    //扫描完成或者清码完成或者扫码暂停，系统有结果且结果不为不存在则显示报告按钮
    if (self.scanStatus == DF_SYS_SCAN_FINISH || self.scanStatus == DF_SYS_SCAN_PAUSE || self.clearStatus == DF_SYS_CLEAR_FINISH) {
        for (ArtiSystemItemModel * model in self.itemArr) {
            if (model.uResult != 0 && model.uResult != DF_ENUM_NOTEXIST) {
                //有结果且结果不为不存在则显示
                isShowReport = YES;
                break;
            }
        }
    }
    if (self.buttonArr.count > 2) {
        TDD_ArtiButtonModel * buttonModel = self.buttonArr[SystemButtonType_Report];
        
        if (isShowReport) {
            buttonModel.uStatus = ArtiButtonStatus_ENABLE;
            if ([TDD_DiagnosisTools isDebug]) {
                buttonModel.uiTextIdentify = @"diagSystemReportButton";
            }
        }else {
            if (self.scanStatus == -1) {
                buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
            }else {
                buttonModel.uStatus = ArtiButtonStatus_DISABLE;
            }
            
        }
    }

    //显示按钮
    [self updateShowButtonStatue:clickSystem];
    
    self.isReloadButton = YES;
}

- (void)updateButtonStatue
{
    [self updateButtonStatue:NO];
}

- (void)updateShowButtonStatue:(BOOL )clickSystem {
    if (clickSystem && self.scanStatus ==-1) {
        return;
    }
    //显示按钮
    if (!isTopVCI && self.buttonArr.count > 4) {
        TDD_ArtiButtonModel * showButtonModel = self.buttonArr[SystemButtonType_Show];
        //不存在系统数组
        NSArray * NoDataArr = [self GetNoDataItems];
        if (clickSystem) {
            //单进系统
            if (self.isShowActual == YES) {
                //按钮为显示全部
                if (self.itemArr.count == NoDataArr.count) {
                    //所有系统不存在
                    self.isShowActual = NO;
                    showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
                }else {
                    if (NoDataArr.count > 0) {
                        showButtonModel.uStatus = ArtiButtonStatus_ENABLE;
                    }else {
                        showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
                    }
                }
            }else {
                //按钮为显示实际
                if (self.itemArr.count != NoDataArr.count) {
                    showButtonModel.uStatus = ArtiButtonStatus_ENABLE;
                }else {
                    showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
                }
            }
            return;
        }
        
        //清码完成
        if (self.isStartClear && self.clearStatus == DF_SYS_CLEAR_FINISH) {
            showButtonModel.uStatus = self.clearStartShowBtnStatus;
            return;
        }
        
        //开始清码
        if (self.clearStatus == DF_SYS_CLEAR_START) {
            showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
            return;
        }
        
        //暂停扫描
        if (self.scanStatus == DF_SYS_SCAN_PAUSE) {
            //所有系统都存在
            if (NoDataArr.count == 0) {
                self.isShowActual = NO;
                showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
            }else {
                self.isShowActual = NO;
                showButtonModel.uStatus = ArtiButtonStatus_ENABLE;
            }
            return;
        }
        
        //所有系统不存在
        if (self.itemArr.count == NoDataArr.count) {
            self.isShowActual = NO;
            showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
        }else {
            //有系统存在
            self.isShowActual = YES;
            if (NoDataArr.count > 0) {
                //显示按钮 改为 可点
                showButtonModel.uStatus = ArtiButtonStatus_ENABLE;
            }else {
                showButtonModel.uStatus = ArtiButtonStatus_DISABLE;
            }
        }

    }
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID
{
    
    if (buttonID == 1 || buttonID == 2) {
        if (buttonID == 1) {
            //点击了显示实际
            self.isShowActual = YES;
            [self sortSystemItemArr];
        }else {
            //点击了显示全部
            self.isShowActual = NO;
            //数据重新排序
            NSSortDescriptor *indexSD = [NSSortDescriptor sortDescriptorWithKey:@"uIndex" ascending:YES];
            
            self.itemArr = [[self.itemArr sortedArrayUsingDescriptors:@[indexSD]] mutableCopy];
        }
        
        //self.isDisplayRefresh = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KTDDNotificationArtiShow object:self userInfo:nil];
        
        return NO;
    }
    
    if (buttonID == DF_ID_SYS_START) {
        //点击扫描
        if (self.scanStatus == DF_SYS_SCAN_PAUSE || self.scanStatus == DF_SYS_SCAN_FINISH || self.scanStatus == -1) {
            self.clickStartScanBtn = YES;
        }else {
            self.clickStopScanBtn = YES;
        }
        
    }
    
    if (buttonID == DF_ID_SYS_STOP) {
        //点击暂停
        if (self.scanStatus == DF_SYS_SCAN_PAUSE || self.scanStatus == DF_SYS_SCAN_FINISH) {
            self.clickStartScanBtn = YES;
        }else {
            self.clickStopScanBtn = YES;
        }
    }
    
    //软件过期前往购买
    if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
        if ([TDD_DiagnosisTools isLimitedTrialFuction] && buttonID == DF_ID_SYS_ERASE) {
            [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
            return NO;
        }
    }else {
        if ([TDD_DiagnosisTools isLimitedTrialFuction] && buttonID != DF_ID_SYS_STOP && buttonID != DF_ID_SYS_START) {
            [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
            return NO;
        }
    }

    
    if (buttonID == DF_ID_SYS_ERASE) {
        // 清码
        self.clickClearCodeBtn = YES;
    }
    
    if (buttonID == DF_ID_HELP){
        //帮助
        [TDD_Statistics event:Event_Clicksystemhelp attributes:nil];
    }
    if (buttonID == DF_ID_REPORT){
        //报告
        [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":@"Autoscan"}];
    }
    return YES;
}

- (void)setIsShowActual:(BOOL)isShowActual
{
    _isShowActual = isShowActual;
    
    uint32_t uButtonId = DF_ID_SYS_H_ACTUAL;
    NSString * title = @"diagnosis_show_actual";
    
    if (isShowActual) {
        uButtonId = DF_ID_SYS_H_ALL;
        title = @"diagnosis_show_all";
    }
    
    if (self.buttonArr.count > 4) {
        TDD_ArtiButtonModel * showButtonModel = self.buttonArr[SystemButtonType_Show];
        showButtonModel.uButtonId = uButtonId;
        showButtonModel.strButtonText = title;
    }
    
    self.isReloadButton = YES;
}

#pragma mark - 获取有码数据
- (NSArray *)GetDtcItems
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uResult >= %u", DF_ENUM_DTCNUM];
    
    NSArray *filterArray = [self.itemArr filteredArrayUsingPredicate:predicate];
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    
    for (ArtiSystemItemModel * itemModel in filterArray) {
        [resultArr addObject:@(itemModel.uIndex)];
    }
    
    return resultArr;
}

#pragma mark - 获取未知的数据
- (NSArray *)GetUnknowItems
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uResult = %u", DF_ENUM_UNKNOWN];
    
    NSArray *filterArray = [self.itemArr filteredArrayUsingPredicate:predicate];
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    
    for (ArtiSystemItemModel * itemModel in filterArray) {
        [resultArr addObject:itemModel];
    }
    
    return resultArr;
    
    
}

#pragma mark - 获取不存在数据
- (NSArray *)GetNoDataItems
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uResult = %u", DF_ENUM_NOTEXIST];
    
    NSArray *filterArray = [self.itemArr filteredArrayUsingPredicate:predicate];
    
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    
    for (ArtiSystemItemModel * itemModel in filterArray) {
        [resultArr addObject:itemModel];
    }
    
    return resultArr;
}

#pragma mark - 数据排序
- (void)sortSystemItemArr {
    
    //系统扫描/清码完成后有故障码的系统前置显示
    NSMutableArray * DTCArr = [[NSMutableArray alloc] init];
    for (ArtiSystemItemModel * model in self.itemArr) {
        if (model.uResult >= DF_ENUM_DTCNUM) {
            [DTCArr addObject:model];
        }
    }
    [self.itemArr removeObjectsInArray:DTCArr];
    [DTCArr addObjectsFromArray:self.itemArr];
    self.itemArr = DTCArr;
    
    //系统扫描/清码完成后不存在的系统后置显示
    NSMutableArray * noSaveArr = [[NSMutableArray alloc] init];
    for (ArtiSystemItemModel * model in self.itemArr) {
        if (model.uResult == DF_ENUM_NOTEXIST) {
            [noSaveArr addObject:model];
        }
    }
    [self.itemArr removeObjectsInArray:noSaveArr];
    [self.itemArr addObjectsFromArray:noSaveArr];
}

- (void)backClick
{
    //系统 - 正在扫码 - 正在清码
    if (self.scanStatus == DF_SYS_SCAN_START) {
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            [TDD_HTipManage showBottomTipViewWithTitle:@"system_readdtcing"];
        }else {
            [TDD_HTipManage showBottomTipViewWithTitle:@"diagnosis_reading_code"];
        }
        
        return;
    }else if (self.clearStatus == DF_SYS_CLEAR_START) {
        [TDD_HTipManage showBottomTipViewWithTitle:@"diagnosis_clearing_code"];
        return;
    }
    [TDD_HTipManage showBtnTipViewWithTitle:TDDLocalized.diagnosis_back_tip buttonType:HTipBtnTwoType block:^(NSInteger btnTag) {
        if (btnTag == 1) {
            [super backClick];
        }
    }];
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (ArtiSystemItemModel * model in self.itemArr) {
            if (model.strItem.length > 0 && !model.isStrItemTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strItem];
            }
//            if (model.strStatus.length > 0 && !model.isStrStatusTranslated) {
//                [self.translatedDic setValue:@"" forKey:model.strStatus];
//            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (ArtiSystemItemModel * model in self.itemArr) {
        if ([self.translatedDic.allKeys containsObject:model.strItem]) {
            if ([self.translatedDic[model.strItem] length] > 0) {
                model.strTranslatedItem = self.translatedDic[model.strItem];
                model.isStrItemTranslated = YES;
            }
        }
//        if ([self.translatedDic.allKeys containsObject:model.strStatus]) {
//            if ([self.translatedDic[model.strStatus] length] > 0) {
//                model.strTranslatedStatus = self.translatedDic[model.strStatus];
//                model.isStrStatusTranslated = YES;
//            }
//        }
    }
    
    [super translationCompleted];
}

- (NSMutableArray<ArtiSystemItemModel *> *)itemArr
{
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

#warning 改为全程非阻塞
- (BOOL)bIsLock
{
    return NO;
}

@end

@implementation ArtiSystemItemModel

- (void)setStrItem:(NSString *)strItem
{
    if ([_strItem isEqualToString:strItem]) {
        return;
    }
    
    _strItem = strItem;
    
    self.strTranslatedItem = _strItem;
    
    self.isStrItemTranslated = NO;
}

- (void)setStrStatus:(NSString *)strStatus
{
    if ([_strStatus isEqualToString:strStatus]) {
        return;
    }
    
    _strStatus = strStatus;
    
    self.strTranslatedStatus = _strStatus;
    
    self.isStrStatusTranslated = NO;
}

@end
