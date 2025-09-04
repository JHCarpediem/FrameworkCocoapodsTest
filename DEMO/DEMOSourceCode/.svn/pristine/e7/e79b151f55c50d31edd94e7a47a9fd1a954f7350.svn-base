#include "DemoArtiListTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"
#include "DemoAPITest.h"

namespace Topdon_AD900_Demo {

	void CArtiListTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");						vctMenuID.push_back(0);
		uiMenu.AddItem("InitTitle1");						vctMenuID.push_back(1);
		uiMenu.AddItem("SetColWidth");						vctMenuID.push_back(2);
		uiMenu.AddItem("SetHeads");							vctMenuID.push_back(3);
		uiMenu.AddItem("SetBlockStatus");					vctMenuID.push_back(4);
		uiMenu.AddItem("AddButton");						vctMenuID.push_back(5);
		uiMenu.AddItem("AddGroup");							vctMenuID.push_back(6);
		uiMenu.AddItem("AddItem");							vctMenuID.push_back(7);
		uiMenu.AddItem("AddItem1");							vctMenuID.push_back(8);
		uiMenu.AddItem("SetItem");							vctMenuID.push_back(9);
		uiMenu.AddItem("SetRowHighLight");					vctMenuID.push_back(10);
		uiMenu.AddItem("SetDefaultSelectedRow");			vctMenuID.push_back(11);
		uiMenu.AddItem("SetCheckBoxStatus");				vctMenuID.push_back(12);
		uiMenu.AddItem("SetButtonStatus");					vctMenuID.push_back(13);
		uiMenu.AddItem("SetButtonText");					vctMenuID.push_back(14);
		uiMenu.AddItem("GetSelectedRow");					vctMenuID.push_back(15);
		uiMenu.AddItem("GetSelectedRowEx");					vctMenuID.push_back(16);
		uiMenu.AddItem("AddButtonEx");						vctMenuID.push_back(17);
		uiMenu.AddItem("DelButton");						vctMenuID.push_back(18);
		uiMenu.AddItem("SetItemPicture");					vctMenuID.push_back(19);
		uiMenu.AddItem("SetLockFirstRow");					vctMenuID.push_back(20);
		uiMenu.AddItem("SetTipsOnTop");						vctMenuID.push_back(21);
		uiMenu.AddItem("SetTipsTitleOnTop");				vctMenuID.push_back(24);
		uiMenu.AddItem("SetTipsOnBottom");					vctMenuID.push_back(22);
		uiMenu.AddItem("Show");								vctMenuID.push_back(23);
		uiMenu.AddItem("SetTipsTitleOnLeft");				vctMenuID.push_back(25);
		uiMenu.AddItem("SetSelectedType");					vctMenuID.push_back(26);
		uiMenu.AddItem("SetRowInCurrentScreen");			vctMenuID.push_back(27);
		uiMenu.AddItem("SetShareButtonVisible");			vctMenuID.push_back(28);
		uiMenu.AddItem("SetTipsOnTopType");					vctMenuID.push_back(29);
		uiMenu.AddItem("AddTipsOnLeft");					vctMenuID.push_back(30);
		uiMenu.AddItem("SetLeftLayoutPicture");				vctMenuID.push_back(31);

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
					ArtiListTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiListTest_InitTitle1();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetColWidth();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetHeads();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetBlockStatus();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiListTest_AddButton();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiListTest_AddGroup();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiListTest_AddItem();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiListTest_AddItem1();
				}
				else if (9 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetItem();
				}
				else if (10 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetRowHighLight();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetDefaultSelectedRow();
				}
				else if (12 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetCheckBoxStatus();
				}
				else if (13 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetButtonStatus();
				}
				else if (14 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetButtonText();
				}
				else if (15 == vctMenuID[uRetBtn])
				{
					ArtiListTest_GetSelectedRow();
				}
				else if (16 == vctMenuID[uRetBtn])
				{
					ArtiListTest_GetSelectedRowEx();
				}
				else if (17 == vctMenuID[uRetBtn])
				{
					ArtiListTest_AddButtonEx();
				}
				else if (18 == vctMenuID[uRetBtn])
				{
					ArtiListTest_DelButton();
				}
				else if (19 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetItemPicture();
				}
				else if (20 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetLockFirstRow();
				}
				else if (21 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetTipsOnTop();
				}
				else if (22 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetTipsOnBottom();
				}
				else if (23 == vctMenuID[uRetBtn])
				{
					ArtiListTest_Show();
				}
				else if (24 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetTipsTitleOnTop();
				}
				else if (25 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetTipsTitleOnLeft();
				}
				else if (26 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetSelectedType();
				}
				else if (27 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetRowInCurrentScreen();
				}
				else if (28 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetShareButtonVisible();
				}
				else if (29 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetTipsOnTopType();
				}
				else if (30 == vctMenuID[uRetBtn])
				{
					ArtiListTest_AddTipsOnLeft();
				}
				else if (31 == vctMenuID[uRetBtn])
				{
					ArtiListTest_SetLeftLayoutPicture();
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_InitTitle()
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
				strTitle = TextSingleLine;
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

			vector<int32_t> vctColWidth;
			vctColWidth.push_back(50);
			vctColWidth.push_back(50);

			vector<string> vctItems;
			vctItems.push_back(artiGetText("FF0600000001"));//"01 - 列表测试项名"
			vctItems.push_back(artiGetText("FF0600000002"));//"01 - 列表测试项值"

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(strTitle);
			uiList.SetColWidth(vctColWidth);

			uiList.AddItem(vctItems, false);
			//uiList.AddItem(vctItems, true);

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_InitTitle1()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0600000003") + "-" + artiGetText("FF1300000001"));//"每行前面没有复选框"			"标题文本为空"
		uiMenu.AddItem(artiGetText("FF0600000004") + "-" + artiGetText("FF1300000002"));//"每行前面有互斥复选框"		"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF0600000005") + "-" + artiGetText("FF1300000003"));//"每行前面有多选复选框"		"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF0600000005") + "-" + artiGetText("FF1300000004"));//"每行前面有多选复选框"		"标题英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000005") + "-" + artiGetText("FF1300000005"));//"每行前面有多选复选框"		"标题中文长度达到阈值"

		CArtiList::eListViewType uType = CArtiList::eListViewType::ITEM_NO_CHECKBOX;
		string listTitle = "";

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				uType = CArtiList::eListViewType::ITEM_NO_CHECKBOX;
				listTitle = "";
			}
			else if (1 == uRetBtn)
			{
				uType = CArtiList::eListViewType::ITEM_WITH_CHECKBOX_SINGLE;
				listTitle = artiGetText("FF0600000000");

			}
			else if (2 == uRetBtn)
			{
				uType = CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI;
				listTitle = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				uType = CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI;
				listTitle = artiGetText("FF1100000004");;
			}
			else
			{
				uType = CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI;
				listTitle = artiGetText("FF1200000004");;
			}

			vector<int32_t> vctColWidth;
			vctColWidth.push_back(50);
			vctColWidth.push_back(50);

			vector<string> vctItems;

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(listTitle, uType);//"列表控件测试"
			uiList.SetColWidth(vctColWidth);

			for (uint32_t i = 0; i < 5; i++)
			{
				vctItems.clear();

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"%d - 列表测试项名"
				vctItems.push_back(buff + artiGetText("FF0600000006"));

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"0%d - 列表测试项值"
				vctItems.push_back(buff + artiGetText("FF0600000007"));

				uiList.AddItem(vctItems);
			}

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetColWidth()
	{
		vector<uint32_t> vctColNum;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0600000008"));	vctColNum.push_back(0);    //"设置列表0列"
		uiMenu.AddItem(artiGetText("FF0600000009"));    vctColNum.push_back(1);	   //"设置列表1列"
		uiMenu.AddItem(artiGetText("FF060000000A"));    vctColNum.push_back(2);	   //"设置列表2列"
		uiMenu.AddItem(artiGetText("FF060000000B"));    vctColNum.push_back(5);	   //"设置列表5列"
		uiMenu.AddItem(artiGetText("FF060000000C"));    vctColNum.push_back(10);   //"设置列表10列"
		uiMenu.AddItem(artiGetText("FF0600000037"));    vctColNum.push_back(16);   //"设置列表16列"

		vector<int32_t> vctColWidth;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				vctColWidth.clear();
				if (0 == uRetBtn)
				{
					vctColWidth.clear();
				}
				else
				{
					for (uint32_t i = 0; i < vctColNum[uRetBtn]; i++)
					{
						vctColWidth.push_back(100 / vctColNum[uRetBtn]);
					}
				}
			}

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth(vctColWidth);

			vector<string> vctItems;
			for (uint32_t i = 0; i < 10; i++)
			{
				vctItems.clear();

				for (uint32_t j = 0; j < vctColNum[uRetBtn]; j++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, j);//"第%d行 - 第%d列"
					vctItems.push_back(buff);
				}
				uiList.AddItem(vctItems);
			}

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetHeads()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF060000007C"));	//"列表头文本为空"
		uiMenu.AddItem(artiGetText("FF060000007B"));	//"列表头文本为单行短文本"
		uiMenu.AddItem(artiGetText("FF060000007D"));	//"列表头文本为单行长文本"
		uiMenu.AddItem(artiGetText("FF060000007E"));	//"列表头文本为多行文本"
		uiMenu.AddItem(artiGetText("FF0600000038"));	//"列表头英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000039"));	//"列表头中文长度达到阈值"

		vector<string> vctItems;
		vector<string> vctHeadNames;

		while (1)
		{
			vctHeadNames.clear();

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				vctHeadNames.push_back("");
				vctHeadNames.push_back("");
			}
			else if (1 == uRetBtn)
			{
				vctHeadNames.push_back(TextSingleLine);
				vctHeadNames.push_back(TextSingleLine);
			}
			else if (2 == uRetBtn)
			{
				vctHeadNames.push_back(artiGetText("FF120000000A"));
				vctHeadNames.push_back(artiGetText("FF120000000A"));
			}
			else if (3 == uRetBtn)
			{
				vctHeadNames.push_back(TextMulitLineTitle);
				vctHeadNames.push_back(TextMulitLineTitle);
			}
			else if (4 == uRetBtn)
			{
				vctHeadNames.push_back(artiGetText("FF1100000005"));
				vctHeadNames.push_back(artiGetText("FF1100000005"));
			}
			else
			{
				vctHeadNames.push_back(artiGetText("FF1200000005"));
				vctHeadNames.push_back(artiGetText("FF1200000005"));
			}

			vector<int32_t> vctColWidth;
			vctColWidth.push_back(50);
			vctColWidth.push_back(50);

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth(vctColWidth);
			uiList.SetHeads(vctHeadNames);

			for (uint32_t i = 1; i < 5; i++)
			{
				vctItems.clear();

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetTipsOnTop()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF1300000010"));	//"提示为空文本"
		uiMenu.AddItem(artiGetText("FF1300000011"));	//"提示为单行短文本"
		uiMenu.AddItem(artiGetText("FF1300000012"));	//"提示为单行长文本"
		uiMenu.AddItem(artiGetText("FF1300000013"));	//"提示为多行文本"
		uiMenu.AddItem(artiGetText("FF1300000014"));	//"提示中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000015"));	//"提示英文长度达到阈值"

		while (1)
		{
#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			for (uint32_t i = 1; i < 5; i++)
			{
				vector<string> vctItems;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			uiList.SetColWidth({ 40, 60 });
			string  strTip = "";

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTip = "";
			}
			else if (1 == uRetBtn)
			{
				strTip = TextSingleLine;
			}
			else if (2 == uRetBtn)
			{
				strTip = artiGetText("FF120000000A");
			}
			else if (3 == uRetBtn)
			{
				strTip = TextMulitLineValue;
			}
			else if (4 == uRetBtn)
			{
				strTip = artiGetText("FF1100000005");
			}
			else
			{
				strTip = artiGetText("FF1200000005");
			}
			uiList.SetTipsOnTop(strTip);
			uint32_t uRetTips = DF_ID_NOKEY;
			while (1)
			{
				Delay(100);
				uRetTips = uiList.Show();
				if (uRetTips == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetTipsOnTopType()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF1300000010"));										//"提示为空文本"
		uiMenu.AddItem(artiGetText("FF1300000011") + "-" + artiGetText("FF060000003C"));	//"提示为单行短文本"				"居中对齐"
		uiMenu.AddItem(artiGetText("FF1300000012") + "-" + artiGetText("FF060000003C"));	//"提示为单行长文本"				"居中对齐"
		uiMenu.AddItem(artiGetText("FF1300000013") + "-" + artiGetText("FF060000003D"));	//"提示为多行文本"					"左对齐"
		uiMenu.AddItem(artiGetText("FF1300000015") + "-" + artiGetText("FF060000003C"));	//"提示中文长度达到阈值"			"居中对齐"
		uiMenu.AddItem(artiGetText("FF1300000014") + "-" + artiGetText("FF060000003D"));	//"提示英文长度达到阈值"			"左对齐"

		while (1)
		{
#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			for (uint32_t i = 1; i < 5; i++)
			{
				vector<string> vctItems;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			uiList.SetColWidth({ 40, 60 });
			string  strTip = "";
			uint32_t uAlignType = 0;

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTip = "";
			}
			else if (1 == uRetBtn)
			{
				strTip = TextSingleLine;
				uAlignType = DT_CENTER;
			}
			else if (2 == uRetBtn)
			{
				strTip = artiGetText("FF120000000A");
				uAlignType = DT_CENTER;
			}
			else if (3 == uRetBtn)
			{
				strTip = TextMulitLineValue;
				uAlignType = DT_LEFT;
			}
			else if (4 == uRetBtn)
			{
				strTip = artiGetText("FF1100000005");
				uAlignType = DT_CENTER;
			}
			else
			{
				strTip = artiGetText("FF1200000005");
				uAlignType = DT_LEFT;
			}

			uiList.SetTipsOnTop(strTip, uAlignType);
			uint32_t uRetTips = DF_ID_NOKEY;
			while (1)
			{
				Delay(100);
				uRetTips = uiList.Show();
				if (uRetTips == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetTipsTitleOnTop()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		string struAlignType = "DT_LEFT";
		string streSize = "FORT_SIZE_SMALL";
		string streBold = "BOLD_TYPE_NONE";
		string strTitle = artiGetText("FF0000000004");	//"文本为单行文本"

		uint32_t uAlignType = DT_LEFT;
		eFontSize eSize = eFontSize::FORT_SIZE_SMALL;
		eBoldType eBold = eBoldType::BOLD_TYPE_NONE;

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetTipsTitleOnTop");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("uAlignType");
		uiList.AddItem("eSize");
		uiList.AddItem("eBold");
		uiList.AddItem("title");

		uiList.SetItem(0, 1, struAlignType);
		uiList.SetItem(1, 1, streSize);
		uiList.SetItem(2, 1, streBold);
		uiList.SetItem(3, 1, strTitle);
		uiList.AddButtonEx("Test");

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
#if __Multi_System_Test__
				CArtiList uiList1(m_uThread);
#else
				CArtiList uiList1;
#endif

				uiList1.InitTitle("Title");		//"参数列表"
				uiList1.SetColWidth(vctColWidth);

				uiList1.SetTipsTitleOnTop(strTitle, uAlignType, eSize, eBold);
				uiList1.SetTipsOnTop("1.Test1\n2.Test2\n3.Test3\n");

				for (uint32_t i = 1; i < 5; i++)
				{
					vector<string> vctItems;

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
					vctItems.push_back(buff);

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
					vctItems.push_back(buff);

					uiList1.AddItem(vctItems);
				}

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiList1.Show();
					if (uRetBtn1 == DF_ID_BACK)
					{
						break;
					}
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uAlignType, struAlignType, mapAlignType);
					uiList.SetItem(0, 1, struAlignType);
				}
				else if (1 == uSelect)
				{
					GetParamValue(eSize, streSize, mapFontSize);
					uiList.SetItem(1, 1, streSize);
				}
				else if (2 == uSelect)
				{
					GetParamValue(eBold, streBold, mapBoldType);
					uiList.SetItem(2, 1, streBold);
				}
				else if (3 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
					uiTitleMenu.AddItem(artiGetText("FF0600000082"));	//"提示标题文本为空"
					uiTitleMenu.AddItem(artiGetText("FF0600000081"));	//"提示标题文本为单行短文本"
					uiTitleMenu.AddItem(artiGetText("FF0600000083"));	//"提示标题文本为单行长文本"			
					uiTitleMenu.AddItem(artiGetText("FF0600000084"));	//"提示标题文本为多行"					
					uiTitleMenu.AddItem(artiGetText("FF060000003E"));	//"提示标题文本英文长度达到阈值"		
					uiTitleMenu.AddItem(artiGetText("FF060000003F"));	//"提示标题文本中文长度达到阈值"	

					while (1)
					{
						uRetBtn = uiTitleMenu.Show();
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
							strTitle = TextSingleLine;
						}
						else if (2 == uRetBtn)
						{
							strTitle = artiGetText("FF120000000A");
						}
						else if (3 == uRetBtn)
						{
							strTitle = TextMulitLineValue;
						}
						else if (4 == uRetBtn)
						{
							strTitle = artiGetText("FF1100000004");
						}
						else if (5 == uRetBtn)
						{
							strTitle = artiGetText("FF1200000004");
						}
						break;
					}
					uiList.SetItem(3, 1, strTitle);
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetTipsOnBottom()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF1300000010"));	//"提示文本为空"
		uiMenu.AddItem(artiGetText("FF1300000011"));	//"提示为单行短文本"		
		uiMenu.AddItem(artiGetText("FF1300000012"));	//"提示为单行长文本"	
		uiMenu.AddItem(artiGetText("FF1300000013"));	//"提示文本为多行"					
		uiMenu.AddItem(artiGetText("FF1300000014"));	//"提示英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000015"));	//"提示中文长度达到阈值"

		string strTipsOnBottom = "";

		while (1)
		{
#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth({ 40, 60 });

			for (uint32_t i = 1; i < 5; i++)
			{
				vector<string> vctItems;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTipsOnBottom = "";
			}
			else if (1 == uRetBtn)
			{
				strTipsOnBottom = TextSingleLine;
			}
			else if (2 == uRetBtn)
			{
				strTipsOnBottom = artiGetText("FF120000000A");
			}
			else if (3 == uRetBtn)
			{
				strTipsOnBottom = TextMulitLineValue;
			}
			else if (4 == uRetBtn)
			{
				strTipsOnBottom = artiGetText("FF1100000005");
			}
			else if (5 == uRetBtn)
			{
				strTipsOnBottom = artiGetText("FF1200000005");
			}

			uiList.SetTipsOnBottom(strTipsOnBottom);

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}

		}
	}

	void CArtiListTest::ArtiListTest_AddTipsOnLeft()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF1300000010"));	//"提示为空文本"
		uiMenu.AddItem(artiGetText("FF1300000011"));	//"提示为单行短文本"			
		uiMenu.AddItem(artiGetText("FF1300000012"));	//"提示为单行长文本"	
		uiMenu.AddItem(artiGetText("FF1300000013"));	//"提示为多行文本"					
		uiMenu.AddItem(artiGetText("FF1300000014"));	//"提示英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000015"));	//"提示中文中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000040"));	//"提示文本加粗"		

		string strTipsOnLeft = "";
		eBoldType eBold = BOLD_TYPE_NONE;

		while (1)
		{
#if __Multi_System_Test__ 
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.AddItem(vector<string>{"Name1", "Value1", "Unit1"});
			uiList.AddItem(vector<string>{"Name2", "Value2", "Unit2"});
			uiList.AddItem(vector<string>{"Name3", "Value3", "Unit3"});
			uiList.AddItem(vector<string>{"Name4", "Value4", "Unit4"}, false);
			uiList.AddItem(vector<string>{"Name5", "Value5", "Unit5"}, false);
			uiList.AddItem(vector<string>{"Name6", "Value6", "Unit6"}, false);
			uiList.SetColWidth({ 30,40,30 });

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTipsOnLeft = "";
				eBold = BOLD_TYPE_NONE;
			}
			else if (1 == uRetBtn)
			{
				strTipsOnLeft = TextSingleLine;
				eBold = BOLD_TYPE_NONE;
			}
			else if (2 == uRetBtn)
			{
				strTipsOnLeft = artiGetText("FF120000000A");
				eBold = BOLD_TYPE_NONE;
			}
			else if (3 == uRetBtn)
			{
				strTipsOnLeft = TextMulitLineValue;
				eBold = BOLD_TYPE_NONE;
			}
			else if (4 == uRetBtn)
			{
				strTipsOnLeft = artiGetText("FF1100000005");
				eBold = BOLD_TYPE_NONE;
			}
			else if (5 == uRetBtn)
			{
				strTipsOnLeft = artiGetText("FF1200000005");
				eBold = BOLD_TYPE_NONE;
			}
			else
			{
				strTipsOnLeft = TextMulitLineValue;
				eBold = BOLD_TYPE_BOLD;
			}
			uiList.AddTipsOnLeft(strTipsOnLeft, eBold);

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetTipsTitleOnLeft()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF0600000082"));	//"提示标题文本为空"
		uiMenu.AddItem(artiGetText("FF0600000081"));	//"提示标题文本为单行短文本"		
		uiMenu.AddItem(artiGetText("FF0600000083"));	//"提示标题文本为单行长文本"		
		uiMenu.AddItem(artiGetText("FF0600000084"));	//"提示标题文本为多行"					
		uiMenu.AddItem(artiGetText("FF060000003E"));	//"提示标题文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF060000003F"));	//"提示标题文本中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000045"));	//"提示标题文本加粗"

		string strTipsTitleOnLeft = "";
		eBoldType eBold = BOLD_TYPE_NONE;

		while (1)
		{
#if __Multi_System_Test__ 
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.AddItem(vector<string>{"Name1", "Value1", "Unit1"});
			uiList.AddItem(vector<string>{"Name2", "Value2", "Unit2"});
			uiList.AddItem(vector<string>{"Name3", "Value3", "Unit3"});
			uiList.AddItem(vector<string>{"Name4", "Value4", "Unit4"}, false);
			uiList.AddItem(vector<string>{"Name5", "Value5", "Unit5"}, false);
			uiList.AddItem(vector<string>{"Name6", "Value6", "Unit6"}, false);
			uiList.SetColWidth({ 30,40,30 });

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTipsTitleOnLeft = "";
			}
			else if (1 == uRetBtn)
			{
				strTipsTitleOnLeft = TextSingleLine;
				eBold = BOLD_TYPE_NONE;
			}
			else if (2 == uRetBtn)
			{
				strTipsTitleOnLeft = artiGetText("FF120000000A");
				eBold = BOLD_TYPE_NONE;
			}
			else if (3 == uRetBtn)
			{
				strTipsTitleOnLeft = TextMulitLineValue;
				eBold = BOLD_TYPE_NONE;
			}
			else if (4 == uRetBtn)
			{
				strTipsTitleOnLeft = artiGetText("FF1100000004");
				eBold = BOLD_TYPE_NONE;
			}
			else if (5 == uRetBtn)
			{
				strTipsTitleOnLeft = artiGetText("FF1200000004");
				eBold = BOLD_TYPE_NONE;
			}
			else
			{
				strTipsTitleOnLeft = TextSingleLine;
				eBold = BOLD_TYPE_BOLD;
			}

			uiList.AddTipsOnLeft("\n\nOriginal transponder chip:\nMEGAMOS 48\nAllowed transponder chip:\nMEGAMOS 48", BOLD_TYPE_NONE);
			uiList.SetTipsTitleOnLeft(strTipsTitleOnLeft, eBold);

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetBlockStatus()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF060000000E"));//"阻塞界面"
		uiMenu.AddItem(artiGetText("FF060000000F"));//"非阻塞界面"

		bool bIsBlock = false;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				bIsBlock = true;
			}
			else if (1 == uRetBtn)
			{
				bIsBlock = false;
			}

			vector<int32_t> vctColWidth;
			vctColWidth.push_back(50);
			vctColWidth.push_back(50);

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth(vctColWidth);
			uiList.SetBlockStatus(bIsBlock);

			uiList.AddItem(artiGetText("FF0600000010"));//"界面刷新次数"
			uiList.AddButtonEx(artiGetText("FF0600000011"));//"刷新界面"

			uint32_t uCnt = 0;
			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_BACK)
				{
					break;
				}
				else
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0600000012").c_str(), uCnt++);//"第%d次"
					uiList.SetItem(0, 1, buff);
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_AddButtonEx()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF1300000007"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF1300000008"));	//"按钮文本为单行"					
		uiMenu.AddItem(artiGetText("FF130000000A"));	//"按钮文本为多行"					
		uiMenu.AddItem(artiGetText("FF130000000B"));	//"按钮英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000C"));	//"按钮中文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000D"));	//"增加按键数量达到阈值"

		uint32_t uRetListBtn = DF_ID_NOKEY;
		uint32_t uRetListBtnNum = 1;
		string strButtonText = "";

		while (1)
		{
			vector<int32_t> vctColWidth;
			vctColWidth.push_back(50);
			vctColWidth.push_back(50);

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth(vctColWidth);

			uiList.AddItem(artiGetText("FF0600000015"));//"第0行第0列"
			uiList.SetItem(0, 1, artiGetText("FF0600000016"));//"第0行第1列"
			uiList.AddButton(artiGetText("FF130000000E")); //增加	

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strButtonText = "";
			}
			else if (1 == uRetBtn)
			{
				strButtonText = TextSingleLine;
			}
			else if (2 == uRetBtn)
			{
				strButtonText = artiGetText("FF1200000009");
			}
			else if (3 == uRetBtn)
			{
				strButtonText = artiGetText("FF1100000002");
			}
			else if (4 == uRetBtn)
			{
				strButtonText = artiGetText("FF1200000002");
			}
			else
			{
				strButtonText = artiGetText("FF0600000047");//测试按键
			}

			uRetListBtnNum = 1;
			while (1)
			{

				uRetListBtn = uiList.Show();

				if (uRetListBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetListBtn == DF_ID_FREEBTN_0)
				{
					string strReButtonID = "";
					uint32_t reButtonID = 0;
					if (5 == uRetBtn)
					{
						for (uint32_t i = 0; i < 31; i++)
						{
							reButtonID = uiList.AddButtonEx(strButtonText + to_string(uRetListBtnNum));
							strReButtonID = strReButtonID + artiGetText("FF0600000047") + to_string(uRetListBtnNum) + ":";
							strReButtonID = strReButtonID + to_string(reButtonID) + "\n";
							uRetListBtnNum++;
						}
						artiShowMsgBox(artiGetText("FF0600000048"), strReButtonID);
					}
					else
					{
						reButtonID = uiList.AddButtonEx(strButtonText);
						strReButtonID = strButtonText + ":" + to_string(reButtonID);
						artiShowMsgBox(artiGetText("FF0600000048"), strReButtonID);
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_AddButton()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF1300000007"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF1300000008"));	//"按钮文本为单行"					
		uiMenu.AddItem(artiGetText("FF130000000A"));	//"按钮文本为多行"					
		uiMenu.AddItem(artiGetText("FF130000000B"));	//"按钮英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000C"));	//"按钮中文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000D"));	//"增加按键数量达到阈值"

		uint32_t uRetListBtn = DF_ID_NOKEY;
		uint32_t uRetListBtnNum = 1;
		string strButtonText = "";

		while (1)
		{
			vector<int32_t> vctColWidth;
			vctColWidth.push_back(50);
			vctColWidth.push_back(50);

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth(vctColWidth);

			uiList.AddItem(artiGetText("FF0600000015"));//"第0行第0列"
			uiList.SetItem(0, 1, artiGetText("FF0600000016"));//"第0行第1列"
			uiList.AddButton(artiGetText("FF130000000E")); //增加	

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strButtonText = "";
			}
			else if (1 == uRetBtn)
			{
				strButtonText = TextSingleLine;
			}
			else if (2 == uRetBtn)
			{
				strButtonText = artiGetText("FF1200000009");
			}
			else if (3 == uRetBtn)
			{
				strButtonText = artiGetText("FF1100000002");
			}
			else if (4 == uRetBtn)
			{
				strButtonText = artiGetText("FF1200000002");
			}
			else
			{
				strButtonText = artiGetText("FF0600000047");//测试按键
			}

			uRetListBtnNum = 1;
			while (1)
			{

				uRetListBtn = uiList.Show();

				if (uRetListBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetListBtn == DF_ID_FREEBTN_0)
				{
					if (5 == uRetBtn)
					{
						for (uint32_t i = 0; i < 31; i++)
						{
							uiList.AddButton(strButtonText + to_string(uRetListBtnNum));
							uRetListBtnNum++;
						}
					}
					else
					{
						uiList.AddButton(strButtonText);
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_DelButton()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(50);
		vctColWidth.push_back(50);

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem(artiGetText("FF0600000015"));//"第0行第0列"
		uiList.SetItem(0, 1, artiGetText("FF0600000016"));//"第0行第1列"

		uiList.AddButtonEx(artiGetText("FF060000002F"));//"删除按键"

		vector<uint32_t> vctBtnID;
		uiList.AddButtonEx(artiGetText("FF090000001A"));//"测试键1"
		uiList.AddButtonEx(artiGetText("FF090000001B"));//"测试键2"
		uiList.AddButtonEx(artiGetText("FF090000001C"));//"测试键3"

		vctBtnID.push_back(DF_ID_FREEBTN_1);
		vctBtnID.push_back(DF_ID_FREEBTN_2);
		vctBtnID.push_back(DF_ID_FREEBTN_3);

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
				if (vctBtnID.size())
				{
					uiList.DelButton(vctBtnID[vctBtnID.size() - 1]);
					vctBtnID.pop_back();
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_AddGroup()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0600000085"));	//"分组组名为空文本"
		uiMenu.AddItem(artiGetText("FF0600000086"));	//"分组组名为单行短文本"
		uiMenu.AddItem(artiGetText("FF0600000080"));	//"分组组名为单行长文本"
		uiMenu.AddItem(artiGetText("FF0600000087"));	//"分组组名为多行文本"
		uiMenu.AddItem(artiGetText("FF0600000043"));	//"分组组名英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000044"));	//"分组组名中文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000051"));	//"添加分组数量达到阈值"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				string strText = "";
				if (0 == uRetBtn)
				{
					strText = "";
				}
				else if (1 == uRetBtn)
				{
					strText = artiGetText("FF0600000018");//"GroupName"
				}
				else if (2 == uRetBtn)
				{
					strText = artiGetText("FF120000000A");
				}
				else if (3 == uRetBtn)
				{
					strText = TextMulitLineTitle;
				}
				else if (4 == uRetBtn)
				{
					strText = artiGetText("FF1100000004");
				}
				else if (5 == uRetBtn)
				{
					strText = artiGetText("FF1200000004");
				}
				else if (6 == uRetBtn)
				{
					strText = artiGetText("FF0600000018");//"GroupName"
				}

				vector<int32_t> vctColWidth;
				vctColWidth.push_back(50);
				vctColWidth.push_back(50);

#if __Multi_System_Test__
				CArtiList uiList(m_uThread);
#else
				CArtiList uiList;
#endif
				uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
				uiList.SetColWidth(vctColWidth);

				if (6 == uRetBtn)
				{
					for (uint32_t j = 0; j < 500; j++)
					{
						uiList.AddGroup(strText + to_string(j));

						vector<string> vctItems;
						for (uint32_t i = 1; i < 5; i++)
						{
							vctItems.clear();

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							uiList.AddItem(vctItems);
						}
					}
				}
				else
				{
					uiList.AddGroup(strText);

					vector<string> vctItems;
					for (uint32_t i = 1; i < 5; i++)
					{
						vctItems.clear();

						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
						vctItems.push_back(buff);

						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
						vctItems.push_back(buff);

						uiList.AddItem(vctItems);
					}
				}

				while (1)
				{
					Delay(100);
					uRetBtn = uiList.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_AddItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenuType(m_uThread);
#else
		CArtiMenu uiMenuType;
#endif
		uiMenuType.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenuType.AddItem(artiGetText("FF0600000030"));	//"列表类型-无复选框"
		uiMenuType.AddItem(artiGetText("FF0600000031"));	//"列表类型-有复选框"

		uint32_t listType = 0;

		while (1)
		{
			uRetBtn = uiMenuType.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				listType = 0;
			}
			else
			{
				listType = 1;
			}

#if __Multi_System_Test__
			CArtiMenu uiMenu(m_uThread);
#else
			CArtiMenu uiMenu;
#endif
			uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
			uiMenu.AddItem(artiGetText("FF0600000088"));	//"新添加数据项文本为空"
			uiMenu.AddItem(artiGetText("FF0600000089"));	//"新添加数据项文本为单行短文本"
			uiMenu.AddItem(artiGetText("FF060000007F"));	//"新添加数据项文本为单行长文本"
			uiMenu.AddItem(artiGetText("FF060000008A"));	//"新添加数据项文本为多行"
			uiMenu.AddItem(artiGetText("FF060000001C"));	//"偶行锁定，奇行不锁定"
			uiMenu.AddItem(artiGetText("FF0600000052"));	//"新添加数据项英文文本长度达到阈值"
			uiMenu.AddItem(artiGetText("FF0600000053"));	//"新添加数据项中文文本长度达到阈值"
			uiMenu.AddItem(artiGetText("FF0600000054"));	//"新添加数据项数量达到阈值"

			while (1)
			{
				uRetBtn = uiMenu.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					break;
				}
				else
				{
					vector<int32_t> vctColWidth;
					vctColWidth.push_back(50);
					vctColWidth.push_back(50);

#if __Multi_System_Test__
					CArtiList uiList(m_uThread);
#else
					CArtiList uiList;
#endif
					if (listType == 0)
					{
						uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
					}
					else
					{
						uiList.InitTitle(artiGetText("FF0600000000"), CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI);//"列表控件测试"
					}
					
					uiList.SetColWidth(vctColWidth);

					vector<string> vctItems;

					if (0 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back("");
							vctItems.push_back("");
							uiList.AddItem(vctItems);
						}

					}
					else if (1 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							uiList.AddItem(vctItems);
						}
					}
					else if (2 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(artiGetText("FF120000000A"));
							vctItems.push_back(artiGetText("FF120000000A"));
							uiList.AddItem(vctItems);
						}
					}
					else if (3 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(TextMulitLineValue);
							vctItems.push_back(TextMulitLineValue);
							uiList.AddItem(vctItems);
						}
					}
					else if (4 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							uiList.AddItem(vctItems, (i + 1) % 2);
						}
					}
					else if (5 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(artiGetText("FF1100000005"));
							vctItems.push_back(artiGetText("FF1100000005"));
							uiList.AddItem(vctItems);
						}
					}
					else if (6 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(artiGetText("FF1200000005"));
							vctItems.push_back(artiGetText("FF1200000005"));
							uiList.AddItem(vctItems);
						}
					}
					else
					{
						for (uint32_t i = 0; i < 10000; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							uiList.AddItem(vctItems);
						}
					}

					while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (uRetBtn == DF_ID_CANCEL)
						{
							break;
						}
					}
				}
			}
		}	
	}

	void CArtiListTest::ArtiListTest_AddItem1()
	{

#if __Multi_System_Test__
		CArtiMenu uiMenuType(m_uThread);
#else
		CArtiMenu uiMenuType;
#endif
		uiMenuType.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenuType.AddItem(artiGetText("FF0600000030"));	//"列表类型-无复选框"
		uiMenuType.AddItem(artiGetText("FF0600000031"));	//"列表类型-有复选框"

		uint32_t listType = 0;

		while (1)
		{
			uRetBtn = uiMenuType.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				listType = 0;
			}
			else
			{
				listType = 1;
			}

#if __Multi_System_Test__
			CArtiMenu uiMenu(m_uThread);
#else
			CArtiMenu uiMenu;
#endif
			uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
			uiMenu.AddItem(artiGetText("FF0600000088"));	//"新添加数据项文本为空"
			uiMenu.AddItem(artiGetText("FF0600000089"));	//"新添加数据项文本为单行短文本"
			uiMenu.AddItem(artiGetText("FF060000007F"));	//"新添加数据项文本为单行长文本"
			uiMenu.AddItem(artiGetText("FF060000008A"));	//"新添加数据项文本为多行"
			uiMenu.AddItem(artiGetText("FF0600000052"));	//"新添加数据项英文文本长度达到阈值"
			uiMenu.AddItem(artiGetText("FF0600000053"));	//"新添加数据项中文文本长度达到阈值"
			uiMenu.AddItem(artiGetText("FF0600000054"));	//"新添加数据项数量达到阈值"

			while (1)
			{
				uRetBtn = uiMenu.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					break;
				}
				else
				{
					vector<int32_t> vctColWidth;
					vctColWidth.push_back(100);
				//	vctColWidth.push_back(50);

#if __Multi_System_Test__
					CArtiList uiList(m_uThread);
#else
					CArtiList uiList;
#endif
					if (listType == 0)
					{
						uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
					}
					else
					{
						uiList.InitTitle(artiGetText("FF0600000000"), CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI);//"列表控件测试"
					}
					uiList.SetColWidth(vctColWidth);

					vector<string> vctItems;

					if (0 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();							
							vctItems.push_back("");
							uiList.AddItem(vctItems);
						}

					}
					else if (1 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);						

							uiList.AddItem(vctItems);
						}
					}
					else if (2 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(artiGetText("FF120000000A"));							
							uiList.AddItem(vctItems);
						}
					}
					else if (3 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(TextMulitLineValue);						
							uiList.AddItem(vctItems);
						}
					}
					else if (4 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(artiGetText("FF1100000005"));					
							uiList.AddItem(vctItems);
						}
					}
					else if (5 == uRetBtn)
					{
						for (uint32_t i = 0; i < 10; i++)
						{
							vctItems.clear();
							vctItems.push_back(artiGetText("FF1200000005"));					
							uiList.AddItem(vctItems);
						}
					}
					else
					{
						for (uint32_t i = 0; i < 10000; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);							

							uiList.AddItem(vctItems);
						}
					}

					while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (uRetBtn == DF_ID_CANCEL)
						{
							break;
						}
					}
				}
			}

		}

		
	}

	void CArtiListTest::ArtiListTest_SetItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF060000001E"));	//"设置列表值为空"
		uiMenu.AddItem(artiGetText("FF060000001F"));	//"设置列表值为单行文本"
		uiMenu.AddItem(artiGetText("FF0600000020"));	//"设置列表值为多行文本"
		uiMenu.AddItem(artiGetText("FF0600000055"));	//"设置列表值英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0600000056"));	//"设置列表值中文文本长度达到阈值"

		string strText = "";

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (0 == uRetBtn)
				{
					strText = "";
				}
				else if (1 == uRetBtn)
				{
					strText = TextSingleLine;
				}
				else if (2 == uRetBtn)
				{
					strText = TextMulitLineTitle;
				}
				else if (3 == uRetBtn)
				{
					strText = artiGetText("FF1100000005");
				}
				else
				{
					strText = artiGetText("FF1200000005");
				}

				vector<int32_t> vctColWidth;
				vctColWidth.push_back(10);
				for (uint32_t i = 0; i < 15; i++)
				{
					vctColWidth.push_back(6);
				}

