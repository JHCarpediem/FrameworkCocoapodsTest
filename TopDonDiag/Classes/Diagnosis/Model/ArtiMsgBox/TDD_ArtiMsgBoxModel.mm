//
//  TDD_ArtiMsgBoxModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/20.
//

#import "TDD_ArtiMsgBoxModel.h"
#if useCarsFramework
#import <CarsFramework/RegMsgBox.hpp>
#else
#import "RegMsgBox.hpp"
#endif


#import "TDD_CTools.h"

#import "TDD_FCAAuthModel.h"
#import "TDD_ArtiMsgBoxGroupModel.h"
#import "TDD_ArtiMsgBoxDsModel.h"
@interface TDD_ArtiMsgBoxModel ()
@property (nonatomic, strong) NSMutableArray * saveButtonArr; //临时保存按钮
@end

@implementation TDD_ArtiMsgBoxModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegMsgBox::artiShowMsgBox(ArtiMsgBoxArtiShowMsgBox);
    CRegMsgBox::artiShowTypeMsgBox(ArtiMsgBoxArtiShowTypeMsgBox);
    CRegMsgBox::artiMsgBoxActTest(ArtiMsgBoxActTest);
    
    CRegMsgBox::artiShowSpecial(ArtiMsgBoxShowSpecial);
    
    CRegMsgBox::Construct(ArtiMsgBoxConstruct);
    CRegMsgBox::Destruct(ArtiMsgBoxDestruct);
    CRegMsgBox::InitMsgBox(ArtiMsgBoxInitMsgBox);
    CRegMsgBox::SetTitle(ArtiMsgBoxSetTitle);
    CRegMsgBox::SetContent(ArtiMsgBoxSetContent);
    CRegMsgBox::AddButton(ArtiMsgBoxAddButton);
    CRegMsgBox::AddButtonEx(ArtiMsgBoxAddButtonEx);
    CRegMsgBox::DelButton(ArtiMsgBoxDelButton);
    CRegMsgBox::SetButtonType(ArtiMsgBoxSetButtonType);
    CRegMsgBox::SetButtonStatus(ArtiMsgBoxSetButtonStatus);
    CRegMsgBox::SetButtonText(ArtiMsgBoxSetButtonText);
    CRegMsgBox::GetButtonText(ArtiMsgGetButtonText);
    CRegMsgBox::SetAlignType(ArtiMsgBoxSetAlignType);
    CRegMsgBox::SetTimer(ArtiMsgBoxSetTimer);
    CRegMsgBox::SetBusyVisible(ArtiMsgBoxSetBusyVisible);
    CRegMsgBox::SetProcessBarVisible(ArtiMsgBoxSetProcessBarVisible);
    CRegMsgBox::SetProgressBarPercent(ArtiMsgBoxSetProgressBarPercent);
    
    //ADAS
    CRegMsgBox::artiShowMsgGroup(ArtiMsgBoxShowMsgGroup);
    CRegMsgBox::artiShowAdasStep(ArtiMsgBoxShowAdasStep);
    CRegMsgBox::artiShowMsgBoxDs(ArtiMsgBoxShowMsgBoxDs);
    
    CRegMsgBox::Show(ArtiMsgBoxShow);
}

uint32_t ArtiMsgBoxArtiShowMsgBox(const std::string& strTitle,
                        const std::string& strContent,
                        uint32_t uButton,
                        uint16_t uAlignType,
                        int32_t iTimer = -1)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];

    NSString * Content = [TDD_CTools CStrToNSString:strContent];
    
    return [TDD_ArtiMsgBoxModel artiShowMsgBoxWithStrTitle:Title strContent:Content uButton:uButton uAlignType:uAlignType iTimer:iTimer];
}

