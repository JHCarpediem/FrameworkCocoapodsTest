/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 系统进入
* 功能描述 : 系统进入接口
* 创 建 人 : panjun        20200120
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/

#include "DemoEnterSys.h"
#include "Expression.h"
#include "DemoInfomation.h"
#include "DemoNetCan.h"
#include "DemoNetKwp2000.h"
#include "Binary.h"
#include "ArtiMsgBox.h"
#include "DemoPublicAPI.h"
#include "DemoAppLayer.h"
#include "DemoNetSaeJ1850.h"
#include "DemoNetTp20.h"
#include "DemoNetNormal.h"

namespace Topdon_AD900_Demo {

	CEnterSys::CEnterSys()
	{
		m_pNetLayer = NULL;
	}

	CEnterSys::~CEnterSys()
	{
	}

	bool CEnterSys::IsEmpty()
	{
		if (m_pNetLayer == NULL)
		{
			return true;
		}
		return false;
	}

#ifndef _WIN32
#include <unistd.h>
#endif

	void CEnterSys::Delay(unsigned long msecs)
	{
#ifndef _WIN32
		usleep(msecs * 1000);
#else
		Sleep(msecs);
#endif
	}

	ErrorCode_t CEnterSys::EnterSystem(uint8_t uProtocol)
	{
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;

		if (m_pNetLayer != NULL)
		{
			delete m_pNetLayer;
			m_pNetLayer = NULL;
		}

		switch (uProtocol)
		{
		case (uint8_t)CStdCommMaco::ProtocolType::PT_CAN:
		case (uint8_t)CStdCommMaco::ProtocolType::PT_CANFD:
		case (uint8_t)CStdCommMaco::ProtocolType::PT_RAW_CAN:
			m_pNetLayer = new CNetCan();
			ectRet = EnterCAN();
			break;
		case (uint8_t)CStdCommMaco::ProtocolType::PT_KWP:
			m_pNetLayer = new CNetKwp2000();
			ectRet = EnterKwp();
			break;
		case (uint8_t)CStdCommMaco::ProtocolType::PT_PWM:
			m_pNetLayer = new CNetSaeJ1850();
			ectRet = EnterPWM();
			break;
		case (uint8_t)CStdCommMaco::ProtocolType::PT_VPW:
			m_pNetLayer = new CNetSaeJ1850();
			ectRet = EnterVPW();
			break;
		case (uint8_t)CStdCommMaco::ProtocolType::PT_ISO:
			m_pNetLayer = new CNetNormal();
			ectRet = EnterNormal();
			break;
		default:
			m_pNetLayer = new CNetCan();
			ectRet = EnterCAN();
			break;
		}
		return ectRet;
	}

	ErrorCode_t CEnterSys::EnterTp20()
	{
		auto retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		if (nullptr != m_pNetLayer)
		{
			delete m_pNetLayer;
			m_pNetLayer = nullptr;
		}

		m_pNetLayer = new CNetTp20();
		m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_TP20);
		m_pNetLayer->SetIoPin(m_EcuInfo.uPinH, m_EcuInfo.uPinL);
		m_pNetLayer->SetBaudRate(m_EcuInfo.uBps);
		m_pNetLayer->SetCommTime(0, 500, 50, 0, 5000);
		m_pNetLayer->SetFlowCtrlType(uint8_t(CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW));
		m_pNetLayer->SetPackUnpack(uint8_t(CStdCommMaco::FrameFormatType::FFT_NONE));


		// 6.申请通道、建立连接
		//设置7F78间隔时间
		m_pNetLayer->SetRCXXHandling(CStdCommMaco::RcxxHandlingMode::RHM_MODE_NRC78, CStdCommMaco::RcxxHandlingType::RHT_UNTIL_TIMEOUT, 30 * 1000, 5 * 1000);

