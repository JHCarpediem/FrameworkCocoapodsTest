#include "DemoHotFunction.h"
#include "ArtiMenu.h"
#include "StdShowMaco.h"
#include "DemoPublicAPI.h"
#include "ArtiMsgBox.h"
#include "DataFile.h"
#include "ArtiGlobal.h"
#include "DemoMaco.h"
#include "ArtiInput.h"
#include "DiagEntryType.h"



namespace Topdon_AD900_Demo {

	void CHotFunction::ShowMainMenu()
	{
		CArtiMenu uiMenu;
		uiMenu.InitTitle(artiGetText("500000060100"));

		vector<string> vctText;
		vector<uint32_t> vctiFun;

		vector<uint32_t> vctiType = GetSupportHotFun();

		for (uint32_t i=0; i<vctiType.size(); i++)
		{
			string	strText = mapeDiagEntryType[(eDiagEntryTypeEx)vctiType[i]];
			if (strText.empty())
			{
				continue;
			}
			vctText.push_back(strText);
			vctiFun.push_back(vctiType[i]);
		}


		if (!vctText.size())
		{
 			artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200004"), DF_MB_OK, DT_LEFT, -1);
 			return;
		}

		for (string strTemp : vctText)
		{
			uiMenu.AddItem(strTemp);
		}
				
		uint32_t uRetMenu = DF_ID_NOKEY;
		while (1)
		{
			uRetMenu = uiMenu.Show();
			if (uRetMenu == DF_ID_BACK)
			{
				break;
			}
			else
			{
				SpFunMask(vctText[uRetMenu & 0xff], vctiFun[uRetMenu & 0xff]);
			}
		}
	}

