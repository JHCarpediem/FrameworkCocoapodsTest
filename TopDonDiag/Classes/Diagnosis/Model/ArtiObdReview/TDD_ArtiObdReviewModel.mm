//
//  TDD_ArtiObdReviewModel.m
//  TopDonDiag
//
//  Created by fench on 2023/9/5.
//

#import "TDD_ArtiObdReviewModel.h"
#if useCarsFramework
#import <CarsFramework/RegObdReview.hpp>
#import <CarsFramework/HStdOtherMaco.h>
#else
#import "RegObdReview.hpp"
#import "HStdOtherMaco.h"
#endif

#import "TDD_CTools.h"
#import "TDD_ArtiTroubleModel.h"
#import "TDD_ArtiLiveDataModel.h"

@interface TDD_ArtiObdReviewModel ()

@property (nonatomic, assign) NSInteger readinessIndex;

@property (nonatomic, assign) NSInteger iuprIndex;

@property (nonatomic, assign) NSInteger liveDataIndex;

@end

@implementation TDD_ArtiObdReviewModel

+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);
    
    CRegObdReview::Construct(ArtiObdReviewConstruct);
    CRegObdReview::Destruct(ArtiObdReviewDestruct);
    CRegObdReview::InitTitle(ArtiObdReviewInitTitle);
    CRegObdReview::SetProtocol(ArtiObdReviewSetProtocol);
    CRegObdReview::SetReportResult(ArtiObdReviewSetReportResult);
    CRegObdReview::SetReCheckResult(ArtiObdReviewSetReCheckResult);
    CRegObdReview::SetNeedReCheck(ArtiObdReviewSetNeedReCheck);
    CRegObdReview::SetMILStatus(ArtiObdReviewSetMILStatus);
    CRegObdReview::SetObdStatus(ArtiObdReviewSetObdStatus);
    CRegObdReview::SetMILOnMileage(ArtiObdReviewSetMILOnMileage);
    CRegObdReview::AddReadinessStatusItems(ArtiObdReviewAddReadinessStatusItems);
    CRegObdReview::AddEcuInfoItems(ArtiObdReviewAddEcuInfoItems);
    CRegObdReview::AddDtcItem(ArtiObdReviewAddDtcItem);
    CRegObdReview::AddDtcItems(ArtiObdReviewAddDtcItems);
    CRegObdReview::AddLiveDataItem(ArtiObdReviewAddLiveDataItem);
    CRegObdReview::AddLiveDataItems(ArtiObdReviewAddLiveDataItems);
    CRegObdReview::AddIUPRStatusItem(ArtiObdReviewAddIUPRStatusItem);
    CRegObdReview::SetEngineInfo(ArtiObdReviewSetEngineInfo);
    CRegObdReview::Show(ArtiObdReviewShow);
    
    // 新增类型
    CRegObdReview::AddReadinessMainType(ArtiObdViewAddReadinessMainType);
    CRegObdReview::AddLiveDataMainType(ArtiObdViewAddLiveDataMainType);
    CRegObdReview::AddIUPRMainType(ArtiObdViewAddIUPRMainType);
}

//MARK: - c++ Method
void ArtiObdReviewConstruct(uint32_t ID)
{
    [TDD_ArtiObdReviewModel Construct:ID];
}

void ArtiObdReviewDestruct(uint32_t ID)
{
    [TDD_ArtiObdReviewModel Destruct:ID];
}

bool ArtiObdReviewInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiObdReviewModel initTitle:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

bool ArtiObdReviewSetProtocol(uint32_t id, bool bCommOK, const std::string& strProtocol)
{
    return [TDD_ArtiObdReviewModel setProtocol:id bCommOK:bCommOK strProtocol:[TDD_CTools CStrToNSString:strProtocol]];
}

void ArtiObdReviewSetReportResult(uint32_t id, uint32_t eResult)
{
    [TDD_ArtiObdReviewModel setReportResult:id eResult:eResult];
}

void ArtiObdReviewSetReCheckResult(uint32_t id, uint32_t eResult)
{
    [TDD_ArtiObdReviewModel setReCheckResult:id eResult:eResult];
}

