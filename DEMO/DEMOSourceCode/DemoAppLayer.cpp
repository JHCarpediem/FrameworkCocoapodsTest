/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 应用层
* 功能描述 : 应用层接口类
* 创 建 人 : panjun        20200120
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#include "DemoAppLayer.h"
#include "Expression.h"
#include "DemoInfomation.h"
#include "DemoVehicleStruct.h"
#include "StdCommMaco.h"
#include "ArtiMenu.h"
#include "StdShowMaco.h"
#include "DataFile.h"
#include "ProFile.h"
#include "ArtiSystem.h"
#include "DemoTroubleCode.h"
#include "DemoLiveData.h"
#include "DemoActive.h"
#include "ArtiMsgBox.h"
#include "DemoEnterSys.h"
#include "ArtiEcuInfo.h"
#include "DemoPublicAPI.h"
#include "ArtiTrouble.h"
#include "ArtiFreeze.h"
#include "ArtiList.h"
#include "ArtiLiveData.h"
#include "ArtiGlobal.h"
#include "ArtiReport.h"
#include "Demo.h"
#include "ArtiPopup.h"
#include "ArtiMiniMsgBox.h"
#include "ArtiGlobal.h"
#include "DemoHotFunction.h"



namespace Topdon_AD900_Demo {

	CAppLayer::CAppLayer()
	{
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DETE_OIL_RESET_POS, artiGetText("500000060101"));///* Oil Reset */
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DETE_THROTTLE_ADAPTATION_POS, artiGetText("500000060102"));//"Throttle Adaptation");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DETE_EPB_RESET_POS, artiGetText("500000060103"));//"EPB Reset");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DETE_ABS_BLEEDING_POS, artiGetText("500000060104"));//"ABS Bleeding");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_STEERING_ANGLE_RESET_POS, artiGetText("500000060105"));//"Steering Angle Reset");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_DPF_REGENERATION_POS, artiGetText("500000060106"));//"DPF Regeneration");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_AIRBAG_RESET_POS, artiGetText("500000060107"));//"Airbag Reset");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_BMS_RESET_POS, artiGetText("500000060108"));//"BMS Reset");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_ADAS_POS, artiGetText("500000060109"));//"ADAS");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_IMMO_POS, artiGetText("50000006010A"));//"IMMO");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_SMART_KEY_POS, artiGetText("50000006010B"));//"SmartKey");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_PASSWORD_READING_POS, artiGetText("50000006010C"));//"PasswordReading");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DETE_EPB_RESET_POS, artiGetText("50000006010D"));//"BrakeReplace");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_INJECTOR_CODE_POS, artiGetText("50000006010E"));//"InjectorCode");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_SUSPENSION_POS, artiGetText("50000006010F"));// "Suspension");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_TIRE_PRESSURE_POS, artiGetText("500000060110"));//"TirePressure");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_TRANSMISSION_POS, artiGetText("500000060111"));//"Transmission");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_GEARBOX_LEARNING_POS, artiGetText("500000060112"));//"GearboxLearning");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_TRANSPORT_MODE_POS, artiGetText("500000060113"));// "TransportMode");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_HEAD_LIGHT_POS, artiGetText("500000060114"));//"Headlight");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_SUNROOF_INIT_POS, artiGetText("500000060115"));// "SunroofInit");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_SEAT_CALI_POS, artiGetText("500000060116"));//"SeatCali");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_WINDOW_CALI_POS, artiGetText("500000060117"));// "WindowCali");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_START_STOP_POS, artiGetText("500000060118"));// "StartStop");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_EGR_POS, artiGetText("500000060119"));// "EGR");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_ODOMETER_POS, artiGetText("50000006011A"));//"Odometer");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_LANGUAGE_POS, artiGetText("50000006011B"));//"Language");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_TIRE_MODIFIED_POS, artiGetText("50000006011C"));//"Tire");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_A_F_ADJ_POS, artiGetText("50000006011D"));//"A_F_Adj");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_ELECTRONIC_PUMP_POS, artiGetText("50000006011E"));//"ElectronicPump");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_NOx_RESET_POS, artiGetText("50000006011F"));//"NoxReset");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_UREA_RESET_POS, artiGetText("500000060120"));// "UreaReset");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_TURBINE_LEARNING_POS, artiGetText("500000060121"));//"TurbineLearning");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_CYLINDER_POS, artiGetText("500000060122"));//"Cylinder");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_EEPROM_POS, artiGetText("500000060123"));//"EEPROM");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_EXHAUST_PROCESSING_POS, artiGetText("500000060124"));//"ExhaustProcessing");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_RFID_POS, artiGetText("500000060125"));//"RFID");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DETE_SPEC_FUNC_POS, artiGetText("500000060126"));//"Special fun");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_CLUTCH_POS, artiGetText("500000060127"));//"CLUTCH");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_SPEED_PTO_POS, artiGetText("500000060128"));//"Speed & PTO");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_FRM_RESET_POS, artiGetText("500000060129"));//"FRM RESET");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_VIN_POS, artiGetText("50000006012A"));//"VIN");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_HV_BATTERY_POS, artiGetText("50000006012B"));//"HV Battery");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_ACC_POS, artiGetText("50000006012C"));//"ACC");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_AC_LEARNING_POS, artiGetText("50000006012D"));//"A/C");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_RAIN_LIGHT_SENSOR_POS, artiGetText("50000006012E"));//"Rain/Light Sensor");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_RESET_CONTROL_UNIT_POS, artiGetText("50000006012F"));//"Reset control unit");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_CSS_ACC_POS, artiGetText("500000060130"));//"CCS/ACC");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_RELATIVE_COMPRESSION_POS, artiGetText("500000060131"));//"Relative Compression");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_HV_DE_ENERGIZATION_POS, artiGetText("500000060132"));//"HV De-energization/Energization");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_COOLANT_REFRIGERANT_CHANGE_POS, artiGetText("500000060133"));//"Coolant/Refrigerant Change");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_RESOLVER_SENSOR_CALIBRATION_POS, artiGetText("500000060134"));//"Resolver Sensor Calibration");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_CAMSHAFT_LEARNING_POS, artiGetText("500000060135"));//"Camshaft learning");
		m_mapeDiagTypeEx.emplace(eDiagEntryTypeEx::DEFE_VIN_ODOMETER_CHECK_POS, artiGetText("500000060136"));//"VIN/Odometer Check");


	}

	CAppLayer::~CAppLayer()
	{
		ExitSystem();
		m_mapeDiagTypeEx.clear();
	}

	void CAppLayer::GetFunMenu(CBinary binSys)
	{
		CDataFile		datafile;
		string			strTemp;
		CBinaryGroup	bgFun;
		CProFile		profile;
		vector<uint32_t>	vctiFunMask;
		vector<uint32_t>	vctiAllSupportFun;


#if __Multi_System_Test__
		CArtiMenu		uiMenu(uThread);
#else
		CArtiMenu uiMenu;
#endif

		CBinary			binMenu("\x50\x00\x00\x06\x00\x00", 6);

		vctiAllSupportFun = GetSupportAllFun();
		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return;
		}

		strTemp = datafile.GetText(Binary2HexString(binSys));
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		datafile.Close();
		bgFun = profile.GetBinaryGroup("FunMenu", "MunuItem");
		vctiFunMask = profile.GetHexGroup("FunMenu", "FunMask");

		uiMenu.InitTitle(artiGetText(binMenu));
		CBinary	binRealMenu;
		for (uint32_t i = 0; i < bgFun.GetSize(); i++)
		{
			CBinary	bin;
			if (find(vctiAllSupportFun.begin(),vctiAllSupportFun.end(),vctiFunMask[i]) == vctiAllSupportFun.end())
			{
				continue;
			}
			bin = binMenu;
			bin.SetAt(4, bgFun[i][0]);
			bin.SetAt(5, bgFun[i][1]);
			uiMenu.AddItem(artiGetText(bin));
			binRealMenu.Append(bgFun[i][1]);
		}

		vector<string> vctstrSpecialMask;

		vctstrSpecialMask = profile.GetStringGroup("Special", "Item");
		for (auto& strSpmask : vctstrSpecialMask)
		{
			uint32_t iSpmask = ToUint32(strSpmask);
			if (find(vctiAllSupportFun.begin(), vctiAllSupportFun.end(), iSpmask) != vctiAllSupportFun.end())
			{
				binRealMenu += 6;
				uiMenu.AddItem(artiGetText(CBinary("\x50\x00\x00\x06\x00\x06", 6)));
				break;
			}
		}
		if (binRealMenu.GetSize()==0)
		{
			artiShowMsgBox(artiGetText("FFFFFFFF0007"), artiGetText("FFFFFFFF0065"));
			return;
		}
		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				//ExitSystem();
				break;
			}
			switch (binRealMenu[uRet & 0xff])
			{
			case 1:
				ReadInformation();
				break;
			case 2:
				ReadTroubleCode(binSys);
				break;
			case 3:
				ClearTroubleCode();
				break;
			case 4:
				ReadDataStream(binSys);
				break;
			case 5:
				ActiveTest(binSys);
				break;
			case 6:
				SpecialFunction(binSys);
				break;
			default:
				break;
			}
		}
	}

	ErrorCode_t CAppLayer::StartAppLayer()
	{
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;
		CArtiSystem		uiSystem;
		CBinary			binSys("\x50\x00\x00\x05\x00\x00", 6);
		CBinaryGroup	bgSys;
		CBinaryGroup	bgRealSys;
		CBinaryGroup	bgSysMask;
		CBinary			bin;
		CDataFile		datafile;
		CProFile		profile;
		string			strTemp;
		vector<string>	vecstrSys;
		uint32_t		iScan = 0;
		uint32_t		uDtcNum = 0;

		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return ErrorCodeType::STATUS_NOERROR;
		}
		strTemp = datafile.GetText("ALLSysTem");
		datafile.Close();
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		bgSys = profile.GetBinaryGroup("System", "Sys");
		bgSysMask = profile.GetBinaryGroup("System", "SysMask");
		uiSystem.InitTitle(artiGetText("FFFFFFFF0085"));
		//uiSystem.SetHelpButtonVisible(true);//控制帮助按钮是否打开
		uiSystem.SetButtonAreaHidden(false);//控制【一键扫描】之类的按钮区域是否显示按钮，由于个别老车全是地址码协议，

		//artiShowMsgBox("bgSysMask", int32ToString(bgSysMask.GetSize()));
		uint64_t uSysMask = (uint64_t)CArtiGlobal::GetDiagMenuMask();
		for (uint32_t i = 0; i < bgSys.GetSize(); i++)
		{
			uint64_t	uSysMaskTemp = 0;

			uSysMaskTemp = (bgSysMask[i][0] * 256) + bgSysMask[i][1];
			if (!(uSysMask & uSysMaskTemp))
			{
				continue;
			}
			bin = binSys;
			bin.SetAt(4, bgSys[i][0]);
			bin.SetAt(5, bgSys[i][1]);
			strTemp = artiGetText(bin);
			uiSystem.AddItem(strTemp);
			vecstrSys.push_back(strTemp);
			bgRealSys.Append(bgSys[i]);
		}

		vector<stSysReportItem> vctItemsys;
		bool					bScan = false;//是否点击了一键扫描

		while (1)
		{
			uint32_t uRet = uiSystem.Show();
			if (uRet == DF_ID_SYS_BACK)
			{

				SetMyHistoryDtcItem(vctItemsys);
				CArtiGlobal::SetHistoryMileage("20237", "20230");
#ifndef WIN32
				CArtiGlobal::SetHistoryMMY("DEMO", CDemo::m_ModelInfo.GetModel(), CDemo::m_ModelInfo.GetYear());
				CArtiGlobal::SetHistoryEngine(CDemo::m_ModelInfo.GetEngineType(),CDemo::m_ModelInfo.GetEngineSubType());
#endif
				break;
			}
			else if (uRet == DF_ID_SYS_HELP)
			{
				artiShowMsgBox("11", "22", DF_MB_OK);
			}
			else if (uRet == DF_ID_SYS_START)
			{
				bScan = true;
				if (iScan == vecstrSys.size())
				{
					iScan = 0;
					vctItemsys.clear();
				}
				uiSystem.SetScanStatus(DF_SYS_SCAN_START);
				//uiSystem.Show();
				for (; iScan < vecstrSys.size(); iScan++)
				{
					stSysReportItem sysReportItem;
					//sysReportItem.strID = uint32ToString(iScan, true);
					sysReportItem.strName = vecstrSys[iScan];

					uiSystem.SetItemStatus(iScan, artiGetText("FFFFFFFF0022"));
					uiSystem.Show();
					CEnterSys::Delay(300);
					while (1)
					{
						uRet = uiSystem.Show();
						if (uRet == DF_ID_BACK)
						{
							return ectRet = ErrorCodeType::STATUS_NOERROR;
						}
						else
						{
							break;
						}
					}
					if ((bgRealSys[iScan] == CBinary("\x00\x01",2)) || (bgRealSys[iScan] == CBinary("\x00\x02", 2)))
					{
						if (CArtiGlobal::GetDiagEntryTypeEx()[1])
						{
							if (bgRealSys[iScan] == CBinary("\x00\x01", 2))
							{
								uDtcNum = 4;
							}
							else
							{
								uDtcNum = 6;
							}
							uiSystem.SetItemResult(iScan, DF_ENUM_DTCNUM | uDtcNum);
						}
						else
						{
							uDtcNum = 0;
							uiSystem.SetItemResult(iScan, DF_ENUM_NODTC);
						}
						sysReportItem.uDtsNums = uDtcNum;
					}
					else if ((bgRealSys[iScan] == CBinary("\x00\x13", 2)) || (bgRealSys[iScan] == CBinary("\x00\x15", 2)))// 根据何工需求，添加不存在系统 [10/27/2022 qunshang.li]
					{
						uiSystem.SetItemResult(iScan, DF_ENUM_NOTEXIST);
						continue;
					}
					else
					{
						uiSystem.SetItemResult(iScan, DF_ENUM_NODTC);
						sysReportItem.uDtsNums = 0;
					}
					if (uRet == DF_ID_SYS_STOP)
					{
						uiSystem.SetScanStatus(DF_SYS_SCAN_PAUSE);
						break;
					}
					vctItemsys.push_back(sysReportItem);
				}
				if (iScan == vecstrSys.size())
				{
					uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);
				}
			}
			else if (uRet == DF_ID_SYS_STOP)
			{
				uiSystem.SetScanStatus(DF_SYS_SCAN_PAUSE);
			}
			else if (uRet == DF_ID_SYS_ERASE)
			{
				uiSystem.SetClearStatus(DF_SYS_CLEAR_START);

				if (!CArtiGlobal::GetDiagEntryTypeEx()[2])
				{
					continue;
				}
				//需要判断有码的系统
				vector<uint16_t>	vecintDtcSys;

				vecintDtcSys = uiSystem.GetDtcItems();
				for (uint32_t i = 0; i < vecintDtcSys.size(); i++)
				{
					uiSystem.SetItemStatus(vecintDtcSys[i], artiGetText("FFFFFFFF0024"));
					uiSystem.Show();
					CEnterSys::Delay(1000);
					uiSystem.SetItemStatus(vecintDtcSys[i], artiGetText("FFFFFFFF0023"));
					uiSystem.Show();
					CEnterSys::Delay(1000);
					uDtcNum = 2;
					uiSystem.SetItemResult(vecintDtcSys[i], DF_ENUM_DTCNUM | uDtcNum);
					vctItemsys[vecintDtcSys[i]].uDtsNums = uDtcNum;
					//uiSystem.SetItemStatus(i, "正常");
				}
				uiSystem.SetClearStatus(DF_SYS_CLEAR_FINISH);
			}
			else if (uRet == DF_ID_SYS_REPORT)
			{
				SetSysReport(vctItemsys);
			}
			else if ((uRet & DF_ID_SYS_DTC_0) != 0)
			{

				if (CArtiGlobal::GetAppProductName() == CArtiGlobal::eProductName::PD_NAME_TOPVCI_CARPAL)
				{
					ReadTroubleCode(bgRealSys[uRet & 0xff]);
					continue;
				}

				int iCout = DF_SYS_GET_DTC_SYS_NO(uRet);//获取点击的系统下标

				//if (uRet == DF_ID_SYS_DTC_2)
				{
					artiShowMiniMsgBox(artiGetText("Communication_status"), artiGetText("Communicating"), DF_MB_NOBUTTON, DT_CENTER);
					Delay(1000);

					CArtiPopup uiPopup;


					CBinary binText = CBinary("\x50\x00\x00\x11\x00\x01", 6);
					uint8_t iNum = 0;
					if (iCout == 1)
					{
						uiPopup.InitTitle(artiGetText("500000050002"), DF_POPUP_TYPE_LIST);
						iNum = 4;
					}
					else
					{
						uiPopup.InitTitle(artiGetText("500000050001"), DF_POPUP_TYPE_LIST);
					}
					uiPopup.SetColWidth(vector<uint32_t>{20, 50, 30});

					for (uint32_t i=iNum,j=0;  j<vctItemsys[uRet&0xff].uDtsNums; i++,j++)
					{
						binText.SetAt(5, i +1);
						string strText = artiGetText(binText);
						if ((strText.size()==0))
						{
							break;
						}
						if (iCout==0)
						{
							if (i==4)
							{
								break;
							}
						}
						vector<string> vctItem = SeparateString(strText, "@");
						uiPopup.AddItem(vctItem);
					}

					uiPopup.Show();
				}
			}
			else if (uRet != DF_ID_SYS_NOKEY)
			{
				// 添加车型路径 [11/28/2022 qunshang.li]
				CDemo::m_ModelInfo.SetSysName(uiSystem.GetItem(uRet & 0xFF));
				//CArtiGlobal::SetSysName(uiSystem.GetItem(uRet & 0xFF));
				CArtiGlobal::SetVehInfo(CDemo::m_ModelInfo.toString());
				CEcuInterface::Log(CDemo::m_ModelInfo.toString().c_str());

				// end [11/28/2022 qunshang.li]
				
				//进入系统
				artiShowMsgBox(artiGetText("Communication_status"), artiGetText("Communicating"), DF_MB_NOBUTTON);
				Delay(800);
				if((bgRealSys[uRet&0xff] == CBinary("\x00\x13", 2)) || (bgRealSys[uRet & 0xff] == CBinary("\x00\x15", 2)))
				{
					artiShowMsgBox(artiGetText("Communication_status"), artiGetText("Communication_Fail"), DF_MB_OK);
					uiSystem.SetItemResult(uRet & 0xff, DF_ENUM_NOTEXIST);
				}
 				else
 				{
					GetFunMenu(bgRealSys[uRet & 0xFF]);
					uiSystem.SetItemStatus(uRet&0xff, artiGetText("FFFFFFFF0023"));
					uiSystem.Show();
					CEnterSys::Delay(1000);
					if ((bgRealSys[uRet & 0xff] == CBinary("\x00\x01", 2)) || (bgRealSys[uRet & 0xff] == CBinary("\x00\x02", 2)))
					{
						uDtcNum = 2;
					}
					else
					{
						uDtcNum = 0;
					}
					if (uDtcNum == 0)
					{
						uiSystem.SetItemResult(uRet & 0xff, DF_ENUM_NODTC | uDtcNum);
					}
					else
					{
						uiSystem.SetItemResult(uRet & 0xff, DF_ENUM_DTCNUM | uDtcNum);
					}
					if (bScan)//点击了一键扫描
					{
						vctItemsys[uRet & 0xff].uDtsNums = uDtcNum;
					}
					else
					{
						stSysReportItem sysReportItem;

						sysReportItem.strName = vecstrSys[uRet & 0xFF];
						if ((bgRealSys[uRet & 0xFF] == CBinary("\x00\x01", 2)) || (bgRealSys[uRet & 0xFF] == CBinary("\x00\x02", 2)))
						{
							if (CArtiGlobal::GetDiagEntryTypeEx()[1])
							{
								if (bgRealSys[uRet & 0xFF] == CBinary("\x00\x01", 2))
								{
									uDtcNum = 4;
								}
								else
								{
									uDtcNum = 6;
								}
								uiSystem.SetItemResult(uRet & 0xFF, DF_ENUM_DTCNUM | uDtcNum);
							}
						}
						else
						{
							uDtcNum = 0;
							uiSystem.SetItemResult(uRet & 0xFF, DF_ENUM_NODTC);
						}
						sysReportItem.uDtsNums = uDtcNum;
						vctItemsys.push_back(sysReportItem);
					}
				}

				// 添加车型路径 [11/28/2022 qunshang.li]
				CDemo::m_ModelInfo.SetSysName("");
				CArtiGlobal::SetVehInfo(CDemo::m_ModelInfo.toString());
				CArtiGlobal::SetSysName("");
				// end [11/28/2022 qunshang.li]
			}
		}
		return ectRet = ErrorCodeType::STATUS_NOERROR;
	}


	ErrorCode_t CAppLayer::ReadInformation()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

