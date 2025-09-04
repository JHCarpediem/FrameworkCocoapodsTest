/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900版本消息框按钮接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTIMSGBOX_H_
#define _ARTIMSGBOX_H_

/*
    消息框分为4种类型
    1、 固定按钮的阻塞消息框；
    2、 固定按钮的非阻塞消息框；
    3、 自由添加按钮的阻塞消息框；
    4、 自由添加按钮的非阻塞消息框。

    消息框按钮在底部，从右向左排列；无按钮的非阻塞消息框有沙漏（即是转圈效果）。
*/

#include "StdShowMaco.h"

/*
    当 uButton 指定为 固定按钮时可：
                DF_MB_NOBUTTON              无按钮的非阻塞消息框
                DF_MB_YES                   Yes 按钮的阻塞消息框
                DF_MB_NO                    No 按钮的阻塞消息框
                DF_MB_YESNO                 Yes/No 按钮的阻塞消息框
                DF_MB_OK                    OK 按钮的阻塞消息框
                DF_MB_CANCEL                Cancel 按钮的阻塞消息框
                DF_MB_OKCANCEL              OK/Cancel 按钮的阻塞消息框
                DF_MB_NEXTEXIT              Next/Exit 按钮的阻塞消息框

    全局消息框函数artiShowMsgBox无自由按钮的模式(会显示忙状态)

注意：当 uButton 指定为 DF_MB_NOBUTTON 时，artiShowMsgBox是
      会显示消息框忙状态，有忙的属性（即转圈圈效果）

注意：当 uButton 指定为 DF_MB_NOBUTTON 时，artiShowMsgBox是
      会显示消息框忙状态，有忙的属性（即转圈圈效果）
*/
    
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBox(const string& strTitle,
    const string& strContent,
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER,
    int32_t iTimer = -1);



// 适用于多线程诊断
// thId为0时，等效于 artiShowMsgBox
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBoxEx(const std::string& strTitle,
    const std::string& strContent,
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER,
    int32_t  iTimer = -1,
    uint32_t thId = 0);


// App根据指定的消息类型，绘制指定UI
// 
// uType 是消息类型
//      MBT_ERROR_DEFAULT        = 0    默认类型，即App不会做任何效果
//      MBT_ERROR_ENTER_SYS_COMM = 1    进系统失败
//      MBT_ERROR_EXEC_FUNC_COMM = 2    功能执行失败 
//                                   
//      MBT_ERROR_DATA_LOADING = 0x10,  "数据加载异常，请稍后再试！"
//      MBT_ERROR_NETWORK      = 0x11,  "网络异常，请稍后再试！"
//
//      动图效果示意图
//      MBT_IGN_ON_WITH_KEY     = 0x20,  打开点火开关动态效果示意图，(针对有钥匙的车辆)
//      MBT_IGN_ON_WITHOUT_KEY  = 0x21,  打开点火开关动态效果示意图，(针对无钥匙的车辆)
//      MBT_IGN_OFF_WITH_KEY    = 0x22,  关闭点火开关动态效果示意图，(针对有钥匙的车辆)
//      MBT_ENG_ON_WITH_BUTTON  = 0x23,  启动发动机动态效果示意图，(针对非机械钥匙的车辆)
//      MBT_MANUAL_GEAR_PARKING = 0x24,  手动挡空挡动态效果示意图，(针对手动挡的车辆)
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBox(uint32_t uType, 
    const string& strTitle = "",
    const string& strContent = "",
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER);


// 使用与小车探项目的部件测试UI
// uTestType 是部件测试类型
// uRpm, 当 uTestType 为 DF_TYPE_INTAKE_PRESSURE 进气压力传感器类型时
//       uRpm为转速
// uCountDown 倒计时参数
uint32_t _STD_SHOW_DLL_API_ artiMsgBoxActTest(const std::string& strTitle,
    const std::string& strContent, uint32_t uButton, uint32_t uTestType, uint32_t uRpm = -1, uint32_t uCountDown = -1);


// 用于ADAS动态校准或者静态校准显示步骤
// uStep 是ADAS类型
//     ACS_DYNAMIC_CALIBRATION   = 1  进入App控制的动态校准流程
//     ACS_STATIC_CALIBRATION    = 2  进入App控制的静态校准流程
// 
//     ACS_CALIBRATION_WHEEL_BROW_HEIGHT = 0x10 轮眉高度
//
// 阻塞界面，直至需要诊断程序参与才返回
uint32_t _STD_SHOW_DLL_API_ artiShowAdasStep(uint32_t uStep);


