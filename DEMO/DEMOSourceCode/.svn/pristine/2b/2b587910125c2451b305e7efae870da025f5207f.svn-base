#include "DemoArtiActiveTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"
#include <time.h>

namespace Topdon_AD900_Demo {

	void CArtiActiveTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("AddItem");			        vctMenuID.push_back(1);
		uiMenu.AddItem("GetUpdateItems");		    vctMenuID.push_back(2);
		uiMenu.AddItem("SetValue");		            vctMenuID.push_back(3);
		uiMenu.AddItem("SetItem");	                vctMenuID.push_back(4);
		uiMenu.AddItem("SetUnit");	                vctMenuID.push_back(5);
		uiMenu.AddItem("SetOperationTipsOnTop");	vctMenuID.push_back(6);
		uiMenu.AddItem("SetOperationTipsOnBottom"); vctMenuID.push_back(7);
		uiMenu.AddItem("SetHeads");				    vctMenuID.push_back(8);
		uiMenu.AddItem("SetLockFirstRow");			vctMenuID.push_back(9);
		uiMenu.AddItem("AddButton");			    vctMenuID.push_back(10);
		uiMenu.AddItem("AddButtonEx");				vctMenuID.push_back(11);
		uiMenu.AddItem("DelButton");				vctMenuID.push_back(12);
		uiMenu.AddItem("SetButtonStatus");	        vctMenuID.push_back(13);
		uiMenu.AddItem("SetButtonText");	        vctMenuID.push_back(14);
		//uiMenu.AddItem("测试极限值");	            vctMenuID.push_back(15);
		uiMenu.AddItem("Show");						vctMenuID.push_back(16);
		uiMenu.AddItem("SetTipsTitleOnTop");		vctMenuID.push_back(17);
		uiMenu.AddItem("SetTipsTitleOnBottom");		vctMenuID.push_back(18);

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
					ArtiActiveTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_AddItem();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_GetUpdateItems();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetValue();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetItem();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetUnit();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetOperationTipsOnTop();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetOperationTipsOnBottom();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetHeads();
				}
				else if (9 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetLockFirstRow();
				}
				else if (10 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_AddButton();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_AddButtonEx();
				}
				else if (12 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_DelButton();
				}
				else if (13 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetButtonStatus();
				}
				else if (14 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetButtonText();
				}
				else if (15 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_MaxTest();
				}
				else if (16 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_Show();
				}
				else if (17 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetTipsTitleOnTop();
				}
				else if (18 == vctMenuID[uRetBtn])
				{
					ArtiActiveTest_SetTipsTitleOnBottom();
				}
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
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
				strTitle = artiGetText("FF0000000006");
			}	
			else if (2 == uRetBtn)
			{
				strTitle = artiGetText("FF0000000046");
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
			CArtiActive uiActive(m_uThread);
#else
			CArtiActive uiActive;
#endif
			uiActive.InitTitle(strTitle);
			uiActive.AddItem(artiGetText("FF0100000003"), artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));
			uiActive.AddItem(artiGetText("FF0100000006"), artiGetText("FF0100000007"), false, artiGetText("FF0100000008"));

			while (1)
			{
				uRetBtn = uiActive.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_AddItem()
	{
		vector<uint32_t> vctBtnID;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0100000009"));       vctBtnID.push_back(0);//名称、值和单位为空文本
		uiMenu.AddItem(artiGetText("FF010000000A"));       vctBtnID.push_back(1);//名称、值和单位为单行短文本
		uiMenu.AddItem(artiGetText("FF010000003F"));       vctBtnID.push_back(2);//名称、值和单位为单行长文本
		uiMenu.AddItem(artiGetText("FF010000000B"));       vctBtnID.push_back(3);//名称、值和单位为多行文本
		uiMenu.AddItem(artiGetText("FF010000000C"));       vctBtnID.push_back(4);//"奇行刷新，偶行不刷新"
		uiMenu.AddItem(artiGetText("FF0100000040"));       vctBtnID.push_back(5);//名称、值和单位英文长度达到阈值
		uiMenu.AddItem(artiGetText("FF0100000041"));       vctBtnID.push_back(6);//名称、值和单位中文长度达到阈值
		uiMenu.AddItem(artiGetText("FF0100000042"));       vctBtnID.push_back(7);//行数达到阈值

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
				CArtiActive uiActive(m_uThread);
#else
				CArtiActive uiActive;
#endif
				uiActive.InitTitle(artiGetText("FF0100000000"));

				if (0 == vctBtnID[uRetBtn])
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						uiActive.AddItem("", "", false, "");
					}
				}
				else if (1 == vctBtnID[uRetBtn])
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
						uiActive.AddItem(buff, artiGetText("FF010000000E"), false, artiGetText("FF010000000F"));
					}
				}
				else if (2 == vctBtnID[uRetBtn])
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						uiActive.AddItem(artiGetText("FF120000000A"), artiGetText("FF120000000A"), false, artiGetText("FF120000000A"));
					}
				}
				else if (3 == vctBtnID[uRetBtn])
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						uiActive.AddItem(TextMulitLineTitle, TextMulitLineValue, false, TextMulitLineUnit);
					}
				}
				else if (4 == vctBtnID[uRetBtn])
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
						if (i % 2 == 0)
						{
							uiActive.AddItem(buff, artiGetText("FF010000000E"), true, artiGetText("FF010000000F"));
						}
						else
						{
							uiActive.AddItem(buff, artiGetText("FF010000000E"), false, artiGetText("FF010000000F"));
						}
					}
				}
				else if (5 == vctBtnID[uRetBtn])//列值达到阈值4000(英文半角字符长度4000)
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						threshold = "";
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
						threshold += buff;
						threshold += ":";
						threshold.append(artiGetText("FF1100000005"));
						uiActive.AddItem(threshold, artiGetText("FF1100000005"), false, artiGetText("FF1100000005"));
					}
				}
				else if (6 == vctBtnID[uRetBtn])//列值达到阈值4000(中文全角字符长度2000)
				{
					for (uint32_t i = 0; i < 10; i++)
					{
						threshold = "";
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
						threshold += buff;
						threshold += ":";
						threshold.append(artiGetText("FF1200000005"));
						uiActive.AddItem(threshold, artiGetText("FF1200000005"), false, artiGetText("FF1200000005"));
					}
				}
				else if (7 == vctBtnID[uRetBtn])//行数达到阈值10000
				{
					for (uint32_t i = 0; i < 10000; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
						uiActive.AddItem(buff, artiGetText("FF010000000E"), false, artiGetText("FF010000000F"));
					}
				}

				while (1)
				{
					uRetBtn = uiActive.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
				}
			}
		}
	}

	//void ArtiActiveTest::ArtiActiveTest_GetUpdateItems()
	//{
	//	uint32_t uCnt = 20;
	//	string strItem = "";
	//	CArtiActive uiActive(m_uThread);
	//	uiActive.InitTitle(artiGetText("FF0100000000"));
	//	for (uint32_t i = 0; i < uCnt; i++)
	//	{
	//		memset(buff, 0, sizeof(buff));
	//		SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
	//		uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
	//	}
	//	uiActive.AddButtonEx(artiGetText("FF000000000A"));
	//
	//	while (1)
	//	{
	//		uRetBtn = uiActive.Show();
	//		if (uRetBtn == DF_ID_CANCEL)
	//		{
	//			break;
	//		}
	//		else if (uRetBtn == DF_ID_FREEBTN_0)
	//		{
	//			strItem = "";
	//			vector<uint16_t> vctItems;
	//			vctItems = uiActive.GetUpdateItems();
	//			for (uint32_t i = 0; i < vctItems.size(); i++)
	//			{
	//				memset(buff, 0, sizeof(buff));
	//				SPRINTF_S(buff, "%d\n", vctItems[i]);
	//				strItem = strItem + buff;
	//			}
	//			artiShowMsgBoxEx(artiGetText("FF0100000010"), strItem, DF_MB_OK, DT_LEFT);
	//		}
	//	}
	//}

	void CArtiActiveTest::ArtiActiveTest_GetUpdateItems()
	{
		uint32_t uCnt = 20;
		string strItem = "";
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));

		memset(buff, 0, sizeof(buff));
		SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), 0);
		uiActive.AddItem(buff, artiGetText("FF0100000004"), true, artiGetText("FF0100000005"));

		for (uint32_t i = 1; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF000000000A"));

		uCnt = 0;
		while (1)
		{
			uRetBtn = uiActive.Show();
			Delay(100);
			if (uRetBtn == DF_ID_CANCEL)//后退
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)//确定
			{
				strItem = "";
				vector<uint16_t> vctItems;
				vctItems = uiActive.GetUpdateItems();
				for (uint32_t i = 0; i < vctItems.size(); i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, "%d\n", vctItems[i]);
					strItem = strItem + buff;
				}
				ShowMsgBoxDemo(artiGetText("FF0100000010"), strItem, DF_MB_OK, DT_LEFT, -1, m_uThread);
			}

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, "TestValue_%d", uCnt++);
			uiActive.SetValue(0, buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, "TestUnit_%d", uCnt++);
			uiActive.SetUnit(0, buff);
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetValue()
	{
		uint32_t uCnt = 5;
		string strItem = "";
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));//FF0100000000	"动作测试"
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), false/*i % 2*/, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF0100000011"));

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu(m_uThread);
#else
				CArtiMenu uiMenu;