uint32_t ArtiMsgBoxArtiShowTypeMsgBox(uint32_t uType,
                        const std::string& strTitle = "",
                        const std::string& strContent = "",
                        uint32_t uButton = DF_MB_OK,
                        uint16_t uAlignType = DT_CENTER)
{
    
    NSString * title = [TDD_CTools CStrToNSString:strTitle];
    
    NSString * content = [TDD_CTools CStrToNSString:strContent];
    
    return [TDD_ArtiMsgBoxModel artiShowMsgBoxWithType:uType strTitle:title strContent:content uButton:uButton uAlignType:uAlignType];
}

uint32_t ArtiMsgBoxActTest(const std::string& strTitle,
                        const std::string& strContent,
                        uint32_t uButton,
                        uint32_t uTestType,
                        uint32_t uRpm,
                        uint32_t uCountDown)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];

    NSString * Content = [TDD_CTools CStrToNSString:strContent];
    
    return [TDD_ArtiMsgBoxModel artiShowMsgBoxActTestWithStrTitle:Title strContent:Content uButton:uButton uTestType:uTestType uRpm:uRpm uCountDown:uCountDown];
}

uint32_t ArtiMsgBoxShowSpecial(uint32_t uType)
{

    return [TDD_ArtiMsgBoxModel artiShowMsgBoxShowSpecial:uType];
}

uint32_t ArtiMsgBoxShowAdasStep(uint32_t uStep)
{

    return [TDD_ArtiMsgBoxModel artiShowMsgBoxShowAdasStep:uStep];
}

void ArtiMsgBoxConstruct(uint32_t id)
{
    [TDD_ArtiMsgBoxModel Construct:id];
}

void ArtiMsgBoxDestruct(uint32_t id)
{
    [TDD_ArtiMsgBoxModel Destruct:id];
}

bool ArtiMsgBoxInitMsgBox(uint32_t id, const std::string& strTitle, const std::string& strContent, uint32_t uButtonType, uint16_t uAlignType, int32_t iTimer)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];

    NSString * Content = [TDD_CTools CStrToNSString:strContent];

    return [TDD_ArtiMsgBoxModel InitMsgBoxWithId:id strTitle:Title strContent:Content uButtonType:uButtonType uAlignType:uAlignType iTimer:iTimer];
}

void ArtiMsgBoxSetTitle(uint32_t id, const std::string& strSetTitle)
{
    NSString * Title = [TDD_CTools CStrToNSString:strSetTitle];

    [TDD_ArtiMsgBoxModel SetTitleWithId:id strTitle:Title];
}

void ArtiMsgBoxSetContent(uint32_t id, const std::string& strContent)
{
    NSString * Content = [TDD_CTools CStrToNSString:strContent];

    [TDD_ArtiMsgBoxModel SetContentWithId:id strContent:Content];
}

void ArtiMsgBoxAddButton(uint32_t id, const std::string& strButtonText)
{
    NSString * ButtonText = [TDD_CTools CStrToNSString:strButtonText];

    [TDD_ArtiMsgBoxModel AddButtonExWithId:id strButtonText:ButtonText];
}

uint32_t ArtiMsgBoxAddButtonEx(uint32_t id, const std::string& strButtonText)
{
    NSString * ButtonText = [TDD_CTools CStrToNSString:strButtonText];

    return [TDD_ArtiMsgBoxModel AddButtonExWithId:id strButtonText:ButtonText];
}

bool ArtiMsgBoxDelButton(uint32_t id, uint32_t uButtonId)
{
    return [TDD_ArtiMsgBoxModel DelButtonWithId:id uButtonId:uButtonId];
}

void ArtiMsgBoxSetButtonType(uint32_t id, uint32_t uButtonTyp)
{
    [TDD_ArtiMsgBoxModel SetButtonTypeWithId:id uButtonType:uButtonTyp];
}

const std::string ArtiMsgGetButtonText(uint32_t id, uint32_t uButtonID)
{
    NSString * str = [TDD_ArtiMsgBoxModel GetButtonTextWithId:id uButtonID:uButtonID];
    
    return [TDD_CTools NSStringToCStr:str];
}

void ArtiMsgBoxSetButtonStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus)
{
    [TDD_ArtiMsgBoxModel SetButtonStatusWithId:id uIndex:uIndex uStatus:uStatus];
}

