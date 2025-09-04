#include "DemoAPITest.h"
#include "DemoAppLayer.h"

#include "Binary.h"
#include "DataFile.h"
#include "Mathematics.h"
#include "ProFile.h"
#include "PublicInterface.h"
#include "ArtiGlobal.h"
#include <chrono>
#include <thread>
#include <iostream>
#include "DemoMulitSysInfo.h"
#include "DemoPublicAPI.h"
#include "Tprog.h"
#include "DemoArtiReportTest.h"
#include "DemoArtiActiveTest.h"
#include "DemoArtiEcuInfoTest.h"
#include "DemoArtiWebTest.h"
#include "DemoArtiTroubleTest.h"
#include "DemoArtiSystemTest.h"
#include "DemoArtiMsgBoxTest.h"
#include "DemoArtiFileDialogTest.h"
#include "DemoArtiFreezeTest.h"
#include "DemoArtiGlobalTest.h"
#include "DemoArtiInputTest.h"
#include "DemoArtiListTest.h"
#include "DemoArtiLiveDataTest.h"
#include "DemoArtiMenuTest.h"
#include "DemoImmoTest.h"
#include "DemoArtiMiniMsgBoxTest.h"
#include "DemoArtiPopupTest.h"
#include "ArtiCoilReader.h"
#include "ArtiFreqWave.h"
#include "DemoArtiCoilReaderTest.h"
#include "DemoArtiFreqWaveTest.h"
#include "DemoMaco.h"
#include "DemoArtiPictureTest.h"
#include "Expression.h"
#include "DemoArtiFloatMiniTest.h"
#include "DemoVehAutoAuthTest.h"
#include "DiagEntryType.h"

namespace Topdon_AD900_Demo {

	using namespace std;

	void MultiSysTest()
	{
#if __Multi_System_Test__
		/*	  系统列表
		*  "01 - 发动机电控系统"
		*  "02 - 变速箱电子装置"
		*  "03 - 制动电子装置"
		*  "04 - 转向角传感器"
		*  "05 - 进入及其起动许可"
		*  ....
		*/

		vector<string> vctSysName;
		vector<uint8_t> vctSysId;

		vctSysName.push_back(artiGetText("51FF00000001")/*"01 - 发动机电控系统"*/);		vctSysId.push_back(0x01);
		vctSysName.push_back(artiGetText("51FF00000002")/*"02 - 变速箱电子装置"*/);		vctSysId.push_back(0x02);
		vctSysName.push_back(artiGetText("51FF00000003")/*"03 - 制动电子装置"*/);		vctSysId.push_back(0x03);
		vctSysName.push_back(artiGetText("51FF00000004")/*"04 - 转向角传感器"*/);		vctSysId.push_back(0x04);
		vctSysName.push_back(artiGetText("51FF00000005")/*"05 - 进入及其起动许可"*/);	vctSysId.push_back(0x05);

		vctSysName.push_back(artiGetText("FF0000000020")/*"接口测试"*/);				vctSysId.push_back(0xF1);
		vctSysName.push_back(artiGetText("FF0000000020")/*"接口测试"*/);				vctSysId.push_back(0xF2);
		vctSysName.push_back(artiGetText("FF0000000020")/*"接口测试"*/);				vctSysId.push_back(0xF3);
		vctSysName.push_back(artiGetText("FF0000000020")/*"接口测试"*/);				vctSysId.push_back(0xF4);
		vctSysName.push_back(artiGetText("FF0000000020")/*"接口测试"*/);				vctSysId.push_back(0xF5);

		vector<int32_t> vctColWidth;
		vctColWidth.push_back(100);

		CArtiSystem uiSystem;
		uiSystem.InitTitle(artiGetText("FF0B00000001"));//系统列表
		for (uint32_t i = 0; i < vctSysName.size(); i++)
		{
			uiSystem.AddItem(vctSysName[i]);
		}
		uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);

		uint32_t uRetBtn = DF_ID_SYS_NOKEY;

		CMulitSysInfo* ptrMulitSysInfo = nullptr;
		while (1)
		{
			uRetBtn = uiSystem.Show();
			Delay(100);

			if (DF_ID_SYS_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_SYS_START == uRetBtn)
			{
				uiSystem.SetScanStatus(DF_SYS_SCAN_START);
				ShowMsgBoxDemo(artiGetText("FF0F00000000"), artiGetText("FF0F0000000D"), DF_MB_OK, DT_CENTER, 2000, m_uThread);
				uiSystem.SetScanStatus(DF_SYS_SCAN_FINISH);
			}
			else if (DF_ID_SYS_STOP == uRetBtn)
			{
				uiSystem.SetScanStatus(DF_SYS_SCAN_PAUSE);
			}
			else if (DF_ID_SYS_ERASE == uRetBtn)
			{
				uiSystem.SetClearStatus(DF_SYS_CLEAR_START);
				ShowMsgBoxDemo(artiGetText("FF0F00000000"), artiGetText("FF0B0000000F"), DF_MB_OK, DT_CENTER, 2000, m_uThread);
				uiSystem.SetClearStatus(DF_SYS_CLEAR_FINISH);
			}
			else if (DF_ID_SYS_REPORT == uRetBtn)
			{
				ShowMsgBoxDemo(artiGetText("FF0F00000000"), artiGetText("FF0B00000018"), DF_MB_OK, DT_CENTER, 2000, m_uThread);
			}
			else if (DF_ID_SYS_HELP == uRetBtn)
			{
				ShowMsgBoxDemo(artiGetText("FF0F00000000"), artiGetText("FF0B00000019"), DF_MB_OK, DT_CENTER, 2000, m_uThread);
			}
			else if (uRetBtn < vctSysName.size())//单系统诊断
			{
				if ((vctSysId[uRetBtn] & 0xF0))//接口测试
				{
					MultiStdAPITest(0);
				}
				else//系统测试
				{
					uint8_t uSysID = vctSysId[uRetBtn];
					string strSysName = vctSysName[uRetBtn];
					string strProtocol = CAppLayer::SelectSysProtocol(uSysID);
					if (strProtocol.empty())
					{
						continue;
					}

					CEnterSys* enterSys = new CEnterSys(uSysID, strProtocol);
					enterSys->InitProtocol();

					CAppLayer* prtAppLayer = new CAppLayer();
					prtAppLayer->SetEnterSys(*enterSys);
					prtAppLayer->ShowSysFuncMenu();
				}
			}
			else if (uRetBtn & DF_ID_SYS_TH_MASK)//多系统诊断
			{
				ptrMulitSysInfo = new CMulitSysInfo();

				if (((uRetBtn & 0xFF) < vctSysId.size()) && (vctSysId[uRetBtn & 0xFF] & 0xF0))//接口测试
				{
					ptrMulitSysInfo->SetType("APITEST");

					CAPITest* ptrApiTest = new CAPITest(DF_SYS_GET_TH_NO(uRetBtn));
					ptrMulitSysInfo->SetApiTest(ptrApiTest);

					CArtiGlobal::SetThreadVehiInfo(DF_SYS_GET_TH_NO(uRetBtn), ptrMulitSysInfo);
				}
				else//系统测试
				{
					ptrMulitSysInfo->SetType("APPLAYER");

					uint8_t uSysID = vctSysId[uRetBtn & 0xFF];
					string strSysName = vctSysName[uRetBtn & 0xFF];

					//string strProtocol = CAppLayer::SelectSysProtocol(uSysID, DF_SYS_GET_TH_NO(uRetBtn));
					CEnterSys* enterSys = new CEnterSys(uSysID, "UDS");
					//CEnterSys* enterSys = new CEnterSys(uSysID, strProtocol);
					enterSys->InitProtocol();

					CAppLayer* prtAppLayer = new CAppLayer();
					prtAppLayer->SetEnterSys(*enterSys);
					ptrMulitSysInfo->SetAppLayer(prtAppLayer);

					CArtiGlobal::SetThreadVehiInfo(DF_SYS_GET_TH_NO(uRetBtn), ptrMulitSysInfo);
				}
			}
			else if (DF_ID_SYS_NOKEY != uRetBtn)
			{

			}
		}
#endif
	}

	void MultiStdAPITest(uint32_t uThread /*= 0*/)
	{
		CAPITest apiTest(uThread);
		apiTest.ShowMenu();
	}

	uint8_t CAPITest::ShowMenu()
	{
		/*
		* 接口测试
		* 1.显示接口测试
		* 2.通讯接口测试
		*/
		vector<uint32_t> vctBtn;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000020"));
		uiMenu.AddItem(artiGetText("FF0000000021"));		vctBtn.push_back(1);//显示接口测试
		uiMenu.AddItem(artiGetText("FF0000000022"));		vctBtn.push_back(2);//通讯接口测试
		uiMenu.AddItem(artiGetText("FF00000000CA"));		vctBtn.push_back(3);//显示平板信息

#if __Multi_System_Test__
		uiMenu.AddItem(artiGetText("FF0F00000000"));		vctBtn.push_back(4);//多系统诊断
#endif

		uiMenu.AddItem(artiGetText("FF0F00000010"));		vctBtn.push_back(5);//蓝牙与VCI通讯测试
		uiMenu.AddItem(artiGetText("FF0F00000030"));		vctBtn.push_back(6);//公英制转换测试（数据流组件）
		uiMenu.AddItem(artiGetText("FF1000000000"));		vctBtn.push_back(7);//锁匠算法测试
		uiMenu.AddItem(artiGetText("FF1000000002"));		vctBtn.push_back(8);//APP崩溃测试
		uiMenu.AddItem(artiGetText("FF1000000003"));		vctBtn.push_back(9);//公英制转换测试（非数据流组件）
		uiMenu.AddItem(artiGetText("FF1000000004"));		vctBtn.push_back(10);//数据流刷新测试

		uint8_t		uExit = 1;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			else if (uRetBtn < vctBtn.size())
			{
				if (1 == vctBtn[uRetBtn])
				{
					uExit = ShowTest();
					if (uExit==0)
					{
						return 0;
					}
				}
				else if (2 == vctBtn[uRetBtn])
				{
					CommTest();
				}
				else if (3 == vctBtn[uRetBtn])
				{
					GlobalTest();
				}
				else if (4 == vctBtn[uRetBtn])
				{
					MultiSysTest();
				}
				else if (5 == vctBtn[uRetBtn])
				{
					BlueToothTest();
				}
				else if (6 == vctBtn[uRetBtn])
				{
					UnitTest();
				}
				else if (7 == vctBtn[uRetBtn])
				{
					ImmoTest();
				}
				else if (8 == vctBtn[uRetBtn])
				{
					AppCrashTest();
				}
				else if (9 == vctBtn[uRetBtn])
				{
					UnitTest_Other();
				}
				else if (10 == vctBtn[uRetBtn])
				{
					TestLiveDataFlush();
				}
			}
		}
		return 1;
	}

	void CAPITest::TestLiveDataFlush()
	{
		CArtiMenu uiMenu;
		CEnterSys EnterSys;

		uiMenu.InitTitle("Protocol");

		uiMenu.AddItem("CAN");
		uiMenu.AddItem("KWP");
		while (1)
		{
			uint32_t uRet = uiMenu.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			ECU_INFO	Ecuinfo;
			ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;

			if (uRet == 0)//CAN
			{
				Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_CAN;
				Ecuinfo.uToolId = 0x07DF;
				Ecuinfo.uPinH = 6;
				Ecuinfo.uPinL = 14;
				Ecuinfo.uBps = 500*1000;
				Ecuinfo.binInitCmd = CBinary("\x01\x00", 2);
			}
			else
			{
				Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_KWP;
				Ecuinfo.uPinH = 7;
				Ecuinfo.uPinL = 7;
				Ecuinfo.uEcuId = 0x33;
				Ecuinfo.binInitCmd = CBinary("\xc1\x33\xF1\x81\x66", 5);
				Ecuinfo.bgEnterCmd.Append(CBinary("\x01\x00", 2));
				Ecuinfo.uToolId = 0xf1;
				Ecuinfo.uBps = 10400;
				Ecuinfo.uPackUpack = (uint8_t)CStdCommMaco::FrameFormatType::FFT_KWP_CX;
			}
			EnterSys.SetEcuInfo(Ecuinfo);
			ectRet = EnterSys.EnterSystem(Ecuinfo.uProtocol);
			if (ectRet == ErrorCodeType::STATUS_NOERROR)
			{
				LiveDataFlush(EnterSys);
			}
			EnterSys.ExitSystem();
		}
	}

	void CAPITest::LiveDataFlush(CEnterSys EnterSys)
	{
		CArtiLiveData uiLiveData;
		CBinary	binText("\x11\x00\x00\x00\x0C\x00", 6);
		CBinaryGroup	bgExpress;
		vector<uint16_t> vecint;//当前屏编号集合
		string	strValue;
		vector<uint32_t>	vctSendNum;

		uiLiveData.InitTitle("Live Data Flush Test");
		for (uint32_t i=0; i<6; i++)
		{
			string	strTemp;
			vector<string>	vctstrTemp;
			string	strName;
			string	strUnit;
			string	strMax;
			string	strMin;

			binText.SetAt(4, 0x0c+i);
			bgExpress.Append(binText);
			strTemp = artiGetText(Binary2HexString(binText));
			vctstrTemp = SeparateString(strTemp, "@");
			if (vctstrTemp.size()>0)
			{
				strName = vctstrTemp[0];
			}
			if (vctstrTemp.size() > 1)
			{
				strUnit = vctstrTemp[1];
			}
			if (vctstrTemp.size() > 2)
			{
				vector<string>	vctstrMaxMin;

				vctstrMaxMin = SeparateString(vctstrTemp[2], "---");
				if (vctstrMaxMin.size()>1)
				{
					strMin = vctstrMaxMin[0];
					strMax = vctstrMaxMin[1];
				}
			}
			uiLiveData.AddItem(strName, "", strUnit, strMin, strMax);
			vctSendNum.push_back(0);
		}

		uiLiveData.Show();
		uint64_t	uBefore = 0; 
		uint64_t	uFlushNum = 0;
		bool		bSendFirst = true;
		bool		bTimeFirst = true;

		while (1)
		{
			vecint = uiLiveData.GetUpdateItems();
			for (uint32_t i = 0; i<bgExpress.GetSize(); i++)
			{
				CBinary binRecv;
				CBinary	binSend("\x01\x00",2);
				CSendFrame	SendFrame;
				CRecvFrame	rf;

				binSend.SetAt(1, bgExpress[vecint[i]][4]);
				SendFrame.SetSendFrameData(binSend);
				if (vctSendNum[vecint[i]]==0)
				{
					rf = EnterSys.SendReceive(SendFrame, 0xff);
				}
				else
				{
					rf = EnterSys.SendReceive(SendFrame, vctSendNum[vecint[i]]);
				}
				vctSendNum[vecint[i]] = rf.GetSize();
				strValue = Calc_Script(Binary2HexString(bgExpress[vecint[i]]), rf.GetFirst(), 2);
				uiLiveData.FlushValue(vecint[i], strValue);
				uint32_t uRet = uiLiveData.Show();
				if (uRet == DF_ID_BACK)
				{
					break;
				}
				if (!bSendFirst)
				{
					uFlushNum++;
				}
			}
			if (!bSendFirst)
			{
				if (GetSysTime() >= uBefore + 60 * 1000)
				{
					char chvalue[100];
					SPRINTF_S(chvalue, "%lu times/s", uFlushNum / 60);
					artiShowMsgBox("Result", chvalue);
					break;
				}
			}
			if (bTimeFirst)
			{
				uBefore = GetSysTime();
				bTimeFirst = false;
			}
			bSendFirst = false;
		}
	}

	void CAPITest::InitMap()
	{
		mapObdPinType.clear();
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_NONE, "PIN_OBD_NONE");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_01, "PIN_OBD_01");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_02, "PIN_OBD_02");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_03, "PIN_OBD_03");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_04, "PIN_OBD_04");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_05, "PIN_OBD_05");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_06, "PIN_OBD_06");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_07, "PIN_OBD_07");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_08, "PIN_OBD_08");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_09, "PIN_OBD_09");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_10, "PIN_OBD_10");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_11, "PIN_OBD_11");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_12, "PIN_OBD_12");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_13, "PIN_OBD_13");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_14, "PIN_OBD_14");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_15, "PIN_OBD_15");
		mapObdPinType.emplace(CStdCommMaco::ObdPinType::PIN_OBD_16, "PIN_OBD_16");

		mapPinVoltageType.clear();
		mapPinVoltageType.emplace(CStdCommMaco::PinVoltageType::PinVol_5V, "PinVol_5V");
		mapPinVoltageType.emplace(CStdCommMaco::PinVoltageType::PinVol_12V, "PinVol_12V");
		mapPinVoltageType.emplace(CStdCommMaco::PinVoltageType::PinVol_24V, "PinVol_24V");
		mapPinVoltageType.emplace(CStdCommMaco::PinVoltageType::PinVol_VPW, "PinVol_VPW");
		mapPinVoltageType.emplace(CStdCommMaco::PinVoltageType::PinVol_PWM, "PinVol_PWM");
		
		mapProtocolType.clear();
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_CAN, "PT_CAN");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_CANFD, "PT_CANFD");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_TP20, "PT_TP20");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_TP16, "PT_TP16");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_VOLVO_CAN, "PT_VOLVO_CAN");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_GMLAN_CAN, "PT_GMLAN_CAN");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_KWP, "PT_KWP");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_VPW, "PT_VPW");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_PWM, "PT_PWM");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_ISO, "PT_ISO");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_1281, "PT_1281");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_ALDL, "PT_ALDL");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_KW81, "PT_KW81");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_KW82, "PT_KW82");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_SCI, "PT_SCI");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_NGC, "PT_NGC");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_NISSAN_OLD, "PT_NISSAN_OLD");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_BMW_DOIP, "PT_BMW_DOIP");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_RAW_CAN, "PT_RAW_CAN");
		mapProtocolType.emplace(CStdCommMaco::ProtocolType::PT_RAW_CANFD, "PT_RAW_CANFD");

		mapObdProtocolType.clear();
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_BEGIN, "PT_OBD_BEGIN");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_CANSTD_500K, "PT_OBD_CANSTD_500K");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_CANEX_500K, "PT_OBD_CANEX_500K");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_CANSTD_250K, "PT_OBD_CANSTD_250K");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_CANEX_250K, "PT_OBD_CANEX_250K");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_VPW, "PT_OBD_VPW");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_PWM, "PT_OBD_PWM");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_ISO, "PT_OBD_ISO");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_KWPS, "PT_OBD_KWPS");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_KWPF, "PT_OBD_KWPF");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::PT_OBD_END, "PT_OBD_END");
		mapObdProtocolType.emplace(CStdCommMaco::ObdProtocolType::INVALID, "INVALID");

		mapPinPropertyType.clear();
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_SAME_SIGNAL_K_AND_L_LINE, "PPT_SAME_SIGNAL_K_AND_L_LINE");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_INPUT_POSITIVE_LOGIC, "PPT_INPUT_POSITIVE_LOGIC");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_OUTPUT_POSITIVE_LOGIC, "PPT_OUTPUT_POSITIVE_LOGIC");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_OUTPUT_REVERSE, "PPT_OUTPUT_REVERSE");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_INPUT_PULLUP_RESISTANCE, "PPT_INPUT_PULLUP_RESISTANCE");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_FET_CK, "PPT_FET_CK");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_MINUS_LOGIC, "PPT_MINUS_LOGIC");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_K_PULL_UP_1K2_RESISTER, "PPT_K_PULL_UP_1K2_RESISTER");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_SAME_SIGNAL_K_AND_L_LINE_EXTRA, "PPT_SAME_SIGNAL_K_AND_L_LINE_EXTRA");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_K_USE_K1_ROUTE, "PPT_K_USE_K1_ROUTE_CAN_USE_HSCAN1");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_K_USE_K2_ROUTE, "PPT_K_USE_K2_ROUTE_CAN_USE_HSCAN2");
// 		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_K_USE_K3_ROUTE_CAN_USE_HSCAN2_BUSC, "PPT_K_USE_K3_ROUTE_CAN_USE_HSCAN2_BUSC");
// 		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_K_USE_K4_ROUTE_CAN_USE_SW_BUSA, "PPT_K_USE_K4_ROUTE_CAN_USE_SW_BUSA");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_CAN_USE_SW_BUSB, "PPT_CAN_USE_SW_BUSB");
		mapPinPropertyType.emplace(CStdCommMaco::PinPropertyType::PPT_INVALID, "PPT_INVALID");


		mapPinStatusType.clear();
		mapPinStatusType.emplace(CStdCommMaco::PinStatusType::PST_VALTAGE, "PST_VALTAGE");
		mapPinStatusType.emplace(CStdCommMaco::PinStatusType::PST_LEVEL, "PST_LEVEL");
		mapPinStatusType.emplace(CStdCommMaco::PinStatusType::INVALID, "INVALID");

		mapBitFormatType.clear();
		mapBitFormatType.emplace(CStdCommMaco::BitFormatType::BFT_1_8_1_N, "BFT_1_8_1_N");
		mapBitFormatType.emplace(CStdCommMaco::BitFormatType::BFT_1_8_1_O, "BFT_1_8_1_O");
		mapBitFormatType.emplace(CStdCommMaco::BitFormatType::BFT_1_8_1_E, "BFT_1_8_1_E");
		mapBitFormatType.emplace(CStdCommMaco::BitFormatType::BFT_1_8_1_S, "BFT_1_8_1_S");
		mapBitFormatType.emplace(CStdCommMaco::BitFormatType::BFT_1_8_1_M, "BFT_1_8_1_M");
		mapBitFormatType.emplace(CStdCommMaco::BitFormatType::INVALID, "INVALID");

		mapFilterType.clear();
		mapFilterType.emplace(CStdCommMaco::FilterType::FT_PASS_ENABLE, "FT_PASS_ENABLE");
		mapFilterType.emplace(CStdCommMaco::FilterType::FT_PASS_DISABLE, "FT_PASS_DISABLE");
		mapFilterType.emplace(CStdCommMaco::FilterType::INVALID, "INVALID");

		mapFilterPduType.clear();
		mapFilterPduType.emplace(CStdCommMaco::FilterPduType::FPT_PDU_DISABLE, "FPT_PDU_DISABLE");
		mapFilterPduType.emplace(CStdCommMaco::FilterPduType::FPT_SID_ONLY_ENABLE, "FPT_SID_ONLY_ENABLE");
		mapFilterPduType.emplace(CStdCommMaco::FilterPduType::FPT_SID_PID_ENABLE, "FPT_SID_PID_ENABLE");
		mapFilterPduType.emplace(CStdCommMaco::FilterPduType::FPT_SID_PID_MORE_ENABLE, "FPT_SID_PID_MORE_ENABLE");
		mapFilterPduType.emplace(CStdCommMaco::FilterPduType::INVALID, "INVALID");

		mapLinkKeepType.clear();
		mapLinkKeepType.emplace(CStdCommMaco::LinkKeepType::LKT_INTERVAL, "LKT_INTERVAL");
		mapLinkKeepType.emplace(CStdCommMaco::LinkKeepType::LKT_FIXED, "LKT_FIXED");
		mapLinkKeepType.emplace(CStdCommMaco::LinkKeepType::INVALID, "INVALID");

		mapFlowCtrlType.clear();
		mapFlowCtrlType.emplace(CStdCommMaco::FlowCtrlType::FCT_AUTO, "FCT_AUTO");
		mapFlowCtrlType.emplace(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL, "FCT_FUNCTIONAL");
		mapFlowCtrlType.emplace(CStdCommMaco::FlowCtrlType::FCT_NORMAL, "FCT_NORMAL");
		mapFlowCtrlType.emplace(CStdCommMaco::FlowCtrlType::FCT_EXCHANGE_2BYTES, "FCT_EXCHANGE_2BYTES");
		mapFlowCtrlType.emplace(CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW, "FCT_VEHICLE_VW");
		mapFlowCtrlType.emplace(CStdCommMaco::FlowCtrlType::INVALID, "INVALID");

		mapCanFormatType.clear();
		mapCanFormatType.emplace(CStdCommMaco::CanFormatType::CFT_FORMAT_NORMAL, "CFT_FORMAT_NORMAL");
		mapCanFormatType.emplace(CStdCommMaco::CanFormatType::CFT_FORMAT_RX_RAW, "CFT_FORMAT_RX_RAW");
		mapCanFormatType.emplace(CStdCommMaco::CanFormatType::CFT_FORMAT_TX_RX_RAW, "CFT_FORMAT_TX_RX_RAW");
		mapCanFormatType.emplace(CStdCommMaco::CanFormatType::CFT_FORMAT_TX_RAW, "CFT_FORMAT_TX_RAW");
		mapCanFormatType.emplace(CStdCommMaco::CanFormatType::INVALID, "INVALID");

		mapAddressEnterParaType.clear();
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_SEND_KW1_REVERSED, "AEPT_SEND_KW1_REVERSED");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_SEND_KW2_REVERSED, "AEPT_SEND_KW2_REVERSED");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_RECV_2_KWS, "AEPT_RECV_2_KWS");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_RECV_5_KWS, "AEPT_RECV_5_KWS");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_RECV_ADDR_REVERSED, "AEPT_RECV_ADDR_REVERSED");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_RECV_ONE_FRAME, "AEPT_RECV_ONE_FRAME");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_RECV_MULTI_FRAME, "AEPT_RECV_MULTI_FRAME");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_AUTO_BAUDRATE, "AEPT_AUTO_BAUDRATE");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_L_LINE_ENABLE, "AEPT_L_LINE_ENABLE");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_ISO_CITROEN, "AEPT_ISO_CITROEN");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_RETRY_ONCE_MORE, "AEPT_RETRY_ONCE_MORE");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_GET_KW_ONLY, "AEPT_GET_KW_ONLY");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_DISABLE_EXTRA_VERSION, "AEPT_DISABLE_EXTRA_VERSION");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_MASK_KW_REVERSED_TO_ECU, "AEPT_MASK_KW_REVERSED_TO_ECU");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_MASK_BYTE_OF_KWS, "AEPT_MASK_BYTE_OF_KWS");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_MASK_RECV_NUM_OF_FRAME, "AEPT_MASK_RECV_NUM_OF_FRAME");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_MASK_ISO_CITROEN, "AEPT_MASK_ISO_CITROEN");
		mapAddressEnterParaType.emplace(CStdCommMaco::AddressEnterParaType::AEPT_AUTO_ALL, "AEPT_AUTO_ALL");

		mapEnterWayType.clear();
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::EWT_5BPS_TYPE01, "EWT_5BPS_TYPE01");
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::EWT_5BPS_TYPE02, "EWT_5BPS_TYPE02");
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::EWT_5BPS_TYPE03, "EWT_5BPS_TYPE03");
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::EWT_5BPS_TYPE04, "EWT_5BPS_TYPE04");
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::EWT_5BPS_TYPE05, "EWT_5BPS_TYPE05");
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::EWT_5BPS_TYPE06, "EWT_5BPS_TYPE06");
		mapEnterWayType.emplace(CStdCommMaco::EnterWayType::INVALID, "INVALID");

		mapRcxxHandlingMode.clear();
		mapRcxxHandlingMode.emplace(CStdCommMaco::RcxxHandlingMode::RHM_MODE_NRC21, "RHM_MODE_NRC21");
		mapRcxxHandlingMode.emplace(CStdCommMaco::RcxxHandlingMode::RHM_MODE_NRC23, "RHM_MODE_NRC23");
		mapRcxxHandlingMode.emplace(CStdCommMaco::RcxxHandlingMode::RHM_MODE_NRC78, "RHM_MODE_NRC78");

		mapRcxxHandlingType.clear();
		mapRcxxHandlingType.emplace(CStdCommMaco::RcxxHandlingType::RHT_DISABLE, "RHT_DISABLE");
		mapRcxxHandlingType.emplace(CStdCommMaco::RcxxHandlingType::RHT_UNTIL_TIMEOUT, "RHT_UNTIL_TIMEOUT");
		mapRcxxHandlingType.emplace(CStdCommMaco::RcxxHandlingType::RHT_UNLIMITED_LOOP, "RHT_UNLIMITED_LOOP");

		mapClearBufferMode.clear();
		mapClearBufferMode.emplace(CStdCommMaco::ClearBufferMode::CBM_CLEAR_DISABLE, "CBM_CLEAR_DISABLE");
		mapClearBufferMode.emplace(CStdCommMaco::ClearBufferMode::CBM_CLEAR_COMM_RX_QUEUE, "CBM_CLEAR_COMM_RX_QUEUE");
		mapClearBufferMode.emplace(CStdCommMaco::ClearBufferMode::CBM_CLEAR_VCI_RX_BUFFER, "CBM_CLEAR_VCI_RX_BUFFER");
	
		mapFrameCsType.clear();
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_NONE, "CS_NONE");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_ADD, "CS_ADD");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_ADD_HL, "CS_ADD_HL");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_ADD_LH, "CS_ADD_LH");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_ADD_REVERSED, "CS_ADD_REVERSED");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_ADD_COMPLEMENT, "CS_ADD_COMPLEMENT");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_XOR, "CS_XOR");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_CRC_8, "CS_CRC_8");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_CRC_16, "CS_CRC_16");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::CS_KWP1281, "CS_KWP1281");
		mapFrameCsType.emplace(CStdCommMaco::FrameCsType::INVALID, "INVALID");

		mapFrameFormatType.clear();
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_NONE, "FFT_NONE");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_CAN, "FFT_CAN");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_VPW_EOBD, "FFT_VPW_EOBD");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_PWM_EOBD, "FFT_PWM_EOBD");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_ISO9141_2, "FFT_ISO9141_2");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP_CX, "FFT_KWP_CX");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP_C0, "FFT_KWP_C0");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP_8X, "FFT_KWP_8X");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP_80, "FFT_KWP_80");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP_0X, "FFT_KWP_0X");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP_00, "FFT_KWP_00");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_PWM_FORD, "FFT_PWM_FORD");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_FORD_ISO, "FFT_FORD_ISO");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_VPW_GM, "FFT_VPW_GM");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_ALDL, "FFT_ALDL");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KW81, "FFT_KW81");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KW82, "FFT_KW82");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_VPW_CHRYSLER, "FFT_VPW_CHRYSLER");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_DSI, "FFT_DSI");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_DSII, "FFT_DSII");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_KWP1281, "FFT_KWP1281");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_VOLVO, "FFT_VOLVO");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_PSA, "FFT_PSA");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_RENAULT_ISO, "FFT_RENAULT_ISO");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_HONDA, "FFT_HONDA");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_NISSAN_OLD, "FFT_NISSAN_OLD");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_DAIHATSU_ISO, "FFT_DAIHATSU_ISO");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_SMS_ISO, "FFT_SMS_ISO");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_MB_ISO, "FFT_MB_ISO");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::FFT_NORMAL, "FFT_NORMAL");
		mapFrameFormatType.emplace(CStdCommMaco::FrameFormatType::INVALID, "INVALID");

