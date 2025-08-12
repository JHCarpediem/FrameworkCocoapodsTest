//
//  TDD_ArtiTroubleModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/9.
//

#import "TDD_ArtiTroubleModel.h"

#if useCarsFramework
#import <CarsFramework/RegTrouble.hpp>
#else
#import "RegTrouble.hpp"
#endif

#import "TDD_CTools.h"
#import "TDD_DiagnosisViewController.h"

typedef enum {
    ///报告按钮
    TroubleButtonType_Report = 0,
    ///报告按钮
    TroubleButtonType_Clear
   
}TroubleButtonType;

@implementation TDD_ArtiTroubleModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegTrouble::Construct(ArtiTroubleConstruct);
    CRegTrouble::Destruct(ArtiTroubleDestruct);
    CRegTrouble::InitTitle(ArtiTroubleInitTitle);
    CRegTrouble::AddItem(ArtiTroubleAddItem);
    //TODO: 新增Ex
    CRegTrouble::AddItemEx(ArtiTroubleAddItemEx);
    
    CRegTrouble::SetItemHelp(ArtiTroubleSetItemHelp);
    CRegTrouble::SetMILStatus(ArtiTroubleSetMILStatus);
    CRegTrouble::SetFreezeStatus(ArtiTroubleSetFreezeStatus);
    CRegTrouble::SetCdtcButtonVisible(ArtiTroubleSetCdtcButtonVisible);
    CRegTrouble::SetRepairManualInfo(ArtiTroubleSetRepairManualInfo);
    CRegTrouble::Show(ArtiTroubleShow);
}

void ArtiTroubleConstruct(uint32_t id)
{
    [TDD_ArtiTroubleModel Construct:id];
}

void ArtiTroubleDestruct(uint32_t id)
{
    [TDD_ArtiTroubleModel Destruct:id];
}

bool ArtiTroubleInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiTroubleModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

void ArtiTroubleAddItem(uint32_t id, const std::string& strTroubleCode, const std::string& strTroubleDesc, const std::string& strTroubleStatus, const std::string& strTroubleHelp)
{
    [TDD_ArtiTroubleModel AddItemWithId:id strTroubleCode:[TDD_CTools CStrToNSString:strTroubleCode] strTroubleDesc:[TDD_CTools CStrToNSString:strTroubleDesc] strTroubleStatus:[TDD_CTools CStrToNSString:strTroubleStatus] strTroubleHelp:[TDD_CTools CStrToNSString:strTroubleHelp]];
}

void ArtiTroubleAddItemEx(uint32_t id, const stDtcNodeEx& note, const std::string& stTroubleHelp)
{
    [TDD_ArtiTroubleModel AddItemWith:id stDtsNoteEx:note strTroubleHelp:[TDD_CTools CStrToNSString:stTroubleHelp]];
}



void ArtiTroubleSetItemHelp(uint32_t id, uint8_t uIndex, const std::string& strToubleHelp)
{
    [TDD_ArtiTroubleModel SetItemHelpWithId:id uIndex:uIndex strToubleHelp:[TDD_CTools CStrToNSString:strToubleHelp]];
}

void ArtiTroubleSetMILStatus(uint32_t id, uint16_t uIndex, bool bIsShow)
{
    [TDD_ArtiTroubleModel SetMILStatusWithId:id uIndex:uIndex bIsShow:bIsShow];
}

void ArtiTroubleSetFreezeStatus(uint32_t id, uint16_t uIndex, bool bIsShow)
{
    [TDD_ArtiTroubleModel SetFreezeStatusWithId:id uIndex:uIndex bIsShow:bIsShow];
}

void ArtiTroubleSetCdtcButtonVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiTroubleModel SetCdtcButtonVisibleWithId:id bIsShow:bIsVisible];
}

