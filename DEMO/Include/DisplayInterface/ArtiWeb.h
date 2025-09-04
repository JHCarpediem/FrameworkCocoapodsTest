/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 网页浏览与操作接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_VIEW_WEB_H__
#define __ARTI_VIEW_WEB_H__

#include "StdInclude.h"

// 网页浏览与操作
// 1、能够html本地浏览，与浏览器浏览html功能类似
//    读取本地html文件，并显示里面的图片、文字等内容
//    浏览框只有一个按钮，后退/返回 按钮
// 
// 2、能够在线浏览（后续再增加此功能）
//
// 3、其它接口（后续再增加）

class _STD_SHOW_DLL_API_ CArtiWeb
{
public:
    CArtiWeb();


#ifdef MULTI_SYSTEM
    CArtiWeb(uint32_t thId);
#endif // MULTI_SYSTEM


    ~CArtiWeb();


    /*******************************************************************
    *    功  能：初始化浏览控件
    * 
    *    参  数：strTitle 浏览框标题
    * 
    *    返回值：true 初始化成功 false 初始化失败
    * 
    ****************************************************************************/
    void InitTitle(const std::string &strTitle); 


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
    uint32_t SetButtonVisible(bool bVisible);


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
    uint32_t AddButton(const string& strButtonText);


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
    *    相对路径，即默认为车型路径下开始
    *    例如：当前车型为EOBD，E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD
    *    html文件为test.html，则实参 strPath 设为 "test.html"
    *
    *    绝对路径
    *    例如：当前车型为EOBD，E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD
    *    html文件为test.html，则实参
    *    strPath 设为 "E:\PC_Debug\Win32Exe\Debug64\Car\Europe\EOBD\test.html"
    *
    ****************************************************************************/
    bool LoadHtmlFile(const std::string& strPath);


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
    bool LoadHtmlContent(const std::string& strContent);


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
    *                        DF_ID_FREEBTN_0
    *                        DF_ID_FREEBTN_1
    *                        DF_ID_FREEBTN_2
    *                        ...
    *                        DF_ID_FREEBTN_XX
    * 
    *    说  明：此接口为阻塞接口，直至用户点击按钮返回
    *********************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_VIEW_WEB_H__
