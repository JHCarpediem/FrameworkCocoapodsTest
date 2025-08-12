#ifndef _STD_SHOW_MACO_H_
#define _STD_SHOW_MACO_H_

//#include "StdInclude.h"

/*-----------------------------------------------------------------------------
说    明：适用所有接口，如果App没有实现此接口功能（即JNI可以找到Apk的函数定义，
          但是App/Apk 却没有实现此接口功能，即App不支持当前功能），返回此值
-----------------------------------------------------------------------------*/
#define DF_APP_CURRENT_NOT_SUPPORT_FUNCTION     (0xFFFFFFEF)    // -17

/*-----------------------------------------------------------------------------
说    明：适用所有接口，如果APP没有实现此接口（即JNI找不到APK的函数定义，或者
          iOS的App没有注册接口的回调函数），返回此值
-----------------------------------------------------------------------------*/
#define DF_FUNCTION_APP_CURRENT_NOT_SUPPORT     (0xFFFFFFF0)    // -16

/*-----------------------------------------------------------------------------
说    明：适用所有接口，如果APP没有此对象实例，返回此值
-----------------------------------------------------------------------------*/
#define DF_FUNCTION_APP_OBJ_NOT_CONSTRUCTOR     (0xFFFFFFF1)    // -15

/*-----------------------------------------------------------------------------
说    明：适用所有接口，如果APP没有此对象实例，返回此值
-----------------------------------------------------------------------------*/
#define STR_FUNCTION_APP_OBJ_NOT_CONSTRUCTOR     ("object not construct!")

#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)


#if !defined(_WIN32)&!defined (_WIN64)
#define DT_TOP                      0x00000000
#define DT_LEFT                     0x00000000
#define DT_CENTER                   0x00000001
#define DT_RIGHT                    0x00000002
#define DT_BOTTOM                   0x00000008
#endif


#define DT_LEFT_TOP                 0x00000010  // 左上角
#define DT_RIGHT_TOP                0x00000011  // 右上角
#define DT_LEFT_BOTTOM              0x00000012  // 左下角
#define DT_RIGHT_BOTTOM             0x00000013  // 右下角


/*-----------------------------------------------------------------------------
说    明：界面阻塞/非阻塞 适用于所有显示类
-----------------------------------------------------------------------------*/
#define DF_MB_NONBLOCK                          0x0000
#define DF_MB_BLOCK                             0x0100


/*-----------------------------------------------------------------------------
说    明：固定按钮
-----------------------------------------------------------------------------*/
#define DF_MB_NOBUTTON                       0x0000   //  无按钮的非阻塞消息框
#define DF_MB_YES                            0x0101   //  Yes 按钮的阻塞消息框
#define DF_MB_NO                             0x0102   //  No 按钮的阻塞消息框
#define DF_MB_YESNO                          0x0103   //  Yes/No 按钮的阻塞消息框
#define DF_MB_OK                             0x0104   //  OK 按钮的阻塞消息框
#define DF_MB_CANCEL                         0x0108   //  Cancel 按钮的阻塞消息框
#define DF_MB_OKCANCEL                       0x010C   //  OK/Cancel 按钮的阻塞消息框
#define DF_MB_NEXTEXIT                       0x010D   //  Next/Exit 按钮的阻塞消息框


/*-----------------------------------------------------------------------------
说    明：自由按钮开关（自由添加按钮）
-----------------------------------------------------------------------------*/
#define DF_MB_FREE                            0x0200  // 自由按钮的非阻塞消息框


/*-----------------------------------------------------------------------------
说    明：固定按钮返回值
-----------------------------------------------------------------------------*/
#define DF_ID_OK                             0x00000000
#define DF_ID_YES                            0x00000000
#define DF_ID_CANCEL                         0xFFFFFFFF
#define DF_ID_NO                             0xFFFFFFFF
#define DF_ID_BACK                           0xFFFFFFFF
#define DF_ID_EXIT                           0xFFFFFFFF
#define DF_ID_HELP                           0x80000001
#define DF_ID_CLEAR_DTC                      0x80000002   // 点击清除故障码
#define DF_ID_REPORT                         0x80000003
#define DF_ID_NEXT                           0x80000010   // 下一个
#define DF_ID_PREV                           0x80000011   // 前一个
#define DF_ID_RESTORE                        0x80000020   // 恢复数据
#define DF_ID_SFD_THIRD                      0x80000030   // VW网关解锁界面，“第三方处理”返回值
                                                          // 用于artiShowSpecial接口的按钮返回值


