/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 多帧发送帧数据管理接口
* 创 建 人 : sujiya        20201031
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _MULTI_SENDFRAME_H_
#define _MULTI_SENDFRAME_H_
#include "SendFrame.h"
#include "StdInclude.h"

class _STD_DLL_API_ CMultiSendFrame
{
public:
	CMultiSendFrame() :m_pvctSendFrame(new vector<CSendFrame>()) {}
	CMultiSendFrame(const CBinary& right) :m_pvctSendFrame(new vector<CSendFrame>(1, CSendFrame(right))) {}
	CMultiSendFrame(const CSendFrame& right) :m_pvctSendFrame(new vector<CSendFrame>(1, right)) {}
	CMultiSendFrame(const CMultiSendFrame& right) :m_pvctSendFrame(new vector<CSendFrame>(*right.m_pvctSendFrame)) {}
	CMultiSendFrame(CMultiSendFrame&& right) :m_pvctSendFrame(right.m_pvctSendFrame) { right.m_pvctSendFrame = nullptr; }
	~CMultiSendFrame() { delete m_pvctSendFrame; }

public:
	/**********************************************************
	*    功  能：获取发送帧总帧数
	*    参  数：无
	*    返回值：发送帧总帧数
	**********************************************************/
	uint32_t GetSize()const { return (uint32_t)m_pvctSendFrame->size(); }

	/**********************************************************
	*    功  能：获取第uPos帧发送帧
	*    参  数：uPos 需要获取的帧序号
	*    返回值：CSendFrame对象
	**********************************************************/
	const CSendFrame& GetAt(uint32_t uPos)const;

	/**********************************************************
	*    功  能：追加发送帧到当前发送帧末尾
	*    参  数：right 需要追加的发送帧数据
	*    返回值：CMultiSendFrame对象
	**********************************************************/
	CMultiSendFrame& Append(const CBinary& right);

	/**********************************************************
	*    功  能：追加发送帧到当前发送帧末尾
	*    参  数：right 需要追加的发送帧
	*    返回值：CMultiSendFrame对象
	**********************************************************/
	CMultiSendFrame& Append(const CSendFrame& right);

	/**********************************************************
	*    功  能：追加发送帧到当前发送帧末尾
	*    参  数：right 需要追加的多帧
	*    返回值：CMultiSendFrame对象
	**********************************************************/
	CMultiSendFrame& Append(const CMultiSendFrame& right);

	/**********************************************************
	*    功  能：清空当前的多帧内容
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Clear();

	/**********************************************************
	*    功  能：判断当前多帧发送帧是否为空
	*    参  数：无
	*    返回值：true 发送帧内容为空， false 发送帧内容不为空
	**********************************************************/
	bool IsEmpty()const;

public:
	//重载操作符
	CMultiSendFrame& operator=(const CMultiSendFrame& right);
	CMultiSendFrame& operator=(CMultiSendFrame&& right);
	CMultiSendFrame& operator+=(const CBinary& right);
	CMultiSendFrame& operator+=(const CSendFrame& right);
	CMultiSendFrame& operator+=(const CMultiSendFrame& right);
	CSendFrame& operator[](uint32_t uPos);
	const CSendFrame& operator[](uint32_t uPos)const;

private:
	vector<CSendFrame>* m_pvctSendFrame;
};


#endif
