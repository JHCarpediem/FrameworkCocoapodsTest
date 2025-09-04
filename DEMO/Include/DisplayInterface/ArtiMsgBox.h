/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : ArtiDiag900�汾��Ϣ��ť�ӿڶ���
* �� �� �� : sujiya 20201216
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef _ARTIMSGBOX_H_
#define _ARTIMSGBOX_H_

/*
    ��Ϣ���Ϊ4������
    1�� �̶���ť��������Ϣ��
    2�� �̶���ť�ķ�������Ϣ��
    3�� ������Ӱ�ť��������Ϣ��
    4�� ������Ӱ�ť�ķ�������Ϣ��

    ��Ϣ��ť�ڵײ��������������У��ް�ť�ķ�������Ϣ����ɳ©������תȦЧ������
*/

#include "StdShowMaco.h"

/*
    �� uButton ָ��Ϊ �̶���ťʱ�ɣ�
                DF_MB_NOBUTTON              �ް�ť�ķ�������Ϣ��
                DF_MB_YES                   Yes ��ť��������Ϣ��
                DF_MB_NO                    No ��ť��������Ϣ��
                DF_MB_YESNO                 Yes/No ��ť��������Ϣ��
                DF_MB_OK                    OK ��ť��������Ϣ��
                DF_MB_CANCEL                Cancel ��ť��������Ϣ��
                DF_MB_OKCANCEL              OK/Cancel ��ť��������Ϣ��
                DF_MB_NEXTEXIT              Next/Exit ��ť��������Ϣ��

    ȫ����Ϣ����artiShowMsgBox�����ɰ�ť��ģʽ(����ʾæ״̬)

ע�⣺�� uButton ָ��Ϊ DF_MB_NOBUTTON ʱ��artiShowMsgBox��
      ����ʾ��Ϣ��æ״̬����æ�����ԣ���תȦȦЧ����

ע�⣺�� uButton ָ��Ϊ DF_MB_NOBUTTON ʱ��artiShowMsgBox��
      ����ʾ��Ϣ��æ״̬����æ�����ԣ���תȦȦЧ����
*/
    
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBox(const string& strTitle,
    const string& strContent,
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER,
    int32_t iTimer = -1);



// �����ڶ��߳����
// thIdΪ0ʱ����Ч�� artiShowMsgBox
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBoxEx(const std::string& strTitle,
    const std::string& strContent,
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER,
    int32_t  iTimer = -1,
    uint32_t thId = 0);


// App����ָ������Ϣ���ͣ�����ָ��UI
// 
// uType ����Ϣ����
//      MBT_ERROR_DEFAULT        = 0    Ĭ�����ͣ���App�������κ�Ч��
//      MBT_ERROR_ENTER_SYS_COMM = 1    ��ϵͳʧ��
//      MBT_ERROR_EXEC_FUNC_COMM = 2    ����ִ��ʧ�� 
//                                   
//      MBT_ERROR_DATA_LOADING = 0x10,  "���ݼ����쳣�����Ժ����ԣ�"
//      MBT_ERROR_NETWORK      = 0x11,  "�����쳣�����Ժ����ԣ�"
//
//      ��ͼЧ��ʾ��ͼ
//      MBT_IGN_ON_WITH_KEY     = 0x20,  �򿪵�𿪹ض�̬Ч��ʾ��ͼ��(�����Կ�׵ĳ���)
//      MBT_IGN_ON_WITHOUT_KEY  = 0x21,  �򿪵�𿪹ض�̬Ч��ʾ��ͼ��(�����Կ�׵ĳ���)
//      MBT_IGN_OFF_WITH_KEY    = 0x22,  �رյ�𿪹ض�̬Ч��ʾ��ͼ��(�����Կ�׵ĳ���)
//      MBT_ENG_ON_WITH_BUTTON  = 0x23,  ������������̬Ч��ʾ��ͼ��(��Էǻ�еԿ�׵ĳ���)
//      MBT_MANUAL_GEAR_PARKING = 0x24,  �ֶ����յ���̬Ч��ʾ��ͼ��(����ֶ����ĳ���)
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBox(uint32_t uType, 
    const string& strTitle = "",
    const string& strContent = "",
    uint32_t uButton = DF_MB_OK,
    uint16_t uAlignType = DT_CENTER);


