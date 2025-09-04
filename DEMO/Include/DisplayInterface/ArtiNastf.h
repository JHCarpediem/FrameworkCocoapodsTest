/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 NASTF 控件
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_NASTF_H__
#define __ARTI_NASTF_H__

#include "StdInclude.h"
#include "StdShowMaco.h"


// NASTF车辆安全数据上传接口界面（VSP-ID输入界面）
// 
// 北美区域，NASTF要求维修的车辆需上报防盗安全功能，包括4类型
// ● Add a key
// ● All keys lost
// ● Immobilizer functions
// ● Any other process that the OE determines to be security related
// 上报需要用户输入NASTF的VSP-ID（车辆安全专业人员）
// 
// 1、自研诊断平板接入NASTF功能，NASTF平台要求进入防盗相关功能时需上传相应功能类别参数
// 2、诊断应用在Show之前需要判断是否需要弹窗，在线数据上报
// 3、如果App返回不需要弹窗，例如在欧洲区域，则不需要Show此界面
// 
// 
class _STD_SHOW_DLL_API_ CArtiNastfVsp
{
public:
    // 1 Add a Key
    // 2 All Keys Lost
    // 3 Immobilizer functions
    // 4 Other
    enum
    {
        SEC_FUNC_TYPE_ADD_A_KEY     = 0,    // Add a key
        SEC_FUNC_TYPE_ALL_KEY_LOST  = 1,    // All keys lost
        SEC_FUNC_TYPE_IMMO          = 2,    // Immobilizer functions

        SEC_FUNC_TYPE_OTHER         = 0x10, // Others
    };

    enum
    {
        NOT_VALIDATION_SHOW  = 0,    // 不需要VSP-ID输入界面，即诊断程序不需要弹窗 Show
        NEED_VALIDATION_SHOW = 1,    // 需要VSP-ID输入界面，即诊断程序需要弹窗 Show
        NEED_OFFLINE_WARNING = 2,    // 有离线数据未上报，不需要VSP-ID输入界面，
                                     // 即诊断程序不需要弹窗 Show，但是需要弹msgBox离线警告
    };

public:
    CArtiNastfVsp();
    ~CArtiNastfVsp();

    /*-------------------------------------------------------------------------------------------------
      功    能：初始化 VSP 验证码输入控件

      参数说明：strTitle  当前无意义，App定死标题


      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT， -16，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_APP_CURRENT_NOT_SUPPORT_FUNCTION， -17，当前App有此接口，但未实现对应功能

                设置成功返回0
                其它返回值，暂无意义

      说    明：诊断程序也可以不调用此接口，直接调用 GetNeedShow 接口后判断是否需要Show
    -------------------------------------------------------------------------------------------------*/
    uint32_t InitTitle(const std::string &strTitle); 


    /*-------------------------------------------------------------------------------------------------
      功    能：询问是否需要显示NASTF VSP的验证码输入界面

      参数说明：FunctionsType  通常情况下为四个类型
                               SEC_FUNC_TYPE_ADD_A_KEY      Add a key
                               SEC_FUNC_TYPE_ALL_KEY_LOST   All keys lost
                               SEC_FUNC_TYPE_IMMO           Immobilizer functions
                               SEC_FUNC_TYPE_OTHER          Others

      返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT， -16，当前APP版本还没有此接口
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回

                DF_APP_CURRENT_NOT_SUPPORT_FUNCTION， -17，当前App有此接口，但未实现对应功能

                返回 NOT_VALIDATION_SHOW， 不需要弹窗Show，例如在欧洲区域，返回 0
                返回 NEED_VALIDATION_SHOW， 需要弹窗Show， 例如在北美区域，返回 1
                返回 NEED_OFFLINE_WARNING， 不需要弹窗Show，但是需要弹msgBox离线警告（有离线数据未上报）
                其它返回值，暂无意义

      说    明：无
    -------------------------------------------------------------------------------------------------*/
    uint32_t GetNeedShow(uint32_t FunctionsType);


    /*-------------------------------------------------------------------------------------------------
       功  能：显示NASTF VSP的验证码输入界面
    
       参  数：无
    
       返回值：uint32_t 组件界面按键返回值
               可能存在的返回值：
                           DF_ID_OK
    
       说  明：此接口为阻塞接口
    ----------------------------------------------------------------------------------------------------*/
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_NASTF_H__
