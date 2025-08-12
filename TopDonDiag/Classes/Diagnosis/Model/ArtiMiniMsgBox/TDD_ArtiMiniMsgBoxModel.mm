//
//  TDD_ArtiMiniMsgBoxModel.m
//  TopDonDiag
//
//  Created by lk_ios2023002 on 2023/7/18.
//

#import "TDD_ArtiMiniMsgBoxModel.h"
#if useCarsFramework
#import <CarsFramework/RegMiniMsgBox.hpp>
#else
#import "RegMiniMsgBox.hpp"
#endif


#import "TDD_CTools.h"
@implementation TDD_ArtiMiniMsgBoxModel
#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegMiniMsgBox::artiShowMiniMsgBox(ArtiMiniMsgBoxArtiShowMsgBox);
    CRegMiniMsgBox::Construct(ArtiMiniMsgBoxConstruct);
    CRegMiniMsgBox::Destruct(ArtiMiniMsgBoxDestruct);
    CRegMiniMsgBox::InitMsgBox(ArtiMiniMsgBoxInitMsgBox);
    CRegMiniMsgBox::SetTitle(ArtiMiniMsgBoxSetTitle);
    CRegMiniMsgBox::SetContent(ArtiMiniMsgBoxSetContent);
    CRegMiniMsgBox::AddButton(ArtiMiniMsgBoxAddButton);
    CRegMiniMsgBox::SetButtonType(ArtiMiniMsgBoxSetButtonType);
    CRegMiniMsgBox::SetButtonStatus(ArtiMiniMsgBoxSetButtonStatus);
    CRegMiniMsgBox::SetButtonText(ArtiMiniMsgBoxSetButtonText);
    CRegMiniMsgBox::SetAlignType(ArtiMiniMsgBoxSetAlignType);
    CRegMiniMsgBox::SetBusyVisible(ArtiMiniMsgBoxSetBusyVisible);
    CRegMiniMsgBox::Show(ArtiMiniMsgBoxShow);
}

uint32_t ArtiMiniMsgBoxArtiShowMsgBox(const std::string& strTitle,
                        const std::string& strContent,
                        uint32_t uButton,
                        uint16_t uAlignType)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];

    NSString * Content = [TDD_CTools CStrToNSString:strContent];
    
    return [TDD_ArtiMiniMsgBoxModel artiShowMiniMsgBoxWithStrTitle:Title strContent:Content uButton:uButton uAlignType:uAlignType];
}

void ArtiMiniMsgBoxConstruct(uint32_t id)
{
    [TDD_ArtiMiniMsgBoxModel Construct:id];
}

void ArtiMiniMsgBoxDestruct(uint32_t id)
{
    [TDD_ArtiMiniMsgBoxModel Destruct:id];
}

bool ArtiMiniMsgBoxInitMsgBox(uint32_t id, const std::string& strTitle, const std::string& strContent, uint32_t uButtonType, uint16_t uAlignType)
{
    NSString * Title = [TDD_CTools CStrToNSString:strTitle];

    NSString * Content = [TDD_CTools CStrToNSString:strContent];

    return [TDD_ArtiMiniMsgBoxModel InitMsgBoxWithId:id strTitle:Title strContent:Content uButtonType:uButtonType uAlignType:uAlignType];
}

void ArtiMiniMsgBoxSetTitle(uint32_t id, const std::string& strSetTitle)
{
    NSString * Title = [TDD_CTools CStrToNSString:strSetTitle];

    [TDD_ArtiMiniMsgBoxModel SetTitleWithId:id strTitle:Title];
}

void ArtiMiniMsgBoxSetContent(uint32_t id, const std::string& strContent)
{
    NSString * Content = [TDD_CTools CStrToNSString:strContent];

    [TDD_ArtiMiniMsgBoxModel SetContentWithId:id strContent:Content];
}

uint32_t ArtiMiniMsgBoxAddButton(uint32_t id, const std::string& strButtonText)
{
    NSString * ButtonText = [TDD_CTools CStrToNSString:strButtonText];

    return [TDD_ArtiMiniMsgBoxModel AddButtonExWithId:id strButtonText:ButtonText];
}


void ArtiMiniMsgBoxSetButtonType(uint32_t id, uint32_t uButtonTyp)
{
    [TDD_ArtiMiniMsgBoxModel SetButtonTypeWithId:id uButtonType:uButtonTyp];
}

void ArtiMiniMsgBoxSetButtonStatus(uint32_t id, uint16_t uIndex, uint32_t uStatus)
{
    [TDD_ArtiMiniMsgBoxModel SetButtonStatusWithId:id uIndex:uIndex uStatus:uStatus];
}

void ArtiMiniMsgBoxSetButtonText(uint32_t id, uint16_t uIndex, const std::string& strButtonText)
{
    NSString * ButtonText = [TDD_CTools CStrToNSString:strButtonText];

    [TDD_ArtiMiniMsgBoxModel SetButtonTextWithId:id uIndex:uIndex strButtonText:ButtonText];
}

void ArtiMiniMsgBoxSetAlignType(uint32_t id, uint16_t uAlignType)
{
    [TDD_ArtiMiniMsgBoxModel SetAlignTypeWithId:id uAlignType:uAlignType];
}

void ArtiMiniMsgBoxSetBusyVisible(uint32_t id, bool bIsVisible)
{
    [TDD_ArtiMiniMsgBoxModel SetBusyVisibleWithId:id bIsVisible:bIsVisible];
}


uint32_t ArtiMiniMsgBoxShow(uint32_t id)
{
    return [TDD_ArtiMiniMsgBoxModel ShowWithId:id];
}

