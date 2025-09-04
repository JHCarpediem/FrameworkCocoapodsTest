/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 故障码
* 功能描述 : 故障码举例
* 创 建 人 : panjun        20210129
* 审 核 人 :
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#include "DemoTroubleCode.h"
#include "Expression.h"
#include "ArtiTrouble.h"
#include "DataFile.h"
#include "ProFile.h"
#include "PublicInterface.h"
#include "StdInclude.h"
#include "ArtiMsgBox.h"
#include "DemoEnterSys.h"
#include "ArtiFreeze.h"
#include "ArtiReport.h"
#include "DemoPublicAPI.h"
#include "ArtiGlobal.h"
#include "Demo.h"
#include "DemoVehicleStruct.h"


namespace Topdon_AD900_Demo {

	CTroubleCode::CTroubleCode()
	{
		m_pSysEnter = NULL;
	}

	CTroubleCode::~CTroubleCode()
	{

	}

	void CTroubleCode::SetSysEnterPointer(CEnterSys* pSysEnter)
	{
		m_pSysEnter = pSysEnter;
	}

	ErrorCode_t CTroubleCode::AutoScanTroubleCode()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

		if (ectRet != ErrorCodeType::STATUS_NOERROR)//初始化数据错误，提示功能不支持
		{
			return ectRet;
		}

