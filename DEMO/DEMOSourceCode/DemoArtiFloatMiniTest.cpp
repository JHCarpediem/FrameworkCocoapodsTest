#include "DemoArtiFloatMiniTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiFloatMiniTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("ArtiFloatMiniTest");
		uiMenu.AddItem("DeleteInstance");								vctMenuID.push_back(0);
		uiMenu.AddItem("Display");										vctMenuID.push_back(1);
		uiMenu.AddItem("NewInstance");									vctMenuID.push_back(2);
		uiMenu.AddItem("Hidden");									    vctMenuID.push_back(3);


		while (1)
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
					ArtiFloatMiniTest_DeleteInstance();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiFloatMiniTest_Display();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiFloatMiniTest_NewInstance();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiFloatMiniTest_Hidden();
				}
			}
		}
	}

	void CArtiFloatMiniTest::ArtiFloatMiniTest_DeleteInstance()
	{
		CArtiFloatMini	FloatMini;

		uint32_t uIdOne = FloatMini.NewInstance(CArtiFloatMini::eFloatType::FT_TIMER_TYPE);
		uint32_t uIdTwo = FloatMini.NewInstance(CArtiFloatMini::eFloatType::FT_TIMER_TYPE);

		FloatMini.Display(uIdOne, "ONE");
		FloatMini.Display(uIdTwo, "TWO");

		artiShowMsgBox("Test Hidden", artiGetText("FF0F000000F2"), DF_MB_OK);
		FloatMini.DeleteInstance(uIdOne);
		artiShowMsgBox("Test Hidden", artiGetText("FF0F000000F3"), DF_MB_OK);
		FloatMini.DeleteInstance(uIdTwo);
	}

	void CArtiFloatMiniTest::ArtiFloatMiniTest_NewInstance()
	{
		CArtiFloatMini	FloatMini;

		FloatMini.NewInstance(CArtiFloatMini::eFloatType::FT_TIMER_TYPE);
		FloatMini.Display(0, artiGetText("FF0F000000F0"));
		artiShowMsgBox("Test NewInstance", artiGetText("FF0F000000F1"), DF_MB_OK);//新建一个悬浮窗

		FloatMini.DeleteInstance(0);

	}

	void CArtiFloatMiniTest::ArtiFloatMiniTest_Display()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF1300000010"));//"提示为空文本"
		uiMenu.AddItem(artiGetText("FF1300000011"));//"提示为单行短文本"
		uiMenu.AddItem(artiGetText("FF1300000012"));//"提示为单行长文本"
		uiMenu.AddItem(artiGetText("FF1300000013"));//"提示为多行文本"
		uiMenu.AddItem(artiGetText("FF1300000014"));//"提示英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000015"));//"提示中文中文长度达到阈值"

		CArtiFloatMini	FloatMini;
		string strContent = "";
		string strTest = "";

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			else if (0 == uRet)
			{
				strContent = "";
				strTest = artiGetText("FF1300000010");
			}
			else if (1 == uRet)
			{
				strContent = TextSingleLine;
				strTest = artiGetText("FF1300000011");
			}
			else if (2 == uRet)
			{
				strContent = artiGetText("FF120000000A");
				strTest = artiGetText("FF1300000012");
			}
			else if (3 == uRet)
			{
				strContent = TextMulitLineValue;
				strTest = artiGetText("FF1300000013");
			}
			else if (4 == uRet)
			{
				strContent = artiGetText("FF1100000003");
				strTest = artiGetText("FF1300000014");
			}
			else if (5 == uRet)
			{
				strContent = artiGetText("FF1200000003");
				strTest = artiGetText("FF1300000015");
			}
			FloatMini.NewInstance(CArtiFloatMini::eFloatType::FT_TIMER_TYPE);
			FloatMini.Display(0, strContent);
			artiShowMsgBox("Test Display", strTest, DF_MB_OK);

			FloatMini.DeleteInstance(0);
		}
	}

	void CArtiFloatMiniTest::ArtiFloatMiniTest_Hidden()
	{
		CArtiFloatMini	FloatMini;

		uint32_t uIdOne = FloatMini.NewInstance(CArtiFloatMini::eFloatType::FT_TIMER_TYPE);
		uint32_t uIdTwo = FloatMini.NewInstance(CArtiFloatMini::eFloatType::FT_TIMER_TYPE);

		FloatMini.Display(uIdOne, "ONE");
		FloatMini.Display(uIdTwo, "TWO");

		artiShowMsgBox("Test Hidden", artiGetText("FF0F000000F4"), DF_MB_OK);
		FloatMini.Hidden(uIdOne);
		artiShowMsgBox("Test Hidden", artiGetText("FF0F000000F5"), DF_MB_OK);

		FloatMini.DeleteInstance(0);

	}


}