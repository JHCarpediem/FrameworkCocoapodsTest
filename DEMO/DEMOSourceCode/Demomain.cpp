#include <cstdint>

//���޸�Ϊ��ϵ�������ͷ�ļ�
#include "Demo.h"
#include "DemoVehicleStruct.h"
#include "PublicInterface.h"

using namespace Topdon_AD900_Demo;

#if defined WIN32 | defined (WIN64)
#include <Windows.h>
#include "ArtiMsgBox.h"
#include "DemoAppLayer.h"
#include "ArtiMenu.h"
#include "DemoAPITest.h"
#include "DemoMulitSysInfo.h"

// /*-----------------------------------------------------------------------------
// 	��    �ܣ�	������
// 	����˵����	uThread �̱߳�ţ������Ϊ0-3��
// 	pVehicleInfo ���ͽṹָ�룬ָ���ʾ�����ܶ�λ��ϵͳ���� ��==NULL��Ϊ�߳�0
// 	�� �� ֵ��	��
// 	˵    ����	��
// -----------------------------------------------------------------------------*/
EXTERN_C int32_t WINAPI ArtiDiag()

#elif defined(__APPLE__)

// ����IOS���汾�ţ������������ ArtiVerDiag_XXX, XXXҪ��ArtiDiag_XXX����һ�� [10/27/2022 qunshang.li]
const std::string __attribute__((visibility("default"))) ArtiVerDiag_DEMO()
{
	return "V1.61"  ;
}

//#if defined(___IS_IOS___)
// ������ڣ����͸���ʵ�����Ƹ���������
// ����IOSĿǰ���ǲ��þ�̬�ⷽʽ��������ں��������뱣��Ψһ��
// ��ϳ�����ں�����������ArtiDiag_XXX
//                      ����XXXΪ��ϳ����������籼�۳���Ϊ��Benz�������ΪArtiDiag_Benz
// ��������Ϊ��ArtiImmo_XXX
//                      ����XXXΪ���������������縣�س���Ϊ��Ford�������ΪArtiDiag_Ford
//extern "C" void __attribute__((visibility("default"))) ArtiDiag_HelloWorld()



extern "C" int32_t __attribute__((visibility("default"))) ArtiDiag_DEMO()

#else
#include <jni.h>
extern "C" __attribute__((visibility("default"))) void _init(void) {}

extern "C" __attribute__((visibility("default"))) int32_t ArtiDiag(JNIEnv *env)
#endif
{
	//�˴��޸�Ϊ��ϵ�ĳ���������
	CDemo demo;
	demo.MainEntry();

	return 0;
}

/*-----------------------------------------------------------------------------
  ��    �ܣ�  ��ϵͳ������

  ����˵����  uThread �̱߳�ţ������Ϊ0-3��
			  pVehicleInfo ���ͽṹָ�룬ָ���ʾ�����ܶ�λ��ϵͳ���ϣ�NULL��Ϊ�߳�0

  �� �� ֵ��  int32_t
  ˵    ����  ��
-----------------------------------------------------------------------------*/
#if defined (_WIN32) | defined (_WIN64)
EXTERN_C void WINAPI ArtiDiagEx(uint32_t uThread, void* pVehicleInfo)
{
	//ArtiShowApiTestCase__MainEx(uThread, pVehicleInfo);
	//artiShowMsgBox("��������", "��������", DF_MB_OK, DT_CENTER);

	if (pVehicleInfo != nullptr)
	{
		CMulitSysInfo* ptrMulitSysInfo = (CMulitSysInfo*)pVehicleInfo;
		if (ptrMulitSysInfo->strType == "APITEST")
		{
			ptrMulitSysInfo->ptrApiTest->SetThread(uThread);
			ptrMulitSysInfo->ptrApiTest->ShowMenu();
		}
		else
		{
			ptrMulitSysInfo->ptrAppLayer->SetThreadNo(uThread);
			ptrMulitSysInfo->ptrAppLayer->ShowSysFuncMenu();
		}
		delete ptrMulitSysInfo;
		pVehicleInfo = nullptr;
		ptrMulitSysInfo = nullptr;
	}
}
#else
//extern "C" __attribute__((visibility("default"))) void _init(void) {}
//extern "C" void __attribute__((visibility("default"))) ArtiDiagEx()
//{
//}
#endif


