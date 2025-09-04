/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 扩展接收帧数据管理接口类
* 创 建 人 : sujiya        20201103
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _EX_RECVFRAME_H_
#define _EX_RECVFRAME_H_
#include "SendFrame.h"

class CRecvFrameExImp;
class _STD_DLL_API_ CRecvFrameEx
{
public:
	CRecvFrameEx();
	CRecvFrameEx(const CRecvFrameEx& right);
	CRecvFrameEx(CRecvFrameEx&& right);
	~CRecvFrameEx();


	/**********************************************************
	*    功  能：获取接收帧的帧个数
	*    参  数：无
	*    返回值：接收帧的帧个数
	**********************************************************/
	uint32_t GetSize()const;

	/**********************************************************
	*    功  能：根据源地址来追加数据
	*    参  数：uSourceId 源地址，right 源地址对应的需要追加的数据
	*    返回值：扩展接收帧对象的引用
	**********************************************************/
	CRecvFrameEx& Append(uint32_t uSourceId, const CBinary& right);

	/**********************************************************
	*    功  能：获取指定帧的源地址
	*    参  数：uPos 指定的帧序号
	*    返回值：指定帧的源地址
	**********************************************************/
	uint32_t GetSourceId(uint32_t uPos);

	/**********************************************************
	*    功  能：根据源地址获取帧数据
	*    参  数：uSourceId 指定的源地址
	*    返回值：指定源地址对应的帧数据
	**********************************************************/
	CBinary GetData(uint32_t uSourceId);

	//重载操作符
	CRecvFrameEx& operator=(const CRecvFrameEx& right);
	CRecvFrameEx& operator=(CRecvFrameEx&& right);

private:
	CRecvFrameExImp* m_pRecvFrameExImp;

};


#endif

