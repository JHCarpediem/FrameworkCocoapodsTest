/*******************************************************************************
* Copyright (C), 2024~ , TOPDON Technology Co., Ltd. All rights reserved.
* �ļ�˵�� : �ĵ����ʶ
* �������� : CarPal Guru ˢ���� ����ִ�� �ؼ�
* �� �� �� : sujiya 20201216
* ʵ �� �� :
* �� �� �� : binchaolin
* �ļ��汾 : V1.00
* �޶���¼ : �汾      �޶���      �޶�����      �޶�����
*
*
*******************************************************************************/
#ifndef __ARTI_HIDDEN_H__
#define __ARTI_HIDDEN_H__

#include "StdInclude.h"
#include "StdShowMaco.h"



// CarPal Guru ˢ���� ����ִ�� �ؼ�
// 
// ����ִ�еĹ���ֵ���÷�����
// 1�������͹��ܣ�����ѡһ�Ŀ��ء���ť��
// 2��ѡ���͹��ܣ���ѡһ��ѡ���͹���
// 3���ɻ��������͹��ܣ���������ѡ��
// 4���������͹��ܣ�������򣬿�������ֵ
// 5�������͹������ã���������4�����͵Ķ������
// 
// ������2���̶���ť��һ����ȷ��ִ�����á���ť��һ�����ָ����ݡ�
// ���С�ȷ��ִ�����á���ťһֱ��Ч�����ָ����ݡ�Ĭ�����أ����Ӧ�ÿ�����Ϊ������
//
class _STD_SHOW_DLL_API_ CArtiHidden
{
public:
    // ������������
    enum eHiddenFunType
    {
        FHT_SWITCH_TYPE      = 0,    // �����͹��ܣ�����ѡһ�Ŀ��ء���ť��
        FHT_SELECT_TYPE      = 1,    // ѡ���͹��ܣ���ѡһ��ѡ���͹���
        FHT_SLIDE_TYPE       = 2,    // �ɻ��������͹��ܣ���������ѡ��
        FHT_INPUT_TYPE       = 3,    // �������͹��ܣ�������򣬿�������ֵ

        FHT_COMPOSITE_TYPE   = 0x10, // ��������ͣ������ܰ��������������
    };

    // �ɻ��������͹��ܵ���ֵ����
    enum eSlideValueType
    {
        SVT_IS_PERSENT      = 0,    // �ɻ��������͹��ܵ���ֵ�ǰٷֱȣ�����0%~100%
        SVT_IS_NUMERICAL    = 1,    // �ɻ��������͹��ܵ���ֵ����ֵ������0~100
    };

    // �����������״̬ö��ֵ
    enum eHiddenFunStatus
    {
        HFS_ENABLE  = 0,    // Ĭ��״̬����ʹ��
        HFS_DISABLE = 1,    // ������״̬�����ɵ�����û�״̬
    };

public:
    CArtiHidden();

#ifdef MULTI_SYSTEM
    CArtiHidden(uint32_t thId);
#endif // MULTI_SYSTEM


    ~CArtiHidden();



    /****************************************************************************************
    *    ��  �ܣ���ʼ��ˢ���ع���ִ�пؼ���ͬʱ���ñ����ı������ù�������
    *
    *    ��  ����strTitle    �����ı�
    *            strFunName  ��������
    *            strFunId    ����ID
    *            Type        ������������
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *            
    *            ��ʼ���ɹ�����1
    *            ��������ֵ����������
    * 
    *    ˵  �������ô˽ӿں��൱�����³�ʼ���������ӿ����ٴε��òŻ���Ч
    ****************************************************************************************/
    uint32_t InitTitle(const string& strTitle, const string& strFunName, const string& strFunId, eHiddenFunType Type);