/*-----------------------------------------------------------------------------
说    明：自由按钮返回值（或者编号），使用于各种可自由添加按钮的控件
-----------------------------------------------------------------------------*/
#define DF_ID_FREEBTN_0                      0x00000100
#define DF_ID_FREEBTN_1                      0x00000101
#define DF_ID_FREEBTN_2                      0x00000102
#define DF_ID_FREEBTN_3                      0x00000103
//#define DF_ID_FREEBTN_XX                   0x000001XX //一共FF个自由按钮


#define DF_ST_BTN_ENABLE                     ((uint32_t)0x00)     // 按钮状态为可见并且可点击
#define DF_ST_BTN_DISABLE                    ((uint32_t)0x01)     // 按钮状态为可见但不可点击
#define DF_ST_BTN_UNVISIBLE                  ((uint32_t)0x02)     // 按钮状态为不可见，隐藏



/*-----------------------------------------------------------------------------
说    明：获取固定按钮文本的宏值ID，用于接口 GetButtonText
-----------------------------------------------------------------------------*/
#define DF_TEXT_ID_OK                             0x00000001
#define DF_TEXT_ID_YES                            0x00000002
#define DF_TEXT_ID_CANCEL                         0x00000003
#define DF_TEXT_ID_NO                             0x00000004
#define DF_TEXT_ID_BACK                           0x00000005
#define DF_TEXT_ID_EXIT                           0x00000006
#define DF_TEXT_ID_HELP                           0x00000007
#define DF_TEXT_ID_CLEAR_DTC                      0x00000008
#define DF_TEXT_ID_REPORT                         0x00000009
#define DF_TEXT_ID_NEXT                           0x0000000A
#define DF_TEXT_ID_PREV                           0x0000000B



/*-----------------------------------------------------------------------------
说    明：无操作返回值
-----------------------------------------------------------------------------*/
#define DF_ID_NOKEY                               0x04000000


/*-----------------------------------------------------------------------------
说    明：没有选中任意一行返回值
          如果诊断应用程序调用了SetSelectedType接口，并设置为ITEM_SELECT_DISABLED
          并且没有调用SetDefaultSelectedRow，情况下
          CArtiList的Show返回值为没有选中任意一行DF_LIST_LINE_NONE
          且GetSelectedRow也返回没有选中任意一行DF_LIST_LINE_NONE
-----------------------------------------------------------------------------*/
#define DF_LIST_LINE_NONE                         0xFFFF


////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：CArtiSystem 按钮返回值宏 Show 的按钮返回值
          按钮包括：一键扫描，一键清码，帮助，诊断报告，返回
          例如，点击“一键扫描”返回 DF_ID_START
-----------------------------------------------------------------------------*/
#define DF_ID_SYS_START                       0x80000004
#define DF_ID_SYS_STOP                        0x80000005
#define DF_ID_SYS_ERASE                       DF_ID_CLEAR_DTC
#define DF_ID_SYS_REPORT                      DF_ID_REPORT
#define DF_ID_SYS_HELP                        DF_ID_HELP
#define DF_ID_SYS_BACK                        DF_ID_BACK
#define DF_ID_SYS_NOKEY                       DF_ID_NOKEY



