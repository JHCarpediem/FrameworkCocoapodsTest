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


#ifndef _APP_LAYER_H_
#define _APP_LAYER_H_

#include "StdCommMaco.h"
#include "DemoEnterSys.h"
#include "DemoVehicleStruct.h"
#include "StdShowMaco.h"
#include "ArtiGlobal.h"
#include "DiagEntryType.h"

namespace Topdon_AD900_Demo {

	class CAppLayer
	{
	public:
		CEnterSys m_EnterSys;//系统进入对象

	public:
		uint32_t uThread = 0;//多系统诊断程序线程编号

	public:
		CAppLayer();
		virtual ~CAppLayer();

	public:
		/*-----------------------------------------------------------------------------
		功    能：开启应用层
		参数说明：无
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t StartAppLayer();

		/*-----------------------------------------------------------------------------
		功    能：进入ECU
		参数说明：无
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t EnterEcu();

		/*-----------------------------------------------------------------------------
		功    能：读版本信息
		参数说明：
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ReadInformation();

		/*-----------------------------------------------------------------------------
		功    能：清故障码
		参数说明：
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ClearTroubleCode();

		/*-----------------------------------------------------------------------------
		功    能：读故障码
		参数说明：
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ReadTroubleCode(CBinary binSys);

		/*-----------------------------------------------------------------------------
		功    能：数据流
		参数说明：
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ReadDataStream(CBinary	binSys);

		/*-----------------------------------------------------------------------------
		功    能：动作测试
		参数说明：
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t ActiveTest(CBinary binSys);

		/*-----------------------------------------------------------------------------
		功    能：特殊功能
		参数说明：
		返 回 值：ErrorCode_t 错误代号
		说    明：无
		-----------------------------------------------------------------------------*/
		ErrorCode_t SpecialFunction(CBinary binSys);

		/*-----------------------------------------------------------------------------
		功    能：取ECU的功能菜单
		参数说明：无
		返 回 值：无
		说    明：无
		-----------------------------------------------------------------------------*/
		void GetFunMenu(CBinary binSys);

		/*-----------------------------------------------------------------------------
		功    能：历史记录的故障码
		参数说明：uDtcNum  ABS 系统故障码的个数
		返 回 值：无
		说    明：无
		-----------------------------------------------------------------------------*/
		void SetMyHistoryDtcItem(vector<stSysReportItem> vctItemsys);

	protected:
		void ExitSystem();//退出系统

	public:
		static vector<string> GetSectionsFromFile(string strFile, string strIndex);
		static vector<string> GetKeysFromFile(string strFile, string strIndex, string strSection);
		static string GetValueFromFile(string strFile, string strIndex, string strSection, string strKey);

		static vector<string> GetSectionsFromFile(string strFile, CBinary binIndex);
		static vector<string> GetKeysFromFile(string strFile, CBinary binIndex, string strSection);
		static string GetValueFromFile(string strFile, CBinary binIndex, string strSection, string strKey);

	public:
		static string SelectSysProtocol(uint8_t uSysId, uint32_t uThread = 0);

	public:
		void SetThreadNo(uint32_t uThread);
		void SetEnterSys(CEnterSys enterSys);
		void ShowSysFuncMenu();

	public:
		ErrorCode_t __ReadInformation();

		ErrorCode_t __ReadTroubleCode();
		ErrorCode_t __ClearTroubleCode();
		ErrorCode_t __FrzDataStream(CBinary binCode);

		ErrorCode_t __ReadDataStream();

		ErrorCode_t __ActiveTest();

	public:
		void SetSysReport(std::vector<stSysReportItem>& vctItem);
		map<eDiagEntryTypeEx, string>    m_mapeDiagTypeEx;

	private:

	};
}
#endif