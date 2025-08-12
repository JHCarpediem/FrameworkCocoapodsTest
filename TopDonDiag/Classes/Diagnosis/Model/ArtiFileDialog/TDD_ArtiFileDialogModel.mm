//
//  TDD_ArtiFileDialogModel.m
//  AD200
//
//  Created by 何可人 on 2022/5/24.
//

#import "TDD_ArtiFileDialogModel.h"

#if useCarsFramework
#import <CarsFramework/RegFileDialog.hpp>
#else
#import "RegFileDialog.hpp"
#endif

#import "TDD_CTools.h"

@implementation TDD_ArtiFileDialogModel

#pragma mark 注册方法
+ (void)registerMethod
{
    HLog(@"%@ - 注册方法", [self class]);

    CRegFileDialog::Construct(ArtiFileDialogConstruct);
    CRegFileDialog::Destruct(ArtiFileDialogDestruct);
    CRegFileDialog::InitType(ArtiFileDialogInitType);
    CRegFileDialog::SetFilter(ArtiFileDialogSetFilter);
    CRegFileDialog::GetPathName(ArtiFileDialogGetPathName);
    CRegFileDialog::GetFileName(ArtiFileDialogGetFileName);
    CRegFileDialog::Show(ArtiFileDialogShow);
}

void ArtiFileDialogConstruct(uint32_t id)
{
    [TDD_ArtiFileDialogModel Construct:id];
}

void ArtiFileDialogDestruct(uint32_t id)
{
    [TDD_ArtiFileDialogModel Destruct:id];
}

void ArtiFileDialogInitType(uint32_t id, bool bType, const std::string& strPath)
{
    [TDD_ArtiFileDialogModel InitTypeWithId:id bType:bType strPath:[TDD_CTools CStrToNSString:strPath]];
}

void ArtiFileDialogSetFilter(uint32_t id, const std::string& strFilter)
{
    [TDD_ArtiFileDialogModel SetFilterWithId:id strFilter:[TDD_CTools CStrToNSString:strFilter]];
}

const std::string ArtiFileDialogGetPathName(uint32_t id)
{
    NSString * str = [TDD_ArtiFileDialogModel GetPathNameWithId:id];
    
    return [TDD_CTools NSStringToCStr:str];
}

const std::string ArtiFileDialogGetFileName(uint32_t id)
{
    NSString * str = [TDD_ArtiFileDialogModel GetFileNameWithId:id];
    
    return [TDD_CTools NSStringToCStr:str];
}

uint32_t ArtiFileDialogShow(uint32_t id)
{
    return [TDD_ArtiFileDialogModel ShowWithId:id];
}


+ (void)Construct:(uint32_t)ID
{
    [super Construct:ID];
    
    TDD_ArtiFileDialogModel * model = (TDD_ArtiFileDialogModel *)[self getModelWithID:ID];
    
    TDD_ArtiButtonModel * buttonModel = [[TDD_ArtiButtonModel alloc] init];
    
    buttonModel.uButtonId = DF_ID_OK;
    
    buttonModel.strButtonText = @"app_confirm";
    
    buttonModel.bIsEnable = YES;
    
    [model.buttonArr addObject:buttonModel];
    
    model.isReloadButton = YES;
}

/**********************************************************
*    功  能：初始化文件对话框控件，同时设置对话框类型及默认路径
*
*    参  数：bType 指定要创建的对话框类型的参数，默认为文件打开
*                  true    文件打开
*                  false   文件另存为
*
*            strPath 指定文件打开或者文件另存为的默认路径
*                    例如：当前车型为EOBD，则
*                    E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD
*
*    返回值：无
*
*    说 明： 如果没有调用此接口，bType 默认为文件打开,
*            strPath路径为当前车型路径
**********************************************************/
+ (void)InitTypeWithId:(uint32_t)ID bType:(BOOL)bType strPath:(NSString *)strPath
{
    HLog(@"%@ - 初始化文件对话框控件，同时设置对话框类型及默认路径 - ID:%d - bType ：%d - strPath : %@", [self class], ID, bType, strPath);
    
    [self Destruct:ID];
    
    TDD_ArtiFileDialogModel * model = (TDD_ArtiFileDialogModel *)[self getModelWithID:ID];
    
    if (!model) {
        [self Construct:ID];
        
        model = (TDD_ArtiFileDialogModel *)[self getModelWithID:ID];
    }
    
    model.bType = bType;
    
    model.strPath = strPath;
    
    model.currentPath = strPath;
}


/**********************************************************
*    功  能：用于指定可应用于文件的筛选器
*
*    参  数：strFilter 字符串，用于指定可应用于文件的筛选器
*             *.*    即 All Files (*.*)|*.*
*            *.xls  即 Worksheet Files (*.xls)|*.xls
*            *.txt  即 txt file (*.txt)|*.txt
*
*    返回值：无
*
*     说 明： 参考MFC接口CFileDialog中的lpszFilter参数
*
*            如果没有调用此接口，默认为 *.*
**********************************************************/
+ (void)SetFilterWithId:(uint32_t)ID strFilter:(NSString *)strFilter
{
    HLog(@"%@ - 用于指定可应用于文件的筛选器 - ID:%d - strFilter : %@", [self class], ID, strFilter);
    
    TDD_ArtiFileDialogModel * model = (TDD_ArtiFileDialogModel *)[self getModelWithID:ID];
    
    model.strFilter = [strFilter componentsSeparatedByString:@"."].lastObject;
}


/******************************************************************
*    功  能：调用此函数获取在对话框中输入的文件的完整路径
*
*    参  数：无
*
*    返回值：在对话框中输入的文件的完整路径
*
*    说  明：文件名的路径包括文件的标题以及整个目录路径
*
*    例如：
*         E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD\VINToCar.dat
********************************************************************/
+ (NSString *)GetPathNameWithId:(uint32_t)ID
{
    HLog(@"%@ - 调用此函数获取在对话框中输入的文件的完整路径 - ID:%d", [self class], ID);
    
    TDD_ArtiFileDialogModel * model = (TDD_ArtiFileDialogModel *)[self getModelWithID:ID];
    
    return [model.currentPath stringByAppendingPathComponent:model.currentFileName];
}


/******************************************************************
*    功  能：调用此函数获取在对话框中输入的文件名称
*
*    参  数：无
*
*    返回值：在对话框中输入的文件的文件名，包括了后缀
*
*    例如：VINToCar.dat
********************************************************************/
+ (NSString *)GetFileNameWithId:(uint32_t)ID
{
    HLog(@"%@ - 调用此函数获取在对话框中输入的文件名称 - ID:%d", [self class], ID);
    
    TDD_ArtiFileDialogModel * model = (TDD_ArtiFileDialogModel *)[self getModelWithID:ID];
    
    if (model.currentFileName.length > 0) {
        return model.currentFileName;
    }else {
        return [model.currentPath lastPathComponent];
    }
}   


/********************************************************************
*    功  能：显示文件对话框，并允许用户浏览文件和目录并输入文件名
*            此接口为阻塞接口，直至用户选择文件确认完成
*
*    参  数：无
*
*    返回值：uint32_t 组件界面按键返回值
*            指示用户是选择了"确定"还是"取消"按钮
*
*     可能存在以下返回：
*                        DF_ID_OK
*                        DF_ID_CANCEL
*
*    说  明：参考MFC接口CFileDialog中的DoModal()接口
*********************************************************************/

@end

@implementation ArtiFileDialogFileModel

@end
