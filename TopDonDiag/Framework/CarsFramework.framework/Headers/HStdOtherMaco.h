//
//  HStdOtherMaco.h
//  AD200
//
//  Created by AppTD on 2022/8/11.
//

#ifndef StdReportMaco_h
#define StdReportMaco_h
#ifdef __cplusplus
#include <string>

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：字体大小类型，通常情况下用于标题，例如 ArtiList 的 SetTipsTitleOnTop 接口
----------------------------------------------------------------------------------*/
typedef enum
{
    FORT_SIZE_SMALL     = 0,    // 小字体
    FORT_SIZE_MEDIUM    = 1,    // 中字体
    FORT_SIZE_LARGE     = 2,    // 大字体
}eFontSize;


///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：是否粗体，通常情况下用于标题，例如 ArtiList 的 SetTipsTitleOnTop 接口
----------------------------------------------------------------------------------*/
typedef enum
{
    BOLD_TYPE_NONE = 0,    // 不是粗体
    BOLD_TYPE_BOLD = 1,    // 粗体
}eBoldType;


/*---------------------------------------------------------------------------------
说    明：指定颜色，通常情况下用于指定字体颜色，如 ArtiList 的 SetRowHighLight 接口
----------------------------------------------------------------------------------*/
typedef enum
{
    COLOUR_TYPE_DEFAULT = 0,    // 颜色有App自己决定
    COLOUR_TYPE_GRAY    = 1,    // 灰色字体
}eColourType;


///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：针对小车探，增加诊断车型（非OBD）不支持当前车辆的返回值给APP
          APP发现当前车辆不支持，立即进入OBD车
          适用CArtiGlobal的接口SetCurVehNotSupport
----------------------------------------------------------------------------------*/
typedef enum
{
    VBST_SUPPORT_NORMAL   = 0,    // 默认值，默认支持
    VBST_VEH_NOT_SUPPORT  = 1,    // 当前车型程序（非OBD）不支持当前车辆
}eVehNotSupportType;


///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：系统诊断报告系统项，适用于 CArtiReport 类，系统诊断报告，用于AddSysItems接口
----------------------------------------------------------------------------------*/
struct stSysReportItem
{
    std::string strID;          // 系统ID, 如果无，则置空
    std::string strName;        // 系统Name，此名称不能为空，如空则添加无效
    uint32_t    uDtsNums;       // 对应系统的故障码个数
};


///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：故障码节点，适用于 CArtiReport 类，系统诊断报告 或者 故障码诊断报告
----------------------------------------------------------------------------------*/
struct stDtcNode
{
    std::string strCode;            // 故障代码，不能为空，例如："P0316:00-28"
    std::string strDescription;     // 故障码描述
    uint32_t    uStatus;            // 故障码状态
};

struct stDtcNodeEx
{
    std::string strCode;            // 故障代码，不能为空，例如："P0316:00-28"
    std::string strDescription;     // 故障码描述
    std::string strStatus;          // 故障码状态，字符串形式
    uint32_t    uStatus;            // 故障码状态
};

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：故障码项，适用于 CArtiReport 类，系统诊断报告 或者 故障码诊断报告
          用于接口 AddDtcItem 或者 AddDtcItems
----------------------------------------------------------------------------------*/
struct stDtcReportItem
{
    std::string strID;                  // 系统ID, 如果无，则置空
    std::string strName;                // 系统Name，此名称不能为空，如空则添加无效
    std::vector<stDtcNode> vctNode;     // 故障码数组，包含了此系统下的所有故障码
                                        // 例如该系统有2个故障码，数组大小为2
};

struct stDtcReportItemEx
{
    std::string strID;                  // 系统ID, 如果无，则置空
    std::string strName;                // 系统Name，此名称不能为空，如空则添加无效
    std::vector<stDtcNodeEx> vctNode;     // 故障码数组，包含了此系统下的所有故障码
                                        // 例如该系统有2个故障码，数组大小为2
};


///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：数据流项，适用于 CArtiReport 类，数据流诊断报告
          用于接口 AddDsItem 或者 AddDsItems
----------------------------------------------------------------------------------*/
struct stDsReportItem
{
    std::string strName;           // 数据流名称
    std::string strValue;          // 数据流值
    std::string strUnit;           // 数据流单位
    std::string strMin;            // 数据流最小参考值
    std::string strMax;            // 数据流最大参考值
    std::string strReference;      // 数据流其他类型值的参考值
};

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：适用于 artiShowMsgGroup 接口
          带多个消息组的信息展示页面，每个消息组包含标题和内容
----------------------------------------------------------------------------------*/
struct stMsgItem
{
    std::string strTitle;     // 标题
    std::string strContent;   // 内容
};

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于artiShowMsgGroup接口，形参uType，指定UI消息类型
          App根据指定的消息类型，绘制指定UI