/*-----------------------------------------------------------------------------
说    明： CArtiSystem 页面列表项返回值(Show)，表示点击了那个系统
-----------------------------------------------------------------------------*/
#define DF_ID_SYS_0                         0x00000000
#define DF_ID_SYS_1                         0x00000001
#define DF_ID_SYS_3                         0x00000003
//...
//#define DF_ID_SYS_X                       0x0000XXXX


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem 系统扫描菜单下，点击ADAS，(Show)返回值
#define DF_ID_SYS_ADAS_0                    0x01000000      // 点击了第0个系统的ADAS
#define DF_ID_SYS_ADAS_1                    0x01000001      // 点击了第1个系统的ADAS
#define DF_ID_SYS_ADAS_2                    0x01000002      // 点击了第2个系统的ADAS
#define DF_ID_SYS_ADAS_3                    0x01000003      // 点击了第3个系统的ADAS
//...
//#define DF_ID_SYS_ADAS_X
#define DF_ID_SYS_ADAS_MASK                 0x0000FFFF
#define DF_SYS_GET_ADAS_SYS_NO(x)           (((x) & DF_ID_SYS_DTC_MASK))   // 系统编号


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem 系统扫描菜单下，点击快速查看故障码，(Show)返回值
#define DF_ID_SYS_DTC_0                     0x00100000      // 点击了第0个系统的故障码快速浏览按钮
#define DF_ID_SYS_DTC_1                     0x00100001      // 点击了第1个系统的故障码快速浏览按钮
#define DF_ID_SYS_DTC_2                     0x00100002      // 点击了第2个系统的故障码快速浏览按钮
#define DF_ID_SYS_DTC_3                     0x00100003      // 点击了第3个系统的故障码快速浏览按钮
//...
//#define DF_ID_SYS_DTC_X
#define DF_ID_SYS_DTC_MASK                  0x0000FFFF
#define DF_SYS_GET_DTC_SYS_NO(x)            (((x) & DF_ID_SYS_DTC_MASK))   // 系统编号


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem 多线程系统诊断，点击了哪个系统
#define DF_ID_SYS_TH1_0                     0x00010000      // 开启“编号为0的系统”第1个线程
#define DF_ID_SYS_TH1_1                     0x00010001      // 开启“编号为1的系统”第1个线程
#define DF_ID_SYS_TH1_2                     0x00010002      // 开启“编号为2的系统”第1个线程
//...
//#define DF_ID_SYS_TH1_X                   0x0001000X
#define DF_ID_SYS_TH2_1                     0x00020001      // 开启“编号为1的系统”第2个线程
#define DF_ID_SYS_TH3_2                     0x00030002      // 开启“编号为2的系统”第3个线程
#define DF_ID_SYS_TH4_3                     0x00040003      // 开启“编号为3的系统”第4个线程
//...
//#define DF_ID_SYS_TH2_X
//#define DF_ID_SYS_TH3_X
//#define DF_ID_SYS_TH4_X
#define DF_ID_SYS_TH_MASK                   0x000F0000
#define DF_SYS_GET_TH_NO(x)                 (((x) & DF_ID_SYS_TH_MASK) >> 16)   // 线程编号



////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem 系统扫描类型
#define DF_SST_TYPE_DEFAULT                0        // 默认系统类型
#define DF_SST_TYPE_ADAS                   1        // ADAS系统扫描类型



/*-----------------------------------------------------------------------------
说    明：CArtiSystem 系统状态宏， uResult 指定系统项的最终结果
          适用于void SetItemResult(uint16_t uIndex, uint32_t uResult);
-----------------------------------------------------------------------------*/
#define DF_ENUM_UNKNOWN                     0x10000000  //未知
#define DF_ENUM_NOTEXIST                    0x20000000  //不存在
#define DF_ENUM_NOTSUPPORT                  0x30000000  //不支持
#define DF_ENUM_NODTC                       0x40000000  //无码
#define DF_ENUM_DTCNUM                      0x80000000  //有码
//DF_ENUM_DTCNUM + 1 为有1个故障码



/*-----------------------------------------------------------------------------
说    明：CArtiSystem ADAS系统状态宏， uAdasResult 指定ADAS系统项的结果
          适用于void SetItemAdas(uint16_t uIndex, uint32_t uAdasResult);
-----------------------------------------------------------------------------*/
#define DF_ENUM_NO_ADAS                     0  // 不存在ADAS
#define DF_ENUM_ADAS_EXIST                  1  // 存在ADAS




/*-----------------------------------------------------------------------------
说    明：CArtiSystem 系统扫描状态宏，用于 SetScanStatus
-----------------------------------------------------------------------------*/
#define DF_SYS_SCAN_START                        0  // 开始扫描
#define DF_SYS_SCAN_PAUSE                        1  // 暂停扫描
#define DF_SYS_SCAN_FINISH                       2  // 扫描结束


/*-----------------------------------------------------------------------------
说    明：CArtiSystem 系统扫描状态宏，用于 SetClearStatus
-----------------------------------------------------------------------------*/
#define DF_SYS_CLEAR_START                       0  // 一键清码开始
#define DF_SYS_CLEAR_FINISH                      1  // 一键清码结束




////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：输入框 Show 返回值，适用于 CArtiInput 类
          三种按钮类型，确定、取消、自定义按键
-----------------------------------------------------------------------------*/
#define DF_ID_INPUT_OK                      DF_ID_OK
#define DF_ID_INPUT_CANCLE                  DF_ID_CANCEL

