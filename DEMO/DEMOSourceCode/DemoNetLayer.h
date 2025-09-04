/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : �����ӿ���
* �� �� �� : panjun        20200120
* �� �� �� : binchaolin    
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
		��    �ܣ���ȡ��ǰ������ʱ��P1��P2��P3��P4��P5
		����˵������
		�� �� ֵ��COMMTIMEʱ��ṹ
		˵    ������
		-----------------------------------------------------------------------------*/
		COMMTIME GetCommTime();

		/*-----------------------------------------------------------------------------
		��    �ܣ�����������Э����λ��ʽ
		����˵����uProtocolType Э������
				  uBitFormat    λ��ʽ
		�� �� ֵ��ErrorCode_t ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetProtocol(uint8_t uProtocolType, uint8_t eBitFormat = (uint8_t)CStdCommMaco::BitFormatType::BFT_1_8_1_N);

		/*-----------------------------------------------------------------------------
		��    �ܣ����ô��������ʽ
		����˵����uPackUnpackType ����������
		�� �� ֵ����
		˵    ������
		-----------------------------------------------------------------------------*/
		void SetPackUnpack(uint8_t uPackUnpackType);

		/*-----------------------------------------------------------------------------
		��    �ܣ����ò�����
		����˵����uBps ������ֵ
		�� �� ֵ��ErrorCode_t ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetBaudRate(uint32_t uBps, uint32_t uCanFDBps = 0);

		/*-----------------------------------------------------------------------------
		��    �ܣ���������
		����˵����IoOutputPort �������
				  IoInputPin   ��������
				  WorkVoltage  ������ѹ
				  PinProperty  �����߼�
		�� �� ֵ��ErrorCode_t  ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetIoPin(uint8_t IoOutputPin, uint8_t IoInputPin,
			uint8_t   WorkVoltage = (uint8_t)(CStdCommMaco::PinVoltageType::PinVol_12V),
			uint32_t  PinProperty = (uint32_t)(CStdCommMaco::PinPropertyType::PPT_SAME_SIGNAL_K_AND_L_LINE
				| CStdCommMaco::PinPropertyType::PPT_INPUT_POSITIVE_LOGIC
				| CStdCommMaco::PinPropertyType::PPT_OUTPUT_POSITIVE_LOGIC));

		/*-----------------------------------------------------------------------------
		��    �ܣ�����ʱ��
		����˵����uP1 ʱ��P1
				  uP2 ʱ��P2
				  uP3 ʱ��P3
				  uP4 ʱ��P4
				  uP5 ʱ��P5
		�� �� ֵ��ErrorCode_t  ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetCommTime(uint32_t uP1, uint32_t uP2, uint32_t uP3, uint32_t uP4, uint32_t uP5);

		/*-----------------------------------------------------------------------------
		��    �ܣ���·����
		����˵����uKeepTime ��·����ʱ��
				  sfSendCmd ��·����֡
				  KeepType ��·���ַ�ʽ
		�� �� ֵ��ErrorCode_t  ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t KeepLink(uint32_t uKeepTime, CSendFrame sfSendCmd, uint8_t KeepType = (uint8_t)CStdCommMaco::LinkKeepType::LKT_INTERVAL);

		/*-----------------------------------------------------------------------------
		��    �ܣ�������������ID
		����˵����const uint8_t*  RecvFrameId     --
		�� �� ֵ��ErrorCode_t  ��������
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetFlowControlId(const uint8_t* RecvFrameId, const uint8_t* FlowCtrlFrameId, uint32_t FrameIdLength);

		/*-----------------------------------------------------------------------------
		��    �ܣ�Tp20����ͨ��
		����˵����
		�� �� ֵ����
		˵    ������
		-----------------------------------------------------------------------------*/
		ErrorCode_t SetRCXXHandling(CStdCommMaco::RcxxHandlingMode Mode, CStdCommMaco::RcxxHandlingType Type, uint32_t CompletionTimeoutMs, uint32_t WaitNext7FXXTimeMs);


		CRecvFrame InitTp20(uint8_t uAddress);
		//////////////////////////////////////////////////////////////////////////
		//�麯������
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

		COMMTIME m_TimePara;// �洢��ǰ���õ�ʱ��
		CFrameFormat* m_pGolPackUnpack;// ȫ�� ���/�����:������ݴ�����FrameFormatType�������˰�ͷ�������㷨������У���㷨
		CEcuInterface* m_pEcuInterface;// ECUͨ�Žӿ�
		CFrameNegative* m_pNegResponse;// ��Ӧ������

		bool m_IsSendPack = false; //����֡��� true:�����false:�����
		bool m_IsReceiveUnpack = false; //����֡��� true:�����false:�����

	public:
		void SetEnablePack(bool isPack);
		bool IsPackEnabled();
		void SetEnableUnpack(bool isUnpack);
		bool IsUnpackEnabeld();

		ErrorCode_t SetKwp2000FilterId(uint16_t uFilterId);
	};
}
#endif//_NETLAYER_H_
