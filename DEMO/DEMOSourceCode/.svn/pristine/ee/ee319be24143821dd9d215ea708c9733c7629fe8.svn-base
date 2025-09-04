/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 网络层接口类
* 创 建 人 : panjun        20200120
* 审 核 人 : binchaolin    
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/


#ifndef _NETLAYER_H_
#define _NETLAYER_H_

#include "StdCommMaco.h"
#include "SendFrame.h"
#include "RecvFrame.h"
#include "FrameNegative.h"
#include "EcuInterface.h"
#include "MultiSendFrame.h"
#include "MultiRecvFrame.h"

class CFrameNegative;

namespace Topdon_AD900_Demo {
	class CNetLayer
	{
	public:
		enum MyEnum
		{
			FT_ByID = 1,
			FT_ByMask = 2,
			FT_ByRange = 3,
		};

		struct COMMTIME
		{
			uint32_t m_uP1;
			uint32_t m_uP2;
			uint32_t m_uP3;
			uint32_t m_uP4;
			uint32_t m_uP5;
		};

		CNetLayer();
		virtual ~CNetLayer();

		/*-----------------------------------------------------------------------------
		功    能：获取当前网络层的时序P1、P2、P3、P4、P5
		参数说明：无
		返 回 值：COMMTIME时序结构
		说    明：无
		-----------------------------------------------------------------------------*/
		COMMTIME GetCommTime();

		/*-----------------------------------------------------------------------------
		功    能：设置网络层的协议与位格式
		参数说明：uProtocolType 协议类型
				  uBitFormat    位格式
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetProtocol(uint8_t uProtocolType, uint8_t eBitFormat = (uint8_t)CStdCommMaco::BitFormatType::BFT_1_8_1_N);

		/*-----------------------------------------------------------------------------
		功    能：设置打包与解包方式
		参数说明：uPackUnpackType 打包解包类型
		返 回 值：无
		说    明：无
		-----------------------------------------------------------------------------*/
		void SetPackUnpack(uint8_t uPackUnpackType);