    /*******************************************************************************************
    *    ��  �ܣ����ý��������״̬
    * 
    *    ��  ����bIsBlock = true  �ý���Ϊ������
    *            bIsBlock = false �ý���Ϊ��������
    * 
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    * 
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    *
    *            ��������ֵ����������
    *******************************************************************************************/
    uint32_t SetBlockStatus(bool bIsBlock);



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
    *    ��  �ܣ����ñ����ı����ı���ʾ
    *
    *    ��  ����strTitleTips     ��Ӧ�ı����ı����ı���ʾ
    *                             ���strTitleTipsΪ�մ�������ʾ������ı���ʾ
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    * 
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    *            ��������ֵ����������
    *
    *    ˵  �������û�����ã�û�е��ô˽ӿڣ�������ʾ��ʾ����
    *            ���strTitleTipsΪ�մ�����ȡ��֮ǰ�Ľӿ����ã���û�б�����ı���ʾ
    ****************************************************************************************/
    uint32_t SetTitleTips(const string& strTitleTips);


    /****************************************************************************************
    *    ��  �ܣ����á��ָ����ݡ���ť��״̬��Ĭ�ϲ��ɼ�
    *
    *    ��  ����bIsVisible  true Ϊ�ɼ����ҿɵ����false Ϊ���ɼ�
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ��������ֵ����������
    *
    *    ˵  �������û�����ã�û�е��ô˽ӿڣ����򡰻ָ����ݡ���ť���ɼ�
    ******************************************************************************************/
    uint32_t SetRestoreButtonVisible(bool bIsVisible);


    /****************************************************************************************
    *    ��  �ܣ����ӹ������������Ϊ"FHT_SWITCH_TYPE"����Կ�����ִ�й��ܣ���ѡһ��
    *            FHT_SWITCH_TYPE���˽ӿ��������ߵĹ���ֵ���Ƽ���ǰ��Ӧ�Ĺ���ֵ
    * 
    *            ֻ������Ϊ��FHT_SWITCH_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    *
    *    ��  ����strTitle      ����������ı���
    *            strOn         �߼��������Ĺ���ֵ�ַ��������硰������������ʾ��
    *            strOff        �߼����ء��Ĺ���ֵ�ַ��������硰�رա��������ء�
    *            bSelectedOn   Ĭ��ѡ�е�״̬
    *                                        true  Ϊѡ���߼�������strOn
    *                                        false Ϊѡ���߼����ء�strOff
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ��ӳɹ����أ��˹����������ƫ�ƣ���0��ʼ����
    *            ���磬AddSwitchValue������0
    *                  AddSelectedValue������1
    *                  AddSwitchValue�� ����2
    * 
    *            ������ʧ�ܣ�����-1
    * 
    *            ����InitTitle��������FHT_SELECT_TYPE���ȵ���AddSelectedValue�ɹ���
    *            �ٵ���AddSwitchValue��������-1
    * 
    *            ����InitTitleû������FHT_COMPOSITE_TYPE�������ͣ��ظ�AddSwitchValue������-1
    * 
    *            ����InitTitle��������FHT_SELECT_TYPE������AddSwitchValue����-1
    * 
    *    ˵  �������û�е��ô˽ӿ�������ΪFHT_SWITCH_TYPE���򿪹���ִ�й��ܵ����ƿմ�
    *            ������Ͳ���FHT_SWITCH_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ�����-1
    *            ��������˴˽ӿ�AddSwitchValue���ֵ���InitTitle�����޸������ͣ�
    *            ��֮ǰ��AddSwitchValueʧЧ
    ****************************************************************************************/
    uint32_t AddSwitchValue(const string& strTitle, const string& strOn, const string& strOff, bool bSelectedOn);



