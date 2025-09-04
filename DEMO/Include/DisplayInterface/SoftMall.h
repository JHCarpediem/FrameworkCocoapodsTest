#ifndef __SOFT_MALL_MACO_H__
#define __SOFT_MALL_MACO_H__

#include "StdInclude.h"


class _STD_SHOW_DLL_API_ CSoftMall
{
public:
    enum eUserSubscription
    {
        SMUS_SUBSCRIPTION_UNCHANGED = 0,   // �û�Ȩ��û�б仯
        SMUS_SUBSCRIPTION_CHANGED   = 1,   // �û�Ȩ���б仯

        SMUS_PAY_OK                 = 2,   // �û�֧���ɹ�
        SMUS_PAY_FAILED             = 3,   // �û�֧��ʧ��
    };

public:
    CSoftMall() {}
    ~CSoftMall() {}

public:
    /*-------------------------------------------------------------------------------------------------------
    ��    �ܣ� ��ת������̳ǽ��棬���Ӧ�ÿ���ͨ���˽ӿ���ת������̳ǽ���
               �˽ӿ������ģ�ֱ���û����̳ǽ��淵�أ�����Ȩ�����ޱ仯

    ����˵���� uType          ��ת����
                              uType = 1����ʾˢ����Ȩ������
                              ����ֵ������

    �� �� ֵ�� �����ǰAPP�汾��û�д˽ӿڣ����� DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
               �����ǰApp�д˽ӿڣ���δʵ�ֶ�Ӧ���ܣ����� DF_APP_CURRENT_NOT_SUPPORT_FUNCTION
               ����û����̳ǹ����˲�Ʒ������ SMUS_SUBSCRIPTION_CHANGED��1��
               ����û�û�й����Ʒ������ SMUS_SUBSCRIPTION_UNCHANGED��0��
    -------------------------------------------------------------------------------------------------------*/
    static uint32_t Navigate(uint32_t uType);
};

#endif // __SOFT_MALL_MACO_H__