		CRecvFrame EnterFrame;
		EnterFrame = m_pNetLayer->InitTp20(m_EcuInfo.uAddress);//uAddress = 1 '\x1'
		if (EnterFrame.GetSize() == 0)
		{
			return retCode = CStdCommMaco::ErrorCodeType::ERR_FAILED;
		}
		if (m_pNetLayer->SendReceive(CSendFrame(CBinary("\x1a\x90", 2),1)).GetSize()==0)
		{
			return CStdCommMaco::ErrorCodeType::ERR_FAILED;
		}
		return retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;
	}


	ErrorCode_t CEnterSys::EnterPWM()
	{
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;
		CBinary			binEnterCmd("\x22\x02\x00", 3);
		CRecvFrame		rf;
		CBinary			binEcuID;

		m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_PWM);
		m_pNetLayer->SetIoPin(2, 10);
		m_pNetLayer->SetBaudRate(41600);
		m_pNetLayer->SetCommTime(20, 800, 100, 5, 5000);
		m_pNetLayer->SetToolId(0xF5);
		m_pNetLayer->SetEcuId(0x10);
		m_pNetLayer->SetJ1850FunctionalAddressFilter(vector<uint8_t>{0xc4, 0x10});
		m_pNetLayer->SetJ1850NodeAddress(0xf5);
		m_pNetLayer->SetPackUnpack((uint8_t)CStdCommMaco::FrameFormatType::FFT_PWM_FORD);

		rf = m_pNetLayer->SendReceive(CSendFrame(binEnterCmd),3);
		if ((rf.GetSize() <= 0) || (rf.GetFirst().GetSize() < 1) || (rf.GetFirst()[0] != 0x62))
		{
			return ectRet = ErrorCodeType::ERR_FAILED;
		}
		return 	ectRet = ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CEnterSys::EnterVPW()
	{
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;
		CBinary			binEnterCmd("\x3c\x08", 2);
		CRecvFrame		rf;
		CBinary			binEcuID;

		m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_VPW);
		m_pNetLayer->SetIoPin(2, 2);
		m_pNetLayer->SetBaudRate(10400);
		m_pNetLayer->SetCommTime(20, 800, 100, 5, 5000);
		m_pNetLayer->SetToolId(0xF1);
		m_pNetLayer->SetEcuId(0x10);
		m_pNetLayer->SetPackUnpack((uint8_t)CStdCommMaco::FrameFormatType::FFT_VPW_GM);
		m_pNetLayer->SetJ1850NodeAddress(0xf1);
		m_pNetLayer->SetJ1850FunctionalAddressFilter(vector<uint8_t>{0x6c, 0xf1});
		rf = m_pNetLayer->SendReceive(CSendFrame(CBinary("\x20",1),0x03));
		rf = m_pNetLayer->SendReceive(CSendFrame(binEnterCmd, 0x01), 0x03);
		if ((rf.GetSize() <= 0) || (rf.GetFirst().GetSize() < 1) || (rf.GetFirst()[0] != 0x7c))
		{
			return ectRet = ErrorCodeType::ERR_FAILED;
		}
		//m_pNetLayer->KeepLink(1500, CSendFrame(CBinary("\x01\x00", 2)));
		m_pNetLayer->SendReceive(CSendFrame(CBinary("\x20", 1), 0x03));
		return 	ectRet = ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CEnterSys::EnterKwp()
	{
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;
		CRecvFrame		rf;
		CBinary			binEcuID;

		m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_KWP);
		m_pNetLayer->SetIoPin(m_EcuInfo.uPinH, m_EcuInfo.uPinL);
		m_pNetLayer->SetBaudRate(m_EcuInfo.uBps);
		m_pNetLayer->SetToolId(m_EcuInfo.uToolId);
		m_pNetLayer->SetEcuId(m_EcuInfo.uEcuId);
		m_pNetLayer->SetEnablePack(true);
		m_pNetLayer->SetEnableUnpack(true);
		m_pNetLayer->SetPackUnpack(m_EcuInfo.uPackUpack);

		m_pNetLayer->SetCommTime(20, 500, 55, 5, 5000);
		for (uint32_t i = 0; i < 2; i++)
		{
			rf = m_pNetLayer->Init(300, 25, 25, m_EcuInfo.binInitCmd);
			if ((rf.GetSize() == 0) && (i == 1))
			{
				return 	ectRet = ErrorCodeType::ERR_FAILED;
			}
			else
			{
				break;
			}
		}
		if (m_EcuInfo.bgEnterCmd.GetSize()>0)
		{
			if (m_pNetLayer->SendReceive(CSendFrame(m_EcuInfo.bgEnterCmd[0]),1).GetSize() == 0)
			{
				return ectRet = ErrorCodeType::ERR_FAILED;;
			}
		}

		return 	ectRet = ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CEnterSys::EnterHondaPro()
	{
		CRecvFrame		rf;
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;

		for (uint32_t i = 0; i < 2; i++)
		{
			rf = m_pNetLayer->Init(300, 70, 140, m_pNetLayer->Pack(CSendFrame(m_EcuInfo.binInitCmd, 1)));
			if ((rf.GetSize() == 0) && (i == 1))
			{
				return 	ectRet = ErrorCodeType::ERR_FAILED;
			}
			else
			{
				if ((rf.GetFirst().GetSize()>0) && (rf.GetFirst().GetAt(0) == (m_EcuInfo.binInitCmd[0]&0xf)))
				{
					break;
				}
			}
		}
		return	ectRet = ErrorCodeType::STATUS_NOERROR;
	}

	ErrorCode_t CEnterSys::EnterMit_Old()
	{
		CRecvFrame		rf;
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;

		for (uint32_t i = 0; i < 2; i++)
		{
			rf = m_pNetLayer->SendReceive(CSendFrame(m_EcuInfo.binInitCmd),1);
			if (rf.GetSize())
			{
				return	ectRet = ErrorCodeType::STATUS_NOERROR;
			}
		}
		return	ectRet = ErrorCodeType::ERR_FAILED;
	}

	ErrorCode_t CEnterSys::EnterKwp1281()
	{
		CRecvFrame		rf;
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;

		for (uint32_t i = 0; i < 3; i++)
		{
			rf = m_pNetLayer->Init(m_EcuInfo.uAddress);
			if ((rf.GetSize() > 0) && (rf[0].GetSize() > 1) && (rf[0][1])==0x8a)
			{
				m_pNetLayer->KeepLink(700, CSendFrame(CBinary("\x09", 1), 1));
				Delay(800);
				rf = m_pNetLayer->SendReceive(CSendFrame(CBinary("\x07", 1), 1));
				if (rf.GetSize()>0)
				{
					return ectRet;
				}
			}
		}
		return	ectRet = ErrorCodeType::ERR_FAILED;
	}

	ErrorCode_t CEnterSys::EnterNormal()
	{
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;

		m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_ISO);

		if (m_EcuInfo.uProtocolSelf == 2)
		{
			m_pNetLayer->SetIoPin(m_EcuInfo.uPinH, m_EcuInfo.uPinL, (uint8_t)(CStdCommMaco::PinVoltageType::PinVol_12V), (uint8_t)CStdCommMaco::PinPropertyType::PPT_MINUS_LOGIC);
		}
		else
		{
			if (m_EcuInfo.uProtocolSelf == 3)
			{
				m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_1281);
			}
			m_pNetLayer->SetIoPin(m_EcuInfo.uPinH, m_EcuInfo.uPinL);
		}
		m_pNetLayer->SetBaudRate(m_EcuInfo.uBps);
		m_pNetLayer->SetEnablePack(true);
		m_pNetLayer->SetEnableUnpack(true);
		m_pNetLayer->SetPackUnpack(m_EcuInfo.uPackUpack);
		m_pNetLayer->SetCommTime(20, 500, 150, 5, 5000);

		if (m_EcuInfo.uProtocolSelf == 1)//honda协议
		{
			ectRet = EnterHondaPro();
		}
		else if (m_EcuInfo.uProtocolSelf == 2)//三菱负逻辑
		{
			ectRet = EnterMit_Old();
		}
		else if (m_EcuInfo.uProtocolSelf == 3)
		{
			ectRet = EnterKwp1281();
		}
		return 	ectRet;
	}


	ErrorCode_t CEnterSys::ExitSystem()
	{
		ErrorCodeType ectRet = ErrorCodeType::STATUS_NOERROR;

		if (m_pNetLayer == NULL)
		{
			return ectRet = ErrorCodeType::ERR_FAILED;
		}
		m_pNetLayer->KeepLink(0, CSendFrame(m_EcuInfo.binKeepLink));
		for (uint32_t i = 0; i < m_EcuInfo.bgExitCmd.GetSize(); i++)
		{
			m_pNetLayer->SendReceive(CSendFrame(m_EcuInfo.bgExitCmd[i]));
		}
		if (m_pNetLayer != NULL)
		{
			delete m_pNetLayer;
			m_pNetLayer = NULL;
		}
		return ectRet = ErrorCodeType::STATUS_NOERROR;
	}

	CRecvFrame CEnterSys::SendReceive(CSendFrame sfSendFrame, uint8_t uSendNum)
	{
		CRecvFrame rf;

		rf = m_pNetLayer->SendReceive(sfSendFrame, uSendNum);
		return rf;
	}


	CBinary CEnterSys::SendReceive(CBinary binSendFrame, uint8_t uSendNum)
	{
		CRecvFrame rf = SendReceive((CSendFrame)binSendFrame, uSendNum);
		return rf.GetFirst();
	}

	uint8_t CEnterSys::GetProtocol()
	{
		return m_EcuInfo.uProtocol;
	}

	void CEnterSys::SetEcuInfo(ECU_INFO EcuInfo)
	{
		m_EcuInfo = EcuInfo;
	}

	ErrorCode_t CEnterSys::EnterCAN()
	{
		ErrorCodeType	ectRet = ErrorCodeType::STATUS_NOERROR;
		CRecvFrame		rf;

		m_pNetLayer->SetProtocol(m_EcuInfo.uProtocol);
		m_pNetLayer->SetIoPin(m_EcuInfo.uPinH, m_EcuInfo.uPinL);
		m_pNetLayer->SetCommTime(0, 500, 50, 0, 5000);
		m_pNetLayer->SetEnablePack(true);
		m_pNetLayer->SetEnableUnpack(true);
		m_pNetLayer->SetFlowCtrlType(uint8_t(CStdCommMaco::FlowCtrlType::FCT_AUTO));

		if (m_EcuInfo.uProtocol == (uint8_t)CStdCommMaco::ProtocolType::PT_CANFD)
		{
			m_pNetLayer->SetCanFillByte(0x00);
			m_pNetLayer->SetBaudRate(m_EcuInfo.uBps,500*1000*10);
		}
		else
		{
			m_pNetLayer->SetBaudRate(m_EcuInfo.uBps);
		}
		m_pNetLayer->SetToolId(m_EcuInfo.uToolId);
		m_pNetLayer->SetPackUnpack((uint8_t)CStdCommMaco::FrameFormatType::FFT_CAN);
		if (m_EcuInfo.uProtocol == (uint8_t)CStdCommMaco::ProtocolType::PT_RAW_CAN)
		{
			m_EcuInfo.uEcuId =0x98ECF900;
			m_pNetLayer->SetFilterId(m_EcuInfo.uEcuId);
		}
		else if (m_EcuInfo.uToolId == 0x07Df)
		{
			CBinaryGroup	bgFilterId;

			bgFilterId.Append(CBinary("\x00\x00\x07\xE8", 4));
			bgFilterId.Append(CBinary("\x00\x00\x07\xEF", 4));
			m_pNetLayer->SetCanFillByte(0x00);
			m_pNetLayer->SetFilterId(CNetLayer::MyEnum::FT_ByRange, bgFilterId);
			m_pNetLayer->SetFlowCtrlType(uint8_t(CStdCommMaco::FlowCtrlType::FCT_FUNCTIONAL));
		}
		else
		{
			m_pNetLayer->SetFilterId(m_EcuInfo.uEcuId);
		}
		if (m_EcuInfo.binSingleCANInitCmd.GetSize()>0)
		{
			m_pNetLayer->SetEnablePack(false);
			m_pNetLayer->SetSingleCanFormatId(0x00000547);
			rf = m_pNetLayer->SendReceive(CSendFrame(m_EcuInfo.binSingleCANInitCmd),1);
			m_pNetLayer->SetEnablePack(true);
		}
		rf = m_pNetLayer->SendReceive(CSendFrame(m_EcuInfo.binInitCmd,1), 1);
		if (rf.GetSize() == 0)
		{
			return ectRet = ErrorCodeType::ERR_FAILED;//通讯失败
		}
		if (m_EcuInfo.bgEnterCmd.GetSize()>0)
		{
			rf = m_pNetLayer->SendReceive(CSendFrame(m_EcuInfo.bgEnterCmd[0]),1);
			if (rf.GetSize() == 0)
			{
				return ectRet = ErrorCodeType::ERR_FAILED;//通讯失败
			}
		}
		return ectRet = ErrorCodeType::STATUS_NOERROR;
	}

	// 开始 [6/14/2022 qunshang.li]
	CEnterSys::CEnterSys(uint8_t uSysId, string strProtocol)
	{
		m_SysId = uSysId;
		m_Protocol = strProtocol;
		m_pNetLayer = new CNetLayer();

		// 获取m_EcuInfo信息  [6/16/2022 qunshang.li]
		/*uint8_t		uProtocol;
		uint32_t	uToolId;
		uint32_t	uEcuId;
		uint32_t	uBps;
		uint8_t		uPinH;
		uint8_t		uPinL;
		COMMTIME	TimePara;
		uint8_t		uPackUpack;
		CBinary		binInitCmd;
		CBinaryGroup		bgEnterCmd;
		CBinary		binKeepLink;
		uint32_t	uKeepTime;
		uint8_t		uFlowCtrlType;
		CBinaryGroup	bgExitCmd;*/

		if (m_Protocol == "UDS" || m_Protocol == "UDS_6E_250K" || m_Protocol == "UDS_3B_500K")
		{
			m_EcuInfo.uProtocol = PROTOCOL_UDS;
		}
		else if (m_Protocol == "KWP2000CAN20")
		{
			m_EcuInfo.uProtocol = PROTOCOL_KWP2000CAN20;
		}
		else if (m_Protocol == "KWP2000CAN16")
		{
			m_EcuInfo.uProtocol = PROTOCOL_KWP2000CAN16;
		}
		else if (m_Protocol == "KWP2000LINE")
		{
			m_EcuInfo.uProtocol = PROTOCOL_KWP2000LINE;
		}
		else if (m_Protocol == "KWP1281LINE")
		{
			m_EcuInfo.uProtocol = PROTOCOL_KWP1281LINE;
		}

		CBinary binProtocol = CBinary("\x56\x00\x00\x00\x00\x01", 6);
		binProtocol.SetAt(5, m_SysId);

		m_EcuInfo.uToolId = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "ToolId"));
		m_EcuInfo.uEcuId = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "EcuId"));
		m_EcuInfo.uBps = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "BaudRate"), 10);

		vector<string> vctStrTemp;
		Split(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "CommPin"), ",", vctStrTemp);
		if (vctStrTemp.size() >= 1)
		{
			m_EcuInfo.uPinH = String2UInt(vctStrTemp[0], 10);
		}
		if (vctStrTemp.size() >= 2)
		{
			m_EcuInfo.uPinL = String2UInt(vctStrTemp[1], 10);
		}

		Split(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "CommTime"), ",", vctStrTemp);
		if (vctStrTemp.size() >= 5)
		{
			m_EcuInfo.TimePara.p1 = String2UInt(vctStrTemp[0], 10);
			m_EcuInfo.TimePara.p2 = String2UInt(vctStrTemp[1], 10);
			m_EcuInfo.TimePara.p3 = String2UInt(vctStrTemp[2], 10);
			m_EcuInfo.TimePara.p4 = String2UInt(vctStrTemp[3], 10);
			m_EcuInfo.TimePara.p5 = String2UInt(vctStrTemp[4], 10);
		}

		m_EcuInfo.binInitCmd = HexString2Binary(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "InitCmd"));
		m_EcuInfo.binKeepLink = HexString2Binary(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "KeepLink"));
		m_EcuInfo.bgExitCmd.Append(HexString2Binary(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "ExitCmd")));
	}

	CStdCommMaco::ErrorCodeType CEnterSys::InitProtocol(uint8_t uProtocolType)
	{
		CStdCommMaco::ErrorCodeType err = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;
		if (m_pNetLayer == nullptr)
		{
			return CStdCommMaco::ErrorCodeType::ERR_INIT_FAILED;
		}

		if (uProtocolType == 0)
		{
			if (m_Protocol == "UDS" || m_Protocol == "UDS_6E_250K" || m_Protocol == "UDS_3B_500K")
			{
				uProtocolType = PROTOCOL_UDS;
			}
			else if (m_Protocol == "KWP2000CAN20")
			{
				uProtocolType = PROTOCOL_KWP2000CAN20;
			}
			else if (m_Protocol == "KWP2000CAN16")
			{
				uProtocolType = PROTOCOL_KWP2000CAN16;
			}
			else if (m_Protocol == "KWP2000LINE")
			{
				uProtocolType = PROTOCOL_KWP2000LINE;
			}
			else if (m_Protocol == "KWP1281LINE")
			{
				uProtocolType = PROTOCOL_KWP1281LINE;
			}
		}

		switch (uProtocolType)
		{
		case PROTOCOL_KWP2000CAN20:
		{
			err = InitProtocolKwp2000Can20();
			break;
		}
		case PROTOCOL_UDS:
		case PROTOCOL_29CAN:
		{
			err = InitProtocolCan();
			break;
		}
		case PROTOCOL_KWP1281CAN16:
		case PROTOCOL_KWP2000CAN16:
		{
			err = InitProtocolKwp2000Can16();
			break;
		}
		case PROTOCOL_KWP1281LINE:
		{
			err = InitProtocolKwp1281Line();
			break;
		}
		case PROTOCOL_KWP2000LINE:
		{
			err = InitProtocolKwp2000Line();
			break;
		}
		default:
		{
			err = CStdCommMaco::ErrorCodeType::ERR_NOT_SUPPORTED;
			break;
		}
		}
		return err;
	}

	CStdCommMaco::ErrorCodeType CEnterSys::InitProtocolKwp2000Can20()
	{
		CStdCommMaco::ErrorCodeType retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		return retCode;
	}

	CStdCommMaco::ErrorCodeType CEnterSys::InitProtocolCan()
	{
		auto retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;
		if (m_pNetLayer == nullptr)
		{
			return CStdCommMaco::ErrorCodeType::ERR_INIT_FAILED;
		}

		CBinary binProtocol = CBinary("\x56\x00\x00\x00\x00\x01", 6);
		binProtocol.SetAt(5, m_SysId);

		// 1.设置协议
		retCode = m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_CAN);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 2.设置引脚
		vector<string> vctTemp;
		string strCommPin = CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "CommPin");

		vctTemp = SeparateString(strCommPin);
		if (vctTemp.size() < 2)
		{
			return CStdCommMaco::ErrorCodeType::ERR_INIT_FAILED;
		}

		retCode = m_pNetLayer->SetIoPin(String2UInt(vctTemp[0], 10), String2UInt(vctTemp[1], 10));
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 3.设置波特率
		uint32_t uBps = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "BaudRate"), 10);
		retCode = m_pNetLayer->SetBaudRate(uBps);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 4.设置流控制
		retCode = m_pNetLayer->SetFlowCtrlType((uint8_t)CStdCommMaco::FlowCtrlType::FCT_VEHICLE_VW);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 5.设置时间参数
		string strCommTime = CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "CommTime");
		vctTemp.clear();
		vctTemp = SeparateString(strCommTime);

		retCode = m_pNetLayer->SetCommTime(String2UInt(vctTemp[0], 10),
			String2UInt(vctTemp[1], 10),
			String2UInt(vctTemp[2], 10),
			String2UInt(vctTemp[3], 10),
			String2UInt(vctTemp[4], 10));

		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 6.设置填充位
		retCode = m_pNetLayer->SetCanFillByte(0x55);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 7.设置过滤ID
		uint32_t uEcuId = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "EcuId"));
		uint32_t uToolId = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "ToolId"));
		m_pNetLayer->SetEcuId(uEcuId);
		m_pNetLayer->SetToolId(uToolId);

		// 8.设置打包格式
		//设置7F78间隔时间
		m_pNetLayer->SetPackUnpack((uint8_t)CStdCommMaco::FrameFormatType::FFT_CAN);

		m_pNetLayer->SetEnablePack(true);
		m_pNetLayer->SetEnableUnpack(true);

		return retCode;
	}

	CStdCommMaco::ErrorCodeType CEnterSys::InitProtocolKwp2000Can16()
	{
		CStdCommMaco::ErrorCodeType retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		return retCode;
	}

	CStdCommMaco::ErrorCodeType CEnterSys::InitProtocolKwp1281Line()
	{
		CStdCommMaco::ErrorCodeType retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;

		return retCode;
	}

	CStdCommMaco::ErrorCodeType CEnterSys::InitProtocolKwp2000Line()
	{
		auto retCode = CStdCommMaco::ErrorCodeType::STATUS_NOERROR;
		if (m_pNetLayer == nullptr)
		{
			return CStdCommMaco::ErrorCodeType::ERR_INIT_FAILED;
		}

		CBinary binProtocol = CBinary("\x56\x00\x00\x00\x00\x01", 6);
		binProtocol.SetAt(5, m_SysId);

		// 1.设置协议
		retCode = m_pNetLayer->SetProtocol((uint8_t)CStdCommMaco::ProtocolType::PT_KWP);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 2.设置引脚
		vector<string> vctTemp;
		string strCommPin = CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "CommPin");

		vctTemp = SeparateString(strCommPin);
		if (vctTemp.size() < 2)
		{
			return CStdCommMaco::ErrorCodeType::ERR_INIT_FAILED;
		}

		retCode = m_pNetLayer->SetIoPin(String2UInt(vctTemp[0], 10), String2UInt(vctTemp[1], 10));
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 3.设置波特率
		uint32_t uBps = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "BaudRate"), 10);
		retCode = m_pNetLayer->SetBaudRate(uBps);
		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 4.设置时间参数
		string strCommTime = CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "CommTime");
		vctTemp.clear();
		vctTemp = SeparateString(strCommTime);

		retCode = m_pNetLayer->SetCommTime(String2UInt(vctTemp[0], 10),
			String2UInt(vctTemp[1], 10),
			String2UInt(vctTemp[2], 10),
			String2UInt(vctTemp[3], 10),
			String2UInt(vctTemp[4], 10));

		if (retCode == CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED)
		{
			return CStdCommMaco::ErrorCodeType::ERR_DEVICE_NOT_CONNECTED;
		}

		// 5.设置过滤ID
		uint32_t uEcuId = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "EcuId"));
		uint32_t uToolId = String2UInt(CAppLayer::GetValueFromFile(FILE_AllSysProtocolConfig, binProtocol, m_Protocol, "ToolId"));

		m_pNetLayer->SetEcuId(uEcuId);
		m_pNetLayer->SetToolId(uToolId);

		//m_pNetLayer->SetKwp2000FilterId(uEcuId);
		CBinary binMask = CBinary("\x00\xFF\xFF", 3);
		CBinary filterPattern = CBinary("\x00\xFF\xFF", 3);

		filterPattern.SetAt(1, uToolId & 0xFF);
		filterPattern.SetAt(2, uEcuId & 0xFF);
		m_pNetLayer->m_pEcuInterface->SetFilterId(binMask.GetBuffer(), filterPattern.GetBuffer(), filterPattern.GetSize());


		// 6.设置打包格式
		//设置7F78间隔时间
		m_pNetLayer->SetPackUnpack((uint8_t)CStdCommMaco::FrameFormatType::FFT_KWP_8X);

		m_pNetLayer->SetEnablePack(true);
		m_pNetLayer->SetEnableUnpack(true);

		return retCode;
	}

	// 结束 [6/14/2022 qunshang.li]
}