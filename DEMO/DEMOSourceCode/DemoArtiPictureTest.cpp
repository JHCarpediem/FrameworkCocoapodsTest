/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 动作测试
* 功能描述 : 动作测试举例
* 创 建 人 : panjun        20210123
* 审 核 人 : 
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#include "StdShowMaco.h"
#include "PublicInterface.h"
#include "ArtiMenu.h"
#include "ArtiMsgBox.h"
#include "DemoArtiPictureTest.h"
#include "ArtiPicture.h"

namespace Topdon_AD900_Demo {

	void CArtiPictureTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;
	
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("ArtiFreqWaveTest");
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("AddButton");				vctMenuID.push_back(1);
		uiMenu.AddItem("AddPicture");				vctMenuID.push_back(2);
		uiMenu.AddItem("AddTopTips");				vctMenuID.push_back(3);
		uiMenu.AddItem("AddText");					vctMenuID.push_back(4);

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
					ArtiPictureTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiPictureTest_AddButton();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiPictureTest_AddPicture();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiPictureTest_AddTopTips();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiPictureTest_AddText();
				}
			}
		}
	}

	void CArtiPictureTest::ArtiPictureTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0F00000090"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF0F00000091"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF0F00000092"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF0F00000093"));	//"标题文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0F00000094"));	//"标题文本中文长度达到阈值"


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
				strTitle = artiGetText("FF0D00000008");
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
			CArtiPicture uiPicture(m_uThread);
#else
			CArtiPicture uiPicture;
