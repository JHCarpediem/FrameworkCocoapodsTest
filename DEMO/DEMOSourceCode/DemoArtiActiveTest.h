#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiActiveTest:
		public CAPITest
	{
	public:
		//uint32_t uRetBtn = DF_ID_NOKEY;

	protected:
	private:

	public:
		void ShowMenu();
		void ArtiActiveTest_InitTitle();
		void ArtiActiveTest_AddItem();
		void ArtiActiveTest_GetUpdateItems();
		void ArtiActiveTest_SetValue();
		void ArtiActiveTest_SetItem();
		void ArtiActiveTest_SetUnit();
		void ArtiActiveTest_SetOperationTipsOnTop();
		void ArtiActiveTest_SetOperationTipsOnBottom();
		void ArtiActiveTest_SetHeads();
		void ArtiActiveTest_SetLockFirstRow();
		void ArtiActiveTest_AddButton();
		void ArtiActiveTest_AddButtonEx();
		void ArtiActiveTest_DelButton();
		void ArtiActiveTest_SetButtonStatus();
		void ArtiActiveTest_SetButtonText();
		void ArtiActiveTest_MaxTest();

		void ArtiActiveTest_Show();
		void ArtiActiveTest_Show_Type1();
		void ArtiActiveTest_Show_Type2();

		void ArtiActiveTest_SetTipsTitleOnTop();
		void ArtiActiveTest_SetTipsTitleOnBottom();

	};
}