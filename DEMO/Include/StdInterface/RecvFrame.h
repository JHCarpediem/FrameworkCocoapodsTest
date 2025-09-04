/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ����֡���ݹ���ӿ���
* �� �� �� : sujiya        20201031
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
	*    ��  �ܣ���ȡ����֡��֡����
	*    ��  ������
	*    ����ֵ������֡��֡����
	**********************************************************/
	uint32_t GetSize()const { return m_pbgRecvFrame->GetSize(); }

	/**********************************************************
	*    ��  �ܣ����õ�uPos����֡����Ϊright
	*    ��  ����uPos �ڼ�������֡�� right��Ҫ���õ�����
	*    ����ֵ����ǰ���������
	**********************************************************/
	CRecvFrame& SetAt(uint32_t uPos, const CBinary& right);

	/**********************************************************
	*    ��  �ܣ���ȡ��uPos����֡����
	*    ��  ����uPos �ڼ�������֡
	*    ����ֵ����uPos֡��������
	**********************************************************/
	const CBinary& GetAt(uint32_t uPos)const;

	/**********************************************************
	*    ��  �ܣ���ȡ��֡����֡����
	*    ��  ������
	*    ����ֵ����֡��������
	**********************************************************/
	const CBinary& GetFirst()const;

	/**********************************************************
	*    ��  �ܣ�׷�����ݵ���ǰ����֡���ݵ�ĩβ
	*    ��  ����right ��Ҫ׷�ӵ�֡����
	*    ����ֵ����ǰ���������
	**********************************************************/
	CRecvFrame& Append(const CBinary& right);

	/**********************************************************
	*    ��  �ܣ�׷�����ݵ���ǰ����֡���ݵ�ĩβ
	*    ��  ����right ��Ҫ׷�ӵ�֡����
	*    ����ֵ����ǰ���������
	**********************************************************/
	CRecvFrame& Append(const CBinaryGroup& right);

	/**********************************************************
	*    ��  �ܣ�׷�����ݵ���ǰ����֡���ݵ�ĩβ
	*    ��  ����right ��Ҫ׷�ӵ�֡����
	*    ����ֵ����ǰ���������
	**********************************************************/
	CRecvFrame& Append(const CRecvFrame& right);

	/**********************************************************
	*    ��  �ܣ���յ�ǰ����֡����
	*    ��  ������
	*    ����ֵ����
	**********************************************************/
	void Clear();

	/**********************************************************
	*    ��  �ܣ��жϵ�ǰ����֡�����Ƿ�Ϊ��
	*    ��  ������
	*    ����ֵ��true Ϊ�գ� false ��Ϊ��
	**********************************************************/
	bool IsEmpty() const;
	


	//���ز�����
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
