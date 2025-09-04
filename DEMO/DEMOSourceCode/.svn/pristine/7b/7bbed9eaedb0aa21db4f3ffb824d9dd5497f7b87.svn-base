/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 数据流
* 功能描述 : 数据流举例
* 创 建 人 : panjun        20210123
* 审 核 人 : 
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#include "DemoEcuTest.h"
#include "ArtiMsgBox.h"
#include "DemoEnterSys.h"
#include "ArtiList.h"
#include "DemoVehicleStruct.h"
#include "StdCommMaco.h"

namespace Topdon_AD900_Demo {

	CEcuTest::CEcuTest()
	{

	}

	CEcuTest::~CEcuTest()
	{

	}

	void CEcuTest::TestEcu()
	{
		CArtiList	uiList;

		uiList.InitTitle(artiGetText("500000300000"));
		uiList.SetColWidth(vector<int32_t>{70, 30});
		for (uint32_t i=1; i<12; i++)
		{
			string	strEcu = "5000003000";
			char	chvalue[20];

			snprintf(chvalue, sizeof(chvalue), "%02X", i);
			strEcu += chvalue;
			uiList.AddItem(artiGetText(strEcu));
		}
		uiList.AddButton(artiGetText("500000300100"));
		while (1)
		{
			uint32_t uRet = uiList.Show();
			if (uRet == DF_ID_BACK)
			{
				break;
			}
			if (uRet == DF_ID_FREEBTN_0)
			{
				uiList.SetButtonStatus(0, DF_ST_BTN_DISABLE);
				uiList.Show();
				for (uint32_t i = 0; i < 11; i++)
				{
					uiList.SetItem(i, 1, artiGetText("500000300101"));
					uiList.Show();
					if (TestSingleEcu(i))
					{
						uiList.SetItem(i, 1, artiGetText("500000300102"));
					}
					else
					{
						uiList.SetItem(i, 1, artiGetText("500000300103"));
					}
					uiList.Show();
				}
				uiList.SetButtonStatus(0, DF_ST_BTN_ENABLE);
			}
			else if (uRet != DF_ID_NOKEY)
			{
				uiList.SetItem((uint16_t)uRet, 1, artiGetText("500000300101"));
				//uiList.SetRowInCurrentScreen(CArtiList::eScreenRowType::SCREEN_TYPE_FIRST_ROW, uRet);
				uiList.Show();
				if (TestSingleEcu(uRet&0xff))
				{
					uiList.SetItem((uint16_t)uRet, 1, artiGetText("500000300102"));
				}
				else
				{
					uiList.SetItem((uint16_t)uRet, 1, artiGetText("500000300103"));
				}
			}
		}
	}

	bool CEcuTest::TestSingleEcu(uint32_t uEcuIndex)
	{
		bool	bEnter = false;

		switch (uEcuIndex)
		{
		case 0://单线CAN 1# 2009别克新君威 气囊 OK
			bEnter = TestCAN(uEcuIndex);
			break;
		case 1://PWM 2# 10# 长安福特发动机
			bEnter = TestPwm();//不 OK
			break;
		case 2://VPW 2#
			bEnter = TestVPW();//OK
			break;
		case 3:// CANFD 标准 5M 3# 11#  GL8 网关
 			bEnter = TestCAN(uEcuIndex);//OK
			break;
		case 4:// CAN 扩展 500K 6# 14#  本田思域
 			bEnter = TestCAN(uEcuIndex);
			break;
		case 5:// K线(快速) 7#  雪铁龙
 			bEnter = TestKWP(uEcuIndex);//OK
			break;
		case 6://HONDA 协议 8#
  			bEnter = TestHondaPro();//OK
			break;
		case 7://三菱负逻辑 9#
 			bEnter = TestMit_Old();//OK
			break;
		case 8://J1939 12# 13#
			bEnter = TestCAN(uEcuIndex);//OK
			break;
		case 9://K线(慢速) 15# 大众 1281 
 			bEnter = TestK1281();//OK
			break;
		case 0xa://CANFD 标准 5M 3# 11#  GL8 仪表
			bEnter = TestCAN(uEcuIndex);//OK
			break;
		default:
			break;
		}
		return bEnter;
	}

	bool CEcuTest::TestPwm()
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;