void ArtiObdReviewSetNeedReCheck(uint32_t id, bool isNeed, const std::string& strReCheck)
{
    [TDD_ArtiObdReviewModel setNeedReCheck:id isNeed:isNeed strReCheck:[TDD_CTools CStrToNSString:strReCheck]];
}

void ArtiObdReviewSetMILStatus(uint32_t id, bool bMILStatus)
{
    [TDD_ArtiObdReviewModel setMILStatus:id bMILStatus:bMILStatus];
}

void ArtiObdReviewSetObdStatus(uint32_t id, uint32_t eResult)
{
    [TDD_ArtiObdReviewModel setObdStatus:id eResult:eResult];
}

void ArtiObdReviewSetMILOnMileage(uint32_t id, const std::string& strMILOnMileage)
{
    [TDD_ArtiObdReviewModel setMILOnMileage:id strMILOnMileage:[TDD_CTools CStrToNSString:strMILOnMileage]];
}

void ArtiObdReviewAddReadinessStatusItems(uint32_t id, const std::string& strName, uint32_t Status)
{
    [TDD_ArtiObdReviewModel addReadinessStatusItems:id strName:[TDD_CTools CStrToNSString:strName] Status:Status];
}

void ArtiObdReviewAddEcuInfoItems(uint32_t id, const std::string& strName, const std::vector<std::string>& vctCALID, const std::vector<std::string>& vctCVN)
{
    [TDD_ArtiObdReviewModel addEcuInfoItems:id strName:[TDD_CTools CStrToNSString:strName] vctCALID:[TDD_CTools CVectorToStringNSArray:vctCALID] vctCVN:[TDD_CTools CVectorToStringNSArray:vctCVN]];
}

void ArtiObdReviewAddDtcItem(uint32_t id, const stDtcNodeEx& dtcItem)
{
    [TDD_ArtiObdReviewModel addDtcItem:id dtcItem:dtcItem];
}

void ArtiObdReviewAddDtcItems(uint32_t id, const std::vector<stDtcNodeEx>& vctItem)
{
    [TDD_ArtiObdReviewModel addDtcItems:id dtcItems:vctItem];
}

void ArtiObdReviewAddLiveDataItem(uint32_t id, stDsReportItem& dsItem)
{
    [TDD_ArtiObdReviewModel addLiveDataItem:id dsItem:dsItem];
}

void ArtiObdReviewAddLiveDataItems(uint32_t id, const std::vector<stDsReportItem>& vctItem)
{
    [TDD_ArtiObdReviewModel addLiveDataItems:id vctItems:vctItem];
}

void ArtiObdReviewAddIUPRStatusItem(uint32_t id, const std::string& strName, const std::string& strStatus)
{
    [TDD_ArtiObdReviewModel addIUPRStatusItem:id strName:[TDD_CTools CStrToNSString:strName] strStatus:[TDD_CTools CStrToNSString:strStatus]];
}

void ArtiObdReviewSetEngineInfo(uint32_t id, const std::string& strInfo, const std::string& strSubType)
{
    [TDD_ArtiObdReviewModel setEngineInfo:id strInfo:[TDD_CTools CStrToNSString:strInfo] strSubType:[TDD_CTools CStrToNSString:strSubType]];
}

uint32_t ArtiObdReviewShow(uint32_t id)
{
    return [TDD_ArtiObdReviewModel ShowWithId:id];
}

void ArtiObdViewAddReadinessMainType(uint32_t id, const std::string& strName)
{
    [TDD_ArtiObdReviewModel addReadinessMainType:id strName:[TDD_CTools CStrToNSString:strName]];
}

void ArtiObdViewAddLiveDataMainType(uint32_t id, const std::string& strName)
{
    [TDD_ArtiObdReviewModel addLivedataMainType:id strName:[TDD_CTools CStrToNSString:strName]];
}

void ArtiObdViewAddIUPRMainType(uint32_t id, const std::string& strName)
{
    [TDD_ArtiObdReviewModel addIUPRMainType:id strName:[TDD_CTools CStrToNSString:strName]];
}

