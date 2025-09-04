/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ��չ����֡���ݹ���ӿ���
* �� �� �� : sujiya        20201103
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
	*    ��  �ܣ���ȡ����֡��֡����
	*    ��  ������
	*    ����ֵ������֡��֡����
	**********************************************************/
	uint32_t GetSize()const;

	/**********************************************************
	*    ��  �ܣ�����Դ��ַ��׷������
	*    ��  ����uSourceId Դ��ַ��right Դ��ַ��Ӧ����Ҫ׷�ӵ�����
	*    ����ֵ����չ����֡���������
	**********************************************************/
	CRecvFrameEx& Append(uint32_t uSourceId, const CBinary& right);

	/**********************************************************
	*    ��  �ܣ���ȡָ��֡��Դ��ַ
	*    ��  ����uPos ָ����֡���
	*    ����ֵ��ָ��֡��Դ��ַ
	**********************************************************/
	uint32_t GetSourceId(uint32_t uPos);

	/**********************************************************
	*    ��  �ܣ�����Դ��ַ��ȡ֡����
	*    ��  ����uSourceId ָ����Դ��ַ
	*    ����ֵ��ָ��Դ��ַ��Ӧ��֡����
	**********************************************************/
	CBinary GetData(uint32_t uSourceId);

	//���ز�����
	CRecvFrameEx& operator=(const CRecvFrameEx& right);
	CRecvFrameEx& operator=(CRecvFrameEx&& right);

private:
	CRecvFrameExImp* m_pRecvFrameExImp;

};


#endif