// 		mapDoipModuleType.clear();
// 		mapDoipModuleType.emplace(CStdCommMaco::DoipModuleType::DMT_DOIP_NO_TYPE, "DMT_DOIP_NO_TYPE");
// 		mapDoipModuleType.emplace(CStdCommMaco::DoipModuleType::DMT_DOIP_ENTITY, "DMT_DOIP_ENTITY");
// 		mapDoipModuleType.emplace(CStdCommMaco::DoipModuleType::DMT_DOIP_VEHICLE, "DMT_DOIP_VEHICLE");
// 		mapDoipModuleType.emplace(CStdCommMaco::DoipModuleType::DMT_DOIP_GROUP, "DMT_DOIP_GROUP");
// 		mapDoipModuleType.emplace(CStdCommMaco::DoipModuleType::DMT_DOIP_COLLECTION, "DMT_DOIP_COLLECTION");
// 		mapDoipModuleType.emplace(CStdCommMaco::DoipModuleType::DMT_DOIP_BMW_VEHICLE, "DMT_DOIP_BMW_VEHICLE");

		mapTrueAndFalse.clear();
		mapTrueAndFalse.emplace(true, "true");
		mapTrueAndFalse.emplace(false, "false");

		mapUint32ToString.clear();
		mapUint32ToString.emplace(0, "0");
		mapUint32ToString.emplace(100, "100");
		mapUint32ToString.emplace(200, "200");
		mapUint32ToString.emplace(1000, "1000");
		mapUint32ToString.emplace(2000, "2000");
		mapUint32ToString.emplace(3000, "3000");
		mapUint32ToString.emplace(5000, "5000");
		mapUint32ToString.emplace(10000, "10000");
		mapUint32ToString.emplace(50000, "50000");

		mapBaudRate.clear();
		mapBaudRate.emplace(9600, "9600");
		mapBaudRate.emplace(10400, "10400");
		mapBaudRate.emplace(33333, "33333");
		mapBaudRate.emplace(250 * 1000, "250 * 1000");
		mapBaudRate.emplace(500 * 1000, "500 * 1000");

		mapPinVoltageMv.clear();
		mapPinVoltageMv.emplace(0, "0mV");
		mapPinVoltageMv.emplace(5000, "5000mV");
		mapPinVoltageMv.emplace(12000, "12000mV");
		mapPinVoltageMv.emplace(24000, "24000mV");

		mapFilterLength.clear();
		mapFilterLength.emplace(0, "0");
		mapFilterLength.emplace(1, "1");
		mapFilterLength.emplace(2, "2");
		mapFilterLength.emplace(3, "3");
		mapFilterLength.emplace(4, "4");
		mapFilterLength.emplace(5, "5");

		mapSequenceNumber.clear();
		mapSequenceNumber.emplace(0, "0");
		mapSequenceNumber.emplace(1, "1");
		mapSequenceNumber.emplace(2, "2");
		mapSequenceNumber.emplace(0x10, "0x10");
		mapSequenceNumber.emplace(0x11, "0x11");
		mapSequenceNumber.emplace(0x12, "0x12");

		mapFlowControlTimes.clear();
		mapFlowControlTimes.emplace(0, "0");
		mapFlowControlTimes.emplace(10, "10");
		mapFlowControlTimes.emplace(100, "100");
		mapFlowControlTimes.emplace(1000, "1000");
		mapFlowControlTimes.emplace(0 | (1 << 31), "0 | (1 << 31)");
		mapFlowControlTimes.emplace(10 | (1 << 31), "10 | (1 << 31)");
		mapFlowControlTimes.emplace(100 | (1 << 31), "100 | (1 << 31)");
		mapFlowControlTimes.emplace(1000 | (1 << 31), "1000 | (1 << 31)");

		mapFlowControlBlockSize.clear();
		mapFlowControlBlockSize.emplace(0, "0");
		mapFlowControlBlockSize.emplace(1, "1");
		mapFlowControlBlockSize.emplace(5, "5");
		mapFlowControlBlockSize.emplace(10, "10");
		mapFlowControlBlockSize.emplace(0 | (1 << 31), "0 | (1 << 31)");
		mapFlowControlBlockSize.emplace(1 | (1 << 31), "1 | (1 << 31)");
		mapFlowControlBlockSize.emplace(5 | (1 << 31), "5 | (1 << 31)");
		mapFlowControlBlockSize.emplace(10 | (1 << 31), "10 | (1 << 31)");

		mapRxCanId.clear();
		mapRxCanId.emplace(0x0000, "0x0000");
		mapRxCanId.emplace(0x0541, "0x0541");
		mapRxCanId.emplace(0x0542, "0x0542");
		mapRxCanId.emplace(0x0543, "0x0543");
		mapRxCanId.emplace(0x0549, "0x0549");
		mapRxCanId.emplace(0x0554, "0x0554");
		mapRxCanId.emplace(0x06E0, "0x06E0");
		mapRxCanId.emplace(0x07E8, "0x07E8");

		mapEnable.clear();
		mapEnable.emplace(0, "0");
		mapEnable.emplace(1, "1");
		mapEnable.emplace(2, "2");

		mapNodeAddress.clear();
		mapNodeAddress.emplace(0xF1, "0xF1");
		mapNodeAddress.emplace(0xF5, "0xF5");

		mapEcuAddress.clear();
		mapEcuAddress.emplace(0xE0, "0xE0");
		mapEcuAddress.emplace(0xE5, "0xE5");
		mapEcuAddress.emplace(0xEF, "0xEF");

		mapToolAddress.clear();
		mapToolAddress.emplace(0xF1, "0xF1");
		mapToolAddress.emplace(0xF5, "0xF5");
		mapToolAddress.emplace(0xFF, "0xFF");

		mapFramePad.clear();
		mapFramePad.emplace(0x00, "00");
		mapFramePad.emplace(0x55, "55");
		mapFramePad.emplace(0xFF, "FF");

		mapAddressCode.clear();
		mapAddressCode.emplace(0x01, "0x01");
		mapAddressCode.emplace(0x02, "0x02");
		mapAddressCode.emplace(0x33, "0x33");
		mapAddressCode.emplace(0x62, "0x62");

		mapAddSendBps.clear();
		mapAddSendBps.emplace(0x05, "0x05");

		mapWaitTimeBeforSendAddress.clear();
		mapWaitTimeBeforSendAddress.emplace(400, "400");
		mapWaitTimeBeforSendAddress.emplace(1000, "1000");
		mapWaitTimeBeforSendAddress.emplace(5000, "5000");

		mapSyncByte0x55OverTime.clear();
		mapSyncByte0x55OverTime.emplace(20, "20");
		mapSyncByte0x55OverTime.emplace(550, "550");
		mapSyncByte0x55OverTime.emplace(1000, "1000");

		mapReceiveKwOverTime.clear();
		mapReceiveKwOverTime.emplace(10, "10");
		mapReceiveKwOverTime.emplace(25, "25");
		mapReceiveKwOverTime.emplace(40, "40");

		mapKw2ReverseWaitTime.clear();
		mapKw2ReverseWaitTime.emplace(500, "500");
		mapKw2ReverseWaitTime.emplace(1000, "1000");
		mapKw2ReverseWaitTime.emplace(1500, "1500");

		mapReceiveReverseAddressOverTime.clear();		
		mapReceiveReverseAddressOverTime.emplace(500, "500");
		mapReceiveReverseAddressOverTime.emplace(1000, "1000");
		mapReceiveReverseAddressOverTime.emplace(1500, "1500");

		mapVoltageTime.clear();
		mapVoltageTime.emplace(0, "0");
		mapVoltageTime.emplace(25, "25");
		mapVoltageTime.emplace(50, "50");
		mapVoltageTime.emplace(100, "100");

		mapTpTargetAddress.clear();
		mapTpTargetAddress.emplace(0x01, "0x01");
		mapTpTargetAddress.emplace(0x02, "0x02");
		mapTpTargetAddress.emplace(0x03, "0x03");

		mapAppLayerID.clear();
		mapAppLayerID.emplace(0x01, "0x01");
		mapAppLayerID.emplace(0x10, "0x10");
		mapAppLayerID.emplace(0x20, "0x20");
		mapAppLayerID.emplace(0x21, "0x21");

		mapEnterSysId.clear();
		mapEnterSysId.emplace(0x200, "0x200");
		mapEnterSysId.emplace(0x2D0, "0x2D0");

		mapEnterFilterId.clear();
		mapEnterFilterId.emplace(0x209, "0x209");
		mapEnterFilterId.emplace(0x2F1, "0x2F1");

		mapTargetAddr.clear();
		mapTargetAddr.emplace(0x311, "0x311");
		mapTargetAddr.emplace(0x7A0, "0x7A0");

		mapEnterAddressCode.clear();
		mapEnterAddressCode.emplace(0x25, "0x25");
		mapEnterAddressCode.emplace(0xC4, "0xC4");

		mapSystemId.clear();
		mapSystemId.emplace(0x11, "0x11");
		mapSystemId.emplace(0x09, "0x09");

		mapTimeMs.clear();
		mapTimeMs.emplace(0, "0");
		mapTimeMs.emplace(100, "100");
		mapTimeMs.emplace(1 * 1000, "1 * 1000");
		mapTimeMs.emplace(3 * 1000, "3 * 1000");
		mapTimeMs.emplace(6 * 1000, "5 * 1000");
		mapTimeMs.emplace(15 * 1000, "15 * 1000");
		mapTimeMs.emplace(30 * 1000, "30 * 1000");

		mapActiveEnable.clear();
		mapActiveEnable.emplace(0, "0");
		mapActiveEnable.emplace(1, "1");
		mapActiveEnable.emplace(2, "2");

#if defined WIN32 | defined (WIN64)
		mapMainFuncType.clear();
		mapMainFuncType.emplace(CTprogMaco::MainFuncType::MFT_SYS, "MFT_SYS");
		mapMainFuncType.emplace(CTprogMaco::MainFuncType::MFT_EEPROM, "MFT_EEPROM");
		mapMainFuncType.emplace(CTprogMaco::MainFuncType::MFT_MCU, "MFT_MCU");
		mapMainFuncType.emplace(CTprogMaco::MainFuncType::MFT_FREQ, "MFT_FREQ");
		mapMainFuncType.emplace(CTprogMaco::MainFuncType::MFT_RFID, "MFT_RFID");
		mapMainFuncType.emplace(CTprogMaco::MainFuncType::INVALID, "INVALID");