/**********************************************************
*    功  能：初始化消息框
*    参  数：strTitle 消息框标题文本
*            strContent 消息框内容文本
*            uButtonType 消息框按钮类型
*            uAlignType 消息框文本对齐方式
*    返回值：true 初始化成功 false 初始化失败
*
*    注：
*     uButtonType值可以如下：
*            DF_MB_NOBUTTON             //  无按钮的非阻塞消息框
*            DF_MB_YES                  //  Yes 按钮的阻塞消息框
*            DF_MB_NO                   //  No 按钮的阻塞消息框
*            DF_MB_YESNO                //  Yes/No 按钮的阻塞消息框
*            DF_MB_OK                   //  OK 按钮的阻塞消息框
*            DF_MB_CANCEL               //  Cancel 按钮的阻塞消息框
*            DF_MB_OKCANCEL             //  OK/Cancel 按钮的阻塞消息框
*            DF_MB_FREE | DF_MB_BLOCK   //  自由按钮的阻塞消息框
*
**********************************************************/
  
+ (uint32_t)artiShowMiniMsgBoxWithStrTitle:(NSString *)strTitle strContent:(NSString *)strContent uButton:(uint32_t)uButton uAlignType:(uint32_t)uAlignType
{
    HLog(@"%@ - 全局Mini消息框 - strTitle ：%@ - strContent : %@ - uButtonType : %d - uAlignType : %d", [self class], strTitle, strContent, uButton, uAlignType);
    TDD_ArtiMiniMsgBoxModel * model = [[TDD_ArtiMiniMsgBoxModel alloc] init];
    model.returnID = DF_ID_NOKEY;
    model.isLock = YES;
    model.strTitle = strTitle;
    model.strContent = strContent;
    model.uButtonType = uButton;
    model.uAlignType = uAlignType;
    return [model show];
    
}

+ (BOOL)InitMsgBoxWithId:(uint32_t)ID strTitle:(NSString *)strTitle strContent:(NSString *)strContent uButtonType:(uint32_t)uButtonType uAlignType:(uint32_t)uAlignType
{
    HLog(@"%@ - 初始化Mini消息框 - ID:%d - strTitle ：%@ - strContent : %@ - uButtonType : %d - uAlignType : %d", [self class], ID, strTitle, strContent, uButtonType, uAlignType);
    
    [self Destruct:ID];
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    }
    
    model.strTitle = strTitle;
    
    model.strContent = strContent;
    
    model.uButtonType = uButtonType;
    
    model.uAlignType = uAlignType;
    
    return YES;
}

/**********************************************************
*    功  能：设置消息框标题
*    参  数：strTitle 消息框标题
*    返回值：无
**********************************************************/
+ (void)SetTitleWithId:(uint32_t)ID strTitle:(NSString *)strTitle
{
    HLog(@"%@ - 设置Mini消息框标题 - ID:%d - strTitle ：%@", [self class], ID, strTitle);
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    model.strTitle = strTitle;
}

/**********************************************************
*    功  能：设置消息框文本内容
*    参  数：strContent 消息框内容
*    返回值：无
**********************************************************/
+ (void)SetContentWithId:(uint32_t)ID strContent:(NSString *)strContent
{
    HLog(@"%@ - 设置Mini消息框文本内容 - ID:%d - strContent ：%@", [self class], ID, strContent);
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    model.strContent = strContent;
}

/**********************************************************
*    功  能：设置消息框按钮类型
*    参  数：uButtonTyp 按钮类型
*    返回值：无
**********************************************************/
+ (void)SetButtonTypeWithId:(uint32_t)ID uButtonType:(uint32_t)uButtonType
{
    HLog(@"%@ - 设置Mini消息框按钮类型 - ID:%d - uButtonTyp ：%d", [self class], ID, uButtonType);
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    model.uButtonType = uButtonType;
}

/**********************************************************
*    功  能：设置消息框内容对齐方式
*    参  数：uAlignType 对齐方式
*    返回值：无
**********************************************************/
+ (void)SetAlignTypeWithId:(uint32_t)ID uAlignType:(uint32_t)uAlignType
{
    HLog(@"%@ - 设置Mini消息框内容对齐方式 - ID:%d - uButtonTyp ：%d", [self class], ID, uAlignType);
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    model.uAlignType = uAlignType;
}

/**********************************************************
*    功  能：设置消息框忙状态是否显示
*    参  数：bIsVisible = true; 显示消息框忙状态，如沙漏或者其他
*            bIsVisible = false; 不显示显示消息框忙状态
*    返回值：无
**********************************************************/
+ (void)SetBusyVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置Mini消息框忙状态是否显示 - ID:%d - bIsVisible ：%d", [self class], ID, bIsVisible);
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    model.isBusyVisible = bIsVisible;
}

+ (void)SetButtonTextWithId:(uint32_t)ID uIndex:(uint32_t)uIndex strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 设置Mini消息框按钮文本 - ID:%d - uIndex:%d - strButtonText:%@", [self class], ID, uIndex, strButtonText);
    
    if (uIndex >= DF_ID_FREEBTN_0) {
        uIndex -= DF_ID_FREEBTN_0;
    }
    
    TDD_ArtiMiniMsgBoxModel * model = (TDD_ArtiMiniMsgBoxModel *)[self getModelWithID:ID];
    
    if (model.buttonArr.count <= uIndex) {
        HLog(@"没有uIndex：%d",uIndex);
        return;
    }
    
    TDD_ArtiButtonModel * buttonModel = model.buttonArr[uIndex];
    
    buttonModel.strButtonText = strButtonText;
    
    model.isReloadButton = YES;
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

- (void)conditionSignal
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [super conditionSignal];
}

@end