// ʹ����С��̽��Ŀ�Ĳ�������UI
// uTestType �ǲ�����������
// uRpm, �� uTestType Ϊ DF_TYPE_INTAKE_PRESSURE ����ѹ������������ʱ
//       uRpmΪת��
// uCountDown ����ʱ����
uint32_t _STD_SHOW_DLL_API_ artiMsgBoxActTest(const std::string& strTitle,
    const std::string& strContent, uint32_t uButton, uint32_t uTestType, uint32_t uRpm = -1, uint32_t uCountDown = -1);


// ����ADAS��̬У׼���߾�̬У׼��ʾ����
// uStep ��ADAS����
//     ACS_DYNAMIC_CALIBRATION   = 1  ����App���ƵĶ�̬У׼����
//     ACS_STATIC_CALIBRATION    = 2  ����App���Ƶľ�̬У׼����
// 
//     ACS_CALIBRATION_WHEEL_BROW_HEIGHT = 0x10 ��ü�߶�
//
// �������棬ֱ����Ҫ��ϳ������ŷ���
uint32_t _STD_SHOW_DLL_API_ artiShowAdasStep(uint32_t uStep);


// ����Ӧϵͳ��������ʾ�ľ�̬ҳ��
// 
// strSysName ��Ӧ��ϵͳ����
// 
// uType ����Ϣ����
//       MBDT_ADAS_DYNAMIC_CALI_OK_WITH_DS = 0,  ��̬У׼�ɹ������������б�
//       MBDT_ADAS_DYNAMIC_CALI_OK_ON_DS = 1,    ��̬У׼�ɹ���û���������б�
//       MBDT_ADAS_DYNAMIC_CALI_FAIL_ON_DS = 2,  ��̬У׼ʧ�ܣ�û���������б�
// 
// vctItem  �������б�� �ο�stDsReportItem�Ķ���
// 
// ���ܵķ���ֵ
//       DF_ID_ADAS_RESULT_BACK       ��������Ͻǡ����ˡ�
//       DF_ID_ADAS_RESULT_OK         ����˰�ť����ɡ�
//       DF_ID_ADAS_RESULT_REPORT     ����˰�ť�����ɱ��桱
//
uint32_t _STD_SHOW_DLL_API_ artiShowMsgBoxDs(uint32_t uType, 
    const std::string& strSysName, const std::vector<stDsReportItem>& vctItem);



// �������Ϣ�����Ϣչʾҳ�棬ÿ����Ϣ�������������
// 
// strTitle ��Ӧ�ı���
// 
// uType ����Ϣ���� eMsgGroupType
//    MGT_MSG_DEFAULT = 0, // Ĭ�����ͣ�����Ϣ����࣬
//                            �С�ȡ�����͡�ȷ����2���̶���ť
// 
// vctItem  ��Ϣ�б�ÿ����Ϣ�������������
//          struct stMsgItem
//          {
//              std::string strTitle;     // ����
//              std::string strContent;   // ����
//          };
// 
// ���ܵķ���ֵ
//       DF_ID_BACK       ��������Ͻǡ����ˡ�
//       DF_ID_CANCEL     ����˰�ť��ȡ����
//       DF_ID_OK         ����˰�ť��ȷ����
//
uint32_t _STD_SHOW_DLL_API_ artiShowMsgGroup(uint32_t uType,
    const std::string& strTitle, const std::vector<stMsgItem>& vctItem);


// ���ڴ������������������ʾ��ע��������������������������
// 
// eType        �ǽ�������
//              PBST_FUNC_HIDDEN_RUNNING = 0   
//              ��ʾ��ˢ���ع�������ִ�н��������棬�ް�ť
// 
//              PBST_FUNC_HIDDEN_READING = 1
//              ��ʾ��ʶ����Ƶ�Ԫ�����ܶ�ȡ�С����棬�ް�ť
// 
// CurPercent   ��ǰ���ȣ����� 80
// TotalPercent �ܽ��ȣ����� 100
// strTitle     ���⣬���û�б��⣬��""������PBST_FUNC_HIDDEN_RUNNINGû�б���
// strContent   ���ݣ�"����д�룬��ȴ�..."
// strTips      ��ʾ�ı������磬"�����޸��У��뱣��APP���ڵ�ǰҳ�治Ҫ�˳�"
//
// ע�⣺���������棬�������ظ���ϳ�����ϳ������ʱ�����ý�����ֵ
uint32_t _STD_SHOW_DLL_API_ artiShowProgressBar(
    eProgressBarShowType eType, 
    uint32_t CurPercent, 
    uint32_t TotalPercent,
    const std::string& strTitle = "",
    const std::string& strContent = "", 
    const std::string& strTips = ""
);


