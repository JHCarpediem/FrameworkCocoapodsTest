/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900列表控件接口定义
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef _ARTILIST_H_
#define _ARTILIST_H_
#include "StdInclude.h"
#include "StdShowMaco.h"

class _STD_SHOW_DLL_API_ CArtiList
{
public:
    enum eListViewType
    {
        ITEM_NO_CHECKBOX             = 0,    // 默认值，每行前面没有复选框，Show为非阻塞
        ITEM_WITH_CHECKBOX_SINGLE    = 1,    // 每行前面有复选框，但是所有复选框是互斥的，只能选中1行，Show为非阻塞
        ITEM_WITH_CHECKBOX_MULTI     = 2,    // 每行前面有复选框，复选框均可以多选，Show为非阻塞
    };

    enum eListSelectType
    {
        // 默认态，任意一行可以被选中
        ITEM_SELECT_DEFAULT         = 0,    // 默认值，用户可以选择哪一行（触摸/点击选择），相应行被选中状态

        // 所有行都不能被选中（UI用户）
        ITEM_SELECT_DISABLED        = 1,    // UI用户不可以选择任何一行（触摸/点击选择），选中由接口
                                            // SetDefaultSelectedRow控制选中
                                            // 点击任意一行，触摸失灵的效果
    };

    enum eScreenRowType
    {
        SCREEN_TYPE_FIRST_ROW = 0,    // 当前屏第一行
        SCREEN_TYPE_LAST_ROW  = 1,    // 当前屏最后一行
    };

public:
    CArtiList();

#ifdef MULTI_SYSTEM
    CArtiList(uint32_t thId);
#endif // MULTI_SYSTEM

    ~CArtiList();

    /**********************************************************
    *    功  能：初始化列表控件，同时设置标题文本
    *
    *    参  数：strTitle    标题文本
    *
    *    返回值：true 初始化成功 false 初始化失败
    * 
    *     注意： 对象实例调用了InitTitle接口后，相当于重新初始化列表，
    *           此实例在InitTitle前调用的其它接口均无效，如需保持
    *           此前的行为，应用必须重复调用除InitTitle外的其它接口
    **********************************************************/
    bool InitTitle(const string& strTitle);


    /**********************************************************
    *    功  能：初始化列表控件，同时设置标题文本，设置列表类型
    * 
    *    参  数：strTitle    标题文本
    *             Type        列表类型
    * 
    *    返回值：true 初始化成功 false 初始化失败
    **********************************************************/
    bool InitTitle(const string& strTitle, eListViewType Type);


    /**********************************************************
    *    功  能：设置列表列宽比
    *    参  数：vctColWidth 列表各列的宽度
    *    返回值：无
    * 
    *     说  明：vctColWidth的大小为列数
    *            例如vctColWidth共有2个元素，即列数为2
    *             vctColWidth各元素的总和为100
    **********************************************************/
    void SetColWidth(const vector<int32_t>& vctColWidth);


    /**********************************************************
    *    功  能：设置列表头，该行锁定状态
    *    参  数：vctHeadNames 列表各列的名称集合
    *    返回值：无
    **********************************************************/
    void SetHeads(const vector<string>& vctHeadNames);



    /*****************************************************************
    *    功  能：在界面顶部设置表格的文本提示
    * 
    *    参  数：strTipsContent   对应的文本提示内容
    *                             如果strTipsContent为空串，则不显示提示标题
    * 
    *            uAlignType       对应的文本对齐方式，例如
    *                             DT_CENTER, 表示居中对齐
    *                             DT_LEFT, 表示左对齐
    * 
    *    返回值：无
    * 
    *    说  明：如果没有设置（没有调用此接口），则不显示提示内容
    *            如果strTipsContent为空串，则取消之前的接口设置，即没有顶部文本提示
    *****************************************************************/
    void SetTipsOnTop(const string& strTipsContent);
    void SetTipsOnTop(const string& strTipsContent, uint32_t uAlignType);



