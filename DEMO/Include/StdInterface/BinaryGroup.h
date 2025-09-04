/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 二维字符数组管理接口类，用于管理二维字符数组的操作
* 创 建 人 : sujiya        20201027
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _BINARY_GROUP_H_
#define _BINARY_GROUP_H_
#include "Binary.h"
#include "StdInclude.h"

class _STD_DLL_API_ CBinaryGroup
{
public:
	CBinaryGroup() :m_pvctBins(new vector<CBinary>()) {}
	CBinaryGroup(const CBinary& right) :m_pvctBins(new vector<CBinary>(1, right)) {}
	CBinaryGroup(const CBinaryGroup& right) :m_pvctBins(new vector<CBinary>(*right.m_pvctBins)) {}
	CBinaryGroup(CBinaryGroup&& right) :m_pvctBins(right.m_pvctBins) { right.m_pvctBins = nullptr; }
	~CBinaryGroup() { delete m_pvctBins; }


	/**********************************************************
	*    功  能：获取存储的CBinary对象的个数
	*    参  数：无
	*    返回值：存储的CBinary对象的个数
	**********************************************************/
	uint32_t GetSize()const { return (uint32_t)m_pvctBins->size(); }

	/**********************************************************
	*    功  能：获取指定下标的CBinary对象
	*    参  数：uPos 指定的下标位置
	*    返回值：指定下标的CBinary对象
	**********************************************************/
	const CBinary& GetAt(uint32_t uPos)const;

	/**********************************************************
	*    功  能：重置指定下标处的CBinary对象
	*    参  数：uPos 指定的下标位置， right 重置后的CBinary对象
	*    返回值：当前对象
	**********************************************************/
	CBinaryGroup& SetAt(uint32_t uPos, const CBinary& right);

	/**********************************************************
	*    功  能：追加一个CBinary对象到当前CBinaryGroup对象的末尾
	*    参  数：right 需要追加的CBinary对象
	*    返回值：当前对象
	**********************************************************/
	CBinaryGroup& Append(const CBinary& right);

	/**********************************************************
	*    功  能：追加一个CBinaryGroup对象到当前CBinaryGroup对象的末尾
	*    参  数：right 需要追加的CBinaryGroup对象
	*    返回值：当前对象
	**********************************************************/
	CBinaryGroup& Append(const CBinaryGroup& right);

	/**********************************************************
	*    功  能：清除指定位置的数组
	*    参  数：uPos为需要清除的位置
	*    返回值：当前对象
	**********************************************************/
	CBinaryGroup& Erase(uint32_t uPos);

	/**********************************************************
	*    功  能：清空当前CBinaryGroup对象的内容
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Clear();

	/**********************************************************
	*    功  能：查找指定数组在CBinaryGroup对象中第一次出现的位置
	*    参  数：right 需要查找的数组引用,  uStartPos开始查找的位置
	*    返回值：指定数组第一次出现的位置，找不到时返回uint32_t(-1)
	**********************************************************/
	uint32_t Find(const CBinary& right, uint32_t uStartPos = 0);

	/**********************************************************
	*    功  能：在CBinaryGroup对象指定的位置插入指定的数组
	*    参  数：uPos 需要插入的位置， right需要插入的字符数组
	*    返回值：当前对象
	**********************************************************/
	CBinaryGroup& Insert(uint32_t uPos, const CBinary& right);

	/**********************************************************
	*    功  能：在CBinaryGroup对象指定的位置插入指定的right
	*    参  数：uPos 需要插入的位置， right需要插入的CBinaryGroup对象
	*    返回值：当前对象
	**********************************************************/
	CBinaryGroup& Insert(uint32_t uPos, const CBinaryGroup& right);

	/**********************************************************
	*    功  能：判断当前CBinaryGroup对象是否为空
	*    参  数：无
	*    返回值：ture 表示当前数组为空数组， false 表示当前数组不为空
	**********************************************************/
	bool IsImpty()const;


	//重载的操作符
	CBinaryGroup& operator=(const CBinaryGroup& right);
	CBinaryGroup& operator=(CBinaryGroup&& right);
	CBinaryGroup& operator+=(const CBinary& right);
	CBinaryGroup& operator+=(const CBinaryGroup& right);
	bool operator==(const CBinaryGroup& right);
	bool operator!=(const CBinaryGroup& right);
	CBinary& operator[](uint32_t uPos);
	const CBinary& operator[](uint32_t uPos)const;

private:
	vector<CBinary>* m_pvctBins;
};


#endif //!_BINARYGROUP_H_