    /****************************************************************************************
    *    ��  �ܣ����ӹ������������Ϊ"FHT_SELECT_TYPE"�����ѡ���͹��ܣ���ѡһ��ѡ���͹���
    *            FHT_SELECT_TYPE���˽ӿ�ͬʱ���ø�ѡ�����ֵ������Ӧ����ѡ����
    * 
    *            ֻ������Ϊ��FHT_SELECT_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    *
    *    ��  ����strTitle    ����������ı���
    *            vctValue    ��ѡ����ֵ�����飬�����ж��ٸ�Ԫ�ؾ��ж��ٸ�ѡ����
    *            Selected    Ĭ����ѡ���ƫ�ƣ���ǰֵ������0��ʼ
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ��ӳɹ����أ��˹����������ƫ�ƣ���0��ʼ����
    *            ���磬AddSwitchValue������0
    *                  AddSelectedValue������1
    *                  AddSwitchValue�� ����2
    * 
    *            ������ʧ�ܣ�����-1
    *
    *            ����InitTitle��������FHT_SWITCH_TYPE���ȵ���AddSwitchValue�ɹ���
    *            �ٵ���AddSelectedValue��������-1
    *
    *            ����InitTitleû������FHT_COMPOSITE_TYPE�������ͣ��ظ�AddSelectedValue������-1
    *
    *            ����InitTitle��������FHT_SWITCH_TYPE������AddSelectedValue����-1
    *
    *    ˵  �������û�е��ô˽ӿ�������ΪFHT_SELECT_TYPE�����޸�ѡ����չʾ
    *            ������Ͳ���FHT_SELECT_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ�����-1
    *            ��������˴˽ӿ�AddSelectedValue���ֵ���InitTitle�����޸������ͣ�
    *            ��֮ǰ��AddSelectedValueʧЧ
    ****************************************************************************************/
    uint32_t AddSelectedValue(const string& strTitle, const std::vector<std::string>& vctValue, uint32_t Selected);



    /****************************************************************************************
    *    ��  �ܣ����ӹ������������Ϊ"FHT_SLIDE_TYPE"����Կɻ��������͹��ܣ���������ѡ��
    *            FHT_SLIDE_TYPE���˽ӿ�ͬʱ���û������ͣ�����صķ�Χֵ������Ӧ�ĵ�ǰֵ
    * 
    *            ֻ������Ϊ��FHT_SLIDE_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    *
    *    ��  ����strTitle    ����������ı���
    *            typeSlide   �������ͣ�����ٷֱȣ����ֵ�
    *            minValue    �ɻ�������Сֵ
    *            maxValue    �ɻ��������ֵ
    *            curValue    ��ǰֵ
    *            strUnit     ��ǰֵ��Ӧ�ĵ�λ������մ�������Ҫ��ʾ��λ
    *            pointCnts   С���㱣��λ����ͨ�������Ϊ2λ
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    * 
    *            ��ӳɹ����أ��˹����������ƫ�ƣ���0��ʼ����
    *            ���磬AddSwitchValue������0
    *                  AddSelectedValue������1
    *                  AddSlideValue�� ����2
    *
    *            ������ʧ�ܣ�����-1
    *
    *            ����InitTitle��������FHT_SWITCH_TYPE���ȵ���AddSwitchValue�ɹ���
    *            �ٵ���AddSlideValue��������-1
    *
    *            ����InitTitleû������FHT_COMPOSITE_TYPE�������ͣ��ظ�AddSlideValue������-1
    *
    *            ����InitTitle��������FHT_SWITCH_TYPE������AddSlideValue����-1
    *
    *    ˵  �������û�е��ô˽ӿ�������ΪFHT_SLIDE_TYPE������������κ�ֵչʾ
    *            ������Ͳ���FHT_SLIDE_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ�����-1
    *            ��������˴˽ӿ�AddSlideValue���ֵ���InitTitle�����޸������ͣ�
    *            ��֮ǰ��AddSlideValueʧЧ
    ****************************************************************************************/
    uint32_t AddSlideValue(const string& strTitle, eSlideValueType typeSlide, float minValue, float maxValue, float curValue, const string& strUnit = "", uint32_t pointCnts = 2);



