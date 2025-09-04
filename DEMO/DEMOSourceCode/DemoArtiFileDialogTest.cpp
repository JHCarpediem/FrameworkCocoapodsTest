#include "DemoArtiFileDialogTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	void CArtiFileDialogTest::ShowMenu()
	{

		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitType");						 vctMenuID.push_back(0);
		uiMenu.AddItem("SetFilter");					 vctMenuID.push_back(1);
		uiMenu.AddItem("GetPathName");					 vctMenuID.push_back(2);
		uiMenu.AddItem("GetFileName");					 vctMenuID.push_back(3);
		//uiMenu.AddItem("测试极限值");	            vctMenuID.push_back(11);

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
					ArtiFileDialogTest_InitType();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiFileDialogTes_SetFilter();
				}
				else if (2 == vctMenuID[uRetBtn])
				{
					ArtiFileDialogTes_GetPathName();
				}
				else if (3 == vctMenuID[uRetBtn])
				{
					ArtiFileDialogTes_GetFileName();
				}
			}
		}
	}

	void CArtiFileDialogTest::ArtiFileDialogTest_InitType()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		bool bType = true;
		string strbType = "true";
		string strPath = CArtiGlobal::GetVehPath();

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("InitType");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("bType");
		uiList.AddItem("strPath");

		uiList.SetItem(0, 1, strbType);
		uiList.SetItem(1, 1, strPath);//"当前工作目录"

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		/*
		* 3.配置和测试接口
		*/
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
				/*
				* 测试步骤:
				*   ->1.配置InitType参数
				*   ->2.调用InitType接口
				*   ->3.调用GetFileName和GetPathName获取文件名和路径
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF00000000A8"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
#if __Multi_System_Test__
				CArtiFileDialog uiFileDiag(m_uThread);
#else
				CArtiFileDialog uiFileDiag;
#endif
				uiFileDiag.InitType(bType, strPath);

				uint32_t uRetFileDiag = uiFileDiag.Show();
				if (uRetFileDiag == DF_ID_OK)
				{
					string strFileName = uiFileDiag.GetFileName();
					string strFilePath = uiFileDiag.GetPathName();

					vector<int32_t> vctColWidth1;
					vctColWidth1.push_back(20);
					vctColWidth1.push_back(80);

#if __Multi_System_Test__
					CArtiList uiList1(m_uThread);
#else
					CArtiList uiList1;
#endif
					uiList1.InitTitle(artiGetText("FF00000000B5"));//"当前文件信息"
					uiList1.SetColWidth(vctColWidth1);
					uiList1.AddItem("FileName");
					uiList1.AddItem("FilePath");

					uiList1.SetItem(0, 1, strFileName);
					uiList1.SetItem(1, 1, strFilePath);

					uint32_t uRetFile = DF_ID_NOKEY;
					while (1)
					{
						uRetFile = uiList1.Show();
						if (uRetFile == DF_ID_BACK)
						{
							break;
						}
					}
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiMenui(m_uThread);
#else
					CArtiMenu uiMenui;
#endif
					uiMenui.InitTitle("bType");
					uiMenui.AddItem("true");
					uiMenui.AddItem("false");

					uint32_t uRetMenu = uiMenui.Show();
					if (uRetMenu == 0)
					{
						bType = true;
						uiList.SetItem(0, 1, "true");
					}
					else if (uRetMenu == 1)
					{
						bType = false;
						uiList.SetItem(0, 1, "false");
					}
				}
				else if (1 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiMenui(m_uThread);
#else
					CArtiMenu uiMenui;
#endif
					uiMenui.InitTitle("strPath");
					uiMenui.AddItem(artiGetText("FF00000000B7"));//当前工作目录
					uiMenui.AddItem(artiGetText("FF00000000B6"));//File

					uint32_t uRetMenu = uiMenui.Show();
					if (uRetMenu == 0)
					{
						strPath = CArtiGlobal::GetVehPath();
						uiList.SetItem(1, 1, artiGetText("FF00000000B7"));
					}
					else if (uRetMenu == 1)
					{
						strPath = CArtiGlobal::GetVehPath() + "\\" + artiGetText("FF00000000B6");
						uiList.SetItem(1, 1, artiGetText("FF00000000B6"));
					}
				}
			}
		}
	}

	void CArtiFileDialogTest::ArtiFileDialogTes_SetFilter()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		string strFilter = "*.*";

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFilter");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("strFilter");

		uiList.SetItem(0, 1, "*.*");

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		/*
		* 3.配置和测试接口
		*/
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
				/*
				* 测试步骤:
				*   ->1.配置SetFilter参数
				*   ->2.调用SetFilter接口
				*   ->3.调用GetFileName和GetPathName获取文件名和路径
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF00000000A9"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
#if __Multi_System_Test__
				CArtiFileDialog uiFileDiag(m_uThread);
#else
				CArtiFileDialog uiFileDiag;
#endif
				uiFileDiag.InitType(true, CArtiGlobal::GetVehPath());
				uiFileDiag.SetFilter(strFilter);

				uint32_t uRetFileDiag = uiFileDiag.Show();
				if (uRetFileDiag == DF_ID_OK)
				{
					string strFileName = uiFileDiag.GetFileName();
					string strFilePath = uiFileDiag.GetPathName();

					vector<int32_t> vctColWidth1;
					vctColWidth1.push_back(20);
					vctColWidth1.push_back(80);

#if __Multi_System_Test__
					CArtiList uiList1(m_uThread);
#else
					CArtiList uiList1;
#endif
					uiList1.InitTitle(artiGetText("FF00000000B5"));//"当前文件信息"
					uiList1.SetColWidth(vctColWidth1);
					uiList1.AddItem("FileName");
					uiList1.AddItem("FilePath");

					uiList1.SetItem(0, 1, strFileName);
					uiList1.SetItem(1, 1, strFilePath);

					uint32_t uRetFile = DF_ID_NOKEY;
					while (1)
					{
						uRetFile = uiList1.Show();
						if (uRetFile == DF_ID_BACK)
						{
							break;
						}
					}
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
#if __Multi_System_Test__
					CArtiMenu uiMenui(m_uThread);
#else
					CArtiMenu uiMenui;
#endif
					uiMenui.InitTitle("strFilter");
					uiMenui.AddItem("*.*");
					uiMenui.AddItem("*.xls");
					uiMenui.AddItem("*.txt");

					uint32_t uRetMenu = uiMenui.Show();
					if (uRetMenu == 0)
					{
						strFilter = "*.*";
						uiList.SetItem(0, 1, strFilter);
					}
					else if (uRetMenu == 1)
					{
						strFilter = "*.xls";
						uiList.SetItem(0, 1, strFilter);
					}
					else
					{
						strFilter = "*.txt";
						uiList.SetItem(0, 1, strFilter);
					}
				}
			}
		}
	}

	void CArtiFileDialogTest::ArtiFileDialogTes_GetPathName()
	{
		string strPath = CArtiGlobal::GetVehPath();

#if __Multi_System_Test__
		CArtiFileDialog uiFileDiag(m_uThread);
#else
		CArtiFileDialog uiFileDiag;
#endif
		uiFileDiag.InitType("true", strPath);

		uint32_t uRetFileDiag = uiFileDiag.Show();
		if (uRetFileDiag == DF_ID_OK)
		{
			//string strFileName = uiFileDiag.GetFileName();
			string strFilePath = uiFileDiag.GetPathName();

			vector<int32_t> vctColWidth1;
			vctColWidth1.push_back(20);
			vctColWidth1.push_back(80);

#if __Multi_System_Test__
			CArtiList uiList1(m_uThread);
#else
			CArtiList uiList1;
#endif
			uiList1.InitTitle(artiGetText("FF00000000B5"));//"当前文件信息"
			uiList1.SetColWidth(vctColWidth1);
			//uiList1.AddItem("GetFileName");
			uiList1.AddItem("GetPathName");

			//uiList1.SetItem(0, 1, strFileName);
			uiList1.SetItem(0, 1, strFilePath);

			uint32_t uRetFile = DF_ID_NOKEY;
			while (1)
			{
				uRetFile = uiList1.Show();
				if (uRetFile == DF_ID_BACK)
				{
					break;
				}
			}
		}
		//ShowMsgBoxDemo(artiGetText("FF0E00000007"), strPath, DF_MB_OK, DT_LEFT, -1, m_uThread);
	}

	void CArtiFileDialogTest::ArtiFileDialogTes_GetFileName()
	{
		string strPath = CArtiGlobal::GetVehPath();

#if __Multi_System_Test__
		CArtiFileDialog uiFileDiag(m_uThread);
#else
		CArtiFileDialog uiFileDiag;
#endif
		uiFileDiag.InitType("true", strPath);

		uint32_t uRetFileDiag = uiFileDiag.Show();
		if (uRetFileDiag == DF_ID_OK)
		{
			string strFileName = uiFileDiag.GetFileName();
			//string strFilePath = uiFileDiag.GetPathName();

			vector<int32_t> vctColWidth1;
			vctColWidth1.push_back(20);
			vctColWidth1.push_back(80);

#if __Multi_System_Test__
			CArtiList uiList1(m_uThread);
#else
			CArtiList uiList1;
#endif
			uiList1.InitTitle(artiGetText("FF00000000B5"));//"当前文件信息"
			uiList1.SetColWidth(vctColWidth1);
			uiList1.AddItem("GetFileName");
			//uiList1.AddItem("GetPathName");

			uiList1.SetItem(0, 1, strFileName);
			//uiList1.SetItem(1, 1, strFilePath);

			uint32_t uRetFile = DF_ID_NOKEY;
			while (1)
			{
				uRetFile = uiList1.Show();
				if (uRetFile == DF_ID_BACK)
				{
					break;
				}
			}
		}
	}


}