void ArtiMsgBoxSetButtonText(uint32_t id, uint16_t uIndex, const std::string& strButtonText)
{
    NSString * ButtonText = [TDD_CTools CStrToNSString:strButtonText];

    [TDD_ArtiMsgBoxModel SetButtonTextWithId:id uIndex:uIndex strButtonText:ButtonText];
}

void ArtiMsgBoxSetAlignType(uint32_t id, uint16_t uAlignType)
{
    [TDD_ArtiMsgBoxModel SetAlignTypeWithId:id uAlignType:uAlignType];
}

void ArtiMsgBoxSetTimer(uint32_t id, int32_t iTimer)
{
    [TDD_ArtiMsgBoxModel SetTimerWithId:id iTimer:iTimer];
}

void ArtiMsgBoxSetBusyVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiMsgBoxModel SetBusyVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiMsgBoxSetProcessBarVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiMsgBoxModel SetProcessBarVisibleWithId:id bIsVisible:bIsVisible];
}

void ArtiMsgBoxSetProgressBarPercent(uint32_t id, int32_t iCurPercent, int32_t iTotalPercent)
{
    [TDD_ArtiMsgBoxModel SetProgressBarPercentWithId:id iCurPercent:iCurPercent iTotalPercent:iTotalPercent];
}

uint32_t ArtiMsgBoxShowMsgGroup(uint32_t uType,const std::string& strTitle, const std::vector<stMsgItem>& vctItem)
{
    NSString * title = [TDD_CTools CStrToNSString:strTitle];


    return  [TDD_ArtiMsgBoxModel addMsgBoxShowMsgGroup:uType strTitle:title vctItem:vctItem];

}

uint32_t ArtiMsgBoxShowMsgBoxDs(uint32_t uType,const std::string& strSysName, const std::vector<stDsReportItem>& vctItem)
{
    NSString * sysName = [TDD_CTools CStrToNSString:strSysName];


    return  [TDD_ArtiMsgBoxModel addMsgBoxShowMsgBoxDs:uType strSysName:sysName vctItem:vctItem];

}

uint32_t ArtiMsgBoxShow(uint32_t id)
{
    return [TDD_ArtiMsgBoxModel ShowWithId:id];
}

/**********************************************************
*    功  能：初始化消息框
*    参  数：strTitle 消息框标题文本
*            strContent 消息框内容文本
*            uButtonType 消息框按钮类型
*            uAlignType 消息框文本对齐方式
*            iTimer 定时器，单位ms
*            注：iTimer只对单按钮消息框或者无按钮消息框有效
*    返回值：true 初始化成功 false 初始化失败
*
*    注：
*     uButtonType值可以如下：
*            DF_MB_NOBUTTON             //  无按钮的非阻塞消息框
*            DF_MB_YES                           //  Yes 按钮的阻塞消息框
*            DF_MB_NO                            //  No 按钮的阻塞消息框
*            DF_MB_YESNO                      //  Yes/No 按钮的阻塞消息框
*            DF_MB_OK                              //  OK 按钮的阻塞消息框
*            DF_MB_CANCEL                     //  Cancel 按钮的阻塞消息框
*            DF_MB_OKCANCEL                //  OK/Cancel 按钮的阻塞消息框
*            DF_MB_NEXTEXIT                    //  Next/Exit 按钮的阻塞消息框
*            DF_MB_FREE | DF_MB_BLOCK   //  自由按钮的阻塞消息框
*
**********************************************************/
+ (uint32_t)artiShowMsgBoxWithStrTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uAlignType:(uint32_t)uAlignType iTimer:(int32_t)iTimer
{
    HLog(@"%@ - 全局消息框 - strTitle ：%@ - strContent : %@ - uButtonType : %d - uAlignType : %d - iTimer : %d", [self class], strTitle, strContent, uButton, uAlignType, iTimer);
    TDD_ArtiMsgBoxModel * model = [[TDD_ArtiMsgBoxModel alloc] init];
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.strTitle = strTitle;
    model.strContent = strContent;
    model.uButtonType = uButton;
    model.uAlignType = uAlignType;
    model.iTimer = iTimer;
    return [model show];
}

