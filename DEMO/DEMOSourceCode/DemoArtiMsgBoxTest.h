#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiMsgBoxTest : public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiMsgBoxTest_InitMsgBox();
		void ArtiMsgBoxTest_SetTitle();
		void ArtiMsgBoxTest_SetContent();
		void ArtiMsgBoxTest_AddButton();
		void ArtiMsgBoxTest_AddButtonEx();
		void ArtiMsgBoxTest_DelButton();
		void ArtiMsgBoxTest_SetButtonType();
		void ArtiMsgBoxTest_SetButtonStatus();
		void ArtiMsgBoxTest_SetButtonText();
		void ArtiMsgBoxTest_GetButtonText();// 新增接口 [11/17/2022 qunshang.li]
		void ArtiMsgBoxTest_SetAlignType();
		void ArtiMsgBoxTest_SetTimer();
		void ArtiMsgBoxTest_SetBusyVisible();
		void ArtiMsgBoxTest_SetProcessBarVisible();
		void ArtiMsgBoxTest_SetProgressBarPercent();
		void ArtiMsgBoxTest_MultiInterface();
		void ArtiMsgBoxTest_MultiInterface_Sample1();
		//void ArtiMsgBoxTest_artiMsgBoxActTest();//全局函数，用于小车探部件测试

	protected:
	private:
	};

}