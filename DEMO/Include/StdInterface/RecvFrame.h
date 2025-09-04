/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 接收帧数据管理接口类
* 创 建 人 : sujiya        20201031
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _RECV_FRAME_H_
#define _RECV_FRAME_H_
#include "BinaryGroup.h"

class _STD_DLL_API_ CRecvFrame
{
public:
	CRecvFrame():m_pbgRecvFrame(new CBinaryGroup()){}
	CRecvFrame(const CBinary& right):m_pbgRecvFrame(new CBinaryGroup(right)){}
	CRecvFrame(const CBinaryGroup& right) :m_pbgRecvFrame(new CBinaryGroup(right)) {}
	CRecvFrame(const CRecvFrame& right):m_pbgRecvFrame(new CBinaryGroup(*right.m_pbgRecvFrame)){}
	CRecvFrame(CRecvFrame&& right) :m_pbgRecvFrame(right.m_pbgRecvFrame) { right.m_pbgRecvFrame = nullptr; }
	~CRecvFrame() { delete m_pbgRecvFrame; }


	/**********************************************************
	*    功  能：获取接收帧的帧个数
	*    参  数：无
	*    返回值：接收帧的帧个数
	**********************************************************/
	uint32_t GetSize()const { return m_pbgRecvFrame->GetSize(); }

	/**********************************************************
	*    功  能：设置第uPos接收帧数据为right
	*    参  数：uPos 第几个接收帧， right需要重置的条数
	*    返回值：当前对象的引用
	**********************************************************/
	CRecvFrame& SetAt(uint32_t uPos, const CBinary& right);

	/**********************************************************
	*    功  能：获取第uPos接收帧数据
	*    参  数：uPos 第几个接收帧
	*    返回值：第uPos帧接收数据
	**********************************************************/
	const CBinary& GetAt(uint32_t uPos)const;

	/**********************************************************
	*    功  能：获取首帧接收帧数据
	*    参  数：无
	*    返回值：首帧接收数据
	**********************************************************/
	const CBinary& GetFirst()const;

	/**********************************************************
	*    功  能：追加数据到当前接收帧数据的末尾
	*    参  数：right 需要追加的帧数据
	*    返回值：当前对象的引用
	**********************************************************/
	CRecvFrame& Append(const CBinary& right);

	/**********************************************************
	*    功  能：追加数据到当前接收帧数据的末尾
	*    参  数：right 需要追加的帧数据
	*    返回值：当前对象的引用
	**********************************************************/
	CRecvFrame& Append(const CBinaryGroup& right);

	/**********************************************************
	*    功  能：追加数据到当前接收帧数据的末尾
	*    参  数：right 需要追加的帧数据
	*    返回值：当前对象的引用
	**********************************************************/
	CRecvFrame& Append(const CRecvFrame& right);

	/**********************************************************
	*    功  能：清空当前接收帧数据
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Clear();

	/**********************************************************
	*    功  能：判断当前接收帧数据是否为空
	*    参  数：无
	*    返回值：true 为空， false 不为空
	**********************************************************/
	bool IsEmpty() const;
	


	//重载操作符
	CRecvFrame& operator=(const CRecvFrame& right);
	CRecvFrame& operator=(CRecvFrame&& right);
	CRecvFrame& operator+=(const CBinary& right);
	CRecvFrame& operator+=(const CBinaryGroup& right);
	CRecvFrame& operator+=(const CRecvFrame& right);
	CBinary& operator[](uint32_t uPos);
	const CBinary& operator[](uint32_t uPos)const;

private:
	CBinaryGroup* m_pbgRecvFrame;
};


#endif