#if __Multi_System_Test__
		__ReadInformation();
#else
		CInformation information;
		information.SetSysEnterPointer(&m_EnterSys);
		information.ReadVersion();
#endif
		return ectRet;
	}

	ErrorCode_t CAppLayer::ClearTroubleCode()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

#if __Multi_System_Test__
		__ClearTroubleCode();
#else
		CTroubleCode	TroubleCode;
		TroubleCode.SetSysEnterPointer(&m_EnterSys);
		TroubleCode.ClearTroubleCode();
#endif

		return ectRet;
	}

	void CAppLayer::SetMyHistoryDtcItem(vector<stSysReportItem> vctItemsys)
	{
		CBinary binText = CBinary("\x50\x00\x00\x11\x00\x01", 6);

		for (uint32_t isys=0; isys<vctItemsys.size(); isys++)
		{
			if (vctItemsys[isys].uDtsNums>0)
			{
				stDtcReportItemEx DtcReportItemEx;

				DtcReportItemEx.strName = vctItemsys[isys].strName;
				uint8_t i = 0;
				if (isys==1)
				{
					i = 4;
				}
				for (uint32_t j=0; j < vctItemsys[isys].uDtsNums; j++)
				{
					stDtcNodeEx dtcNodeEx;

					binText.SetAt(5, i + 1);
					string strText = artiGetText(binText);
					vector<string> vctDtc = SeparateString(strText, "@");
					if (vctDtc.size() > 0)
					{
						dtcNodeEx.strCode = vctDtc[0];
					}
					if (vctDtc.size() > 1)
					{
						dtcNodeEx.strDescription = vctDtc[1];
					}
					if (i == 2 || i == 3)
					{
						dtcNodeEx.uStatus = DF_DTC_STATUS_HISTORY;
					}
					else if (i == 0 || i == 1 || i == 4 || i == 5)
					{
						dtcNodeEx.uStatus = DF_DTC_STATUS_CURRENT;
					}
					else
					{
						dtcNodeEx.uStatus = DF_DTC_STATUS_NONE;
					}
					DtcReportItemEx.vctNode.push_back(dtcNodeEx);
					i++;
				}
				CArtiGlobal::SetHistoryDtcItem(DtcReportItemEx);
			}
		}
	}


	ErrorCode_t CAppLayer::ReadTroubleCode(CBinary binSys)
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;
#if __Multi_System_Test__
		__ReadTroubleCode();
