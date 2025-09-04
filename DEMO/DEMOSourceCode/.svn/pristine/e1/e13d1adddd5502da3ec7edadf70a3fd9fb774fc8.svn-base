#include "Demo.h"
#include "Binary.h"
#include "DataFile.h"
#include "ArtiMsgBox.h"
#include "DemoAppLayer.h"
#include "ProFile.h"
#include "ArtiInput.h"
#include "PublicInterface.h"
#include "ArtiGlobal.h"
#include "Mathematics.h"
#include "ArtiMenu.h"
#include "DemoEnterSys.h"
#include "DemoAPITest.h"
#include "DemoHotFunction.h"
#include "DemoPublicAPI.h"
#include "DemoEcuTest.h"
#include "DemoUnlockGW.h"
#include "DiagEntryType.h"



namespace Topdon_AD900_Demo {

	Topdon_AD900_Demo::CModelInfo CDemo::m_ModelInfo;

	CDemo::CDemo()
	{
		CDataFile::SetVehPath(CArtiGlobal::GetVehPath());
		CDataFile::SetLanguage(CArtiGlobal::GetLanguage());
//		CDataFile::SetLanguage("cn");


		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_NORMAL_NONE, "DET_NORMAL_NONE");
		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_BASE_VER, "DET_BASE_VER");
		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_BASE_RDTC, "DET_BASE_RDTC");
		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_BASE_CDTC, "DET_BASE_CDTC");
		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_BASE_RDS, "DET_BASE_RDS");
		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_BASE_ACT, "DET_BASE_ACT");
		// 		mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_BASE_FFRAME, "DET_BASE_FFRAME");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DETE_OIL_RESET_POS, artiGetText("500000060101"));///* Oil Reset */
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DETE_THROTTLE_ADAPTATION_POS, artiGetText("500000060102"));//"Throttle Adaptation");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DETE_EPB_RESET_POS, artiGetText("500000060103"));//"EPB Reset");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DETE_ABS_BLEEDING_POS, artiGetText("500000060104"));//"ABS Bleeding");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_STEERING_ANGLE_RESET_POS, artiGetText("500000060105"));//"Steering Angle Reset");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_DPF_REGENERATION_POS, artiGetText("500000060106"));//"DPF Regeneration");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_AIRBAG_RESET_POS, artiGetText("500000060107"));//"Airbag Reset");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_BMS_RESET_POS, artiGetText("500000060108"));//"BMS Reset");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_ADAS_POS, artiGetText("500000060109"));//"ADAS");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_IMMO_POS, artiGetText("50000006010A"));//"IMMO");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_SMART_KEY_POS, artiGetText("50000006010B"));//"SmartKey");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_PASSWORD_READING_POS, artiGetText("50000006010C"));//"PasswordReading");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_INJECTOR_CODE_POS, artiGetText("50000006010E"));//"InjectorCode");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_SUSPENSION_POS, artiGetText("50000006010F"));// "Suspension");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_TIRE_PRESSURE_POS, artiGetText("500000060110"));//"TirePressure");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_TRANSMISSION_POS, artiGetText("500000060111"));//"Transmission");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_GEARBOX_LEARNING_POS, artiGetText("500000060112"));//"GearboxLearning");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_TRANSPORT_MODE_POS, artiGetText("500000060113"));// "TransportMode");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_HEAD_LIGHT_POS, artiGetText("500000060114"));//"Headlight");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_SUNROOF_INIT_POS, artiGetText("500000060115"));// "SunroofInit");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_SEAT_CALI_POS, artiGetText("500000060116"));//"SeatCali");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_WINDOW_CALI_POS, artiGetText("500000060117"));// "WindowCali");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_START_STOP_POS, artiGetText("500000060118"));// "StartStop");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_EGR_POS, artiGetText("500000060119"));// "EGR");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_ODOMETER_POS, artiGetText("50000006011A"));//"Odometer");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_LANGUAGE_POS, artiGetText("50000006011B"));//"Language");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_TIRE_MODIFIED_POS, artiGetText("50000006011C"));//"Tire");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_A_F_ADJ_POS, artiGetText("50000006011D"));//"A_F_Adj");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_ELECTRONIC_PUMP_POS, artiGetText("50000006011E"));//"ElectronicPump");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_NOx_RESET_POS, artiGetText("50000006011F"));//"NoxReset");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_UREA_RESET_POS, artiGetText("500000060120"));// "UreaReset");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_TURBINE_LEARNING_POS, artiGetText("500000060121"));//"TurbineLearning");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_CYLINDER_POS, artiGetText("500000060122"));//"Cylinder");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_EEPROM_POS, artiGetText("500000060123"));//"EEPROM");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_EXHAUST_PROCESSING_POS, artiGetText("500000060124"));//"ExhaustProcessing");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_RFID_POS, artiGetText("500000060125"));//"RFID");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DETE_SPEC_FUNC_POS, artiGetText("500000060126"));//"Special fun");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_CLUTCH_POS, artiGetText("500000060127"));//"CLUTCH");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_SPEED_PTO_POS, artiGetText("500000060128"));//"Speed & PTO");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_FRM_RESET_POS, artiGetText("500000060129"));//"FRM RESET");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_VIN_POS, artiGetText("50000006012A"));//"VIN");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_HV_BATTERY_POS, artiGetText("50000006012B"));//"HV Battery");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_ACC_POS, artiGetText("50000006012C"));//"ACC");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_AC_LEARNING_POS, artiGetText("50000006012D"));//"A/C");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_RAIN_LIGHT_SENSOR_POS, artiGetText("50000006012E"));//"Rain/Light Sensor");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_RESET_CONTROL_UNIT_POS, artiGetText("50000006012F"));//"Reset control unit");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_CSS_ACC_POS, artiGetText("500000060130"));//"CCS/ACC");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_RELATIVE_COMPRESSION_POS, artiGetText("500000060131"));//"Relative Compression");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_HV_DE_ENERGIZATION_POS, artiGetText("500000060132"));//"HV De-energization/Energization");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_COOLANT_REFRIGERANT_CHANGE_POS, artiGetText("500000060133"));//"Coolant/Refrigerant Change");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_RESOLVER_SENSOR_CALIBRATION_POS, artiGetText("500000060134"));//"Resolver Sensor Calibration");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_CAMSHAFT_LEARNING_POS, artiGetText("500000060135"));//"Camshaft learning");
		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_VIN_ODOMETER_CHECK_POS, artiGetText("500000060136"));//"VIN/Odometer Check");

