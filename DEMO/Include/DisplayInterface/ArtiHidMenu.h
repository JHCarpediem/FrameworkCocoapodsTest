/*******************************************************************************
* Copyright (C), 2024~ , TOPDON Technology Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : CarPal Guru ˢ���� �������˵�
* �� �� �� : sujiya 20201216
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef __ARTI_HID_MENU_H__
#define __ARTI_HID_MENU_H__
#include "StdInclude.h"
#include "StdShowMaco.h"

// ˢ���� �������˵�����һ�������˵���һ���˵�����¼���ϲ��ɼ�
// 
// Show Ϊ�����ӿڣ����ض�Ӧ�Ķ����˵����
// 
// �˽����ް�ť

class _STD_SHOW_DLL_API_ CArtiHidMenu
{
public:
    CArtiHidMenu();
#ifdef MULTI_SYSTEM
    CArtiHidMenu(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiHidMenu();


    /****************************************************************************************
    *    ��  �ܣ���ʼ�������˵����⣬��ˢ���ع��ܲ˵�����ı��⣬Ҳ����һ���˵�����ı��⣬
    *            �ڶ�������ı����ǵ�һ����Ӧ�Ĳ˵�����
    *
    *    ��  ����strTitle    �����ı�
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ��ʼ���ɹ�����1
    *            ��������ֵ����������
    *
    *    ˵  �������ô˽ӿں��൱�����³�ʼ���������ӿ����ٴε��òŻ���Ч
    ****************************************************************************************/
    uint32_t InitTitle(const string& strTitle);


    /****************************************************************************************
    *    ��  �ܣ��ڽ��涥�����ù���ִ�е��ı���ʾ
    *
    *    ��  ����strTipsContent   ��Ӧ���ı���ʾ����
    *                             ���strTipsContentΪ�մ�������ʾ��ʾ����
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ���óɹ�����1
    *            ��������ֵ����������
    *
    *    ˵  �������û�����ã�û�е��ô˽ӿڣ�������ʾ��ʾ����
    *            ���strTipsContentΪ�մ�����ȡ��֮ǰ�Ľӿ����ã���û�ж����ı���ʾ
    ****************************************************************************************/
    uint32_t SetTipsOnTop(const string& strTipsContent);


    /****************************************************************************************
    *    ��  �ܣ�����Ĭ�Ͻ���ڶ����˵�����
    *
    *    ��  ����Index   ��Ӧ�ĵ�һ���˵���ƫ��
    *                    ���index�Ĵ�С����һ���˵���������������ö����˵�����
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ���óɹ����ض�Ӧ��index
    *            ����ʧ�ܣ�����-1
    *            ��������ֵ����������
    *
    *    ˵  �������û�����ã�û�е��ô˽ӿڣ�����Ĭ�Ͻ���һ���˵�����
    ****************************************************************************************/
    uint32_t SetDefaultLevel2nd(uint32_t Index);


    /****************************************************************************************
    *    ��  �ܣ���Ӷ�Ӧ�Ĺ��ܴ���˵���������ӹ����б�
    *
    *    ��  ����Item    stHiddenItem�ṹ�Ĳ˵���
    * 
    *                    stHiddenItem�ṹ�嶨�壺
    *                    struct stHiddenItem
    *                    {
    *                        std::string strName;
    *                        std::string strIconPath;
    *                        std::vector<stHiddenNode> vctNodes;
    *                    };
    *                    struct stHiddenNode
    *                    {
    *                        std::string strName;
    *                        std::string strCurValue;
    *                        uint32_t    uCurStatus;
    *                        std::string strFuncId;
    *                        std::string strIconPath;
    *                    };
    * 
    *                   ���ڹ��ܴ���˵��strName����Ϊ��
    * 
    *                   ���ڹ�������˵����ͼ�꣬��ΪApp�洢�˵�ͼƬʱ��
    *                   strIconPath ΪeHiddenMenuMask��ö���ִ�ֵ������
    *                   "HMM_CHASSIS_ENGINE_CLASS"  ��ʾ HMM_CHASSIS_ENGINE_CLASS   = (1 << 0) ��ͼ��
    *                   "HMM_DRIVING_STEER_CLASS"   ��ʾ HMM_DRIVING_STEER_CLASS    = (1 << 1) ��ͼ��
    *                   "HMM_AC_CLASS"              ��ʾ HMM_AC_CLASS               = (1 << 2) ��ͼ��
    *                   "HMM_IM_CLASS"              ��ʾ HMM_IM_CLASS               = (1 << 3) ��ͼ��
    *                   "HMM_LIGHTS_CLASS"          ��ʾ HMM_LIGHTS_CLASS           = (1 << 4) ��ͼ��
    *                   "HMM_LOCK_CLASS"            ��ʾ HMM_LOCK_CLASS             = (1 << 5) ��ͼ��
    *                   "HMM_MIRRORS_CLASS"         ��ʾ HMM_MIRRORS_CLASS          = (1 << 6) ��ͼ��
    *                   "HMM_DOOR_CLASS"            ��ʾ HMM_DOOR_CLASS             = (1 << 7) ��ͼ��
    *                   "HMM_WIPERS_CLASS"          ��ʾ HMM_WIPERS_CLASS           = (1 << 8) ��ͼ��
    *                   "HMM_SEATS_CLASS"           ��ʾ HMM_SEATS_CLASS            = (1 << 9) ��ͼ��
    *                   "HMM_WARNING_OTHER_CLASS"   ��ʾ HMM_WARNING_OTHER_CLASS    = (1 << 10)��ͼ��
    * 
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ��ӳɹ����ض�Ӧ�˵���ƫ�ƣ���0��ʼ��
    *
    *    ˵  �������û������κβ˵������ʾһ���ս���
    ****************************************************************************************/
    uint32_t AddItem(const stHiddenItem& Item);


    /****************************************************************************************
    *    ��  �ܣ��޸Ķ�Ӧ�ڵ㹦����ĵ�ǰֵ
    *
    *    ��  ����L1               һ���˵�ƫ��
    *            L2               �����˵�ƫ��
    * 
    *            uCurStatus       ��Ӧ�Ĺ��ܵ�ǰֵ������HNS_FUNC_HIDDEN_OK
    *                             ����HNS_FUNC_HIDDEN_FAILED
    * 
    *            strCurValue      ��Ӧ�Ĺ��ܵ�ǰֵ�����硰�رա�
    * 
    *            ���L1��L2ƫ�Ƴ�����Χ�������޸�
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            �޸ĳɹ����ض�Ӧ�˵���ƫ�ƣ�ƫ�ƹ����Show���ع���һ��
    *            ���磬L1 = 1, L2 = 2���޸ĳɹ����� 0x00010002
    *            �޸�ʧ�ܣ�����-1������L1��L2ƫ�Ƴ�����Χ
    *            ����ֵ����������
    *
    *    ˵  ��������
    ****************************************************************************************/
    uint32_t SetNodeCurrVal(uint32_t L1, uint32_t L2, uint32_t uCurStatus, const std::string& strCurValue);


    /****************************************************************************************
    *    ��  �ܣ���ʾˢ���ع��ܴ���˵��������ӿ�
    * 
    *    ��  ������
    * 
    *    ����ֵ��uint32_t ����������˵�����ֵ
    * 
    *            һ���˵�ƫ��Ϊ��16λ�������˵�ƫ��Ϊ��16λ
    * 
    *            �������û�ѡ���˹��ܴ���ĵ�2�ƫ��1�����ƹ����á��µĵ�1�ƫ��0���ӹ���
    *                  ���ռ��г��ơ����򷵻�ֵΪ 0x00010000
    * 
    *            �������û�ѡ���˹��ܴ���ĵ�3�ƫ��2�����������á��µĵ�2�ƫ��1���ӹ���
    *                  ���ߵ͵��ڡ����򷵻�ֵΪ 0x00020001
    * 
    *    ˵  ����
    *            �����ӿ�
    *            �����޹̶���ť��������ӵİ�ť
    *            �����������Ͻǵķ��ذ�ť������DF_ID_BACK
    ****************************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif // __ARTI_HID_MENU_H__
