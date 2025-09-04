#ifndef _STD_INCLUDE_H_
#define _STD_INCLUDE_H_

#include <string>
#include <vector>
#include <set>
#include <map>
#include <stack>
#include <memory>
#include <cstdint>
#include <cassert>

#if defined (WIN32) | defined (WIN64)
#include <windows.h>
#endif

#if defined (WIN32) | defined (WIN64)
#if (INCLUDE_ENABLE_USING_STD_NAMESPACE)
using namespace std;
#endif
#else
using namespace std;
#endif

/******  WINDOWS StdShow.dll 导入导出定义 *************/
#if defined (WIN32) | defined (WIN64)
#if defined (STD_SHOW_DLL_EXPORT)
#define _STD_SHOW_DLL_API_                __declspec(dllexport)
#else
#define _STD_SHOW_DLL_API_                __declspec(dllimport)
#endif
#else
#define _STD_SHOW_DLL_API_ __attribute__ ((visibility ("default")))
#endif
/*****************************************************/

/******  WINDOWS StdComm.dll 导入导出定义 ******/
#if defined (WIN32) | defined (WIN64)
#if defined (STD_ECU_DLL_EXPORT)
#define _STD_ECU_DLL_API_                __declspec(dllexport)
#else
#define _STD_ECU_DLL_API_                __declspec(dllimport)
/* 隐性加载通信库 */
#pragma comment(lib,"StdComm.lib")
#endif
#else
#define _STD_ECU_DLL_API_ __attribute__ ((visibility ("default")))
#endif
/*****************************************************/

/******  WINDOWS Std.dll 导入导出定义 ***************/
#if defined (WIN32) | defined (WIN64)
#ifdef _STD_DLL_EXPORTS_
#define _STD_DLL_API_ _declspec(dllexport)
#else
#define _STD_DLL_API_ _declspec(dllimport)
/* 隐性加载std库 */
#pragma comment (lib, "Std.lib")
#endif
#else 
#define _STD_DLL_API_
#endif
/*****************************************************/
#endif
