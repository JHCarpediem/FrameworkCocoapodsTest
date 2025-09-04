#include "DemoArtiMsgBoxTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiMsgBoxTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitMsgBox");					vctMenuID.push_back(0);
		uiMenu.AddItem("SetTitle");						vctMenuID.push_back(1);
		uiMenu.AddItem("SetContent");					vctMenuID.push_back(2);
		uiMenu.AddItem("AddButton");					vctMenuID.push_back(3);
		uiMenu.AddItem("AddButtonEx");					vctMenuID.push_back(12);
		uiMenu.AddItem("DelButton");					vctMenuID.push_back(13);
		uiMenu.AddItem("SetButtonType");				vctMenuID.push_back(4);
		uiMenu.AddItem("SetButtonStatus");				vctMenuID.push_back(5);
		uiMenu.AddItem("SetButtonText");				vctMenuID.push_back(6);
		uiMenu.AddItem("GetButtonText");				vctMenuID.push_back(14);
		uiMenu.AddItem("SetAlignType");					vctMenuID.push_back(7);
		uiMenu.AddItem("SetTimer");						vctMenuID.push_back(8);
		uiMenu.AddItem("SetBusyVisible");				vctMenuID.push_back(9);
		uiMenu.AddItem("SetProcessBarVisible");			vctMenuID.push_back(10);
		uiMenu.AddItem("SetProgressBarPercent");		vctMenuID.push_back(11);
		uiMenu.AddItem(artiGetText("FF0900000049"));	vctMenuID.push_back(15);

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
					ArtiMsgBoxTest_InitMsgBox();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetTitle();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetContent();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_AddButton();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetButtonType();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetButtonStatus();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetButtonText();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetAlignType();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetTimer();
				}
				else if (9 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetBusyVisible();
				}
				else if (10 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetProcessBarVisible();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_SetProgressBarPercent();
				}
				else if (12 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_AddButtonEx();
				}
				else if (13 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_DelButton();
				}
				else if (14 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_GetButtonText();
				}
				else if (15 == vctMenuID[uRetBtn])
				{
					ArtiMsgBoxTest_MultiInterface();
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_InitMsgBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("InitMsgBox");
		uiMenu.AddItem("uButtonType");
		uiMenu.AddItem("uAlignType");
		uiMenu.AddItem("iTimer");
		uiMenu.AddItem("strTitle");
		uiMenu.AddItem("strContent");

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				vector<uint32_t> vctBtnID;
				vector<string> vctBtnType;
				vctBtnType.push_back("DF_MB_NOBUTTON");     vctBtnID.push_back(DF_MB_NOBUTTON);
				vctBtnType.push_back("DF_MB_YES");          vctBtnID.push_back(DF_MB_YES);
				vctBtnType.push_back("DF_MB_NO");           vctBtnID.push_back(DF_MB_NO);
				vctBtnType.push_back("DF_MB_YESNO");        vctBtnID.push_back(DF_MB_YESNO);
				vctBtnType.push_back("DF_MB_OK");           vctBtnID.push_back(DF_MB_OK);
				vctBtnType.push_back("DF_MB_CANCEL");       vctBtnID.push_back(DF_MB_CANCEL);
				vctBtnType.push_back("DF_MB_OKCANCEL");     vctBtnID.push_back(DF_MB_OKCANCEL);
				vctBtnType.push_back("DF_MB_FREE");			vctBtnID.push_back(DF_MB_FREE);
#if __Multi_System_Test__
				CArtiMenu uiMenu0(m_uThread);
#else
				CArtiMenu uiMenu0;
#endif

				uiMenu0.InitTitle("uButtonType");
				for (uint32_t uCnt = 0; uCnt < vctBtnType.size(); uCnt++)
				{
					uiMenu0.AddItem(vctBtnType[uCnt]);
				}
				while (1)
				{
					uRetBtn = uiMenu0.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
					else
					{
#if __Multi_System_Test__
						CArtiMsgBox uiMsgBox(m_uThread);
#else
						CArtiMsgBox uiMsgBox;
#endif																		
						if (vctBtnID[uRetBtn] == DF_MB_NOBUTTON)
						{
							uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF090000000D"), vctBtnID[uRetBtn]);
							uiMsgBox.Show();
							Delay(5000);
						}
						else if (vctBtnID[uRetBtn] == DF_MB_YES || vctBtnID[uRetBtn] == DF_MB_NO ||
							vctBtnID[uRetBtn] == DF_MB_OK || vctBtnID[uRetBtn] == DF_MB_CANCEL || vctBtnID[uRetBtn] == DF_MB_YESNO || vctBtnID[uRetBtn] == DF_MB_OKCANCEL)
						{
							uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF090000005F"), vctBtnID[uRetBtn]);
							uiMsgBox.Show();
						}
						else if (vctBtnID[uRetBtn] == DF_MB_FREE)
						{
							uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF090000005F"), vctBtnID[uRetBtn]);
							uiMsgBox.AddButton("Test");
							while (1)
							{
								uRetBtn = uiMsgBox.Show();
								if (uRetBtn == DF_ID_BACK || uRetBtn == DF_ID_FREEBTN_0)
								{
									break;
								}
							}						
						}
					}
				}
			}
			else if (1 == uRetBtn)
			{
				vector<uint32_t> vctAlignTypeID;
				vector<string> vctAlignType;
				vctAlignType.push_back("DT_LEFT");     vctAlignTypeID.push_back(DT_LEFT);
				vctAlignType.push_back("DT_CENTER");   vctAlignTypeID.push_back(DT_CENTER);
				vctAlignType.push_back("DT_RIGHT");    vctAlignTypeID.push_back(DT_RIGHT);

#if __Multi_System_Test__
				CArtiMenu uiMenu1(m_uThread);
#else
				CArtiMenu uiMenu1;
#endif
				uiMenu1.InitTitle("AlignType");
				for (uint32_t uCnt = 0; uCnt < vctAlignType.size(); uCnt++)
				{
					uiMenu1.AddItem(vctAlignType[uCnt]);
				}
				while (1)
				{
					uRetBtn = uiMenu1.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
					else
					{
#if __Multi_System_Test__
						CArtiMsgBox uiMsgBox(m_uThread);
#else
						CArtiMsgBox uiMsgBox;
#endif
						/*
						* "测试InitMsgBox接口"
						* "这是一个测试程序！\n点击[确定]开始测试！"
						*/
						uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000003"), DF_MB_OK, vctAlignTypeID[uRetBtn]);
						uiMsgBox.Show();
					}
				}
			}
			else if (2 == uRetBtn)
			{
				vector<int32_t> vctiTimer;
				vector<string> vctStrTimer;
				vctStrTimer.push_back("-1");     vctiTimer.push_back(-1);
				vctStrTimer.push_back("500");    vctiTimer.push_back(500);
				vctStrTimer.push_back("2000");   vctiTimer.push_back(2000);
				vctStrTimer.push_back("5000");   vctiTimer.push_back(5000);

#if __Multi_System_Test__
				CArtiMenu uiMenu2(m_uThread);
#else
				CArtiMenu uiMenu2;
#endif
				uiMenu2.InitTitle("iTimer");
				for (uint32_t uCnt = 0; uCnt < vctStrTimer.size(); uCnt++)
				{
					uiMenu2.AddItem(vctStrTimer[uCnt]);
				}
				while (1)
				{
					uRetBtn = uiMenu2.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
					else
					{
#if __Multi_System_Test__
						CArtiMsgBox uiMsgBox(m_uThread);
#else
						CArtiMsgBox uiMsgBox;
#endif
						/*
						* "测试InitMsgBox接口"
						* "这是一个测试程序！\niTimer为界面阻塞时间（毫秒）！"
						*/
						uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000004"), DF_MB_OK, DT_LEFT, vctiTimer[uRetBtn]);
						uiMsgBox.Show();
					}
				}
			}
			else if (3 == uRetBtn)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu1(m_uThread);