----------------------------------------------------------------------------------*/
typedef enum
{
    MGT_MSG_DEFAULT = 0,       // 默认类型，按消息组分类
                               // 有“取消”和“确定”2个固定按钮
}eMsgGroupType;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于带数据流显示的消息框，artiShowMsgBoxDs，形参uType，指定消息框类型
          ADAS结果展示新增需求，App根据指定的uType，显示对应的消息框
----------------------------------------------------------------------------------*/
typedef enum
{
    MBDT_ADAS_DYNAMIC_CALI_OK_WITH_DS = 0,  // 动态校准成功，带数据流列表，“生成报告”，“完成”两个按钮
    MBDT_ADAS_DYNAMIC_CALI_OK_ON_DS   = 1,  // 动态校准成功，没有数据流列表，“生成报告”，“完成”两个按钮
    MBDT_ADAS_DYNAMIC_CALI_FAIL_ON_DS = 2,  // 动态校准失败，没有数据流列表，“生成报告”，“完成”两个按钮
}eMsgBoxDsType;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：故障码组件中，用于设置维修资料信息的类型名，适用于 CArtiTrouble 类的接口
          SetRepairManualInfo的参数

          bool SetRepairManualInfo(const std::vector<stRepairInfoItem>& vctDtcInfo);
----------------------------------------------------------------------------------*/
// 维修资料所需信息的类型
typedef enum
{
    RIT_DTC_CODE        = 0,       //  表示故障码编码
    RIT_VEHICLE_BRAND   = 1,       //  表示车辆品牌
    RIT_VEHICLE_MODEL   = 2,       //  表示车型
    RIT_VEHICLE_YEAR    = 3,       //  表示车辆年款
    RIT_VIN             = 4,       //  表示车辆VIN
    RIT_SYSTEM_NAME     = 5,       //  表示系统名称
}eRepairInfoType;


typedef enum
{
    AVSM_MODE_NORMAL        = 1,  // 正常AUTOVIN协议扫描模式
    AVSM_MODE_LAST_PROTOCOL = 2,  // AUTOVIN使用上次保存的协议去读取VIN
    
}eAutoVinScannMode;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：ArtiGlobal用于获取当前的FCA登录界面上用户选择的区域，适用于全局类的接口
          FcaGetLoginRegion

          eLoginRegionType FcaGetLoginRegion();
----------------------------------------------------------------------------------*/
enum eLoginRegionType
{
    LGT_SELECT_AMERICA = 0,      //  表示App的FCA登录中，当前选择的区域是美洲
    LGT_SELECT_EUROPE = 1,       //  表示App的FCA登录中，当前选择的区域是欧洲
    LGT_SELECT_OTHER = 2,        //  表示App的FCA登录中，当前选择的区域是其它
};


///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于ADAS接口GetAdasCalData，形参eAdasCaliData表示对应的数据类型
          ADAS新增需求，诊断程序通过此接口获取App的ADAS相关数据
----------------------------------------------------------------------------------*/
typedef enum
{
    ACD_CAL_WHEEL_BROW_HEIGHT_LF = 0,           // 左前轮数据类型
    ACD_CAL_WHEEL_BROW_HEIGHT_RF = 1,           // 右前轮数据类型
    ACD_CAL_WHEEL_BROW_HEIGHT_LR = 2,           // 左后轮数据类型
    ACD_CAL_WHEEL_BROW_HEIGHT_RR = 4,           // 右后轮数据类型

    ACD_CAL_FUEL_LEVEL           = 0x10         // 燃油液位数据类型
}eAdasCaliData;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：用于ADAS接口artiShowAdasStep，形参uStep，指定步骤类型
          ADAS新增需求，App根据指定的步骤，控制ADAS的UI流程
