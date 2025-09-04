/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : NetNormal��
* �������� : NetNormal�ӿ�
* �� �� �� : panjun        20210325
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/

#include "DemoNetNormal.h"
namespace Topdon_AD900_Demo {
	CNetNormal::CNetNormal()
	{

	}

	CNetNormal::~CNetNormal()
	{

	}

	CRecvFrame CNetNormal::Init(uint32_t uWaitTimes, uint32_t uLowVoltageTime, uint32_t uHighVoltageTime, CSendFrame SendCmd)
	{
		CRecvFrame rfRet;

		m_pEcuInterface->QuickEnter(SendCmd, rfRet, uWaitTimes, uLowVoltageTime, uHighVoltageTime);

		//��Ӧ����
		m_pNegResponse->SetFrameFormat(m_pGolPackUnpack);
		//m_pNegResponse->SetSendData(SendCmd);
		if (rfRet.GetSize())
		{
			rfRet = m_pNegResponse->FilterRecvFrame(rfRet);
		}
		//����յ�����
		if (rfRet.GetSize() > 0)
		{
			rfRet = UnPack(rfRet);
		}

		return rfRet;
	}

	CRecvFrame CNetNormal::Init(uint8_t uAddress, uint32_t AddSendBps, uint32_t EnterType, uint32_t WaitTimeBeforSendAddress, uint32_t SyncByte0x55OverTime, uint32_t ReceiveKwOverTime, uint32_t Kw2ReverseWaitTime, uint32_t ReceiveReverseAddressOverTime)
	{
		CRecvFrame rfRet;

		m_pEcuInterface->AddressCodeEnter(uAddress, \
			rfRet, \
			AddSendBps, \
			(CStdCommMaco::AddressEnterParaType)EnterType, \
			WaitTimeBeforSendAddress, \
			SyncByte0x55OverTime, \
			ReceiveKwOverTime, \
			Kw2ReverseWaitTime, \
			ReceiveReverseAddressOverTime);

		return rfRet;
	}

	CSendFrame CNetNormal::Pack(CSendFrame sfSendFrame)
	{
		if (sfSendFrame.GetSize() > 0)
		{
			sfSendFrame = m_pGolPackUnpack->PackData(sfSendFrame);
		}
		return sfSendFrame;
	}

	CRecvFrame CNetNormal::UnPack(CRecvFrame receData)
	{
		CRecvFrame rfRet;

		if (receData.GetSize() > 0)
		{
			rfRet = m_pGolPackUnpack->UnPackData(receData);
		}

		return rfRet;
	}

	ErrorCode_t CNetNormal::ResetFilter()
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		m_pEcuInterface->ClearFilter();

		return ecRet;
	}

	ErrorCode_t CNetNormal::SetFilterId(uint32_t uFilterID)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		CBinary binMask = CBinary("\x00\xFF\xFF", 3);
		CBinary binFilterId = CBinary("\x00\xFF\xFF", 3);

		binFilterId.SetAt(1, (uFilterID >> 8) & 0xFF);
		binFilterId.SetAt(2, uFilterID & 0xFF);

		ecRet = m_pEcuInterface->SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), binFilterId.GetSize());
		return ecRet;
	}

	ErrorCode_t CNetNormal::SetFilterId(CBinary binFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		return ecRet;
	}

	void CNetNormal::SetToolId(uint32_t uTooID)
	{
		m_pGolPackUnpack->SetToolId(uTooID);
		return;
	}
}