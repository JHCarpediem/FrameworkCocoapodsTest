/*******************************************************************************
* Copyright (C), 2020~ , Lenkor Tech. Co., Ltd. All rights reserved.
* 文件说明 : 文档类标识
* 功能描述 : ArtiDiag900 图片显示 控件
* 创 建 人 : sujiya 20201216
* 实 现 人 :
* 审 核 人 : binchaolin
* 文件版本 : V1.00
* 修订记录 : 版本      修订人      修订日期      修订内容
*
*
*******************************************************************************/
#ifndef __ARTI_PICTURE_H__
#define __ARTI_PICTURE_H__

#include "StdInclude.h"
#include "StdShowMaco.h"

// 图片显示示意图
// 
// 1、可以追加图片显示
// 2、每张图片可以点击放大并旋转
// 3、可以为图片添加顶部文字提示和底部文字提示
// 4、界面右侧为文本帮助提示
// 5、界面为阻塞显示
// 
// 
class _STD_SHOW_DLL_API_ CArtiPicture
{
public:
    CArtiPicture();

#ifdef MULTI_SYSTEM
    CArtiPicture(uint32_t thId);
#endif // MULTI_SYSTEM


    ~CArtiPicture();



    /**************************************************************************
    *    功  能：初始化图片显示控件
    * 
    *    参  数：strTitle 图片浏览标题
    * 
    *    返回值：true 初始化成功 false 初始化失败
    * 
    ****************************************************************************/
    void InitTitle(const std::string &strTitle); 



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



    /***************************************************************************
    *    功  能：添加一个图片显示
    *
    *    参  数：strPicturePath 指定显示的图片路径
    *                           如果strPicturePath指定图片路径串为非法路径（空串
    *                           或文件不存在），返回失败
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



    /***************************************************************************
    *    功  能：在指定图片顶部添加一个文本提示
    *
    *    参  数：uiPictID    在指定图片的顶部添加文本的图片索引ID，即哪个图片上添加
    * 
    *            strTopTips  在指定图片的顶部添加的提示本文
    *
    *            eSize            FORT_SIZE_SMALL 表示 小字体（与文本同等大小）
    *                             FORT_SIZE_MEDIUM 表示 中等字体
    *                             FORT_SIZE_LARGE 表示 大字体
    * 
    *            eBold            是否粗体显示
    *                             BOLD_TYPE_NONE, 表示不加粗
    *                             BOLD_TYPE_BOLD, 表示加粗
    *
    *    返回值：图片索引ID，如果添加失败（路径非法），返回 DF_ID_PICTURE_NONE
    *            可能的返回值：
    *                         DF_ID_PICTURE_0
    *                         DF_ID_PICTURE_1
    *                         DF_ID_PICTURE_2
    *                         DF_ID_PICTURE_3
    *                         DF_ID_PICTURE_XX
    ***************************************************************************/
    void AddTopTips(uint32_t uiPictID, const std::string& strTopTips, eFontSize eSize, eBoldType eBold);


    /******************************************************************************
    *    功  能：在界面中添加文本框显示，具有滚动条效果，目前只支持右侧，无格式控制
    *
    *    参  数：strText    显示的文本
    *
    *    返回值：无
    ******************************************************************************/
    void AddText(const std::string& strText);

    /********************************************************************
    *    功  能：显示图片界面
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
    *    说  明：此接口为阻塞接口
    *********************************************************************/
    uint32_t Show();

private:
    void*        m_pData;
};

#endif // __ARTI_COIL_READER_H__
