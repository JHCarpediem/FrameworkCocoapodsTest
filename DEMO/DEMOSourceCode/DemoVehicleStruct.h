#ifndef _VEHICLE_STRUCT_H_
#define _VEHICLE_STRUCT_H_

#include "StdInclude.h"
#include "DemoNetLayer.h"
#include "DataFile.h"

namespace Topdon_AD900_Demo {

	struct ECU_INFO
	{
		uint8_t		uProtocol;
		uint8_t		uProtocolSelf;//自定义的协议 如 honda、mit 负逻辑 ==1 为honda  2为mit负逻辑
		uint8_t		uAddress;
		uint32_t	uToolId;
		uint32_t	uEcuId;
		uint32_t	uBps;
		uint8_t		uPinH;
		uint8_t		uPinL;
		COMMTIME	TimePara;
		uint8_t		uPackUpack;
		CBinary		binInitCmd;
		CBinary		binSingleCANInitCmd;
		CBinaryGroup		bgEnterCmd;
		CBinary		binKeepLink;
		uint32_t	uKeepTime;
		uint8_t		uFlowCtrlType;
		CBinaryGroup	bgExitCmd;
	};

	struct SYS_INFO
	{
		string	strSysName;
		vector<ECU_INFO> vecEcuInfo;
	};

	struct TROUBLECODE
	{
		string	strCode;//码号
		string	strCodeText;//码的定义
		string	strStatus;//码的状态
	};

	class CModelInfo
	{
	private:
		string strVehicle = "DEMO";
		string strDiagnosisType = "";	//诊断类型
		string strModel = "";			//车型
		string strYear = "";			//年款
		string strEngineType = "";			//发动机型号
		string strEngineSubType = "";			//发动机子型号
		string strDiagnosisMenu = "";	//诊断菜单
		string strSysName = "";

	public:
		void Clear() 
		{
			strVehicle = "DEMO";
			strDiagnosisType = "";
			strModel = "";
			strYear = "";
			strDiagnosisMenu = "";
		}

		string toString()
		{
			string strModelInfo = "DEMO";

			if (strDiagnosisType.empty())
			{
				return strModelInfo;
			}
			strModelInfo = strModelInfo + "/" + strDiagnosisType;

			if (!strDiagnosisType.compare(artiGetText(CBinary("\x50\x00\x00\x00\x00\x02", 6))))
			{
				if (strModel.empty())
				{
					return strModelInfo;
				}
				strModelInfo = strModelInfo + "/" + strModel;

				if (strYear.empty())
				{
					return strModelInfo;
				}
				strModelInfo = strModelInfo + "/" + strYear;

				if (strDiagnosisMenu.empty())
				{
					return strModelInfo;
				}
				strModelInfo = strModelInfo + "/" + strDiagnosisMenu;
			}

			if (strSysName.empty())
			{
				return strModelInfo;
			}

			strModelInfo = strModelInfo + "/" + strSysName;
			return strModelInfo;
		}

	public:
		void SetVehicle(string var1)
		{
			strVehicle = var1;
		}
		void SetDiagnosisType(string var1)
		{
			strDiagnosisType = var1;
		}
		void SetModel(string var1)
		{
			strModel = var1;
		}
		string GetDiagType()
		{
			return strDiagnosisType;
		}
		string GetModel()
		{
			return strModel;
		}
		string GetSysName()
		{
			return strSysName;
		}
		string GetYear()
		{
			return strYear;
		}
		string GetEngineType()
		{
			return strEngineType;
		}
		string GetEngineSubType()
		{
			return strEngineSubType;
		}
		void SetYear(string var1)
		{
			strYear = var1;
		}
		void SetEngineType(string strType)
		{
			strEngineType = strType;
		}
		void SetEngineSubType(string strSubType)
		{
			strEngineSubType = strSubType;
		}
		void SetDiagnosisMenu(string var1)
		{
			strDiagnosisMenu = var1;
		}
		void SetSysName(string var1)
		{
			strSysName = var1;
		}

	protected:
	private:
	};

}
#endif
