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
#include "DemoActive.h"
#include "ArtiActive.h"
#include "Expression.h"
#include "DataFile.h"
#include "ProFile.h"
#include "Expression.h"
#include "StdShowMaco.h"
#include "PublicInterface.h"
#include "ArtiMenu.h"
#include "ArtiMsgBox.h"
#include "DemoEnterSys.h"
#include "DemoActive.h"
#include "ArtiGlobal.h"
#include "DemoPublicAPI.h"

namespace Topdon_AD900_Demo {

	CActive::CActive()
	{

	}

	CActive::~CActive()
	{

	}

	void CActive::SetSysEnterPointer(CEnterSys* pSysEnter)
	{
		m_pSysEnter = pSysEnter;
	}

	ErrorCode_t CActive::ActiveTest(CBinary binSys)
	{
		ErrorCode_t		ectRet = ErrorCodeType::STATUS_NOERROR;
		CDataFile		datafile;
		CProFile		profile;
		string			strTemp;
		vector<string>	vecstrItem;
		CArtiMenu		uiMenu;
		uint32_t		uRet;
		uint32_t		uActMode;
		vector<string>	vecstrActName;
		string			strSys;

		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return ectRet;
		}
		strSys = Binary2HexString(binSys);
		strTemp = datafile.GetText(strSys);
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		else
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return ectRet;
		}

		vecstrItem = profile.GetStringGroup("ActTest", "Item");
		uiMenu.InitTitle(artiGetText("500000060005"));
		for (uint32_t i = 0; i < vecstrItem.size(); i++)
		{
			strTemp = "5000000A";
			strTemp += vecstrItem[i];
			uiMenu.AddItem(artiGetText(strTemp));
			vecstrActName.push_back(artiGetText(strTemp));
		}

		while (1)
		{
			uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			string	strAct = "Act_";
			strAct += vecstrItem[uRet & 0xff];
			uActMode = profile.GetHex(strAct, "ActiveMode");
			switch (uActMode)
			{
			case 1:
				ActiveTest1(strSys,vecstrActName[uRet & 0xff], strAct, profile);
				break;
			case 2:
				ActiveTest2(strSys,vecstrActName[uRet & 0xff], strAct, profile);
				break;
			case 3:
				ActiveTest3(strSys, vecstrActName[uRet & 0xff], strAct, profile);
				break;
			default:
				break;
			}
		}

		return ectRet;
	}

	vector<vector<string>>CActive::GetDataList(string strSys, vector<string> vctstrData)
	{
		CDataFile		datafile;
		CProFile		profile;
		vector<vector<string>>	vctvctstrDataList;
		string			strTemp;
		vector<vector<string>>	vctvctstrTemp;
		uint32_t		uLiveDataNum;
		vector<vector<string>>	vctvctstrDataListTemp;

		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return vctvctstrDataList;
		}
		strTemp = datafile.GetText(strSys);
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		else
		{
			return vctvctstrDataList;
		}
		uLiveDataNum = profile.GetHex("LiveData", "LiveDataNum");
		for (uint32_t i = 0; i < uLiveDataNum; i++)
		{
			string			strItem = "Item";
			char			chvalue[100];
			string			strLiveData;
			string			strUnit = "50000009";
			string			strMin = "";
			string			strMax = "";

			strLiveData = strSys;
			SPRINTF_S(chvalue, "%d", i + 1);
			strItem += chvalue;
			vctvctstrDataListTemp.push_back(profile.GetStringGroup("LiveData", strItem));
		}
		for (uint32_t i=0; i<vctstrData.size(); i++)
		{
			for (uint32_t j=0;j< vctvctstrDataListTemp.size(); j++)
			{
				if (vctstrData[i]== vctvctstrDataListTemp[j][0])
				{
					vctvctstrDataList.push_back(vctvctstrDataListTemp[j]);
					break;
				}
			}
		}
		return vctvctstrDataList;
	}

	ErrorCode_t CActive::ActiveTest1(string strSys,string strTitle, string strItem, CProFile& profile)
	{
		ErrorCode_t		ectRet = ErrorCodeType::STATUS_NOERROR;
		vector<string>	vecstrBtnId;
		vector<string>	vecstrLiveList;
		CArtiActive		uiAct;
		string			strTemp;
		vector<string>	vecstrBtn;
		uint32_t		uRet;
		vector<string>	vecstrUnit;
		string			strActInfo;
		string			strActWaitInfo;

		vecstrBtnId = profile.GetStringGroup(strItem, "Button");
		vecstrLiveList = profile.GetStringGroup(strItem, "DataList");
		strActInfo = artiGetText(profile.GetValue(strItem, "ActInfo"));
		strActWaitInfo = artiGetText(profile.GetValue(strItem, "ActWaitInfo"));
		uiAct.InitTitle(strTitle);
		if (strActInfo.size()>0)
		{
			uiAct.SetOperationTipsOnTop(strActInfo);
		}
		uiAct.AddItem(strTitle, strActWaitInfo);
		for (uint32_t i = 0; i < vecstrBtnId.size(); i++)
		{
			strTemp = "50000010";

			strTemp += vecstrBtnId[i];
			strTemp = artiGetText(strTemp);
			vecstrBtn.push_back(strTemp);
			uiAct.AddButton(strTemp);
		}

		vector<vector<string>> vctvctstrDataList;

		vctvctstrDataList = GetDataList(strSys,vecstrLiveList);
		for (uint32_t i = 0; i < vctvctstrDataList.size(); i++)
		{
			strTemp = strSys;
			string		strUnit = "50000009";;
			stUnitItem	unitTem;


			strTemp += vctvctstrDataList[i][0];
			if (vctvctstrDataList[i].size()>2)
			{
				strUnit += vctvctstrDataList[i][2];
			}
			strTemp = artiGetText(strTemp);
			strUnit = artiGetText(strUnit);
			unitTem.strValue = "";
			unitTem.strUnit = strUnit;
			unitTem = CArtiGlobal::UnitsConversion(unitTem);
			vecstrUnit.emplace_back(strUnit);
			uiAct.AddItem(strTemp, "N/A", false, unitTem.strUnit);
		}

		while (1)
		{
			uRet = uiAct.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}

			for (uint32_t i = 0; i < vctvctstrDataList.size(); i++)
			{
				string			strExp = strSys;
				string			strValue;
				CBinary			binRecv("\x10\x32\x32\x05", 4);
				uint8_t			uValue = 0;
				stUnitItem		unitTem;


				uValue = rand();
				binRecv.SetAt(2, uValue);

				strExp += vctvctstrDataList[i][1];
				strValue = Calc_Script(strExp, binRecv, 2);
				unitTem.strValue = strValue;
				unitTem.strUnit = vecstrUnit[i];
				unitTem = CArtiGlobal::UnitsConversion(unitTem);
				CEcuInterface::Log("unit:",vecstrUnit[i].c_str(), "\nchange unit:",unitTem.strUnit.c_str());

				uiAct.SetValue(i + 1, unitTem.strValue);
				uiAct.SetUnit(i + 1, unitTem.strUnit);
			}
			CEnterSys::Delay(300);
			if (uRet != DF_ID_NOKEY)
			{
				uiAct.SetValue(0, vecstrBtn[uRet & 0xff]);
				for (uint32_t i = 0; i < vecstrBtnId.size(); i++)
				{
					if (i == (uRet & 0xff))
					{
						uiAct.SetButtonStatus(i, (uint32_t)true);
					}
					else
					{
						uiAct.SetButtonStatus(i, (uint32_t)false);
					}
				}
			}
		}
		return ectRet;
	}

	ErrorCode_t CActive::ActiveTest2(string strSys, string strTitle, string strItem, CProFile& profile)
	{
		ErrorCode_t		ectRet = ErrorCodeType::STATUS_NOERROR;
		vector<string>	vecstrBtnId;
		vector<string>	vecstrLiveList;
		CArtiActive		uiAct;
		string			strTemp;
		vector<string>	vecstrBtn;
		uint32_t		uRet;
		vector<string>	vecstrUnit;
		string			strActUnit;
		string			strActInfor;
		string			strStartValue;
		vector<uint32_t>		vctuActMinMax;
		vector<uint32_t>		vctuActStepLen;


		vecstrBtnId = profile.GetStringGroup(strItem, "Button");
		vecstrLiveList = profile.GetStringGroup(strItem, "DataList");
		strStartValue = profile.GetValue(strItem, "ActInitialValue");
		vctuActMinMax = profile.GetHexGroup(strItem, "ActMinMax");
		vctuActStepLen = profile.GetHexGroup(strItem, "ActStepLen");

		strActUnit = artiGetText(profile.GetValue(strItem, "Actunit"));
		strActInfor = artiGetText(profile.GetValue(strItem, "ActInfo"));

		uiAct.InitTitle(strTitle);
		if (strActInfor.size()>0)
		{
			uiAct.SetOperationTipsOnTop(strActInfor);
		}
		uiAct.AddItem(strTitle, strStartValue,false,strActUnit);
		for (uint32_t i = 0; i < vecstrBtnId.size(); i++)
		{
			strTemp = "50000010";

			strTemp += vecstrBtnId[i];
			strTemp = artiGetText(strTemp);
			vecstrBtn.push_back(strTemp);
			uiAct.AddButton(strTemp);
		}

		vector<vector<string>> vctvctstrDataList;

		vctvctstrDataList = GetDataList(strSys, vecstrLiveList);
		for (uint32_t i = 0; i < vctvctstrDataList.size(); i++)
		{
			strTemp = strSys;
			string		strUnit = "50000009";;
			stUnitItem	unitTem;


			strTemp += vctvctstrDataList[i][0];
			if (vctvctstrDataList[i].size() > 2)
			{
				strUnit += vctvctstrDataList[i][2];
			}
			strTemp = artiGetText(strTemp);
			strUnit = artiGetText(strUnit);
			unitTem.strValue = "";
			unitTem.strUnit = strUnit;
			unitTem = CArtiGlobal::UnitsConversion(unitTem);
			vecstrUnit.emplace_back(strUnit);
			uiAct.AddItem(strTemp, "N/A", false, unitTem.strUnit);
		}
		int32_t uValue = ToInt32(strStartValue,10);
		while (1)
		{
			uRet = uiAct.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}

			for (uint32_t i = 0; i < vctvctstrDataList.size(); i++)
			{
				string			strExp = strSys;
				string			strValue;
				CBinary			binRecv("\x10\x32\x32\x05", 4);
				uint8_t			uValue = 0;
				stUnitItem		unitTem;


				uValue = rand();
				binRecv.SetAt(2, uValue);

				strExp += vctvctstrDataList[i][1];
				strValue = Calc_Script(strExp, binRecv, 2);
				unitTem.strValue = strValue;
				unitTem.strUnit = vecstrUnit[i];
				unitTem = CArtiGlobal::UnitsConversion(unitTem);
				CEcuInterface::Log("unit:", vecstrUnit[i].c_str(), "\nchange unit:", unitTem.strUnit.c_str());

				uiAct.SetValue(i + 1, unitTem.strValue);
				uiAct.SetUnit(i + 1, unitTem.strUnit);
			}
			CEnterSys::Delay(300);
			if (uRet != DF_ID_NOKEY)
			{
				if ((0 == (uRet & 0xff)) || (2 == (uRet & 0xff)))
				{
					if (0 == (uRet & 0xff))
					{
						uValue = uValue + (int32_t)vctuActStepLen[0];
						if (uValue > (int32_t)vctuActMinMax[1])
						{
							uValue = (int32_t)vctuActMinMax[1];
							uiAct.SetButtonStatus(0, DF_ST_BTN_DISABLE);
						}
					}
					if (2 == (uRet & 0xff))
					{
						uValue = uValue - (int32_t)vctuActStepLen[0];
						if (uValue < (int32_t)vctuActMinMax[0])
						{
							uValue = (int32_t)vctuActMinMax[0];
						}
					}
				}
				else
				{
					if (1 == (uRet & 0xff))
					{
						uValue = uValue + (int32_t)vctuActStepLen[1];
						if (uValue > (int32_t)vctuActMinMax[1])
						{
							uValue = (int32_t)vctuActMinMax[1];
						}
					}
					if (3 == (uRet & 0xff))
					{
						uValue = uValue - (int32_t)vctuActStepLen[1];
						if (uValue < (int32_t)vctuActMinMax[0])
						{
							uValue = (int32_t)vctuActMinMax[0];
						}
					}
				}
				if ((uValue >= vctuActMinMax[1]))
				{
					uiAct.SetButtonStatus(0, DF_ST_BTN_DISABLE);
					uiAct.SetButtonStatus(1, DF_ST_BTN_DISABLE);
					uiAct.SetButtonStatus(2, DF_ST_BTN_ENABLE);
					uiAct.SetButtonStatus(3, DF_ST_BTN_ENABLE);
				}
				if ((uValue <= vctuActMinMax[0]))
				{
					uiAct.SetButtonStatus(0, DF_ST_BTN_ENABLE);
					uiAct.SetButtonStatus(1, DF_ST_BTN_ENABLE);
					uiAct.SetButtonStatus(2, DF_ST_BTN_DISABLE);
					uiAct.SetButtonStatus(3, DF_ST_BTN_DISABLE);
				}
				uiAct.SetValue(0, int32ToString(uValue,true));
			}
		}
		return ectRet;
	}

	ErrorCode_t CActive::ActiveTest3(string strSys, string strTitle, string strItem, CProFile& profile)
	{
		ErrorCode_t		ectRet = ErrorCodeType::STATUS_NOERROR;
		string			strTemp;
		string			strActInfo;
		string			strFinishInfo;


		strActInfo = profile.GetValue(strItem, "ActInfo");
		strFinishInfo = profile.GetValue(strItem, "ActFinishInfo");

		if (strActInfo.size()>0)
		{
			artiShowMsgBox(artiGetText("500000200000"), artiGetText(strActInfo), DF_MB_OK);
		}
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText(strFinishInfo), DF_MB_OK);


		return ectRet;
	}

}
