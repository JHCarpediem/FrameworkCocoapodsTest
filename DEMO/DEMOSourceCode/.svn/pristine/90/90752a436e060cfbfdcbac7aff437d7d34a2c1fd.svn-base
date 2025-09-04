/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : NetNormal类
* 功能描述 : NetNormal接口
* 创 建 人 : panjun        20210325
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#pragma once

#include "DemoNetLayer.h"
namespace Topdon_AD900_Demo {

	class CNetNormal : public CNetLayer
	{
	public:
		CNetNormal();
		~CNetNormal();

		/*-----------------------------------------------------------------------------
		功    能：	Normal进入
		参数说明：	uWaitTimes -- 拉低拉高前的等待时间，一般300
					uLowVoltageTime -- 拉低时间，一般25
					uHighVoltageTime -- 拉高时间，一般25
					SendCmd -- 进入命令
		返 回 值：	CReceiveFrame -- 接收的应答数据
		说    明：	无
		-----------------------------------------------------------------------------*/
		CRecvFrame Init(uint32_t uWaitTimes,
			uint32_t uLowVoltageTime,
			uint32_t uHighVoltageTime,
			CSendFrame SendCmd);

		/*-----------------------------------------------------------------------------
		功    能：	Normal慢速进入
		参数说明：    AddressCode 	    --  地址码
					AddSendBps	        --  发送地址码的波特率，默认为5bps
					EnterType	        --  进入参数（如协议、波特率全自动识别，KW2取反，
											KW1取反，地址码取反，接收关键字个数，接收一
											帧数据，接收多帧数据等等一些参数信息）

					WaitTimeBeforSendAddress	    --  发送地址码前高电平等待时间（单位ms）
					SyncByte0x55OverTime	        --  接收0x55的最大等待时间（单位ms）
					ReceiveKwOverTime	            --  接收关键字的最大等待时间（单位ms）
					Kw2ReverseWaitTime	            --  关键字KW2取反发回的最小时间（单位ms）
					ReceiveReverseAddressOverTime	--  接收地址码取反的最大等待时间（单位ms）

					Normal或者KWP2000 on K-Line  对应关系:
						WaitTimeBeforSendAddress	    --  W0,W5
						SyncByte0x55OverTime	        --  W1
						ReceiveKwOverTime	            --  W2,W3
						Kw2ReverseWaitTime	            --  W4
						ReceiveReverseAddressOverTime	--  下位机固定1000

		返 回 值：	CReceiveFrame 接收的应答数据
		说    明：	无
		-----------------------------------------------------------------------------*/
		CRecvFrame Init(uint8_t uAddress,
			uint32_t AddSendBps = 5,
			uint32_t EnterType = (uint32_t)CStdCommMaco::AddressEnterParaType::AEPT_AUTO_BAUDRATE,
			uint32_t WaitTimeBeforSendAddress = 400,
			uint32_t SyncByte0x55OverTime = 300,
			uint32_t ReceiveKwOverTime = 20,
			uint32_t Kw2ReverseWaitTime = 25,
			uint32_t ReceiveReverseAddressOverTime = 1000);

		/*-----------------------------------------------------------------------------
		功    能：发送接收命令
		参数说明：sfSendCmd 请求命令
		返 回 值：CReceiveFrame 应答命令
		说    明：无
		-----------------------------------------------------------------------------*/
		//CRecvFrame SendReceive(CSendFrame sfSendCmd);

		/*-----------------------------------------------------------------------------
		功    能：打包命令
		参数说明：cSendFrame 命令
		返 回 值：CSendFrame 打包后的命令
		说    明：无
		-----------------------------------------------------------------------------*/
		CSendFrame    Pack(CSendFrame cSendFrame = CSendFrame());

		/*-----------------------------------------------------------------------------
		功    能：解包命令
		参数说明：rf 数据
		返 回 值：CRecvFrame 解包后的数据
		说    明：无
		-----------------------------------------------------------------------------*/
		CRecvFrame UnPack(CRecvFrame rf);


		/*-----------------------------------------------------------------------------
		功    能：重设过滤器
		参数说明：无
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ResetFilter();

		/*-----------------------------------------------------------------------------
		功    能：按ID设置过滤器
		参数说明：uFilterID 过滤ID
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFilterId(uint32_t uFilterID);


		/*-----------------------------------------------------------------------------
		功    能：按ID设置过滤器
		参数说明：binFilterId 过滤ID
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFilterId(CBinary binFilterId);

		/*-----------------------------------------------------------------------------
		功    能：设置帧格式类型中打包需要的ToolId
		参数说明：
		返 回 值：无
		说    明：无
		-----------------------------------------------------------------------------*/
		void SetToolId(uint32_t uTooID);


	protected:


	};
}