#else
		CTroubleCode	TroubleCode;
		TroubleCode.SetSysEnterPointer(&m_EnterSys);
		TroubleCode.ReadTroubleCode(binSys);
#endif

		return ectRet;
	}

	ErrorCode_t CAppLayer::ReadDataStream(CBinary	binSys)
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;
#if __Multi_System_Test__
		__ReadDataStream();
#else
		CLiveData	LiveData;
		LiveData.SetSysEnterPointer(&m_EnterSys);
		LiveData.DataStream(binSys);
#endif
		return ectRet;
	}

	ErrorCode_t CAppLayer::ActiveTest(CBinary binSys)
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;
#if __Multi_System_Test__
		__ActiveTest();
#else
		CActive		uiAct;
		uiAct.SetSysEnterPointer(&m_EnterSys);
		uiAct.ActiveTest(binSys);
#endif
		return ectRet;
	}

	ErrorCode_t CAppLayer::SpecialFunction(CBinary binSys)
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;
		CDataFile	datafile;
		string      strTemp;
		CProFile	profile;
		CArtiMenu	uiMenu;
		vector<uint32_t> vctiDiagFun;

		vctiDiagFun = GetSupportHotFun();

		uiMenu.InitTitle(artiGetText("500000060006"));
		if (!datafile.Open("Vehicle.dat"))
		{
			artiShowMsgBox("error", "error", DF_MB_OK);
			return ectRet;
		}

		strTemp = datafile.GetText(Binary2HexString(binSys));
		if (strTemp.size() > 0)
		{
			profile.Set(strTemp);
		}
		vector<string> vctstrSpecialMask;
		vector<uint32_t> vctuSpMask;

		vctstrSpecialMask = profile.GetStringGroup("Special", "Item");
		for (auto& strSpmask : vctstrSpecialMask)
		{
			uint32_t iSpmask = ToUint32(strSpmask);
			if (find(vctiDiagFun.begin(), vctiDiagFun.end(), iSpmask) != vctiDiagFun.end())
			{
				uiMenu.AddItem(m_mapeDiagTypeEx[(eDiagEntryTypeEx)iSpmask]);
				vctuSpMask.push_back(iSpmask);
			}
		}
		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			CHotFunction  HotFun;
			HotFun.SpFunMask(uiMenu.GetItem(uRet & 0xff), vctuSpMask[uRet & 0xff]);
		}
		return ectRet;
	}

	void CAppLayer::ExitSystem()
	{
		if (!m_EnterSys.IsEmpty())
		{
			m_EnterSys.ExitSystem();
		}
	}

	std::vector<std::string> CAppLayer::GetSectionsFromFile(string strFile, string strIndex)
	{
		CDataFile dataFile;
		if (!dataFile.Open(strFile))
		{
			return vector<string>{};
		}

		CProFile proFile;
		string strText = dataFile.GetText(strIndex);
		proFile.Set(strText);

		return proFile.GetSections();
	}

	std::vector<std::string> CAppLayer::GetSectionsFromFile(string strFile, CBinary binIndex)
	{
		return GetSectionsFromFile(strFile, Binary2HexString(binIndex));
	}

	std::vector<std::string> CAppLayer::GetKeysFromFile(string strFile, string strIndex, string strSection)
	{
		CDataFile dataFile;
		if (!dataFile.Open(strFile))
		{
			return vector<string>{};
		}

		CProFile proFile;
		string strText = dataFile.GetText(strIndex);
		proFile.Set(strText);

		return proFile.GetKeysBySection(strSection);
	}

	std::vector<std::string> CAppLayer::GetKeysFromFile(string strFile, CBinary binIndex, string strSection)
	{
		return GetKeysFromFile(strFile, Binary2HexString(binIndex), strSection);
	}

	std::string CAppLayer::GetValueFromFile(string strFile, string strIndex, string strSection, string strKey)
	{
		CDataFile dataFile;
		if (!dataFile.Open(strFile))
		{
			return "";
		}

		CProFile proFile;
		string strText = dataFile.GetText(strIndex);
		proFile.Set(strText);

		return proFile.GetValue(strSection, strKey);
	}

	std::string CAppLayer::GetValueFromFile(string strFile, CBinary binIndex, string strSection, string strKey)
	{
		return GetValueFromFile(strFile, Binary2HexString(binIndex), strSection, strKey);
	}

	std::string CAppLayer::SelectSysProtocol(uint8_t uSysId, uint32_t uThread)
	{
		CBinary binSysName = CBinary("\x51\xFF\x00\x00\x00\x01", 6);
		CBinary binProtocol = CBinary("\x56\x00\x00\x00\x00\x01", 6);

		binSysName.SetAt(5, uSysId);
		binProtocol.SetAt(5, uSysId);

		vector<string> vctProtocol = CAppLayer::GetSectionsFromFile(FILE_AllSysProtocolConfig, binProtocol);
		if (vctProtocol.empty())
		{
#if __Multi_System_Test__
			artiShowMsgBoxEx(artiGetText(binSysName), artiGetText("FF00000000AA"), DF_MB_OK, DT_CENTER, -1, uThread);
#else
			artiShowMsgBox(artiGetText(binSysName), artiGetText("FF00000000AA"), DF_MB_OK, DT_CENTER, -1);
#endif
			return "";
		}

#if __Multi_System_Test__
		CArtiMenu uiMenu(uThread);
#else
		CArtiMenu uiMenu;
#endif

		uiMenu.InitTitle(artiGetText(binSysName));

		for (uint8_t i = 0; i < vctProtocol.size(); i++)
		{
			uiMenu.AddItem(vctProtocol[i]);
		}

		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_CANCEL == uRetBtn)
			{
				return "";
			}
			else if (uRetBtn < vctProtocol.size())
			{
				return vctProtocol[uRetBtn];
			}
		}
	}

	void CAppLayer::SetThreadNo(uint32_t uThread)
	{
		this->uThread = uThread;
	}

	void CAppLayer::SetEnterSys(CEnterSys enterSys)
	{
		this->m_EnterSys = enterSys;
	}

	void CAppLayer::ShowSysFuncMenu()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(uThread);
