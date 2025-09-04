/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 一维字符数组管理接口类，用于管理一维字符数组的操作的接口
* 创 建 人 : sujiya        20201026
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _BINARY_H_
#define _BINARY_H_
#include "StdInclude.h"

//class CBinaryImp;
class _STD_DLL_API_ CBinary
{
public:
	CBinary();
	CBinary(const char* szBuffer, uint32_t uLen);
	CBinary(const uint8_t* szBuffer, uint32_t uLen);
	CBinary(const CBinary& right);
	CBinary(CBinary&& right);
	~CBinary();


	/**********************************************************
	*    功  能：获取有效数据的长度
	*    参  数：无
	*    返回值：数组的有效长度
	**********************************************************/
	uint32_t GetSize() const;
	uint32_t GetLength() const;
	uint32_t GetAllocLen() const;


	/**********************************************************
	*    功  能：获取当前数组指定下标位置的值
	*    参  数：uPos 指定的下标位置
	*    返回值：指定位置的值
	**********************************************************/
	uint8_t GetAt(uint32_t uPos) const;

	/**********************************************************
	*    功  能：重置指定位置的值
	*    参  数：uPos 指定的位置， uValue 需要重置的值
	*    返回值：当前数组
	**********************************************************/
	CBinary& SetAt(uint32_t uPos, uint8_t uValue);

	/**********************************************************
	*    功  能：追加某值到当前数组的末尾
	*    参  数：uValue 需要追加到数组末尾的值
	*    返回值：当前数组
	**********************************************************/
	CBinary& Append(uint8_t uValue);

	/**********************************************************
	*    功  能：追加一个数组到当前数组的末尾
	*    参  数：right为需要追加到数组末尾的另一个数组
	*    返回值：当前数组
	**********************************************************/
	CBinary& Append(const CBinary& right);

	/**********************************************************
	*    功  能：追加指定的字符数组到末尾
	*    参  数：szData 需要追加的数据， uLen数据的长度
	*    返回值：当前数组
	**********************************************************/
	CBinary& Append(const uint8_t* szData, uint32_t uLen);

	/**********************************************************
	*    功  能：清除指定位置的值，清除后，指定位置之后的数值需要往前移动一位
	*    参  数：uPos为需要清除的位置
	*    返回值：当前数组
	**********************************************************/
	CBinary& Erase(uint32_t uPos);

	/**********************************************************
	*    功  能：清除指定位置开始的指定长度的数据
	*    参  数：uPos为需要清除的开始位置，
	*           uCount为需要清除的个数
	*    返回值：当前数组
	**********************************************************/
	CBinary& Erase(uint32_t uStartPos, uint32_t uCount);

	/**********************************************************
	*    功  能：清空当前数组
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Clear();

	/**********************************************************
	*    功  能：获取有效数据的内容
	*    参  数：无
	*    返回值：数组的有效内容
	**********************************************************/
	uint8_t* GetBuffer() const;

	/**********************************************************
	*    功  能：从指定位置开始查找指定值在数组中出现的位置
	*    参  数：uValue需要查找的值，uStartPos指定开始位置
	*    返回值：指定值第一次出现的位置，找不到时返回uint32_t(-1)
	**********************************************************/
	uint32_t Find(uint8_t uValue, uint32_t uStartPos = 0) const;

	/**********************************************************
	*    功  能：从指定位置查找指定数组在数组中第一次出现的位置
	*    参  数：需要查找的数组引用，uStartPos指定开始位置
	*    返回值：指定数组第一次出现的位置，找不到时返回uint32_t(-1)
	**********************************************************/
	uint32_t Find(const CBinary& right, uint32_t uStartPos = 0) const;

	/**********************************************************
	*    功  能：数组翻转
	*    参  数：无
	*    返回值：翻转后的数组
	**********************************************************/
	CBinary& Reverse();

	/**********************************************************
	*    功  能：在指定位置插入指定值
	*    参  数：uPos 需要插入的位置， uValue需要插入的值
	*    返回值：当前数组
	**********************************************************/
	CBinary& Insert(uint32_t uPos, uint8_t uValue);

	/**********************************************************
	*    功  能：在指定的位置插入指定的数组
	*    参  数：uPos 需要插入的位置， right需要插入的数组
	*    返回值：当前数组
	**********************************************************/
	CBinary& Insert(uint32_t uPos, CBinary& right);

	/**********************************************************
	*    功  能：判断当前数组是否为空
	*    参  数：无
	*    返回值：ture 表示当前数组为空数组，false 表示当前数组不为空
	**********************************************************/
	bool IsEmpty() const;

	/**********************************************************
	*    功  能：从指定的位置uStartPos复制最大uCount的数据到新的数组
	*    参  数：uStartPos指定开始位置
	*            uCount指定个数，默认到原数据结尾
	*    返回值：ture 表示当前数组为空数组，false 表示当前数组不为空
	**********************************************************/
	CBinary SubBinary(uint32_t uStartPos, uint32_t uCount = (uint32_t)-1) const;

	//重载操作符
	CBinary& operator=(const CBinary& right);
	CBinary& operator=(CBinary&& right);
	CBinary& operator+=(uint8_t uValue);
	CBinary& operator+=(const CBinary& right);
	bool operator==(const CBinary& right)const;
	bool operator!=(const CBinary& right)const;
	bool operator>=(const CBinary& right)const;
	bool operator<=(const CBinary& right)const;
	bool operator>(const CBinary& right)const;
	bool operator<(const CBinary& right)const;
	uint8_t& operator[](uint32_t uPos);
	const uint8_t& operator[](uint32_t uPos)const;

private:
	enum { AllocBlock = 16 };
	typedef struct tagDataInfo
	{
		uint8_t szDataBuffer[AllocBlock];//数据区域
		uint8_t* pExtDataBuffer;//数据指针
		uint32_t uDataLen;//实际数据的长度
		uint32_t uAllocLen;//分配的数据空间长度
	} *PDataInfo, DataInfo;

	PDataInfo m_pDataInfo;
};


#endif // !_BINARY_H_
