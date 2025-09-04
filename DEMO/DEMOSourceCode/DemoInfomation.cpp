/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �汾��Ϣ
* �������� : �汾��Ϣ����
* �� �� �� : panjun        20210123
* �� �� �� : 
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#include "DemoInfomation.h"
#include "ArtiEcuInfo.h"
#include "Expression.h"
#include "DataFile.h"
#include "ProFile.h"
#include "Expression.h"
#include "PublicInterface.h"
#include "StdInclude.h"
#include "ArtiMsgBox.h"
#include "DemoEnterSys.h"
#include "ArtiGlobal.h"

namespace Topdon_AD900_Demo {

	CInformation::CInformation()
	{

	}

	CInformation::~CInformation()
	{

	}

	void CInformation::SetSysEnterPointer(CEnterSys* pSysEnter)
	{
		m_pSysEnter = pSysEnter;
	}

	void CInformation::ReadVersion()
	{
		CArtiEcuInfo	uiEcu;
		CDataFile		datafile;
		CProFile		profile;
		string			strTemp;
		uint32_t		iInformationNum;

		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return;
		}
		strTemp = datafile.GetText("Information");
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		else
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return;
		}
		uiEcu.InitTitle(artiGetText("500000060001"));
		uiEcu.SetColWidth(50, 50);
		//uiEcu.AddGroup("111");
		iInformationNum = profile.GetHex("Information", "InformationNum");
		for (uint32_t i = 0; i < iInformationNum; i++)
		{
			string			strItem = "Item";
			char			chvalue[100];
			vector<string>	vecstr;
			string			strInfo = "50000007";
			string			strExp = "50000007";
			string			strValue;
			CBinary			binRecv("\x31\x4E\x34\x48\x42\x47\x38\x42\x58\x38\x44\x36\x33\x33\x38\x34\x38", 17);

			SPRINTF_S(chvalue, "%d", i + 1);
			strItem += chvalue;
			vecstr = profile.GetStringGroup("Information", strItem);
			if (vecstr.size() < 4)
			{
				artiShowMsgBox("error", "error", DF_MB_OK);
				continue;
			}
			if (i!=1)
			{
				binRecv.SetAt(0, (uint8_t)rand());
				binRecv.SetAt(1, (uint8_t)rand());
				binRecv.SetAt(2, (uint8_t)rand());
				binRecv.SetAt(4, (uint8_t)rand());
			}
			strInfo += vecstr[0];
			strExp += vecstr[3];
			strValue = Calc_Script(strExp, binRecv, atoi(vecstr[2].c_str()));
			strInfo = artiGetText(strInfo);
			if (i==1)
			{
				string	strVIN;

				strVIN = CArtiGlobal::GetVIN();
				if (strVIN.size()==17)
				{
					strValue = strVIN;
				}
			}
			uiEcu.AddItem(strInfo, strValue);
		}
		uiEcu.Show();
	}

}