#endif
				uiMenu.InitTitle(artiGetText("FF0100000012"));
				uiMenu.AddItem(artiGetText("FF010000002C"));//"动作测试项值为空文本"
				uiMenu.AddItem(artiGetText("FF010000002D"));//"动作测试项值为单行短文本"				
				uiMenu.AddItem(artiGetText("FF010000002E"));//"动作测试项值为多行文本"
				uiMenu.AddItem(artiGetText("FF010000002F"));//"动作测试项值英文长度达到阈值"
				uiMenu.AddItem(artiGetText("FF0100000030"));//"动作测试项值中文长度达到阈值"
				uiMenu.AddItem(artiGetText("FF010000003B"));//"动作测试项值为单行长文本"

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiMenu.Show();
					if (0 == uRetBtn1)
					{
						strItem = "";
					}
					else if (1 == uRetBtn1)
					{
						strItem = TextSingleLine;
					}
					else if (2 == uRetBtn1)
					{
						strItem = TextMulitLineValue;
					}
					else if (3 == uRetBtn1)
					{
						strItem = artiGetText("FF1100000005");
					}
					else if (4 == uRetBtn1)
					{
						strItem = artiGetText("FF1200000005");
					}
					else if (5 == uRetBtn1)
					{
						strItem = artiGetText("FF120000000A");
					}
					break;
				}

				uiActive.SetValue(3, strItem);

			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetItem()
	{
		uint32_t uCnt = 5;
		string strItem = "";
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF0100000013"));

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu(m_uThread);
#else
				CArtiMenu uiMenu;
#endif
				uiMenu.InitTitle(artiGetText("FF0100000014"));
				uiMenu.AddItem(artiGetText("FF0100000031"));//"动作测试项名称为空文本"
				uiMenu.AddItem(artiGetText("FF0100000032"));//"动作测试项名称为单行短文本"
				uiMenu.AddItem(artiGetText("FF0100000033"));//"动作测试项名称为多行文本"
				uiMenu.AddItem(artiGetText("FF0100000034"));//"动作测试项名称英文长度达到阈值"
				uiMenu.AddItem(artiGetText("FF0100000035"));//"动作测试项名称中文长度达到阈值"
				uiMenu.AddItem(artiGetText("FF010000003C"));//"动作测试项名称为单行长文本"

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiMenu.Show();
					if (0 == uRetBtn1)
					{
						strItem = "";
					}
					else if (1 == uRetBtn1)
					{
						strItem = TextSingleLine;
					}
					else if (2 == uRetBtn1)
					{
						strItem = TextMulitLineTitle;
					}
					else if (3 == uRetBtn1)
					{
						strItem = artiGetText("FF1100000005");
					}
					else if (4 == uRetBtn1)
					{
						strItem = artiGetText("FF1200000005");
					}
					else if (5 == uRetBtn1)
					{
						strItem = artiGetText("FF120000000A");
					}
					break;
				}

				uiActive.SetItem(3, strItem);
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetUnit()
	{
		uint32_t uCnt = 5;
		string strItem = "";
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF0100000017"));

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu(m_uThread);
#else
				CArtiMenu uiMenu;
#endif
				uiMenu.InitTitle(artiGetText("FF0100000018"));
				uiMenu.AddItem(artiGetText("FF0100000036"));//动作测试项单位为空文本
				uiMenu.AddItem(artiGetText("FF0100000037"));//动作测试项单位为单行短文本
				uiMenu.AddItem(artiGetText("FF0100000038"));//动作测试项单位为多行文本
				uiMenu.AddItem(artiGetText("FF0100000039"));//动作测试项单位英文长度达到阈值
				uiMenu.AddItem(artiGetText("FF010000003A"));//动作测试项单位中文长度达到阈值
				uiMenu.AddItem(artiGetText("FF010000003D"));//动作测试项单位为单行长文本

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiMenu.Show();
					if (0 == uRetBtn1)
					{
						strItem = "";
					}
					else if (1 == uRetBtn1)
					{
						strItem = TextSingleLine;
					}
					else if (2 == uRetBtn1)
					{
						strItem = TextMulitLineUnit;
					}
					else if (3 == uRetBtn1)
					{
						strItem = artiGetText("FF1100000005");
					}
					else if (4 == uRetBtn1)
					{
						strItem = artiGetText("FF1200000005");
					}
					else if (5 == uRetBtn1)
					{
						strItem = artiGetText("FF120000000A");
					}
					break;
				}

				uiActive.SetUnit(3, strItem);
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetOperationTipsOnTop()
	{
		uint32_t uCnt = 5;
		string strItem = "";
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF0100000019"));

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu(m_uThread);
#else
				CArtiMenu uiMenu;
#endif
				uiMenu.InitTitle(artiGetText("FF010000001A"));
				uiMenu.AddItem(artiGetText("FF0100000046"));//操作提示为空文本
				uiMenu.AddItem(artiGetText("FF0100000047"));//操作提示为单行短文本
				uiMenu.AddItem(artiGetText("FF0100000048"));//操作提示为多行文本
				uiMenu.AddItem(artiGetText("FF0100000049"));//操作提示英文长度达到阈值
				uiMenu.AddItem(artiGetText("FF010000004A"));//操作提示中文长度达到阈值
				uiMenu.AddItem(artiGetText("FF010000003E"));//操作提示为单行长文本

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiMenu.Show();
					if (0 == uRetBtn1)
					{
						strItem = "";
					}
					else if (1 == uRetBtn1)
					{
						strItem = TextSingleLine;
					}
					else if (2 == uRetBtn1)
					{
						strItem = TextMulitLineHelp;
					}
					else if (3 == uRetBtn1)
					{
						strItem = artiGetText("FF1100000005");
					}
					else if (4 == uRetBtn1)
					{
						strItem = artiGetText("FF1200000005");
					}
					else if (5 == uRetBtn1)
					{
						strItem = artiGetText("FF120000000A");
					}
					break;
				}

				uiActive.SetOperationTipsOnTop(strItem);
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetOperationTipsOnBottom()
	{
		uint32_t uCnt = 5;
		string strItem = "";
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF010000001D"));

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu(m_uThread);
#else
				CArtiMenu uiMenu;
#endif
				uiMenu.InitTitle(artiGetText("FF010000001E"));
				uiMenu.AddItem(artiGetText("FF0100000046"));//操作提示为空
				uiMenu.AddItem(artiGetText("FF0100000047"));//操作提示为单行短文本
				uiMenu.AddItem(artiGetText("FF0100000048"));//操作提示为多行文本
				uiMenu.AddItem(artiGetText("FF0100000049"));//操作提示英文长度达到阈值
				uiMenu.AddItem(artiGetText("FF010000004A"));//操作提示中文长度达到阈值
				uiMenu.AddItem(artiGetText("FF010000003E"));//操作提示为单行长文本

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiMenu.Show();
					if (0 == uRetBtn1)
					{
						strItem = "";
					}
					else if (1 == uRetBtn1)
					{
						strItem = TextSingleLine;
					}
					else if (2 == uRetBtn1)
					{
						strItem = TextMulitLineHelp;
					}
					else if (3 == uRetBtn1)
					{
						strItem = artiGetText("FF1100000005");
					}
					else if (4 == uRetBtn1)
					{
						strItem = artiGetText("FF1200000005");
					}
					else if (5 == uRetBtn1)
					{
						strItem = artiGetText("FF120000000A");
					}
					break;
				}

				uiActive.SetOperationTipsOnBottom(strItem);
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetHeads()
	{
		uint32_t uCnt = 0;
		uint32_t uMaxItem = 10;
		uint32_t uRetBtn1 = DF_ID_NOKEY;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF010000004B"));	//"设置列表头"
		uiMenu.AddItem(artiGetText("FF00000000D0"));	//"重复调用2次"

		string strHeadNames = "";
		vector<string> vctItems;
		vector<string> vctHeadNames;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
#if __Multi_System_Test__
				CArtiActive uiActive(m_uThread);
#else
				CArtiActive uiActive;
#endif
				uCnt = 0;
				while (1)
				{
					vctHeadNames.clear();
					
					if (uCnt % 6 == 0)
					{
						vctHeadNames.push_back("");
						vctHeadNames.push_back("");
						vctHeadNames.push_back("");
					}
					else if (uCnt % 6 == 1)
					{
						vctHeadNames.push_back(TextSingleLine);
						vctHeadNames.push_back(TextSingleLine);
						vctHeadNames.push_back(TextSingleLine);
					}
					else if (uCnt % 6 == 2)
					{
						vctHeadNames.push_back(artiGetText("FF120000000A"));
						vctHeadNames.push_back(artiGetText("FF120000000A"));
						vctHeadNames.push_back(artiGetText("FF120000000A"));
					}
					else if (uCnt % 6 == 3)
					{
						vctHeadNames.push_back(artiGetText("FF1200000009"));
						vctHeadNames.push_back(artiGetText("FF1200000009"));
						vctHeadNames.push_back(artiGetText("FF1200000009"));
					}
					else if (uCnt % 6 == 4)
					{
						vctHeadNames.push_back(artiGetText("FF1100000005"));
						vctHeadNames.push_back(artiGetText("FF1100000005"));
						vctHeadNames.push_back(artiGetText("FF1100000005"));
					}
					else if (uCnt % 6 == 5)
					{
						vctHeadNames.push_back(artiGetText("FF1200000005"));
						vctHeadNames.push_back(artiGetText("FF1200000005"));
						vctHeadNames.push_back(artiGetText("FF1200000005"));
					}

					uiActive.InitTitle(artiGetText("FF0100000000"));//动作测试
					uiActive.SetHeads(vctHeadNames);
					for (uint32_t i = 0; i < uMaxItem; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);//"第%d项"
						uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));//"Value"//"Unit"
					}
					uiActive.AddButtonEx(artiGetText("FF000000000A"));//确定
					uiActive.SetOperationTipsOnTop(artiGetText("FF010000004C"));//点击[确定]按钮切换列表头各列值文本长度

					while (1)
					{
						uRetBtn1 = uiActive.Show();
						if (DF_ID_CANCEL == uRetBtn1)
						{
							break;
						}
						else if (DF_ID_FREEBTN_0 == uRetBtn1)
						{
							uCnt++;
							break;
						}
					}
					if (DF_ID_CANCEL == uRetBtn1)
					{
						break;
					}
				}
			}
			else
			{
				vctHeadNames.clear();
				vctHeadNames.push_back(artiGetText("FF00000000B9"));//第1列
				vctHeadNames.push_back(artiGetText("FF00000000BA"));//第2列
				vctHeadNames.push_back(artiGetText("FF00000000BB"));//第3列

#if __Multi_System_Test__
				CArtiActive uiActive(m_uThread);
#else
				CArtiActive uiActive;
#endif
				uiActive.InitTitle(artiGetText("FF0100000000"));//动作测试

				uiActive.SetHeads(vctHeadNames);
				uiActive.SetHeads(vctHeadNames);

				for (uint32_t i = 0; i < uMaxItem; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);//"第%d项"
					uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));//"Value"//"Unit"
				}

				while (1)
				{
					uRetBtn1 = uiActive.Show();
					if (uRetBtn1 == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetLockFirstRow()
	{
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));	//"动作测试"
		vector<string> vctHeadNames;

		for (uint32_t i = 0; i < 50; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF00000000B8"));//锁定首行

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
				uiActive.SetLockFirstRow();
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_AddButtonEx()
	{
		string strButton = "";
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF130000000D"));	//"增加按钮数量达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000007"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF1300000008"));	//"按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF130000000A"));	//"按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF130000000B"));	//"英文按钮文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000C"));	//"中文按钮文本长度达到阈值"	
		while (1)
		{		
#if __Multi_System_Test__
			CArtiActive uiActive(m_uThread);
#else
			CArtiActive uiActive;
#endif
			uiActive.InitTitle(artiGetText("FF0100000000"));
			uiActive.AddButton(artiGetText("FF130000000E"));//增加

			for (uint32_t i = 0; i < 10; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
				uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));
			}

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (1 == uRetBtn)
			{
				strButton = "";
			}
			else if (2 == uRetBtn)
			{
				strButton = TextSingleLine;
			}
			else if (3 == uRetBtn)
			{
				strButton = artiGetText("FF1200000009");
			}
			else if (4 == uRetBtn)
			{
				strButton = artiGetText("FF1100000002");
			}
			else if (5 == uRetBtn)
			{
				strButton = artiGetText("FF1200000002");
			}

			if (0 == uRetBtn)
			{
				uint32_t uBtnRet = 0;
				string strBtnID = "";
				string strBtnText = "";					

				while (1)
				{
					uRetBtn = uiActive.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}	
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{		
						for (uint32_t i = 1; i < 32; i++)
						{
							strBtnText = "";

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, "%d", i);
							strBtnText = artiGetText("FF000000000C") + buff;//"测试键%d"

							uBtnRet = uiActive.AddButtonEx(strBtnText);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, "%d", uBtnRet - DF_ID_FREEBTN_0);
							strBtnID += strBtnText + artiGetText("FF0000000027") + "DF_ID_FREEBTN_" + buff + "\n";
						}
						ShowMsgBoxDemo(artiGetText("FF0000000026"), strBtnID, DF_MB_OK, DT_LEFT, -1, m_uThread); //新增按键ID：*****
					}
				}
			}
			else
			{
				while (1)
				{					
					uRetBtn = uiActive.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						uint32_t uRetButton = uiActive.AddButtonEx(strButton);
						ShowMsgBoxDemo(artiGetText("FF0000000026"), artiGetText("FF1300000009") + ":" + to_string(uRetButton), DF_MB_OK, DT_LEFT, -1, m_uThread); //新增按键ID：*****
					}				
				}
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_DelButton()
	{
		uint32_t uCnt = 10;
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));//"动作测试"
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));
		}

		uiActive.AddButtonEx(artiGetText("FF060000002F"));//"删除按键"

		vector<uint32_t> vctBtnID;
		uiActive.AddButtonEx(artiGetText("FF090000001A"));//"测试键1"
		uiActive.AddButtonEx(artiGetText("FF090000001B"));//"测试键2"
		uiActive.AddButtonEx(artiGetText("FF090000001C"));//"测试键3"

		vctBtnID.push_back(DF_ID_FREEBTN_1);
		vctBtnID.push_back(DF_ID_FREEBTN_2);
		vctBtnID.push_back(DF_ID_FREEBTN_3);

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
				if (vctBtnID.size())
				{
					uiActive.DelButton(vctBtnID[vctBtnID.size() - 1]);
					vctBtnID.pop_back();
				}
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_AddButton()
	{
		string strButton = "";
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF130000000D"));	//"增加按钮数量达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000007"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF1300000008"));	//"按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF130000000A"));	//"按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF130000000B"));	//"英文按钮文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000C"));	//"中文按钮文本长度达到阈值"	

		while (1)
		{			
#if __Multi_System_Test__
			CArtiActive uiActive(m_uThread);
#else
			CArtiActive uiActive;
#endif
			uiActive.InitTitle(artiGetText("FF0100000000"));
			uiActive.AddButton(artiGetText("FF130000000E"));//增加

			for (uint32_t i = 0; i < 10; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
				uiActive.AddItem(buff, artiGetText("FF0100000004"), false, artiGetText("FF0100000005"));
			}

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (1 == uRetBtn)
			{
				strButton = "";
			}
			else if (2 == uRetBtn)
			{
				strButton = TextSingleLine;
			}
			else if (3 == uRetBtn)
			{
				strButton = artiGetText("FF1200000009");
			}
			else if (4 == uRetBtn)
			{
				strButton = artiGetText("FF1100000002");
			}
			else if (5 == uRetBtn)
			{
				strButton = artiGetText("FF1200000002");
			}

			if (0 == uRetBtn)
			{						
				string strBtnText = "";

				while (1)
				{
					uRetBtn = uiActive.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						for (uint32_t i = 1; i < 32; i++)
						{
							strBtnText = "";

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, "%d", i);
							strBtnText = artiGetText("FF000000000C") + buff;//"测试键%d"

							 uiActive.AddButton(strBtnText);																	
						}					
					}
				}
			}
			else
			{
				while (1)
				{					
					uRetBtn = uiActive.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						uiActive.AddButton(strButton);						
					}
				}
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetButtonStatus()
	{
		uint32_t uCnt = 5;
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF0100000022"));//切换按键状态
		uiActive.AddButtonEx(artiGetText("FF0100000023"));//测试按键

		uCnt = 0;
		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
				uCnt++;
				uint32_t uStatus = 0;
				if (0 == uCnt % 3)
				{
					uStatus = DF_ST_BTN_ENABLE;
				}
				else if (1 == uCnt % 3)
				{
					uStatus = DF_ST_BTN_DISABLE;
				}
				else
				{
					uStatus = DF_ST_BTN_UNVISIBLE;
				}

				uiActive.SetButtonStatus(1, uStatus);
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetButtonText()
	{
		uint32_t uCnt = 5;
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		uiActive.AddButtonEx(artiGetText("FF0100000024"));
		uiActive.AddButtonEx(artiGetText("FF0100000023"));

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
				if (uCnt % 5 == 0)
				{
					uiActive.SetButtonText(1, "");
				}
				else if (uCnt % 5 == 1)
				{
					uiActive.SetButtonText(1, TextSingleLine);
				}
				else if (uCnt % 5 == 2)
				{
					uiActive.SetButtonText(1, artiGetText("FF1200000009"));
				}
				else if (uCnt % 5 == 3)
				{
					uiActive.SetButtonText(1, artiGetText("FF1100000002"));//英文全角字符长度200
				}
				else if (uCnt % 5 == 4)
				{
					uiActive.SetButtonText(1, artiGetText("FF1200000002"));//中文全角字符长度100
				}				
				uCnt++;
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_MaxTest()
	{
		ShowMsgBoxDemo(artiGetText("FF0100000025"), artiGetText("FF0100000026"), DF_MB_OK, DT_LEFT, -1, m_uThread);

#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif
		uiActive.InitTitle(artiGetText("FF0100000000"));
		for (uint32_t i = 0; i < 500; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF010000000D").c_str(), i);
			uiActive.AddItem(buff, artiGetText("FF0100000004"), i % 2, artiGetText("FF0100000005"));
		}
		for (uint32_t i = 0; i < 20; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF000000000F").c_str(), i);
			uiActive.AddButtonEx(buff);
		}

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_Show()
	{
		CArtiMenu uiMenu;
		uiMenu.InitTitle("Show");
		uiMenu.AddItem(artiGetText("FF0000000110"));//"按键响应时间测试"
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
				ArtiActiveTest_Show_Type1();
			}
			else if (1 == uRetBtn)
			{
				ArtiActiveTest_Show_Type2();
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_Show_Type1()
	{
		CArtiActive uiActive;
		uiActive.InitTitle(artiGetText("FF0000000110"));				//"按键响应时间测试"
		uiActive.AddItem(artiGetText("FF0000000112"), "0", false, "ms");//"响应时间"
		uiActive.AddButtonEx("Test");

		while (1)
		{
			time_t time_start = GetSysTime();
			uRetBtn = uiActive.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				break;
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				time_t time_end = GetSysTime();
				uiActive.SetValue(0, uint32ToString(time_end - time_start));
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_Show_Type2()
	{
		CArtiActive uiActive1;
		uiActive1.InitTitle(artiGetText("FF0000000111"));//"连续点击按键测试"
		uiActive1.AddItem("Sleep Time", "0", false, "s");
		uiActive1.AddButtonEx("Sleep 0 s");
		uiActive1.AddButtonEx("Sleep 2 s");
		uiActive1.AddButtonEx("Sleep 4 s");
		uiActive1.AddButtonEx("Sleep 6 s");
		uiActive1.AddButtonEx("Sleep 8 s");

		while (1)
		{
			uRetBtn = uiActive1.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				return;
			}
			else if ((uRetBtn >= DF_ID_FREEBTN_0) && (uRetBtn <= DF_ID_FREEBTN_0 + 4))
			{
				uiActive1.SetValue(0, uint32ToString((uRetBtn - DF_ID_FREEBTN_0) * 2));
				Delay((uRetBtn - DF_ID_FREEBTN_0) * 2000);
			}
		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetTipsTitleOnTop()
	{
		CArtiActive uiActive;
		CArtiMenu	uiMenu;
		string		strTop = "Test top 11111111122222222222344456666666666";

		uiMenu.InitTitle("SetTipsTitleOnTop");
		uiMenu.AddItem("uAlignType--DT_CENTER");
		uiMenu.AddItem("uAlignType--DT_LEFT");
		uiMenu.AddItem("eSize--FORT_SIZE_SMALL");
		uiMenu.AddItem("eSize--FORT_SIZE_MEDIUM");
		uiMenu.AddItem("eSize--FORT_SIZE_LARGE");
		uiMenu.AddItem("eBold--BOLD_TYPE_NONE");
		uiMenu.AddItem("eBold--BOLD_TYPE_BOLD");

		uiActive.InitTitle("SetTipsTitleOnTop");
		uiActive.AddItem("Test1", "Test1");
		uiActive.AddItem("Test2", "Test2");
		uiActive.AddItem("Test3", "Test3");
		uiActive.AddItem("Test4", "Test4");
		uiActive.AddItem("Test5", "Test5");

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			switch (uRetBtn & 0xff)
			{
			case 0:
				uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_SMALL, BOLD_TYPE_NONE);
				break;
			case 1:
				uiActive.SetTipsTitleOnTop(strTop, DT_LEFT, FORT_SIZE_LARGE, BOLD_TYPE_BOLD);
				break;
			case 2:
				uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				break;
			case 3:
				uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_LARGE, BOLD_TYPE_BOLD);
				break;
			case 4:
				uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_MEDIUM, BOLD_TYPE_BOLD);
				break;
			case 5:
				uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_MEDIUM, BOLD_TYPE_NONE);
				break;
			case 6:
				uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_MEDIUM, BOLD_TYPE_BOLD);
				break;
			default:
				break;
			}
			while (1)
			{
				uRetBtn = uiActive.Show();
				if (DF_ID_CANCEL == uRetBtn)
				{
					break;
				}
			}

		}
	}

	void CArtiActiveTest::ArtiActiveTest_SetTipsTitleOnBottom()
	{
		CArtiActive uiActive;
		CArtiMenu	uiMenu;
		string		strTop = "Test top 11111111122222222222344456666666666";

		uiMenu.InitTitle("SetTipsTitleOnBottom");
		uiMenu.AddItem("uAlignType--DT_CENTER");
		uiMenu.AddItem("uAlignType--DT_LEFT");
		uiMenu.AddItem("eSize--FORT_SIZE_SMALL");
		uiMenu.AddItem("eSize--FORT_SIZE_MEDIUM");
		uiMenu.AddItem("eSize--FORT_SIZE_LARGE");
		uiMenu.AddItem("eBold--BOLD_TYPE_NONE");
		uiMenu.AddItem("eBold--BOLD_TYPE_BOLD");

		uiActive.InitTitle("SetTipsTitleOnBottom");
		uiActive.AddItem("Test1", "Test1");
		uiActive.AddItem("Test2", "Test2");
		uiActive.AddItem("Test3", "Test3");
		uiActive.AddItem("Test4", "Test4");
		uiActive.AddItem("Test5", "Test5");

		//uiActive.SetTipsTitleOnTop(strTop, DT_CENTER, FORT_SIZE_SMALL, BOLD_TYPE_NONE);
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			switch (uRetBtn & 0xff)
			{
			case 0:
				uiActive.SetTipsTitleOnBottom(strTop, DT_CENTER, FORT_SIZE_SMALL, BOLD_TYPE_NONE);
				break;
			case 1:
				uiActive.SetTipsTitleOnBottom(strTop, DT_LEFT, FORT_SIZE_LARGE, BOLD_TYPE_BOLD);
				break;
			case 2:
				uiActive.SetTipsTitleOnBottom(strTop, DT_CENTER, FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				break;
			case 3:
				uiActive.SetTipsTitleOnBottom(strTop, DT_CENTER, FORT_SIZE_LARGE, BOLD_TYPE_BOLD);
				break;
			case 4:
				uiActive.SetTipsTitleOnBottom(strTop, DT_CENTER, FORT_SIZE_MEDIUM, BOLD_TYPE_BOLD);
				break;
			case 5:
				uiActive.SetTipsTitleOnBottom(strTop, DT_CENTER, FORT_SIZE_MEDIUM, BOLD_TYPE_NONE);
				break;
			case 6:
				uiActive.SetTipsTitleOnBottom(strTop, DT_CENTER, FORT_SIZE_MEDIUM, BOLD_TYPE_BOLD);
				break;
			default:
				break;
			}
			while (1)
			{
				uRetBtn = uiActive.Show();
				if (DF_ID_CANCEL == uRetBtn)
				{
					break;
				}
			}

		}
	}

}