#if __Multi_System_Test__
				CArtiList uiList(m_uThread);
#else
				CArtiList uiList;
#endif
				uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
				uiList.SetColWidth(vctColWidth);

				vector<string> vctItems = { "1","2","3" ,"4" ,"5" ,"6" ,"7" ,"8" ,"9" ,"10" ,"11" ,"12" ,"13" ,"14" ,"15" ,"16" };
				for (uint32_t i = 0; i < 100; i++)
				{
					uiList.AddItem(vctItems);
				}

				uiList.AddButtonEx(artiGetText("FF060000001D"));					//"设置"

				while (1)
				{
					Delay(100);
					uRetBtn = uiList.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						for (uint32_t i = 0; i < 100; i++)
						{

							uiList.SetItem(i, i % 16, strText);
						}
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetItemPicture()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(30);
		vctColWidth.push_back(30);
		vctColWidth.push_back(40);

		vector<string> vctHeadNames;
		vctHeadNames.clear();
		vctHeadNames.push_back(artiGetText("FF00000000B1"));//"车型"
		vctHeadNames.push_back(artiGetText("FF00000000B2"));//"文本"
		vctHeadNames.push_back(artiGetText("FF00000000B3"));//"图片"

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
		uiList.SetColWidth(vctColWidth);

		uiList.SetHeads(vctHeadNames);
		uiList.SetHeads(vctHeadNames);

		uiList.AddItem("Audi");
		uiList.AddItem("Benz");
		uiList.AddItem("BWM");
		uiList.AddItem("GM");
		uiList.AddItem("DUCATI");
		uiList.AddItem("VW");
		uiList.AddItem("DEMO");

		uiList.SetItem(0, 1, "Audi.png");
		uiList.SetItem(1, 1, "Benz.png");
		uiList.SetItem(2, 1, "BWM.png");
		uiList.SetItem(3, 1, artiGetText("FF0600000057"));	//"指定路径为空"
		uiList.SetItem(4, 1, artiGetText("FF0600000058"));	//"指定路径非法"
		uiList.SetItem(5, 1, artiGetText("FF0600000059"));	//"图片路径总数小于行数"

		uiList.AddButtonEx(artiGetText("FF060000001D"));	//"设置"

		vector<std::string> vctPath;
		vctPath.push_back(CArtiGlobal::GetVehPath() + "/Logo/Audi.png");
		vctPath.push_back(CArtiGlobal::GetVehPath() + "/Logo/Benz.png");
		vctPath.push_back(CArtiGlobal::GetVehPath() + "/Logo/BWM.png");
		vctPath.push_back(CArtiGlobal::GetVehPath() + "");
		vctPath.push_back(CArtiGlobal::GetVehPath() + "Illegal paths");

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				uiList.SetItemPicture(2, vctPath);
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetLeftLayoutPicture()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		string strPicturePath = "/Logo/Audi.png";
		string strPictureTips = TextSingleLine;
		uint16_t uPictureType = DT_LEFT_TOP;

		vector<string> vecHeadNames;
		vecHeadNames.clear();
		vecHeadNames.push_back(artiGetText("FF060000005A"));//"参数项"		
		vecHeadNames.push_back(artiGetText("FF060000005B"));//"参数值"	

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetLeftLayoutPicture");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("PicturePath");
		uiList.AddItem("PictureTips");
		uiList.AddItem("AlignType");

		uiList.SetItem(0, 1, strPicturePath);
		uiList.SetItem(1, 1, artiGetText("FF0000000004"));
		uiList.SetItem(2, 1, "DT_LEFT_TOP");

		uiList.SetHeads(vecHeadNames);
		uiList.AddButtonEx("Test");

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
#if __Multi_System_Test__
				CArtiList uiListTwo(m_uThread);
#else
				CArtiList uiListTwo;
#endif
				uiListTwo.InitTitle("SetLeftLayoutPicture");
				uiListTwo.SetColWidth(vctColWidth);
				uiListTwo.AddItem("1-1");
				uiListTwo.AddItem("2-1");
				uiListTwo.AddItem("3-1");

				uiListTwo.SetItem(0, 1, "1-2");
				uiListTwo.SetItem(1, 1, "2-2");
				uiListTwo.SetItem(2, 1, "3-2");

				uiListTwo.SetLeftLayoutPicture(strPicturePath, strPictureTips, uPictureType);
				while (1)
				{
					uRetBtn = uiListTwo.Show();

					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
				}
			}
			else if (uRetBtn != DF_ID_NOKEY)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif					
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
					uiTitleMenu.AddItem(artiGetText("FF060000008E"));	//图片路径为空
					uiTitleMenu.AddItem("/Logo/Audi.png");
					uiTitleMenu.AddItem("/Logo/Benz.png");
					uiTitleMenu.AddItem("/Logo/BWM.png");

					string uiPic = "";

					while (1)
					{
						uRetBtn = uiTitleMenu.Show();


						if (DF_ID_BACK == uRetBtn)
						{
							break;
						}
						else if (0 == uRetBtn)
						{
							uiPic = artiGetText("FF060000008E");
							strPicturePath = "";
						}
						else if (1 == uRetBtn)
						{
							uiPic = "/Logo/Audi.png";
							strPicturePath = "/Logo/Audi.png";
						}
						else if (2 == uRetBtn)
						{
							uiPic = "/Logo/Benz.png";
							strPicturePath = "/Logo/Benz.png";
						}
						else if (3 == uRetBtn)
						{
							uiPic = "/Logo/BWM.png";
							strPicturePath = "/Logo/BWM.png";
						}
						break;
						}
					uiList.SetItem(0, 1, uiPic);
					}
				else if (1 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
					uiTitleMenu.AddItem(artiGetText("FF060000008B"));	//"图片提示为空"
					uiTitleMenu.AddItem(artiGetText("FF060000008C"));	//"图片提示为单行文本"					
					uiTitleMenu.AddItem(artiGetText("FF060000008D"));	//"图片提示为多行文本"					
					uiTitleMenu.AddItem(artiGetText("FF060000005C"));	//"图片提示英文长度达到阈值"
					uiTitleMenu.AddItem(artiGetText("FF060000005D"));	//"图片提示中文长度达到阈值"

					while (1)
					{
						uRetBtn = uiTitleMenu.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							break;
						}
						else if (0 == uRetBtn)
						{
							strPictureTips = "";
							uiList.SetItem(1, 1, artiGetText("FF060000008B"));
						}
						else if (1 == uRetBtn)
						{
							strPictureTips = TextSingleLine;
							uiList.SetItem(1, 1, artiGetText("FF060000008C"));
						}
						else if (2 == uRetBtn)
						{
							strPictureTips = TextMulitLineValue;
							uiList.SetItem(1, 1, artiGetText("FF060000008D"));
						}
						else if (3 == uRetBtn)
						{
							strPictureTips = artiGetText("FF1100000005");
							uiList.SetItem(1, 1, artiGetText("FF060000005C"));
						}
						else if (4 == uRetBtn)
						{
							strPictureTips = artiGetText("FF1200000005");
							uiList.SetItem(1, 1, artiGetText("FF060000005D"));
						}
						break;
						}
					}
				else if (2 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif					
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
					uiTitleMenu.AddItem("DT_LEFT_TOP");
					uiTitleMenu.AddItem("DT_RIGHT_TOP");
					uiTitleMenu.AddItem("DT_LEFT_BOTTOM");
					uiTitleMenu.AddItem("DT_RIGHT_BOTTOM");

					while (1)
					{
						uRetBtn = uiTitleMenu.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							break;
						}
						else if (0 == uRetBtn)
						{
							uPictureType = DT_LEFT_TOP;
							uiList.SetItem(2, 1, "DT_LEFT_TOP");
						}
						else if (1 == uRetBtn)
						{
							uPictureType = DT_RIGHT_TOP;
							uiList.SetItem(2, 1, "DT_RIGHT_TOP");
						}
						else if (2 == uRetBtn)
						{
							uPictureType = DT_LEFT_BOTTOM;
							uiList.SetItem(2, 1, "DT_LEFT_BOTTOM");
						}
						else if (3 == uRetBtn)
						{
							uPictureType = DT_RIGHT_BOTTOM;
							uiList.SetItem(2, 1, "DT_RIGHT_BOTTOM");
						}
						break;
					}
				}
			}
				}
				}

	void CArtiListTest::ArtiListTest_SetRowHighLight()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenuRowHighLight(m_uThread);
