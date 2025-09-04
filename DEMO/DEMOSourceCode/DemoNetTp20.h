/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : NetTp20接口类
* 创 建 人 : panjun        20200120
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#pragma once

#include "DemoNetLayer.h"
#include "StdInclude.h"
#include "Binary.h"

namespace Topdon_AD900_Demo {

	class CNetTp20 : public CNetLayer
	{
	public:
		CNetTp20();
		~CNetTp20();

		/*-----------------------------------------------------------------------------
		功    能：发送接收命令
		参数说明：sfSendCmd 请求命令
		返 回 值：CReceiveFrame 应答命令
		说    明：无
		-----------------------------------------------------------------------------*/
		CRecvFrame SendReceive(CSendFrame sfSendCmd,uint8_t uPackUnpack);



		/*-----------------------------------------------------------------------------
		功    能：	设置流控制帧类型
		参数说明：	uFlowCtrlMode 流控制类型
		uFlowCtrlTime 流控制帧时间
		uFlowCtrlBlockSize 流控制帧块大小
		返 回 值：	ErrorCode_t 错误类型
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFlowCtrlType(uint8_t uFlowCtrlMode = (uint8_t)CStdCommMaco::FlowCtrlType::FCT_AUTO, uint32_t uFlowCtrlTime = (1 << 31), uint32_t uFlowCtrlBlockSize = (1 << 31));

		/*-----------------------------------------------------------------------------
		功    能：清除缓存数据
		参数说明：
		返 回 值：无
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetClearBuffer(CStdCommMaco::ClearBufferMode Mode = CStdCommMaco::ClearBufferMode::CBM_CLEAR_DISABLE);




	protected:

	};
}