/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 诊断开发常用的公共函数接口
* 创 建 人 : sujiya        20201109
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _PUBLIC_INTERFACE_H_
#define _PUBLIC_INTERFACE_H_
#include "StdInclude.h"
#include "Binary.h"

/*-----------------------------------------------------------------------------
	  功    能：获取版本号

	  参数说明：无

	  返 回 值：32位 整型 0xHHLLYYXX

	  说    明：Coding of version numbers
				HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
				LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
				YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
				XX 为 最低字节, Bit 7 ~  Bit 0    保留

				例如 0x02010300, 表示 V2.01.003
				例如 0x020B0000, 表示 V2.11
	-----------------------------------------------------------------------------*/
_STD_DLL_API_ uint32_t GetStdVersion();

/**********************************************************
*    功  能：使用指定的分割符来分割字符串
*    参  数：strSrc 原始字符串，
*            strSeparate 指定分隔符，默认为","符号
*    返回值：分割后的字符串向量
**********************************************************/
_STD_DLL_API_ vector<string> SeparateString(const string& strSrc, const string& strSeparate = ",");
_STD_DLL_API_ uint32_t SeparateString(vector<string>& vctResults, const string& strSrc, const string& strSeparate = ",");

/**********************************************************
*    功  能：替换字符串中的指定字符串
*    参  数：strSrc 原始字符串， strOld 需要被替换的字符串，
*            strNew 替换后的新字符串
*    返回值：替换后的字符串本身的引用
**********************************************************/
_STD_DLL_API_ string& StringReplace(string& strSrc, const string& strOld, const string& strNew);

/**********************************************************
*    功  能：十六进制字符串转换为CBinary
*    参  数：strSrc 原始的需要转换的字符串
*    返回值：转换后的CBinary对象
**********************************************************/
_STD_DLL_API_ CBinary HexString2Binary(const string& strSrc);

/**********************************************************
*    功  能：Binary对象转换为十六进制字符串
*    参  数：binData需要转换的CBinary对象
*    返回值：转换后的字符串
**********************************************************/
_STD_DLL_API_ string Binary2HexString(const CBinary& binData);

/**********************************************************
*    功  能：string转大写
*    参  数：strSrc 原始字符串
*    返回值：转换后的字符串
**********************************************************/
_STD_DLL_API_ string& String2Upper(string& strSrc);

/**********************************************************
*    功  能：string转小写
*    参  数：strSrc 原始字符串
*    返回值：转换后的字符串
**********************************************************/
_STD_DLL_API_ string& String2Lower(string& strSrc);

/**********************************************************
*    功  能：检查VIN码中的字符是否全部有效
*    参  数：strVin 需要检查的VIN
*    返回值：true:有效   false: 无效
**********************************************************/
_STD_DLL_API_ bool CheckVinCharIsValid(const string& strVin);


#endif

