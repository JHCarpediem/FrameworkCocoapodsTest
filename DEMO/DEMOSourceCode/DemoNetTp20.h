/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : NetTp20�ӿ���
* �� �� �� : panjun        20200120
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
		��    �ܣ����ͽ�������
		����˵����sfSendCmd ��������
		�� �� ֵ��CReceiveFrame Ӧ������
		˵    ������
		-----------------------------------------------------------------------------*/
		CRecvFrame SendReceive(CSendFrame sfSendCmd,uint8_t uPackUnpack);



		/*-----------------------------------------------------------------------------
		��    �ܣ�	����������֡����
		����˵����	uFlowCtrlMode ����������
		uFlowCtrlTime ������֡ʱ��
		uFlowCtrlBlockSize ������֡���С
		�� �� ֵ��	ErrorCode_t ��������
		˵    ����	��
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFlowCtrlType(uint8_t uFlowCtrlMode = (uint8_t)CStdCommMaco::FlowCtrlType::FCT_AUTO, uint32_t uFlowCtrlTime = (1 << 31), uint32_t uFlowCtrlBlockSize = (1 << 31));

		/*-----------------------------------------------------------------------------
		��    �ܣ������������
		����˵����
		�� �� ֵ����
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetClearBuffer(CStdCommMaco::ClearBufferMode Mode = CStdCommMaco::ClearBufferMode::CBM_CLEAR_DISABLE);




	protected:

	};
}