bool ArtiTroubleSetRepairManualInfo(uint32_t id, const std::vector<stRepairInfoItem>& vctDtcInfo)
{
    return [TDD_ArtiTroubleModel SetRepairManualInfoWithId:id vctDtcInfo:vctDtcInfo];
}

uint32_t ArtiTroubleShow(uint32_t id)
{
    return [TDD_ArtiTroubleModel ShowWithId:id];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    NSArray * titleArr = @[@"app_report",@"diagnosis_remove_code"];
    
    NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_UNVISIBLE)];
    
    NSArray * IDArr = @[@(DF_ID_TROUBLE_REPORT),@(DF_ID_CLEAR_DTC)];
    
    for (int i = 0; i < titleArr.count; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
        buttonModel.uButtonId = [IDArr[i] intValue];
        
        buttonModel.strButtonText = titleArr[i];
        
        buttonModel.uStatus = (ArtiButtonStatus)[statusArr[i] intValue];
        
        buttonModel.bIsEnable = YES;
        
        if ([TDD_DiagnosisTools isLimitedTrialFuction]) {
            if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
                if (i == 1){
                    buttonModel.isLock = YES;
                }
                
            }else{
                buttonModel.isLock = YES;
            }
            
        }
        
        [model.buttonArr addObject:buttonModel];
    }
}

/**********************************************************
*    功  能：添加故障码
*    参  数：strTroubleCode 故障码号
*            strTroubleDesc 故障码描述
*            strTroubleState 故障码状态
*    返回值：无
**********************************************************/
+ (void)AddItemWithId:(uint32_t)ID strTroubleCode:(NSString *)strTroubleCode strTroubleDesc:(NSString *)strTroubleDesc strTroubleStatus:(NSString *)strTroubleStatus strTroubleHelp:(NSString *)strTroubleHelp
{
    HLog(@"%@ - 添加故障码 - ID:%d - strTroubleCode ：%@ - strTroubleDesc ：%@ - strTroubleStatus ：%@ - strTroubleHelp ：%@", [self class], ID, strTroubleCode, strTroubleDesc, strTroubleStatus, strTroubleHelp);
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    TDD_ArtiTroubleItemModel * itemModel = [[TDD_ArtiTroubleItemModel alloc] init];
    
    itemModel.strTroubleCode = strTroubleCode;
    
    itemModel.strTroubleDesc = strTroubleDesc;
    
    itemModel.strTroubleStatus = strTroubleStatus;
    
    itemModel.strTroubleHelp = strTroubleHelp;
    
    if (strTroubleHelp.length > 0) {
        itemModel.isShowHelpButton = YES;
    }
    
    [model.itemArr addObject:itemModel];
}

+ (void)AddItemWith:(uint32_t)ID stDtsNoteEx:(stDtcNodeEx)node strTroubleHelp:(NSString *)strTroubleHelp
{
    HLog(@"%@ - 添加故障码 - ID:%d - strTroubleCode ：%@ - strTroubleDesc ：%@ - strTroubleStatus ：%@ - strTroubleHelp ：%@", [self class], ID, [TDD_CTools CStrToNSString:node.strCode], [TDD_CTools CStrToNSString:node.strDescription], [TDD_CTools CStrToNSString:node.strStatus], strTroubleHelp);
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    TDD_ArtiTroubleItemModel *itemModel = [[TDD_ArtiTroubleItemModel alloc] init];
    itemModel.strTroubleCode = [TDD_CTools CStrToNSString: node.strCode];
    itemModel.strTroubleDesc = [TDD_CTools CStrToNSString: node.strDescription];
    itemModel.strTroubleStatus = [TDD_CTools CStrToNSString: node. strStatus];
    itemModel.uStatus = node.uStatus;
    itemModel.strTroubleHelp = strTroubleHelp;
    
    if (strTroubleHelp.length > 0) {
        itemModel.isShowHelpButton = YES;
    }
    
    [model.itemArr addObject:itemModel];
}

