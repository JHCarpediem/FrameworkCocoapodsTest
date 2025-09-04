/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 发送帧数据管理接口类
* 创 建 人 : sujiya        20201031
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _SEND_FRAME_H_
#define _SEND_FRAME_H_
#include "StdCommMaco.h"
#include "Binary.h"

class _STD_DLL_API_ CSendFrame
{
public:
	enum RECV_FRAME_NUM : uint8_t
	{
		//自动接收，p2时间一到即返回
		SF_RECEIVE_AUTO = 0xFF, 

		//扩展自动接收，p2时间到时，若还有数据没有接收，
		//会自动延长往下延长一个p2时间来接收数据
		SF_RECEIVE_AUTO_EX = 0xFE,

		//0x80~0xFD，预留给通讯库使用
		//0x01~0x7F，若设置为此范围任一值，则表示接收到指定设置的帧数立即返回，
		//          如果p2时间内仍没有接收够指定的帧数，p2时间一到也返回

		//接收到一帧数据即返回，(主要用于大部分车的数据流这样的功能)
		SF_RECEIVE_ONE = 0x01,

		//只发送不接收
		SF_RECEIVE_NONE = 0x00,
	};

public:
	CSendFrame(uint8_t uRecvFrameNum = SF_RECEIVE_AUTO) \
		:m_pbinSend(new CBinary()), m_uRecvFrameNum(uRecvFrameNum),\
		m_uFrameFormatType(CStdCommMaco::FrameFormatType::FFT_NONE) \
	{m_uEcuId = 0; m_uToolId = 0; }

	CSendFrame(const CBinary& right, uint8_t uRecvFrameNum = SF_RECEIVE_AUTO, \
		CStdCommMaco::FrameFormatType uFrameFormatType = CStdCommMaco::FrameFormatType::FFT_NONE, \
		uint32_t uEcuId = 0, uint32_t uToolId = 0) \
		: m_pbinSend(new CBinary(right)), m_uRecvFrameNum(uRecvFrameNum), \
		m_uFrameFormatType(uFrameFormatType), m_uEcuId(uEcuId), m_uToolId(uToolId) {}

	CSendFrame(const CSendFrame& right) :m_pbinSend(new CBinary(*right.m_pbinSend)), \
		m_uRecvFrameNum(right.m_uRecvFrameNum), m_uFrameFormatType(right.m_uFrameFormatType), \
		m_uEcuId(right.m_uEcuId), m_uToolId(right.m_uToolId) {}

	CSendFrame(CSendFrame&& right) :m_pbinSend(right.m_pbinSend), \
		m_uRecvFrameNum(right.m_uRecvFrameNum), m_uFrameFormatType(right.m_uFrameFormatType), \
		m_uEcuId(right.m_uEcuId), m_uToolId(right.m_uToolId){ right.m_pbinSend = nullptr; }

	~CSendFrame() { delete m_pbinSend; }


	/**********************************************************
	*    功  能：获取发送帧数据的长度
	*    参  数：无
	*    返回值：发送帧数据的有效长度
	**********************************************************/
	uint32_t GetSize()const{ return m_pbinSend->GetSize(); }

	/**********************************************************
	*    功  能：设置发送帧数据
	*    参  数：right 需要发送的帧数据
	*    返回值：发送帧数据的有效长度
	**********************************************************/
	CSendFrame& SetSendFrameData(const CBinary& right);

	/**********************************************************
	*    功  能：设置当前发送帧需要接收的数据帧个数
	*    参  数：uRecvFrameNum 需要接收的数据帧个数
	*            此参数需要根据具体情况设置，默认为 SF_RECEIVE_AUTO
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& SetRecvFrameNum(uint8_t uRecvFrameNum);

	/**********************************************************
	*    功  能：设置发送帧的校验类型
	*           主要用于临时打包时使用，一般情况下无需设置
	*    参  数：uCsType 帧校验的类型
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& SetFrameFormatType(CStdCommMaco::FrameFormatType uFrameFormatType);

	/**********************************************************
	*    功  能：设置当前发送帧的EcuId,
	*           主要用于临时打包时使用，一般情况下无需设置
	*    参  数：无
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& SetEcuId(uint32_t uEcuId);

	/**********************************************************
	*    功  能：获取设置的EcuId,
	*    参  数：无
	*    返回值：设置的EcuId
	**********************************************************/
	uint32_t GetEcuId() const;

	/**********************************************************
	*    功  能：设置当前发送帧的ToolId,
	*           主要用于临时打包时使用，一般情况下无需设置
	*    参  数：无
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& SetToolId(uint32_t uToolId);

	/**********************************************************
	*    功  能：获取设置的ToolId,
	*    参  数：无
	*    返回值：设置的EcuId
	**********************************************************/
	uint32_t GetToolId() const;

	/**********************************************************
	*    功  能：获取需要发送的帧数据
	*    参  数：无
	*    返回值：发送帧的内容
	**********************************************************/
	const CBinary& GetSendFrameData()const;

	/**********************************************************
	*    功  能：获取当前发送帧需要接收的帧个数
	*    参  数：无
	*    返回值：接收帧个数
	**********************************************************/
	uint8_t GetRecvFrameNum()const { return m_uRecvFrameNum; }

	/**********************************************************
	*    功  能：获取当前发送帧的校验类型
	*    参  数：无
	*    返回值：接收帧个数
	**********************************************************/
	CStdCommMaco::FrameFormatType GetFrameCsType()const { return m_uFrameFormatType; }

	/**********************************************************
	*    功  能：设置发送帧指定位置的值
	*    参  数：uPos 发送帧指定的位置， uValue需要设置的值
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& SetAt(uint32_t uPos, uint8_t uValue);

	/**********************************************************
	*    功  能：打包当前发送帧数据
	*    参  数：无
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& PackData();

	/**********************************************************
	*    功  能：针对打包好的数据重置EcuId
	*    参  数：无
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& ResetEcuId(uint32_t uEcuId);

	/**********************************************************
	*    功  能：针对打包好的数据重置ToolId
	*    参  数：无
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& ResetToolId(uint32_t uToolId);

	/**********************************************************
	*    功  能：解包当前发送帧数据
	*    参  数：无
	*    返回值：当前对象的引用
	**********************************************************/
	CSendFrame& UnPackData();

	/**********************************************************
	*    功  能：获取发送帧指定位置的值
	*    参  数：uPos 发送帧指定的位置
	*    返回值：指定位置的字节数据
	**********************************************************/
	uint8_t GetAt(uint32_t uPos)const;

	/**********************************************************
	*    功  能：清空发送帧内容
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Clear();

	/**********************************************************
	*    功  能：判断当前发送帧内容是否为空
	*    参  数：无
	*    返回值：true 发送帧内容为空， false 发送帧内容不为空
	**********************************************************/
	bool IsEmpty()const;


	//重载操作符
	CSendFrame& operator=(const CSendFrame& right);
	CSendFrame& operator=(CSendFrame&& right);
	uint8_t& operator[](uint32_t uPos);
	const uint8_t& operator[](uint32_t uPos)const;

private:
	CBinary* m_pbinSend;
	uint8_t m_uRecvFrameNum;

	CStdCommMaco::FrameFormatType m_uFrameFormatType;
	uint32_t m_uEcuId;
	uint32_t m_uToolId;
};


#endif