+ (uint32_t) artiShowMsgBoxWithType:(uint32_t)type strTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uAlignType:(uint32_t)uAlignType
{
    HLog(@"%@ - 全局消息框 - type : %d - strTitle ：%@ - strContent : %@ - uButtonType : %d - uAlignType : %d", [self class], type, strTitle, strContent, uButton, uAlignType);
    
    TDD_ArtiMsgBoxModel * model = [[TDD_ArtiMsgBoxModel alloc] init];
    model.uType = type;
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.strTitle = strTitle;
    model.strContent = strContent;
    model.uButtonType = uButton;
    model.uAlignType = uAlignType;
    return [model show];
}

/**********************************************************
*    功  能：初始化消息框
*    参  数：strTitle 消息框标题文本
*            strContent 消息框内容文本
*            uButtonType 消息框按钮类型
*            uAlignType 消息框文本对齐方式
*            iTimer 定时器，单位ms
*            注：iTimer只对单按钮消息框或者无按钮消息框有效
*    返回值：true 初始化成功 false 初始化失败
*
*    注：
*     uButtonType值可以如下：
*            DF_MB_NOBUTTON             //  无按钮的非阻塞消息框
*            DF_MB_YES                           //  Yes 按钮的阻塞消息框
*            DF_MB_NO                            //  No 按钮的阻塞消息框
*            DF_MB_YESNO                      //  Yes/No 按钮的阻塞消息框
*            DF_MB_OK                              //  OK 按钮的阻塞消息框
*            DF_MB_CANCEL                     //  Cancel 按钮的阻塞消息框
*            DF_MB_OKCANCEL                //  OK/Cancel 按钮的阻塞消息框
*            DF_MB_NEXTEXIT                    //  Next/Exit 按钮的阻塞消息框
*            DF_MB_FREE | DF_MB_BLOCK   //  自由按钮的阻塞消息框
*
**********************************************************/
+ (uint32_t)artiShowMsgBoxActTestWithStrTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uTestType:(uint32_t)uTestType uRpm:(uint32_t)uRpm uCountDown:(uint32_t)uCountDown
{
    HLog(@"%@ - 小车探项目的部件测试UI - strTitle ：%@ - strContent : %@ - uButtonType : %d - uTestType : %d - uRpm: %d", [self class], strTitle, strContent, uButton, uTestType, uRpm);
    TDD_ArtiMsgBoxModel * model = [[TDD_ArtiMsgBoxModel alloc] init];
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.strTitle = strTitle;
    model.strContent = strContent;
    model.uButtonType = uButton;
    model.uTestType = uTestType;
    model.uRpm = uRpm;
    model.uCountDown = uCountDown;
    model.uAlignType = uTestType == 2 ? DT_LEFT : DT_CENTER;
    return [model show];
}

+ (uint32_t)artiShowMsgBoxShowSpecial:(uint32_t)uType {
    HLog(@"%@ - artiShowMsgBoxShowSpecial - uType ：%d", [self class], uType);
    //根据服务器返回判断。 后续 NASTF也需要
    if (uType == SST_FUNC_VW_SFD_AUTH && !([TDD_DiagnosisManage sharedManage].functionConfigMask & 16)) {
        return DF_CUR_BRAND_APP_NOT_SUPPORT;
    }
    if (uType == SST_FUNC_FCA_AUTH || uType == SST_FUNC_RENAULT_AUTH || uType == SST_FUNC_NISSAN_AUTH || uType == SST_FUNC_VW_SFD_AUTH || uType == (int)SST_FUNC_DEMO_AUTH) {
        TDD_FCAAuthModel *model = [[TDD_FCAAuthModel alloc] init];
        model.strTitle = (uType == 0) ? TDDLocalized.app_sign_in:TDDLocalized.detail_info;
        model.returnID = DF_ID_NOKEY;
        model.isLock = YES;
        model.uType = (eSpecialShowType)uType;
        if (uType == SST_FUNC_FCA_AUTH || uType == SST_FUNC_NISSAN_AUTH) {
            if ([TDD_DiagnosisTools isAutoAuthNa] == 1) {
                model.unlockType = 0;
            }else {
                model.unlockType = 1;
            }
        }else {
            model.unlockType = 1;
        }

        
        [TDD_ArtiGlobalModel sharedArtiGlobalModel].authType = (eSpecialShowType)uType;
        model.viewType = 1;
        
        return [model show];

    }
    
    return DF_FUNCTION_APP_CURRENT_NOT_SUPPORT;
}

