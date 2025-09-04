#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiMiniMsgBoxTest : public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiMiniMsgBoxTest_InitMsgBox();
		void ArtiMiniMsgBoxTest_SetTitle();
		void ArtiMiniMsgBoxTest_SetContent();
		void ArtiMiniMsgBoxTest_AddButton();
		void ArtiMiniMsgBoxTest_SetButtonType();
		void ArtiMiniMsgBoxTest_SetButtonStatus();
		void ArtiMiniMsgBoxTest_SetButtonText();
		void ArtiMiniMsgBoxTest_SetAlignType();
		void ArtiMiniMsgBoxTest_SetBusyVisible();
		void ArtiMiniMsgBoxTest_SetBusyVisible1();	
		void ArtiMiniMsgBoxTest_SetSingleCheckBoxText();
	protected:
	private:
		vector<int32_t> vctColWidth2 = {50, 50};
		vector<int32_t> vctColWidth3 = {50, 30, 20};


	};

}