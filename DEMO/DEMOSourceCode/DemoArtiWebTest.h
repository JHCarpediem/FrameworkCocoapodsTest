#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiWebTest : public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiWebTest_InitTitle();
		void ArtiWebTest_LoadHtmlFile();
		void ArtiWebTest_LoadHtmlContent();
		void ArtiWebTest_AddButton();
		void ArtiWebTest_SetButtonVisible();

	protected:
	private:
	};

}