#else
		CArtiMenu uiMenu;
#endif

		CBinary binsys("\x00\x03", 2);

		uiMenu.InitTitle(artiGetText("500000060000"));				//"功能菜单"
		uiMenu.AddItem(artiGetText("500000060001"));				//"读电脑信息"
		uiMenu.AddItem(artiGetText("500000060002"));				//"读故障码"
		uiMenu.AddItem(artiGetText("500000060003"));				//"清除故障码"
		uiMenu.AddItem(artiGetText("500000060004"));				//"读数据流"
		//uiMenu.AddItem(artiGetText("500000060005"));				//"动作测试"

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				//ExitSystem();
				break;
			}
// 			switch (uRet & 0xff)
// 			{
// 			case 0:
// 				ReadInformation();
// 				break;
// 			case 1:
// 				ReadTroubleCode(binsys);
// 				break;
// 			case 2:
// 				ClearTroubleCode();
// 				break;
// 			case 3:
// 				ReadDataStream(binsys);
// 				break;
// 			case 4:
// 				ActiveTest();
// 				break;
// 			default:
// 				break;
// 			}
		}

	}

	ErrorCode_t CAppLayer::__ReadInformation()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

#if __Multi_System_Test__
		CArtiEcuInfo uiEcuInfo(uThread);