		return ectRet;
	}

	ErrorCode_t CTroubleCode::AutoScanClearTroubleCode()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

		if (ectRet != ErrorCodeType::STATUS_NOERROR)//
		{
			return ectRet;
		}

		return ectRet;
	}

	ErrorCode_t CTroubleCode::ClearTroubleCode()
	{
		ErrorCode_t		ectRet = ErrorCodeType::STATUS_NOERROR;

		if (DF_ID_NO ==artiShowMsgBox(artiGetText("500000060003"), artiGetText("FFFFFFFF0060"), DF_MB_YESNO))
		{
			artiShowMsgBox(artiGetText("500000060003"), artiGetText("FFFFFFFF0073"), DF_MB_OK);
			return ectRet;
		}
		artiShowMsgBox(artiGetText("FFFFFFFF0009"), artiGetText("FFFFFFFF000A"), DF_MB_NOBUTTON);
		m_pSysEnter->Delay(1000);
		artiShowMsgBox(artiGetText("500000060003"), artiGetText("FFFFFFFF0061"), DF_MB_OK);
		return ectRet;
	}

	ErrorCode_t CTroubleCode::ReadTroubleCode(CBinary binSys)
	{
		ErrorCode_t		ectRet = ErrorCodeType::STATUS_NOERROR;
		CArtiTrouble	uiTrouble;
		CDataFile		datafile;
		CProFile		profile;
		string			strTemp;
		uint32_t		iNum;

		m_vecTroubleCode.clear();

		artiShowMsgBox(artiGetText("FFFFFFFF0009"), artiGetText("FFFFFFFF000A"), DF_MB_NOBUTTON);
		m_pSysEnter->Delay(1000);
		if ((binSys != CBinary("\x00\x01",2))&& ((binSys != CBinary("\x00\x02", 2))))
		{
			artiShowMsgBox(artiGetText("500000060002"), artiGetText("FFFFFFFF005D"), DF_MB_OK);
			return ectRet;
		}
		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return ectRet;
		}
		strTemp = datafile.GetText("TroubleCode");
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		else
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return ectRet;
		}

		stDtcReportItem DtcReportItem;
		DtcReportItem.strID = "1";
		DtcReportItem.strName = artiGetText("500000050003");

		//设置故障码组合状态  [12/8/2022 qunshang.li]
		map<uint32_t, uint32_t> mapStatus;
		mapStatus.emplace(0, DF_DTC_STATUS_CURRENT);
		mapStatus.emplace(1, DF_DTC_STATUS_HISTORY);
		mapStatus.emplace(2, DF_DTC_STATUS_PENDING);
		mapStatus.emplace(3, DF_DTC_STATUS_TEMP);
		mapStatus.emplace(4, DF_DTC_STATUS_NA);
		mapStatus.emplace(5, DF_DTC_STATUS_CURRENT | DF_DTC_STATUS_HISTORY);
		mapStatus.emplace(6, DF_DTC_STATUS_CURRENT | DF_DTC_STATUS_HISTORY | DF_DTC_STATUS_PENDING);
		mapStatus.emplace(7, DF_DTC_STATUS_CURRENT | DF_DTC_STATUS_HISTORY | DF_DTC_STATUS_PENDING | DF_DTC_STATUS_TEMP);
		mapStatus.emplace(8, DF_DTC_STATUS_CURRENT | DF_DTC_STATUS_HISTORY | DF_DTC_STATUS_PENDING | DF_DTC_STATUS_TEMP | DF_DTC_STATUS_NA);

		uiTrouble.InitTitle(artiGetText("500000060002"));
		if ((binSys == CBinary("\x00\x02", 2)))
		{
			iNum = 4;
		}
		else
		{
			iNum = 0;
		}
		for (; ; iNum++)
		{
			char	chvalue[100];
			string	strItem;
			string	strText = "50000011";
			vector<string>	vecstr;

			if ((binSys == CBinary("\x00\x01", 2)))
			{
				if (iNum==4)
				{
					break;
				}
			}
			strTemp = "Item";
			SPRINTF_S(chvalue, "%d", iNum + 1);
			strTemp += chvalue;
			strText += profile.GetValue("TroubleCode", strTemp);
			strTemp = artiGetText(strText);
			if (strTemp.size()==0)
			{
				break;
			}
			vecstr = SeparateString(strTemp, "@");
			if (vecstr.size() > 3)
			{
				uiTrouble.AddItem(vecstr[0], vecstr[1], vecstr[2], vecstr[3]);
			}
			else if (vecstr.size() > 2)
			{
				uiTrouble.AddItem(vecstr[0], vecstr[1], vecstr[2], "");
			}
			else if (vecstr.size() > 1)
			{
				uiTrouble.AddItem(vecstr[0], vecstr[1], "", "");
			}
			if (vecstr.size() > 3)
			{
				uiTrouble.SetItemHelp(iNum, vecstr[3]);
			}
			else
			{
				if (iNum == 0 || iNum == 1 || iNum == 4 || iNum == 5)
				{
					uiTrouble.SetMILStatus(iNum, true);
				}
				uiTrouble.SetFreezeStatus(iNum, true);
			}

			stDtcNode dtcNode;
			dtcNode.strCode = vecstr[0];
			dtcNode.strDescription = vecstr[1];

			// 设置故障码组合状态 [12/8/2022 qunshang.li]
			if (iNum ==2 || iNum ==3)
			{
				dtcNode.uStatus = DF_DTC_STATUS_HISTORY;
			}
			else if (iNum == 0 || iNum == 1 || iNum == 4 || iNum == 5)
			{
				dtcNode.uStatus = DF_DTC_STATUS_CURRENT;
			}
			else
			{
				dtcNode.uStatus = DF_DTC_STATUS_NONE;
			}
			
			DtcReportItem.vctNode.push_back(dtcNode);
		}

		uiTrouble.SetCdtcButtonVisible(true);
		while (1)
		{
			uint32_t uRet = uiTrouble.Show();
			if (uRet == DF_ID_BACK)
			{
				return ectRet;
			}
			else if (uRet == DF_ID_TROUBLE_CLEAR)
			{
				artiShowMsgBox(artiGetText("FFFFFFFF0009"), artiGetText("FFFFFFFF000A"), DF_MB_NOBUTTON);
				m_pSysEnter->Delay(1500);
				artiShowMsgBox(artiGetText("500000060002"), artiGetText("FFFFFFFF005D"), DF_MB_OK);
				return ectRet;

			}
			else if (uRet == DF_ID_TROUBLE_REPORT)
			{
				SetTroubleCodeReport(DtcReportItem);
			}
			else if ((uRet >= DF_ID_TROUBLE_0) && (uRet - DF_ID_TROUBLE_0 < DtcReportItem.vctNode.size()))
			{
				FrzDataStream(DtcReportItem.vctNode[uRet - DF_ID_TROUBLE_0].strCode,binSys);
			}
			else if ((uRet & DF_ID_REPAIR_MANUAL_0) == DF_ID_REPAIR_MANUAL_0)
			{
				vector<stRepairInfoItem> vctstRepairInfoItem;
				stRepairInfoItem onestRepairInfoItem;

				onestRepairInfoItem.eType = RIT_DTC_CODE;
				onestRepairInfoItem.strValue = DtcReportItem.vctNode[uRet & 0xff].strCode;
				vctstRepairInfoItem.push_back(onestRepairInfoItem);

				onestRepairInfoItem.eType = RIT_VEHICLE_BRAND;
				onestRepairInfoItem.strValue = "Nissan";
				vctstRepairInfoItem.push_back(onestRepairInfoItem);

				onestRepairInfoItem.eType = RIT_VEHICLE_MODEL;
				onestRepairInfoItem.strValue = "MAXIMA";
				vctstRepairInfoItem.push_back(onestRepairInfoItem);

				onestRepairInfoItem.eType = RIT_VEHICLE_YEAR;
				onestRepairInfoItem.strValue = "2013";
				vctstRepairInfoItem.push_back(onestRepairInfoItem);
				uiTrouble.SetRepairManualInfo(vctstRepairInfoItem);
			}
		}

		return ectRet;
	}

	uint32_t CTroubleCode::GetSysCodeNum()
	{
		return (uint32_t)m_vecTroubleCode.size();
	}

	vector<TROUBLECODE> CTroubleCode::GetSysCodeInfo()
	{
		return m_vecTroubleCode;
	}

	void CTroubleCode::FrzDataStream(string strPCBU,CBinary binSys)
	{
		CArtiFreeze		uiLiveData;
		CDataFile		datafile;
		CProFile		profile;
		string			strTemp;
		uint32_t		iLiveDataNum;
		vector<vector<string>> vecvecstrItem;
		vector<uint16_t> vecint;//当前屏编号集合
		vector<string>	vecstr;
		CRecvFrame			cf;
		CBinary			binRecv("\x10\x32\x32\x05", 4);
		string	strTitle = artiGetText("FFFFFFFF0030");

		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return;
		}

		strTemp = datafile.GetText(Binary2HexString(binSys));
		if (strTemp.empty())
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return;
		}
		profile.Set(strTemp);
		strTitle += "(";
		strTitle += strPCBU;
		strTitle += ")";
		uiLiveData.InitTitle(strTitle);
		iLiveDataNum = profile.GetHex("LiveData", "LiveDataNum");
		for (uint32_t i = 0; i < iLiveDataNum; i++)
		{
			string			strItem = "Item";
			char			chvalue[100];
			string			strLiveData = Binary2HexString(binSys);
			string			strUnit = "50000009";
			uint8_t			uValue;
			string			strValue;

			SPRINTF_S(chvalue, "%d", i + 1);
			strItem += chvalue;
			vecstr = profile.GetStringGroup("LiveData", strItem);
			if (vecstr.size() < 2)
			{
				artiShowMsgBox("error", "error", DF_MB_OK);
				continue;
			}
			strLiveData += vecstr[0];
			if (vecstr.size() > 2)
			{
				strUnit += vecstr[2];
			}
			strUnit = artiGetText(strUnit);

			uValue = rand();
			binRecv.SetAt(2, uValue);
			strValue = Calc_Script(strLiveData, binRecv, 2);
			stUnitItem		unitTem;

			unitTem.strValue = strValue;
			unitTem.strUnit = strUnit;
			unitTem = CArtiGlobal::UnitsConversion(unitTem);

			uiLiveData.AddItem(artiGetText(strLiveData), unitTem.strValue, unitTem.strUnit);
		}
		while (1)
		{
			uint32_t uret = uiLiveData.Show();
			if (uret == DF_ID_BACK)
			{
				break;
			}
		}
	}

	void CTroubleCode::SetTroubleCodeReport(stDtcReportItem& DtcReportItem)
	{
		// 判断 APP 的宿主机类型
		//CArtiGlobal::eHostType uHostType = CArtiGlobal::GetHostType();

		//当前app应用的产品名称
		//CArtiGlobal::eProductName uProductName = CArtiGlobal::GetAppProductName();

		//当前诊断的入口类型
		//CArtiGlobal::eDiagEntryType uDiagEntryType = CArtiGlobal::GetDiagEntryType();
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200001"), DF_MB_NOBUTTON);

		Delay(1000);

		//设置系统报告
		CArtiReport uiReport;
		uiReport.InitTitle(artiGetText("5100000000E0"));			//诊断报告
		uiReport.SetReportType(CArtiReport::REPORT_TYPE_DTC);
		uiReport.SetTypeTitle(artiGetText("510000000102"));			//故障诊断报告
		//uiReport.SetDescribeTitle(artiGetText("5100000000F3"));		//2015-09奥迪
		uiReport.SetVehInfo("DEMO", CDemo::m_ModelInfo.GetModel(), CDemo::m_ModelInfo.GetYear());			
		//uiReport.SetEngineInfo(artiGetText("5100000000F6"), artiGetText("5100000000F7"));
		uiReport.SetVehPath(CDemo::m_ModelInfo.toString());			//宝马>320>系统>自动扫描

		/*
		* 概述
		* 总共扫描出12个系统，其中12个系统故障，故障数量为105个。为了安全驾驶请你仔细阅读分析报告，并修复相关故障信息组件，及时处理排查。
		*/
		uiReport.SetSummarize(artiGetText("510000000107"), artiGetText("510000000108"));

		uiReport.AddDtcItem(DtcReportItem);

		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			uRetBtn = uiReport.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
		}
	}
}



















