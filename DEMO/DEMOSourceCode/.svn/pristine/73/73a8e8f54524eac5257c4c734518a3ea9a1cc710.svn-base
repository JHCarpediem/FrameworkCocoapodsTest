#include "DemoArtiLiveDataTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiLiveDataTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("AddItem");	                vctMenuID.push_back(1);
		uiMenu.AddItem("SetNextButtonVisible");	    vctMenuID.push_back(2);
		uiMenu.AddItem("SetNextButtonText");	    vctMenuID.push_back(3);		
		uiMenu.AddItem("FlushValue");	            vctMenuID.push_back(4);
		uiMenu.AddItem("GetUpdateItems");	        vctMenuID.push_back(5);
		uiMenu.AddItem("GetItemIsUpdate");	        vctMenuID.push_back(6);
		uiMenu.AddItem("SetColWidth");				vctMenuID.push_back(7);
		uiMenu.AddItem("Show");						vctMenuID.push_back(8);
		uiMenu.AddItem("SetPrevButtonVisible");	    vctMenuID.push_back(9);
		uiMenu.AddItem("SetPrevButtonText");	    vctMenuID.push_back(10);
		uiMenu.AddItem("SetAllValue");				vctMenuID.push_back(11);
		uiMenu.AddItem("Tp005ComponentTesting");	vctMenuID.push_back(12);
		uiMenu.AddItem("GetSearchItems");			vctMenuID.push_back(13);

		
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
					ArtiLiveDataTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_AddItem();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_SetNextButtonVisible();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_SetNextButtonText();
				}					
				else if (4 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_FlushValue();
				}
				else if (5 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_GetUpdateItems();
				}
				else if (6 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_GetItemIsUpdate();
				}
				else if (7 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_SetColWidth();
				}
				else if (8 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_Show();
				}
				else if (9 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_SetPrevButtonVisible();
				}
				else if (10 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_SetPrevButtonText();
				}
				else if (11 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_SetAllValue();
				}
				else if (12 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_Tp005ComponentTesting();
				}
				else if (13 == vctMenuID[uRetBtn])
				{
					ArtiLiveDataTest_GetSearchItems();
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_InitTitle()
	{
		string strTitle;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF070000001D"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF070000001E"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF070000001F"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF070000002C"));	//"标题英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF070000002D"));	//"标题中文长度达到阈值"

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
				strTitle = artiGetText("FF0700000000");//"数据流控件测试"
			}
			else if (2 == uRetBtn)
			{
				strTitle = TextMulitLineTitle;
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");
			}
			else
			{
				strTitle = artiGetText("FF1200000004");
			}


