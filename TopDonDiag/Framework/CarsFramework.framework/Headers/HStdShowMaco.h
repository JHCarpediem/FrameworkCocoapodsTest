#ifndef _STD_SHOW_MACO_H_
#define _STD_SHOW_MACO_H_

//#include "StdInclude.h"

/*-----------------------------------------------------------------------------
˵    �����������нӿڣ����Appû��ʵ�ִ˽ӿڹ��ܣ���JNI�����ҵ�Apk�ĺ������壬
          ����App/Apk ȴû��ʵ�ִ˽ӿڹ��ܣ���App��֧�ֵ�ǰ���ܣ������ش�ֵ
-----------------------------------------------------------------------------*/
#define DF_APP_CURRENT_NOT_SUPPORT_FUNCTION     (0xFFFFFFEF)    // -17

/*-----------------------------------------------------------------------------
˵    �����������нӿڣ����APPû��ʵ�ִ˽ӿڣ���JNI�Ҳ���APK�ĺ������壬����
          iOS��Appû��ע��ӿڵĻص������������ش�ֵ
-----------------------------------------------------------------------------*/
#define DF_FUNCTION_APP_CURRENT_NOT_SUPPORT     (0xFFFFFFF0)    // -16

/*-----------------------------------------------------------------------------
˵    �����������нӿڣ����APPû�д˶���ʵ�������ش�ֵ
-----------------------------------------------------------------------------*/
#define DF_FUNCTION_APP_OBJ_NOT_CONSTRUCTOR     (0xFFFFFFF1)    // -15

/*-----------------------------------------------------------------------------
˵    �����������нӿڣ����APPû�д˶���ʵ�������ش�ֵ
-----------------------------------------------------------------------------*/
#define STR_FUNCTION_APP_OBJ_NOT_CONSTRUCTOR     ("object not construct!")

#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)


#if !defined(_WIN32)&!defined (_WIN64)
#define DT_TOP                      0x00000000
#define DT_LEFT                     0x00000000
#define DT_CENTER                   0x00000001
#define DT_RIGHT                    0x00000002
#define DT_BOTTOM                   0x00000008
#endif


#define DT_LEFT_TOP                 0x00000010  // ���Ͻ�
#define DT_RIGHT_TOP                0x00000011  // ���Ͻ�
#define DT_LEFT_BOTTOM              0x00000012  // ���½�
#define DT_RIGHT_BOTTOM             0x00000013  // ���½�


/*-----------------------------------------------------------------------------
˵    ������������/������ ������������ʾ��
-----------------------------------------------------------------------------*/
#define DF_MB_NONBLOCK                          0x0000
#define DF_MB_BLOCK                             0x0100


/*-----------------------------------------------------------------------------
˵    �����̶���ť
-----------------------------------------------------------------------------*/
#define DF_MB_NOBUTTON                       0x0000   //  �ް�ť�ķ�������Ϣ��
#define DF_MB_YES                            0x0101   //  Yes ��ť��������Ϣ��
#define DF_MB_NO                             0x0102   //  No ��ť��������Ϣ��
#define DF_MB_YESNO                          0x0103   //  Yes/No ��ť��������Ϣ��
#define DF_MB_OK                             0x0104   //  OK ��ť��������Ϣ��
#define DF_MB_CANCEL                         0x0108   //  Cancel ��ť��������Ϣ��
#define DF_MB_OKCANCEL                       0x010C   //  OK/Cancel ��ť��������Ϣ��
#define DF_MB_NEXTEXIT                       0x010D   //  Next/Exit ��ť��������Ϣ��


/*-----------------------------------------------------------------------------
˵    �������ɰ�ť���أ�������Ӱ�ť��
-----------------------------------------------------------------------------*/
#define DF_MB_FREE                            0x0200  // ���ɰ�ť�ķ�������Ϣ��


