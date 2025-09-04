/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 动作测试
* 功能描述 : 动作测试举例
* 创 建 人 : panjun        20210123
* 审 核 人 :
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ACTIVE_
#define _ACTIVE_

#include "DemoEnterSys.h"
#include "ProFile.h"

namespace Topdon_AD900_Demo {
	class CActive
	{
	private:
		CEnterSys* m_pSysEnter;

	public:
		CActive();
		~CActive();

	public:
		/*-----------------------------------------------------------------------------
		功    能：	将pSysEnter设给m_pSysEnter
		参数说明：	pSysEnter 系统进入指针
		返 回 值：	无
		说    明：	无
		-----------------------------------------------------------------------------*/
		void SetSysEnterPointer(CEnterSys* pSysEnter);

		/*-----------------------------------------------------------------------------
		功    能：	动作测试入口
		参数说明：	无
		返 回 值：	错误代码
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ActiveTest(CBinary binSys);

		/*-----------------------------------------------------------------------------
		功    能：	动作测试模式1
		参数说明：	strTitl 标题  strItem
		返 回 值：	错误代码
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ActiveTest1(string strSys,string strTitle, string strItem, CProFile& profile);

		/*-----------------------------------------------------------------------------
		功    能：	动作测试模式2
		参数说明：	strTitl 标题  strItem
		返 回 值：	错误代码
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ActiveTest2(string strSys, string strTitle, string strItem, CProFile& profile);

		/*-----------------------------------------------------------------------------
		功    能：	动作测试模式3
		参数说明：	strTitl 标题  strItem
		返 回 值：	错误代码
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ActiveTest3(string strSys, string strTitle, string strItem, CProFile& profile);


		vector<vector<string>> GetDataList(string strSys, vector<string> vctstrData);

	protected:


	};
}
#endif /*_READ_VER_H_*/