#endif

		mapTprogAddress.clear();
		mapTprogAddress.emplace(0x10, "0x10");
		mapTprogAddress.emplace(0x14, "0x14");
		mapTprogAddress.emplace(0x18, "0x18");
		mapTprogAddress.emplace(0x1B, "0x1B");

		mapTprogLength.clear();
		mapTprogLength.emplace(0x04, "0x04");
		mapTprogLength.emplace(0x1C, "0x1C");
		mapTprogLength.emplace(0x20, "0x20");

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
																													   //mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_ALLFUN, "DET_ALLFUN");
		//mapeDiagEntryType.emplace(CArtiGlobal::eDiagEntryType::DET_INVALID, "DET_INVALID");

		mapDFButton.emplace(DF_MB_NOBUTTON,	"DF_MB_NOBUTTON");
		mapDFButton.emplace(DF_MB_YES,		"DF_MB_YES");
		mapDFButton.emplace(DF_MB_NO,		"DF_MB_NO");
		mapDFButton.emplace(DF_MB_YESNO,	"DF_MB_YESNO");
		mapDFButton.emplace(DF_MB_OK,		"DF_MB_OK");
		mapDFButton.emplace(DF_MB_CANCEL,	"DF_MB_CANCEL");
		mapDFButton.emplace(DF_MB_OKCANCEL,	"DF_MB_OKCANCEL");
		mapDFButton.emplace(DF_MB_NEXTEXIT,	"DF_MB_NEXTEXIT");

		mapDFButton.emplace(DF_MB_YES, "DF_MB_YES");
		mapDFButton.emplace(DF_MB_NO, "DF_MB_NO");
		mapDFButton.emplace(DF_MB_YESNO, "DF_MB_YESNO");
		mapDFButton.emplace(DF_MB_OK, "DF_MB_OK");
		mapDFButton.emplace(DF_MB_CANCEL, "DF_MB_CANCEL");
		mapDFButton.emplace(DF_MB_OKCANCEL, "DF_MB_OKCANCEL");
		mapDFButton.emplace(DF_MB_NEXTEXIT, "DF_MB_NEXTEXIT");

		mapDFTextID.emplace(DF_ID_OK, DF_TEXT_ID_OK);
		mapDFTextID.emplace(DF_ID_YES, DF_TEXT_ID_YES);
		mapDFTextID.emplace(DF_ID_CANCEL, DF_TEXT_ID_CANCEL);
		mapDFTextID.emplace(DF_ID_NO, DF_TEXT_ID_NO);
		mapDFTextID.emplace(DF_ID_BACK, DF_TEXT_ID_BACK);
		mapDFTextID.emplace(DF_ID_EXIT, DF_TEXT_ID_EXIT);
		mapDFTextID.emplace(DF_ID_HELP, DF_TEXT_ID_HELP);
		mapDFTextID.emplace(DF_ID_CLEAR_DTC, DF_TEXT_ID_CLEAR_DTC);
		mapDFTextID.emplace(DF_ID_REPORT, DF_TEXT_ID_REPORT);
		mapDFTextID.emplace(DF_ID_NEXT, DF_TEXT_ID_NEXT);

		//mapAlignType.emplace(DT_TOP, "DT_TOP");
		mapAlignType.emplace(DT_LEFT, "DT_LEFT");
		mapAlignType.emplace(DT_CENTER, "DT_CENTER");
		mapAlignType.emplace(DT_RIGHT, "DT_RIGHT");
		mapAlignType.emplace(DT_BOTTOM, "DT_BOTTOM");

		mapPopupType.emplace(DF_POPUP_TYPE_MSG, "DF_POPUP_TYPE_MSG");
		mapPopupType.emplace(DF_POPUP_TYPE_LIST, "DF_POPUP_TYPE_LIST");

		mapPopupDirection.emplace(DF_POPUP_DIR_TOP, "DF_POPUP_DIR_TOP");
		mapPopupDirection.emplace(DF_POPUP_DIR_LEFT, "DF_POPUP_DIR_LEFT");
		mapPopupDirection.emplace(DF_POPUP_DIR_CENTER, "DF_POPUP_DIR_CENTER");
		mapPopupDirection.emplace(DF_POPUP_DIR_RIGHT, "DF_POPUP_DIR_RIGHT");
		mapPopupDirection.emplace(DF_POPUP_DIR_BOTTOM, "DF_POPUP_DIR_BOTTOM");

		mapColWidth.emplace(vector<uint32_t>{100}, "{100}");
		mapColWidth.emplace(vector<uint32_t>{50, 50}, "{50, 50}");
		mapColWidth.emplace(vector<uint32_t>{50, 30, 20}, "{50, 30, 20}");

		mapListNum.emplace(1, "1");
		mapListNum.emplace(2, "2");
		mapListNum.emplace(3, "3");
		mapListNum.emplace(4, "4");
		mapListNum.emplace(16, "16");

		mapRowNum.emplace(1, "1");
		mapRowNum.emplace(2, "2");
		mapRowNum.emplace(3, "3");
		mapRowNum.emplace(4, "4");
		mapRowNum.emplace(10000, "10000");

		mapFontSize.emplace(eFontSize::FORT_SIZE_SMALL, "FORT_SIZE_SMALL");
		mapFontSize.emplace(eFontSize::FORT_SIZE_MEDIUM, "FORT_SIZE_MEDIUM");
		mapFontSize.emplace(eFontSize::FORT_SIZE_LARGE, "FORT_SIZE_LARGE");

		mapBoldType.emplace(eBoldType::BOLD_TYPE_NONE, "BOLD_TYPE_NONE");
		mapBoldType.emplace(eBoldType::BOLD_TYPE_BOLD, "BOLD_TYPE_BOLD");
	}

	uint8_t CAPITest::ShowTest()
	{
		vector<uint32_t> vctBtn;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000021"));
		uiMenu.AddItem("ArtiActiveTest");			vctBtn.push_back(1);
		uiMenu.AddItem("ArtiEcuInfoTest");			vctBtn.push_back(2);
		uiMenu.AddItem("ArtiFileDialogTest");		vctBtn.push_back(3);
		uiMenu.AddItem("ArtiFreezeTest");			vctBtn.push_back(4);
		uiMenu.AddItem("ArtiGlobalTest");			vctBtn.push_back(5);
		uiMenu.AddItem("ArtiInputTest");			vctBtn.push_back(6);
		uiMenu.AddItem("ArtiListTest");				vctBtn.push_back(7);
		uiMenu.AddItem("ArtiLiveDataTest");			vctBtn.push_back(8);
		uiMenu.AddItem("ArtiMenuTest");				vctBtn.push_back(9);
		uiMenu.AddItem("ArtiMiniMsgBoxTest");		vctBtn.push_back(15);
		uiMenu.AddItem("ArtiMsgBoxTest");			vctBtn.push_back(10);
		uiMenu.AddItem("ArtiPopupTest");			vctBtn.push_back(16);
		uiMenu.AddItem("ArtiReportTest");			vctBtn.push_back(11);
		uiMenu.AddItem("ArtiSystemTest");			vctBtn.push_back(12);
		uiMenu.AddItem("ArtiTroubleTest");			vctBtn.push_back(13);
		uiMenu.AddItem("ArtiWebTest");			    vctBtn.push_back(14);
		uiMenu.AddItem("ArtiCoilReader");			vctBtn.push_back(17);
		uiMenu.AddItem("ArtiFreqWave");			    vctBtn.push_back(18);
		uiMenu.AddItem("ArtiPicture");			    vctBtn.push_back(19);
		uiMenu.AddItem("ArtiFloatMini");			vctBtn.push_back(20);
		uiMenu.AddItem("VehAutoAuth");				vctBtn.push_back(21);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctBtn.size())
			{
				if (1 == vctBtn[uRetBtn])
				{
					CArtiActiveTest artiActiveTest;
					artiActiveTest.ShowMenu();
				}
				else if (2 == vctBtn[uRetBtn])
				{
					CArtiEcuInfoTest artiEcuInfoTest;
					artiEcuInfoTest.ShowMenu();
				}
				else if (3 == vctBtn[uRetBtn])
				{
					CArtiFileDialogTest artiFileDialogTest;
					artiFileDialogTest.ShowMenu();
				}
				else if (4 == vctBtn[uRetBtn])
				{
					CArtiFreezeTest artiFreezeTest;
					artiFreezeTest.ShowMenu();
				}
				else if (5 == vctBtn[uRetBtn])
				{
					CArtiGlobalTest artiGlobalTest;
					if (artiGlobalTest.ShowMenu() == 0)
					{
						return 0;
					}
				}
				else if (6 == vctBtn[uRetBtn])
				{
					CArtiInputTest artiInputTest;
					artiInputTest.ShowMenu();
				}
				else if (7 == vctBtn[uRetBtn])
				{
					CArtiListTest artiListTest;
					artiListTest.ShowMenu();
				}
				else if (8 == vctBtn[uRetBtn])
				{
					CArtiLiveDataTest artiLiveDataTest;
					artiLiveDataTest.ShowMenu();
				}
				else if (9 == vctBtn[uRetBtn])
				{
					CArtiMenuTest artiMenuTest;
					artiMenuTest.ShowMenu();
				}
				else if (10 == vctBtn[uRetBtn])
				{
					CArtiMsgBoxTest artiMsgBoxTest;
					artiMsgBoxTest.ShowMenu();
				}
				else if (11 == vctBtn[uRetBtn])
				{
					CArtiReportTest artiReportTest;
					artiReportTest.ShowMenu();
				}
				else if (12 == vctBtn[uRetBtn])
				{
					CArtiSystemTest artiSystemTest;
					artiSystemTest.ShowMenu();
				}
				else if (13 == vctBtn[uRetBtn])
				{
					CArtiTroubleTest artiTroubleTest;
					artiTroubleTest.ShowMenu();
				}
				else if (14 == vctBtn[uRetBtn])
				{
					CArtiWebTest artiWebTest;
					artiWebTest.ShowMenu();
				}
				else if (15 == vctBtn[uRetBtn])
				{
					CArtiMiniMsgBoxTest artiMiniMsgBoxTest;
					artiMiniMsgBoxTest.ShowMenu();
				}
				else if (16 == vctBtn[uRetBtn])
				{
					CArtiPopupTest artiPopupTest;
					artiPopupTest.ShowMenu();
				}
				else if (17 == vctBtn[uRetBtn])
				{
					CArtiCoilReaderTest artiCoilReaderTest;
					artiCoilReaderTest.ShowMenu();
				}
				else if (18 == vctBtn[uRetBtn])
				{
					CArtiFreqWaveTest artiFreqWaveTest;
					artiFreqWaveTest.ShowMenu();
				}
				else if (19 == vctBtn[uRetBtn])
				{
					CArtiPictureTest artPictureTest;
					artPictureTest.ShowMenu();
				}
				else if (20 == vctBtn[uRetBtn])

				{
					CArtiFloatMiniTest artFloatMiniTest;
					artFloatMiniTest.ShowMenu();
				}
				else if (21 == vctBtn[uRetBtn])
				{
					CVehAutoAuthTest vehAutoAuthTest;
					vehAutoAuthTest.ShowMenu();
				}
				else
				{
					ShowMsgBoxDemo(artiGetText("FF0000000021"), artiGetText("FF0000000008"), DF_MB_OK, DT_CENTER, -1, m_uThread);
				}
			}
		}
		return 1;
	}

	void CAPITest::CommTest()
	{
		vector<uint32_t> vctBtn;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000022"));				//"通讯接口测试"
		uiMenu.AddItem("EcuInterface");	vctBtn.push_back(1);
		uiMenu.AddItem("CTProg");		vctBtn.push_back(2);
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctBtn.size())
			{
				if (1 == vctBtn[uRetBtn])
				{
					EcuInterfaceTest();
				}
				else if (2 == vctBtn[uRetBtn])
				{
#ifdef __TProgTest__
					TProgTest();
#else
					ShowFuncInDevelopment();
#endif // __TProgTest__
				}
				else
				{
					/*
					* 通讯接口测试
					* 请选择正确测试项
					*/
					ShowMsgBoxDemo(artiGetText("FF0000000021"), artiGetText("FF0000000008"), DF_MB_OK, DT_CENTER, -1, m_uThread);
				}
			}
		}
	}


	/*****************************************************************************
	*
	*    通信接口测试程序
	*
	*****************************************************************************/

	void CAPITest::EcuInterfaceTest()
	{
		vector<uint32_t> vctIDMenu;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("EcuInterface");											//"通讯接口测试"
		uiMenu.AddItem(artiGetText("FF0000000020"));	vctIDMenu.push_back(0x01);	//"接口测试"
		uiMenu.AddItem(artiGetText("FF00000000C0"));	vctIDMenu.push_back(0x02);	//"协议测试"
		uiMenu.AddItem(artiGetText("FF00000000C1"));	vctIDMenu.push_back(0x03);	//"通讯测试"

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctIDMenu.size())
			{
				switch (vctIDMenu[uRetBtn])
				{
				case 0x01:	EcuInterfaceTest_API();						break;
				case 0x02:	EcuInterfaceTest_MultiInterface();			break;
				case 0x03:	EcuInterfaceTest_VciCommunication();		break;
				default:
					/*
					* 通讯接口测试
					* 请选择正确测试项
					*/
					ShowMsgBoxDemo(artiGetText("FF0000000021"), artiGetText("FF0000000008"), DF_MB_OK, DT_CENTER, -1, m_uThread);
					break;
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_API()
	{
		vector<uint32_t> vctIDMenu;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle(artiGetText("FF0000000001"));										//"通讯接口测试"
		//uiMenu.AddItem(artiGetText("FF000000002B"));			vctIDMenu.push_back(0xFF);	//"组合测试"
		uiMenu.AddItem("SetProtocolType");						vctIDMenu.push_back(1);
		uiMenu.AddItem("SetIoPin");								vctIDMenu.push_back(2);
		uiMenu.AddItem("SetBaudRate");							vctIDMenu.push_back(3);
		uiMenu.AddItem("SetLinkKeep");							vctIDMenu.push_back(4);
		uiMenu.AddItem("SetLinkKeep1");							vctIDMenu.push_back(5);
		uiMenu.AddItem("SetCommLineVoltage");					vctIDMenu.push_back(6);
		uiMenu.AddItem("SetCommTime");							vctIDMenu.push_back(7);
		uiMenu.AddItem("SetPinVoltage");						vctIDMenu.push_back(8);
		uiMenu.AddItem("SetJ1850FunctionalAddressFilter");		vctIDMenu.push_back(9);
		uiMenu.AddItem("SetJ1850NodeAddress");					vctIDMenu.push_back(10);
		uiMenu.AddItem("SetCanExtendedAddress");				vctIDMenu.push_back(11);
		uiMenu.AddItem("SetFilterId");							vctIDMenu.push_back(12);
		uiMenu.AddItem("SetFilterIdRange");						vctIDMenu.push_back(13);
		uiMenu.AddItem("SetFilterPDU");							vctIDMenu.push_back(14);
		uiMenu.AddItem("SetCanFramePad");						vctIDMenu.push_back(15);
		uiMenu.AddItem("ClearFilter");							vctIDMenu.push_back(16);
		uiMenu.AddItem("SetFlowControlId");						vctIDMenu.push_back(17);
		uiMenu.AddItem("SetFlowControlMode");					vctIDMenu.push_back(18);
		uiMenu.AddItem("SetFlowControlSendDelay");				vctIDMenu.push_back(19);
		uiMenu.AddItem("SetCanFirstConsecutiveFrameValue");		vctIDMenu.push_back(20);
		uiMenu.AddItem("SetSingleMsgCanFormatId");				vctIDMenu.push_back(21);
		uiMenu.AddItem("EnableSegmentedSendSingleCanFrame");	vctIDMenu.push_back(22);
		uiMenu.AddItem("AddressCodeEnter");						vctIDMenu.push_back(23);
		uiMenu.AddItem("QuickEnter");							vctIDMenu.push_back(24);
		uiMenu.AddItem("TP20Enter");							vctIDMenu.push_back(25);
		uiMenu.AddItem("TP16Enter");							vctIDMenu.push_back(26);
		uiMenu.AddItem("TP20Broadcast");						vctIDMenu.push_back(27);
		uiMenu.AddItem("SetRCXXHandling");						vctIDMenu.push_back(28);
		uiMenu.AddItem("SetClearBuffer");						vctIDMenu.push_back(29);
		uiMenu.AddItem("SendReceive");							vctIDMenu.push_back(30);
		uiMenu.AddItem("SendReceive1");							vctIDMenu.push_back(31);
		uiMenu.AddItem("SendReceive2");							vctIDMenu.push_back(32);
		uiMenu.AddItem("GetPinStatus");							vctIDMenu.push_back(33);
		uiMenu.AddItem("ActiveDoipPin");						vctIDMenu.push_back(34);
		uiMenu.AddItem("SelectDoipOption");						vctIDMenu.push_back(35);
		uiMenu.AddItem("GetDoipModule");						vctIDMenu.push_back(36);
		uiMenu.AddItem("Log");									vctIDMenu.push_back(47);
		uiMenu.AddItem("GetVersion");							vctIDMenu.push_back(37);
		uiMenu.AddItem("GetVciTypeName");						vctIDMenu.push_back(38);
		uiMenu.AddItem("GetVciSN");								vctIDMenu.push_back(43);
		uiMenu.AddItem("GetVciKey");							vctIDMenu.push_back(44);
		uiMenu.AddItem("GetVciMcuId");							vctIDMenu.push_back(45);
		uiMenu.AddItem("IsVciConnected");						vctIDMenu.push_back(39);
		uiMenu.AddItem("VciReset");								vctIDMenu.push_back(40);
		uiMenu.AddItem("GetCommType");							vctIDMenu.push_back(46);
		uiMenu.AddItem("VciVehicleLedOn");						vctIDMenu.push_back(41);
		uiMenu.AddItem("VciBuzzOn");							vctIDMenu.push_back(42);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctIDMenu.size())
			{
				switch (vctIDMenu[uRetBtn])
				{
				case 1:		EcuInterfaceTest_SetProtocolType();						break;
				case 2:		EcuInterfaceTest_SetIoPin();							break;
				case 3:		EcuInterfaceTest_SetBaudRate();							break;
				case 4:		EcuInterfaceTest_SetLinkKeep();							break;
				case 5:		EcuInterfaceTest_SetLinkKeep1();						break;
				case 6:		EcuInterfaceTest_SetCommLineVoltage();					break;
				case 7:		EcuInterfaceTest_SetCommTime();							break;
				case 8:		EcuInterfaceTest_SetPinVoltage();						break;
				case 9:		EcuInterfaceTest_SetJ1850FunctionalAddressFilter();		break;
				case 10:	EcuInterfaceTest_SetJ1850NodeAddress();					break;
				case 11:	EcuInterfaceTest_SetCanExtendedAddress();				break;
				case 12:	EcuInterfaceTest_SetFilterId();							break;
				case 13:	EcuInterfaceTest_SetFilterIdRange();					break;
				case 14:	EcuInterfaceTest_SetFilterPDU();						break;
				case 15:	EcuInterfaceTest_SetCanFramePad();						break;
				case 16:	EcuInterfaceTest_ClearFilter();							break;
				case 17:	EcuInterfaceTest_SetFlowControlId();					break;
				case 18:	EcuInterfaceTest_SetFlowControlMode();					break;
				case 19:	EcuInterfaceTest_SetFlowControlSendDelay();				break;
				case 20:	EcuInterfaceTest_SetCanFirstConsecutiveFrameValue();	break;
				case 21:	EcuInterfaceTest_SetSingleMsgCanFormatId();				break;
				case 22:	EcuInterfaceTest_EnableSegmentedSendSingleCanFrame();	break;
				case 23:	EcuInterfaceTest_AddressCodeEnter();					break;
				case 24:	EcuInterfaceTest_QuickEnter();							break;
				case 25:	EcuInterfaceTest_TP20Enter();							break;
				case 26:	EcuInterfaceTest_TP16Enter();							break;
				case 27:	EcuInterfaceTest_TP20Broadcast();						break;
				case 28:	EcuInterfaceTest_SetRCXXHandling();						break;
				case 29:	EcuInterfaceTest_SetClearBuffer();						break;
				case 30:	EcuInterfaceTest_SendReceive();							break;
				case 31:	EcuInterfaceTest_SendReceive1();						break;
				case 32:	EcuInterfaceTest_SendReceive2();						break;
				case 33:	EcuInterfaceTest_GetPinStatus();						break;
				case 34:	EcuInterfaceTest_ActiveDoipPin();						break;
				case 35:	EcuInterfaceTest_SelectDoipOption();					break;
				case 36:	EcuInterfaceTest_GetDoipModule();						break;
				case 37:	EcuInterfaceTest_GetVersion();							break;
				case 38:	EcuInterfaceTest_GetVciTypeName();						break;
				case 39:	EcuInterfaceTest_IsVciConnected();						break;
				case 40:	EcuInterfaceTest_VciReset();							break;
				case 41:	EcuInterfaceTest_VciVehicleLedOn();						break;
				case 42:	EcuInterfaceTest_VciBuzzOn();							break;
				case 43:	EcuInterfaceTest_GetVciSN();							break;
				case 44:	EcuInterfaceTest_GetVciKey();							break;
				case 45:	EcuInterfaceTest_GetVciMcuId();							break;
				case 46:	EcuInterfaceTest_GetCommType();							break;
				case 47:	EcuInterfaceTest_Log();									break;
				case 0xFF:	EcuInterfaceTest_MultiInterface();						break;
				default:
					/*
					* 通讯接口测试
					* 请选择正确测试项
					*/
					ShowMsgBoxDemo(artiGetText("FF0000000021"), artiGetText("FF0000000008"), DF_MB_OK, m_uThread);
					break;
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_VciCommunication()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(50);
		vctColWidth.push_back(50);

#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("VciCommunication");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("Name"));
		vctHeads.push_back(artiGetText("Value"));
		uiList.SetHeads(vctHeads);

		/*
		* 连接方式    |  USB
		* 通信协议    |  CAN
		* 通信引脚    |  PIN6,PIN14
		* 通信波特率  |  500K
		* 测试命令    |  08 07 E0 02 1A 8E 00 00 00 00 00
		* 命令应答    |  08 07 E8 02 5A 8E 00 00 00 00 00
		* 循环次数    |  1000
		* 异常统计    |  1000
		*/

		uiList.AddItem(artiGetText("FF00000000C2"));	//连接方式
		uiList.AddItem(artiGetText("FF00000000C3"));	//通信协议
		uiList.AddItem(artiGetText("FF00000000C4"));	//通信引脚
		uiList.AddItem(artiGetText("FF00000000C5"));	//通信波特率
		uiList.AddItem(artiGetText("FF00000000C6"));    //测试命令
		uiList.AddItem(artiGetText("FF00000000C7"));    //命令应答
		uiList.AddItem(artiGetText("FF00000000C8"));    //通信时间
		uiList.AddItem(artiGetText("FF00000000C9"));    //异常统计

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		/////////////////////////////////

		CEcuInterface ecu;

		ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);
		ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		ecu.SetBaudRate(500 * 1000);
		ecu.SetCanFramePad(0x00);
		ecu.SetCommTime(0, 200, 1, 0);

		CBinary binMask = CBinary("\xFF\xFF\xFF\x00", 4);
		CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
		ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);

		CSendFrame SndFrame = CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO);

		////////////////////////////////

		bool bStart = false;
		uint32_t uCntFail = 0;
		uint32_t uCntTotal = 0;

		uiList.SetItem(0, 1, ecu.GetCommType());
		uiList.SetItem(1, 1, "CAN");
		uiList.SetItem(2, 1, "PIN6,PIN14");
		uiList.SetItem(3, 1, "500K");
		uiList.SetItem(4, 1, "08 07 E0 02 1A 8E 00 00 00 00 00");
		uiList.SetItem(5, 1, "");
		uiList.SetItem(6, 1, "0");
		uiList.SetItem(7, 1, "0");

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
				* 测试说明:
				*   ->1.通过循环发送CAN协议测试命令，测试VCI通信是否稳定;
				*/
				ShowMsgBoxDemo("VciCommunication", artiGetText("FF00000000A7"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				bStart = true;
				uiList.SetButtonStatus(1, (uint32_t)DF_ST_BTN_DISABLE);
			}

			if (bStart)
			{
				uCntTotal++;

				CRecvFrame recvFrame;
				recvFrame.Clear();

				ErrorCode_t restult = ecu.SendReceive(SndFrame, recvFrame);
				if (restult == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					uCntFail++;
				}
				if (recvFrame.IsEmpty())
				{
					uCntFail++;

					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, "%d", uCntFail);
					uiList.SetItem(7, 1, buff);
				}
				else
				{
					string strTemp = GetStringFromFrame(recvFrame);
					uiList.SetItem(5, 1, strTemp);
				}

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, "%d", uCntTotal);
				uiList.SetItem(6, 1, buff);
			}
		}
	}

	void CAPITest::EcuInterfaceTest_MultiInterface()
	{
		vector<uint32_t> vctIDMenu;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("ProtocolType");
		uiMenu.AddItem("PT_CAN");					vctIDMenu.push_back(0x01);
		uiMenu.AddItem("PT_CANFD");					vctIDMenu.push_back(0x02);
		uiMenu.AddItem("PT_TP20");					vctIDMenu.push_back(0x03);
		uiMenu.AddItem("PT_TP16");					vctIDMenu.push_back(0x04);
		uiMenu.AddItem("PT_VOLVO_CAN");				vctIDMenu.push_back(0x05);
		uiMenu.AddItem("PT_GMLAN_CAN");				vctIDMenu.push_back(0x06);
		uiMenu.AddItem("PT_KWP");					vctIDMenu.push_back(0x07);
		uiMenu.AddItem("PT_VPW");					vctIDMenu.push_back(0x08);
		uiMenu.AddItem("PT_PWM");					vctIDMenu.push_back(0x09);
		uiMenu.AddItem("PT_ISO");					vctIDMenu.push_back(0x0A);
		uiMenu.AddItem("PT_1281");					vctIDMenu.push_back(0x0B);
		uiMenu.AddItem("PT_ALDL");					vctIDMenu.push_back(0x0C);
		uiMenu.AddItem("PT_KW81");					vctIDMenu.push_back(0x0D);
		uiMenu.AddItem("PT_KW82");					vctIDMenu.push_back(0x0E);
		uiMenu.AddItem("PT_SCI");					vctIDMenu.push_back(0x0F);
		uiMenu.AddItem("PT_NGC");					vctIDMenu.push_back(0x10);
		uiMenu.AddItem("PT_NISSAN_OLD");			vctIDMenu.push_back(0x11);
		uiMenu.AddItem("PT_BMW_DOIP");				vctIDMenu.push_back(0x12);

		uiMenu.AddItem("PT_RAW_CAN");				vctIDMenu.push_back(0x81);
		uiMenu.AddItem("PT_RAW_CANFD");				vctIDMenu.push_back(0x82);

		//uiMenu.AddItem("INVALID");					vctIDMenu.push_back(0xFF);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (uRetBtn < vctIDMenu.size())
			{
				switch (vctIDMenu[uRetBtn])
				{
				case 0x01:		EcuInterfaceTest_MultiInterface_PT_CAN();						break;
				case 0x02:		EcuInterfaceTest_MultiInterface_PT_CANFD();						break;
				case 0x03:		EcuInterfaceTest_MultiInterface_PT_TP20();						break;
				case 0x04:		EcuInterfaceTest_MultiInterface_PT_TP16();						break;
				case 0x05:		EcuInterfaceTest_MultiInterface_PT_VOLVO_CAN();					break;
				case 0x06:		EcuInterfaceTest_MultiInterface_PT_GMLAN_CAN();					break;
				case 0x07:		EcuInterfaceTest_MultiInterface_PT_KWP();						break;
				case 0x08:		EcuInterfaceTest_MultiInterface_PT_VPW();						break;
				case 0x09:		EcuInterfaceTest_MultiInterface_PT_PWM();						break;
				case 0x0A:		EcuInterfaceTest_MultiInterface_PT_ISO();						break;
				case 0x0B:		EcuInterfaceTest_MultiInterface_PT_1281();						break;
				case 0x0C:		EcuInterfaceTest_MultiInterface_PT_ALDL();						break;
				case 0x0D:		EcuInterfaceTest_MultiInterface_PT_KW81();						break;
				case 0x0E:		EcuInterfaceTest_MultiInterface_PT_KW82();						break;
				case 0x0F:		EcuInterfaceTest_MultiInterface_PT_SCI();						break;
				case 0x10:		EcuInterfaceTest_MultiInterface_PT_NGC();						break;
				case 0x11:		EcuInterfaceTest_MultiInterface_PT_NISSAN_OLD();				break;
				case 0x12:		EcuInterfaceTest_MultiInterface_PT_BMW_DOIP();					break;
				case 0x81:		EcuInterfaceTest_MultiInterface_PT_RAW_CAN();					break;
				case 0x82:		EcuInterfaceTest_MultiInterface_PT_RAW_CANFD();					break;

				default:
					/*
					* 通讯接口测试
					* 请选择正确测试项
					*/
					ShowMsgBoxDemo(artiGetText("FF0000000021"), artiGetText("FF0000000008"), DF_MB_OK, DT_CENTER, -1, m_uThread);
					break;
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_CAN(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_CAN*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		/*
		* 通信配置：
		* 通信协议： PT_CAN
		* 通信引脚： PIN_OBD_06,PIN_OBD_14
		* 波特率为： 500 * 1000
		* 发送命令：
		*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
		*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
		*/

		ShowMsgBoxDemo("PT_CAN", artiGetText("FF0000000055"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		CEcuInterface ecu;

		ecu.SetProtocolType(eProtocolType, eBitFormat);
		ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		ecu.SetBaudRate(500 * 1000);
		ecu.SetCanFramePad(0x00);
		ecu.SetCommTime(0, 1000, 10, 0);
		ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_EXCHANGE_2BYTES);

		CBinary binMask = CBinary("\xFF\xFF\xFF\x00", 4);
		CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
		ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);

		vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
		vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 1 * 1000);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("PT_CAN", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_CANFD(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_CANFD*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		/*
		* 通信配置：
		* 通信协议： PT_CANFD
		* 通信引脚： PIN_OBD_06,PIN_OBD_14
		* Bps为   ： 500K
		* FdBps为 ： 5M
		* 发送命令：
		*   -> REQ : 08 07 E0 02 3E 00 55 55 55 55 55
		*   -> REQ : 08 07 E0 02 1A 8E 55 55 55 55 55
		*/
		ShowMsgBoxDemo("PT_CANFD", artiGetText("FF00000000A5"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		ErrorCode_t retCode = ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;
		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CANFD);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetProtocolType", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetIoPin", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(500 * 1000, 5 * 1000 * 1000);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCanFramePad(0x55);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetCanFramePad", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		//retCode = ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_EXCHANGE_2BYTES);
		//if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		//{
		//	ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
		//	return;
		//}

		CBinary binMask = CBinary("\xFF\xFF\xFF\x00", 4);
		CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
		retCode = ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetFilterId", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(0, 500, 50, 0);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetCommTime", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		/*
		REQ : 08 07 E0 02 3E 00 00 00 00 00 00  69430MS
		0000: 08 07 E8 06 49 00 00 00 00 00 00  1MS
		REQ : 08 07 E0 02 1A 8E 00 00 00 00 00  2013MS
		0001: 08 07 E8 06 49 11 11 11 11 11 00  1MS
		*/
		vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
		vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("PT_CANFD", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_TP20(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_TP20*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		uint8_t TpTargetAddress = 0x01;
		uint8_t AppLayerID = 0x01;

		/*
		* 通信配置：
		* 通信协议为： PT_TP20
		* 通信引脚为： PIN_OBD_06,PIN_OBD_14
		* 波特率为：   500K
		* 0x01系统TP20Enter
		*   ->发送 : 07 02 00 01 C0 00 10 00 03 01
		*   ->接收 : 07 02 01 00 D0 00 03 40 07 01
		*   ->发送 : 06 07 40 A0 0F 8A FF 00 FF
		*   ->接收 : 06 03 00 A1 0F 8A FF 4A FF
		*   ->链路 : 01 07 40 A3
		* 发送命令：
		*   -> 发送 : 05 07 40 10 00 02 10 89
		*   -> 发送 : 07 07 40 11 00 04 31 B8 00 00
		*/
		ShowMsgBoxDemo("TP20Enter", artiGetText("FF000000007D"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		CEcuInterface ecu;
		ecu.SetProtocolType(eProtocolType, eBitFormat);
		ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		ecu.SetBaudRate(500 * 1000);
		ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW);
		ecu.SetCommTime(10, 500, 50, 10);

		CRecvFrame ReceiveFrame;
		retErrCode = ecu.TP20Enter(TpTargetAddress, ReceiveFrame, AppLayerID);
		if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
		{
			ShowMsgBoxDemo("PT_TP20", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		if (!ReceiveFrame.GetSize())
		{
			//快速进入失败，请检测模拟数据是否正确。
			ShowMsgBoxDemo("PT_TP20", artiGetText("FF000000007B"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return;
		}

		ShowEstablishComMsg();

		vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary("\x10\x89", 2), 1));
		vctSendFrame.push_back(CSendFrame(CBinary("\x31\xB8\x00\x00", 4), 1));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("PT_TP20", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_TP16(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_TP16*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		uint32_t EnterSysId = 0x2D0;
		uint32_t EnterFilterId = 0x2F1;
		uint32_t TargetAddr = 0x311;
		uint8_t EnterAddressCode = 0x25;
		uint8_t SystemId = 0x11;

		/*
		* 通信配置：
		* 通信协议为： PT_TP16
		* 通信引脚为： PIN_OBD_06,PIN_OBD_14
		* 波特率为：   500K
		* 0x11系统TP16Enter
		*   REQ : 03 02D0 11 C0 11
		*   Ans : 03 02F1 00 D0 A1
		*
		*   REQ : 06 0311 A0 0F 8A FF 00 FF
		*   Ans : 06 03A1 A1 03 94 54 00 D9
		*
		*   REQ : 02 0311 30 25
		*   Ans : 04 03A1 10 55 6B 8F
		*
		*   REQ : 02 0311 30 70
		*   Ans : 02 03A1 10 DA
		*
		* 发送命令：
		*   -> 发送 : 82 C0 F1 1A 87 D4
		*   -> 发送 : 84 C0 F1 31 B8 00 00 1E
		*/
		ShowMsgBoxDemo("PT_TP16", artiGetText("FF00000000A2"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		CEcuInterface ecu;
		ecu.SetProtocolType(eProtocolType, eBitFormat);
		ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		ecu.SetBaudRate(500 * 1000);
		ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW);
		ecu.SetCommTime(10, 500, 50, 10);

		CRecvFrame ReceiveFrame;
		retErrCode = ecu.TP16Enter(EnterSysId, EnterFilterId, TargetAddr, EnterAddressCode, SystemId, ReceiveFrame);
		if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
		{
			ShowMsgBoxDemo("PT_TP16", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		if (!ReceiveFrame.GetSize())
		{
			//快速进入失败，请检测模拟数据是否正确。
			ShowMsgBoxDemo("TP16Enter", artiGetText("FF000000007B"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return;
		}

		ShowEstablishComMsg();

		CBinary keepBin = CBinary("\x81\xC0\xF1\x3E\x70", 5);
		CSendFrame KeepFrame(keepBin, 0);
		ecu.SetLinkKeep(1000, KeepFrame, CStdCommMaco::LinkKeepType::LKT_INTERVAL);

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary("\x82\xC0\xF1\x1A\x87\xD4", 6), 1));
		vctSendFrame.push_back(CSendFrame(CBinary("\x84\xC0\xF1\x31\xB8\x00\x00\x1E", 8), 1));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("PT_TP16", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_VOLVO_CAN(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_VOLVO_CAN*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment();  return;
		ErrorCode_t retCode = ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;
		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_VOLVO_CAN);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(500 * 1000);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		//retCode = ecu.SetCanExtendedAddress(0x50);
		//if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		//{
		//	ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
		//	return;
		//}

		unsigned char filterMask[4] = { 0x00, 0x00, 0x00, 0x03 };
		unsigned char filterPattern[4] = { 0x00, 0x00, 0x00, 0x03 };
		retCode = ecu.SetFilterId(filterMask, filterPattern, 4);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(0, 500, 50, 0);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xB9\xF0", 2), CSendFrame::SF_RECEIVE_AUTO));
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xAE\x1B", 2), CSendFrame::SF_RECEIVE_AUTO));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_GMLAN_CAN(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_GMLAN_CAN*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment();
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_KWP(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_KWP*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{

		uint32_t KeepTimeMs = 1000;
		CSendFrame KeepFrame = CSendFrame(CBinary("\x81\x28\xF1\x3E\x00", 5));
		CStdCommMaco::LinkKeepType KeepType = CStdCommMaco::LinkKeepType::LKT_INTERVAL;

		/*
		* 通信配置：
		* 通信协议： PT_KWP
		* 通信引脚： PIN_OBD_07,PIN_OBD_15
		* 波特率为： 10400
		* 发送命令：
		*   -> REQ : 82 28 F1 10 89 34
		*   -> REQ : 84 28 F1 31 B8 00 00 6E
		*/
		ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF0000000068"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		CEcuInterface ecu;

		ecu.SetProtocolType(eProtocolType, eBitFormat);
		ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
		ecu.SetBaudRate(10400);
		ecu.SetCommTime(20, 800, 100, 5);

		ecu.SetLinkKeep(KeepTimeMs, KeepFrame, KeepType);

		vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
		vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 5000);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_VPW(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_VPW*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		/*
		* 通信配置：
		* 通信协议： PT_VPW
		* 通信引脚： PIN_OBD_07,PIN_OBD_07
		* 波特率为： 10400
		* 发送命令：
		*   -> REQ : 6C 10 F1 20 64
		*   -> REQ : 6C 10 F1 3C 01 05
		*/
		ShowMsgBoxDemo("PT_VPW", artiGetText("FF00000000A6"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;

		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_VPW);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetProtocolType", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_07);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetIoPin", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(10400);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(20, 800, 100, 1);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetCommTime", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		unsigned char filterMask[3] = { 0x00, 0xFF, 0xFF };
		unsigned char filterPattern[3] = { 0x00, 0xF1, 0x10 };
		retCode = ecu.SetFilterId(filterMask, filterPattern, 3);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return;
		}

		/*
		REQ : 6C 10 F1 20 64  1122575MS
		0000: 6C F1 10 60 00 FF FF FF FF E1 BF
		REQ : 6C 10 F1 3C 01 05  841MS
		0001: 6C F1 10 7C 00 FF FF FF FF E1 BD
		*/
		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x6C\x10\xF1\x20\x64", 5), CSendFrame::SF_RECEIVE_AUTO));
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x6C\x10\xF1\x3C\x01\x05", 6), 1));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("PT_VPW", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_PWM(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_PWM*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		/*
		* 通信配置：
		* 通信协议： PT_PWM
		* 通信引脚： PIN_OBD_02,PIN_OBD_10
		* 波特率为： 41600
		* 发送命令：
		*   -> 发送 :  C4 10 F1 10 E0
		*   -> 发送 :  C4 10 F5 10 E0
		*/
		ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF0000000088"), DF_MB_OK, DT_LEFT, -1, m_uThread);

		ShowEstablishComMsg();

		ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;
		retCode = ecu.SetProtocolType(eProtocolType, eBitFormat);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_02, CStdCommMaco::ObdPinType::PIN_OBD_10);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(41600);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(0, 500, 20, 0, 1000);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		uint8_t NodeAddress = 0xF1;
		retCode = ecu.SetJ1850NodeAddress(NodeAddress);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.clear();
		vctSendFrame.push_back(CSendFrame(CBinary("\xC4\x10\xF1\x10\xE0", 5), 1));
		vctSendFrame.push_back(CSendFrame(CBinary("\xC4\x10\xF5\x10\xE0", 5), 1));
		//vctSendFrame.push_back(CSendFrame(CBinary("\xC4\x10\xF5\x3F\xDC", 5), CSendFrame::SF_RECEIVE_AUTO_EX));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);// 命令返回值

		ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_ISO(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_ISO*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{

		/*
		* 通信配置：
		* 通信协议： PT_CAN
		* 通信引脚： NA
		* 波特率为： 500K
		* 发送命令：
		*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
		*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
		*/

		ShowMsgBoxDemo("PT_ISO", artiGetText("FF0000000065"), DF_MB_OK, DT_LEFT, -1, m_uThread);
		ShowEstablishComMsg();

		ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;
		CEcuInterface ecu;
		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_ISO);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetProtocolType", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_07);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetIoPin", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(10400);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(20, 800, 100, 0);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetCommTime", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xC1\x33\xF1\x81\x66", 5), CSendFrame::SF_RECEIVE_AUTO));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 500);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

		ShowMsgBoxDemo("PT_ISO", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_1281(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_1281*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment(); return;
		CEcuInterface ecu;

		auto retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_1281);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(500000);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(20, 200, 100, 5);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		unsigned char AddressCode = 0x01;
		CRecvFrame recvFrame;

		uint32_t KLine_W0_MS = 5000, KLine_W1_MAX_MS = 1000, KLine_W2_W3_MAX_MS = 550, KLine_W4_MIN_MS = 10;
		retCode = ecu.AddressCodeEnter(AddressCode,
			recvFrame, 5,
			CStdCommMaco::AddressEnterParaType::AEPT_AUTO_BAUDRATE | CStdCommMaco::AddressEnterParaType::AEPT_SEND_KW2_REVERSED | CStdCommMaco::AddressEnterParaType::AEPT_RECV_2_KWS,
			KLine_W0_MS,
			KLine_W1_MAX_MS,
			KLine_W2_W3_MAX_MS,
			KLine_W4_MIN_MS,
			1000);

		if (recvFrame.IsEmpty())
		{
			return;
		}

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x04\x00\x29\x01\x03", 5), 0));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));

		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x04\x00\x29\x01\x03", 5), 0));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));

		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x04\x00\x29\x01\x03", 5), 0));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));

		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x04\x00\x29\x01\x03", 5), 0));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));
		vctSendFrame.push_back(CSendFrame(CBinary(), 1));

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 20);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_ALDL(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_ALDL*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment();
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_KW81(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_KW81*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment();
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_KW82(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_KW82*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment(); return;

		ErrorCode_t retCode = ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;
		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KW82);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_03, CStdCommMaco::ObdPinType::PIN_OBD_03);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(9600);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(7, 500, 7, 1);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		unsigned char AddressCode = 0x62;
		CRecvFrame recvFrame;

		uint32_t KLine_W0_MS = 5000, KLine_W1_MAX_MS = 1000, KLine_W2_W3_MAX_MS = 550, KLine_W4_MIN_MS = 25;
		retCode = ecu.AddressCodeEnter(AddressCode,
			recvFrame, 5,
			CStdCommMaco::AddressEnterParaType::AEPT_AUTO_BAUDRATE | CStdCommMaco::AddressEnterParaType::AEPT_SEND_KW2_REVERSED,
			KLine_W0_MS,
			KLine_W1_MAX_MS,
			KLine_W2_W3_MAX_MS,
			KLine_W4_MIN_MS,
			1000);

		if (recvFrame.IsEmpty())
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		// 回 26 A1 08 2C 1F 21 00 3F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 FF FF 00 00 00 00 F0 F0 00 80 FF 00 00 47 07 26
		CSendFrame ReadSnapshotFrameTx(CBinary((const uint8_t*)"\x02\x11\x00\x13", 4), 1);

		// 回 22 A0 4E 4E 20 39 32 30 39 39 37 32 36 20 53 30 33 32 32 38 32 34 20 34 34 32 39 33 36 20 34 32 30 33 07 47
		CSendFrame ReadEcuIdFrameTx(CBinary((const uint8_t*)"\x02\x10\x00\x12", 4), 1);

		// 回 不需要回复
		CSendFrame ExitSysFrameTx(CBinary((const uint8_t*)"\x02\xB2\x00\xB4", 4), 0);   // End of diagnosis 

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.emplace_back(ReadSnapshotFrameTx);
		vctSendFrame.emplace_back(ReadEcuIdFrameTx);
		vctSendFrame.emplace_back(ExitSysFrameTx);
		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_SCI(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_SCI*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment(); return;
		ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;

		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_SCI);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		//retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_07);
		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_12, CStdCommMaco::ObdPinType::PIN_OBD_07);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(62500);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(15, 100, 50, 30);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		CSendFrame ReturnLowSpeedFrameTx(CBinary((const uint8_t*)"\xFE", 1), 1);            // 切换到低速波特率

		/* MODE $10 Request Diagnostic Trouble Codes (SCI Fault IDs) */
		CSendFrame RequestDTC_FrameTx(CBinary((const uint8_t*)"\x10", 1), 1);               // 请求DTC

		/* MODE $12  Request High-Speed Data Parameter / RAM Memory Interrogation */
		CSendFrame RequestHighSpeedFrameTx(CBinary((const uint8_t*)"\x12\xF4\x0A", 3), 1);  // 切换到高速波特率

		/* MODE $14  Request Sensor Information */
		CSendFrame RequestSensor_FrameTx(CBinary((const uint8_t*)"\x14\x46", 2), 1);        // 请求 Sensor 信息

		/* Enable Common F-Table Interrogation */
		std::vector<CSendFrame> vctEnableCommonFrame;
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x0B", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x18", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x19", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x17", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x19", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF5\xE4", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x12", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x14", 2), 1));
		vctEnableCommonFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\xF4\x13", 2), 1));

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(ReturnLowSpeedFrameTx);

		vctSendFrame.push_back(RequestDTC_FrameTx);
		vctSendFrame.push_back(RequestDTC_FrameTx);
		vctSendFrame.push_back(RequestDTC_FrameTx);
		vctSendFrame.push_back(RequestSensor_FrameTx);

		vctSendFrame.push_back(RequestHighSpeedFrameTx);
		vctSendFrame.insert(vctSendFrame.end(), vctEnableCommonFrame.begin(), vctEnableCommonFrame.end());

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 100000, 30);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_NGC(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_NGC*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment(); return;
		ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;

		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_NGC);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_12, CStdCommMaco::ObdPinType::PIN_OBD_07);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(7812);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(15, 100, 50, 50);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		/* MODE $10 Request Diagnostic Trouble Codes (SCI Fault IDs) */
		CSendFrame RequestDTC_FrameTx(CBinary((const uint8_t*)"\x10", 1), 1);               // 请求DTC

		std::vector<CSendFrame> vctSendFrame;;
		vctSendFrame.push_back(RequestDTC_FrameTx);

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 3, 500);
		ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_NISSAN_OLD(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_NISSAN_OLD*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment();
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_BMW_DOIP(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_BMW_DOIP*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment();
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_RAW_CAN(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_RAW_CAN*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment(); return;
		ErrorCode_t retCode = ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(500000);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		ecu.ClearFilter();

		unsigned char filterMask[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
		unsigned char filterPattern[4] = { 0x00, 0x00, 0x07, 0xE8 };
		retCode = ecu.SetFilterId(filterMask, filterPattern, 4);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetCommTime(0, 500, 50, 0);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		//CSendFrame sf = CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x55\x55\x55\x55\x55", 12), 1);
		CSendFrame sf = CSendFrame(CBinary((const uint8_t*)"\x00\x00\x01\x01\xFE\x01\x3E\x00\x00\x00\x00\x00", 12), 1);
		retCode = ecu.SetLinkKeep(1000, sf, CStdCommMaco::LinkKeepType::LKT_INTERVAL);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		std::vector<CSendFrame> vctSendFrame;
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x01\x00\x00\x00\x00\x00\x00", 12), 1));
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x55\x55\x55\x55\x55", 12), 1));
		//vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x03\x22\xF1\x90\x00\x00\x00\x00", 12), 1));
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x1A\x90\x55\x55\x55\x55\x55", 12), 1));
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x01\x01\x00\x00\x00\x00\x00", 12), 1));
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x10\x03\xFF\xFF\xFF\xFF\xFF", 12), 1));

		//Sleep(300);

		string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 1200);

		filterPattern[3] = 0xE9;
		retCode = ecu.SetFilterId(filterMask, filterPattern, 4);
		vctSendFrame.push_back(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE1\x02\x01\x00\x00\x00\x00\x00\x00", 12), 1));

		strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 1200);
	}

	void CAPITest::EcuInterfaceTest_MultiInterface_PT_RAW_CANFD(CStdCommMaco::ProtocolType eProtocolType /*= CStdCommMaco::ProtocolType::PT_RAW_CANFD*/, CStdCommMaco::BitFormatType eBitFormat /*= CStdCommMaco::BitFormatType::BFT_1_8_1_N*/)
	{
		ShowFuncInDevelopment(); return;
		ErrorCode_t retCode = ErrorCodeType::STATUS_NOERROR;

		CEcuInterface ecu;
		retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_RAW_CANFD);
		//retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_RAW_CAN);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		retCode = ecu.SetBaudRate(500 * 1000, 5 * 1000);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		//unsigned char filterMask[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
		//unsigned char filterPattern[4] = { 0x00, 0x00, 0x07, 0xE8 };
		//if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		//{
		//	ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
		//	return;
		//}

		retCode = ecu.SetCommTime(0, 500, 50, 0);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
			return;
		}

		std::vector<CMultiSendFrame> vctSendFrame;
		CMultiSendFrame multiSendFrame;

		// USB死机
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x10\x53\x2A\x2A\x2A\x01\x02\x03", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x21\x03\x04\x05\x06\x08\x09\x0E", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x22\x10\x11\x13\x8B\x34\x15\x16", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x23\x17\x17\x18\x19\x1B\x1E\x20", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x24\x22\x28\x2E\x30\x36\x3C\x3D", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x25\x3E\x42\x46\x47\x52\x53\x55", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x26\x56\x57\x85\x5F\x62\x26\x65", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x27\x69\x6C\x6D\x6F\x72\x3B\x7F", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x28\x82\x84\x48\x5B\x88\x89\x8A", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x29\x8D\x8F\x90\xAC\x44\x81\x8E", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x2A\xC0\xA9\x40\x51\x8C\xBA\x14", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x2B\x00\x00\x00\x00\x00\x00\x00", 12), 0));

		// ERR_TIMEOUT
		/*multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x10\x53\x2A\x2A\x2A\x01\x02\x03", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x21\x03\x04\x05\x06\x08\x09\x0E", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x22\x10\x11\x13\x8B\x34\x15\x16", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x23\x17\x17\x18\x19\x1B\x1E\x20", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x24\x22\x28\x2E\x30\x36\x3C\x3D", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x25\x3E\x42\x46\x47\x52\x53\x55", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x26\x56\x57\x85\x5F\x62\x26\x65", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x27\x69\x6C\x6D\x6F\x72\x3B\x7F", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x28\x82\x84\x48\x5B\x88\x89\x8A", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x29\x8D\x8F\x90\xAC\x44\x81\x8E", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x02\x3E\x00\x00\x00\x00\x00\x00", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x2A\xC0\xA9\x40\x51\x8C\xBA\x14", 12), 0));
		multiSendFrame.Append(CSendFrame(CBinary((const uint8_t*)"\x00\x00\x07\xE0\x2B\x00\x00\x00\x00\x00\x00\x00", 12), 0));*/

		vctSendFrame.push_back(multiSendFrame);

		auto fnSendRecvLoop = [](CEcuInterface* ptrEcu, const std::vector<CMultiSendFrame>& vctSendFrame, std::size_t Counts)
		{
			CRecvFrame RecvFrame;
			for (std::size_t loopCnt = 0; loopCnt < Counts; loopCnt++)
			{
				for (auto& TxFrame : vctSendFrame)
				{
					CMultiRecvFrame recvFrame;
					recvFrame.Clear();

					ErrorCode_t restult = ptrEcu->SendReceive(TxFrame, recvFrame);
					if (restult == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
						break;

					if (recvFrame.IsEmpty())
					{
						printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!\r\n");
						return;
					}
				}
			}

			return;
		};

		fnSendRecvLoop(&ecu, vctSendFrame, 500);
		std::this_thread::sleep_for(std::chrono::seconds(3));
		return;
	}

	void CAPITest::EcuInterfaceTest_SetProtocolType()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		string streProtocolType = "PT_CAN";
		string streBitFormat = "BFT_1_8_1_N";

		CStdCommMaco::ProtocolType eProtocolType = CStdCommMaco::ProtocolType::PT_CAN;
		CStdCommMaco::BitFormatType eBitFormat = CStdCommMaco::BitFormatType::BFT_1_8_1_N;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetProtocolType");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("eProtocolType");
		uiList.AddItem("eBitFormat");

		uiList.SetItem(0, 1, streProtocolType);
		uiList.SetItem(1, 1, streBitFormat);

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
				* 测试说明:
				*   ->1.eProtocolType : 通过模拟通信，来判断参数设置是否正常；
				*   ->2.eBitFormat    : 通过模拟通信，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF00000000A3"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				if (CStdCommMaco::ProtocolType::PT_CAN == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_CAN(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_CANFD == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_CANFD(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_TP20 == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_TP20(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_TP16 == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_TP16(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_VOLVO_CAN == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_VOLVO_CAN(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_GMLAN_CAN == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_GMLAN_CAN(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_KWP == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_KWP(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_VPW == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_VPW(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_PWM == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_PWM(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_ISO == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_ISO(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_1281 == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_1281(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_ALDL == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_ALDL(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_KW81 == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_KW81(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_KW82 == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_KW82(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_SCI == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_SCI(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_NGC == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_NGC(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_NISSAN_OLD == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_NISSAN_OLD(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_BMW_DOIP == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_BMW_DOIP(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_RAW_CAN == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_RAW_CAN(eProtocolType, eBitFormat);
				}
				else if (CStdCommMaco::ProtocolType::PT_RAW_CANFD == eProtocolType)
				{
					EcuInterfaceTest_MultiInterface_PT_RAW_CANFD(eProtocolType, eBitFormat);
				}
				else
				{
					ShowFuncInDevelopment();	continue;
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(eProtocolType, streProtocolType, mapProtocolType);
					uiList.SetItem(0, 1, streProtocolType);
				}
				else if (1 == uSelect)
				{
					GetParamValue(eBitFormat, streBitFormat, mapBitFormatType);
					uiList.SetItem(1, 1, streBitFormat);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetIoPin()
	{
		uint8_t uPos = 0;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string	strProtocolType = "PT_KWP";
		string strIoOutputPin = "PIN_OBD_07";
		string strIoInputPin = "PIN_OBD_15";
		string strWorkVoltage = "PinVol_12V";
		string strPinProperty = "PPT_SAME_SIGNAL_K_AND_L_LINE | PPT_INPUT_POSITIVE_LOGIC | PPT_OUTPUT_POSITIVE_LOGIC";

		CStdCommMaco::ProtocolType eProtocolType = CStdCommMaco::ProtocolType::PT_KWP;
		CStdCommMaco::ObdPinType IoOutputPin = CStdCommMaco::ObdPinType::PIN_OBD_07;
		CStdCommMaco::ObdPinType IoInputPin = CStdCommMaco::ObdPinType::PIN_OBD_15;
		CStdCommMaco::PinVoltageType WorkVoltage = CStdCommMaco::PinVoltageType::PinVol_12V;
		CStdCommMaco::PinPropertyType PinProperty = CStdCommMaco::PinPropertyType::PPT_SAME_SIGNAL_K_AND_L_LINE | CStdCommMaco::PinPropertyType::PPT_INPUT_POSITIVE_LOGIC | CStdCommMaco::PinPropertyType::PPT_OUTPUT_POSITIVE_LOGIC;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetIoPin");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("ProtocolType");
		uiList.AddItem("IoOutputPin");
		uiList.AddItem("IoInputPin");
		uiList.AddItem("WorkVoltage");
		uiList.AddItem("PinProperty");

		uiList.SetItem(uPos++, 1, strProtocolType);
		uiList.SetItem(uPos++, 1, strIoOutputPin);
		uiList.SetItem(uPos++, 1, strIoInputPin);
		uiList.SetItem(uPos++, 1, strWorkVoltage);
		uiList.SetItem(uPos++, 1, strPinProperty);


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
				* 测试说明:
				*   ->1.IoOutputPin : 通过模拟KWP和CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoOutputPin设置是否正常；
				*   ->2.IoInputPin  : 通过模拟CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoInputPin设置是否正常；
				*   ->3.WorkVoltage : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压，来判断WorkVoltage设置是否正常；
				*   ->4.PinProperty : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压和波形，来判断PinProperty设置是否正常；
				*/
				ShowMsgBoxDemo("SetIoPin", artiGetText("FF0000000063"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				if (eProtocolType == CStdCommMaco::ProtocolType::PT_KWP)
				{
					/*
					* 通信配置：
					* 通信协议： PT_KWP
					* 通信引脚： NA
					* 波特率为： 10400
					* 发送命令：
					*   -> REQ : 82 28 F1 10 89 34
					*   -> REQ : 84 28 F1 31 B8 00 00 6E
					*/
					ShowMsgBoxDemo("SetIoPin", artiGetText("FF0000000064"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					CEcuInterface ecu;
					ecu.SetProtocolType(eProtocolType);
					ecu.SetIoPin(IoOutputPin, IoInputPin, WorkVoltage, PinProperty);
					ecu.SetBaudRate(10400);
					ecu.SetCommTime(20, 800, 100, 5);

					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
					vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 500);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetIoPin", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else if (eProtocolType == CStdCommMaco::ProtocolType::PT_CAN)
				{

					/*
					* 通信配置：
					* 通信协议： PT_CAN
					* 通信引脚： NA
					* 波特率为： 500K
					* 发送命令：
					*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
					*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
					*/

					ShowMsgBoxDemo("SetIoPin", artiGetText("FF0000000065"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					CEcuInterface ecu;
					ecu.SetProtocolType(eProtocolType);//设置协议类型
					ecu.SetIoPin(IoOutputPin, IoInputPin, WorkVoltage, PinProperty);
					ecu.SetBaudRate(500 * 1000);
					ecu.SetCanFramePad(0x00);
					ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

					CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
					CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
					ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);

					ecu.SetCommTime(10, 300, 50, 10);

					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetProtocolType", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else
				{
					/*
					* 协议类型，请选择PT_KWP或者PT_CAN!
					*/
					ShowMsgBoxDemo("SetIoPin", artiGetText("FF0000000062"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
			else if(DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(eProtocolType, strProtocolType, mapProtocolType);
					uiList.SetItem(0, 1, strProtocolType);
				}
				else if (1 == uSelect)
				{
					GetParamValue(IoInputPin, strIoInputPin, mapObdPinType);
					uiList.SetItem(1, 1, strIoOutputPin);
				}
				else if (2 == uSelect)
				{
					GetParamValue(IoInputPin, strIoInputPin, mapObdPinType);
					uiList.SetItem(2, 1, strIoInputPin);
				}
				else if (3 == uSelect)
				{
					GetParamValue(WorkVoltage, strWorkVoltage, mapPinVoltageType);
					uiList.SetItem(3, 1, strWorkVoltage);
				}
				else if (4 == uSelect)
				{
					GetParamValueWithCheckBox(PinProperty, strPinProperty, mapPinPropertyType);
					uiList.SetItem(4, 1, strPinProperty);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetBaudRate()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strBps = "10400";
		string strFdBps = "0";

		uint32_t Bps = 10400;
		uint32_t FdBps = 0;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetBaudRate");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("Bps");
		uiList.AddItem("FdBps");

		uiList.SetItem(0, 1, strBps);
		uiList.SetItem(1, 1, strFdBps);

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
				* 测试说明:
				*   ->1.Bps : 通过模拟KWP和CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断Bps设置是否正常；
				*   ->2.FdBps : 使用示波器和逻辑分析仪测试引脚波形，来判断FdBps设置是否正常；
				*/
				ShowMsgBoxDemo("SetBaudRate", artiGetText("FF0000000066"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				if (9600 == Bps || 10400 == Bps || 33333 == Bps)
				{
					/*
					* 通信配置：
					* 通信协议： PT_KWP
					* 通信引脚： PIN_OBD_07,PIN_OBD_15
					* 波特率为： NA
					* 发送命令：
					*   -> REQ : 82 28 F1 10 89 34
					*   -> REQ : 84 28 F1 31 B8 00 00 6E
					*/

					ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000005B"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					CEcuInterface ecu;

					ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
					ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
					ecu.SetBaudRate(Bps);
					ecu.SetCommTime(20, 800, 100, 5);

					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
					vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 500);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else if ((250 * 1000 == Bps || 500 * 1000 == Bps) && (0 == FdBps))
				{
					/*
					* 通信配置：
					* 通信协议： PT_CAN
					* 通信引脚： PIN_OBD_06,PIN_OBD_14
					* 波特率为： NA
					* 发送命令：
					*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
					*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
					*/

					ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000005A"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					CEcuInterface ecu;
					ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
					ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
					ecu.SetBaudRate(Bps, FdBps);
					ecu.SetCanFramePad(0x00);
					ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

					CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
					CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
					ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);

					ecu.SetCommTime(10, 300, 50, 10);

					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else
				{
					ShowFuncInDevelopment();
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(Bps, strBps, mapBaudRate);
					uiList.SetItem(0, 1, strBps);
				}
				else if (1 == uSelect)
				{
					GetParamValue(FdBps, strFdBps, mapBaudRate);
					uiList.SetItem(1, 1, strFdBps);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetLinkKeep()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strKeepTimeMs = "1000";
		string strKeepFrame = "81 28 F1 3E 00";
		string strKeepType = "LKT_INTERVAL";

		uint32_t KeepTimeMs = 1000;
		CSendFrame KeepFrame = CSendFrame(CBinary("\x81\x28\xF1\x3E\x00", 5));
		CStdCommMaco::LinkKeepType KeepType = CStdCommMaco::LinkKeepType::LKT_INTERVAL;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetLinkKeep");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("KeepTimeMs");
		uiList.AddItem("KeepFrame");
		uiList.AddItem("KeepType");

		uiList.SetItem(0, 1, strKeepTimeMs);
		uiList.SetItem(1, 1, strKeepFrame);
		uiList.SetItem(2, 1, strKeepType);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.KeepTimeMs : 通过模拟KWP和CAN通信，观察链路保持时间间隔，来判断KeepTimeMs设置是否正常；
				*   ->2.KeepFrame  : 通过模拟KWP和CAN通信，观察链路保持命令，来判断KeepFrame设置是否正常；
				*   ->3.KeepType : 通过模拟KWP和CAN通信，观察链路保持时间间隔，来判断KeepType设置是否正常；
				*/
				ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF0000000067"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				 * 通信配置：
				 * 通信协议： PT_KWP
				 * 通信引脚： PIN_OBD_07,PIN_OBD_15
				 * 波特率为： 10400
				 * 发送命令：
				 *   -> REQ : 82 28 F1 10 89 34
				 *   -> REQ : 84 28 F1 31 B8 00 00 6E
				 */
				ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF0000000068"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;

				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
				ecu.SetBaudRate(10400);
				ecu.SetCommTime(20, 800, 100, 5);

				ecu.SetLinkKeep(KeepTimeMs, KeepFrame, KeepType);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 5000);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(KeepTimeMs, strKeepTimeMs, mapUint32ToString);
					uiList.SetItem(0, 1, strKeepTimeMs);
				}
				else if (1 == uSelect)
				{
					GetKeepFrame(KeepFrame, strKeepFrame);
					uiList.SetItem(1, 1, strKeepFrame);
				}
				else if (2 == uSelect)
				{
					GetParamValue(KeepType, strKeepType, mapLinkKeepType);
					uiList.SetItem(2, 1, strKeepType);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetLinkKeep1()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strKeepTimeMs = "1000";
		string strKeepFrame = "81 28 F1 3E 00";
		string strKeepType = "LKT_INTERVAL";
		string strResponesd = "81 F1 28 7E 40";
		string strbImmediatelyEnable = "true";

		uint32_t KeepTimeMs = 1000;
		CSendFrame KeepFrame = CSendFrame(CBinary("\x81\x28\xF1\x3E\x00", 5));
		CStdCommMaco::LinkKeepType KeepType = CStdCommMaco::LinkKeepType::LKT_INTERVAL;
		CRecvFrame Responesd = CRecvFrame(CBinary("\x81\xF1\x28\x7E\x40", 5));
		bool bImmediatelyEnable = true;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetLinkKeep");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("KeepTimeMs");
		uiList.AddItem("KeepFrame");
		uiList.AddItem("KeepType");
		uiList.AddItem("Responesd");
		uiList.AddItem("bImmediatelyEnable");

		uiList.SetItem(0, 1, strKeepTimeMs);
		uiList.SetItem(1, 1, strKeepFrame);
		uiList.SetItem(2, 1, strKeepType);
		uiList.SetItem(3, 1, strResponesd);
		uiList.SetItem(4, 1, strbImmediatelyEnable);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.KeepTimeMs : 通过模拟KWP和CAN通信，观察链路保持时间间隔，来判断KeepTimeMs设置是否正常；
				*   ->2.KeepFrame  : 通过模拟KWP和CAN通信，观察链路保持命令，来判断KeepFrame设置是否正常；
				*   ->3.KeepType   : 通过模拟KWP和CAN通信，观察链路保持时间间隔，来判断KeepType设置是否正常；
				*   ->3.bImmediatelyEnable : 通过模拟KWP和CAN通信，观察链路保持时间间隔，来判断bImmediatelyEnable设置是否正常；
				*/
				ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF0000000069"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_KWP
				* 通信引脚： PIN_OBD_07,PIN_OBD_15
				* 波特率为： 10400
				* 发送命令：
				*   -> REQ : 82 28 F1 10 89 34
				*   -> REQ : 84 28 F1 31 B8 00 00 6E
				*/
				ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF0000000068"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;

				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
				ecu.SetBaudRate(10400);
				ecu.SetCommTime(20, 800, 100, 5);

				ecu.SetLinkKeep(KeepTimeMs, KeepFrame, KeepType, Responesd, bImmediatelyEnable);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 5000);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetLinkKeep", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(KeepTimeMs, strKeepTimeMs, mapUint32ToString);
					uiList.SetItem(0, 1, strKeepTimeMs);
				}
				else if (1 == uSelect)
				{
					GetKeepFrame(KeepFrame, strKeepFrame);
					uiList.SetItem(1, 1, strKeepFrame);
				}
				else if (2 == uSelect)
				{
					GetParamValue(KeepType, strKeepType, mapLinkKeepType);
					uiList.SetItem(2, 1, strKeepType);
				}
				else if (3 == uSelect)
				{
					GetResponesd(Responesd, strResponesd);
					uiList.SetItem(3, 1, strResponesd);
				}
				else if (4 == uSelect)
				{
					GetParamValue(bImmediatelyEnable, strbImmediatelyEnable, mapTrueAndFalse);
					uiList.SetItem(2, 1, strbImmediatelyEnable);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetCommLineVoltage()
	{
		//ShowFuncInDevelopment();  return; 
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		vector<uint16_t> vctHihgLow = vector<uint16_t>{ 15, 2500, 15, 3500 };
		string strHihgLow = "High:15ms, Low:2500ms, High:15ms, Low:3500";

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetCommLineVoltage");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("vctHihgLow");
		uiList.SetItem(0, 1, strHihgLow);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.vctHihgLow : 使用示波器和逻辑分析仪测试引脚波形，来判断vctHihgLow设置是否正常；
				*/
				ShowMsgBoxDemo("SetCommLineVoltage", artiGetText("FF000000006A"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_KWP
				* 通信引脚： PIN_OBD_07,PIN_OBD_15
				* 波特率为： 10400
				* 发送命令：
				*   -> REQ : 82 28 F1 10 89 34
				*   -> REQ : 84 28 F1 31 B8 00 00 6E
				*/
				ShowMsgBoxDemo("SetCommLineVoltage", artiGetText("FF0000000068"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;

				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
				ecu.SetBaudRate(10400);
				ecu.SetCommTime(20, 800, 100, 5);

				ecu.SetCommLineVoltage(vctHihgLow);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 500);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetCommLineVoltage", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetvctHihgLow(vctHihgLow, strHihgLow);
					uiList.SetItem(0, 1, strHihgLow);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetCommTime()
	{
		//	ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strCommTime = "10, 200, 55, 5, 5000";
		vector<uint32_t> vctCommTime = vector<uint32_t>{ 10, 200, 55, 5, 5000 };

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetCommTime");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("CommTime");
		uiList.SetItem(0, 1, strCommTime);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.ReceiveMaxByte2ByteInterval_P1 : 测试方法有待研究；
				*   ->2.ReceiveFrameMaxWaitTime_P2     : 测试方法有待研究；
				*   ->3.SendFrameInterval_P3           : 测试方法有待研究；
				*   ->4.SendByte2Byte_P4               : 测试方法有待研究；
				*   ->5.ReceivePacketOverTime          : 测试方法有待研究；
				*/
				ShowMsgBoxDemo("SetCommTime", artiGetText("FF000000006B"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_KWP
				* 通信引脚： PIN_OBD_07,PIN_OBD_15
				* 波特率为： 10400
				* 发送命令：
				*   -> REQ : 82 28 F1 10 89 34
				*   -> REQ : 84 28 F1 31 B8 00 00 6E
				*/
				ShowMsgBoxDemo("SetCommTime", artiGetText("FF0000000068"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;

				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
				ecu.SetBaudRate(10400);
				if (vctCommTime.size() >= 4)
				{
					ecu.SetCommTime(vctCommTime[0], vctCommTime[1], vctCommTime[2], vctCommTime[3]);
				}
				else if (vctCommTime.size() >= 5)
				{
					ecu.SetCommTime(vctCommTime[0], vctCommTime[1], vctCommTime[2], vctCommTime[3], vctCommTime[4]);
				}
				else
				{
					ecu.SetCommTime(20, 800, 100, 5);
				}

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 500);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetCommTime", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetCommTime(vctCommTime, strCommTime);
					uiList.SetItem(0, 1, strCommTime);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetPinVoltage()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strPinNum = "PIN_OBD_01";
		string strPinVoltageMv = "5000mV";

		CStdCommMaco::ObdPinType PinNum = CStdCommMaco::ObdPinType::PIN_OBD_01;
		uint32_t PinVoltageMv = 5000;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetPinVoltage");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("PinNum");
		uiList.AddItem("PinVoltageMv");

		uiList.SetItem(0, 1, strPinNum);
		uiList.SetItem(1, 1, strPinVoltageMv);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.PinNum       : 使用示波器测试引脚电压，来判断参数设置是否正常；
				*   ->2.PinVoltageMv : 使用示波器测试引脚电压，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("SetPinVoltage", artiGetText("FF000000006C"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				//ShowFuncInDevelopment();	continue;
				/*
				 * 执行流程:
				 *   1.将指定引脚PinNum电压设置为0;
				 *   2.等待 1500 ms;
				 *   3.将指定引脚PinNum电压设置为PinVoltageMv;
				 *   4.等待 2000 ms;
				 *   5.将指定引脚PinNum电压设置为0;
				 *   6.等待 2500 ms;
				 */

				ShowMsgBoxDemo("SetPinVoltage", artiGetText("FF000000008B"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetPinVoltage(PinNum, 0);
				std::this_thread::sleep_for(std::chrono::seconds(2));
				ecu.SetPinVoltage(PinNum, -1);//设置电压后，要先恢复高阻抗，才能再次设置电压。

				ecu.SetPinVoltage(PinNum, PinVoltageMv);
				std::this_thread::sleep_for(std::chrono::seconds(1));
				ecu.SetPinVoltage(PinNum, -1);//设置电压后，要先恢复高阻抗，才能再次设置电压。

				ecu.SetPinVoltage(PinNum, 0);
				std::this_thread::sleep_for(std::chrono::seconds(2));

				ShowMsgBoxDemo("SetPinVoltage", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(PinNum, strPinNum, mapObdPinType);
					uiList.SetItem(0, 1, strPinNum);
				}
				else if (1 == uSelect)
				{
					GetParamValue(PinVoltageMv, strPinVoltageMv, mapPinVoltageMv);
					uiList.SetItem(1, 1, strPinVoltageMv);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetJ1850FunctionalAddressFilter()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		string strVctFunctionalAddress = "0x6B";

		vector<uint8_t> vctFunctionalAddress;
		vctFunctionalAddress.push_back(0x6B);

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetJ1850FunctionalAddressFilter");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("vctFunctionalAddress");
		uiList.SetItem(0, 1, strVctFunctionalAddress);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.vctFunctionalAddress : 通过模拟PWM通信，改变接收帧BYTE2，观察命令接收帧，来判断参数设置是否正常；
				*         例如:
				*          发送 : 61 6A F1 01 00 00
				*          发送 : 61 6A F1 09 02 00
				*          如果 vctFunctionalAddress = {0x6A}, 只过滤BYTE2={0x6A}帧
				*          如果 vctFunctionalAddress = {0x6B}, 只过滤BYTE2={0x6B}帧
				*          如果 vctFunctionalAddress = {0x6A, 0x6B}, 过滤BYTE2={0x6A, 0x6B}帧
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0000000089"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_PWM
				* 通信引脚： PIN_OBD_02,PIN_OBD_10
				* 波特率为： 41600
				* 发送命令：
				*   -> 发送 : 61 6A F1 01 00 00
				*   -> 发送 : 61 6B F1 09 02 00
				*/
				ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF0000000087"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

				CEcuInterface ecu;

				retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_PWM);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_02, CStdCommMaco::ObdPinType::PIN_OBD_10);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				retCode = ecu.SetBaudRate(41600);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}
				retCode = ecu.SetCommTime(0, 500, 20, 0, 1000);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				/*std::vector<uint8_t> table;
				table.push_back(0x6B);*/
				retCode = ecu.SetJ1850FunctionalAddressFilter(vctFunctionalAddress);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				std::vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x61\x6A\xF1\x01\x00\x00", 6), 1));
				vctSendFrame.push_back(CSendFrame(CBinary("\x61\x6A\xF1\x09\x02\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetJ1850FunctionalAddressFilter", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetFunctionalAddress(vctFunctionalAddress, strVctFunctionalAddress);
					uiList.SetItem(0, 1, strVctFunctionalAddress);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetJ1850NodeAddress()
	{
		//	ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strNodeAddress = "0xF1";

		uint8_t NodeAddress = 0xF1;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetJ1850NodeAddress");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("NodeAddress");

		uiList.SetItem(0, 1, strNodeAddress);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.NodeAddress : 通过模拟PWM通信，改变接收帧BYTE2，观察命令接收帧，来判断参数设置是否正常；
				*          例如:
				*          发送: C4 10 F5 10 E0
				*          如果 NodeAddress != 0xF5
				*          则命令发送和接收失败
				*/
				ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000008A"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_PWM
				* 通信引脚： PIN_OBD_02,PIN_OBD_10
				* 波特率为： 41600
				* 发送命令：
				*   -> 发送 :  C4 10 F1 10 E0
				*   -> 发送 :  C4 10 F5 10 E0
				*/
				ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF0000000088"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				ErrorCode_t retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

				CEcuInterface ecu;
				retCode = ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_PWM);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				retCode = ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_02, CStdCommMaco::ObdPinType::PIN_OBD_10);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				retCode = ecu.SetBaudRate(41600);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}
				retCode = ecu.SetCommTime(0, 500, 20, 0, 1000);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				retCode = ecu.SetJ1850NodeAddress(NodeAddress);
				if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
				{
					ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}
				std::vector<CSendFrame> vctSendFrame;
				vctSendFrame.clear();
				vctSendFrame.push_back(CSendFrame(CBinary("\xC4\x10\xF1\x10\xE0", 5), 1));
				vctSendFrame.push_back(CSendFrame(CBinary("\xC4\x10\xF5\x10\xE0", 5), 1));
				//vctSendFrame.push_back(CSendFrame(CBinary("\xC4\x10\xF5\x3F\xDC", 5), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetJ1850NodeAddress", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(NodeAddress, strNodeAddress, mapNodeAddress);
					uiList.SetItem(0, 1, strNodeAddress);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetCanExtendedAddress()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strEcuAddress = "0xEF";
		string strToolAddress = "0xF1";

		uint8_t EcuAddress = 0xEF;
		uint8_t ToolAddress = 0xF1;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetCanExtendedAddress");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("EcuAddress");
		uiList.AddItem("ToolAddress");

		uiList.SetItem(0, 1, strEcuAddress);
		uiList.SetItem(1, 1, strToolAddress);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.EcuAddress  : 通过模拟CAN通信，设置发送帧地址第3个字节（例如：08 07 E0 [EF] 02 1A 8E 00 00 00 00），来判断参数设置是否正常；
				*   ->2.ToolAddress : 通过模拟CAN通信，设置接收帧地址第3个字节（例如：08 07 E8 [F1] 02 5A 8E 55 55 55 55），来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("SetCanExtendedAddress", artiGetText("FF000000008C"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500 * 1000
				* 发送命令：
				*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
				*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
				*/

				ShowMsgBoxDemo("SetCanExtendedAddress", artiGetText("FF0000000055"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;

				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0x00);
				ecu.SetCommTime(0, 1000, 10, 0);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_EXCHANGE_2BYTES);
				ecu.SetCanExtendedAddress(EcuAddress, ToolAddress);

				CBinary binMask = CBinary("\xFF\xFF\xFF\x00", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 1 * 1000);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetCanExtendedAddress", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(EcuAddress, strEcuAddress, mapEcuAddress);
					uiList.SetItem(0, 1, strEcuAddress);
				}
				else if (1 == uSelect)
				{
					GetParamValue(ToolAddress, strToolAddress, mapToolAddress);
					uiList.SetItem(1, 1, strToolAddress);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetFilterId()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strFilterMask = "0xFF,0xFF,0xFF,0xFF";
		string strFilterPattern = "0x00,0x00,0x07,0xE8";
		string strFilterLength = "4";
		string strFilterType = "FT_PASS_ENABLE";

		CBinary binFilterMask = CBinary("\xFF\xFF\xFF\xFF", 4);
		CBinary binFilterPattern = CBinary("\x00\x00\x07\xE8", 4);
		uint32_t FilterLength = 4;
		CStdCommMaco::FilterType FilterType = CStdCommMaco::FilterType::FT_PASS_ENABLE;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFilterId");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("FilterMask");
		uiList.AddItem("FilterPattern");
		uiList.AddItem("FilterLength");
		uiList.AddItem("FilterType");

		uiList.SetItem(0, 1, strFilterMask);
		uiList.SetItem(1, 1, strFilterPattern);
		uiList.SetItem(2, 1, strFilterLength);
		uiList.SetItem(3, 1, strFilterType);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.FilterMask    : 通过模拟CAN通信，来判断参数设置是否正常；
				*   ->2.FilterPattern : 通过模拟CAN通信，来判断参数设置是否正常；
				*   ->3.FilterLength  : FilterLength为FilterMask和FilterPattern长度；
				*   ->4.FilterType    : 通过模拟CAN通信，观察接收命令，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("SetFilterId", artiGetText("FF000000006D"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
				*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
				*/

				ShowMsgBoxDemo("SetFilterId", artiGetText("FF0000000055"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

				ecu.SetFilterId(binFilterMask.GetBuffer(), binFilterPattern.GetBuffer(), FilterLength, FilterType);

				ecu.SetCommTime(10, 300, 50, 10);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetFilterId", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetFilterMask(binFilterMask, strFilterMask);
					uiList.SetItem(0, 1, strFilterMask);
				}
				else if (1 == uSelect)
				{
					GetFilterPattern(binFilterPattern, strFilterPattern);
					uiList.SetItem(1, 1, strFilterPattern);
				}
				else if (2 == uSelect)
				{
					GetParamValue(FilterLength, strFilterLength, mapFilterLength);
					uiList.SetItem(2, 1, strFilterLength);
				}
				else if (3 == uSelect)
				{
					GetParamValue(FilterType, strFilterType, mapFilterType);
					uiList.SetItem(3, 1, strFilterType);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetFilterIdRange()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strFilterBegin = "0x00,0x00,0x07,0xE8";
		string strFilterEnd = "0x00,0x00,0x07,0xEF";
		string strFilterLength = "4";

		CBinary binFilterBegin = CBinary("\x00\x00\x07\xE8", 4);
		CBinary binFilterEnd = CBinary("\x00\x00\x07\xEF", 4);
		uint32_t FilterLength = 4;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFilterIdRange");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("FilterBegin");
		uiList.AddItem("FilterEnd");
		uiList.AddItem("FilterLength");

		uiList.SetItem(0, 1, strFilterBegin);
		uiList.SetItem(1, 1, strFilterEnd);
		uiList.SetItem(2, 1, strFilterLength);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.FilterBegin  : 通过模拟CAN通信，观察发送接收命令，来判断参数设置是否正常；
				*   ->2.FilterEnd    : 通过模拟CAN通信，观察发送接收命令，来判断参数设置是否正常；
				*   ->3.FilterLength : FilterLength为FilterBegin和FilterEnd长度；
				*/
				ShowMsgBoxDemo("SetFilterIdRange", artiGetText("FF000000006E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
				*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
				*/
				ShowMsgBoxDemo("SetFilterIdRange", artiGetText("FF0000000055"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

				ecu.SetFilterIdRange(binFilterBegin.GetBuffer(), binFilterEnd.GetBuffer(), FilterLength);

				ecu.SetCommTime(10, 300, 50, 10);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetFilterIdRange", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetFilterBegin(binFilterBegin, strFilterBegin);
					uiList.SetItem(0, 1, strFilterBegin);
				}
				else if (1 == uSelect)
				{
					GetFilterPattern(binFilterEnd, strFilterEnd);
					uiList.SetItem(1, 1, strFilterEnd);
				}
				else if (2 == uSelect)
				{
					GetParamValue(FilterLength, strFilterLength, mapFilterLength);
					uiList.SetItem(2, 1, strFilterLength);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetFilterPDU()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strFilterType = "FPT_SID_PID_MORE_ENABLE";
		string strFilterPidLength = "2";

		CStdCommMaco::FilterPduType FilterType = CStdCommMaco::FilterPduType::FPT_SID_PID_MORE_ENABLE;
		uint32_t FilterPidLength = 2;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFilterPDU");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("FilterType");
		uiList.AddItem("FilterPidLength");

		uiList.SetItem(0, 1, strFilterType);
		uiList.SetItem(1, 1, strFilterPidLength);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.FilterType      : 通过模拟CAN通信，来判断FilterType设置是否正常；
				*   ->2.FilterPidLength : 通过模拟CAN通信，来判断FilterPidLength设置是否正常；
				*/
				ShowMsgBoxDemo("SetFilterPDU", artiGetText("FF000000006F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 03 22 F1 90 FF FF FF FF
				*   -> REQ : 08 07 E0 03 22 F1 91 FF FF FF FF
				*/
				ShowMsgBoxDemo("SetFilterPDU", artiGetText("FF0000000094"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				//1. 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(10, 300, 50, 10);

				//2. 设置测试接口
				ecu.SetFilterPDU(FilterType, FilterPidLength);

				//3. 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x90", 7), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x91", 7), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetFilterPDU", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(FilterType, strFilterType, mapFilterPduType);
					uiList.SetItem(0, 1, strFilterType);
				}
				else if (1 == uSelect)
				{
					GetParamValue(FilterPidLength, strFilterPidLength, mapFilterLength);
					uiList.SetItem(1, 1, strFilterPidLength);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetCanFramePad()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strFramePad = "00";
		string strPadActive = "true";

		uint8_t FramePad = 0x00;
		bool PadActive = true;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetCanFramePad");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("FramePad");
		uiList.AddItem("PadActive");

		uiList.SetItem(0, 1, strFramePad);
		uiList.SetItem(1, 1, strPadActive);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.FramePad   : 通过模拟CAN通信，来判断FramePad设置是否正常；
				*   ->2.PadActive  : 通过模拟CAN通信，来判断PadActive设置是否正常；
				*/
				ShowMsgBoxDemo("SetCanFramePad", artiGetText("FF0000000070"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
				*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
				*/
				ShowMsgBoxDemo("SetCanFramePad", artiGetText("FF0000000055"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				//1. 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(FramePad, PadActive);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(10, 300, 50, 10);

				//2. 设置测试接口
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

				//3. 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetCanFramePad", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(FramePad, strFramePad, mapFramePad);
					uiList.SetItem(0, 1, strFramePad);
				}
				else if (1 == uSelect)
				{
					GetParamValue(PadActive, strFramePad, mapTrueAndFalse);
					uiList.SetItem(1, 1, strFramePad);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_ClearFilter()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		bool bClearFilter = true;
		string strClearFilter = "true";

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFilterId");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("ClearFilter");
		uiList.SetItem(0, 1, strClearFilter);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   1. 在切换过滤器ID时，先调用ClearFilter清除过滤ID，再设置过滤ID，否则存在多个过滤ID情况。
				*/
				ShowMsgBoxDemo("SetFilterId", artiGetText("FF000000008D"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   1.设置过滤ID为0
				*   -> REQ : 08 07 E0 02 3E 00 00 00 00 00 00
				*   -> REQ : 08 07 E0 02 1A 8E 00 00 00 00 00
				*   设置过滤ID：
				*      1.设置过滤ID为0x07E8
				*      2.是否ClearFilter
				*      3.设置过滤ID为0x7E9。
				*/

				ShowMsgBoxDemo("SetFilterId", artiGetText("FF000000008E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL);

				ecu.SetFilterId(CBinary("\xFF\xFF\xFF\xFF", 4).GetBuffer(), CBinary("\x00\x00\x07\xE8", 4).GetBuffer(), 4, CStdCommMaco::FilterType::FT_PASS_ENABLE);

				if (bClearFilter)
				{
					ecu.ClearFilter();
				}

				ecu.SetFilterId(CBinary("\xFF\xFF\xFF\xFF", 4).GetBuffer(), CBinary("\x00\x00\x07\xE9", 4).GetBuffer(), 4, CStdCommMaco::FilterType::FT_PASS_ENABLE);

				ecu.SetCommTime(10, 300, 50, 10);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x1A\x8E", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetFilterId", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(bClearFilter, strClearFilter, mapTrueAndFalse);
					uiList.SetItem(0, 1, strClearFilter);
				}
			}
		}
	}

	// 该接口诊断功能未用到，已弃用。 [3/23/2022 qunshang.li]
	void CAPITest::EcuInterfaceTest_SetFlowControlId()
	{
		ShowFuncNotSupport();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strRecvFrameId = "0x00,0x00,0x07,0xE8";
		string strFlowCtrlFrameId = "0x00,0x00,0x07,0xE0";
		string strFrameIdLength = "4";

		CBinary binRecvFrameId = CBinary("\x00\x00\x07\xE8", 2);
		CBinary binFlowCtrlFrameId = CBinary("\x00\x00\x07\xE0", 2);
		uint32_t FrameIdLength = 4;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFlowControlId");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("RecvFrameId");
		uiList.AddItem("FlowCtrlFrameId");
		uiList.AddItem("FrameIdLength");

		uiList.SetItem(0, 1, strRecvFrameId);
		uiList.SetItem(1, 1, strFlowCtrlFrameId);
		uiList.SetItem(2, 1, strFrameIdLength);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.RecvFrameId     : 通过CAN通信，来判断参数设置是否正常；
				*   ->2.FlowCtrlFrameId : 通过CAN通信，来判断参数设置是否正常；
				*   ->3.FrameIdLength   : RecvFrameId和FlowCtrlFrameId长度；
				*/
				ShowMsgBoxDemo("SetFlowControlId", artiGetText("FF000000008F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 DF 02 09 02 FF FF FF FF FF
				*/
				ShowMsgBoxDemo("SetFlowControlId", artiGetText("FF0000000090"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_NORMAL);
				ecu.SetCommTime(10, 300, 50, 10);

				/*CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);*/

				retErrCode = ecu.SetFlowControlId(CBinary("\x00\x00\x07\xEF", 2).GetBuffer(), CBinary("\x00\x00\x07\xE7", 2).GetBuffer(), FrameIdLength, true);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("SetFlowControlId", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xDF\x09\x02", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetFlowControlId", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetRecvFrameId(binRecvFrameId, strRecvFrameId);
					uiList.SetItem(0, 1, strRecvFrameId);
				}
				else if (1 == uSelect)
				{
					GetRecvFrameId(binFlowCtrlFrameId, strFlowCtrlFrameId);
					uiList.SetItem(1, 1, strFlowCtrlFrameId);
				}
				else if (2 == uSelect)
				{
					GetParamValue(FrameIdLength, strFrameIdLength, mapFilterLength);
					uiList.SetItem(2, 1, strFrameIdLength);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetFlowControlMode()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strFlowControlMode = "FCT_AUTO";
		string strFlowControlTimes = "(1 << 31)";
		string strFlowControlBlockSize = "(1 << 31)";

		CStdCommMaco::FlowCtrlType FlowControlMode = CStdCommMaco::FlowCtrlType::FCT_AUTO;
		uint32_t FlowControlTimes = (1 << 31);
		uint32_t FlowControlBlockSize = (1 << 31);

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFlowControlMode");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("FlowControlMode");
		uiList.AddItem("FlowControlTimes");
		uiList.AddItem("FlowControlBlockSize");

		uiList.SetItem(0, 1, strFlowControlMode);
		uiList.SetItem(1, 1, strFlowControlTimes);
		uiList.SetItem(2, 1, strFlowControlBlockSize);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.FlowControlMode      : 通过模拟CAN通信，来判断FlowControlMode设置是否正常；
				*   ->2.FlowControlTimes     : 通过模拟CAN通信，来判断FlowControlTimes设置是否正常；
				*   ->3.FlowControlBlockSize : 模拟KWP和CAN通信，来判断FlowControlBlockSize设置是否正常；
				*/
				ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF0000000054"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				if (FlowControlMode == CStdCommMaco::FlowCtrlType::FCT_AUTO)
				{
					/*
					* 通信配置：
					* 通信协议： PT_CAN
					* 通信引脚： PIN_OBD_06,PIN_OBD_14
					* 波特率为： NA
					* 发送命令：
					*   -> REQ : 08 07 E0 03 22 F1 9E FF FF FF FF
					*   -> REQ : 08 07 E0 10 18 22 F1 9E 45 56 5F 44 61 73 68 42 6F 61 72 64 4A 43 49 4D 51 42 41 42 00
					*/
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF0000000095"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					//1. 配置通讯协议
					CEcuInterface ecu;
					ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
					ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
					ecu.SetBaudRate(500 * 1000);
					ecu.SetCanFramePad(0xFF);

					CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
					CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
					ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
					ecu.SetCommTime(10, 300, 50, 10);

					//2. 设置测试接口
					retErrCode = ecu.SetFlowControlMode(FlowControlMode, FlowControlTimes, FlowControlBlockSize);
					if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
					{
						ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
						continue;
					}

					//3. 发送示例命令，观察现象
					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E", 7), CSendFrame::SF_RECEIVE_AUTO_EX));
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E\x45\x56\x5F\x44\x61\x73\x68\x42\x6F\x61\x72\x64\x4A\x43\x49\x4D\x51\x42\x41\x42\x00", 28), CSendFrame::SF_RECEIVE_AUTO_EX));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else if (FlowControlMode == CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL)
				{
					/*
					* 通信配置：
					* 通信协议： PT_CAN
					* 通信引脚： PIN_OBD_06,PIN_OBD_14
					* 波特率为： NA
					* 发送命令：
					*   -> REQ : 08 07 DF 03 22 F1 9E FF FF FF FF
					*   -> REQ : 08 07 DF 10 18 22 F1 9E 45 56 5F 44 61 73 68 42 6F 61 72 64 4A 43 49 4D 51 42 41 42 00
					*/
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF0000000095"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					//1. 配置通讯协议
					CEcuInterface ecu;
					ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
					ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
					ecu.SetBaudRate(500 * 1000);
					ecu.SetCanFramePad(0xFF);

					CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
					CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
					ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
					ecu.SetCommTime(10, 300, 50, 10);

					//2. 设置测试接口
					retErrCode = ecu.SetFlowControlMode(FlowControlMode, FlowControlTimes, FlowControlBlockSize);
					if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
					{
						ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
						continue;
					}

					//3. 发送示例命令，观察现象
					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xDF\x22\xF1\x9E", 7), CSendFrame::SF_RECEIVE_AUTO_EX));
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xDF\x22\xF1\x9E\x45\x56\x5F\x44\x61\x73\x68\x42\x6F\x61\x72\x64\x4A\x43\x49\x4D\x51\x42\x41\x42\x00", 28), CSendFrame::SF_RECEIVE_AUTO_EX));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else if (FlowControlMode == CStdCommMaco::FlowCtrlType::FCT_NORMAL)
				{
					//接口SetFlowControlId()已弃用，此参数不支持。
					ShowFuncNotSupport();
					continue;
				}
				else if (FlowControlMode == CStdCommMaco::FlowCtrlType::FCT_EXCHANGE_2BYTES)
				{
					/*
					* 通信配置：
					* 通信协议： PT_CAN
					* 通信引脚： PIN_OBD_06,PIN_OBD_14
					* 波特率为： NA
					* 发送命令：
					*   -> REQ : 08 07 E0 03 22 F1 9E FF FF FF FF
					*   -> REQ : 08 07 E0 10 18 22 F1 9E 45 56 5F 44 61 73 68 42 6F 61 72 64 4A 43 49 4D 51 42 41 42 00
					*/
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF0000000095"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					//1. 配置通讯协议
					CEcuInterface ecu;
					ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
					ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
					ecu.SetBaudRate(500 * 1000);
					ecu.SetCanFramePad(0xFF);

					ecu.SetCanExtendedAddress(0xEF, 0xF1);

					CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
					CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
					ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
					ecu.SetCommTime(10, 300, 50, 10);

					//2. 设置测试接口
					retErrCode = ecu.SetFlowControlMode(FlowControlMode, FlowControlTimes, FlowControlBlockSize);
					if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
					{
						ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
						continue;
					}

					//3. 发送示例命令，观察现象
					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E", 7), CSendFrame::SF_RECEIVE_AUTO_EX));
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E\x45\x56\x5F\x44\x61\x73\x68\x42\x6F\x61\x72\x64\x4A\x43\x49\x4D\x51\x42\x41\x42\x00", 28), CSendFrame::SF_RECEIVE_AUTO_EX));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
				else if (FlowControlMode == CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW)
				{
					/*
						* 通信配置：
						* 通信协议： PT_CAN
						* 通信引脚： PIN_OBD_06,PIN_OBD_14
						* 波特率为： NA
						* 发送命令：
						*   -> REQ : 08 07 E0 03 22 F1 9E FF FF FF FF
						*   -> REQ : 08 07 E0 10 18 22 F1 9E 45 56 5F 44 61 73 68 42 6F 61 72 64 4A 43 49 4D 51 42 41 42 00
						*/
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF0000000095"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					ShowEstablishComMsg();

					//1. 配置通讯协议
					CEcuInterface ecu;
					ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
					ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
					ecu.SetBaudRate(500 * 1000);
					ecu.SetCanFramePad(0xFF);

					CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
					CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
					ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
					ecu.SetCommTime(10, 300, 50, 10);

					//2. 设置测试接口
					retErrCode = ecu.SetFlowControlMode(FlowControlMode, FlowControlTimes, FlowControlBlockSize);
					if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
					{
						ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
						continue;
					}

					//3. 发送示例命令，观察现象
					vector<CSendFrame> vctSendFrame;
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E", 7), CSendFrame::SF_RECEIVE_AUTO_EX));
					vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E\x45\x56\x5F\x44\x61\x73\x68\x42\x6F\x61\x72\x64\x4A\x43\x49\x4D\x51\x42\x41\x42\x00", 28), CSendFrame::SF_RECEIVE_AUTO_EX));

					string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
					ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(FlowControlMode, strFlowControlMode, mapFlowCtrlType);
					uiList.SetItem(0, 1, strFlowControlMode);
				}
				else if (1 == uSelect)
				{
					GetParamValue(FlowControlTimes, strFlowControlTimes, mapFlowControlTimes);
					uiList.SetItem(1, 1, strFlowControlTimes);
				}
				else if (2 == uSelect)
				{
					GetParamValue(FlowControlBlockSize, strFlowControlBlockSize, mapFlowControlBlockSize);
					uiList.SetItem(2, 1, strFlowControlBlockSize);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetFlowControlSendDelay()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strusDelay = "200";
		uint32_t usDelay = 200;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetFlowControlSendDelay");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("usDelay");

		uiList.SetItem(0, 1, strusDelay);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.usDelay : 通过模拟CAN通信，发送命令接收多帧，观察流控制帧延时时间变化，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("SetFlowControlSendDelay", artiGetText("FF0000000071"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 03 22 F1 9E 00 00 00 00
				*   -> REQ : 08 07 E0 03 22 F1 9E 00 00 00 00
				*/

				ShowMsgBoxDemo("SetBaudRate", artiGetText("FF0000000091"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				// 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0x00);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);

				ecu.SetCommTime(10, 300, 50, 10);

				// 设置测试接口
				retErrCode = ecu.SetFlowControlSendDelay(usDelay);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				// 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x22\xF1\x9E", 7), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 2, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetBaudRate", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(usDelay, strusDelay, mapUint32ToString);
					uiList.SetItem(0, 1, strusDelay);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetCanFirstConsecutiveFrameValue()
	{
		//	ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strSequenceNumber = "0";
		uint32_t SequenceNumber = 0;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetCanFirstConsecutiveFrameValue");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("SequenceNumber");
		uiList.SetItem(0, 1, strSequenceNumber);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.SequenceNumber : 通过模拟CAN通信发送长帧命令，观察第一帧命令序号，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("SetCanFirstConsecutiveFrameValue", artiGetText("FF0000000072"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 10 0B 19 06 E1 09 09 FF
				*   -> REQ : 08 07 E0 2X 01 02 03 04 05 FF FF
				*/

				ShowMsgBoxDemo("SetCanFirstConsecutiveFrameValue", artiGetText("FF0000000073"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				// 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(10, 300, 50, 10);

				// 设置测试接口
				retErrCode = ecu.SetCanFirstConsecutiveFrameValue(SequenceNumber);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("SetCanFirstConsecutiveFrameValue", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				// 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x19\x06\xE1\x09\x09\xFF\x01\x02\x03\x04\x05", 15), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetCanFirstConsecutiveFrameValue", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(SequenceNumber, strSequenceNumber, mapSequenceNumber);
					uiList.SetItem(0, 1, strSequenceNumber);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetSingleMsgCanFormatId()
	{
		//	ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strRxCanId = "0x07E8";
		string strTxCanId = "0x06E0";
		string strSetFlag = "true";

		uint32_t RxCanId = 0x07E8;
		uint32_t TxCanId = 0x06E0;
		bool SetFlag = true;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetSingleMsgCanFormatId");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("RxCanId");
		uiList.AddItem("TxCanId");
		uiList.AddItem("SetFlag");

		uiList.SetItem(0, 1, strRxCanId);
		uiList.SetItem(1, 1, strTxCanId);
		uiList.SetItem(2, 1, strSetFlag);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.RxCanId : RxCanId和SetFilterId设置ID不能相同，否则该接口不起作用。
				*   ->2.TxCanId : TxCanId必须和发送命令ID相同，否则该接口不起作用；
				*   ->3.SetFlag : 模拟CAN通信，为false时，按标准CAN格式发送；为true时，按单报文发送接收；
				*/
				ShowMsgBoxDemo("SetSingleMsgCanFormatId", artiGetText("FF0000000074"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> 发送:   00 00 06 E0 FC 01 02 03 04 05 06 07
				*   -> 接收:   00 00 07 E8 FD 01 02 03 04 05 06 07
				*/
				ShowMsgBoxDemo("SetSingleMsgCanFormatId", artiGetText("FF0000000075"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				//1. 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE9", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(10, 300, 50, 10);

				//2. 设置测试接口
				/*
				uint32_t RxCanId = 0x07E8;
				uint32_t TxCanId = 0x06E0;
				bool SetFlag = true;
				*/
				// RxCanId 和 SetFilterId设置ID不能相同，否则SetSingleMsgCanFormatId接口不起作用。
				retErrCode = ecu.SetSingleMsgCanFormatId(RxCanId, TxCanId, SetFlag);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				//3. 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x06\xE0\xFC\x01\x02\x03\x04\x05\x06\x07", 12), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetSingleMsgCanFormatId", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(RxCanId, strRxCanId, mapRxCanId);
					uiList.SetItem(0, 1, strRxCanId);
				}
				else if (1 == uSelect)
				{
					GetParamValue(TxCanId, strTxCanId, mapRxCanId);
					uiList.SetItem(1, 1, strTxCanId);
				}
				else if (2 == uSelect)
				{
					GetParamValue(SetFlag, strSetFlag, mapTrueAndFalse);
					uiList.SetItem(2, 1, strSetFlag);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_EnableSegmentedSendSingleCanFrame()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strEnable = "0";
		uint32_t Enable = 0;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("EnableSegmentedSendSingleCanFrame");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("Enable");

		uiList.SetItem(0, 1, strEnable);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.Enable : 通过模拟CAN通信，发送多帧数据，来判断Enable设置是否正常；
				*/
				ShowMsgBoxDemo("EnableSegmentedSendSingleCanFrame", artiGetText("FF0000000076"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 91 07 2E 01 02 03 04 05 06
				*/
				ShowMsgBoxDemo("EnableSegmentedSendSingleCanFrame", artiGetText("FF0000000077"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				//1. 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(10, 300, 50, 10);

				//2. 设置测试接口
				retErrCode = ecu.EnableSegmentedSendSingleCanFrame(Enable);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("SetFlowControlMode", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				//3. 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\x91\x2E\x01\x02\x03\x04\x05\x06", 11), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("EnableSegmentedSendSingleCanFrame", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(Enable, strEnable, mapEnable);
					uiList.SetItem(0, 1, strEnable);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_AddressCodeEnter()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strAddressCode = "1";
		string strAddSendBps = "5";
		string strEnterType = "AEPT_AUTO_BAUDRATE | AEPT_SEND_KW2_REVERSED | AEPT_RECV_2_KWS";
		string strWaitTimeBeforSendAddress = "2500";
		string strSyncByte0x55OverTime = "350";
		string strReceiveKwOverTime = "200";
		string strKw2ReverseWaitTime = "40";
		string strReceiveReverseAddressOverTime = "1000";

		uint8_t AddressCode = 0x01;
		uint32_t AddSendBps = 5;
		CStdCommMaco::AddressEnterParaType EnterType = CStdCommMaco::AddressEnterParaType::AEPT_AUTO_BAUDRATE | CStdCommMaco::AddressEnterParaType::AEPT_SEND_KW2_REVERSED | CStdCommMaco::AddressEnterParaType::AEPT_RECV_2_KWS;
		uint32_t WaitTimeBeforSendAddress = 2500;
		uint32_t SyncByte0x55OverTime = 350;
		uint32_t ReceiveKwOverTime = 200;
		uint32_t Kw2ReverseWaitTime = 40;
		uint32_t ReceiveReverseAddressOverTime = 1000;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("AddressCodeEnter");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("AddressCode");
		uiList.AddItem("AddSendBps");
		uiList.AddItem("EnterType");
		uiList.AddItem("WaitTimeBeforSendAddress");
		uiList.AddItem("SyncByte0x55OverTime");
		uiList.AddItem("ReceiveKwOverTime");
		uiList.AddItem("Kw2ReverseWaitTime");
		uiList.AddItem("ReceiveReverseAddressOverTime");

		uiList.SetItem(0, 1, strAddressCode);
		uiList.SetItem(1, 1, strAddSendBps);
		uiList.SetItem(2, 1, strEnterType);
		uiList.SetItem(3, 1, strWaitTimeBeforSendAddress);
		uiList.SetItem(4, 1, strSyncByte0x55OverTime);
		uiList.SetItem(5, 1, strReceiveKwOverTime);
		uiList.SetItem(6, 1, strKw2ReverseWaitTime);
		uiList.SetItem(7, 1, strReceiveReverseAddressOverTime);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.AddressCode : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->2.AddSendBps  : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->3.EnterType   : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->4.WaitTimeBeforSendAddress : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->5.SyncByte0x55OverTime     : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->6.ReceiveKwOverTime        : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->7.Kw2ReverseWaitTime       : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->8.ReceiveReverseAddressOverTime : 通过模拟KWP通信，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("AddressCodeEnter", artiGetText("FF0000000079"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				 * 通信配置：
				 * 通信协议： PT_KWP
				 * 通信引脚： PIN_OBD_07,PIN_OBD_15
				 * 波特率为： 10400
				 * 地址码进入:
				 *	 ->addr: 01
				 *	 ->send: 55
				 *	 ->send: 01 8F
				 *	 ->read: 70
				 *	 ->send: FE
				 * 发送命令：
				 *   -> REQ : 82 28 F1 10 89 34
				 *   -> REQ : 84 28 F1 31 B8 00 00 6E
				 */
				ShowMsgBoxDemo("AddressCodeEnter", artiGetText("FF0000000078"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;

				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_07);
				ecu.SetBaudRate(10400);
				ecu.SetCommTime(20, 800, 100, 5);
				ecu.SetClearBuffer(CStdCommMaco::ClearBufferMode::CBM_CLEAR_COMM_RX_QUEUE);

				CRecvFrame recvFrame;
				ecu.AddressCodeEnter(AddressCode, recvFrame, AddSendBps, EnterType, WaitTimeBeforSendAddress, SyncByte0x55OverTime, ReceiveKwOverTime, Kw2ReverseWaitTime, ReceiveReverseAddressOverTime);

				if (!recvFrame.GetSize())
				{
					/*
					* 地址码进入失败，请检测模拟数据是否正确。
					*/
					ShowMsgBoxDemo("AddressCodeEnter", artiGetText("FF0000000061"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					continue;
				}
				CBinary key = recvFrame.GetFirst();
				if (key.GetSize() < 2)
				{
					/*
					* 地址码进入失败，请检测模拟数据是否正确。
					*/
					ShowMsgBoxDemo("AddressCodeEnter", artiGetText("FF0000000061"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					continue;
				}
				if (key.GetAt(0) == 0x01 && key.GetAt(1) == 0x8A)
				{
					// KWP1281
					ShowMsgBoxDemo("AddressCodeEnter", "KWP1281", DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else if (key.GetAt(0) == 0x01 && key.GetAt(1) == 0x8F)
				{
					// KWP2000
					ShowMsgBoxDemo("AddressCodeEnter", "KWP2000", DF_MB_OK, DT_LEFT, -1, m_uThread);
				}

				ShowEstablishComMsg();

				// 1.链路保持
				CBinary keepBin = CBinary("\x81\x10\xF1\x3E\xC0", 5);
				CSendFrame KeepFrame(keepBin, 0);
				ecu.SetLinkKeep(2000, KeepFrame, CStdCommMaco::LinkKeepType::LKT_INTERVAL);

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("AddressCodeEnter", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(AddressCode, strAddressCode, mapAddressCode);
					uiList.SetItem(0, 1, strAddressCode);
				}
				else if (1 == uSelect)
				{
					GetParamValue(AddSendBps, strAddSendBps, mapAddSendBps);
					uiList.SetItem(1, 1, strAddSendBps);
				}
				else if (2 == uSelect)
				{
					//GetEnterType(EnterType, strEnterType);
					GetParamValueWithCheckBox(EnterType, strEnterType, mapAddressEnterParaType);
					uiList.SetItem(2, 1, strEnterType);
				}
				else if (3 == uSelect)
				{
					GetParamValue(WaitTimeBeforSendAddress, strWaitTimeBeforSendAddress, mapWaitTimeBeforSendAddress);
					uiList.SetItem(3, 1, strWaitTimeBeforSendAddress);
				}
				else if (4 == uSelect)
				{
					GetParamValue(SyncByte0x55OverTime, strSyncByte0x55OverTime, mapSyncByte0x55OverTime);
					uiList.SetItem(4, 1, strSyncByte0x55OverTime);
				}
				else if (5 == uSelect)
				{
					GetParamValue(ReceiveKwOverTime, strReceiveKwOverTime, mapReceiveKwOverTime);
					uiList.SetItem(5, 1, strReceiveKwOverTime);
				}
				else if (6 == uSelect)
				{
					GetParamValue(Kw2ReverseWaitTime, strKw2ReverseWaitTime, mapKw2ReverseWaitTime);
					uiList.SetItem(6, 1, strKw2ReverseWaitTime);
				}
				else if (7 == uSelect)
				{
					GetParamValue(ReceiveReverseAddressOverTime, strReceiveReverseAddressOverTime, mapReceiveReverseAddressOverTime);
					uiList.SetItem(7, 1, strReceiveReverseAddressOverTime);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_QuickEnter()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strSendFrame = "0x82,0x28,0xF1,0x10,0x89,0x34";
		string strWaitTime = "300";
		string strLowVoltageTime = "25";
		string strHighVoltageTime = "25";

		CSendFrame SendFrame = CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO);
		uint32_t WaitTime = 300;
		uint32_t LowVoltageTime = 25;
		uint32_t HighVoltageTime = 25;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("QuickEnter");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("SendFrame");
		uiList.AddItem("WaitTime");
		uiList.AddItem("LowVoltageTime");
		uiList.AddItem("HighVoltageTime");

		uiList.SetItem(0, 1, strSendFrame);
		uiList.SetItem(1, 1, strWaitTime);
		uiList.SetItem(2, 1, strLowVoltageTime);
		uiList.SetItem(3, 1, strHighVoltageTime);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.SendFrame      : 通过模拟KWP通信，来判断参数设置是否正常；
				*   ->2.WaitTime       : 通过模拟KWP通信，使用示波器和逻辑分析仪测试引脚波形，来判断参数设置是否正常；
				*   ->3.LowVoltageTime : 通过模拟KWP通信，使用示波器和逻辑分析仪测试引脚波形，来判断参数设置是否正常；
				*   ->4.HighVoltageTime: 通过模拟KWP通信，使用示波器和逻辑分析仪测试引脚波形，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("QuickEnter", artiGetText("FF000000007A"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议为： PT_KWP
				* 通信引脚为： PIN_OBD_07,PIN_OBD_15
				* 波特率为：   10400
				* 发送命令：
				*   -> REQ : 84 28 F1 31 B8 00 00 6E
				*/
				ShowMsgBoxDemo("QuickEnter", artiGetText("FF000000009F"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_15);
				ecu.SetBaudRate(10400);
				ecu.SetCommTime(20, 800, 50, 5, 10000);

				CRecvFrame ReceiveFrame;
				retErrCode = ecu.QuickEnter(SendFrame, ReceiveFrame, WaitTime, LowVoltageTime, HighVoltageTime);
				if (CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED == retErrCode)
				{
					ShowMsgBoxDemo("QuickEnter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				if (!ReceiveFrame.GetSize())
				{
					//快速进入失败，请检测模拟数据是否正确。
					ShowMsgBoxDemo("QuickEnter", artiGetText("FF000000007B"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					continue;
				}

				ShowEstablishComMsg();

				vector<CSendFrame> vctSendFrame;
				//	vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\x28\xF1\x31\xB8\x00\x00\x6E", 8), CSendFrame::SF_RECEIVE_AUTO));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 500);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("QuickEnter", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetSendFrame(SendFrame, strSendFrame);
					uiList.SetItem(0, 1, strSendFrame);
				}
				else if (1 == uSelect)
				{
					GetParamValue(WaitTime, strWaitTime, mapUint32ToString);
					uiList.SetItem(1, 1, strWaitTime);
				}
				else if (2 == uSelect)
				{
					GetParamValue(LowVoltageTime, strLowVoltageTime, mapVoltageTime);
					uiList.SetItem(2, 1, strLowVoltageTime);
				}
				else if (3 == uSelect)
				{
					GetParamValue(HighVoltageTime, strHighVoltageTime, mapVoltageTime);
					uiList.SetItem(3, 1, strHighVoltageTime);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_TP20Enter()
	{
		//	ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strTpTargetAddress = "0x01";
		string strAppLayerID = "0x01";

		uint8_t TpTargetAddress = 0x01;
		uint8_t AppLayerID = 0x01;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("TP20Enter");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("TpTargetAddress");
		uiList.AddItem("AppLayerID");

		uiList.SetItem(0, 1, strTpTargetAddress);
		uiList.SetItem(1, 1, strAppLayerID);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.TpTargetAddress : 通过模拟TP20通信，来判断参数设置是否正常；
				*   ->2.AppLayerID      : 通过模拟TP20通信，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("TP20Enter", artiGetText("FF000000007C"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议为： PT_TP20
				* 通信引脚为： PIN_OBD_06,PIN_OBD_14
				* 波特率为：   500K
				* 0x01系统TP20Enter
				*   ->发送 : 07 02 00 01 C0 00 10 00 03 01
				*   ->接收 : 07 02 01 00 D0 00 03 40 07 01
				*   ->发送 : 06 07 40 A0 0F 8A FF 00 FF
				*   ->接收 : 06 03 00 A1 0F 8A FF 4A FF
				*   ->链路 : 01 07 40 A3
				* 发送命令：
				*   -> 发送 : 05 07 40 10 00 02 10 89
				*   -> 发送 : 07 07 40 11 00 04 31 B8 00 00
				*/

				ShowMsgBoxDemo("TP20Enter", artiGetText("FF000000007D"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_TP20);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW);
				ecu.SetCommTime(10, 500, 50, 10);

				CRecvFrame ReceiveFrame;
				retErrCode = ecu.TP20Enter(TpTargetAddress, ReceiveFrame, AppLayerID);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("TP20Enter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				if (!ReceiveFrame.GetSize())
				{
					//快速进入失败，请检测模拟数据是否正确。
					ShowMsgBoxDemo("TP20Enter", artiGetText("FF000000007B"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					continue;
				}

				ShowEstablishComMsg();

				vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x10\x89", 2), 1));
				vctSendFrame.push_back(CSendFrame(CBinary("\x31\xB8\x00\x00", 4), 1));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("TP20Enter", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(TpTargetAddress, strTpTargetAddress, mapTpTargetAddress);
					uiList.SetItem(0, 1, strTpTargetAddress);
				}
				else if (1 == uSelect)
				{
					GetParamValue(AppLayerID, strAppLayerID, mapAppLayerID);
					uiList.SetItem(1, 1, strAppLayerID);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_TP16Enter()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		string strEnterSysId = "0x2D0";
		string strEnterFilterId = "0x2F1";
		string strTargetAddr = "0x311";
		string strEnterAddressCode = "0x25";
		string strSystemId = "0x11";

		uint32_t EnterSysId = 0x2D0;
		uint32_t EnterFilterId = 0x2F1;
		uint32_t TargetAddr = 0x311;
		uint8_t EnterAddressCode = 0x25;
		uint8_t SystemId = 0x11;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("TP16Enter");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("EnterSysId");
		uiList.AddItem("EnterFilterId");
		uiList.AddItem("TargetAddr");
		uiList.AddItem("EnterAddressCode");
		uiList.AddItem("SystemId");

		uiList.SetItem(0, 1, strEnterSysId);
		uiList.SetItem(1, 1, strEnterFilterId);
		uiList.SetItem(2, 1, strTargetAddr);
		uiList.SetItem(3, 1, strEnterAddressCode);
		uiList.SetItem(4, 1, strSystemId);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.EnterSysId    : 通过模拟TP16通信，来判断参数设置是否正常；
				*   ->2.EnterFilterId : 通过模拟TP16通信，来判断参数设置是否正常；
				*   ->3.TargetAddr    : 通过模拟TP16通信，来判断参数设置是否正常；
				*   ->4.EnterAddressCode : 通过模拟TP16通信，来判断参数设置是否正常；
				*   ->5.SystemId         : 通过模拟TP16通信，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("TP16Enter", artiGetText("FF00000000A1"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议为： PT_TP16
				* 通信引脚为： PIN_OBD_06,PIN_OBD_14
				* 波特率为：   500K
				* 0x11系统TP16Enter
				*   REQ : 03 02D0 11 C0 11
				*   Ans : 03 02F1 00 D0 A1
				*
				*   REQ : 06 0311 A0 0F 8A FF 00 FF
				*   Ans : 06 03A1 A1 03 94 54 00 D9
				*
				*   REQ : 02 0311 30 25
				*   Ans : 04 03A1 10 55 6B 8F
				*
				*   REQ : 02 0311 30 70
				*   Ans : 02 03A1 10 DA
				*
				* 发送命令：
				*   -> 发送 : 82 C0 F1 1A 87 D4
				*   -> 发送 : 84 C0 F1 31 B8 00 00 1E
				*/

				ShowMsgBoxDemo("TP16Enter", artiGetText("FF00000000A2"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_TP16);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW);
				ecu.SetCommTime(10, 500, 50, 10);

				CRecvFrame ReceiveFrame;
				retErrCode = ecu.TP16Enter(EnterSysId, EnterFilterId, TargetAddr, EnterAddressCode, SystemId, ReceiveFrame);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("TP16Enter", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				if (!ReceiveFrame.GetSize())
				{
					//快速进入失败，请检测模拟数据是否正确。
					ShowMsgBoxDemo("TP16Enter", artiGetText("FF000000007B"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					continue;
				}

				ShowEstablishComMsg();

				CBinary keepBin = CBinary("\x81\xC0\xF1\x3E\x70", 5);
				CSendFrame KeepFrame(keepBin, 0);
				ecu.SetLinkKeep(1000, KeepFrame, CStdCommMaco::LinkKeepType::LKT_INTERVAL);

				std::vector<CSendFrame> vctSendFrame;
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\xC0\xF1\x1A\x87\xD4", 6), 1));
				vctSendFrame.push_back(CSendFrame(CBinary("\x84\xC0\xF1\x31\xB8\x00\x00\x1E", 8), 1));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 100);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("TP16Enter", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(EnterSysId, strEnterSysId, mapEnterSysId);
					uiList.SetItem(0, 1, strEnterSysId);
				}
				else if (1 == uSelect)
				{
					GetParamValue(EnterFilterId, strEnterFilterId, mapEnterFilterId);
					uiList.SetItem(1, 1, strEnterFilterId);
				}
				else if (2 == uSelect)
				{
					GetParamValue(TargetAddr, strTargetAddr, mapTargetAddr);
					uiList.SetItem(2, 1, strTargetAddr);
				}
				else if (3 == uSelect)
				{
					GetParamValue(EnterAddressCode, strEnterAddressCode, mapEnterAddressCode);
					uiList.SetItem(3, 1, strEnterAddressCode);
				}
				else if (4 == uSelect)
				{
					GetParamValue(SystemId, strSystemId, mapSystemId);
					uiList.SetItem(4, 1, strSystemId);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_TP20Broadcast()
	{
		ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		string strSendFrame = "\x82\x28\xF1\x10\x89\x34";
		string strTimeIntervalMs = "";
		string strSendTimes = "";
		string strTimeIntervalOfReTriggerMs = "";

		CSendFrame SendFrame = CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO);
		uint32_t TimeIntervalMs = 0;
		uint32_t SendTimes = 0;
		uint8_t TimeIntervalOfReTriggerMs = 0;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("TP20Broadcast");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("SendFrame");
		uiList.AddItem("TimeIntervalMs");
		uiList.AddItem("SendTimes");
		uiList.AddItem("TimeIntervalOfReTriggerMs");

		uiList.SetItem(0, 1, strSendFrame);
		uiList.SetItem(1, 1, strTimeIntervalMs);
		uiList.SetItem(2, 1, strSendTimes);
		uiList.SetItem(3, 1, strTimeIntervalOfReTriggerMs);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.SendFrame : 通过模拟KWP和CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoOutputPin设置是否正常；
				*   ->2.TimeIntervalMs  : 通过模拟CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoInputPin设置是否正常；
				*   ->3.SendTimes : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压，来判断WorkVoltage设置是否正常；
				*   ->4.TimeIntervalOfReTriggerMs : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压和波形，来判断PinProperty设置是否正常；
				*/
				ShowMsgBoxDemo("TP20Broadcast", artiGetText("FF0000000054"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_NONE, CStdCommMaco::PinVoltageType::PinVol_12V);
				ecu.SetBaudRate(Bps, FdBps);
				ecu.SetCommTime(20, 800, 100, 5);

				vector<CSendFrame> vctSendFrame;
				CSendFrame EmptySf;
				EmptySf.Clear();
				vctSendFrame.push_back(EmptySf);
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x10\xF1\x10\x89\x1C", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\xC1\x33\xF1\x81\x66", 5), CSendFrame::SF_RECEIVE_AUTO));
				ExeSendRecvLoop(ecu, vctSendFrame, 1, 1 * 1000);*/
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetSendFrame(SendFrame, strSendFrame);
					uiList.SetItem(0, 1, strSendFrame);
				}
				else if (1 == uSelect)
				{
					GetParamValue(TimeIntervalMs, strTimeIntervalMs, mapTimeMs);
					uiList.SetItem(1, 1, strTimeIntervalMs);
				}
				else if (2 == uSelect)
				{
					GetParamValue(SendTimes, strSendTimes, mapTimeMs);
					uiList.SetItem(2, 1, strSendTimes);
				}
				else if (3 == uSelect)
				{
					GetParamValue(TimeIntervalOfReTriggerMs, strTimeIntervalOfReTriggerMs, mapEnterAddressCode);
					uiList.SetItem(3, 1, strTimeIntervalOfReTriggerMs);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetRCXXHandling()
	{
		//ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/
		string strMode = "RHM_MODE_NRC78";
		string strType = "RHT_UNTIL_TIMEOUT";
		string strCompletionTimeoutMs = "15 * 1000";
		string strWaitNext7FXXTimeMs = "3 * 1000";

		CStdCommMaco::RcxxHandlingMode Mode = CStdCommMaco::RcxxHandlingMode::RHM_MODE_NRC78;
		CStdCommMaco::RcxxHandlingType Type = CStdCommMaco::RcxxHandlingType::RHT_UNTIL_TIMEOUT;
		uint32_t CompletionTimeoutMs = 15 * 1000;
		uint32_t WaitNext7FXXTimeMs = 3 * 1000;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetRCXXHandling");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("Mode");
		uiList.AddItem("Type");
		uiList.AddItem("CompletionTimeoutMs");
		uiList.AddItem("WaitNext7FXXTimeMs");

		uiList.SetItem(0, 1, strMode);
		uiList.SetItem(1, 1, strType);
		uiList.SetItem(2, 1, strCompletionTimeoutMs);
		uiList.SetItem(3, 1, strWaitNext7FXXTimeMs);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.Mode               : 通过模拟CAN通信，来判断参数设置是否正常；
				*   ->2.Type               : 通过模拟CAN通信，来判断参数设置是否正常；
				*   ->3.CompletionTimeoutMs: 通过模拟CAN通信，来判断参数设置是否正常；
				*   ->4.WaitNext7FXXTimeMs : 通过模拟CAN通信，来判断参数设置是否正常；
				*/
				ShowMsgBoxDemo("SetRCXXHandling", artiGetText("FF0000000092"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*
				* 通信配置：
				* 通信协议： PT_CAN
				* 通信引脚： PIN_OBD_06,PIN_OBD_14
				* 波特率为： 500K
				* 发送命令：
				*   -> REQ : 08 07 E0 02 33 02 FF FF FF FF FF
				*/
				ShowMsgBoxDemo("SetRCXXHandling", artiGetText("FF00000000A4"), DF_MB_OK, DT_LEFT, -1, m_uThread);

				ShowEstablishComMsg();

				//1. 配置通讯协议
				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);//设置协议类型
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(10, 500, 50, 0);

				//2. 设置测试接口

				//CStdCommMaco::RcxxHandlingMode Mode = CStdCommMaco::RcxxHandlingMode::RHM_MODE_NRC78;
				//CStdCommMaco::RcxxHandlingType Type = CStdCommMaco::RcxxHandlingType::RHT_UNTIL_TIMEOUT;
				//uint32_t CompletionTimeoutMs = 15 * 1000;
				//uint32_t WaitNext7FXXTimeMs = 3 * 1000;

				retErrCode = ecu.SetRCXXHandling(Mode, Type, CompletionTimeoutMs, WaitNext7FXXTimeMs);
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR != retErrCode)
				{
					ShowMsgBoxDemo("SetRCXXHandling", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);//设置失败!
					continue;
				}

				//3. 发送示例命令，观察现象
				vector<CSendFrame> vctSendFrame;
				//vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x33\x02", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				//vctSendFrame.push_back(CSendFrame(CBinary("\x00\x00\x07\xE0\x3E\x00", 6), CSendFrame::SF_RECEIVE_AUTO_EX));

				string strTemp = ExeSendRecvLoop(ecu, vctSendFrame, 1, 10);
				ShowMsgBoxDemo(artiGetText("FF000000004A"), strTemp, DF_MB_OK, DT_LEFT, -1, m_uThread);//命令返回值

				ShowMsgBoxDemo("SetRCXXHandling", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(Mode, strMode, mapRcxxHandlingMode);
					uiList.SetItem(0, 1, strMode);
				}
				else if (1 == uSelect)
				{
					GetParamValue(Type, strType, mapRcxxHandlingType);
					uiList.SetItem(1, 1, strType);
				}
				else if (2 == uSelect)
				{
					GetParamValue(CompletionTimeoutMs, strCompletionTimeoutMs, mapTimeMs);
					uiList.SetItem(2, 1, strCompletionTimeoutMs);
				}
				else if (3 == uSelect)
				{
					GetParamValue(WaitNext7FXXTimeMs, strWaitNext7FXXTimeMs, mapTimeMs);
					uiList.SetItem(3, 1, strWaitNext7FXXTimeMs);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SetClearBuffer()
	{
		ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strMode = "CBM_CLEAR_DISABLE";
		CStdCommMaco::ClearBufferMode Mode = CStdCommMaco::ClearBufferMode::CBM_CLEAR_DISABLE;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("SetClearBuffer");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("Mode");

		uiList.SetItem(0, 1, strMode);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.Mode : 通过模拟KWP和CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoOutputPin设置是否正常；
				*   ->2.IoInputPin  : 通过模拟CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoInputPin设置是否正常；
				*   ->3.WorkVoltage : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压，来判断WorkVoltage设置是否正常；
				*   ->4.PinProperty : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压和波形，来判断PinProperty设置是否正常；
				*/
				ShowMsgBoxDemo("SetClearBuffer", artiGetText("FF0000000054"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_NONE, CStdCommMaco::PinVoltageType::PinVol_12V);
				ecu.SetBaudRate(Bps, FdBps);
				ecu.SetCommTime(20, 800, 100, 5);

				vector<CSendFrame> vctSendFrame;
				CSendFrame EmptySf;
				EmptySf.Clear();
				vctSendFrame.push_back(EmptySf);
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x10\xF1\x10\x89\x1C", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\xC1\x33\xF1\x81\x66", 5), CSendFrame::SF_RECEIVE_AUTO));
				ExeSendRecvLoop(ecu, vctSendFrame, 1, 1 * 1000);*/
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(Mode, strMode, mapClearBufferMode);
					uiList.SetItem(0, 1, strMode);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SendReceive()
	{
		//ShowFuncInDevelopment();  return;
		vector<uint8_t> vctBtnID;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SendReceive");
		//uiMenu.AddItem(artiGetText("FF0000000099"));vctBtnID.push_back(0);//循环发送控帧
		uiMenu.AddItem(artiGetText("FF000000009A")); vctBtnID.push_back(1);//循环发送单帧
		uiMenu.AddItem(artiGetText("FF000000009B")); vctBtnID.push_back(2);//循环发送长帧
		uiMenu.AddItem(artiGetText("FF000000009C")); vctBtnID.push_back(3);//循环发送0x0FFF字节命令

		uiMenu.SetHelpButtonVisible(true);

		/*
		* 3.配置和测试接口
		*/
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*  1. 单帧命令:  [02] 10 EF
				*  2. 多帧命令:  [0B] 19 06 E1 09 09 FF 01 02 03 04 05
				*  3. 0x0FFF字节命令: [FFF] 10 11 12 13 14 15 16 17 18 19 ...
				*/
				ShowMsgBoxDemo("SendFrame", artiGetText("FF000000009E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (uRetBtn < vctBtnID.size())
			{
				ShowEstablishComMsg();

				string strSendFrame = "";
				CSendFrame SendFrame = CSendFrame();

				if (0 == vctBtnID[uRetBtn])
				{
					strSendFrame = "NULL";
					SendFrame = CSendFrame();
				}
				else if (1 == vctBtnID[uRetBtn])
				{
					strSendFrame = "[02] 10 EF";
					SendFrame = CSendFrame(CBinary("\x00\x00\x07\xE0\x10\xFF", 6), CSendFrame::SF_RECEIVE_AUTO_EX);
				}
				else if (2 == vctBtnID[uRetBtn])
				{
					strSendFrame = "[0B] 19 06 E1 09 09 FF 01 02 03 04 05";
					SendFrame = CSendFrame(CBinary("\x00\x00\x07\xE0\x19\x06\xE1\x09\x09\xFF\x01\x02\x03\x04\x05", 15), CSendFrame::SF_RECEIVE_AUTO_EX);
				}
				else if (3 == vctBtnID[uRetBtn])
				{
					strSendFrame = "[FFF] 10 11 12 13 FF FF FF FF FF FF ...";
					SendFrame = CSendFrame(CBinary("\x00\x00\x07\xE0\x10\x11\x12\x13\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x00\x01\x02\x03", 4099), CSendFrame::SF_RECEIVE_AUTO_EX);
				}

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(0, 500, 20, 0, 5000);

				vector<int32_t> vctColWidth;
				vctColWidth.push_back(40);
				vctColWidth.push_back(60);

#if __Multi_System_Test__
				CArtiList uiList(m_uThread);
#else
				CArtiList uiList;
#endif
				uiList.InitTitle("SendFrame");		//"参数列表"
				uiList.SetColWidth(vctColWidth);
				uiList.AddItem("SendFrame"); uiList.SetItem(0, 1, "ReceiveFrame");
				uiList.AddItem(strSendFrame);

				while (1)
				{
					CRecvFrame ReceiveFrame;
					ecu.SendReceive(SendFrame, ReceiveFrame);

					std::this_thread::sleep_for(std::chrono::milliseconds(1000));

					string strTemp = PrintRecvFrame(ReceiveFrame);
					uiList.SetItem(1, 1, strTemp);

					Delay(100);
					uRetBtn = uiList.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
				}

				ShowMsgBoxDemo("SendReceive", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SendReceive1()
	{
		ShowFuncInDevelopment();  return;
	}

	void CAPITest::EcuInterfaceTest_SendReceive2()
	{
		//ShowFuncInDevelopment();  return;
		vector<uint8_t> vctBtnID;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SendReceive");
		uiMenu.AddItem(artiGetText("FF000000009D")); vctBtnID.push_back(0);//"循环发送单帧、长帧、超长帧命令"

		uiMenu.SetHelpButtonVisible(true);

		/*
		* 3.配置和测试接口
		*/
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*  1. 单帧命令  :  [02] 10 EF
				*  2. 多帧命令  :  [0B] 19 06 E1 09 09 FF 01 02 03 04 05
				*  3. 超长帧命令:  [FFF] 10 11 12 13 14 15 16 17 18 19 ...
				*/
				ShowMsgBoxDemo("SendFrame", artiGetText("FF000000009E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (uRetBtn < vctBtnID.size())
			{
				ShowEstablishComMsg();

				CMultiSendFrame MultiSendFrame;
				CMultiRecvFrame MultiRecvFrame;

				MultiSendFrame.Append(CSendFrame(CBinary("\x00\x00\x07\xE0\x10\xFF", 6), CSendFrame::SF_RECEIVE_AUTO_EX));
				MultiSendFrame.Append(CSendFrame(CBinary("\x00\x00\x07\xE0\x19\x06\xE1\x09\x09\xFF\x01\x02\x03\x04\x05", 15), CSendFrame::SF_RECEIVE_AUTO_EX));
				MultiSendFrame.Append(CSendFrame(CBinary("\x00\x00\x07\xE0\x10\x11\x12\x13\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x00\x01\x02\x03", 4099), CSendFrame::SF_RECEIVE_AUTO_EX));

				vector<int32_t> vctColWidth;
				vctColWidth.push_back(40);
				vctColWidth.push_back(60);

#if __Multi_System_Test__
				CArtiList uiList(m_uThread);
#else
				CArtiList uiList;
#endif
				uiList.InitTitle("SendFrame");		//"参数列表"
				uiList.SetColWidth(vctColWidth);
				uiList.AddItem("SendFrame"); uiList.SetItem(0, 1, "ReceiveFrame");
				uiList.AddItem("[02] 10 EF");
				uiList.AddItem("[0B] 19 06 E1 09 09 FF 01 02 03 04 05");
				uiList.AddItem("[FFF] 10 11 12 13 FF FF FF FF FF FF ...");

				CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_CAN);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_06, CStdCommMaco::ObdPinType::PIN_OBD_14);
				ecu.SetBaudRate(500 * 1000);
				ecu.SetCanFramePad(0xFF);
				ecu.SetFlowControlMode(CStdCommMaco::FlowCtrlType::FCT_AUTO);

				CBinary binMask = CBinary("\xFF\xFF\xFF\xFF", 4);
				CBinary binFilterId = CBinary("\x00\x00\x07\xE8", 4);
				ecu.SetFilterId(binMask.GetBuffer(), binFilterId.GetBuffer(), 4);
				ecu.SetCommTime(0, 500, 20, 0, 2000);

				while (1)
				{
					ecu.SendReceive(MultiSendFrame, MultiRecvFrame);

					for (uint8_t i = 0; i < MultiRecvFrame.GetSize(); i++)
					{
						string strTemp = PrintRecvFrame(MultiRecvFrame.GetAt(i));
						uiList.SetItem(1 + i, 1, strTemp);
					}

					Delay(100);
					uRetBtn = uiList.Show();
					if (DF_ID_BACK == uRetBtn)
					{
						break;
					}
				}

				ShowMsgBoxDemo("SendReceive", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetPinStatus()
	{
		//	ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strPinNum = "PIN_OBD_07";
		string strPinVoltageMv = "5000mV";

		CStdCommMaco::ObdPinType PinNum = CStdCommMaco::ObdPinType::PIN_OBD_07;
		uint32_t PinVoltageMv = 5000;

		string strIoPort = "PIN_OBD_07";
		string strStatusWay = "PST_VALTAGE";

		CStdCommMaco::ObdPinType    IoPort = CStdCommMaco::ObdPinType::PIN_OBD_07;
		CStdCommMaco::PinStatusType StatusWay = CStdCommMaco::PinStatusType::PST_VALTAGE;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("GetPinStatus");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddGroup("SetPinVoltage");
		uiList.AddItem("PinNum");
		uiList.AddItem("PinVoltageMv");
		uiList.SetItem(1, 1, strPinNum);
		uiList.SetItem(2, 1, strPinVoltageMv);

		uiList.AddGroup("GetPinStatus");
		uiList.AddItem("IoPort");
		uiList.AddItem("StatusWay");
		uiList.SetItem(4, 1, strIoPort);
		uiList.SetItem(5, 1, strStatusWay);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.调用SetPinVoltage，设置引脚电压；
				*   ->2.调用GetPinStatus获取引脚状态；
				*   ->3.使用示波器或逻辑分析仪，测量对应引脚电压；
				*/
				ShowMsgBoxDemo("GetPinStatus", artiGetText("FF000000007F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				ShowEstablishComMsg();

				CEcuInterface ecu;
				ecu.SetPinVoltage(PinNum, PinVoltageMv);

				/* PC测试问题描述 //  [3/18/2022 qunshang.li]
				*  1.SetPinVoltage设置引脚电平为0时，GetPinStatus获取的仍是高电平。
				*  2.GetPinStatus设置PST_LEVEL或者PST_VALTAGE，返回值均一样。
				*  3.电平1对应引脚：1,2,3,7,8,9,10,11,12,13
				*  4.电平0对应引脚：4,5
				*  5.电平24对应引脚：6,14,15
				*  6.电平122对应引脚：16
				*/
				uint32_t uRet = ecu.GetPinStatus(IoPort, StatusWay);

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, "%d", uRet);
				ShowMsgBoxDemo(artiGetText("FF000000007E"), buff, DF_MB_OK, DT_LEFT, -1, m_uThread);//GetPinStatus返回值
				ShowMsgBoxDemo("GetPinStatus", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (1 == uSelect)
				{
					GetParamValue(PinNum, strPinNum, mapObdPinType);
					uiList.SetItem(1, 1, strPinNum);
				}
				else if (2 == uSelect)
				{
					GetParamValue(PinVoltageMv, strPinVoltageMv, mapPinVoltageMv);
					uiList.SetItem(2, 1, strPinVoltageMv);
				}
				if (4 == uSelect)
				{
					GetParamValue(IoPort, strIoPort, mapObdPinType);
					uiList.SetItem(4, 1, strIoPort);
				}
				else if (5 == uSelect)
				{
					GetParamValue(StatusWay, strStatusWay, mapPinStatusType);
					uiList.SetItem(5, 1, strStatusWay);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_ActiveDoipPin()
	{
		ShowFuncInDevelopment();  return;
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(40);
		vctColWidth.push_back(60);

		/*
		* 1.配置接口参数初始值
		*/

		string strPinNum = "PIN_OBD_07";
		string strActiveEnable = "PST_VALTAGE";

		CStdCommMaco::ObdPinType  PinNum = CStdCommMaco::ObdPinType::PIN_OBD_08;
		uint32_t ActiveEnable = 1;

		/*
		* 2.显示参数列表
		*/
#if __Multi_System_Test__
		CArtiList uiList(m_uThread);
#else
		CArtiList uiList;
#endif
		uiList.InitTitle("ActiveDoipPin");		//"参数列表"
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("IoPort");
		uiList.AddItem("StatusWay");

		uiList.SetItem(0, 1, strPinNum);
		uiList.SetItem(1, 1, strActiveEnable);

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
			else if (DF_ID_FREEBTN_0 == uRetBtn) // 显示帮助信息
			{
				/*
				* 测试说明:
				*   ->1.IoOutputPin : 通过模拟KWP和CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoOutputPin设置是否正常；
				*   ->2.IoInputPin  : 通过模拟CAN通信，或使用示波器和逻辑分析仪测试引脚波形，来判断IoInputPin设置是否正常；
				*   ->3.WorkVoltage : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压，来判断WorkVoltage设置是否正常；
				*   ->4.PinProperty : 模拟KWP和CAN通信，使用示波器或逻辑分析仪测试引脚电压和波形，来判断PinProperty设置是否正常；
				*/
				ShowMsgBoxDemo("ActiveDoipPin", artiGetText("FF0000000054"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn) // 测试
			{
				/*CEcuInterface ecu;
				ecu.SetProtocolType(CStdCommMaco::ProtocolType::PT_KWP);
				ecu.SetIoPin(CStdCommMaco::ObdPinType::PIN_OBD_07, CStdCommMaco::ObdPinType::PIN_OBD_NONE, CStdCommMaco::PinVoltageType::PinVol_12V);
				ecu.SetBaudRate(Bps, FdBps);
				ecu.SetCommTime(20, 800, 100, 5);

				vector<CSendFrame> vctSendFrame;
				CSendFrame EmptySf;
				EmptySf.Clear();
				vctSendFrame.push_back(EmptySf);
				vctSendFrame.push_back(CSendFrame(CBinary("\x82\x10\xF1\x10\x89\x1C", 6), CSendFrame::SF_RECEIVE_AUTO));
				vctSendFrame.push_back(CSendFrame(CBinary("\xC1\x33\xF1\x81\x66", 5), CSendFrame::SF_RECEIVE_AUTO));
				ExeSendRecvLoop(ecu, vctSendFrame, 1, 1 * 1000);*/
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(PinNum, strPinNum, mapObdPinType);
					uiList.SetItem(0, 1, strPinNum);
				}
				else if (1 == uSelect)
				{
					GetParamValue(ActiveEnable, strActiveEnable, mapActiveEnable);
					uiList.SetItem(1, 1, strActiveEnable);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_SelectDoipOption()
	{
		ShowFuncInDevelopment();  return;
	}

	void CAPITest::EcuInterfaceTest_GetDoipModule()
	{
		ShowFuncInDevelopment();  return;
	}

	void CAPITest::EcuInterfaceTest_Log()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("Log");
		uiMenu.AddItem(artiGetText("FF0000000096"));	//打印单行文本
		uiMenu.AddItem(artiGetText("FF0000000097"));	//打印多行文本
		//uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				ShowMsgBoxDemo("Log", artiGetText("FF0000000080"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else/* if (0 == uRetBtn)*/
			{
				if (0 == uRetBtn)
				{
					ShowMsgBoxDemo(artiGetText("FF0000000098"), TextSingleLine, DF_MB_OK, DT_LEFT, -1, m_uThread);
					ecu.Log(TextSingleLine.c_str());
				}
				else
				{
					ShowMsgBoxDemo("Log", TextMulitLine, DF_MB_OK, DT_LEFT, -1, m_uThread);
					ecu.Log(TextMulitLine.c_str());
				}
				ShowMsgBoxDemo("Log", artiGetText("FF000000002D"), DF_MB_OK, DT_LEFT, -1, m_uThread);//测试结束!
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetVersion()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetVersion");
		uiMenu.AddItem(artiGetText("FF0000000032"));	//"获取VCI版本号"
		uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：Coding of version numbers
				*	HH 为 最高字节, Bit 31 ~Bit 24   主版本号（正式发行），0...255
				*	LL 为 次高字节, Bit 23 ~Bit 16   次版本号（正式发行），0...255
				*	YY 为 次低字节, Bit 15 ~Bit 8    最低版本号（测试使用），0...255
				*	XX 为 最低字节, Bit 7 ~Bit 0    保留
				*
				*	例如 0x02010300, 表示 V2.01.003
				*	例如 0x020B0000, 表示 V2.11
				*/
				ShowMsgBoxDemo("GetVersion", artiGetText("FF0000000080"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				static uint32_t uVers = ecu.GetVersion();
				if (uVers == 0)
				{
					/*
					* "未获取到VCI类型，请确认VCI是否连接。"
					*/
					ShowMsgBoxDemo("GetVersion", artiGetText("FF0000000033"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, "0x%08X", uVers);
					ShowMsgBoxDemo("GetVersion", buff, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetVciTypeName()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetVciTypeName");
		uiMenu.AddItem(artiGetText("FF0000000034"));
		uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*	 返回VCI的类型名称：
				*	   例如"AD900VCI"指AD900平板蓝牙小接头
				*	   如果VCI没有连接上，返回空串
				*
				*	 VCI类型名称：
				*		"AD900TOOL"    -->  AD900 Tool诊断工装盒子
				*		"AD900VCI"     -->  AD900 VCI 小接头，只能平板蓝牙连接
				*		"EasyVCI"      -->  TOPKEY EasyVCI 小接头
				*/
				ShowMsgBoxDemo("GetVciTypeName", artiGetText("FF0000000081"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				static string strText = ecu.GetVciTypeName();
				if (strText.empty())
				{
					/*
					* "未获取到VCI类型，请确认VCI是否连接。"
					*/
					ShowMsgBoxDemo("GetVciTypeName", artiGetText("FF0000000035"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					ShowMsgBoxDemo("GetVciTypeName", strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetVciSN()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetVciSN");
		uiMenu.AddItem(artiGetText("FF000000004C"));//获取VCI的序列号
		uiMenu.SetHelpButtonVisible(true);

		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*   1.返回VCI的序列号, 例如：“JV0013BA100044”
				*/
				ShowMsgBoxDemo("GetVciSN", artiGetText("FF0000000082"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				static string strText = ecu.GetVciSN();
				ShowMsgBoxDemo("GetVciSN", strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetVciKey()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetVciKey");
		uiMenu.AddItem(artiGetText("FF000000004D"));//获取VCI的6字节校验码
		uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*   1.返回VCI的校验码, 例如：“123456”
				*/
				ShowMsgBoxDemo("GetVciKey", artiGetText("FF0000000083"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				static string strText = ecu.GetVciKey();
				ShowMsgBoxDemo("GetVciKey", strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetVciMcuId()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetVciMcuId");
		uiMenu.AddItem(artiGetText("FF000000004F"));//获取VCI的MCU的ID
		uiMenu.SetHelpButtonVisible(true);

		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*   1.返回VCI MCU的ID, 例如：[27 00 34 00 03 51 38 32 30 34 35 32]
				*/
				ShowMsgBoxDemo("GetVciMcuId", artiGetText("FF0000000084"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				vector<uint8_t> vctMcuId = ecu.GetVciMcuId();
				string strText = "";
				for (uint32_t i = 0; i < vctMcuId.size(); i++)
				{
					memset(buff, 0, sizeof(buff));
					SPRINTF_S(buff, "%02X ", vctMcuId[i]);
					strText = strText + buff;
				}
				ShowMsgBoxDemo("GetVciMcuId", strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
		}
	}

	void CAPITest::EcuInterfaceTest_IsVciConnected()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("IsVciConnected");
		uiMenu.AddItem(artiGetText("FF0000000036"));//"VCI是否已经连接"
		uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				* 1.true, 已连接； false, 没有连接
				*/
				ShowMsgBoxDemo("IsVciConnected", artiGetText("FF0000000085"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				if (ecu.IsVciConnected())
				{
					/*
					* "VCI已连接。"
					*/
					ShowMsgBoxDemo("IsVciConnected", artiGetText("FF0000000037"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					/*
					* "VCI未连接。"
					*/
					ShowMsgBoxDemo("IsVciConnected", artiGetText("FF0000000038"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_GetCommType()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("GetCommType");
		uiMenu.AddItem(artiGetText("FF000000004B"));//"获取当前连接的VCI的连接方式"
		uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*   1.[not connected]       VCI没有连接
				*   2.[usb]                 当前是USB连接方式
				*   3.[system bluetooth]    当前是平板蓝牙连接方式
				*/
				ShowMsgBoxDemo("GetCommType", artiGetText("FF0000000086"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				string strText = ecu.GetCommType();
				ShowMsgBoxDemo("GetCommType", strText, DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
		}
	}

	void CAPITest::EcuInterfaceTest_VciReset()
	{
		ShowFuncNotSupport();   return;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("VciReset");
		uiMenu.AddItem(artiGetText("FF0000000039"));//复位VCI
		//uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*/
				ShowMsgBoxDemo("VciReset", artiGetText("FF0000000081"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR == ecu.VciReset())
				{
					/*
					* "设置成功！\n请检测下位机VCI是否复位？"
					*/
					ShowMsgBoxDemo("VciReset", artiGetText("FF000000003A"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					//"设置失败!"
					ShowMsgBoxDemo("VciReset", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_VciVehicleLedOn()
	{
		ShowFuncNotSupport();   return;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("VciVehicleLedOn");
		uiMenu.AddItem(artiGetText("FF000000003B"));//0, 灯灭
		uiMenu.AddItem(artiGetText("FF000000003C"));//1, 灯亮
		//uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*/
				ShowMsgBoxDemo("GetVciSN", artiGetText("FF0000000081"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR == ecu.VciVehicleLedOn(0))
				{
					/*
					* "设置成功！\n请检测下位机VCI通信灯是否灭灯？"
					*/
					ShowMsgBoxDemo("VciVehicleLedOn", artiGetText("FF000000003D"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					ShowMsgBoxDemo("VciVehicleLedOn", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
			else
			{
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR == ecu.VciVehicleLedOn(1))
				{
					/*
					* "设置成功！\n请检测下位机VCI通信灯是否亮灯？"
					*/
					ShowMsgBoxDemo("VciVehicleLedOn", artiGetText("FF000000003E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					ShowMsgBoxDemo("VciVehicleLedOn", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CAPITest::EcuInterfaceTest_VciBuzzOn()
	{
		ShowFuncNotSupport();   return;
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("VciBuzzOn");
		uiMenu.AddItem(artiGetText("FF000000003F"));//关闭蜂鸣器
		uiMenu.AddItem(artiGetText("FF0000000040"));//打开蜂鸣器
		//uiMenu.SetHelpButtonVisible(true);
		CEcuInterface ecu;

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				*说    明：
				*  1.
				*/
				ShowMsgBoxDemo("VciBuzzOn", artiGetText("FF0000000081"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (0 == uRetBtn)
			{
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR == ecu.VciBuzzOn(0))
				{
					/*
					* 设置成功！\n请检测下位机蜂鸣器是否关闭。
					*/
					ShowMsgBoxDemo("VciBuzzOn", artiGetText("FF0000000041"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					ShowMsgBoxDemo("VciBuzzOn", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
			else
			{
				if (CStdCommMaco::ErrorCodeType::STATUS_NOERROR == ecu.VciBuzzOn(1))
				{
					/*
					* 设置成功！\n请检测下位机蜂鸣器是否打开。
					*/
					ShowMsgBoxDemo("VciBuzzOn", artiGetText("FF0000000042"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
				else
				{
					ShowMsgBoxDemo("VciBuzzOn", artiGetText("FF000000002E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
				}
			}
		}
	}

	void CAPITest::GetKeepFrame(CSendFrame& KeepFrame, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("KeepFrame");

		vector<string> vctStrText;
		vector<CSendFrame> vctKeepFrame;

		vctStrText.push_back("NULL");			vctKeepFrame.push_back(CSendFrame(CBinary()));
		vctStrText.push_back("81 28 F1 3E 00");		    	vctKeepFrame.push_back(CSendFrame(CBinary("\x81\x28\xF1\x3E\x00", 5)));
		vctStrText.push_back("82 28 F1 3E 00 01");			vctKeepFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x3E\x00\x01", 6)));
		vctStrText.push_back("82 28 F1 3E 01 02");			vctKeepFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x3E\x01\x02", 6)));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctKeepFrame.size())
				{
					KeepFrame = vctKeepFrame[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetResponesd(CRecvFrame& Responesd, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("Responesd");

		vector<string> vctStrText;
		vector<CRecvFrame> vctResponesd;

		vctStrText.push_back("NULL");						vctResponesd.push_back(CRecvFrame(CBinary()));
		vctStrText.push_back("81 F1 28 7E 40");		    	vctResponesd.push_back(CRecvFrame(CBinary("\x81\xF1\x28\x7E\x40", 5)));
		vctStrText.push_back("82 F1 28 7E 00 19");			vctResponesd.push_back(CRecvFrame(CBinary("\x82\xF1\x28\xF1\x7E\x00\x19", 6)));
		vctStrText.push_back("82 F1 28 7E 01 1A");			vctResponesd.push_back(CRecvFrame(CBinary("\x82\xF1\x28\xF1\x7E\x01\x1A", 6)));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctResponesd.size())
				{
					Responesd = vctResponesd[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetvctHihgLow(vector<uint16_t>& vctHihgLow, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("vctHihgLow");

		vector<string> vctStrText;
		vector<vector<uint16_t>> vctVctHihgLow;

		vctStrText.push_back("High:20ms, Low:20ms, High:20ms, Low:20ms");					vctVctHihgLow.push_back(vector<uint16_t>{20, 20, 20, 20});
		vctStrText.push_back("High:15ms, Low:2500ms, High:15ms, Low:3500ms");				vctVctHihgLow.push_back(vector<uint16_t>{15, 2500, 15, 3500});
		vctStrText.push_back("High:0ms, Low:15ms, High:2500ms, Low:15ms, High:3500ms");	vctVctHihgLow.push_back(vector<uint16_t>{0, 15, 2500, 15, 3500});
		vctStrText.push_back("High:1000ms, Low:1000ms, High:1000ms, Low:1000ms");			vctVctHihgLow.push_back(vector<uint16_t>{1000, 1000, 1000, 1000, 1000});

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctVctHihgLow.size())
				{
					vctHihgLow = vctVctHihgLow[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetCommTime(vector<uint32_t>& vctCommTime, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("vctCommTime");

		vector<string> vctStrText;
		vector<vector<uint32_t>> vctvctCommTime;

		vctStrText.push_back("0, 500, 50, 0");			vctvctCommTime.push_back(vector<uint32_t>{0, 500, 50, 0});
		vctStrText.push_back("0, 1000, 10, 0");			vctvctCommTime.push_back(vector<uint32_t>{0, 1000, 10, 0});
		vctStrText.push_back("10, 200, 55, 5, 5000");	vctvctCommTime.push_back(vector<uint32_t>{10, 200, 55, 5, 5000});
		vctStrText.push_back("30, 300, 35, 1, 5000");	vctvctCommTime.push_back(vector<uint32_t>{30, 300, 35, 1, 5000});

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctvctCommTime.size())
				{
					vctCommTime = vctvctCommTime[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetFunctionalAddress(vector<uint8_t>& vctFunctionalAddress, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("vctFunctionalAddress");

		vector<string> vctStrText;
		vector<vector<uint8_t>> vctvctFunctionalAddress;

		vctStrText.push_back("0x6A");			vctvctFunctionalAddress.push_back(vector<uint8_t>{0x6A});
		vctStrText.push_back("0x6B");			vctvctFunctionalAddress.push_back(vector<uint8_t>{0x6B});
		vctStrText.push_back("0x6A,0x6B");		vctvctFunctionalAddress.push_back(vector<uint8_t>{0x6A, 0x6B});

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctvctFunctionalAddress.size())
				{
					vctFunctionalAddress = vctvctFunctionalAddress[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetFilterMask(CBinary& FilterMask, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("FilterMask");

		vector<string> vctStrText;
		vector<CBinary> vctFilterMask;

		vctStrText.push_back("0x00,0xFF,0xFF");		    vctFilterMask.push_back(CBinary("\x00\xFF\xFF", 3));
		vctStrText.push_back("0x00,0x00,0x00,0x03");	vctFilterMask.push_back(CBinary("\x00\x00\x00\x03", 4));
		vctStrText.push_back("0xFF,0xFF,0xFF,0x00");	vctFilterMask.push_back(CBinary("\xFF\xFF\xFF\x00", 4));
		vctStrText.push_back("0xFF,0xFF,0xFF,0xFF");	vctFilterMask.push_back(CBinary("\xFF\xFF\xFF\xFF", 4));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctFilterMask.size())
				{
					FilterMask = vctFilterMask[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetFilterPattern(CBinary& FilterPattern, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("FilterPattern");

		vector<string> vctStrText;
		vector<CBinary> vctFilterPattern;

		vctStrText.push_back("0x00,0xF1,0x10");		    vctFilterPattern.push_back(CBinary("\x00\xF1\x10", 3));
		vctStrText.push_back("0x00,0x00,0x06,0x00");	vctFilterPattern.push_back(CBinary("\x00\x00\x06\x00", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE0");	vctFilterPattern.push_back(CBinary("\x00\x00\x07\xE0", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE7");	vctFilterPattern.push_back(CBinary("\x00\x00\x07\xE7", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE8");	vctFilterPattern.push_back(CBinary("\x00\x00\x07\xE8", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE9");	vctFilterPattern.push_back(CBinary("\x00\x00\x07\xE9", 4));
		vctStrText.push_back("0x94,0xDA,0xF1,0x60");	vctFilterPattern.push_back(CBinary("\x94\xDA\xF1\x60", 4));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctFilterPattern.size())
				{
					FilterPattern = vctFilterPattern[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetFilterBegin(CBinary& FilterBegin, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("FilterBegin");

		vector<string> vctStrText;
		vector<CBinary> vctFilterBegin;

		vctStrText.push_back("0x00,0x00,0x07,0xE0");		vctFilterBegin.push_back(CBinary("\x00\x00\x07\xE0", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE7");		vctFilterBegin.push_back(CBinary("\x00\x00\x07\xE7", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE8");		vctFilterBegin.push_back(CBinary("\x00\x00\x07\xE8", 4));
		vctStrText.push_back("0x98,0xDA,0xF1,0x00");		vctFilterBegin.push_back(CBinary("\x98\xDA\xF1\x00", 4));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctFilterBegin.size())
				{
					FilterBegin = vctFilterBegin[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetFilterEnd(CBinary& FilterEnd, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("FilterEnd");

		vector<string> vctStrText;
		vector<CBinary> vctFilterEnd;

		vctStrText.push_back("0x00,0x00,0x07,0xEF");		vctFilterEnd.push_back(CBinary("\x00\x00\x07\xEF", 4));
		vctStrText.push_back("0x98,0xDA,0xF1,0xFF");		vctFilterEnd.push_back(CBinary("\x98\xDA\xF1\xFF", 4));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctFilterEnd.size())
				{
					FilterEnd = vctFilterEnd[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetRecvFrameId(CBinary& RecvFrameId, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("FrameId");

		vector<string> vctStrText;
		vector<CBinary> vctFrameId;

		vctStrText.push_back("0x00,0x00,0x07,0xDF");		vctFrameId.push_back(CBinary("\x00\x00\x07\xDF", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE0");		vctFrameId.push_back(CBinary("\x00\x00\x07\xE0", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE7");		vctFrameId.push_back(CBinary("\x00\x00\x07\xE7", 4));
		vctStrText.push_back("0x00,0x00,0x07,0xE8");		vctFrameId.push_back(CBinary("\x00\x00\x07\xE8", 4));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctFrameId.size())
				{
					RecvFrameId = vctFrameId[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetSendFrame(CSendFrame& SendFrame, string& strText)
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif
		uiMenu.InitTitle("SendFrame");

		vector<string> vctStrText;
		vector<CSendFrame> vctSendFrame;

		//vctStrText.push_back("0xFE.0x04,0x91,0x6D");			vctSendFrame.push_back(CSendFrame(CBinary("\xFE\x04\x91\x6D", 4), CSendFrame::SF_RECEIVE_AUTO));
		//vctStrText.push_back("0x81,0x58,0xFC,0x81,0x56");		vctSendFrame.push_back(CSendFrame(CBinary("\x81\x58\xFC\x81\x56", 5), CSendFrame::SF_RECEIVE_AUTO));
		//vctStrText.push_back("0x81,0x46,0xF0,0x81,0x38");		vctSendFrame.push_back(CSendFrame(CBinary("\x81\x46\xF0\x81\x38", 5), CSendFrame::SF_RECEIVE_AUTO));
		vctStrText.push_back("0xC1,0x33,0xF1,0x81,0x66");		vctSendFrame.push_back(CSendFrame(CBinary("\xC1\x33\xF1\x81\x66", 5), CSendFrame::SF_RECEIVE_AUTO));
		vctStrText.push_back("0x82,0x28,0xF1,0x10,0x89,0x34");	vctSendFrame.push_back(CSendFrame(CBinary("\x82\x28\xF1\x10\x89\x34", 6), CSendFrame::SF_RECEIVE_AUTO));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctSendFrame.size())
				{
					SendFrame = vctSendFrame[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GlobalTest()
	{
		string strItem = "";
		string strValue = "";
		string strUnit = "";
		uint32_t uTemp = 0;

#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif

		uiActive.InitTitle(artiGetText("FF00000000CA"));
		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF00000000CB"));
		vctHeads.push_back(artiGetText("FF00000000CC"));
		vctHeads.push_back(artiGetText("FF00000000CD"));

		uiActive.SetHeads(vctHeads);

		//1. 获取stdshow版本号
		strItem = artiGetText("FF00000000D1"); //stdshow版本号
		strValue = "GetVersion";

		uTemp = CArtiGlobal::GetVersion();
		memset(buff, 0, sizeof(buff));
		SPRINTF_S(buff, "V%d.%02d.%03d", (uTemp & 0xFF000000) >> 24, (uTemp & 0xFF0000) >> 16, (uTemp & 0xFF00) >> 8);
		strUnit = buff;

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//2. 获取显示应用的版本号
		strItem = artiGetText("FF00000000D2");//显示应用的版本号
		strValue = "GetAppVersion";

		uTemp = CArtiGlobal::GetAppVersion();
		memset(buff, 0, sizeof(buff));
		SPRINTF_S(buff, "V%d.%02d.%03d", (uTemp & 0xFF000000) >> 24, (uTemp & 0xFF0000) >> 16, (uTemp & 0xFF00) >> 8);
		strUnit = buff;

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//3. 获取当前语言
		strItem = artiGetText("FF00000000D3");//当前语言
		strValue = "GetLanguage";
		strUnit = CArtiGlobal::GetLanguage();

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//4. 获取当前车型路径
		strItem = artiGetText("FF00000000D4");//当前车型路径
		strValue = "GetVehPath";
		strUnit = CArtiGlobal::GetVehPath();

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//5. 获取当前车型名称
		strItem = artiGetText("FF00000000D5");//当前车型名称
		strValue = "GetVehName";
		strUnit = CArtiGlobal::GetVehName();

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//6. 获取当前车辆VIN码
		CArtiGlobal::SetVIN("WB33A23C2L3181097");
		strItem = artiGetText("FF00000000D6");//当前车辆VIN码
		strValue = "GetVIN";
		strUnit = CArtiGlobal::GetVIN();

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//7. 设置当前车辆VIN码
		strItem = artiGetText("FF00000000D7");
		strValue = "SetVIN";
		strUnit = "WB33A23C2H3181097";
		CArtiGlobal::SetVIN(strUnit);

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//8. 设置车辆信息
		strItem = artiGetText("FF00000000D8");// 设置车辆信息
		strValue = "SetVehInfo";
		strUnit = artiGetText("FF00000000BF");//宝马/3'/320Li_B48/F35/
		CArtiGlobal::SetVehInfo(strUnit);

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//9. 设置系统名称
		strItem = artiGetText("FF00000000D9");//设置系统名称
		strValue = "SetSysName";
		strUnit = artiGetText("FF00000000BE");
		CArtiGlobal::SetSysName(strUnit);

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//10. 获取平板的序列号
		strItem = artiGetText("FF00000000DA");//平板的序列号
		strValue = "GetTabletSN";
		strUnit = CArtiGlobal::GetTabletSN();

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//11. 获取平板的6字节校验码
		strItem = artiGetText("FF00000000DB");//平板的6字节校验码
		strValue = "GetTabletKey";
		strUnit = CArtiGlobal::GetTabletKey();

		uiActive.AddItem(strItem, strValue, false, strUnit);

		//12. 网络连接状态
		strItem = artiGetText("FF00000000DC");//网络连接状态
		strValue = "IsNetworkAvailable";
		if (CArtiGlobal::IsNetworkAvailable())
		{
			strUnit = artiGetText("FF00000000BD");//连接
		}
		else
		{
			strUnit = artiGetText("FF00000000BC");//未连接
		}

		uiActive.AddItem(strItem, strValue, false, strUnit);

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
		}
	}

	void CAPITest::BlueToothTest()
	{
#if __Multi_System_Test__
		CArtiMenu uiMenu(m_uThread);
#else
		CArtiMenu uiMenu;
#endif

		uiMenu.InitTitle(artiGetText("FF0F00000010"));//蓝牙与VCI通讯测试
		uiMenu.AddItem(artiGetText("FF0F00000011") + "Type1");// 模拟CAN协议通讯
		uiMenu.AddItem(artiGetText("FF0F00000011") + "Type2");// 模拟CAN协议通讯
		uiMenu.AddItem(artiGetText("FF0F00000012"));// 模拟KWP协议通讯

		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (0 == (uRetBtn & 0xFF))
			{
				BlueToothTest_Can();
			}
			else if (1 == (uRetBtn & 0xFF))
			{
				BlueToothTest_Can_Type2();
			}
			else if (2 == (uRetBtn & 0xFF))
			{
				BlueToothTest_Kwp();
			}
		}
	}

	void CAPITest::BlueToothTest_Can()
	{
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif

		uiActive.InitTitle(artiGetText("FF0F00000011"));//模拟CAN协议通讯
		/*
		* 系统信息
		* 配置信息 = 560000000001,UDS
		* SysName  = 01 - 发动机电控系统
		* CommPin  = 6,14
		* EcuId    = 0x07E8
		* ToolId   = 0x07E0
		* BaudRate = 500000
		* CommTime = 0,200,1,0,6000
		*/
		uiActive.SetOperationTipsOnTop(artiGetText("FF0F00000013"));
		uiActive.AddItem("10 01 02 03 04 05 06 ...");
		uiActive.AddItem(artiGetText("FF0F0000001A"));////统计发送命令次数";
		uiActive.AddItem(artiGetText("FF0F0000001B"));////统计命令失败次数";

		uint32_t uSysID = 0x01;
		string strProtocol = "UDS";

		CAppLayer* prtAppLayer = new CAppLayer();
		CEnterSys* enterSys = new CEnterSys(uSysID, strProtocol);

		enterSys->InitProtocol();
		prtAppLayer->SetEnterSys(*enterSys);

		uint32_t uTime = 0x06;
		uint32_t uFailed = 0x00;

		CBinary binRecv;
		CBinary binCmd = CBinary("\x10\x01\x02\x03\x04\x05\x06", 7);

		uint32_t uRetBtn = DF_ID_NOKEY;

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			if (uTime < 0xFFF)
			{
				binRecv = prtAppLayer->m_EnterSys.SendReceive(binCmd, 1);
				if (!binRecv.GetSize())
				{
					uFailed += 1;
				}
				string strRecv = Binary2HexString(binRecv);
				string strCmd = Binary2HexString(binCmd);

				uiActive.SetItem(0, strCmd);
				uiActive.SetValue(0, strRecv);
				uiActive.SetValue(1, uint32ToString(uTime));
				uiActive.SetValue(2, uint32ToString(uFailed));

				binCmd += (++uTime) & 0xFF;
			}
		}
	}

	void CAPITest::BlueToothTest_Can_Type2()
	{
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif

		uiActive.InitTitle(artiGetText("FF0F00000011"));//模拟CAN协议通讯
		/*
		* 系统信息
		* 配置信息 = 560000000001,UDS
		* SysName  = 01 - 发动机电控系统
		* CommPin  = 6,14
		* EcuId    = 0x07E8
		* ToolId   = 0x07E0
		* BaudRate = 500000
		* CommTime = 0,200,1,0,6000
		*/
		uiActive.SetOperationTipsOnTop(artiGetText("FF0F00000013"));
		uiActive.AddItem("220000");
		uiActive.AddItem(artiGetText("FF0F0000001A"));//"统计发送命令次数";
		uiActive.AddItem(artiGetText("FF0F0000001B"));//"统计命令失败次数";

		uint32_t uSysID = 0x01;
		string strProtocol = "UDS";

		CAppLayer* prtAppLayer = new CAppLayer();
		CEnterSys* enterSys = new CEnterSys(uSysID, strProtocol);

		enterSys->InitProtocol();
		prtAppLayer->SetEnterSys(*enterSys);

		uint32_t uTime = 0x01;
		uint32_t uFailed = 0x00;

		CBinary binRecv;
		CBinary binCmd = CBinary("\x22\x00\x00", 3);

		uint32_t uRetBtn = DF_ID_NOKEY;

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}
			if (uTime < 0xFFFF)
			{
				binRecv = prtAppLayer->m_EnterSys.SendReceive(binCmd, 1);
// 				if ((binRecv.GetSize() >= 3) && (binRecv[0] == binCmd[0] + 0x40) && (binRecv[1] == binCmd[1]) && (binRecv[2] == binCmd[2]))
				if (!binRecv.GetSize() || binRecv[0] == 0x7F)
				{
					uFailed++;
					if (DF_ID_CANCEL == artiShowMsgBox("error!", "communication failed!", DF_MB_OKCANCEL, DT_CENTER))
					{
						return;
					}
				}
				string strRecv = Binary2HexString(binRecv);
				string strCmd = Binary2HexString(binCmd);

				uiActive.SetItem(0, strCmd);
				uiActive.SetValue(0, strRecv);
				uiActive.SetValue(1, uint32ToString(uTime));
				uiActive.SetValue(2, uint32ToString(uFailed));

				binCmd.SetAt(1, (uTime >> 8) & 0xFF);
				binCmd.SetAt(2, (uTime >> 0) & 0xFF);

				uTime = uTime + 1;
			}
		}
	}

	void CAPITest::BlueToothTest_Kwp()
	{
#if __Multi_System_Test__
		CArtiActive uiActive(m_uThread);
#else
		CArtiActive uiActive;
#endif

		uiActive.InitTitle(artiGetText("FF0F00000012"));//模拟KWP协议通讯
		/*
		* 系统信息
		* 配置信息 = 560000000001,KWP2000LINE
		* SysName  = 01 - 发动机电控系统
		* CommPin  = 7,15
		* EcuId    = 0x10
		* ToolId   = 0xF1
		* BaudRate = 10400
		* CommTime = 20,300,50,5,10000
		*/
		uiActive.SetOperationTipsOnTop(artiGetText("FF0F00000014"));
		uiActive.AddItem(artiGetText("FF0F0000001A"));//"统计发送命令次数"
		uiActive.AddItem("10 01 02 03 04 05 06 ...");

		uint32_t uSysID = 0x01;
		string strProtocol = "KWP2000LINE";

		CAppLayer* prtAppLayer = new CAppLayer();
		CEnterSys* enterSys = new CEnterSys(uSysID, strProtocol);

		enterSys->InitProtocol();
		prtAppLayer->SetEnterSys(*enterSys);

		uint32_t uTime = 0x07;

		CBinary binRecv;
		CBinary binCmd = CBinary("\x10\x01\x02\x03\x04\x05\x06", 7);

		uint32_t uRetBtn = DF_ID_NOKEY;

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				break;
			}

			binRecv = prtAppLayer->m_EnterSys.SendReceive(binCmd, CSendFrame::RECV_FRAME_NUM::SF_RECEIVE_ONE);
			string strRecv = Binary2HexString(binRecv);
			string strCmd = Binary2HexString(binCmd);

			uiActive.SetItem(1, strCmd);
			uiActive.SetValue(1, strRecv);
			uiActive.SetValue(0, uint32ToString(uTime, true));

			binCmd += (++uTime) & 0xFF;

			if (uTime >= 0x3F)
			{
				uTime = 0x07;
				binCmd = CBinary("\x10\x01\x02\x03\x04\x05\x06", 7);
			}
		}
	}

	void CAPITest::UnitTest()
	{
		CArtiMenu uiMenu;
		uiMenu.InitTitle(artiGetText("FF0F00000030"));	//公英制转换测试
		uiMenu.AddItem(artiGetText("FF0F0000002E"));	//英制转公制
		uiMenu.AddItem(artiGetText("FF0F0000002F"));	//公制转英制
		uiMenu.AddItem(artiGetText("FF0F0000002F") + "Type1");	//公制转英制

		bool bMetric = false;
		uint32_t uBtnMenu = DF_ID_NOKEY;

		while (1)
		{
			uBtnMenu = uiMenu.Show();
			if (uBtnMenu == DF_ID_BACK)
			{
				break;
			}
			else if ((uBtnMenu  == 0) || (uBtnMenu == 1))
			{
				bMetric = (uBtnMenu == 0) ? false : true;
				UnitTest_Type1(bMetric);
			}
			else if (uBtnMenu == 2)
			{
				UnitTest_Type2();
			}
		}
	}

	void CAPITest::UnitTest_Other()
	{
		CArtiMenu uiMenu;
		uiMenu.InitTitle(artiGetText("FF1000000003"));	//公英制转换测试
		uiMenu.AddItem(artiGetText("FF0F0000002E"));	//英制转公制
		uiMenu.AddItem(artiGetText("FF0F0000002F"));	//公制转英制
		uiMenu.AddItem(artiGetText("FF0F0000002F") + "Type1");	//公制转英制

		bool bMetric = false;
		uint32_t uBtnMenu = DF_ID_NOKEY;

		while (1)
		{
			uBtnMenu = uiMenu.Show();
			if (uBtnMenu == DF_ID_BACK)
			{
				break;
			}
			else if ((uBtnMenu == 0) || (uBtnMenu == 1))
			{
				bMetric = (uBtnMenu == 0) ? false : true;
				UnitTest_Type1_Other(bMetric);
			}
			else if (uBtnMenu == 2)
			{
				UnitTest_Type2_Other();
			}
		}
	}


	void CAPITest::UnitTest_Type1(bool bMetric)
	{
		vector<string> vctUnit;
		uint32_t uStartIndex = 0x0031;
		uint32_t uEndIndex = 0x01FF;
		CBinary binUnitIndex = CBinary("\xFF\x0F\x00\x00\x00\x31", 6);

		if (!bMetric)
		{
			uStartIndex = 0x100;
		}

		for (uint32_t i = uStartIndex; i < uEndIndex; i++)
		{
			binUnitIndex.SetAt(5, i & 0xFF);
			binUnitIndex.SetAt(4, (i & 0xFF00) >> 8);
			string strUnit = artiGetText(binUnitIndex);
			if (strUnit.empty())
			{
				break;
			}

			vctUnit.push_back(strUnit);
		}

		CArtiLiveData uiLiveData;
		uint32_t uRetBtn = DF_ID_NEXT;
		while (1)
		{
			if (DF_ID_NEXT == uRetBtn)
			{
				if (bMetric)
				{
					uiLiveData.InitTitle(artiGetText("FF0F0000002F"));			//公制转英制
				}
				else
				{
					uiLiveData.InitTitle(artiGetText("FF0F0000002E"));			//英制转公制
				}

				uiLiveData.SetNextButtonText(artiGetText("FF0000000113"));	//改变数值
				uiLiveData.SetNextButtonVisible(true);

				for (uint32_t i = 0; i < vctUnit.size(); i++)
				{
					uint32_t uValue = rand() % 200 + 20;
					string strValue = uint32ToString(uValue);

					uiLiveData.AddItem(strValue + " , " + vctUnit[i], strValue, vctUnit[i], uint32ToString(uValue - 10), uint32ToString(uValue + 20), uint32ToString(uValue + 10));
				}
			}
			else if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			uRetBtn = uiLiveData.Show();
		}
	}

	void CAPITest::UnitTest_Type2()
	{
		vector<string> vctUnit;
		uint32_t uStartIndex = 0x0031;
		uint32_t uEndIndex = 0x01FF;
		CBinary binUnitIndex = CBinary("\xFF\x0F\x00\x00\x00\x31", 6);

		for (uint32_t i = uStartIndex; i < uEndIndex; i++)
		{
			binUnitIndex.SetAt(5, i & 0xFF);
			binUnitIndex.SetAt(4, (i & 0xFF00) >> 8);
			string strUnit = artiGetText(binUnitIndex);
			if (strUnit.empty())
			{
				break;
			}

			vctUnit.push_back(strUnit);
		}

		vector<string> vctName;
		vector<string> vctValue;
		//vector<string> vctUnit;
		vector<string> vctMin;
		vector<string> vctMax;
		vector<string> vctReference;

		CArtiLiveData uiLiveData;
		uint32_t uRetBtn = DF_ID_NEXT;

		uiLiveData.InitTitle(artiGetText("FF0F0000002F"));			//公制转英制

		for (uint32_t i = 0; i < vctUnit.size(); i++)
		{
			uint32_t uValue = rand() % 200 + 20;
			string strValue = uint32ToString(uValue);

			uiLiveData.AddItem(strValue + " , " + vctUnit[i], strValue, vctUnit[i], uint32ToString(uValue - 10), uint32ToString(uValue + 20), uint32ToString(uValue + 10));

			vctName.push_back(strValue + " , " + vctUnit[i]);
			vctValue.push_back(strValue);
			//vctUnit.push_back(vctUnit[i]);
			vctMin.push_back(uint32ToString(uValue - 10));
			vctMax.push_back(uint32ToString(uValue + 20));
			vctReference.push_back(uint32ToString(uValue + 10));
		}

		uiLiveData.SetNextButtonVisible(false);

		while (1)
		{
			uRetBtn = uiLiveData.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			for (uint32_t i = 0; i < vctUnit.size(); i++)
			{
				uiLiveData.SetUnit(i, vctUnit[i]);
				uiLiveData.SetLimits(i, vctMin[i], vctMax[i]);
				uiLiveData.SetReference(i, vctReference[i]);
				uiLiveData.FlushValue(i, vctValue[i]);
			}
		}
	}

	void CAPITest::UnitTest_Type1_Other(bool bMetric)
	{
		vector<string> vctUnit;
		uint32_t uStartIndex = 0x0031;
		uint32_t uEndIndex = 0x01FF;
		CBinary binUnitIndex = CBinary("\xFF\x0F\x00\x00\x00\x31", 6);

		if (!bMetric)
		{
			uStartIndex = 0x100;
		}

		for (uint32_t i = uStartIndex; i < uEndIndex; i++)
		{
			binUnitIndex.SetAt(5, i & 0xFF);
			binUnitIndex.SetAt(4, (i & 0xFF00) >> 8);
			string strUnit = artiGetText(binUnitIndex);
			if (strUnit.empty())
			{
				break;
			}

			vctUnit.push_back(strUnit);
		}

		CArtiList uiLiveData;
		vector<int32_t> vctColWidth;
		vector<string> vctHeadNames;

		vctColWidth.push_back(40);
		vctColWidth.push_back(15);
		vctColWidth.push_back(15);
		vctColWidth.push_back(15);
		vctColWidth.push_back(15);

		vctHeadNames.push_back(artiGetText("FF0700000027"));
		vctHeadNames.push_back(artiGetText("FF0700000028"));
		vctHeadNames.push_back(artiGetText("FF0700000029"));
		vctHeadNames.push_back(artiGetText("FF070000002A"));
		vctHeadNames.push_back(artiGetText("FF070000002B"));


		uint32_t uRetBtn = DF_ID_FREEBTN_0;
		while (1)
		{
			if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				if (bMetric)
				{
					uiLiveData.InitTitle(artiGetText("FF0F0000002F"));			//公制转英制
				}
				else
				{
					uiLiveData.InitTitle(artiGetText("FF0F0000002E"));			//英制转公制
				}
				uiLiveData.SetColWidth(vctColWidth);
				uiLiveData.SetHeads(vctHeadNames);
				uiLiveData.AddButton(artiGetText("FF0000000113"));

				uiLiveData.SetButtonStatus(0, DF_ST_BTN_ENABLE);	//改变数值

				for (uint32_t i = 0; i < vctUnit.size(); i++)
				{
					uint32_t uValue = rand() % 200 + 20;
					string strValue = uint32ToString(uValue);
					stUnitItem	unitTem;

					unitTem.strValue = strValue;
					unitTem.strUnit = vctUnit[i];
					CEcuInterface::Log(unitTem.strValue.c_str());
					CEcuInterface::Log(unitTem.strUnit.c_str());

					unitTem = CArtiGlobal::UnitsConversion(unitTem);
					CEcuInterface::Log(unitTem.strValue.c_str());
					CEcuInterface::Log(unitTem.strUnit.c_str());

					uiLiveData.AddItem(strValue + "," + vctUnit[i]);
					uiLiveData.SetItem(i, 1, unitTem.strValue);
					uiLiveData.SetItem(i, 3, unitTem.strUnit);
				}
			}
			else if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			uRetBtn = uiLiveData.Show();
		}
	}

	void CAPITest::UnitTest_Type2_Other()
	{
		vector<string> vctUnit;
		uint32_t uStartIndex = 0x0031;
		uint32_t uEndIndex = 0x01FF;
		CBinary binUnitIndex = CBinary("\xFF\x0F\x00\x00\x00\x31", 6);

		for (uint32_t i = uStartIndex; i < uEndIndex; i++)
		{
			binUnitIndex.SetAt(5, i & 0xFF);
			binUnitIndex.SetAt(4, (i & 0xFF00) >> 8);
			string strUnit = artiGetText(binUnitIndex);
			if (strUnit.empty())
			{
				break;
			}

			vctUnit.push_back(strUnit);
		}

		CArtiList uiLiveData;
		vector<int32_t> vctColWidth;
		vector<string> vctHeadNames;

		vctColWidth.push_back(40);
		vctColWidth.push_back(15);
		vctColWidth.push_back(15);
		vctColWidth.push_back(15);
		vctColWidth.push_back(15);

		vctHeadNames.push_back(artiGetText("FF0700000027"));
		vctHeadNames.push_back(artiGetText("FF0700000028"));
		vctHeadNames.push_back(artiGetText("FF0700000029"));
		vctHeadNames.push_back(artiGetText("FF070000002A"));
		vctHeadNames.push_back(artiGetText("FF070000002B"));

		uiLiveData.InitTitle(artiGetText("FF0F0000002F"));			//公制转英制

		uiLiveData.SetColWidth(vctColWidth);
		uiLiveData.SetHeads(vctHeadNames);

		for (uint32_t i = 0; i < vctUnit.size(); i++)
		{
			string strValue = uint32ToString(i);
			uiLiveData.AddItem(strValue + "," + vctUnit[i]);
		}

		while (1)
		{
			uRetBtn = uiLiveData.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			for (uint32_t i = 0; i < vctUnit.size(); i++)
			{
				uint32_t uValue = rand() % 200 + 20;
				string strValue = uint32ToString(uValue);
				stUnitItem	unitTem;

				unitTem.strValue = strValue;
				unitTem.strUnit = vctUnit[i];
				CEcuInterface::Log(unitTem.strValue.c_str());
				CEcuInterface::Log(unitTem.strUnit.c_str());
				unitTem = CArtiGlobal::UnitsConversion(unitTem);
				CEcuInterface::Log(unitTem.strValue.c_str());
				CEcuInterface::Log(unitTem.strUnit.c_str());
				uiLiveData.SetItem(i, 1, unitTem.strValue);
				uiLiveData.SetItem(i, 3, unitTem.strUnit);
			}
			CEnterSys::Delay(1500);
		}
	}


	void CAPITest::ImmoTest()
	{
		CImmoTest ImmoTest;
		ImmoTest.ShowMenu();
	}

	void CAPITest::AppCrashTest()
	{
		CBinary binTest("\x01", 1);
		char	chvalue[1];
		uint16_t	i = 2;
		binTest.SetAt(2, 0x02);
		binTest.GetAt(2);
		chvalue[i] = '1';
		int32_t a = 1;
		int32_t b = 0;
		int32_t uvalue = 0;
		uvalue = a / b;

	}

#ifdef __TProgTest__

	void CAPITest::TProgTest()
	{
		vector<uint32_t> vctMenuID;
		CArtiMenu uiMenu;
		uiMenu.InitTitle("MainFuncType");
		uiMenu.AddItem("MFT_SYS");			vctMenuID.push_back(0x01);
		uiMenu.AddItem("MFT_EEPROM");		vctMenuID.push_back(0x02);
		uiMenu.AddItem("MFT_MCU");			vctMenuID.push_back(0x03);
		uiMenu.AddItem("MFT_FREQ");			vctMenuID.push_back(0x04);
		uiMenu.AddItem("MFT_RFID");			vctMenuID.push_back(0x05);
		uiMenu.AddItem("TProgTest_Chip_46"); vctMenuID.push_back(0x06);
		uiMenu.AddItem("GetCommType"); vctMenuID.push_back(0x07);

		uiMenu.SetHelpButtonVisible(true);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else if (DF_ID_HELP == uRetBtn)
			{
				/*
				* T-prog属于编程器，涉及的功能领域有EEPROM、MCU、ECU、发动机、RFID、
				* 遥控频率、气囊、仪表、防盗等当做一块内存来读写。所有功能都以主业务
				*（MainFuncType）为单位，根据业务的属性制定业务流程。
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F0000001C"), DF_MB_OK, DT_CENTER, -1, m_uThread);
			}
			else if (uRetBtn < vctMenuID.size())
			{
				if (0x01 == vctMenuID[uRetBtn])//MFT_SYS
				{
					TProgTest_MFT_SYS();
				}
				else if (0x02 == vctMenuID[uRetBtn])//MFT_EEPROM
				{
					TProgTest_MFT_EEPROM();
				}
				else if (0x03 == vctMenuID[uRetBtn])//MFT_MCU
				{
					TProgTest_MFT_MCU();
				}
				else if (0x04 == vctMenuID[uRetBtn])//MFT_FREQ
				{
					TProgTest_MFT_FREQ();
				}
				else if (0x05 == vctMenuID[uRetBtn])//MFT_RFID
				{
					TProgTest_MFT_RFID();
				}
				else if (0x06 == vctMenuID[uRetBtn])
				{
					TProgTest_Chip_46();
				}
				else if (0x07 == vctMenuID[uRetBtn])
				{
					TProgTest_GetCommType();
				}
			}
		}
	}

	void CAPITest::TProgTest_GetCommType()
	{
		artiShowMsgBox(CTProg::GetCommType(), CTProg::GetCommType());
	}

	void CAPITest::TProgTest_Chip_46()
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		CArtiList uiList;
		uiList.InitTitle("Test_Chip_46");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("intdata");
		uiList.SetItem(0, 1, "<0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000,0x00000000>");

		uiList.AddItem("ReadData01");
		uiList.AddItem("WriteData");
		uiList.AddItem("ReadData02");

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		CBinary binRead;
		CBinary binWrite("\x12\x34\x56\xDD", 4);

		CTProg TProg(CTprogMaco::MainFuncType::MFT_RFID);
		CTprogMaco::stINIT intdata = { 0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000,0x00000000 };

		if (TProg.Init(intdata))
		{
			TProg.Close();
			ShowMsgBoxDemo("TProg.Init", "Failed", DF_MB_OK, DT_CENTER, -1, m_uThread);
			return;
		}

		if (TProg.Read(0, 4, binRead))
		{
			TProg.Close();
			ShowMsgBoxDemo("TProg.Read", "Failed", DF_MB_OK, DT_CENTER, -1, m_uThread);
			return;
		}

		uiList.SetItem(1, 1, Binary2HexString(binRead));
		uiList.SetItem(2, 1, Binary2HexString(binWrite));

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
				* 测试说明：
				* 1.先读取 RFID 起始地址为 20 四个字节数据 ReadData01
				* 2.将 WriteData 写入 RFID 地址为 20 处
				* 3.再读取 RFID 起始地址为 20 四个字节数据 ReadData02
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000019"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				if (TProg.Write(20, binWrite))
				{
					TProg.Close();
					ShowMsgBoxDemo("TProg.Read", "Failed", DF_MB_OK, DT_CENTER, -1, m_uThread);
					return;
				}

				uiList.SetItem(3, 1, Binary2HexString(binRead));
			}
		}

		TProg.Close();
	}

	void CAPITest::TProgTest_MFT_SYS()
	{
		ShowFuncInDevelopment();
	}

	void CAPITest::TProgTest_MFT_EEPROM()
	{
	//	ShowFuncInDevelopment(); return;

		uint32_t uRetBtn = DF_ID_NOKEY;
		CTProg TProg(CTprogMaco::MainFuncType::MFT_EEPROM);

		string strinitData = "";// "46 -> <0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000>";
		CTprogMaco::stINIT initData;// = { 0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000 };

		GettagInit(initData, strinitData);
		uint32_t uRetFun = TProg.Init(initData);
		if (0 != uRetFun)
		{
			// "Init失败!"
			ShowMsgBoxDemo("Init", artiGetText("FF0F00000027"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return;
		}

		CArtiMenu uiMenu;
		vector<uint32_t> vctBtn;

		uiMenu.InitTitle("TProgTest_MFT_RFID");
		uiMenu.AddItem("Init");				vctBtn.push_back(1);
		uiMenu.AddItem("CheckConnStatus");	vctBtn.push_back(6);
		uiMenu.AddItem("GetSize");			vctBtn.push_back(2);
		uiMenu.AddItem("Read");				vctBtn.push_back(3);
		uiMenu.AddItem("Erase");			vctBtn.push_back(7);
		uiMenu.AddItem("GetSatus");			vctBtn.push_back(8);
		uiMenu.AddItem("Write");			vctBtn.push_back(4);
		uiMenu.AddItem("Close");			vctBtn.push_back(5);
		uiMenu.SetHelpButtonVisible(true);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				TProg.Close();
				return;
			}
			else if (uRetBtn == DF_ID_HELP)
			{
				/*
				* EEPROM的业务有读取、写入、校验、擦除、检查空白。
				* 本示例主要流程和接口如下：
				* 1. 初始化当前操作类型 （Init）
				* 2. 检查连接情况（CheckConnStatus）
				* 3. 获取数据大小（GetSize）
				* 4. 读取数据（Read）
				* 5. 擦除数据（Erase）
				* 6. 获取操作状态（GetSatus）
				* 7. 写入数据（Write）
				* 8. 读取数据（Read）
				* 9. 关闭功能操作（Close）
				*/
				ShowMsgBoxDemo("TProgTest_MFT_EEPROM", artiGetText("FF0F00000024"), DF_MB_OK, DT_CENTER, -1, m_uThread);

			}
			else if ((uRetBtn & 0xFF) < vctBtn.size())
			{
				if (vctBtn[uRetBtn & 0xFF] == 1)
				{
					TProgTest_Init(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 2)
				{
					TProgTest_GetSize(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 3)
				{
					TProgTest_Read(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 4)
				{
					TProgTest_Write(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 5)
				{
					TProgTest_Close(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 6)
				{
					TProgTest_CheckConnStatus(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 7)
				{
					TProgTest_Erase(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 8)
				{
					TProgTest_GetSatus(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
			}
		}
	}

	void CAPITest::TProgTest_MFT_MCU()
	{
	//	ShowFuncInDevelopment();  return;

		uint32_t uRetBtn = DF_ID_NOKEY;
		CTProg TProg(CTprogMaco::MainFuncType::MFT_MCU);

		string strinitData = "";// "46 -> <0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000>";
		CTprogMaco::stINIT initData;// = { 0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000 };

		GettagInit(initData, strinitData);

		if (0 != TProg.Init(initData))
		{
			// "Init失败!"
			ShowMsgBoxDemo("Init", artiGetText("FF0F00000027"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return;
		}

		CArtiMenu uiMenu;
		vector<uint32_t> vctBtn;

		uiMenu.InitTitle("TProgTest_MFT_RFID");
		uiMenu.AddItem("Init");				vctBtn.push_back(1);
		uiMenu.AddItem("CheckConnStatus");	vctBtn.push_back(6);
		uiMenu.AddItem("ChechkIsLock");		vctBtn.push_back(7);
		uiMenu.AddItem("Crack");			vctBtn.push_back(8);
		uiMenu.AddItem("GetSize");			vctBtn.push_back(2);
		uiMenu.AddItem("Read");				vctBtn.push_back(3);
		uiMenu.AddItem("Erase");			vctBtn.push_back(9);
		uiMenu.AddItem("Write");			vctBtn.push_back(4);
		uiMenu.AddItem("Close");			vctBtn.push_back(5);
		uiMenu.SetHelpButtonVisible(true);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				TProg.Close();
				return;
			}
			else if (uRetBtn == DF_ID_HELP)
			{
				/*
				* MCU的业务有读取、写入、校验、擦除、检查空白、分区、加锁、解锁。
				* 本示例主要流程和接口如下：
				* 1. 初始化当前操作类型 （Init）
				* 2. 检查连接情况（CheckConnStatus）
				* 3. 检查是否已经上锁（ChechkIsLock）
				* 4. 芯片破解（Crack）
				* 5. 获取数据大小（GetSize）
				* 6. 读取数据（Read）
				* 7. 擦除数据（Erase）
				* 8. 写入数据（Write）
				* 9. 读取数据（Read）
				*10. 关闭功能操作（Close）
				*/

				ShowMsgBoxDemo("TProgTest_MFT_MCU", artiGetText("FF0F00000024"), DF_MB_OK, DT_CENTER, -1, m_uThread);

			}
			else if ((uRetBtn & 0xFF) < vctBtn.size())
			{
				if (vctBtn[uRetBtn & 0xFF] == 1)
				{
					TProgTest_Init(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 2)
				{
					TProgTest_GetSize(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 3)
				{
					TProgTest_Read(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 4)
				{
					TProgTest_Write(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 5)
				{
					TProgTest_Close(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 6)
				{
					TProgTest_CheckConnStatus(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 7)
				{
					TProgTest_ChechkIsLock(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 8)
				{
					TProgTest_Crack(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 9)
				{
					TProgTest_Erase(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
			}
		}
	}

	void CAPITest::TProgTest_MFT_FREQ()
	{
		//ShowFuncInDevelopment();

		CTProg TProg(CTprogMaco::MainFuncType::MFT_FREQ);
		CTprogMaco::stINIT initData = { 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

		if (0 != TProg.Init(initData))
		{
			// "Init失败!"
			ShowMsgBoxDemo("Init", artiGetText("FF0F00000027"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return;
		}

		CArtiActive uiActive;
		uiActive.InitTitle("TProgTest_MFT_FREQ");
		uiActive.AddItem(artiGetText("FF0F00000028"));//"频率"
		uiActive.AddItem(artiGetText("FF0F00000029"));//"调制方式"
		uiActive.AddItem(artiGetText("FF0F0000002A"));//"强度"

		CBinary binRead;
		double freq = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;

		while (1)
		{
			uRetBtn = uiActive.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}

			TProg.Read(0x00, 0x128, binRead);
			if (binRead.GetSize() > 5)
			{
				freq = ((((binRead[0] * 0x100) + binRead[1]) * 0x100 + binRead[2]) * 0x100 + binRead[3]) / 1000.0;

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, "%0.00f", freq);
				uiActive.SetValue(0, buff);

				if (binRead[4] > 0x00)
				{
					uiActive.SetValue(1, "ASK");
				}
				else
				{
					uiActive.SetValue(1, "FSK");
				}

				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, "%d", 0x100 - binRead[5]);
				uiActive.SetValue(2, buff);
			}
		}
	}

	void CAPITest::TProgTest_MFT_RFID()
	{
		//ShowFuncInDevelopment();
		uint32_t uRetBtn = DF_ID_NOKEY;
		CTProg TProg(CTprogMaco::MainFuncType::MFT_RFID);

		string strinitData = "";// "46 -> <0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000>";
		CTprogMaco::stINIT initData;// = { 0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000 };

		GettagInit(initData, strinitData);

		if (0 != TProg.Init(initData))
		{
			// "Init失败!"
			ShowMsgBoxDemo("Init", artiGetText("FF0F00000027"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return;
		}

		CArtiMenu uiMenu;
		vector<uint32_t> vctBtn;

		uiMenu.InitTitle("TProgTest_MFT_RFID");
		uiMenu.AddItem("Init");				vctBtn.push_back(1);
		uiMenu.AddItem("GetSize");			vctBtn.push_back(2);
		uiMenu.AddItem("Read");				vctBtn.push_back(3);
		uiMenu.AddItem("Write");			vctBtn.push_back(4);
		uiMenu.AddItem("Close");			vctBtn.push_back(5);
		uiMenu.SetHelpButtonVisible(true);

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (uRetBtn == DF_ID_BACK)
			{
				TProg.Close();
				return;
			}
			else if (uRetBtn == DF_ID_HELP)
			{
				/*
				* RFID的业务只有读取、写入、校验。本示例主要流程和接口如下：
				* 1. 初始化当前操作类型 （Init）
				* 2. 获取数据大小（GetSize）
				* 3. 读取数据（Read）
				* 4. 写入数据（Write）
				* 5. 读取数据（Read）
				* 6. 关闭功能操作（Close）
				*/
				ShowMsgBoxDemo("TProgTest_MFT_RFID", artiGetText("FF0F00000023"), DF_MB_OK, DT_CENTER, -1, m_uThread);
			}
			else if ((uRetBtn & 0xFF) < vctBtn.size())
			{
				if (vctBtn[uRetBtn & 0xFF] == 1)
				{
					TProgTest_Init(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 2)
				{
					TProgTest_GetSize(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 3)
				{
					TProgTest_Read(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 4)
				{
					TProgTest_Write(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
				else if (vctBtn[uRetBtn & 0xFF] == 5)
				{
					TProgTest_Close(TProg, CTprogMaco::MainFuncType::MFT_RFID);
				}
			}
		}
	}

	uint32_t CAPITest::TProgTest_Init(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strinitData = "";// "<0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000>";
		CTprogMaco::stINIT initData;// = { 0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000 };

		CArtiList uiList;
		uiList.InitTitle("Init");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("initData");
		uiList.SetItem(0, 1, strinitData);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*   ->1.初始化当前操作类型
				*   ->2.initData 初始化参数，参数数据来自xml
				*   ->3.业务开始前必须先初始化，所用到的参数全部都在对应的XML数据表，XML格式和字段含义请参考xml数据格式
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000017"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				if (strinitData.empty())
				{
					// 请配置接口参数!!
					ShowMsgBoxDemo("Init", artiGetText("FF0F0000001D"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					continue;
				}

				uRetFun = TProg.Init(initData);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("Init", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_OK;
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("Init", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("Init", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("Init", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GettagInit(initData, strinitData);
					uiList.SetItem(0, 1, strinitData);
				}
			}
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_GetSize(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strSize = "";
		uint32_t Size = 0x00;

		CArtiList uiList;
		uiList.InitTitle("GetSize");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("Size");
		uiList.SetItem(0, 1, strSize);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.GetSize(Size);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("GetSize", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					uiList.SetItem(0, 1, uint32ToString(Size));
					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("GetSize", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("GetSize", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("GetSize", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_CheckConnStatus(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strConnStatus = "";
		uint8_t ConnStatus = 0;

		CArtiList uiList;
		uiList.InitTitle("CheckConnStatus");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("ConnStatus");
		uiList.SetItem(0, 1, strConnStatus);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			Delay(100);
			uRetBtn = uiList.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*   ->1.点击[Test]按键，检查连接情况
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.CheckConnStatus(ConnStatus);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("CheckConnStatus", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_OK;
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("CheckConnStatus", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("CheckConnStatus", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("CheckConnStatus", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_Read(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strAddress = "0x10";
		uint32_t uAddress = 0x10;

		string strLength = "0x04";
		uint32_t uLength = 0x04;

		string strRead = "";
		CBinary binRead;

		CArtiList uiList;
		uiList.InitTitle("Read");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("Address");
		uiList.SetItem(0, 1, strAddress);

		uiList.AddItem("Length");
		uiList.SetItem(1, 1, strLength);

		uiList.AddItem("binRead");

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.Read(uAddress, uLength, binRead);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					uiList.SetItem(2, 1, Binary2HexString(binRead));
					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uAddress, strAddress, mapTprogAddress);
					uiList.SetItem(0, 1, strAddress);
				}
				else if (1 == uSelect)
				{
					GetParamValue(uLength, strLength, mapTprogLength);
					uiList.SetItem(1, 1, strLength);
				}
			}

			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_Write(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strAddress = "0x10";
		uint32_t uAddress = 0x10;

		string strWrite = "01020304";
		CBinary binWrite = CBinary("\x01\x02\x03\x04", 4);

		CArtiList uiList;
		uiList.InitTitle("Write");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("Address");
		uiList.SetItem(0, 1, strAddress);

		uiList.AddItem("Length");
		uiList.SetItem(1, 1, strWrite);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.Write(uAddress, binWrite);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			else if (DF_ID_NOKEY != uRetBtn)
			{
				uint16_t uSelect = uiList.GetSelectedRow();
				if (0 == uSelect)
				{
					GetParamValue(uAddress, strAddress, mapTprogAddress);
					uiList.SetItem(0, 1, strAddress);
				}
				else if (1 == uSelect)
				{
					GetTrogBinWrite(binWrite, strWrite);
					uiList.SetItem(1, 1, strWrite);
				}
			}

			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_Erase(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		CArtiList uiList;
		uiList.InitTitle("Erase");
		uiList.SetColWidth(vctColWidth);

		uiList.AddItem("Erase");
		uiList.SetItem(0, 1, "");

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.Erase();
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("Erase", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("Read", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_GetSatus(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strStatus = "";
		uint8_t Status = 0x00;

		CArtiList uiList;
		uiList.InitTitle("GetSatus");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("Status");
		uiList.SetItem(0, 1, strStatus);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.GetSatus(Status);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("GetSatus", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					uiList.SetItem(0, 1, uint32ToString(Status));
					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("GetSatus", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("GetSatus", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("GetSatus", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_ChechkIsLock(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strIsLock = "";
		uint8_t IsLock = 0x00;

		CArtiList uiList;
		uiList.InitTitle("ChechkIsLock");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("IsLock");
		uiList.SetItem(0, 1, strIsLock);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.ChechkIsLock(IsLock);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("ChechkIsLock", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					uiList.SetItem(0, 1, uint32ToString(IsLock));
					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("ChechkIsLock", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("ChechkIsLock", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("ChechkIsLock", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_Crack(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		vector<int32_t> vctColWidth;
		vctColWidth.push_back(20);
		vctColWidth.push_back(80);

		string strCrk = "";
		uint8_t Crk = 0x00;

		CArtiList uiList;
		uiList.InitTitle("Crack");
		uiList.SetColWidth(vctColWidth);

		vector<string> vctHeads;
		vctHeads.push_back(artiGetText("FF0000000051"));	//参数
		vctHeads.push_back(artiGetText("FF000000002F"));	//参数值
		uiList.SetHeads(vctHeads);

		uiList.AddItem("Crk");
		uiList.SetItem(0, 1, strCrk);

		uiList.AddButtonEx("Help");
		uiList.AddButtonEx("Test");

		uint32_t uRetFun = 0;
		uint32_t uRetBtn = DF_ID_NOKEY;
		while (1)
		{
			if (DF_ID_BACK == uRetBtn)
			{
				return DF_ID_BACK;
			}
			else if (DF_ID_FREEBTN_0 == uRetBtn)
			{
				/*
				* 测试说明:
				*  ->1.点击[Test]按键，进行测试!
				*/
				ShowMsgBoxDemo(artiGetText("FF0000000052"), artiGetText("FF0F00000022"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			}
			else if (DF_ID_FREEBTN_1 == uRetBtn)
			{
				uRetFun = TProg.Crack(Crk);
				if (0 == uRetFun)
				{
					// "设置成功!"
					ShowMsgBoxDemo("Crack", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);

					uiList.SetItem(0, 1, uint32ToString(Crk));
					/*while (1)
					{
						Delay(100);
						uRetBtn = uiList.Show();
						if (DF_ID_BACK == uRetBtn)
						{
							return DF_ID_OK;
						}
						else if ((DF_ID_FREEBTN_0 == uRetBtn) || (DF_ID_FREEBTN_1 == uRetBtn) || (0 == uRetBtn) || (1 == uRetBtn))
						{
							break;
						}
					}
					continue;*/
				}
				else if (8 == uRetFun)
				{
					// "ErrorCode[08]:与设备没有连接!"
					ShowMsgBoxDemo("Crack", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else if (9 == uRetFun)
				{
					// "ErrorCode[09]:等待设备数据返回超时!"
					ShowMsgBoxDemo("Crack", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
				else
				{
					// "ErrorCode:其他状态码!"
					ShowMsgBoxDemo("Crack", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
					//return DF_ID_BACK;
				}
			}
			Delay(100);
			uRetBtn = uiList.Show();
		}

		return DF_ID_BACK;
	}

	uint32_t CAPITest::TProgTest_Close(CTProg& TProg, CTprogMaco::MainFuncType eMainType)
	{
		uint32_t uRetFun = TProg.Close();
		if (0 == uRetFun)
		{
			// "设置成功!"
			ShowMsgBoxDemo("Close", artiGetText("FF0F0000001E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return DF_ID_OK;
		}
		else if (8 == uRetFun)
		{
			// "ErrorCode[08]:与设备没有连接!"
			ShowMsgBoxDemo("Close", artiGetText("FF0F0000001F"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return DF_ID_BACK;
		}
		else if (9 == uRetFun)
		{
			// "ErrorCode[09]:等待设备数据返回超时!"
			ShowMsgBoxDemo("Close", artiGetText("FF0F00000020"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return DF_ID_BACK;
		}
		else
		{
			// "ErrorCode:其他状态码!"
			ShowMsgBoxDemo("Close", artiGetText("FF0F00000021"), DF_MB_OK, DT_LEFT, -1, m_uThread);
			return DF_ID_BACK;
		}
	}

	void CAPITest::GettagInit(CTprogMaco::tagInit& initData, string& strText)
	{
		CArtiMenu uiMenu;

		uiMenu.InitTitle(artiGetText("FF0F00000026"));//选择芯片类型

		vector<string> vctStrText;
		vector<CTprogMaco::tagInit> vctinitData;

		CTprogMaco::tagInit initTemp;
		/*
		参数说明：initData   初始化参数，参数数据来自xml

		  例如 当前操作类型 MFT_EEPROM
		  initData = <01, 03, 01, 00000080, 32, 65107555, 1110A000>
		  具体意义表示如下：
		  01          -->   编程类型为 EEPROM
		  03          -->   子类型, 表示 IIC 操作类型
		  01          -->   区域为EEPROM
		  00000080    -->   大小为128
		  32          -->   VCC电压，32=3.2V
		  65107555    -->   管脚配置为 0x65107555
		  1110A000    -->   属性配置位 0x1110A000
		*/
		//vctStrText.push_back("<0x01, 0x03, 0x01, 0x00000080, 0x32, 0x65107555, 0x1110A000>"); vctinitData.push_back(initTemp = { 0x01, 0x03, 0x01, 0x00000080, 0x32, 0x65107555, 0x1110A000 });
		vctStrText.push_back("46 -> <0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000>"); vctinitData.push_back(initTemp = { 0x04, 0x01, 0x80, 0x00000000, 0x32, 0x00000000, 0x00000000 });
		vctStrText.push_back("48 -> <0x04, 0x02, 0x01, 0x00000000, 0x32, 0x00000000, 0x00000000>"); vctinitData.push_back(initTemp = { 0x04, 0x02, 0x01, 0x00000000, 0x32, 0x00000000, 0x00000000 });

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctinitData.size())
				{
					initData = vctinitData[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

	void CAPITest::GetTrogBinWrite(CBinary& binWrite, string& strText)
	{
		CArtiMenu uiMenu;
		uiMenu.InitTitle("binWrite");
		vector<string> vctStrText;
		vector<CBinary> vctbinWrite;

		vctStrText.push_back("9E9C9A9296A4"); vctbinWrite.push_back(HexString2Binary("9E9C9A9296A4"));
		vctStrText.push_back("CCB9802F0604"); vctbinWrite.push_back(HexString2Binary("CCB9802F0604"));
		vctStrText.push_back("123456DD"); vctbinWrite.push_back(HexString2Binary("123456DD"));

		for (uint32_t i = 0; i < vctStrText.size(); i++)
		{
			uiMenu.AddItem(vctStrText[i]);
		}

		while (1)
		{
			uRetBtn = uiMenu.Show();
			if (DF_ID_BACK == uRetBtn)
			{
				break;
			}
			else
			{
				if (uRetBtn < vctbinWrite.size())
				{
					binWrite = vctbinWrite[uRetBtn];
					strText = vctStrText[uRetBtn];
				}
				break;
			}
		}
	}

#endif // __TProgTest__

	uint32_t ShowMsgBoxDemo(const string& strTitle, const string& strContent, uint32_t uButton, uint16_t uAlignType, int32_t iTimer, uint32_t thId)
	{
#if __Multi_System_Test__
		return artiShowMsgBoxEx(strTitle, strContent, uButton, uAlignType, iTimer, thId);
#else
		return artiShowMsgBox(strTitle, strContent, uButton, uAlignType, iTimer);
#endif
	}

	string CAPITest::PrintRecvFrame(const CRecvFrame& rf)
	{
		string strRet = "";
		uint32_t recvNums = rf.GetSize();
		for (uint32_t i = 0; i < recvNums; i++)
		{
			string strRecv = "";
			CBinary binSend = rf.GetAt(i);
			uint8_t* pRecvData = (uint8_t*)binSend.GetBuffer();

			std::wcout << "Rev Frame: ";
			for (uint32_t i = 0; i < binSend.GetSize(); i++)
			{
				printf("%02X ", pRecvData[i]);
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, "%02X, ", pRecvData[i]);
				strRecv += buff;
			}
			std::wcout << std::endl;
			strRet = strRet + strRecv + "\n";
		}

		return strRet;
	}

	string CAPITest::GetStringFromFrame(const CRecvFrame& rf)
	{
		string strRet = "";
		uint32_t recvNums = rf.GetSize();
		for (uint32_t i = 0; i < recvNums; i++)
		{
			string strRecv = "";
			CBinary binSend = rf.GetAt(i);
			uint8_t* pRecvData = (uint8_t*)binSend.GetBuffer();

			for (uint32_t i = 0; i < binSend.GetSize(); i++)
			{
				memset(buff, 0, sizeof(buff));
				SPRINTF_S(buff, "%02X ", pRecvData[i]);
				strRecv += buff;
			}
			strRet = strRet + strRecv + "\n";
		}

		return strRet;
	}

	string CAPITest::ExeSendRecvLoop(CEcuInterface& ecu, const std::vector<CSendFrame>& vctSendFrame, std::size_t Counts, uint32_t P2_us)
	{
		string strRet;
		CRecvFrame RecvFrame;
		for (std::size_t loopCnt = 0; loopCnt < Counts; loopCnt++)
		{
			for (auto TxFrame : vctSendFrame)
			{
				CRecvFrame recvFrame;
				recvFrame.Clear();

				ErrorCode_t restult = ecu.SendReceive(TxFrame, recvFrame);
				if (restult == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
					break;
				string strTemp = PrintRecvFrame(recvFrame);
				std::this_thread::sleep_for(std::chrono::milliseconds(P2_us));

				strRet = strRet + strTemp + "\n";
			}
		}
		return strRet;
	}
}
