#include "DemoArtiFreezeTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiFreezeTest::ShowMenu()
	{

		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");								 vctMenuID.push_back(0);
		uiMenu.AddItem("AddItem");									 vctMenuID.push_back(1);
		uiMenu.AddItem("SetHeads");									 vctMenuID.push_back(2);
		uiMenu.AddItem("SetHeads_SetValueType_AddItemEx");			 vctMenuID.push_back(3);

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
					ArtiFreezeTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiFreezeTest_AddItem();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiFreezeTest_SetHeads();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiFreezeTest_SetHeads_SetValueType_AddItemEx();
				}
			}
		}
	}

	void CArtiFreezeTest::ArtiFreezeTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0300000002"));
		uiMenu.AddItem(artiGetText("FF1300000001"));	//"标题为空文本"
		uiMenu.AddItem(artiGetText("FF1300000002"));	//"标题为单行文本"
		uiMenu.AddItem(artiGetText("FF1300000003"));	//"标题为多行文本"
		uiMenu.AddItem(artiGetText("FF1300000004"));	//"标题英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000005"));	//"标题中文文本长度达到阈值"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = "";
			}
			else if (1 == uRetBtn)
			{
				strTitle = artiGetText("FF0300000001");
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");
			}
			else if (4 == uRetBtn)
			{
				strTitle = artiGetText("FF1200000004");
			}			
			else
			{
				strTitle = TextMulitLineTitle;
			}

#if __Multi_System_Test__
			CArtiFreeze uiFreeze(m_uThread);
#else
			CArtiFreeze uiFreeze;
