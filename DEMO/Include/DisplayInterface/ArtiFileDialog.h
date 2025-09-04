/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900文件打开另存为接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_FILE_DIALOG_H__
#define __ARTI_FILE_DIALOG_H__

#include "StdInclude.h"

// 文件选取、文件另存为

class _STD_SHOW_DLL_API_ CArtiFileDialog
{
public:
    CArtiFileDialog();

#ifdef MULTI_SYSTEM
    CArtiFileDialog(uint32_t thId);
#endif // MULTI_SYSTEM

    ~CArtiFileDialog();

    /**************************************************************************
    *    功  能：初始化文件对话框控件，同时设置对话框类型及默认路径
    * 
    *    参  数：bType 指定要创建的对话框类型的参数，默认为文件打开
    *                  true    文件打开
    *                  false   文件另存为
    * 
    *            strPath 指定文件打开或者文件另存为的默认路径（包括文件名）
    *
    *                    例如：bType为文件打开，当前车型为EOBD，需打开Vehicle.dat
    *                    实参为：
    *                    E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD\Vehicle.dat
    *                    路径定位到EOBD文件夹，默认选择的文件名为Vehicle.dat
    *                    如果实际路径不存在，将定位到上一次操作的有效路径
    * 
    *                    例如：bType为文件另存为，当前车型为EOBD，需另存为Vehicle.dat
    *                    实参为：
    *                    E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD\Vehicle.dat
    *                    路径定位到EOBD文件夹，默认选择的文件名为Vehicle.dat
    *                    如果实际路径不存在，将定位到上一次操作的有效路径
    * 
    *                    如果文件名为空，则默认选择的文件名为空
    *                    例如：E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD\
    *                    路径定位到EOBD文件夹下，如果实际路径不存在，将定位到
    *                    上一次操作的有效路径
    * 
    *                    如果实参为：E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD
    *                    路径定位到Europe文件夹下，默认选择的文件名EOBD，即使EOBD是文件夹
    * 
    *    返回值：无
    *    
    *    说 明： 如果没有调用此接口，bType 默认为文件打开, 
    *            如果实际路径不存在，将定位到上一次操作的有效路径
    **************************************************************************/
    void InitType(bool bType, const std::string& strPath = "");


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
    * 
    *            strFilter 字符串只能是一种类型，不能是多种类型
    *            的组合
    **********************************************************/
    void SetFilter(const std::string& strFilter);


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
    std::string GetPathName();

    /******************************************************************
    *    功  能：调用此函数获取在对话框中输入的文件名称
    *
    *    参  数：无
    *
    *    返回值：在对话框中输入的文件的文件名，包括了后缀
    * 
    *    例如：VINToCar.dat
    ********************************************************************/
    std::string GetFileName();
    

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
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_FILE_DIALOG_H__
