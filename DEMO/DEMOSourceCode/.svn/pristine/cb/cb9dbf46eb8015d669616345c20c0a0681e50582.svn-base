#include "DemoArtiPopupTest.h"
#include "ArtiPopup.h"
#include "DemoMaco.h"
#include "PublicInterface.h"
#include "DemoPublicAPI.h"
namespace Topdon_AD900_Demo {

	typedef void (CArtiPopupTest::* func)();

	void CArtiPopupTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;
		map<uint32_t, func> mapTestFunc;

		CArtiMenu uiMenu;
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");				mapTestFunc.emplace(make_pair(0, &CArtiPopupTest::ArtiPopupTest_InitTitle));
		uiMenu.AddItem("SetTitle");					mapTestFunc.emplace(make_pair(1, &CArtiPopupTest::ArtiPopupTest_SetTitle));
		uiMenu.AddItem("SetContent");				mapTestFunc.emplace(make_pair(2, &CArtiPopupTest::ArtiPopupTest_SetContent));
		uiMenu.AddItem("SetPopDirection");			mapTestFunc.emplace(make_pair(3, &CArtiPopupTest::ArtiPopupTest_SetPopDirection));
		uiMenu.AddItem("AddButton");				mapTestFunc.emplace(make_pair(4, &CArtiPopupTest::ArtiPopupTest_AddButton));
		uiMenu.AddItem("SetButtonText");			mapTestFunc.emplace(make_pair(5, &CArtiPopupTest::ArtiPopupTest_SetButtonText));
		uiMenu.AddItem("SetColWidth");				mapTestFunc.emplace(make_pair(6, &CArtiPopupTest::ArtiPopupTest_SetColWidth));
		uiMenu.AddItem("AddItem");					mapTestFunc.emplace(make_pair(7, &CArtiPopupTest::ArtiPopupTest_AddItem));
		
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (mapTestFunc.find(uRetBtn & 0xFF) != mapTestFunc.end())
			{
				(this->*mapTestFunc[uRetBtn & 0xFF])();
			}
		}
	}

	void CArtiPopupTest::ArtiPopupTest_InitTitle()
	{
		CArtiList uiList;
		uiList.InitTitle("InitTitle");
		uiList.SetColWidth(vctColWidth2);		
		uiList.AddItem("uPopupType");
		uiList.AddItem("strTitle");
		uiList.AddButtonEx("Test");

		string strTitleList = artiGetText("FF1300000002"); //"标题文本为单行"	
		string strTitle = "";
		uint32_t uPopupType = DF_POPUP_TYPE_MSG;
		string strPopupType = "DF_POPUP_TYPE_MSG";		

		uiList.SetItem(0, 1, strPopupType);
		uiList.SetItem(1, 1, strTitleList);

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				CArtiPopup uiPopup;
				uiPopup.InitTitle(strTitle, uPopupType);
				if (uPopupType == DF_POPUP_TYPE_MSG)
				{
					uiPopup.SetContent(artiGetText("FF090000002B"));
				}
				else
				{
					uiPopup.SetColWidth(vector<uint32_t>{20,50,30});

					CBinary binText = CBinary("\xFF\x00\x00\x00\x01\x20", 6);
					for (uint8_t i = 0; i < 8; i++)
					{
						binText.SetAt(5, i + 0x20);
						string strText = artiGetText(binText);

						vector<string> vctItem = SeparateString(strText, "$");
						uiPopup.AddItem(vctItem);
					}
				}
				uiPopup.Show();
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uPopupType, strPopupType, mapPopupType);
					uiList.SetItem(0, 1, strPopupType);
				}
				else if (1 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
					uiTitleMenu.AddItem(artiGetText("FF1300000001"));	//"标题文本为空"
					uiTitleMenu.AddItem(artiGetText("FF1300000002"));	//"标题文本为单行"			
					uiTitleMenu.AddItem(artiGetText("FF1300000003"));	//"标题文本为多行"				
					uiTitleMenu.AddItem(artiGetText("FF1300000004"));	//"标题文本为英文且长度达到阈值"
					uiTitleMenu.AddItem(artiGetText("FF1300000005"));	//"标题文本为中文且长度达到阈值"

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
							strTitleList = artiGetText("FF1300000001");
						}
						else if (1 == uRetBtn)
						{
							strTitle = TextSingleLine;
							strTitleList = artiGetText("FF1300000002");
						}
						else if (2 == uRetBtn)
						{
							strTitle = TextMulitLineValue;
							strTitleList = artiGetText("FF1300000003");
						}
						else if (3 == uRetBtn)
						{
							strTitle = artiGetText("FF1100000004");
							strTitleList = artiGetText("FF1300000004");
						}
						else if (4 == uRetBtn)
						{
							strTitle = artiGetText("FF1200000004");
							strTitleList = artiGetText("FF1300000005");
						}
						break;
					}
					uiList.SetItem(1, 1, strTitleList);
				}
			}
		}
	}

	void CArtiPopupTest::ArtiPopupTest_SetTitle()
	{
		uint32_t clickNums = 0;		
		string strTitle = "";

		CArtiPopup uiPopup;
		
		uiPopup.InitTitle("ArtiPopupTest_SetTitle", DF_POPUP_TYPE_LIST);
		uiPopup.SetContent(artiGetText("FF0900000003"));
		uiPopup.AddButton(artiGetText("FF0000000009"));//"取消"
		uiPopup.AddButton(artiGetText("FF000000000B"));//"切换文本长度"
		uiPopup.SetColWidth(vector<uint32_t>{20, 50, 30});

		CBinary binText = CBinary("\xFF\x00\x00\x00\x01\x20", 6);
		for (uint8_t i = 0; i < 8; i++)
		{
			binText.SetAt(5, i + 0x20);
			string strText = artiGetText(binText);

			vector<string> vctItem = SeparateString(strText, "$");
			uiPopup.AddItem(vctItem);
		}

		while (1)
		{
			uRetBtn = uiPopup.Show();
			if (uRetBtn == DF_ID_FREEBTN_0 || uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{				
				if (clickNums % 5 == 0)
				{
					strTitle = "";
				}
				else if (clickNums % 5 == 1)
				{
					strTitle = TextSingleLine;
				}
				else if (clickNums % 5 == 2)
				{
					strTitle = TextMulitLineTitle;
				}
				else if (clickNums % 5 == 3)
				{
					strTitle = artiGetText("FF1100000004");
				}
				else if (clickNums % 5 == 4)
				{
					strTitle = artiGetText("FF1200000004");
				}
				clickNums++;	
				ShowMsgBoxDemo("SetTitle", artiGetText("FF0900000050") + strTitle);
				uiPopup.SetTitle(strTitle);
			}
		}
	}

	void CArtiPopupTest::ArtiPopupTest_SetContent()
	{

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0900000052"));	//"消息框居中弹出"
		uiMenu.AddItem(artiGetText("FF0900000053"));	//"消息框底部弹出"

		uint32_t clickNums = 0;
		string strContent = "";
		string strContentThresholdCn = "";
		string strContentThresholdEn = "";

		CArtiPopup uiPopup;

		uiPopup.InitTitle("ArtiPopupTest_SetContent", DF_POPUP_TYPE_MSG);
		uiPopup.SetContent(artiGetText("FF0900000003"));
		uiPopup.AddButton(artiGetText("FF0000000009"));//"取消"
		uiPopup.AddButton(artiGetText("FF000000000B"));//"切换文本长度"			

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strContentThresholdEn = artiGetText("FF1100000005");	//居中弹出阈值（0,4000）
				strContentThresholdCn = artiGetText("FF1200000005");
				uiPopup.SetPopDirection(DF_POPUP_DIR_CENTER);
			}
			else if (1 == uRetBtn)
			{
				strContentThresholdEn = artiGetText("FF1100000008");	//底部弹出阈值（0,100000）
				strContentThresholdCn = artiGetText("FF1200000008");
				uiPopup.SetPopDirection(DF_POPUP_DIR_BOTTOM);
			}
			uiPopup.SetContent(TextSingleLine);
			clickNums = 0;
			while (1)
			{
				uRetBtn = uiPopup.Show();
				if (uRetBtn == DF_ID_FREEBTN_0 || uRetBtn == DF_ID_BACK)
				{
					break;
				}				
				else if (uRetBtn == DF_ID_FREEBTN_1)
				{
					if (clickNums % 5 == 0)
					{
						strContent = "";
					}
					else if (clickNums % 5 == 1)
					{
						strContent = TextSingleLine;
					}
					else if (clickNums % 5 == 2)
					{
						strContent = TextMulitLineTitle;
					}
					else if (clickNums % 5 == 3)
					{
						strContent = strContentThresholdEn;
					}
					else if (clickNums % 5 == 4)
					{
						strContent = strContentThresholdCn;
					}
					clickNums++;
					ShowMsgBoxDemo("SetContent", artiGetText("FF0900000051") + strContent);
					uiPopup.SetContent(strContent);
				}
			}
		}							
	}

	void CArtiPopupTest::ArtiPopupTest_SetPopDirection()
	{
		CArtiList uiList;
		uiList.InitTitle("SetPopDirection");
		uiList.SetColWidth(vctColWidth2);
		uiList.AddItem("uDirection");
		uiList.AddButtonEx("Test");

		uint32_t uDirection = DF_POPUP_DIR_TOP;
		string strDirection = "DF_POPUP_DIR_TOP";

		uiList.SetItem(0, 1, strDirection);

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				CArtiPopup uiPopup;
				uiPopup.InitTitle("SetPopDirection", DF_POPUP_TYPE_MSG);
				uiPopup.SetContent(artiGetText("FF090000002B"));
				uiPopup.AddButton(artiGetText("FF000000000A"));//"确定"
				uiPopup.Show();
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uDirection, strDirection, mapPopupDirection);
					uiList.SetItem(0, 1, strDirection);
					if (uDirection == DF_POPUP_DIR_TOP || uDirection == DF_POPUP_DIR_LEFT || uDirection == DF_POPUP_DIR_RIGHT)
					{
						ShowMsgBoxDemo("Tips", artiGetText("FF0900000058"));
					}
				}
			}
		}
	}

	void CArtiPopupTest::ArtiPopupTest_AddButton()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0900000037"));	 // "按钮文本为空"
		uiMenu.AddItem(artiGetText("FF0900000038"));	 // "按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF0900000039"));	 // "按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF090000003A"));	 // "按钮英文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF090000003B"));	 // "按钮中文文本长度达到阈值"
		uiMenu.AddItem(artiGetText("FF090000003C"));	 // "添加按钮数量达到阈值"

		string strButton = "";	
		uint32_t uPopRetBtn = DF_ID_NOKEY;		

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strButton = "";
			}
			else if (1 == uRetBtn)
			{
				strButton = TextSingleLine;
			}
			else if (2 == uRetBtn)
			{
				strButton = artiGetText("FF1200000009");
			}
			else if (3 == uRetBtn)
			{
				strButton = artiGetText("FF1100000002");
			}
			else if (4 == uRetBtn)
			{
				strButton = artiGetText("FF1200000002");
			}

			CArtiPopup uiPopup;
			uiPopup.InitTitle(artiGetText("FF090000000B"), DF_POPUP_TYPE_MSG);
			uiPopup.SetContent(artiGetText("FF0900000059"));	//"测试AddButton接口"
			uiPopup.AddButton(artiGetText("FF000000000A"));		//"确定"
			uint32_t buttonNums = 1;

			while (1)
			{
				uPopRetBtn = uiPopup.Show();
				if (uPopRetBtn == DF_ID_BACK)
				{
					break;
				}
				else if (uPopRetBtn == DF_ID_FREEBTN_0 && uRetBtn != 5)
				{
					uiPopup.AddButton(strButton);
					buttonNums++;
				}
				else if (uPopRetBtn == DF_ID_FREEBTN_0 && uRetBtn == 5)
				{
					for (uint32_t i = 0;i < 30;i++)
					{
						uiPopup.AddButton(artiGetText("FF000000000C") + to_string(buttonNums++));
					}
				}
			}
		}		
		
	}

	void CArtiPopupTest::ArtiPopupTest_SetButtonText()
	{

		uint32_t clickNums = 0;
		string strButton = "";

		CArtiPopup uiPopup;		
		uiPopup.InitTitle(artiGetText("FF0900000015"), DF_POPUP_TYPE_MSG);
		uiPopup.SetContent(artiGetText("FF0900000003"));		
		uiPopup.AddButton(artiGetText("FF000000000A"));		//"确定"
		uiPopup.AddButton(artiGetText("FF000000000C"));		//"测试键";

		while (1)
		{
			uRetBtn = uiPopup.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_0)
			{				
				if (clickNums % 5 == 0)
				{
					strButton = "";
				}
				if (clickNums % 5 == 1)
				{
					strButton = TextSingleLine;
				}
				if (clickNums % 5 == 2)
				{
					strButton = TextMulitLineTitle;
				}
				if (clickNums % 5 == 3)
				{
					strButton = artiGetText("FF1100000002");
				}
				if (clickNums % 5 == 4)
				{
					strButton = artiGetText("FF1200000002");
				}				
				uiPopup.SetButtonText(1, strButton);
				clickNums++;
			}			
		}

	}

	void CArtiPopupTest::ArtiPopupTest_SetColWidth()
	{
		CArtiList uiList;
		uiList.InitTitle("SetColWidth");
		uiList.SetColWidth(vctColWidth2);
		uiList.AddItem("vctColWidth");
		uiList.AddButtonEx("Test");

		vector<uint32_t> vctColWidth = {100};
		string strColWidth = "{100}";

		uiList.SetItem(0, 1, strColWidth);

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				CArtiPopup uiPopup;
				uiPopup.InitTitle("SetColWidth", DF_POPUP_TYPE_LIST);
				uiPopup.SetColWidth(vctColWidth);

				string strText = artiGetText("FF060000000D");//"第%d行 - 第%d列"
				for (uint32_t i = 0; i < 3; i++)
				{
					vector<string> vctItems;
					for (uint32_t j = 0 ; j < vctColWidth.size(); j++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, strText.c_str(), i, j);
						vctItems.push_back(buff);
					}
					uiPopup.AddItem(vctItems);
				}
				uiPopup.AddButton(artiGetText("FF000000000A"));//"确定"
				uiPopup.Show();
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(vctColWidth, strColWidth, mapColWidth);
					uiList.SetItem(0, 1, strColWidth);
				}
			}
		}
	}

	void CArtiPopupTest::ArtiPopupTest_AddItem()
	{
		uint32_t uRowNum = 1;
		uint32_t uColNum = 1;
		string  strRowNum = "1";
		string strColNum = "1";
		string strValueList = artiGetText("FF090000005A");

		string strValue = "";

		CArtiList uiList;
		uiList.InitTitle("AddItem");
		uiList.SetColWidth(vctColWidth2);
		uiList.AddItem(artiGetText("FF00000000DD"));//"行数"
		uiList.AddItem(artiGetText("FF00000000DE"));//"列数"
		uiList.AddItem("listValue");				//"各列值"
		uiList.AddButtonEx("Test");

		uiList.SetItem(0, 1, strRowNum);
		uiList.SetItem(1, 1, strColNum);
		uiList.SetItem(2, 1, strValueList);

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				vector<uint32_t> vctColWidth;
				vctColWidth.clear();
				for (uint32_t i = 0; i < uColNum; i++)
				{
					vctColWidth.push_back(100 / uColNum);
				}
				
				//显示界面
				CArtiPopup uiPopup;
				uiPopup.InitTitle("SetColWidth", DF_POPUP_TYPE_LIST);
				uiPopup.SetColWidth(vctColWidth);
			
				for (uint32_t i = 0; i < uRowNum; i++)
				{
					vector<string> vctItems;
					for (uint32_t j = 0; j < vctColWidth.size(); j++)
					{						
						vctItems.push_back(strValue);
					}
					uiPopup.AddItem(vctItems);
				}
				uiPopup.AddButton(artiGetText("FF000000000A"));//"确定"
				uiPopup.Show();
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uRowNum, strRowNum, mapRowNum);
					uiList.SetItem(0, 1, strRowNum);
				}
				else if (1 == uSelect)
				{
					GetParamValue(uColNum, strColNum, mapListNum);
					uiList.SetItem(1, 1, strColNum);
				}
				else if (2 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiMenu(m_uThread);
#else
					CArtiMenu uiMenu;
#endif
					uiMenu.InitTitle(artiGetText("FF0000000002"));
					uiMenu.AddItem(artiGetText("FF090000005A"));	 // "各列值为空"
					uiMenu.AddItem(artiGetText("FF090000005B"));	 // "各列值为单行"
					uiMenu.AddItem(artiGetText("FF090000005C"));	 // "各列值为多行"
					uiMenu.AddItem(artiGetText("FF090000005D"));	 // "各列值英文文本长度达到阈值"
					uiMenu.AddItem(artiGetText("FF090000005E"));	 // "各列值中文文本长度达到阈值"
					

					while (1)
					{
						uRetBtn = uiMenu.Show();
						if (uRetBtn == DF_ID_BACK)
						{
							break;
						}
						else if (uRetBtn == 0)
						{
							strValue = "";
							strValueList = artiGetText("FF090000005A");
						}
						else if (uRetBtn == 1)
						{
							strValue = TextSingleLine;
							strValueList = artiGetText("FF090000005B");
						}
						else if (uRetBtn == 2)
						{
							strValue = TextMulitLineTitle;
							strValueList = artiGetText("FF090000005C");
						}
						else if (uRetBtn == 3)
						{
							strValue = artiGetText("FF1100000005");
							strValueList = artiGetText("FF090000005D");
						}
						else if (uRetBtn == 4)
						{
							strValue = artiGetText("FF1200000005");
							strValueList = artiGetText("FF090000005E");
						}
						uiList.SetItem(2, 1, strValueList);
						break;
					}
				}
			}
		}
	}


}