#include "DemoMaco.h"
#include "cctype"
#include "DemoPublicAPI.h"
#include "PublicInterface.h"
#include <time.h>
#include <algorithm>
#include "ArtiGlobal.h"
#include <stdio.h>
#include <stdlib.h>

#if defined WIN32 | defined (WIN64)

#else

#include <sys/time.h>
#include <unistd.h>

#endif




namespace Topdon_AD900_Demo {

	std::string Binary2ASCIIString(const CBinary& binData)
	{
		string strRet;
		for (size_t i = 0; i < binData.GetSize(); i++)
		{
			char buff[100] = { 0 };
			SPRINTF_S(buff, "%c", binData[i]);
			strRet += buff;
		}
		return strRet;
	}

	uint32_t String2UInt(string strSrc, uint16_t uFormat /*= 16*/)
	{
		uint32_t uDst = 0;
		/*for (auto c : strSrc)
		{
			c = toupper(c);
		}*/

		transform(strSrc.begin(), strSrc.end(), strSrc.begin(), ::toupper);

		if (("0X" == strSrc.substr(0, 2)))
		{
			uFormat = 16;
			strSrc = strSrc.substr(2, strSrc.length());
		}
		if (10 == uFormat)
		{
			uDst = atoi(strSrc.c_str());
		}
		else if (16 == uFormat)
		{
			for (auto ch : strSrc)
			{
				uint8_t uByte = 0;
				switch (ch)
				{
				case 'A':				uByte = 10;				break;
				case 'B':				uByte = 11;				break;
				case 'C':				uByte = 12;				break;
				case 'D':				uByte = 13;				break;
				case 'E':				uByte = 14;				break;
				case 'F':				uByte = 15;				break;
				default:				uByte = ch - '0';		break;
				}
				uDst = (uDst << 4) + uByte;
			}
		}
		return uDst;
	}

	/**********************************************************
	*    ��������ToDouble
	*    ��  ����string &
	*    ����ֵ��double
	#    ˵  �����ַ���ת˫���ȸ�����
	**********************************************************/
	double ToDouble(string& str)
	{
		return ToDouble(str.c_str());
	}

	/**********************************************************
	*    ��������ToDouble
	*    ��  ����char *
	*    ����ֵ��double
	#    ˵  �����ַ���ת˫���ȸ�����
	**********************************************************/
	double ToDouble(const char* str)
	{
		return strtod(str, NULL);
	}

	/**********************************************************
	*    ��������ToFolat
	*    ��  ����string &
	*    ����ֵ��float
	#    ˵  �����ַ���ת�����ȸ�����
	**********************************************************/
	float ToFolat(string& str)
	{
		return ToFolat(str.c_str());
	}

	/**********************************************************
	*    ��������ToFolat
	*    ��  ����char *
	*    ����ֵ��float
	#    ˵  �����ַ���ת�����ȸ�����
	**********************************************************/
	float ToFolat(const char* str)
	{
		return strtof(str, NULL);
	}