		ectRet = EnterSys.EnterSystem((uint8_t)CStdCommMaco::ProtocolType::PT_PWM);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		return bEnter;
	}

	bool CEcuTest::TestVPW()
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;

		ectRet = EnterSys.EnterSystem((uint8_t)CStdCommMaco::ProtocolType::PT_VPW);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		EnterSys.ExitSystem();
		return bEnter;
	}

	bool CEcuTest::TestKWP(uint8_t uSel)
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;

		ECU_INFO	Ecuinfo;

		Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_KWP;
		if (uSel == 5)//K线(快速) 7#
		{
			Ecuinfo.uPinH = 7;
			Ecuinfo.uPinL = 7;
			Ecuinfo.uEcuId = 0x10;
			Ecuinfo.binInitCmd = CBinary("\x81\x10\xF1\x81\x03", 5);
			Ecuinfo.bgEnterCmd.Append(CBinary("\x21\x80", 2));
		}
		else//K线(快速) 15# 大众1281
		{
			Ecuinfo.uPinH = 15;
			Ecuinfo.uPinL = 15;
			Ecuinfo.uEcuId = 0x28;
			Ecuinfo.binInitCmd = CBinary("\x81\x28\xF1\x81\x1b", 5);
			Ecuinfo.bgEnterCmd.Append(CBinary("\x3e", 1));
		}
		Ecuinfo.uToolId = 0xf1;
		Ecuinfo.uBps = 10400;
		Ecuinfo.uPackUpack = (uint8_t)CStdCommMaco::FrameFormatType::FFT_KWP_8X;
		EnterSys.SetEcuInfo(Ecuinfo);
		ectRet = EnterSys.EnterSystem(Ecuinfo.uProtocol);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		EnterSys.ExitSystem();
		return bEnter;
	}

	bool CEcuTest::TestHondaPro()
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;
		ECU_INFO	Ecuinfo;

		Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_ISO;
		Ecuinfo.uProtocolSelf = 1;
		Ecuinfo.uPinH = 8;
		Ecuinfo.uPinL = 8;
		Ecuinfo.binInitCmd = CBinary("\xfe\x91", 2);
		Ecuinfo.uBps = 10400;
		Ecuinfo.uPackUpack = (uint8_t)CStdCommMaco::FrameFormatType::FFT_HONDA;
		EnterSys.SetEcuInfo(Ecuinfo);
		ectRet = EnterSys.EnterSystem(Ecuinfo.uProtocol);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		EnterSys.ExitSystem();
		return bEnter;
	}

	bool CEcuTest::TestMit_Old()
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;
		ECU_INFO	Ecuinfo;

		Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_ISO;
		Ecuinfo.uProtocolSelf = 2;
		Ecuinfo.uPinH = 9;
		Ecuinfo.uPinL = 9;
		Ecuinfo.binInitCmd = CBinary("\xfe", 1);
		Ecuinfo.uBps = 2400;
		Ecuinfo.uPackUpack = (uint8_t)CStdCommMaco::FrameFormatType::FFT_NONE;
		EnterSys.SetEcuInfo(Ecuinfo);
		ectRet = EnterSys.EnterSystem(Ecuinfo.uProtocol);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		EnterSys.ExitSystem();
		return bEnter;
	}

	bool CEcuTest::TestK1281()
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;
		ECU_INFO	Ecuinfo;

		Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_ISO;
		Ecuinfo.uProtocolSelf = 3;
		Ecuinfo.uPinH = 15;
		Ecuinfo.uPinL = 15;
		Ecuinfo.uAddress = 0x02;
		Ecuinfo.uBps = 10400;
		Ecuinfo.uPackUpack = (uint8_t)CStdCommMaco::FrameFormatType::FFT_KWP1281;
		EnterSys.SetEcuInfo(Ecuinfo);
		ectRet = EnterSys.EnterSystem(Ecuinfo.uProtocol);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		EnterSys.ExitSystem();
		return bEnter;
	}


	bool CEcuTest::TestCAN(uint8_t uSelect)
	{
		bool	bEnter = false;
		CEnterSys	EnterSys;
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;
		ECU_INFO	Ecuinfo;

		Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_CAN;
		if (uSelect == 0)//单线CAN
		{
			Ecuinfo.uEcuId = 0x0647;
			Ecuinfo.uToolId = 0x0247;
			Ecuinfo.uPinH = 1;
			Ecuinfo.uPinL = 1;
			Ecuinfo.uBps = 33.333 * 1000;
			Ecuinfo.binSingleCANInitCmd = CBinary("\x00\x00\x01\x00",4);
			Ecuinfo.binInitCmd = CBinary("\x3e", 1);
		}
		else if (uSelect == 3)// CANFD  5M 3# 11#
		{
			Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_CANFD;
			Ecuinfo.uEcuId = 0x94DAF145;
			Ecuinfo.uToolId = 0x94DA45F1;
			Ecuinfo.binInitCmd = CBinary("\x3e\x00", 2);
			Ecuinfo.bgEnterCmd.Append(CBinary("\x19\x02\x09", 3));
			Ecuinfo.uPinH = 3;
			Ecuinfo.uPinL = 11;
			Ecuinfo.uBps = 500 * 1000;
		}
		else if (uSelect == 4)// CAN 标准 500K 6# 14#
		{
			Ecuinfo.uEcuId = 0x98DAF110;
			Ecuinfo.uToolId = 0x98DA10F1;
			Ecuinfo.binInitCmd = CBinary("\x3e\x00", 2);
			Ecuinfo.bgEnterCmd.Append(CBinary("\x22\xf1\x90", 3));
			Ecuinfo.uPinH = 6;
			Ecuinfo.uPinL = 14;
			Ecuinfo.uBps = 500 * 1000;
		}
		else if (uSelect == 8)////CAN(扩展) 12# 13#  J1939
		{
			Ecuinfo.uToolId = 0x98EA00F9;
			Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_RAW_CAN;
			Ecuinfo.binInitCmd = CBinary("\xda\xfe\x00", 3);
			Ecuinfo.uPinH = 12;
			Ecuinfo.uPinL = 13;
			Ecuinfo.uBps = 250 * 1000;
		}
		else if (uSelect == 0xa)// CANFD  5M 3# 11# 仪表
		{
			Ecuinfo.uProtocol = (uint8_t)CStdCommMaco::ProtocolType::PT_CANFD;
			Ecuinfo.uEcuId = 0x94DAF160;
			Ecuinfo.uToolId = 0x94DA60F1;
			Ecuinfo.binInitCmd = CBinary("\x3e\x00", 2);
			Ecuinfo.bgEnterCmd.Append(CBinary("\x19\x02\x09", 3));
			Ecuinfo.uPinH = 3;
			Ecuinfo.uPinL = 11;
			Ecuinfo.uBps = 500 * 1000;
		}
		EnterSys.SetEcuInfo(Ecuinfo);
		ectRet = EnterSys.EnterSystem(Ecuinfo.uProtocol);
		if (ectRet == ErrorCodeType::STATUS_NOERROR)
		{
			bEnter = true;
		}
		else
		{
			bEnter = false;
		}
		EnterSys.ExitSystem();
		return bEnter;
	}
}