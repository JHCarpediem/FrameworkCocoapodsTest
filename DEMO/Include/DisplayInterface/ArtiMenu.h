/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900菜单显示控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
* 
* 说明：
*  
*     菜单界面，包含返回按钮，帮助按钮，添加的菜单，菜单图标等；
*
*   菜单界面具备颜色变化功能，即上一级选择的菜单改变颜色，提醒用户。
*   上一级菜单菜单记忆功能。
*
*   菜单采用左右滑动。
* 
*    注意：可左侧菜单树点击的选项（菜单树部分）
*
*******************************************************************************/
#ifndef _ARTIMENU_H_
#define _ARTIMENU_H_
#include "StdInclude.h"
#include "StdShowMaco.h"

class _STD_SHOW_DLL_API_ CArtiMenu
{
public:
    enum eMenuShowType
    {
        MST_TYPE_DEFAULT = 0,   // 默认类型，菜单排列由App决定，例如九宫格
        MST_TYPE_LIST    = 1,   // 菜单以List形式展示，例如竖屏
    };

public:
    CArtiMenu();
#ifdef MULTI_SYSTEM
    CArtiMenu(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiMenu();

    /**********************************************************
    *    功  能：初始化菜单显示控件，同时设置标题文本
    *    参  数：strTitle 标题文本
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle);


    /******************************************************************************
    *    功  能：设置菜单排列显示方式，默认为由App决定
    *
    *    参  数：eMenuShowType  菜单排列显示方式类型
    *            MST_TYPE_DEFAULT = 0,  默认类型，菜单排列由App决定，例如九宫格
    *            MST_TYPE_LIST    = 1,  菜单以List形式展示，例如竖屏
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    * 
    *    说 明： 如果MenuShowType接口没有被调用过，默认为MST_TYPE_DEFAULT
    ******************************************************************************/
    uint32_t MenuShowType(eMenuShowType eType);


    /******************************************************************************
    *    功  能：添加菜单项
    * 
    *    参  数：strItem   菜单项名称
    *            bStatus   菜单项的状态
    *
    *            DF_ST_MENU_NORMAL       正常状态
    *            DF_ST_MENU_EXPIR        软件过期
    *            DF_ST_MENU_DISABLE      失能状态，不可用状态
    * 
    *    返回值：无
    ******************************************************************************/
    void AddItem(const string& strItem);
    void AddItem(const string& strItem, uint32_t uStatus/* = DF_ST_MENU_NORMAL*/);


    /**************************************************************************************
    *    功  能：设置菜单的状态
    *
    *    参  数：uIndex    指定的菜单项
    *            bStatus   菜单项的状态
    *
    *            DF_ST_MENU_NORMAL       正常状态
    *            DF_ST_MENU_EXPIR        软件过期
    *            DF_ST_MENU_DISABLE      失能状态，不可用状态
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：
    *            如果没有调用此接口，默认的菜单项状态为AddItem中指定的初始状态
    ****************************************************************************************/
    uint32_t SetMenuStatus(uint16_t uIndex, uint32_t uStatus);


    /**********************************************************
    *    功  能：获取指定菜单项的文本串
    *    参  数：uIndex 指定的菜单项
    *    返回值：string 指定菜单项的文本串
    **********************************************************/
    string GetItem(uint16_t uIndex);


    /**********************************************************
    *    功  能：设置指定菜单项需要附加的图片
    * 
    *    参  数：uIndex 指定的菜单项
    *            strIconPath   需要设置的图片路径
    *            strShortName  菜单项的名称缩写
    *                          如果strShortName为空串，则不改变菜
    *                          单项的名称
    * 
    *    返回值：无
    * 
    *    注 意： 菜单图标的大小暂设定为150*150，输入图标长宽如果
    *            不等于150，等比例缩放到长宽最大值为150显示
    **********************************************************/
    void SetIcon(uint16_t uIndex, 
        const string& strIconPath, 
        const string& strShortName = "");


    /**********************************************************
    *    功  能：设置帮助按钮是否显示，控件默认不显示
    *    参  数：bIsVisible = true  显示帮助按钮
    *            bIsVisible = false 隐藏帮助按钮
    *    返回值：无
    **********************************************************/
    void SetHelpButtonVisible(bool bIsVisible = true);


    /**********************************************************
    *    功  能：设置左侧菜单树要不要显示，默认不显示
    *    参  数：bIsVisible = true  显示左侧菜单树
    *            bIsVisible = false 隐藏左侧菜单树
    *    返回值：无
    **********************************************************/
    void SetMenuTreeVisible(bool bIsVisible = true);


    /**********************************************************
    *    功  能：设置菜单ID给显示层，由显示层存储，必要时去取
    *    参  数：strMenuId 菜单ID
    *    返回值：无
    **********************************************************/
    void SetMenuId(const string& strMenuId);


    /**********************************************************
    *    功  能：获取菜单树选择项的菜单ID
    *    参  数：无
    *    返回值：string 设置过的菜单ID
    **********************************************************/
    string GetMenuId();


    /**********************************************************
    *    功  能：显示菜单
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *            选中菜单树区域，菜单项，返回
    *            阻塞接口
    **********************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