#else
		CArtiMenu uiMenuRowHighLight;
#endif

		uiMenuRowHighLight.InitTitle("Test SetRowHighLight");
		uiMenuRowHighLight.AddItem(artiGetText("FF060000005E"));	//"指定行高亮"
		uiMenuRowHighLight.AddItem(artiGetText("FF060000005F"));	//"指定行高亮且指定颜色"
		uiMenuRowHighLight.AddItem(artiGetText("FF0600000060"));	//"指定多行高亮且指定颜色"

		while (1)
		{
			uint32_t uRet = uiMenuRowHighLight.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			if ((uRet & 0xff) == 0)
			{
				CArtiMenu uiMenu;
				uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
				uiMenu.AddItem(artiGetText("FF0600000021"));	//"锁定第0行"
				uiMenu.AddItem(artiGetText("FF0600000022"));	//"锁定第2行"
				uiMenu.AddItem(artiGetText("FF0600000023"));	//"锁定奇数行"
				uiMenu.AddItem(artiGetText("FF0600000024"));	//"锁定所有行"

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

						vector<int32_t> vctColWidth;
						vctColWidth.push_back(40);
						vctColWidth.push_back(20);
						vctColWidth.push_back(20);
						vctColWidth.push_back(20);

#if __Multi_System_Test__
						CArtiList uiList(m_uThread);
#else
						CArtiList uiList;
#endif
						uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
						uiList.SetColWidth(vctColWidth);

						vector<string> vctItems;
						for (uint32_t i = 0; i < 100; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							uiList.AddItem(vctItems);
						}

						uiList.AddButtonEx(artiGetText("FF060000001D"));					//"设置"

						while (1)
						{
							Delay(100);
							uRetBtn = uiList.Show();
							if (uRetBtn == DF_ID_CANCEL)
							{
								break;
							}
							else if (DF_ID_FREEBTN_0 == uRetBtn)
							{
								if (0 == uSelect)
								{
									uiList.SetRowHighLight(0);
								}
								else if (1 == uSelect)
								{
									uiList.SetRowHighLight(2);
								}
								else if (2 == uSelect)
								{
									for (uint32_t i = 0; i < 100; i++)
									{
										if (i % 2)
										{
											uiList.SetRowHighLight(i);
										}
									}
								}
								else
								{
									for (uint32_t i = 0; i < 100; i++)
									{
										uiList.SetRowHighLight(i);
									}
								}
							}
						}
					}
				}
			}
			else if ((uRet & 0xff) == 1 || (uRet & 0xff) == 2)
			{
				CArtiList	uiList;


				vector<int32_t> vctColWidth;
				vctColWidth.push_back(40);
				vctColWidth.push_back(20);
				vctColWidth.push_back(20);
				vctColWidth.push_back(20);

				if ((uRet & 0xff) == 1)
				{
					uiList.InitTitle(artiGetText("FF060000008F"));//指定行高亮且指定颜色
				}
				else
				{
					uiList.InitTitle(artiGetText("FF0600000090"));//指定多行高亮且指定颜色
				}

				uiList.SetColWidth(vctColWidth);
				uiList.AddItem("First Row");
				uiList.AddItem("Second Row");
				uiList.AddItem("Other Row");
				uiList.AddItem("Other Row");
				uiList.AddItem("Fifth Row");
				uiList.AddItem("Sixth Row");

				if ((uRet & 0xff) == 1)
				{
					uiList.SetRowHighLight(0, COLOUR_TYPE_DEFAULT);
					uiList.SetRowHighLight(1, COLOUR_TYPE_GRAY);

				}
				else
				{
					vector<uint16_t> vctRowIndex;
					vector<eColourType> vctColourType;

					vctRowIndex.emplace_back(0);
					vctRowIndex.emplace_back(1);
					vctRowIndex.emplace_back(2);
					vctRowIndex.emplace_back(3);

					vctColourType.push_back(COLOUR_TYPE_GRAY);
					vctColourType.push_back(COLOUR_TYPE_GRAY);
					vctColourType.push_back(COLOUR_TYPE_DEFAULT);
					vctColourType.push_back(COLOUR_TYPE_DEFAULT);
					uiList.SetRowHighLight(vctRowIndex, vctColourType);
				}
				while (1)
				{
					if (uiList.Show() == DF_ID_BACK)
					{
						break;
					}
				}
			}
				}
			}

	void CArtiListTest::ArtiListTest_SetLockFirstRow()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif

		uiMenu.InitTitle("SetLockFirstRow");
		uiMenu.AddItem(artiGetText("FF0600000061"));	//"存在列表头锁定首行"
		uiMenu.AddItem(artiGetText("FF0600000062"));	//"不存在列表头锁定首行"

		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(20);
		vctColWidth.push_back(20);
		vctColWidth.push_back(20);


		while (1)
		{
			uRetBtn = uiMenu.Show();

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
			uiList.SetColWidth(vctColWidth);

			vector<string> vctItems;
			for (uint32_t i = 0; i < 50; i++)
			{
				vctItems.clear();
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			uiList.AddButtonEx(artiGetText("FF060000001D"));					//"设置"
			vector<string> vctHeadNames = { "HeadNameOne","HeadNameTwo","HeadNameThree","HeadNameFour" };
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == 0)
			{
				uiList.SetHeads(vctHeadNames);
			}

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (DF_ID_FREEBTN_0 == uRetBtn)
				{
					uiList.SetLockFirstRow();
				}
			}
		}

			}

	void CArtiListTest::ArtiListTest_SetDefaultSelectedRow()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenuRow(m_uThread);