//MARK: - OC Method
+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    NSArray * titleArr = @[@"app_report",@"diagnosis_remove_code"];
    
    NSArray * statusArr = @[@(ArtiButtonStatus_ENABLE),@(ArtiButtonStatus_UNVISIBLE)];
    
    NSArray * IDArr = @[@(DF_ID_TROUBLE_REPORT),@(DF_ID_CLEAR_DTC)];
    
    for (int i = 0; i < titleArr.count; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
        buttonModel.uButtonId = [IDArr[i] intValue];
        
        buttonModel.strButtonText = titleArr[i];
        
        buttonModel.uStatus = (ArtiButtonStatus)[statusArr[i] intValue];
        
        buttonModel.bIsEnable = YES;
        
        [model.buttonArr addObject:buttonModel];
    }
}

/*-----------------------------------------------------------------------------
 *    功  能：初始化年检预审报告显示控件，同时设置标题文本
 *
 *    参  数：strTitle 标题文本
 *
 *    返回值：true 初始化成功 false 初始化失败
 -----------------------------------------------------------------------------*/
+ (BOOL)initTitle:(uint32_t)ID strTitle:(NSString *)strTitle
{
    HLog(@"%@ - 初始化菜单显示控件，同时设置标题文本 - ID:%d - 标题 ：%@", [self class], ID, strTitle);
    
    [self Destruct:ID];
    
    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    if ([model.strTitle isEqualToString:strTitle]) {
        return YES;
    }else{
        return NO;
    }
}


/*-----------------------------------------------------------------------------
 *    功  能：设置OBD的通信协议类型
 *
 *    参  数：bCommOK,  与OBD诊断仪通讯情况
 *                      true     通信成功
 *                      false    通信不成功
 *
 *            strProtocol，协议字符串
 *                         例如："ISO 15765-4(CAN)"
 *
 *    返回值：true 设置成功 false 设置失败
 -----------------------------------------------------------------------------*/
+ (BOOL)setProtocol:(uint32_t)ID bCommOK:(BOOL)bCommOK strProtocol:(NSString *)protocol
{
    HLog("%@ - 设置OBD的通信协议类型: commOK - %d, protocol - %@", [self class], bCommOK, protocol);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    model.bCommOk = bCommOK;
    model.strProtocol = protocol;
    
    return YES;
}