    /***********************************************************************
    *    功  能：在界面顶部设置表格文本提示的标题
    *
    *    参  数：strTipsTitle     对应文本提示的标题
    *            uAlignType       对应文本标题的对齐方式，例如
    *                             DT_CENTER, 表示居中对齐
    *                             DT_LEFT, 表示左对齐
    *            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
    *                             FORT_SIZE_MEDIUM 表示 中等字体
    *                             FORT_SIZE_LARGE 表示 大字体
    *            eBold            是否粗体显示
    *                             BOLD_TYPE_NONE, 表示不加粗
    *                             BOLD_TYPE_BOLD, 表示加粗
    * 
    *    返回值：无
    *
    *    说  明：如果没有设置（没有调用此接口），则不显示提示标题
    ***********************************************************************/
    void SetTipsTitleOnTop(const string& strTipsTitle, uint32_t uAlignType, eFontSize eSize, eBoldType eBold);



    /**********************************************************
    *    功  能：在界面底部设置表格的文本提示
    * 
    *    参  数：strTips   对应的文本提示
    * 
    *    返回值：无
    * 
    *    说  明：如果没有设置（没有调用此接口），则不显示提示
    **********************************************************/
    void SetTipsOnBottom(const string& strTips = "");



    /**********************************************************
    *    功  能：在界面左侧栏增加表格的文本提示
    *
    *    参  数：strTips   对应的文本提示
    *
    *    返回值：无
    *
    *    说  明：如果从没有增加过（没有调用此接口），则左侧栏不显示提示
    **********************************************************/
    void AddTipsOnLeft(const string& strTipsContent, eBoldType eBold);


    /***********************************************************************
    *    功  能：在界面左侧栏设置表格文本提示的标题
    *
    *    参  数：strTipsTitle     对应文本提示的标题
    * 
    *            eBold            是否粗体显示
    *                             BOLD_TYPE_NONE, 表示不加粗
    *                             BOLD_TYPE_BOLD, 表示加粗
    *
    *    返回值：无
    *
    *    说  明：如果没有设置（没有调用此接口），则不显示提示标题
    ***********************************************************************/
    void SetTipsTitleOnLeft(const string& strTipsTitle, eBoldType eBold);



    /**********************************************************
    *    功  能：设置界面的阻塞状态
    *    参  数：bIsBlock=true 该界面为阻塞的
    *            bIsBlock=false 该界面为非阻塞的
    *    返回值：无
    **********************************************************/
    void SetBlockStatus(bool bIsBlock);


    /**********************************************************
    *    功  能：自由添加按钮
    *
    *    参  数：strButtonText 按钮名称
    *
    *    返回值：按钮的ID，此ID用于DelButton接口的参数
    *            可能的返回值：
    *                         DF_ID_FREEBTN_0
    *                         DF_ID_FREEBTN_1
    *                         DF_ID_FREEBTN_2
    *                         DF_ID_FREEBTN_3
    *                         DF_ID_FREEBTN_XX
    **********************************************************/
    void AddButton(const string& strButtonText);
    uint32_t AddButtonEx(const string& strButtonText);


    /**********************************************************
    *    功  能：删除自由按钮
    *
    *    参  数：uButtonId  按钮的编号
    *
    *            uButtonId 可能值是 DF_ID_FREEBTN_0
    *                               DF_ID_FREEBTN_1
    *                               DF_ID_FREEBTN_2
    *                               DF_ID_FREEBTN_3
    *                               DF_ID_FREEBTN_XX
    *
    *    返回值：true  自用添加的按钮删除成功
    *            false 自用添加的按钮删除失败
    **********************************************************/
    bool DelButton(uint32_t uButtonId);


    /****************************************************************************
    *    功  能：  添加固定按钮类型的“分享”按钮，并显示
    *              默认没有显示这个“分享”按钮，即bVisible为false
    * 
    *              固定的“分享”按钮点击不做任何返回值
    *              即App在Show中不会将用户点击此按钮返回给诊断应用
    * 
    *              通常情况下，分享有3种类型，“二维码”、“邮件”、“本地存储”
    *
    *    参  数：  bVisible   是否显示按钮并可用
    *                         true   显示并可用
    *                         false  隐藏
    * 
    *              strTitle   “邮件”分享的标题
    *                         “本地存储”分享的标题
    * 
    *              strContent  分享的实际内容
    *
    *    返回值：  DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *              其他值，暂无意义
    *
    *    注  意：  如果没有调用过此接口，此按钮不显示
    ****************************************************************************/
    uint32_t SetShareButtonVisible(bool bVisible,
        const std::string &strTitle, const std::string& strContent);


