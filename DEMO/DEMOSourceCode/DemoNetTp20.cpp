/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : NetTp20
* �������� : NetTp20�����
* �� �� �� : panjun        20200122
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/

#include "DemoNetTp20.h"
namespace Topdon_AD900_Demo {
	CNetTp20::CNetTp20()
	{

	}

	CNetTp20::~CNetTp20()
	{

	}

	CRecvFrame CNetTp20::SendReceive(CSendFrame SendCmd, uint8_t uPackUnpack)
	{
		CRecvFrame		rfRet;

		rfRet.Clear();

		//ͨ�Ų㷢������
		m_pEcuInterface->SendReceive(SendCmd, rfRet);

		//��Ӧ����
		if (rfRet.GetSize() > 0)
		{
			m_pNegResponse->SetFrameFormat(m_pGolPackUnpack);
			rfRet = m_pNegResponse->FilterRecvFrame(rfRet);
		}
		return rfRet;
	}

	ErrorCode_t CNetTp20::SetFlowCtrlType(uint8_t uFlowCtrlMode, uint32_t uFlowCtrlTime, uint32_t uFlowCtrlBlockSize)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		m_pEcuInterface->SetFlowControlSendDelay(200);
		ecRet = m_pEcuInterface->SetFlowControlMode((CStdCommMaco::FlowCtrlType)uFlowCtrlMode);

		return ecRet;
	}

	ErrorCode_t CNetTp20::SetClearBuffer(CStdCommMaco::ClearBufferMode Mode)
	{
		ErrorCode_t ecRet = ErrorCodeType::STATUS_NOERROR;

		ecRet = m_pEcuInterface->SetClearBuffer(Mode);
		return ecRet;
	}
}