+ (uint32_t)artiShowMsgBoxShowAdasStep:(uint32_t)uStep {
    HLog(@"%@ - ADAS Step - uStep ：%d", [self class], uStep);
    TDD_ArtiMsgBoxModel * model = [[TDD_ArtiMsgBoxModel alloc] init];
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.adasStep = uStep;
    model.specialViewType = 1;
    model.uButtonType = DF_MB_OK;
    model.uAlignType = DT_CENTER;
    if (model.adasStep == ACS_DYNAMIC_CALI_NOT_SUPPORT) {
        model.strTitle = TDDLocalized.adas_calibration;
        model.strContent = TDDLocalized.adas_calibration_no_support;
    }

    return [model show];
}

+ (BOOL)InitMsgBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strContent:(NSString *)strContent uButtonType:(uint32_t)uButtonType uAlignType:(uint32_t)uAlignType iTimer:(int32_t)iTimer
{
    HLog(@"%@ - 初始化消息框 - ID:%d - strTitle ：%@ - strContent : %@ - uButtonType : %d - uAlignType : %d - iTimer : %d", [self class], ID, strTitle, strContent, uButtonType, uAlignType, iTimer);
    
    [self Destruct:ID];
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    model.strContent = strContent;
    
    model.uButtonType = uButtonType;
    
    model.uAlignType = uAlignType;
    
    model.iTimer = iTimer;
    
    return YES;
}

//+ (void)Construct:(uint32_t)ID
//{
//    [super Construct:ID];
//    
//    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
//}

/**********************************************************
*    功  能：设置消息框标题
*    参  数：strTitle 消息框标题
*    返回值：无
**********************************************************/
+ (void)SetTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle
{
    HLog(@"%@ - 设置消息框标题 - ID:%d - strTitle ：%@", [self class], ID, strTitle);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.strTitle = strTitle;
}

/**********************************************************
*    功  能：设置消息框文本内容
*    参  数：strContent 消息框内容
*    返回值：无
**********************************************************/
+ (void)SetContentWithId:(uint32_t)ID strContent:(NSString *)strContent
{
    HLog(@"%@ - 设置消息框文本内容 - ID:%d - strContent ：%@", [self class], ID, strContent);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.strContent = strContent;
}


/**********************************************************
*    功  能：设置消息框按钮类型
*    参  数：uButtonTyp 按钮类型
*    返回值：无
**********************************************************/
+ (void)SetButtonTypeWithId:(uint32_t)ID uButtonType:(uint32_t)uButtonType
{
    HLog(@"%@ - 设置消息框按钮类型 - ID:%d - uButtonTyp ：%d", [self class], ID, uButtonType);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.uButtonType = uButtonType;
}

