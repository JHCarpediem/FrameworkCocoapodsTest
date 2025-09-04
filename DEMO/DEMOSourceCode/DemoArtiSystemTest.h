#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiSystemTest : public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiSystemTest_InitTitle();
		void ArtiSystemTest_AddItem();
		void ArtiSystemTest_GetItem();
		void ArtiSystemTest_GetDtcItems();
		void ArtiSystemTest_SetHelpButtonVisible();
		void ArtiSystemTest_SetClearButtonVisible();
		void ArtiSystemTest_SetItemStatus();
		void ArtiSystemTest_SetItemResult();
		void ArtiSystemTest_SetButtonAreaHidden();
		void ArtiSystemTest_SetScanStatus();
		void ArtiSystemTest_SetClearStatus();
		void ArtiSystemTest_GetDiagMenuMask();
		void ArtiSystemTest_SetAtuoScanEnable();
		void SetAtuoScanEnableScanSys(bool bAutoScan = false);

	protected:
	private:
	};

}