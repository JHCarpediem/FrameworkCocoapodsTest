#include "DemoImmoTest.h"
#include "DemoPublicAPI.h"
#include "AlgorithmData.h"
#include "PublicInterface.h"


namespace Topdon_AD900_Demo {

	void CImmoTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

		CArtiMenu uiMenu;
		uiMenu.InitTitle(artiGetText("FF1000000000"));			//À¯Ω≥≤‚ ‘œÓ
		uiMenu.AddItem(artiGetText("FF1000000001"));	vctMenuID.push_back(0);	//À„∑®≤‚ ‘

		while (true)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctMenuID.size())
			{
				if (0 == vctMenuID[uRetBtn])
				{
					ImmoTest_CalcTest();
				}
			}
		}
	}

	void CImmoTest::ImmoTest_CalcTest()
	{
		//uint32_t uCalcID = 0x0206;
		//CBinary CalcSeed = CBinary("\x12\x34\x56\x78", 4);
		//uint8_t SeedType = CAlgorithmData::SEED_TYPE_LOCAL;

		CArtiList uiList;
		uiList.InitTitle("AlgorithmDataTest");
		uiList.SetColWidth(vector<int32_t>({ 50, 50 }));
		uiList.AddItem("CalcID");
		uiList.AddItem("CalcSeed");
		uiList.AddItem("SeedType");
		uiList.AddItem("KeyValue");

		uiList.SetItem(0, 1, "0x0206");
		uiList.SetItem(1, 1, " 0x12, 0x34, 0x56, 0x78");
		uiList.SetItem(2, 1, "SEED_TYPE_LOCAL");
		uiList.SetItem(3, 1, "");

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{

			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				CAlgorithmData data2;
				data2.SetId(0x0206);
				data2.SetSeed(CBinary("\x12\x34\x56\x78", 4));
				data2.SetSeedType(CAlgorithmData::SEED_TYPE_LOCAL);
				CArtiGlobal::RpcSendRecv(&data2);
				CBinary bOut = data2.GetKey();//∑µªÿFC4F13E7
				string strOut = Binary2HexString(bOut);
				uiList.SetItem(3, 1, strOut);
			}
		}
	}
}
