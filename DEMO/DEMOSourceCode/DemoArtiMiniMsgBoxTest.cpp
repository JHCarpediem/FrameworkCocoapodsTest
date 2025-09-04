#include "DemoArtiMiniMsgBoxTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"
#include <map>
#include "ArtiMiniMsgBox.h"

namespace Topdon_AD900_Demo {

	typedef void (CArtiMiniMsgBoxTest::*func)();

	void CArtiMiniMsgBoxTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;
		map<uint32_t, func> mapTestFunc;

		CArtiMenu uiMenu;
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitMsgBox");					mapTestFunc.emplace(make_pair(0, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_InitMsgBox));
		uiMenu.AddItem("SetTitle");						mapTestFunc.emplace(make_pair(1, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetTitle));
		uiMenu.AddItem("SetContent");					mapTestFunc.emplace(make_pair(2, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetContent));
		uiMenu.AddItem("AddButton");					mapTestFunc.emplace(make_pair(3, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_AddButton));
		uiMenu.AddItem("SetButtonType");				mapTestFunc.emplace(make_pair(4, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetButtonType));
		uiMenu.AddItem("SetButtonStatus");				mapTestFunc.emplace(make_pair(5, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetButtonStatus));
		uiMenu.AddItem("SetButtonText");				mapTestFunc.emplace(make_pair(6, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetButtonText));
		uiMenu.AddItem("SetAlignType");					mapTestFunc.emplace(make_pair(7, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetAlignType));
		uiMenu.AddItem("SetBusyVisible");				mapTestFunc.emplace(make_pair(8, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetBusyVisible));
		uiMenu.AddItem("SetBusyVisible1");				mapTestFunc.emplace(make_pair(9, &CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetBusyVisible1));		
		//uiMenu.AddItem("SetSingleCheckBoxText");		mapTestFunc.emplace(make_pair(10,&CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetSingleCheckBoxText));

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

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_InitMsgBox()
	{
		CArtiList uiList;
		uiList.InitTitle("InitMsgBox");
		uiList.SetColWidth(vctColWidth2);

		uiList.AddItem("uButtonType");
		uiList.AddItem("uAlignType");
		uiList.AddItem("uTitle");
		uiList.AddItem("uContents");
		uiList.AddButtonEx("Test");

		uint32_t uButtonType = DF_MB_OK;
		uint32_t uAlignType  = DT_CENTER;
		string strTitle = "";
		string strContents = "";

		string strButtonType = "DF_MB_OK";
		string strAlignType = "DT_CENTER";
		string strTitleList = artiGetText("FF1300000001");
		string strContentsList = artiGetText("FF0900000033");

		uiList.SetItem(0, 1, strButtonType);
		uiList.SetItem(1, 1, strAlignType);
		uiList.SetItem(2, 1, strTitleList);
		uiList.SetItem(3, 1, strContentsList);

		uint32_t uRetBtn = DF_ID_NOKEY;

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
				CArtiMiniMsgBox uiMsgBox;				
				uiMsgBox.InitMsgBox(strTitle, strContents, uButtonType, uAlignType);
				uiMsgBox.Show();
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uButtonType, strButtonType, mapDFButton);
					uiList.SetItem(0, 1, strButtonType);
				}
				else if (1 == uSelect)
				{
					GetParamValue(uAlignType, strAlignType, mapAlignType);
					uiList.SetItem(1, 1, strAlignType);
				}
				else if (2 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"ѡ�������"	
					uiTitleMenu.AddItem(artiGetText("FF1300000001"));	//"�����ı�Ϊ��"
					uiTitleMenu.AddItem(artiGetText("FF1300000002"));	//"�����ı�Ϊ����"			
					uiTitleMenu.AddItem(artiGetText("FF1300000003"));	//"�����ı�Ϊ����"				
					uiTitleMenu.AddItem(artiGetText("FF1300000004"));	//"�����ı�ΪӢ���ҳ��ȴﵽ��ֵ"
					uiTitleMenu.AddItem(artiGetText("FF1300000005"));	//"�����ı�Ϊ�����ҳ��ȴﵽ��ֵ"

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
					uiList.SetItem(2, 1, strTitleList);
				}
				else if (3 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTitleMenu(m_uThread);
#else
					CArtiMenu uiTitleMenu;
#endif
					uiTitleMenu.InitTitle(artiGetText("FF0000000002"));	//"ѡ�������"	
					uiTitleMenu.AddItem(artiGetText("FF0900000031"));	//"�����ı�Ϊ���ı�"
					uiTitleMenu.AddItem(artiGetText("FF0900000032"));	//"�����ı�Ϊ���ж��ı�"
					uiTitleMenu.AddItem(artiGetText("FF0900000033"));	//"�����ı�Ϊ���г��ı�"			
					uiTitleMenu.AddItem(artiGetText("FF0900000034"));	//"�����ı�Ϊ�����ı�"			
					uiTitleMenu.AddItem(artiGetText("FF0900000035"));	//"�����ı�ΪӢ���ҳ��ȴﵽ��ֵ"
					uiTitleMenu.AddItem(artiGetText("FF0900000036"));	//"�����ı�Ϊ�����ҳ��ȴﵽ��ֵ"
					while (1)
					{
						uRetBtn = uiTitleMenu.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							break;
						}
						else if (0 == uRetBtn)
						{
							strContents = "";
							strContentsList = artiGetText("FF0900000031");
						}
						else if (1 == uRetBtn)
						{
							strContents = TextSingleLine;
							strContentsList = artiGetText("FF0900000032");
						}
						else if (2 == uRetBtn)
						{
							strContents = artiGetText("FF120000000A");
							strContentsList = artiGetText("FF0900000033");
						}
						else if (3 == uRetBtn)
						{
							strContents = TextMulitLineValue;
							strContentsList = artiGetText("FF0900000034");
						}
						else if (4 == uRetBtn)
						{
							strContents = artiGetText("FF1100000008");
							strContentsList = artiGetText("FF0900000035");
						}
						else if (5 == uRetBtn)
						{
							strContents = artiGetText("FF1200000008");
							strContentsList = artiGetText("FF0900000036");
						}
						break;
					}
					uiList.SetItem(3, 1, strContentsList);
				}
			}
		}
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetTitle()
	{	
		uint32_t clickNums = 0;	


		CArtiMiniMsgBox uiMsgBox;
		/*
		* "����SetTitle�ӿ�"
		*  "����һ�����Գ���\n���[ȷ��]��ʼ���ԣ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000002"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButton(artiGetText("FF0000000009"));//"ȡ��"
		uiMsgBox.AddButton(artiGetText("FF000000000A"));//"ȷ��"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0 || uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{				
				if (clickNums % 5 == 0)
				{
					uiMsgBox.SetTitle(artiGetText(""));					//��ֵ
				}
				else if (clickNums % 5 == 1)
				{
					uiMsgBox.SetTitle(TextSingleLine);					//�����ı�
				}
				else if (clickNums % 5 == 2)
				{
					uiMsgBox.SetTitle(TextMulitLineTitle);				//�����ı�
				}
				else if (clickNums % 5 == 3)
				{
					uiMsgBox.SetTitle(artiGetText("FF1100000004"));		//"�����ı�ΪӢ���ҳ��ȴﵽ��ֵ"
				}
				else if (clickNums % 5 == 4)
				{
					uiMsgBox.SetTitle(artiGetText("FF1200000004"));		//"�����ı�Ϊ�����ҳ��ȴﵽ��ֵ"
				}
				clickNums++;
			}
		}
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetContent()
	{
		uint32_t clickNums = 0;
		string strTemp = "";

		CArtiMiniMsgBox uiMsgBox;

		/*
		* "����SetContent�ӿ�"
		* "����һ�����Գ���\n���[ȷ��]��ʼ���ԣ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF090000000A"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButton(artiGetText("FF0000000009"));//"ȡ��"
		uiMsgBox.AddButton(artiGetText("FF000000000A"));//"ȷ��"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0 || uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				
				if (clickNums % 6 == 0)
				{
					uiMsgBox.SetContent(artiGetText(""));					//��ֵ
				}
				else if (clickNums % 6 == 1)
				{
					uiMsgBox.SetContent(TextSingleLine);					//���ж��ı�
				}
				else if (clickNums % 6 == 2)
				{
					uiMsgBox.SetContent(artiGetText("FF120000000A"));		//���г��ı�
				}
				else if (clickNums % 6 == 3)
				{
					uiMsgBox.SetContent(TextMulitLineTitle);				//�����ı�
				}
				else if (clickNums % 6 == 4)
				{
					uiMsgBox.SetContent(artiGetText("FF1100000008"));		//"�����ı�ΪӢ���ҳ��ȴﵽ��ֵ(100000)"
				}
				else if (clickNums % 6 == 5)
				{
					uiMsgBox.SetContent(artiGetText("FF1200000008"));		//"�����ı�Ϊ�����ҳ��ȴﵽ��ֵ(50000)"
				}
				clickNums++;
			}
		}
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_AddButton()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	
		uiMenu.AddItem(artiGetText("FF0900000037"));	//"��ť�ı�Ϊ��"	
		uiMenu.AddItem(artiGetText("FF0900000038"));	//"��ť�ı�Ϊ����"
		uiMenu.AddItem(artiGetText("FF0900000039"));	//"��ť�ı�Ϊ����"
		uiMenu.AddItem(artiGetText("FF090000003A"));	//"��ťӢ���ı����ȴﵽ��ֵ"
		uiMenu.AddItem(artiGetText("FF090000003B"));	//"��ť�����ı����ȴﵽ��ֵ"
		uiMenu.AddItem(artiGetText("FF090000003C"));	//"���������ť"

		string strButtonText = "";

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
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
				strButtonText = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				strButtonText = artiGetText("FF1100000002");
			}
			else if (4 == uRetBtn)
			{
				strButtonText = artiGetText("FF1200000002");
			}

			CArtiMiniMsgBox uiMsgBox;
			uiMsgBox.InitMsgBox(artiGetText("FF090000000B"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
			uiMsgBox.AddButton(artiGetText("FF000000000A"));//"ȷ��"

			bool	bHaveAdd = false;
			uint32_t uMsgBoxRetBtn = DF_ID_NOKEY;
			while (1)
			{
				uMsgBoxRetBtn = uiMsgBox.Show();
				if (uMsgBoxRetBtn == DF_ID_FREEBTN_0 && uRetBtn != 5)
				{
					if (!bHaveAdd)
					{
						uiMsgBox.AddButton(strButtonText);
						bHaveAdd = true;
					}
				}
				else if (uMsgBoxRetBtn == DF_ID_FREEBTN_0 && uRetBtn == 5)
				{
					if (!bHaveAdd)
					{
						uiMsgBox.AddButton(artiGetText("FF000000000D"));						
						bHaveAdd = true;
					}
				}
				else
				{
					break;
				}				
			}

		}
	
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetButtonType()
	{
		CArtiMiniMsgBox uiMsgBox1;

		while (1)
		{
			//"MsgBox���Խ���,���[OK]����SetButtonType���ð�������."
			uiMsgBox1.InitMsgBox("MsgBox", artiGetText("FF0900000027"), DF_MB_OKCANCEL, DT_LEFT);

			uRetBtn = uiMsgBox1.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_OK)
			{
				CArtiList uiList;
				uiList.InitTitle("ButtonType");
				uiList.SetColWidth(vctColWidth2);
				uiList.AddItem("uButtonTyp");
				uiList.AddButton("Test");

				uint32_t uButtonTyp = DF_MB_OK;
				string strButtonTyp = "DF_MB_OK";

				uiList.SetItem(0, 1, strButtonTyp);

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
						if (uButtonTyp == DF_MB_NOBUTTON)
						{
							//"����AddButton�ӿ�"	//"��ѡ����DF_MB_NOBUTTON���ͣ��������ϼ��˵���"
							ShowMsgBoxDemo("SetButtonType", artiGetText("FF090000000D"), DF_MB_OK, DT_LEFT, -1, m_uThread);
							continue;
						}
						uiMsgBox1.SetButtonType(uButtonTyp);

						//������ⰴ��������[ButtonType]ѡ�����
						uiMsgBox1.SetContent(artiGetText("FF0900000028"));

						uiMsgBox1.Show();
					}
					else if (DF_ID_NOKEY != uRetBtn)
					{
						uint16_t uSelect = uiList.GetSelectedRow();
						if (0 == uSelect)
						{
							GetParamValue(uButtonTyp, strButtonTyp, mapDFButton);
							uiList.SetItem(0, 1, strButtonTyp);
						}
					}
				}

				break;
			}
		}
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetButtonStatus()
	{
		uint32_t uOffSet = 0;

		CArtiMiniMsgBox uiMsgBox;
		/*
		* "����SetButtonStatus�ӿ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000016"), artiGetText("FF090000003F"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButton(artiGetText("FF090000003D"));//"�л�"
		uiMsgBox.AddButton(artiGetText("FF090000003E"));//"����"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				uOffSet += 1;
				if (uOffSet % 3 == 0)
				{
					uiMsgBox.SetButtonStatus(1 , DF_ST_BTN_ENABLE);
				}
				else if (uOffSet % 3 == 1)
				{
					uiMsgBox.SetButtonStatus(1 , DF_ST_BTN_DISABLE);
				}
				else if (uOffSet % 3 == 2)
				{
					uiMsgBox.SetButtonStatus(1 , DF_ST_BTN_UNVISIBLE);
				}
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				break;
			}		
		}
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetButtonText()
	{
		uint32_t uOffSet = 0;

		CArtiMiniMsgBox uiMsgBox;
		/*
		* "����SetButtonText�ӿ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000015"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButton(artiGetText("FF0000000009"));//"ȡ��"
		uiMsgBox.AddButton(artiGetText("FF000000000A"));//"ȷ��"

		while (1)
		{
			uRetBtn = uiMsgBox.Show();
			if (uRetBtn == DF_ID_FREEBTN_0)
			{
				break;
			}
			else if (uRetBtn == DF_ID_FREEBTN_1)
			{
				uOffSet = uOffSet + 1;
				if (uOffSet % 5 == 0)
				{
					uiMsgBox.SetButtonText(1, "");
				}
				else if (uOffSet % 5 == 1)
				{
					uiMsgBox.SetButtonText(1, TextSingleLine);
				}
				else if (uOffSet % 5 == 2)
				{
					uiMsgBox.SetButtonText(1, TextMulitLineTitle);
				}
				else if (uOffSet % 5 == 3)
				{
					uiMsgBox.SetButtonText(1, artiGetText("FF1100000002"));
				}
				else if (uOffSet % 5 == 4)
				{
					uiMsgBox.SetButtonText(1, artiGetText("FF1200000002"));
				}
				else
				{
					break;
				}
			}			
		}
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetAlignType()
	{
		uint32_t uOffSet = 0;

		CArtiMiniMsgBox uiMsgBox;
		/*
		* "����SetAlignType�ӿ�"
		* "����һ�����Գ���\n���[ȷ��]��ʼ���ԣ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF090000000E"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButton(artiGetText("FF0000000009"));//"ȡ��"
		uiMsgBox.AddButton(artiGetText("FF000000000A"));//"ȷ��"
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

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetBusyVisible()
	{
		bool bOffSet = false;

		CArtiMiniMsgBox uiMsgBox;
		/*
		* "����SetBusyVisible�ӿ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000012"), artiGetText("FF0900000003"), DF_MB_FREE | DF_MB_BLOCK, DT_LEFT);
		uiMsgBox.AddButton(artiGetText("FF0000000009"));//"ȡ��"
		uiMsgBox.AddButton(artiGetText("FF000000000A"));//"ȷ��"

		while (1)
		{
			Delay(100);
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

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetBusyVisible1()
	{
		CArtiMiniMsgBox uiMsgBox;
		/*
		* "����SetBusyVisible�ӿ�"
		*/
		uiMsgBox.InitMsgBox(artiGetText("FF0900000012"), artiGetText("FF0900000003"), DF_MB_NOBUTTON, DT_LEFT);
		uiMsgBox.SetBusyVisible(true);
		for (uint16_t i = 10; i != 0 ; i--)
		{
			char buff[100] = { 0 };
			string strText = artiGetText("FF090000002C");//"�ȴ�%d��..."
			SPRINTF_S(buff, strText.c_str(), i);

			CEcuInterface::Log("SetBusyVisible1 before");
			uiMsgBox.SetContent(buff);
			
			uiMsgBox.Show();
			CEcuInterface::Log("SetBusyVisible1 arfer");
			Delay(1000);
		}
		return;
	}

	void CArtiMiniMsgBoxTest::ArtiMiniMsgBoxTest_SetSingleCheckBoxText()
	{
		
	}

}