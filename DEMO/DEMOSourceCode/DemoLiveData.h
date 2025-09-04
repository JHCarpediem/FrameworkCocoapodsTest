/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : ������
* �������� : ����������
* �� �� �� : panjun        20210123
* �� �� �� :
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/


#ifndef _LIVEDATA_
#define _LIVEDATA_
#include "DemoEnterSys.h"
#include "StdShowMaco.h"
#include "DemoVehicleStruct.h"

namespace Topdon_AD900_Demo {

	class CLiveData
	{
	private:
		CEnterSys* m_pSysEnter;

	public:
		CLiveData();
		~CLiveData();

	public:
		/*-----------------------------------------------------------------------------
		��    �ܣ�	��pSysEnter���m_pSysEnter
		����˵����	pSysEnter ϵͳ����ָ��
		�� �� ֵ��	��
		˵    ����	��
		-----------------------------------------------------------------------------*/
		void SetSysEnterPointer(CEnterSys* pSysEnter);

		/*-----------------------------------------------------------------------------
		��    �ܣ�	���汾��Ϣ
		����˵����	��
		�� �� ֵ��	��
		˵    ����	��
		-----------------------------------------------------------------------------*/
		void DataStream(CBinary binSys);

	protected:

	public:
		void SetLiveDataReport(std::vector<stDsReportItem>& vctItem);
	};
}
#endif /*_READ_VER_H_*/