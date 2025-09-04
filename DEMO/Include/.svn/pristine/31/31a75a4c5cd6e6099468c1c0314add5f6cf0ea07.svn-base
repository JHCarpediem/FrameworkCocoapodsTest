/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 图片输入框组件接口定义
* 创 建 人 : sujiya 20231116
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
*
*******************************************************************************/
#ifndef __ARTI_PICTURE_INPUT_H__
#define __ARTI_PICTURE_INPUT_H__

#include "StdShowMaco.h"

/*
*
*    带图片示意图的输入框组件，Show为阻塞接口
*/
// 1、默认情况下，图片示意图在左侧，输入框在右侧
// 2、输入框可以是一列形式，也可以是2列形式
// 3、可在界面顶部增加提示文本，也可以在底部增加提示文本
// 4、可在右侧输入框顶部增加主提示文本，也可以在底部增加
// 
/*
*    输入框掩码说明：掩码决定了需要输入的内容和输入长度
*        *：表示可输入任意可显示字符
         0：表示可输入0~9之间的字符
         F：表示可输入0~9，A~F之间的用来表示16进制的字符
         #：表示可输入0~9，+，-，*，/字符
         V：表示可输入0~9，A~Z之间除了I，O，Q外的其他所有可出现在VIN码中的字符
         A：表示可输入A~Z之间的大写字母
         B：表示可输入0~9之间的字符和A~Z之间的大写字母

    输入框为用户提供输入的界面，存在以下情况
    1、 单输入框，确定、取消按钮，另加自由添加按钮，阻塞界面；
    2、 多输入框，确定、取消按钮，另加自由添加按钮，阻塞界面；
    3、 输入框应具备输入记忆功能；
    4、 输入框涉及键盘问题，请根据掩码和按钮组合键盘；
    5、 输入框采用上下滑动
*/
// 输入框提示字串，即strTips，默认在输入框上面（上一行）
// 如果需要设置输入框提示字串在输入框的左边，需要设置输入框提示类型

class _STD_SHOW_DLL_API_ CArtiPictureInput
{
public:
    // 输入框列形式
    enum eInputListType
    {
        ILT_COLUMN_ONE,  // 所有输入框为1列往下排
        ILT_COLUMN_TWO,  // 所有输入框为2列往下排

        ILT_COLUMN_INVALID = 0xFF,   
    };

public:
    CArtiPictureInput();


    ~CArtiPictureInput();


    /*******************************************************************
    *    功  能：设置图片输入框的标题和类型
    * 
    *    参  数：strTips           图片输入框界面标题
    * 
    *            eColumnType       输入框的列类型
    *                 LT_COLUMN_ONE   输入框为1列往下排
    *                 ILT_COLUMN_TWO  输入框为2列往下排
    * 
    *    返回值：无
    *******************************************************************/
    void InitTitle(const std::string& strTitle, eInputListType eColumnType);


    /*****************************************************************
    *    功  能：设置界面的主提示文本
    *
    *    参  数：strTips  提示文本
    *            posTyp   TIPS_IS_TOP    提示文本居于顶部显示
    *                     TIPS_IS_BOTTOM 提示文本居于底部显示
    *
    *    返回值：无
    *    说  明：如果没有调用此接口，则无主提示文本
    *****************************************************************/
    void SetMainTips(const std::string& strTips, eTipsPosType posType);


    /***************************************************************************
    *    功  能：添加图片，图片默认居左侧
    *
    *    参  数：strPicturePath 指定图片路径
    *                           如果strPicturePath指定图片路径串为非法路径（空串
    *                           或文件不存在），返回失败DF_ID_PICTURE_NONE
    *
    *            strBottomTips  图片显示的文本提示（底部）
    *                           如果strBottomTips为空，代表图片底部没有文本提示
    *
    *    返回值：图片索引ID，如果添加失败（路径非法），返回 DF_ID_PICTURE_NONE
    *            可能的返回值：
    *                         DF_ID_PICTURE_0
    *                         DF_ID_PICTURE_1
    *                         DF_ID_PICTURE_2
    *                         DF_ID_PICTURE_3
    *                         DF_ID_PICTURE_XX
    ***************************************************************************/
    uint32_t AddPicture(const std::string& strPicturePath, const std::string& strBottomTips);


    /*************************************************************************
    *    功  能：自由添加按钮
    *
    *    参  数：strButtonText 按钮名称
    *
    *    返回值：按钮的ID
    *            可能的返回值：
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *                         DF_ID_FREEBTN_2
    *                         DF_ID_FREEBTN_3
    *                         DF_ID_FREEBTN_XX
    *************************************************************************/
    uint32_t AddButton(const std::string& strButtonText);



    /*************************************************************************
    *    功  能：初始化输入框控件，如果数组元素为1，则为单输入框
    * 
    *    参  数：strTitle       标题文本
    *            vctTips        输入框对应的提示文本集合，一一对应，空则无提示
    *            vctMasks       输入框对应的输入掩码，一一对应
    *            vctDefaults    输入框对应的默认值，一一对应，空则无默认值
    * 
    *    返回值：无
    *************************************************************************/
    bool InitInputBox(const std::string& strTitle,
        const std::vector<std::string>& vctTips,
        const std::vector<std::string>& vctMasks,
        const std::vector<std::string>& vctDefaults = vector<std::string>(0));



    /**********************************************************
    *    功  能：获取多输入框的返回值
    * 
    *    参  数：无
    * 
    *    返回值：vector<string> 多输入框输入值的集合
    **********************************************************/
    std::vector<std::string> GetInputBox();



    /*****************************************************************
    *    功  能：设置输入框底部设置提示文本
    *
    *    参  数：strTips       提示文本
    *            strTipsTitle  提示文本的标题，通常黑体
    *
    *    返回值：无
    * 
    *    说  明：如果没有调用此接口，则无底部的输入框提示文本
    *****************************************************************/
    void SetInputTipsBottom(const std::string& strTips, const std::string& strTipsTitle);



    /**********************************************************
    *    功  能：显示图片输入框，阻塞
    * 
    *    参  数：无
    * 
    *    返回值：uint32_t 组件界面按键返回值
    **********************************************************/
    uint32_t Show();

private:
    void*    m_pData;
};


#endif // __ARTI_PICTURE_INPUT_H__
