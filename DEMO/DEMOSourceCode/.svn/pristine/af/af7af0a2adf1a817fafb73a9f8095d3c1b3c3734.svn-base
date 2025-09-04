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


//#include "stdafx.h"
#include "DemoNetLayer.h"
#include "StdCommMaco.h"
namespace Topdon_AD900_Demo {
	CNetLayer::CNetLayer()
	{
		m_TimePara.m_uP1 = 0;
		m_TimePara.m_uP2 = 50;
		m_TimePara.m_uP3 = 50;
		m_TimePara.m_uP4 = 5;
		m_TimePara.m_uP5 = 500;

		m_pEcuInterface = new CEcuInterface();
		m_pGolPackUnpack = new CFrameFormat();
		m_pNegResponse = new CFrameNegative();
		m_pNegResponse->SetNetLayer(this);
		//	m_pNegResponse->SetEcuInterfacePointer(m_pEcuInterface);
	}

	CNetLayer::~CNetLayer()
	{
		if (m_pGolPackUnpack != NULL)
		{
			delete m_pGolPackUnpack;
			m_pGolPackUnpack = NULL;
		}
		if (m_pNegResponse != NULL)
		{
			delete m_pNegResponse;
			m_pNegResponse = NULL;
		}
		//#ifdef WIN32
		if (m_pEcuInterface != NULL)
		{
			delete m_pEcuInterface;
			m_pEcuInterface = NULL;
		}
		//#endif
	}