/**********************************************************
*    功  能：获取消息框固定按钮文本
*
*    参  数：uButtonID 按钮类型
*            DF_TEXT_ID_OK
*            DF_TEXT_ID_YES
*            DF_TEXT_ID_CANCEL
*            DF_TEXT_ID_NO
*            DF_TEXT_ID_BACK
*            DF_TEXT_ID_EXIT
*            DF_TEXT_ID_HELP
*            DF_TEXT_ID_CLEAR_DTC
*            DF_TEXT_ID_REPORT
*            DF_TEXT_ID_NEXT
*
*    返回值：无
**********************************************************/
+ (NSString *)GetButtonTextWithId:(uint32_t)ID uButtonID:(uint32_t)uButtonID
{
    HLog(@"%@ - 获取消息框固定按钮文本 - ID:%d - uButtonID ：%d", [self class], ID, uButtonID);
    
    NSArray * arr = @[@"app_confirm",@"app_yes",@"app_cancel",@"app_no",@"back",@"app_exit",@"diagnosis_help",@"diagnosis_remove_code",@"app_report",@"app_next"];
    
    if (uButtonID >= 1 && uButtonID - 1 < arr.count) {
        return [TDD_HLanguage getLanguage:arr[uButtonID - 1]];
    }
    
    return @"";
}

/**********************************************************
*    功  能：设置消息框内容对齐方式
*    参  数：uAlignType 对齐方式
*    返回值：无
**********************************************************/
+ (void)SetAlignTypeWithId:(uint32_t)ID uAlignType:(uint32_t)uAlignType
{
    HLog(@"%@ - 设置消息框内容对齐方式 - ID:%d - uButtonTyp ：%d", [self class], ID, uAlignType);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.uAlignType = uAlignType;
}

/**********************************************************
*    功  能：设置定时器
*    参  数：定时器时间，单位ms
*    返回值：无
**********************************************************/
+ (void)SetTimerWithId:(uint32_t)ID iTimer:(int32_t)iTimer
{
    HLog(@"%@ - 设置定时器 - ID:%d - iTimer ：%d", [self class], ID, iTimer);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.iTimer = iTimer;
}

/**********************************************************
*    功  能：设置消息框忙状态是否显示
*    参  数：bIsVisible = true; 显示消息框忙状态，如沙漏或者其他
*            bIsVisible = false; 不显示显示消息框忙状态
*    返回值：无
**********************************************************/
+ (void)SetBusyVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置消息框忙状态是否显示 - ID:%d - bIsVisible ：%d", [self class], ID, bIsVisible);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.isBusyVisible = bIsVisible;
}

/**********************************************************
*    功  能：设置进度条是否显示
*    参  数：bIsVisible = true;   显示进度条
*            bIsVisible = false; 不显示进度条
*    返回值：无
**********************************************************/
+ (void)SetProcessBarVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置进度条是否显示 - ID:%d - bIsVisible ：%d", [self class], ID, bIsVisible);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    
    model.isProcessBarVisible = bIsVisible;
}

/**********************************************************
*    功  能：设置进度条的进度
*    参  数：iCurPercent，   当前进度
*            iTotalPercent，总进度
*    返回值：无
**********************************************************/
+ (void)SetProgressBarPercentWithId:(uint32_t)ID iCurPercent:(int32_t)iCurPercent iTotalPercent:(int32_t)iTotalPercent
{
    HLog(@"%@ - 设置进度条的进度 - ID:%d - iCurPercent ：%d - iTotalPercent ：%d", [self class], ID, iCurPercent, iTotalPercent);
    
    TDD_ArtiMsgBoxModel * model = (TDD_ArtiMsgBoxModel *)[self getModelWithID:ID];
    if (iCurPercent < 0 || iTotalPercent <= 0) {
        HLog(@"%@ - 设置进度条进度有误 - ID:%d - iCurPercent ：%d - iTotalPercent ：%d", [self class], ID, iCurPercent, iTotalPercent);
        return;
    }
    model.iCurPercent = iCurPercent;
    
    model.iTotalPercent = iTotalPercent;
}