// 带对应系统数据流显示的静态页面
// 
// strSysName 对应的系统名称
// 
// uType 是消息类型
//       MBDT_ADAS_DYNAMIC_CALI_OK_WITH_DS = 0,  动态校准成功，带数据流列表
//       MBDT_ADAS_DYNAMIC_CALI_OK_ON_DS = 1,    动态校准成功，没有数据流列表
//       MBDT_ADAS_DYNAMIC_CALI_FAIL_ON_DS = 2,  动态校准失败，没有数据流列表
// 
// vctItem  数据流列表项， 参考stDsReportItem的定义
// 
// 可能的返回值
//       DF_ID_ADAS_RESULT_BACK       点击了左上角“后退”
//       DF_ID_ADAS_RESULT_OK         点击了按钮“完成”
//       DF_ID_ADAS_RESULT_REPORT     点击了按钮“生成报告”
//
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBoxDs(uint32_t uType, 
    const std::string& strSysName, const std::vector<stDsReportItem>& vctItem);



// 带多个消息组的信息展示页面，每个消息包含标题和内容
// 
// strTitle 对应的标题
// 
// uType 是消息类型 eMsgGroupType
//    MGT_MSG_DEFAULT = 0, // 默认类型，按消息组分类，
//                            有“取消”和“确定”2个固定按钮
// 
// vctItem  消息列表，每个消息包含标题和内容
//          struct stMsgItem
//          {
//              std::string strTitle;     // 标题
//              std::string strContent;   // 内容
//          };
// 
// 可能的返回值
//       DF_ID_BACK       点击了左上角“后退”
//       DF_ID_CANCEL     点击了按钮“取消”
//       DF_ID_OK         点击了按钮“确定”
//
uint32_t _STD_SHOW_DLL_API_ artiShowMsgGroup(uint32_t uType,
    const std::string& strTitle, const std::vector<stMsgItem>& vctItem);


// 用于带进度条的特殊界面显示，注意界面非阻塞，非阻塞，非阻塞
// 
// eType        是界面类型
//              PBST_FUNC_HIDDEN_RUNNING = 0   
//              表示，刷隐藏功能正在执行进度条界面，无按钮
// 
//              PBST_FUNC_HIDDEN_READING = 1
//              表示，识别控制单元“功能读取中”界面，无按钮
// 
// CurPercent   当前进度，例如 80
// TotalPercent 总进度，例如 100
// strTitle     标题，如果没有标题，传""，例如PBST_FUNC_HIDDEN_RUNNING没有标题
// strContent   内容，"正在写入，请等待..."
// strTips      提示文本，例如，"功能修改中，请保持APP处于当前页面不要退出"
//
// 注意：非阻塞界面，立即返回给诊断程序，诊断程序隔段时间设置进度条值
uint32_t _STD_SHOW_DLL_API_ artiShowProgressBar(
    eProgressBarShowType eType, 
    uint32_t CurPercent, 
    uint32_t TotalPercent,
    const std::string& strTitle = "",
    const std::string& strContent = "", 
    const std::string& strTips = ""
);