#else
				CArtiMenu uiMenu1;
#endif	
				uiMenu1.InitTitle("AlignType");
				uiMenu1.AddItem(artiGetText("FF1300000001"));	//"标题为空文本"
				uiMenu1.AddItem(artiGetText("FF1300000002"));	//"标题为单行文本"
				uiMenu1.AddItem(artiGetText("FF1300000003"));	//"标题为多行文本"
				uiMenu1.AddItem(artiGetText("FF1300000004"));	//"标题英文文本长度达到阈值"
				uiMenu1.AddItem(artiGetText("FF1300000005"));	//"标题中文文本长度达到阈值"
				string strTitle = "";

				while (1)
				{
					uRetBtn = uiMenu1.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
					else if (uRetBtn == 0)
					{
						strTitle = "";
					}
					else if (uRetBtn == 1)
					{
						strTitle = TextSingleLine;
					}
					else if (uRetBtn == 2)
					{
						strTitle = TextMulitLineTitle;
					}
					else if (uRetBtn == 3)
					{
						strTitle = artiGetText("FF1100000004");
					}
					else if (uRetBtn == 4)
					{
						strTitle = artiGetText("FF1200000004");
					}
#if __Multi_System_Test__
					CArtiMsgBox uiMsgBox(m_uThread);
#else
					CArtiMsgBox uiMsgBox;
#endif						
					uiMsgBox.InitMsgBox(strTitle, artiGetText("FF0900000040"), DF_MB_OK, DT_CENTER);
					uiMsgBox.Show();
				}
			}
			else if (4 == uRetBtn)
			{
#if __Multi_System_Test__
				CArtiMenu uiMenu1(m_uThread);
#else
				CArtiMenu uiMenu1;
#endif	
				uiMenu1.InitTitle("AlignType");
				uiMenu1.AddItem(artiGetText("FF0900000031"));	//"内容文本为空文本"
				uiMenu1.AddItem(artiGetText("FF0900000032"));	//"内容文本为单行短文本"
				uiMenu1.AddItem(artiGetText("FF0900000033"));	//"内容文本为单行短文本"
				uiMenu1.AddItem(artiGetText("FF0900000034"));	//"内容文本为多行文本"
				uiMenu1.AddItem(artiGetText("FF0900000035"));	//"内容文本为英文且长度达到阈值"
				uiMenu1.AddItem(artiGetText("FF0900000036"));	//"内容文本为中文且长度达到阈值"
				string strContent = "";

				while (1)
				{
					uRetBtn = uiMenu1.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
					else if (uRetBtn == 0)
					{
						strContent = "";
					}
					else if (uRetBtn == 1)
					{
						strContent = TextSingleLine;
					}
					else if (uRetBtn == 2)
					{
						strContent = artiGetText("FF120000000A");
					}
					else if (uRetBtn == 3)
					{
						strContent = TextMulitLineTitle;
					}
					else if (uRetBtn == 4)
					{
						strContent = artiGetText("FF1100000008");
					}
					else if (uRetBtn == 5)
					{
						strContent = artiGetText("FF1200000008");
					}
#if __Multi_System_Test__
					CArtiMsgBox uiMsgBox(m_uThread);
#else
					CArtiMsgBox uiMsgBox;
#endif						
					uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), strContent, DF_MB_OK, DT_CENTER);
					uiMsgBox.Show();
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetTitle()
	{
		string strTitle = "";
		uint32_t uClickNums = 0; ;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif

		uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000042"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF0900000041"));//"切换标题文本"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				if (uClickNums % 5 == 0)
				{
					strTitle = "";
				}
				else if (uClickNums % 5 == 1)
				{
					strTitle = TextSingleLine;
				}
				else if (uClickNums % 5 == 2)
				{
					strTitle = TextMulitLineTitle;
				}
				else if (uClickNums % 5 == 3)
				{
					strTitle = artiGetText("FF1100000004");
				}
				else if (uClickNums % 5 == 4)
				{
					strTitle = artiGetText("FF1200000004");
				}
				uClickNums++;
				uiMsgBox.SetTitle(strTitle);
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetContent()
	{
		string strContent = "";
		uint32_t uClickNums = 0; ;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif

		uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000044"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"		
		uiMsgBox.AddButtonEx(artiGetText("FF0900000043"));//"切换内容文本"


		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				if (uClickNums % 6 == 0)
				{
					strContent = "";
				}
				else if (uClickNums % 6 == 1)
				{
					strContent = TextSingleLine;
				}
				else if (uClickNums % 6 == 2)
				{
					strContent = artiGetText("FF120000000A");
				}
				else if (uClickNums % 6 == 3)
				{
					strContent = TextMulitLineTitle;
				}
				else if (uClickNums % 6 == 4)
				{
					strContent = artiGetText("FF1100000008");
				}
				else if (uClickNums % 6 == 5)
				{
					strContent = artiGetText("FF1200000008");
				}
				uClickNums++;
				uiMsgBox.SetContent(strContent);
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_AddButton()
	{
		string strButton = "";
		uint32_t uClickNums = 0;
		uint32_t uButtonNums = 4;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif

		uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000046"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		uiMsgBox.AddButtonEx(artiGetText("FF0900000045"));//"切换文本"
		uiMsgBox.AddButtonEx(artiGetText("FF0900000047"));//"阈值"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uiMsgBox.AddButton(strButton);
				uButtonNums++;
			}
			else if (uRetBtn == DF_ID_FREEBTN_2)
			{
				if (uClickNums % 5 == 0)
				{
					strButton = "";
				}
				else if (uClickNums % 5 == 1)
				{
					strButton = TextSingleLine;
				}
				else if (uClickNums % 5 == 2)
				{
					strButton = artiGetText("FF1200000009");
				}
				else if (uClickNums % 5 == 3)
				{
					strButton = artiGetText("FF1100000002");
				}
				else if (uClickNums % 5 == 4)
				{
					strButton = artiGetText("FF1200000002");
				}
				uClickNums++;
			}
			else if (uRetBtn == DF_ID_FREEBTN_3)
			{
				for (uint32_t i = uClickNums; i <= 32; i++)
				{
					uiMsgBox.AddButton(artiGetText("FF0900000017") + to_string(i));
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_AddButtonEx()
	{
		string strButton = "";
		uint32_t uClickNums = 0;
		uint32_t uButtonNums = 4;
		uint32_t uButtonID = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif

		uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000046"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		uiMsgBox.AddButtonEx(artiGetText("FF0900000045"));//"切换内容文本"
		uiMsgBox.AddButtonEx(artiGetText("FF0900000047"));//"添加按钮数量到阈值(32)"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uButtonID = uiMsgBox.AddButtonEx(strButton);
				uButtonNums++;
				ShowMsgBoxDemo("Button ID", strButton + ":" + to_string(uButtonID));
			}
			else if (uRetBtn == DF_ID_FREEBTN_2)
			{
				if (uClickNums % 5 == 0)
				{
					strButton = "";
				}
				else if (uClickNums % 5 == 1)
				{
					strButton = TextSingleLine;
				}
				else if (uClickNums % 5 == 2)
				{
					strButton = TextMulitLineTitle;
				}
				else if (uClickNums % 5 == 3)
				{
					strButton = artiGetText("FF1100000002");
				}
				else if (uClickNums % 5 == 4)
				{
					strButton = artiGetText("FF1200000002");
				}
				uClickNums++;
			}
			else if (uRetBtn == DF_ID_FREEBTN_3)
			{
				string  strButtonID = "";
				for (uint32_t i = uButtonNums; i <= 32; i++)
				{
					uButtonID = uiMsgBox.AddButtonEx(artiGetText("FF0900000017") + to_string(i));
					strButtonID = strButtonID + artiGetText("FF0900000017") + to_string(i) + ":" + to_string(uButtonID) + "\n";
					uClickNums++;
				}
				ShowMsgBoxDemo("Button ID", strButtonID);
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_DelButton()
	{
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif		
		uiMsgBox.InitMsgBox(artiGetText("FF090000001D"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"

		vector<uint32_t> vctBtnID;
		uiMsgBox.AddButtonEx(artiGetText("FF090000001A"));//"测试键1"
		uiMsgBox.AddButtonEx(artiGetText("FF090000001B"));//"测试键2"
		uiMsgBox.AddButtonEx(artiGetText("FF090000001C"));//"测试键3"

		vctBtnID.push_back(DF_ID_FREEBTN_2);
		vctBtnID.push_back(DF_ID_FREEBTN_3);
		vctBtnID.push_back(0x00000104);

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				if (vctBtnID.size())
				{
					uiMsgBox.DelButton(vctBtnID[vctBtnID.size() - 1]);
					vctBtnID.pop_back();
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetButtonType()
	{
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox1(m_uThread);
#else
		CArtiMsgBox uiMsgBox1;
#endif

		while (1)
		{
			//"MsgBox测试界面,点击[OK]调用SetButtonType设置按键类型."
			uiMsgBox1.InitMsgBox("MsgBox", artiGetText("FF0900000027"), DF_MB_OKCANCEL, DT_LEFT);

			uRetBtn = uiMsgBox1.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_OK)
			{
				vector<uint32_t> vctBtnID;
				vector<string> vctBtnType;
				vctBtnType.push_back("DF_MB_NOBUTTON");     vctBtnID.push_back(DF_MB_NOBUTTON);
				vctBtnType.push_back("DF_MB_YES");          vctBtnID.push_back(DF_MB_YES);
				vctBtnType.push_back("DF_MB_NO");           vctBtnID.push_back(DF_MB_NO);
				vctBtnType.push_back("DF_MB_YESNO");        vctBtnID.push_back(DF_MB_YESNO);
				vctBtnType.push_back("DF_MB_OK");           vctBtnID.push_back(DF_MB_OK);
				vctBtnType.push_back("DF_MB_CANCEL");       vctBtnID.push_back(DF_MB_CANCEL);
				vctBtnType.push_back("DF_MB_OKCANCEL");     vctBtnID.push_back(DF_MB_OKCANCEL);
				vctBtnType.push_back("DF_MB_NEXTEXIT");     vctBtnID.push_back(DF_MB_NEXTEXIT);

#if __Multi_System_Test__
				CArtiMenu uiMenu(m_uThread);
#else
				CArtiMenu uiMenu;
#endif
				uiMenu.InitTitle("ButtonType");
				for (uint32_t uCnt = 0; uCnt < vctBtnType.size(); uCnt++)
				{
					uiMenu.AddItem(vctBtnType[uCnt]);
				}

				while (1)
				{
					uRetBtn = uiMenu.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
					else if (uRetBtn < vctBtnID.size())
					{
						if (vctBtnID[uRetBtn] == DF_MB_NOBUTTON)
						{
							uiMsgBox1.SetButtonType(vctBtnID[uRetBtn]);

							uiMsgBox1.SetContent(artiGetText("FF090000000D"));

							uiMsgBox1.SetTimer(5000);

							uiMsgBox1.Show();

							Delay(5000);
						}
						else
						{
							uiMsgBox1.SetButtonType(vctBtnID[uRetBtn]);

							//点击任意按键，返回[ButtonType]选择界面
							uiMsgBox1.SetContent(artiGetText("FF0900000028"));

							uiMsgBox1.Show();
						}
					}
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetButtonStatus()
	{
		uint32_t uOffSet = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif

		uiMsgBox.InitMsgBox(artiGetText("FF0900000016"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000D"));// "测试键0";

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uOffSet += 1;
				if (uOffSet % 3 == 0)
				{
					uiMsgBox.SetButtonStatus(2, DF_ST_BTN_ENABLE);
				}
				else if (uOffSet % 3 == 1)
				{
					uiMsgBox.SetButtonStatus(2, DF_ST_BTN_DISABLE);
				}
				else
				{
					uiMsgBox.SetButtonStatus(2, DF_ST_BTN_UNVISIBLE);
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetButtonText()
	{
		uint32_t uClickNums = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif

		uiMsgBox.InitMsgBox(artiGetText("FF0900000015"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000D"));// "测试键0"
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				if (uClickNums % 5 == 0)
				{
					uiMsgBox.SetButtonText(2, "");
				}
				if (uClickNums % 5 == 1)
				{
					uiMsgBox.SetButtonText(2, TextSingleLine);
				}
				if (uClickNums % 5 == 2)
				{
					uiMsgBox.SetButtonText(2, TextMulitLineTitle);
				}
				if (uClickNums % 5 == 3)
				{
					uiMsgBox.SetButtonText(2, artiGetText("FF1100000002"));
				}
				if (uClickNums % 5 == 4)
				{
					uiMsgBox.SetButtonText(2, artiGetText("FF1200000002"));
				}
				uClickNums++;
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_GetButtonText()
	{
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiList uiList;
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* 测试GetButtonText接口
		* 设置ArtiMsgBox按键类型
		*/
		uint32_t uBtnType = DF_MB_OK;
		string strBtnText = mapDFButton[uBtnType];

		uiList.InitTitle(artiGetText("FF0900000029"));
		uiList.SetColWidth(vector<int32_t>{50, 50});
		uiList.AddItem(vector<string>{artiGetText("FF090000002A"), strBtnText});
		uiList.AddButton(artiGetText("FF000000000A"));

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
				uiMsgBox.InitMsgBox(artiGetText("FF0900000029"), artiGetText("FF0900000003"), uBtnType, DT_LEFT);

				while (1)
				{
					uint32_t uRetBtnMsg = uiMsgBox.Show();
					if (uRetBtnMsg == 0x00000000)
					{
						if (uBtnType == DF_MB_OK || uBtnType == DF_MB_OKCANCEL)
						{
							strBtnText = uiMsgBox.GetButtonText(DF_TEXT_ID_OK);
						}
						else
						{
							strBtnText = uiMsgBox.GetButtonText(DF_TEXT_ID_YES);
						}
					}
					else if (uRetBtnMsg == 0xFFFFFFFF)
					{
						if (uBtnType == DF_MB_OKCANCEL || uBtnType == DF_MB_CANCEL)
						{
							strBtnText = uiMsgBox.GetButtonText(DF_TEXT_ID_CANCEL);
						}
						else if (uBtnType == DF_MB_YESNO || uBtnType == DF_MB_NO)
						{
							strBtnText = uiMsgBox.GetButtonText(DF_TEXT_ID_NO);
						}
						else if (uBtnType == DF_MB_NEXTEXIT)
						{
							strBtnText = uiMsgBox.GetButtonText(DF_TEXT_ID_EXIT);
						}
						else
						{
							strBtnText = uiMsgBox.GetButtonText(DF_TEXT_ID_BACK);
						}
					}

					uRetBtnMsg = artiShowMsgBox("Btn Text", strBtnText, DF_MB_OKCANCEL, DT_CENTER);
					if (uRetBtnMsg == DF_ID_CANCEL)
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
					GetParamValue(uBtnType, strBtnText, mapDFButton);
					uiList.SetItem(0, 1, strBtnText);
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetAlignType()
	{
		uint32_t uOffSet = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* "测试SetAlignType接口"
		* "这是一个测试程序！\n点击[确定]开始测试！"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF090000000E"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uOffSet += 1;
				if (uOffSet % 3 == 0)
				{
					uiMsgBox.SetAlignType(DT_LEFT);
				}
				else if (uOffSet % 3 == 1)
				{
					uiMsgBox.SetAlignType(DT_CENTER);
				}
				else
				{
					uiMsgBox.SetAlignType(DT_RIGHT);
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetTimer()
	{
		//uint32_t uOffSet = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* "测试SetTimer接口"
		* "这是一个测试程序！\n点击[确定]开始测试！"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF090000000F"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uiMsgBox.SetContent(artiGetText("FF0900000010"));//"定时器已启动，界面阻塞3秒！"
				uiMsgBox.SetTimer(3000);
			}
			else
			{
				uiMsgBox.SetContent(artiGetText("FF0900000011"));//"定时器已结束，测试结束！"
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetBusyVisible()
	{
		bool bOffSet = false;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* "测试SetBusyVisible接口"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000012"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				bOffSet = !bOffSet;
				if (bOffSet)
				{
					uiMsgBox.SetBusyVisible(true);
				}
				else
				{
					uiMsgBox.SetBusyVisible(false);
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetProcessBarVisible()
	{
		bool bOffSet = false;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* "测试SetProcessBarVisible接口"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000013"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				bOffSet = !bOffSet;
				if (bOffSet)
				{
					uiMsgBox.SetProcessBarVisible(true);
				}
				else
				{
					uiMsgBox.SetProcessBarVisible(false);
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_SetProgressBarPercent()
	{
		uint32_t uOffSet = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* "测试SetProgressBarPercent接口"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000014"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF0000000009"));//"取消"
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//"确定"

		uiMsgBox.SetProcessBarVisible(true);

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uOffSet += 1;
				if (uOffSet % 3 == 0)
				{
					uiMsgBox.SetProgressBarPercent(0, 30);
				}
				else if (uOffSet % 3 == 1)
				{
					uiMsgBox.SetProgressBarPercent(15, 30);
				}
				else
				{
					uiMsgBox.SetProgressBarPercent(30, 30);
				}
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_MultiInterface()
	{
		string strTitle;
		vector<uint32_t> vctMenuID;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));									//"选择测试项"
		uiMenu.AddItem(artiGetText("FF090000001E"));	vctMenuID.push_back(0);			//"按键【增加->删除->修改文本】测试"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == vctMenuID[uRetBtn])
			{
				ArtiMsgBoxTest_MultiInterface_Sample1();
			}
		}
	}

	void CArtiMsgBoxTest::ArtiMsgBoxTest_MultiInterface_Sample1()
	{
		/*
		* 程序流程
		* 1.调用 AddButtonEx 增加 3 个按键： Btn1 \ Btn2 \ Btn3
		* 2.调用 DelButton 删除 Btn2
		* 3.调用 SetButtonText 修改 Btn1 \ Btn3 文本
		* 4.调用 SetButtonStatus 修改 Btn1 \ Btn3 状态
		* 5.调用 AddButtonEx 增加按键 Btn2
		*/

		ShowMsgBoxDemo(artiGetText("FF090000001F"), artiGetText("FF0900000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		uint32_t uIDBtn2 = 0;
#if __Multi_System_Test__
		CArtiMsgBox uiMsgBox(m_uThread);
#else
		CArtiMsgBox uiMsgBox;
#endif
		/*
		* 1.调用 AddButtonEx 增加 3 个按键： Btn1 \ Btn2 \ Btn3
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000000"), artiGetText("FF0900000021"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButtonEx(artiGetText("FF000000000A"));//确定
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				break;
			}
		}

		uiMsgBox.AddButtonEx("Btn1");
		uIDBtn2 = uiMsgBox.AddButtonEx("Btn2");
		uiMsgBox.AddButtonEx("Btn3");

		/*
		* 2.调用 DelButton 删除 Btn2
		*/
		uiMsgBox.SetContent(artiGetText("FF0900000022"));
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				break;
			}
		}

		uiMsgBox.DelButton(uIDBtn2);

		/*
		* 3.调用 SetButtonText 修改 Btn1 \ Btn3 文本
		*/
		uiMsgBox.SetContent(artiGetText("FF0900000023"));
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				break;
			}
		}

		uiMsgBox.SetButtonText(1, "Button_1");
		uiMsgBox.SetButtonText(2, "Button_3");

		/*
		* 4.调用 SetButtonStatus 修改 Btn1 \ Btn3 状态
		*/
		uiMsgBox.SetContent(artiGetText("FF0900000024"));
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				break;
			}
		}
		uiMsgBox.SetButtonStatus(1, (uint32_t)DF_ST_BTN_DISABLE);
		uiMsgBox.SetButtonStatus(2, (uint32_t)DF_ST_BTN_UNVISIBLE);

		/*
		* 5.调用 AddButtonEx 增加按键 Btn2
		*/
		uiMsgBox.SetContent(artiGetText("FF0900000025"));
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				break;
			}
		}

		uIDBtn2 = uiMsgBox.AddButtonEx("Btn2");
		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				break;
			}
		}
	}

}