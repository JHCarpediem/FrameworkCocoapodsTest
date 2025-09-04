/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ֡��ʽ�ӿ��࣬���ڴ�����/��֡������
* �� �� �� : sujiya        20201103
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
	*    ��  �ܣ�����֡��ʽ����
	*    ��  ����uFrameFormatType ��Ҫ���õ�֡��ʽ����
	*            Ŀǰ֧�ֵ�֡��ʽ��StdCommMaco.h��ö��
	*            ������������ʽ����������
	*    ����ֵ����
	**********************************************************/
	void SetFrameFormatType(CStdCommMaco::FrameFormatType uFrameFormatType);

	/**********************************************************
	*    ��  �ܣ���ȡ�����õ�֡��ʽ����
	*    ��  ������
	*    ����ֵ�������õ�֡��ʽ����
	**********************************************************/
	CStdCommMaco::FrameFormatType GetFrameFormatType()const;

	/**********************************************************
	*    ��  �ܣ�����֡��ʽ�����д����Ҫ��ͷ
	*    ��  ����*Head ��Ҫ���õ�Head
	*    ˵  ����SetFrameFormatType����������Ŀǰ��֪Э�鳣�õ�Э��ͷ��
	*            �����Ҫ�������ø�Э���ͷ���ֽ�Ϊ��������Ҫ��SetFrameFormatType
	*            ֮�����SetHead,���ɸı�Э��ͷ�ֽ�
	*    ����ֵ�����óɹ�����true,����ʧ�ܷ���false
	**********************************************************/
	bool SetHead(uint8_t uHead);
	bool SetHead(const CBinary& binHead);
	bool SetHead(uint8_t* pHead, uint8_t len);

	/**********************************************************
	*    ��  �ܣ�����֡��ʽ�����д����Ҫ��EcuId
	*    ��  ����uEcuId ��Ҫ���õ�EcuId
	*    ����ֵ����
	**********************************************************/
	void SetEcuId(uint32_t uEcuId);

	/**********************************************************
	*    ��  �ܣ���ȡ�����õ�EcuId
	*    ��  ������
	*    ����ֵ�������õ�EcuId
	**********************************************************/
	uint32_t GetEcuId()const;

	/**********************************************************
	*    ��  �ܣ����ݽ��ǰ�����ݻ�ȡEcuId
	*    ��  ����right ���ǰ������
	*    ����ֵ����Ҫ��������е�EcuId
	**********************************************************/
	uint32_t GetEcuId(const CBinary& right)const;

	/**********************************************************
	*    ��  �ܣ�����֡��ʽ�����д����Ҫ��ToolId
	*    ��  ����uToolId ��Ҫ���õ�ToolId
	*    ����ֵ����
	**********************************************************/
	void SetToolId(uint32_t uToolId);

	/**********************************************************
	*    ��  �ܣ���ȡ�����õ�ToolId
	*    ��  ������
	*    ����ֵ�������õ�ToolId
	**********************************************************/
	uint32_t GetToolId()const;

	/**********************************************************
	*    ��  �ܣ������������
	*    ��  ����right��Ҫ���������
	*    ����ֵ���Ѵ��������
	**********************************************************/
	CBinary PackData(const CBinary& right);

	/**********************************************************
	*    ��  �ܣ������������
	*    ��  ����right��Ҫ���������
	*    ����ֵ���Ѵ��������
	**********************************************************/
	CSendFrame PackData(const CSendFrame& right);

	/**********************************************************
	*    ��  �ܣ������������
	*    ��  ����right��Ҫ���������
	*    ����ֵ���ѽ��������
	**********************************************************/
	CBinary UnPackData(const CBinary& right);

	/**********************************************************
	*    ��  �ܣ������������
	*    ��  ����right��Ҫ���������
	*    ����ֵ���ѽ��������
	**********************************************************/
	CRecvFrame UnPackData(const CRecvFrame& right);
	

	CFrameFormat& operator=(const CFrameFormat& right);
	CFrameFormat& operator=(CFrameFormat&& right);

private:
	CFrameFormatImp* m_pFrameFormatImp;
};


#endif