#define DF_ID_INPUT_0                       DF_ID_FREEBTN_0
#define DF_ID_INPUT_1                       DF_ID_FREEBTN_1
#define DF_ID_INPUT_2                       DF_ID_FREEBTN_2
#define DF_ID_INPUT_3                       DF_ID_FREEBTN_3
//...
//#define DF_ID_INPUT_X                     DF_ID_FREEBTN_X





////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：菜单项 Show 返回值，适用于 CArtiMenu 类
-----------------------------------------------------------------------------*/
#define DF_ID_MENU_BACK                     DF_ID_BACK
#define DF_ID_MENU_HELP                     DF_ID_HELP

#define DF_ID_MENU_TREE                     0x80000000  // 菜单树部分，暂定

#define DF_ID_MENU                          0x00000000
#define DF_ID_MENU_0                        0x00000000
#define DF_ID_MENU_1                        0x00000001
#define DF_ID_MENU_2                        0x00000002
#define DF_ID_MENU_3                        0x00000003
//...
//#define DF_ID_MENU_X                      0x0000XXXX

#define DF_ST_MENU_NORMAL                   0x00000000  // 正常状态
#define DF_ST_MENU_EXPIR                    0x00000001  // 软件过期
#define DF_ST_MENU_DISABLE                  0x00000003  // 失能状态



////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：数据流 Show 返回值，适用于 CArtiLiveData 类
-----------------------------------------------------------------------------*/
#define DF_ID_LIVEDATA_BACK                 DF_ID_BACK
#define DF_ID_LIVEDATA_NEXT                 DF_ID_NEXT
#define DF_ID_LIVEDATA_PREV                 DF_ID_PREV
#define DF_ID_LIVEDATA_REPORT               DF_ID_REPORT




///////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：故障码 Show 返回值，适用于 CArtiTrouble 类
-----------------------------------------------------------------------------*/
#define DF_ID_TROUBLE_BACK                       DF_ID_BACK
#define DF_ID_TROUBLE_CLEAR                      DF_ID_CLEAR_DTC
#define DF_ID_TROUBLE_REPORT                     DF_ID_REPORT

// 故障码 点击 "冻结帧" 的 Show 返回值，适用于 CArtiTrouble 类
#define DF_ID_TROUBLE_0                          0x00000000
#define DF_ID_TROUBLE_1                          0x00000001
#define DF_ID_TROUBLE_2                          0x00000002
#define DF_ID_TROUBLE_3                          0x00000003
#define DF_ID_TROUBLE_4                          0x00000004
//...
//#define DF_ID_TROUBLE_X                        0x0000XXXX

// 故障码 点击 "维修资料" 的 Show 返回值，适用于 CArtiTrouble 类
#define DF_ID_REPAIR_MANUAL_0                    0x40000000
#define DF_ID_REPAIR_MANUAL_1                    0x40000001
#define DF_ID_REPAIR_MANUAL_2                    0x40000002
#define DF_ID_REPAIR_MANUAL_3                    0x40000003
#define DF_ID_REPAIR_MANUAL_4                    0x40000004
//...
//#define DF_ID_REPAIR_MANUAL_XXXX               0x4000XXXX
////////////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：诊断报告故障码状态，用于故障码项，结构体 stDtcNode 的 uStatus
----------------------------------------------------------------------------------*/
#define DF_DTC_STATUS_NONE                 (0)            // 无状态
#define DF_DTC_STATUS_CURRENT              (1 << 0)       // 当前故障码    Current
#define DF_DTC_STATUS_HISTORY              (1 << 1)       // 历史故障码    History
#define DF_DTC_STATUS_PENDING              (1 << 2)       // 待定故障码    Pending
#define DF_DTC_STATUS_TEMP                 (1 << 3)       // 临时故障码    Temporary
#define DF_DTC_STATUS_NA                   (1 << 4)       // 未知故障码    N/A
#define DF_DTC_STATUS_OTHERS               (0xFFFFFFFF)   // 无法归类到以上枚举分类，直接按strStatus显示




///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：弹出框组件，1、纯消息文本弹出框类型     2、表格类型的弹出框
          适用于 CArtiPopup 的 InitTitle 接口的 uPopupType 参数
----------------------------------------------------------------------------------*/
#define DF_POPUP_TYPE_MSG              0x00000001       // 纯消息文本弹出框类型
#define DF_POPUP_TYPE_LIST             0x00000002       // 表格类型的弹出框





