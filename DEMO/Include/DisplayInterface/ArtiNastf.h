/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ArtiDiag900 NASTF �ؼ�
* �� �� �� : sujiya 20201216
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef __ARTI_NASTF_H__
#define __ARTI_NASTF_H__

#include "StdInclude.h"
#include "StdShowMaco.h"


// NASTF������ȫ�����ϴ��ӿڽ��棨VSP-ID������棩
// 
// ��������NASTFҪ��ά�޵ĳ������ϱ�������ȫ���ܣ�����4����
// �� Add a key
// �� All keys lost
// �� Immobilizer functions
// �� Any other process that the OE determines to be security related
// �ϱ���Ҫ�û�����NASTF��VSP-ID��������ȫרҵ��Ա��
// 
// 1���������ƽ�����NASTF���ܣ�NASTFƽ̨Ҫ����������ع���ʱ���ϴ���Ӧ����������
// 2�����Ӧ����Show֮ǰ��Ҫ�ж��Ƿ���Ҫ���������������ϱ�
// 3�����App���ز���Ҫ������������ŷ����������ҪShow�˽���
// 
// 
class _STD_SHOW_DLL_API_ CArtiNastfVsp
{
public:
    // 1 Add a Key
    // 2 All Keys Lost
    // 3 Immobilizer functions
    // 4 Other
    enum
    {
        SEC_FUNC_TYPE_ADD_A_KEY     = 0,    // Add a key
        SEC_FUNC_TYPE_ALL_KEY_LOST  = 1,    // All keys lost
        SEC_FUNC_TYPE_IMMO          = 2,    // Immobilizer functions

        SEC_FUNC_TYPE_OTHER         = 0x10, // Others
    };

    enum
    {
        NOT_VALIDATION_SHOW  = 0,    // ����ҪVSP-ID������棬����ϳ�����Ҫ���� Show
        NEED_VALIDATION_SHOW = 1,    // ��ҪVSP-ID������棬����ϳ�����Ҫ���� Show
        NEED_OFFLINE_WARNING = 2,    // ����������δ�ϱ�������ҪVSP-ID������棬
                                     // ����ϳ�����Ҫ���� Show��������Ҫ��msgBox���߾���
    };

public:
    CArtiNastfVsp();
    ~CArtiNastfVsp();

    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ���ʼ�� VSP ��֤������ؼ�

      ����˵����strTitle  ��ǰ�����壬App��������


      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT�� -16����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_APP_CURRENT_NOT_SUPPORT_FUNCTION�� -17����ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����

                ���óɹ�����0
                ��������ֵ����������

      ˵    ������ϳ���Ҳ���Բ����ô˽ӿڣ�ֱ�ӵ��� GetNeedShow �ӿں��ж��Ƿ���ҪShow
    -------------------------------------------------------------------------------------------------*/
    uint32_t InitTitle(const std::string &strTitle); 


    /*-------------------------------------------------------------------------------------------------
      ��    �ܣ�ѯ���Ƿ���Ҫ��ʾNASTF VSP����֤���������

      ����˵����FunctionsType  ͨ�������Ϊ�ĸ�����
                               SEC_FUNC_TYPE_ADD_A_KEY      Add a key
                               SEC_FUNC_TYPE_ALL_KEY_LOST   All keys lost
                               SEC_FUNC_TYPE_IMMO           Immobilizer functions
                               SEC_FUNC_TYPE_OTHER          Others

      ����ֵ��  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT�� -16����ǰAPP�汾��û�д˽ӿ�
                DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����

                DF_APP_CURRENT_NOT_SUPPORT_FUNCTION�� -17����ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����

                ���� NOT_VALIDATION_SHOW�� ����Ҫ����Show��������ŷ�����򣬷��� 0
                ���� NEED_VALIDATION_SHOW�� ��Ҫ����Show�� �����ڱ������򣬷��� 1
                ���� NEED_OFFLINE_WARNING�� ����Ҫ����Show��������Ҫ��msgBox���߾��棨����������δ�ϱ���
                ��������ֵ����������

      ˵    ������
    -------------------------------------------------------------------------------------------------*/
    uint32_t GetNeedShow(uint32_t FunctionsType);


    /*-------------------------------------------------------------------------------------------------
       ��  �ܣ���ʾNASTF VSP����֤���������
    
       ��  ������
    
       ����ֵ��uint32_t ������水������ֵ
               ���ܴ��ڵķ���ֵ��
                           DF_ID_OK
    
       ˵  �����˽ӿ�Ϊ�����ӿ�
    ----------------------------------------------------------------------------------------------------*/
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_NASTF_H__