    /****************************************************************************************
    *    ��  �ܣ����ӹ������������Ϊ"FHT_INPUT_TYPE"����Կ������͹��ܣ��������
    *            ��������ֵ��FHT_INPUT_TYPE���ӿ�ͬʱ�������������뼰��Ӧ����ʾ��
    * 
    *            ֻ������Ϊ��FHT_INPUT_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    *
    *    ��  ����strTitle    ����������ı���
    *            strTips     �����Ĭ�ϵ���ʾ������ɫ��ʾ
    *            strMask     �������룬�������͸�CArtiInput����������һ��
    * 
    *                        ���������˵���������������Ҫ������������ƺ����볤������
    *                            *����ʾ�������������ʾ�ַ�
    *                            0����ʾ������0~9֮����ַ�
    *                            F����ʾ������0~9��A~F֮���������ʾ16���Ƶ��ַ�
    *                            #����ʾ������0~9��+��-��*��/�ַ�
    *                            A����ʾ������A~Z֮��Ĵ�д��ĸ
    *                            B����ʾ������0~9֮����ַ���A~Z֮��Ĵ�д��ĸ
    * 
    *            strCurrent  ��ǰֵ��������ʾ��
    * 
    *            strUnit     ��λ����ǰֵ��Ӧ�ĵ�λ������մ�������Ҫ��ʾ��λ
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            ��ӳɹ����أ��˹����������ƫ�ƣ���0��ʼ����
    *            ���磬AddSwitchValue������0
    *                  AddSelectedValue������1
    *                  AddSlideValue�� ����2
    *                  AddInputBox������3
    *
    *            ������ʧ�ܣ�����-1
    *
    *            ����InitTitle��������FHT_SWITCH_TYPE���ȵ���AddSwitchValue�ɹ���
    *            �ٵ���AddInputBox��������-1
    *
    *            ����InitTitleû������FHT_COMPOSITE_TYPE�������ͣ��ظ�AddInputBox������-1
    *
    *            ����InitTitle��������FHT_SWITCH_TYPE������AddInputBox����-1
    *
    *    ˵  �������û�е��ô˽ӿ�������ΪFHT_INPUT_TYPE�����������չʾ
    *            ������Ͳ���FHT_INPUT_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ�����-1
    *            ��������˴˽ӿ�AddInputBox���ֵ���InitTitle�����޸������ͣ�
    *            ��֮ǰ��AddInputBoxʧЧ
    ****************************************************************************************/
    uint32_t AddInputBox(const string& strTitle, const string& strTips, const string& strMask, const string& strCurrent, const string& strUnit = "");


    /***********************************************************************************
    *    ��  �ܣ����ÿ����͹��ܿ��״̬
    *
    *    ��  ����uIndex      �ĸ������͹��ܿ��������AddSwitchValue���ص�ƫ��
    *            bStatus     ������״̬
    *
    *                        HFS_ENABLE  = 0,     Ĭ��״̬����ʹ��
    *                        HFS_DISABLE = 1,     ������״̬�����ɵ�����û�״̬
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    *
    *            ���û�е��ô˽ӿڣ�Ĭ��Ϊ״̬Ϊ��ʹ��
    *************************************************************************************/
    uint32_t SetSwitchValueStatus(uint32_t uIndex, eHiddenFunStatus uStatus);


    /***********************************************************************************
    *    ��  �ܣ�����ѡ���Թ��ܿ��״̬
    *
    *    ��  ����uIndex      �ĸ�ѡ���Թ��ܿ��������AddSelectedValue���ص�ƫ��
    *            bStatus     ������״̬
    *
    *                        HFS_ENABLE  = 0,     Ĭ��״̬����ʹ��
    *                        HFS_DISABLE = 1,     ������״̬�����ɵ�����û�״̬
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    *
    *            ���û�е��ô˽ӿڣ�Ĭ��Ϊ״̬Ϊ��ʹ��
    *************************************************************************************/
    uint32_t SetSelectedValueStatus(uint32_t uIndex, eHiddenFunStatus uStatus);


    /***********************************************************************************
    *    ��  �ܣ����ý�����ѡ���״̬
    *
    *    ��  ����uIndex      �ĸ���������������AddSlideValue���ص�ƫ��
    *            bStatus     ������״̬
    *
    *                        HFS_ENABLE  = 0,     Ĭ��״̬����ʹ��
    *                        HFS_DISABLE = 1,     ������״̬�����ɵ�����û�״̬
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    *
    *            ���û�е��ô˽ӿڣ�Ĭ��Ϊ״̬Ϊ��ʹ��
    *************************************************************************************/
    uint32_t SetSlideValueStatus(uint32_t uIndex, eHiddenFunStatus uStatus);


