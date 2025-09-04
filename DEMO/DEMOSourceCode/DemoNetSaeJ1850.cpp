/*******************************************************************************
* Copyright (C), 2021, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : CNetSaeJ1850类
* 功能描述 : CNetSaeJ1850接口
* 创 建 人 : panjun        20210419
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#include "DemoNetSaeJ1850.h"

namespace Topdon_AD900_Demo {
	CNetSaeJ1850::CNetSaeJ1850()
	{
		m_bgFilterId.Clear();
	}

	CNetSaeJ1850::~CNetSaeJ1850()
	{
		m_bgFilterId.Clear();
	}

	ErrorCode_t CNetSaeJ1850::ResetFilter()
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		m_pEcuInterface->ClearFilter();

		return ecRet;
	}

	ErrorCode_t CNetSaeJ1850::SetFilterId(CBinary binFilterId /*= CBinary("\x48\x6B", 2)*/)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		uint32_t uSize = binFilterId.GetSize();
		CBinary binMask;
		binMask.Clear();

		for (uint32_t i = 0; i < uSize; i++)
		{
			binMask += 0xFF;
		}

		m_pEcuInterface->SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), binFilterId.GetSize());

		return ecRet;
	}

	ErrorCode_t CNetSaeJ1850::SetFilterId(uint8_t uFilterType, CBinaryGroup bgFilterId)
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

	void CNetSaeJ1850::SetToolId(uint32_t bSourceId)
	{
		m_pGolPackUnpack->SetToolId(bSourceId);
	}

	void CNetSaeJ1850::SetEcuId(uint32_t bTargetId)
	{
		m_pGolPackUnpack->SetEcuId(bTargetId);
	}

	ErrorCode_t CNetSaeJ1850::SetJ1850NodeAddress(uint8_t uNodeAddress)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetJ1850NodeAddress(uNodeAddress);

		return ecRet;
	}

	ErrorCode_t CNetSaeJ1850::SetJ1850FunctionalAddressFilter(vector<uint8_t> vctFunctionalAddress)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetJ1850FunctionalAddressFilter(vctFunctionalAddress);

		return ecRet;
	}

	CSendFrame CNetSaeJ1850::Pack(CSendFrame SendFrame)
	{
		//发送数据打包
		CSendFrame   sfSendFrame;

		sfSendFrame = m_pGolPackUnpack->PackData(SendFrame);

		return sfSendFrame;
	}

	CRecvFrame CNetSaeJ1850::UnPack(CRecvFrame rf)
	{
		CRecvFrame rfRet;

		if (rf.GetSize() > 0)
		{
			rfRet = m_pGolPackUnpack->UnPackData(rf);
		}

		return rfRet;
	}

	CRecvFrame CNetSaeJ1850::SendReceive(CSendFrame SendCmd, uint8_t uPackUnPack)
	{
		CRecvFrame		rfRet;
		CSendFrame		sfSendCmd;	//打包发送数据

		rfRet.Clear();

		if (uPackUnPack & 0x01)
		{
			sfSendCmd = Pack(SendCmd);
		}
		//通信层发送命令
		m_pEcuInterface->SendReceive(sfSendCmd, rfRet);

		//否定应答处理
		if (rfRet.GetSize() > 0)
		{
			m_pNegResponse->SetFrameFormat(m_pGolPackUnpack);
			//m_pNegResponse->SetSendData(SendCmd);
			rfRet = m_pNegResponse->FilterRecvFrame(rfRet);
		}
		//解包收到数据
		if (rfRet.GetSize() > 0)
		{
			if (uPackUnPack & 0x02)
			{
				rfRet = UnPack(rfRet);
			}
		}

		return rfRet;
	}


	// CRecvFrame CNetSaeJ1850::SendReceiveMulti(CSendFrame SendCmd)
	// {
	// 	CRecvFrame rfRet, rfTmp;
	// 	rfRet.Clear();
	// 
	// 	//打包发送数据
	// 	CSendFrame    sfSendCmd = Pack(SendCmd);
	// 
	// 	ErrorCode_t ecRet = m_pEcuInterface->SendReceive(sfSendCmd, rfTmp);
	// 
	// 	if ((ecRet == ErrorCodeType::STATUS_NOERROR) && (rfTmp.GetSize() > 0))
	// 	{
	// 		rfRet.Append(rfTmp.GetFirst());
	// 		CSendFrame sfNull;
	// 		while (1)
	// 		{
	// 			ecRet = m_pEcuInterface->SendReceive(sfNull, rfTmp);
	// 			if ((ecRet == ErrorCodeType::STATUS_NOERROR) && (rfTmp.GetSize() > 0))
	// 			{
	// 				rfRet.Append(rfTmp.GetFirst());
	// 			}
	// 			else
	// 			{
	// 				break;
	// 			}
	// 		}
	// 		m_pNegResponse->SetFrameFormat(m_pGolPackUnpack);
	// 		//m_pNegResponse->SetSendData(sfSendCmd);
	// 		rfRet = m_pNegResponse->FilterRecvFrame(rfRet);
	// 	}
	// 
	// 	if (rfRet.GetSize() > 0)
	// 	{
	// 		rfRet = UnPack(rfRet);
	// 	}
	// 
	// 	return rfRet;
	// }
}