#else
		CArtiEcuInfo uiEcuInfo;
#endif

		uiEcuInfo.InitTitle("Ecu Information");
		uiEcuInfo.SetColWidth(50, 50);

		uiEcuInfo.AddItem("SysID", uint32ToString(m_EnterSys.m_SysId));
		uiEcuInfo.AddItem("EcuID", uint32ToString(m_EnterSys.m_EcuInfo.uEcuId, false));
		uiEcuInfo.AddItem("ToolID", uint32ToString(m_EnterSys.m_EcuInfo.uToolId, false));
		uiEcuInfo.AddItem("SysProtocol", m_EnterSys.m_Protocol);

		CBinary binSysName = CBinary("\x51\xFF\x00\x00\x00\x01", 6);
		binSysName.SetAt(5, m_EnterSys.m_SysId);
		uiEcuInfo.AddItem("SysName", artiGetText(binSysName));

		uiEcuInfo.Show();

		return ectRet;
	}

	ErrorCode_t CAppLayer::__FrzDataStream(CBinary binCode)
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

		if (binCode.GetSize() != 0x02)
		{
			// 提示数据错误
		}

		CBinary binRecv;
		CBinary binFreezeFrame("\x19\x06\x00\x00\x00", 5);
		CBinary binTextIndex("\x50\x00\x00\x08\x00\x00", 6);
		CBinary binUnitIndex("\x50\x00\x00\x09\x00\x00", 6);

		binFreezeFrame.SetAt(3, binCode[0]);
		binFreezeFrame.SetAt(4, binCode[1]);

		binRecv = m_EnterSys.SendReceive(binFreezeFrame,1);
		if (!binRecv.GetSize())
		{
			// 提示通信失败
		}
		else if (binRecv.GetSize() <= 3)
		{
			// 提示无数据流
		}
		else
		{

#if __Multi_System_Test__
			CArtiFreeze uiFreeze(uThread);
#else
			CArtiFreeze uiFreeze;
#endif
			uiFreeze.InitTitle(artiGetText("500000080000"));

			for (uint32_t i = 3; i + 3 < binRecv.GetSize(); i++)
			{
				binTextIndex.SetAt(4, binRecv[i]);
				binTextIndex.SetAt(5, binRecv[i + 1]);

				binUnitIndex.SetAt(4, binRecv[i + 3]);
				binUnitIndex.SetAt(5, binRecv[i + 4]);

				string strValue = Calc_Script(Binary2HexString(binTextIndex), binRecv, i + 2);

				uiFreeze.AddItem(artiGetText(binTextIndex), strValue, artiGetText(binUnitIndex));
			}

			uint32_t uRetBtn = DF_ID_NOKEY;
			while (1)
			{
				uRetBtn = uiFreeze.Show();
				if (uRetBtn == DF_ID_BACK)
				{
					break;
				}
			}

		}

		return ectRet;
	}

	ErrorCode_t CAppLayer::__ClearTroubleCode()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