    /***********************************************************************************
    *    ��  �ܣ�����������״̬
    *
    *    ��  ����uIndex      �ĸ�������������AddInputBox���ص�ƫ��
    *            bStatus     ������״̬
    *
    *                        HFS_ENABLE  = 0,     Ĭ��״̬����ʹ��
    *                        HFS_DISABLE = 1,     ������״̬�����ɵ�����û�״̬
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    * 
    *            ���û�е��ô˽ӿڣ�Ĭ��Ϊ״̬Ϊ��ʹ��
    *************************************************************************************/
    uint32_t SetInputBoxStatus(uint32_t uIndex, eHiddenFunStatus uStatus);


    /***********************************************************************************
    *    ��  �ܣ�������Ҫ��������Ĺ��ܿ�
    *            
    *            ���磬������FHT_COMPOSITE_TYPE�������ͣ������˿����͹��ܣ�ѡ���͹��ܣ�
    *                  �ɻ��������͹��ܣ��������͹���
    *                  ��ʱ����Ҫѡ���͹��ܿ򣬿ɻ��������͹��ܿ򣬿������͹��ܿ���3��
    *                  ���ܿ��ֵ���������仯�ģ����û��ı��κ�һ��ֵ���������ܿ��ֵҲ��
    *                  ���Ÿı�
    * 
    *                  SetBindChange(0, 1, 2);
    *
    *    ��  ����uSlide      ��Ҫ�����仯�Ļ��������Թ��ܿ��������AddSlideValue���ص�ƫ��
    *            uInput      ��Ҫ�����仯�Ŀ������͹��ܿ��������AddInputBox���ص�ƫ��
    *            uSelected   ��Ҫ�����仯��ѡ���͹��ܿ��������AddSelectedValue���ص�ƫ��
    *
    *            ���ֻ��Ҫ2�����ܿ������仯���򽫲���Ҫ�����Ĺ��ܿ���������Ϊ-1
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    *
    *            ���û�е��ô˽ӿڣ�Ĭ��Ϊ״̬Ϊ��ʹ��
    *************************************************************************************/
    uint32_t SetBindChange(uint32_t uSlide, uint32_t uInput, uint32_t uSelected);


    /***************************************************************************
    *    ��  �ܣ���ӹ��ܽ��ܣ�ͼƬ����ʾ�ı���App����� strSearchId ȥ����ˢ��
    *            �ع��ܽ����ļ���Ȼ����ʾ
    *            
    *            AddFuncDescribe�ӿ��ѷ���
    *
    *    ��  ����strSearchId    ����ˢ���ع��ܽ����ļ��ļ���ID
    *                           /api/v1/user/customize/intro
    * 
    *            strPicturePath ָ��ͼƬ·��
    *                           ���strPicturePathָ��ͼƬ·����Ϊ�Ƿ�·�����մ�
    *                           ���ļ������ڣ�������ʧ��DF_ID_PICTURE_NONE
    *
    *            strTopTips     ���ܽ��ܵ���ʾ�ı���λ��ͼƬ����
    *                           ���strTopTipsΪ�գ�����ͼƬ����û���ı�����
    * 
    *            strBottomTips  ���ܽ��ܵ���ʾ�ı���λ��ͼƬ�ײ�
    *                           ���strBottomTipsΪ�գ�����ͼƬ�ײ�û���ı�����
    *
    *    ����ֵ��ͼƬ����ID��������ʧ�ܣ�·���Ƿ��������� DF_ID_PICTURE_NONE
    *            ���ܵķ���ֵ��
    *                         DF_ID_PICTURE_0
    * 
    *    ˵ ���� ��ǰֻ֧��һ��ͼƬ˵������֧��2�ż�2�����ϣ�
    ***************************************************************************/
    uint32_t AddFuncDescSearchId(const std::string& strSearchId);
    uint32_t AddFuncDescribe(const std::string& strPictPath, const std::string& strTopTips, const std::string& strBottomTips);



