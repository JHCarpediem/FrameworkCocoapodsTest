#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiEcuInfoTest:public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiEcuInfoTest_InitTitle();
		void ArtiEcuInfoTest_SetColWidth();
		void ArtiEcuInfoTest_AddGroup();
		void ArtiEcuInfoTest_AddItem();
		void ArtiEcuInfoTest_MaxTest();

	protected:
	private:
	};

}