///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于弹出框组件 CArtiPopup 接口SetPopDirection，设置弹出框弹出的方向
          void SetPopDirection(uint32_t uDirection);
----------------------------------------------------------------------------------*/
#define DF_POPUP_DIR_TOP              0x00000000       // 顶部弹出
#define DF_POPUP_DIR_CENTER           0x00000001       // 居中弹出
#define DF_POPUP_DIR_RIGHT            0x00000002       // 右侧弹出
#define DF_POPUP_DIR_BOTTOM           0x00000004       // 底部弹出
#define DF_POPUP_DIR_LEFT             0x00000008       // 左侧弹出



/*-----------------------------------------------------------------------------
说    明：图片添加返回值（或者编号），使用于CArtiPicture的
-----------------------------------------------------------------------------*/
#define DF_ID_PICTURE_NONE                   0xFFFFFFFF
#define DF_ID_PICTURE_0                      0x00000000
#define DF_ID_PICTURE_1                      0x00000001
#define DF_ID_PICTURE_2                      0x00000002
#define DF_ID_PICTURE_3                      0x00000003
//#define DF_ID_PICTURE_XX                   0x000000XX //一共FF张图片



/*-----------------------------------------------------------------------------
说    明：小车探UI类型，适用于 artiMsgBoxActTest 的形参 uTestType
          或者用于 CArtiLiveData 的接口 SetComponentType
-----------------------------------------------------------------------------*/
#define DF_TYPE_ENTRY_COMMING                0x00000001     // 正在通信中，例如点击部件测试、数据流等
#define DF_TYPE_COMM_FAILED                  0x00000002     // 通信失败类型
#define DF_TYPE_ACT_TEST_NOT_SUPPORT         0x00000003     // 不支持部件测试
#define DF_TYPE_THROTTLE_CARBON              0x00000010     // 节气门积碳检测
#define DF_TYPE_FULE_CORRECTION              0x00000020     // 燃油修正控制系统检测
#define DF_TYPE_MAF_TEST                     0x00000030     // 空气流量传感器检测
#define DF_TYPE_INTAKE_PRESSURE              0x00000040     // 进气压力传感器检测
#define DF_TYPE_INTAKE_PRESSURE_ACC          0x00000041     // 进气压力传感器检测中的松开油门提示
#define DF_TYPE_OXYGEN_SENSOR                0x00000050     // 氧传感器检测
#define DF_TYPE_ENGINE_TEST_NO_DTC           0x00000060     // CarPal发动机检测，无故障码页面



/*-----------------------------------------------------------------------------
说    明：部件测试结果值，用于 CArtiLiveData 的接口 SetComponentResult
-----------------------------------------------------------------------------*/
#define DF_RESULT_THROTTLE_NORMAL            0x00000001      // 发动机节气门运作正常
#define DF_RESULT_THROTTLE_LIGHT_CARBON      0x00000002      // 节气门疑似有轻微积碳
#define DF_RESULT_THROTTLE_SERIOUSLY         0x00000003      // 节气门积碳严重

#define DF_RESULT_FULE_NORMAL                0x00000001      // 燃油修正正常
#define DF_RESULT_FULE_HIGH                  0x00000002      // 燃油修正偏浓
#define DF_RESULT_FULE_LOW                   0x00000003      // 燃油修正偏稀
#define DF_RESULT_FULE_ABNORMAL              0x00000004      // 燃油修正异常

#define DF_RESULT_MAF_NORMAL                 0x00000001      // 进气量正常
#define DF_RESULT_MAF_HIGH                   0x00000002      // 进气量偏大
#define DF_RESULT_MAF_LOW                    0x00000003      // 进气量偏小

#define DF_RESULT_INTAKE_PRESSURE_NORMAL     0x00000001      // 进气压力正常
#define DF_RESULT_INTAKE_PRESSURE_HIGH       0x00000002      // 进气压力偏高

#define DF_RESULT_OXYGEN_NORMAL              0x00000001      // 氧传感器正常
#define DF_RESULT_OXYGEN_ERROR               0x00000002      // 氧传感器出现故障



