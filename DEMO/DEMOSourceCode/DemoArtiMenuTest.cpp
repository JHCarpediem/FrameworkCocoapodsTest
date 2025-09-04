#include "DemoArtiMenuTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiMenuTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("AddItem");	                vctMenuID.push_back(1);
		uiMenu.AddItem("GetItem");	                vctMenuID.push_back(2);
		uiMenu.AddItem("SetIcon");	                vctMenuID.push_back(3);
		uiMenu.AddItem("SetHelpButtonVisible");	    vctMenuID.push_back(4);
		//uiMenu.AddItem("SetMenuTreeVisible");	    vctMenuID.push_back(5);
		uiMenu.AddItem("SetMenuId");	            vctMenuID.push_back(6);
		uiMenu.AddItem("GetMenuId");	            vctMenuID.push_back(7);
		uiMenu.AddItem("Show");					    vctMenuID.push_back(8);

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
					ArtiMenuTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_AddItem();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_GetItem();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_SetIcon();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_SetHelpButtonVisible();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_SetMenuTreeVisible();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_SetMenuId();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_GetMenuId();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiMenuTest_Show();
				}
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0800000020"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF0800000022"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF0000000005"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF0800000012"));	//"标题英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0800000013"));	//"标题中文文本长度达到阈值"

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
				strTitle = artiGetText("FF0800000000");
			}
			else if (2 == uRetBtn)
			{
				strTitle = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");
			}
			else if (4 == uRetBtn)
			{
				strTitle = artiGetText("FF1200000004");
			}

#if __Multi_System_Test__
			CArtiMenu uiMenuTest(m_uThread);
#else
			CArtiMenu uiMenuTest;
#endif

			uiMenuTest.InitTitle(strTitle);
			uiMenuTest.AddItem(artiGetText("FF0800000001"));
			uiMenuTest.AddItem(artiGetText("FF0800000002"));
			uiMenuTest.AddItem(artiGetText("FF0800000003"));

			while (1)
			{
				uRetBtn = uiMenuTest.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_AddItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF080000000F"));//"菜单名称文本为空"
		uiMenu.AddItem(artiGetText("FF0800000010"));//"菜单名称文本为单行短文本"
		uiMenu.AddItem(artiGetText("FF0800000023"));//"菜单名称文本为单行长文本"
		uiMenu.AddItem(artiGetText("FF0800000011"));//"菜单名称文本为多行文本"
		uiMenu.AddItem(artiGetText("FF0800000014"));//"菜单名称英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0800000015"));//"菜单名称中文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0800000016"));//"菜单项数量达到阈值"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
#if __Multi_System_Test__
				CArtiMenu uiMenuTest(m_uThread);
#else
				CArtiMenu uiMenuTest;
#endif

				uiMenuTest.InitTitle(artiGetText("FF0800000000"));//"菜单控件测试"

				if (0 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem("");
					}
				}
				else if (1 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0800000004").c_str(), i);//"菜单%d"
						uiMenuTest.AddItem(buff);
					}
				}
				else if (2 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(artiGetText("FF120000000A"));
					}
				}
				else if (3 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(TextMulitLineTitle);
					}
				}
				else if (4 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(artiGetText("FF1100000004"));
					}
				}
				else if (5 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(artiGetText("FF1200000004"));
					}
				}
				else
				{
					for (uint32_t i = 0; i < 1000; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0800000004").c_str(), i);//"菜单%d"
						uiMenuTest.AddItem(buff);
					}
				}

				while (1)
				{
					uRetBtn = uiMenuTest.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
					else
					{
						ShowMsgBoxDemo(artiGetText("FF0800000005"), uiMenuTest.GetItem(uRetBtn), DF_MB_OK, DT_LEFT, -1, m_uThread);
					}
				}
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_GetItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF080000000F"));//"菜单名称文本为空"
		uiMenu.AddItem(artiGetText("FF0800000010"));//"菜单名称文本为单行文本"
		uiMenu.AddItem(artiGetText("FF0800000011"));//"菜单名称文本为多行文本"
		uiMenu.AddItem(artiGetText("FF0800000014"));//"菜单名称英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0800000015"));//"菜单名称中文文本长度达到阈值"		

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
#if __Multi_System_Test__
				CArtiMenu uiMenuTest(m_uThread);