/*-----------------------------------------------------------------------------
˵    �����̶���ť����ֵ
-----------------------------------------------------------------------------*/
#define DF_ID_OK                             0x00000000
#define DF_ID_YES                            0x00000000
#define DF_ID_CANCEL                         0xFFFFFFFF
#define DF_ID_NO                             0xFFFFFFFF
#define DF_ID_BACK                           0xFFFFFFFF
#define DF_ID_EXIT                           0xFFFFFFFF
#define DF_ID_HELP                           0x80000001
#define DF_ID_CLEAR_DTC                      0x80000002   // ������������
#define DF_ID_REPORT                         0x80000003
#define DF_ID_NEXT                           0x80000010   // ��һ��
#define DF_ID_PREV                           0x80000011   // ǰһ��
#define DF_ID_RESTORE                        0x80000020   // �ָ�����
#define DF_ID_SFD_THIRD                      0x80000030   // VW���ؽ������棬����������������ֵ
                                                          // ����artiShowSpecial�ӿڵİ�ť����ֵ


/*-----------------------------------------------------------------------------
˵    �������ɰ�ť����ֵ�����߱�ţ���ʹ���ڸ��ֿ�������Ӱ�ť�Ŀؼ�
-----------------------------------------------------------------------------*/
#define DF_ID_FREEBTN_0                      0x00000100
#define DF_ID_FREEBTN_1                      0x00000101
#define DF_ID_FREEBTN_2                      0x00000102
#define DF_ID_FREEBTN_3                      0x00000103
//#define DF_ID_FREEBTN_XX                   0x000001XX //һ��FF�����ɰ�ť


#define DF_ST_BTN_ENABLE                     ((uint32_t)0x00)     // ��ť״̬Ϊ�ɼ����ҿɵ��
#define DF_ST_BTN_DISABLE                    ((uint32_t)0x01)     // ��ť״̬Ϊ�ɼ������ɵ��
#define DF_ST_BTN_UNVISIBLE                  ((uint32_t)0x02)     // ��ť״̬Ϊ���ɼ�������



/*-----------------------------------------------------------------------------
˵    ������ȡ�̶���ť�ı��ĺ�ֵID�����ڽӿ� GetButtonText
-----------------------------------------------------------------------------*/
#define DF_TEXT_ID_OK                             0x00000001
#define DF_TEXT_ID_YES                            0x00000002
#define DF_TEXT_ID_CANCEL                         0x00000003
#define DF_TEXT_ID_NO                             0x00000004
#define DF_TEXT_ID_BACK                           0x00000005
#define DF_TEXT_ID_EXIT                           0x00000006
#define DF_TEXT_ID_HELP                           0x00000007
#define DF_TEXT_ID_CLEAR_DTC                      0x00000008
#define DF_TEXT_ID_REPORT                         0x00000009
#define DF_TEXT_ID_NEXT                           0x0000000A
#define DF_TEXT_ID_PREV                           0x0000000B



/*-----------------------------------------------------------------------------
˵    �����޲�������ֵ
-----------------------------------------------------------------------------*/
#define DF_ID_NOKEY                               0x04000000


/*-----------------------------------------------------------------------------
˵    ����û��ѡ������һ�з���ֵ
          ������Ӧ�ó��������SetSelectedType�ӿڣ�������ΪITEM_SELECT_DISABLED
          ����û�е���SetDefaultSelectedRow�������
          CArtiList��Show����ֵΪû��ѡ������һ��DF_LIST_LINE_NONE
          ��GetSelectedRowҲ����û��ѡ������һ��DF_LIST_LINE_NONE
-----------------------------------------------------------------------------*/
#define DF_LIST_LINE_NONE                         0xFFFF


////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    ����CArtiSystem ��ť����ֵ�� Show �İ�ť����ֵ
          ��ť������һ��ɨ�裬һ�����룬��������ϱ��棬����
          ���磬�����һ��ɨ�衱���� DF_ID_START
