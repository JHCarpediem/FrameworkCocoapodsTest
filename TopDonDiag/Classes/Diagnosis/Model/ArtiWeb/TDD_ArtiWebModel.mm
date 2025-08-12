//
//  TDD_ArtiWebModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/23.
//

#import "TDD_ArtiWebModel.h"

#if useCarsFramework
#import <CarsFramework/RegWeb.hpp>
#else
#import "RegWeb.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiWebModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegWeb::Construct(ArtiWebConstruct);
    CRegWeb::Destruct(ArtiWebDestruct);
    CRegWeb::InitTitle(ArtiWebInitTitle);
    CRegWeb::LoadHtmlFile(ArtiWebLoadHtmlFile);
    CRegWeb::LoadHtmlContent(ArtiWebLoadHtmlContent);
    CRegWeb::AddButton(ArtiWebAddButton);
    CRegWeb::Show(ArtiWebShow);
    CRegWeb::SetButtonVisible(ArtiWebSetBackButtonVisible);
}

void ArtiWebConstruct(uint32_t id)
{
    [TDD_ArtiWebModel Construct:id];
}

void ArtiWebDestruct(uint32_t id)
{
    [TDD_ArtiWebModel Destruct:id];
}

bool ArtiWebInitTitle(uint32_t id, const std::string& strTitle)
{
    return [TDD_ArtiWebModel InitTitleWithId:id strTitle:[TDD_CTools CStrToNSString:strTitle]];
}

uint32_t ArtiWebSetBackButtonVisible(uint32_t id, bool bIsVisible)
{
    return [TDD_ArtiWebModel SetBackButtonVisibleWithId:id bIsVisible:bIsVisible];
}

bool ArtiWebLoadHtmlFile(uint32_t id, const std::string& strPath)
{
    return [TDD_ArtiWebModel LoadHtmlFileWithId:id strPath:[TDD_CTools CStrToNSString:strPath]];
}

bool ArtiWebLoadHtmlContent(uint32_t id, const std::string& strContent)
{
    return [TDD_ArtiWebModel LoadHtmlContentWithId:id strContent:[TDD_CTools CStrToNSString:strContent]];
}

uint32_t ArtiWebAddButton(uint32_t id, const std::string& strButtonText)
{
    return [TDD_ArtiWebModel AddButtonWithId:id strButtonText:[TDD_CTools CStrToNSString:strButtonText]];
}

uint32_t ArtiWebShow(uint32_t id)
{
    return [TDD_ArtiWebModel ShowWithId:id];
}

+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiWebModel * model = (TDD_ArtiWebModel *)[self getModelWithID:ID];
    
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
        
    buttonModel.uButtonId = DF_ID_BACK;
    
    buttonModel.strButtonText = @"back";
    
    buttonModel.bIsEnable = YES;
    
    buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    
    [model.buttonArr addObject:buttonModel];
}
/*******************************************************************
*    功  能：设置html路径并加载此静态html文件
*
*    参  数：strPath 指定需要浏览的文件路径
*                    路径分两种类型：相对路径和绝对路径
*                     相对路径以车型路径为基准
*
*    返回值：true 加载成功 false 加载失败
*            如果html文件不存在，加载失败
*
*    说 明： strPath 路径分两种类型：相对路径和绝对路径
*
*     相对路径，即默认为车型路径下开始
*    例如：当前车型为EOBD，E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD
*    html文件为test.html，则实参 strPath 设为 "test.html"
*
*    绝对路径
*    例如：当前车型为EOBD，E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD
*    html文件为test.html，则实参
*    strPath 设为 "E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD\test.html"
*
****************************************************************************/
+ (BOOL)LoadHtmlFileWithId:(uint32_t)ID strPath:(NSString *)strPath
{
    HLog(@"%@ - 设置html路径并加载此静态html文件 - ID:%d - strPath ：%@", [self class], ID, strPath);
    
    TDD_ArtiWebModel * model = (TDD_ArtiWebModel *)[self getModelWithID:ID];
    
    model.strContent = @"";
    
    model.strPath = strPath;
    
    if ([model.strPath isEqualToString:strPath]) {
        return YES;
    }
    
    return NO;
}

