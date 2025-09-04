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

#ifndef _ENTER_SYS_H_
#define _ENTER_SYS_H_

#include "DemoNetLayer.h"
#include "RecvFrame.h"
#include "SendFrame.h"
#include "DemoVehicleStruct.h"

#include "DemoMaco.h"
#include "DataFile.h"
#include "ProFile.h"
#include "PublicInterface.h"

namespace Topdon_AD900_Demo {

	class CEnterSys
	{
	public:
		CNetLayer* m_pNetLayer;// 网络层指针
		ECU_INFO   m_EcuInfo;

	public://  [6/14/2022 qunshang.li]
		uint8_t m_SysId;
		string m_Protocol;
		string m_strSysName;

	public:
		CEnterSys();
		virtual ~CEnterSys();

	public:
		/*-----------------------------------------------------------------------------
		功    能：	判断m_Netlayer是否为空
		参数说明：	无
		返 回 值：	true -- 为空
					false -- 为非空
		说    明：	无
		-----------------------------------------------------------------------------*/
		bool IsEmpty();

		/*-----------------------------------------------------------------------------
		功    能：	系统进入
		参数说明：	uProtocol 协议
		返 回 值：	CErrorCode -- 错误代号
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t EnterSystem(uint8_t uProtocol);

		/*-----------------------------------------------------------------------------
		功    能：	退出当前系统
		参数说明：	无
		返 回 值：	CErrorCode -- 错误代号
		说    明：	无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ExitSystem();

		/*-----------------------------------------------------------------------------
		功    能：	发送单个命令，接收数据
		参数说明：	sfSendFrame -- 命令对象，
					uRecvNum -- 接收的次数
		返 回 值：	CReceiveFrame -- 接受的数据
		说    明：	无
		-----------------------------------------------------------------------------*/
		CRecvFrame SendReceive(CSendFrame sfSendFrame, uint8_t uSendNum = 0xff);


		/*-----------------------------------------------------------------------------
		功    能：	获取当前协议类型
		参数说明：	无
		返 回 值：	W_U8 -- 协议类型值
		说    明：	无
		-----------------------------------------------------------------------------*/
		uint8_t GetProtocol();

		/*-----------------------------------------------------------------------------
		功    能：	应用层传递Ecu信息
		参数说明：	EcuInfo ecu信息，协议、引脚等
		返 回 值：	W_U8 -- 协议类型值
		说    明：	无
		-----------------------------------------------------------------------------*/
		void SetEcuInfo(ECU_INFO EcuInfo);

		static void Delay(unsigned long msecs);

	protected:
		ErrorCode_t EnterCAN();// 标准CAN与扩展CAN进入
		ErrorCode_t EnterKwp();// EnterKwp
		ErrorCode_t EnterPWM();// PWM进入
		ErrorCode_t EnterVPW();// VPW进入
		ErrorCode_t EnterTp20();//Tp20进入
		ErrorCode_t EnterNormal();//Tp20进入
		ErrorCode_t EnterHondaPro();//Honda 协议
		ErrorCode_t EnterMit_Old();//三菱负逻辑
		ErrorCode_t EnterKwp1281();//KWP1281

	public:
		CEnterSys(uint8_t uSysId, string strProtocol);

		CBinary SendReceive(CBinary binSendFrame, uint8_t uRecvNum = 1);

	public:
		CStdCommMaco::ErrorCodeType InitProtocol(uint8_t uProtocolType = 0);
		CStdCommMaco::ErrorCodeType InitProtocolCan();
		CStdCommMaco::ErrorCodeType InitProtocolKwp2000Can20();
		CStdCommMaco::ErrorCodeType InitProtocolKwp2000Can16();
		CStdCommMaco::ErrorCodeType InitProtocolKwp1281Line();
		CStdCommMaco::ErrorCodeType InitProtocolKwp2000Line();

	public:
	};
}
#endif