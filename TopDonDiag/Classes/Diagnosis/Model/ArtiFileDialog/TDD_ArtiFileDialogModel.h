//
//  TDD_ArtiFileDialogModel.h
//  AD200
//
//  Created by 何可人 on 2022/5/24.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtiFileDialogFileModel : NSObject
@property (nonatomic, assign) int type; //0、文件 1、普通目录 2、根目录 3、上一级目录
@property (nonatomic, strong) NSString * fileName; //文件名字
@end

@interface TDD_ArtiFileDialogModel : TDD_ArtiModelBase
@property (nonatomic, assign) BOOL bType; //  true    文件打开/ false   文件另存为
@property (nonatomic, strong) NSString * strPath; //指定文件打开或者文件另存为的默认路径
@property (nonatomic, strong) NSString * strFilter; //用于指定可应用于文件的筛选器
@property (nonatomic, strong) NSString * currentPath; //当前路径
@property (nonatomic, strong) NSString * currentFileName; //当前选择的文件

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
+ (void)InitTypeWithId:(uint32_t)ID bType:(BOOL)bType strPath:(NSString *)strPath;


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
+ (void)SetFilterWithId:(uint32_t)ID strFilter:(NSString *)strFilter;


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
+ (NSString *)GetPathNameWithId:(uint32_t)ID;


/******************************************************************
*    功  能：调用此函数获取在对话框中输入的文件名称
*
*    参  数：无
*
*    返回值：在对话框中输入的文件的文件名，包括了后缀
*
*    例如：VINToCar.dat
********************************************************************/
+ (NSString *)GetFileNameWithId:(uint32_t)ID;


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

NS_ASSUME_NONNULL_END