#if __Multi_System_Test__
		artiShowMsgBoxEx(artiGetText("FF0F00000000"), artiGetText("FF0B0000000F"), DF_MB_NOBUTTON, DT_CENTER, 2000, uThread);
#else
		artiShowMsgBox(artiGetText("FF0F00000000"), artiGetText("FF0B0000000F"), DF_MB_NOBUTTON, DT_CENTER, 2000);
#endif

		CBinary binEraseCmd("\x14\xFF\xFF\xFF", 4);
		m_EnterSys.SendReceive(binEraseCmd,1);
		artiShowMsgBox(artiGetText("500000060003"), artiGetText("ClearSuc"), DF_MB_OK);

		return ectRet;
	}

	ErrorCode_t CAppLayer::__ReadTroubleCode()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

		CBinary binRecv;
		CBinary binRead = CBinary("\x19\x02\x2C", 3);
		CBinary binText = CBinary("\x50\x00\x00\x11\x00\x01", 6);

#if __Multi_System_Test__
		artiShowMsgBoxEx(artiGetText("FF00000000CB"), artiGetText("FF00000000AB"), DF_MB_NOBUTTON, DT_CENTER, -1, uThread);
#else
		artiShowMsgBox(artiGetText("FF00000000CB"), artiGetText("FF00000000AB"), DF_MB_NOBUTTON, DT_CENTER, -1);
