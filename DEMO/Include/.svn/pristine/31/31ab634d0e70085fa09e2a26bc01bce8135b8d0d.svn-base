#ifndef _ALGORITHMDATA_H_
#define _ALGORITHMDATA_H_
#include "Binary.h"

class _STD_DLL_API_ CAlgorithmData
{
public:
	enum { SEED_TYPE_REMOTE = 1, SEED_TYPE_LOCAL = 2, 
		SEED_TYPE_DOWNLOAD = 3, SEED_TYPE_UNKNOWN = 0xFF };
	enum { KEY_TYPE_ANS = 0, KEY_TYPE_ERR = 1, KEY_TYPE_UNKNOWN = 0xFF };
	CAlgorithmData();
	CAlgorithmData(const CAlgorithmData& right);
	CAlgorithmData(CAlgorithmData&& right);
	~CAlgorithmData();

	void SetId(uint32_t uId) { m_uId = uId; }//设置算法Id
	uint32_t GetId() const { return m_uId; }//获取算法Id
	void SetSubId(uint32_t uSubId);//设置算法扩充Id，预留扩充时使用
	uint32_t GetSubId() const { return m_uSubId; };//获取算法扩充Id
	void SetSeedType(uint8_t uSeedType = SEED_TYPE_LOCAL) { m_uSeedType = uSeedType; }//设置算法类型，默认为本地算法
	void SetSeed(uint16_t uSeed);//设置算法数据
	void SetSeed(uint32_t uSeed);//设置算法数据
	void SetSeed(const CBinary& binSeedData, bool bIsStringData = false);//设置算法数据
	void SetSeed(uint8_t* pSeedData, uint32_t uLen, bool bIsStringData = true);//设置算法数据
	void SetSerialNum(const string& strSerialNum);//设置设备序列号
	CBinary GetSeed()const;//获取算法数据
	void AddExtraInfo(const string& strInfoKey, const string& strInfoValue);//增加额外的扩充信息
	void Clear();//清空当前算法数据
	CBinary GetKey()const;//获取算法返回的key数据
	uint8_t GetKeyType() { return m_uKeyType; }//获取返回的Key类型，目前分三种正常应答、错误应答和未知应答

	CAlgorithmData& operator=(const CAlgorithmData& right);
	//////////////////////////////以上接口给车型开发使用////////////////////////////////////////////////////

	//////////////////////////////以下接口给系统平台使用////////////////////////////////////////////////////	
	bool SetKeyData(uint8_t* pKeyData, uint32_t uLen);//设置服务器返回的Key数据包
	const uint8_t* GetPackedData();//获取需要发送给服务器的打包后的数据
	uint32_t GetPackedDataLength() { return m_uPackedSeedLen; }//获取需要发送给服务器的打包后的数据长度
	uint8_t GetSeedType() const { return m_uSeedType; }//获取算法类型
	///////////////////////////////////////////////////////////////////////////////////////////////////////

protected:
	bool PackSeed();
	bool UnPackKey(uint8_t *pKeyData, uint32_t uLen);
	uint32_t GetExtraInfoLength();
	string GetExtraInfoData();
	uint32_t CopyHexData(uint8_t* pDesData, uint8_t* pData, uint32_t uLen);
	uint32_t CopyStringData(uint8_t* pDesData, uint8_t* pData, uint32_t uLen);
	char Hex2Char(uint8_t c);
	uint8_t Char2Hex(char c);


private:
	uint8_t m_uSeedType;//算法类型，本地的，远程的，其他的
	uint8_t m_uKeyType;//服务器返回的Key类型(正常的、错误的、未知的)
	bool m_bSeedIsStringData;//标记传进来的是不是String字符串
	uint32_t m_uId;
	uint32_t m_uSubId;

	uint32_t m_uSeedLen;//
	uint32_t m_uKeyLen;
	uint32_t m_uPackedSeedLen;
	//uint32_t m_uExtraInfoLen;

	uint8_t* m_pSeedData;
	uint8_t* m_pKeyData;
	//uint8_t* m_pKeyData;
	uint8_t* m_pPackedSeedData;
#if defined (WIN32) | defined (WIN64)
#pragma warning( disable : 4251 )
#endif	
	map<string, string> m_mapExtraInfo;
};

#endif
