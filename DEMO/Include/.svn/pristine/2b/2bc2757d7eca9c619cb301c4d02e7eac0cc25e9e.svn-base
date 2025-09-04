/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 来自网络修改
* 功能描述 : 计算MD5 
* 创 建 人 : sujiya        20201031
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _MD5_H_
#define _MD5_H_
#include<cstdio>
#include<cstring>
#include<algorithm>
#include<cstdlib>
#include<iostream>
#include<cmath>
#include "StdInclude.h"

class _STD_DLL_API_ Md5
{
public:
	Md5();
	~Md5();

	/**********************************************************
	*    功  能：更新MD5
	*    参  数：input 需要计算MD5的数据，inputlen 参与计算的数据的长度
	*    返回值：空
	**********************************************************/
	void UpdateMd5(uint8_t *input, uint32_t inputlen);

	/**********************************************************
	*    功  能：获取最终的MD5
	*    参  数：无
	*    返回值：接收帧总帧数
	**********************************************************/
	void FinalMd5(uint8_t digest[16]);
	

protected:
	void MD5Transform(uint32_t state[4], uint8_t block[64]);
	void MD5Encode(uint8_t *output, uint32_t *input, uint32_t len);
	void MD5Decode(uint32_t *output, uint8_t *input, uint32_t len);

private:
	struct {
		uint32_t count[2];
		uint32_t state[4];
		uint8_t buffer[64];
	} m_md5_context;
};

#endif
