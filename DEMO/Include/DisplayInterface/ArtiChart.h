/*******************************************************************************
* Copyright (C), 2023~ , TOPDON TECHNOLOGY Co.,Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 图形/表示意图组件
* 创 建 人 : sujiya 20231118
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_CHART_H__
#define __ARTI_CHART_H__

#include "StdInclude.h"
#include "StdShowMaco.h"


// 图形图表示意图组件
// 
// 1、默认为Line Graph，即曲线图（X-Y轴），曲线有滚动效果，通常X轴为时间
// 
// 2、图表类型分4种，例如：Pie Graph 饼图， Line Graph 曲线图，Bar Chart 柱状图，
//                         Single Bar 单条柱状图（横着的，类似进度条）
// 
// 3、Line Graph 曲线图支持单线和多线展示
//    例如在一个X轴和Y轴的图表中，有Y轴1个曲线，即一个X轴数据和一个Y轴数据，此为单线
//    例如在一个X轴和Y轴的图表中，有Y轴2个曲线，即一个X轴数据和两个Y轴数据，此为多线（3线）
//
// 4、可增加曲线图，如果曲线图不能一屏展示，界面需要增加滑动效果
// 
// 5、Show为非阻塞，无阻塞场景
//
class _STD_SHOW_DLL_API_ CArtiChart
{
public:
    enum eChartType
    {
        CT_LINE_GRAPH = 1, // Line Graph 曲线图，默认此值
        CT_PIE_GRAPH = 2, // Pie Graph 饼图
        CT_BAR_CHART = 3, // Bar Chart 柱状图
        CT_SINGLE_BAR = 4, // Single Bar 单条柱状图（横着的，类似进度条）

        CT_MIXED_CHART = 0x10, // 不是单一的，混合的
    };

    enum eLineGraphType
    {
        LGT_LINE_SINGLE = 1,     // X-Y 轴中只有1条曲线，默认此值
        // X 轴的时间数据由App自己计算，单位为秒，
        // 诊断应用不需要传时间

        LGT_LINE_SINGLE_XY = 2,     // X-Y 轴中只有1条曲线，且X轴数据也需指定

        LGT_LINE_MULTI = 3,     // X-Y 轴中可能有多条曲线，默认此值
        // X 轴的时间数据有App自己计算，单位为秒，
        // 诊断应用不需要传时间

        LGT_LINE_MULTI_XY = 4,     // X-Y 轴中可能有多条曲线
    };

public:
    CArtiChart();

    ~CArtiChart();


    /***********************************************************************************
    *    功  能：初始化图形图表控件
    *
    *    参  数：strTitle      图形图表标题
    *            chartType     图标类型
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *************************************************************************************/
    uint32_t InitTitle(const std::string& strTitle, eChartType chartType = CT_LINE_GRAPH);



    /*****************************************************************
    *    功  能：设置界面的主提示文本
    *
    *    参  数：strTips  提示文本
    *            posTyp   TIPS_IS_TOP    提示文本居于顶部显示
    *                     TIPS_IS_BOTTOM 提示文本居于底部显示
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：如果没有调用此接口，则无主提示文本
    *****************************************************************/
    uint32_t SetMainTips(const std::string& strTips, eTipsPosType posType);



    /**************************************************************************************
    *    功  能：设置图表的提示文本
    *
    *    参  数：uIndex   对应哪个图表，编号从0开始
    *            strTips  提示文本
    *            posTyp   TIPS_IS_TOP    提示文本居于图表顶部显示
    *                     TIPS_IS_BOTTOM 提示文本居于图表底部显示
    *                     TIPS_IS_LEFT   提示文本居于图表左部显示
    *                     TIPS_IS_RIGHT  提示文本居于图表右部显示
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：如果没有调用此接口，则图表无提示文本
    **************************************************************************************/
    uint32_t SetChartTips(uint16_t uIndex, const std::string& strTips, eTipsPosType posType);



    /***********************************************************************************
    *    功  能：增加一个曲线图表
    *
    *    参  数：graphType            曲线类型
    *
    *            graphType值可能为
    *            LGT_LINE_SINGLE_XY    单条曲线，且X 轴和Y 轴 数据都由诊断应用提供
    *            LGT_LINE_MULTI_XY     同时多条曲线，且X 轴和Y 轴 数据都由诊断应用提供
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            返回图表编号，编号从0开始
    *
    **************************************************************************************/
    uint32_t AddLineGraph(eLineGraphType graphType = LGT_LINE_SINGLE_XY);



    /***********************************************************************************
    *    功  能：增加一个饼图图表
    *
    *    参  数：无
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            返回图表编号，编号从0开始
    *
    **************************************************************************************/
    uint32_t AddPieGraph();



    /***********************************************************************************
    *    功  能：增加一个柱状图图表
    *
    *    参  数：无
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            返回图表编号，编号从0开始
    *
    **************************************************************************************/
    uint32_t AddBarChart();


    /***********************************************************************************
    *    功  能：增加一个 Single Bar 横着的单条柱状图，类似进度条
    *
    *    参  数：无
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            返回图表编号，编号从0开始
    *
    **************************************************************************************/
    uint32_t AddSingleBar();



    /***********************************************************************************
    *    功  能：设置坐标轴Y轴刻度的最大值和最小值，此接口适用Y轴只有2个刻度场景
    *            例如：0%和100%，或者，0V和5V，或者，700RPM和1200RPM
    *
    *    参  数：uIndex        指定的曲线图表项
    *            uMiniVaule    坐标轴Y轴刻度的最小值，例如，700
    *            uMaxValue     坐标轴Y轴刻度的最大值，例如，1200
    *            strUnit       刻度的单位，例如"RPM"，strUnit为空串的话，则不显示单位
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对曲线图表
    **************************************************************************************/
    uint32_t SetScaleAxisY(uint16_t uIndex, uint32_t uMiniVaule, uint32_t uMaxValue, const std::string& strUnit);

    [[deprecated("is deprecated, please use SetScaleAxisX(uint16_t uIndex, const std::vector<std::string>& vctValue) instead.")]]
    uint32_t SetScaleAxisX(uint16_t uIndex, uint32_t uMaxValue, uint32_t uInterval);

    /***********************************************************************************
    *    功  能：设置坐标轴X轴刻度的间隔，此接口适用曲线
    *            例如：X轴刻度为: {0, 10, 20, 30} 或 {a, b, c, d}
    *
    *    参  数：uIndex        指定的曲线图表项
    *            vctTips       坐标轴X轴刻度，容器数量为刻度数量
    *
    *            参数举例，vctTips = {a, b, c, d}
    *                      即x轴有4个刻度 (a, b, c, d)
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对曲线图表，LGT_LINE_SINGLE 和 LGT_LINE_MULTI 时间轴曲线不需要设置
    **************************************************************************************/
    uint32_t SetScaleAxisX(uint16_t uIndex, const std::vector<std::string>& vctTips);


    /***********************************************************************************
    *    功  能：设置单条柱状图类型图表的刻度值
    *            例如：单条柱状图刻度为: 0, 2000, 4000, 6000
    *
    *    参  数：uIndex        指定的曲线图表项
    *            uMinValue     单条柱状图刻度的最小值，例如，0
    *            uMaxValue     单条柱状图刻度的最大值，例如，6000
    *            uInterval     单条柱状图刻度的间隔值，例如，2000
    *
    *            参数举例，uMinValue = 0，uMaxValue = 6000， uInterval = 2000
    *                      即2000一个刻度，最大到6000，共4个刻度值
    *                      (0, 2000, 4000, 6000)
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对CT_SINGLE_BAR类型的曲线图表，即单条柱状图类型图表
    **************************************************************************************/
    uint32_t SetSingleBarScale(uint16_t uIndex, uint32_t uMinValue, uint32_t uMaxValue, uint32_t uInterval);


    /*************************************************************************************
    *    功  能：刷新当前柱状图表的数值
    *
    *    参  数：uIndex     指定的曲线图表项
    *            fValue     对应的数值
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对CT_SINGLE_BAR类型的曲线图表，即单条柱状图类型图表
    *************************************************************************************/
    uint32_t FlushSingleBar(uint16_t uIndex, float fValue);


    /*************************************************************************************
    *    功  能：追加指定曲线图表的Y轴数据
    *
    *    参  数：uIndex     指定的曲线图表项
    *            fValue     新添加的Y轴数值
    *
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对LGT_LINE_SINGLE类型的曲线图表，单条曲线
    *************************************************************************************/
    uint32_t FlushLineGraphPushBackY(uint16_t uIndex, float fValue);

    /*************************************************************************************
    *    功  能：追加指定曲线图表的Y轴数据
    *
    *    参  数：uIndex     指定的曲线图表项
    *            vctValue   新添加的Y轴数值
    *
    *    举例说明，vctValue为 {4，2，5}，
                   表示添加第一条曲线的值为4，
                   表示添加第二条曲线的值为2，
                   表示添加第三条曲线的值为3。
    *
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对LGT_LINE_MULTI类型的曲线图表，多条曲线
    *************************************************************************************/
    uint32_t FlushLineGraphPushBackY(uint16_t uIndex, const std::vector<float>& vctValue);

    /*************************************************************************************
    *    功  能：刷新（添加）指定曲线图表的Y轴数据
    *
    *    参  数：uIndex     指定的曲线图表项
    *            vctValue   每个X轴值对应的Y轴数值，顺序和X轴刻度一致，
    *                       数量不得大于SetScaleAxisX设置的X轴刻度数
    *                       例如：{4，5，6} 表示更新单曲线的所有值为4，5，6
    *
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对LGT_LINE_SINGLE_XY类型的曲线图表，单条曲线
    *************************************************************************************/
    uint32_t FlushLineGraphY(uint16_t uIndex, const std::vector<float>& vctValue);


    /*************************************************************************************
    *    功  能：刷新（添加）指定曲线图表的Y轴数据，针对LGT_LINE_MULTI_XY类型
    *
    *    参  数：uIndex     指定的曲线图表项
    *            vctValue   一个vector为一个曲线的点，
    *                       每个X轴值对应的Y轴数值，顺序和X轴刻度一致，数量不得大于X轴刻度
    *
    *            举例说明，假如X轴刻度为3，vctValue可以为
    *                      { {1，2，3}，{4，5}，{1} } 表示3条曲线的数据
    *
    *    返回值：无
    *
    *    说  明：此接口仅针对LGT_LINE_MULTI_XY类型的曲线图表
    *************************************************************************************/
    uint32_t FlushLineGraphY(uint16_t uIndex, const std::vector<std::vector<float>>& vctValue);


    /*************************************************************************************
    *    功  能：刷新（添加）指定曲线图表的Y轴数据，针对LGT_LINE_SINGLE_XY类型，
    *            需先用FlushLineGraphY填满X坐标点，或从0开始修改
    *
    *    参  数：uIndex     指定的曲线图表项
    *            iValueX    X轴下标，从0开始。
    *            fValueY    对应的数值
    *
    *           参数举例，iValueX = 2，fValueY = 20。
    *                     把X轴第3个点的值改成 20。
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对LGT_LINE_SINGLE_XY类型的曲线图表
    *************************************************************************************/
    uint32_t FlushLineGraphXY(uint16_t uIndex, int iValueX, float fValueY);



    /*************************************************************************************
    *    功  能：刷新（添加）指定曲线图表的Y轴数据，针对LGT_LINE_MULTI_XY类型
    *
    *    参  数：uIndex     指定的曲线图表项
    *            vctValueX  每组vector表示一条曲线的X轴下标，从0开始。
    *            vctValueY  对应的数值
    *
    *            参数举例，vctValueX = {2，2，5}，vctValueY = {20，10，30}。
    *                      把第一条曲线的X轴第3个点的值改成 20，
    *                      把第二条曲线的X轴第3个点的值改成 10，·
    *                      把第三条曲线的X轴第6个点的值改成 30。
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：此接口仅针对LGT_LINE_MULTI_XY类型的曲线图表，X-Y 轴中可能有多条曲线
    *************************************************************************************/
    uint32_t FlushLineGraphXY(uint16_t uIndex, const std::vector<int>& vctValueX, const std::vector<float>& vctValueY);



    /*************************************************************************************
    *    功  能：设置饼图图表的各项百分比
    *
    *    参  数：uIndex         指定的饼图图表项
    *            vctTips        对应百分比项的数据项提示文本
    *            vctPercent     百分比项数值
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：vctTips和vctPercent需一一对应
    *            vctPercent加起来为100
    *************************************************************************************/
    uint32_t SetPipGraphData(uint16_t uIndex, const std::vector<std::string>& vctTips, const std::vector<float>& vctPercent);



    /*************************************************************************************
    *    功  能：设置柱状图图表的各项百分比
    *
    *    参  数：uIndex         指定的柱状图图表项
    *            vctTips        对应柱状图项的数据项提示文本
    *            vctValue       数据项数值
    *
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    *
    *    说  明：
    *************************************************************************************/
    uint32_t SetBarChartData(uint16_t uIndex, const std::vector<std::string>& vctTips, const std::vector<float>& vctValue);

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
    uint32_t AddButton(const string& strButtonText);

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
    *    返回值：DF_FUNCTION_APP_CURRENT_NOT_SUPPORT，当前APP版本还没有此接口
    *            DF_FUNCTION_APP_CURRENT_NOT_SUPPORT值由SO返回
    *            其它值，暂无意义
    * 
    *            如果没有调用此接口，默认为按钮状态为可见并且可点击
    ********************************************************************/
    uint32_t SetButtonStatus(uint16_t uIndex, uint32_t uStatus);

    /********************************************************************
    *    功  能：显示图表组件界面
    *
    *    参  数：无
    *
    *    返回值：uint32_t 组件界面按键返回值
    *            指示用户是点击了"返回"按钮
    *
    *     可能存在以下返回：
    *                        DF_ID_BACK
    *                        DF_ID_FREEBTN_0
    *                        DF_ID_FREEBTN_1
    *                        DF_ID_FREEBTN_2
    *                        ...
    *                        DF_ID_FREEBTN_XX
    *
    *    说  明：此接口为非阻塞接口
    *********************************************************************/
    uint32_t Show();

private:
    void* m_pData;
};

#endif // __ARTI_CHART_H__