-----------------------------------------------------------------------------*/
#define DF_ID_SYS_START                       0x80000004
#define DF_ID_SYS_STOP                        0x80000005
#define DF_ID_SYS_ERASE                       DF_ID_CLEAR_DTC
#define DF_ID_SYS_REPORT                      DF_ID_REPORT
#define DF_ID_SYS_HELP                        DF_ID_HELP
#define DF_ID_SYS_BACK                        DF_ID_BACK
#define DF_ID_SYS_NOKEY                       DF_ID_NOKEY



/*-----------------------------------------------------------------------------
˵    ���� CArtiSystem ҳ���б����ֵ(Show)����ʾ������Ǹ�ϵͳ
-----------------------------------------------------------------------------*/
#define DF_ID_SYS_0                         0x00000000
#define DF_ID_SYS_1                         0x00000001
#define DF_ID_SYS_3                         0x00000003
//...
//#define DF_ID_SYS_X                       0x0000XXXX


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem ϵͳɨ��˵��£����ADAS��(Show)����ֵ
#define DF_ID_SYS_ADAS_0                    0x01000000      // ����˵�0��ϵͳ��ADAS
#define DF_ID_SYS_ADAS_1                    0x01000001      // ����˵�1��ϵͳ��ADAS
#define DF_ID_SYS_ADAS_2                    0x01000002      // ����˵�2��ϵͳ��ADAS
#define DF_ID_SYS_ADAS_3                    0x01000003      // ����˵�3��ϵͳ��ADAS
//...
//#define DF_ID_SYS_ADAS_X
#define DF_ID_SYS_ADAS_MASK                 0x0000FFFF
#define DF_SYS_GET_ADAS_SYS_NO(x)           (((x) & DF_ID_SYS_DTC_MASK))   // ϵͳ���


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem ϵͳɨ��˵��£�������ٲ鿴�����룬(Show)����ֵ
#define DF_ID_SYS_DTC_0                     0x00100000      // ����˵�0��ϵͳ�Ĺ�������������ť
#define DF_ID_SYS_DTC_1                     0x00100001      // ����˵�1��ϵͳ�Ĺ�������������ť
#define DF_ID_SYS_DTC_2                     0x00100002      // ����˵�2��ϵͳ�Ĺ�������������ť
#define DF_ID_SYS_DTC_3                     0x00100003      // ����˵�3��ϵͳ�Ĺ�������������ť
//...
//#define DF_ID_SYS_DTC_X
#define DF_ID_SYS_DTC_MASK                  0x0000FFFF
#define DF_SYS_GET_DTC_SYS_NO(x)            (((x) & DF_ID_SYS_DTC_MASK))   // ϵͳ���


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem ���߳�ϵͳ��ϣ�������ĸ�ϵͳ
#define DF_ID_SYS_TH1_0                     0x00010000      // ���������Ϊ0��ϵͳ����1���߳�
#define DF_ID_SYS_TH1_1                     0x00010001      // ���������Ϊ1��ϵͳ����1���߳�
#define DF_ID_SYS_TH1_2                     0x00010002      // ���������Ϊ2��ϵͳ����1���߳�
//...
//#define DF_ID_SYS_TH1_X                   0x0001000X
#define DF_ID_SYS_TH2_1                     0x00020001      // ���������Ϊ1��ϵͳ����2���߳�
#define DF_ID_SYS_TH3_2                     0x00030002      // ���������Ϊ2��ϵͳ����3���߳�
#define DF_ID_SYS_TH4_3                     0x00040003      // ���������Ϊ3��ϵͳ����4���߳�
//...
//#define DF_ID_SYS_TH2_X
//#define DF_ID_SYS_TH3_X
//#define DF_ID_SYS_TH4_X
#define DF_ID_SYS_TH_MASK                   0x000F0000
#define DF_SYS_GET_TH_NO(x)                 (((x) & DF_ID_SYS_TH_MASK) >> 16)   // �̱߳��



////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem ϵͳɨ������
#define DF_SST_TYPE_DEFAULT                0        // Ĭ��ϵͳ����
#define DF_SST_TYPE_ADAS                   1        // ADASϵͳɨ������



