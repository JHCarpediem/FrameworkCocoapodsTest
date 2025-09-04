/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 帧格式接口类，用于处理收/发帧打包解包
* 创 建 人 : sujiya        20201103
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _FRAME_FORMAT_H_
#define _FRAME_FORMAT_H_
#include "StdInclude.h"
#include "FrameCs.h"
#include "SendFrame.h"
#include "RecvFrame.h"

class CFrameFormatImp;
class _STD_DLL_API_ CFrameFormat
{
public:
	CFrameFormat(CStdCommMaco::FrameFormatType uFrameFormatType = CStdCommMaco::FrameFormatType::FFT_NONE);
	CFrameFormat(CStdCommMaco::FrameFormatType uFrameFormatType, uint32_t uEcuId, uint32_t uToolId);
	CFrameFormat(const CFrameFormat& right);
	~CFrameFormat();


	/**********************************************************
	*    功  能：设置帧格式类型
	*    参  数：uFrameFormatType 需要设置的帧格式类型
	*            目前支持的帧格式在StdCommMaco.h中枚举
	*            后续有新增格式需求再增加
	*    返回值：无
	**********************************************************/
	void SetFrameFormatType(CStdCommMaco::FrameFormatType uFrameFormatType);

	/**********************************************************
	*    功  能：获取已设置的帧格式类型
	*    参  数：无
	*    返回值：已设置的帧格式类型
	**********************************************************/
	CStdCommMaco::FrameFormatType GetFrameFormatType()const;

	/**********************************************************
	*    功  能：设置帧格式类型中打包需要的头
	*    参  数：*Head 需要设置的Head
	*    说  明：SetFrameFormatType函数设置了目前已知协议常用的协议头，
	*            如果需要重新设置该协议的头部字节为其他，需要在SetFrameFormatType
	*            之后调用SetHead,即可改变协议头字节
	*    返回值：设置成功返回true,设置失败返回false
	**********************************************************/
	bool SetHead(uint8_t uHead);
	bool SetHead(const CBinary& binHead);
	bool SetHead(uint8_t* pHead, uint8_t len);

	/**********************************************************
	*    功  能：设置帧格式类型中打包需要的EcuId
	*    参  数：uEcuId 需要设置的EcuId
	*    返回值：无
	**********************************************************/
	void SetEcuId(uint32_t uEcuId);

	/**********************************************************
	*    功  能：获取已设置的EcuId
	*    参  数：无
	*    返回值：已设置的EcuId
	**********************************************************/
	uint32_t GetEcuId()const;

	/**********************************************************
	*    功  能：根据解包前的数据获取EcuId
	*    参  数：right 解包前的数据
	*    返回值：需要解包数据中的EcuId
	**********************************************************/
	uint32_t GetEcuId(const CBinary& right)const;

	/**********************************************************
	*    功  能：设置帧格式类型中打包需要的ToolId
	*    参  数：uToolId 需要设置的ToolId
	*    返回值：无
	**********************************************************/
	void SetToolId(uint32_t uToolId);

	/**********************************************************
	*    功  能：获取已设置的ToolId
	*    参  数：无
	*    返回值：已设置的ToolId
	**********************************************************/
	uint32_t GetToolId()const;

	/**********************************************************
	*    功  能：打包发送数据
	*    参  数：right需要打包的数据
	*    返回值：已打包的数据
	**********************************************************/
	CBinary PackData(const CBinary& right);

	/**********************************************************
	*    功  能：打包发送数据
	*    参  数：right需要打包的数据
	*    返回值：已打包的数据
	**********************************************************/
	CSendFrame PackData(const CSendFrame& right);

	/**********************************************************
	*    功  能：解包接收数据
	*    参  数：right需要解包的数据
	*    返回值：已解包的数据
	**********************************************************/
	CBinary UnPackData(const CBinary& right);

	/**********************************************************
	*    功  能：解包接收数据
	*    参  数：right需要解包的数据
	*    返回值：已解包的数据
	**********************************************************/
	CRecvFrame UnPackData(const CRecvFrame& right);
	

	CFrameFormat& operator=(const CFrameFormat& right);
	CFrameFormat& operator=(CFrameFormat&& right);

private:
	CFrameFormatImp* m_pFrameFormatImp;
};


#endif

