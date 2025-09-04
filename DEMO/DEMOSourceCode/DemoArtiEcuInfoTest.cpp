#include "DemoArtiEcuInfoTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiEcuInfoTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("SetColWidth");			    vctMenuID.push_back(1);
		uiMenu.AddItem("AddGroup");		            vctMenuID.push_back(2);
		uiMenu.AddItem("AddItem");		            vctMenuID.push_back(3);
		//uiMenu.AddItem("测试极限值");	            vctMenuID.push_back(11);

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
					ArtiEcuInfoTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiEcuInfoTest_SetColWidth();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiEcuInfoTest_AddGroup();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiEcuInfoTest_AddItem();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiEcuInfoTest_MaxTest();
				}
			}
		}
	}


	void CArtiEcuInfoTest::ArtiEcuInfoTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000023"));
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
				strTitle = artiGetText("FF0200000000");
			}
			else if (3 == uRetBtn)//"英文标题文本长度达到阈值(1000)"
			{
				strTitle = artiGetText("FF1100000004");
			}
			else if (4 == uRetBtn)//"中文表达文本长度达到阈值(500)"
			{
				strTitle = artiGetText("FF1200000004");
			}			
			else
			{
				strTitle = TextMulitLineTitle;
			}

#if __Multi_System_Test__
			CArtiEcuInfo uiEcuInfo(m_uThread);
#else
			CArtiEcuInfo uiEcuInfo;