+ (uint32_t)addMsgBoxShowMsgGroup:(uint32_t )uType strTitle:(NSString *)strTitle vctItem:(std::vector<stMsgItem>)items {
    
    TDD_ArtiMsgBoxGroupModel *model = [[TDD_ArtiMsgBoxGroupModel alloc] init];
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.strTitle = strTitle;
    if (!model.itemArr) {
        model.itemArr = [NSMutableArray array];
    }
    for (int i=0; i<items.size(); i++) {
        stMsgItem item = items[i];
        NSString *title = [TDD_CTools CStrToNSString:item.strTitle];
        NSString *content = [TDD_CTools CStrToNSString:item.strContent];
        TDD_ArtiMsgBoxGroupItemModel *itemModel = [TDD_ArtiMsgBoxGroupItemModel new];
        itemModel.title = title;
        itemModel.content = content;
        HLog(@"%@ - addMsgBoxShowMsgGroup - uType:%d - strTitle ：%@ - i - %d - title - %@ - content - %@", [self class], uType, strTitle,i,title,content);
        [model.itemArr addObject:itemModel];
        
    }
    
    return [model show];
}

+ (uint32_t)addMsgBoxShowMsgBoxDs:(uint32_t )uType strSysName:(NSString *)strSysName vctItem:(std::vector<stDsReportItem>)items {

    TDD_ArtiMsgBoxDsModel *model = [[TDD_ArtiMsgBoxDsModel alloc] init];
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.sysName = strSysName;
    for (int i=0; i<items.size(); i++) {
        stDsReportItem item = items[i];
        TDD_ArtiLiveDataItemModel *itemModel = [TDD_ArtiLiveDataItemModel new];
        NSString *strName = [TDD_CTools CStrToNSString:item.strName];
        NSString *strValue = [TDD_CTools CStrToNSString:item.strValue];
        NSString *strUnit = [TDD_CTools CStrToNSString:item.strUnit];
        NSString *strMin = [TDD_CTools CStrToNSString:item.strMin];
        NSString *strMax = [TDD_CTools CStrToNSString:item.strMax];
        NSString *strReference = [TDD_CTools CStrToNSString:item.strReference];
        HLog("%@ - 添加数据流列表第（%d）项: strName - %@, strValue - %@, strUnit - %@, strMin - %@, strMax - %@, strReference - %@", [self class], i, strName, strValue, strUnit, strMin, strMax, strReference);
        itemModel.strName = strName;
        itemModel.strValue = strValue;
        itemModel.strUnit = strUnit;
        itemModel.strMin = strMin;
        itemModel.strMax = strMax;
        itemModel.strReference = strReference;
        [model.liveDataItems addObject:itemModel];
        
    }
    return [model show];
}

#pragma mark 机器翻译 -- 后期有卡顿的话需要优化
- (void)machineTranslation
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (self.strContent.length > 0 && !self.isStrContentTranslated) {
            [self.translatedDic setValue:@"" forKey:self.strContent];
        }
        
        [super machineTranslation];
    });
    
}

#pragma mark 翻译完成
- (void)translationCompleted
{
    if ([self.translatedDic.allKeys containsObject:self.strContent]) {
        if ([self.translatedDic[self.strContent] length] > 0) {
            self.strTranslatedContent = self.translatedDic[self.strContent];
            self.isStrContentTranslated = YES;
        }
    }
    
    [super translationCompleted];
}

