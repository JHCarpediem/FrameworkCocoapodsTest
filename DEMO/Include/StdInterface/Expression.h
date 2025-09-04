/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : �㷨���ʽ�����ӿ���
* �� �� �� : sujiya        20201113
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef _EXPRESSION_H_
#define _EXPRESSION_H_
#include "Binary.h"
#include "StdInclude.h"

/**********************************************************
*    ��  �ܣ������㷨���ʽ���㷨���ʽ�ļ��̶�ΪCalcLib.dat
*    ��  ����strExpress �㷨���ʽ���磺z=x1*256+x2
*            strFormat �㷨��ʽ�������%d
*            mapParamPairs �㷨���������ֵ�ԣ��磺{{"x1", 0x01}, {"x2", 0x02}}
*       ���� vctParamPairs �㷨���������ֵ�ԣ��磺{{"x1", 0.1}, {"x2", 0.2}}
*            strOutVariableName�㷨���ʽ����������������㷨ʾ�������������Ϊ"z"
*    ����ֵ���㷨���ʽ�ļ�����
**********************************************************/
_STD_DLL_API_ string Calc_ScriptEx(const string& strExpress,
	const string& strFormat,
	const map<string, double>& mapParamPairs,
	const string& strOutVariableName = "y");

_STD_DLL_API_ string Calc_ScriptEx(const string& strExpress,
	const string& strFormat,
	const vector<pair<string, double>>& vctParamPairs,
	const string& strOutVariableName = "y");

/**********************************************************
*    ��  �ܣ������㷨���ʽ���㷨���ʽ�ļ��̶�ΪCalcLib.dat
*    ��  ����strExpress �㷨���ʽ��
*            strFormat �㷨��ʽ���
*            binRecvData ���յ����ݣ�
*            uStartPos �������ݿ�ʼ�������ʼλ��
*			 uOffset �������Ľ������ݵ��ֽڼ��
*    ����ֵ���㷨���ʽ�ļ�����
**********************************************************/

_STD_DLL_API_ string Calc_ScriptEx(const string& strExpress,
	const string& strFormat,
	const CBinary& binRecvData,
	uint32_t uStartPos,
	uint32_t uOffset = 0x01);

_STD_DLL_API_ string Calc_Script(string& strExpress,
	string& strFormat,
	const CBinary& binRecvData,
	uint32_t uStartPos,
	uint32_t uOffset = 0x01);

/**********************************************************
*    ��  �ܣ������㷨���ʽ���㷨���ʽ�ļ��̶�ΪCalcLib.dat
*    ��  ����strExpressId �㷨���ʽID��
*            binRecvData ���յ����ݣ�
*            uStartPos �������ݿ�ʼ�������ʼλ��
*			 uOffset �������Ľ������ݵ��ֽڼ��
*    ����ֵ���㷨���ʽ�ļ�����
**********************************************************/
_STD_DLL_API_ string Calc_ScriptEx(const string& strExpressId,
	const CBinary& binRecvData,
	uint32_t uStartPos,
	uint32_t uOffset = 0x01);

_STD_DLL_API_ string Calc_Script(const string& strExpressId,
	const CBinary& binRecvData,
	uint32_t uStartPos,
	uint32_t uOffset = 0x01);

/**********************************************************
*    ��  �ܣ������㷨���ʽ���㷨���ʽ�ļ��̶�ΪCalcLib.dat
*    ��  ����binExpressId �㷨���ʽID��
*            binRecvData ���յ����ݣ�
*            uStartPos �������ݿ�ʼ�������ʼλ��
*			 uOffset �������Ľ������ݵ��ֽڼ��
*    ����ֵ���㷨���ʽ�ļ�����
**********************************************************/
_STD_DLL_API_ string Calc_ScriptEx(const CBinary& binExpressId,
	const CBinary& binRecvData,
	uint32_t uStartPos,
	uint32_t uOffset = 0x01);

_STD_DLL_API_ string Calc_Script(const CBinary& binExpressId,
	const CBinary& binRecvData,
	uint32_t uStartPos,
	uint32_t uOffset = 0x01);

#endif
