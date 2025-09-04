#include "DemoArtiInputTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiInputTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitOneInputBox");	   vctMenuID.push_back(0);
		uiMenu.AddItem("GetOneInputBox");      vctMenuID.push_back(1);
		uiMenu.AddItem("AddButton");		   vctMenuID.push_back(2);
		uiMenu.AddItem("InitManyInputBox");    vctMenuID.push_back(3);
		uiMenu.AddItem("GetManyInputBox");	   vctMenuID.push_back(4);
		uiMenu.AddItem("InitOneComboBox");	   vctMenuID.push_back(5);
		uiMenu.AddItem("GetOneComboBox");	   vctMenuID.push_back(6);
		uiMenu.AddItem("InitManyComboBox");	   vctMenuID.push_back(7);
		uiMenu.AddItem("GetManyComboBox");	   vctMenuID.push_back(8);
		uiMenu.AddItem("SetTipsPosition");	   vctMenuID.push_back(9);
		uiMenu.AddItem("GetManyComboBoxNum");	   vctMenuID.push_back(10);
		uiMenu.AddItem("SetVisibleButtonQR");	   vctMenuID.push_back(11);

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
					ArtiInputTest_InitOneInputBox();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_GetOneInputBox();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_AddButton();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_InitManyInputBox();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_GetManyInputBox();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_InitOneComboBox();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_GetOneComboBox();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_InitManyComboBox();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_GetManyComboBox();
				}
				else if (9 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_SetTipsPosition();
				}
				else if (10 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_GetManyComboBoxNum();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiInputTest_SetVisibleButtonQR();
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_SetTipsPosition()
	{
#if __Multi_System_Test__
		CArtiInput uiInput(m_uThread);
#else
		CArtiInput uiInput;
#endif
		CArtiMenu	uiMenu;

		uiMenu.InitTitle("Test SetTipsPoition");
		uiMenu.AddItem("SetTipsPosition:Top OneComboBox");
		uiMenu.AddItem("SetTipsPosition:Left OneComboBox");
		uiMenu.AddItem("SetTipsPosition:Top ManyComboBox");
		uiMenu.AddItem("SetTipsPosition:Left ManyComboBox");

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (DF_ID_BACK == uRet)
			{
				break;
			}
			if ((uRet & 0xff) == 0 || (uRet & 0xff) == 1)
			{
				string strTitle = "SetTipsPoition";
				string strTips = "SetTips_OneComboBox";
				string strDefault = "TestValue0";
				vector<string> vctValue = { "TestValue0", "TestValue1", "TestValue2" };

				uiInput.InitOneComboBox(strTitle, strTips, vctValue, strDefault);
			}
			else if ((uRet & 0xff) == 2 || (uRet & 0xff) == 3)
			{
				string strTitle = "InitManyComboBox";
				vector<string> vctTips = { "ComboBox_0", "ComboBox_1" , "ComboBox_2" };
				vector<vector<string>> vctValue = { {"TestValue0", "TestValue1", TextMulitLineValue},
											{"TestValue0", "TestValue1", TextMulitLineValue},
											{"TestValue0", "TestValue1", TextMulitLineValue} };
				vector<string> vctDefault = vctValue[0];

				uiInput.InitManyComboBox(strTitle, vctTips, vctValue, vctDefault);
			}


			if ((uRet & 0xff) == 0 || (uRet & 0xff) == 2)
			{
				uiInput.SetTipsPosition(TIPS_IS_TOP);
			}
			else if ((uRet & 0xff) == 1 || (uRet & 0xff) == 3)
			{
				uiInput.SetTipsPosition(TIPS_IS_LEFT);
			}
			while (1)
			{
				uRetBtn = uiInput.Show();
				if (DF_ID_BACK == uRetBtn || DF_ID_OK == uRetBtn)
				{
					break;
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_InitOneInputBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0500000002"));//"标题、提示和默认值均为空文本"
		uiMenu.AddItem(artiGetText("FF0500000003"));//"标题、提示和默认值均为单行短文本"
		uiMenu.AddItem(artiGetText("FF0500000004"));//"标题、提示和默认值均为多行文本"
		uiMenu.AddItem(artiGetText("FF050000001C"));//"标题、提示和默认值英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF050000001D"));//"标题、提示和默认值中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0500000000"));//"标题、提示和默认值均为单行长文本"
		uiMenu.AddItem(artiGetText("FF0500000005"));//"Mask测试"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if ((0 == uRetBtn) || (1 == uRetBtn) || (2 == uRetBtn) || (3 == uRetBtn) || (4 == uRetBtn) || (5 == uRetBtn))
				{
#if __Multi_System_Test__
					CArtiInput uiInput(m_uThread);
#else
					CArtiInput uiInput;
#endif
					if (0 == uRetBtn)
					{
						uiInput.InitOneInputBox("", "", "", "");
					}
					else if (1 == uRetBtn)
					{
						string strTemp = TextSingleLine;
						string strMask = "";
						for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
						{
							strMask += "*";
						}
						uiInput.InitOneInputBox(TextSingleLine, TextSingleLine, strMask, strTemp);
					}
					else if (2 == uRetBtn)
					{
						string strTemp = TextMulitLineValue;
						string strMask = "";
						for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
						{
							strMask += "*";
						}
						uiInput.InitOneInputBox(TextMulitLineTitle, TextMulitLineHelp, strMask, strTemp);
					}
					else if (3 == uRetBtn)
					{
						string strTemp = artiGetText("FF1100000005");
						string strMask = "";
						for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
						{
							strMask += "*";
						}
						uiInput.InitOneInputBox(artiGetText("FF1100000004"), artiGetText("FF1100000005"), strMask, strTemp);
					}
					else if (4 == uRetBtn)
					{
						string strTemp = artiGetText("FF1200000005");
						string strMask = "";
						for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
						{
							strMask += "*";
						}
						uiInput.InitOneInputBox(artiGetText("FF1200000004"), artiGetText("FF1200000005"), strMask, strTemp);
					}
					else if (5 == uRetBtn)
					{
						string strTemp = artiGetText("FF120000000A");
						string strMask = "";
						for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
						{
							strMask += "*";
						}
						uiInput.InitOneInputBox(artiGetText("FF120000000A"), artiGetText("FF120000000A"), strMask, strTemp);
					}

					while (1)
					{
						uRetBtn = uiInput.Show();
						if (DF_ID_BACK == uRetBtn || 0 == uRetBtn)
						{
							break;
						}
					}
				}
				else
				{
					vector<string> vctMask;

#if __Multi_System_Test__
					CArtiMenu uiMenuMask(m_uThread);
#else
					CArtiMenu uiMenuMask;
#endif

					uiMenuMask.InitTitle(artiGetText("FF0500000005"));//"Mask测试"
					uiMenuMask.AddItem("Mask=**********");				vctMask.push_back("**********");
					uiMenuMask.AddItem("Mask=0000000000");				vctMask.push_back("0000000000");
					uiMenuMask.AddItem("Mask=FFFFFFFFFF");				vctMask.push_back("FFFFFFFFFF");
					uiMenuMask.AddItem(artiGetText("FF0500000031"));  	vctMask.push_back(artiGetText("FF1100000005")); //英文掩码长度达到阈值
					uiMenuMask.AddItem(artiGetText("FF0500000032"));  	vctMask.push_back(artiGetText("FF1200000005")); //中文掩码长度达到阈值

					while (1)
					{
						uRetBtn = uiMenuMask.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							break;
						}
						else
						{
#if __Multi_System_Test__
							CArtiInput uiInput(m_uThread);
#else
							CArtiInput uiInput;
#endif
							uiInput.InitOneInputBox("Title", "Mask=" + vctMask[uRetBtn], vctMask[uRetBtn], vctMask[uRetBtn]);
							while (1)
							{
								uRetBtn = uiInput.Show();
								if (DF_ID_BACK == uRetBtn || 0 == uRetBtn)
								{
									break;
								}
							}
						}
					}
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_GetOneInputBox()
	{
		vector<string> vctMask;
#if __Multi_System_Test__
		CArtiMenu uiMenuMask(m_uThread);
#else
		CArtiMenu uiMenuMask;
#endif
		uiMenuMask.InitTitle(artiGetText("FF0500000028"));			//GetOneInputBox接口测试								
		uiMenuMask.AddItem(artiGetText("FF0500000035"));	        vctMask.push_back("");								//单输入框内容为空
		uiMenuMask.AddItem(artiGetText("FF0500000036"));			vctMask.push_back(TextMulitLineValue);				//单输入框内容为多行
		uiMenuMask.AddItem("Default=**********");					vctMask.push_back("**********");
		uiMenuMask.AddItem("Default=0000000000");					vctMask.push_back("0000000000");
		uiMenuMask.AddItem("Default=FFFFFFFFFF");					vctMask.push_back("FFFFFFFFFF");
		uiMenuMask.AddItem("Default=*0F#VAB");  					vctMask.push_back("*0F#VAB");
		uiMenuMask.AddItem(artiGetText("FF0500000033"));			vctMask.push_back(artiGetText("FF1100000005"));		//单输入框内容英文长度到达阈值
		uiMenuMask.AddItem(artiGetText("FF0500000034"));  			vctMask.push_back(artiGetText("FF1200000005"));		//单输入框内容中文长度到达阈值
		while (1)
		{
			uRetBtn = uiMenuMask.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
#if __Multi_System_Test__
				CArtiInput uiInput(m_uThread);
#else
				CArtiInput uiInput;
#endif
				/*
				* "输入框标题"
				* "输入框提示[Mask="
				*/
				uiInput.InitOneInputBox(artiGetText("FF0500000008"), artiGetText("FF0500000009") + vctMask[uRetBtn] + "]", vctMask[uRetBtn], vctMask[uRetBtn]);
				while (1)
				{
					uRetBtn = uiInput.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
					else
					{
						string strRetVal = uiInput.GetOneInputBox();
						ShowMsgBoxDemo(artiGetText("FF050000000A"), artiGetText("FF0500000029") + strRetVal, DF_MB_OK, DT_LEFT, -1, m_uThread);
					}
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_AddButton()
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
		uiMenu.AddItem(artiGetText("FF130000000B"));	//"按钮文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF130000000C"));	//"按钮文本中文长度达到阈值"		
		uiMenu.AddItem(artiGetText("FF130000000D"));	//"增加按钮数量达到阈值"
		uiMenu.AddItem(artiGetText("FF000000012A"));	//"输入内容设置为按钮文本"		

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (0 == uRetBtn || 1 == uRetBtn || 2 == uRetBtn || 3 == uRetBtn || 4 == uRetBtn || 5 == uRetBtn || 6 == uRetBtn)
				{
#if __Multi_System_Test__
					CArtiInput uiInput(m_uThread);
#else
					CArtiInput uiInput;
#endif
					string strBtnText = "";
					if (0 == uRetBtn)
					{
						strBtnText = "";
					}
					else if (1 == uRetBtn)
					{
						strBtnText = artiGetText("FF050000000C");
					}
					else if (2 == uRetBtn)
					{
						strBtnText = artiGetText("FF1200000009");
					}
					else if (3 == uRetBtn)
					{
						strBtnText = artiGetText("FF1100000002");
					}
					else if (4 == uRetBtn)
					{
						strBtnText = artiGetText("FF1200000002");
					}
					else
					{
						strBtnText = artiGetText("FF050000000C");
					}

					uiInput.InitOneInputBox(artiGetText("FF0500000008"), artiGetText("FF050000000D"), "**********", "");

					uint32_t uRetInputBtn = DF_ID_NOKEY;

					while (1)
					{
						uRetInputBtn = uiInput.Show();
						if (DF_ID_BACK == uRetInputBtn)
						{
							break;
						}
						else if (DF_ID_OK == uRetInputBtn)
						{
							if (0 == uRetBtn || 1 == uRetBtn || 2 == uRetBtn || 3 == uRetBtn || 4 == uRetBtn)
							{
								uiInput.AddButton(strBtnText);
							}
							else if (5 == uRetBtn)
							{
								for (uint32_t i = 0; i < 30; i++)
								{
									uiInput.AddButton(artiGetText("FF0000000025") + to_string(i));
								}
							}
							else
							{
								strBtnText = uiInput.GetOneInputBox();			//输入框内容设置为按钮文本
								if (strBtnText == "")
								{
									artiShowMsgBox(artiGetText("FF000000012C"), artiGetText("FF000000012B"));
									continue;
								}
								uiInput.AddButton(strBtnText);
							}
						}
					}
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_SetVisibleButtonQR()
	{
#if __Multi_System_Test__
		CArtiInput uiInput(m_uThread);
#else
		CArtiInput uiInput;
#endif
		string strTitle = "SetVisibleButtonQR";
		string strTips = "Tips";
		string strDefault = "TestValue0";
		vector<string> vctValue = { "TestValue0", "TestValue1", "TestValue2" };

		uiInput.InitOneComboBox(strTitle, strTips, vctValue, strDefault);

		uint32_t uClickNums = 0;
		while (1)
		{
			uRetBtn = uiInput.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_OK == uRetBtn)
			{
				if (uClickNums % 2 == 0)
				{
					uint32_t uRet = uiInput.SetVisibleButtonQR(true);
					if (uRet == DF_FUNCTION_APP_CURRENT_NOT_SUPPORT)
					{
						artiShowMsgBox("SetVisibleButtonQR", artiGetText("FF040000004D"));//当前APP版本还没有此接口
					}
					uClickNums++;
				}
				else if (uClickNums % 2 == 1)
				{
					uint32_t uRet = uiInput.SetVisibleButtonQR(false);
					if (uRet == DF_FUNCTION_APP_CURRENT_NOT_SUPPORT)
					{
						artiShowMsgBox("SetVisibleButtonQR", artiGetText("FF040000004D"));//当前APP版本还没有此接口
					}
					uClickNums++;
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_InitManyInputBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0500000038"));	//"输入框数量达到阈值"
		uiMenu.AddItem(artiGetText("FF0500000039"));	//"提示、掩码、默认值测试"

		vector<string> vctTips;
		vector<string> vctMasks;
		vector<string> vctDefaults;

		while (1)
		{
			vctTips.clear();
			vctMasks.clear();
			vctDefaults.clear();

			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == 0)
			{
				for (uint32_t iTemp = 0; iTemp < 16; iTemp++)
				{
					vctTips.push_back(artiGetText("FF050000003A") + to_string(iTemp)); vctMasks.push_back("**********"); vctDefaults.push_back(artiGetText("FF050000003A") + to_string(iTemp));
				}
			}
			else
			{
				vctTips.push_back("");	vctMasks.push_back(""); vctDefaults.push_back("");

				string strTemp = TextSingleLine;
				string strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back(TextSingleLine);	vctMasks.push_back(strMask); vctDefaults.push_back(strTemp);

				strTemp = artiGetText("FF120000000A");//单行长文本
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back(artiGetText("FF120000000A"));	vctMasks.push_back(strMask); vctDefaults.push_back(artiGetText("FF120000000A"));

				strTemp = TextMulitLineValue;
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back(TextMulitLineValue);	vctMasks.push_back(strMask); vctDefaults.push_back(strTemp);

				strTemp = artiGetText("FF1100000005");//英文阈值4000
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back(artiGetText("FF1100000005"));	vctMasks.push_back(strMask); vctDefaults.push_back(artiGetText("FF1100000005"));

				strTemp = artiGetText("FF1200000005");//中文阈值2000
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back(artiGetText("FF1200000005"));	vctMasks.push_back(strMask); vctDefaults.push_back(artiGetText("FF1200000005"));
			}
#if __Multi_System_Test__
			CArtiInput uiInput(m_uThread);
#else
			CArtiInput uiInput;
#endif
			uiInput.InitManyInputBox(artiGetText("FF0500000012"), vctTips, vctMasks, vctDefaults);

			while (1)
			{
				uRetBtn = uiInput.Show();
				if (DF_ID_BACK == uRetBtn || DF_ID_OK == uRetBtn)
				{
					break;
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_GetManyInputBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0500000038"));	//"输入框数量达到阈值"
		uiMenu.AddItem(artiGetText("FF0500000039"));	//"提示、掩码、默认值测试"

		vector<string> vctTips;
		vector<string> vctMasks;
		vector<string> vctDefaults;

		while (1)
		{
			vctTips.clear();
			vctMasks.clear();
			vctDefaults.clear();

			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == 0)
			{
				for (uint32_t iTemp = 0; iTemp < 16; iTemp++)
				{
					vctTips.push_back(artiGetText("FF050000003A") + to_string(iTemp)); vctMasks.push_back("**********"); vctDefaults.push_back(artiGetText("FF050000003A") + to_string(iTemp));
				}
			}
			else
			{
				vctTips.push_back("InputBox_1");	vctMasks.push_back(""); vctDefaults.push_back("");

				string strTemp = TextSingleLine;
				string strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back("InputBox_2");	vctMasks.push_back(strMask); vctDefaults.push_back(strTemp);

				strTemp = TextMulitLineValue;
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back("InputBox_3");	vctMasks.push_back(strMask); vctDefaults.push_back(strTemp);

				strTemp = artiGetText("FF1100000005");//英文阈值4000
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back("InputBox_4");	vctMasks.push_back(strMask); vctDefaults.push_back(artiGetText("FF1100000005"));

				strTemp = artiGetText("FF1200000005");//中文阈值2000
				strMask = "";
				for (uint32_t iTemp = 0; iTemp < strTemp.size(); iTemp++)
				{
					strMask += "*";
				}
				vctTips.push_back("InputBox_5");	vctMasks.push_back(strMask); vctDefaults.push_back(artiGetText("FF1200000005"));
			}
#if __Multi_System_Test__
			CArtiInput uiInput(m_uThread);
#else
			CArtiInput uiInput;
#endif
			uiInput.InitManyInputBox(artiGetText("FF0500000012"), vctTips, vctMasks, vctDefaults);

			while (1)
			{
				uRetBtn = uiInput.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					break;
				}
				else if (DF_ID_OK == uRetBtn)
				{
					string strRetVal = "";
					vector<string> vctStrRetVal;
					vctStrRetVal = uiInput.GetManyInputBox();

					for (uint32_t i = 0; i < vctStrRetVal.size(); i++)
					{
						strRetVal = strRetVal + "InputBox_" + to_string(i) + ":";
						strRetVal = strRetVal + vctStrRetVal[i] + "\n";
					}
					ShowMsgBoxDemo(artiGetText("FF050000001B"), strRetVal, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_InitOneComboBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF050000001E"));
		uiMenu.AddItem(artiGetText("FF050000002A"));	//"标题、提示、值和默认值为空文本"
		uiMenu.AddItem(artiGetText("FF050000002B"));	//"标题、提示、值和默认值为单行短文本"
		uiMenu.AddItem(artiGetText("FF0500000037"));	//"标题、提示、值和默认值为单行长文本"
		uiMenu.AddItem(artiGetText("FF050000002C"));	//"标题、提示、值和默认值为多行文本"
		uiMenu.AddItem(artiGetText("FF050000002D"));	//"标题、提示、值和默认值英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF050000002E"));	//"标题、提示、值和默认值中文长度达到阈值"	
		uiMenu.AddItem(artiGetText("FF0500000024"));	//"默认值不属于下拉框集合"
		uiMenu.AddItem(artiGetText("FF0500000025"));	//"默认值为空"
		uiMenu.AddItem(artiGetText("FF0500000026"));	//"下拉框集合为1"

		while (1)
		{
#if __Multi_System_Test__
			CArtiInput uiInput(m_uThread);
#else
			CArtiInput uiInput;
#endif
			string strTitle = "";
			string strTips = "";
			string strDefault = "";
			vector<string> vctValue = { "" };

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = "";
				strTips = "";
				strDefault = "";
				vctValue = { "" };
			}
			else if (1 == uRetBtn)
			{
				strTitle = "InitOneComboBox";
				strTips = "Tips";
				strDefault = "TestValue0";
				vctValue = { "TestValue0","TestValue1","TestValue2" };
			}
			else if (2 == uRetBtn)
			{
				strTitle = artiGetText("FF120000000A");
				strTips = artiGetText("FF120000000A");
				strDefault = "0-" + artiGetText("FF120000000A");
				vctValue = { "0-" + artiGetText("FF120000000A"),"1-" + artiGetText("FF120000000A"),"2-" + artiGetText("FF120000000A") };
			}
			else if (3 == uRetBtn)
			{
				strTitle = TextMulitLineValue;
				strTips = TextMulitLineValue;
				strDefault = "0-" + TextMulitLineValue;
				vctValue = { "0-" + TextMulitLineValue,"1-" + TextMulitLineValue,"2-" + TextMulitLineValue };
			}
			else if (4 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");
				strTips = artiGetText("FF1100000005");
				strDefault = "0-" + artiGetText("FF1100000005");
				vctValue = { "0-" + artiGetText("FF1100000005"),"1-" + artiGetText("FF1100000005"),"2-" + artiGetText("FF1100000005") };
			}
			else if (5 == uRetBtn)
			{
				strTitle = artiGetText("FF1200000004");
				strTips = artiGetText("FF1200000005");
				strDefault = "0-" + artiGetText("FF1200000005");
				vctValue = { "0-" + artiGetText("FF1200000005"),"1-" + artiGetText("FF1200000004"),"2-" + artiGetText("FF1200000003") };
			}
			else if (6 == uRetBtn)
			{
				strTitle = "InitOneComboBox";
				strTips = "Tips";
				strDefault = "TestValue4";//默认值不属于下拉框集合
				vctValue = { "TestValue0","TestValue1","TestValue2" };
			}
			else if (7 == uRetBtn)
			{
				strTitle = "InitOneComboBox";
				strTips = "Tips";
				strDefault = "";
				vctValue = { "TestValue0","TestValue1","TestValue2" };
			}
			else
			{
				strTitle = "InitOneComboBox";
				strTips = "Tips";
				strDefault = "TestValue0";
				vctValue = { "TestValue0" };
			}

			uiInput.InitOneComboBox(strTitle, strTips, vctValue, strDefault);
			while (1)
			{
				uRetBtn = uiInput.Show();
				if (DF_ID_BACK == uRetBtn || DF_ID_OK == uRetBtn)
				{
					break;
				}
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_GetOneComboBox()
	{
#if __Multi_System_Test__
		CArtiInput uiInput(m_uThread);
#else
		CArtiInput uiInput;
#endif
		string strTitle = "InitOneComboBox";
		string strTips = "Tips";
		string strDefault = "TestValue";
		vector<string> vctValue = { "", "TestValue", TextMulitLineValue, artiGetText("FF1100000005"),artiGetText("FF1200000005") };

		uiInput.InitOneComboBox(strTitle, strTips, vctValue, strDefault);

		while (1)
		{
			uRetBtn = uiInput.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_OK == uRetBtn)
			{
				ShowMsgBoxDemo("GetOneComboBox", artiGetText("FF050000002F") + uiInput.GetOneComboBox(), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
		}
	}

	void CArtiInputTest::ArtiInputTest_InitManyComboBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF050000003B"));	//"下拉框数量达到阈值"
		uiMenu.AddItem(artiGetText("FF050000003C"));	//"提示、值、默认值测试"

#if __Multi_System_Test__
		CArtiInput uiInput(m_uThread);
#else
		CArtiInput uiInput;
#endif				
		string strTitle;
		vector<string> vctTips;
		vector<vector<string>> vctValue;
		vector<string> vctDefault;

		while (true)
		{
			strTitle = "";
			vctTips.clear();
			vctValue.clear();
			vctDefault.clear();

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = "InitManyComboBox_Threshold";
				vctTips = { "ComboBox_0","ComboBox_1","ComboBox_2", "ComboBox_3", "ComboBox_4", "ComboBox_5", "ComboBox_6", "ComboBox_7", "ComboBox_8", "ComboBox_9",
										"ComboBox_10","ComboBox_11","ComboBox_12", "ComboBox_13", "ComboBox_14", "ComboBox_15" };

				vctValue = { { "TestValue0","TestValue15" },
													{ "TestValue1","TestValue14" },
													{ "TestValue2","TestValue13" },
													{ "TestValue3","TestValue12" },
													{ "TestValue4","TestValue11" },
													{ "TestValue5","TestValue10" },
													{ "TestValue6","TestValue9"  },
													{ "TestValue7","TestValue8"  },
													{ "TestValue8","TestValue7"  },
													{ "TestValue9","TestValue6"  },
													{ "TestValue10","TestValue5" },
													{ "TestValue11","TestValue4" },
													{ "TestValue12","TestValue3" },
													{ "TestValue13","TestValue2" },
													{ "TestValue14","TestValue1" },
													{ "TestValue15","TestValue0" } };
				vctDefault = { "TestValue0","TestValue1","TestValue2", "TestValue3", "TestValue4", "TestValue5", "TestValue6", "TestValue7", "TestValue8", "TestValue9",
										"TestValue10","TestValue11","TestValue12", "TestValue13", "TestValue14", "TestValue15" };
			}
			else if (1 == uRetBtn)
			{
				strTitle = "InitManyComboBox";
				vctTips = { "","ComboBox_0", artiGetText("FF0500000024"),TextMulitLineValue , artiGetText("FF1100000005") ,artiGetText("FF1200000005"),artiGetText("FF120000000A") };
				vctValue = { {"","",""},
											{"TestValue0"},
											{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005"),artiGetText("FF120000000A")},
											{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005"),artiGetText("FF120000000A")},
											{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005"),artiGetText("FF120000000A")},
											{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005"),artiGetText("FF120000000A")},
											{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005"),artiGetText("FF120000000A") } };

				//1：默认值为空 2:下拉框集合大小为1 3:默认值不属于下拉框集合 4：默认值为多行 5：默认值英文长度达到阈值 6：默认值中文长度达到阈值 7：单行长文本
				vctDefault = { "","TestValue0",artiGetText("FF0500000024"),TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005"),artiGetText("FF120000000A") };
			}

			uiInput.InitManyComboBox(strTitle, vctTips, vctValue, vctDefault);
			while (1)
			{
				uRetBtn = uiInput.Show();
				if (DF_ID_BACK == uRetBtn || DF_ID_OK == uRetBtn)
				{
					break;
				}
			}

		}		
	
}

	void CArtiInputTest::ArtiInputTest_GetManyComboBox()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF050000003B"));	//"下拉框数量达到阈值"
		uiMenu.AddItem(artiGetText("FF050000003C"));	//"提示、值、默认值测试"

#if __Multi_System_Test__
		CArtiInput uiInput(m_uThread);
#else
		CArtiInput uiInput;
#endif				
		string strTitle;
		vector<string> vctTips;
		vector<vector<string>> vctValue;
		vector<string> vctDefault;

		while (1)
		{
			strTitle = "";
			vctTips.clear();
			vctValue.clear();
			vctDefault.clear();

			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = "InitManyComboBox_Threshold";
				vctTips = { "ComboBox_0","ComboBox_1","ComboBox_2", "ComboBox_3", "ComboBox_4", "ComboBox_5", "ComboBox_6", "ComboBox_7", "ComboBox_8", "ComboBox_9",
										"ComboBox_10","ComboBox_11","ComboBox_12", "ComboBox_13", "ComboBox_14", "ComboBox_15" };

				vctValue = { { "TestValue0","TestValue15" },
													{ "TestValue1","TestValue14" },
													{ "TestValue2","TestValue13" },
													{ "TestValue3","TestValue12" },
													{ "TestValue4","TestValue11" },
													{ "TestValue5","TestValue10" },
													{ "TestValue6","TestValue9"  },
													{ "TestValue7","TestValue8"  },
													{ "TestValue8","TestValue7"  },
													{ "TestValue9","TestValue6"  },
													{ "TestValue10","TestValue5" },
													{ "TestValue11","TestValue4" },
													{ "TestValue12","TestValue3" },
													{ "TestValue13","TestValue2" },
													{ "TestValue14","TestValue1" },
													{ "TestValue15","TestValue0" } };
				vctDefault = { "TestValue0","TestValue1","TestValue2", "TestValue3", "TestValue4", "TestValue5", "TestValue6", "TestValue7", "TestValue8", "TestValue9",
										"TestValue10","TestValue11","TestValue12", "TestValue13", "TestValue14", "TestValue15" };
			}
			else if (1 == uRetBtn)
			{
				strTitle = "GetManyComboBox";
				vctTips  = { "ComboBox_0","ComboBox_1", "ComboBox_2","ComboBox_3" , "ComboBox_4" ,"ComboBox_5" };
				vctValue = { {"","",""},
							{"TestValue0"},
							{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
							{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
							{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
							{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")} };

				//1：默认值为空 2:下拉框集合大小为1 3:默认值为多行 4：默认值不属于下拉框集合 4：默认值英文长度达到阈值 5：默认值中文长度达到阈值
				vctDefault = { "","TestValue0",TextMulitLineValue,artiGetText("FF0500000024"),artiGetText("FF1100000005"),artiGetText("FF1200000005") };
			}

			uiInput.InitManyComboBox(strTitle, vctTips, vctValue, vctDefault);
			while (1)
			{
				uRetBtn = uiInput.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					break;
				}
				else if (DF_ID_OK == uRetBtn)
				{
					string strValue = "";
					for (uint8_t i = 0; i < uiInput.GetManyComboBox().size(); i++)
					{
						strValue = strValue + to_string(i) + ": ";
						strValue = strValue + uiInput.GetManyComboBox()[i] + "\n";
					}
					ShowMsgBoxDemo("GetManyComboBox", strValue, DF_MB_OK, DT_LEFT, -1, m_uThread);
					break;
				}
			}
		}	
	}

	void CArtiInputTest::ArtiInputTest_GetManyComboBoxNum()
	{

#if __Multi_System_Test__
		CArtiInput uiInput(m_uThread);
#else
		CArtiInput uiInput;
#endif
		string strTitle = "InitManyComboBox";
		vector<string> vctTips = { "ComboBox_0", "ComboBox_1" , "ComboBox_2" , "ComboBox_3" , "ComboBox_4" };
		vector<vector<string>> vctValue = { {"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
									{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
									{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
									{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")},
									{"TestValue0", "TestValue1", TextMulitLineValue,artiGetText("FF1100000005"),artiGetText("FF1200000005")} };
		vector<string> vctDefault = vctValue[0];

		uiInput.InitManyComboBox(strTitle, vctTips, vctValue, vctDefault);

		while (1)
		{
			uRetBtn = uiInput.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_OK == uRetBtn)
			{
				string strValue = "";
				vector<uint16_t> vctint;
				vector<string> strRet = {};

				vctint = uiInput.GetManyComboBoxNum();
				for (uint8_t i = 0; i < vctint.size(); i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0500000030").c_str(), i);//"%d - 列表测试项名"
					strRet.push_back(buff + to_string(vctint[i]) + "\n");
				}

				for (uint8_t i = 0; i < strRet.size(); i++)
				{
					strValue += strRet[i];
				}

				ShowMsgBoxDemo("Select Result", strValue, DF_MB_OK, DT_LEFT, -1, m_uThread);
				break;
			}
		}
	}

}
