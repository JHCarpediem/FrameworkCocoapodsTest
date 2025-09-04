/*******************************************************************************
* Copyright (C), 2021, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 文本类型数据库文件内存操作类，
*           用于在内存中操作数据库文本文件
* 备    注 : 该类主要用于从zip文件中读取.dat文件使用，
*           不建议用于大文件操作，比较占用内存资源
* 创 建 人 : sujiya        20210818
* 审 核 人 : binchaolin    20210818
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _MEMDATA_FILE_H_
#define _MEMDATA_FILE_H_
#include "DataFile.h"
#include "StdInclude.h"

class CMemDataFileImp;
class _STD_DLL_API_ CMemDataFile
{
public:
	CMemDataFile();
	CMemDataFile(const uint8_t* pFileBuffer, uint32_t len);
	CMemDataFile(const CMemDataFile& right);
	~CMemDataFile();

	CMemDataFile& operator=(const CMemDataFile& right);

	/**********************************************************
	*    功  能：将*dat文件的内容追加到类里
	*    参  数：pFileBuffer dat文件的内容，
	*           len pFileBuffer的长度
	*    返回值：无
	**********************************************	************/
	void Append(const uint8_t* pFileBuffer, uint32_t len);

	/**********************************************************
	*    功  能：关闭内存文件
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

	/**********************************************************
	*    功  能：获取文件内容
	*    参  数：
	*    返回值：文件内容在内存中的起始地址
	**********************************************************/
	uint8_t* GetBuffer() const;

	/**********************************************************
	*    功  能：获取文件内容的长度
	*    参  数：
	*    返回值：文件长度
	**********************************************************/
	uint32_t GetLength() const;

private:
	CMemDataFileImp* m_pMemDataFileImp;
};

//从zip文件中获取一个指定的*.dat文件，存在CMemDataFile中
_STD_DLL_API_ bool artiGetFileInZip(CMemDataFile& memDataFile, //将strFileName文件的内容存在MemDataFile中
	const string& strZipFileName, //zip文件名字*.zip
	const string& strFileName, //zip压缩包中的文件名字
	const string& strPassWord);//zip压缩包的密码

//从zip文件中解压一个文件到车型目录,成功返回true,失败返回false,
//比如：从0000.zip中解压1111.dat,文件解压在0000.zip所在目录的0000/1111.dat
_STD_DLL_API_ bool artiDecompressFile(const string& strZipFileName, //zip文件名字*.zip
	const string& strFileName, //zip压缩包中的文件名字
	const string& strPassWord);//zip压缩包的密码

//删除当前车型中的一个目录
//
_STD_DLL_API_ bool artiDeletePath(const string& strPath);


#endif