#endif

		binRecv = m_EnterSys.SendReceive(binRead);

		if (!binRecv.GetSize())
		{
#if __Multi_System_Test__
			//提示通信失败
			artiShowMsgBoxEx(artiGetText("FF00000000CB"), artiGetText("FF00000000AC"), DF_MB_OK, DT_CENTER, -1, uThread);
#else
			//提示通信失败
			artiShowMsgBox(artiGetText("FF00000000CB"), artiGetText("FF00000000AC"), DF_MB_OK, DT_CENTER, -1);
#endif

		}
		else if (binRecv.GetSize() <= 3)
		{
#if __Multi_System_Test__
			//提示无故障码
			artiShowMsgBoxEx(artiGetText("FF00000000CB"), artiGetText("FF00000000AD"), DF_MB_OK, DT_CENTER, -1, uThread);
#else
			//提示无故障码
			artiShowMsgBox(artiGetText("FF00000000CB"), artiGetText("FF00000000AD"), DF_MB_OK, DT_CENTER, -1);
#endif
		}
		else
		{
			string strTemp = "";
			vector<string> vctStr;

#if __Multi_System_Test__
			CArtiTrouble uiTrouble(uThread);
#else
			CArtiTrouble uiTrouble;
#endif
			uiTrouble.InitTitle(artiGetText("500000060002"));

			for (uint32_t i = 3; i + 1 < binRecv.GetSize(); i = i + 2)
			{
				binText.SetAt(4, binRecv[i]);
				binText.SetAt(5, binRecv[i + 1]);

				vctStr.clear();
				strTemp = artiGetText(binText);
				Split(strTemp, "@", vctStr);
				if (vctStr.size() > 1)
				{
					uiTrouble.AddItem(vctStr[0], vctStr[1], "Current", "");
				}
				if (vctStr.size() > 2)
				{
					uiTrouble.SetItemHelp(i, vctStr[2]);
				}
				else
				{
					uiTrouble.SetMILStatus(i, true);
					uiTrouble.SetFreezeStatus(i, true);
				}
			}
			uiTrouble.SetCdtcButtonVisible(true);

			uint32_t uRetBtn = DF_ID_NOKEY;
			while (1)
			{
				uRetBtn = uiTrouble.Show();
				if (uRetBtn == DF_ID_BACK)
				{
					break;
				}
				else if (uRetBtn == DF_ID_TROUBLE_CLEAR)
				{
					__ClearTroubleCode();
					break;
				}
				else if (((uRetBtn & 0xFF) != 1) && ((uRetBtn & 0xFF) != 3))
				{

				}
			}
		}
		return ectRet;
	}

	ErrorCode_t CAppLayer::__ReadDataStream()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