/*-----------------------------------------------------------------------------
˵    ����CArtiSystem ϵͳ״̬�꣬ uResult ָ��ϵͳ������ս��
          ������void SetItemResult(uint16_t uIndex, uint32_t uResult);
-----------------------------------------------------------------------------*/
#define DF_ENUM_UNKNOWN                     0x10000000  //δ֪
#define DF_ENUM_NOTEXIST                    0x20000000  //������
#define DF_ENUM_NOTSUPPORT                  0x30000000  //��֧��
#define DF_ENUM_NODTC                       0x40000000  //����
#define DF_ENUM_DTCNUM                      0x80000000  //����
//DF_ENUM_DTCNUM + 1 Ϊ��1��������



/*-----------------------------------------------------------------------------
˵    ����CArtiSystem ADASϵͳ״̬�꣬ uAdasResult ָ��ADASϵͳ��Ľ��
          ������void SetItemAdas(uint16_t uIndex, uint32_t uAdasResult);
-----------------------------------------------------------------------------*/
#define DF_ENUM_NO_ADAS                     0  // ������ADAS
#define DF_ENUM_ADAS_EXIST                  1  // ����ADAS




/*-----------------------------------------------------------------------------
˵    ����CArtiSystem ϵͳɨ��״̬�꣬���� SetScanStatus
-----------------------------------------------------------------------------*/
#define DF_SYS_SCAN_START                        0  // ��ʼɨ��
#define DF_SYS_SCAN_PAUSE                        1  // ��ͣɨ��
#define DF_SYS_SCAN_FINISH                       2  // ɨ�����


/*-----------------------------------------------------------------------------
˵    ����CArtiSystem ϵͳɨ��״̬�꣬���� SetClearStatus
-----------------------------------------------------------------------------*/
#define DF_SYS_CLEAR_START                       0  // һ�����뿪ʼ
#define DF_SYS_CLEAR_FINISH                      1  // һ���������




////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    ��������� Show ����ֵ�������� CArtiInput ��
          ���ְ�ť���ͣ�ȷ����ȡ�����Զ��尴��
-----------------------------------------------------------------------------*/
#define DF_ID_INPUT_OK                      DF_ID_OK
#define DF_ID_INPUT_CANCLE                  DF_ID_CANCEL

#define DF_ID_INPUT_0                       DF_ID_FREEBTN_0
#define DF_ID_INPUT_1                       DF_ID_FREEBTN_1
#define DF_ID_INPUT_2                       DF_ID_FREEBTN_2
#define DF_ID_INPUT_3                       DF_ID_FREEBTN_3
//...
//#define DF_ID_INPUT_X                     DF_ID_FREEBTN_X





////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    �����˵��� Show ����ֵ�������� CArtiMenu ��
-----------------------------------------------------------------------------*/
#define DF_ID_MENU_BACK                     DF_ID_BACK
#define DF_ID_MENU_HELP                     DF_ID_HELP

#define DF_ID_MENU_TREE                     0x80000000  // �˵������֣��ݶ�

#define DF_ID_MENU                          0x00000000
#define DF_ID_MENU_0                        0x00000000
#define DF_ID_MENU_1                        0x00000001
#define DF_ID_MENU_2                        0x00000002
#define DF_ID_MENU_3                        0x00000003
//...
//#define DF_ID_MENU_X                      0x0000XXXX

#define DF_ST_MENU_NORMAL                   0x00000000  // ����״̬
#define DF_ST_MENU_EXPIR                    0x00000001  // �������
#define DF_ST_MENU_DISABLE                  0x00000003  // ʧ��״̬



////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    ���������� Show ����ֵ�������� CArtiLiveData ��
-----------------------------------------------------------------------------*/
#define DF_ID_LIVEDATA_BACK                 DF_ID_BACK
#define DF_ID_LIVEDATA_NEXT                 DF_ID_NEXT
#define DF_ID_LIVEDATA_PREV                 DF_ID_PREV
#define DF_ID_LIVEDATA_REPORT               DF_ID_REPORT




