#include <cstdint>

//此修改为车系的主入口头文件
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
// 	功    能：	诊断入口
// 	参数说明：	uThread 线程编号，（编号为0-3）
// 	pVehicleInfo 车型结构指针，指针表示最终能定位到系统集合 ，==NULL则为线程0
// 	返 回 值：	无
// 	说    明：	无
// -----------------------------------------------------------------------------*/
EXTERN_C int32_t WINAPI ArtiDiag()

#elif defined(__APPLE__)

// 增加IOS包版本号，入口命名规则 ArtiVerDiag_XXX, XXX要和ArtiDiag_XXX保持一致 [10/27/2022 qunshang.li]
const std::string __attribute__((visibility("default"))) ArtiVerDiag_DEMO()
{
	return "V1.61"  ;
}

//#if defined(___IS_IOS___)
// 车型入口，车型根据实际名称更换函数名
// 由于IOS目前我们采用静态库方式，车型入口函数名必须保持唯一行
// 诊断车型入口函数命名规则：ArtiDiag_XXX
//                      这里XXX为诊断车型名，例如奔驰车，为：Benz，则入口为ArtiDiag_Benz
// 锁匠车型为：ArtiImmo_XXX
//                      这里XXX为锁匠车型名，例如福特车，为：Ford，则入口为ArtiDiag_Ford
//extern "C" void __attribute__((visibility("default"))) ArtiDiag_HelloWorld()



extern "C" int32_t __attribute__((visibility("default"))) ArtiDiag_DEMO()

#else
#include <jni.h>
extern "C" __attribute__((visibility("default"))) void _init(void) {}

extern "C" __attribute__((visibility("default"))) int32_t ArtiDiag(JNIEnv *env)
#endif
{
	//此处修改为车系的出入口类对象
	CDemo demo;
	demo.MainEntry();

	return 0;
}

/*-----------------------------------------------------------------------------
  功    能：  多系统诊断入口

  参数说明：  uThread 线程编号，（编号为0-3）
			  pVehicleInfo 车型结构指针，指针表示最终能定位到系统集合，NULL则为线程0

  返 回 值：  int32_t
  说    明：  无
-----------------------------------------------------------------------------*/
#if defined (_WIN32) | defined (_WIN64)
EXTERN_C void WINAPI ArtiDiagEx(uint32_t uThread, void* pVehicleInfo)
{
	//ArtiShowApiTestCase__MainEx(uThread, pVehicleInfo);
	//artiShowMsgBox("测试用例", "测试用例", DF_MB_OK, DT_CENTER);

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


