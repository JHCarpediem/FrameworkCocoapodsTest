/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : ���������޸�
* �������� : ����MD5 
* �� �� �� : sujiya        20201031
* �� �� �� : binchaolin    20201202
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
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
	*    ��  �ܣ�����MD5
	*    ��  ����input ��Ҫ����MD5�����ݣ�inputlen �����������ݵĳ���
	*    ����ֵ����
	**********************************************************/
	void UpdateMd5(uint8_t *input, uint32_t inputlen);

	/**********************************************************
	*    ��  �ܣ���ȡ���յ�MD5
	*    ��  ������
	*    ����ֵ������֡��֡��
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
