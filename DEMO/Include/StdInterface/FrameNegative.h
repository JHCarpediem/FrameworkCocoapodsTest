/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ��Ӧ��֡������࣬�����ṩ����֡�ķ񶨴���ӿڣ���������������ʹ��
* �� �� �� : sujiya        
* �� �� �� : binchaolin    
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef _FRAME_NEGATIVE_H_
#define _FRAME_NEGATIVE_H_
#include "StdInclude.h"
#include "Binary.h"
#include "SendFrame.h"
#include "RecvFrame.h"
#include "FrameFormat.h"

class CNetLayer;
class _STD_DLL_API_ CFrameNegative
{//�������ʵ�֣���Ҫʹ�õ�ͨѶ�ӿ����շ����ݣ�
	//�������ĳЭ����Ҫ���⴦�����������������ʵ��
public:
	CFrameNegative(uint8_t uNegByte = 0x7F) :m_uNegByte(uNegByte), 
		m_pSendFrame(nullptr),
		m_i7F21CycleTime(10), 
		m_i7F78CycleTime(10)
	{
	}

	CFrameNegative(const CSendFrame& right, uint8_t uNegByte = 0x7F) :m_uNegByte(uNegByte),
		m_pSendFrame(new CSendFrame(right)),
		m_i7F21CycleTime(10), 
		m_i7F78CycleTime(10)
		
	{
	}

	virtual ~CFrameNegative() 
	{ 
		if(m_pSendFrame != nullptr)
			delete m_pSendFrame; 
	}


	//�����һ��Ҫ���ã��漰���շ�����
	void SetNetLayer(CNetLayer* pNetLayer);
	void SetNetLayer(void* pNetLayer);
	void* GetNetLayer();

	//����֡��ʽָ�룬���ڴ�����֡����
	void SetFrameFormat(CFrameFormat* pFrameFormat);
	CFrameFormat* GetFrameFormat();

	//�����Ӧ��Ϊ�����ֽ�ʱ�������÷�Ӧ���ֽڣ�Ĭ��Ϊ0x7F
	void SetNegativeByte(uint8_t uNegByte = 0x7F) { m_uNegByte = uNegByte; }
	uint8_t GetNegativeByte() { return m_uNegByte; }

	//����7FXX78��ѭ�����������Ĭ�ϴ���10��
	void SetNegative78Times(int32_t i7F78CycleTime) { m_i7F78CycleTime = i7F78CycleTime; }
	int32_t GetNegative78Times() { return m_i7F78CycleTime; }

	//����7FXX21��ѭ�����������Ĭ�ϴ���10��
	void SetNegative21Times(int32_t i7F21CycleTime) { m_i7F21CycleTime = i7F21CycleTime; }
	int32_t GetNegative21Times() { return m_i7F21CycleTime; }

	//���÷���֡
	void SetSendData(const CSendFrame& right);
	CSendFrame* GetSendData();
	
	//���˽���֡���ݣ���������Ҫ�����Լ�����Э������ԣ���дʵ�ִ��麯��
	virtual CRecvFrame& FilterRecvFrame(CRecvFrame& right);


private:
	uint8_t     m_uNegByte;
	CSendFrame* m_pSendFrame;
	void*  m_pNetLayer;
	CFrameFormat* m_pFrameFormat;
	int32_t     m_i7F21CycleTime;
	int32_t     m_i7F78CycleTime;
};

#endif