#else
				CArtiMenu uiMenuTest;
#endif

				uiMenuTest.InitTitle(artiGetText("FF0800000000"));//"菜单控件测试"

				if (0 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem("");
					}
				}
				else if (1 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0800000004").c_str(), i);//"菜单%d"
						uiMenuTest.AddItem(buff);
					}
				}
				else if (2 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(TextMulitLineTitle);
					}
				}
				else if (3 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(artiGetText("FF1100000004"));
					}
				}
				else if (4 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiMenuTest.AddItem(artiGetText("FF1200000004"));
					}
				}

				while (1)
				{
					uRetBtn = uiMenuTest.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
					else
					{
						ShowMsgBoxDemo(artiGetText("FF0800000005"), artiGetText("FF0800000017") + uiMenuTest.GetItem(uRetBtn), DF_MB_OK, DT_LEFT, -1, m_uThread);
					}
				}
			}			
		}		
	}

	void CArtiMenuTest::ArtiMenuTest_SetIcon()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SetIcon");
		uiMenu.AddItem("Benz");
		uiMenu.AddItem("BWM");
		uiMenu.AddItem(artiGetText("FF0800000019"));
		uiMenu.AddItem(artiGetText("FF0800000018"));	

		string strPathBenz = CArtiGlobal::GetVehPath() + "/Logo/Benz.png";
		string strPathBWM = CArtiGlobal::GetVehPath() + "/Logo/BWM.png";
		string strPathAudi = CArtiGlobal::GetVehPath() + "/Logo/Audi.png";
		string strPathNull = "";

		uiMenu.SetIcon(0, strPathBenz, "Benz");
		uiMenu.SetIcon(1, strPathBWM, "BMW");
		uiMenu.SetIcon(2, strPathAudi, "");							  //菜单项名称缩写为空
		uiMenu.SetIcon(3, strPathNull, artiGetText("FF0800000018"));  //图片路径为空
		

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_SetHelpButtonVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0800000006"));//"显示帮助按钮"
		uiMenu.AddItem(artiGetText("FF0800000007"));//"隐藏帮助按钮"

		uint32_t uSelect = 0;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				uSelect = uRetBtn;
#if __Multi_System_Test__
				CArtiMenu uiMenuTest(m_uThread);
#else
				CArtiMenu uiMenuTest;
#endif

				uiMenuTest.InitTitle(artiGetText("FF0800000000"));//"菜单控件测试"
				for (uint32_t i = 0; i < 500; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0800000004").c_str(), i);//"菜单%d"
					uiMenuTest.AddItem(buff);
				}
				if (uSelect == 0)
				{
					uiMenuTest.SetHelpButtonVisible(true);
				}
				else
				{
					uiMenuTest.SetHelpButtonVisible(false);
				}

				while (1)
				{
					uRetBtn = uiMenuTest.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
					else if (uRetBtn == DF_ID_HELP)
					{
						ShowMsgBoxDemo("Click Events", artiGetText("FF080000001A"));
					}
				}
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_SetMenuTreeVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0800000008"));//"显示左侧菜单树"
		uiMenu.AddItem(artiGetText("FF0800000009"));//"隐藏左侧菜单树"

		uint32_t uSelect = 0;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				uSelect = uRetBtn;
#if __Multi_System_Test__
				CArtiMenu uiMenuTest(m_uThread);
#else
				CArtiMenu uiMenuTest;
#endif

				uiMenuTest.InitTitle(artiGetText("FF0800000000"));//"菜单控件测试"
				for (uint32_t i = 0; i < 500; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0800000004").c_str(), i);//"菜单%d"
					uiMenuTest.AddItem(buff);
				}
				if (uSelect == 0)
				{
					uiMenuTest.SetMenuTreeVisible(true);
				}
				else
				{
					uiMenuTest.SetMenuTreeVisible(false);
				}

				while (1)
				{
					uRetBtn = uiMenuTest.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_SetMenuId()
	{
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SetMenuId");//artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF080000000B"));	//"菜单ID文本为空"
		uiMenu.AddItem(artiGetText("FF080000000C"));	//"菜单ID文本为单行文本"
		uiMenu.AddItem(artiGetText("FF080000000D"));	//"菜单ID文本为多行文本"
		uiMenu.AddItem(artiGetText("FF080000001B"));	//"菜单ID文本为英文且长度达到阈值"
		uiMenu.AddItem(artiGetText("FF080000001C"));	//"菜单ID文本为中文且长度达到阈值"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strText = "";
			}
			else if (1 == uRetBtn)
			{
				strText = artiGetText("FF080000000A");
			}
			else if (2 == uRetBtn)
			{
				strText = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				strText = artiGetText("FF1100000001");
			}
			else if (4 == uRetBtn)
			{
				strText = artiGetText("FF1200000001");
			}

