/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : NetCAN
* 功能描述 : NetCAN网络层
* 创 建 人 : panjun        20200122
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#include "DemoNetCan.h"
namespace Topdon_AD900_Demo {
	CNetCan::CNetCan()
	{

	}

	CNetCan::~CNetCan()
	{

	}

	CRecvFrame CNetCan::Init(CSendFrame sfSendCmd)
	{
		return SendReceive(sfSendCmd);
	}
	//
	//CRecvFrame CNetCan::SendReceive(CSendFrame SendCmd)
	//{
	//	CRecvFrame rfRet;
	//	rfRet.Clear();
	//
	//	//打包发送数据
	//	CSendFrame    sfSendCmd = Pack(SendCmd);
	//	//通信层发送命令
	//	m_pEcuInterface->SendReceive(sfSendCmd, rfRet);
	//
	//	//否定应答处理
	//	if (rfRet.GetSize() > 0)
	//	{
	//		m_pNegResponse->SetFrameFormat(m_pGolPackUnpack);
	//		//m_pNegResponse->SetSendData(SendCmd);
	//		rfRet = m_pNegResponse->FilterRecvFrame(rfRet);
	//	}
	//	//解包收到数据
	//	if (rfRet.GetSize() > 0)
	//	{
	//		rfRet = UnPack(rfRet);
	//	}
	//
	//	return rfRet;
	//}



	// CRecvFrame CNetCan::SendReceiveMulti(CSendFrame SendCmd)
	// {
	// 	CRecvFrame rfRet, rfTmp;
	// 	rfRet.Clear();
	// 
	// 	//打包发送数据
	// 	CSendFrame    sfSendCmd = Pack(SendCmd);
	// 
	// 	//通信层发送命令
	// 	ErrorCode_t ecRet = m_pEcuInterface->SendReceive(sfSendCmd, rfTmp);
	// 
	// 	//否定应答处理，若收到的多帧有否定应答可能会出问题，因为FilterReceiveFrame里面没有做收多帧处理
	// 	if ((ecRet == CErrorCode::STATUS_NOERROR) && (rfTmp.GetSize() > 0))
	// 	{
	// 		rfRet.Add(rfTmp.GetFirst());
	// 		CSendFrame sfNull;
	// 		while (1)
	// 		{
	// 			ecRet = m_pEcuInterface->SendReceive(sfNull, rfTmp);
	// 			if ((ecRet == CErrorCode::STATUS_NOERROR) && (rfTmp.GetSize() > 0))
	// 			{
	// 				rfRet.Add(rfTmp.GetFirst());
	// 			}
	// 			else
	// 			{
	// 				break;
	// 			}
	// 		}
	// 		m_pNegResponse->SetPackUnpackPointer(m_pCurPackUnpack);
	// 		m_pNegResponse->FilterSendFrame(sfSendCmd.GetFrameData());
	// 		rfRet = m_pNegResponse->FilterReceiveFrame(rfRet);
	// 	}
	// 
	// 	if (rfRet.GetSize() > 0)
	// 	{
	// 		rfRet = UnPack(rfRet);
	// 	}
	// 
	// 	return rfRet;
	// }

	CSendFrame CNetCan::Pack(CSendFrame sfSendFrame)
	{
		if (sfSendFrame.GetSize() > 0)
		{
			sfSendFrame = m_pGolPackUnpack->PackData(sfSendFrame);
		}
		return sfSendFrame;
	}

	CRecvFrame CNetCan::UnPack(CRecvFrame receData)
	{
		CRecvFrame rfRet;

		if (receData.GetSize() > 0)
		{
			rfRet = m_pGolPackUnpack->UnPackData(receData);
		}

		return rfRet;
	}

	ErrorCode_t CNetCan::ResetFilter()
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		m_pEcuInterface->ClearFilter();

		return ecRet;
	}

	ErrorCode_t CNetCan::SetFilterId(CBinary binFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		CBinary		binMask("\xff\xff\xff\xff", 4);

		//CAN协议过滤ID长度必须是4
		while (binFilterId.GetSize() < 4)
		{
			binFilterId.Insert(0, 0x00);
		}
		ecRet = m_pEcuInterface->SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), binFilterId.GetSize());
		return ecRet;
	}

	ErrorCode_t CNetCan::SetFilterId(uint32_t uFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		CBinary binMask = CBinary("\xFF\xFF\xFF\xff", 4);
		CBinary		binFilterId;

		binFilterId.Clear();
		binFilterId += (uFilterId >> 24) & 0xff;
		binFilterId += (uFilterId >> 16) & 0xff;
		binFilterId += (uFilterId >> 8) & 0xff;
		binFilterId += (uFilterId >> 0) & 0xff;


		ecRet = m_pEcuInterface->SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), binFilterId.GetSize());
		return ecRet;
	}

	ErrorCode_t CNetCan::SetFilterId(uint8_t uFilterType, CBinaryGroup bgFilterId)
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

	void CNetCan::SetToolId(uint32_t uTooID)
	{
		m_pGolPackUnpack->SetToolId(uTooID);
		return;
	}

	ErrorCode_t CNetCan::SetFlowCtrlType(uint8_t uFlowCtrlMode, uint32_t uFlowCtrlTime, uint32_t uFlowCtrlBlockSize)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		ecRet = m_pEcuInterface->SetFlowControlMode((CStdCommMaco::FlowCtrlType)uFlowCtrlMode, uFlowCtrlTime, uFlowCtrlBlockSize);
		return ecRet;
	}

	ErrorCode_t CNetCan::SetSingleCanFormatId(uint32_t RxCanId, uint32_t TxCanId, bool SetFlag)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		ecRet = m_pEcuInterface->SetSingleMsgCanFormatId(RxCanId,TxCanId);
		return ecRet;
	}

	ErrorCode_t CNetCan::SetCanFillByte(uint8_t ucFillByte)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetCanFramePad(ucFillByte);

		return ecRet;
	}

	ErrorCode_t CNetCan::SetCanExtendedId(uint8_t bTargetId, uint8_t bSourceId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetCanExtendedAddress(bTargetId, bSourceId);

		return ecRet;
	}
}