class _STD_SHOW_DLL_API_ CArtiMsgBox
{
public:
    CArtiMsgBox();
#ifdef MULTI_SYSTEM
    /* 多线程诊断编号，目前支持最多4线程 */
    CArtiMsgBox(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiMsgBox();

    /**********************************************************
    *    功  能：初始化消息框
    *    参  数：strTitle 消息框标题文本
    *            strContent 消息框内容文本
    *            uButtonType 消息框按钮类型
    *            uAlignType 消息框文本对齐方式
    *            iTimer 定时器，单位ms
    *            注：iTimer只对单按钮消息框或者无按钮消息框有效
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
    *    注  意： 如果设置了自由按钮DF_MB_FREE，Show之前需要调用AddButton
    *             如果不需要按钮请用DF_MB_NOBUTTON
    *
    **********************************************************/
    bool InitMsgBox(const string& strTitle,
        const string& strContent,
        uint32_t uButtonType = DF_MB_OK,
        uint16_t uAlignType = DT_CENTER,
        int32_t iTimer = -1);
    

    /**********************************************************
    *    功  能：设置消息框标题
    *    参  数：strTitle 消息框标题
    *    返回值：无
    **********************************************************/
    void SetTitle(const string& strTitle);

    /**********************************************************
    *    功  能：设置消息框文本内容
    *    参  数：strContent 消息框内容
    *    返回值：无
    **********************************************************/
    void SetContent(const string& strContent);


    /**********************************************************
    *    功  能：自由添加按钮，初始化的时候使用了DF_MB_FREE，此接口才生效
    * 
    *    参  数：strButtonText 按钮文本
    * 
    *    返回值：按钮的ID，此ID用于DelButton接口的参数
    *            可能的返回值：
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *                         DF_ID_FREEBTN_2
    *                         DF_ID_FREEBTN_3
    *                         DF_ID_FREEBTN_XX
    **********************************************************/
    void AddButton(const string& strButtonText);
    uint32_t AddButtonEx(const string& strButtonText);


    /**********************************************************
    *    功  能：删除自由按钮，初始化的时候使用了DF_MB_FREE，此接口才生效
    *
    *    参  数：uButtonId  按钮的ID
    * 
    *            uButtonId 可能值是 DF_ID_FREEBTN_0
    *                               DF_ID_FREEBTN_1
    *                               DF_ID_FREEBTN_2
    *                               DF_ID_FREEBTN_3
    *                               DF_ID_FREEBTN_XX
    *
    *    返回值：true  自用添加的按钮删除成功
    *            false 自用添加的按钮删除失败
    **********************************************************/
    bool DelButton(uint32_t uButtonId);


    /**********************************************************
    *    功  能：设置消息框按钮类型
    *    参  数：uButtonTyp 按钮类型
    *    返回值：无
    **********************************************************/
    void SetButtonType(uint32_t uButtonTyp);


    /******************************************************************
    *    功  能：设置自定义按钮的状态
    * 
    *    参  数：uIndex      自定义按钮下标
    *            bStatus     自定义按钮的状态
    * 
    *                  DF_ST_BTN_ENABLE    按钮状态为可见并且可点击
    *                  DF_ST_BTN_DISABLE   按钮状态为可见但不可点击
    *                  DF_ST_BTN_UNVISIBLE 按钮状态为不可见，隐藏
    * 
    *    返回值：无
    *            如果没有调用此接口，默认为按钮状态为可见并且可点击
    ********************************************************************/
    void SetButtonStatus(uint16_t uIndex, uint32_t uStatus);


    /**********************************************************
    *    功  能：设置消息框按钮文本
    *    参  数：uIndex 按钮下标
    *            strButtonText对应下标按钮的文本串
    *    返回值：无
    **********************************************************/
    void SetButtonText(uint16_t uIndex, const string& strButtonText);


    /**********************************************************
    *    功  能：获取消息框固定按钮文本
    * 
    *    参  数：uButtonID 按钮类型
    *            DF_TEXT_ID_OK
    *            DF_TEXT_ID_YES
    *            DF_TEXT_ID_CANCEL
    *            DF_TEXT_ID_NO
    *            DF_TEXT_ID_BACK
    *            DF_TEXT_ID_EXIT
    *            DF_TEXT_ID_HELP
    *            DF_TEXT_ID_CLEAR_DTC
    *            DF_TEXT_ID_REPORT
    *            DF_TEXT_ID_NEXT
    * 
    *    返回值：无
    **********************************************************/
    std::string GetButtonText(uint32_t uButtonID = DF_TEXT_ID_OK);


    /**********************************************************
    *    功  能：设置消息框内容对齐方式
    *    参  数：uAlignType 对齐方式
    *    返回值：无
    **********************************************************/
    void SetAlignType(uint16_t uAlignType);

    /**********************************************************
    *    功  能：设置定时器
    *    参  数：定时器时间，单位ms
    *    返回值：无
    **********************************************************/
    void SetTimer(int32_t iTimer);

    /**********************************************************
    *    功  能：设置消息框忙状态是否显示
    *    参  数：bIsVisible = true; 显示消息框忙状态，如沙漏或者其他
    *            bIsVisible = false; 不显示显示消息框忙状态
    *    返回值：无
    **********************************************************/
    void SetBusyVisible(bool bIsVisible);

    /**********************************************************
    *    功  能：设置进度条是否显示
    *    参  数：bIsVisible = true;   显示进度条
    *            bIsVisible = false; 不显示进度条
    *    返回值：无
    **********************************************************/
    void SetProcessBarVisible(bool bIsVisible);

    /**********************************************************
    *    功  能：设置进度条的进度
    *    参  数：iCurPercent，   当前进度
    *            iTotalPercent，总进度
    *    返回值：无
    **********************************************************/
    void SetProgressBarPercent(int32_t iCurPercent, int32_t iTotalPercent);


    /*************************************************************************
    *    功  能：显示消息框
    *    参  数：无
    *    返回值：uint32_t 按钮返回值
    *
    *            固定按钮返回固定按钮返回值，
    *            自定义按钮返回自定义按钮返回值
    *
    *    说明
    *        1. 参考 固定按钮返回值
    *           例如， DF_ID_OK 用户点击了 OK 按钮
    *
    *        2. 参考 消息框自由按钮返回值
    *           有按键操作返回用户选择按钮 DF_ID_FREEBTN_XXX
    *           例如：返回的值是 DF_ID_FREEBTN_3(0x03000103) 
    *                  代表点击了第四个自由按钮
    *
    *        3. 当用户定义为阻塞消息框，等待用户操作返回选择按钮;
    *        
    *        4. DF_ID_NOKEY 当定义为非阻塞消息框，无操作返回 ;
    *           例如，在动作测试有按钮非阻塞消息框，需要固定发指令多少条后自动返回
    **************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
