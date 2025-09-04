/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ArtiDiag900������ؼ��ӿڶ���
* �� �� �� : sujiya 20201216
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef _ARTITROUBLE_H_
#define _ARTITROUBLE_H_
#include "StdInclude.h"
#include "StdShowMaco.h"

// ��������棬����List �����������������֡��Ϣ���������������Ȳ���

class _STD_SHOW_DLL_API_ CArtiTrouble
{
public:
    CArtiTrouble();
#ifdef MULTI_SYSTEM
    CArtiTrouble(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiTrouble();



    /**********************************************************
    *    ��  �ܣ���ʼ��������ؼ���ͬʱ���ñ����ı�
    *    ��  ����strTitle �����ı�
    *    ����ֵ��true ��ʼ���ɹ� false ��ʼ��ʧ��
    **********************************************************/
    bool InitTitle(const string& strTitle);



    /**********************************************************
    *    ��  �ܣ���ӹ�����
    *    ��  ����strTroubleCode �������
    *            strTroubleDesc ����������
    *            strTroubleState ������״̬
    *    ����ֵ����
    **********************************************************/
    void AddItem(const string& strTroubleCode,
        const string& strTroubleDesc,
        const string& strTroubleStatus,
        const string& strTroubleHelp = "");


    /**********************************************************
    *    ��  �ܣ���ӹ�����
    * 
    *    ��  ����stDtcReportItemEx nodeItem ������ڵ�
    *            nodeItem �ڵ� �ṹ����
    *            struct stDtcNodeEx
    *            {
    *                std::string strCode;        // ���ϴ���
    *                std::string strDescription; // ����������
    *                std::string strStatus;      // ������״̬
    *                uint32_t    uStatus;        // ������״̬
    *            };
    * 
    *            strTroubleHelp �����������Ϣ
    * 
    *    ����ֵ����
    **********************************************************/
    void AddItemEx(const stDtcNodeEx& nodeItem, const string& strTroubleHelp = "");



    /**********************************************************
    *    ��  �ܣ�����ָ��������İ�����Ϣ
    *    ��  ����uIndex ָ���Ĺ�����
    *            strToubleHelp �����������Ϣ
    *    ����ֵ����
    **********************************************************/
    void SetItemHelp(uint16_t uIndex, const string& strToubleHelp);
    


    /**********************************************************
    *    ��  �ܣ�����ָ���������߹��ϵƵ�״̬
    *    ��  ����uIndex ָ���Ĺ�����
    *            bIsShow=true ��ʾһ�������Ĺ��ϵ�
    *            bIsShow=false ����ʾ���ϵ�
    *    ����ֵ����
    **********************************************************/
    void SetMILStatus(uint16_t uIndex, bool bIsShow = true);



    /**********************************************************
    *    ��  �ܣ�����ָ���������߶���֡��־��״̬
    *    ��  ����uIndex ָ���Ĺ�����
    *            bIsShow=true ��ʾ����֡��־
    *            bIsShow=false ����ʾ����֡��־
    *    ����ֵ����
    **********************************************************/
    void SetFreezeStatus(uint16_t uIndex, bool bIsShow = true);



    /**********************************************************
    *    ��  �ܣ��������밴ť�Ƿ���ʾ
    *    ��  ����bIsVisible=true  ��ʾ���밴ť
    *            bIsVisible=false �������밴ť
    *    ����ֵ����
    **********************************************************/
    void SetCdtcButtonVisible(bool bIsVisible = true);



    /*********************************************************************************
    *    ��  �ܣ�����ά��ָ������Ҫ����Ϣ
    * 
    *    ��  ����vctDtcInfo    ά������������Ϣ����
    *            
    *             stRepairInfoItem���͵�Ԫ��
    *             eRepairInfoType eType          ά������������Ϣ������
    *                                            ���� RIT_DTC_CODE����ʾ�� "���������"
    *             std::string     strValue       ʵ�ʵ��ַ���ֵ
    *                                            ���統 eType = RIT_VINʱ
    *                                            strValueΪ "KMHSH81DX9U478798"
    * 
    *    ����ֵ������ʧ��
    *            ���統����Ԫ��Ϊ��ʱ������false
    *            ���統�����в�����"���������"������false
    *********************************************************************************/
    bool SetRepairManualInfo(const std::vector<stRepairInfoItem>& vctDtcInfo);



    /**********************************************************
    *    ��  �ܣ���ʾ������
    *    ��  ������
    *    ����ֵ��uint32_t ������水������ֵ
    *           ����������֡�����룬���أ����棬"ά������"
    *    
    *     ���ܴ������·��أ�
    *                        DF_ID_TROUBLE_BACK
    *                        DF_ID_TROUBLE_CLEAR
    *                        DF_ID_TROUBLE_REPORT
    *                        DF_ID_TROUBLE_0
    *                        DF_ID_TROUBLE_1
    *                        ......
    *                        DF_ID_TROUBLE_X
    * 
    *                        ά�����ϰ�ť
    *                         DF_ID_REPAIR_MANUAL_0
    *                         DF_ID_REPAIR_MANUAL_1
    *                         DF_ID_REPAIR_MANUAL_2
    *                         DF_ID_REPAIR_MANUAL_3
    *                         DF_ID_REPAIR_MANUAL_4
    *                         DF_ID_REPAIR_MANUAL_XXXX
    **********************************************************/
    uint32_t Show();


private:
    void*        m_pData;
};

#endif