#endif
			uiFreeze.InitTitle(strTitle);
			uiFreeze.AddItem(artiGetText("FF0300000003"), artiGetText("FF0300000004"), artiGetText("FF0300000005"), artiGetText("FF0300000006"));
			uiFreeze.AddItem(artiGetText("FF0300000007"), artiGetText("FF0300000008"), artiGetText("FF0300000009"), artiGetText("FF030000000A"));

			while (1)
			{
				uRetBtn = uiFreeze.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiFreezeTest::ArtiFreezeTest_AddItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF030000000B"));
		uiMenu.AddItem(artiGetText("FF030000000C"));	//冻结帧各列值为空文本
		uiMenu.AddItem(artiGetText("FF030000000D"));	//冻结帧各列值为单行短文本
		uiMenu.AddItem(artiGetText("FF030000000E"));	//冻结帧各列值为多行文本
		uiMenu.AddItem(artiGetText("FF0300000018"));	//冻结帧各列值英文长度达到阈值
		uiMenu.AddItem(artiGetText("FF0300000019"));	//冻结帧各列值中文长度达到阈值
		uiMenu.AddItem(artiGetText("FF030000001A"));	//冻结帧项数量达到阈值
		uiMenu.AddItem(artiGetText("FF0300000013"));	//冻结帧各列值为单行长文本


		while (1)
		{
#if __Multi_System_Test__
			CArtiFreeze uiFreeze(m_uThread);
#else
			CArtiFreeze uiFreeze;
#endif

			uiFreeze.InitTitle(artiGetText("FF0300000000"));

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				for (uint32_t i = 0; i < 10; i++)	//空文本
				{
					uiFreeze.AddItem("", "", "", "");
				}
			}
			else if (1 == uRetBtn)	//单行文本
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItem(artiGetText("FF030000000F") + "-" + to_string(i), artiGetText("FF0300000010"), artiGetText("FF0300000011"), artiGetText("FF0300000012"));
				}
			}
			else if (3 == uRetBtn)	//"列值英文文本长度阈值(4000)"
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItem(artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"));
				}
			}
			else if (4 == uRetBtn)	//"列值中文文本长度阈值(2000)"
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItem(artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"));
				}
			}
			else if (5 == uRetBtn)	//"数量达到阈值(1000)"
			{
				for (uint32_t i = 0; i < 1000; i++)
				{
					uiFreeze.AddItem(artiGetText("FF030000000F") + "-" + to_string(i), artiGetText("FF0300000010"), artiGetText("FF0300000011"), artiGetText("FF0300000012"));
				}
			}
			else if (6 == uRetBtn)
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItem(artiGetText("FF120000000A"), artiGetText("FF120000000A"), artiGetText("FF120000000A"), artiGetText("FF120000000A"));
				}
			}
			else
			{
				for (uint32_t i = 0; i < 10; i++)	//多行文本
				{
					uiFreeze.AddItem(TextMulitLineTitle, TextMulitLineValue, TextMulitLineUnit, TextMulitLineHelp);
				}
			}

			while (1)
			{
				uRetBtn = uiFreeze.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiFreezeTest::ArtiFreezeTest_SetHeads_SetValueType_AddItemEx()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF030000000B"));
		uiMenu.AddItem(artiGetText("FF030000000C"));	//冻结帧各列值为空文本
		uiMenu.AddItem(artiGetText("FF030000000D"));	//冻结帧各列值为单行短文本
		uiMenu.AddItem(artiGetText("FF030000000E"));	//冻结帧各列值为多行文本
		uiMenu.AddItem(artiGetText("FF0300000018"));	//冻结帧各列值英文长度达到阈值
		uiMenu.AddItem(artiGetText("FF0300000019"));	//冻结帧各列值中文长度达到阈值
		uiMenu.AddItem(artiGetText("FF030000001A"));	//冻结帧项数量达到阈值
		uiMenu.AddItem(artiGetText("FF0300000013"));	//冻结帧各列值为单行长文本

		while (1)
		{
#if __Multi_System_Test__
			CArtiFreeze uiFreeze(m_uThread);
#else
			CArtiFreeze uiFreeze;
#endif

			uiFreeze.InitTitle(artiGetText("FF0300000000"));
			uiFreeze.SetValueType(VALUE_2_COLUMN);
			uiFreeze.SetHeads(vector<string>({ "Name","Value3","Value4","Unit","Help" }));
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)	//空文本
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItemEx("", "", "", "", "");
				}
			}
			else if (1 == uRetBtn)	//单行文本
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItemEx(artiGetText("FF0300000003"), artiGetText("FF0300000004"), artiGetText("FF0300000004"), artiGetText("FF0300000005"), artiGetText("FF0300000006"));
				}
			}
			else if (3 == uRetBtn)	//"列值英文文本长度阈值(4000)"
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItemEx(artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"));
				}
			}
			else if (4 == uRetBtn)	//"列值中文文本长度阈值(2000)"
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItemEx(artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"));
				}
			}
			else if (5 == uRetBtn)	//"数量达到阈值(1000)"
			{
				for (uint32_t i = 0; i < 1000; i++)
				{
					uiFreeze.AddItemEx(artiGetText("FF030000000F") + "-" + to_string(i), artiGetText("FF0300000010"), artiGetText("FF0300000010"), artiGetText("FF0300000011"), artiGetText("FF0300000012"));
				}
			}
			else if (6 == uRetBtn)	//单行文本
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItemEx(artiGetText("FF120000000A"), artiGetText("FF120000000A"), artiGetText("FF120000000A"), artiGetText("FF120000000A"), artiGetText("FF120000000A"));
				}
			}
			else  //多行文本
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiFreeze.AddItemEx(TextMulitLineTitle, TextMulitLineValue, TextMulitLineValue, TextMulitLineUnit, TextMulitLineHelp);
				}
			}

			while (1)
			{
				uRetBtn = uiFreeze.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiFreezeTest::ArtiFreezeTest_SetHeads()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000021"));
		uiMenu.AddItem(artiGetText("FF030000001B"));	//表头列值为空
		uiMenu.AddItem(artiGetText("FF030000001C"));	//表头列值为单行
		uiMenu.AddItem(artiGetText("FF030000001D"));	//表头列值为多行
		uiMenu.AddItem(artiGetText("FF030000001E"));	//表头列值英文长度达到阈值
		uiMenu.AddItem(artiGetText("FF030000001F"));	//表头列值中文长度达到阈值

#if __Multi_System_Test__
		CArtiMenu uiTypeMenu(m_uThread);
#else
		CArtiMenu uiTypeMenu;//冻结帧类型
#endif
		uiTypeMenu.InitTitle("TYPE");
		uiTypeMenu.AddItem("VALUE_ONE_COLUMN");
		uiTypeMenu.AddItem("VALUE_TWO_COLUMN");		

		while (1)
		{
			uint32_t uflag = 0;
#if __Multi_System_Test__
			CArtiFreeze uiFreeze(m_uThread);
#else
			CArtiFreeze uiFreeze;
#endif

			uiFreeze.InitTitle(artiGetText("FF0300000000"));
					
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}		

			while (1)
			{
				uRetBtn = uiTypeMenu.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					uflag = 1;
					break;
				}
				else if (0 == uRetBtn)
				{
					uiFreeze.SetValueType(VALUE_1_COLUMN);
					if (0 == uRetBtn)	//空文本
					{
						uiFreeze.SetHeads(vector<string>({ "","","" }));
					}
					else if (1 == uRetBtn)	//单行文本
					{
						uiFreeze.SetHeads(vector<string>({ "Name","Value","Unit"}));
					}
					else if (3 == uRetBtn)	//"列值英文文本长度阈值(4000)"
					{
						uiFreeze.SetHeads(vector<string>({ artiGetText("FF1100000005"),artiGetText("FF1100000005"),artiGetText("FF1100000005") }));
					}
					else if (4 == uRetBtn)	//"列值中文文本长度阈值(2000)"
					{
						uiFreeze.SetHeads(vector<string>({ artiGetText("FF1200000005"),artiGetText("FF1200000005"),artiGetText("FF1200000005") }));
					}
					else  //多行文本
					{
						uiFreeze.SetHeads(vector<string>({ TextMulitLineTitle,TextMulitLineHelp,TextMulitLineHelp }));
					}

					for (uint32_t i = 0; i < 10; i++)
					{
						uiFreeze.AddItem(to_string(i) + "-" + artiGetText("FF030000000F"), artiGetText("FF0300000010"), artiGetText("FF0300000011"));
					}
					break;
				}
				else
				{
					uiFreeze.SetValueType(VALUE_2_COLUMN);
					if (0 == uRetBtn)	//空文本
					{
						uiFreeze.SetHeads(vector<string>({ "","","","","" }));
					}
					else if (1 == uRetBtn)	//单行文本
					{
						uiFreeze.SetHeads(vector<string>({ "Name","Value1","Value2","Unit","Help" }));
					}
					else if (3 == uRetBtn)	//"列值英文文本长度阈值(4000)"
					{
						uiFreeze.SetHeads(vector<string>({ artiGetText("FF1100000005"),artiGetText("FF1100000005"),artiGetText("FF1100000005"),artiGetText("FF1100000005"),artiGetText("FF1100000005") }));
					}
					else if (4 == uRetBtn)	//"列值中文文本长度阈值(2000)"
					{
						uiFreeze.SetHeads(vector<string>({ artiGetText("FF1200000005"),artiGetText("FF1200000005"),artiGetText("FF1200000005"),artiGetText("FF1200000005"),artiGetText("FF1200000005") }));
					}
					else  //多行文本
					{
						uiFreeze.SetHeads(vector<string>({ TextMulitLineTitle,TextMulitLineValue,TextMulitLineUnit,TextMulitLineHelp,TextMulitLineHelp }));
					}

					for (uint32_t i = 0; i < 10; i++)
					{
						uiFreeze.AddItemEx(to_string(i) + "-" + artiGetText("FF030000000F"), artiGetText("FF0300000010"), artiGetText("FF0300000010"), artiGetText("FF0300000011"), artiGetText("FF0300000012"));
					}
					break;
				}
			}

			if (uflag)
			{
				continue;
			}

			while (1)
			{
				uRetBtn = uiFreeze.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

}