    /****************************************************************************************
    *    ��  �ܣ���Կ�����ִ�й��ܣ���ѡһ����FHT_SWITCH_TYPE������FHT_COMPOSITE_TYPE��
    *            ��ȡ����ѡ��ֵ
    * 
    *            ֻ������Ϊ��FHT_SWITCH_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    * 
    *    ��  ����Index     ��ӦAddSwitchValue���ص�ƫ��
    *
    *    ����ֵ����Ӧ�Ŀ���ѡ��ֵ
    * 
    *            ��������ڶ�Ӧ��Index�����ؿմ�
    *            �������Index������Indexȴ����AddSwitchValue���صģ����ؿմ�
    * 
    *            ����������FHT_COMPOSITE_TYPEȴû�е���AddSwitchValue������GetSwitchValue���ؿմ�
    *
    *    ˵  ����������Ͳ���FHT_SWITCH_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ������ؿմ�
    *            ��������˽ӿ�AddSwitchValue���ֵ���InitTitle�����޸������ͣ�
    *            ��GetSwitchValueͬ�������ؿմ�
    ****************************************************************************************/
    const std::string GetSwitchValue(uint32_t Index);



    /****************************************************************************************
    *    ��  �ܣ����ѡ���͹��ܣ���ѡһ��ѡ���͹��ܣ�FHT_SELECT_TYPE������FHT_COMPOSITE_TYPE��
    *            ��ȡѡ��ֵ
    * 
    *            ֻ������Ϊ��FHT_SELECT_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    *
    *    ��  ����Index     ��ӦAddSelectedValue���ص�ƫ��
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *            
    *            ѡ��ֵ��ƫ�ƣ���0��
    *            ��������ڶ�Ӧ��Index������-1
    *            �������Index������Indexȴ����AddSelectedValue���صģ�����-1
    *
    *            ����������FHT_COMPOSITE_TYPEȴû�е���AddSelectedValue������GetSwitchValue����-1
    *
    *    ˵  ����������Ͳ���FHT_SELECT_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ�������-1
    *            ��������˽ӿ�AddSelectedValue���ֵ���InitTitle�����޸������ͣ�
    *            ��GetSelectedValueͬ��������-1
    ****************************************************************************************/
    uint32_t GetSelectedValue(uint32_t Index);



    /****************************************************************************************
    *    ��  �ܣ���Կɻ��������͹��ܣ���������ѡ��FHT_SLIDE_TYPE������FHT_COMPOSITE_TYPE��
    *            ��ȡ������������ѡ��ֵ
    * 
    *            ֻ������Ϊ��FHT_SLIDE_TYPE ���� FHT_COMPOSITE_TYPE�����ô˽ӿڲ���Ч
    *            App�������ͺͽӿ��Ƿ�ƥ��
    *
    *    ��  ����Index     ��ӦAddSlideValue���ص�ƫ��
    *
    *    ����ֵ��������������ѡ��ֵ
    *            ���������SVT_IS_PERSENT�ٷֱȣ����ش�����%����50%����50
    * 
    *            ��������ڶ�Ӧ��Index�����ؿմ�
    *            �������Index������Indexȴ����AddSlideValue���صģ����ؿմ�
    *
    *            ����������FHT_COMPOSITE_TYPEȴû�е���AddSlideValue������GetSlideValue���ؿմ�
    *
    *    ˵  ����������Ͳ���FHT_SLIDE_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ������ؿմ�
    *            ��������˽ӿ�AddSlideValue���ֵ���InitTitle�����޸������ͣ�
    *            ��GetSlideValueͬ�������ؿմ�
    ****************************************************************************************/
    const std::string GetSlideValue(uint32_t Index);



