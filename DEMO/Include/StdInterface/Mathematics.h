/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : �㷨���ʽת���ӿ���
* �� �� �� : sujiya        20201111
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef _MATHEMATICS_H_
#define _MATHEMATICS_H_
#include "StdInclude.h"

class CMathematicsImp;

class _STD_DLL_API_ CMathematics
{
public:
	CMathematics();
	~CMathematics();


	/**********************************************************
	*    ��  �ܣ�ת�����ʽ������׺���ʽתΪ��׺���ʽ
	*    ��  ����strInfix ��׺���ʽ��strPostfix ��׺���ʽ
	*    ����ֵ��true ���쳣��false���쳣
	**********************************************************/
	bool TranslateExpress(string& strInfix, string& strPostfix);

	/**********************************************************
	*    ��  �ܣ���׺���ʽ�ļ���
	*    ��  ����strExpress ��Ҫ����ĺ�׺���ʽ��
	*            strtFormat ��ʽ���������pData
	*            iDataLen pData����Ч����
	*    ����ֵ����׺���ʽ�ļ�����
	**********************************************************/
	string CalcExpress(const string &strExpress,
		const string  &strtFormat,
		uint8_t *pData = nullptr,
		int32_t iDataLen = 0);

private:
	CMathematicsImp* m_pMathematicsImp;
};


#endif
