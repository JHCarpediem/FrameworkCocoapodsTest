/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 算法表达式转换接口类
* 创 建 人 : sujiya        20201111
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
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
	*    功  能：转换表达式，将中缀表达式转为后缀表达式
	*    参  数：strInfix 中缀表达式，strPostfix 后缀表达式
	*    返回值：true 无异常，false有异常
	**********************************************************/
	bool TranslateExpress(string& strInfix, string& strPostfix);

	/**********************************************************
	*    功  能：后缀表达式的计算
	*    参  数：strExpress 需要计算的后缀表达式，
	*            strtFormat 格式化输出符，pData
	*            iDataLen pData的有效长度
	*    返回值：后缀表达式的计算结果
	**********************************************************/
	string CalcExpress(const string &strExpress,
		const string  &strtFormat,
		uint8_t *pData = nullptr,
		int32_t iDataLen = 0);

private:
	CMathematicsImp* m_pMathematicsImp;
};


#endif
