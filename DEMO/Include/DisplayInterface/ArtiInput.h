/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900输入框控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
*
*******************************************************************************/
#ifndef _ARTIINPUT_H_
#define _ARTIINPUT_H_

#include "StdShowMaco.h"


/*
*
*    输入框掩码说明：掩码决定了需要输入的内容和输入长度
*        *：表示可输入任意可显示字符
         0：表示可输入0~9之间的字符
         F：表示可输入0~9，A~F之间的用来表示16进制的字符
         #：表示可输入0~9，+，-，*，/，.字符
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
// 输入框，如果掩码带V类型开头，表示当前可能是VIN码输入框，App限制为单行显示
class _STD_SHOW_DLL_API_ CArtiInput
{
public:
    CArtiInput();
#ifdef MULTI_SYSTEM
    CArtiInput(uint32_t thId);
#endif // MULTI_SYSTEM
    ~CArtiInput();

    enum ControlType
    {
        InputBox = 0,
        ComboBox = 1,
    };

    /**********************************************************
    *    功  能：设置输入框提示文本的位置
    *
    *    参  数：posTyp  TIPS_IS_TOP    输入框的提示符居于输入框
    *                                   上面（上一行）
    *
    *                    TIPS_IS_LEFT   输入框的提示符居于输入框
    *                                   左边（同一行）
    *
    *    返回值：无
    *
    *    注  意：如果没有调用此接口，默认为TIPS_IS_TOP，提示在
    *            输入框的上面
    **********************************************************/
    void SetTipsPosition(eTipsPosType posType);



    /**********************************************************
    *    功  能：初始化单输入框控件
    *    参  数：strTitle 标题文本
    *            strTips 提示文本
    *            strMask 输入掩码
    *            strDefault 默认值
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitOneInputBox(const string& strTitle,
        const string& strTips,
        const string& strMask,
        const string& strDefault = "");


    /****************************************************************************************
    功    能： 设置单输入框的内部提示文本
               如果在 InitOneInputBox 设置了 strDefault，输入框默认按 strDefault
               如果用户删除了默认输入值，则显示 strInnerTips
               例如，"请输入"

    参数说明： strInnerTips          "请输入"

    返 回 值： 如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
               如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION,
               其它值，暂无意义
    ****************************************************************************************/
    uint32_t SetInputBoxInnerTips(const std::string& strInnerTips);


    /**********************************************************
    *    功  能：获取单输入框的内容
    *    参  数：无
    *    返回值：string 输入框输入的值
    **********************************************************/
    string GetOneInputBox();


    /**********************************************************
    *    功  能：添加按钮
    *    参  数：strButtonText 按钮文本
    *    返回值：无
    **********************************************************/
    void AddButton(const string& strButtonText);


    /****************************************************************************
    *    功  能：  添加固定的“二维码扫描获取”按钮，并显示
    *              默认没有显示这个QR按钮，即bVisible为false
    * 
    *              添加固定的“扫码”按钮和“粘贴”按钮，并显示
    *              默认没有显示这两个按钮，即bScanVisible和bPasteVisible为false
    * 
    *              SetVisibleButtonQR   只有一个固定按钮“二维码扫描获取”，
    *                                   通常在"确定"/"OK"旁边
    * 
    *              SetVisibleButtonQREx 有2个固定按钮，"扫码"按钮，和"粘贴"按钮
    *                                   通常，"扫码"和"粘贴"按钮，在输入框的下边
    *                                   点击"扫码"按钮，弹出二维码扫描界面
    *                                   点击"粘贴"按钮，粘贴剪切板内容到输入框中
    *
    *              固定的“二维码扫描获取”按钮点击不做任何返回值
    *              即App在Show中不会将用户点击此按钮返回给诊断应用
    *
    *              扫描二维码后的结果字串应在输入框中显示，诊断应用通过接口
    *              GetOneInputBox 获取二维码上的字串
    * 
    *
    *    参  数：  bVisible 是否显示按钮并可用
    *                       true   显示并可用
    *                       false  隐藏
    * 
    *              bScanVisible  输入框下边的"扫码"按钮是否可见，true 显示并可用
    *              bPasteVisible 输入框下边的"粘贴"按钮是否可见，true 显示并可用
    *                            false  隐藏
    *
    *    返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *              其他值，暂无意义
    *
    *    注  意：  如果没有调用过此接口，此按钮不显示
    *              此接口只针对单输入框界面, InitOneInputBox
    ****************************************************************************/
    uint32_t SetVisibleButtonQR(bool bVisible = true);
    uint32_t SetVisibleButtonQREx(bool bScanVisible, bool bPasteVisible = true);


    /**********************************************************
    *    功  能：初始化多输入框控件
    *    参  数：strTitle 标题文本
    *            vctTips 输入框对应的提示文本集合，一一对应
    *            vctMasks 输入框对应的输入掩码，一一对应
    *            vctDefaults 输入框对应的默认值，一一对应
    *    返回值：无
    **********************************************************/
    bool InitManyInputBox(const string& strTitle,
        const vector<string>& vctTips,
        const vector<string>& vctMasks,
        const vector<string>& vctDefaults = vector<string>(0));


    /****************************************************************************************
    功    能： 设置多输入框的内部提示文本
               如果在 InitManyInputBox 设置了 strDefault，输入框默认按 strDefault
               如果用户删除了默认输入值，则显示 strInnerTips
               例如，"请输入"

    参数说明： strInnerTips          "请输入"

    返 回 值： 如果当前APP版本还没有此接口，返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
               如果当前App有此接口，但未实现对应功能，返回 DF_APP_CURRENT_NOT_SUPPORT_FUNCTION,
               其它值，暂无意义
    ****************************************************************************************/
    uint32_t SetManyInputBoxInnerTips(const std::vector<std::string>& strInnerTips);


    /**********************************************************
    *    功  能：获取多输入框的返回值
    *    参  数：无
    *    返回值：vector<string> 多输入框输入值的集合
    **********************************************************/
    vector<string> GetManyInputBox();



    /**********************************************************************************
    *    功  能：初始化单个ComboBox下拉框控件
    *
    *    参  数：strTitle       标题文本
    *            strTips        下拉框对应的提示文本
    *            vctValue       下拉框所有能被选择的值的集合
    *            strDefault     默认下拉框被选中的初始值，如果不存在于vctValue中，则认为
    *                           vctValue的第一个，如果strDefault为空，下拉框被选中的初始
    *                           值也是vctValue的第一个
    *
    *    返回值：true 初始化成功 false 初始化失败
    *
    *    说  明：如果vctValue的大小为1，则没有下拉框选择，只是一个不可输入的输入框显示
    *            strDefault为下拉框被选中的初始值，如果strDefault为空，下拉框被选中的初始
    *            值也是vctValue的第一个
    ************************************************************************************/
    bool InitOneComboBox(const string& strTitle, const string& strTips,
        const vector<string>& vctValue, const string& strDefault = "");



    /**********************************************************************************
    *    功  能：获取单下拉框ComboBox的内容
    *
    *    参  数：无
    *
    *    返回值：string 下拉框ComboBox选择的值
    ************************************************************************************/
    string GetOneComboBox();


    /**********************************************************************************
    *    功  能：初始化多个ComboBox下拉框控件
    *
    *    参  数：strTitle       标题文本
    *            vctTips        所有下拉框对应的提示文本的集合，一一对应
    *            vctValue       所有下拉框对应的所有能被选择的值，一一对应
    *            vctDefault     所有下拉框对应的初始值，默认下拉框被选中的初始值，一一对
    *                           应,如果不存在于vctValue中，则认为vctValue的第一个，如果
    *                           vctDefault为空，下拉框被选中的初始值也是vctValue的第一个
    *
    *    返回值：true 初始化成功 false 初始化失败
    *
    *    说  明：如果vctValue的某个元素的大小为1，则其对应的那个下拉框控件没有下拉框选择，
    *            只是一个不可输入的输入框显示，vctDefault为下拉框被选中的初始值，如果
    *            vctDefault的某个元素为空，则其对应的那个下拉框被选中的初始值也是
    *            vctValue对应的第一个值
    ************************************************************************************/
    bool InitManyComboBox(const string& strTitle,
        const vector<string>& vctTips,
        const vector<vector<string>>& vctValue,
        const vector<string>& vctDefault = vector<string>(0));



    /**********************************************************************************
    *    功  能：获取多个下拉框ComboBox的内容
    *
    *    参  数：无
    *
    *    返回值：vector<string> 多下拉框ComboBox选择的值集合
    ************************************************************************************/
    vector<string> GetManyComboBox();


    /**********************************************************************************
    *    功  能：获取多个下拉框ComboBox的内容偏移编号
    *
    *    参  数：无
    *
    *    返回值：vector<uint16_t> 多下拉框ComboBox选择值的编号的集合
    ************************************************************************************/
    vector<uint16_t> GetManyComboBoxNum();

    /**********************************************************************************
    *    功  能：初始化混合输入框和下拉框控件
    *
    *    参  数：strTitle       标题文本
    *            vctTips        所有控件对应的提示文本的集合
    *            vctMasks       输入框对应的输入掩码集合
    *            vctDefaults    输入框对应的默认值集合
    *            vctComboValues 下拉框对应的所有能被选择的值集合
    *            vctComboDefaults 下拉框对应的初始值集合
    *            vctOrder       控件显示顺序，ControlType::InputBox 表示输入框，ControlType::ComboBox 表示下拉框
    *
    *           例子：
    *                   vector<string> tips = {"输入框1提示", "下拉框1提示", "输入框2提示", "下拉框2提示"};
    *                   vector<string> masks = {"*", "*"};
    *                   vector<string> defaults = {"默认值1", "默认值2"};
    *
    *                   vector<vector<string>> comboValues = {
    *                   {"选项1", "选项2", "选项3"}, // 第一个下拉框的选项
    *                   {"选项A", "选项B", "选项C"} // 第二个下拉框的选项
    *                   };
    *
    *                   vector<string> comboDefaults = {
    *                       "选项2", // 第一个下拉框的默认值
    *                       "选项B" // 第二个下拉框的默认值
    *                   };
    *
    *                   vector<ControlType> order = {ControlType::InputBox, ControlType::ComboBox, ControlType::InputBox, ControlType::ComboBox}; // 控件显示顺序
    *
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************************************/
    bool InitMixedInputComboBox(const string& strTitle,
        const vector<string>& vctTips,
        const vector<string>& vctMasks,
        const vector<string>& vctDefaults,
        const vector<vector<string>>& vctComboValues,
        const vector<string>& vctComboDefaults,
        const vector<ControlType>& vctOrder);


    /**********************************************************************************
    *    功  能：获取混合输入框和下拉框的内容
    *
    *    参  数：无
    * 
    *    例子： InitMixedInputComboBox 中设置了输入框和下拉框控件顺序为：
    *    vector<ControlType> order = {ControlType::InputBox, ControlType::ComboBox, ControlType::InputBox, ControlType::ComboBox}; 
    *    根据输入返回 {"输入框1的值", "下拉框1选项的字符串", "输入框2的值", "下拉框2选项的字符串"}
    * 
    *
    *    返回值：vector<string> 混合输入框和下拉框输入值的集合
    **********************************************************************************/
    vector<string> GetMixedInputComboBox();


    /**********************************************************************************
    *    功  能：获取混合的下拉框的内容偏移编号
    *
    *    参  数：无
    * 
    *    例子： InitMixedInputComboBox 中设置的下拉框选项为
    *           vector<vector<string>> comboValues = {
    *                {"选项1", "选项2", "选项3"}, // 第一个下拉框的选项
    *                {"选项A", "选项B", "选项C"} // 第二个下拉框的选项
    *                };
    *            选择了 "选项1"、"选项B"，则返回值为 {0, 1}
    *
    *    返回值：vector<uint16_t> 混合下拉框值偏移编号的集合
    **********************************************************************************/
    vector<uint16_t> GetMixedComboBoxNum();


    /**********************************************************
    *    功  能：显示输入框
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值
    *        按键：确定，取消，自定义按键，返回
    **********************************************************/
    uint32_t Show();

private:
    void* m_pData;
};


#endif