    /****************************************************************************************
    *    ��  �ܣ���Կ������͹��ܣ�������򣬿�������ֵ��FHT_INPUT_TYPE���ͣ�
    *            ����FHT_COMPOSITE_TYPE����ȡ���������
    *
    *    ��  ����Index     ��ӦAddInputBox���ص�ƫ��
    *
    *    ����ֵ������������ֵ
    * 
    *            ��������ڶ�Ӧ��Index�����ؿմ�
    *            �������Index������Indexȴ����AddInputBox���صģ����ؿմ�
    *
    *            ����������FHT_COMPOSITE_TYPEȴû�е���AddInputBox������GetInputBox���ؿմ�
    *
    *    ˵  ����������Ͳ���FHT_INPUT_TYPE����FHT_COMPOSITE_TYPE���ֵ����˴˽ӿڣ������ؿմ�
    *            ��������˽ӿ�AddInputBox���ֵ���InitTitle�����޸������ͣ�
    *            ��GetInputBoxͬ�������ؿմ�
    ****************************************************************************************/
    const std::string GetInputBox(uint32_t Index);


    /****************************************************************************************
    *    ��  �ܣ���Կ������͹��ܣ�������򣬿��������ֵ��FHT_INPUT_TYPE����
    *            ����FHT_COMPOSITE_TYPE�����������ķ�Χ
    *
    *    ��  ����Index     ��ӦAddInputBox���ص�ƫ��
    *            minValue  ����������Сֵ
    *            maxValue  �����������ֵ
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT ֵ��SO����
    * 
    *            DF_APP_CURRENT_NOT_SUPPORT_FUNCTION, ��ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ����
    * 
    *            ��������ڶ�Ӧ��Index������-1
    * 
    *    ˵  �������û�е��� AddInputBox, ����SetInputBoxLimits������-1
    ****************************************************************************************/
    uint32_t SetInputBoxLimits(uint32_t Index, float minValue, float maxValue);


    /****************************************************************************************
    *    ��  �ܣ����õ�ǰˢ���ع��ܵĽ����Ĭ��Ϊû��ִ��״̬
    *
    *    ��  ����HiddenStatus   ��ǰˢ���ع��ܵĽ��״̬
    *                           APP�Ľ����˾��ʾ���棬���ݴ�״ֵ̬�Ƿ�չʾ���ɹ�����ʧ����չʾ
    *                           û��ִ��״̬������˾��ʾ

    *                           HNS_FUNC_HIDDEN_DEFAULT   0,  ˢ����δ���У�Show ����˾��ʾ
    *                           HNS_FUNC_HIDDEN_OK        1,  ����������ɣ�Show ����˾��ʾ
    *                           HNS_FUNC_HIDDEN_FAILED    2,  ��������ʧ�ܣ�Show ����˾��ʾ
    *
    *    ����ֵ��DF_FUNCTION_APP_CURRENT_NOT_SUPPORT����ǰAPP�汾��û�д˽ӿ�
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORTֵ��SO����
    *
    *    ˵  �������û�е��ù��˽ӿڣ�Ĭ��ΪHNS_FUNC_HIDDEN_DEFAULT��Show ����˾��ʾ
    ****************************************************************************************/
    const uint32_t SetHidderResult(uint32_t HiddenStatus);


    /***************************************************************************************
    *    ��  �ܣ���ʾ����ִ�н��棬��˾��ʾ����SetHidderResult�ӿڶ�
    * 
    *    ��  ������
    * 
    *    ����ֵ��uint32_t ������水������ֵ
    *            ָʾ�û��ǵ����"ȷ��ִ������"��ť
    *    
    *     ���ܴ������·��أ�
    *                      DF_ID_HIDDEN_BACK           ����ˡ����ˡ�
    *                      DF_ID_HIDDEN_OK             ����ˡ�ȷ��ִ�����á�
    *                      DF_ID_HIDDEN_RESTORE_DATA   ����ˡ��ָ����ݡ�
    * 
    *    ˵  �����˽ӿڿ���������/������
    ****************************************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_HIDDEN_H__