    /**********************************************************
    *    功  能：添加分组，组为一列，相当于合并了单元格（整行）
    * 
    *    参  数：strGroupName 组名
    * 
    *    返回值：无
    **********************************************************/
    void AddGroup(const string& strGroupName);


    /**********************************************************
    *    功  能：添加数据项, 默认该行不高亮显示
    * 
    *    参  数：vctItems 数据项集合
    * 
    *            bIsHighLight=true   高亮显示该行
    *            bIsHighLight=false  不高亮显示该行
    * 
    *    返回值：无
    **********************************************************/
    void AddItem(const vector<string>& vctItems, bool bIsHighLight = false);


    /**********************************************************
    *    功  能：添加数据项名称
    *    参  数：strItem 数据项名称
    *    返回值：无
    **********************************************************/
    void AddItem(const string& strItem);



    /**********************************************************
    *    功  能：设置列表指定位置的值
    *    参  数：uRowIndex 列表行标
    *            uColIndex 列表列标
    *            strValue   指定位置需要设置的值
    *    返回值：无
    **********************************************************/
    void SetItem(uint16_t uRowIndex, uint16_t uColIndex, const string& strValue);



    /***************************************************************************
    *    功  能：在指定某一列插入图片，图片格式为png
    * 
    *    参  数：uColIndex        List 列标
    *                           指定此列显示图片，那此列的所有行将不能显示文本
    * 
    *            vctPath        指定列上显示的各行图片路径
    *                           vctPath的大小为总行数
    *                           如果小于总行数，最后缺少的行的图片为空
    *                           如果vctPath指定行的路径串为非法路径（空串或文件
    *                           不存在），此行此列的图片为空
    * 
    *                           图片路径格式为： 绝对路径（全路径）
    * 
    *    返回值：无
    * 
    *    使用场景：需要用到小的图标（图片）来指示每一行的状态
    * 
    ***************************************************************************/
    void SetItemPicture(uint16_t uColIndex, const std::vector<std::string>& vctPath);



    /***************************************************************************
    *    功  能：在list左边增加一个图片，list半屏靠右显示，增加的图片半屏靠左显示
    *
    *    参  数：strPicturePath 指定显示的图片路径
    *                           如果strPicturePath指定图片路径串为非法路径（空串
    *                           或文件不存在），返回失败
    *
    *            strPictureTips 图片显示的文本提示
    *            
    *            uAlignType     文本提示显示在图片的哪个部位
    *                           DT_RIGHT_TOP，文本提示显示在图片的右上角
    *                           DT_LEFT_TOP， 文本提示显示在图片的左上角
    *
    *    返回值：无
    * 
    *    注  意：SetLeftLayoutPicture不能和SetItemPicture一起使用，即调用了
    *            SetLeftLayoutPicture后，再调用SetItemPicture无效
    *
    *    使用场景：防盗芯片识别
    *
    ***************************************************************************/
    bool SetLeftLayoutPicture(const std::string& strPicturePath, const std::string& strPictureTips, uint16_t uAlignType = DT_RIGHT_TOP);



    /*********************************************************************
    *    功  能：设置指定的行需要高亮显示，同时高亮显示行不能被选中
    *            以最后一次设置为准
    * 
    *    参  数：uRowIndex     指定需要高亮显示的行号
    *            uColourType   指定显示高亮显示行的颜色
    *                          COLOUR_TYPE_DEFAULT, 由APP决定，兼容旧接口
    *                          COLOUR_TYPE_GRAY,    由接口指定为置灰颜色
    * 
    *    返回值：无
    * 
    *    注意：显示高亮显示行与选中行的颜色不一致
    *********************************************************************/
    void SetRowHighLight(uint16_t uRowIndex);
    void SetRowHighLight(uint16_t uRowIndex, eColourType uColourType);
    


    /*********************************************************************
    *    功  能：设置指定的行需要高亮显示，同时高亮显示行不能被选中
    *            以最后一次设置为准，可一次多行设置
    *
    *    参  数：vctRowIndex   指定需要高亮显示的行号，可一次指定多行
    *            vctColourType 指定显示高亮显示行的颜色
    *                          COLOUR_TYPE_DEFAULT, 由APP决定，兼容旧接口
    *                          COLOUR_TYPE_GRAY,    由接口指定为置灰颜色
    *           
    *            vctRowIndex与vctColourType的对应关系为下标对应
    *            例如，vctRowIndex[0]  对应    vctColourType[0]
    *                  vctRowIndex[1]  对应    vctColourType[1]
    *
    *    返回值：无
    *
    *    注意：显示高亮显示行与选中行的颜色不一致
    *********************************************************************/
    void SetRowHighLight(const std::vector<uint16_t>& vctRowIndex, const std::vector<eColourType>& vctColourType);