// 		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_MT_CUSTOMIZE_POS, artiGetText("500000060136"));//
// 		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_MT_MOTOR_ANGLE_POS, artiGetText("500000060136"));//
// 		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_MT_EV_COMPRESSION_POS, artiGetText("500000060136"));//
// 		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_MT_EV_OBC_POS, artiGetText("500000060136"));//
// 		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_MT_EV_DCDC_POS, artiGetText("500000060136"));//
// 		mapeDiagEntryType.emplace(eDiagEntryTypeEx::DEFE_MT_EV_48V_POS, artiGetText("500000060136"));//

	}

	CDemo::~CDemo()
	{
		CDataFile::Destroy();
	}

	int32_t CDemo::MainEntry()
	{
		CArtiMenu	uiMenu;
		uint32_t	uRet;
		string		strPath;
		string		strVIN;
		string		strHistoryRecord;

		// 	strPath = CArtiGlobal::GetVehPath();
		// 	strPath += "\\";
		// 	setLanguage(CArtiGlobal::GetLanguage());
		// 	setPath(strPath);

// 		strHistoryRecord += artiGetText("500000000002");//自动？手动？
// 		strHistoryRecord += "@JN111111111111111";
// 		strHistoryRecord += "@";
// 		strHistoryRecord += "350Z";//车型
// 		strHistoryRecord += "@";
// 		strHistoryRecord += "2020";//年份

#ifndef WIN32

		if (CArtiGlobal::IsEntryFromHistory())
		{
			strHistoryRecord = CArtiGlobal::GetHistoryRecord();
		}
#endif // DEBUG
		//strHistoryRecord.clear();
		if (strHistoryRecord.size()>0)
		{
			vector<string>	vecstrHistory;

			vecstrHistory = SeparateString(strHistoryRecord, "@");
			if (vecstrHistory.size()>3)
			{
				m_ModelInfo.Clear();
				m_ModelInfo.SetDiagnosisType(vecstrHistory[0]);
				m_ModelInfo.SetModel(vecstrHistory[2]);
				m_ModelInfo.SetYear(vecstrHistory[3]);
 				m_ModelInfo.SetEngineType(vecstrHistory[4]);
// 				m_ModelInfo.SetEngineSubType(vecstrHistory[5]);
				CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
				CArtiGlobal::SetVIN(vecstrHistory[1]);
				SelectDiagType();
				return 0;
			}
		}

		strVIN = CArtiGlobal::GetVIN();
		if (strVIN.size() == 17)
		{
			CArtiGlobal::SetVIN(strVIN);
			CAppLayer	applayer;

			applayer.StartAppLayer();
		}
		uiMenu.InitTitle(artiGetText("FFFFFFFF0003"));
		uiMenu.AddItem(artiGetText("FFFFFFFF0004"));
		uiMenu.AddItem(artiGetText("FFFFFFFF0005"));

		string strLang = CArtiGlobal::GetLanguage();
		if ((String2Upper(strLang) == "CN") && (CArtiGlobal::GetAppScenarios() == CArtiGlobal::eAppScenarios::AS_INTERNAL_USE))
		{
			uiMenu.AddItem(artiGetText("FF0000000020"));	// "接口测试";
			//uiMenu.AddItem(artiGetText("FF0F00000000"));	// "多系统诊断"
			uiMenu.AddItem(artiGetText("500000300000"));	// "Ecu测试";
			uiMenu.AddItem(artiGetText("500000400000"));	// 品牌切换		
			uiMenu.AddItem(artiGetText("500000400001"));	// 网关解锁		
		}
		
		while (1)
		{
			uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				return 0;
			}
			uRet &= 0xff;

			// 添加车型路径 [11/28/2022 qunshang.li]
			m_ModelInfo.Clear();
			m_ModelInfo.SetDiagnosisType(uiMenu.GetItem(uRet));
			CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
			// end [11/28/2022 qunshang.li]

			if (uRet == 0)
			{
				Automatic_Selection();
			}
			else if (uRet == 1)
			{
				Manual_Selection();
			}
			else if (uRet == 2)// 添加API测试程序 [2/14/2022 qunshang.li]
			{
				CAPITest apiTest;

				if (0 == apiTest.ShowMenu())
				{
					return 0;
				}
				
			}
			else if (uRet == 3)// 添加API测试程序 [2/14/2022 qunshang.li]
			{
				CEcuTest EcuTest;
				EcuTest.TestEcu();
			}
			else if (uRet == 4)
			{
				ChangeVechile();
				return 0;
			}
			else if (uRet == 5)
			{
				CUnlockGW unlockGw;

				unlockGw.ShowMenu();
				return 0;
			}

			// 添加车型路径 [11/28/2022 qunshang.li]
			m_ModelInfo.SetDiagnosisType("");
			CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
			// end [11/28/2022 qunshang.li]
		}
		return 0;
	}

	void CDemo::Automatic_Selection()
	{
		CArtiInput	uiInput;
		uint32_t	uRet;
		string		strVin;

		while (1)
		{
			uiInput.InitOneInputBox(artiGetText("FFFFFFFF006A"), artiGetText("FFFFFFFF000B"), "VVVVVVVVVVVVVVVVV", strVin);
			uiInput.AddButton(artiGetText("ReadVIN"));
			uRet = uiInput.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}
			else if (uRet == DF_ID_FREEBTN_0)
			{
				// "正在读取VIN..."
				artiShowMsgBox(artiGetText("FFFFFFFF0010"), artiGetText("FFFFFFFF006D"), DF_MB_NOBUTTON);
				Delay(500);
				
				strVin = "1N4BL4BV4NNXXXXXX";
				CArtiGlobal::SetVIN(strVin);
			}
			else
			{
				strVin = uiInput.GetOneInputBox();
				if (strVin.size() != 17)
				{
					artiShowMsgBox(artiGetText("FFFFFFFF000C"), artiGetText("FFFFFFFF000E"), DF_MB_OK);
					continue;
				}
				artiShowMsgBox(artiGetText("FFFFFFFF000C"), artiGetText("FFFFFFFF000D"), DF_MB_NOBUTTON);
				CArtiGlobal::SetVIN(strVin);

				CArtiList		uiVehicle;
				vector<int32_t> vctColWidth;
				bool			bClipEsc = false;

				uiVehicle.InitTitle(artiGetText("FFFFFFFF0080"));
				vctColWidth.push_back(30);
				vctColWidth.push_back(70);
				uiVehicle.SetColWidth(vctColWidth);
				uiVehicle.AddItem("VIN");
				uiVehicle.AddItem(artiGetText("500000020000"));

				uiVehicle.AddItem(artiGetText("500000030000"));
				uiVehicle.AddItem(artiGetText("510000000110"));//车辆型号
				//uiVehicle.AddItem(artiGetText("5100000000E8"));//发动机子类型

				uiVehicle.AddButton(artiGetText("FFFFFFFF0015"));	//是
				uiVehicle.SetItem(0, 1, strVin);
				uiVehicle.SetItem(1, 1, artiGetText("500000020009"));
				uiVehicle.SetItem(2, 1, "2024");
				uiVehicle.SetItem(3, 1, artiGetText("5100000000F6"));
				//uiVehicle.SetItem(4, 1, artiGetText("5100000000F7"));

				while (1)
				{
					uint32_t uRet = uiVehicle.Show();
					if (DF_ID_FREEBTN_0 == uRet)
					{
						break;
					}
					else if (uRet == DF_ID_BACK)
					{
						bClipEsc = true;
						break;
					}
				}
				if (bClipEsc)
				{
					continue;
				}
				CDemo::m_ModelInfo.SetModel(artiGetText("500000020009"));
				CDemo::m_ModelInfo.SetYear("2024");
				CDemo::m_ModelInfo.SetEngineType(artiGetText("5100000000F6"));
				//CDemo::m_ModelInfo.SetEngineSubType(artiGetText("5100000000F7"));
				//将历史记录设给APP
				SetMyHistory();
				SelectDiagType();
				break;
			}
		}
	}

	void CDemo::SelectDiagType()
	{
		vector<uint32_t> vctiAllFunSuport = GetSupportAllFun();
		if (vctiAllFunSuport.size() == 1)
		{
			ShowMainMenu();
#ifndef WIN32
			CArtiGlobal::SetHistoryMileage("20237", "20230");
			CArtiGlobal::SetHistoryMMY("DEMO", CDemo::m_ModelInfo.GetModel(), CDemo::m_ModelInfo.GetYear());
			CArtiGlobal::SetHistoryEngine(CDemo::m_ModelInfo.GetEngineType(), CDemo::m_ModelInfo.GetEngineSubType());
#endif
		}
		else
		{
			CArtiMenu		uiMenu;

			uiMenu.InitTitle(artiGetText("FFFFFFFF0016"));

			uiMenu.AddItem(artiGetText("FFFFFFFF0017"));
			uiMenu.AddItem(artiGetText("FFFFFFFF0019"));

			while (1)
			{
				uint32_t uMenu = uiMenu.Show();
				if (uMenu == DF_ID_BACK)
				{
					break;
				}
				if (uMenu == 1)
				{
					ShowMainMenu();
				}
				else
				{
					CAppLayer applay;
					applay.StartAppLayer();
				}
			}
		}
		return;
	}

	void CDemo::ShowMainMenu()
	{

		CHotFunction hotFunction;
		hotFunction.ShowMainMenu();
		//CArtiGlobal::SetVehInfo(m_ModelInfo.toString());

// 		uint32_t uRetMainMenu = DF_ID_NOKEY;
// 
// 		CArtiMenu uiMainMenu;
// 		uiMainMenu.InitTitle(artiGetText("Text_MainMenu"));
// 		uiMainMenu.AddItem(artiGetText("Text_Diagnostic"));
// 		uiMainMenu.AddItem(artiGetText("500000060100"));
// 
// 		while (1)
// 		{
// 			uRetMainMenu = uiMainMenu.Show();
// 			if (DF_ID_BACK == uRetMainMenu)
// 			{
// 				break;
// 			}
// 			else
// 			{
// 				uRetMainMenu = uRetMainMenu & 0xff;
// 
// 				// 添加车型路径 [11/28/2022 qunshang.li]
// 				m_ModelInfo.SetDiagnosisMenu(uiMainMenu.GetItem(uRetMainMenu));
// 				CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
// 				// end [11/28/2022 qunshang.li]
// 
// 				if (0 == uRetMainMenu)
// 				{
// 					//开启应用层
// 					CAppLayer	appLayer;
// 					appLayer.StartAppLayer();
// 				}
// 				else
// 				{
// 					CHotFunction hotFunction;
// 					hotFunction.ShowMainMenu();
// 				}
// 
// 				// 添加车型路径 [11/28/2022 qunshang.li]
// 				m_ModelInfo.SetDiagnosisMenu("");
// 				CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
// 				// end [11/28/2022 qunshang.li]
// 			}
// 		}

	}

	void CDemo::Manual_Selection()
	{
		CArtiMenu		uiMenu;
		char			chvalue[10];

		uiMenu.InitTitle(artiGetText("500000020000"));
		for (uint32_t i = 1; i <= 0x50; i++)
		{
			string	strVehText;

			strVehText = "5000000200";
			snprintf(chvalue, sizeof(chvalue), "%02X", i);
			strVehText += chvalue;
			uiMenu.AddItem(artiGetText(strVehText));
		}
		while (1)
		{
			uint32_t iRet = uiMenu.Show();
			if (iRet == DF_ID_BACK)
			{

				break;
			}

			m_ModelInfo.SetModel(uiMenu.GetItem(iRet));
			CArtiGlobal::SetVehInfo(m_ModelInfo.toString());

			CArtiMenu uiMenuYear;

			uiMenuYear.InitTitle(artiGetText("500000030000"));

			for (uint32_t i = 1; i < 0x1B; i++)
			{
				string	strVehText;

				strVehText = "5000000300";
				snprintf(chvalue, sizeof(chvalue), "%02X", i);
				strVehText += chvalue;
				uiMenuYear.AddItem(artiGetText(strVehText));
			}
			while (1)
			{
				uint32_t iRetYear = uiMenuYear.Show();
				if (iRetYear == DF_ID_BACK)
				{
					break;
				}
				CArtiList		uiVehicle;
				vector<int32_t> vctColWidth;
				string			strVIN;
				uint32_t		iSet = 0;

				uiVehicle.InitTitle(artiGetText("Confirm_vehicle_profile"));
				vctColWidth.push_back(30);
				vctColWidth.push_back(70);
				uiVehicle.SetColWidth(vctColWidth);
				strVIN = CArtiGlobal::GetVIN();
				if (strVIN.size())
				{
					uiVehicle.AddItem("VIN");
					iSet = 1;
				}
				uiVehicle.AddItem(artiGetText("500000020000"));
				uiVehicle.AddItem(artiGetText("500000030000"));
				uiVehicle.AddItem(artiGetText("510000000110"));

				uiVehicle.AddButton(artiGetText("FFFFFFFF0015"));	//确定
				if (strVIN.size())
				{
					uiVehicle.SetItem(0, 1, strVIN);
				}
				uiVehicle.SetItem(0 + iSet, 1, uiMenu.GetItem(iRet));
				uiVehicle.SetItem(1 + iSet, 1, uiMenuYear.GetItem(iRetYear & 0xff));
				uiVehicle.SetItem(2 + iSet, 1, artiGetText("5100000000F6"));

				while (1)
				{
					uint32_t uRet = uiVehicle.Show();
					if (DF_ID_FREEBTN_0 == uRet)
					{
						break;
					}
					if (DF_ID_BACK == uRet)
					{
						return;
					}
				}
				m_ModelInfo.SetEngineType(artiGetText("5100000000F6"));
				m_ModelInfo.SetYear(uiMenuYear.GetItem(iRetYear &0xff));
				CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
				//将历史记录设给APP
				SetMyHistory();
				SelectDiagType();
				m_ModelInfo.SetYear("");
				CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
			}
			m_ModelInfo.SetModel("");
			CArtiGlobal::SetVehInfo(m_ModelInfo.toString());
		}
	}

	void CDemo::SetMyHistory()
	{
		string	strHistoryRecord;

		strHistoryRecord = m_ModelInfo.GetDiagType();
		strHistoryRecord += "@";
		strHistoryRecord += CArtiGlobal::GetVIN();//VIN
		strHistoryRecord += "@";
		strHistoryRecord += m_ModelInfo.GetModel();
		strHistoryRecord += "@";
		strHistoryRecord += m_ModelInfo.GetYear();
		strHistoryRecord += "@";
		strHistoryRecord += m_ModelInfo.GetEngineType();
// 		strHistoryRecord += "@";
// 		strHistoryRecord += m_ModelInfo.GetEngineSubType();
		CArtiGlobal::SetHistoryRecord(strHistoryRecord);
	}

	void CDemo::ChangeVechile()
	{
		vector<string>	vctstrVehicle;
		CArtiInput		uiInput;
		vector<string>	vctstr5VINVeh{"VIN","Vehicle"};
		vector<string>	vctstrMask{ "VVVVVVVVVVVVVVVVV","*****************" };
		vector<string>	vctInputValue;
		uiInput.InitManyInputBox(artiGetText("500000400000"), vctstr5VINVeh, vctstrMask);

		while (1)
		{
			uint32_t uRet = uiInput.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}
			vctInputValue = uiInput.GetManyInputBox();
			if ((vctInputValue.size()>1) && (vctInputValue[0].size()==17) && (vctInputValue[1].size()>1))
			{
				break;
			}
			else
			{
				artiShowMsgBox("error", "please input again");
			}
		}
		CArtiGlobal::SetCurVehNotSupport(VBST_VEH_NOT_SUPPORT);
		CArtiGlobal::SetVIN(vctInputValue[0]);
		vctstrVehicle.push_back(String2Upper(vctInputValue[1]));
		CArtiGlobal::SetVehicle(vctstrVehicle);

	}
}