	/**********************************************************
	*    ��������ToInt8
	*    ��  ����string &, int32_t
	*    ����ֵ��int8_t
	#    ˵  �����ַ���ת�з���8λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	int8_t ToInt8(string& str, int32_t radix)
	{
		return (int8_t)strtol(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToUint8
	*    ��  ����string &, int32_t
	*    ����ֵ��uint8_t
	#    ˵  �����ַ���ת�޷���8λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	uint8_t ToUint8(string& str, int32_t radix)
	{
		return (uint8_t)strtol(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToInt16
	*    ��  ����string &, int32_t
	*    ����ֵ��int16_t
	#    ˵  �����ַ���ת�з���16λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	int16_t ToInt16(string& str, int32_t radix)
	{
		return (int16_t)strtol(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToUint16
	*    ��  ����string &, int32_t
	*    ����ֵ��uint16_t
	#    ˵  �����ַ���ת�޷���16λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	uint16_t ToUint16(string& str, int32_t radix)
	{
		return (uint16_t)strtol(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToInt32
	*    ��  ����string &, int32_t
	*    ����ֵ��int32_t
	#    ˵  �����ַ���ת�з���32λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	int32_t ToInt32(string& str, int32_t radix)
	{
		return (int32_t)strtoll(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToInt32
	*    ��  ����string &, int32_t
	*    ����ֵ��uint32_t
	#    ˵  �����ַ���ת�޷���32λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	uint32_t ToUint32(string& str, int32_t radix)
	{
		return (uint32_t)strtoll(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToInt64
	*    ��  ����string &, int32_t
	*    ����ֵ��int64_t
	#    ˵  �����ַ���ת�з���64λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	int64_t ToInt64(string& str, int32_t radix)
	{
		return strtoull(str.c_str(), NULL, radix);
	}

	/**********************************************************
	*    ��������ToUint64
	*    ��  ����string &, int32_t
	*    ����ֵ��uint64_t
	#    ˵  �����ַ���ת�޷���64λ����
	#    ��  �����ڶ�����������ת���Ľ���
	**********************************************************/
	uint64_t ToUint64(string& str, int32_t radix)
	{
		return strtoull(str.c_str(), NULL, radix);
	}


	string uint8ToString(uint8_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%d", value);
		}
		else
		{
			sprintf_lk(chs, "%x", value);
		}

