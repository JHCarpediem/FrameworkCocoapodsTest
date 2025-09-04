/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 文本类型数据库文件操作类，用于操作数据库文本文件
* 创 建 人 : sujiya        20201128
* 审 核 人 : binchaolin    20201202
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _DATA_FILE_H_
#define _DATA_FILE_H_
#include "BinaryGroup.h"
#include "StdInclude.h"


//由于目前管理程序暂时没有提供语言和车型路径，
//读文件操作时需要调用以下两个接口来自己设置
//_STD_DLL_API_ void setLanguage(const string& strLanguage = "en");
//_STD_DLL_API_ void setPath(const string& strPath);

//从text_xx.dat中获取文本串
_STD_DLL_API_ const string artiGetText(const string& strId);
_STD_DLL_API_ const string artiGetText(const CBinary& binId);

class CDataFileImp;
class _STD_DLL_API_ CDataFile
{
public:
	CDataFile();
	CDataFile(const CDataFile& right);
	CDataFile(const string& strFileName);
	~CDataFile();
	
	CDataFile& operator=(const CDataFile& right);

	/**********************************************************
	*    功  能：设置车型路径，进入车型时设置
	*    参  数：strPath 车型文件夹路径，由车型管理程序提供
	*    返回值：无
	**********************************************	************/
	static void SetVehPath(const string& strPath);
	static string GetVehPath();

	/**********************************************************
	*    功  能：设置当前语言，进入车型时设置
	*    参  数：strLanguage 当前语言包，由车型管理程序提供
	*    返回值：无
	**********************************************************/
	static void SetLanguage(const string& strLanguage);

	/*-----------------------------------------------------------------------------
	  功    能：获取dat文件的版本号

	  参数说明：无

	  返 回 值：32位 整型 0xHHLLYYXX

	  说    明：Coding of version numbers
				HH 为 最高字节, Bit 31 ~ Bit 24   主版本号（正式发行），0...255
				LL 为 次高字节, Bit 23 ~ Bit 16   次版本号（正式发行），0...255
				YY 为 次低字节, Bit 15 ~ Bit 8    最低版本号（测试使用），0...255
				XX 为 最低字节, Bit 7 ~  Bit 0    保留

				例如 0x02010300, 表示 V2.01.003
				例如 0x020B0000, 表示 V2.11
	-----------------------------------------------------------------------------*/
	uint32_t GetVersion();

	/**********************************************************
	*    功  能：打开文件
	*    参  数：strFileName 文件名字
	*    返回值：true 文件打开成功，false 文件打开失败
	**********************************************************/
	bool Open(const string& strFileName);

	/**********************************************************
	*    功  能：打开文件
	*    参  数：strFileName 文件名字
	*    返回值：打开失败错误码，<0：打开失败  >=0：打开成功
	*           -1：不允许执行该操作
	            -2：文件或目录不存在
				-5：I/O 错误
				-10001~-10015，-12001~-12003，-13001：DAT文件已损坏
	**********************************************************/
	int32_t OpenEx(const string& strFileName);

	/**********************************************************
	*    功  能：关闭已打开的文件
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Close();

	/**********************************************************
	*    功  能：根据文本ID获取文本内容
	*    参  数：strId 需要查找的文本ID
	*    返回值：strId对应的文本内容
	*    说  明：如果该ID下有多列，只返回第0列的内容
	**********************************************************/
	const string GetText(const string& strId);

	/**********************************************************
	*    功  能：根据文本ID获取文本内容
	*    参  数：binId 需要查找的文本ID
	*    返回值：binId对应的文本内容
	*    说  明：如果该ID下有多列，只返回第0列的内容
	**********************************************************/
	const string GetText(const CBinary& binId);

	/**********************************************************
	*    功  能：根据文本ID获取数组内容
	*    参  数：strId 需要查找的数组ID
	*    返回值：strId对应的数组内容
	*    说  明：如果该ID下有多组，只返回第0组的内容
	**********************************************************/
	const CBinary GetBinary(const string& strId);

	/**********************************************************
	*    功  能：根据文本ID获取数组内容
	*    参  数：binId 需要查找的数组ID
	*    返回值：binId对应的数组内容
	*    说  明：如果该ID下有多组，只返回第0组的内容
	**********************************************************/
	const CBinary GetBinary(const CBinary& binId);

	/**********************************************************
	*    功  能：根据文本ID获取文本内容
	*    参  数：strId 需要查找的文本ID
	*    返回值：strId对应的所有文本内容
	**********************************************************/
	const vector<string> Search(const string& strId);

	/**********************************************************
	*    功  能：根据文本ID获取文本内容
	*    参  数：binId 需要查找的文本ID
	*    返回值：binId对应的所有文本内容
	**********************************************************/
	const vector<string> Search(const CBinary& binId);

	/**********************************************************
	*    功  能：根据文本ID获取数组内容
	*    参  数：strId 需要查找的数组ID
	*    返回值：strId对应的所有数组内容
	**********************************************************/
	const CBinaryGroup SearchBinary(const string& strId);

	/**********************************************************
	*    功  能：根据文本ID获取数组内容
	*    参  数：binId 需要查找的数组ID
	*    返回值：binId对应的所有数组内容
	**********************************************************/
	const CBinaryGroup SearchBinary(const CBinary& binId);

	/**********************************************************
	*    功  能：根据列标-字符串对获取内容，类似于Excel表格筛选功能
	*    参  数：vctKeyValuesPairs 列标和字符串对集合,列标从0开始
	*            bOnlyGetFirst是否取到一行就返回，默认否
	*    返回值：所有满足条件的行
	**********************************************************/
	const vector<vector<string>> Search(const vector<pair<int, string>>& vctKeyValuesPairs, bool bOnlyGetFirst = false);
	int Search(vector<vector<string>> &vctResult, const vector<pair<int, string>>& vctKeyValuesPairs, bool bOnlyGetFirst = false);

	/**********************************************************
	*    功  能：退出车型时调用，关闭所有当前车型打开后未关闭的文件
	*    参  数：无
	*    返回值：无
	**********************************************************/
	static void Destroy();

private:
	CDataFileImp* m_pDataFileImp;
};


#endif // !_DATAFILE_H_
