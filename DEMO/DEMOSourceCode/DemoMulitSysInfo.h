#pragma once
#include "StdInclude.h"
#include "DemoAPITest.h"
#include "DemoAppLayer.h"

namespace Topdon_AD900_Demo {

	class CMulitSysInfo
	{
	public:
		CMulitSysInfo() {}
		~CMulitSysInfo()
		{
			if (ptrApiTest != nullptr)
			{
				delete ptrApiTest;
			}
			if (ptrAppLayer != nullptr)
			{
				delete ptrAppLayer;
			}
		}

	public:
		string strType = "APITEST";
		CAPITest* ptrApiTest = nullptr;
		CAppLayer* ptrAppLayer = nullptr;

	public:
		void SetType(string strType)
		{
			this->strType = strType;
		}

		void SetApiTest(CAPITest* ptrApiTest)
		{
			this->ptrApiTest = ptrApiTest;
		}

		void SetAppLayer(CAppLayer* ptrAppLayer)
		{
			this->ptrAppLayer = ptrAppLayer;
		}

	protected:
	private:
	};

}