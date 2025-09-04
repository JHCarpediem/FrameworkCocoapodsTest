#include "DemoArtiSystemTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"
#include "ArtiGlobal.h"
#include "ArtiMsgBox.h"

namespace Topdon_AD900_Demo {

	void CArtiSystemTest::ShowMenu()
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
		uiMenu.AddItem("GetItem");		            vctMenuID.push_back(2);
		uiMenu.AddItem("GetDtcItems");		        vctMenuID.push_back(3);
		uiMenu.AddItem("SetHelpButtonVisible");	    vctMenuID.push_back(4);
		uiMenu.AddItem("SetClearButtonVisible");    vctMenuID.push_back(10);
		uiMenu.AddItem("SetItemStatus");	        vctMenuID.push_back(5);
		uiMenu.AddItem("SetItemResult");	        vctMenuID.push_back(6);
		uiMenu.AddItem("SetButtonAreaHidden");		vctMenuID.push_back(7);
		uiMenu.AddItem("SetScanStatus");			vctMenuID.push_back(8);
		uiMenu.AddItem("SetClearStatus");	        vctMenuID.push_back(9);
		//uiMenu.AddItem("GetDiagMenuMask");		vctMenuID.push_back(11);
		uiMenu.AddItem("SetAtuoScanEnable");		vctMenuID.push_back(12);		


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
					ArtiSystemTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_AddItem();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_GetItem();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_GetDtcItems();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetHelpButtonVisible();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetItemStatus();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetItemResult();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetButtonAreaHidden();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetScanStatus();
				}
				else if (9 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetClearStatus();
				}
				else if (10 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetClearButtonVisible();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_GetDiagMenuMask();
				}
				else if (12 == vctMenuID[uRetBtn])
				{
					ArtiSystemTest_SetAtuoScanEnable();
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0B00000026"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF0B00000027"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF0B00000028"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF0B0000001A"));	//"标题英文文本长度达到阈值(1000)"
		uiMenu.AddItem(artiGetText("FF0B0000001B"));	//"标题中文文本长度达到阈值(500)"

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
				strTitle = artiGetText("FF0B00000001");		//"系统列表";
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
			

			CArtiSystem uiSystem;
			uiSystem.InitTitle(strTitle);
			uiSystem.AddItem(artiGetText("FF0B00000001"));//"01 - 发动机系统"
			uiSystem.AddItem(artiGetText("FF0B00000001"));//"02 - 变速箱系统"

			while (1)
			{
				uRetBtn = uiSystem.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_AddItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0B0000001C"));	//"系统名为空"
		uiMenu.AddItem(artiGetText("FF0B0000001D"));	//"系统名为单行"
		uiMenu.AddItem(artiGetText("FF0B0000001E"));	//"系统名为多行"
		uiMenu.AddItem(artiGetText("FF0B0000001F"));	//"系统名英文文本长度达到阈值(1000)"
		uiMenu.AddItem(artiGetText("FF0B00000020"));	//"系统名中文文本长度达到阈值(500)"
		uiMenu.AddItem(artiGetText("FF0B00000021"));	//"系统项数量达到阈值(1000)"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				CArtiSystem uiSystem;
				uiSystem.InitTitle(artiGetText("FF0B00000001"));//"系统列表";

				if (0 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiSystem.AddItem("");
					}
				}
				else if (1 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
						uiSystem.AddItem(buff);
					}
				}
				else if (2 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiSystem.AddItem(TextMulitLineTitle);
					}
				}
				else if (3 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiSystem.AddItem(artiGetText("FF1100000004"));
					}
				}
				else if (4 == uRetBtn)
				{
					for (uint32_t i = 0; i < 100; i++)
					{
						uiSystem.AddItem(artiGetText("FF1200000004"));
					}
				}
				else if (5 == uRetBtn)
				{
					for (uint32_t i = 0; i < 1000; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
						uiSystem.AddItem(buff);
					}
				}

				while (1)
				{
					uRetBtn = uiSystem.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}


	void CArtiSystemTest::ArtiSystemTest_GetItem()
	{
		uint32_t uCnt = 20;
		string strItem = "";
		CArtiSystem uiSystem;
		uiSystem.InitTitle(artiGetText("FF0B00000001"));//"系统列表");
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
			uiSystem.AddItem(buff);
		}

		while (1)
		{
			uRetBtn = uiSystem.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn < 20)
			{
				strItem = uiSystem.GetItem(uRetBtn);
				ShowMsgBoxDemo(artiGetText("FF0B00000008"), strItem, DF_MB_OK, DT_LEFT, -1, m_uThread);//"您选择的系统如下"
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_GetDtcItems()
	{
		ShowMsgBoxDemo("GetDtcItems", artiGetText("FF0B00000009"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		uint32_t uCnt = 20;
		string strItem = "";
		CArtiSystem uiSystem;
		uiSystem.InitTitle(artiGetText("FF0B00000001"));//"系统列表"

		uiSystem.SetScanStatus(DF_SYS_SCAN_START);

		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
			uiSystem.AddItem(buff);

			if (i % 4 == 0)
			{
				uiSystem.SetItemResult(i, DF_ENUM_UNKNOWN);
			}
			else if (i % 4 == 1)
			{
				uiSystem.SetItemResult(i, DF_ENUM_NOTEXIST);
			}
			else if (i % 4 == 2)
			{
				uiSystem.SetItemResult(i, DF_ENUM_NODTC);
			}
			else if (i % 4 == 3)
			{
				uiSystem.SetItemResult(i, DF_ENUM_DTCNUM);
			}
		}

		uiSystem.SetHelpButtonVisible(false);
		uiSystem.SetButtonAreaHidden(false);

		uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);
		
		while (1)
		{
			uRetBtn = uiSystem.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_CLEAR_DTC)
			{
				uiSystem.SetClearStatus(DF_SYS_CLEAR_START);

				strItem = "";
				vector<uint16_t> vctDtcNo;
				vctDtcNo = uiSystem.GetDtcItems();
				for (uint32_t i = 0; i < vctDtcNo.size(); i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, "%d\n", vctDtcNo[i]);
					strItem = strItem + buff;
				}
				ShowMsgBoxDemo(artiGetText("FF0B0000000A"), strItem, DF_MB_OK, DT_LEFT, -1, m_uThread);//"以下系统存在故障码"

				uiSystem.SetClearStatus(DF_SYS_CLEAR_FINISH);
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetHelpButtonVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0B0000000B"));//"显示帮助按钮"
		uiMenu.AddItem(artiGetText("FF0B0000000C"));//"隐藏帮助按钮"

		bool bIsVisible = true;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				bIsVisible = true;
			}
			else if (1 == uRetBtn)
			{
				bIsVisible = false;
			}

			CArtiSystem uiSystem;
			uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
			for (uint32_t i = 0; i < 20; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
				uiSystem.AddItem(buff);
			}

			uiSystem.SetHelpButtonVisible(bIsVisible);
			uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

			while (1)
			{
				uRetBtn = uiSystem.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_HELP)
				{
					ShowMsgBoxDemo("Click Event", artiGetText("FF0B00000022"));
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetClearButtonVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));//"选择测试项"
		uiMenu.AddItem(artiGetText("FF00000000AE"));//"显示一键清码"
		uiMenu.AddItem(artiGetText("FF00000000AF"));//"隐藏一键清码"

		bool bIsVisible = true;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				bIsVisible = true;
			}
			else if (1 == uRetBtn)
			{
				bIsVisible = false;
			}

			CArtiSystem uiSystem;
			uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
			for (uint32_t i = 0; i < 20; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
				uiSystem.AddItem(buff);
			}

			uiSystem.SetClearButtonVisible(bIsVisible);
			uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

			while (1)
			{
				uRetBtn = uiSystem.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetItemStatus()
	{
		uint32_t uCnt = 20;
		string strItem = "";
		CArtiSystem uiSystem;
		uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
			uiSystem.AddItem(buff);

			if (i % 3 == 0)
			{
				uiSystem.SetItemStatus(i, artiGetText("FF0B0000000D"));//"正在初始化..."
			}
			else if (i % 3 == 1)
			{
				uiSystem.SetItemStatus(i, artiGetText("FF0B0000000E"));//"正在读码..."
			}
			else if (i % 3 == 2)
			{
				uiSystem.SetItemStatus(i, artiGetText("FF0B0000000F"));//"正在清码..."
			}
		}
		uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

		while (1)
		{
			uRetBtn = uiSystem.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetItemResult()
	{
		uint32_t uCnt = 20;
		string strItem = "";
		CArtiSystem uiSystem;
		uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
			uiSystem.AddItem(buff);

			if (i % 4 == 0)
			{
				uiSystem.SetItemResult(i, DF_ENUM_UNKNOWN);
			}
			else if (i % 4 == 1)
			{
				uiSystem.SetItemResult(i, DF_ENUM_NOTEXIST);
			}
			else if (i % 4 == 2)
			{
				uiSystem.SetItemResult(i, DF_ENUM_NODTC);
			}
			else if (i % 4 == 3)
			{
				uiSystem.SetItemResult(i, DF_ENUM_DTCNUM);
			}
		}
		uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

		while (1)
		{
			uRetBtn = uiSystem.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_CLEAR_DTC)
			{
				uiSystem.SetClearStatus(DF_SYS_CLEAR_START);
				uiSystem.SetClearStatus(DF_SYS_CLEAR_FINISH);
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetButtonAreaHidden()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SetButtonAreaHidden");
		uiMenu.AddItem(artiGetText("FF0B00000011"));//"隐藏扫描按键"
		uiMenu.AddItem(artiGetText("FF0B00000012"));//"显示扫描按键"

		bool bIsHidden = true;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				bIsHidden = true;
			}
			else if (1 == uRetBtn)
			{
				bIsHidden = false;
			}

			CArtiSystem uiSystem;
			uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
			for (uint32_t i = 0; i < 20; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
				uiSystem.AddItem(buff);
			}

			uiSystem.SetButtonAreaHidden(bIsHidden);
			uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

			while (1)
			{
				uRetBtn = uiSystem.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetScanStatus()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SetScanStatus");
		uiMenu.AddItem(artiGetText("FF0B00000013"));//"开始扫描"
		uiMenu.AddItem(artiGetText("FF0B00000014"));//"暂停扫描"
		uiMenu.AddItem(artiGetText("FF0B00000015"));//"扫描结束"

		uint32_t uStatus = DF_SYS_SCAN_START;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				uStatus = DF_SYS_SCAN_START;
			}
			else if (1 == uRetBtn)
			{
				uStatus = DF_SYS_SCAN_PAUSE;
			}
			else
			{
				uStatus = DF_SYS_SCAN_FINISH;
			}

			CArtiSystem uiSystem;
			uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
			for (uint32_t i = 0; i < 20; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
				uiSystem.AddItem(buff);
			}

			uiSystem.SetScanStatus(uStatus);
			ShowMsgBoxDemo("SetScanStatus", artiGetText("FF0B00000023"));		//"设置系统扫描状态成功"
			uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

			while (1)
			{
				uRetBtn = uiSystem.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetClearStatus()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SetClearStatus");
		uiMenu.AddItem(artiGetText("FF0B00000016"));//"一键清码开始"
		uiMenu.AddItem(artiGetText("FF0B00000017"));//"一键清码结束"

		uint32_t uStatus = 0;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				uStatus = DF_SYS_CLEAR_START;
			}
			else if (1 == uRetBtn)
			{
				uStatus = DF_SYS_CLEAR_FINISH;
			}

			CArtiSystem uiSystem;

			uiSystem.InitTitle(artiGetText("FF0B00000001"));		//"系统列表";
			for (uint32_t i = 0; i < 20; i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
				uiSystem.AddItem(buff);

				if (i % 4 == 0)
				{
					uiSystem.SetItemResult(i, DF_ENUM_UNKNOWN);
				}
				else if (i % 4 == 1)
				{
					uiSystem.SetItemResult(i, DF_ENUM_NOTEXIST);
				}
				else if (i % 4 == 2)
				{
					uiSystem.SetItemResult(i, DF_ENUM_NODTC);
				}
				else if (i % 4 == 3)
				{
					uiSystem.SetItemResult(i, DF_ENUM_DTCNUM);
				}
			}
			uiSystem.SetClearStatus(uStatus);
			ShowMsgBoxDemo("SetClearStatus", artiGetText("FF0B00000024"));		//"设置一键清码状态成功"
			uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

			while (1)
			{
				uRetBtn = uiSystem.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_CLEAR_DTC)
				{
					uiSystem.SetClearStatus(DF_SYS_CLEAR_START);
					uiSystem.SetClearStatus(DF_SYS_CLEAR_FINISH);
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_GetDiagMenuMask()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif

		map<uint64_t, string>	mapintstrSys;

		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_ECM_CLASS] = "Engine";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_TCM_CLASS] = "TCM";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_ABS_CLASS] = "ABS";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_SRS_CLASS] = "SRS";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_HVAC_CLASS] = "HVAC";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_ADAS_CLASS] = "ADAS";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_IMMO_CLASS] = "IMMO";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_BMS_CLASS] = "BMS";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_EPS_CLASS] = "EPS";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_LED_CLASS] = "LED";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_IC_CLASS] = "IC";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_INFORMA_CLASS] = "INFORMA";
		mapintstrSys[(uint64_t)CArtiGlobal::eDiagMenuMask::DMM_BCM_CLASS] = "BCM";
		uint64_t	uMask = (uint64_t)CArtiGlobal::GetDiagMenuMask();
		char		chvalue[100];

		SPRINTF_S(chvalue, "%lu", uMask);
		artiShowMsgBox("Mask", chvalue);
		uiMenu.InitTitle("GetDiagMenuMask");
		uiMenu.AddItem("ALL System");//所有系统
		uiMenu.AddItem("Mask System");//Mask 系统

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				CArtiSystem uiSystem;
				uiSystem.InitTitle(artiGetText("FF0B00000001"));//"系统列表";

				if (0 == uRetBtn)
				{
					for (map<uint64_t,string>::iterator it = mapintstrSys.begin(); it != mapintstrSys.end(); it++)
					{
						uiSystem.AddItem(it->second);
					}
				}
				else
				{
					for (map<uint64_t, string>::iterator it = mapintstrSys.begin(); it != mapintstrSys.end(); it++)
					{

						if (it->first & uMask)
						{
							uiSystem.AddItem(it->second);
						}
					}
				}

				while (1)
				{
					uRetBtn = uiSystem.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiSystemTest::ArtiSystemTest_SetAtuoScanEnable()
	{
		CArtiMenu	uiMenu;
		bool		bSet = true;

		uiMenu.InitTitle("Test SetAtuoScanEnable");
		uiMenu.AddItem("Test False");
		uiMenu.AddItem("Test True");

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			if (uRet == 0)
			{
				bSet = false;
			}
			else if (uRet == 1)
			{
				bSet = true;
			}
			SetAtuoScanEnableScanSys(bSet);
		}
	}

	void CArtiSystemTest::SetAtuoScanEnableScanSys(bool bAutoScan)
	{
		CArtiSystem uiSystem;
		uint32_t uCnt = 20;
		string strItem = "";
		vector<string> vctSys;
		uint32_t	iScan = 0;

		uiSystem.InitTitle(artiGetText("FF0B00000001"));//"系统列表");
		for (uint32_t i = 0; i < uCnt; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0B00000007").c_str(), i);//"第%d个系统"
			vctSys.push_back(buff);
			uiSystem.AddItem(buff);
		}
		uiSystem.SetAtuoScanEnable(bAutoScan);
		while (1)
		{
			uRetBtn = uiSystem.Show();
			if (uRetBtn == DF_ID_CANCEL)
			{
				break;
			}
			else if (uRetBtn == DF_ID_SYS_START)
			{
				if (iScan == vctSys.size())
				{
					iScan = 0;
					vctSys.clear();
				}
				uiSystem.SetScanStatus(DF_SYS_SCAN_START);
				uiSystem.Show();
				for (; iScan < vctSys.size(); iScan++)
				{
					uiSystem.SetItemStatus(iScan, artiGetText("FFFFFFFF0022"));
					uiSystem.Show();
					Delay(500);
					uiSystem.SetItemResult(iScan, DF_ENUM_NODTC);
					uiSystem.Show();
				}
				if (iScan == vctSys.size())
				{
					uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);
				}
			}
		}
	}
}