    /**********************************************************
    *    功  能：设置第一行是锁定状态，类似Excel表格的“冻结首行”
    * 
    *    参  数：无
    * 
    *    返回值：无
    * 
    *    注  意：首行和列表头(Head)是不一样的
    *            如果设置了列表头，SetHeads
    *            并且锁定了首行，SetLockFirstRow
    *            会有类似冻结了2行的效果
    * 
    *            列表头 和 SetLockFirstRow的首行 底纹 应该有区别的效果
    **********************************************************/
    void SetLockFirstRow();



    /*******************************************************************
    *    功  能：设置默认选中的行
    * 
    *    参  数：uRowIndex 默认选中行的行，以最后一次设置为准
    * 
    *    返回值：无
    * 
    *    注 意：此接口针对 ITEM_NO_CHECKBOX 类型的列表框， 如果是“复选
    *           框”(ITEM_WITH_CHECKBOX_SINGLE和ITEM_WITH_CHECKBOX_MULTI)
    *           类型，请用SetCheckBoxStatus接口
    *********************************************************************/
    void SetDefaultSelectedRow(uint16_t uRowIndex);
    


    /*******************************************************************
    *    功  能：设置默认选中的行，可多行设置
    *
    *    参  数：uRowIndex 默认选中行的行，以最后一次设置为准
    *
    *    返回值：无
    *
    *    注 意：此接口针对 ITEM_NO_CHECKBOX 类型的列表框， 如果是“复选
    *           框”(ITEM_WITH_CHECKBOX_SINGLE和ITEM_WITH_CHECKBOX_MULTI)
    *           类型，请用SetCheckBoxStatus接口
    *********************************************************************/
    void SetDefaultSelectedRow(const std::vector<uint16_t>& vctRowIndex);




    /**********************************************************
    *    功  能：设置复选框默认选中状态
    * 
    *    参  数：uRowIndex 行序号，bChecked 是否选中
    * 
    *    返回值：无
    * 
    *    说 明： 如果没有调用此接口，所有行默认状态都为未选中
    **********************************************************/
    void SetCheckBoxStatus(uint16_t uRowIndex, bool bChecked);


    /**********************************************************
    *    功  能：设置指定按钮的状态
    *    参  数：uIndex 指定的按钮
    *            bIsEnable=true 按钮可点击
    *            bIsEnable=false 按钮不可点击
    *    返回值：无
    **********************************************************/
    [[deprecated("is deprecated, please use CArtiList::SetButtonStatus(uint16_t, uint32_t) instead.")]]
    void SetButtonStatus(uint8_t uIndex, bool bIsEnable);


    /******************************************************************
    *    功  能：设置自定义按钮的状态
    *
    *    参  数：uIndex      自定义按钮下标
    *            bStatus     自定义按钮的状态
    *
    *                  DF_ST_BTN_ENABLE    按钮状态为可见并且可点击
    *                  DF_ST_BTN_DISABLE   按钮状态为可见但不可点击
    *                  DF_ST_BTN_UNVISIBLE 按钮状态为不可见，隐藏
    *
    *    返回值：无
    *            如果没有调用此接口，默认为按钮状态为可见并且可点击
    ********************************************************************/
    void SetButtonStatus(uint16_t uIndex, uint32_t uStatus);


    /**********************************************************
    *    功  能：设置指定的按钮文本
    *    参  数：uIndex 指定的按钮
    *            strButtonText 需要设置的按钮文本
    *    返回值：无
    **********************************************************/
    void SetButtonText(uint8_t uIndex, const string& strButtonText);


    /**********************************************************
    *    功  能：获取选中的行号
    * 
    *             即：list类型为ITEM_NO_CHECKBOX时，调用此接口可以
    *                获取选中的行号
    * 
    *    参  数：无
    *    返回值：选中的行号
    **********************************************************/
    uint16_t GetSelectedRow();


