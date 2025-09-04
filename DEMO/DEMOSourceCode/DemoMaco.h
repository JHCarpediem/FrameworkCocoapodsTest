#pragma once
#include "StdInclude.h"
#include "StdShowMaco.h"

namespace Topdon_AD900_Demo {

	#if defined WIN32 | defined (WIN64)
	#define __Multi_System_Test__	false	//多系统诊断测试用例宏
	#endif

	#define PROTOCOL_KWP2000CAN20					0x01
	#define PROTOCOL_UDS							0x02
	#define PROTOCOL_KWP2000CAN16					0x03
	#define PROTOCOL_KWP1281CAN16					0x04
	#define PROTOCOL_KWP2000LINE					0x05
	#define PROTOCOL_KWP1281LINE					0x06
	#define PROTOCOL_KWP2000CANISO					0x07
	#define PROTOCOL_29CAN							0x08
	#define PROTOCOL_CAN							0x09
	#define PROTOCOL_UNKNOW							0xFF

	#define FILE_AllSysProtocolConfig				"AllSysProtocolConfig.dat"

	#define ShowFuncInDevelopment();				ShowMsgBoxDemo(artiGetText("FF0000000010"), artiGetText("FF0000000011"), DF_MB_OK, DT_LEFT, -1, m_uThread);
	#define ShowFuncNotSupport();			    	ShowMsgBoxDemo(artiGetText("FF0000000010"), artiGetText("FF000000004E"), DF_MB_OK, DT_LEFT, -1, m_uThread);
	#define ShowEstablishComMsg();					ShowMsgBoxDemo(artiGetText("FF0000000043"), artiGetText("FF0000000044"), DF_MB_NOBUTTON, DT_LEFT,-1, m_uThread);

	#define TextSingleLine							artiGetText("FF0000000006")
	#define TextMulitLine							artiGetText("FF0000000007")
	#define TextMulitLineTitle						artiGetText("FF0000000046")//"Title:第1行:长文本测试\n第2行:长文本测试\n第3行:长文本测试\n第4行:长文本测试..."
	#define TextMulitLineValue						artiGetText("FF0000000047")//"Value:第1行:长文本测试\n第2行:长文本测试\n第3行:长文本测试\n第4行:长文本测试..."
	#define TextMulitLineUnit						artiGetText("FF0000000048")//"Unit:第1行:长文本测试\n第2行:长文本测试\n第3行:长文本测试\n第4行:长文本测试..."
	#define TextMulitLineHelp						artiGetText("FF0000000049")//"Help:第1行:长文本测试\n第2行:长文本测试\n第3行:长文本测试\n第4行:长文本测试..."

	static const std::size_t M_SIZE_LOGHEX_BUFFER_FOR_FUNCTION = 100;
	static const std::size_t M_SIZE_LOGHEX_BUFFER_FOR_FUNCTION_LK = 10;

	#if !defined (WIN32) & !defined (WIN64)
	#define SPRINTF_S(STR__, FORMAT__, ...)       {do{snprintf(STR__, M_SIZE_LOGHEX_BUFFER_FOR_FUNCTION, FORMAT__, __VA_ARGS__);}while(0);}
	#else
	#define SPRINTF_S(STR__, FORMAT__, ...)       {do{sprintf_s(STR__, M_SIZE_LOGHEX_BUFFER_FOR_FUNCTION, FORMAT__, __VA_ARGS__);}while(0);}
	#endif

	#if !defined (WIN32) & !defined (WIN64)
	#define sprintf_lk(STR__, FORMAT__, ...)       {do{snprintf(STR__, M_SIZE_LOGHEX_BUFFER_FOR_FUNCTION_LK, FORMAT__, __VA_ARGS__);}while(0);}
	#else
	#define sprintf_lk(STR__, FORMAT__, ...)       {do{sprintf_s(STR__, M_SIZE_LOGHEX_BUFFER_FOR_FUNCTION_LK, FORMAT__, __VA_ARGS__);}while(0);}
	#endif


	//字符最大长度4K，TextMulitLine长度为10kb

}