		return string(chs, strlen(chs));
	}

	string int8ToString(int8_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%d", value);
		}
		else
		{
			sprintf_lk(chs, "%x", value);
		}

		return string(chs, strlen(chs));
	}

	string uint8ToBinaryString(uint8_t value)
	{
		string strRet = "";
		for (int8_t i = 7; i >= 0; i--)
		{
			if ((value >> i) & 0x01)
			{
				strRet += "1";
			}
			else
			{
				strRet += "0";
			}
		}
		return strRet;
	}

	string uint16ToString(uint16_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%d", value);
		}
		else
		{
			sprintf_lk(chs, "%x", value);
		}

		return string(chs, strlen(chs));
	}

	string int16ToString(int16_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%d", value);
		}
		else
		{
			sprintf_lk(chs, "%x", value);
		}

		return string(chs, strlen(chs));
	}

	string uint32ToString(uint32_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%d", value);
		}
		else
		{
			sprintf_lk(chs, "%x", value);
		}

		return string(chs, strlen(chs));
	}

	string int32ToString(int32_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%d", value);
		}
		else
		{
			sprintf_lk(chs, "%x", value);
		}

		return string(chs, strlen(chs));
	}

	string uint64ToString(uint64_t value, bool decimal)
	{
		char chs[100] = { 0 };
		if (decimal)
		{
			snprintf(chs, sizeof(chs),"%llu", (unsigned long long)value);
		}
		else
		{
			snprintf(chs, sizeof(chs), "%llx", (unsigned long long)value);
		}

		return string(chs, strlen(chs));
	}

	string int64ToString(int64_t value, bool decimal)
	{
		char chs[17] = { 0 };
		if (decimal)
		{
			sprintf_lk(chs, "%lld", (long long int)value);
		}
		else
		{
			sprintf_lk(chs, "%llx", (long long int)value);
		}

		return string(chs, strlen(chs));
	}

	/**********************************************************
	*    ��������BinFindByte
	*    ��  ����CBinary, CBinary
	*    ����ֵ��int
	#    ˵  �������ַ�����binValue���ҵ��̶�����Ϊ2������binFind��λ��
	**********************************************************/
	int BinFindByte(CBinary binValue, CBinary binFind)
	{
		int16_t iPos = 0xFF;
		if (binFind.GetSize() != 2)
		{
			return iPos;
		}
		for (uint32_t z = 0; z < binValue.GetSize() - 1; z++)
		{
			if (binValue[z] == binFind[0] && binValue[z + 1] == binFind[1])
			{
				iPos = z + 2;
				return iPos;
			}
		}
		return iPos;
	}

	/**********************************************************
	*    ��������Split
	*    ��  ����const string& , const string& , vector<string>&
	*    ����ֵ��void
	#    ˵  �������ַ���s�����ַ���c�ָ��ŵ�����v��
	**********************************************************/
	void Split(const string& s, const string& c, vector<string>& v)
	{
		string::size_type pos1, pos2;
		pos2 = s.find(c);
		pos1 = 0;
		while (string::npos != pos2)
		{
			v.push_back(s.substr(pos1, pos2 - pos1));

			pos1 = pos2 + c.size();
			pos2 = s.find(c, pos1);
		}

		v.push_back(s.substr(pos1));
	}

	/**********************************************************
	*    ��������SortCBinary
	*    ��  ����CBinary &
	*    ����ֵ��void
	#    ˵  �������ַ�����bin���°��մ�С��������
	**********************************************************/
	void SortCBinary(CBinary& bin)
	{
		int size = bin.GetSize();
		for (int i = 1; i < size; i++)
		{
			for (int j = 0; j < size - i; j++)
			{
				if (bin[j] > bin[j + 1])
				{
					uint8_t k = bin[j];
					bin.SetAt(j, bin[j + 1]);
					bin.SetAt(j + 1, k);
				}
			}
		}
	}

	/**********************************************************
	*    ��������isVctStrHasOneStr
	*    ��  ����vector<string>& , string &
	*    ����ֵ��bool
	#    ˵  �����ж��ַ�������vctStr���Ƿ�����ַ���str
	**********************************************************/
	bool isVctStrHasOneStr(vector<string>& vctStr, string& str)
	{
		for (vector<string>::iterator it = vctStr.begin(); it != vctStr.end(); it++)
		{
			if (str == *it)
			{
				return true;
			}
		}
		return false;
	}

	/**********************************************************
	*    ��������Binary2ASCIIStringForVIN
	*    ��  ����const CBinary&
	*    ����ֵ��string
	#    ˵  ����VIN������ظ������ַ�����ת�ַ���
	#    ��  �����Զ�ȥ������'0'-'8'�� 'A'- 'Z'֮���ascll��
	**********************************************************/
	string Binary2ASCIIStringForVIN(const CBinary& binData)
	{
		string strRet;
		for (size_t i = 0; i < binData.GetSize(); i++)
		{
			if ((binData[i] >= '0' && binData[i] <= '9') ||
				(binData[i] >= 'A' && binData[i] <= 'Z'))
			{
				char buff[10] = { 0 };
				sprintf_lk(buff, "%c", binData[i]);
				strRet += buff;
			}
		}

		if (strRet.size() > 17)
		{
			strRet = strRet.substr(0, 17);
		}
		return strRet;
	}

	uint32_t CountOneItemRepeatPosMap(map<uint32_t, uint32_t>& RepeatPosMap, uint32_t iBytePos)
	{
		uint32_t iCount = 0;
		for (size_t i = 0; i < RepeatPosMap.size(); i++)
		{
			if (RepeatPosMap[i] == iBytePos)
				iCount++;
		}
		return iCount;
	}

	int32_t ComplementCode(CBinary buf)
	{
		int f = (buf[0] & 0x80) >> 7;//ȡ����λ
		if (f)//��ʾ����λΪ��
		{
			char d1 = ~buf[0];  //������ȡ��
			char d2 = ~buf[1];
			char d3 = ~buf[2];  //������ȡ��
			char d4 = ~buf[3];
			int32_t b = ((d1 << 24) & 0xff000000) | ((d2 << 16) & 0xff0000) | ((d3 << 8) & 0xff00) | (d4 & 0xff);	 //�õ�~x��ֵ
			return -1 - b;		     //���ظ���ֵ
		}
		else
		{
			return ((buf[0] << 24) & 0xff000000) | ((buf[1] << 16) & 0xff0000) | ((buf[2] << 8) & 0xff00) | (buf[3] & 0xff);
		}

	}

	string DecString2HexString(string str)
	{
		uint32_t iInput = ToUint32(str, 10);
		char buf[50] = { 0 };
		sprintf_lk(buf, "%X", iInput);
		str = buf;
		return str;
	}

	string HexString2UintDecString(string str)
	{
		uint32_t iInput = ToUint32(str, 16);
		char buf[50] = { 0 };
		sprintf_lk(buf, "%u", iInput);
		str = buf;
		return str;
	}

	string HexString2IntDecString(string str)
	{
		int32_t iInput = ToInt32(str, 16);
		char buf[50] = { 0 };
		sprintf_lk(buf, "%d", iInput);
		str = buf;
		return str;
	}

	CBinary getBinFromDecString(string strReturn, uint32_t iBinSize)
	{
		int64_t iTemp = 0;
		if (strReturn.find("-") != -1)//����
		{
			strReturn = strReturn.substr(1);
			uint32_t uTemp = ToUint32(strReturn, 10);
			iTemp = ((1 << (8 * iBinSize)) - uTemp);
		}
		else//����
		{
			uint32_t uTemp = ToUint32(strReturn, 10);
			iTemp = uTemp;
			//iTemp = ((1 << (8 * iBinSize)) - 1);
		}
		//int64_t ii1 = 1 << (8 * iBinSize);
		//int64_t ii2 = 1 << 31;

		char format[16] = { 0 };
		char value[256] = { 0 };
		memset(format, 0x0, 16);
		memset(value, 0x0, 256);
		sprintf_lk(format, "%%0%dX", iBinSize * 2);//���ֽڳ�������ʽ��
		sprintf_lk(value, format, iTemp);
		return HexString2Binary(value);
	}

	void Delay(int msec)
	{
#if defined (WIN32) | defined (WIN64)
		Sleep(msec);
#else
		usleep(msec * 1000);
#endif
	}

	char* strcat_lk(char* destStr, char const* srcStr)
	{
		if (destStr == nullptr
			|| srcStr == nullptr)
		{
			return destStr;
		}
		char* temp = destStr;
		while (*temp != '\0') temp++;
		while ((*temp++ = *srcStr++) != '\0');
		return destStr;
	}

	void Android_log(string strLog)
	{
#if !defined (WIN32) & !defined (WIN64)
		//artiShowMsgBox(artiGetText(Txt_Info), strLog, DF_MB_OK);
#endif
	}
	//
	//CBinary GetCurDateBinData(bool isReverseOrder)
	//{
	//	CBinary binData("\x00\x00\x00\x00", 4);
	//	time_t t = time_t(NULL);
	//	struct tm* local = localtime_s(&t);
	//
	//	string hYear = uint32ToString((local->tm_year + 1900) / 100, true);
	//	string lYear = uint32ToString((local->tm_year + 1900) % 100, true);
	//	string month = uint32ToString(local->tm_mon + 1, true);
	//	string day = uint32ToString(local->tm_mday, true);
	//	binData.SetAt(0, ToUint32(hYear));
	//	binData.SetAt(1, ToUint32(lYear));
	//	binData.SetAt(2, ToUint32(month));
	//	binData.SetAt(3, ToUint32(day));
	//	binData.Erase(0);
	//	if (isReverseOrder)
	//	{
	//		CBinary temp = binData;
	//		binData.SetAt(0, temp[2]);
	//		binData.SetAt(2, temp[0]);
	//	}
	//	return binData;
	//}
	//
	//string GetCurTime()
	//{
	//	string value = "";
	//	time_t t = time(NULL);
	//	struct tm* local = localtime(&t);
	//	char buf[256] = { 0 };
	//	sprintf_lk(buf, "Local time is: %02d : %02d : %02d/n", local->tm_hour, local->tm_min, local->tm_sec);
	//	value = string(buf);
	//	return value;
	//}
	//

	string GetInputExpressBySize(uint32_t uSize)
	{
		string strnputExpress = "(";
		for (size_t i = 1; i <= uSize; i++)
		{
			char buf[256] = { 0 };
			if (i != uSize)
			{
				sprintf_lk(buf, "(x%zu<<%lu) + ", i, (uSize - i) * 8);
				strnputExpress += buf;
			}
			else
			{
				sprintf_lk(buf, "x%zu", i);
				strnputExpress += buf;
			}
		}
		strnputExpress += ")";
		return strnputExpress;
	}

	string substring(string value, uint32_t numericIndex, uint32_t numericCount)
	{
		string strValue = value;
		if (numericIndex >= 0 && numericIndex <= value.length())
		{
			if (numericCount < 0)
			{
				strValue = "";
			}
			else
			{
				int32_t iCount = numericCount - numericIndex;
				if (!iCount)
				{
					strValue = "";
				}
				else if ((uint32_t)iCount < value.length())
				{
					strValue = (value.substr(numericIndex, iCount));
				}
			}
		}
		return strValue;
	}

	string trim(string value)
	{
		int len = value.length();
		int st = 0;
		string val = value;    /* avoid getfield opcode */

		while ((st < len) && ((uint8_t)val[st] <= ' '))
		{
			st++;
		}
		while ((st < len) && ((uint8_t)val[len - 1] <= ' '))
		{
			len--;
		}
		return ((st > 0) || (len < (int)value.length())) ? substring(value, st, len) : value;
	}

	/**********************************************************
	*    ��������printLog
	*    ��  ����string
	*    ����ֵ��void
	#    ˵  ������Visual studio��������д�ӡ��־
	**********************************************************/
	void printLog(string t)
	{
#if defined WIN32 | defined (WIN64)
		t += "\n";
		OutputDebugStringA(t.c_str());
#endif
	}

	/**********************************************************
	*    ��������printLog
	*    ��  ����initializer_list<string> ls
	*    ����ֵ��void
	#    ˵  ������Visual studio��������д�ӡ��־
	#	 ���Դ��룺printLog({ "AAAA", "BBBB", "CCCC" })
	**********************************************************/
	void printLog(initializer_list<string> ls)
	{
#if defined WIN32 | defined (WIN64)
		string  m = "";
		for (auto& n : ls)
		{
			m += n;
		}
		OutputDebugStringA(m.c_str());
#endif
	}

	int64_t GetSysTime()
	{
#if defined WIN32 | defined (WIN64)
		time_t time = GetTickCount();
		return time;
#else
		struct timeval time;
		gettimeofday(&time, NULL);
		return time.tv_sec * 1000 + time.tv_usec / 1000;
#endif
	}

	/*-----------------------------------------------------------------------------
		��    �ܣ�ȡ֧�ֵĳ������⹦�ܵ��±꼯��
		����˵������
		�� �� ֵ���±꼯��
		˵    ������
	-----------------------------------------------------------------------------*/
	vector<uint32_t> GetSupportHotFun()
	{
		vector<uint32_t> vctiFun;
		vector<bool> vctbFun;

		vctbFun = CArtiGlobal::GetDiagEntryTypeEx();
		for (uint32_t i=6;i<vctbFun.size(); i++)
		{
			if (vctbFun[i])
			{
				vctiFun.push_back(i);
			}
		}
		return vctiFun;
	}

	/*-----------------------------------------------------------------------------
	��    �ܣ�ȡ֧�ֵĹ��ܵ��±�
	����˵������
	�� �� ֵ���������ܺ����⹦���±꼯��
	˵    ������
-----------------------------------------------------------------------------*/
	vector<uint32_t> GetSupportAllFun()
	{
		vector<uint32_t> vctiAllFun;
		vector<bool> vctbFun;

		vctbFun = CArtiGlobal::GetDiagEntryTypeEx();
		for (uint32_t i = 0; i < vctbFun.size(); i++)
		{
			if (vctbFun[i])
			{
				vctiAllFun.push_back(i);
			}
		}
		return vctiAllFun;
	}
}
