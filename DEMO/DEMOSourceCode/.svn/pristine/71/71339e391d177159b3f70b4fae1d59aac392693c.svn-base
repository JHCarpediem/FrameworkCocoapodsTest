/*******************************************************************************
* Copyright (C), 2021, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : NetSaeJ1850类
* 功能描述 : NetSaeJ1850接口
* 创 建 人 : panjun        20210419
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#pragma once

#include "DemoNetLayer.h"
namespace Topdon_AD900_Demo {
	class CNetSaeJ1850 :public CNetLayer
	{
	public:
	public:
		CNetSaeJ1850();
		~CNetSaeJ1850();

		/*-----------------------------------------------------------------------------
		功    能：重设过滤器
		参数说明：无
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ResetFilter();

		/*-----------------------------------------------------------------------------
		功    能：按ID设置过滤器
		参数说明：binFilterId 过滤ID
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFilterId(CBinary binFilterId = CBinary("\x48\x6B", 2));

		/*-----------------------------------------------------------------------------
		功    能：根据类型进行过滤
		参数说明：bgFilterId 为过滤ID的集合，规则如下：
						  uFilterType为过滤类型，FT_ByID，FT_ByMask，FT_ByRange
						  FT_ByID时,bgFilterId[0]为000007E0,单个存在
						  FT_ByMask时,bgFilterId[0]为FFFFFF00,bgFilterId[1]为18DA11F1,1是掩码，2是过滤ID，且ID长度一致,成对存在
						  FT_ByRange时,bgFilterId[0]为18F11000,bgFilterId[1]为18F11A00, 1是起始ID，2是结束ID，且ID长度一致,成对存在
						  多组ID同时过滤
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFilterId(uint8_t uFilterType, CBinaryGroup bgFilterId);

		/*-----------------------------------------------------------------------------
		功    能：	设置设备地址
		参数说明：	uToolId 设备地址
		返 回 值：	无
		说    明：	无
		-----------------------------------------------------------------------------*/
		void SetToolId(uint32_t uToolId);

		/*-----------------------------------------------------------------------------
		功    能：	设置目标地址
		参数说明：	bEcuId 目标地址
		返 回 值：	无
		说    明：	无
		-----------------------------------------------------------------------------*/
		void SetEcuId(uint32_t bEcuId); //设置EcuId    目标地址

		/*-----------------------------------------------------------------------------
		功    能：	设置J1850节点地址

		参数说明：	W_U8 uNodeAddress    --  设置J1850节点地址

					参考 SAE-J2178-1 "Class B Data Communication Network Messages—Detailed
					Header Formats and Physical Address Assignments"

					SAE-J1850 PWM消息头格式中，BYTE1 BYTE2 BYTE3 DATA
					BYTE1  ----  Header Format
					BYTE2  ----  目的地址
					BYTE3  ----  源地址

					BYTE1 格式：
					Bit7 | Bit6 | Bit5 | Bit4 | Bit3 | Bit2 | Bit1 | Bit0
					P  |   P  |   P  |   0  |   K  |   Y  |   Z  |   Z

					PPP: 优先级（0-7）；
					K:   是否需要IFR，0，需要IFR；1，不需要IFR；
					Y:   地址模式，0，功能性地址；1，物理地址；
					ZZ:  指定的消息类型

					对于J1850总线上的数据，如果消息头的K为0（需要IFR），则需要回复IFR，
					IFR字节值即为NodeAddress；

					通信库默认NodeAddress为0xF1

		返 回 值：	ErrorCode_t 错误代码

		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetJ1850NodeAddress(uint8_t uNodeAddress);

		/*-----------------------------------------------------------------------------
		功    能：打包命令
		参数说明：tabCmd 命令
		返 回 值：CSendFrame 打包后的命令
		说    明：无
		-----------------------------------------------------------------------------*/
		CSendFrame Pack(CSendFrame SendFrame);

		/*-----------------------------------------------------------------------------
		功    能：解包命令
		参数说明：rf 数据
		返 回 值：CRecvFrame 解包后的数据
		说    明：无
		-----------------------------------------------------------------------------*/
		CRecvFrame UnPack(CRecvFrame rf);

		/*-----------------------------------------------------------------------------
		功    能：发送接收命令
		参数说明：sfSendCmd 请求命令,uPackUnPack 发送和接收需不需要打包解包 &01为真打包  &02为真解包
		返 回 值：CReceiveFrame 应答命令
		说    明：无
		-----------------------------------------------------------------------------*/
		CRecvFrame SendReceive(CSendFrame sfSendCmd, uint8_t uPackUnPack = 3);

		/*-----------------------------------------------------------------------------
		功    能：设置J1850功能性地址过滤，默认会增加相应地址的过滤器
				  重复调用，以最后一次调用为准

		参数说明：vector<uint8_t>& vctFunctionalAddress    --  功能性地址过滤表

				  参考 SAE-J2178-1 "Class B Data Communication Network Messages—Detailed
										Header Formats and Physical Address Assignments"

				  SAE-J1850 PWM消息头格式中，BYTE1 BYTE2 BYTE3 DATA
							BYTE1  ----  Header Format
							BYTE2  ----  目的地址
							BYTE3  ----  源地址

				  BYTE1 格式：
							Bit7 | Bit6 | Bit5 | Bit4 | Bit3 | Bit2 | Bit1 | Bit0
							  P  |   P  |   P  |   0  |   K  |   Y  |   Z  |   Z

						PPP: 优先级（0-7）；
						K:   是否需要IFR，0，需要IFR；1，不需要IFR；
						Y:   地址模式，0，功能性地址；1，物理地址；
						ZZ:  指定的消息类型

				 对于J1850总线上的数据，如果消息头的Y为0（功能性地址），则需要“功能性地址过滤”；

				 通信库默认vctFunctionalAddress为“0x6B”，长度为1；

		返 回 值：设置成功，返回0，    CStdCommMaco::STATUS_NOERROR
				  其它值，设置失败

		说    明：向量表数组
				  调用此接口，会清除以前的功能地址表，以最后一次调用为准

		附加(下位机收PWM数据流程如下):
			1、收总线数据放到buffer中；

			2、判断BYTE1是否是功能地址（相当于广播数据），是则判断BYTE2是否匹配功能地址表，
			   匹配OK跳至4，不匹配丢弃；

			3、判断BYTE1是否是物理地址，是物理地址则跳至4

			4、正常过滤器过滤；
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetJ1850FunctionalAddressFilter(vector<uint8_t> vctFunctionalAddress);

		// 	/*-----------------------------------------------------------------------------
		// 	功    能：发送接收命令，接受多帧
		// 	参数说明：SendCmd 请求命令
		// 	返 回 值：CRecvFrame 应答命令
		// 	说    明：无
		// 	-----------------------------------------------------------------------------*/
		// 	CRecvFrame SendReceiveMulti(CSendFrame SendCmd);

	protected:
		CBinaryGroup m_bgFilterId;

	};
}