///////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    ���������� Show ����ֵ�������� CArtiTrouble ��
-----------------------------------------------------------------------------*/
#define DF_ID_TROUBLE_BACK                       DF_ID_BACK
#define DF_ID_TROUBLE_CLEAR                      DF_ID_CLEAR_DTC
#define DF_ID_TROUBLE_REPORT                     DF_ID_REPORT

// ������ ��� "����֡" �� Show ����ֵ�������� CArtiTrouble ��
#define DF_ID_TROUBLE_0                          0x00000000
#define DF_ID_TROUBLE_1                          0x00000001
#define DF_ID_TROUBLE_2                          0x00000002
#define DF_ID_TROUBLE_3                          0x00000003
#define DF_ID_TROUBLE_4                          0x00000004
//...
//#define DF_ID_TROUBLE_X                        0x0000XXXX

// ������ ��� "ά������" �� Show ����ֵ�������� CArtiTrouble ��
#define DF_ID_REPAIR_MANUAL_0                    0x40000000
#define DF_ID_REPAIR_MANUAL_1                    0x40000001
#define DF_ID_REPAIR_MANUAL_2                    0x40000002
#define DF_ID_REPAIR_MANUAL_3                    0x40000003
#define DF_ID_REPAIR_MANUAL_4                    0x40000004
//...
//#define DF_ID_REPAIR_MANUAL_XXXX               0x4000XXXX
////////////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
˵    ������ϱ��������״̬�����ڹ�������ṹ�� stDtcNode �� uStatus
----------------------------------------------------------------------------------*/
#define DF_DTC_STATUS_NONE                 (0)            // ��״̬
#define DF_DTC_STATUS_CURRENT              (1 << 0)       // ��ǰ������    Current
#define DF_DTC_STATUS_HISTORY              (1 << 1)       // ��ʷ������    History
#define DF_DTC_STATUS_PENDING              (1 << 2)       // ����������    Pending
#define DF_DTC_STATUS_TEMP                 (1 << 3)       // ��ʱ������    Temporary
#define DF_DTC_STATUS_NA                   (1 << 4)       // δ֪������    N/A
#define DF_DTC_STATUS_OTHERS               (0xFFFFFFFF)   // �޷����ൽ����ö�ٷ��ֱ࣬�Ӱ�strStatus��ʾ




///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
˵    ���������������1������Ϣ�ı�����������     2��������͵ĵ�����
          ������ CArtiPopup �� InitTitle �ӿڵ� uPopupType ����
----------------------------------------------------------------------------------*/
#define DF_POPUP_TYPE_MSG              0x00000001       // ����Ϣ�ı�����������
#define DF_POPUP_TYPE_LIST             0x00000002       // ������͵ĵ�����





///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
˵    �������ڵ�������� CArtiPopup �ӿ�SetPopDirection�����õ����򵯳��ķ���
          void SetPopDirection(uint32_t uDirection);
----------------------------------------------------------------------------------*/
#define DF_POPUP_DIR_TOP              0x00000000       // ��������
#define DF_POPUP_DIR_CENTER           0x00000001       // ���е���
#define DF_POPUP_DIR_RIGHT            0x00000002       // �Ҳ൯��
#define DF_POPUP_DIR_BOTTOM           0x00000004       // �ײ�����
#define DF_POPUP_DIR_LEFT             0x00000008       // ��൯��



/*-----------------------------------------------------------------------------
˵    ����ͼƬ��ӷ���ֵ�����߱�ţ���ʹ����CArtiPicture��
-----------------------------------------------------------------------------*/
#define DF_ID_PICTURE_NONE                   0xFFFFFFFF
#define DF_ID_PICTURE_0                      0x00000000
#define DF_ID_PICTURE_1                      0x00000001
#define DF_ID_PICTURE_2                      0x00000002
#define DF_ID_PICTURE_3                      0x00000003
//#define DF_ID_PICTURE_XX                   0x000000XX //һ��FF��ͼƬ