#endif
			string strPath = CArtiGlobal::GetVehPath();
			uiPicture.InitTitle(strTitle);		
			uiPicture.AddPicture(strPath + "/picture/Audi.png", "pitcure");

			while (1)
			{
				uRetBtn = uiPicture.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					break;
				}
			}
		
		}
	}

	void CArtiPictureTest::ArtiPictureTest_AddPicture()
	{
		CArtiPicture	uiPicture;
		string			strPath;
		string			strPicture1Path;
		string			strPicture2Path;
		string			strPicture3Path;
		string			strPicture4Path;
		string			strPicture5Path;
		uint32_t		uPicture1Id;
		uint32_t		uPicture2Id;
		uint32_t		uPicture3Id;
		uint32_t		uPicture4Id;
		uint32_t		uPicture5Id;

		CArtiMenu		uiMenu;

		uiMenu.InitTitle("Test artipicture");
		uiMenu.AddItem("png");
		uiMenu.AddItem("bmp");
		uiMenu.AddItem("jpg");
		uiMenu.AddItem("svg");

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}

			strPath = CArtiGlobal::GetVehPath();

			strPicture1Path = strPath;
			strPicture2Path = strPath;
			strPicture3Path = strPath;
			strPicture4Path = strPath;
			strPicture5Path = strPath;

			strPicture1Path += "/picture/";
			strPicture2Path += "/picture/";
			strPicture3Path += "/picture/";
			strPicture4Path += "/picture/";
			strPicture5Path += "/picture/";

			uiPicture.InitTitle("ArtiPicture");
			uiPicture.AddButton("OK");

			uRet &= 0xff;
			if (uRet == 0)
			{
				strPicture1Path += "Audi.png";
				strPicture2Path += "Benz.png";
				strPicture3Path += "BWM.png";
				strPicture4Path += "BWM.png";

				
				uPicture1Id = uiPicture.AddPicture(strPicture1Path, "pitcure1");
				uPicture2Id = uiPicture.AddPicture(strPicture2Path, "pitcure2");
				uPicture3Id = uiPicture.AddPicture(strPicture3Path, "pitcure3");
				uPicture4Id = uiPicture.AddPicture(strPicture4Path, "pitcure4");

				uiPicture.AddTopTips(uPicture1Id, "picture1Info111111111111111111111\n11111111111111111", FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				uiPicture.AddTopTips(uPicture2Id, "picture2Info111111111111111111111\n11111111111111", FORT_SIZE_MEDIUM, BOLD_TYPE_NONE);
				uiPicture.AddTopTips(uPicture3Id, "picture3Info11111111111111111111111", FORT_SIZE_LARGE, BOLD_TYPE_NONE);
				uiPicture.AddTopTips(uPicture4Id, "picture3Info11111111111111111111111", FORT_SIZE_LARGE, BOLD_TYPE_NONE);
			}
			else
			{
				if (uRet==1)
				{
					strPicture1Path += "bmp.bmp";
					strPicture2Path += "bmp.bmp";
					strPicture3Path += "bmp.bmp";
					strPicture4Path += "bmp.bmp";
					strPicture5Path += "bmp.bmp";
				}
				else if (uRet == 2)
				{
					strPicture1Path += "JPG.jpg";
					strPicture2Path += "JPG.jpg";
					strPicture3Path += "JPG.jpg";
					strPicture4Path += "JPG.jpg";
					strPicture5Path += "JPG.jpg";
				}
				else
				{
					strPicture1Path += "SVG.svg";
					strPicture2Path += "SVG.svg";
					strPicture3Path += "SVG.svg";
					strPicture4Path += "SVG.svg";
					strPicture5Path += "SVG.svg";
				}
				uPicture1Id = uiPicture.AddPicture(strPicture1Path, "pitcure1");
				uPicture2Id = uiPicture.AddPicture(strPicture2Path, "pitcure2");
				uPicture3Id = uiPicture.AddPicture(strPicture3Path, "pitcure3");
				uPicture4Id = uiPicture.AddPicture(strPicture4Path, "pitcure4");
				uPicture5Id = uiPicture.AddPicture(strPicture5Path, "pitcure5");

				uiPicture.AddTopTips(uPicture1Id, "picture1Info111111111111111111111\n11111111111111111", FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				uiPicture.AddTopTips(uPicture2Id, "picture1Info111111111111111111111\n11111111111111111", FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				uiPicture.AddTopTips(uPicture3Id, "picture1Info111111111111111111111\n11111111111111111", FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				uiPicture.AddTopTips(uPicture4Id, "picture1Info111111111111111111111\n11111111111111111", FORT_SIZE_SMALL, BOLD_TYPE_BOLD);
				uiPicture.AddTopTips(uPicture5Id, "picture1Info111111111111111111111\n11111111111111111", FORT_SIZE_SMALL, BOLD_TYPE_BOLD);

			}

			uiPicture.AddText("Citroen Relay 2006-\nPeugeot Boxer 2006-\nIveco Daily 2007-\n\nkey types:\nMEGAMOS 48");
			while (1)
			{
				uRetBtn = uiPicture.Show();
				if (DF_ID_BACK == uRetBtn || DF_ID_FREEBTN_0 == uRetBtn)
				{
					break;
				}
			}
		}
	}

	void CArtiPictureTest::ArtiPictureTest_AddButton()
	{
		string strButton = "";
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF0F00000096"));	//"按钮数量达到阈值"
		uiMenu.AddItem(artiGetText("FF0F00000097"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF0F00000098"));	//"按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF0F00000099"));	//"按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF0F0000009A"));	//"按钮文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0F0000009B"));	//"按钮文本中文长度达到阈值"	

		while (1)
		{
#if __Multi_System_Test__
			CArtiPicture uiPicture(m_uThread);
#else
			CArtiPicture uiPicture;
#endif
			string strPath = CArtiGlobal::GetVehPath();
			uiPicture.InitTitle(artiGetText("FF0F00000095"));//图片测试
			uiPicture.AddPicture(strPath + "/picture/Audi.png", "pitcure");
			uiPicture.AddButton(artiGetText("FF0F0000009C"));//增加按钮

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
				strButton = TextMulitLine;
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
					uRetBtn = uiPicture.Show();
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
							SPRINTF_S(buff, artiGetText("FF0F0000009D").c_str(), i);
							strBtnText = buff;

							uiPicture.AddButton(strBtnText);
						}
					}
				}
			}
			else
			{
				while (1)
				{
					uRetBtn = uiPicture.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						uiPicture.AddButton(strButton);
					}
				}
			}

		}
	}

	void CArtiPictureTest::ArtiPictureTest_AddTopTips()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		string streSize = "FORT_SIZE_SMALL";
		string streBold = "BOLD_TYPE_NONE";
		string strTopTips = artiGetText("FF0F0000009F");	//"图片提示为单行"

		eFontSize eSize = eFontSize::FORT_SIZE_SMALL;
		eBoldType eBold = eBoldType::BOLD_TYPE_NONE;
		string  eTopTips = artiGetText("FF0000000006");

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("AddTopTips");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("eSize");
		uiList.AddItem("eBold");
		uiList.AddItem("Tips");

		uiList.SetItem(0, 1, streSize);
		uiList.SetItem(1, 1, streBold);
		uiList.SetItem(2, 1, strTopTips);
		uiList.AddButtonEx("Test");

		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn) 
			{
#if __Multi_System_Test__
				CArtiPicture uiPicture(m_uThread);
#else
				CArtiPicture uiPicture;
#endif
				string strPath = CArtiGlobal::GetVehPath();
				uiPicture.InitTitle(artiGetText("FF0F00000095"));//图片测试
				uiPicture.AddPicture(strPath + "/picture/Audi.png", "pitcure");
				uiPicture.AddTopTips(0, eTopTips, eSize, eBold);

				uint32_t uRetBtn1 = DF_ID_NOKEY;
				while (1)
				{
					uRetBtn1 = uiPicture.Show();
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
					GetParamValue(eSize, streSize, mapFontSize);
					uiList.SetItem(0, 1, streSize);
				}
				else if (1 == uSelect)
				{
					GetParamValue(eBold, streBold, mapBoldType);
					uiList.SetItem(1, 1, streBold);
				}
				else if (2 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiTipsMenu(m_uThread);
#else
					CArtiMenu uiTipsMenu;
#endif
					uiTipsMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
					uiTipsMenu.AddItem(artiGetText("FF0F0000009E"));	//"图片提示为空文本"
					uiTipsMenu.AddItem(artiGetText("FF0F0000009F"));	//"图片提示为单行短文本"	
					uiTipsMenu.AddItem(artiGetText("FF0F000000A9"));	//"图片提示为单行长文本"	
					uiTipsMenu.AddItem(artiGetText("FF0F000000A0"));	//"图片提示为多行文本"					
					uiTipsMenu.AddItem(artiGetText("FF0F000000A1"));	//"图片提示英文长度达到阈值"		
					uiTipsMenu.AddItem(artiGetText("FF0F000000A2"));	//"图片提示中文长度达到阈值"	

					while (1)
					{
						uRetBtn = uiTipsMenu.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							break;
						}
						else if (0 == uRetBtn)
						{
							eTopTips = "";
							strTopTips = artiGetText("FF0F0000009E");
						}
						else if (1 == uRetBtn)
						{
							eTopTips = TextSingleLine;
							strTopTips = artiGetText("FF0F0000009F");
						}
						else if (2 == uRetBtn)
						{
							eTopTips = artiGetText("FF120000000A");
							strTopTips = artiGetText("FF0F000000A9");
						}
						else if (3 == uRetBtn)
						{
							eTopTips = TextMulitLineValue;
							strTopTips = artiGetText("FF0F000000A0");
						}
						else if (4 == uRetBtn)
						{
							eTopTips = artiGetText("FF1100000007");
							strTopTips = artiGetText("FF0F000000A1");
						}
						else if (5 == uRetBtn)
						{
							eTopTips = artiGetText("FF1200000007");
							strTopTips = artiGetText("FF0F000000A2");
						}
						break;
					}
					uiList.SetItem(2, 1, strTopTips);
				}
			}
		}
	}

	void CArtiPictureTest::ArtiPictureTest_AddText()
	{
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0F000000A3"));	//"文本框文本为空文本"
		uiMenu.AddItem(artiGetText("FF0F000000A4"));	//"文本框文本为单行短文本"
		uiMenu.AddItem(artiGetText("FF0F000000AA"));	//"文本框文本为单行长文本"
		uiMenu.AddItem(artiGetText("FF0F000000A5"));	//"文本框文本为多行文本"
		uiMenu.AddItem(artiGetText("FF0F000000A6"));	//"文本框文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0F000000A7"));	//"文本框文本中文长度达到阈值"


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
				strText = TextSingleLine;
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
				strText = artiGetText("FF1100000006");
			}
			else if (5 == uRetBtn)
			{
				strText = artiGetText("FF1200000006");
			}



#if __Multi_System_Test__
			CArtiPicture uiPicture(m_uThread);
#else
			CArtiPicture uiPicture;
#endif
			string strPath = CArtiGlobal::GetVehPath();
			uiPicture.InitTitle(artiGetText("FF0F000000A8"));//文本框测试
			uiPicture.AddPicture(strPath + "/picture/Audi.png", "pitcure");
			uiPicture.AddText(strText);

			while (1)
			{
				uRetBtn = uiPicture.Show();
				if (DF_ID_BACK == uRetBtn)
				{
					break;
				}
			}

		}
	}
}
