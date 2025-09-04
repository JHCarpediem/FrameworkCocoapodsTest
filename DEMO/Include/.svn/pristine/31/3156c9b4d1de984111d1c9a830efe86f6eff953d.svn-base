/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 否定应答帧处理基类，用于提供接收帧的否定处理接口，供各车型派生类使用
* 创 建 人 : sujiya        
* 审 核 人 : binchaolin    
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
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
{//该类后续实现，需要使用到通讯接口来收发数据，
	//如果车型某协议需要特殊处理，则可以派生此类来实现
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


	//网络层一定要设置，涉及到收发命令
	void SetNetLayer(CNetLayer* pNetLayer);
	void SetNetLayer(void* pNetLayer);
	void* GetNetLayer();

	//设置帧格式指针，用于打包解包帧数据
	void SetFrameFormat(CFrameFormat* pFrameFormat);
	CFrameFormat* GetFrameFormat();

	//如果否定应答为其他字节时，则设置否定应答字节，默认为0x7F
	void SetNegativeByte(uint8_t uNegByte = 0x7F) { m_uNegByte = uNegByte; }
	uint8_t GetNegativeByte() { return m_uNegByte; }

	//设置7FXX78的循环处理次数，默认处理10次
	void SetNegative78Times(int32_t i7F78CycleTime) { m_i7F78CycleTime = i7F78CycleTime; }
	int32_t GetNegative78Times() { return m_i7F78CycleTime; }

	//设置7FXX21的循环处理次数，默认处理10次
	void SetNegative21Times(int32_t i7F21CycleTime) { m_i7F21CycleTime = i7F21CycleTime; }
	int32_t GetNegative21Times() { return m_i7F21CycleTime; }

	//设置发送帧
	void SetSendData(const CSendFrame& right);
	CSendFrame* GetSendData();
	
	//过滤接收帧数据，各车型需要根据自己车型协议的特性，重写实现此虚函数
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

