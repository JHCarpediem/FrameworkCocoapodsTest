#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiFreezeTest : public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiFreezeTest_InitTitle();
		void ArtiFreezeTest_AddItem();
		void ArtiFreezeTest_SetHeads_SetValueType_AddItemEx();
		void ArtiFreezeTest_SetHeads();

	protected:
	private:
	};

}