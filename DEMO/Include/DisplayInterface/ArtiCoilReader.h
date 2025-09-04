/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 TDarts RFID 钥匙线圈检测 控件
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_COIL_READER_H__
#define __ARTI_COIL_READER_H__

#include "StdInclude.h"
#include "StdShowMaco.h"

// 线圈检测示意图
// 
// 1、线圈检测根据检测到和没有检测到，分为“有信号”和“无信号”两种
// 
// 
//
class _STD_SHOW_DLL_API_ CArtiCoilReader
{
public:
    enum eSignalType
    {
        SIGNAL_IS_NOT_SET   = 0, // 无信号，即没有检测到线圈
        SIGNAL_IS_SET       = 1, // 有信号，即检测到线圈
    };

public:
    CArtiCoilReader();

#ifdef MULTI_SYSTEM
    CArtiCoilReader(uint32_t thId);
#endif // MULTI_SYSTEM


    ~CArtiCoilReader();


    /*******************************************************************
    *    功  能：初始化线圈检测控件
    * 
    *    参  数：strTitle 浏览框标题
    * 
    *    返回值：true 初始化成功 false 初始化失败
    * 
    ****************************************************************************/
    void InitTitle(const std::string &strTitle); 


    /*******************************************************************
    *    功  能：设置线圈检测的状态，检测到还是未检测到线圈
    *
    *    参  数：eType    状态类型，例如，SIGNAL_IS_NOT_SET，没有检测到线圈
    *                             例如，SIGNAL_IS_SET，检测到线圈
    *
    *    返回值：无
    *
    *    说 明： 如果没有调用此接口，默认为 SIGNAL_IS_NOT_SET，即没有检测到线圈
    ****************************************************************************/
    void SetCoilSignal(eSignalType eType);


    /********************************************************************
    *    功  能：显示线圈检测的状态界面
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 组件界面按键返回值
    *            指示用户是点击了"返回"按钮
    *    
    *     可能存在以下返回：
    *                        DF_ID_BACK
    * 
    *    说  明：此接口为非阻塞接口
    *********************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_COIL_READER_H__
