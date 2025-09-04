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

#pragma once

#include "DemoNetLayer.h"
namespace Topdon_AD900_Demo {

	class CNetNormal : public CNetLayer
	{
	public:
		CNetNormal();
		~CNetNormal();

		/*-----------------------------------------------------------------------------
		��    �ܣ�	Normal����
		����˵����	uWaitTimes -- ��������ǰ�ĵȴ�ʱ�䣬һ��300
					uLowVoltageTime -- ����ʱ�䣬һ��25
					uHighVoltageTime -- ����ʱ�䣬һ��25
					SendCmd -- ��������
		�� �� ֵ��	CReceiveFrame -- ���յ�Ӧ������
		˵    ����	��
		-----------------------------------------------------------------------------*/
		CRecvFrame Init(uint32_t uWaitTimes,
			uint32_t uLowVoltageTime,
			uint32_t uHighVoltageTime,
			CSendFrame SendCmd);

		/*-----------------------------------------------------------------------------
		��    �ܣ�	Normal���ٽ���
		����˵����    AddressCode 	    --  ��ַ��
					AddSendBps	        --  ���͵�ַ��Ĳ����ʣ�Ĭ��Ϊ5bps
					EnterType	        --  �����������Э�顢������ȫ�Զ�ʶ��KW2ȡ����
											KW1ȡ������ַ��ȡ�������չؼ��ָ���������һ
											֡���ݣ����ն�֡���ݵȵ�һЩ������Ϣ��

					WaitTimeBeforSendAddress	    --  ���͵�ַ��ǰ�ߵ�ƽ�ȴ�ʱ�䣨��λms��
					SyncByte0x55OverTime	        --  ����0x55�����ȴ�ʱ�䣨��λms��
					ReceiveKwOverTime	            --  ���չؼ��ֵ����ȴ�ʱ�䣨��λms��
					Kw2ReverseWaitTime	            --  �ؼ���KW2ȡ�����ص���Сʱ�䣨��λms��
					ReceiveReverseAddressOverTime	--  ���յ�ַ��ȡ�������ȴ�ʱ�䣨��λms��

					Normal����KWP2000 on K-Line  ��Ӧ��ϵ:
						WaitTimeBeforSendAddress	    --  W0,W5
						SyncByte0x55OverTime	        --  W1
						ReceiveKwOverTime	            --  W2,W3
						Kw2ReverseWaitTime	            --  W4
						ReceiveReverseAddressOverTime	--  ��λ���̶�1000

		�� �� ֵ��	CReceiveFrame ���յ�Ӧ������
		˵    ����	��
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
		��    �ܣ����ͽ�������
		����˵����sfSendCmd ��������
		�� �� ֵ��CReceiveFrame Ӧ������
		˵    ������
		-----------------------------------------------------------------------------*/
		//CRecvFrame SendReceive(CSendFrame sfSendCmd);

		/*-----------------------------------------------------------------------------
		��    �ܣ��������
		����˵����cSendFrame ����
		�� �� ֵ��CSendFrame ����������
		˵    ������
		-----------------------------------------------------------------------------*/
		CSendFrame    Pack(CSendFrame cSendFrame = CSendFrame());

		/*-----------------------------------------------------------------------------
		��    �ܣ��������
		����˵����rf ����
		�� �� ֵ��CRecvFrame ����������
		˵    ������
		-----------------------------------------------------------------------------*/
		CRecvFrame UnPack(CRecvFrame rf);


		/*-----------------------------------------------------------------------------
		��    �ܣ����������
		����˵������
		�� �� ֵ��ErrorCode_t ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t ResetFilter();

		/*-----------------------------------------------------------------------------
		��    �ܣ���ID���ù�����
		����˵����uFilterID ����ID
		�� �� ֵ��ErrorCode_t ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFilterId(uint32_t uFilterID);


		/*-----------------------------------------------------------------------------
		��    �ܣ���ID���ù�����
		����˵����binFilterId ����ID
		�� �� ֵ��ErrorCode_t ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFilterId(CBinary binFilterId);

		/*-----------------------------------------------------------------------------
		��    �ܣ�����֡��ʽ�����д����Ҫ��ToolId
		����˵����
		�� �� ֵ����
		˵    ������
		-----------------------------------------------------------------------------*/
		void SetToolId(uint32_t uTooID);


	protected:


	};
}