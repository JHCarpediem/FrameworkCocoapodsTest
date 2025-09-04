#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
	class CArtiObdReviewTest : public CAPITest
	{
	public:
		void ShowMenu();
		void ArtiObdReviewTest_InitTitle();
		void ArtiObdReviewTest_SetReportResult();
		void ArtiObdReviewTest_SetMILStatus();
		void ArtiObdReviewTest_AddReadinessStatusItems();
		void ArtiObdReviewTest_AddEcuInfoItems();
		void ArtiObdReviewTest_AddDtcItem();
		void ArtiObdReviewTest_AddDtcItems();
		void ArtiObdReviewTest_AddLiveDataItem();
		void ArtiObdReviewTest_AddLiveDataItems();
		void ArtiObdReviewTest_AddIUPRStatusItem();

	protected:
	private:
	};

}