#include "DemoArtiTroubleTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiTroubleTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("AddItem");		            vctMenuID.push_back(1);
		uiMenu.AddItem("SetItemHelp");	            vctMenuID.push_back(2);
		uiMenu.AddItem("SetMILStatus");	            vctMenuID.push_back(3);
		uiMenu.AddItem("SetFreezeStatus");	        vctMenuID.push_back(4);
		uiMenu.AddItem("SetCdtcButtonVisible");	    vctMenuID.push_back(5);
		uiMenu.AddItem("SetRepairManualInfo");	    vctMenuID.push_back(6);
		uiMenu.AddItem("AddItemEx");		        vctMenuID.push_back(7);

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
					ArtiTroubleTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_AddItem();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_SetItemHelp();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_SetMILStatus();
				}
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_SetFreezeStatus();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_SetCdtcButtonVisible();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_SetRepairManualInfo();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiTroubleTest_AddItemEx();
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0C00000015"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF0C00000016"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF0C00000017"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF0C00000018"));	//"标题文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0C00000019"));	//"标题文本中文长度达到阈值"

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
				strTitle = artiGetText("FF0C00000000");
			}
			else if (2 == uRetBtn)
			{
				strTitle = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");//1000个英文半角字符
			}
			else
			{
				strTitle = artiGetText("FF1200000004");//500个中文全角字符
			}


#if __Multi_System_Test__
			CArtiTrouble uiTrouble(m_uThread);
#else
			CArtiTrouble uiTrouble;