class _STD_SHOW_DLL_API_ CArtiMsgBox
{
public:
    CArtiMsgBox();
#ifdef MULTI_SYSTEM
    /* ���߳���ϱ�ţ�Ŀǰ֧�����4�߳� */
    CArtiMsgBox(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiMsgBox();

    /**********************************************************
    *    ��  �ܣ���ʼ����Ϣ��
    *    ��  ����strTitle ��Ϣ������ı�
    *            strContent ��Ϣ�������ı�
    *            uButtonType ��Ϣ��ť����
    *            uAlignType ��Ϣ���ı����뷽ʽ
    *            iTimer ��ʱ������λms
    *            ע��iTimerֻ�Ե���ť��Ϣ������ް�ť��Ϣ����Ч
    *    ����ֵ��true ��ʼ���ɹ� false ��ʼ��ʧ��
    *
    *    ע��
    *     uButtonTypeֵ�������£�
    *            DF_MB_NOBUTTON             //  �ް�ť�ķ�������Ϣ��
    *            DF_MB_YES                  //  Yes ��ť��������Ϣ��
    *            DF_MB_NO                   //  No ��ť��������Ϣ��
    *            DF_MB_YESNO                //  Yes/No ��ť��������Ϣ��
    *            DF_MB_OK                   //  OK ��ť��������Ϣ��
    *            DF_MB_CANCEL               //  Cancel ��ť��������Ϣ��
    *            DF_MB_OKCANCEL             //  OK/Cancel ��ť��������Ϣ��
    *            DF_MB_FREE | DF_MB_BLOCK   //  ���ɰ�ť��������Ϣ��
    * 
    *    ע  �⣺ ������������ɰ�ťDF_MB_FREE��Show֮ǰ��Ҫ����AddButton
    *             �������Ҫ��ť����DF_MB_NOBUTTON
    *
    **********************************************************/
    bool InitMsgBox(const string& strTitle,
        const string& strContent,
        uint32_t uButtonType = DF_MB_OK,
        uint16_t uAlignType = DT_CENTER,
        int32_t iTimer = -1);
    

    /**********************************************************
    *    ��  �ܣ�������Ϣ�����
    *    ��  ����strTitle ��Ϣ�����
    *    ����ֵ����
    **********************************************************/
    void SetTitle(const string& strTitle);

    /**********************************************************
    *    ��  �ܣ�������Ϣ���ı�����
    *    ��  ����strContent ��Ϣ������
    *    ����ֵ����
    **********************************************************/
    void SetContent(const string& strContent);


    /**********************************************************
    *    ��  �ܣ�������Ӱ�ť����ʼ����ʱ��ʹ����DF_MB_FREE���˽ӿڲ���Ч
    * 
    *    ��  ����strButtonText ��ť�ı�
    * 
    *    ����ֵ����ť��ID����ID����DelButton�ӿڵĲ���
    *            ���ܵķ���ֵ��
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *                         DF_ID_FREEBTN_2
    *                         DF_ID_FREEBTN_3
    *                         DF_ID_FREEBTN_XX
    **********************************************************/
    void AddButton(const string& strButtonText);
    uint32_t AddButtonEx(const string& strButtonText);


    /**********************************************************
    *    ��  �ܣ�ɾ�����ɰ�ť����ʼ����ʱ��ʹ����DF_MB_FREE���˽ӿڲ���Ч
    *
    *    ��  ����uButtonId  ��ť��ID
    * 
    *            uButtonId ����ֵ�� DF_ID_FREEBTN_0
    *                               DF_ID_FREEBTN_1
    *                               DF_ID_FREEBTN_2
    *                               DF_ID_FREEBTN_3
    *                               DF_ID_FREEBTN_XX
    *
    *    ����ֵ��true  ������ӵİ�ťɾ���ɹ�
    *            false ������ӵİ�ťɾ��ʧ��
    **********************************************************/
    bool DelButton(uint32_t uButtonId);


    /**********************************************************
    *    ��  �ܣ�������Ϣ��ť����
    *    ��  ����uButtonTyp ��ť����
    *    ����ֵ����
    **********************************************************/
    void SetButtonType(uint32_t uButtonTyp);


    /******************************************************************
    *    ��  �ܣ������Զ��尴ť��״̬
    * 
    *    ��  ����uIndex      �Զ��尴ť�±�
    *            bStatus     �Զ��尴ť��״̬
    * 
    *                  DF_ST_BTN_ENABLE    ��ť״̬Ϊ�ɼ����ҿɵ��
    *                  DF_ST_BTN_DISABLE   ��ť״̬Ϊ�ɼ������ɵ��
    *                  DF_ST_BTN_UNVISIBLE ��ť״̬Ϊ���ɼ�������
    * 
    *    ����ֵ����
    *            ���û�е��ô˽ӿڣ�Ĭ��Ϊ��ť״̬Ϊ�ɼ����ҿɵ��
    ********************************************************************/
    void SetButtonStatus(uint16_t uIndex, uint32_t uStatus);


    /**********************************************************
    *    ��  �ܣ�������Ϣ��ť�ı�
    *    ��  ����uIndex ��ť�±�
    *            strButtonText��Ӧ�±갴ť���ı���
    *    ����ֵ����
    **********************************************************/
    void SetButtonText(uint16_t uIndex, const string& strButtonText);


    /**********************************************************
    *    ��  �ܣ���ȡ��Ϣ��̶���ť�ı�
    * 
    *    ��  ����uButtonID ��ť����
    *            DF_TEXT_ID_OK
    *            DF_TEXT_ID_YES
    *            DF_TEXT_ID_CANCEL
    *            DF_TEXT_ID_NO
    *            DF_TEXT_ID_BACK
    *            DF_TEXT_ID_EXIT
    *            DF_TEXT_ID_HELP
    *            DF_TEXT_ID_CLEAR_DTC
    *            DF_TEXT_ID_REPORT
    *            DF_TEXT_ID_NEXT
    * 
    *    ����ֵ����
    **********************************************************/
    std::string GetButtonText(uint32_t uButtonID = DF_TEXT_ID_OK);


    /**********************************************************
    *    ��  �ܣ�������Ϣ�����ݶ��뷽ʽ
    *    ��  ����uAlignType ���뷽ʽ
    *    ����ֵ����
    **********************************************************/
    void SetAlignType(uint16_t uAlignType);

    /**********************************************************
    *    ��  �ܣ����ö�ʱ��
    *    ��  ������ʱ��ʱ�䣬��λms
    *    ����ֵ����
    **********************************************************/
    void SetTimer(int32_t iTimer);

    /**********************************************************
    *    ��  �ܣ�������Ϣ��æ״̬�Ƿ���ʾ
    *    ��  ����bIsVisible = true; ��ʾ��Ϣ��æ״̬����ɳ©��������
    *            bIsVisible = false; ����ʾ��ʾ��Ϣ��æ״̬
    *    ����ֵ����
    **********************************************************/
    void SetBusyVisible(bool bIsVisible);

    /**********************************************************
    *    ��  �ܣ����ý������Ƿ���ʾ
    *    ��  ����bIsVisible = true;   ��ʾ������
    *            bIsVisible = false; ����ʾ������
    *    ����ֵ����
    **********************************************************/
    void SetProcessBarVisible(bool bIsVisible);

    /**********************************************************
    *    ��  �ܣ����ý������Ľ���
    *    ��  ����iCurPercent��   ��ǰ����
    *            iTotalPercent���ܽ���
    *    ����ֵ����
    **********************************************************/
    void SetProgressBarPercent(int32_t iCurPercent, int32_t iTotalPercent);


    /*************************************************************************
    *    ��  �ܣ���ʾ��Ϣ��
    *    ��  ������
    *    ����ֵ��uint32_t ��ť����ֵ
    *
    *            �̶���ť���ع̶���ť����ֵ��
    *            �Զ��尴ť�����Զ��尴ť����ֵ
    *
    *    ˵��
    *        1. �ο� �̶���ť����ֵ
    *           ���磬 DF_ID_OK �û������ OK ��ť
    *
    *        2. �ο� ��Ϣ�����ɰ�ť����ֵ
    *           �а������������û�ѡ��ť DF_ID_FREEBTN_XXX
    *           ���磺���ص�ֵ�� DF_ID_FREEBTN_3(0x03000103) 
    *                  �������˵��ĸ����ɰ�ť
    *
    *        3. ���û�����Ϊ������Ϣ�򣬵ȴ��û���������ѡ��ť;
    *        
    *        4. DF_ID_NOKEY ������Ϊ��������Ϣ���޲������� ;
    *           ���磬�ڶ��������а�ť��������Ϣ����Ҫ�̶���ָ����������Զ�����
    **************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
