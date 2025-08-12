//
//  TDD_ArtiWebModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/23.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDD_ArtiWebModel : TDD_ArtiModelBase

@property (nonatomic, strong) NSString * strPath;

@property (nonatomic, strong) NSString * strContent;

@property (nonatomic, assign) BOOL isBackButtonVisible;
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
+ (BOOL)LoadHtmlFileWithId:(uint32_t)ID strPath:(NSString *)strPath;

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
+ (BOOL)LoadHtmlContentWithId:(uint32_t)ID strContent:(NSString *)strContent;


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

@end

NS_ASSUME_NONNULL_END