#if __Multi_System_Test__
		CArtiLiveData uiLiveData(uThread);
#else
		CArtiLiveData uiLiveData;
#endif
		uiLiveData.InitTitle(artiGetText("500000080000"));

		CBinary binText = CBinary("\x50\x00\x00\x08\x00\x00", 6);
		CBinary binUnit = CBinary("\x50\x00\x00\x09\x00\x00", 6);

		for (uint32_t i = 1; i < 5; i++)
		{
			binText.SetAt(5, i);
			binUnit.SetAt(5, i);
			uiLiveData.AddItem(artiGetText(binText), "", artiGetText(binUnit));
		}

		CBinary binCal = CBinary("\x10\x32\x32\x05", 4);
		CBinary binExp = CBinary("\x50\x00\x00\x08\x00\x00", 6);
		CBinary binRead = CBinary("\x22\x01\x02", 3);

		string strValue;
		uint32_t uPos = 2;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			uRetBtn = uiLiveData.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

			CBinary binRecv = m_EnterSys.SendReceive(binRead,1);
			for (uint32_t i = 3, ucnt = 0; i < binRecv.GetSize() && ucnt < 5; i++, ucnt++)
			{
				binExp.SetAt(5, ucnt + 1);
				binCal.SetAt(2, binRecv[i]);
				strValue = Calc_Script(binExp, binCal, uPos);

				uiLiveData.FlushValue(ucnt, strValue);
			}
		}

		return ectRet;
	}

	ErrorCode_t CAppLayer::__ActiveTest()
	{
		ErrorCode_t ectRet = ErrorCodeType::STATUS_NOERROR;

		return ectRet;
	}

	void CAppLayer::SetSysReport(std::vector<stSysReportItem>& vctItem)
	{
		// 判断 APP 的宿主机类型
		//CArtiGlobal::eHostType uHostType = CArtiGlobal::GetHostType();

		//当前app应用的产品名称
		//CArtiGlobal::eProductName uProductName = CArtiGlobal::GetAppProductName();

		//当前诊断的入口类型
		//CArtiGlobal::eDiagEntryType uDiagEntryType = CArtiGlobal::GetDiagEntryType();

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200001"), DF_MB_NOBUTTON);

		//设置系统报告
		CArtiReport uiReport;
		uiReport.InitTitle(artiGetText("5100000000E0"));			//诊断报告
		uiReport.SetReportType(CArtiReport::REPORT_TYPE_SYSTEM);
		uiReport.SetTypeTitle(artiGetText("510000000101"));			//系统诊断报告
		uiReport.SetDescribeTitle(artiGetText("510000000100"));		//2015-09奥迪
		uiReport.SetVehInfo("DEMO", CDemo::m_ModelInfo.GetModel(), CDemo::m_ModelInfo.GetYear());			
		uiReport.SetEngineInfo(artiGetText("5100000000F6"), "");
		uiReport.SetVehPath(CDemo::m_ModelInfo.toString());			//宝马>320>系统>自动扫描
		uiReport.SetMileage("20237","20230");
		/*
		* 概述
		* 总共扫描出10个系统，其中1个系统故障，故障数量为105个。为了安全驾驶请你仔细阅读分析报告，并修复相关故障信息组件，及时处理排查。
		*/
		uiReport.SetSummarize(artiGetText("510000000107"), artiGetText("510000000108"));

		Delay(1000);

		/*
		* 1  -   发动机系统   -   无码
		* 2  -   变速箱系统   -   无码
		* 3  -   ABS系统      -   有码|2个
		* 4  -   SRS系统      -   无码
		* 5  -   BCM系统      -   无码
		*/
		uiReport.AddSysItems(vctItem);

		/*
		* 3  -   ABS系统
		* PC0015   -   位置传感器短路     -   当前的
		* PC0016   -   位置传感器短路     -   历史的
		*/
		//DtcReportItem.strID = "1";

		CBinary binText = CBinary("\x50\x00\x00\x11\x00\x01", 6);

		for (uint32_t isys=0; isys<vctItem.size(); isys++)
		{

			if (vctItem[isys].uDtsNums>0)
			{
				uint32_t	uNum = 0;
				stDtcReportItem DtcReportItem;

				DtcReportItem.strName = vctItem[isys].strName;
				if (isys==1)
				{
					uNum = 4;
				}

				for (uint8_t i = uNum,j=0; j < vctItem[isys].uDtsNums; j++)
				{
					stDtcNode dtcNode;

					binText.SetAt(5, i + 1);
					string strText = artiGetText(binText);
					vector<string> vctDtc = SeparateString(strText, "@");
					if (vctDtc.size() > 0)
					{
						dtcNode.strCode = vctDtc[0];
					}
					if (vctDtc.size() > 1)
					{
						dtcNode.strDescription = vctDtc[1];
					}
					if (i == 0 || i == 1 || i == 4 || i == 5)
					{
						dtcNode.uStatus = DF_DTC_STATUS_CURRENT;
					}
					else if (i == 2 || i == 3)
					{
						dtcNode.uStatus = DF_DTC_STATUS_HISTORY;
					}
					else
					{
						dtcNode.uStatus = DF_DTC_STATUS_NONE;
					}
					DtcReportItem.vctNode.push_back(dtcNode);
					i++;
				}
				uiReport.AddDtcItem(DtcReportItem);
			}
		}
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