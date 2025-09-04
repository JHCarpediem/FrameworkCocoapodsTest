/*******************************************************************************
* Copyright (C), 2024~ , TOPDON Technology Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : CarPal Guru 刷隐藏 功能主菜单
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_HID_MENU_H__
#define __ARTI_HID_MENU_H__
#include "StdInclude.h"
#include "StdShowMaco.h"

// 刷隐藏 功能主菜单，是一个二级菜单，一级菜单点击事件诊断不可见
// 
// Show 为阻塞接口，返回对应的二级菜单点击
// 
// 此界面无按钮

class _STD_SHOW_DLL_API_ CArtiHidMenu
{
public:
    CArtiHidMenu();
#ifdef MULTI_SYSTEM
    CArtiHidMenu(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiHidMenu();


    /****************************************************************************************
    *    功  能：初始化两级菜单标题，即刷隐藏功能菜单界面的标题，也即第一级菜单界面的标题，
    *            第二级界面的标题是第一级对应的菜单名称
    *
    *    参  数：strTitle    标题文本
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            初始化成功返回1
    *            其它返回值，暂无意义
    *
    *    说  明：调用此接口后，相当于重新初始化，其它接口需再次调用才会生效
    ****************************************************************************************/
    uint32_t InitTitle(const string& strTitle);


    /****************************************************************************************
    *    功  能：在界面顶部设置功能执行的文本提示
    *
    *    参  数：strTipsContent   对应的文本提示内容
    *                             如果strTipsContent为空串，则不显示提示标题
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            设置成功返回1
    *            其它返回值，暂无意义
    *
    *    说  明：如果没有设置（没有调用此接口），则不显示提示内容
    *            如果strTipsContent为空串，则取消之前的接口设置，即没有顶部文本提示
    ****************************************************************************************/
    uint32_t SetTipsOnTop(const string& strTipsContent);


    /****************************************************************************************
    *    功  能：设置默认进入第二级菜单界面
    *
    *    参  数：Index   对应的第一级菜单项偏移
    *                    如果index的大小超出一级菜单总数，将不进入该二级菜单界面
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            设置成功返回对应的index
    *            设置失败，返回-1
    *            其它返回值，暂无意义
    *
    *    说  明：如果没有设置（没有调用此接口），则默认进入一级菜单界面
    ****************************************************************************************/
    uint32_t SetDefaultLevel2nd(uint32_t Index);


    /****************************************************************************************
    *    功  能：添加对应的功能大类菜单项，含二级子功能列表
    *
    *    参  数：Item    stHiddenItem结构的菜单项
    * 
    *                    stHiddenItem结构体定义：
    *                    struct stHiddenItem
    *                    {
    *                        std::string strName;
    *                        std::string strIconPath;
    *                        std::vector<stHiddenNode> vctNodes;
    *                    };
    *                    struct stHiddenNode
    *                    {
    *                        std::string strName;
    *                        std::string strCurValue;
    *                        uint32_t    uCurStatus;
    *                        std::string strFuncId;
    *                        std::string strIconPath;
    *                    };
    * 
    *                   对于功能大类菜单项，strName不能为空
    * 
    *                   对于功能子类菜单项的图标，当为App存储菜单图片时，
    *                   strIconPath 为eHiddenMenuMask的枚举字串值，例如
    *                   "HMM_CHASSIS_ENGINE_CLASS"  表示 HMM_CHASSIS_ENGINE_CLASS   = (1 << 0) 的图标
    *                   "HMM_DRIVING_STEER_CLASS"   表示 HMM_DRIVING_STEER_CLASS    = (1 << 1) 的图标
    *                   "HMM_AC_CLASS"              表示 HMM_AC_CLASS               = (1 << 2) 的图标
    *                   "HMM_IM_CLASS"              表示 HMM_IM_CLASS               = (1 << 3) 的图标
    *                   "HMM_LIGHTS_CLASS"          表示 HMM_LIGHTS_CLASS           = (1 << 4) 的图标
    *                   "HMM_LOCK_CLASS"            表示 HMM_LOCK_CLASS             = (1 << 5) 的图标
    *                   "HMM_MIRRORS_CLASS"         表示 HMM_MIRRORS_CLASS          = (1 << 6) 的图标
    *                   "HMM_DOOR_CLASS"            表示 HMM_DOOR_CLASS             = (1 << 7) 的图标
    *                   "HMM_WIPERS_CLASS"          表示 HMM_WIPERS_CLASS           = (1 << 8) 的图标
    *                   "HMM_SEATS_CLASS"           表示 HMM_SEATS_CLASS            = (1 << 9) 的图标
    *                   "HMM_WARNING_OTHER_CLASS"   表示 HMM_WARNING_OTHER_CLASS    = (1 << 10)的图标
    * 
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            添加成功返回对应菜单的偏移，从0开始计
    *
    *    说  明：如果没有添加任何菜单项，将显示一个空界面
    ****************************************************************************************/
    uint32_t AddItem(const stHiddenItem& Item);


    /****************************************************************************************
    *    功  能：修改对应节点功能项的当前值
    *
    *    参  数：L1               一级菜单偏移
    *            L2               二级菜单偏移
    * 
    *            uCurStatus       对应的功能当前值，例如HNS_FUNC_HIDDEN_OK
    *                             或者HNS_FUNC_HIDDEN_FAILED
    * 
    *            strCurValue      对应的功能当前值，例如“关闭”
    * 
    *            如果L1和L2偏移超出范围，不做修改
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *
    *            修改成功返回对应菜单的偏移，偏移规则跟Show返回规则一致
    *            例如，L1 = 1, L2 = 2，修改成功返回 0x00010002
    *            修改失败，返回-1，例如L1和L2偏移超出范围
    *            其它值，暂无意义
    *
    *    说  明：暂无
    ****************************************************************************************/
    uint32_t SetNodeCurrVal(uint32_t L1, uint32_t L2, uint32_t uCurStatus, const std::string& strCurValue);


    /****************************************************************************************
    *    功  能：显示刷隐藏功能大类菜单，阻塞接口
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 组件界面点击菜单返回值
    * 
    *            一级菜单偏移为高16位，二级菜单偏移为低16位
    * 
    *            举例：用户选择了功能大类的第2项（偏移1）“灯光设置”下的第1项（偏移0）子功能
    *                  “日间行车灯”，则返回值为 0x00010000
    * 
    *            举例：用户选择了功能大类的第3项（偏移2）“座椅设置”下的第2项（偏移1）子功能
    *                  “高低调节”，则返回值为 0x00020001
    * 
    *    说  明：
    *            阻塞接口
    *            界面无固定按钮和自由添加的按钮
    *            如果点击了左上角的返回按钮，返回DF_ID_BACK
    ****************************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif // __ARTI_HID_MENU_H__