/**********************************************************
*    功  能：设置指定故障码的帮助信息
*    参  数：uIndex 指定的故障码
*            strToubleHelp 故障码帮助信息
*    返回值：无
**********************************************************/
+ (void)SetItemHelpWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strToubleHelp:(NSString *)strToubleHelp
{
    HLog(@"%@ - 设置指定故障码的帮助信息 - ID:%d - uIndex ：%d - strTroubleHelp ：%@", [self class], ID, uIndex, strToubleHelp);
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界, uIndex:%d, itemArr.count:%lu", uIndex, (unsigned long)model.itemArr.count);
        return;
    }
    
    TDD_ArtiTroubleItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.strTroubleHelp = strToubleHelp;
    
    itemModel.isShowHelpButton = YES;
}

/**********************************************************
*    功  能：设置指定故障码后边故障灯的状态
*    参  数：uIndex 指定的故障码
*            bIsShow=true 显示一个点亮的故障灯
*            bIsShow=false 不显示故障灯
*    返回值：无
**********************************************************/
+ (void)SetMILStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex bIsShow:(BOOL)bIsShow
{
    HLog(@"%@ - 设置指定故障码后边故障灯的状态 - ID:%d - uIndex ：%d - bIsShow ：%d", [self class], ID, uIndex, bIsShow);
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界, uIndex:%d, itemArr.count:%lu", uIndex, (unsigned long)model.itemArr.count);
        return;
    }
    
    TDD_ArtiTroubleItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.isShowMILStatus = bIsShow;
}

/**********************************************************
*    功  能：设置指定故障码后边冻结帧标志的状态
*    参  数：uIndex 指定的故障码
*            bIsShow=true 显示冻结帧标志
*            bIsShow=false 不显示冻结帧标志
*    返回值：无
**********************************************************/
+ (void)SetFreezeStatusWithId:(uint32_t)ID uIndex:(uint32_t)uIndex bIsShow:(BOOL)bIsShow
{
    HLog(@"%@ - 设置指定故障码后边冻结帧标志的状态 - ID:%d - uIndex ：%d - bIsShow ：%d", [self class], ID, uIndex, bIsShow);
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    if (uIndex >= model.itemArr.count) {
        HLog(@"uIndex 过界, uIndex:%d, itemArr.count:%lu", uIndex, (unsigned long)model.itemArr.count);
        return;
    }
    
    TDD_ArtiTroubleItemModel * itemModel = model.itemArr[uIndex];
    
    itemModel.isShowFreezeStatus = bIsShow;
}

/**********************************************************
*    功  能：设置清码按钮是否显示
*    参  数：bIsVisible=true  显示清码按钮
*            bIsVisible=false 隐藏清码按钮
*    返回值：无
**********************************************************/
+ (void)SetCdtcButtonVisibleWithId:(uint32_t)ID bIsShow:(BOOL)bIsShow
{
    HLog(@"%@ - 设置清码按钮是否显示 - ID:%d - bIsShow ：%d", [self class], ID, bIsShow);
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    TDD_ArtiButtonModel * buttonModel = model.buttonArr[TroubleButtonType_Clear];
    
    if (bIsShow) {
        buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    }else{
        buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    }
    
    model.isReloadButton = YES;
}

