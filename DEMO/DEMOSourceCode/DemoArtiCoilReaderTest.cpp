#include "DemoArtiCoilReaderTest.h"
#include "DemoMaco.h"
#include "ArtiCoilReader.h"
#include "ArtiMenu.h"
#include "ArtiList.h"

namespace Topdon_AD900_Demo{

	void CArtiCoilReaderTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

		CArtiMenu uiMenu;

		uiMenu.InitTitle(artiGetText("FF0000000001"));
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("SetCoilSignal");			vctMenuID.push_back(1);
		//uiMenu.AddItem("Show");						vctMenuID.push_back(2);

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
					ArtiCoilReaderTest_InitTitle();
				}
				else if (1 == vctMenuID[uRetBtn])
				{
					ArtiCoilReaderTest_SetCoilSignal();
				}
			}
		}
	}

	void CArtiCoilReaderTest::ArtiCoilReaderTest_InitTitle()
	{
		string strTitle;
		CArtiMenu uiMenu;

		uiMenu.InitTitle(artiGetText("FF0000000002"));	//"选择测试项"
		uiMenu.AddItem(artiGetText("FF1300000001"));	//"标题文本为空"
		uiMenu.AddItem(artiGetText("FF1300000002"));	//"标题文本为单行"
		uiMenu.AddItem(artiGetText("FF1300000003"));	//"标题文本为多行"
		uiMenu.AddItem(artiGetText("FF1300000004"));	//"标题文本英文长度达到阈值"
		uiMenu.AddItem(artiGetText("FF1300000005"));	//"标题文本中文长度达到阈值"

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
				strTitle = artiGetText("FF0100000002");
			}
			else if (2 == uRetBtn)
			{
				strTitle = TextMulitLine;
			}
			else if (3 == uRetBtn)
			{
				strTitle = artiGetText("FF1100000004");
			}
			else if (4 == uRetBtn)
			{
				strTitle = artiGetText("FF1200000004");
			}

			CArtiCoilReader uiCoilReader;
			uiCoilReader.InitTitle(strTitle);
			uiCoilReader.SetCoilSignal(CArtiCoilReader::SIGNAL_IS_SET);
			
			while (1)
			{
				uRetBtn = uiCoilReader.Show();
				if (uRetBtn == DF_ID_CANCEL)
				{
					break;
				}
			}
		}
	}

	void CArtiCoilReaderTest::ArtiCoilReaderTest_SetCoilSignal()
	{
		// 1.配置接口参数初始值
		map<CArtiCoilReader::eSignalType, string> mapSignalType;
		mapSignalType.emplace(CArtiCoilReader::SIGNAL_IS_NOT_SET, "SIGNAL_IS_NOT_SET");
		mapSignalType.emplace(CArtiCoilReader::SIGNAL_IS_SET, "SIGNAL_IS_SET");

		CArtiCoilReader::eSignalType SignalType = CArtiCoilReader::SIGNAL_IS_NOT_SET;
		string strSignalType = mapSignalType[SignalType];

		// 2.显示参数列表
		CArtiList uiList;
		uiList.InitTitle("SetCoilSignal");
		uiList.SetColWidth(vector<int32_t>{50, 50});
		uiList.SetHeads(vector<string>{"Name","Value"});
		uiList.AddItem("eSignalType");
		uiList.SetItem(0, 1, strSignalType);

		uiList.AddButtonEx("Test");
		//uiList.AddButtonEx("Help");

		// 3.配置和测试接口
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (true)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				CArtiCoilReader uiCoilReader;
				uiCoilReader.InitTitle("SetCoilSignal");
				uiCoilReader.SetCoilSignal(SignalType);

				while (1)
				{
					uRetBtn = uiCoilReader.Show();
					if (uRetBtn == DF_ID_BACK)
					{
						break;
					}
				}
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{

			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(SignalType, strSignalType, mapSignalType);
					uiList.SetItem(0, 1, strSignalType);
				}
			}
		}
	}


}