    /**********************************************************
    *    功  能：获取选中的行号，适用于复选框情况
    * 
    *            即：list类型为ITEM_WITH_CHECKBOX_SINGLE或
    *                者ITEM_WITH_CHECKBOX_MULTI
    * 
    *    参  数：无
    *    返回值：选中的行号
    *            如果大小为0，表示没有选中任何一项
    **********************************************************/
    std::vector<uint16_t> GetSelectedRowEx();



    /****************************************************************************
    *    功  能：设置List所有行是否可被选择，默认可以被选中（触摸/点击）
    *            复选框不在此范围（不受影响）
    *
    *    参  数： eListSelectType lstType 
    *                  ITEM_SELECT_DEFAULT  任意一行可以被选中
    *                  用户可以选择哪一行（触摸/点击选择），相应行被选中状态
    *
    *                  ITEM_SELECT_DISABLED  所有行都不能被选中（UI用户）
    *                  UI用户不可以选择任何一行（触摸/点击选择），选中只能由接口
    *                  SetDefaultSelectedRow控制
    *                  如果诊断应用程序没有调用SetDefaultSelectedRow接口，Show返回
    *                  没有选中任何一行DF_LIST_LINE_NONE
    *                  同时GetSelectedRow也返回没有选中任何一行DF_LIST_LINE_NONE
    *
    *    返回值： 设置正常，返回0
    *             如果找不到App对此接口的定义（或者App没有注册此接口回调），
    *             返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
    *             
    *    说  明： 如果应用程序调用了此接口并且设置类型为ITEM_SELECT_DISABLED，
    *             List所有行将不能被选择（用户UI点击任意一行都将不会被反应，
    *             触摸失效的效果），选中哪一行将由接口SetDefaultSelectedRow指定
    *             同时Show返回的行与SetDefaultSelectedRow保持一致
    * 
    *             如果应用程序没有调用此接口，默认为ITEM_SELECT_DEFAULT
    *             即可以被选中（触摸/点击）
    ****************************************************************************/
    uint32_t SetSelectedType(eListSelectType lstType);



    /****************************************************************************
    *    功  能：设置当前屏的第一行的行号或者当前屏的最后一行的行号
    *            从而诊断程序可以控制当前屏幕需要显示的行
    *
    *    参  数： eScreenRowType rowType
    *                  SCREEN_TYPE_FIRST_ROW  设置的行号是当前屏的第一行
    *                  SCREEN_TYPE_LAST_ROW   设置的行号是当前屏的最后一行
    *
    *    返回值： 设置正常，返回0
    *             如果找不到App对此接口的定义（或者App没有注册此接口回调），
    *             返回 DF_FUNCTION_APP_CURRENT_NOT_SUPPORT
    *
    *    说  明： 通过此接口，诊断程序可以控制当前屏幕显示的行
    ****************************************************************************/
    uint32_t SetRowInCurrentScreen(eScreenRowType rowType, uint32_t uIndex);




    /*********************************************************************
    *    功  能：显示列表
    *    参  数：无
    *    返回值：uint32_t 组件界面按键返回值，不包含选用的行号信息
    * 
    *            如果list类型为 ITEM_NO_CHECKBOX，选中行号信息通过
    *            接口GetSelectedRow获取
    * 
    *            如果list类型为ITEM_WITH_CHECKBOX_SINGLE，选中的行
    *            号通过接口GetSelectedRowEx获取，此时返回的vector
    *            大小为1或者0
    *            如果大小为0，表示没有选中任何一项
    * 
    *            如果list类型为ITEM_WITH_CHECKBOX_MULTI，选中的行
    *            号通过接口GetSelectedRowEx获取
    *            如果大小为0，表示没有选中任何一项
    * 
    *            如果点击了按键，Show返回相应的按键值
    * 
    *            如果点击了某一行，Show同样会返回相应的行号
    *            
    *            如果诊断应用程序调用了SetSelectedType接口，
    *            并设置为ITEM_SELECT_DISABLED，并且没有调用
    *            SetDefaultSelectedRow，情况下Show返回值为没有选中
    *            任意一行DF_LIST_LINE_NONE且GetSelectedRow也返回
    *            没有选中任意一行DF_LIST_LINE_NONE
    * 
    *********************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};


#endif
