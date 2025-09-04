/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 算法表达式解析接口类
* 创 建 人 : sujiya        20201113
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _EXPRESSION_H_
#define _EXPRESSION_H_
#include "Binary.h"
#include "StdInclude.h"

/**********************************************************
*    功  能：计算算法表达式，算法表达式文件固定为CalcLib.dat
*    参  数：strExpress 算法表达式，如：z=x1*256+x2
*            strFormat 算法格式输出，如%d
*            mapParamPairs 算法输入变量数值对，如：{{"x1", 0x01}, {"x2", 0x02}}
*       或者 vctParamPairs 算法输入变量数值对，如：{{"x1", 0.1}, {"x2", 0.2}}
*            strOutVariableName算法表达式的输出变量，以上算法示例的输出变量名为"z"
*    返回值：算法表达式的计算结果
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
*    功  能：计算算法表达式，算法表达式文件固定为CalcLib.dat
*    参  数：strExpress 算法表达式，
*            strFormat 算法格式输出
*            binRecvData 接收的数据，
*            uStartPos 接收数据开始计算的起始位置
*			 uOffset 参与计算的接收数据的字节间隔
*    返回值：算法表达式的计算结果
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
*    功  能：计算算法表达式，算法表达式文件固定为CalcLib.dat
*    参  数：strExpressId 算法表达式ID，
*            binRecvData 接收的数据，
*            uStartPos 接收数据开始计算的起始位置
*			 uOffset 参与计算的接收数据的字节间隔
*    返回值：算法表达式的计算结果
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
*    功  能：计算算法表达式，算法表达式文件固定为CalcLib.dat
*    参  数：binExpressId 算法表达式ID，
*            binRecvData 接收的数据，
*            uStartPos 接收数据开始计算的起始位置
*			 uOffset 参与计算的接收数据的字节间隔
*    返回值：算法表达式的计算结果
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