/*-----------------------------------------------------------------------------
˵    ����С��̽UI���ͣ������� artiMsgBoxActTest ���β� uTestType
          �������� CArtiLiveData �Ľӿ� SetComponentType
-----------------------------------------------------------------------------*/
#define DF_TYPE_ENTRY_COMMING                0x00000001     // ����ͨ���У��������������ԡ���������
#define DF_TYPE_COMM_FAILED                  0x00000002     // ͨ��ʧ������
#define DF_TYPE_ACT_TEST_NOT_SUPPORT         0x00000003     // ��֧�ֲ�������
#define DF_TYPE_THROTTLE_CARBON              0x00000010     // �����Ż�̼���
#define DF_TYPE_FULE_CORRECTION              0x00000020     // ȼ����������ϵͳ���
#define DF_TYPE_MAF_TEST                     0x00000030     // �����������������
#define DF_TYPE_INTAKE_PRESSURE              0x00000040     // ����ѹ�����������
#define DF_TYPE_INTAKE_PRESSURE_ACC          0x00000041     // ����ѹ������������е��ɿ�������ʾ
#define DF_TYPE_OXYGEN_SENSOR                0x00000050     // �����������
#define DF_TYPE_ENGINE_TEST_NO_DTC           0x00000060     // CarPal��������⣬�޹�����ҳ��



/*-----------------------------------------------------------------------------
˵    �����������Խ��ֵ������ CArtiLiveData �Ľӿ� SetComponentResult
-----------------------------------------------------------------------------*/
#define DF_RESULT_THROTTLE_NORMAL            0x00000001      // ��������������������
#define DF_RESULT_THROTTLE_LIGHT_CARBON      0x00000002      // ��������������΢��̼
#define DF_RESULT_THROTTLE_SERIOUSLY         0x00000003      // �����Ż�̼����

#define DF_RESULT_FULE_NORMAL                0x00000001      // ȼ����������
#define DF_RESULT_FULE_HIGH                  0x00000002      // ȼ������ƫŨ
#define DF_RESULT_FULE_LOW                   0x00000003      // ȼ������ƫϡ
#define DF_RESULT_FULE_ABNORMAL              0x00000004      // ȼ�������쳣

#define DF_RESULT_MAF_NORMAL                 0x00000001      // ����������
#define DF_RESULT_MAF_HIGH                   0x00000002      // ������ƫ��
#define DF_RESULT_MAF_LOW                    0x00000003      // ������ƫС

#define DF_RESULT_INTAKE_PRESSURE_NORMAL     0x00000001      // ����ѹ������
#define DF_RESULT_INTAKE_PRESSURE_HIGH       0x00000002      // ����ѹ��ƫ��

#define DF_RESULT_OXYGEN_NORMAL              0x00000001      // ������������
#define DF_RESULT_OXYGEN_ERROR               0x00000002      // �����������ֹ���



/*-----------------------------------------------------------------------------
˵    ����������TAP����
-----------------------------------------------------------------------------*/
#define DF_TAP_TYPE_IS_TOP_NAVIG           1          /* ����������     ���� */
#define DF_TAP_TYPE_IS_MSGBOX              2          /* ArtiMsgBox     ���� */
#define DF_TAP_TYPE_IS_INPUT               3          /* ArtiInput      ���� */
#define DF_TAP_TYPE_IS_ACTIVE              4          /* ArtiActive     ���� */
#define DF_TAP_TYPE_IS_ECUINFO             5          /* ArtiEcuInfo    ���� */
#define DF_TAP_TYPE_IS_FILE_DIALOG         6          /* ArtiFileDialog ���� */
#define DF_TAP_TYPE_IS_FREEZE              7          /* ArtiFreeze     ���� */
#define DF_TAP_TYPE_IS_LIST                8          /* ArtiList       ���� */
#define DF_TAP_TYPE_IS_LIVE_DATA           9          /* ArtiLiveData   ���� */
#define DF_TAP_TYPE_IS_MENU                10         /* ArtiMenu       ���� */
#define DF_TAP_TYPE_IS_PICTURE             11         /* ArtiPicture    ���� */
#define DF_TAP_TYPE_IS_SYSTEM              12         /* ArtiSystem     ���� */
#define DF_TAP_TYPE_IS_TROUBLE             13         /* ArtiTrouble    ���� */