/*-----------------------------------------------------------------------------
*    功  能：设置年检预审的检测结果类型
*
*    参  数：eResult，  检测是否合格
*                       RESULT_TYPE_PASS        检测合格
*                       RESULT_TYPE_FAILED      检测不合格
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)setReportResult:(uint32_t)ID  eResult:(uint32_t)result
{
    HLog("%@ - 设置年检预审的report检测结果类型: result - %d", [self class], result);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.checkResult = result > 2 ? RESULT_TYPE_INVALID : (TDD_OBDResultType)result;
}

/*-----------------------------------------------------------------------------
*    功  能：设置年检预审的复检结果类型
*
*    参  数：eResult，  检测是否合格
*                       RESULT_TYPE_PASS        检测合格
*                       RESULT_TYPE_FAILED      检测不合格
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)setReCheckResult:(uint32_t)ID eResult:(uint32_t)result
{
    HLog("%@ - 设置年检预审的check检测结果类型: result - %d", [self class], result);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.checkResult = result > 2 ? RESULT_TYPE_INVALID : (TDD_OBDResultType)result;
}

/*-----------------------------------------------------------------------------
*    功  能：设置是否需要复检
*
*    参  数：isNeed，       是否需要复检
*            strReCheck     如果需要复检，复检内容
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)setNeedReCheck:(uint32_t)ID isNeed:(BOOL)isNeed strReCheck:(NSString *)strReCheck
{
    HLog("%@ - 设置是否需要复检: isNeed - %d, strReCheck - %@", [self class], isNeed, strReCheck);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.isNeedRecheck = isNeed;
    model.strRecheck = strReCheck;
}

/*-----------------------------------------------------------------------------
*    功  能：设置OBD系统故障指示器状态
*
*    参  数：bMILStatus,  OBD系统故障指示器状态
*                      true     OBD系统故障指示器点亮
*                      false    OBD系统故障指示器熄灭
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)setMILStatus:(uint32_t)ID bMILStatus:(BOOL)status
{
    HLog("%@ - 设置OBD系统故障指示器状态: status - %d", [self class], status);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.bMILStatus = status;
}

/*-----------------------------------------------------------------------------
*    功  能：设置“OBD故障指示器”结果类型
*
*    参  数：eResult，  是否合格
*                       RESULT_TYPE_PASS        合格
*                       RESULT_TYPE_FAILED      不合格
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)setObdStatus:(uint32_t)ID eResult:(uint32_t)result
{
    HLog("%@ - 设置“OBD故障指示器”结果类型: result - %d", [self class], result);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.obdStatus = (TDD_OBDResultType)result;
}

/*-----------------------------------------------------------------------------
*    功  能：设置故障灯亮后行驶里程数（KM）
*
*    参  数：strMILOnMileage   故障灯亮后的行驶里程，单位为KM
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)setMILOnMileage:(uint32_t)ID strMILOnMileage:(NSString *)strMILOnMileage
{
    HLog("%@ - 设置故障灯亮后行驶里程数（KM）: strMILOnMileage - %@", [self class], strMILOnMileage);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.strMilOnMileage = strMILOnMileage;
    if (![NSString tdd_isEmpty:strMILOnMileage]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carMILOnMileage = strMILOnMileage;
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加诊断就绪状态未完成项目
*
*    参  数：strName       名称，例如："氧传感器检测 - 发动机($7E8)"
*            strStatus     状态，例如："未就绪"
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)addReadinessMainType:(uint32_t)ID strName:(NSString *)strName
{
    HLog("%@ - 添加诊断就绪状态未完成项目：addReadinessMainType -%@", [self class], strName);
    
    TDD_ArtiObdReviewModel *model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    
    BOOL isContain = NO;
    for (TDD_ArtiObdReviewMainTypeDataModel *item in model.mainTypeItems) {
        if ([item.name  isEqualToString:strName]) {
            isContain = YES;
            model.readinessIndex = [model.mainTypeItems indexOfObject:item];
            break;
        }
    }
    if (!isContain) {
        TDD_ArtiObdReviewMainTypeDataModel *itemModel = [TDD_ArtiObdReviewMainTypeDataModel new];
        itemModel.name = strName;
        [model.mainTypeItems addObject:itemModel];
        model.readinessIndex = [model.mainTypeItems indexOfObject:itemModel];
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加车载排放诊断系统数据流
*
*    参  数：strName        名称，例如，"$7E8 发动机"
*
*    返回值：无
*
*    说  明：
-----------------------------------------------------------------------------*/
+ (void)addLivedataMainType:(uint32_t)ID strName:(NSString *)strName
{
    HLog("%@ - 添加车载排放诊断系统数据流：addLivedataMainType -%@", [self class], strName);
    
    TDD_ArtiObdReviewModel *model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    
    BOOL isContain = NO;
    for (TDD_ArtiObdReviewMainTypeDataModel *item in model.mainTypeItems) {
        if ([item.name  isEqualToString:strName]) {
            isContain = YES;
            model.liveDataIndex = [model.mainTypeItems indexOfObject:item];
            break;
        }
    }
    if (!isContain) {
        TDD_ArtiObdReviewMainTypeDataModel *itemModel = [TDD_ArtiObdReviewMainTypeDataModel new];
        itemModel.name = strName;
        [model.mainTypeItems addObject:itemModel];
        model.liveDataIndex = [model.mainTypeItems indexOfObject:itemModel];
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加车载排放诊断系统实际监测频率 (IUPR状态)的主类型
*
*    参  数：strName        名称，例如，"$7E8 发动机"
*
*    返回值：无
*
*    说  明：
-----------------------------------------------------------------------------*/
+ (void)addIUPRMainType:(uint32_t)ID strName:(NSString *)strName
{
    HLog("%@ - 添加车载排放诊断系统实际监测频率 (IUPR状态)的主类型：addIUPRMainType -%@", [self class], strName);
    
    TDD_ArtiObdReviewModel *model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    
    BOOL isContain = NO;
    for (TDD_ArtiObdReviewMainTypeDataModel *item in model.mainTypeItems) {
        if ([item.name  isEqualToString:strName]) {
            isContain = YES;
            model.iuprIndex = [model.mainTypeItems indexOfObject:item];
            break;
        }
    }
    if (!isContain) {
        TDD_ArtiObdReviewMainTypeDataModel *itemModel = [TDD_ArtiObdReviewMainTypeDataModel new];
        itemModel.name = strName;
        [model.mainTypeItems addObject:itemModel];
        model.iuprIndex = [model.mainTypeItems indexOfObject:itemModel];
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加诊断就绪状态未完成项目
*
*    参  数：strName       名称，例如："氧传感器检测 - 发动机($7E8)"
*            strStatus     状态，例如："未就绪"
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)addReadinessStatusItems:(uint32_t)ID strName:(NSString *)strName Status:(uint32_t)status
{
    HLog("%@ - 添加诊断就绪状态未完成项目: strName - %@, status - %d", [self class], strName, status);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    TDD_ArtiObdReviewItemModel *item = [TDD_ArtiObdReviewItemModel new];
    item.name = strName;
    item.status = status;
    item.strStatus = status == 1 ? TDDLocalized.obd_review_ready : TDDLocalized.obd_review_unready;
    
    NSInteger currentIndex = model.readinessIndex;
    if (model.mainTypeItems.count > 0 && model.mainTypeItems.count > currentIndex) {
        [model.mainTypeItems[currentIndex].readinessItems addObject:item];
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加车辆控制单元的CALID（如果适用）和CVN信息（如果适用）
*
*            CALID --   Calibration ID                       -- 软件标定识别
*            CVN   --   Calibration Verification Number      -- 标定验证码
*
*
*    参  数：strName       车辆控制单元名称，例如："发动机控制单元"
*            vctCALID      对应ECU的软件标定识别(CALID)数组
*            vctCVN        对应ECU的标定验证码(CVN)数组
*
*    返回值：无
-----------------------------------------------------------------------------*/
+ (void)addEcuInfoItems:(uint32_t)ID strName:(NSString *)strName vctCALID: (NSArray<NSString *> *)CALIDs vctCVN:(NSArray<NSString *> *)CVNs
{
    HLog("%@ - 添加车辆控制单元的CALID和CVN信息: strName - %@, CALIDs - %@, CVNs - %@", [self class], strName, CALIDs, CVNs);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model.ecuItems) {
        model.ecuItems = [NSMutableArray array];
    }
    
    TDD_ArtiObdReviewEcuItemModel *item = [TDD_ArtiObdReviewEcuItemModel new];
    item.name = strName;
    [item.calidItems addObjectsFromArray:CALIDs];
    [item.cvnItems addObjectsFromArray:CVNs];
    
    [model.ecuItems addObject:item];
}

/*-----------------------------------------------------------------------------
*    功  能：添加故障码列表项
*
*    参  数：dtcItem    故障码列表项， 参考stDtcNodeEx的定义
*            dtcItem 节点 结构定义
*            struct stDtcNodeEx
*            {
*                std::string strCode;        // 故障代码
*                std::string strDescription; // 故障码描述
*                std::string strStatus;      // 故障码状态
*                uint32_t    uStatus;        // 故障码状态
*            };
*
*    返回值：无
*
*    说  明：故障码项
-----------------------------------------------------------------------------*/
+ (void)addDtcItem:(uint32_t)ID dtcItem:(stDtcNodeEx)item
{
    NSString *strTroubleCode = [TDD_CTools CStrToNSString:item.strCode];
    NSString *strDescription = [TDD_CTools CStrToNSString:item.strDescription];
    NSString *strStatus = [TDD_CTools CStrToNSString:item.strStatus];
    int status = (int)item.uStatus;
    
    HLog("%@ - 添加故障码列表项: strCode - %@, strDescription - %@, strStatus - %@, status - %d", [self class], strTroubleCode, strDescription, strStatus, status);

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model.dtcItems) {
        model.dtcItems = [NSMutableArray array];
    }
    
    TDD_ArtiTroubleItemModel *itemModel = [TDD_ArtiTroubleItemModel new];
    itemModel.strTroubleCode = strTroubleCode;
    itemModel.strTroubleDesc = strDescription;
    itemModel.strTroubleStatus = strStatus;
    itemModel.uStatus = status;
    [model.dtcItems addObject:itemModel];
}

/*-----------------------------------------------------------------------------
*    功  能：添加故障码列表
*
*    参  数：vctItem        故障码列表项数组， 参考stDtcNodeEx的定义

*    返回值：无
*
*    说  明：故障码数组
-----------------------------------------------------------------------------*/
+ (void)addDtcItems:(uint32_t)ID dtcItems:(std::vector<stDtcNodeEx>)items
{

    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model.dtcItems) {
        model.dtcItems = [NSMutableArray array];
    }
    
    for (int i=0; i<items.size(); i++) {
        NSString *strTroubleCode = [TDD_CTools CStrToNSString:items[i].strCode];
        NSString *strDescription = [TDD_CTools CStrToNSString:items[i].strDescription];
        NSString *strStatus = [TDD_CTools CStrToNSString:items[i].strStatus];
        int status = (int)items[i].uStatus;
        HLog("%@ - 添加故障码列表数组第（%d）条: strCode - %@, strDescription - %@, strStatus - %@, status - %d", [self class], i, strTroubleCode, strDescription, strStatus, status);
        TDD_ArtiTroubleItemModel *itemModel = [TDD_ArtiTroubleItemModel new];
        itemModel.strTroubleCode = strTroubleCode;
        itemModel.strTroubleDesc = strDescription;
        itemModel.strTroubleStatus = strStatus;
        itemModel.uStatus = status;
        [model.dtcItems addObject:itemModel];
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加数据流列表项
*
*    参  数：dsItem    数据流列表项， 参考stDsReportItem的定义
*
*    返回值：无
*
*    说  明：
-----------------------------------------------------------------------------*/
+ (void)addLiveDataItem:(uint32_t)ID dsItem:(stDsReportItem)item
{
    NSString *strName = [TDD_CTools CStrToNSString:item.strName];
    NSString *strValue = [TDD_CTools CStrToNSString:item.strValue];
    NSString *strUnit = [TDD_CTools CStrToNSString:item.strUnit];
    NSString *strMin = [TDD_CTools CStrToNSString:item.strMin];
    NSString *strMax = [TDD_CTools CStrToNSString:item.strMax];
    NSString *strReference = [TDD_CTools CStrToNSString:item.strReference];
    
    HLog("%@ - 添加数据流列表项: strName - %@, strValue - %@, strUnit - %@, strMin - %@, strMax - %@, strReference - %@", [self class], strName, strValue, strUnit, strMin, strMax, strReference);
    
    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    
    TDD_ArtiLiveDataItemModel *itemModel = [TDD_ArtiLiveDataItemModel new];
    itemModel.strName = strName;
    itemModel.strValue = strValue;
    itemModel.strUnit = strUnit;
    itemModel.strMin = strMin;
    itemModel.strMax = strMax;
    itemModel.strReference = strReference;
    
    NSInteger currentIndex = model.liveDataIndex;
    if (model.mainTypeItems.count > 0 && model.mainTypeItems.count > currentIndex) {
        [model.mainTypeItems[currentIndex].liveDataItems addObject:itemModel];
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加数据流列表
*
*    参  数：dsItem    数据流列表项数组， 参考stDsReportItem的定义
*
*    返回值：无
*
*    说  明：
-----------------------------------------------------------------------------*/
+ (void)addLiveDataItems:(uint32_t)ID vctItems:(std::vector<stDsReportItem>)items
{
    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    
    for (int i=0; i<items.size(); i++) {
        stDsReportItem item = items[i];
        NSString *strName = [TDD_CTools CStrToNSString:item.strName];
        NSString *strValue = [TDD_CTools CStrToNSString:item.strValue];
        NSString *strUnit = [TDD_CTools CStrToNSString:item.strUnit];
        NSString *strMin = [TDD_CTools CStrToNSString:item.strMin];
        NSString *strMax = [TDD_CTools CStrToNSString:item.strMax];
        NSString *strReference = [TDD_CTools CStrToNSString:item.strReference];
        HLog("%@ - 添加数据流列表第（%d）项: strName - %@, strValue - %@, strUnit - %@, strMin - %@, strMax - %@, strReference - %@", [self class], i, strName, strValue, strUnit, strMin, strMax, strReference);
        
        TDD_ArtiLiveDataItemModel *itemModel = [TDD_ArtiLiveDataItemModel new];
        itemModel.strName = strName;
        itemModel.strValue = strValue;
        itemModel.strUnit = strUnit;
        itemModel.strMin = strMin;
        itemModel.strMax = strMax;
        itemModel.strReference = strReference;
        
        NSInteger currentIndex = model.liveDataIndex;
        if (model.mainTypeItems.count > 0 && model.mainTypeItems.count > currentIndex) {
            [model.mainTypeItems[currentIndex].liveDataItems addObject:itemModel];
        }
    }
}

/*-----------------------------------------------------------------------------
*    功  能：添加车载排放诊断系统实际监测频率 (IUPR状态)
*            IUPR相关数据
*
*    参  数：strName        名称，例如，"催化器组1在用监测频率"
*            strStatus      状态
*
*    返回值：无
*
*    说  明：
-----------------------------------------------------------------------------*/
+ (void)addIUPRStatusItem:(uint32_t)ID strName:(NSString *)strName strStatus:(NSString *)strStatus
{
    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    
    HLog("%@ - 添加车载排放诊断系统实际监测频率 (IUPR状态): strName - %@, strStatus - %@", [self class], strName, strStatus);
    
    if (!model.mainTypeItems) {
        model.mainTypeItems = [NSMutableArray array];
    }
    
    TDD_ArtiObdReviewItemModel *itemModel = [TDD_ArtiObdReviewItemModel new];
    itemModel.name = strName;
    itemModel.strStatus = strStatus;
    
    NSInteger currentIndex = model.iuprIndex;
    if (model.mainTypeItems.count > 0 && model.mainTypeItems.count > currentIndex) {
        [model.mainTypeItems[currentIndex].iuprItems addObject:itemModel];
    }
}

/*-----------------------------------------------------------------------------
功能：设置车辆发动机信息

参数说明：
        strInfo                发动机机信息，例如，"F62-D52"
        strSubType             发动机子型号或者其它信息，例如，"N542"

返回值：
-----------------------------------------------------------------------------*/
+ (void)setEngineInfo:(uint32_t)ID strInfo:(NSString *)info strSubType:(NSString *)strSubType
{
    HLog("%@ - 设置车辆发动机信息: info - %@, strSubType - %@", [self class], info, strSubType);
    
    TDD_ArtiObdReviewModel * model = (TDD_ArtiObdReviewModel *)[self getModelWithID:ID];
    model.engineInfo = info;
    model.engineSubType = strSubType;
    if (![NSString tdd_isEmpty:info]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carEngineInfo = info;
    }
    if (![NSString tdd_isEmpty:strSubType]) {
        TDD_ArtiGlobalModel.sharedArtiGlobalModel.carEngineSubInfo = strSubType;
    }
}


@end


@implementation TDD_ArtiObdReviewItemModel

@end

@implementation TDD_ArtiObdReviewEcuItemModel

- (NSMutableArray<NSString *> *)calidItems {
    if (!_calidItems) {
        _calidItems = [NSMutableArray array];
    }
    return _calidItems;
}

- (NSMutableArray<NSString *> *)cvnItems {
    if (!_cvnItems) {
        _cvnItems = [NSMutableArray array];
    }
    return _cvnItems;
}

@end

@implementation TDD_ArtiObdReviewMainTypeDataModel

- (NSMutableArray<TDD_ArtiLiveDataItemModel *> *)liveDataItems
{
    if (!_liveDataItems) {
        _liveDataItems = [NSMutableArray array];
    }
    return _liveDataItems;
}

- (NSMutableArray<TDD_ArtiObdReviewItemModel *> *)readinessItems {
    if (!_readinessItems) {
        _readinessItems = [NSMutableArray array];
    }
    return _readinessItems;
}

- (NSMutableArray<TDD_ArtiObdReviewItemModel *> *)iuprItems {
    if (!_iuprItems) {
        _iuprItems = [NSMutableArray array];
    }
    return _iuprItems;
}

@end