		/*-----------------------------------------------------------------------------
		功    能：设置波特率
		参数说明：uBps 波特率值
		返 回 值：ErrorCode_t 错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetBaudRate(uint32_t uBps, uint32_t uCanFDBps = 0);

		/*-----------------------------------------------------------------------------
		功    能：设置引脚
		参数说明：IoOutputPort 输出引脚
				  IoInputPin   输入引脚
				  WorkVoltage  工作电压
				  PinProperty  正负逻辑
		返 回 值：ErrorCode_t  错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetIoPin(uint8_t IoOutputPin, uint8_t IoInputPin,
			uint8_t   WorkVoltage = (uint8_t)(CStdCommMaco::PinVoltageType::PinVol_12V),
			uint32_t  PinProperty = (uint32_t)(CStdCommMaco::PinPropertyType::PPT_SAME_SIGNAL_K_AND_L_LINE
				| CStdCommMaco::PinPropertyType::PPT_INPUT_POSITIVE_LOGIC
				| CStdCommMaco::PinPropertyType::PPT_OUTPUT_POSITIVE_LOGIC));

		/*-----------------------------------------------------------------------------
		功    能：设置时序
		参数说明：uP1 时序P1
				  uP2 时序P2
				  uP3 时序P3
				  uP4 时序P4
				  uP5 时序P5
		返 回 值：ErrorCode_t  错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetCommTime(uint32_t uP1, uint32_t uP2, uint32_t uP3, uint32_t uP4, uint32_t uP5);

		/*-----------------------------------------------------------------------------
		功    能：链路保持
		参数说明：uKeepTime 链路空闲时间
				  sfSendCmd 链路保持帧
				  KeepType 链路保持方式
		返 回 值：ErrorCode_t  错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t KeepLink(uint32_t uKeepTime, CSendFrame sfSendCmd, uint8_t KeepType = (uint8_t)CStdCommMaco::LinkKeepType::LKT_INTERVAL);

		/*-----------------------------------------------------------------------------
		功    能：设置流控制器ID
		参数说明：const uint8_t*  RecvFrameId     --
		返 回 值：ErrorCode_t  错误类型
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFlowControlId(const uint8_t* RecvFrameId, const uint8_t* FlowCtrlFrameId, uint32_t FrameIdLength);

		/*-----------------------------------------------------------------------------
		功    能：Tp20建立通道
		参数说明：
		返 回 值：无
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetRCXXHandling(CStdCommMaco::RcxxHandlingMode Mode, CStdCommMaco::RcxxHandlingType Type, uint32_t CompletionTimeoutMs, uint32_t WaitNext7FXXTimeMs);


		CRecvFrame InitTp20(uint8_t uAddress);
		//////////////////////////////////////////////////////////////////////////
		//虚函数区域
		virtual CRecvFrame Init(CSendFrame sfsendCmd);
		virtual CRecvFrame Init(uint32_t uWaitTimes, uint32_t uLowVoltageTime, uint32_t uHighVoltageTime, CSendFrame SendFrame);
		virtual CRecvFrame Init(uint8_t uAddress, uint32_t AddSendBps = 5, uint32_t EnterType = (uint32_t)CStdCommMaco::AddressEnterParaType::AEPT_AUTO_ALL, uint32_t WaitTimeBeforSendAddress = 800, uint32_t SyncByte0x55OverTime = 350, uint32_t ReceiveKwOverTime = 200, uint32_t Kw2ReverseWaitTime = 40, uint32_t ReceiveReverseAddressOverTime = 1000);
		virtual CRecvFrame Init(CSendFrame sfsendCmd, uint8_t uAddress);
		virtual CRecvFrame SendReceive(CSendFrame SendCmd, uint8_t uFrameNum = 0xFF);
		virtual CRecvFrame SendReceive(CBinary binSendCmd, uint8_t uSendType);
		virtual CMultiRecvFrame SendReceiveMulti(CMultiSendFrame mulsfSendCmd);
		virtual CSendFrame Pack(CSendFrame SendCmd);
		virtual CRecvFrame UnPack(CRecvFrame recvFrame);
		virtual ErrorCode_t ResetFilter();
		virtual ErrorCode_t SetFilterId(CBinary binFilterId);
		virtual ErrorCode_t SetFilterId(uint32_t uFilterId);
		virtual ErrorCode_t SetFilterId(uint8_t uFilterType, CBinaryGroup bgFilterId);
		virtual ErrorCode_t SetFlowCtrlType(uint8_t FlowControlMode, uint32_t FlowControlTimes = 0, uint32_t FlowControlBlockSize = 0);
		virtual ErrorCode_t SetCanFillByte(uint8_t uFillByte);
		virtual ErrorCode_t SetCanExtendedId(uint8_t uTargetId, uint8_t uSourceId);
		virtual void SetToolId(uint32_t uSourceId);
		virtual void SetEcuId(uint32_t uTargetId);
		virtual ErrorCode_t SetJ1850NodeAddress(uint8_t uNodeAddress);
		virtual ErrorCode_t SetJ1850FunctionalAddressFilter(vector<uint8_t> vctFunctionalAddress);
		virtual ErrorCode_t SetSingleCanFormatId(uint32_t RxCanId, uint32_t TxCanId = 0, bool SetFlag = true);


	public:

		COMMTIME m_TimePara;// 存储当前设置的时序
		CFrameFormat* m_pGolPackUnpack;// 全局 打包/解包类:该类根据打包解包FrameFormatType，设置了包头、长度算法与数据校验算法
		CEcuInterface* m_pEcuInterface;// ECU通信接口
		CFrameNegative* m_pNegResponse;// 否定应答处理类

		bool m_IsSendPack = false; //发送帧打包 true:打包，false:不打包
		bool m_IsReceiveUnpack = false; //接收帧打包 true:打包，false:不打包

	public:
		void SetEnablePack(bool isPack);
		bool IsPackEnabled();
		void SetEnableUnpack(bool isUnpack);
		bool IsUnpackEnabeld();

		ErrorCode_t SetKwp2000FilterId(uint16_t uFilterId);
	};
}
#endif//_NETLAYER_H_