////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    ���������� Show ����ֵ�������� CArtiNavigation �� ���� CArtiTopTap ��
-----------------------------------------------------------------------------*/
#define DF_ID_TAP_0                        0x00000000
#define DF_ID_TAP_1                        0x00000001
#define DF_ID_TAP_2                        0x00000002
#define DF_ID_TAP_3                        0x00000003
#define DF_ID_TAP_4                        0x00000004
#define DF_ID_TAP_5                        0x00000005
#define DF_ID_TAP_6                        0x00000006
//...
//#define DF_ID_MENU_X                      0x0000XXXX

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
˵    ���������� artiShowMsgBoxDs �ӿڷ���ֵ
----------------------------------------------------------------------------------*/
#define DF_ID_ADAS_RESULT_BACK             DF_ID_BACK       // ����ˡ����ˡ�
#define DF_ID_ADAS_RESULT_OK               DF_ID_OK         // ����ˡ���ɡ�
#define DF_ID_ADAS_RESULT_REPORT           DF_ID_REPORT     // ����ˡ����ɱ��桱



///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
˵    ���������� CArtiHidden �� Show �ӿڷ���ֵ
----------------------------------------------------------------------------------*/
#define DF_ID_HIDDEN_BACK             DF_ID_BACK        // ����ˡ����ˡ�
#define DF_ID_HIDDEN_OK               DF_ID_OK          // ����ˡ�ȷ��ִ�����á�
#define DF_ID_HIDDEN_RESTORE_DATA     DF_ID_RESTORE     // ����ˡ��ָ����ݡ�



/////////////////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------------------------
˵    ���������� CArtiTopoGraph �� SetSvgPath �� SetUsedLocalData �ӿڷ���ֵ
-------------------------------------------------------------------------------------------------*/
#define DF_SVG_PATH_IS_INVALID      0xFFFFFFFF    // ·���Ƿ��������ļ�������
#define DF_SVG_PATH_OK              0             // ������ȷ
#define DF_SVG_USED_LOCAL_OK        0             // ������ȷ
#define DF_SVG_LOCAL_NOT_SUPPORT    DF_APP_CURRENT_NOT_SUPPORT_FUNCTION  // ��ʾ����SVG�����ļ���֧��
#define DF_SVG_API_NOT_SUPPORT      DF_FUNCTION_APP_CURRENT_NOT_SUPPORT  // ��ʾ��ǰAPP�汾��û�д˽ӿ�

////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
˵    ����ϵͳ���Ժ궨�壬����stSysReportItemEx�ṹ���е�ϵͳ����uSysProp
-----------------------------------------------------------------------------*/
#define DF_SYS_PROP_DEFAULT                0x00000000   // Ĭ�ϣ�����
#define DF_SYS_PROP_ADAS                   0x00000001   // ����ADAS��������
#define DF_SYS_PROP_TPMS                   0x00000002   // ����̥ѹ��������


////////////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------------------------------
˵    ����ϵͳִ�н��״̬�궨�壬����stSysReportItemEx�ṹ���е�ִ��״̬uStatus
-------------------------------------------------------------------------------*/
#define DF_SYS_STATUS_ADAS_DEFAULT         0x00000000     // ADAS���ܲ���ִ�У��հף�
#define DF_SYS_STATUS_ADAS_OK              0x00000001     // ADAS����ִ��OK���ִ�У�Yes��
#define DF_SYS_STATUS_ADAS_FAILED          0x00000002     // ADAS����ִ��ʧ��
#endif