#if __Multi_System_Test__
			CArtiMenu uiMenuTest(m_uThread);
#else
			CArtiMenu uiMenuTest;
#endif

			uiMenuTest.InitTitle(artiGetText("FF0800000000"));
			uiMenuTest.AddItem(artiGetText("FF0800000001"));
			uiMenuTest.AddItem(artiGetText("FF0800000002"));
			uiMenuTest.AddItem(artiGetText("FF0800000003"));

			uiMenuTest.SetMenuId(strText);

			ShowMsgBoxDemo(artiGetText("FF080000000E"), artiGetText("FF080000001D") + uiMenuTest.GetMenuId(), DF_MB_OK, DT_LEFT, -1, m_uThread);//GetMenuId()返回值

		}
	}

	void CArtiMenuTest::ArtiMenuTest_GetMenuId()
	{
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetMenuId");//artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF080000000B"));	//"菜单ID文本为空"
		uiMenu.AddItem(artiGetText("FF080000000C"));	//"菜单ID文本为单行文本"
		uiMenu.AddItem(artiGetText("FF080000000D"));	//"菜单ID文本为多行文本"
		uiMenu.AddItem(artiGetText("FF080000001B"));	//"菜单ID文本为英文且长度达到阈值"
		uiMenu.AddItem(artiGetText("FF080000001C"));	//"菜单ID文本为中文且长度达到阈值"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strText = "";
		}
			else if (1 == uRetBtn)
			{
				strText = artiGetText("FF080000000A");
			}
			else if (2 == uRetBtn)
			{
				strText = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				strText = artiGetText("FF1100000001");
			}
			else if (4 == uRetBtn)
			{
				strText = artiGetText("FF1200000001");
			}

#if __Multi_System_Test__
			CArtiMenu uiMenuTest(m_uThread);
#else
			CArtiMenu uiMenuTest;
#endif

			uiMenuTest.InitTitle(artiGetText("FF0800000000"));
			uiMenuTest.AddItem(artiGetText("FF0800000001"));
			uiMenuTest.AddItem(artiGetText("FF0800000002"));
			uiMenuTest.AddItem(artiGetText("FF0800000003"));

			uiMenuTest.SetMenuId(strText);

			ShowMsgBoxDemo(artiGetText("FF080000000E"), artiGetText("FF080000001E") + uiMenuTest.GetMenuId(), DF_MB_OK, DT_LEFT, -1, m_uThread);//GetMenuId()返回值

	}
	}

	void CArtiMenuTest::ArtiMenuTest_Show()
	{
		CArtiMenu uiMenu;
		uiMenu.InitTitle("Show");
		uiMenu.AddItem(artiGetText("FF0000000111"));//"连续点击按键测试"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				ArtiMenuTest_Show_Type2();
			}
		}
	}

	void CArtiMenuTest::ArtiMenuTest_Show_Type1()
	{
		
	}

	void CArtiMenuTest::ArtiMenuTest_Show_Type2()
	{
		CArtiMenu uiMenu1;
		uiMenu1.InitTitle(artiGetText("FF0000000111") + " Menu1");//"连续点击按键测试"
		uiMenu1.AddItem("Sleep 0 s");
		uiMenu1.AddItem("Sleep 2 s");
		uiMenu1.AddItem("Sleep 4 s");
		uiMenu1.AddItem("Sleep 6 s");
		uiMenu1.AddItem("Sleep 8 s");
		
		while (1)
		{
			uRetBtn = uiMenu1.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				return;
			}
			else if (uRetBtn >= 0 && uRetBtn <= 4)
			{				
				artiShowMsgBox("ShowTest", "Sleep" + to_string(uRetBtn * 2) + "s", DF_MB_NOBUTTON, DT_CENTER, -1);
				Delay(uRetBtn * 2000);
				return;
				
			}
		}
	}

}