	void CHotFunction::SpFunMask(string strtile,uint32_t uMak)
	{
		switch (uMak)
		{
		case eDiagEntryTypeEx::DETE_OIL_RESET_POS:
			OilRest();
			break;
		case eDiagEntryTypeEx::DETE_THROTTLE_ADAPTATION_POS:
			ThrottleAdaptation();
			break;
		case eDiagEntryTypeEx::DETE_EPB_RESET_POS:
			EPBRest(strtile);
			break;
		case eDiagEntryTypeEx::DETE_ABS_BLEEDING_POS:
			ABSBleed(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_STEERING_ANGLE_RESET_POS:
			SteeringAngleReset();
			break;
		case eDiagEntryTypeEx::DEFE_DPF_REGENERATION_POS://DPF
		case eDiagEntryTypeEx::DEFE_EXHAUST_PROCESSING_POS://尾气后处理	
			DPFReset();
			break;
		case eDiagEntryTypeEx::DEFE_AIRBAG_RESET_POS:
			SRSReset();
			break;
		case eDiagEntryTypeEx::DEFE_BMS_RESET_POS:
			BMSReset();
			break;
		case eDiagEntryTypeEx::DEFE_ADAS_POS:
			ADASReset();
			break;
		case eDiagEntryTypeEx::DEFE_IMMO_POS:
			IMMOMatch(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_SMART_KEY_POS:
			SmartKeyMatch(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_PASSWORD_READING_POS:
			PasswordReading();
			break;
		case eDiagEntryTypeEx::DEFE_INJECTOR_CODE_POS:
			InjectorCode(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_SUSPENSION_POS:
			Suspension(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_TIRE_PRESSURE_POS:
			TirePressure(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_TRANSMISSION_POS:
			TransMatch(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_GEARBOX_LEARNING_POS:
			GearboxLearning(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_TRANSPORT_MODE_POS:
			TransportMode(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_HEAD_LIGHT_POS:
			AFSReset(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_SUNROOF_INIT_POS:
			SunroofInit(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_SEAT_CALI_POS:
			SeatCali(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_WINDOW_CALI_POS:
			WindowCali(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_START_STOP_POS:
			StartStop(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_EGR_POS:
			EGRTest(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_ODOMETER_POS:
			OdometerCali(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_LANGUAGE_POS:
			SetLanguage(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_TIRE_MODIFIED_POS:
			TireModify(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_A_F_ADJ_POS:
			A_F_Adj(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_ELECTRONIC_PUMP_POS:
			ElectronicPump(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_NOx_RESET_POS:
			NoxReset(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_UREA_RESET_POS:
			AdBlueReset(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_TURBINE_LEARNING_POS:
			TurbineLearning(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_CYLINDER_POS:
			Cylinder(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_EEPROM_POS:
			Eeprom(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_RFID_POS:
			RFID(strtile);
			break;
		case eDiagEntryTypeEx::DETE_SPEC_FUNC_POS:
			SpecialFunTest(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_CLUTCH_POS:
			ClutchMatch(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_SPEED_PTO_POS:
			SpeedAndPTO(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_FRM_RESET_POS:
			FrmReset(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_VIN_POS:
			WriteVIN(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_HV_BATTERY_POS:
			HV_BATTERY(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_ACC_POS:
			ACCReset(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_AC_LEARNING_POS:
			ACLearn(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_RAIN_LIGHT_SENSOR_POS:
			RainLightSensor(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_RESET_CONTROL_UNIT_POS:
			ControlUnitReset(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_CSS_ACC_POS:
			CSS_ACC(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_RELATIVE_COMPRESSION_POS:
			RelativeCompression(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_HV_DE_ENERGIZATION_POS:
			HVPoActi(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_COOLANT_REFRIGERANT_CHANGE_POS:
			CoolantChange(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_RESOLVER_SENSOR_CALIBRATION_POS:
			ResolverSenCali(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_CAMSHAFT_LEARNING_POS:
			CamshaftLearn(strtile);
			break;
		case eDiagEntryTypeEx::DEFE_VIN_ODOMETER_CHECK_POS:
			VINODOCheck(strtile);
			break;
		default:
			break;
		}

	}
	void CHotFunction::OilRest()
	{
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);

	}

	void CHotFunction::ThrottleAdaptation()
	{
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200012"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(3000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);

	}

	void CHotFunction::EPBRest(string strTile)
	{
		CArtiMenu	uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("5000000A0035"));
		uiMenu.AddItem(artiGetText("5000000A0036"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet==DF_ID_BACK)
			{
				return;
			}
			if (0 == (uRet&0xff) )
			{
				artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200013"), DF_MB_OK);
			}
			else if (1 == (uRet & 0xff))
			{
				artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200014"), DF_MB_OK);
			}
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

			Delay(3000);
			   
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		}
	}

	void CHotFunction::ABSBleed(string strTile)
	{
		CArtiMenu	uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("500000200015"));
		uiMenu.AddItem(artiGetText("500000200016"));
		uiMenu.AddItem(artiGetText("500000200017"));
		uiMenu.AddItem(artiGetText("500000200018"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}

			artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200019"), DF_MB_OK);
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
			Delay(3000);
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020001A"), DF_MB_OK);
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
			Delay(4000);
			CBinary		binText("\x50\x00\x00\x20\x00\x1B", 6);
			binText.SetAt(5, binText[5] + (uRet & 0xff));

			int64_t uTime = GetSysTime();
			CArtiMsgBox	uiBox;

			uiBox.InitMsgBox(artiGetText("500000200000"), artiGetText(Binary2HexString(binText)), DF_MB_FREE | DF_MB_NONBLOCK);
			uiBox.AddButton(artiGetText("500000200020"));
			uiBox.SetBusyVisible(true);
			while (1)
			{
				uint32_t uBoxBtn = uiBox.Show();
				if (uBoxBtn == DF_ID_FREEBTN_0)
				{
					artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020001F"), DF_MB_OK);
					break;
				}
				if (uTime + 10000 <= GetSysTime())
				{
					artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
					break;
				}
			}
		}
	}

	void CHotFunction::SteeringAngleReset()
	{
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200021"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::DPFReset()
	{
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200022"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("Communicating"), DF_MB_NOBUTTON);
		Delay(1000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200023"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("Communicating"), DF_MB_NOBUTTON);
		Delay(1000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200024"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200025"), DF_MB_NOBUTTON);
		Delay(6000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200026"), DF_MB_OK);
		return;
	}

	void CHotFunction::SRSReset()
	{
// 		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);

	}

	void CHotFunction::BMSReset()
	{
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200027"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
	}

	void CHotFunction::ADASReset()
	{
		CArtiMsgBox	uiBox;

		uiBox.InitMsgBox(artiGetText("500000200028"), artiGetText("500000200029"), DF_MB_FREE | DF_MB_BLOCK);
		uiBox.AddButton(artiGetText("500000100035"));
		uiBox.Show();

		uiBox.InitMsgBox(artiGetText("500000200028"), artiGetText("50000020002A"), DF_MB_FREE | DF_MB_BLOCK);
		uiBox.AddButton(artiGetText("500000100035"));
		uiBox.Show();

		uiBox.InitMsgBox(artiGetText("500000200028"), artiGetText("50000020002B"), DF_MB_FREE | DF_MB_BLOCK);
		uiBox.AddButton(artiGetText("500000100035"));
		uiBox.Show();

		uiBox.InitMsgBox(artiGetText("500000200028"), artiGetText("50000020002C"), DF_MB_FREE | DF_MB_BLOCK);
		uiBox.AddButton(artiGetText("500000100035"));
		uiBox.Show();

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020002D"), DF_MB_NOBUTTON);
		Delay(5000);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020002E"), DF_MB_OK);
		return;
	}

	void CHotFunction::SmartKeyMatch(string strTile)
	{
		CArtiMenu	uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("50000020002F"));
		uiMenu.AddItem(artiGetText("500000200030"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}
			if ((uRet&0xff) == 0)
			{
				artiShowMsgBox(uiMenu.GetItem(uRet&0xff), artiGetText("500000200031"), DF_MB_OK);
				artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
				Delay(5000);
				artiShowMsgBox(uiMenu.GetItem(uRet & 0xff), artiGetText("500000200003"), DF_MB_OK);
			}
			else
			{
				CArtiActive uiAct;

				uiAct.InitTitle(uiMenu.GetItem(uRet & 0xff));
				uiAct.SetOperationTipsOnTop(artiGetText("500000200032"));
				uiAct.AddItem(uiMenu.GetItem(uRet & 0xff), artiGetText("50000020000C"));
				uiAct.AddButton(artiGetText("500000200033"));
				uiAct.AddButton(artiGetText("500000200034"));
				uiAct.AddButton(artiGetText("500000200035"));
				uiAct.AddButton(artiGetText("500000200036"));
				uiAct.AddButton(artiGetText("500000200037"));
				while (1)
				{
					uint32_t uAct = uiAct.Show();
					if (uAct == DF_ID_BACK)
					{
						break;
					}
					if (uAct != DF_ID_NOKEY)
					{
						uiAct.SetValue(0, artiGetText("500000200038"));
						uiAct.Show();
						Delay(2000);
						uiAct.SetValue(0, artiGetText("ClearSuc"));
					}
				}
			}
		}
		return;
	}

	void CHotFunction::IMMOMatch(string strTile)
	{
		CArtiMenu	uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("500000200043"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}
			if ((uRet & 0xff) == 0)
			{
				CArtiInput uiInput;

				uiInput.InitOneInputBox(artiGetText("500000200043"), artiGetText("500000200039"), "FFFFFF", "123456");
				uint32_t uValue = uiInput.Show();
				if (uValue==DF_ID_BACK)
				{
					continue;
				}
				uint8_t uKey = 0;
				while (1)
				{
					CBinary	binKey("\x50\x00\x00\x20\x00\x3A", 6);

					binKey.SetAt(5, 0x3a + uKey*2);
					if (DF_ID_NO == artiShowMsgBox(artiGetText("500000200000"), artiGetText(Binary2HexString(binKey)), DF_MB_YESNO))
					{
						artiShowMsgBox(uiMenu.GetItem(uRet & 0xff), artiGetText("500000200044"), DF_MB_OK);
						break;
					}
					
					artiShowMsgBox(artiGetText("500000200000"), artiGetText("Communicating"), DF_MB_NOBUTTON);
					Delay(1500);
					binKey.SetAt(5, 0x3a + uKey*2+1);
					if (DF_ID_CANCEL == artiShowMsgBox(artiGetText("500000200000"), artiGetText(Binary2HexString(binKey)), DF_MB_OKCANCEL))
					{
						artiShowMsgBox(uiMenu.GetItem(uRet & 0xff), artiGetText("500000200044"), DF_MB_OK);
						break;
					}


					if ((uKey++)>=3)
					{
						artiShowMsgBox(uiMenu.GetItem(uRet & 0xff), artiGetText("500000200044"), DF_MB_OK);
						break;
					}
					else
					{
						if (DF_ID_CANCEL == artiShowMsgBox(uiMenu.GetItem(uRet & 0xff), artiGetText("500000200042"), DF_MB_OKCANCEL))
						{
							artiShowMsgBox(uiMenu.GetItem(uRet & 0xff), artiGetText("500000200044"), DF_MB_OK);
							break;
						}
					}
				}
			}
		}
		return;
	}

	void CHotFunction::PasswordReading()
	{
		// 		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);

	}

	void CHotFunction::InjectorCode(string strTile)
	{
		CArtiInput uiInput;
		vector<string> vctTips;
		vector<string> vctMasks;
		vector<string> vctDefaults;

		artiShowMsgBox(strTile, artiGetText("500000200045"), DF_MB_OK);

		for (uint32_t i=0; i<4; i++)
		{
			CBinary	binText("\x50\x00\x00\x20\x00\x46", 6);

			binText.SetAt(5, 0x46 + i);
			vctTips.push_back(artiGetText(binText));
			vctMasks.push_back("FFFFFFF");
		}
		vctDefaults.push_back("2236471");
		vctDefaults.push_back("2236472");
		vctDefaults.push_back("2236473");
		vctDefaults.push_back("2236474");
		
		uiInput.InitManyInputBox(strTile, vctTips, vctMasks, vctDefaults);
		while (1)
		{
			uint32_t iRet = uiInput.Show();
			if (iRet == DF_ID_BACK)
			{
				break;
			}
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
			Delay(2000);
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
			break;
		}
		return;
	}

	void CHotFunction::Suspension(string strTile)
	{
		CArtiMenu	uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("50000020004C"));
		uiMenu.AddItem(artiGetText("50000020004D"));
		uiMenu.AddItem(artiGetText("50000020004E"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			uRet = uRet & 0xff;
			if (uRet == 0)
			{
				artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020004B"), DF_MB_OK);
			}
			else
			{
				artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020004A"), DF_MB_OK);
			}
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
			Delay(2500);
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		}
		return;
	}

	void CHotFunction::TirePressure(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("50000020004F"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::TransMatch(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200050"), DF_MB_OK);
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::GearboxLearning(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200051"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::TransportMode(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200051"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::AFSReset(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200051"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::SunroofInit(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200051"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::SeatCali(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200052"), DF_MB_OK);
		artiShowMsgBox(strTile, artiGetText("500000200053"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200054"), DF_MB_OK);
		return;
	}

	void CHotFunction::WindowCali(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200055"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::StartStop(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("50000020000D"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200003"), DF_MB_OK);
		return;
	}

	void CHotFunction::EGRTest(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200056"), DF_MB_OK);
		artiShowMsgBox(strTile, artiGetText("500000200057"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200058"), DF_MB_OK);
		return;
	}

	void CHotFunction::OdometerCali(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200059"), DF_MB_OK);
		artiShowMsgBox(strTile, artiGetText("50000020005A"), DF_MB_OK);
		CArtiInput uiInput;

		uiInput.InitOneInputBox(strTile, artiGetText("50000020007F"), "0000000");
		if (uiInput.Show() == DF_ID_CANCEL)
		{
			return;
		}
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020005B"), DF_MB_OK);
		return;
	}

	void CHotFunction::SetLanguage(string strTile)
	{
		CArtiInput  uiInput;
		vector<string> vecstrLang;

		vecstrLang.push_back(artiGetText("50000020005D"));
		vecstrLang.push_back(artiGetText("50000020005E"));
		vecstrLang.push_back(artiGetText("50000020005F"));
		vecstrLang.push_back(artiGetText("500000200060"));
		vecstrLang.push_back(artiGetText("500000200061"));

		uiInput.InitOneComboBox(strTile, artiGetText("50000020005C"), vecstrLang, artiGetText("50000020005D"));
		
		if (uiInput.Show() == DF_ID_BACK)
		{
			return;
		}
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::TireModify(string strTile)
	{
		CArtiInput  uiInput;
		vector<string> vecstrSize;

		vecstrSize.push_back(artiGetText("500000200063"));
		vecstrSize.push_back(artiGetText("500000200064"));
		vecstrSize.push_back(artiGetText("500000200065"));
		vecstrSize.push_back(artiGetText("500000200066"));

		uiInput.InitOneComboBox(strTile, artiGetText("500000200062"), vecstrSize, artiGetText("500000200065"));

		if (uiInput.Show() == DF_ID_BACK)
		{
			return;
		}
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::A_F_Adj(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200067"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::ElectronicPump(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200068"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
		Delay(1500);
		artiShowMsgBox(strTile, artiGetText("50000020006A"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
		Delay(3000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200069"), DF_MB_OK);
		return;
	}

	void CHotFunction::NoxReset(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200080"), DF_MB_OK);
		artiShowMsgBox(strTile, artiGetText("500000200081"), DF_MB_OK);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200082"), DF_MB_NOBUTTON);

		Delay(8000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200083"), DF_MB_OK);
		return;
	}

	void CHotFunction::AdBlueReset(string strTile)
	{
		CArtiMenu uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("500000200084"));
		uiMenu.AddItem(artiGetText("500000200085"));
		uiMenu.AddItem(artiGetText("500000200086"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);
			Delay(2000);
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);

		}
		return;
	}

	void CHotFunction::TurbineLearning(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("50000020006B"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(3000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020006C"), DF_MB_OK);
		return;
	}

	void CHotFunction::Cylinder(string strTile)
	{
		CArtiList uiList;
		vector<int32_t> vctColWidth;
		vector<string> vctHeadNames;

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(1500);

		uiList.InitTitle(strTile);
		vctColWidth.push_back(40);
		vctColWidth.push_back(12);
		vctColWidth.push_back(12);
		vctColWidth.push_back(12);
		vctColWidth.push_back(12);
		vctColWidth.push_back(12);

		string str = artiGetText("50000020008F");
		vctHeadNames.push_back(str);
		vctHeadNames.push_back(artiGetText("500000200090"));
		vctHeadNames.push_back(artiGetText("500000200091"));
		vctHeadNames.push_back(artiGetText("500000200092"));
		vctHeadNames.push_back(artiGetText("500000200093"));
		vctHeadNames.push_back(artiGetText("500000200094"));

		uiList.SetColWidth(vctColWidth);
		uiList.SetHeads(vctHeadNames);

 		for (uint8_t i=0; i<8; i++)
 		{
 			vector<string> vctTemp;
 			CBinary	binTemp("\x50\x00\x00\x20\x00\x87", 6);
 
 			binTemp.SetAt(5, binTemp[5]+i);
 			vctTemp.push_back(artiGetText(binTemp));//description
 			vctTemp.push_back("0");//Min
 			vctTemp.push_back("65535");//Max
 			if (i==2 || i==5)
 			{
 				if (i == 2)
 				{
 					vctTemp.push_back("-5");//当前值
 				}
 				else
 				{
 					vctTemp.push_back("75623");//当前值
 				}
 			}
 			else
 			{
 				vctTemp.push_back("0");//当前值
 			}
 			vctTemp.push_back(artiGetText("500000200095"));//单位
 			if (i == 2 || i == 5)
 			{
 				vctTemp.push_back(artiGetText("500000300103"));//失败
 			}
 			else
 			{
 				vctTemp.push_back(artiGetText("50000010000E"));//正常
 			}
 			uiList.AddItem(vctTemp);
 		}
		while (1)
		{
			uint32_t uRet = uiList.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
		}
		return;
	}

	void CHotFunction::Eeprom(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200067"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::RFID(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200067"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::SpecialFunTest(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200067"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::ClutchMatch(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::SpeedAndPTO(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200067"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::FrmReset(string strTile)
	{
		//artiShowMsgBox(strTile, artiGetText("500000200067"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::WriteVIN(string strTile)
	{
		CArtiInput uiInputVIN1;
		CArtiInput uiInputVIN2;
		string     strVIN1;
		string     strVIN2;

		artiShowMsgBox(strTile, artiGetText("50000020006D"), DF_MB_OK);
		
		uiInputVIN1.InitOneInputBox(strTile, artiGetText("50000020006E"), "VVVVVVVVVVVVVVVVV", "1N4BL4BV4NNXXXXXX");
		uiInputVIN2.InitOneInputBox(strTile, artiGetText("50000020006F"), "VVVVVVVVVVVVVVVVV", "1N4BL4BV4NNXXXXXX");

		while (1)
		{
			while (1)
			{
				uint32_t uRet1 = uiInputVIN1.Show();
				if (uRet1 == DF_ID_CANCEL)
				{
					return;
				}
				strVIN1 = uiInputVIN1.GetOneInputBox();
				break;
			}

			while (1)
			{
				uint32_t uRet1 = uiInputVIN2.Show();
				if (uRet1 == DF_ID_CANCEL)
				{
					return;
				}
				strVIN2 = uiInputVIN2.GetOneInputBox();
				break;
			}
			if (strVIN1 != strVIN2)
			{
				artiShowMsgBox(strTile, artiGetText("500000200070"), DF_MB_OK);
				continue;
			}
			else
			{
				break;
			}
		}



		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200071"), DF_MB_OK);
		return;
	}

	void CHotFunction::HV_BATTERY(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200072"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200073"), DF_MB_OK);
		return;
	}

	void CHotFunction::ACCReset(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200074"), DF_MB_OK);
		artiShowMsgBox(strTile, artiGetText("500000200075"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("500000200076"), DF_MB_OK);
		return;
	}

	void CHotFunction::ACLearn(string strTile)
	{
		CArtiMenu uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("500000200077"));
		uiMenu.AddItem(artiGetText("500000200078"));
		uiMenu.AddItem(artiGetText("500000200079"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}
			if ((uRet&0xff) == 0)
			{
				artiShowMsgBox(strTile, artiGetText("50000020007A"), DF_MB_OK);
			}
			else if ((uRet & 0xff) == 1)
			{
				artiShowMsgBox(strTile, artiGetText("50000020007B"), DF_MB_OK);
			}
			else
			{
				artiShowMsgBox(strTile, artiGetText("50000020007C"), DF_MB_OK);
			}
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

			Delay(2000);

			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		}
		return;
	}

	void CHotFunction::RainLightSensor(string strTile)
	{
		CArtiMenu uiMenu;

		uiMenu.InitTitle(strTile);
		uiMenu.AddItem(artiGetText("50000020007D"));
		uiMenu.AddItem(artiGetText("50000020007E"));

		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				return;
			}
			CArtiInput uiinput;

			uiinput.InitOneComboBox(uiMenu.GetItem(uRet & 0xff), uiMenu.GetItem(uRet & 0xff), vector<string>{"0", "1", "2", "3", "4"}, "2");
			uint32_t uinput = uiinput.Show();
			if (uinput == DF_ID_BACK)
			{
				continue;
			}
			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

			Delay(2000);

			artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		}
		return;
	}

	void CHotFunction::ControlUnitReset(string strTile)
	{
// 		artiShowMsgBox(strTile, artiGetText("500000200074"), DF_MB_OK);
 		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::CSS_ACC(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::RelativeCompression(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::HVPoActi(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::ResolverSenCali(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::CoolantChange(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::CamshaftLearn(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

	void CHotFunction::VINODOCheck(string strTile)
	{
		artiShowMsgBox(strTile, artiGetText("500000200008"), DF_MB_OK);
		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000E"), DF_MB_NOBUTTON);

		Delay(2000);

		artiShowMsgBox(artiGetText("500000200000"), artiGetText("50000020000A"), DF_MB_OK);
		return;
	}

}