----------------------------------------------------------------------------------*/
typedef enum
{
    ACS_ADAS_CALIBRATION_DEFAULT      = 0,   // 默认，保留
    ACS_DYNAMIC_CALIBRATION           = 1,   // 进入App控制的动态校准流程
    ACS_STATIC_CALIBRATION            = 2,   // 进入App控制的静态校准流程

    ACS_CALIBRATION_WHEEL_BROW_HEIGHT = 0x10,    // 轮眉高度类型

    // ADAS静态校准，校准过程，标靶展示
    ACS_STATIC_CALI_PROCESS_STEP_0    = 0x40, // ADAS静态校准校准过程标靶展示，步骤0
    ACS_STATIC_CALI_PROCESS_STEP_1    = 0x41, // ADAS静态校准校准过程标靶展示，步骤1
    ACS_STATIC_CALI_PROCESS_STEP_2    = 0x42, // ADAS静态校准校准过程标靶展示，步骤2
    ACS_STATIC_CALI_PROCESS_STEP_3    = 0x43, // ADAS静态校准校准过程标靶展示，步骤3
    ACS_STATIC_CALI_PROCESS_STEP_4    = 0x44, // ADAS静态校准校准过程标靶展示，步骤4
    ACS_STATIC_CALI_PROCESS_STEP_5    = 0x45, // ADAS静态校准校准过程标靶展示，步骤5
    ACS_STATIC_CALI_PROCESS_STEP_6    = 0x46, // ADAS静态校准校准过程标靶展示，步骤6
    ACS_STATIC_CALI_PROCESS_STEP_7    = 0x47, // ADAS静态校准校准过程标靶展示，步骤7
    ACS_STATIC_CALI_PROCESS_STEP_8    = 0x48, // ADAS静态校准校准过程标靶展示，步骤8
    ACS_STATIC_CALI_PROCESS_STEP_9    = 0x49, // ADAS静态校准校准过程标靶展示，步骤9
    ACS_STATIC_CALI_PROCESS_STEP_10   = 0x4A, // ADAS静态校准校准过程标靶展示，步骤10


    ACS_DYNAMIC_CALI_NOT_SUPPORT      = 0x50, // TOPSCAN，控制单元不支持ADAS校准
}eAdasCaliStep;

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
说    明：故障码组件中，用于设置维修资料信息，适用于 CArtiTrouble 类的接口
          SetRepairManualInfo的参数

          bool SetRepairManualInfo(const std::vector<stRepairInfoItem>& vctDtcInfo);
----------------------------------------------------------------------------------*/
// 维修资料所需信息的类型
struct stRepairInfoItem
{
    eRepairInfoType eType;         // 维修资料所需信息的类型
                                   // 例如 RIT_DTC_CODE，表示strValue 此值是 "故障码编码"

    std::string     strValue;      // 实际信息的字符串值
                                   // 例如当 eType = RIT_DTC_CODE，strValue为 "strValue"
                                   // 例如当 eType = RIT_VIN，strValue为 "strValue"
};

struct stUnitItem
{
    std::string strUnit;            // 单位   例如 km
    std::string strValue;           // 值     例如 1234
                                    // 表示1234km
};

///////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------------
说    明：扩展功能的系统诊断报告系统项（ADAS），适用于 CArtiReport 类，
          系统诊断报告，用于AddSysItemEx接口
------------------------------------------------------------------------------------*/
struct stSysReportItemEx
{
    std::string strID;              // 系统ID, 如果无，则置空
    std::string strName;            // 系统Name，此名称不能为空，如空则添加无效
    
    uint32_t    uSysProp;           // 对应系统的属性，例如具有ADAS属性，
                                    // 则显示个ADAS图标，示意可以ADAS校准
                                    // DF_SYS_PROP_DEFAULT      默认，常规
                                    // DF_SYS_PROP_ADAS         具有ADAS功能属性
                                    // DF_SYS_PROP_TPMS         具有胎压功能属性

    uint32_t    uStatusPre;         // 执行前，对应系统功能的状态
                                    // DF_SYS_STATUS_ADAS_DEFAULT   ADAS功能不可执行（空白）
                                    // DF_SYS_STATUS_ADAS_OK        ADAS功能可执行（Yes）

    uint32_t    uDtsNumsPre;        // 执行前，对应系统的故障码个数

    uint32_t    uStatusPost;        // 执行后，对应系统功能的执行状态
                                    // DF_SYS_STATUS_ADAS_DEFAULT   ADAS功能不可执行（空白）
                                    // DF_SYS_STATUS_ADAS_OK        ADAS功能执行OK（Yes）
                                    // DF_SYS_STATUS_ADAS_FAILED    ADAS功能执行失败

    uint32_t    uDtsNumsPost;       // 执行后，对应系统的故障码个数
};

struct stReportAdasResult
{
    std::string  strSysName;     // 系统Name，此名称不能为空，如空则添加无效
    std::string  strStartTime;   // 校准开始时间，例如："2022-06-27 20:55:40"
    std::string  strStopTime;    // 校准结束时间，例如："2022-06-27 20:56:48"
    uint32_t     uTotalTimeS;    // 总校准耗时时间，单位为秒
    uint32_t     uType;          // ADAS系统校准类型
                                 // RAT_ADAS_CALI_STATIC    0   静态校准
                                 // RAT_ADAS_CALI_DYNAMIC   1   动态校准
    uint32_t     uStatus;        // 系统校准结果状态
                                 // RAR_ADAS_CALI_OK      0   ADAS校准OK
                                 // RAR_ADAS_CALI_FAILED  1   ADAS校准失败
};
#endif
#endif /* StdReportMaco_h */
