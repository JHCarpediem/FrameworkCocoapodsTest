/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 数据流
* 功能描述 : 数据流举例
* 创 建 人 : panjun        20210123
* 审 核 人 :
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/


#ifndef _LIVEDATA_
#define _LIVEDATA_
#include "DemoEnterSys.h"
#include "StdShowMaco.h"
#include "DemoVehicleStruct.h"

namespace Topdon_AD900_Demo {

	class CLiveData
	{
	private:
		CEnterSys* m_pSysEnter;

	public:
		CLiveData();
		~CLiveData();

	public:
		/*-----------------------------------------------------------------------------
		功    能：	将pSysEnter设给m_pSysEnter
		参数说明：	pSysEnter 系统进入指针
		返 回 值：	无
		说    明：	无
		-----------------------------------------------------------------------------*/
		void SetSysEnterPointer(CEnterSys* pSysEnter);

		/*-----------------------------------------------------------------------------
		功    能：	读版本信息
		参数说明：	无
		返 回 值：	无
		说    明：	无
		-----------------------------------------------------------------------------*/
		void DataStream(CBinary binSys);

	protected:

	public:
		void SetLiveDataReport(std::vector<stDsReportItem>& vctItem);
	};
}
#endif /*_READ_VER_H_*/