/*********************************************************************************
*    功  能：设置维修指南所需要的信息
*
*    参  数：vctDtcInfo    维修资料所需信息数组
*
*             stRepairInfoItem类型的元素
*             eRepairInfoType eType            维修资料所需信息的类型
*                                            例如 RIT_DTC_CODE，表示是 "故障码编码"
*            std::string     strValue        实际的字符串值
*                                           例如当 eType = RIT_VIN时
*                                           strValue为 "KMHSH81DX9U478798"
*
*    返回值：设置失败
*            例如当数组元素为空时，返回false
*            例如当数组中不包含"故障码编码"，返回false
*********************************************************************************/
+ (BOOL)SetRepairManualInfoWithId:(uint32_t)ID vctDtcInfo:(const std::vector<stRepairInfoItem>)vctDtcInfo
{
    TDD_ArtiTroubleRepairInfoModle * infoModel = [[TDD_ArtiTroubleRepairInfoModle alloc] init];
    for (int i = 0; i < vctDtcInfo.size(); i ++) {
        if (vctDtcInfo[i].eType == 0) {
            infoModel.RIT_DTC_CODE = [TDD_CTools CStrToNSString:vctDtcInfo[i].strValue];
        }
        
        if (vctDtcInfo[i].eType == 1) {
            
            if (![NSString tdd_isEmpty:infoModel.RIT_VEHICLE_BRAND]) {
                infoModel.RIT_VEHICLE_BRAND = [TDD_CTools CStrToNSString:vctDtcInfo[i].strValue];
                TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand = infoModel.RIT_VEHICLE_BRAND;
            }else {
                infoModel.RIT_VEHICLE_BRAND = TDD_ArtiGlobalModel.sharedArtiGlobalModel.carBrand?:@"";
            }
        }
        
        if (vctDtcInfo[i].eType == 2) {
            if (![NSString tdd_isEmpty:infoModel.RIT_VEHICLE_MODEL]) {
                TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel = infoModel.RIT_VEHICLE_MODEL;
                infoModel.RIT_VEHICLE_MODEL = [TDD_CTools CStrToNSString:vctDtcInfo[i].strValue];
            }else {
                infoModel.RIT_VEHICLE_MODEL = TDD_ArtiGlobalModel.sharedArtiGlobalModel.carModel?:@"";
            }
        }
        
        if (vctDtcInfo[i].eType == 3) {
            if (![NSString tdd_isEmpty:infoModel.RIT_VEHICLE_YEAR]) {
                TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear = infoModel.RIT_VEHICLE_YEAR;
                infoModel.RIT_VEHICLE_YEAR = [TDD_CTools CStrToNSString:vctDtcInfo[i].strValue];
            }else {
                infoModel.RIT_VEHICLE_YEAR = TDD_ArtiGlobalModel.sharedArtiGlobalModel.carYear?:@"";
            }
        }
        
        if (vctDtcInfo[i].eType == 4) {
            infoModel.RIT_VIN = [TDD_CTools CStrToNSString:vctDtcInfo[i].strValue];
            if (![NSString tdd_isEmpty:infoModel.RIT_VIN]) {
                TDD_ArtiGlobalModel.sharedArtiGlobalModel.CarVIN = infoModel.RIT_VIN;
            }
        }
        
        if (vctDtcInfo[i].eType == 5) {
            infoModel.RIT_SYSTEM_NAME = [TDD_CTools CStrToNSString:vctDtcInfo[i].strValue];
        }
    }
    
    HLog(@"%@ - 设置维修指南所需要的信息 - ID:%d - vctDtcInfo ：%@", [self class], ID, infoModel);
    
    TDD_ArtiTroubleModel * model = (TDD_ArtiTroubleModel *)[self getModelWithID:ID];
    
    if (model.repairInfoIndex >= model.itemArr.count) {
        HLog(@"repairInfoIndex 过界, repairInfoIndex:%d, itemArr.count:%lu", model.repairInfoIndex, (unsigned long)model.itemArr.count);
    }else {
        TDD_ArtiTroubleItemModel * itemModel = model.itemArr[model.repairInfoIndex];
        infoModel.RIT_TROUBLE_DESC = itemModel.strTroubleDesc;
    }
    
    model.repairInfoModle = infoModel;
    
    if ([model.delegate respondsToSelector:@selector(ArtiTroubleSetRepairManualInfo:)]) {
        [model.delegate ArtiTroubleSetRepairManualInfo:infoModel];
    }
    
    return YES;
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (TDD_ArtiTroubleItemModel * model in self.itemArr) {
            if (model.strTroubleDesc.length > 0 && !model.isStrTroubleDescTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strTroubleDesc];
            }
            if (model.strTroubleStatus.length > 0 && !model.isStrTroubleStatusTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strTroubleStatus];
            }
            if (model.strTroubleHelp.length > 0 && !model.isStrTroubleHelpTranslated) {
                [self.translatedDic setValue:@"" forKey:model.strTroubleHelp];
            }
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    for (TDD_ArtiTroubleItemModel * model in self.itemArr) {
        if ([self.translatedDic.allKeys containsObject:model.strTroubleDesc]) {
            if ([self.translatedDic[model.strTroubleDesc] length] > 0) {
                model.strTranslatedTroubleDesc = self.translatedDic[model.strTroubleDesc];
                model.isStrTroubleDescTranslated = YES;
            }
        }
        if ([self.translatedDic.allKeys containsObject:model.strTroubleStatus]) {
            if ([self.translatedDic[model.strTroubleStatus] length] > 0) {
                model.strTranslatedTroubleStatus = self.translatedDic[model.strTroubleStatus];
                model.isStrTroubleStatusTranslated = YES;
            }
        }
        if ([self.translatedDic.allKeys containsObject:model.strTroubleHelp]) {
            if ([self.translatedDic[model.strTroubleHelp] length] > 0) {
                model.strTranslatedTroubleHelp = self.translatedDic[model.strTroubleHelp];
                model.isStrTroubleHelpTranslated = YES;
            }
        }
    }
    
    [super translationCompleted];
}

