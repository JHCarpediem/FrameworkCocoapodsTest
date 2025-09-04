#pragma once
#include "DemoAPITest.h"
#include <vector>

namespace Topdon_AD900_Demo {
    class CArtiReportTest :
        public CAPITest
    {
	private:
		vector<string> m_vctHeads;
		vector<int32_t> m_vctColWidth2;
		vector<stSysReportItem> vctSysReportItem;
		vector<stSysReportItem> vctSysReportItem24;
		vector<stSysReportItem> vctSysReportItem135;
		
		vector<stDtcReportItem> vctDtcReportItem;
		vector<stDtcReportItem> vctDtcReportItem24;
		vector<stDtcReportItem> vctDtcReportItem135;

		vector<stDsReportItem> vctDsReportItem;
		vector<stDsReportItem> vctDsReportItem24;
		vector<stDsReportItem> vctDsReportItem135;

		vector<stDtcReportItemEx> m_vctDtcReportItemEx;


	public:
		CArtiReportTest();

	public:
		// ArtiReport≤‚ ‘œÓ
		void ShowMenu();
		void ArtiReportTest_InitTitle();
		void ArtiReportTest_SetReportType();
		void ArtiReportTest_SetTypeTitle();
		void ArtiReportTest_SetDescribeTitle();
		void ArtiReportTest_SetSummarize();
		void ArtiReportTest_AddSysItem();
		void ArtiReportTest_AddSysItems();
		void ArtiReportTest_AddDtcItem();
		void ArtiReportTest_AddDtcItems();
		void ArtiReportTest_AddLiveDataSys();
		void ArtiReportTest_AddLiveDataItem();
		void ArtiReportTest_AddLiveDataItems();
		void ArtiReportTest_SetMileage();
		void ArtiReportTest_SetVehInfo();
		void ArtiReportTest_SetEngineInfo();
		void ArtiReportTest_SetVehPath();
		void ArtiReportTest_AddDtcItemEx();
		void ArtiReportTest_AddDtcItemsEx();

    };
}
