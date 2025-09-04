#include "DemoArtiObdReviewTest.h"
#include "DemoMaco.h"
#include "DemoPublicAPI.h"
#include "ArtiObdReview.h"

namespace Topdon_AD900_Demo {

	void CArtiObdReviewTest::ShowMenu()
	{
		vector<uint32_t> vctMenuID;

#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("ArtiObdReview");
		uiMenu.AddItem("InitTitle");		        vctMenuID.push_back(0);
		uiMenu.AddItem("SetReportResult");			    vctMenuID.push_back(1);
		uiMenu.AddItem("SetMILStatus");				vctMenuID.push_back(2);
		uiMenu.AddItem("SetMILOnMileage");				vctMenuID.push_back(3);
		uiMenu.AddItem("AddReadinessStatusItems");				vctMenuID.push_back(4);
		uiMenu.AddItem("AddEcuInfoItems");				vctMenuID.push_back(5);
		uiMenu.AddItem("AddDtcItem");				vctMenuID.push_back(6);
		uiMenu.AddItem("AddDtcItems");				vctMenuID.push_back(7);
		uiMenu.AddItem("AddLiveDataItem");				vctMenuID.push_back(8);
		uiMenu.AddItem("AddLiveDataItems");				vctMenuID.push_back(9);
		uiMenu.AddItem("AddIUPRStatusItem");				vctMenuID.push_back(10);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctMenuID.size())
			{
			}
		}
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_InitTitle()
	{
		//CArtiObdReview ObdReview;

// 		ObdReview.InitTitle("OBD Check Report");
// 
// 		while (1)
// 		{
// 			if (ObdReview.Show()==DF_ID_BACK)
// 			{
// 				break;
// 			}
// 		}
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_SetReportResult()
	{
// 		CArtiMenu	uiMenu;
// 		CArtiObdReview ObdReview;
// 
// 		uiMenu.InitTitle("Test SetReportResult");
// 		uiMenu.AddItem("RESULT_TYPE_PASS");
// 		uiMenu.AddItem("RESULT_TYPE_FAILED");
// 		ObdReview.InitTitle("OBD Check Report");
// 
// 		while (1)
// 		{
// 			uint32_t uRet = uiMenu.Show();
// 			if (uRet == DF_ID_BACK)
// 			{
// 				return;
// 			}
// 			if ((uRet&=0xff)==0)
// 			{
// 				ObdReview.SetReportResult(CArtiObdReview::eResultType::RESULT_TYPE_PASS);
// 			}
// 			else if ((uRet &= 0xff) == 1)
// 			{
// 				ObdReview.SetReportResult(CArtiObdReview::eResultType::RESULT_TYPE_FAILED);
// 			}
// 			while (1)
// 			{
// 				if (ObdReview.Show() == DF_ID_BACK)
// 				{
// 					break;
// 				}
// 			}
// 		}
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_SetMILStatus()
	{
// 		CArtiMenu	uiMenu;
// 		CArtiObdReview ObdReview;
// 
// 		uiMenu.InitTitle("Test SetReportResult");
// 		uiMenu.AddItem("true");
// 		uiMenu.AddItem("false");
// 		ObdReview.InitTitle("SetMILStatus");
// 
// 		while (1)
// 		{
// 			uint32_t uRet = uiMenu.Show();
// 			if (uRet == DF_ID_BACK)
// 			{
// 				return;
// 			}
// 			if ((uRet &= 0xff) == 0)
// 			{
// 				ObdReview.SetMILStatus(true);
// 			}
// 			else if ((uRet &= 0xff) == 1)
// 			{
// 				ObdReview.SetMILStatus(false);
// 			}
// 			while (1)
// 			{
// 				if (ObdReview.Show() == DF_ID_BACK)
// 				{
// 					break;
// 				}
// 			}
// 		}
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddReadinessStatusItems()
	{
// 		CArtiObdReview ObdReview;
// 
// 		ObdReview.InitTitle("AddReadinessStatusItems");
// 		for (uint8_t i=0; i<10; i++)
// 		{
// 			string	strTemp = "Test";
// 			CArtiObdReview::eReadinessType uType;
// 
// 			if ((i%2)==0)
// 			{
// 				if (i==0)
// 				{
// 					uType = CArtiObdReview::eReadinessType::READINESS_TYPE_NOT_SUPOORT;
// 				}
// 				else
// 				{
// 					uType = CArtiObdReview::eReadinessType::READINESS_TYPE_OK;
// 				}
// 			}
// 			else
// 			{
// 				uType = CArtiObdReview::eReadinessType::READINESS_TYPE_FAILED;
// 			}
// 
// 			strTemp += uint8ToString(i + 1);
// 			ObdReview.AddReadinessStatusItems(strTemp, uType);
// 		}
// 		ObdReview.Show();
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddEcuInfoItems()
	{
// 		CArtiObdReview ObdReview;
// 		vector<string>	vctCALID;
// 		vector<string>	vctCVN;
// 
// 		ObdReview.InitTitle("AddEcuInfoItems");
// 		for (uint8_t i = 0; i < 2; i++)
// 		{
// 			string	strTemp = "Engine";
// 
// 			vctCALID.clear();
// 			vctCVN.clear();
// 
// 			if (i==1)
// 			{
// 				strTemp = "Trasmission";
// 			}
// 			for (uint8_t j=0;j<4; j++)
// 			{
// 				vctCALID.push_back("11111");
// 				vctCVN.push_back("22222");
// 			}
// 			ObdReview.AddEcuInfoItems(strTemp, vctCALID, vctCVN);
// 		}
// 		ObdReview.Show();
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddDtcItem()
	{
//		CArtiObdReview ObdReview;
//
// 		ObdReview.InitTitle("AddDtcItem");
// 		for (uint8_t i = 0; i < 10; i++)
// 		{
// 			stDtcNodeEx	 oneDtc;
// 			string		strPcbu;
// 			string		strDtcText;
// 
// 			strPcbu = "P000";
// 			strDtcText = "DtcText";
// 
// 			strPcbu = int8ToString(i + 1, true);
// 			strDtcText = int8ToString(i + 1, true);
// 
// 			oneDtc.strCode = strPcbu;
// 			oneDtc.strDescription = strPcbu;
// 			oneDtc.strStatus = "Current";
// 			oneDtc.uStatus = DF_DTC_STATUS_CURRENT;
// 			ObdReview.AddDtcItem(oneDtc);
// 		}
// 		ObdReview.Show();
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddDtcItems()
	{
// 		CArtiObdReview ObdReview;
// 		vector<stDtcNodeEx> vctDtc;
// 
// 		ObdReview.InitTitle("AddDtcItems");
// 		for (uint8_t i = 0; i < 10; i++)
// 		{
// 			stDtcNodeEx	 oneDtc;
// 			string		strPcbu;
// 			string		strDtcText;
// 
// 			strPcbu = "P000";
// 			strDtcText = "DtcText";
// 
// 			strPcbu = int8ToString(i + 1, true);
// 			strDtcText = int8ToString(i + 1, true);
// 
// 			oneDtc.strCode = strPcbu;
// 			oneDtc.strDescription = strPcbu;
// 			oneDtc.strStatus = "Current";
// 			oneDtc.uStatus = DF_DTC_STATUS_CURRENT;
// 			vctDtc.push_back(oneDtc);
// 		}
// 		ObdReview.AddDtcItems(vctDtc);
// 		ObdReview.Show();
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddLiveDataItem()
	{
// 		CArtiObdReview ObdReview;
// 
// 		ObdReview.InitTitle("AddLiveDataItem");
// 		for (uint8_t j=0; j<2; j++)
// 		{
// 			if (j==0)
// 			{
// 				ObdReview.AddLiveDataMainType("Engine");
// 			}
// 			else
// 			{
// 				ObdReview.AddLiveDataMainType("Transmission");
// 			}
// 			for (uint8_t i = 0; i < 10; i++)
// 			{
// 				stDsReportItem	 oneLiveData;
// 				string		strDs;
// 				string		strValue;
// 				string		strUnit;
// 
// 				strDs = "LivaData";
// 				strValue = "strValue";
// 
// 				strDs = int8ToString(i + 1, true);
// 				strValue = int8ToString(i + 1, true);
// 
// 				oneLiveData.strName = strDs;
// 				oneLiveData.strValue = strValue;
// 				oneLiveData.strUnit = strUnit;
// 				ObdReview.AddLiveDataItem(oneLiveData);
// 			}
// 		}
// 		ObdReview.Show();
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddLiveDataItems()
	{
// 		CArtiObdReview ObdReview;
// 
// 		ObdReview.InitTitle("AddLiveDataItems");
// 		for (uint8_t j = 0; j < 2; j++)
// 		{
// 			vector<stDsReportItem>	 vctoneLiveData;
// 
// 			if (j == 0)
// 			{
// 				ObdReview.AddLiveDataMainType("Engine");
// 			}
// 			else
// 			{
// 				ObdReview.AddLiveDataMainType("Transmission");
// 			}
// 			for (uint8_t i = 0; i < 10; i++)
// 			{
// 				stDsReportItem	 oneLiveData;
// 				string		strDs;
// 				string		strValue;
// 				string		strUnit;
// 
// 				strDs = "LivaData";
// 				strValue = "strValue";
// 
// 				strDs = int8ToString(i + 1, true);
// 				strValue = int8ToString(i + 1, true);
// 
// 				oneLiveData.strName = strDs;
// 				oneLiveData.strValue = strValue;
// 				oneLiveData.strUnit = strUnit;
// 				vctoneLiveData.push_back(oneLiveData);
// 			}
// 			ObdReview.AddLiveDataItems(vctoneLiveData);
// 		}
// 		ObdReview.Show();
	}

	void CArtiObdReviewTest::ArtiObdReviewTest_AddIUPRStatusItem()
	{
// 		CArtiObdReview ObdReview;
// 
// 		ObdReview.InitTitle("AddIUPRStatusItem");
// 		for (uint8_t j = 0; j < 2; j++)
// 		{
// 			if (j == 0)
// 			{
// 				ObdReview.AddIUPRMainType("Engine");
// 			}
// 			else
// 			{
// 				ObdReview.AddIUPRMainType("Transmission");
// 			}
// 			for (uint8_t i = 0; i < 10; i++)
// 			{
// 				string		strDs;
// 				string		strValue;
// 				string		strUnit;
// 
// 				strDs = "IUPR";
// 				strValue = "IUPRValue";
// 
// 				strDs = int8ToString(i + 1, true);
// 				strValue = int8ToString(i + 1, true);
// 				ObdReview.AddIUPRStatusItem(strDs, strValue);
// 			}
// 		}
// 		ObdReview.Show();
	}
}