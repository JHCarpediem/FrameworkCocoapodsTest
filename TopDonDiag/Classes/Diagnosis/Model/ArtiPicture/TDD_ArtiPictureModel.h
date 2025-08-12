//
//  TDD_ArtiPictureModel.h
//  AD200
//
//  Created by AppTD on 2023/4/25.
//

#import "TDD_ArtiModelBase.h"

NS_ASSUME_NONNULL_BEGIN

// 图片显示示意图
//
// 1、可以追加图片显示
// 2、每张图片可以点击放大并旋转
// 3、可以为图片添加顶部文字提示和底部文字提示
// 4、界面右侧为文本帮助提示
// 5、界面为阻塞显示
//
//

@interface TDD_ArtiPictureItemModel : NSObject
@property (nonatomic, copy) NSString *topTips;//图片顶部文本提示
@property (nonatomic, copy) NSString *bottomTips;//图片底部文本提示
@property (nonatomic, strong) NSString *picturePath;//图片路径
@property (nonatomic, assign) uint32_t size;//顶部文本字体大小
@property (nonatomic, assign) uint32_t bold;//顶部文本字体字重

@property (nonatomic, strong) NSString * strTranslatedTopTips;//图片顶部文本提示 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, strong) NSString * strTranslatedBottomTips;//图片底部文本提示 - 翻译后的数据 - 未翻译前与原数据一致
@property (nonatomic, assign) BOOL isStrTopTipsTranslated; //图片顶部文本提示是否已翻译
@property (nonatomic, assign) BOOL isStrBottomTipsTranslated; //图片底部文本提示是否已翻译
@end


@interface TDD_ArtiPictureModel : TDD_ArtiModelBase

// 图片数组
@property (nonatomic, strong) NSMutableArray <TDD_ArtiPictureItemModel *>* pictureArr;
// 右侧文本
@property (nonatomic, copy) NSString *text;


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
+ (uint32_t)AddPictureWithId:(uint32_t)ID strPicturePath:(NSString *)strPicturePath strBottomTips:(NSString *)strBottomTips;

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
+ (uint32_t)AddTopTipsWithId:(uint32_t)ID uiPictID:(uint32_t)uiPictID strTopTips:(NSString *)strTopTips eSize:(uint32_t)eSize eBold:(uint32_t)eBold;

/******************************************************************************
*    功  能：在界面中添加文本框显示，具有滚动条效果，目前只支持右侧，无格式控制
*
*    参  数：strText    显示的文本
*
*    返回值：无
******************************************************************************/
+ (void)AddTextWithId:(uint32_t)ID strText:(NSString *)strText;

@end

NS_ASSUME_NONNULL_END