#endif
			uiEcuInfo.InitTitle(strTitle);
			uiEcuInfo.SetColWidth(50, 50);
			uiEcuInfo.AddItem(artiGetText("FF0200000003"), artiGetText("FF0200000004"));
			uiEcuInfo.AddItem(artiGetText("FF0200000005"), artiGetText("FF0200000006"));

			while (1)
			{
				uRetBtn = uiEcuInfo.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiEcuInfoTest::ArtiEcuInfoTest_SetColWidth()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0200000007"));
		uiMenu.AddItem("0,100");
		uiMenu.AddItem("50,50");
		uiMenu.AddItem("100,0");

		while (1)
		{
#if __Multi_System_Test__
			CArtiEcuInfo uiEcuInfo(m_uThread);
#else
			CArtiEcuInfo uiEcuInfo;
#endif
			uiEcuInfo.InitTitle(artiGetText("FF0200000000"));

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				uiEcuInfo.SetColWidth(0, 100);
			}
			else if (1 == uRetBtn)
			{
				uiEcuInfo.SetColWidth(50, 50);
			}
			else
			{
				uiEcuInfo.SetColWidth(100, 0);
			}
			uiEcuInfo.AddItem(artiGetText("FF0200000003"), artiGetText("FF0200000004"));
			uiEcuInfo.AddItem(artiGetText("FF0200000005"), artiGetText("FF0200000006"));

			while (1)
			{
				uRetBtn = uiEcuInfo.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiEcuInfoTest::ArtiEcuInfoTest_AddGroup()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0200000008"));
		uiMenu.AddItem(artiGetText("FF0200000012"));	//分组名为空文本
		uiMenu.AddItem(artiGetText("FF0200000013"));	//分组名为单行短文本
		uiMenu.AddItem(artiGetText("FF0200000015"));	//分组名为多行文本
		uiMenu.AddItem(artiGetText("FF0200000016"));	//分组名英文长度达到阈值
		uiMenu.AddItem(artiGetText("FF0200000017"));	//分组名中文长度达到阈值
		uiMenu.AddItem(artiGetText("FF0200000018"));	//分组数量达到阈值
		uiMenu.AddItem(artiGetText("FF0200000014"));	//分组名为单行长文本

		while (1)
		{
#if __Multi_System_Test__
			CArtiEcuInfo uiEcuInfo(m_uThread);
#else
			CArtiEcuInfo uiEcuInfo;
#endif
			uiEcuInfo.InitTitle(artiGetText("FF0200000000"));
			uiEcuInfo.SetColWidth(50, 50);

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				uiEcuInfo.AddGroup("");
			}
			else if (1 == uRetBtn)
			{
				uiEcuInfo.AddGroup(artiGetText("FF0200000009"));
			}
			else if (2 == uRetBtn)
			{
				uiEcuInfo.AddGroup(TextMulitLineTitle);
			}
			else if (3 == uRetBtn)//"分组组名英文文本长度达到阈值(1000)"
			{
				uiEcuInfo.AddGroup(artiGetText("FF1100000004"));			
			}
			else if (4 == uRetBtn)//"分组组名中文表达文本长度达到阈值(500)"
			{
				uiEcuInfo.AddGroup(artiGetText("FF1200000004"));				
			}
			else if (5 == uRetBtn)//"分组数量达到阈值(500)"
			{
				for (uint32_t i = 0; i < 500; i++)
				{
					uiEcuInfo.AddGroup(artiGetText("FF0200000009") + "-" + to_string(i));
					uiEcuInfo.AddItem(artiGetText("FF0200000003"), artiGetText("FF0200000004"));
					uiEcuInfo.AddItem(artiGetText("FF0200000005"), artiGetText("FF0200000006"));
				}

				while (1)
				{
					uRetBtn = uiEcuInfo.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
				continue;
			}
			else if (6 == uRetBtn)
			{
				uiEcuInfo.AddGroup(artiGetText("FF120000000A"));
			}			
			uiEcuInfo.AddItem(artiGetText("FF0200000003"), artiGetText("FF0200000004"));
			uiEcuInfo.AddItem(artiGetText("FF0200000005"), artiGetText("FF0200000006"));

			while (1)
			{
				uRetBtn = uiEcuInfo.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiEcuInfoTest::ArtiEcuInfoTest_AddItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF020000000A"));	//"名称和值为空文本"
		uiMenu.AddItem(artiGetText("FF020000000B"));	//"名称和值为单行短文本"
		uiMenu.AddItem(artiGetText("FF020000000D"));	//"名称和值为多行文本"
		uiMenu.AddItem(artiGetText("FF0200000019"));	//"名称和值英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF020000001A"));	//"名称和值中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF020000001B"));	//"版本信息项数量达到阈值"
		uiMenu.AddItem(artiGetText("FF020000000C"));	//"名称和值为单行长文本"

		while (1)
		{
#if __Multi_System_Test__
			CArtiEcuInfo uiEcuInfo(m_uThread);
#else
			CArtiEcuInfo uiEcuInfo;
#endif
			uiEcuInfo.InitTitle(artiGetText("FF0200000000"));
			uiEcuInfo.SetColWidth(50, 50);

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiEcuInfo.AddItem("", "");
				}
			}
			else if (1 == uRetBtn)
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiEcuInfo.AddItem(artiGetText("FF0200000000") + "-" + to_string(i), artiGetText("FF020000000D") + "-" + to_string(i));
				}
			}
			else if (3 == uRetBtn)	//"列值英文文本长度阈值(4000)"
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiEcuInfo.AddItem(artiGetText("FF1100000005"), artiGetText("FF1100000005"));
				}				
			}
			else if (4 == uRetBtn)	//"列值中文文本长度阈值(2000)"
			{			
				for (uint32_t i = 0; i < 10; i++)
				{
					uiEcuInfo.AddItem(artiGetText("FF1200000005"), artiGetText("FF1200000005"));
				}										
			}
			else if (5 == uRetBtn)	//"行数达到阈值(10000)"
			{
				for (uint32_t i = 0; i < 10000; i++)
				{
					uiEcuInfo.AddItem(artiGetText("FF0200000000") + "-" + to_string(i), artiGetText("FF020000000D") + "-" + to_string(i));
				}				
			}
			else if (6 == uRetBtn)	
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiEcuInfo.AddItem(artiGetText("FF120000000A"), artiGetText("FF120000000A"));
				}
			}
			else
			{
				for (uint32_t i = 0; i < 10; i++)
				{
					uiEcuInfo.AddItem(TextMulitLineTitle, TextMulitLineValue);
				}
			}

			while (1)
			{
				uRetBtn = uiEcuInfo.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiEcuInfoTest::ArtiEcuInfoTest_MaxTest()
	{
		ShowMsgBoxDemo(artiGetText("FF0200000001"), artiGetText("FF0200000002"), DF_MB_OK, DT_LEFT, -1, m_uThread);
#if __Multi_System_Test__
		CArtiEcuInfo uiEcuInfo(m_uThread);
#else
		CArtiEcuInfo uiEcuInfo;
#endif
		uiEcuInfo.InitTitle(artiGetText("FF0200000000"));
		uiEcuInfo.SetColWidth(50, 50);
		for (uint32_t i = 0; i < 500; i++)
		{
			uiEcuInfo.AddItem(TextMulitLineTitle, TextMulitLineValue);
		}
		uiEcuInfo.Show();
	}

}