#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(strTitle);
			for (uint32_t i = 0; i < 5; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_AddItem()
	{
		string strTitle = artiGetText("FF0700000000");//"数据流控件测试"
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0700000007"));	//"数据流项名称、值、单位、最小参考值、最大参考值、枚举参考值为空"
		uiMenu.AddItem(artiGetText("FF0700000008"));	//"数据流项名称、值、单位、最小参考值、最大参考值、枚举参考值为单行文本"
		uiMenu.AddItem(artiGetText("FF0700000009"));	//"数据流项名称、值、单位、最小参考值、最大参考值、枚举参考值为多行文本"
		uiMenu.AddItem(artiGetText("FF070000002E"));	//"数据流项名称、值、单位、最小参考值、最大参考值、枚举参考值英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF070000002F"));	//"数据流项名称、值、单位、最小参考值、最大参考值、枚举参考值中文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0700000030"));	//"数据流项数量达到阈值"

		//uint32_t uSelect = 0;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(strTitle);

			for (uint32_t i = 0; i < 100; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				if (uRetBtn == 0)
				{
					uiLiveData.AddItem("", "", "", "", "", "");
				}
				else if (uRetBtn == 1)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
					strName = buff + artiGetText("FF0700000001");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
					strValue = buff + artiGetText("FF0700000002");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
					strUnit = buff + artiGetText("FF0700000003");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
					strMin = buff + artiGetText("FF0700000004");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
					strMax = buff + artiGetText("FF0700000005");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
					strRef = buff + artiGetText("FF0700000006");

					uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
				}
				else if (uRetBtn == 2)
				{
					uiLiveData.AddItem(TextMulitLineTitle, TextMulitLineValue, TextMulitLineUnit, TextMulitLineValue, TextMulitLineValue, TextMulitLineValue);
				}
				else if (uRetBtn == 3)
				{
					uiLiveData.AddItem(artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"), artiGetText("FF1100000005"));
				}
				else if (uRetBtn == 4)
				{
					uiLiveData.AddItem(artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"), artiGetText("FF1200000005"));
				}				
			}

			if (uRetBtn == 5)
			{
				for (uint32_t j = 0; j < 10000; j++)
				{
					string strName, strValue, strUnit, strMin, strMax, strRef;
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), j);//"第%d项数据流名称"
					strName = buff + artiGetText("FF0700000001");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), j);//"第%d项数据流值"
					strValue = buff + artiGetText("FF0700000002");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), j);//"第%d项数据流单位"
					strUnit = buff + artiGetText("FF0700000003");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), j);//"第%d项数据流最小参考值"
					strMin = buff + artiGetText("FF0700000004");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), j);//"第%d项数据流最大参考值"
					strMax = buff + artiGetText("FF0700000005");

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), j);//"第%d项数据流枚举类型参考值"
					strRef = buff + artiGetText("FF0700000006");

					uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
				}
			}
			

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_SetNextButtonVisible()
	{
		string strTitle = artiGetText("FF0700000000");//"数据流控件测试"
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF070000000A"));	//"显示Next按钮"
		uiMenu.AddItem(artiGetText("FF070000000B"));	//"隐藏Next按钮"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));
			for (uint32_t i = 0; i < 5; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			if (uRetBtn == 0)
			{
				uiLiveData.SetNextButtonVisible(true);
			}
			else
			{
				uiLiveData.SetNextButtonVisible(false);
			}

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_NEXT)
				{
					ShowMsgBoxDemo("Click Events", artiGetText("FF0700000031"));
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_SetNextButtonText()
	{
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF070000003B"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF070000003C"));	//"按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF070000003D"));	//"按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF0700000032"));	//"按钮文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0700000033"));	//"按钮文本中文长度达到阈值"

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
				strText = artiGetText("FF070000000C");//"测试Next按钮文本"
			}
			else if (2 == uRetBtn)
			{
				strText = artiGetText("FF1200000009");
			}
			else if (3 == uRetBtn)
			{
				strText = artiGetText("FF1100000002");
			}
			else
			{
				strText = artiGetText("FF1200000002");
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));//"数据流控件测试"
			for (uint32_t i = 0; i < 5; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			uiLiveData.SetNextButtonText(strText);
			uiLiveData.SetNextButtonVisible(true);

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_SetPrevButtonVisible()
	{
		string strTitle = artiGetText("FF0700000000");//"数据流控件测试"
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF070000003E"));	//"显示Prev按钮"
		uiMenu.AddItem(artiGetText("FF070000003F"));	//"隐藏Prev按钮"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));
			for (uint32_t i = 0; i < 5; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}
			if (uRetBtn == 0)
			{
				uiLiveData.SetPrevButtonVisible(true);
			}
			else
			{
				uiLiveData.SetPrevButtonVisible(false);
			}

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_PREV)
				{
					ShowMsgBoxDemo("Click Events", artiGetText("FF0700000034"));
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_SetPrevButtonText()
	{
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF070000003B"));	//"按钮文本为空"
		uiMenu.AddItem(artiGetText("FF070000003C"));	//"按钮文本为单行"
		uiMenu.AddItem(artiGetText("FF070000003D"));	//"按钮文本为多行"
		uiMenu.AddItem(artiGetText("FF0700000032"));	//"按钮文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0700000033"));	//"按钮文本中文长度达到阈值"

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
				strText = artiGetText("FF0700000040");//"测试Prev按钮文本"
			}
			else if (2 == uRetBtn)
			{
				strText = artiGetText("FF1200000009");
			}
			else if (3 == uRetBtn)
			{
				strText = artiGetText("FF1100000002");
			}
			else
			{
				strText = artiGetText("FF1200000002");
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));//"数据流控件测试"
			for (uint32_t i = 0; i < 5; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}
			uiLiveData.SetPrevButtonVisible(true);
			uiLiveData.SetPrevButtonText(strText);

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_PREV)
				{
					ShowMsgBoxDemo("Click Events", artiGetText("FF0700000031"));
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_SetAllValue()
	{
		string strTitle;
		string strValue;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0700000035"));	//"数据流项名称-值-参考值-单位-帮助信息为空"
		uiMenu.AddItem(artiGetText("FF0700000036"));	//"数据流项名称-值-参考值-单位-帮助信息为单行文本"
		uiMenu.AddItem(artiGetText("FF0700000037"));	//"数据流项名称-值-参考值-单位-帮助信息为多行文本"
		uiMenu.AddItem(artiGetText("FF0700000038"));	//"数据流项名称-值-参考值-单位-帮助信息英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF0700000039"));	//"数据流项名称-值-参考值-单位-帮助信息中文长度达到阈值"


		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == uRetBtn)
			{
				strTitle = artiGetText("FF0700000035");
				strValue = "";
			}
			else if (1 == uRetBtn)
			{
				strTitle = artiGetText("FF0700000036");	
				strValue = artiGetText("FF0700000000");	
			}
			else if (2 == uRetBtn)
			{
				strTitle = artiGetText("FF0700000037");
				strValue = TextMulitLineTitle;			
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF0700000038");
				strValue = artiGetText("FF1100000005");	
			}
			else if (4 == uRetBtn)
			{
				strTitle = artiGetText("FF0700000039");
				strValue = artiGetText("FF1200000005");	
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(strTitle);
			uiLiveData.SetNextButtonVisible(true);
			uiLiveData.SetNextButtonText("Change");
			for (uint32_t i = 0; i < 5; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_LIVEDATA_NEXT)
				{
					for (uint32_t i = 0; i < 5; i++)
					{
						uiLiveData.SetName(i, strValue);				//修改名称	
						uiLiveData.SetVaule(i, strValue);				//修改值	
						uiLiveData.SetUnit(i, strValue);				//修改单位
						uiLiveData.SetLimits(i, strValue, strValue);	//修改取值范围
						uiLiveData.SetReference(i, strValue);			//修改枚举值
						uiLiveData.SetHelpText(i, strValue);			//修改帮助信息
					}
					uiLiveData.SetNextButtonVisible(false);
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_SetColWidth()
	{
#if __Multi_System_Test__
		CArtiLiveData uiLiveData(m_uThread);
#else
		CArtiLiveData uiLiveData;
#endif
		CArtiMenu	uiArtiMenu;

		uiArtiMenu.InitTitle("ColWidth");
		uiArtiMenu.AddItem("25, 25, 25, 25");
		uiArtiMenu.AddItem("10, 20, 30, 40");
		uiArtiMenu.AddItem("40, 30, 20, 10");
		uiArtiMenu.AddItem("100, 0, 0, 0");

		while (1)
		{
			uint32_t uRet = uiArtiMenu.Show();
			if (uRet==DF_ID_BACK)
			{
				break;
			}
			uiLiveData.InitTitle(artiGetText("FF0700000000"));//"数据流控件测试"
			if (0 == (uRet&0xff))
			{
				uiLiveData.SetColWidth(25, 25, 25, 25);
			}
			else if (1 == (uRet&0xff))
			{
				uiLiveData.SetColWidth(10, 20, 30, 40);
			}
			else if (2 == (uRet&0xff))
			{
				uiLiveData.SetColWidth(40, 30, 20, 10);
			}
			else if (3 == (uRet & 0xff))
			{
				uiLiveData.SetColWidth(100, 0, 0, 0);
			}
			for (uint32_t i = 0; i < 50; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			uiLiveData.SetNextButtonVisible(true);
			uiLiveData.SetNextButtonText(artiGetText("FF0700000015"));//Next

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_NEXT)
				{
					artiShowMsgBox("press next", "press next", DF_MB_OK);
					break;
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_FlushValue()
	{
		vector<uint32_t> vctMenuID;
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF070000000D"));	vctMenuID.push_back(3);//"动态刷新"
		uiMenu.AddItem(artiGetText("FF0700000012"));	vctMenuID.push_back(4);//"点击[Next]刷新"

		uint32_t uSelect = 0;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

			uSelect = vctMenuID[uRetBtn];
#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));//"数据流控件测试"
			/*
			*	计算的发动机负荷	0	100	%
				发动机冷却液温度	-40	215	℃
				燃油压力	0	765	kPa
				进气歧管绝对压力	0	255	kPa
				引擎速度	0	16383.75
				车速	0	255	km/h
				进气温度	-40	215	℃
			*/
			uiLiveData.AddItem(artiGetText("FF0700000020"), "", artiGetText("FF0700000019"), "0", "100");
			uiLiveData.AddItem(artiGetText("FF0700000021"), "", artiGetText("FF070000001A"), "-40", "215");
			uiLiveData.AddItem(artiGetText("FF0700000022"), "", artiGetText("FF070000001B"), "0", "765");
			uiLiveData.AddItem(artiGetText("FF0700000023"), "", artiGetText("FF070000001B"), "0", "255");
			uiLiveData.AddItem(artiGetText("FF0700000024"), "", "", "0", "16383.75");
			uiLiveData.AddItem(artiGetText("FF0700000025"), "", artiGetText("FF070000001C"), "0", "255");
			uiLiveData.AddItem(artiGetText("FF0700000026"), "", artiGetText("FF070000001A"), "-40", "215");

			uiLiveData.SetNextButtonVisible(true);
			uiLiveData.SetNextButtonText(artiGetText("FF0700000015"));//Next

			bool bNext = false;
			vector<uint16_t> vctUpdateItems;

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_NEXT)
				{
					bNext = !bNext;
				}

				if ((uSelect == 3 && !bNext) || (uSelect == 4 && bNext))
				{
					vctUpdateItems = uiLiveData.GetUpdateItems();
					for (uint32_t i = 0; i < vctUpdateItems.size(); i++)
					{
						uint32_t uValue = 0;
						string strValue = "";
						switch (vctUpdateItems[i])
						{
						case 0:
							uValue = rand() % 100;
							strValue = uint32ToString(uValue);
							break;
						case 1:
							uValue = rand() % 255 - 40;
							strValue = uint32ToString(uValue);
							break;
						case 2:
							uValue = rand() % 765;
							strValue = uint32ToString(uValue);
							break;						
						case 3:		
							strValue = "";								//为空
							break;
						case 4:
							strValue = TextMulitLineTitle;				//多行
							break;
						case 5:
							strValue = artiGetText("FF1100000005");		//英文文本长度达到阈值
							break;
						case 6:
							strValue = artiGetText("FF1200000005");		//中文文本长度达到阈值
							break;
						default:
							break;
						}

						uiLiveData.FlushValue(vctUpdateItems[i], strValue);
					}

					if (uSelect == 4)
					{
						bNext = !bNext;
					}
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_GetUpdateItems()
	{
		vector<uint32_t> vctMenuID;
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0700000013"));	vctMenuID.push_back(4);//"点击[Next]刷新"


		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));//"数据流控件测试"
			for (uint32_t i = 0; i < 50; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			uiLiveData.SetNextButtonVisible(true);
			uiLiveData.SetNextButtonText(artiGetText("FF0700000015"));//Next

			//bool bNext = false;
			//uint32_t uCnt = 0;
			vector<uint16_t> vctUpdateItems;

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_NEXT)
				{
					strText = "";
					vctUpdateItems = uiLiveData.GetUpdateItems();
					for (uint32_t i = 0; i < vctUpdateItems.size(); i++)
					{
						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, "%d\n", vctUpdateItems[i]);
						strText = strText + buff;
					}
					ShowMsgBoxDemo(artiGetText("FF0700000014"), strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_GetItemIsUpdate()
	{
		string strText;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF0700000013"));	

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

#if __Multi_System_Test__
			CArtiLiveData uiLiveData(m_uThread);
#else
			CArtiLiveData uiLiveData;
#endif
			uiLiveData.InitTitle(artiGetText("FF0700000000"));//"数据流控件测试"
			for (uint32_t i = 0; i < 50; i++)
			{
				string strName, strValue, strUnit, strMin, strMax, strRef;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流名称"
				strName = buff + artiGetText("FF0700000001");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流值"
				strValue = buff + artiGetText("FF0700000002");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流单位"
				strUnit = buff + artiGetText("FF0700000003");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最小参考值"
				strMin = buff + artiGetText("FF0700000004");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流最大参考值"
				strMax = buff + artiGetText("FF0700000005");

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), i);//"第%d项数据流枚举类型参考值"
				strRef = buff + artiGetText("FF0700000006");

				uiLiveData.AddItem(strName, strValue, strUnit, strMin, strMax, strRef);
			}

			uiLiveData.SetNextButtonVisible(true);
			uiLiveData.SetNextButtonText(artiGetText("FF0700000015"));//Next

			bool bUpdate = false;
			//uint32_t uCnt = 0;
			vector<uint16_t> vctUpdateItems;

			while (1)
			{
				uRetBtn = uiLiveData.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
				else if (uRetBtn == DF_ID_NEXT)
				{
					strText = "";
					for (uint32_t Index = 0; Index < 50; Index++)
					{
						bUpdate = uiLiveData.GetItemIsUpdate(Index);

						memset(buff, 0, sizeof(buff));
						SPRINTF_S(buff, artiGetText("FF0000000024").c_str(), Index);//"第%d项"

						if (bUpdate)
						{
							strText = strText + buff + artiGetText("FF0700000016") + "\n";
						}
						else
						{
							strText = strText + buff + artiGetText("FF0700000017") + "\n";
						}
					}
					ShowMsgBoxDemo(artiGetText("FF0700000018"), strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_GetSearchItems()
	{
		CArtiLiveData	uiLive;
		vector<string>	vctLive;


		uiLive.InitTitle("Test GetSearchItems");
		vctLive.push_back("Engine speed 1");
		vctLive.push_back("Vehicle speed 1");
		vctLive.push_back("battery 1");
		vctLive.push_back("Engine speed 2");
		vctLive.push_back("Vehicle speed 2");
		vctLive.push_back("battery 2");
		vctLive.push_back("Engine speed 1");
		vctLive.push_back("Vehicle speed 1");
		vctLive.push_back("battery 1");
		vctLive.push_back("Engine speed 3");
		vctLive.push_back("Vehicle speed 3");
		vctLive.push_back("battery 3");
		vctLive.push_back("Engine speed 1");
		vctLive.push_back("Vehicle speed 1");
		vctLive.push_back("battery 1");
		vctLive.push_back("Engine speed 4");
		vctLive.push_back("Vehicle speed 4");
		vctLive.push_back("battery 4");

		for (auto strData : vctLive)
		{
			uiLive.AddItem(strData, "111");
		}

		while (1)
		{
			uint32_t uRet = uiLive.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			else if (uRet == DF_ID_LIVEDATA_REPORT)
			{
				vector<uint16_t> vctint;
				vector<stDsReportItem> vctDsReport;

				vctint = uiLive.GetSearchItems();

				for (auto iItem : vctint)
				{
					// 设置诊断报告项 
					stDsReportItem dsReportItem;
					dsReportItem.strName = vctLive[iItem];
					dsReportItem.strValue = "111";
					vctDsReport.push_back(dsReportItem);
				}
				//设置系统报告
				CArtiReport uiReport;
				uiReport.InitTitle("Report");			//诊断报告
				uiReport.SetReportType(CArtiReport::REPORT_TYPE_DATA_STREAM);
				uiReport.SetTypeTitle("Live Data");			//"故障码&冻结帧"
				uiReport.SetVehPath("");
				uiReport.AddLiveDataSys("1", "Test");
				uiReport.AddLiveDataItems(vctDsReport);

				while (1)
				{
					if (uiReport.Show() == DF_ID_BACK)
					{
						break;
					}
				}
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_Show()
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
				ArtiLiveDataTest_Show_Type1();
			}
			else if (1 == uRetBtn)
			{
				ArtiLiveDataTest_Show_Type2();
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_Show_Type1()
	{
		CArtiLiveData uiLiveData;
		uiLiveData.InitTitle(artiGetText("FF0000000110"));			//"按键响应时间测试"
		uiLiveData.AddItem(artiGetText("FF0000000112"), "0", "ms");	//"响应时间"
		uiLiveData.SetNextButtonVisible(true);

		while (1)
		{
			time_t time_start = GetSysTime();
			uRetBtn = uiLiveData.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				break;
			}
			else if (DF_ID_NEXT == uRetBtn)
			{
				time_t time_end = GetSysTime();
				uiLiveData.FlushValue(0, uint32ToString(time_end - time_start));
			}
		}
	}

	void CArtiLiveDataTest::ArtiLiveDataTest_Show_Type2()
	{
		CArtiLiveData uiLiveData1;
		uiLiveData1.InitTitle(artiGetText("FF0000000111"));//"连续点击按键测试"
		uiLiveData1.AddItem("Sleep", "2", "s");
		uiLiveData1.AddItem("Sleep", "4", "s");
		uiLiveData1.AddItem("Sleep", "6", "s");
		uiLiveData1.AddItem("Sleep", "8", "s");
		uiLiveData1.SetNextButtonVisible(true);

		while (1)
		{
			uRetBtn = uiLiveData1.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				return;
			}
			else if(DF_ID_NEXT == uRetBtn)
			{
				vector<uint16_t> vecRet = uiLiveData1.GetUpdateItems();
				if (vecRet.size() != 1)
				{
					artiShowMsgBox("Test tips", artiGetText("FF080000001F"));					
				}
				else
				{
					artiShowMsgBox("Test tips", "Sleep" + to_string((vecRet[0]+1) * 2) + "s", DF_MB_NOBUTTON, DT_CENTER, -1);
					Delay(vecRet[0] * 2000);
				}
				
			}
		}
	}	

	void CArtiLiveDataTest::ArtiLiveDataTest_Tp005ComponentTesting()
	{
		CArtiMenu	uiMenu;
		vector<uint64_t> vctuType;

		uiMenu.InitTitle("ComponentTesting");
		uiMenu.AddItem("ThrottleTest");
		uiMenu.AddItem("FuelTest");
		uiMenu.AddItem("AirFlowTest");
		uiMenu.AddItem("IntakePressureTest");
		uiMenu.AddItem("O2Test");

		vctuType.push_back(DF_TYPE_THROTTLE_CARBON);
		vctuType.push_back(DF_TYPE_FULE_CORRECTION);
		vctuType.push_back(DF_TYPE_MAF_TEST);
		vctuType.push_back(DF_TYPE_INTAKE_PRESSURE);
		vctuType.push_back(DF_TYPE_OXYGEN_SENSOR);


		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			else
			{
				CArtiMenu uiResultMenu;

				uiResultMenu.InitTitle("Result Type");
				if ((uRet&0xff)==0)
				{
					uiResultMenu.AddItem("DF_RESULT_THROTTLE_NORMAL");
					uiResultMenu.AddItem("DF_RESULT_THROTTLE_LIGHT_CARBON");
					uiResultMenu.AddItem("DF_RESULT_THROTTLE_SERIOUSLY");
				}
				else if ((uRet & 0xff) == 1)
				{
					uiResultMenu.AddItem("DF_RESULT_FULE_NORMAL");
					uiResultMenu.AddItem("DF_RESULT_FULE_HIGH");
					uiResultMenu.AddItem("DF_RESULT_FULE_LOW");
					uiResultMenu.AddItem("DF_RESULT_FULE_ABNORMAL");
				}
				else if ((uRet & 0xff) == 2)
				{
					uiResultMenu.AddItem("DF_RESULT_MAF_NORMAL");
					uiResultMenu.AddItem("DF_RESULT_MAF_HIGH");
					uiResultMenu.AddItem("DF_RESULT_MAF_LOW");
				}
				else if ((uRet & 0xff) == 3)
				{
					uiResultMenu.AddItem("DF_RESULT_INTAKE_PRESSURE_NORMAL");
					uiResultMenu.AddItem("DF_RESULT_INTAKE_PRESSURE_HIGH");
				}
				else
				{
					uiResultMenu.AddItem("DF_RESULT_OXYGEN_NORMAL");
					uiResultMenu.AddItem("DF_RESULT_OXYGEN_ERROR");
				}
				while (1)
				{
					uint32_t uResult = uiResultMenu.Show();
					if (uResult == DF_ID_BACK)
					{
						break;
					}
					else
					{
						CArtiLiveData	uiLiveData;

						uiLiveData.InitTitle(uiMenu.GetItem(uRet));
						uiLiveData.AddItem("Engine speed", "600", "rpm");
						uiLiveData.AddItem("Vehicle speed", "150", "km");
						uiLiveData.AddItem("Engine load", "20", "%");
#if 0
						uiLiveData.SetComponentType(vctuType[uRet & 0xff]);

						if (((uRet&0xff)==0)&&(uResult&0xff)==0)
						{
							uiLiveData.SetComponentResult(DF_RESULT_THROTTLE_NORMAL);
						}
						else if (((uRet & 0xff) == 0) && (uResult & 0xff) == 1)
						{
							uiLiveData.SetComponentResult(DF_RESULT_THROTTLE_LIGHT_CARBON);
						}
						else if (((uRet & 0xff) == 0) && (uResult & 0xff) == 2)
						{
							uiLiveData.SetComponentResult(DF_RESULT_THROTTLE_SERIOUSLY);
						}
						else if (((uRet & 0xff) == 1) && (uResult & 0xff) == 0)
						{
							uiLiveData.SetComponentResult(DF_RESULT_FULE_NORMAL);
						}
						else if (((uRet & 0xff) == 1) && (uResult & 0xff) == 1)
						{
							uiLiveData.SetComponentResult(DF_RESULT_FULE_HIGH);
						}
						else if (((uRet & 0xff) == 1) && (uResult & 0xff) == 2)
						{
							uiLiveData.SetComponentResult(DF_RESULT_FULE_LOW);
						}
						else if (((uRet & 0xff) == 1) && (uResult & 0xff) == 3)
						{
							uiLiveData.SetComponentResult(DF_RESULT_FULE_ABNORMAL);
						}
						else if (((uRet & 0xff) == 2) && (uResult & 0xff) == 0)
						{
							uiLiveData.SetComponentResult(DF_RESULT_MAF_NORMAL);
						}
						else if (((uRet & 0xff) == 2) && (uResult & 0xff) == 1)
						{
							uiLiveData.SetComponentResult(DF_RESULT_MAF_HIGH);
						}
						else if (((uRet & 0xff) == 2) && (uResult & 0xff) == 2)
						{
							uiLiveData.SetComponentResult(DF_RESULT_MAF_LOW);
						}
						else if (((uRet & 0xff) == 3) && (uResult & 0xff) == 0)
						{
							uiLiveData.SetComponentResult(DF_RESULT_INTAKE_PRESSURE_NORMAL);
						}
						else if (((uRet & 0xff) == 3) && (uResult & 0xff) == 1)
						{
							uiLiveData.SetComponentResult(DF_RESULT_INTAKE_PRESSURE_HIGH);
						}
						else if (((uRet & 0xff) == 4) && (uResult & 0xff) == 0)
						{
							uiLiveData.SetComponentResult(DF_RESULT_OXYGEN_NORMAL);
						}
						else if (((uRet & 0xff) == 4) && (uResult & 0xff) == 1)
						{
							uiLiveData.SetComponentResult(DF_RESULT_OXYGEN_ERROR);
						}
#endif

						while (1)
						{
							if (DF_ID_BACK == uiLiveData.Show())
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