- (BOOL)ArtiButtonClick:(uint32_t)buttonID {
    //软件过期前往购买
    if ([TDD_DiagnosisTools isLimitedTrialFuction]) {
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            if (buttonID == DF_ID_CLEAR_DTC){
                [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
                return NO;
            }
        }else {
            [TDD_DiagnosisTools showSoftExpiredToBuyAlert:nil];
            return NO;
        }

    }
    if (buttonID == DF_ID_REPORT){
        //报告
        if ([TDD_DiagnosisTools softWareIsCarPalSeries]) {
            NSString *referrer = @"EngineInspection";
            if ([[UIViewController tdd_topViewController] isKindOfClass:[TDD_DiagnosisViewController class]]) {
                referrer = @"AutoScan";
            }
            [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":referrer}];
        }else {
            [TDD_Statistics event:Event_ClickReport attributes:@{@"Reportreferrer":@"ReadCode"}];
        }

        
    }
    return YES;
}

- (NSMutableArray<TDD_ArtiTroubleItemModel *> *)itemArr
{
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    
    return _itemArr;
}
@end

@implementation TDD_ArtiTroubleItemModel

- (void)setStrTroubleDesc:(NSString *)strTroubleDesc
{
    if ([_strTroubleDesc isEqualToString:strTroubleDesc]) {
        return;
    }
    
    _strTroubleDesc = strTroubleDesc;
    
    self.strTranslatedTroubleDesc = _strTroubleDesc;
    
    self.isStrTroubleDescTranslated = NO;
}

- (void)setStrTroubleStatus:(NSString *)strTroubleStatus
{
    if ([_strTroubleStatus isEqualToString:strTroubleStatus]) {
        return;
    }
    
    _strTroubleStatus = strTroubleStatus;
    
    self.strTranslatedTroubleStatus = _strTroubleStatus;
    
    self.isStrTroubleStatusTranslated = NO;
}

- (void)setStrTroubleHelp:(NSString *)strTroubleHelp
{
    if ([_strTroubleHelp isEqualToString:strTroubleHelp]) {
        return;
    }
    
    _strTroubleHelp = strTroubleHelp;
    
    self.strTranslatedTroubleHelp = _strTroubleHelp;
    
    self.isStrTroubleHelpTranslated = NO;
}

@end

