/*******************************************************************************
* Copyright (C), 2020, Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : 通用型配置库读取接口
* 创 建 人 : sujiya        20201210
* 审 核 人 : binchaolin    20201212
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _PROFILE_H_
#define _PROFILE_H_
#include "StdInclude.h"
#include "Binary.h"
#include "BinaryGroup.h"

class _STD_DLL_API_ CProFile
{
public:
	CProFile();
	CProFile(string &strCfg);
	CProFile(const CProFile& right);
	virtual ~CProFile();


public:
	/**********************************************************
	*    功  能：设置配置字符串
	*    参  数：strCfg 标准配置库字符串
	*    返回值：无
	**********************************************************/
	void Set(string& strCfg);

	/**********************************************************
	*    功  能：重置配置信息
	*    参  数：无
	*    返回值：无
	**********************************************************/
	void Reset();

	/**********************************************************
	*    功  能：从指定的配置库文件中获取获取配置项，然后设置
	*    注  意：此接口每次都进行了打开文件，关闭文件操作，
	*            如果数据库文件过大，则会影响速度
	*    参  数：strFileName 数据库名字，strCfgId 配置项ID
	*    返回值：true 设置成功，false 设置失败
	**********************************************************/
	bool GetCfgFromDatFileSet(const string& strFileName, const string& strCfgId);

	/**********************************************************
	*    功  能：从指定的配置库文件中获取获取配置项，然后设置
	*    注  意：此接口每次都进行了打开文件，关闭文件操作，
	*            如果数据库文件过大，则会影响速度
	*    参  数：strFileName 数据库名字，binCfgId 配置项ID
	*    返回值：true 设置成功，false 设置失败
	**********************************************************/
	bool GetCfgFromDatFileSet(const string& strFileName, const CBinary& binCfgId);

	/**********************************************************
	*    功  能：获取当前配置项中的所有节名称
	*    参  数：无
	*    返回值：vector<string> 配置项中的所有Section名称
	**********************************************************/
	const vector<string>& GetSections() const;

	/**********************************************************
	*    功  能：获取指定节下的所有Key名称
	*    参  数：strSection 节名称
	*    返回值：vector<string> 指定节下的所有Key名称
	**********************************************************/
	vector<string> GetKeysBySection(const string& strSection);

	/**********************************************************
	*    功  能：根据Section和Key获取配置项的值
	*    参  数：strSection 节名称，strKey 主键名称
	*    返回值：string 指定的配置项内容
	**********************************************************/
	string GetValue(const string& strSection, const string& strKey);

	/**********************************************************
	*    功  能：根据Section和Key获取配置项的值，并转为CBinary
	*    参  数：strSection 节名称，strKey 主键名称
	*    返回值：CBinary 指定的配置项内容
	**********************************************************/
	CBinary GetBinary(const string& strSection, const string& strKey);

	/**********************************************************
	*    功  能：根据Section和Key获取配置项的值，并转为CBinaryGroup
	*    参  数：strSection 节名称，strKey 主键名称
	*    返回值：CBinaryGroup 指定的配置项内容
	**********************************************************/
	CBinaryGroup GetBinaryGroup(const string& strSection, const string& strKey);

	/**********************************************************
	*    功  能：根据Section和Key获取配置项的值，并转为uint32_t
	*    参  数：strSection 节名称，strKey 主键名称
	*    返回值：uint32_t 指定的配置项内容
	**********************************************************/
	uint32_t GetHex(const string& strSection, const string& strKey);

	/**********************************************************
	*    功  能：根据Section和Key获取配置项的值，并转为vector<uint32_t>
	*    参  数：strSection 节名称，strKey 主键名称
	*    返回值：vector<uint32_t> 指定的配置项内容
	**********************************************************/
	vector<uint32_t> GetHexGroup(const string& strSection, const string& strKey);

	/**********************************************************
	*    功  能：根据Section和Key获取配置项的值，并转为vector<string>
	*    参  数：strSection 节名称，strKey 主键名称
	*    返回值：vector<string> 指定的配置项内容
	**********************************************************/
	vector<string> GetStringGroup(const string& strSection, const string& strKey);

protected:
	string GetOneLine(string& strCfg, size_t& nPos);
	uint32_t String2Hex(string& strValue);

private:
#if defined (WIN32) | defined (WIN64)
#pragma warning( disable : 4251 )
#endif
	map<string, vector<pair<string, string>>> m_mapSections;
	vector<string> m_vctSections;
};


#endif