#endif
			uiTrouble.InitTitle(strTitle);
			uiTrouble.AddItem(artiGetText("FF0C00000001"), artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));

			while (1)
			{
				uRetBtn = uiTrouble.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_AddItem()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C00000005"));//"故障码号、描述、状态和帮助信息文本为空为空"
		uiMenu.AddItem(artiGetText("FF0C00000006"));//"故障码号、描述、状态和帮助信息文本为单行文本"
		uiMenu.AddItem(artiGetText("FF0C00000007"));//"故障码号、描述、状态和帮助信息文本为多行文本"
		uiMenu.AddItem(artiGetText("FF0C0000001A"));//"故障码号、描述、状态和帮助信息文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0C0000001B"));//"故障码号、描述、状态和帮助信息文本中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0C0000001C"));//"故障码数量达到阈值"

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
				CArtiTrouble uiTrouble(m_uThread);
#else
				CArtiTrouble uiTrouble;
#endif
				uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

				if (0 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						uiTrouble.AddItem("", "", "", "");
					}
				}
				else if (1 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
						uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));
					}
				}
				else if (2 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						uiTrouble.AddItem(TextMulitLineTitle, TextMulitLineValue, TextMulitLineUnit, TextMulitLineHelp);
					}
				}
				else if (3 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						uiTrouble.AddItem(artiGetText("FF1100000002"), artiGetText("FF1100000004"), artiGetText("FF1100000004"), artiGetText("FF1100000007"));
					}
				}
				else if (4 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						uiTrouble.AddItem(artiGetText("FF1200000002"), artiGetText("FF1200000004"), artiGetText("FF1200000004"), artiGetText("FF1200000007"));
					}
				}
				else if (5 == uRetBtn)
				{
					for (uint32_t i = 0; i < 10000; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
						uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));
					}
				}


				while (1)
				{
					uRetBtn = uiTrouble.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_AddItemEx()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C00000005"));//"故障码号、描述、状态和帮助信息文本为空为空"
		uiMenu.AddItem(artiGetText("FF0C00000006"));//"故障码号、描述、状态和帮助信息文本为单行文本"
		uiMenu.AddItem(artiGetText("FF0C00000007"));//"故障码号、描述、状态和帮助信息文本为多行文本"
		uiMenu.AddItem(artiGetText("FF0C0000001A"));//"故障码号、描述、状态和帮助信息文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0C0000001B"));//"故障码号、描述、状态和帮助信息文本中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0C0000001C"));//"故障码数量达到阈值"

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
				CArtiTrouble uiTrouble(m_uThread);
#else
				CArtiTrouble uiTrouble;
#endif
				uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

				if (0 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						stDtcNodeEx oneDtcNodeEx;

						oneDtcNodeEx.strCode = "";
						oneDtcNodeEx.strDescription = "";
						oneDtcNodeEx.strStatus = "";
						oneDtcNodeEx.uStatus = DF_DTC_STATUS_HISTORY;
						uiTrouble.AddItemEx(oneDtcNodeEx, "");
					}
				}
				else if (1 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
						stDtcNodeEx oneDtcNodeEx;
						oneDtcNodeEx.strCode = buff;
						oneDtcNodeEx.strDescription = artiGetText("FF0C00000002");
						oneDtcNodeEx.strStatus = artiGetText("FF0C00000003");
						oneDtcNodeEx.uStatus = DF_DTC_STATUS_HISTORY;
						uiTrouble.AddItemEx(oneDtcNodeEx, artiGetText("FF0C00000004"));
					}
				}
				else if (2 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						stDtcNodeEx oneDtcNodeEx;
						oneDtcNodeEx.strCode = TextMulitLineTitle;
						oneDtcNodeEx.strDescription = TextMulitLineValue;
						oneDtcNodeEx.strStatus = TextMulitLineUnit;
						oneDtcNodeEx.uStatus = DF_DTC_STATUS_CURRENT;
						uiTrouble.AddItemEx(oneDtcNodeEx, TextMulitLineHelp);
					}
				}
				else if (3 == uRetBtn)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						stDtcNodeEx oneDtcNodeEx;
						oneDtcNodeEx.strCode = artiGetText("FF1100000002");
						oneDtcNodeEx.strDescription = artiGetText("FF1100000004");
						oneDtcNodeEx.strStatus = artiGetText("FF1100000004");
						oneDtcNodeEx.uStatus = DF_DTC_STATUS_CURRENT;
						uiTrouble.AddItemEx(oneDtcNodeEx, artiGetText("FF1100000007"));
					}
				}
				else if (4 == uRetBtn)
				{
					for (uint32_t i = 0; i < 500; i++)
					{
						stDtcNodeEx oneDtcNodeEx;
						oneDtcNodeEx.strCode = artiGetText("FF1200000002");
						oneDtcNodeEx.strDescription = artiGetText("FF1200000004");
						oneDtcNodeEx.strStatus = artiGetText("FF1200000004");
						oneDtcNodeEx.uStatus = DF_DTC_STATUS_CURRENT;
						uiTrouble.AddItemEx(oneDtcNodeEx, artiGetText("FF1200000007"));
					}
				}
				else if (5 == uRetBtn)
				{
					for (uint32_t i = 0; i < 10000; i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
						stDtcNodeEx oneDtcNodeEx;
						oneDtcNodeEx.strCode = buff;
						oneDtcNodeEx.strDescription = artiGetText("FF0C00000002");
						oneDtcNodeEx.strStatus = artiGetText("FF0C00000003");
						oneDtcNodeEx.uStatus = DF_DTC_STATUS_HISTORY;
						uiTrouble.AddItemEx(oneDtcNodeEx, artiGetText("FF0C00000004"));
					}
				}


				while (1)
				{
					uRetBtn = uiTrouble.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_SetItemHelp()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C0000001D"));//"故障码帮助信息文本为空"
		uiMenu.AddItem(artiGetText("FF0C0000001E"));//"故障码帮助信息文本为单行"
		uiMenu.AddItem(artiGetText("FF0C0000001F"));//"故障码帮助信息文本为多行"
		uiMenu.AddItem(artiGetText("FF0C00000020"));//"故障码帮助信息文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0C00000021"));//"故障码帮助信息文本中文长度达到阈值"


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
				CArtiTrouble uiTrouble(m_uThread);
#else
				CArtiTrouble uiTrouble;
#endif
				uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

				for (uint32_t i = 0; i < 50; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
					uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), "");
				}

				if (uSelect == 0)
				{
					uiTrouble.SetItemHelp(0, "");
					uiTrouble.SetItemHelp(3, "");
				}
				else if (uSelect == 1)
				{
					uiTrouble.SetItemHelp(0, artiGetText("FF0C0000000A"));
					uiTrouble.SetItemHelp(3, artiGetText("FF0C0000000A"));
				}
				else if (uSelect == 2)
				{
					uiTrouble.SetItemHelp(0, TextMulitLineHelp);
					uiTrouble.SetItemHelp(3, TextMulitLineHelp);
				}
				else if (uSelect == 3)
				{
					uiTrouble.SetItemHelp(0, artiGetText("FF1100000007"));
					uiTrouble.SetItemHelp(3, artiGetText("FF1100000007"));
				}
				else if (uSelect == 4)
				{
					uiTrouble.SetItemHelp(0, artiGetText("FF1200000007"));
					uiTrouble.SetItemHelp(3, artiGetText("FF1200000007"));
				}

				while (1)
				{
					uRetBtn = uiTrouble.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_SetMILStatus()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C0000000B"));//"故障码显示故障灯"
		uiMenu.AddItem(artiGetText("FF0C0000000C"));//"故障码不显示故障灯"

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
				CArtiTrouble uiTrouble(m_uThread);
#else
				CArtiTrouble uiTrouble;
#endif
				uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

				for (uint32_t i = 0; i < 50; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
					uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));
				}

				if (uSelect == 0)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						if (i % 2 == 1)
						{
							uiTrouble.SetMILStatus(i, true);
						}
					}
				}
				else
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						uiTrouble.SetMILStatus(i, true);
					}
					for (uint32_t i = 0; i < 50; i++)
					{
						if (i % 2 == 1)
						{
							uiTrouble.SetMILStatus(i, false);
						}
					}
				}

				while (1)
				{
					uRetBtn = uiTrouble.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_SetFreezeStatus()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C00000011"));//"故障码显示冻结帧"
		uiMenu.AddItem(artiGetText("FF0C00000012"));//"故障码不显示冻结帧"

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
				CArtiTrouble uiTrouble(m_uThread);
#else
				CArtiTrouble uiTrouble;
#endif
				uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

				for (uint32_t i = 0; i < 500; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
					uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));
				}

				if (uSelect == 0)
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						if (i % 2 == 1)
						{
							uiTrouble.SetFreezeStatus(i, true);
						}
					}
				}
				else
				{
					for (uint32_t i = 0; i < 50; i++)
					{
						uiTrouble.SetFreezeStatus(i, true);
					}
					for (uint32_t i = 0; i < 50; i++)
					{
						if (i % 2 == 1)
						{
							uiTrouble.SetFreezeStatus(i, false);
						}
					}
				}

				while (1)
				{
					uRetBtn = uiTrouble.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_SetCdtcButtonVisible()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C0000000F"));//"显示清码按钮"
		uiMenu.AddItem(artiGetText("FF0C00000010"));//"隐藏清码按钮"

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
				CArtiTrouble uiTrouble(m_uThread);
#else
				CArtiTrouble uiTrouble;
#endif

				uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

				for (uint32_t i = 0; i < 500; i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
					uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));
				}

				if (uSelect == 0)
				{
					uiTrouble.SetCdtcButtonVisible(true);
				}
				else
				{
					uiTrouble.SetCdtcButtonVisible(false);
				}

				while (1)
				{
					uRetBtn = uiTrouble.Show();
					if (uRetBtn == DF_ID_CANCEL)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiTroubleTest::ArtiTroubleTest_SetRepairManualInfo()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));
		uiMenu.AddItem(artiGetText("FF0C00000022"));//"现代"
		uiMenu.AddItem(artiGetText("FF0C00000023"));//"奥迪"


		CArtiTrouble uiTrouble;

		uiTrouble.InitTitle(artiGetText("FF0C00000008"));//"故障码列表"

		for (uint32_t i = 0; i < 10; i++)
		{
			memset(buff, 0, sizeof(buff));
			SPRINTF_S(buff, artiGetText("FF0C00000009").c_str(), i);//"第%d个故障码"
			uiTrouble.AddItem(buff, artiGetText("FF0C00000002"), artiGetText("FF0C00000003"), artiGetText("FF0C00000004"));
		}
		uiTrouble.SetCdtcButtonVisible(false);

		vector<stRepairInfoItem> vctAudiDtcInfo;
		vector<stRepairInfoItem> vctNissanDtcInfo;

		stRepairInfoItem repairInfoItem;
		repairInfoItem.eType = eRepairInfoType::RIT_DTC_CODE;		//  表示故障码编码
		repairInfoItem.strValue = "P1000";
		vctAudiDtcInfo.push_back(repairInfoItem);
		repairInfoItem.strValue = "P0011";
		vctNissanDtcInfo.push_back(repairInfoItem);

		repairInfoItem.eType = eRepairInfoType::RIT_VEHICLE_BRAND;	//  表示车辆品牌
		repairInfoItem.strValue = "AUDI";
		vctAudiDtcInfo.push_back(repairInfoItem);

		repairInfoItem.strValue = "Nissan";
		vctNissanDtcInfo.push_back(repairInfoItem);

		repairInfoItem.eType = eRepairInfoType::RIT_VEHICLE_MODEL;	//  表示车型
		repairInfoItem.strValue = "A8";
		vctAudiDtcInfo.push_back(repairInfoItem);
		repairInfoItem.strValue = "MAXIMA";
		vctNissanDtcInfo.push_back(repairInfoItem);

		repairInfoItem.eType = eRepairInfoType::RIT_VEHICLE_YEAR;	//  表示车辆年款
		repairInfoItem.strValue = "2014";
		vctAudiDtcInfo.push_back(repairInfoItem);
		repairInfoItem.strValue = "2013";
		vctNissanDtcInfo.push_back(repairInfoItem);

		repairInfoItem.eType = eRepairInfoType::RIT_VIN;			//  表示车辆VIN
		repairInfoItem.strValue = "KMHSH81DX9U478798";
		vctAudiDtcInfo.push_back(repairInfoItem);

		repairInfoItem.eType = eRepairInfoType::RIT_SYSTEM_NAME;	//  表示系统名称
		repairInfoItem.strValue = "Engine System";
		vctAudiDtcInfo.push_back(repairInfoItem);

		uint32_t uRetTroBtn = DF_ID_NOKEY;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				while (1)
				{
					uRetTroBtn = uiTrouble.Show();
					if (uRetTroBtn == DF_ID_CANCEL)
					{
						break;
					}
					else if ((uRetTroBtn & DF_ID_REPAIR_MANUAL_0) != 0)
					{
						if (0 == uRetBtn)
						{
							uiTrouble.SetRepairManualInfo(vctNissanDtcInfo);
						}
						else if (1 == uRetBtn)
						{
							uiTrouble.SetRepairManualInfo(vctAudiDtcInfo);
						}
					}
				}
			}		
		}
	}

}