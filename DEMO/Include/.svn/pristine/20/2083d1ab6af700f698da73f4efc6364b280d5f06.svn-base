/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900侧边导航栏接口定义
* 创 建 人 : sujiya 20231104
* 实 现 人 : 
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTI_NAVIGATION_H_
#define _ARTI_NAVIGATION_H_

// 在界面中显示侧边导航栏（左侧），达到一个左侧菜单栏效果
// 
// 可参考 CUINavigation
// 
// 通常情况下，大屏平板（12寸或12寸以上）中使用效果较好
/*
    组件名：CArtiNavigation

    侧边导航栏，也称为“左侧导航栏”，ADAS需求增加
    1、从导航体系的层级来分，“左侧导航栏”属于界面的一级导航，“顶部导航栏”属于二级导航
    2、可任意添加导航栏项Tap，一个Tap中可以是一个MsgBox，也可以是一个Input，List等
    3、导航栏项Tap也可以是一个顶部导航栏，顶部导航栏也可以有多个Tap组成
    4、左侧导航栏，应用可置灰某项Tap，置灰后Tap将不可点击
    5、如果点击Tap，show将依次返回back，直至“左侧导航栏”的show返回Tap索引
       例如：“左侧导航栏”增加了2个TAP项，一个添加了MsgBox，一个添加了List，此时界
       面正在第一个TAP的MsgBox，当点击第二个TAP时，MsgBox的show应返回back，然后
       Navigation返回指定TAP索引（这里为1），其它依次类推
    6、Show是非阻塞的
*/

#include "StdShowMaco.h"

class _STD_SHOW_DLL_API_ CArtiNavigation
{

public:
    /* 导航栏项的类型 */
    enum eViewType
    {
        VT_NAVIG_TOP_NAVIG       = DF_TAP_TYPE_IS_TOP_NAVIG,
        VT_NAVIG_MSGBOX          = DF_TAP_TYPE_IS_MSGBOX,
        VT_NAVIG_INPUT           = DF_TAP_TYPE_IS_INPUT,
        VT_NAVIG_ACTIVE          = DF_TAP_TYPE_IS_ACTIVE,
        VT_NAVIG_ECUINFO         = DF_TAP_TYPE_IS_ECUINFO,
        VT_NAVIG_FILE_DIALOG     = DF_TAP_TYPE_IS_FILE_DIALOG,
        VT_NAVIG_FREEZE          = DF_TAP_TYPE_IS_FREEZE,
        VT_NAVIG_LIST            = DF_TAP_TYPE_IS_LIST,
        VT_NAVIG_LIVE_DATA       = DF_TAP_TYPE_IS_LIVE_DATA,
        VT_NAVIG_MENU            = DF_TAP_TYPE_IS_MENU,
        VT_NAVIG_PICTURE         = DF_TAP_TYPE_IS_PICTURE,
        VT_NAVIG_SYSTEM          = DF_TAP_TYPE_IS_SYSTEM,
        VT_NAVIG_TROUBLE         = DF_TAP_TYPE_IS_TROUBLE,

        TAP_TYPE_IS_INVALID      = 0xFF
    };

public:
    CArtiNavigation();


    ~CArtiNavigation();


    /*-----------------------------------------------------------------------------
    *    功  能：初始化左侧导航栏显示控件，同时设置标题文本
    *
    *    参  数：strTitle 标题文本
    *
    *    返回值：true 初始化成功 false 初始化失败
    -----------------------------------------------------------------------------*/
    bool InitTitle(const std::string& strTitle);
    


    /********************************************************************************
    *    功  能：添加左侧导航栏项（TAP)
    * 
    *    参  数：strTitle      导航栏项（TAP)的标题 
    *            bStatus       导航栏项（TAP)的状态，true为可用，false为不可用
    * 
    *    返回值：无
    ********************************************************************************/
    void AddTap(const string& strTitle, bool bStatus);



    /********************************************************************************
    *    功  能：设置左侧导航栏项（TAP)的类型，并且绑定对应类型的对象指针
    *
    *    参  数：index      导航栏项（TAP)的索引，表示第几个项，从0开始计
    *            eTapType   导航栏项（TAP)的类型
    *            pArtiXXXX  对象指针
    *
    *    返回值：无
    ********************************************************************************/
    bool SetTapType(uint16_t index, eViewType eTapType, void* pArtiXXXX);



    /********************************************************************************
    *    功  能：设置当前显示（Active）的导航栏项（TAP)
    *
    *    参  数：index      导航栏项的索引，表示第几个项，从0开始计
    *
    *    返回值：无
    ********************************************************************************/
    void SetCurTab(uint16_t index);



    /***************************************************************************
    *    功  能：设置导航栏项（TAP)的图标（图标在前，文字在后）
    *
    *    参  数：index          导航栏项（TAP)的索引，表示第几个项，从0开始计
    * 
    *            strIconPath    指定显示的图标路径
    *                           如果strIconPath指定图片路径串为非法路径（空串
    *                           或文件不存在），返回失败
    *
    *    返回值：无
    ***************************************************************************/
    bool SetTabIcon(uint16_t index, std::string const& strIconPath);



    /***************************************************************************
    *    功  能：设置导航栏项（TAP)的状态，锁定为置灰，不锁定为可用
    *
    *    参  数：index          导航栏项（TAP)的索引，表示第几个项，从0开始计
    *
    *            bLock          true,  为锁定，置灰
    *                           false, 不锁定，可用
    *
    *    返回值：无
    ***************************************************************************/
    bool SetTabLock(uint16_t index, bool bLock);



    /*************************************************************************
    *    功  能：显示导航栏
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 导航栏选项返回值
    *
    *            按钮为TAP组件的按钮返回，不在此返回
    *
    *    说明
    *        1. 点击了哪个TAP的索引
    * 
    **************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif // _ARTI_NAVIGATION_H_