	ErrorCode_t CNetLayer::SetJ1850NodeAddress(uint8_t uNodeAddress)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		return ecRet;
	}

	ErrorCode_t CNetLayer::SetJ1850FunctionalAddressFilter(vector<uint8_t> vctFunctionalAddress)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		return ecRet;
	}

	CNetLayer::COMMTIME CNetLayer::GetCommTime()
	{
		return m_TimePara;
	}

	ErrorCode_t CNetLayer::SetProtocol(uint8_t uProtocolType, uint8_t uBitFormat)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetProtocolType((CStdCommMaco::ProtocolType)uProtocolType, (CStdCommMaco::BitFormatType)uBitFormat);

		return ecRet;
	}

	void CNetLayer::SetPackUnpack(uint8_t uPackUnpackType)
	{
		m_pGolPackUnpack->SetFrameFormatType((CStdCommMaco::FrameFormatType)uPackUnpackType);
		return;
	}

	ErrorCode_t CNetLayer::SetBaudRate(uint32_t uBps,uint32_t uCanFDBps)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetBaudRate(uBps, uCanFDBps);

		return ecRet;
	}

	ErrorCode_t CNetLayer::SetIoPin(uint8_t IoOutputPort, uint8_t IoInputPin, uint8_t WorkVoltage, uint32_t PinProperty)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetIoPin((CStdCommMaco::ObdPinType)IoOutputPort, (CStdCommMaco::ObdPinType)IoInputPin, (CStdCommMaco::PinVoltageType)WorkVoltage, (CStdCommMaco::PinPropertyType)PinProperty);

		return ecRet;
	}

	ErrorCode_t CNetLayer::SetCommTime(uint32_t uP1, uint32_t uP2, uint32_t uP3, uint32_t uP4, uint32_t uP5)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		//保存时序
		m_TimePara.m_uP1 = uP1;
		m_TimePara.m_uP2 = uP2;
		m_TimePara.m_uP3 = uP3;
		m_TimePara.m_uP4 = uP4;
		m_TimePara.m_uP5 = uP5;

		//设置通信时序
		ecRet = m_pEcuInterface->SetCommTime(m_TimePara.m_uP1, m_TimePara.m_uP2, m_TimePara.m_uP3, m_TimePara.m_uP4, m_TimePara.m_uP5);

		return ecRet;
	}

	ErrorCode_t CNetLayer::KeepLink(uint32_t uKeepTime, CSendFrame sfLinkKeep, uint8_t KeepType)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		//通信层设置链路保持
		sfLinkKeep = IsPackEnabled() ? Pack(sfLinkKeep) : sfLinkKeep;
		ecRet = m_pEcuInterface->SetLinkKeep(uKeepTime, sfLinkKeep, (CStdCommMaco::LinkKeepType)KeepType);

		return ecRet;
	}

	CRecvFrame CNetLayer::SendReceive(CSendFrame sfSendCmd, uint8_t uFrameNum)
	{
		CRecvFrame recvFrame; recvFrame.Clear();
		sfSendCmd = IsPackEnabled() ? Pack(sfSendCmd) : sfSendCmd;
		sfSendCmd.SetRecvFrameNum(uFrameNum);

		//!!!注意，多路CAN协议通信时，发送命令前，先清除缓存，否则接收命令会错乱!!!
		m_pEcuInterface->SetClearBuffer(CStdCommMaco::ClearBufferMode::CBM_CLEAR_COMM_RX_QUEUE);

		ErrorCode_t ecRet = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;
		for (uint8_t i=0; i<3; i++)
		{
			ecRet = m_pEcuInterface->SendReceive(sfSendCmd, recvFrame);
			if (recvFrame.GetSize()>0)
			{
				break;
			}
		}
		recvFrame = IsUnpackEnabeld() ? UnPack(recvFrame) : recvFrame;
		return recvFrame;
	}

	CRecvFrame CNetLayer::SendReceive(CBinary binSendCmd, uint8_t uSendType)
	{
		return CRecvFrame();
	}

	CMultiRecvFrame CNetLayer::SendReceiveMulti(CMultiSendFrame mulsfSendCmd)
	{
		return CMultiRecvFrame();
	}

	CSendFrame CNetLayer::Pack(CSendFrame sfSendFrame)
	{
		if (sfSendFrame.GetSize() > 0)
		{
			sfSendFrame = m_pGolPackUnpack->PackData(sfSendFrame);
		}
		return sfSendFrame;
	}

	CRecvFrame CNetLayer::UnPack(CRecvFrame receData)
	{
		if (receData.GetSize() > 0)
		{
			receData = m_pGolPackUnpack->UnPackData(receData);
		}
		return receData;
	}

	ErrorCode_t CNetLayer::ResetFilter()
	{
		return 	ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CNetLayer::SetFilterId(CBinary binFilterId)
	{
		return ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CNetLayer::SetFilterId(uint8_t uFilterType, CBinaryGroup bgFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		uint32_t	uSize = bgFilterId.GetSize();
		//添加通信层数据过滤设置

		switch (uFilterType)
		{
		case FT_ByID:
			for (uint32_t i = 0; i < bgFilterId.GetSize(); i++)
			{
				ecRet = SetFilterId(bgFilterId[i]);
			}
			break;
		case FT_ByMask:
			if (uSize % 2 == 0)
			{
				for (uint32_t i = 0; i < uSize / 2; i++)
				{
					m_pEcuInterface->SetFilterId(bgFilterId[2 * i].GetBuffer(), bgFilterId[2 * i + 1].GetBuffer(), bgFilterId[2 * i].GetSize());
				}
			}
			break;
		case FT_ByRange:
			if (uSize % 2 == 0)
			{
				for (uint32_t i = 0; i < uSize / 2; i++)
				{
					m_pEcuInterface->SetFilterIdRange(bgFilterId[2 * i].GetBuffer(), bgFilterId[2 * i + 1].GetBuffer(), bgFilterId[2 * i].GetSize());
				}
			}
			break;
		default:
			ecRet = ErrorCodeType::ERR_FAILED;
			break;
		}
		return ecRet;
	}

	ErrorCode_t CNetLayer::SetFilterId(uint32_t uFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		CBinary		binMask("\xff\xff\xff\xff", 4);
		CBinary		binFilterId;

		binFilterId.Clear();
		binFilterId += (uFilterId >> 24) & 0xff;
		binFilterId += (uFilterId >> 16) & 0xff;
		binFilterId += (uFilterId >> 8) & 0xff;
		binFilterId += (uFilterId >> 0) & 0xff;

		ecRet = m_pEcuInterface->SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), binFilterId.GetSize());
		return ecRet;
	}

	ErrorCode_t CNetLayer::SetFlowCtrlType(uint8_t uFlowCtrlMode, uint32_t uFlowCtrlTime, uint32_t uFlowCtrlBlockSize)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		ecRet = m_pEcuInterface->SetFlowControlMode((CStdCommMaco::FlowCtrlType)uFlowCtrlMode, uFlowCtrlTime, uFlowCtrlBlockSize);
		return ecRet;
	}

	ErrorCode_t CNetLayer::SetFlowControlId(const uint8_t* RecvFrameId, const uint8_t* FlowCtrlFrameId, uint32_t FrameIdLength)
	{
		return ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CNetLayer::SetCanFillByte(uint8_t ucFillByte)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		ecRet = m_pEcuInterface->SetCanFramePad(ucFillByte);
		return ecRet;
	}

	ErrorCode_t CNetLayer::SetCanExtendedId(uint8_t uTargetId, uint8_t uSourceId)
	{
		return ErrorCodeType::STATUS_NOERROR;
	}

	void CNetLayer::SetToolId(uint32_t uSourceId)
	{
		m_pGolPackUnpack->SetToolId(uSourceId);
		return;
	}

	void CNetLayer::SetEcuId(uint32_t uTargetId)
	{
		m_pGolPackUnpack->SetEcuId(uTargetId);
		return;
	}

	void CNetLayer::SetEnablePack(bool isPack)
	{
		m_IsSendPack = isPack;
	}

	bool CNetLayer::IsPackEnabled()
	{
		return m_IsSendPack;
	}

	void CNetLayer::SetEnableUnpack(bool isUnpack)
	{
		m_IsReceiveUnpack = isUnpack;
	}

	bool CNetLayer::IsUnpackEnabeld()
	{
		return m_IsReceiveUnpack;
	}

	ErrorCode_t CNetLayer::SetKwp2000FilterId(uint16_t uFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		CBinary filterMask = CBinary("\x00\xFF\xFF", 3);
		CBinary filterPattern = CBinary("\x00\xF1\x10", 3);
		filterPattern.SetAt(2, uFilterId & 0x0ff);

		ecRet = m_pEcuInterface->SetFilterId(filterMask.GetBuffer(), filterPattern.GetBuffer(), filterPattern.GetSize());
		return ecRet;
	}

	// ErrorCode_t CNetLayer::SetJ1850NodeAddress(uint8_t uNodeAddress)
	// {
	// 	return ErrorCodeType::STATUS_NOERROR;
	// }


	CRecvFrame CNetLayer::Init(CSendFrame SendCmd)
	{
		return CRecvFrame();
	}

	CRecvFrame CNetLayer::Init(uint32_t uWaitTimes, uint32_t uLowVoltageTime, uint32_t uHighVoltageTime, CSendFrame SendCmd)
	{
		return CRecvFrame();
	}

	CRecvFrame CNetLayer::Init(uint8_t uAddress, uint32_t AddSendBps /*= CLibStdCommDef::CBR_5_bps*/, uint32_t EnterType /*= CLibStdCommDef::ACEP_AUTO_BPS*/, uint32_t WaitTimeBeforSendAddress /*= 400*/, uint32_t SyncByte0x55OverTime /*= 300*/, uint32_t ReceiveKwOverTime /*= 20*/, uint32_t Kw2ReverseWaitTime /*= 25*/, uint32_t ReceiveReverseAddressOverTime /*= 1000*/)
	{
		return CRecvFrame();
	}

	CRecvFrame CNetLayer::Init(CSendFrame SendCmd, uint8_t uAddress)
	{
		return CRecvFrame();
	}

	ErrorCode_t CNetLayer::SetRCXXHandling(CStdCommMaco::RcxxHandlingMode Mode, CStdCommMaco::RcxxHandlingType Type, uint32_t CompletionTimeoutMs, uint32_t WaitNext7FXXTimeMs)
	{
		return m_pEcuInterface->SetRCXXHandling(Mode, Type, CompletionTimeoutMs, WaitNext7FXXTimeMs);
	}

	CRecvFrame CNetLayer::InitTp20(uint8_t uAddress)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		CRecvFrame EnterFrame;

		ecRet = m_pEcuInterface->TP20Enter(uAddress, EnterFrame);
		return EnterFrame;
	}

	ErrorCode_t CNetLayer::SetSingleCanFormatId(uint32_t RxCanId, uint32_t TxCanId, bool SetFlag)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		return ecRet;
	}
}