/*******************************************************************
*    功  能：设置html内容并加载，内容必需符合html格式
*
*    参  数：strContent 指定需要显示的html内容
*
*    返回值：true 加载成功 false 加载失败
*
*    说 明： 内容需符合html格式
*
****************************************************************************/
+ (BOOL)LoadHtmlContentWithId:(uint32_t)ID strContent:(NSString *)strContent
{
    HLog(@"%@ - 设置html内容并加载 - ID:%d - strContent ：%@", [self class], ID, strContent);
    
    TDD_ArtiWebModel * model = (TDD_ArtiWebModel *)[self getModelWithID:ID];
    
    model.strPath = @"";
    
    model.strContent = strContent;
    
    if ([model.strContent isEqualToString:strContent]) {
        return YES;
    }
    
    return NO;
}

/**********************************************************
*    功  能：自由添加按钮
*
*    参  数：strButtonText 按钮名称
*
*    返回值：按钮的ID，此ID用于DelButton接口的参数
*            可能的返回值：
*                         DF_ID_FREEBTN_0
*                         DF_ID_FREEBTN_1
*                         DF_ID_FREEBTN_2
*                         DF_ID_FREEBTN_3
*                         DF_ID_FREEBTN_XX
**********************************************************/
+ (uint32_t)AddButtonWithId:(uint32_t)ID strButtonText:(NSString *)strButtonText
{
    HLog(@"%@ - 添加按钮 - ID:%d - strButtonText:%@", [self class], ID, strButtonText);
    
    TDD_ArtiWebModel * model = (TDD_ArtiWebModel *)[self getModelWithID:ID];
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    
    buttonModel.uButtonId = DF_ID_FREEBTN_0 + (uint32_t)model.buttonArr.count - 1;
    
    buttonModel.strButtonText = strButtonText;
    
    buttonModel.bIsEnable = YES;
    
    [model.buttonArr addObject:buttonModel];
    
    model.isReloadButton = YES;
    
    return buttonModel.uButtonId;
}

/******************************************************************
*    功  能：设置固定按钮“后退”是否隐藏
*
*    参  数：bVisible    true  固定“后退”按钮隐藏，按钮不可见
*                        false 固定“后退”按钮可见
*
*    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
*            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
*            其它值，暂无意义
*
*    说 明： 如果没有调用此接口，默认为按钮状态为可见并且可点击
********************************************************************/

+ (uint32_t )SetBackButtonVisibleWithId:(uint32_t)ID bIsVisible:(BOOL)bIsVisible
{
    HLog(@"%@ - 设置后退按钮是否显示 - ID:%d - bIsVisible:%d", [self class], ID, bIsVisible);
    
    TDD_ArtiWebModel * model = (TDD_ArtiWebModel *)[self getModelWithID:ID];
    
    model.isBackButtonVisible = bIsVisible;
    return 1;
}

/********************************************************************
*    功  能：显示浏览对话框
*
*    参  数：无
*
*    返回值：uint32_t 组件界面按键返回值
*            指示用户是点击了"返回"按钮
*
*     可能存在以下返回：
*                        DF_ID_BACK
*                        DF_ID_CANCEL
*
*    说  明：此接口为阻塞接口，直至用户点击返回按钮
*********************************************************************/

- (void)setIsBackButtonVisible:(BOOL)isBackButtonVisible
{
    _isBackButtonVisible = isBackButtonVisible;
    
    TDD_ArtiButtonModel * buttonModel = self.buttonArr.firstObject;
        
    if (!isBackButtonVisible) {
        buttonModel.uStatus = ArtiButtonStatus_ENABLE;
    }else {
        buttonModel.uStatus = ArtiButtonStatus_UNVISIBLE;
    }
    
    self.isReloadButton = YES;
}
@end
