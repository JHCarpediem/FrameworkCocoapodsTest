#include "DemoArtiWebTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiWebTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("LoadHtmlFile");			    vctMenuID.push_back(1);
		uiMenu.AddItem("LoadHtmlContent");			vctMenuID.push_back(2);
		uiMenu.AddItem("AddButton");				vctMenuID.push_back(3);
		uiMenu.AddItem("SetButtonVisible");			vctMenuID.push_back(4);

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
					ArtiWebTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiWebTest_LoadHtmlFile();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiWebTest_LoadHtmlContent();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiWebTest_AddButton();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiWebTest_SetButtonVisible();
				}
			}
		}
	}

	void CArtiWebTest::ArtiWebTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0D00000009"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF0D0000000A"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF0D0000000B"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF0D0000000C"));	//"标题文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0D0000000D"));	//"标题文本中文长度达到阈值"


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

			string strHtml = artiGetText("FF0D00000004");	
			strHtml = CArtiGlobal::GetVehPath() + strHtml;

#if __Multi_System_Test__
			CArtiWeb uiArtiWeb(m_uThread);
#else
			CArtiWeb uiArtiWeb;
#endif
			uiArtiWeb.InitTitle(strTitle);
			if (uiArtiWeb.LoadHtmlFile(strHtml))
			{
				uiArtiWeb.Show();
			}
		}
	}

	void CArtiWebTest::ArtiWebTest_LoadHtmlFile()
	{
		string strTitle;
		string strHtml;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0D00000001"));	//"选择网址"
		uiMenu.AddItem(artiGetText("FF0D00000002"));	//"百度一下，你就知道"
		uiMenu.AddItem(artiGetText("FF0D00000003"));	//"Google 翻译"
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = artiGetText("FF0D00000002");	//"Baidu"
				strHtml = artiGetText("FF0D00000004");	//"./html/Baidu.htm"
			}
			else if (1 == uRetBtn)
			{
				strTitle = artiGetText("FF0D00000003");	//"Google"
				strHtml = artiGetText("FF0D00000005");	//"./html/Google.htm"
			}

#if __Multi_System_Test__
			CArtiWeb uiArtiWeb(m_uThread);
#else
			CArtiWeb uiArtiWeb;
#endif
			uiArtiWeb.InitTitle(strTitle);

			strHtml = CArtiGlobal::GetVehPath() + strHtml;
			//strHtml = "E:\\10_DOC\\钉钉接收文件\\vaudes_document_0800452180b90ab0.html";
			if (uiArtiWeb.LoadHtmlFile(strHtml))
			{
				uiArtiWeb.Show();
			}
		}
	}

	void CArtiWebTest::ArtiWebTest_LoadHtmlContent()
	{
		ShowMsgBoxDemo("LoadHtmlContent", artiGetText("FF0D00000006"), DF_MB_OK, DT_LEFT, -1, m_uThread);
#if __Multi_System_Test__
		CArtiWeb uiArtiWeb(m_uThread);
#else
		CArtiWeb uiArtiWeb;
#endif
		uiArtiWeb.InitTitle(artiGetText("FF0D00000002"));
		uiArtiWeb.LoadHtmlContent(artiGetText("FF0D00000007"));
		uiArtiWeb.Show();
	}

	void CArtiWebTest::ArtiWebTest_AddButton()
	{
		string strButton = "";
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"	
		uiMenu.AddItem(artiGetText("FF0D00000025"));	//"按钮数量达到阈值"
		uiMenu.AddItem(artiGetText("FF0D00000020"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF0D00000021"));	//"按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF0D00000022"));	//"按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF0D00000023"));	//"按钮文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0D00000024"));	//"按钮文本中文长度达到阈值"	
		
		while (1)
		{
#if __Multi_System_Test__
			CArtiWeb uiArtiWeb(m_uThread);
#else
			CArtiWeb uiArtiWeb;
#endif
			uiArtiWeb.InitTitle("Add button");
			uiArtiWeb.LoadHtmlContent(artiGetText("FF0D00000007"));
			uiArtiWeb.AddButton(artiGetText("FF130000000E"));//增加

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
					uRetBtn = uiArtiWeb.Show();
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

							uiArtiWeb.AddButton(strBtnText);
						}
					}
				}
			}
			else
			{
				while (1)
				{
					uRetBtn = uiArtiWeb.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
					else if (DF_ID_FREEBTN_0 == uRetBtn)
					{
						uiArtiWeb.AddButton(strButton);
					}
				}
			}

		}
	}

	void CArtiWebTest::ArtiWebTest_SetButtonVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0D0000000E"));	//"返回按钮可见"
		uiMenu.AddItem(artiGetText("FF0D0000000F"));	//"返回按钮不可见"
		uint32_t uRet = DF_ID_NOKEY;

#if __Multi_System_Test__
		CArtiWeb uiArtiWeb(m_uThread);
#else
		CArtiWeb uiArtiWeb;
#endif
		uiArtiWeb.InitTitle("SetButtonVisible");
		uiArtiWeb.LoadHtmlContent(artiGetText("FF0D00000007"));	

		while (1)
		{
			uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			else if (uRet == 0)
			{
				uiArtiWeb.SetButtonVisible(false);
			}
			else if (uRet == 1)
			{
				uiArtiWeb.SetButtonVisible(true);
			}

			while (1)
			{
				uint32_t uRet = uiArtiWeb.Show();
				if (uRet == DF_ID_BACK)
				{
					break;
				}				
			}
		}
	}	

}