/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : NetKwp2000��
* �������� : Netkwp2000�ӿ�
* �� �� �� : panjun        20210325
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/

#include "DemoNetKwp2000.h"
namespace Topdon_AD900_Demo {
	CNetKwp2000::CNetKwp2000()
	{

	}

	CNetKwp2000::~CNetKwp2000()
	{

	}

	CRecvFrame CNetKwp2000::Init(uint32_t uWaitTimes, uint32_t uLowVoltageTime, uint32_t uHighVoltageTime, CSendFrame SendCmd)
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

	CRecvFrame CNetKwp2000::Init(uint8_t uAddress, uint32_t AddSendBps, uint32_t EnterType, uint32_t WaitTimeBeforSendAddress, uint32_t SyncByte0x55OverTime, uint32_t ReceiveKwOverTime, uint32_t Kw2ReverseWaitTime, uint32_t ReceiveReverseAddressOverTime)
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

	CSendFrame CNetKwp2000::Pack(CSendFrame sfSendFrame)
	{
		if (sfSendFrame.GetSize() > 0)
		{
			sfSendFrame = m_pGolPackUnpack->PackData(sfSendFrame);
		}
		return sfSendFrame;
	}

	CRecvFrame CNetKwp2000::UnPack(CRecvFrame receData)
	{
		CRecvFrame rfRet;

		if (receData.GetSize() > 0)
		{
			rfRet = m_pGolPackUnpack->UnPackData(receData);
		}

		return rfRet;
	}

	ErrorCode_t CNetKwp2000::ResetFilter()
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		m_pEcuInterface->ClearFilter();

		return ecRet;
	}

	ErrorCode_t CNetKwp2000::SetFilterId(uint32_t uFilterID)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		CBinary binMask = CBinary("\x00\xFF\xFF", 3);
		CBinary binFilterId = CBinary("\x00\xFF\xFF", 3);

		binFilterId.SetAt(1, (uFilterID >> 8) & 0xFF);
		binFilterId.SetAt(2, uFilterID & 0xFF);

		ecRet = m_pEcuInterface->SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), binFilterId.GetSize());
		return ecRet;
	}

	ErrorCode_t CNetKwp2000::SetFilterId(CBinary binFilterId)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;
		return ecRet;
	}

	void CNetKwp2000::SetToolId(uint32_t uTooID)
	{
		m_pGolPackUnpack->SetToolId(uTooID);
		return;
	}

	//CRecvFrame CNetKwp2000::SendReceive(CSendFrame SendCmd)
	//{
	//	CRecvFrame rfRet;
	//
	//	//�����������
	//	CSendFrame    sfSendCmd = Pack(SendCmd);
	//
	//	//ͨ�Ų㷢������
	//	m_pEcuInterface->SendReceive(sfSendCmd, rfRet);
	//
	//	//��Ӧ����
	//	if (rfRet.GetSize() > 0)
	//	{
	//		m_pNegResponse->SetFrameFormat(m_pGolPackUnpack);
	//		//m_pNegResponse->SetSendData(sfSendCmd);
	//		rfRet = m_pNegResponse->FilterRecvFrame(rfRet);
	//	}
	//	//����յ�����
	//	if (rfRet.GetSize() > 0)
	//	{
	//		rfRet = UnPack(rfRet);
	//	}
	//
	//	return rfRet;
	//}

}