#else
		CArtiMenu	uiMenuRow;
#endif
		uiMenuRow.InitTitle("Test SetDefaultSelectedRow");

		uiMenuRow.AddItem(artiGetText("FF0600000064"));		//"设置默认选中行"				void SetDefaultSelectedRow(const std::vector<uint16_t>& vctRowIndex);
		uiMenuRow.AddItem(artiGetText("FF0600000065"));		//"设置复选框默认选中状态"		void SetCheckBoxStatus(uint16_t uRowIndex, bool bChecked);

		while (1)
		{
			uint32_t uRet = uiMenuRow.Show();

			if (uRet == DF_ID_BACK)
			{
				break;
			}
			else if ((uRet & 0xff) == 0)
			{
				CArtiMenu uiMenu;

				uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
				uiMenu.AddItem(artiGetText("FF0600000025"));	//"默认选中第0行"
				uiMenu.AddItem(artiGetText("FF0600000026"));	//"默认选中第5行"
				uiMenu.AddItem(artiGetText("FF060000002E"));	//"默认选中第20行"
				uiMenu.AddItem(artiGetText("FF0600000063"));	//"默认选中行不存在"

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

						vector<int32_t> vctColWidth;
						vctColWidth.push_back(40);
						vctColWidth.push_back(20);
						vctColWidth.push_back(20);
						vctColWidth.push_back(20);

#if __Multi_System_Test__
						CArtiList uiList(m_uThread);
#else
						CArtiList uiList;
#endif
						uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
						uiList.SetColWidth(vctColWidth);

						vector<string> vctItems;
						for (uint32_t i = 0; i < 100; i++)
						{
							vctItems.clear();
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
							vctItems.push_back(buff);

							uiList.AddItem(vctItems);
						}

						uiList.AddButtonEx(artiGetText("FF060000001D"));					//"设置"

						/*
							"SetDefaultSelectedRow()设置默认选中行，点击[设置]按钮使用GetSelectedRow()获取当前选中行号。"
						*/
						ShowMsgBoxDemo("SetDefaultSelectedRow", artiGetText("FF060000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);

						while (1)
						{
							Delay(100);
							uRetBtn = uiList.Show();
							if (uRetBtn == DF_ID_CANCEL)
							{
								break;
							}
							else if (DF_ID_FREEBTN_0 == uRetBtn)
							{
								if (0 == uSelect)
								{
									uiList.SetDefaultSelectedRow(0);
								}
								else if (1 == uSelect)
								{
									uiList.SetDefaultSelectedRow(5);
								}
								else if (2 == uSelect)
								{
									uiList.SetDefaultSelectedRow(20);
								}
								else if (3 == uSelect)
								{
									uiList.SetDefaultSelectedRow(200);
								}

								uint16_t uRowNo = uiList.GetSelectedRow();
								memset(buff, 0, sizeof(buff));
								SPRINTF_S(buff, artiGetText("FF0000000045").c_str(), uRowNo);

								if (uRetBtn == 0xFFFF)
								{
									ShowMsgBoxDemo("SetDefaultSelectedRow", artiGetText("FF0600000063"), DF_MB_OK, DT_CENTER, -1, m_uThread);//默认选中行不存在
								}
								else
								{
									ShowMsgBoxDemo("SetDefaultSelectedRow", artiGetText("FF060000002C") + buff, DF_MB_OK, DT_LEFT, -1, m_uThread);
								}
							}
						}
					}
				}
			}
			else if ((uRet & 0xff) == 1)
			{
				vector<int32_t> vctColWidth;
				vctColWidth.push_back(40);
				vctColWidth.push_back(20);
				vctColWidth.push_back(20);
				vctColWidth.push_back(20);

				CArtiList uiList;
				vector<uint16_t> vctRowIndex;

				vctRowIndex.emplace_back(0);
				vctRowIndex.emplace_back(2);
				vctRowIndex.emplace_back(4);
				uiList.InitTitle("Select First Third Fifth");
				uiList.SetColWidth(vctColWidth);
				uiList.AddItem("First Row");
				uiList.AddItem("Second Row");
				uiList.AddItem("Other Row");
				uiList.AddItem("Other Row");
				uiList.AddItem("Fifth Row");
				uiList.AddItem("Sixth Row");
				uiList.SetDefaultSelectedRow(vctRowIndex);
				while (1)
				{
					if (DF_ID_BACK == uiList.Show())
					{
						break;
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetCheckBoxStatus()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(20);
		vctColWidth.push_back(20);
		vctColWidth.push_back(20);

#if __Multi_System_Test__
		CArtiList uiListBef(m_uThread);
#else
		CArtiList uiListBef;
#endif
		uiListBef.InitTitle(artiGetText("FF0600000077"), CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI);
		uiListBef.SetColWidth({ 100 });


#if __Multi_System_Test__
		CArtiList uiListLater(m_uThread);
#else
		CArtiList uiListLater;
#endif
		uiListLater.InitTitle(artiGetText("FF0600000078"), CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI);
		uiListLater.SetColWidth(vctColWidth);


		vector<string> vctItems;
		for (uint32_t i = 0; i < 100; i++)
		{
			vctItems.clear();
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			uiListLater.AddItem(vctItems);
		}

		for (uint32_t i = 0; i < 100; i++)
		{
			vctItems.clear();
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0600000091").c_str(), i, 0);//"默认选择第%d行"
			vctItems.push_back(buff);

			uiListBef.AddItem(vctItems);
		}



		uiListBef.AddButtonEx(artiGetText("FF060000001D"));			//"设置"		
		uiListBef.AddTipsOnLeft(artiGetText("FF0600000066"), BOLD_TYPE_BOLD);		//"选择需要被设置为选中状态的复选框"


		uiListLater.AddTipsOnLeft(artiGetText("FF0600000067"), BOLD_TYPE_BOLD);		//"设置复选框默认选中状态成功"

		vector<uint16_t> vecRow = {};
		string strRow = "";

		while (1)
		{
			uRetBtn = uiListBef.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{
				vecRow.clear();
				vecRow = uiListBef.GetSelectedRowEx();
				for (uint16_t i = 0; i < vecRow.size(); i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000045").c_str(), vecRow[i]);
					if (i != 0)
					{
						strRow = strRow + "," + buff;
					}
					else
					{
						strRow = buff;
					}
				}
				ShowMsgBoxDemo("SetDefaultSelectedRow", artiGetText("FF060000002C") + strRow, DF_MB_OK, DT_LEFT, -1, m_uThread);

				while (1)
				{
					uRetBtn = uiListLater.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
					else
					{
						for (uint32_t i = 0; i < vecRow.size(); i++)
						{
							uiListLater.SetCheckBoxStatus(vecRow[i], true);
						}
					}
				}
			}
		}
		}

	void CArtiListTest::ArtiListTest_SetButtonStatus()
	{
		uint32_t uClickNums = 0;

		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(20);
		vctColWidth.push_back(20);
		vctColWidth.push_back(20);

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
		uiList.SetColWidth(vctColWidth);

		vector<string> vctItems;
		for (uint32_t i = 0; i < 500; i++)
		{
			vctItems.clear();
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
			vctItems.push_back(buff);

			uiList.AddItem(vctItems);
		}

		uiList.AddButtonEx(artiGetText("FF060000001D"));					//"设置"
		uiList.AddButtonEx(artiGetText("FF000000000C"));					//"测试键"

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				uint32_t uStatus = 0;

				if (2 == uClickNums % 3)
				{
					uStatus = DF_ST_BTN_ENABLE;
				}
				else if (0 == uClickNums % 3)
				{
					uStatus = DF_ST_BTN_DISABLE;
				}
				else if (1 == uClickNums % 3)
				{
					uStatus = DF_ST_BTN_UNVISIBLE;
				}

				uiList.SetButtonStatus(1, uStatus);
				uClickNums++;
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				artiShowMsgBox(artiGetText("FF0100000021"), artiGetText("FF0600000068"));
			}
			}
		}

	void CArtiListTest::ArtiListTest_SetButtonText()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0600000029"));	//"设置按钮文本为空"
		uiMenu.AddItem(artiGetText("FF060000002A"));	//"设置按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF060000002B"));	//"设置按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF0600000069"));	//"设置按钮文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF060000006A"));	//"设置按钮文本中文长度达到阈值"

		string strText = "";
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

				vector<int32_t> vctColWidth;
				vctColWidth.push_back(40);
				vctColWidth.push_back(20);
				vctColWidth.push_back(20);
				vctColWidth.push_back(20);

#if __Multi_System_Test__
				CArtiList uiList(m_uThread);
#else
				CArtiList uiList;
#endif
				uiList.InitTitle(artiGetText("FF0600000000"));//"列表控件测试"
				uiList.SetColWidth(vctColWidth);

				vector<string> vctItems;
				for (uint32_t i = 0; i < 100; i++)
				{
					vctItems.clear();
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
					vctItems.push_back(buff);

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
					vctItems.push_back(buff);

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
					vctItems.push_back(buff);

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
					vctItems.push_back(buff);

					uiList.AddItem(vctItems);
				}

				uiList.AddButtonEx(artiGetText("FF060000001D"));					//"设置"
				uiList.AddButtonEx(artiGetText("FF000000000C"));					//"测试键"

				while (1)
				{
					Delay(100);
					uRetBtn = uiList.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						if (0 == uSelect)
						{
							strText = "";
						}
						else if (1 == uSelect)
						{
							strText = TextSingleLine;
						}
						else if (2 == uSelect)
						{
							strText = artiGetText("FF1200000009");
						}
						else if (3 == uSelect)
						{
							strText = artiGetText("FF1100000002");
						}
						else
						{
							strText = artiGetText("FF1200000002");
						}
						uiList.SetButtonText(1, strText);
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_GetSelectedRow()
	{
		CArtiMenu	uiMenu;
		uint32_t	uRet;

		uiMenu.InitTitle("Test tips,group mix SelectedRow");

		uiMenu.AddItem(artiGetText("FF060000006D"));	//"获取行号"
		uiMenu.AddItem(artiGetText("FF060000006F"));	//"分组后获取行号"

		while (1)
		{
			uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			vector<int32_t> vctColWidth;
			vctColWidth.push_back(40);
			vctColWidth.push_back(20);
			vctColWidth.push_back(20);
			vctColWidth.push_back(20);

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			uiList.InitTitle(artiGetText("FF0600000000"), CArtiList::eListViewType::ITEM_NO_CHECKBOX);//"列表控件测试"
			uiList.SetColWidth(vctColWidth);

			if ((uRet & 0xff) == 0)
			{
				uiList.SetTipsOnTop(artiGetText("FF060000006B"));
			}
			else if ((uRet & 0xff) == 1)
			{
				uiList.SetTipsOnTop(artiGetText("FF060000006B") + "\n" + "AddGroup" + artiGetText("FF060000006C"));
				uiList.AddGroup("AddGroup");
			}
			uiList.SetHeads(vector<string>{"HeadNames", "HeadNames", "HeadNames", "HeadNames"});
			uiList.AddItem(vector<string>{"HighLight", "HighLight", "HighLight", "HighLight"}, true);

			vector<string> vctItems;
			for (uint32_t i = 0; i < 10; i++)
			{
				vctItems.clear();
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			uiList.AddButtonEx(artiGetText("FF0100000027"));					//"返回行号"

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (DF_ID_FREEBTN_0 == uRetBtn)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, "%d", uiList.GetSelectedRow());

					ShowMsgBoxDemo(artiGetText("FF0100000028"), buff, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
			}
		}

	void CArtiListTest::ArtiListTest_GetSelectedRowEx()
	{
		CArtiMenu	uiMenu;
		uint32_t	uRet;

		uiMenu.InitTitle("Test tips,group mix SelectedRow");

		uiMenu.AddItem("SetTipsOnTop CHECKBOX_SINGLE");
		uiMenu.AddItem("SetTipsOnTop CHECKBOX_MULTI");
		uiMenu.AddItem("AddGroup CHECKBOX_SINGLE");
		uiMenu.AddItem("AddGroup CHECKBOX_MULTI");
		while (1)
		{
			uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			vector<int32_t> vctColWidth;
			vctColWidth.push_back(40);
			vctColWidth.push_back(20);
			vctColWidth.push_back(20);
			vctColWidth.push_back(20);

#if __Multi_System_Test__
			CArtiList uiList(m_uThread);
#else
			CArtiList uiList;
#endif
			if (uRet % 2 == 0)
			{
				uiList.InitTitle(artiGetText("FF0600000000"), CArtiList::eListViewType::ITEM_WITH_CHECKBOX_SINGLE);//"列表控件测试"
			}
			else if (uRet % 2 == 1)
			{
				uiList.InitTitle(artiGetText("FF0600000000"), CArtiList::eListViewType::ITEM_WITH_CHECKBOX_MULTI);//"列表控件测试"
			}
			uiList.SetColWidth(vctColWidth);
			uiList.SetBlockStatus(true);

			if ((uRet & 0xff) <= 1)
			{
				uiList.SetTipsOnTop(artiGetText("FF060000006B"));
			}
			else if ((uRet & 0xff) <= 3)
			{
				uiList.SetTipsOnTop(artiGetText("FF060000006B") + "\n" + "AddGroup" + artiGetText("FF060000006C"));
				uiList.AddGroup("AddGroup");
			}
			uiList.SetHeads(vector<string>{"HeadNames", "HeadNames", "HeadNames", "HeadNames"});
			uiList.AddItem(vector<string>{"HighLight", "HighLight", "HighLight", "HighLight"}, true);

			vector<string> vctItems;
			for (uint32_t i = 0; i < 10; i++)
			{
				vctItems.clear();
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 0);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 1);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 2);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF060000000D").c_str(), i, 3);//"第%d行 - 第%d列"
				vctItems.push_back(buff);

				uiList.AddItem(vctItems);
			}

			uiList.AddButtonEx(artiGetText("FF0100000027"));					//"返回行号"

			while (1)
			{
				Delay(100);
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (DF_ID_FREEBTN_0 == uRetBtn)
				{
					string strItem = "";
					memset(buff, 0, sizeof(buff));
					vector<uint16_t> vctSelect;
					vctSelect = uiList.GetSelectedRowEx();
					for (uint32_t i = 0; i < vctSelect.size(); i++)
					{
						if (i == 0)
						{
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, "%d", vctSelect[i]);
							strItem = strItem + buff;
						}
						else
						{
							memset(buff, 0, sizeof(buff));
							SPRINTF_S(buff, " %d", vctSelect[i]);
							strItem = strItem + buff;
						}
					}

					ShowMsgBoxDemo(artiGetText("FF0100000028"), artiGetText("FF0600000092") + strItem, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
			}

		}

	void CArtiListTest::ArtiListTest_Show()
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
				ArtiListTest_Show_Type1();
			}
			else if (1 == uRetBtn)
			{
				ArtiListTest_Show_Type2();
			}
		}
	}

	void CArtiListTest::ArtiListTest_Show_Type1()
	{
		CArtiList uiList;
		uiList.InitTitle(artiGetText("FF0000000110"));
		uiList.SetColWidth(vector<int32_t>{40, 40, 20});
		uiList.AddItem(vector<string>{artiGetText("FF0000000112"), "0", "ms"});//"响应时间"
		uiList.AddButtonEx("Test");

		while (1)
		{
			time_t time_start = GetSysTime();
			uRetBtn = uiList.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				break;
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				time_t time_end = GetSysTime();
				uiList.SetItem(0, 1, uint32ToString(time_end - time_start));
			}
		}
	}

	void CArtiListTest::ArtiListTest_Show_Type2()
	{
		CArtiList uiList1;
		uiList1.InitTitle(artiGetText("FF0000000111"));//"连续点击按键测试"
		uiList1.SetColWidth(vector<int32_t>{40, 40, 20});
		uiList1.AddItem(vector<string>{"Sleep Time", "0", "s"});
		uiList1.AddButtonEx("Sleep 0 s");
		uiList1.AddButtonEx("Sleep 2 s");
		uiList1.AddButtonEx("Sleep 4 s");
		uiList1.AddButtonEx("Sleep 6 s");
		uiList1.AddButtonEx("Sleep 8 s");

		while (1)
		{
			Delay(100);
			uRetBtn = uiList1.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				return;
			}
			else if ((uRetBtn >= DF_ID_FREEBTN_0) && (uRetBtn <= DF_ID_FREEBTN_0 + 4))
			{
				uiList1.SetItem(0, 1, uint32ToString((uRetBtn - DF_ID_FREEBTN_0) * 2));
				Delay((uRetBtn - DF_ID_FREEBTN_0) * 2000);
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetSelectedType()
	{

		CArtiMenu	uiMenu;

		uiMenu.InitTitle("ArtiListTest_SetSelectedType");

		uiMenu.AddItem(artiGetText("FF060000006E"));	//"设置任意行都可以被选中"
		uiMenu.AddItem(artiGetText("FF0600000070"));	//"设置所有行都不能被选中"

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			CArtiList uiList;

			uiList.InitTitle("Key information");
			uiList.SetColWidth(vector<int32_t>{30, 40, 30});
			uiList.AddItem(vector<string>{"Key1", "", ""});
			uiList.AddItem(vector<string>{"Key2", "", ""});
			uiList.AddItem(vector<string>{"Key3", "", ""});
			uiList.AddItem(vector<string>{"Key4", "", ""}, false);
			uiList.AddItem(vector<string>{"Key5", "", ""}, false);
			uiList.AddItem(vector<string>{"Key6", "", ""}, false);
			uiList.AddButton(artiGetText("FF0100000027"));	//获取行号
			if ((uRet & 0xff) == 0)
			{
				uiList.SetSelectedType(CArtiList::ITEM_SELECT_DEFAULT);
			}
			else
			{
				uiList.SetSelectedType(CArtiList::ITEM_SELECT_DISABLED);

				CArtiMenu	uiMenuSet;

				uiMenuSet.InitTitle("if SetDefaultSelectedRow");
				uiMenuSet.AddItem(artiGetText("FF0600000071"));
				uiMenuSet.AddItem(artiGetText("FF0600000072"));
				while (1)
				{

					uint32_t uSet = uiMenuSet.Show();
					if (uSet == DF_ID_BACK)
					{
						artiShowMsgBox("Must to Select", "Cant click back,must to select" + artiGetText("FF0600000071") + "or" + artiGetText("FF0600000072"));
						continue;
					}
					if ((uSet & 0xff) == 0)
					{
						uiList.SetDefaultSelectedRow(2);
					}
					break;
				}
			}

			while (1)
			{
				uint32_t uRetList = uiList.Show();
				if (uRetList == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetList != DF_ID_NOKEY)
				{
					uint16_t uSelcet = uiList.GetSelectedRow();

					if (uSelcet == DF_LIST_LINE_NONE)//这里表示类型为ITEM_SELECT_DISABLED
					{
						artiShowMsgBox(artiGetText("FF0600000073"), artiGetText("FF0600000093"));//未选中任意一行
					}
					else
					{
						if (uRetList & 0x00000100)
						{
							artiShowMsgBox(artiGetText("FF0600000074"), artiGetText("FF0600000092") + uint16ToString(uSelcet));
						}
					}
				}
			}
		}
	}

	void CArtiListTest::ArtiListTest_SetRowInCurrentScreen()
	{
		CArtiMenu	uiMenu;

		uiMenu.InitTitle("SetRowInCurrentScreen Type");
		uiMenu.AddItem(artiGetText("FF0600000075"));	//"设置的行号是当前屏的首行"
		uiMenu.AddItem(artiGetText("FF0600000076"));	//"设置的行号是当前屏的末行"

		while (1)
		{
			uint32_t uRetMenu = uiMenu.Show();
			if (uRetMenu == DF_ID_BACK)
			{
				break;
			}

			CArtiList uiList;

			uiList.InitTitle("SetRowInCurrentScreen");
			uiList.SetColWidth(vector<int32_t>{30, 40, 30});

			for (uint32_t i = 0; i < 50; i++)
			{
				string	strStep = "Step";

				strStep += uint32ToString(i + 1);
				uiList.AddItem(strStep);
			}

			uiList.SetSelectedType(CArtiList::ITEM_SELECT_DISABLED);
			uint32_t iStep = 0;

			while (1)
			{
				uint32_t uRet = uiList.Show();
				if (uRet == DF_ID_BACK)
				{
					break;
				}
				Delay(2000);
				if (iStep > 7)
				{
					artiShowMsgBox("Test", "Test Finish");
					break;
				}
				if ((uRetMenu & 0xff) == 0)
				{
					uiList.SetRowInCurrentScreen(CArtiList::SCREEN_TYPE_FIRST_ROW, iStep * 7);
				}
				else
				{
					uiList.SetRowInCurrentScreen(CArtiList::SCREEN_TYPE_LAST_ROW, iStep * 7);
				}
				uiList.SetRowHighLight(iStep * 7);
				iStep++;
			}
		}

			}

	void CArtiListTest::ArtiListTest_SetShareButtonVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0600000049"));	//分享标题和内容文本为空
		uiMenu.AddItem(artiGetText("FF060000004A"));	//分享标题和内容文本为单行
		uiMenu.AddItem(artiGetText("FF060000004B"));	//分享标题和内容文本为多行
		uiMenu.AddItem(artiGetText("FF060000004C"));	//分享标题和内容英文长度达到阈值
		uiMenu.AddItem(artiGetText("FF060000004D"));	//分享标题和内容中文长度达到阈值

		while (1)
		{
			string strTitle = "";
			string strContent = "";
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = "";
				strContent = "";
			}
			else if (1 == uRetBtn)
			{
				strTitle = TextSingleLine;
				strContent = TextSingleLine;
			}
			else if (2 == uRetBtn)
			{
				strTitle = TextMulitLine;
				strContent = TextMulitLine;
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");
				strContent = artiGetText("FF1100000005");
			}
			else
			{
				strTitle = artiGetText("FF1200000004");
				strContent = artiGetText("FF1200000005");
			}

			CArtiList uiList;
			uiList.InitTitle("Key information");
			uiList.SetColWidth(vector<int32_t>{30, 40, 30});
			uiList.AddItem(vector<string>{"Key1", "", ""});
			uiList.AddItem(vector<string>{"Key2", "", ""});
			uiList.AddItem(vector<string>{"Key3", "", ""});
			uiList.AddItem(vector<string>{"Key4", "", ""}, false);
			uiList.AddItem(vector<string>{"Key5", "", ""}, false);
			uiList.AddItem(vector<string>{"Key6", "", ""}, false);
			uiList.SetTipsTitleOnLeft("Help information", BOLD_TYPE_BOLD);
			uiList.AddTipsOnLeft("\n\nOriginal transponder chip:\nMEGAMOS 48\nAllowed transponder chip:\nMEGAMOS 48", BOLD_TYPE_BOLD);
			uiList.SetShareButtonVisible(true, strTitle, strContent);
			while (1)
			{
				uRetBtn = uiList.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

		}