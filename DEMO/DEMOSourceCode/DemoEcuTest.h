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


#ifndef _EcuTest_
#define _EcuTest_

#include "DemoEnterSys.h"

namespace Topdon_AD900_Demo {

	class CEcuTest
	{
// 	private:
// 		CEnterSys* m_pSysEnter;

	public:
		CEcuTest();
		~CEcuTest();

	public:
		void TestEcu();
		bool TestSingleEcu(uint32_t uEcuIndex);
		bool TestPwm();
		bool TestVPW();
		bool TestKWP(uint8_t uSel);
		bool TestCAN(uint8_t uSelect);
		bool TestHondaPro();
		bool TestMit_Old();
		bool TestK1281();

	protected:

	public:
	};
}
#endif /*_READ_VER_H_*/