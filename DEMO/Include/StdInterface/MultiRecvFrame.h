/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 多帧接收帧数据管理接口类
* 创 建 人 : sujiya        20201031
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _MULTI_RECVFRAME_H_
#define _MULTI_RECVFRAME_H_
#include "RecvFrame.h"
#include "StdInclude.h"

class _STD_DLL_API_ CMultiRecvFrame
{
public:
	CMultiRecvFrame() :m_pvctRecvFrame(new vector<CRecvFrame>()) {}
	CMultiRecvFrame(const CBinary& right) :m_pvctRecvFrame(new vector<CRecvFrame>(1, CRecvFrame(right))) {}
	CMultiRecvFrame(const CRecvFrame& right) :m_pvctRecvFrame(new vector<CRecvFrame>(1, right)) {}
	CMultiRecvFrame(const CMultiRecvFrame& right) :m_pvctRecvFrame(new vector<CRecvFrame>(*right.m_pvctRecvFrame)) {}
	CMultiRecvFrame(CMultiRecvFrame&& right) :m_pvctRecvFrame(right.m_pvctRecvFrame) { right.m_pvctRecvFrame = nullptr; }
	~CMultiRecvFrame() { delete m_pvctRecvFrame; }

public:
	/**********************************************************
	*    功  能：获取接收帧多帧的总帧数
	*    参  数：无
	*    返回值：接收帧总帧数
	**********************************************************/
	uint32_t GetSize()const { return (uint32_t)m_pvctRecvFrame->size(); }

	/**********************************************************
	*    功  能：获取第uPos帧接收帧
	*    参  数：uPos 需要获取的帧序号
	*    返回值：CRecvFrame对象
	**********************************************************/
	const CRecvFrame& GetAt(uint32_t uPos)const;

	/**********************************************************
	*    功  能：追加发送帧到当前接收帧末尾
	*    参  数：right 需要追加的接收帧数据
	*    返回值：CMultiRecvFrame对象
	**********************************************************/
	CMultiRecvFrame& Append(const CBinary& right);

	/**********************************************************
	*    功  能：追加发送帧到当前接收帧末尾
	*    参  数：right 需要追加的接收帧
	*    返回值：CMultiRecvFrame对象
	**********************************************************/
	CMultiRecvFrame& Append(const CRecvFrame& right);

	/**********************************************************
	*    功  能：追加接收帧到当前接收帧末尾
	*    参  数：right 需要追加的多帧
	*    返回值：CMultiRecvFrame对象
	**********************************************************/
	CMultiRecvFrame& Append(const CMultiRecvFrame& right);

	/**********************************************************
	*    功  能：清空当前的多帧内容
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Clear();

	/**********************************************************
	*    功  能：判断当前多帧接收帧是否为空
	*    参  数：无
	*    返回值：true 发送帧内容为空， false 发送帧内容不为空
	**********************************************************/
	bool IsEmpty()const;

public:
	//重载操作符
	CMultiRecvFrame& operator=(const CMultiRecvFrame& right);
	CMultiRecvFrame& operator=(CMultiRecvFrame&& right);
	CMultiRecvFrame& operator+=(const CBinary& right);
	CMultiRecvFrame& operator+=(const CRecvFrame& right);
	CMultiRecvFrame& operator+=(const CMultiRecvFrame& right);
	CRecvFrame& operator[](uint32_t uPos);
	const CRecvFrame& operator[](uint32_t uPos)const;

private:
	vector<CRecvFrame>* m_pvctRecvFrame;
};


#endif
