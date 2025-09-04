/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ��֡����֡���ݹ���ӿ���
* �� �� �� : sujiya        20201031
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
	*    ��  �ܣ���ȡ����֡��֡����֡��
	*    ��  ������
	*    ����ֵ������֡��֡��
	**********************************************************/
	uint32_t GetSize()const { return (uint32_t)m_pvctRecvFrame->size(); }

	/**********************************************************
	*    ��  �ܣ���ȡ��uPos֡����֡
	*    ��  ����uPos ��Ҫ��ȡ��֡���
	*    ����ֵ��CRecvFrame����
	**********************************************************/
	const CRecvFrame& GetAt(uint32_t uPos)const;

	/**********************************************************
	*    ��  �ܣ�׷�ӷ���֡����ǰ����֡ĩβ
	*    ��  ����right ��Ҫ׷�ӵĽ���֡����
	*    ����ֵ��CMultiRecvFrame����
	**********************************************************/
	CMultiRecvFrame& Append(const CBinary& right);

	/**********************************************************
	*    ��  �ܣ�׷�ӷ���֡����ǰ����֡ĩβ
	*    ��  ����right ��Ҫ׷�ӵĽ���֡
	*    ����ֵ��CMultiRecvFrame����
	**********************************************************/
	CMultiRecvFrame& Append(const CRecvFrame& right);

	/**********************************************************
	*    ��  �ܣ�׷�ӽ���֡����ǰ����֡ĩβ
	*    ��  ����right ��Ҫ׷�ӵĶ�֡
	*    ����ֵ��CMultiRecvFrame����
	**********************************************************/
	CMultiRecvFrame& Append(const CMultiRecvFrame& right);

	/**********************************************************
	*    ��  �ܣ���յ�ǰ�Ķ�֡����
	*    ��  ������
	*    ����ֵ����
	**********************************************************/
	void Clear();

	/**********************************************************
	*    ��  �ܣ��жϵ�ǰ��֡����֡�Ƿ�Ϊ��
	*    ��  ������
	*    ����ֵ��true ����֡����Ϊ�գ� false ����֡���ݲ�Ϊ��
	**********************************************************/
	bool IsEmpty()const;

public:
	//���ز�����
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