/*-----------------------------------------------------------------------------
说    明：导航栏TAP类型
-----------------------------------------------------------------------------*/
#define DF_TAP_TYPE_IS_TOP_NAVIG           1          /* 顶部导航栏     类型 */
#define DF_TAP_TYPE_IS_MSGBOX              2          /* ArtiMsgBox     类型 */
#define DF_TAP_TYPE_IS_INPUT               3          /* ArtiInput      类型 */
#define DF_TAP_TYPE_IS_ACTIVE              4          /* ArtiActive     类型 */
#define DF_TAP_TYPE_IS_ECUINFO             5          /* ArtiEcuInfo    类型 */
#define DF_TAP_TYPE_IS_FILE_DIALOG         6          /* ArtiFileDialog 类型 */
#define DF_TAP_TYPE_IS_FREEZE              7          /* ArtiFreeze     类型 */
#define DF_TAP_TYPE_IS_LIST                8          /* ArtiList       类型 */
#define DF_TAP_TYPE_IS_LIVE_DATA           9          /* ArtiLiveData   类型 */
#define DF_TAP_TYPE_IS_MENU                10         /* ArtiMenu       类型 */
#define DF_TAP_TYPE_IS_PICTURE             11         /* ArtiPicture    类型 */
#define DF_TAP_TYPE_IS_SYSTEM              12         /* ArtiSystem     类型 */
#define DF_TAP_TYPE_IS_TROUBLE             13         /* ArtiTrouble    类型 */


////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：导航栏 Show 返回值，适用于 CArtiNavigation 类 或者 CArtiTopTap 类
-----------------------------------------------------------------------------*/
#define DF_ID_TAP_0                        0x00000000
#define DF_ID_TAP_1                        0x00000001
#define DF_ID_TAP_2                        0x00000002
#define DF_ID_TAP_3                        0x00000003
#define DF_ID_TAP_4                        0x00000004
#define DF_ID_TAP_5                        0x00000005
#define DF_ID_TAP_6                        0x00000006
//...
//#define DF_ID_MENU_X                      0x0000XXXX

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：适用于 artiShowMsgBoxDs 接口返回值
----------------------------------------------------------------------------------*/
#define DF_ID_ADAS_RESULT_BACK             DF_ID_BACK       // 点击了“后退”
#define DF_ID_ADAS_RESULT_OK               DF_ID_OK         // 点击了“完成”
#define DF_ID_ADAS_RESULT_REPORT           DF_ID_REPORT     // 点击了“生成报告”



///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：适用于 CArtiHidden 的 Show 接口返回值
----------------------------------------------------------------------------------*/
#define DF_ID_HIDDEN_BACK             DF_ID_BACK        // 点击了“后退”
#define DF_ID_HIDDEN_OK               DF_ID_OK          // 点击了“确定执行设置”
#define DF_ID_HIDDEN_RESTORE_DATA     DF_ID_RESTORE     // 点击了“恢复数据”



/////////////////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------------------------
说    明：适用于 CArtiTopoGraph 的 SetSvgPath 和 SetUsedLocalData 接口返回值
-------------------------------------------------------------------------------------------------*/
#define DF_SVG_PATH_IS_INVALID      0xFFFFFFFF    // 路径非法，或者文件不存在
#define DF_SVG_PATH_OK              0             // 设置正确
#define DF_SVG_USED_LOCAL_OK        0             // 设置正确
#define DF_SVG_LOCAL_NOT_SUPPORT    DF_APP_CURRENT_NOT_SUPPORT_FUNCTION  // 表示本地SVG数据文件不支持
#define DF_SVG_API_NOT_SUPPORT      DF_FUNCTION_APP_CURRENT_NOT_SUPPORT  // 表示当前APP版本还没有此接口

////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
说    明：系统属性宏定义，用于stSysReportItemEx结构体中的系统属性uSysProp
-----------------------------------------------------------------------------*/
#define DF_SYS_PROP_DEFAULT                0x00000000   // 默认，常规
#define DF_SYS_PROP_ADAS                   0x00000001   // 具有ADAS功能属性
#define DF_SYS_PROP_TPMS                   0x00000002   // 具有胎压功能属性


////////////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------------------------------
说    明：系统执行结果状态宏定义，用于stSysReportItemEx结构体中的执行状态uStatus
-------------------------------------------------------------------------------*/
#define DF_SYS_STATUS_ADAS_DEFAULT         0x00000000     // ADAS功能不可执行（空白）
#define DF_SYS_STATUS_ADAS_OK              0x00000001     // ADAS功能执行OK或可执行（Yes）
#define DF_SYS_STATUS_ADAS_FAILED          0x00000002     // ADAS功能执行失败
#endif