- (void)setUButtonType:(uint32_t)uButtonType
{
    //有些车型先加按钮再设置类型为自由按钮，这样按钮就会不见了
    if (uButtonType == DF_MB_FREE) {
        if (!(_uButtonType == 0 || _uButtonType == DF_MB_FREE)) {
            [self.buttonArr removeAllObjects];
        }
    }else {
        [self.buttonArr removeAllObjects];
    }

    _uButtonType = uButtonType;
    
    if ((uButtonType & DF_MB_BLOCK) == DF_MB_BLOCK) {
        // 阻塞消息框
        self.bIsBlock = YES;
    }else {
        self.bIsBlock = NO;
    }
    
    /*
     *            DF_MB_NOBUTTON             //  无按钮的非阻塞消息框
     *            DF_MB_YES                           //  Yes 按钮的阻塞消息框
     *            DF_MB_NO                            //  No 按钮的阻塞消息框
     *            DF_MB_YESNO                      //  Yes/No 按钮的阻塞消息框
     *            DF_MB_OK                              //  OK 按钮的阻塞消息框
     *            DF_MB_CANCEL                     //  Cancel 按钮的阻塞消息框
     *            DF_MB_OKCANCEL                //  OK/Cancel 按钮的阻塞消息框
     *            DF_MB_NEXTEXIT                    //  Next/Exit 按钮的阻塞消息框
     *            DF_MB_FREE | DF_MB_BLOCK   //  自由按钮的阻塞消息框
     */
    
    NSArray * IDArr;
    
    NSArray * titleArr;
    
    switch (uButtonType) {
        case DF_MB_NOBUTTON:
        {
            self.isBusyVisible = YES;
            [self.buttonArr removeAllObjects];
        }
            break;
        case DF_MB_YES:
        {
            IDArr = @[@(DF_ID_YES)];
            
            titleArr = @[@"app_yes"];
        }
            break;
        case DF_MB_NO:
        {
            IDArr = @[@(DF_ID_NO)];
            
            titleArr = @[@"app_no"];
        }
            break;
        case DF_MB_YESNO:
        {
            IDArr = @[@(DF_ID_NO),@(DF_ID_YES)];
            
            titleArr = @[@"app_no",@"app_yes"];
        }
            break;
        case DF_MB_OK:
        {
            IDArr = @[@(DF_ID_OK)];
            if isKindOfTopVCI {
                titleArr = @[@"app_ok"];
            }
            titleArr = @[@"app_confirm"];
        }
            break;
        case DF_MB_CANCEL:
        {
            IDArr = @[@(DF_ID_CANCEL)];
            
            titleArr = @[@"app_cancel"];
        }
            break;
        case DF_MB_OKCANCEL:
        {
            IDArr = @[@(DF_ID_CANCEL),@(DF_ID_OK)];
            
            titleArr = @[@"app_cancel",@"app_confirm"];
        }
            break;
        case DF_MB_NEXTEXIT:
        {
            IDArr = @[@(DF_ID_EXIT),@(DF_ID_NEXT)];
            
            titleArr = @[@"app_exit",@"app_next"];
        }
            break;
        default:
            break;
    }
    
    for (int i = 0; i < IDArr.count; i ++) {
        TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
        buttonModel.uButtonId = [IDArr[i] intValue];
        
        buttonModel.strButtonText = [TDD_HLanguage getLanguage:titleArr[i]];
        
        buttonModel.bIsEnable = YES;
        
        [self.buttonArr addObject:buttonModel];
    }
    
    self.isReloadButton = YES;
}

- (uint32_t)show
{
    if (self.iTimer > 0) {
        
        for (TDD_ArtiButtonModel * model in self.buttonArr) {
            [self.saveButtonArr addObject:@(model.uStatus)];
            model.uStatus = ArtiButtonStatus_DISABLE;
        }
        
        self.isReloadButton = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelector:@selector(modelUnlock) withObject:nil afterDelay:self.iTimer / 1000.0];
        });
    }
    
    return [super show];
}

- (void)modelUnlock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        HLog(@"定时器时间到");
        
        self.iTimer = 0;
        
        for (int i = 0; i < self.buttonArr.count; i ++) {
            TDD_ArtiButtonModel * model = self.buttonArr[i];
            
            ArtiButtonStatus uStatus = (ArtiButtonStatus)[self.saveButtonArr[i] intValue];
            
            model.uStatus = uStatus;
        }
        
        self.isReloadButton = YES;
        
        [self.saveButtonArr removeAllObjects];
        
        self.returnID = DF_ID_BACK;
        
        [self conditionSignal];
    });
}

- (void)conditionSignal
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [super conditionSignal];
}

- (NSMutableArray *)saveButtonArr
{
    if (!_saveButtonArr) {
        _saveButtonArr = [[NSMutableArray alloc] init];
    }
    
    return _saveButtonArr;
}

- (void)setStrContent:(NSString *)strContent
{
    if ([_strContent isEqualToString:strContent]) {
        return;
    }
    
    _strContent = strContent;
    
    self.strTranslatedContent = _strContent;
    
    self.isStrContentTranslated = NO;
}

@end
